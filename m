Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD7BCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20F7D80A89;
	Mon, 19 Oct 2026 09:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sq-6tLdh4uru; Mon, 19 Oct 2026 09:13:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A249080A8C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401226;
	b=qNqhjNQ2xj8Hy0icj4Kfzhe2dGFarWOQ918a9mvFiefaEmWnyhYdCwEE8chOlSMJDfs2
	 ec/zxYaW32rFqBm/z6Kr2URddiZX0arCA6+Yflb3/6GKZzV6wMNLZmYV2tcSaigwuK6KS
	 fJxPpkt7Tt8uZ4hrq3lk4ucSkabBv9h5a+LZTipPteuTBldf0S/DOsXIqt4bk2cpVHfnQ
	 bu1Y3r959HayWBh0P8FBgZUpvKdyDW1+sdbr5HOhQTULkthKHf786OGKZQH+wqIg9O0YB
	 pHVlp+WSbUUEG01yZGnUnQ6+ojrTJvxbhYw4eJmopv6EIRtXpsCXvC7hpP+DRkrPuwA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401226;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sp9QzO/2OE6cJq7z9kiwBsnc3vImIFuzdW/3r/97sho=;
	b=X356ltswsPpRT2R5zKOS1l72VQm60Q1hCiW+2/fx6U42IuexvEsB0vGRaWD0YYIDC7RW
	 7tLsiHonLgxR3TeLCSfvQKrm90kKCDHBGhe3JOMlxTwlFi3lqOCn5M/yCJtGVaDCmyq2o
	 XrdtNdbv4Yurv+S8SbtG/DZ2qW780fP1paOtop6NamtrKJ3CeBf3Kr6W5CMLoBbnZANQ9
	 7G3evrbM2la5A83GMLJT4Y3PiFHpWcDq8azAvlREnzkJX/LF3kCCrln9jX7jE4RLHynV2
	 E16Fp0KoTz4CcScDNvfzyuh7oJgjtPSkqBRW+LqYBOsHcLKBdoUB6PWPYUaq50IaB1w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401226;
	bh=Sp9QzO/2OE6cJq7z9kiwBsnc3vImIFuzdW/3r/97sho=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bwX8qAHAw4U6iS+9mJdK/j06e34pDhWDTgKsJrY24cS+dFMWy56ycwU+9vD8KbAUa
	 GGmpd+r39zh/VeJ7vrh/WaHYmTWtYKgkixBEUJMYEbTKj0hfQ3/sY3P3eX/MO43THy
	 BaMQllo5VeaB4UnRNFFEiQi7UNwAe7rfSTYQDfXSdbJpDacdZgww+NukYYurDc3iHP
	 D53doKKZgqM2d3JQLkz59KxukbFgWjsOMogk3Zl7HjkWqpDVwlOJAH77s8bBMS8Vre
	 r59IrGbhd2zmNe9k6m6dw3lJ8QqQSJPQo8oKrAFrOR5b3/IOmMwO4C+UjD4xBCJ8Dl
	 PbrOvtyz0quwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A249080A8C;
	Mon, 19 Oct 2026 09:13:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AAB6C2A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B4C26075D
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:13:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gecAXNC-X1iK for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:13:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E9B5F605E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401224;
 b=kzx5nD8GRI9dqzexZX9+pIQZ8P6K0J7Y43x1KS9MkPemSZfzNipqFtR7VMow48421A4p
 jkQiwok2gfyqAT9ITmaOJ302fDHG7VqftjtnGfqi4NNlwRMFUmV8SLfH83cEF1cQdnazb
 C7dl0qxdnVHqECzaHsiMnsVhBNoZRl8QxZ2qh+ylG5gql0bA6As6gNbEDRkAKoT11zvMm
 i1q8qfGH5jlp8NI+1sgacELV4K7biSiAJl6oT1JDuRFOP1/gHfEI0IGynib92cwfyly8w
 cTl5kmfY+18oz1j1IJDftxL4yxxFnadihLOfcxODMMe1yJVRdk9WedvcO9wbtXItq+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401224;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=Sp9QzO/2OE6cJq7z9kiwBsnc3vImIFuzdW/3r/97sho=;
 b=JjDNUrXqN+zLL0IUGsMdZYqWuAZ4Wzj13iiUNFUtJA8V9kk9Okzcv7oysVVtJqBwg+4R
 grgudzj/fVl21fKdmSyvNxt1E6tA6t6qe4cIA6VfEeiYKf4OijQOOfmws3ano22Ndb+3o
 pDemvCAeVcIkP1vlNAzjuoBqlstaEdRJRoFvPEJXybaZxaMDW8m6/L6fY/4MCQS5bPGaq
 Gq5b41b+JO+Js2qshqEzpVVAFkj5nT87kQFmtGx61RC3f0iZRXfoibWTRshh/22GNAoXx
 lLArQv53NAFXasNHLkSp8EZi1u9YJEUWpJ4wqmvzduOt4xhk8qOrXcCpfYVQy/6AAIQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Wr1ARPDK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Wr1ARPDK
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9B5F605E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:13:43 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b2232d8ef5so2719205a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401221; cv=none;
 d=google.com; s=arc-20260327;
 b=jv3kQIZ7g5voEbHac51WZEK6Pr08ry9BPUrXU3+CqiNXgD1lkwfAq85hSpkqWQAQrZ
 ITu0rJwNQNeI/eABzJ6/miOK4IMYTbEG2/xG47C+uFOVyj0a40jFUzzreJTGuw5ezo5t
 k/kIEY3Kq0D0IbLS7KYFY2yB/2yF4gzRNa5wIMY3UnFOadExcs/aXzN/VVsQnJi4fsl3
 YX1YOZX3ECgRfar9Cbnxs+HMTWDGsYHntuRbUFlpQA2ZgVLJQedjYwzcMx6yQXzyi/Fz
 mE7XXmRY3ox9sz8KvmNT4Xx8PuYfe1MOdS7E1QhnFo9RgeTGpiRQ7APA9T6zT/3fhqzk
 VymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Sp9QzO/2OE6cJq7z9kiwBsnc3vImIFuzdW/3r/97sho=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=EwXOdBfKsD9i8OIStKRiY62TxFEh935K9y46RPd6rVFtfiI285wkmse5L+prUMCCRz
 O8EQxoUEBiM5QDxhGetEGUwuAv6pALhMNIgEhbpTD90IZU8aihGm460z/aNFcJA8rSVt
 xg+IDUjLttbZVWI7Daq6L01XS2hizIe6aqfEdYb1Cq9WTyJiRaPNoDCY5AwilZNMjUVf
 2cOrDoOyUN9bGhEyNTltwbqnbWf+46U3Cz7kgd4ffEeFGAgJ3V9oktlEnYNQrpu81PUK
 AD/+mKNfVuBdZgOBbwa5WXeJkzLI/ufuTkRDxZfzBiLuiV+0cUbboUVipdBatYRx3rp/
 YeUg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401221; x=1793006021;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Sp9QzO/2OE6cJq7z9kiwBsnc3vImIFuzdW/3r/97sho=;
 b=Wr1ARPDKzSBfaUObn8sRieVybWIJj7Ud1dHw/o3k65cork+U002TUpu7wu3UKSUfQc
 bPriJtb0FoZFG4sWm0cMclWeh5YykUmLvyQYR+Xip6y5IdC8wbFMaHL4j2HdtlGehQdA
 a8PN4avEhPbHJ4hamCtQ0lUmfVp6pDaog2kik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401221; x=1793006021;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Sp9QzO/2OE6cJq7z9kiwBsnc3vImIFuzdW/3r/97sho=;
 b=mxnShKkO7t6OFnucT1VHaoWXVrHNZ2QRwD1/rg+qoXikNJySWxkDgr75sCxwlHP9VE
 AWS5E+4aCMc4ckWsCBcSplYZjLzYAYm8PqGlYSTfYgHFAQF+cESMQwJXudpxmzfD35wV
 n0FSftkC8VZU/cjNKbz1vsYstBgXcbNbp5k61awWoBeI0TgmhxyxOluvujl+/EHQUM62
 xOLlo7LHhwRtwAlNNi2AgqeB3iJJKbwsc79ZUyrmhrOGX2k6IATfrtZhX2grUDICUxk+
 LLNJpQ56IX3nWhY4JLPle+KCz4jYPQ+E41kjdv7/cboMMN6LidCh/zlmnyXeRKpnT3ti
 GFqg==
