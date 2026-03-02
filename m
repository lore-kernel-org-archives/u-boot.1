Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F85AEA4E07
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 14:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ED8283F30;
	Mon,  2 Mar 2026 15:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mKGftZ1M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA7783F53; Mon,  2 Mar 2026 15:20:42 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE15483F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 15:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso49190385e9.0
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 06:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772461238; x=1773066038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQpKpoEGlr9dR/5m3xv8RBa3w2tO7e8K+X8afDMMfrQ=;
 b=mKGftZ1MmDbIvOzsQYGtYKHiRqnx8xN3ORzvnw1HBllVSA4vLHBgX7JkWYDQtIcGEB
 sRiz83KP8m4HgwKyB5SPmb8yraMRmRrF3fyYYy06RTAr+5dCz6da7IQCI0BbgSu7Lo5Y
 A34eDSiHNiRK2l3nmveXWyAS5akizycitsLMtNR1drSkAK4kAQwhNMuCENBGkEaArueA
 6njcAddeHUHosiV5WIvIIcMUXIi3fC1Iec64a1KyM7e9PhSUTuTm8vh8jaZ5omy1h9NS
 s1rwQkK364LU565GsDRWXQHxJNg8DHDdnfwqT0CY0ytH6dICDWhtYHOE7wNnic8/Sxuj
 TXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772461238; x=1773066038;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PQpKpoEGlr9dR/5m3xv8RBa3w2tO7e8K+X8afDMMfrQ=;
 b=eNIK6OU9vYPGe1vco5yS2KfUC1HKGYGa4n7gBIRZzyseybZPFJ4Tncsuq2XgiuX+SA
 6FzyYZEHKxwjZntmZMR61Tcb3YRY/Z9Gw0DrNbrjaqPrRH21f3KmkZksMz46VaaE25SP
 EL8Jv8eJfO+wvsDSpqovzuPbP8rk/QxZILLe/DFMudCOpgLm46Ux+01hVpZ9/hXtRHsf
 2iW0LJZnoL+EiVNPSAHHHvtVSDRpfJO205fAIl+HqyixI5bl4el+3yXbIyfT6wK/uO2c
 C09tJJh2YNjTasEg6LthXn4c9Iv1qBuHuXPV/K37NquBe61+SJKKNIQQfPcA8TbDC4w3
 XvfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLC5PMEeEfJ6P+9VSq8KyV6fYhZJMokTIrNY74uNbRQgv9QoNgNhGPldSeqXjUO7wUtNL6DkY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy//mwMGX7qEow0HORndHvOh0bXRnTIaw0hB/o5Ua6RRWnbGEYs
 TLw1kYpUzhjnXkZlVQwRX9INdNheEKu/Yn+CrryrFR92IdQtgkPr5z5vKQgVF2wc6e4=
X-Gm-Gg: ATEYQzxrfHM0n/GTfwLHC2J+OSOEnN7sW0vNDkvF7EjOgoQ6XciLueTPyPbU+dD8fr+
 RhvzcjuuVIkhfcrBZE1l1mj517ywxU59dq4xbkboP5CM4T1/MCREcHTqUWaT5PnB4SjDv2hLsUD
 E52PAcdlvMwGmDZSrlog9lyjwYMIDP/pOUJe0CfazDHBDnF2dt9NMu/Pr6Sv+NTtrovbIwW2+pE
 GwNo1M1sbL7tLEZpyqO8z3fuogamtnRefpu7zErVdBrqqPZujYaVD4LoMrW3ubnodFHujMPrivm
 QnsWuu8SEqrHMCNDbSSXG9gGRj6gli6/LJhEL1j3ur9EdnLjQNf8zQp0N8dD+slXZzx/m9SHGSi
 ykvSZ/ag8thAUqLalXyG2SmVhcCIGNn1p0TAgPMpoJRWyqxQET0UZlnU9ctpClb+twrcfdqlXkL
 sk2HSYSHqToRfEqxmX25f4KCxha157E0H1Gg15cKbcn4R3
X-Received: by 2002:a05:600c:46d5:b0:483:5310:dc67 with SMTP id
 5b1f17b1804b1-483c9bbbe77mr198848625e9.20.1772461237908; 
 Mon, 02 Mar 2026 06:20:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b6d540b2sm8214202f8f.36.2026.03.02.06.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 06:20:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, dlechner@baylibre.com
In-Reply-To: <20260203-cleanup-ufs-header-v1-1-4c10424485f0@baylibre.com>
References: <20260203-cleanup-ufs-header-v1-1-4c10424485f0@baylibre.com>
Subject: Re: [PATCH] drivers: ufs: remove unused ufs_post_bind()
 declaration
Message-Id: <177246123685.1351530.8392732510096580323.b4-ty@linaro.org>
Date: Mon, 02 Mar 2026 15:20:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

Hi,

On Tue, 03 Feb 2026 10:21:26 +0100, Julien Stephan wrote:
> Commit 067c1b033282 ("ufs: Call ufs_scsi_bind() from uclass .post_bind")
> inlined ufs_scsi_bind() into ufs_post_bind() as trivial
> device_bind_driver() call.
> 
> ufs_scsi_bind() is no longer referenced anywhere in the codebase, so
> drop its declaration from include/ufs.h.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[1/1] drivers: ufs: remove unused ufs_post_bind() declaration
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/47905f28468e3524cb5f775f52928cdcc568815a

-- 
Neil

