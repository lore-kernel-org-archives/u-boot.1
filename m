Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4205ECD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C99DB848FC;
	Mon, 25 May 2026 17:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20251104.gappssmtp.com header.i=@monstr-eu.20251104.gappssmtp.com header.b="lNJD/nkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC3E848E7; Mon, 25 May 2026 17:29:27 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A49A848E7
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso946443a12.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1779722964; x=1780327764;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/DBaYKfUWKMSe3JfWFyvGuEM9OYXZbOKH6+E9M/PTA=;
 b=lNJD/nkHxTPJ0pqMOURiXijapvVJUZ6PoYT7Ypde2PXf8wu+TVBwfamlI+i8hKybEH
 QMvoJ4L60v55+epZc9BzFwElxMuNL7xxRdIcmPFhqn3GcuDZp4nGuQvjG93Pa3QBnXsa
 +0Dd3Ey8DVvTm/f3JeEJrYadD9IpfuPnC77x9KuFUYcOJgeBCtvJmJYRb50q3mtPlUkW
 fLssIElNZnbVjWNVuCvrvHd577P0mChYrSbxZmbUPlcDQvjS/1LlsK+KKweZI/ft6c/Q
 SlKe3Kx9xZn/rZkUbluS3h8lyVF8h83hW03T0+hjmYgm3i57ISMdni0JwoOvTcD3EVeo
 QoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722964; x=1780327764;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v/DBaYKfUWKMSe3JfWFyvGuEM9OYXZbOKH6+E9M/PTA=;
 b=h8AZBf/JrlzF8UnPUMwN6TfMhGMB92JjHmwtsDj15dMEzPGrBV6ofsFRwSCqj+RHDb
 49tRhpvQooBiOIpcBpNcFNh3pBoPeKikjFcFS3zNaXM/6pRXoNYMqyXG6yQfXxCysfgV
 Fse4ZPuMr4sNJIFU25Qv97yFiNYf0QwxHuA9OZB4+eQ9caSUzX+VzShk2OH1Ctz0cxE5
 UFBQfD3sAToF+hSQAzCRcds9nTtJXsUGWt/CgjQx/XunH/1YRAwasQpckhj3prniHG27
 YOJGOhmiPqGzE36beX9ZwUSIQvk0CZIyqOxIL8EwJKVHjNXmiU44xc9IdtR72uDe1mgv
 Kj/w==
X-Gm-Message-State: AOJu0Ywe1tx2XJ6eUuTWrP5SXHCZWjmcXAuWLer0pd8tG175eEQosb0v
 JHi5WCdAE79cW6vLwf6RcUPo4yBVV/dw4PPZv3br38T8+UWmFFb7HS3x6kClDwlOiI21tiYQClQ
 8AYPESg==
X-Gm-Gg: Acq92OGCYasbzDMqXXxAQU3XHmlsOnpxmEEWRGljCBlNTpOYaRc+mA44SfloUcpShMV
 WOUcBPA0c9ubASYE06K3MQjJKCUeTbND18Ee0pCrtmWf50quGSVThH1JiFLqtoYTaPQDjZ9wryu
 sdPqDMLe4pex3/hwBiir2UHiwjbeXT++3txjiY4AQAAk7dAoiwIfHKkdsT/Ry6YlHwy7ldsUJ9r
 EE28YR6WQLJc2m7D3SOHL+gYkteWbJFQfDDTN9+RE/zs6UkqxUOZKVol75G9vcRSLtGxXaQwySW
 uJg+R7DPF5LlgYmmBqHVHjgatWnHJxJHH8V2O4ntPcZevYGWGrdQ7J94eHKjrjvSOTCevTFCCaU
 gtvKaWqxFIL+eIOvsreJUSLQNyrdhDLB+720l7rYhaA78qEm3ullT2bp3KYJAGwGC3lL8z2M1oB
 APrKaf+nK5YfC5QthSpI6SyVnEe9sb5QguGpw=
X-Received: by 2002:a05:6402:510e:b0:682:c363:d96f with SMTP id
 4fb4d7f45d1cf-6889c44e129mr6792452a12.10.1779722964423; 
 Mon, 25 May 2026 08:29:24 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688b9f60898sm4306674a12.13.2026.05.25.08.29.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 08:29:23 -0700 (PDT)
Message-ID: <4f24dd76-54eb-48e9-ae90-1cbfd8755caf@monstr.eu>
Date: Mon, 25 May 2026 17:29:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] amd/xilinx patches for v2025.07-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Tom,

please pull these two fixes to your branch.

Thanks,
Michal

The following changes since commit 987c93fc68a641cc735c9828872511a947e54191:

   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh 
(2026-05-22 13:30:42 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2026.07-rc3

for you to fetch changes up to 8a5989acc6ff1430a2775178d2e6b0b5d4573247:

   arm64: versal2: Fix buffer overflow in soc_name_decode (2026-05-25 15:14:05 
+0200)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2026.07-rc3

versal/fpga:
- Fix unaligned buffer handling

versal2:
- Fix buffer overflow in SOC name array

----------------------------------------------------------------
Francois Berder (1):
       arm64: versal2: Fix buffer overflow in soc_name_decode

Pranav Tilak (1):
       fpga: versalpl: Fix unaligned buffer handling

  board/amd/versal2/board.c | 9 +++++----
  drivers/fpga/versalpl.c   | 2 +-
  2 files changed, 6 insertions(+), 5 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
