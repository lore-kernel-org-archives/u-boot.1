Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDE5CD8C92
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D868489E;
	Tue,  9 Jun 2026 14:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qaeYgLl1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB1A6848A9; Tue,  9 Jun 2026 14:49:21 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8906B846D3
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-68f36e1663cso9767821a12.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781009358; x=1781614158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQmXpriFF5Y3CglAYD5X+vV4aSntJt4Oo6xGSpywt9s=;
 b=qaeYgLl1Yp8QJuEc5NDXVEKDpbXaRe3MpWIz3KHknDoE/YFAwBO0DimXA6uVM9iwVr
 4pcj5aZOehSYLzmqCqwtriDjn0TH2AlNCmifNwhhc6eqIdfZMTyv0KArmTOckCR4ZV6a
 hlbxMcA1GJLFiHT7ecPlbuy3MchzpX9lKNJlGfXggCzz2du6JFIxltysvi2Q2rHiz0fT
 B/YQozgiiwq1q2HRLAe0AULBBYoUtp67BwKgf3ghFqlj9P/eAx1Nbndp7tkdS1NrAs8d
 7NOIthH2Qqu8jNLvavLt2TjArBekEBw11awHMeOrYtQ2aJi87ZmvyfVI8ceUSgo7Ug/a
 Pjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781009358; x=1781614158;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CQmXpriFF5Y3CglAYD5X+vV4aSntJt4Oo6xGSpywt9s=;
 b=oB96Jn2GvGOGz0jlSuwW6mJ5aHf3nEYlIn2EbXIcO9znr2p5lEJS+SQ1TEHIi+AkTP
 s4xcgGXkx2mCi6Ueexnm2MzpF67hieizppwRcR6jjeMtuUeOwafcbx+nkSp6A+mAPFMP
 fj8QQZzIuXEgnXHeMyLE07eztfVcF4Bi1WQd3jsCZXbouRQAeVsE/y0ZZ0H0QcB94ifk
 /falj0KVRwARXkUIneYuf2o2KQzZ9bS5gIUhYm145WHVUKo4qqS3v8nPWK1dE/GFqXi1
 khrrS/KhvLgWhVqAJ2yMeLWgaTqxsWZiNdwDGdAbX0HRPxxSznPvQsw/ps2Xcgk1sZdI
 6Esw==
X-Forwarded-Encrypted: i=1;
 AFNElJ98E6K/PD3+7a801AmaD3++4mBdCvO2rgtH/LZ4klorjrz3KpePa/JV0DU0e1jemCQkPTPwh7U=@lists.denx.de
X-Gm-Message-State: AOJu0Yzooe2IvqXkXfk5tHnizj+Pk2fqvFEDKQR6JtBVF7QWEUB24W+/
 B6kVKhi41+ADsy78OMRO3woxmpTmY0m74vRb5rLtT0ALRbyZiNOWKyNhtsiMKdF+Yvw=
X-Gm-Gg: Acq92OG79Osq3Pg5rFviFKYS3MtxQdMvRkkUMY5ZEDHqcOjYsD3RhRtyQRfW467WlGF
 h5QZ08Qwj0XqjH7+/fSEZwQU26Qf2FwwAkICPfK8mA5r+hVpXP1Ma/v30X+195ciIhRKIUh3h2j
 qcDuMM/yCGzBfhVSFjTI6EfzsF1b//VXQ7sLe/nNuXyZsH4xfMQbWuJPkwZVUybhAlz1kTFIZ7y
 tnCzcJEV71vuPxgfuYC6VFVPaqNRm6D8jsUYDntfK17RAHyk8KkjA107lFbTAPc38Y+/QFgZBQX
 O0TxMo1bcMSY1WALrTkBmidfjIJ4UxRAbx+RHXLue6xEUHqFOGsnuabQ4Y/Np4rFTHIdI+y4Y5u
 IpSS17FK0qBkp8ElHK4l2BI3Ou5yuj90bXqfRSc+KsgkPz2DW8w8qNBXK37W3V1Bp4PkKSw9yEu
 Q4tLUx4/jOwRCvSRCsf+3tXx+36Izl6u78yWcashbuvE1VoboPkh3x2s0py9fShcZFiXE7eaXP5
 gto
X-Received: by 2002:a05:6402:3484:b0:691:ad86:ac51 with SMTP id
 4fb4d7f45d1cf-691ad86c033mr5751759a12.20.1781009357918; 
 Tue, 09 Jun 2026 05:49:17 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b55d81sm8689526a12.27.2026.06.09.05.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:49:17 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Federico Amedeo Izzo <federico@izzo.pro>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260523-qcom-ufs-regulator-support-v4-0-45639533b06d@izzo.pro>
References: <20260523-qcom-ufs-regulator-support-v4-0-45639533b06d@izzo.pro>
Subject: Re: (subset) [PATCH v4 0/2] Add regulator support to qcom-ufs driver
Message-Id: <178100935695.3342853.6296256088876220341.b4-ty@b4>
Date: Tue, 09 Jun 2026 14:49:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Sat, 23 May 2026 15:04:23 +0200, Federico Amedeo Izzo wrote:
> This series enables UFS support on SC7280 devices with UFS3.1.
> SC7280 devices with UFS2.2 were already working.
> 
> The root cause was ABL leaving vcc-supply regulator disabled on UFS3.1
> devices, and enabled on UFS2.2 devices that worked fine without
> regulator support.
> 
> [...]

Applied, thanks!

[1/2] regulator: qcom-rpmh-regulator: fix regulator mode mismatch
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5e6f370c1e3d

Best regards,
-- 
// Casey (she/they)


