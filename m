Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AE6C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 17:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 513B2888F0;
	Sat, 20 Jul 2024 19:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HWeiqHKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0822F888B2; Sat, 20 Jul 2024 19:10:26 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE5B7887F3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 19:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70360eeb7d2so1462472a34.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721495423; x=1722100223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxD+3jLIJJ+iODI6+xMxbXQa/sW/hLDg6J2WTQ7ODOk=;
 b=HWeiqHKindiiT8n2t2SxlmY0Vomt89o1hxspgBdXbP6SehhB0PFxSvW5Z/8+yXRNxN
 4sDTfXesS4YhCVCNk6i+sPxofkEr3hse+Sincz1nwqVzVgc/YAEgwcOl+xrGDVtRuwYr
 vQh0qd0WhEVnHiUlhchb6H2Fhq4hVCBqyYpL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721495423; x=1722100223;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TxD+3jLIJJ+iODI6+xMxbXQa/sW/hLDg6J2WTQ7ODOk=;
 b=cF8dOPdjgm1sIW3Vm/tIGP4IjBUFEQLx8/NvqrwgPCOQvo6DqtEWm1pI7O/+9C8wES
 gRcqIJnNAshp6s7Qgyevy0PoHnGHPO9hjFOrW9AQV4o+AdZhRf/tj/a8/eYIP0PPcE3b
 c1l5R0GF+/AmG0HqSCK3kptMbYzwlF2StELlxY+qh94OTLewsEFo69sGZvuQoiYfx26A
 6rJlTmgc8YM328uxqTv6b36d0erWgANVoV9/Mb1Sbu0Tmtd7wy1wzSKiTsfrs/FAqHUH
 sxvjWNi98oBs0oIN8IPPa1z6YBLYpo4K+B9h+eWjEEGksaydxU3JIMxGOVFBYDwKGwNi
 g9ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfY3ASPDZJCd/MFVEyNnF0+b8hC8tZ1hjIUV62MGMDXzzf/3BPxeFDbEkJiQjSG4EgxIW61vYla/vNWBh9sa5AtvVsag==
X-Gm-Message-State: AOJu0YzF2Fld9S/dCAQNMQa5PKFeTcEdnygWGcjZV9wkIq8QA5OgLVaA
 DV4/mT/UWm6hL8k7hAjF/bbqCnvHrxzO4SrqnzbrNVCQkktDK807hCEMMO7dt/s=
X-Google-Smtp-Source: AGHT+IHABrDUXzpHsFmL0ixzYINxBAiVXxgklN74osJh++UOiicgoFQ8cNjaPrv81nQtOy94kREBOA==
X-Received: by 2002:a05:6830:3590:b0:703:6cdf:461b with SMTP id
 46e09a7af769-709008d961dmr2699712a34.6.1721495422795; 
 Sat, 20 Jul 2024 10:10:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6189bd5sm773037a34.65.2024.07.20.10.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 10:10:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Anand Moon <linux.amoon@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20240717145446.192222-1-heinrich.schuchardt@canonical.com>
References: <20240717145446.192222-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH] cmd: move CMD_DHCP6 options beneath CMD_DHCP6
Message-Id: <172149542001.3268377.30648189416569371.b4-ty@konsulko.com>
Date: Sat, 20 Jul 2024 11:10:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 17 Jul 2024 16:54:46 +0200, Heinrich Schuchardt wrote:

> All Kconfig options that depend on CONFIG_CMD_DHCP6 should immediately
> follow it.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


