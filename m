Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F190CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 319AE831E0;
	Fri, 26 Sep 2025 17:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SNn+de2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D28408373B; Fri, 26 Sep 2025 17:57:15 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3B183817
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-9158337ac22so38656039f.3
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758902232; x=1759507032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lf4Sff/IGySWbAnslFasTS79nqXBslbR/vU/6TY8lgc=;
 b=SNn+de2PWlxRDqyyZeGONPiU54gN8RV2JM8Cta8jcr7a/vlXuLlzH8T6X2dsTyeHqs
 6SWRPLuW1Eg35Q3lyGcUn0thVKYJJ/1PKHTN/2BbIM4T2jwEFQo/x0ij0DzF6NZ7GVMD
 cqtNH5MGdCwn2kfSHXtFdCqkmS5BPs6EMP2yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902232; x=1759507032;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lf4Sff/IGySWbAnslFasTS79nqXBslbR/vU/6TY8lgc=;
 b=kHJt0lDvY8QSlqTWsMPiIm3WsY6FxD+RCe4kXvh6MkUug+0KUWfacUEc+FJ2Av4zuV
 L7AalY1JlKKWKhFP+CO4j7B8kUl3i4RbQafnrqj3NA7knWu+MMFod3V+M92wNdHVPzBT
 zlC8kOoxqzX2x+JBjPxCkjhCkJUI6KyLodugV0O3YcYhf1Qn1ecb9KGUit/gM+BuMXmW
 Qzvg8J4mckQvD0fiQzf6Ljtpa3gtx56YW1p3AkqDJwA4RwGZuj5SE4StV76fueCEYBst
 oc6DgqQsCmnEXTnviVgVfqdxkVIRuC+REuXkwjMUq/Y7OBLmafCZnMCeMJg4iUnuNQPg
 GjNQ==
X-Gm-Message-State: AOJu0Yy3iKCY3EMZEu19z+CqZf0QzMsxFvc4Uq+OBidSp2QM1CH0cQoF
 Rj6lletH7WYBV7rBhYGjnA/5mLeFloqGX7z1QiGLZX/iBLAGxMvhdCw/zRQuo60nOU7lZ6wHump
 FWACnhAk=
X-Gm-Gg: ASbGncuRSFGwOBfSXlD7n90g1L/iVp9SzDJvfTbm/JPIKzDwg6v8XvMTUBGJ40ixQfE
 ko/eUbhPBrMl0rCyFwCqsGe6T57RO/2N/LmJTc+9oaWe0REz+ypKCUoXQGqc0x747ik4f0MzqSY
 JmeLFeboPsuTU6BJoTz2TPWfpiRm8X96MXM9+UcVGTfabBdXfQHRnPRAcx9ScgFEa9JEBX54Ma8
 WNgYHLVLJjbD8bKu6J53UJfhg/szKiWSX8dt8v0ydAavpGmvHK8X4+XoS6QLaRQFmZwDfg4h+hm
 rruPKG+AjEv5CgEOBbosAF6j9A6ZY0Qva0es5bCXW9sZA2tnUdSWuLXSgY1TD6Gm57AWDSDqW7x
 qyJmaRgkE179SIhULq8lH3rD+RIBOiyOnei4RJgNTyBDwBTGUnYJ89Lw=
X-Google-Smtp-Source: AGHT+IGVd4gWvfx4US/J5K3cX/7eb7gbhoKsdwJJMyjjDAqCUo7lP95Rr/bjGLNiwgTGM31QYp7LWw==
X-Received: by 2002:a05:6e02:2509:b0:427:8024:750e with SMTP id
 e9e14a558f8ab-427802475fbmr30563455ab.20.1758902232452; 
 Fri, 26 Sep 2025 08:57:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425bff81253sm23502615ab.34.2025.09.26.08.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:57:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, yegorslists@googlemail.com
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com
In-Reply-To: <20250925205150.453502-1-yegorslists@googlemail.com>
References: <20250925205150.453502-1-yegorslists@googlemail.com>
Subject: Re: [PATCH] spl: nand: initialize writesize for am335x
Message-Id: <175890223123.3683518.17642590196860530782.b4-ty@konsulko.com>
Date: Fri, 26 Sep 2025 09:57:11 -0600
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

On Thu, 25 Sep 2025 22:51:50 +0200, yegorslists@googlemail.com wrote:

> Initialize mtd->writesize in nand_init() as otherwise
> nand_page_size() returns 0 and this affects NAND read
> operations.
> 
> 

Applied to u-boot/master, thanks!

[1/1] spl: nand: initialize writesize for am335x
      commit: 9b45d574af1b64fcd997f08fe702a2d0ecfccbe4
-- 
Tom


