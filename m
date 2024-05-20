Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F702C25B7A
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 15:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B89608863A;
	Mon, 20 May 2024 17:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jWMVVwCK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B42587E49; Mon, 20 May 2024 17:04:50 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB3AC881AC
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 17:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5727dc6d3edso7927799a12.0
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 08:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716217487; x=1716822287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lz6VsTj/Ck3WWOerXzYU1xWhWnbADEfcs6yVZ8ZCMSc=;
 b=jWMVVwCKEjssRJmcYeXdpmm7usLoiymP+kGrtAFrSfi5QvYH8k0dj694p0oXQYY0Y4
 X1hZ9nxkYd26g+nsHNlXf/9OB3d05CQlcYtQd+FLP+6dM0+X4BxTUPDfVIUlPXzgrT5X
 nPe23Jv5RG/cYQOKX66aR3dsP51/7lcKKggWFuBVxBA7ybMFH4Xk/fOkQAP8nFu/0NKr
 VIAPuFkiSB9J9G9pJpGbR3/eRmdfG4tUCkiLSca3VInx7HIOgaU3IGM27pPuzGrH2jYy
 vQ1wQn3eqIT/x7ksQ3GIVkEBiVSZ/w6UPCt0UA0pnmYm5eHFYV1HLfRVEKHuqa9I2fOg
 xOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716217487; x=1716822287;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lz6VsTj/Ck3WWOerXzYU1xWhWnbADEfcs6yVZ8ZCMSc=;
 b=b0nDg6kWtRzIs9QPaeGj1sHOc7SP4pggR0nNJDqXOz2ptJ6ny4TcCPSVI5ydyOMdJa
 +h1j1T/m+vlplL5xvpvASjkRYN8DbEipeQl9uSjLelJ1pB9bZK0hei+hus43OY2ZLA0Y
 SzsaijhLmumVb3VpPy3NBxC283TagKBltbTtZiwSaqn5FtpKjK8HzLeED+QysUja+WDu
 YbU/cBGzN2CLJxJfkjynCrVfDaK/oufvOugzWfMj9UiO2QRWhsfVajSQ7W9U/WfTbNQv
 oxe6YOEWH80D5rBEdIPFDxeYeEsXuOnRPpHWHClu008R1Y7JglUmLnXn+f0t/BxnhSJW
 AKqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcrfF6Na+T0vmhYjCxxstUub5ABTqjfH/3dSs1DHiednxo2pNedEhuEt2Gv8n+v9M1OSF8frgbpHsY/MOa2r8XIeI9mw==
X-Gm-Message-State: AOJu0Yy3Ud2McK27eUL3aJlC0A9TdGb7EtDYHnsJGI93AQVMEAsH+9A9
 +8htU4/+eVyw6NO/IaZCflXZwwgzDlEaZqePPKcOXaSEu+osPxrfalKPomafY18=
X-Google-Smtp-Source: AGHT+IFQzziFXhGaHS19LpnLGyYLS/Qas4wWqEIFdgFCXrG/csqcr5I6NWJMlm/dmTk655Q5EB1okw==
X-Received: by 2002:a50:8e12:0:b0:572:67d9:3400 with SMTP id
 4fb4d7f45d1cf-5734d6b286fmr17622493a12.39.1716217487059; 
 Mon, 20 May 2024 08:04:47 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-574f26d1574sm7488198a12.36.2024.05.20.08.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 08:04:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@linaro.org, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Robert Marko <robert.marko@sartura.hr>
Cc: j.beck@linefinity.com
In-Reply-To: <20240514101824.23872-1-robert.marko@sartura.hr>
References: <20240514101824.23872-1-robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/3] mach-ipq40xx: add CPU specific code
Message-Id: <171621748583.910636.11085851061601126076.b4-ty@linaro.org>
Date: Mon, 20 May 2024 17:04:45 +0200
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


On Tue, 14 May 2024 12:17:50 +0200, Robert Marko wrote:
> Provide basic DRAM info population from DT, cache setting and the
> board_init stub.
> 
> 

Applied, thanks!

[1/3] mach-ipq40xx: add CPU specific code
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/31718ccb900d
[2/3] mach-ipq40xx: use OF_UPSTREAM
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/6eb2efafc33a
[3/3] arm: dts: drop downstream IPQ4019 DTSI
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d8903c0f94ee

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

