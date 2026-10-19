Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55758CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25E60810E6;
	Mon, 19 Oct 2026 13:26:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n04EanC7Xw7e; Mon, 19 Oct 2026 13:26:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 646B5810E0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416376;
	b=gdiAgzBxfVE7FaffZaTx3gLgaS8MHkKi/Pg6+DQqQXnWSJeE8fyVVjlOVH+QuLfechzg
	 ddSaV+GpugwIcqUKKh6SwDEVol33qWJeliChNphLfeTXUqxe+8RQBSisGYCmHWZjW9CW+
	 v3llOMz5+IxUCEKZPczT5E5yP91svRbhIDNlNzhziW4+BPPX7z8rjfwWvQa+2TdmK6wiC
	 Z5cy0Kdk7ss/0B3/lN0apMNUF4DFd6YyXLBJs/b+bEBfEY5/N/VWdHNu/kCKP0ypEcWX5
	 Qt4YPzgep0BXchNr2PCvWBwXRAGCulzEd9M7AKwWBmvXRLrKSJZEp+eCTHctlfjsp4A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416376;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Eu6MMen+wQ9PxCQ6Zuw49CGTvQUeCEHH92bvcuAUcAs=;
	b=l2dlY+DRd90Gd6bPNQGtu1Eby3oDvHc0HgPxGobl9cVHPjkjk81zHVper+M4IzrLWjHT
	 q+NBt1xOd2SNd0KHFpSOBnk3SK28oF2W8h1c42i7XUCRSidKAmQvRVoL7Ek3ihotbzQ2f
	 UyEVWTqKP0BtfK4s1I5y/Qnr3Am0YqDn6m6hYbYr3WEC0JQIqtlhqguMyBx/ebwkrvVpF
	 e5FtzlaghDsOq6K1OY1b2qeMQCRyjosPrNFUjbeJcJ1YtvlieeU6/9ZwHT4iJ3NQGVyQq
	 pCfbIlz6ZWHO8s6NwXHFR8+x0DpnGazBprJ+MHv+x9KtaxH3+2GVv+ufL6xjE9l933w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416376;
	bh=Eu6MMen+wQ9PxCQ6Zuw49CGTvQUeCEHH92bvcuAUcAs=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=phFkt/msi5yhev8lYzXnVPQUHmjpka71ab+ym8EtiGChF0++3EryOk7K5MSgqQyHf
	 9d4ral3qyNHDI1khOTEF0qzQzve+EU1KaNPpVhSpZNzToYITIg/Ev1KcUv5nfVZWB5
	 NhRv2LamnwQTxdxE+MvjgDWJLR21W8dK3XMBqJWR1VVFal9mBE/jsfZSfZDt8t6y1D
	 YYdHpBeE83lz8cI7VP3nhhog/S18cVyjRVYbAxPJ5slAoqQtGO0FBc58RXOZIx7LMr
	 9mqYeCl78ax1J2Qvag9oy7//1KJM3DO6pnfDL8H8P8GmhPzPUMdRyURkbaC708OEEj
	 mADUsbAzn/IvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 646B5810E0;
	Mon, 19 Oct 2026 13:26:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 36AFE1AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2870660644
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wzvrtI2ahSGp for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:26:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 438AE6063F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416374;
 b=aEctEc+M8iuYnEUVrmHlB4K8VjRUlaIBPoOuP/TW/BjwmbXWvcQOXLQXHb/FyhJ6XhXP
 ZYmaEgHXgrrgm4hxNSfeHqi+DHZw02Pe3uzoEdB1VFLMq5mo+rqoOdTnnA2LZQ36qaDzT
 x+zqhCimdCbvZD6g3Q02XVY4cX97VwdlKoF5rPVA8f9Aizt96h0rFGbF+busr+ED1C13b
 yEF1fxH8yrL1Kgi8fuJ4ZT8evSNEC7mevlvHtB/WQYZ+yjW0O4QM7oYnHuBhiC6eIoOAw
 ap+tmXVQng2GF24N6n016mVAZT7ZutyM+NDs4cT3eQitXu7l5itW82iQ/9u3z2ypuKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416374;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=Eu6MMen+wQ9PxCQ6Zuw49CGTvQUeCEHH92bvcuAUcAs=;
 b=IcA14M4zs4/olFPt06l4JvPrfehQrgzZAs7Nx5EHU4OxWEwHWWrGryzKz53UyjBk23se
 z6bXqCFDvzeibm2MFMVT6d06GKvEimantCscLDSFyUKj/4UVah7YmGS2t0Ic5WS3E1eSa
 ptzYTiwyA4XMmsDyFjTRc/mdLuMUNN0s8RWX8+b2YH8k7layz/amuGZL2aKfOwGHsTlNP
 Ch+LZUZI9wZOPO1YSo4aRWzDGERpow3Up5N47Usow56SIXHK+CT8OP+bkme03WlQqo96u
 TOvQQbmb06Ybtg6KlVm5Lvp6KkZVvIhQTcJ3QJb/u2Y6IAtMLVAMz2OTPhiPPt4quzg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UBlSfZ9B; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=UBlSfZ9B
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 438AE6063F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:13 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b170129413so3291540a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416372; cv=none;
 d=google.com; s=arc-20260327;
 b=UudOmG19ujFfw6pYIJESLM3tVAcMhvNBdTn51iLMvCtzoI2/rO2yPM0xtF5+0uqeTt
 Kbb0lfz4dG2bvvlSJV0gETwE+oBPoLKy6i3LD8B9fiOkUCoOUBdKr3syEALpVB0nt4Zc
 zz2oFmrrZ1sL1b+3RMXClDbA1ftlCnquiWXvA96oQXeWR75drfDy/oPY9NFWe4bCBD+I
 LF2OOj078iKU47IZmcxUKWby6Ehxt9VHP6tHlZ38als3KxJPMdxdz9T3HEeJtDRRIMCq
 DEV01399KP88XR7srq5lDGdEWZ/k/27a7fRbthpxB2cplBw8KbumUq70XyNpew7dt+Sg
 1YSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Eu6MMen+wQ9PxCQ6Zuw49CGTvQUeCEHH92bvcuAUcAs=;
 fh=JkTdLZhBDMuyJRQweWq352NPhSzrMof93Cxu1xAk1BU=;
 b=hzoeziYmkgyL3QuhOUBEamQYECYh8B5X/ex1WAcBGy6n+2XSF/WtY1A/D4OONVafeK
 k2RPDMBPS1EWaPnZ3SHdyL1obRs7LJqkJTIWrtJiOb6oRG4qgsm3H7uZcig6699UUKdd
 +OJJuS07Pwp7G6JFNFaqguAXrmDb8XC9tWbiyvZJbG+QE3CmF8/c3oY83g3gAFPdMM5z
 fBpiw5t5srnIT+9515NkqWllZPb0WoxjixvdaUsZ83CVm0ThK2RM84FVv73AuaayVKvB
 T7CThgnix47rxlQLmW4mSEzFPkQ02hahmj4FvaUr2Y99PwATIw8r10X+Goj1g07AsP9k
 PYnA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416372; x=1793021172;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Eu6MMen+wQ9PxCQ6Zuw49CGTvQUeCEHH92bvcuAUcAs=;
 b=UBlSfZ9BwiJhD5T2WgOQXx/Zey+0LN7AkxwjM0JKdFX2rtRD+WxlWTam0Kwq2aarJv
 w/XJmIR/EfARCSIPsux14FJgPwHE+VZgQrnCvGfVU/96ZA6gRgoANCag7Dw/NXskjQMr
 B9No60qqVFgTr2j7SD0vxe5hj+kKnvlTrbQdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416372; x=1793021172;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Eu6MMen+wQ9PxCQ6Zuw49CGTvQUeCEHH92bvcuAUcAs=;
 b=SaiyGkjd4SMU6osF3H3c5trDNLusc/BTxns1pSiKcv2rvPIPDfzjJAwBthai9tR3bT
 oxFNeTpG6CzmOmDWP1xy0khsU9TPhFpWKNewAKa2ZqLm35wsFVZfvOQvL+SoZSxM7Z/Z
 /T3OtStn/AjhL9w9h+boC6E7xeKM7ITASHpcpRDNwUH2QjABE20RvKmT2i84GiaLZASV
 gLZQxSmzQOKO8XZ/JDLrWONgsnIxJ52BYVy+NP7AUVspUjFx6EiDouBObX0F7v8bHqWJ
 ba+g2vx1OAGGGzmkPstQJgsnKvz7WKksuaYV7A175awScAP2C4hJg6Jtr5pDANyOGd4x
 AKdg==
