Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93968CA5FC4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:20:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43CF560B94;
	Thu,  1 Oct 2026 01:20:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B6Fq2EMO_k5Q; Thu,  1 Oct 2026 01:20:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 83A5B60BA5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790817615;
	b=ZcYPCZ2Vx+fbcc/YKC0xZTWfMtQGLM6NsfA+bd3jyjFX4EbMi05+bwcX2/QdKrgxjT7p
	 wB/RZsom/uSI95aBOqv6t2flTSnK7e55RfmIjlPz16B6wg6hAEkbMF6mW0WlekvZk2wS9
	 95M0xZcoYexDMbaqQ/L17SoESjk/EKHzOnoLDXeIF9+SrKRwXzwuTnFkmx1KoSegJwww1
	 Ls+IKzrt5M558swYJDjDs+EI2XYze+gEAxgpFEj/4t5sDI/6Aajaw7A356Aqva4A2EvoQ
	 6v+YSp09/ld9qtbJmsE+vkyMIS59OoNDsz/va0r8OednQOLlFMLf/hgJWGCIB1eSx/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790817615;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sJZszS1CinxjYcT0YbcRbuPyOWPonEfmq27ndPASWc0=;
	b=SaWjgLD8n1HjSdk3Un3SyUyAwBNMzFpsVbql/T3RIqvUxT1YvyxbkmKxOtBoGHwb2l97
	 Fn1VqekuZ/WJe3MVeuckybHD9a1svpAZF0QEIxKUXtMvmb0EfNroIxBrIXq0voulY7KCQ
	 +3sSV7Xr9R+fzGGL8QIgKabhxdQzk9s0i6SEZEYhVfXjzb2H8S774IlB4AcvrMXLIsE2I
	 EdstUG0stC1RAA5K16jVERGWvhc+xME4IPwaTUaXvzxy8hG6fFqBbQzgJKdiHEkUC+JMx
	 +UvES5IMd7SusHgfwGTWiGMJwpGGuqrnIzWmkj7MKuT7muFExD8IHMwyXdM34FuSqHw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790817615;
	bh=sJZszS1CinxjYcT0YbcRbuPyOWPonEfmq27ndPASWc0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RAQoBT2jJwm5LYF9ETqJhvbRlfM6+B6BgObDD2YwVEKy4tNc/zgYgbQ8Ipq3WwJJQ
	 7zyU19HAMoPqs1K/2B+ws8mwa/GulWW3nxuLDn31bBp2PUNPeKnnlYakAmBm3S99xW
	 LyLe2njYQfuihuZsdP65/weOGY5Qc1vMrYD3joZEfyKq5RTesDnoLNUaxppMnOBfLy
	 glqKusyEPiMd765ynYwSCESHrCil8aWlKFPavJvUHjWSR8ii9YnkdSUpA8m8AXmb5W
	 VDWY9PdCUGX8gWQyTlDmuRwOgfdG5F3pC7BicxdLujpISW+ylIS3RsgW4P0xut7c9W
	 gJ7tXHCkFPt+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83A5B60BA5;
	Thu,  1 Oct 2026 01:20:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D4701A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 824AB40B26
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:20:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VjP2RnQvnrER for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:20:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A8F4640B24
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790817613;
 b=FOWqaaibpDeH5OP24U9Hlrldg7WDyPXzSRLlbU3+G9o4ogGTFohk3+ChZqJAiV2lgdko
 ISwfioBFhIkWIf441l97hLPkklEOx71ZMwAu1fGDq0i4j7AJYgKrn8wCGNjnI4a8NWUEL
 6xVeoKnKpUhI37Y5xFHyK0knkxAtXoQQ7LNtL4/jrq9en0BEFCQhZ6P3+ke51P9QQay+g
 5ogNGEBiGYaiGxMHSjUd+K0FYpiExCFmaNK0+dMuDkwnKra6xbC/PQPj0BSlMO27IOwLO
 hdTt93rpQpbnHW5aC7Xo2Y+X6ngUNuKC+R8pY6c8X5QCoP8Vd006IqzA0Tyttx1zXmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790817613;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=sJZszS1CinxjYcT0YbcRbuPyOWPonEfmq27ndPASWc0=;
 b=h8A1CXJg1FW4JerY3JmPa9eDqPQsfrzV93N9xBHTHWlRKW2QUEIeorbFL2ggGuswDGEm
 UDZPCv3I1V1xRjmG6xB9WMHaxRc7XIE5t/1Dt2qtpCGeC2s0+HgOSuR5KhhfeWGwtt8zj
 1pk939KB4IrzLIQzvhW/kOGVpeioVsuBKQo2Rl69BFpfp3k4EklZHWPkzfPk5KHDg8EHe
 ilYxLs7DP9kvjyZGyyK7WIooiOegNpCliPzk5MEmbHSA+qsSYQG6idKJPYKMyNcucHhoz
 YNEDy3foZyzA71/MO2wAOMgCHsuxFbApiYluLFxEY66Z1CyMS5MhJmcXypxc6JL89iA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fRUQZisN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fRUQZisN
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8F4640B24
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:20:12 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-820532e4ac4so698712a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790817611; x=1791422411;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sJZszS1CinxjYcT0YbcRbuPyOWPonEfmq27ndPASWc0=;
 b=fRUQZisNyXn0lmsxBCNIfPAwA9UeYFtK2ocHbcDZE2vonzV8XO2putNS73JodtG01R
 jFbP3pWrYKfBm8SQ78o1QurtLpJR9CQdksvY0tLQ3qm7UJXsjxp6YK5tLvT+I3cCc1xg
 w/G0hL1qHkdtIdpSc4Y7aoBYx0Z49TVgvQW+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790817611; x=1791422411;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sJZszS1CinxjYcT0YbcRbuPyOWPonEfmq27ndPASWc0=;
 b=OmC/Uga8byob8A7VuR2EMw10+feysXRTGjIyycYKaIWIiNyab8RUOqqQnAFTJPiwjN
 ZyUDpnsu1iiMUug874X7+kUqFWobTChjq+6sJfJcC1md7JWP+x5a9WkgW7+7oX8tb0N5
 yIFX2gp49xi5P33avBbX1RRLXPpDLc0Bl8+rqmafEKgxPbpvgRcUBnsfi2bl5qjcyb04
 POyk7sipQk4nleP5Wd2htEE+lmnb7te8IhslkHcwde0SzJek4EfCeZnXpyX1b1WMHfhS
 H+OqbG1aNtUKPAa9fIErYAtvv1A+BnpVK7lRZZ1seYMHDVPTPDXiOtfRXYroWM9pf2mk
 lIMA==
