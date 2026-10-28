Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198EB606A333
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WUI+1Ihv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=HjSyxP7H
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19B21404D0;
	Wed, 28 Oct 2026 18:42:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rZcwLWzl6_0U; Wed, 28 Oct 2026 18:42:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B128403F0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793212970;
	b=M67X1Ntr2MCMG64i6Fef5ouwFfWYZuwtkzy0To7BuNjGotwhFlMT8n/h/JTWlulqzQ52
	 d1uwJEbSLqxKODWQG6E6LBUYKsDwxGIgjM84VQ0tmGGkWP4OGJqAgqkqQgd1NOHi5aWcp
	 rCzl+Pj2RO7Wj1ynzsAJZgRwetyWqJ2P3WHYcs0iktwGi0/9Nh1DbPSuqeASf4ZVc9gMK
	 yaZ98bDD4swXa12/YBf1A+F9Z0dQUapXk0Q5vBGimXiPoU+JJVflPDTQ3FgYbiUfNWNLB
	 vzif4LtLMOqNdkeRUukEqIBDdWvbsplbkm+nAGquyG12u8cVEskspPiO9LfnzPC/tUg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793212970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yimC22B9QCOBpL8ZJxOmFWROYB/SLUbdgJZAukY0EB0=;
	b=YhNcuBKb2Kw6PsYmMs7r6UuCHpdO87op2V7NgSgPLl648MV5OCDpKuu+t0kSjTS0rBPb
	 GK8AB0MarbpXlhezWx1YYOrCiYpLweE89Xpc7qg7HcO4dsLgs6t8nzYqFEpdaoQv9UN5h
	 4vBXArXXchdY6yVne0FVKCh0o2QqN0l+HiwIS03l++3/Mn45pZjulh1wc6l6yM6RDASJy
	 WsxD69GX/PhaLTzp6X5b9RoX5cG/giv8APe3pNjD/fhovENsyA0UXsHuUCl8fzUL1DcfI
	 o/Gb7xOGK6xO+C4qXq0h3ituzYj90XaV0db6V1vWr4PkIbT76yCdE1GMouyA5U3nf1w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793212970;
	bh=yimC22B9QCOBpL8ZJxOmFWROYB/SLUbdgJZAukY0EB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WUI+1Ihvn52Z8+Azsa+Whi+m01HiB7a9Mtu0SQwwOIeLCeHVnqNPv6sIJJXrbhF1P
	 JiUIpsCbyMUOTYIZ8MYlDmqm6o7V5L85v/hriZzGNpNXYgDxRwLbub2/YqbktwmhH2
	 /S/imcMrJfbQeGpvI4DhhQxh11RrXaVAi6n6zS9vcNpN5DbPOOhEVJkk3KdWE/4khN
	 eQ4xl+G6PpdJ6SvKrbez0vWXgABNIYm+HzNl/nDSIwEd+QIyLuUYxuTcS8oN2QBOUJ
	 EIAVNRSm4WGjnmPmTBCDgtIdh7oCDzXCB0jdZRRCydKceJyiyC+nLjyvqid435abTR
	 nYUp0hw/ED1Xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B128403F0;
	Wed, 28 Oct 2026 18:42:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B95CD235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A855060763
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:42:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zPM_uvLdSmSi for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 18:42:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EC200606AE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793212967;
 b=mmspOonU2yRbwqyoNIi1xpY2llWaHfYfVdurYtiH90Cs4kozyycrqTWcTukHqDXf5wLf
 qgtEqHAa6LL2YtSnX1HHz7448ql1kSGA2K4HGM6HLmmSRh/qMXYiuw/VRlH6+cZDVcjsQ
 jrDgOWtD7Ak+PPJXcNmvTJsoQRFnt+SvV7P4BW6eAesGQJYH0lYHt/N0ln29f68ue7HjY
 K7452ERvaM/OtbCwXgMGwi/3ZIwuRltjprHcK4XKnDuMwxHu7jVdFDcgCr3lCFnltFmYT
 WE9bV3VfadOtEwDbSSAiSMcKRj5O2h7v/GkCjitm7vvE5iiam46Ip9tZWpFqf0QQuzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793212967;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=yimC22B9QCOBpL8ZJxOmFWROYB/SLUbdgJZAukY0EB0=;
 b=Jryx99ydc3fk8dR9uaIQXhwOJ7e8rqfT6OGMd5QkI7jiIudnncFH5CLT2+VkGBa/0riq
 PLZceY6B8C6cNty73ly8+3qZm/Xd5nDAhmvdEqEpA/zE6wIxjZwh0RPolaV3dA4GuDpQK
 PnNTyBDmvf8CR86yuHeF3djz6bQ8GCKlIy1fue9aYHUVIkAbk85mcmoRoNBSDiJ5YdiVv
 0Z/MlkS4LkmXz//iAm/tVHXgA9quZq+DPzD/woqn/I0P3bROGjNXfquO7xRCxrnLpZBfJ
 XACE1n8O9wI3iaPaXkXqna500H5ZBDqgOC89kAkS2mB14hmNahs4ea8TsyrFaK4TWVA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=none header.from=iav.lv;
 dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho
 header.b=HjSyxP7H; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.16
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.16;
 helo=sender-op-o16.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=HjSyxP7H