X-Gm-Message-State: AFq9FYIST9K/0ZEDGNAgFVER5yJclD+r8IMGbSBLNMhNoD+HSFYnIbzh
 xXtHpnIH9pQUKRCa/fFsyNcnqASvfgT1/m/MgGXmMtv8uCDc4WLX1ae8jvwpDN3g5KgMb1qXC0J
 IdmdRCUivZIh5cNAcxb8DF5frw5xZUqj0mScq77gW
X-Gm-Gg: AYBFou3UKji6dUMqRYt2xF5pKnHhVPoiqfUpaCPWzcfxJ97YWvwVrIChNRYACO4gkP9
 Q4r48NvudARt0BNEgjQP6EZTJSFm25oWC70lm7xHxI8v8QZJ1AnMKrNphcc3tKyWzGAjBnTqS3c
 9aMD6Z4jzGPz433RpKw0/JMSid81dj6lsOgT/aYBoiLDSu244Vj2VXWaIGU5+G7V8uwtVOVCj4n
 Wz7ERbgrz4OynZe9kEYytUXXJD8e3gMmJpBR6ph9AryzzLylA0/xVbRj+qloaZTrONKtCLPQpjH
 CT2Qmx6dJP1w6BVP6TKHHUSFETmrHv3W3bmZAy5ekjWhqCz66VZ9lN4=
