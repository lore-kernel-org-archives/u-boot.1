Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAB7C3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 17:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B409D82C7C;
	Wed, 30 Apr 2025 19:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WRtjpUXO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D54582C2B; Wed, 30 Apr 2025 19:03:49 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D2BC82C49
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 19:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3f6eaa017d0so107295b6e.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746032626; x=1746637426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzZ1ADmKmBk+8IuWNgNQD6OQrjFeJUVNOMf7rkhkngk=;
 b=WRtjpUXOGJ4U3eN+H/FBLusrKUCHaeID0P55jtk70X4epi3N74FPjWDKPOM6OTmU80
 AgK+ZD1d2e10ImTNifHSm4sR9N3BSj31HPg05V7xyyv/HdMJV7yRcGzbBrv15NURr5iy
 C9K5XN0ySOiVuYuOdxLDG6l3XcG/efc9SJoXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032626; x=1746637426;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tzZ1ADmKmBk+8IuWNgNQD6OQrjFeJUVNOMf7rkhkngk=;
 b=tcPcxMyx2BBEPlgb+iqBoMPaGKB/TRP79GWPenmlGC34TQhUN68YXRHXExySfKufj6
 6Ch/GC4e7qXyD8q21oVbz+jFFPbl4sO8NSInuiFtUyxLvVhYDK0TpVTxtXeqryy6pVAK
 jZ1KFNc099EzTcXQ0HroKw2UqX/K24/maA2DB0RXLURq5f3SVnVaQvrpveoMVzpIZh/J
 AMDtaZc/EUn2ix52VgYQxyu64CRF/mL+yYDU1Yv0X0U2seuOpp4qfb/oVoTHUfkFOC3F
 GOwQXfdMc6K+SCRjC6P6EE9ZzHWpUC1RryB6NfdhLFVuAd4aG3eqaewcILxVZ/tCTAxe
 nEuA==
X-Gm-Message-State: AOJu0YxfQ4Lr2QHTESssEo3Fo6DvLjZwRvqpgOHRkgyBB1zpzn6ZdtUL
 jhbAcelEqsg/mRyoIKynZiA22oJMvUP3Ck4FLhNXxj/luwtA8ORnt2oeVEhGYzNL7qJ+O/Hn8l9
 o12w=
X-Gm-Gg: ASbGncvlKvkdvX+2nOTrzsMe7p1HQTr9dZ9PY3rlwheaSJI/m/PL6ZCv6x9NcKPERao
 sgAqJzrBhlRoCRbV/ojKOlGpOzF9Lq15TBvKAL6fJmcqg5VCygDtDDlb2FPTRk3XIp8R945sxNM
 yZ+XwDIhodqLuVTeu0Pl3ufsPzuP6XI6EqmLE7sYnjzyheHUsv7a6Cad+rARVoRZyCw6VsKWYhk
 eGu5pdiKpTfQ5UGuy9JYR6mkJl7FQeAuNeqvDIKlssgUdjLgjcNzbQ84zBgRyLNiX86yoYzs6oN
 IdCfpB+WmTx2qTwG0nXCzTyGwUymZrdSPk9IRDaj9eotI6CSN/8JHKt9tOCK+naFR/RY+FXtIEW
 R
X-Google-Smtp-Source: AGHT+IEiypEofHw6zHq11WiJOw2schWxS4IVpqQl3SGv8NI8QFfzO0Z9W7wkJ9lTyCJoVi9Tq0+bhQ==
X-Received: by 2002:a05:6808:3194:b0:3fb:e9d1:9548 with SMTP id
 5614622812f47-4024395d620mr2747779b6e.26.1746032626067; 
 Wed, 30 Apr 2025 10:03:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-402e1c102c8sm456111b6e.16.2025.04.30.10.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 10:03:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@amd.com, Prasad Kummari <prasad.kummari@amd.com>
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com, 
 padmarao.begari@amd.com, git@xilinx.com, jagan@amarulasolutions.com, 
 n-francis@ti.com, d-gole@ti.com
In-Reply-To: <20250228091723.1732878-1-prasad.kummari@amd.com>
References: <20250228091723.1732878-1-prasad.kummari@amd.com>
Subject: Re: [PATCH] Revert "mtd: spi-nor: Remove recently added SST
 special case"
Message-Id: <174603262457.1760506.5379477061150781302.b4-ty@konsulko.com>
Date: Wed, 30 Apr 2025 11:03:44 -0600
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

On Fri, 28 Feb 2025 14:47:24 +0530, Prasad Kummari wrote:

> SST(sst26wf016) flashes have multiple erase block sizes, including
> 8 KB, 32 KB, and 64 KB. Since a 64 KB sector erase cannot be performed
> on all blocks, the 4 KB sector erase command should be used instead.
> Enabling the SPI_FLASH_USE_4K_SECTORS configuration allows the use of
> 4 KB sector erases, but it may increase the erase operation time for large
> memory flashes.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Revert "mtd: spi-nor: Remove recently added SST special case"
      commit: f59cb6a6970bd5603e225acabf741b930fd43156
-- 
Tom


