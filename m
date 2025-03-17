Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DA9C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5A7081101;
	Mon, 17 Mar 2025 14:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F2d0HlTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BAA081877; Mon, 17 Mar 2025 14:48:26 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5B44800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so11606345e9.0
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742219303; x=1742824103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=geLron4UfFHG4KTCqdBWo6KmEOOscZ6Jp3TzNGj16d8=;
 b=F2d0HlTnT8BpaO5GQTKG6UslffV5wS9jSZpKGesiG5tYbnw5N9oIKtO9sziQu0Fgll
 FZ/LcxWCZKFMkNIQMxsPLzX1B1MY4nq/+oH3hasBQB7VRcNFWzUBxni1RkuPWWUQG2CC
 1dFIx940nBNL0jX56FE8PmD5d/nPV2lT7x+giJwtZMDO2FQafd7WEV8qz8TlldlORpG/
 o0AYVVi/gxjYoKuAUrCb/xpcCKgbOS/kXBf00a3La9dV7x3redhGQAunShMxkQ5sZQBn
 zCz5PV8a07TzDT/f/aqyNzLXQGNUTCt938r3zZy3VKTGIHiJrORw4pLy67rHECxPYQ1/
 k4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742219303; x=1742824103;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=geLron4UfFHG4KTCqdBWo6KmEOOscZ6Jp3TzNGj16d8=;
 b=aNfNkNtXM0luIMvZ5xb8A2lFofn0SgW6+5d1KJlmlcuMvMJHdSNIbSA4FYLL0kRZbC
 7NEfIrIxab1Ee3JqcD8SuPuiF9Ors13N7z9eBq2m4TDx7Tj0kkTAVyl/MFCEfK2NR5xg
 CBEbPMfIlCVhVk/wOZDpEDFxjVhEVprZnGdiU6LAt40j8IkNDg+A1GgtCRM6VQuyBcqQ
 qAuOEedhA7JMbAs6hoj6uGJanySH8ozlGs1GA/B/L/Rz8fu4fGiuoicFPCjNRUXNhBeH
 hmZbHAu/TS26qE89jkq324W3nDhUh1+Ev/q7o88q/KtY2mHm/nzijwWI65LO8MGSSVFc
 4oqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Jjg6USNJeCJfj6N3SqKauLXnwaWBBSNBi1qnJsWIyTFfwhvBY7M5SAmXbEVHtKeq57yudIo=@lists.denx.de
X-Gm-Message-State: AOJu0YyRaVdcLuHYHVotqwjszyVg9DWOYX3jhWUEiwjOh5m49Ln/Ng0K
 vUO0J0c2DglqXQtiJhYVO7hE4PIel71VYPfvfyauRmyiDfqxwuOlnrumwJx+Q+o=
X-Gm-Gg: ASbGncthYwgF+x/inGm2VoUuL5KS1Ta9lcVEAOD9eQX7oeoWSLRA1fW2qCeB452fH3S
 r1j1aQgt+AxI8lay2YH5zDNHH62dlu7JXCecnjmdL3lcyTW5rKk+EWg7EnyIgyn9sxfkyXNrOhM
 fDCOzFb5IK4JU6D50itnbz3x3GH0gNdVpFl4WbopBHqd8ObA8tvpEvISl27y4sy7tjaJIw8Sr6q
 hpNFpaz1KMY9RxB6SpqcBztOFaD9b3bguwGQkfNWFQN4QCzu2Cx3U0ZrMtcj7TJD5ANfU3EtTfU
 +67mukTcpIgbTjg9+MC3fcMvELSmuwB2+zLeZpf2906FWVDBwc5lPG/7EUNm
X-Google-Smtp-Source: AGHT+IGOUerF8wvND1MvQqRu0y9h7niw1gkbpSpGup5x0vlV6FhgahE0EZi5VWWscKfcJmrzyEpUvQ==
X-Received: by 2002:a05:600c:470a:b0:43d:b33:679c with SMTP id
 5b1f17b1804b1-43d1f23b645mr124323965e9.14.1742219303281; 
 Mon, 17 Mar 2025 06:48:23 -0700 (PDT)
Received: from [192.168.1.116] ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d200fae4asm105655945e9.27.2025.03.17.06.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:48:22 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, lukma@denx.de, 
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com, 
 robert.marko@sartura.hr, luka.perkov@sartura.hr, lehmanju@devpi.de, 
 Volodymyr_Babchuk@epam.com, sjg@chromium.org, 
 marek.vasut+renesas@mailbox.org, pbrobinson@gmail.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250226064505.1178054-1-quic_varada@quicinc.com>
References: <20250226064505.1178054-1-quic_varada@quicinc.com>
Subject: Re: [PATCH v6 0/7] Add initial support for IPQ9574 based boards
Message-Id: <174221930190.73541.8194656879582030365.b4-ty@linaro.org>
Date: Mon, 17 Mar 2025 13:48:21 +0000
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


On Wed, 26 Feb 2025 12:14:58 +0530, Varadarajan Narayanan wrote:
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