Received: from sender-op-o16.zoho.eu (sender-op-o16.zoho.eu [136.143.169.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC200606AE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793212952; cv=none; d=zohomail.eu; s=zohoarc; 
 b=PEPemH0Fs0cChsWlxKeEoRTTedyo7mH0dL1W8HfAsCpg/tit9rvIK7+C2yeunfN7bR9SZM87xYseI64xbUxXItzXSsJ0+csQZDvgdH5vLydYRBxshQj8btbXOMEf6NdKU04TYBXwJ6H3DV09L/UkMETwFO4Q7yN9fD+TBqGcoOk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1793212952;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yimC22B9QCOBpL8ZJxOmFWROYB/SLUbdgJZAukY0EB0=; 
 b=ctLfiCuD1yvMp4VmpGMyun8HZINMsmPrunV9VXib1afgZ/zgSNnd4nqwlPqqQEXjzwekTBqmftTlAYo8B70jNjiYcsuHACD01SWoWCWi1b87ewvDqsKeBSZkQ3yX0+ErGWcxCoeTi1fOy7jo6+XuZgBKVJ/I4OMTAqdeNv60LJY=
ARC-Authentication-Results: i=1; mx.zohomail.eu; dkim=pass  header.i=iav.lv;
 spf=pass  smtp.mailfrom=iav@iav.lv;
 dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256;
 b=HjSyxP7HOFCjrgxnV0G3q3EI85AHNwmoycf7Q2UhekpeAF67gIvIplJNQ/TuAhOR8TvK3A3NYS0GXImGkpoXE0em/NYikL2cOT7wZSq0aSUreLNNqGQZoFDzV8dpV8F0fv45WqVjoh5hrHak1CBpRvxUJkTI7mGSKe7gmDDFVMw=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=yimC22B9QCOBpL8ZJxOmFWROYB/SLUbdgJZAukY0EB0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 17932129499583.547856157145702;
 Wed, 28 Oct 2026 19:42:29 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH] board: rockchip: Add Kobol Helios64
Date: Wed, 28 Oct 2026 20:45:00 +0200
Message-ID: <20261028-h64-uboot-v1-review-reply@iav.lv>
In-Reply-To: <b102efbe-548b-42b5-bdba-c744449db9e6@0leil.net>
References: <20261021-b4-helios64-v1-1-74afe8aa6d72@iav.lv>
 <b102efbe-548b-42b5-bdba-c744449db9e6@0leil.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On 10/28/26 1:25 PM, Quentin Schulz wrote:
> Can we have you as a reviewer at least, so that any patch modifying
> either of the first two helios64-specific patches are sent to you and
> you can review/test them? Is this something you'd be ok with?

Yes, as R:. I can't review schematics or drivers, but I'll boot-test
helios64 changes on my board.

> Please work with the Linux kernel to get the vdd_log and vdd_center
> parts reviewed and merged there.

Sent on 21.10:
https://lore.kernel.org/r/20261021-helios64-vdd-log-center-v1-1-4cafd110e0e5@iav.lv
I'll send v2 once it lands in devicetree-rebasing.

> This is already the default (except it's a lowercase f by default, hence
> why it appears in the defconfig), please simply write it lowercase so
> it's using the default value.

Done, the line is gone.

> You said SPI flash boot wasn't tested, maybe don't generate an image
> that we don't know is valid?

Tested now: SPL loads U-Boot from SPI, then Linux over TFTP, 6 of 6 boots.

> Is the offset used by the Helios64 original support known?

Kobol's U-Boot used 0x80000, which also boots here. I'd keep 0xE0000 like
the other RK3399 boards: an update rewrites TPL/SPL as well, so the old
offset doesn't matter.

> Are you using the Rockchip bl31 blob as TF-A or upstream?

Upstream v2.13.0, dropped.

> Please remove clock-names from this here

Dropped.

> Are there really that many USB Ethernet adapters on the board?

No, the list came from evb-rk3399. U-Boot has no RTL8156 support
(r8152 knows 0x8050/0x8152/0x8153 only), so I dropped all of them.
Only the GMAC port was tested.

Igor
