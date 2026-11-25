Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA1606A326
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eCAc7yjw;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ksWBxjWV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5AD680D35;
	Wed, 25 Nov 2026 03:08:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F25W1tvXJa3I; Wed, 25 Nov 2026 03:08:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 270C180D15
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795576084;
	b=fFyxXKjD++g3I6t9Y4IoLlw5uhtctf/hkHYChPMWwfybHkd3CkvHD/qwYQHXMREpjIUP
	 sMP2b97Brr88rG7F9/dDKUpIc/p1hIzmtqQXoZlxRqdlyfYOVq86svcBTy0KVb56Xzi18
	 bLhdkms9Vjfsj976tKlGUbTE8fdZV0BdhfkvaQjS4mvihW30NIeRgYzu7zsaQbUjwNLRS
	 Lkx6cDm4oX65GgIYxR5y4DN6EiQkTwR4o3a/o21PAUmUs/QV3rB2v0bq3NjIHz4ZyO5TA
	 kMLWApXhEkyHNZz9kFMBS0kkmcSoujL9AuyFVdnbLpHyZUz8cXB7/ukRWGpFyIf03CA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795576084;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=61Q2GA6llJjy5PWRq8Ty1CAYNOjIY3TW+9ZX0+4Xv20=;
	b=DolSfClP2y5vqawsg2MHzrCi1XBCfz4sdhRC2qW8kDAPL8mZmvGBzti8UeWU53IH3w45
	 HtSjjPwpHMgXUUuhsBOBao0qN40j3EUzIISjUb0iLk4HgJVXn7taNbXKA6s/+E19h/Ey3
	 zT/SHvt8cqyBXrxE3o7yg8ciQfQU2GQoLbOR18H+RCtTGLbNC/kKHPrhY6AjjZhOvOZqS
	 dd2iS4UIr6xbQ4yM+YctzGCXRvThJ1dNNc+Hk2jK5buYyLSw8Vycfy+eF2g19KqvzZ8wR
	 ft69DR7b5yPzm5tA6a5o1LxVMH3njju6cUExIOPtfedqSJfh++weFov+qQUx9Lxoo7g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795576084;
	bh=61Q2GA6llJjy5PWRq8Ty1CAYNOjIY3TW+9ZX0+4Xv20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eCAc7yjwRtbhLGzbYdA/jRJe8IUMEJcyQili8KNvvFbu9ADtF7EKGhbk5LmDCHHxk
	 PWKEVx2cY06997Zvbp0/g+t5+qCTRgBsp+UpPpiuLX99voBa0nxLWer26Sl2qVpdjD
	 0E8zeZdQnaMUeTwrGztdp4XXU3p7H04TIpLVPEV0WOB5EjubftsH49cjpG2gJCgAR9
	 xzXyCMCIkL4p02gyeTe/X0ynJ3Tfy13KnuWymEySHhwhVX3Nrwhc2FBt6ZpKFqDHRw
	 OnJreZBiJ07Fy1gMH4ZSkxZB+/Qz96dvoPdps5utTDUtjQBLrvFt7Y86nHfKDNCdNO
	 dJ65yBhOoJTIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 270C180D15;
	Wed, 25 Nov 2026 03:08:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD67A1C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A36CB405DC
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:08:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AGjojEbOoham for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 03:08:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76BD74055F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ksWBxjWV
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76BD74055F
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:08:01 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b86bbce3d1so7035539a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795576079; x=1796180879;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=61Q2GA6llJjy5PWRq8Ty1CAYNOjIY3TW+9ZX0+4Xv20=;
 b=ksWBxjWVjYSDyAOFwrAi/3G2GG5W2FY66+nFdveAs2AkJpyfuCkC/8WtdCJq0qEp9A
 2ojTgn15ZSlodOoI/RJ/JItcEHfIfwUnOqgnt7gusra/9UqVf5eJRXzoCu6gCb3isK9H
 FvfEYC+7FZDwnpGqPGRw7Yg0Vk+8lui18pEDeRUYY61O+gsGW3LUeejBf0fMrPG395qs
 xzluL3KmnxDwI04W2TI+If7a2GAoJrHKnXIQQ7yObEHAoZ8/fDniox3dRntGuRxeGiZa
 1xxnVfvsdjgqtv+2IEQpoWtmatEp4bgL3XNW/g8UXbjNK79tvuCrYLIEBBXrNlJyuNeL
 DuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795576079; x=1796180879;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=61Q2GA6llJjy5PWRq8Ty1CAYNOjIY3TW+9ZX0+4Xv20=;
 b=fUioiFu+IiCk5ZE4FK6ftyvIOr7KqkyEBejNgb36HhH2E0v7c2LpWsbC8RbU/2E4sI
 z+EVZ9XNsE6I6SNWlkEPYkEvTvLl3XNCd1/9JqVhPgtTFPET9ZuGi1cq5tVpzx/Fwjbl
 QxhDaeiy/ExlnUL8s0SdrvmaLhYmDWlUNH3RQJBS81Dbkp/Lo0/XltwUKktbnNCNW3YT
 Rgn6Xt2w8x1tCEhwfmDY5Wa5bVQLgqEUkbDUWeUSf16DtNag6P84+iJj8wlLy5dM6Ekj
 deKxhbK+bvXdkngmh3WVhHHHHJPGvtM3YjzbpR36nzx9Vn1qK8HiFFMllLHG07SdCq66
 5DtA==
