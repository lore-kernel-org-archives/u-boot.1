Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399BAE71080
	for <u-boot@archiver.kernel.org>; Sat,  7 Sep 2024 13:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E9AC88703;
	Sat,  7 Sep 2024 15:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="iid9FCP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3381588D52; Fri,  6 Sep 2024 23:25:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEB8088966
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 23:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ahalaney@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725657910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r13ZMcuUN8EtVpysmy15C7sCtILZ2K1cEYvohhKKeFo=;
 b=iid9FCP+cZyHT6PPEJ9qWExwAfdA+iyA8kbpj0MQbwUk5woWTiiRn9Yi7ZcqW49ei5OdEy
 q7EXmFTrJKZwNbE+6xJKlz+plbAifFEo1/PKvwzbHeEtDjfIVqnNzuQGfdvYldlOPunCwk
 oAUrjYzoXIpC/vM9fP5UYdP0dBHejYE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-iGlX0bn2OwSBu5dyBsDV5A-1; Fri, 06 Sep 2024 17:25:09 -0400
X-MC-Unique: iGlX0bn2OwSBu5dyBsDV5A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6c3702d3ecfso34380386d6.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 14:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725657909; x=1726262709;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r13ZMcuUN8EtVpysmy15C7sCtILZ2K1cEYvohhKKeFo=;
 b=YezxcF5lYcNQgkjP2DWJFbc+y1VgXTJuXxsc86E1v8RdZvCAwTcNQtNRDD5dh3ClDD
 1eMWxkBO0/PUXumYLnQfVBrQx7hACQ5vVu0Rp7ufsg8e7aHE7L5vFxavN29gxqwDjy5t
 PYC3o1OdW04ZGwNyb1P2VAIRL4JLKb5zjqGz06GyI4wY0AWk1UwmpEEPbqf80nS40hHN
 inDZQROVKEf4XzJlPm6cRnWENeYHQyYWTnD8AyXuzPhF+SMO2GZSvF9pwq9gaftfPz+a
 HWqPFjnB5TXeETlejfogrqArP7ETLMuQDt4OYa8JFXCbLq8ohc/vPsjSplZrdCNjv8BK
 SZKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYfOffDli7Kv4/JJ/R8nkYJyVXWcTqE6bylF93RyOP6w6/7L+9AbiopP3i6kQOsobE6Nm93TE=@lists.denx.de
X-Gm-Message-State: AOJu0YzMq7KfVukd3WPNk6sRSgdj5NmjfpBW09+BsJ6Nx64E1sWxnMQq
 lxU1pNeXjriPBpKR5gNbGCHWvCMr0sIif1GmujwhUz1eW2BIWY8HT/b2ZxVjuLoTo3INBzEhqyJ
 YkhwQxWQ4yVRZYBHFnn1SU2HLxiYqs5J2/LaTk0j0q9BRFs2rra8=
X-Received: by 2002:a05:6214:4888:b0:6c3:6e6f:794a with SMTP id
 6a1803df08f44-6c5283fcaa9mr53244456d6.20.1725657908788; 
 Fri, 06 Sep 2024 14:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw22/HjAuar0SDuevkAW4harcvqDMZX9TbIt8AELvIa0oHfWweoeZvrfkOOFtd6UTkph9BCw==
X-Received: by 2002:a05:6214:4888:b0:6c3:6e6f:794a with SMTP id
 6a1803df08f44-6c5283fcaa9mr53244156d6.20.1725657908389; 
 Fri, 06 Sep 2024 14:25:08 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5203148f8sm19967006d6.86.2024.09.06.14.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 14:25:08 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH RFC/RFT 0/3] k3-j784s4-r5-evm: Enable ESMs and related PMIC
Date: Fri, 06 Sep 2024 16:24:50 -0500
Message-Id: <20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACJz22YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwMz3SxzC5NiE93U4lzd1LzEpJxUXZNkkzQzS4u0VPNkEyWgvoKi1LT
 MCrCZ0UpBbs76QW4hSrG1tQDWuIxDbAAAAA==
To: Apurva Nandan <a-nandan@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Eric Chanudet <echanude@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
 Udit Kumar <u-kumar1@ti.com>, j-humphreys@ti.com, 
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.14.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 07 Sep 2024 15:02:07 +0200
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

This enables the ESMs and the associated PMIC. Programming these bits is
a requirement to make the watchdog actually reset the board.

Note, this relies on the linked devicetree changes to land in Linux
first and get synced here, otherwise the board will fail to boot!

I've tested this series (with the linked change) on the k3-j784s4-evm,
but not its sibling the k3-am69-sk. I'd appreciate at a minimum someone
to test on that platform to ensure this doesn't break boot.

Link: https://lore.kernel.org/all/20240906-j784s4-tps6594-bootph-v1-0-c5b58d43bf04@redhat.com/
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Andrew Halaney (1):
      configs: j784s4_evm_r5: Enable ESM related configs

Keerthy (1):
      board: ti: j784s4: Initialize the ESM & PMIC ESM

Neha Malcom Francis (1):
      arm: dts: k3-j784s4-r5-evm: Add the PMIC ESM node

 arch/arm/dts/k3-j784s4-r5-evm.dts |  7 +++++++
 board/ti/j784s4/evm.c             | 28 ++++++++++++++++++++++++++++
 configs/j784s4_evm_r5_defconfig   |  7 +++++++
 3 files changed, 42 insertions(+)
---
base-commit: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
change-id: 20240906-j784s4-esm-enable-4c4f698fe7c4

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>

