Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629E110F9945
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 14:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C58FF8412A;
	Wed,  8 Apr 2026 16:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n0xpB8Rv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EEE184142; Wed,  8 Apr 2026 16:51:20 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC7B840AB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 16:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbb89ab229so4707945a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775659876; x=1776264676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4YEilyWl6GDfQXrEyXkYepjtuVhaUa40cP2EO3R+Ec=;
 b=n0xpB8RvJtq4Ex+iypU/UqCQIxdbmpptaIM3yle3wrblZaBspaYsXM+2BouYpWcgDT
 rWY+rhNNrvDBYN1Vzvv9p/k1cMTdyu2rwZFiy0JqCOK/HlxrUBO18xx6Kkk0GJEUbyDp
 0amoUmQmsJ8tyIfKO3Bwl2iFCAemVNyB1zQfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775659876; x=1776264676;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N4YEilyWl6GDfQXrEyXkYepjtuVhaUa40cP2EO3R+Ec=;
 b=eFadOLVtkfVlnlWlud6T4kiesDQcyACaU7lHsqaAySJ7jhluSy8Q1o65qOGCKsEOL2
 z+fIJwvTAol6sdT2O9WiEPvkVBWJxAzWSYm3M8yTsXt36U0VxfbHnBeAJSZhk2Vt+2Mv
 AKeB0DBze5VQ9NoeD416cajd7BKYp+xYijS6EKb1uonnTk3t5poj6yBUJmTo8zS8+VAe
 fjWgu0Gxta0ycGm1SFkwxNDLTH6ANz414fEBT6LodgP6gPpD9YMfbySMjktHxToh8bkY
 fkZRvne7JEIsANkDtUQTNWfTy+/hWp9A2BpB/plVK/nEWQZsj+WPTbuKK1ts15V3v8EZ
 N+ug==
X-Gm-Message-State: AOJu0Yz9Sb6QWRdWKhtnRPnBu2Im+zoTm7MNpwLbxlIoVNwgw+rZxNB/
 AjISANUfL4HyFVXl1zJMLCxNz18MJLTpKNVWJu7N3FlVDMPZ/rr+OQL0LlQwIQll8Tc=
X-Gm-Gg: AeBDiev8PcCx7HDbtepfWPcgtgixpOKHVyFTFlArF4XVK6VkDea2OeqlGkdmyHfFjs0
 Dby9XeZWrT4PEvo7dmrif/T+74CmCsF/CwU+hy71mI+ZVyKpFwILJtyGBsWrEvWuvKxFVxWdktY
 SxEXdXhVV7tWCdBdbdYFT7pTseFQNuj6FeGETzzxJMPxJZrYqaXB8JQzWDLgTU39QRsz3WhXlgE
 yuHtNnsgPkT4TdXgC7EKw0NZGTnswp59HtnoAH2nzDYDee4Lt0H+skqR25zmPskTpM6f3DWXmf1
 IFittexT+fMETwTmAdqXEEnPUi9HPwE/1JIL5POKKBNInv/HbsF/7AqPd2a7Tr0HJX4ndcrjCQ4
 uwKPaFYYFHcrvAZN9IrPeU47KB1Mkqb6Z8zdRsXrxjb6MhCo4FpCuWZxUi6GwYh/HSYtNg1ouiU
 klij+6x83nwuNgCAxq89kQx9wbB8bVMeiiLnNGtxGsy2PeXE5z1cbU2uX5bghi1ivvjIZamMdo1
 F5oH2o18Js+gLAfEg+DDO0yO+niAgXEZ8g2AffZ5fONI34=
X-Received: by 2002:a05:6830:410a:b0:7d7:ef0a:1ce9 with SMTP id
 46e09a7af769-7dbb741d6e5mr13043166a34.14.1775659854954; 
 Wed, 08 Apr 2026 07:50:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc081753f6sm1514644a34.6.2026.04.08.07.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 07:50:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paresh Bhagat <p-bhagat@ti.com>
Cc: praneeth@ti.com, vigneshr@ti.com, bb@ti.com, afd@ti.com, nm@ti.com, 
 v-singh1@ti.com
In-Reply-To: <20260325070804.3037288-1-p-bhagat@ti.com>
References: <20260325070804.3037288-1-p-bhagat@ti.com>
Subject: Re: [PATCH v2] board: ti: am62dx: Separate resource management
 config from am62ax
Message-Id: <177565985393.779397.4422095369400207268.b4-ty@konsulko.com>
Date: Wed, 08 Apr 2026 08:50:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 25 Mar 2026 12:38:04 +0530, Paresh Bhagat wrote:

> AM62d currently shares resource management configuration files with
> AM62a. However, AM62a resource management needs to be modified for DMA
> resource sharing scheme for CPSW3G Ethernet functionality to support
> multi-core traffic handling.
> 
> Add separate AM62d-specific resource management configuration files to
> decouple from the AM62a changes and maintain proper resource allocation
> for AM62d.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: ti: am62dx: Separate resource management config from am62ax
      commit: b7caaaef86beb8f87cc12cc13501efc4da832002
-- 
Tom


