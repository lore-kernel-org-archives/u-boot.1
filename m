Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C60606A31E
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tRquyk1B;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=gWbT25gW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 747C840692;
	Thu, 29 Oct 2026 08:38:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pD_wXMFrEHQV; Thu, 29 Oct 2026 08:38:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D4B0240665
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793263113;
	b=sd3t/Ab7njkr0/JQo5wNyrz6HEPKAhB867lAYEUIv3fQssEUaHiOuZWPLAQS29WCWgvD
	 9rvWovzLcL5DlqMeLldSW/kRkxIbRz0xr9fpgUSRxXJVI5LXyeJ6EjZiD6PnH39XZXTjW
	 7DUtP15Tw3EPogcmA8C0nF8VoyQq15b+kMzGlGs5bu8hMnOjGvHFzFUQROf3BHiTwTtRe
	 mAGkWONBsNYJYMVETDsaiwxJuZ1U3UjvMZXc4L48ROk+GW0HJRfg4OcZ990I9K15h9MJG
	 9lXieBJSqolMlUQg+1Nxi4nFfY+90p2upUOi7Y2KBt/Xh9Fmkzoftpg76WxsQYKn9lg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793263113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=S//dXUIGJ17ikrBzsN0MEb3OyIIGWRFaJ614udXO2Cc=;
	b=KTZl/sQ/pgJl88br88Nb2lrKThmSlPSA6Cd5YNCi8g+meXs2FrGqPKQuBKNBYADZLmJF
	 AV+2PFUC/SLSmdKjLxLaaRCspsDtTasSBTT89wqSZaup9IRXRcFBWIf1wtGXkNXnuqcgz
	 zwOIh/+gZuIEzpDPPa1pUFJREFEzELjR9+xNFw8wjY1uhs3LcP0OwWwUeHrTB+L4idS7X
	 qbNsK+l+dN5mGhibqndJL+wajgd6EhVe+D4mT02xW/PuzHp5HWKICn1+xtMIgDvd48GzK
	 DjKJF+1zG5IxhkDYK1UrrP/KDk7JW7quj8g50QpRrx5lZz5yt4RJ3rSxSWpfJlFbdBg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=sifive.com;
	dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=gWbT25gW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793263113;
	bh=S//dXUIGJ17ikrBzsN0MEb3OyIIGWRFaJ614udXO2Cc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tRquyk1BieBqY/VOFdUhqLFU16e9+4hpNRbQJyqn/aZTwlSmj5hwid/ADTOrhqHvS
	 T4wVNqL5nTS9XcYGGcX5piMTqoEf6MkRqBtJAuZU+JbJmfilG28UuENMpM+SF6ZtEM
	 UnjaS8ZUZ8IZ2cSmr9ZatzPooPbzhAzm9NPHddaXI4r6PHvr+wOAb/lrb7uC/bgwJ6
	 /cPyQg2TjRYaWbb2J1gHPh0ySmPjjEnVrswmo9NyNjOVqmvRza+UawfAu/H9SA3PjC
	 urCmobCytEqEajMMuxuSgfxtMiIonTD9smUyxqlq0PtAWsaMtfDLaLXVu5AA2wB4Hw
	 AOsxO5Kpvyh6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4B0240665;
	Thu, 29 Oct 2026 08:38:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1923D356
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A80440665
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:38:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xMrdNDioTaMj for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 08:38:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 53C1140664
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::233"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793263110;
 b=iZgI+KznliuN0OtpSKkRxa14ZFiGqqZpVslw6IdSxskCzdc+tsxZIDo2gopTnS31fSvP
 SKHYeCxbov7btEHXNSvpe5HxD8/YADnspP5ZWkrLMV1Ii7SDFjeEeOI8jvNxQMleCk1iK
 jC7odwRuX450sCJk/AGLCWxY84uq2f3ZsHwhq6NZiVg+vDMSC27DjEf9aFtCARBzjuxJ1
 tkpc7UopHxz+hp7pm4xaDUXvLY8NByfa174OsGOZBCgDr51aIxmA5QQbDmpYrork2JaLP
 UaraevJZYeKq0zqpF0tXsQXEOQuRc1WC5WHsJakbJ6girynqb9MVqdZ2ja22F9MDSqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793263110;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=S//dXUIGJ17ikrBzsN0MEb3OyIIGWRFaJ614udXO2Cc=;
 b=hOJ3uJCERLZkY07PiOg65/hMHuYB0WAYo4X38m/JZPp4sHYnh4yS4rXXd+WDXq2IIL4J
 vBdPScQn4G/nCXC/qwy8MWZyuHuHnuvRVU07MD9yKICGighlMTBxDHje9jeLOQEMgVr0T
 RLJrCQbnDVBcAoZPjDXySE2StbecwhOnPT5ZRX448U0nxRR+XtlQpJibUuwQA5g/VB974
 eR56rLpPnM1RIAH49BQCNQdbDQkGA4k6GmTFQuOCd+1mhKcJMHsSFo9nrYp7tzVo5uPb3
 weJj14ka6gQgKlsjLWhD/GylPQOPUlLcOOf/mSxJcNpMfpsEl9g61fvHp9NNEmsLNIg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=gWbT25gW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::233; helo=mail-lj1-x233.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=gWbT25gW
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53C1140664
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:38:28 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-3a595487d43so15248381fa.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 01:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793263106; cv=none;
 d=google.com; s=arc-20260327;
 b=O+r2dy6PCcrRaU4ytqEwh5UiwJMAFSl9i6gX4vwultf4nwlijhteutYtquxxGgO21i
 zF/HmGZ3wXiHGkTLdqZ3LB2LIlHrUgFNwhQua2l6o1xmgVf8bfcNzGUyPPx8jI1qHlbl
 lPYJe7jG279CRhHWxw/gP5RoJUq3JLQx+nlG3owzfxFwmNgvQ+8D082UNFVtqU13G6ad
 vaqwjv+pQ260cbHOtyE3pf9yZcfIEk4ZTKblB9OyE7uLi+/uKzdHHg+8ki3y9rOWFUVG
 0iMv/U//Dz0SUPDZrQi6o2VUw4iO2ZNB9cX5Q08pBD98qiJLMdln4r7T6TO0OWx/4UoI
 dTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S//dXUIGJ17ikrBzsN0MEb3OyIIGWRFaJ614udXO2Cc=;
 fh=Q1HQX+N6XsthkN31ooFMKN8AyVKGJu5zjgmQRpVmkEY=;
 b=bEovmB3N+iNi/nziJM/A7TQhDkyT73ZAMynAfMSZ7LTLzXejy6Fuv/3ttDjPSxcQjU
 Cndbyf9Wqx4hdj1w+a3pt/jHAg56lOwwYnLvYT+RZRQRlqpJvM+ZumlChNH7ypvuek9m
 AVD8O74DL19kH0Tz2ivUH43wYSFP1K1WkmmRDeb5JAFZbMr0NT7DeWfrQwxsYwkShsGz
 nnXTVpHGhSAULJUc8N3jwOl2r5CxuVCuClWH7fmXE4KUmQBMAhkIQmyVEAIdWkcSMXgI
 maLNJgkWDbEBLZ7TrpiKMGlV7vSyjZR0ex3P0WlwnHGeE0G2qrNSqZE1GwxdUQ5whDKE
 QMHQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793263106; x=1793867906;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S//dXUIGJ17ikrBzsN0MEb3OyIIGWRFaJ614udXO2Cc=;
 b=gWbT25gWgTB9PjNp424+KvmeTAfZHqq5WocHKlzEEkIv/1RIwzZG2usEOHoQteUrwO
 RsB70hJux2zB2a6CCZ887cvt5HcrtfqFq9aVDifoL5y8Zax6Ris9yvttM6rwunMRA0IB
 xf/993AL9A1nNXc/7Qnv/BN2ReMmlmAAvPmuY6FMci3CqExK2vIDBsATR+Ql4k+wv3LQ
 aYYg2/9VIpRlK79UzRl5O8IPXt7JUouekKXIq0PAiAOcUvnT6y4+YSzdBQbUC2LwQoNe
 KPNSpbxNQ2Wn/dYs9JwzCN+JOueqvOonGu3Lirx8Q5cvqEX9GFiB+gmCnY4dSqQu0Kus
 XgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793263106; x=1793867906;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S//dXUIGJ17ikrBzsN0MEb3OyIIGWRFaJ614udXO2Cc=;
 b=TFM9UXUXlLU4XI1/26AxIgnYoaHqApYobVdnYVPXWezeb37wlqgEk2qgZ4laqZ5SVg
 64AWznvDixhE/HNzAyVc6uNJsVBeuNOb9ibRla1WBY5KdpA/ioXv7bbZeLTDnc1SnGS+
 ALWweFiNmKsGb9yt9i0jqZ8pxuHt6ShEJrv1ap67ShbEu+m4jG4E2JLxSG2qoaq7DTSS
 fJDwtrOO/GHu5/J3fN915KGfYhaMemTHjfrM7qkmdt4xkFvN9nfjozNbV+Fwta2nsFdi
 V0NJgvIsGoNKyEEAVCs/Xj3EC6O95JMU0QvHiuEm839FnJa4x4YT2cZia2235/FpSoid
 je9w==