X-Received: by 2002:a05:6402:210e:b0:6b1:801e:e01b with SMTP id
 4fb4d7f45d1cf-6b3a8168ab3mr4166951a12.20.1792401219986; Mon, 19 Oct 2026
 02:13:39 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 02:13:37 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 01:25:13 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-1-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-1-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 02:13:37 -0700
X-Gm-Features: AclHuK-Rmg4K1CpD13vSntiNbhoIA4V1Aiv5KgwPQoA0C1sRh1KQh0EHbqIVVJw
Message-ID: <CAFLszTgobHdzc1_OEKhsnp7-M16EP=3NAGX+Kgx2i42fv6a6DA@mail.gmail.com>
Subject: Re: [PATCH 01/14] expo: Add section headers to menus
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>
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

Hi Petr,

On 2026-10-17T09:10:23, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> expo: Add section headers to menus
>
> Add SCENEMIF_HEADER a menu item flag for an item which is laid out and
> shown like any other but is never highlighted or selected.

>
> Up/down skip over it the initial selection skips it and
> scene_menu_select_item() refuses it.

Commit message needs a tidy-up: comma after SCENEMIF_HEADER in the
first sentence, and the second sentence has run together - perhaps
'Up/down skip over it, the initial selection skips it, and
scene_menu_select_item() refuses it', or split it in two.

>
> Up/down skip over it the initial selection skips it and
> scene_menu_select_item() refuses it.
>
> This lets a menu group its items under titles.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> boot/scene_menu.c    | 21 +++++++++++++++++----
>  doc/develop/expo.rst |  4 ++++
>  include/expo.h       |  2 ++
>  3 files changed, 23 insertions(+), 4 deletions(-)

> diff --git a/boot/scene_menu.c b/boot/scene_menu.c
> @@ -401,22 +403,28 @@ int scene_menu_send_key(struct scene *scn, struct scene_obj_menu *menu, int key,
>
>  	switch (key) {
>  	case BKEY_UP:
> -		if (item != list_first_entry(&menu->item_head,
> -					     struct scene_menitem, sibling)) {
> +		while (item != list_first_entry(&menu->item_head,
> +						struct scene_menitem, sibling)) {
>  			item = list_entry(item->sibling.prev,
>  					  struct scene_menitem, sibling);
> +			if (item->flags & SCENEMIF_HEADER)
> +				continue;
>  			event->type = EXPOACT_POINT_ITEM;
>  			event->select.id = item->id;
>  			log_debug("up to item %d\n", event->select.id);
> +			break;
>  		}
>  		break;
>  	case BKEY_DOWN:
> -		if (!list_is_last(&item->sibling, &menu->item_head)) {
> +		while (!list_is_last(&item->sibling, &menu->item_head)) {
>  			item = list_entry(item->sibling.next,
>  					  struct scene_menitem, sibling);
> +			if (item->flags & SCENEMIF_HEADER)
> +				continue;
>  			event->type = EXPOACT_POINT_ITEM;
>  			event->select.id = item->id;
>  			log_debug("down to item %d\n", event->select.id);
> +			break;
>  		}
>  		break;

Patch 4 then throws these two while-loops away and replaces them with
a menu_step() helper. It would be cleaner to introduce menu_step()
here (without the wrap flag) and have patch 4 just add the wrap
handling, so we don't land an awkward intermediate form that only
lives for two commits. What do you think?

> diff --git a/boot/scene_menu.c b/boot/scene_menu.c
> @@ -529,12 +537,17 @@ int scene_menu_set_pointer(struct scene *scn, uint id, uint pointer_id)
>  int scene_menu_select_item(struct scene *scn, uint id, uint cur_item_id)
>  {
>  	struct scene_obj_menu *menu;
> +	const struct scene_menitem *item;
>  	int ret;
>
>  	menu = scene_obj_find(scn, id, SCENEOBJT_MENU);
>  	if (!menu)
>  		return log_msg_ret("menu", -ENOENT);
>
> +	item = scene_menuitem_find(menu, cur_item_id);
> +	if (item && (item->flags & SCENEMIF_HEADER))
> +		return log_msg_ret("hdr", -EINVAL);

Just to check - scene_menuitem_find() returning NULL is treated as
'not a header' and falls through to menu_point_to_item(), which
returns its own error. That is probably fine, but worth a line in the
commit message to make clear that a bad cur_item_id is still rejected
downstream rather than here.

> diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
> @@ -63,6 +63,10 @@ select the item), label and description. All three are shown in a single line
> +A menu item flagged `SCENEMIF_HEADER` is a section header. It is laid out and
> +shown like any other item, however, it is never highlighted or selected so the
> +user can only move between the items around it.

Please mention how a header is created - i.e. that the flag is passed
via the 'flags' argument of scene_menuitem() - so a reader of the docs
can act on this without diving into the header file.

Regards,
Simon
