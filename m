Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA97C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6551981760;
	Mon, 17 Mar 2025 14:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dFQsVxP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E868168B; Mon, 17 Mar 2025 14:48:24 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B64B8081A
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so15358815e9.2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742219302; x=1742824102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i5oqaMspsxgLPa07GFAaJ+kxQoS/krobl+YGjxxnYd8=;
 b=dFQsVxP9yNq9i02wTZ4pIoiqeNqrV3LVvKaJ3Z8vefUvojdeGxV3U2rajkM2bvqGOk
 gK8BwVh9tPn3S0L87Ygmv55XVGdHsykMH3pgmZ+TjxC9K/zC608KkyX2TTI1D56ax6dK
 hcgefsQXRwQEZoTyIt1u7bz0EoekxdsS3lBj0YtTlqr16GAAC7DfcIBKR501Rs8bxLOx
 q2HsajewPkJVQ+gfzHN12x3IzKXs7JXzxw05nro0doBYonxhJcup8TH8f83JOIuDF5lX
 f8Pw3+vPeivDWrCuZE1hbFKFsgL8zAdRHQGO3UiiSAx8vVzmOZ6w8WfG80A8Tnnq7tnG
 +wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742219302; x=1742824102;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5oqaMspsxgLPa07GFAaJ+kxQoS/krobl+YGjxxnYd8=;
 b=Ki9byFNfq3x2h0Ddr6soNkROE6rsyQXZRPlv0s89a4XQwd+d6yIEiQzhMwc0rEiJTG
 qRlCqy8wLeFAkw+xBVqkF4n3kf9N2Bxx08s0GTK54RGTjnFBRk64Bi4OfFap/TpfpeyG
 ioF05Z+e1jzAdYYPg5Y/Z4ejLk/Xc0Hk1MMicMHo8glE/xEq4xF2/Wvy2v6rhEgD7/yH
 LFaL265Fe4IYw6+eoHOx3bHAz9+MJqJGHQavOn3yLrEEq3z8kmbT9cVFFrw5VFTb9Te4
 hLHibB9q8q7XTNRFnjBIdWHO/QSoNsd1NtlkW+onP/hmZ8MffRWhdGYPQwZmby+RLUCn
 M80A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG7Gs2w/3L084ECc2bqoDtpqXE2vgl1YcpadmOtDa849SEjTNdyNObi+cEmrNQuegRg4iS314=@lists.denx.de
X-Gm-Message-State: AOJu0YyDKnJSgHWfjeWZ29MrPfUIMAOG4DB/8JaFt5lYFtsOHPWN34C+
 qtodmbmd8eEgleMWLTr6aU3PLLu1dHjFXLtkkt4qQcJwzbntJvacMygbv9yq4/Y=
X-Gm-Gg: ASbGncsmuHVM4B2Wue4mM1TeXRJM7tQITmfPgC+GRJuQiBvdyQxKx+zEi+XHExkpWdv
 QuQKt8Di3Qdv+GKsSJcmIG9+19+3vfH7fnE2chCv8UHlqk3MM5m6ygrNBA8roq0zCDf5kQTX0PD
 baf6nMCWWCs7oABwNtjf17RXuNIoUhKi8AnyMSAPtNMj4z8vX/rYF4nyV8ZGGrf/s3ra+hCyCE9
 wMzomfIKt1fzk+tfMI7iHxyYqIDM8KSm436u5Zg3w70bZ3504bcxpvfcguvw5awtcGRP7hCRNvI
 aEJ8+K5sKo47OT3659LtI3VMz8fVzSgxt6C0J/AIxh2BqHk0Ksp2dOjAxPZFswlEALfFq7g=
X-Google-Smtp-Source: AGHT+IF8cqOeS5bAcUk6iM3rl9JA7vNu4zkDqkyXiX74oqWIjGe7seVfo6PAbUdBZjzP3nr/2fMZAg==
X-Received: by 2002:a05:600c:3b97:b0:43c:f1cd:3d78 with SMTP id
 5b1f17b1804b1-43d1ec72a07mr129609305e9.12.1742219301750; 
 Mon, 17 Mar 2025 06:48:21 -0700 (PDT)
Received: from [192.168.1.116] ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d200fae4asm105655945e9.27.2025.03.17.06.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:48:21 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, lukma@denx.de, 
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com, 
 robert.marko@sartura.hr, luka.perkov@sartura.hr, lehmanju@devpi.de, 
 Volodymyr_Babchuk@epam.com, sjg@chromium.org, pbrobinson@gmail.com, 
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250225065303.342174-1-quic_varada@quicinc.com>
References: <20250225065303.342174-1-quic_varada@quicinc.com>
Subject: Re: [PATCH v5 0/7] Add initial support for IPQ9574 based boards
Message-Id: <174221930033.73541.4539388431486396659.b4-ty@linaro.org>
Date: Mon, 17 Mar 2025 13:48:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Tue, 25 Feb 2025 12:22:56 +0530, Varadarajan Narayanan wrote:
> These patches introduce the initial support code needed
> for the QTI IPQ9574 SoC and RDP433 board.
> 
> 	SoC	: Qualcomm IPQ9574
> 	RAM	: 2GB DDR4
> 	Flash	: eMMC 8GB
> 	WiFi	: 1 x 2.4GHz, 1 x 5GHz, 1 x 6GHz
> 
> [...]

Applied, thanks!

[1/7] doc: board/qualcomm: document RDP building/flashing
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/a4c8912608ef
[2/7] dts: ipq9574-rdp433-u-boot: add override dtsi
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/25edbbf7fde8
[3/7] clk/qcom: add initial clock driver for ipq9574
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/ad3e8a2f59e7
[4/7] pinctrl: qcom: Handle get_function_mux failure
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/6ec61fd46222
[5/7] pinctrl: qcom: Add ipq9574 pinctrl driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/1b734e019048
[6/7] mmc: msm_sdhci: Reset clocks before reconfiguration
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5bff42afd1c0
[7/7] configs: add qcom_ipq9574_mmc_defconfig
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/3c5a192a0530

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