X-Gm-Message-State: APuU4Z+tm9aRBD2oxG5xRUi9aD7oOtMZuvXnzrYx5Z7dGpBiSqgjgu9i
 g9Mgg/kK/kjI//ycW0+Lifk8Awi/FIHSacj2+46A0pHk6F2gAZgamYqNHxxA3oSRTX1SgtFhhEa
 Jox5O4CKIxXnxm8XUBY8Kgh3s8VRn4gM=
X-Gm-Gg: AZFdTZf7q0yEpCDu5f35bzzXkMyHV50sVuXpdAGBRQd2WAXStJ4D0WgDI3PW1P+IelJ
 OeOGKtz59rHQl5+imkAp/XaURMviSvIPyjatbHGpKbZxlveAH1NPeFJoIWskjR1oeTTeUZfD5E5
 qaJNGckgZnNdYPPRwTtTDNUsuwuXUPMfkyZM3++0EeSql2+v3WmHVFhzY176HkcIqOXgtZ+16wP
 n3EdjtlGsWeoTXmOhnLLYOOous6/NYM64hSvXCcZQeSgS/kFVnnJfzTMtQVLLtuBZPjY+1opWey
 6J0uwiYlw5EzARvpWrMACF5pVxer+qMEIsCEvsLwZXYiFK/OSdgWt3w47tBffCdMplQ6GavU/iW
 E4bkTb6/22I8ia+38BD8IuGFwaCaapIxt6lodCSWHtBAIszV/OHpiiwHe
X-Received: by 2002:a05:6402:1941:b0:6ba:7b46:7885 with SMTP id
 4fb4d7f45d1cf-6ba7b468283mr7816339a12.11.1795576079241; Tue, 24 Nov 2026
 19:07:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123193714.5096-1-linux.amoon@gmail.com>
 <20261123193714.5096-5-linux.amoon@gmail.com>
 <20261124105243-GKI100890@kernel.org>
In-Reply-To: <20261124105243-GKI100890@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 25 Nov 2026 08:37:45 +0530
X-Gm-Features: Aa3M54oqPN-QbuceHVyb8sOOUe2lSlprsbnbis0okiVgPZjt7EmDI3L6798sk3Q
Message-ID: <CANAwSgT8kHvsBdbbSavKWrM0V-sV2QvdYiF3KsXwU5-f=qUhmw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] pinctrl: spacemit: Add SPL support for K1/K3
 pinctrl driver
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Dave Klotz <DaveWK225@protonmail.com>, 
 Eric Chung <eric.chung@riscstar.com>, Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yixun,

On Tue, 24 Nov 2026 at 16:22, Yixun Lan <dlan@kernel.org> wrote:
>
> On 19:37 Mon 23 Nov     , Anand Moon wrote:
> > Add a Kconfig option to enable the SpacemiT K1/K3 pinctrl driver
> > in SPL, allowing pin multiplexing and pin configuration during
> > early board initialization.
> >
> ..
> > Depend on SPL_PINCTRL instead of SPL_DM_GPIO, as pinctrl support
> > does not require the GPIO subsystem.
> >
> Not put above into commit message, but should in Changelog..
>
Ok, Thanks
> > Cc: Dave Klotz <DaveWK225@protonmail.com>
> > Cc: Eric Chung <eric.chung@riscstar.com>
> > Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> > Cc: E Shattow <e@freeshell.de>
> > Cc: Yixun Lan <dlan@kernel.org>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> Otherwise, Looks good
> Reviewed-by: Yixun Lan <dlan@kernel.org>
>
Thanks
-Anand