X-Gm-Message-State: AFq9FYKqjtVrULqsJ6r0cL7+olw8fjQn2OvCIr5r4N4voCr6WV3TglQw
 Ldf7yoaSBpX80SOFK8J1KAL3yQntNoWzZ72f6PDAjLTp67a9kRGGdUhbW0DV6B34VCDM1h6Lnfn
 y08lM7ZO6rHd/s1CwNVNzNyjUw2H/OBwYqxX5FAGn
X-Gm-Gg: AYBFou2TDYS3IvfOePaBl/ld9gINU9nms+9e4bJiFXKaGni3cUt5fLxioy9TJcHH+C9
 SwaSeCrQIkEdKDjJAwJs6iVwgJY6qUQRlvvmXGSp17fX4QYsO8aE76k55xDqdugu056/EYNU2WT
 cFWQAUIVrXfkZsGkLoNJ9/MmP2zR9p1Kt6yuFOLJ1Yvto8MgdsvrK9CChi9ZrlHvOg+ra1D0RED
 soUoXCiVKG9SE99ymjZZcZj35PIk5BTe2PC2CxIQE5sJvhakCxXfZoGeZNhkjTPaKWIMhmAGBNf
 NrO+9JjhbHMUwe5St2VfXoJ8uv2hxmMJ8aYYMJeNMao1xb8uhNWabg==