X-Forwarded-Encrypted: i=1;
 AKwUvByJxAAOrv8HwY7c2Gc2cq9M4g4ZT9oCkkhOZpnj+idd7Kdx3PVleE6cu2e8ZCg8+JcG8oF24ZA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJE6cxlWWaxtmlhDhSfzPYHrrf+IB219TAaaeyKYjew9Y8fwpTI
 InTcEDs5ZtK3CK3la24rOlIc8xYUw9uYfE96GdFJur7VwkA0fOSKYFN4ZD8wiSVsYA+sfKxU5rH
 HFUTicTZLMY1PG3Wg/wBUUVZNL5XuWjvLzQvy5zQ8gw==
X-Gm-Gg: AYBFou2o1zMTvx+kEbW66xenMcjn9Mz9FBkleM6rEVbQmDfQLuszfxVI6Mx39tMfd3X
 y2WYMeCrAH+LxJFQKKQ1u2gAN3/7bLg+BH/cEIRgjYf4K50X9eM2RDpBlBPLDu3ec/dyOQfGZxI
 0hZVY4gQKGeWW49WbW5wsQTaAgZafQnJgrzQ9OSq863nBvyBJs4yCOniH+Nia4px5KvRAuOcEUW
 Fg3gqRnyN2hXqVjtGncMARlc6c68bxEwPR8T1I98DJQa2rBz4axtXYkLtlSFuHcJliWSD0FmRBj
 4seXSkWBvDY5JTiqFlwaUsa8PO8eg4bGKirkTA6MLX8R9RvdMsgiZQzzxCGVrsLjiN+C757/hUy
 cPSTXLDIQorDdyXaBnLkqBo4XrPho+9al7CIbMORaN/uygTaIv5yYdOxfQeRc
