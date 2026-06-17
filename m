Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D633ECD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 19:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC0D848D7;
	Wed, 17 Jun 2026 21:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bIDwtWAs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D14458460E; Wed, 17 Jun 2026 21:47:19 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94A6848D7
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 21:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-486852c7b68so80506b6e.2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781725635; x=1782330435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NMIll6TbFeO5mLnU7bnw4XYEgixoHswG/PUZuQ8rSws=;
 b=bIDwtWAsD2qEZB2ETiMb/w6v9qdr3UnKvRM9f6ySWt2i4tNl687CitnQ/UEYHfPw5H
 trM8Tc+/npn0Ji5HZ09B6sgJuiYgFGkO6ZBNQEL5DlX+mKnX2y/qygSgujq7hUlAZMeu
 sEBuf+KyaEUdlxu/HxaBGIIy29XvvBaTC+lGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781725635; x=1782330435;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NMIll6TbFeO5mLnU7bnw4XYEgixoHswG/PUZuQ8rSws=;
 b=HbI2EaqTOPxEUqqUHXwBgh8D7r9F25boooNiKB7Pb7TCN38ie/fJ55piG88iv/tvSn
 ycBLnNkmzMGIvRs2BldtvvtPPEmKaMxj9XuoqW275HCQZ5DG7tDt3LQVBPrBj07OPpMR
 rZveTX4Zs33kakZKJTX7VGJMWiNkTRSlxXu+zXsOkyVHAJHUJEmI4lg8myvOmNMHt/Zy
 wpV5ZbOZOO0g9HsBK+L+M75U6xqU1a3tSh5BST0z5IiF1pEBMIsGxHcNcsk06SfJDshC
 YhtplB4ZxS+ndGfKTUOpiO6UBuDLAHY2j0jLnk7czeaIN/w8dndfNic0tgJb4SGBscuH
 xc2Q==
X-Gm-Message-State: AOJu0YxpKZ+YavS4rghRnUfi1xaXglIZOU0HAH+beQpx5Ffvw4VU3P8V
 /ZtbNsbuwFskwcEOjU9WvEmTLVO2Zs0VOGTDoXoJ31liKnfjv6j8YY3Woyy8ILPGENw=
X-Gm-Gg: Acq92OHPiO433fK6rDOzlFBwMVHOqATGXp0v8LSzQ2b9HlswIAekjUaIJ1ehdS89rLw
 Z/Mua++tGVvxaP6BK2bFNJmU8hElGZ8XymlQlwfX6c12WfIdkWJMwVp7e95k40xboOmVpIxQeIi
 KKMDBcTdTH/UOwVrtJKOOu9mqrrtkWMTgi3TG2u03Dn9qB06AFzugDqw69wTOmOuy8jDyzmTuae
 wk3bqrRWW06lGrBEZuZl8X1zR/MXZjsipJ5buXe+EfdVgKVLTL9oiciOcqHw5l2bxK2J6Bpmrra
 waJBWfZdakYu5xC+BAxD+xvmRghDpQfMfVzCUCzMPYtfPzPrasyRNqeW+GfZOgRe7Gry+3aDL7z
 /8YAC8vVOsId6MituZfhYLA7B9mouPPy+8DJQhF2D4604j1DtOlOKgDt0qKw1dSkzwiR9JslfVp
 NR54Vafv0q9TKpAHzO51dJ2Kwd1J36yDUSPr3gc9WNuE0rKDxpIEtp7+w+hyhcdnFg2PRdDTW14
 ZP7wivLBt0Omnrq41r7Qvgta57oPLBlTknIyiA=
X-Received: by 2002:a05:6808:244c:b0:486:37ab:e829 with SMTP id
 5614622812f47-48942b189f6mr5372603b6e.41.1781725634769; 
 Wed, 17 Jun 2026 12:47:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4875dda5f7csm6798219b6e.1.2026.06.17.12.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:47:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sumit Garg <sumit.garg@kernel.org>
In-Reply-To: <20260608-b4-mmu-unmap-fixes-v6-0-ac0764cccf40@linaro.org>
References: <20260608-b4-mmu-unmap-fixes-v6-0-ac0764cccf40@linaro.org>
Subject: Re: [PATCH v6 0/4] armv8: mmu: fix region unmapping and optimise
 set_one_region()
Message-Id: <178172563347.2028295.1788725000652275924.b4-ty@konsulko.com>
Date: Wed, 17 Jun 2026 13:47:13 -0600
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

On Mon, 08 Jun 2026 19:13:47 +0200, Casey Connolly wrote:

> Currently trying to unmap a region results in slow and largely broken
> behaviour as we unnecessarily split blocks and manually set thousands of
> individual 4k pages instead of higher level blocks.
> 
> This series fixes the behaviour of set_one_region() so that it works properly when called to unmap regions. See patch 4 for details.
> 
> Patches 1 & 2 improve the existing debug functionality, the pagetable
> dumper will now print most explicitly unmapped regions (since they still
> have their PA intact), as well as adding a new function which does a
> very basic software TLB lookup to help with debugging.
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] armv8: mmu: add a function to help debug TLB lookups
      commit: 647990c5284af3b4fe70af99b03b91e91d692a69
[2/4] armv8: mmu: teach the pagetable dumper to show explicit FAULT maps
      commit: 41b6b904b58577c4aa7100e2850af0429e964283
[3/4] armv8: mmu: commonize the set_one_region() loop
      commit: 76c90926087cd586f151c5ebd557589e1306b45c
[4/4] armv8: mmu: fix and optimise explicitly unmapping regions
      commit: 6468ca13ffd6f3ce85edff8f9b0c317c719aa9c6
-- 
Tom


