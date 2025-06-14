Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF09C71141
	for <u-boot@archiver.kernel.org>; Sat, 14 Jun 2025 13:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C7D4808AF;
	Sat, 14 Jun 2025 15:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HZjO8nOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5D180F0E; Sat, 14 Jun 2025 15:56:34 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A69A800C1
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 15:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-739f2508ffaso2268117a34.2
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749909391; x=1750514191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SB2WxYju5bGKtXEV+mzAg0CYbJtB+AcQeNuumKgwFqE=;
 b=HZjO8nOeghzyBR7BiwOaV3VqPmhpIjRl2FnWIXT0qR3MatcE2RNhS5EYF8nszNuQfM
 +hw0kta9w8lDx6AniIGJ6++GQv7YhDs2m0T58OIy+H7PLmWh/qpHQQX8C6lFVN+UvayR
 tTsQhx25cjnki+k96IJ9tK46EaI0pvZzyv6qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749909391; x=1750514191;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SB2WxYju5bGKtXEV+mzAg0CYbJtB+AcQeNuumKgwFqE=;
 b=VwAVsGGlsEj0xpuzTSlw1xqwliKi4IShDeBluFpsV1nj1LMlqU06EnLLgr/OZCMBew
 b3Y6DIS3H++dvcOHZbATo6iitMQWmgTuQ1oB1kXQshpzq4dYouCOGjjC0ObCx6PS7T0e
 9tTPa+GzVwLnrrSksLRDXSGk6urjMR2xCo/ti/OKMpQXM1BjSg0h9dctt9yapBDV7jgB
 Jku9ae9Bz2Xx/9VFOOzY+CgU1DMFr1SEeark9OqsU65HATPzA+AqPZZmfzgyS0390Pdn
 xbnQZihU90aAUlEE7rhQ968Ox38sGlQYfYgPB4FQoQYyDqtFFLj+/GZt+0AJvavmCWh5
 74Sw==
X-Gm-Message-State: AOJu0YzG+1jRZe7FXIH/Z3PHuqJQy3kOQG/QMG4JEMaIePyzNFQAvjUq
 SF3TiAZddHCw6sTyuJxu7HceqtweI1eJ7OVOkH+iGU/BaTbOQoGEtnJ12HV12yCy5sQrnuIRbRa
 JaqAVU2Qf2w==
X-Gm-Gg: ASbGncs/Zs5nj/LuBZXVyzZ8q2ce+LtY7MTsHzMoq7eyJfR/vU42B/9NFjvVYJLGFx1
 FEQtdp7YORMvK2Ips0kYv7H66HPjJa8HJxs8JJAoQPVj6J0aXfqeFJy4GNB3GRubUWp4aCJpeak
 DKH2uFlgM+IK9n7WD4cM9WRlbinYqSX7zXVZD0m9HpHbHobl8eSjxUX8HHJ3TxisEugUuMEMGGw
 5be83EMKH1G8//sdsPyfW7JqgjWa26uenm8F7FCjw1sdeyu+VRHCHvoY/otE77SSYtDekaGCPBo
 AL0CgiFsdBaez5Ub5gHJOz/bGWYWylx7i44Kuk3yeZ0pl45mSQhdCs14/uY+8HviL5MrugIEyiH
 /qDQTDNp8r4k648vjc/k3yw==
X-Google-Smtp-Source: AGHT+IHZlcFFnfjj2EDNRsaOJuK4hg8a5Sxlxk483kiEX8/52/wOjv/XO/zb/9DTZ5EoGcOBEsIH0g==
X-Received: by 2002:a05:6808:1ded:b0:40a:3e68:b194 with SMTP id
 5614622812f47-40a7c196b75mr1474116b6e.27.1749909391257; 
 Sat, 14 Jun 2025 06:56:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a7418c881sm704170b6e.41.2025.06.14.06.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Jun 2025 06:56:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 uboot-snps-arc@synopsys.com
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
Subject: Re: [PATCH 00/12] drop volatile from global data
Message-Id: <174990938963.962063.5579321613463235820.b4-ty@konsulko.com>
Date: Sat, 14 Jun 2025 07:56:29 -0600
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

On Wed, 04 Jun 2025 21:56:00 +0200, Rasmus Villemoes wrote:

> There's really no reason for the gd pointer to have the volatile
> qualifier.
> 
> In fact, I claim that it's completely unnecessary and just pessimizes
> code generation and forces ugly casts in lots of places. For example,
> see the casts in drivers/core/tag.c where elements are added to
> gd->dm_taglist, or a helper such as cyclic_get_list() that should not
> be needed.
> 
> [...]

Applied to u-boot/next, thanks!

[01/12] arm: drop volatile qualifier from gd pointer
        commit: 45fa0014ba56fc52765d66edda489933ce0e9871
[02/12] powerpc: drop volatile qualifier from gd pointer
        commit: aa53d9bb7d7b470eaa62e53550d66546f80d2446
[03/12] mips: drop volatile qualifier from gd pointer
        commit: 344c7e091c2033be4a5cb8bf73c08d8cf020b77d
[04/12] microblaze: drop volatile qualifier from gd pointer
        commit: fe0fa2bb6635ce3826b38204e68b284ada3a79fe
[05/12] m68k: drop volatile qualifier from gd pointer
        commit: e66d7fc089912a8f84bbbfa4a69eb5c0ebaa1e1d
[06/12] m68k: drop pointless #if 0 block
        commit: a6f3d70a6bc2f99ac86f47bc5697d7e6e36ea7b8
[07/12] arc: drop volatile qualifier from gd pointer
        commit: 30b97f58f20e58ea5bb1d5dce7253c58d03629d5
[08/12] arm: imx: remove unnecessary volatile qualifiers from "save gd" variables
        commit: 01869368c08278d19a0b7ec744013bc88afcf09a
[09/12] efi: drop volatile qualifier from "save gd" variables
        commit: 83b040983c92446c284c7b4ee5f97c60c6ab5afc
[10/12] lib/trace: drop volatile qualifier from "save gd" variables
        commit: abe705be4751dfd5ae2ed0c24971cd4417f645ad
[11/12] arm: remove volatile from set_gd prototype
        commit: ce55643546a59c05d6c4b181c2b490b6db7ba1f5
[12/12] riscv: remove volatile from set_gd prototype
        commit: ae86cd8c59fe08c9a37d14dbd6e42190dda2a0d4
-- 
Tom


