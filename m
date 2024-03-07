Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE721C54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 09:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFBE887DA1;
	Thu,  7 Mar 2024 10:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X+baUSW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E59187DF6; Thu,  7 Mar 2024 10:26:51 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1321287C0A
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 10:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a4467d570cdso82482966b.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 01:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709803590; x=1710408390; darn=lists.denx.de;
 h=content-transfer-encoding:subject:cc:to:content-language:user-agent
 :mime-version:date:message-id:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xX6iEg5s3t7yZe3OPQa9Yhb5MWkIY2OV2CMdCqdQqE=;
 b=X+baUSW6s++EYaqG3NsBbW7zH0qRYd5byiodj2/rJ2Inme1CUvq1A6N0y1yfHFw+y1
 bskS6dnLAqIt5SC/+nflH3Hsf+qUv67dKD7jxgnL9KNhHR4E4xLJX6sEaFTGdE5xNS3z
 vRIm4xuNJTRse9vqxFRpX9EpQaqvsqM7dm/1JZCSOtBPrEicgR8S/Xsqxnm87608YfNd
 /Ox+NoAbj4JnP+2HUpeqJYaYJGjwA4K8Y5GpKlX5edaPa705XP1fsl9tSNdIyQE9I80r
 bk8YoeSk9QxgysBMjxdd97ubhsgHadqegyZkkObpLZbMXweXuejcnpVIjlg2EQ7i8I81
 NuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709803590; x=1710408390;
 h=content-transfer-encoding:subject:cc:to:content-language:user-agent
 :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xX6iEg5s3t7yZe3OPQa9Yhb5MWkIY2OV2CMdCqdQqE=;
 b=Oxcuc5pNkOXcvHXBmbQ854KKkouNxsoQH1T1DF2ZKssRhDjh/eHtozvN6pCS9nJ15v
 98FX51EFikW1AYsk/RQVmIQpjVeL1q1fPKIWBa2UINHVz/wNlgAveeycApAnhFuCMG4U
 /0qO+6yPmkOGmRna2bMSDwhwAmCnJOz40Z7MVon5WgJdFZGehdPPQE8uENH/vpvsly6F
 32vhFDaZz7YKYsflw+PjNWqBH6Pty5rk1YTP6gkrapuDh3Yl8MlB6qDql6zMR+T6/aED
 +WzJ1VHRmlYFh8/ncb9gWuhRtYJ1L8RE392WdQXmHALkhPWTHA8nJHcbKAsxWP+dUFwh
 Ru9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE/6nsJFxhIDBDqE6vbmQgqp3xQ3Vsr+uG13I3NuSoj07Yise4ttNXgZxbelElGBCwYDKlJWB+u8sUi6GMYoMGzLTF2A==
X-Gm-Message-State: AOJu0YyvgIxcKCqMBiRRDMoyp5kQquzIe64E39SgcRdDrUJv5v29f1lH
 qXFzE2v4q3zZW9yO2bxKo0xcOZ0mW0FqZ3IpV++yUtQZNCFN0EGf
X-Google-Smtp-Source: AGHT+IEcJpVprG9mkl1q2V+Tsw3sg2Aa7jlpymA+vwN9T0iJzsHNjNdkzOCVvINP33C/Fh7z14Zl+g==
X-Received: by 2002:a17:906:1846:b0:a45:d3c7:b462 with SMTP id
 w6-20020a170906184600b00a45d3c7b462mr687812eje.41.1709803589598; 
 Thu, 07 Mar 2024 01:26:29 -0800 (PST)
Received: from ?IPV6:2001:b07:aac:705d:547a:31f1:d31b:1cb6?
 ([2001:b07:aac:705d:547a:31f1:d31b:1cb6])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a1709062a0f00b00a45a96a9c37sm2633663eje.65.2024.03.07.01.26.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 01:26:29 -0800 (PST)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
X-Google-Original-From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Message-ID: <4b64a9de-a840-4065-a530-f81155b4b9f2@toradex.com>
Date: Thu, 7 Mar 2024 10:26:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Breno Matheus Lima <brenomatheus@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Tobias Junghans <tobias.junghans@veyon.io>,
 igor.opaniuk@gmail.com, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: imx7 issues with Secure and Non-Secure boot mode
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello,

I'm currently facing issues with our board, Colibri-imx7,
regarding its behavior in different boot modes:

- Secure Mode (bootm_boot_mode=sec in U-Boot):
  When running Linux in secure mode, the idle time management does not function
  properly. The following error message is displayed during boot: 
  "CPUidle arm: CPU 0 failed to init idle CPU ops".

- Non-Secure Mode (bootm_boot_mode=nonsec in U-Boot):
  In non-secure mode, the caam_jr fails to initialize correctly,
  preventing the utilization of the hardware random number generation. 
  The error message shown during boot is: 
  "caam_jr 30901000.jr: failed to flush job ring before reset".

I have conducted tests using both mainline and 6.1 stable versions,
with consistent results.

I have also reviewed the following threads for potential solutions:

 - https://lore.kernel.org/u-boot/2536787.mZni4QDSI2@crypto/
 - https://lore.kernel.org/u-boot/CAByghJZn8d91uFr5JXSR=jXcfU4engZP_=buOk7MNNjaVeigLA@mail.gmail.com/
 - https://lore.kernel.org/all/20220608170223.1536594-1-festevam@denx.de/T/

The first thread leave me thinking the only solution is to use OPTEE,
but the last email is without any answer.
So, I am considering the utilization of OPTEE, as it seems it might address 
the issues discussed in the threads.
Could this configuration potentially resolve my current issues?

Your advice would be greatly appreciated.

Kind regards,

Emanuele Ghidoli
