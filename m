Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4382CD8C9D
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 01:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FBDD84851;
	Tue,  9 Jun 2026 03:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="okjm6o/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B8EF84851; Tue,  9 Jun 2026 03:25:04 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ADA284869
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 03:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bec453b6ffcso52764166b.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 18:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780968299; x=1781573099; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e98YqBIjkZY3cVWozebSuCkpVF35D84I/vYK97POTYc=;
 b=okjm6o/hKcyCDKlhMno1ijr53r6q+BNe/qdliWoOjd/hrEEEQRwAjwVJMoPVuViFX2
 xeCuRfbPRGaphBDxIa/TQirEx5Kx4OhFjm8DBU5XnXdrw0FK+XyJFUss+iuR2IH6IIdp
 NDC7q7fPSaO4BZr/01F6MsiJy7HUQuCtjUQ1Zd1rlZjGolQo13Oh7RbTAU5FMg2nX397
 jUDZhrgbKaW668W1hqpFljp/3gHS2FJaQpCC4tsB6biahIZR4eowFWn+Zhtj4iRSoI9k
 jOWVbLbybD/QBxmiPIJRRA59pZLEyRyelxHG+ZgTsT5IR8YhN5uEjLD0g30FJM7FEZH8
 2mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780968299; x=1781573099;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e98YqBIjkZY3cVWozebSuCkpVF35D84I/vYK97POTYc=;
 b=W+tuFEWW1UjW8VCrBA5CZrbNvQNCK8fkQ/fpLzKhjYoCu8qPOzzYK28KyLZSW4g7eV
 P+AEBshSkvEp2iru4baik7qBsHU9Zj4l1MS8SKsz+EZRQrWwWc3L9PP1o4JWnTEubSS3
 JC78RWhhnIwLd5gqtIo7hJGPNWueiOgBQ/jPorluxWw7bO4XqCURnNsYHy+3xvik8Qzx
 uvyzCl0a0hRn/OAlvo0+uUZdues9mkUqWZ4wp4cO2lDrnE51FCc1w6O6Fp64FYOIEMOe
 VuzypDKc8uu56qybWjUqG2SJLoM3q+lxTsRoZbBXmcqUUz6FV+VWKrU7MB3b2ydBNPRm
 FY6g==
X-Gm-Message-State: AOJu0YwQ2BsbEF4VXj6UNIdGindW3APLxnF+3EcQaa+wWOs/bRyAvX2C
 ow5VwKxK9OvLLCSZaMCP4uV1NQOk+YqqUXJqE5cQiZfuRs/NE4vePRKdZFPRLg==
X-Gm-Gg: Acq92OEqbZguNhjY5v3qXUYkeq/ttjpV8OjKMs2RrzNVRFRXdd9S1t4C3T8d2t0Is7p
 GAkRGItZgrccBoBV0QAWFo+RIAzU0z1gT0SP0ZiCXJY28B7ynR400bSvMr8yiCOkOy/iGnrmeUp
 Nls5Wt5nkAawnl7wd1gWyY2SWdXR3WNJqdj4yppjCX9ZiOwAuPQbfIOup29OnoS49wOPpF6ge3v
 FFSqMjl1WvomDLdAAcjcPz0q6GT2sMxTr1ZfxxQ8/si8lGAM7Y7nRs7FRgQNRdA5oroZGze+jsq
 ZMhCHe4L8al1m/GWCzNorjY5cXFYS/o1oT8djosqA4T93jeOzBQ1NG4pxcFDiG8VRthhpdBUxSP
 uisJ0vts7m5H3gD+MqpbkofcLhZ/7fFHg4+cinzTIljkVjoD6fBqtPNqsNhCGFvhT2T+da79EJM
 HtqIJDTd2MMz3PPVFh9UaRq//myfUlceuOHWqbbv9/SAUQU+WmVl/NhaoECGbBuTMH2RHgKdVc
X-Received: by 2002:a17:907:96a2:b0:bec:7b80:7267 with SMTP id
 a640c23a62f3a-bf372932a48mr381569266b.5.1780968298492; 
 Mon, 08 Jun 2026 18:24:58 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf055309368sm939374966b.49.2026.06.08.18.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 18:24:56 -0700 (PDT)
Message-ID: <49fe8243-d33b-41ec-b492-33be6ab5ca46@gmail.com>
Date: Tue, 9 Jun 2026 03:24:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/8] Kconfig: powerpc: mpc85xx: fix typo
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
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

While restyling Kconfig the script checkpatch.pl gives
this info:

WARNING: 'Enble' may be misspelled - perhaps 'Enable'?

Fix by changing 'Enble' to 'Enable'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/powerpc/cpu/mpc85xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index cb564b32c072..f0580e3877ad 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -973,7 +973,7 @@ config E500MC
 	select BTB
 	imply CMD_PCI
 	help
-		Enble PowerPC E500MC core
+		Enable PowerPC E500MC core

 config E5500
 	bool
--
2.39.5