X-Received: by 2002:a05:6402:1f8f:b0:6b3:cc03:a721 with SMTP id
 4fb4d7f45d1cf-6b3cc03afdfmr2273758a12.28.1792416371915; Mon, 19 Oct 2026
 06:26:11 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 08:26:08 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 05:03:20 -0700
MIME-Version: 1.0
In-Reply-To: <20261017173458.226395-2-marek.vasut+renesas@mailbox.org>
References: <20261017173458.226395-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 08:26:08 -0500
X-Gm-Features: AclHuK8Z8mLJqTk99uSuueLR5NTvNLrwlEYwX0flWHWde3LdXNrBVqnurcLBXt0
Message-ID: <CAFLszTisRfHbds2Z5TT5uQEdRdg=5c7G5ZQh=tSP9TCZ6WgcAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: Do not pass -Wno-graph_child_address to DTC
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.u-boot-project.org, 
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?B?SMOpY3RvciBPcsOzbiBNYXJ0w61uZXo=?= <zumbi@debian.org>, 
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, "Rob Herring (Arm)" <robh@kernel.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Vagrant Cascadian <vagrant@debian.org>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-17T17:34:28, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> kbuild: Do not pass -Wno-graph_child_address to DTC
>
> DTC commit cba90ce82064 ("checks: Remove check for graph child addresses")
> removed -Wno-graph_child_address command line parameter. Drop this option
> unconditionally, as it is flawed according to the aforementioned DTC commit.
>
> This can be triggered on e.g. Debian Testing (as of 2026-09-07) when
> using system DTC:
>
> $ export DTC=/usr/bin/dtc
> $ $DTC --version
> Version: DTC 1.8.1
> $ r8a779g3_sparrowhawk_defconfig
> $ make -j$(nproc)
> ...
> FATAL ERROR: Unrecognized check name "graph_child_address"
> Check /path/to/dts/upstream/src/arm64/renesas/.r8a779g3-sparrow-hawk.dtb.pre.tmp for errors
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
>  scripts/Makefile.lib | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
