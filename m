Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68872E9A767
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 10:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199EF83952;
	Tue, 24 Mar 2026 11:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZTmFtCOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E4E2839A8; Tue, 24 Mar 2026 11:59:41 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7CBC838FA
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 11:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439d8df7620so3353778f8f.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 03:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774349978; x=1774954778; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwz684Xa/91be45sMaZ9Iy0fLkL5fYJJ6clwh2EQG4g=;
 b=ZTmFtCObkPxEgpwICZk0ve3T3IlUoNuTz6n4LrotUsj9Dg+F+5wu+7dhQRQjgtLOLq
 TR5MFBETJYQyNTcXNcdmlJTqnjgsWFX8VdNuhz8FIoUN4sW3GN8woFyfA/QruYyvslsA
 A/LEVVxRHgze1lXB9p//3czEDd69UiHNNqMTZmjB3BQHOKuAVcMPoV0K9xI5lzMqbSG/
 BQvuy38Pnnczj11eMbFzSHhU4D86m/qhby/6N+P01Se3G6cp6/O1TsEP+Pw5owPoFMOG
 rrLLvXvhDlisS6f3FX7xkObvCXuv7rPVgyiEHpmz7T4/IJ46Halsu/OsYDyp7t/fzdUj
 zfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774349978; x=1774954778;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xwz684Xa/91be45sMaZ9Iy0fLkL5fYJJ6clwh2EQG4g=;
 b=HHUHR9JQRPJltbaVTjHmJVyUdhzT1OLshQPFrXCokmjnWzM0tstBGfFpFGGKjsKdec
 j70+c3chrnk7AYxSslCuH2QXqNgQSxGW3FGGjOigITc8hF/ZZ4AGSA8iyBJ+vC77UfYy
 dYsvB4ElBjv51nmQbknwn3KGSdQMx32ZnTD9/Z/PURIO4cJARZRVdMsQO9tJIDx6kym/
 3+EerGz2vc6H2NjVh7j+tCD9ccZAADaD/F6Wi6DxdTstP40mRJjgXm7gY7ZKp80bP7pC
 LYlD330OpG0BfbXy6wT1HpAJmRaS7w/fcEExw5blsw07SubqGBbewtuqnsVUXvHp3wiQ
 gvBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUB8awf5mTDiqbfggDm0RhDPQszLwOxKL/0ebPsLz0/BdxS5zYmEFD/yvmyXeI8JBwue5HvBE=@lists.denx.de
X-Gm-Message-State: AOJu0YyQHpLPwHqCzR1iJMiObJlaChalb+Tp1nvejW5RajKI+VTmNEL4
 KdrEZoln86w1qelakIgeEgo+Els+/DlWaHouXzfNuVCORfvbUpPnh7DOFiRuqA3EKH0=
X-Gm-Gg: ATEYQzw/PyRHMbF4eafl0l6g9jxsGHhrXIi4kDu9LCA+1ulEQICH1Q02Hetkx3tjGyz
 ZTqlHNB4BdIsRnXcX8aOWmMjkKy58VLnUbEQvRSIrlfTsX8CUzNgaIvx5oepjwl6Q6XXwxXYZOU
 4p655aYDgwEIBHQ4FKV+ZsTwcuPA8+z/nsERadV96gWYxZhtVmBIJUHBrGvL9oEU97cX/2RRmN3
 qoNuTrtup6RTMrEjT0SlRcFWNymge70yMYPFRTKnde8oR85Z2LRHaszj4hLjNyUMMKozJ1tdnB7
 renuqMfFnDk7BQ7XssItyTJjDYdSC7uG9ypLiJa8ae8dWjOyqxWqupNWjWT0rrEt6CekLN1TESw
 QsADX64dfGVPR/VcOCFF/odDIylWBVdfsplBdfa4nq8uiP/WeDT7iDhyR1ZBONJMTSl1vFwhu2N
 sgaRUANxE77aVAP57LAFUXGCoqgOmGVxmIeuJbqks1o5kksKhsvvYOQ2k6zayGSwHnyQ==
X-Received: by 2002:a05:6000:2489:b0:43b:43ae:8c2e with SMTP id
 ffacd0b85a97d-43b64289994mr23383292f8f.51.1774349978121; 
 Tue, 24 Mar 2026 03:59:38 -0700 (PDT)
Received: from lion.localdomain (p5b29eb0d.dip0.t-ipconnect.de. [91.41.235.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470b243sm37810416f8f.26.2026.03.24.03.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 03:59:37 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Shmuel Leib Melamud <smelamud@redhat.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20260121003659.69305-1-casey.connolly@linaro.org>
References: <20260121003659.69305-1-casey.connolly@linaro.org>
Subject: Re: [PATCH] watchdog: qcom: stop watchdog by default
Message-Id: <177434997680.3720457.10960566999240623555.b4-ty@linaro.org>
Date: Tue, 24 Mar 2026 11:59:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


On Wed, 21 Jan 2026 01:36:51 +0100, Casey Connolly wrote:
> Prevent the Qualcomm watchdog from autostarting and ensure it's stopped
> when the driver probed. In some cases the watchdog is left running by
> a previous bootloader stage. Disable autostart so it isn't left running
> when we boot into the OS, this behaviour can be changed by enabling
> autostart in the board defconfig.
> 
> 
> [...]

Applied, thanks!

[1/1] watchdog: qcom: stop watchdog by default
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/1cf505e51b49

Best regards,
-- 
// Casey (she/they)


