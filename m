Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15929C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 22:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F7A58820E;
	Fri, 12 Apr 2024 23:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p+u5jjq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E0B88207; Fri, 12 Apr 2024 23:59:36 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7CFD881D0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 23:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e2178b2cf2so12103645ad.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 14:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712959172; x=1713563972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKOCz+yhYB2Xe4HsAT0WVhW4VR9g81Z/Zm2fkLKmju8=;
 b=p+u5jjq3tnm2WJ2Iqhya4/VzUVt8dNs6Hv9hQ7Kn3kHOTBw0q4aAIHi2schEQol91E
 fDAzRIbgnKhEwEiKNLLVdChkoet7thByVd21+ksM0QZy5aZVZ9R8NSoFeWki82QSYssK
 d9n/LUXmR7iw6liW82iuPZhwxui+aUrkqUGCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712959172; x=1713563972;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nKOCz+yhYB2Xe4HsAT0WVhW4VR9g81Z/Zm2fkLKmju8=;
 b=j3Ot86mUOEfU/TnzDswVNWkd0/jcyVStc9NyIGDDT4raeehpuk7I/FPjX9L5AzqbKk
 uLH8qEE2bi/tT1OeVnFoPb00Fp+x9JteCHpWwtR+5dq0mj8Q3+gM5RyNeDLYt1SlWEM5
 0vaKSmTERqDSyEPC3MJ2a/vIkLNRFiGDrU8cv4DC6T4rIV0ZVn37Af9rX8MTQGOh1rGM
 J7A7Y+BSx31xgru0kYWqf1P7SfxseSS3GibWq+gpna9NpA2BDReyJTxlsWGy7PiXjfut
 hWnVMkD9zsDwBWgllPZcG/q/lZwbpJOKp4iwYiOsL7kMoCF/PiSuz/e3lqqkBhn0Lr/E
 ylpg==
X-Gm-Message-State: AOJu0YwlQNw0MnRgo6Jo7R0/aPK0mn1uasrl18BEKG6FYSypEdU53orW
 WHKCX+zCaoJ5XnvWFGmEMEELFm1cz9m8h8tcnKiBTVwJEkVZ3P267+w6YC+Kj8F4st/H70seSNa
 ex5wb3Q==
X-Google-Smtp-Source: AGHT+IFe1zuorgmUxK4eXvhDKuneAq+85EkzmL4VYdIWPjtkBh4jSL3Q3G+ebrkjEEJrZPMvQXUUpg==
X-Received: by 2002:a17:902:6503:b0:1e3:d8ae:df34 with SMTP id
 b3-20020a170902650300b001e3d8aedf34mr4186378plk.11.1712959172140; 
 Fri, 12 Apr 2024 14:59:32 -0700 (PDT)
Received: from [127.0.1.1] ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 kw7-20020a170902f90700b001e45240eca4sm3472958plb.196.2024.04.12.14.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 14:59:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Elmar Psilog <epsi@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Simon Glass <sjg@chromium.org>, 
 Yanhong Wang <yanhong.wang@starfivetech.com>
In-Reply-To: <20240405161529.1419902-1-patrice.chotard@foss.st.com>
References: <20240405161529.1419902-1-patrice.chotard@foss.st.com>
Subject: Re: [PATCH] net: dwc_eth_qos: Fix compilation warning in
 eqos_free_pkt()
Message-Id: <171295917036.1044279.5551427954733750533.b4-ty@konsulko.com>
Date: Fri, 12 Apr 2024 15:59:30 -0600
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

On Fri, 05 Apr 2024 18:15:29 +0200, Patrice Chotard wrote:

> Fix compilation warning:
> 
> ../arch/arm/include/asm/io.h: In function 'eqos_free_pkt':
> ../arch/arm/include/asm/io.h:103:32: warning: 'rx_desc' may be used uninitialized [-Wmaybe-uninitialized]
>   103 | #define writel(v,c)     ({ u32 __v = v; __iowmb(); __arch_putl(__v,c); __v; })
>       |                                ^~~
> ../drivers/net/dwc_eth_qos.c:1220:27: note: 'rx_desc' was declared here
>  1220 |         struct eqos_desc *rx_desc;
>       |                           ^~~~~~~
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