X-Received: by 2002:a05:651c:210e:b0:3ab:1207:bd2f with SMTP id
 38308e7fff4ca-3ac9cf7e5fcmr11828271fa.11.1793263106523; Thu, 29 Oct 2026
 01:38:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260825065257.69536-1-bbanelli@gmail.com>
 <at6fcP366xFg3oeU@lliang-1876.localdomain>
 <20261026012054-GKB184714@kernel.org>
In-Reply-To: <20261026012054-GKB184714@kernel.org>
From: Leo Liang <leo.liang@sifive.com>
Date: Thu, 29 Oct 2026 16:38:14 +0800
X-Gm-Features: AclHuK-cDoufEu8rCQ5qV2unmN1E8lffmo-AvodFj57HMV65X4HhUky3Fk5O1so
Message-ID: <CAC7DN2AOq9nViKLXOXZQUeNvnizkccAviUVng9cm15HxO=-WoA@mail.gmail.com>
Subject: Re: [PATCH] board: spacemit: k1: accept the "m1-x_" TLV product name
 prefix
To: Yixun Lan <dlan@kernel.org>
Cc: Bruno Banelli <bbanelli@gmail.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <docular.xu@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yixun,

On Mon, Oct 26, 2026 at 9:20=E2=80=AFAM Yixun Lan <dlan@kernel.org> wrote:
>
> Hi Leo, Bruno
>
> On 08:31 Mon 26 Oct     , Leo Liang wrote:
> > Hi Bruno,
> >
> > So sorry for the late reply!
> > Could you rebase your patch against current master and send again.
> > I will merge the patch once you send out the patch.
> >
> Sorry, I've also missed this patch.
>
> But since currently there is a dedicated custodian tree[1] for
> SpacemiT SoC, let's merge it via there..
>
> [1] https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit
>

Of course! Thanks for your help, Yixun!

Best regards
Leo

> > Best regards,
> > Leo
> >
> > On Tue, Aug 25, 2026 at 08:52:57AM +0200, Bruno Banelli wrote:
> > > board_fit_config_name_match() derives the device tree name from the T=
LV
> > > product name held in the board EEPROM, and only recognises boards who=
se
> > > product name starts with "k1-x_".
> > >
> > > Boards fitted with the higher-binned M1 part report an "m1-x_" prefix
> > > instead.  On those, fdt_name is left empty and the function silently
> > > falls back to "k1-musepi-pro", so an M1 board selects the wrong devic=
e
> > > tree with no error or warning.
> > >
> > > A Milk-V Jupiter fitted with an M1 reads, from the 24c04 at i2c2 0x50=
:
> > >
> > >   00: 54 6c 76 49 6e 66 6f 00 01 00 1a 21 12 6d 31 2d  TlvInfo....!.m=
1-
> > >   10: 78 5f 6d 69 6c 6b 76 2d 6a 75 70 69 74 65 72 fe  x_milkv-jupite=
r.
> > >
> > > i.e. TLV code 0x21 (product name), length 0x12, "m1-x_milkv-jupiter".
> > >
> > > The device trees are named for the K1 in both cases, so accept either
> > > prefix and keep deriving a "k1-" name.
> > >
> > > Signed-off-by: Bruno Banelli <bbanelli@gmail.com>
> > > Reviewed-by: Yixun Lan <dlan@kernel.org>
> > > ---
> > >  board/spacemit/k1/spl.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > >
> > > base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
>
> --
> Yixun Lan (dlan)
