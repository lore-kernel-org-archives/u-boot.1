Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34EEC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6421587767;
	Thu,  2 Nov 2023 23:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HSiFgVpb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 139BD87745; Thu,  2 Nov 2023 23:49:31 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25CD087764
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a90d6ab962so18011027b3.2
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965367; x=1699570167; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jg2OTojgCxFXuFTktGJExVF7aAPgJ97MBBJtrePT+uo=;
 b=HSiFgVpb02pvkDwnEh9CgfcTZMdIvxhLVBULLFK+FhDA7WAuqzpDU01wY8CLLG/wTz
 5A1+1KAIVNW0eSDElX1ifTXWVU6VZ0jTNH0oa3RI/lDlfS892E3I5r0nefYyL+0oZvro
 Wtrp0+Z7PgMBmVgE1eCkvuoaAkDMvUAM46ht4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965367; x=1699570167;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jg2OTojgCxFXuFTktGJExVF7aAPgJ97MBBJtrePT+uo=;
 b=Ydnwvgki89YvMzoSYb0QIQ86nVOrL1s0Zm0BJN5nsk4M4+LIKlxoPXzg5/xMDWsHj0
 kJRM2PEIwmSe3kzkjGFgehrzRi9K+McSnPLNTePbdA+wcr/qG5l4k60lGg+F4OtrSgvK
 jaxmqSpip/lfvuKYEfxkAi2ZP6LheVmzo5jK4fPtRWLMxgdhWFaBpaQyheTiGxBU3BVd
 7IwNhVLYiromYYbp+0dmTFusaG9C3biBd7KeizzTfmOADjfP4MiIpjYXmwPDf0J5yGF2
 vJXdcbiRj4FYGngzbSzG7XlT8qw5EKFqknaxGcnIyIzwmkVxOSKZhFJ4qWeMu9TsmFFo
 MxhA==
X-Gm-Message-State: AOJu0YwQws/ubsgJYxZuyyEZl1c0M2V0MfRbq+2Vaby+NWLBkyygnPig
 meVsz7kHqJxZz2y2SpUU3tMD2dFDMM4NuPa2qQ8HbQ==
X-Google-Smtp-Source: AGHT+IHcOS8DYNDoySH9R0mWiotbaCAkqlbFR0fqxrtJYhFhQfdpCWHcln2aAZ2hp/qfoK0J+Y2HpOOudtrvM/pvWZQ=
X-Received: by 2002:a81:9a54:0:b0:5a7:fa8b:3fa6 with SMTP id
 r81-20020a819a54000000b005a7fa8b3fa6mr1238755ywg.9.1698965366693; Thu, 02 Nov
 2023 15:49:26 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Nov 2023 17:49:20 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231014204033.3077052-4-sjg@chromium.org>
References: <20231014204033.3077052-4-sjg@chromium.org>
 <20231014204033.3077052-1-sjg@chromium.org>
Date: Thu, 2 Nov 2023 17:49:20 -0500
X-Google-Sender-Auth: _BNHFdAen_sVaaqhoXvBZ4k96IA
Message-ID: <CAPnjgZ1YYCYx5uP-FyHWOam4vz-xwHBmir=1TzKJkNd_1za=tw@mail.gmail.com>
Subject: Re: [PATCH 3/6] binman: Ensure attributes always come last in the
 metadata
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

cbfsutil changed to write zero bytes instead of 0xff when a small
padding must be added. Adjust the binman implementation to do the same.

Drop the code which looks for an unused attribute tag, since it is not
used. A future patch moves the attributes to the end of the header in
any case, so no data will follow the attributes.

This mirrors commit f0cc7adb2f in coreboot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/cbfs_util.py | 46 ++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

Applied to u-boot-dm, thanks!
