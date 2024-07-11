Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98001C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 21:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 031F088619;
	Thu, 11 Jul 2024 23:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fW6IULia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C9CF88626; Thu, 11 Jul 2024 23:27:56 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0BE987B77
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 23:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-25e00f348e6so668283fac.1
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720733272; x=1721338072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EF77p9BtksvxZotgS2j5fdzc2Yvq84vtuO6Vi8ddCrE=;
 b=fW6IULiaTL1Ofa35ppjxyd0r/q4AKFSUvkOwTegUEc/aepO9MWNcm8oyeCh8qpWFAN
 yKAIlh7+fYuMReGXHh2UCyFidfHPHUWov8nOSgynao8uUQDE2EloWMZyKL5MqwUlCEAf
 PIbIgjkQ/KDj8zS8aG/CNHp8XIaUmsF0MzfDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720733272; x=1721338072;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EF77p9BtksvxZotgS2j5fdzc2Yvq84vtuO6Vi8ddCrE=;
 b=i49ExX89YEpYGipk/r5chvsWim8feVptoA0asNQK/KwkLwn7laMl+7fiiI4v0NdCbQ
 JGAB2zVIQznDI08oelwAxcHP+vDCwcZEDUkRgyQEjY1OCoQABAAapH3vzBa7AVt9nqYJ
 zzTnkGBPdKKr9ipoG2tNg3R3hR0yV122LRqz2N9uBuJdIXBazUEV4/TId6qVtoSPAh4J
 9jv+6k8AszYb5SXLTzzU1XV5R0TpG9mh4YypiYKIJttqzlDcpPU2mc66MEsN2PkPj5MM
 +rrCgQgP6H8M+/oMIGvCI9O/Dddo8n0/44g26JIBCN2nyCDFkNMrDTTMSuSuDYnnNusG
 AL6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvUsLfbqCsetfAkjs2MXhJSYQFk4SO5sCBLEuZa0U435ROKWW5dqTJvvF+3Skh3cjV44sjDab9dFRcEz57X6DjyT1rNw==
X-Gm-Message-State: AOJu0Yz/8oN+IXbvYbM5vA8/j16+DxQZf9xUYpvvck/P8AYu4xkwIMLX
 wFIsf0bfiaCncGyaXSwfxb2zekkkDITY5sADkRPVHqjOhWcY+UF3hp9PGIgoJmZLxx7jZNbw0ZG
 SIQCMEQ==
X-Google-Smtp-Source: AGHT+IF8U7Ihza5/J3JpO07OpWBSIv4ZiY+PE6PTnCBxMAXjDDrH7J+szyeh636rlOIWGznY4/FRIw==
X-Received: by 2002:a05:6871:712:b0:25e:b999:d24 with SMTP id
 586e51a60fabf-25eb9992dbbmr5906627fac.0.1720733272619; 
 Thu, 11 Jul 2024 14:27:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa29478bsm1824155fac.46.2024.07.11.14.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 14:27:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Joshua Watt <jpewhacker@gmail.com>, 
 Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>, u-boot@lists.denx.de, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240627112904.99969-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627112904.99969-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH] gpt: allow spaces in partition list
Message-Id: <172073327187.2744109.11937664314147509716.b4-ty@konsulko.com>
Date: Thu, 11 Jul 2024 15:27:51 -0600
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

On Thu, 27 Jun 2024 14:29:04 +0300, Mikhail Kshevetskiy wrote:

> This allows spliting partition list to several lines in environment file
> 
> ex:
> --------------------
> gpt_partition_list=
> 	name=boot1,size=5MiB,start=0x100000;
> 	name=boot2,size=5MiB;
> 	name=rootfs1,size=70MiB;
> 	name=rootfs2,size=70MiB;
> 	name=overlay1,size=20MiB;
> 	name=overlay2,size=20MiB;
> 	name=art,size=4MiB;
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