X-Gm-Message-State: AFuF++loSrgNq1EwUyCsnhKVDRczNw3SD3Jwb41z0Mbgp8PL/gc2BTIE
 sNCiIRzeBm6Irn4KTb9n2L7RACWuxE5JKlzwyJDQaGfG1zLrlzD2GnX7mHbEjQXMSCU=
X-Gm-Gg: AYBFou35JIBSsG+Yua83PdT/d+S6MK6lhDjffmC+QJEvizF3YT1n+GO45Ix1xT8tPpf
 8WJ/1ykiJIHPJHJFkIMuD1FNeUdlIoI/lX6Yn2orYLFk9gDMh5lR9HQnLnsLrresCSpJWftroN6
 nnFk5n9RIfs8/CVmt0mOuxfoGRuTdrhonqHwX2AgYHHlPTKKVPUetFV0QJwxA1+L3WX0t9nXLX7
 wMe2acoeUgLJR7HFWQKz3dl97L4ODx115RkpttPS2abd1wbWTSVCVbQbxumMe8MCjig5tbeQoDX
 Tso9mf/Sv2Mk/SNzR0+/9w/G99bFRzHKM4t5Qv9Ze09tiXVR9LR2Tyvn2h8EHj9q8AXrT0qRInt
 8tM//J8f9Bn03VLmPmsv4jbsoqLOWX/PMnOsSTxWxC0A+nTPZx9sl383QCMDQS08EqoCIFbAI6R
 1CIipXAwJCike0iXxFFE736WvAjKQgkw4HdPYqxD6F4ScMUWeeLEhWsJBwpI5q803BQ0XjK91Dg
 yu8QOyazpRiqHNWqb7uwCHnU73Y3XS0BpJ/MoFdM61OyVIC4ss+DLvqYy9S6HkScjnj557QePyA
 lvlzuJ6BOpxjoYEmj1vtj/yoeBvC
X-Received: by 2002:a05:6830:83aa:b0:81c:a945:60b7 with SMTP id
 46e09a7af769-820470bb2c1mr4319817a34.2.1790817611256; 
 Wed, 30 Sep 2026 18:20:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-821281a797dsm1681082a34.3.2026.09.30.18.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 18:20:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
In-Reply-To: <20260915-phy-reject-driver-without-ops-v1-1-64bb49f7ba13@baylibre.com>
References: <20260915-phy-reject-driver-without-ops-v1-1-64bb49f7ba13@baylibre.com>
Subject: Re: [PATCH] phy: reject drivers without operations at bind time
Message-Id: <179081761034.570197.2739471899535825246.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 19:20:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, 15 Sep 2026 10:17:22 +0200, Julien Stephan wrote:

> phy_dev_ops() returns dev->driver->ops without checking it, and every
> generic_phy_*() helper dereferences the result unconditionally. A PHY
> driver registered without an operations table therefore faults on the
> first PHY access.
> 
> Add a uclass post_bind hook rejecting such drivers, as the pinctrl
> uclass already does, instead of open-coding a NULL check in each helper.
> Return -ENODEV so that lists_bind_fdt() only skips the offending device
> instead of failing the whole device tree scan.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] phy: reject drivers without operations at bind time
      commit: 52a1b525760abaf55fe0027a7bb57714028a7671
-- 
Tom


