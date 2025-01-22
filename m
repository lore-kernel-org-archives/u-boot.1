Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8F8C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACD8A809A5;
	Wed, 22 Jan 2025 17:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KX5edihZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 243EE80977; Wed, 22 Jan 2025 17:12:53 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0666807EC
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so2289629a12.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737562370; x=1738167170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4WecP1KP8isqBoM7pVT4Xy25oYdrQeibrC8/xU52Q3E=;
 b=KX5edihZzlOOeIsH1tOlODG4a9dvTjHmjPVVA8UmZ/aykGb2C8ac4VRAT6MUx98Ofp
 5R+L9Mfsy39fWAn8EYq5vGL/Du04Kh4hGEzecgrRoZpGjcwaU3RHilogeCYqIlCO07TS
 EYVaQ1hz3tLk7RcK5jNffAOPQQVelKHmIUZvkEVa8eQPxf9D4FWNzkfYVmyvE+gpBREn
 A36tUtvSRA2DH5Hwroul5FIQihYVKUdPx3zskwVgm4kENceYA9TLaZEeH9wx+mwtv9lU
 SsjD5jbg2NMSpDCYDjYoDxtIjh5ksKHVwxLQ2cRCSaRrDNJXdrCEtizoXQd+76jOkwy6
 sxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562370; x=1738167170;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WecP1KP8isqBoM7pVT4Xy25oYdrQeibrC8/xU52Q3E=;
 b=xI9fBkwjzL+IqFQSkaFP67fCP31PRLZ0hfPyHS1JhbSZGrydWPngcgRRK1AEkAbnA3
 RoP85IKRsx2lC4S+NEw2xwxL6kWdudmAq9UVCqoDxSW7+E8O8lmkuNCPQ3WbFZpowl3n
 TRw+9gCpXlSJmfW7PRtmFCtAzKNBfc8sBsEBTArNNSkxS8SjnkpGXul2apUlw1jCEjbX
 zAHUD2IRrcPjwyOH3oEKhRgxDN3BXj9IwZ0SqNFyBdnZek1zqWtscAypDF8DI/2fihCp
 yA3YT3/S2p57hKqCew2U7fdeB9qGvKXzW2YftKBivxZWoi7krE+ABvyXpD678Uxx+uR5
 7TrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDKMhIHavUSkw1VqmR2a6OBs5tdluycVrr/jEsf+LE9hn41A3NMB0miPT0sX2j71xnZqcORFQ=@lists.denx.de
X-Gm-Message-State: AOJu0YykCcepAHAGNUCUB3dUYd0cL67sK8HJoE3uf9t5PTJSUgKCSnwZ
 G1lISMp8GRbGYWnQ3Kc+urVZQmGG3XUUTb38TpauHtLxKGg2Uiul0cKesAgrxzI=
X-Gm-Gg: ASbGncu+ltmnmxl8diXSHh/z7g3OCX676UMuf4+qEZa2TCdw6UQpklX1JLVA85f9AxB
 ADEULkxHzF5sYYmBWaqlNRuOSYQ6x/n9Mj3S99GHpPyBfyWo3GFR0/PlmWd7r2/g208BoVxFGEd
 i8b6bipmtU3YLuOCmNGuU6oxrrjPYuoC3Q8Zd9uj3bds5H+XqgrO1Siil47Bw8BrwTOYuNkiZVz
 YbOkJJ9laMAlq2FlruL3fV69rXjU/REqCaha7TSbrw9H04hPbMw4mL4Jlu06P7iDT7f2Hfmk25w
 yC5sSVMcQVJr
X-Google-Smtp-Source: AGHT+IFtjL6LM/WKTbMaX2NhXepdsIC8QZc0BfpaaRV7UYbiNuhcykUnHVV0KwMiyRrni3HrzIcKhg==
X-Received: by 2002:a17:907:7f28:b0:aae:e52f:3d2b with SMTP id
 a640c23a62f3a-ab38cdc372amr2231993066b.28.1737562370039; 
 Wed, 22 Jan 2025 08:12:50 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce105dsm924966866b.39.2025.01.22.08.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:12:49 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@linaro.org, 
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org, 
 ilias.apalodimas@linaro.org, Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, 
 bhupesh.linux@gmail.com, konradybcio@kernel.org, quic_tengfan@quicinc.com, 
 andersson@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250110050817.3819282-1-quic_varada@quicinc.com>
References: <20250110050817.3819282-1-quic_varada@quicinc.com>
Subject: Re: [PATCH v3 0/6] Enable QCOM QCS9100 Ride platform support
Message-Id: <173756236841.1864727.1971103744286990488.b4-ty@linaro.org>
Date: Wed, 22 Jan 2025 17:12:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Fri, 10 Jan 2025 10:38:11 +0530, Varadarajan Narayanan wrote:
> The following patch series enables support for QCOM QCS9100 based
> Ride platform. The QCS9100 SoC is a derivative of SA8775p and hence
> this series makes use of the SA8775p related code to enable the
> QCS9100 based Ride platform support.
> 
> Use 'make qcs9100_defconfig' to generate '.config'.
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: qcom: qcs9100: Add support for the QCS9100 Ride and Ride Rev3 boards
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5c713a9cf1f2
[2/6] dts: qcs9100-ride-r3-u-boot: add override dtsi
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5cc2d9736751
[3/6] clk/qcom: add initial clock driver for qcs9100
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/b3c48d8f8278
[4/6] phy: qcom: Add SA8775 to QMP UFS PHY driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/4695cb5de70e
[5/6] qcom_defconfig: enable SA8775P clock driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/ea3d9be2038a
[6/6] configs: add qcs9100_defconfig
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/58bf7db9a554

Best regards,
-- 
// Caleb (they/them)


