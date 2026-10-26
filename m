Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574B606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=owGY9+w+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aWzpQP6G
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FC2840661;
	Mon, 26 Oct 2026 13:36:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2KljP4qQHmqY; Mon, 26 Oct 2026 13:36:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D76B540664
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793021808;
	b=I1LYYVhk28w+KQwzX3SJw+yw20NZvDUyhK2GXWw4uXWRkhj3aWc3fANoH3lTRPO53C9M
	 TqrhD9UaLY/kKzjaqvfNlYwZe++g6Qs06AV2v1QWNG+V5EIYmI80oCASYmxCD1d7sr1Ip
	 agcYWWC3cWduuSiEiln6lgprR1BV/e4m9HzxG4To2SNVEutlvwbmWBoYNw8Io/xa+Po8Y
	 2eTtq6qPOYnrZdAwYEXOw8AyKqIMKj9/Cr8nHLP9jUDmtUc81QP8uF6NxrOXeZTYzxd9k
	 xTyvhzUjUwIjUZ6wS0oXdP3syBgoo2MHVlyTKqJDpEw9i2a14oK+oq96G2vWLWGTcBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793021808;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:
	 X-Google-Original-Message-ID:Date:From:To:Cc:Subject:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WrQOzk/MJbb3kWfX/OjSyJVqBmclrSMk74Pe8wvJVWY=;
	b=Qd8vvjK1vokLYSncHaRlIsDjg3jDDSMhxSOz4Bg2bqkOheVxev0OsZW/YLWraK97KBCg
	 q9DePdfBlUHWS0NUY7kTF81GoHecH9NnuKnY1kAQ9/7JZoxJm4CKHbWjVpvkkL+wBXUxk
	 LGemcblY9ux4xAN/2rZH/LmVACOmtD4bTiUwPXgWwlzI240etLLHD0RaMlpvKfovdx/HP
	 ifU9diU/ZLnED+TGQwUVQVBEwI+GqnkfDEbdVphDX48bSdLxqCmP9mB0AVuQpm1fvWd3f
	 AqKdURMcgY+ShuWjKLX31Cma+ZIqWh+F6yo4cyVDQ9kJxCzZtL3QrPUKFgfA/dpR5vA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aWzpQP6G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793021808;
	bh=WrQOzk/MJbb3kWfX/OjSyJVqBmclrSMk74Pe8wvJVWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=owGY9+w+848eUKr4n6tYQaqy3ziJN5L1mPCBQkcsDft9zR1ulhMcWOXtgm+s1s6oo
	 HirbAPNtDv2b94+SlBrG1dJnFEkJoKQiFWKF33GcIE9GJ324a4lZ0sE7O4aOeP8o3H
	 CcuvTQIgIolK1e3V6CSwVjytBEBZ5uxSLmYh8xyTbZM95QZQeg+9L8B8/CwOaXcwIx
	 S71m1Cf2yEAou6FSOScZJ7S7l0jf/XJAYafFVsGn6568PsQnMeKpFII3o/xQDrByy4
	 tvDRSoo04+0V2hRSabk7ag4lYohtTs5HU4jzOIq9DWQToczKatCpjSEO1NZ53kF5kn
	 gHLnBsNezrw9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D76B540664;
	Mon, 26 Oct 2026 13:36:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4ACCB3B6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3063240664
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:36:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z1gBidmKMrDf for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:36:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E7B740661
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793021805;
 b=XFKag61fcxlf5klCAybg21wo1W7lhjxMJCM1pPh8/d+1SwyiXQPBqVRqsXE8lnXNb3UH
 sq3LDeVdli8miMGXEoZ/ECAHfGMV+B3KE7Qu3d+Pmoe8lj09R7JkJ9YGVK7z9aqvOkAhY
 QZOwyCdH1ex460ibJ5tjOjVP2BIYnAie2x7t9fJKA0Z7Vq0rEt9S0Lh9LmzxOzyV5gj/L
 tAZ6IBXRJRBBypU27vkHqeVeaW6q62DsnLMUE7fRH9yiHNSw+9NM7qzoqrzHeBY0kJ/U5
 f5MjKA41j9DVyTeuPiVfvEFnS3THYVCw6Ez1U5oKgI/E3gT811wVzvBFVKHjf38pSyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793021805;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=WrQOzk/MJbb3kWfX/OjSyJVqBmclrSMk74Pe8wvJVWY=;
 b=M31Apuk92FnOp3x0YmTxr6wpsaEr1D5Tnc+xBb+ILrVtnIG9Um19PSM4/Yfb2XxIm2li
 kjmHcRG+cZrDz9I52iPl8DZ6obNHJSJ2lwgQamTztPTJj7YPV1sxwnTPx8UqSnx4nzADn
 gmQ56cgE7s5dELVTypVtvRo74jQUDHifGhy9Xkng6IopFP0vdE4QcjGLidoVPdkoky68c
 dDH04SOissf2XB5H2SipfEKnXEmJGO0WlB5pNSHrYSxGwm6KD1wsGpdOXiFzv760Vudmb
 TevBpmEi2FX1uzJT5XKNfOmhqEM/uvkFRYfk/8XYs6ZFqHvjpR4qz2zD/y8tbsDWx9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aWzpQP6G; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=aWzpQP6G
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E7B740661
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:36:44 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso16923515e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793021803; x=1793626603;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:subject:cc:to:from:date:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WrQOzk/MJbb3kWfX/OjSyJVqBmclrSMk74Pe8wvJVWY=;
 b=aWzpQP6G0RS3us3uTKB1IIEy/Ff+JbmIfD7TNPay4xu4EreUKDqdxJ9k9AhqYlP986
 MRlMxkJDjmOHjnbg7R5tIS/s9baVxKCMw/3cJaaKYNT6Gl50SqQJR2zWojrbj257Ly/y
 LpQjoxEfJ9ChXjp+OGuX+LO/jwzY39v0w8tNZ65cfhFmMt0rbZhJ0EP1iVwu+/0mJGzs
 GFTdVoXr5nA+3Zv8kKwHBIkGmE/6NVLpM8XpPNUlBZ6hb7jaW0UJltejsArCvCtVzJSD
 4pFPiNf7sKfnXN1+iauX3huJ5j/bSF43hNw50ZMc1DddqfAAeEKe2PQfL6VGC308zxXZ
 muPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793021803; x=1793626603;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:subject:cc:to:from:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WrQOzk/MJbb3kWfX/OjSyJVqBmclrSMk74Pe8wvJVWY=;
 b=C4qVoYoicHv/oKdT/Egpml6mfVsCv9B4QuVEjoYZI+KHLB0H3d0y1lWwfTkvlhRNHi
 Qi9rCATEeVum2JhqLJYNvn4Pdnaars0lwb+ci57CfvRNGHlWgIP6DTmXGL0ArbqsPa8v
 xOqanS1mQQtZUyaVErdgovgTL9YW49ypOiRb72kVewjYmGGVR9Fw1dhPumsyb4P2Qlvr
 LI9tI811QGIN4Y9QgPlFMQVeDYOCooI9xTFLdo17AqaOI0algPafHzhGNvVfgG30NJlm
 BzCgdS0Q0i1FwM6GQ29fbfmBXyxyO6ulie1/WpkXAIhhBU8WqjFV4gTf1ugcOMhIsGkN
 pcrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwr175dZ3znz8GjbHqvVILZozzMAni8llE0saTeMIPqbqH6QXHfWkMRV0JXLv5SPyZDT9/CE38=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ2JYl2mnkZygv6eItR0yGCDpVjxt23h41BjzQBpYVH1tlu5Azn
 k/yWpTZSDwy+pWfgT+BFkl9/l91PslYUH3NLcIeCgVQSkzP27P/KganU
X-Gm-Gg: AYBFou3MWVqmzj7Oss4/2NrDXEM5nOa6fbHzneruNIbCfIENvkgDlO1KH9dpdJfsq3Y
 awlu1JzFjHZ5grrEKu2jtgkT9pVH5rRwfNdIvQ+Nd5HITvlNXpzRomldqmtgHN51FbRbBMt1KrK
 idP8NWVIPVU6Ni74xJKd3W97BEUNnJHLJ4UR8lOBeZcPEgI85Tt+fr+l4fv1QySoJoZLtkDxmWS
 kwxRr3Wq2C3yoSZVa5z+vd45Yyp5TX7/OkVNSMTstQiKccwkersjqQpX/UQED7Pdxm7xC2zO21a
 aUKcNn3ttOtT3ukhUJmUb3t5yD+Nlu44NBfDaBCuo8q4STN+88MJBkg6iaBDQkguzrrCxZs6FGT
 x4Vy17+ZWgTBtP4nogzZENN382Ir9mvuw8bSU8WPLfBy1CJ/P6zbLPgtys6265y3A2Txtyrm4BB
 yfCZuxpw+hkxesfP2sTy++RjnFqZM17hViiJsysSseGHGYSOYGxa0m689kra7jz/zQalFuGaEsW
 g9LCENCyyKtSZa7Q8n/dF62Ck10lkbF1EsRclEl32M/fpKwjqQ6XSJaO99QYS8y+QdIUogcz6vB
 SUF0942FGO8ONmvb0JXfP0vW7CUCPosE/E3LN2Li/M8=
X-Received: by 2002:a05:600c:3553:b0:4a2:fd2:985e with SMTP id
 5b1f17b1804b1-4a35aca7809mr139753515e9.17.1793021802528; 
 Mon, 26 Oct 2026 06:36:42 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a08dcbfsm131137035e9.2.2026.10.26.06.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:36:41 -0700 (PDT)
Message-ID: <6adf5769.950cae81.ea04b.740f@mx.google.com>
X-Google-Original-Message-ID: <at9XZZGmhl2zPplf@Ansuel-XPS.>
Date: Mon, 26 Oct 2026 14:36:37 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Randolph Sapp <rs@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v9 7/8] misc: fw_loader: introduce FIP loader driver
References: <20261023190034.911023-1-ansuelsmth@gmail.com>
 <20261023190034.911023-8-ansuelsmth@gmail.com>
 <CAFLszTgNfacD0cDBii5VudmUWZhGThU2WFGHh=qNr6FvM5PTVQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgNfacD0cDBii5VudmUWZhGThU2WFGHh=qNr6FvM5PTVQ@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 05:37:29AM -0700, Simon Glass wrote:
> Hi Christian,
> 
> On 2026-10-23T19:00:21, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > misc: fw_loader: introduce FIP loader driver
> >
> > Introduce a variant of the FS loader driver to extract images from FIP
> > image. These image can contain additional binary used to init Network
> > accelerator or PHY firmware blob.
> >
> > The way FIP handle image type is with the usage of UUID.
> >
> > This FIP loader driver implement a simple FIP image parser that check
> > every entry for a matching UUID.
> >
> > Similar to FS loader, this driver also support both UBI and Block
> > devices.
> >
> > Also an additional property is added to handle special case with eMMC
> > that doesn't have a GPT partition and require a global offset to
> > reference the FIP partition.
> >
> > An example usage of this driver is the following:
> >
> > [...]
> >
> >  drivers/misc/Kconfig                |  23 ++
> >  drivers/misc/fw_loader/Makefile     |   1 +
> >  drivers/misc/fw_loader/fip_loader.c | 558 ++++++++++++++++++++++++++++++++++++
> >  drivers/misc/fw_loader/internal.h   |   2 +
> >  4 files changed, 584 insertions(+)
> 
> > diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> > @@ -0,0 +1,558 @@
> > +	lbaint_t offset = part_info->start + part_offset;
> > +	lbaint_t pos, to_read, read = 0;
> > +	lbaint_t blkstart, blkcnt;
> > +	char *read_buf;
> > +	size_t size;
> > +	int i, ret;
> > +
> > +	read_buf = malloc(desc->blksz);
> > +	if (!read_buf)
> > +		return -ENOMEM;
> > +
> > +	size = min(firmwarep->size, (size_t)ent->size - firmwarep->offset);
> > +	blkcnt = BLOCK_CNT(size, desc);
> > +	blkstart = ent->offset_address + firmwarep->offset;
> > +	pos = do_div(blkstart, desc->blksz);
> 
> One thing I'd like to check: the move to lbaint_t in v9 breaks 32-bit
> builds. Without CONFIG_SYS_64BIT_LBA, lbaint_t is a ulong, so on
> 32-bit ARM blkstart is only 32 bits wide. do_div() needs a u64, so
> __div64_32() then writes 64 bits through a pointer to a 32-bit
> variable. Building Cubietruck_defconfig with CONFIG_FIP_LOADER=y
> gives:
> 
>     include/div64.h:220:32: warning: right shift count >= width of type
>     include/div64.h:224:36: warning: passing argument 1 of
> '__div64_32' from incompatible pointer type
> 
> blkstart is a byte offset here, not an LBA, so please can you make it a u64?
> 
> > diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> > @@ -0,0 +1,558 @@
> > +		to_read = min(desc->blksz,
> > +			      (lbaint_t)(sizeof(*hdr) - read));
> 
> The same build also gives 'comparison of distinct pointer types'
> warnings from min() here and in blk_read_fip_toc_entry(). That build
> has no CONFIG_SYS_64BIT_LBA, so lbaint_t matches blksz, but size_t is
> unsigned int on 32-bit ARM, so the two min() calls in
> blk_read_fip_firmware() that cast to size_t still warn. With
> CONFIG_SYS_64BIT_LBA=y, lbaint_t becomes uint64_t, so these two calls
> warn as well. Using min_t() for all four would avoid this. No in-tree
> board enables FIP_LOADER yet, so CI won't catch it. It would be worth
> building a 32-bit board with it enabled before v10.
> 
> With those two nits fixed:
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 

I compiled for qemu_arm_defconfig and used min_t(lbaint_t...

I think should be enough. (I also verified 64bit target...)

-- 
	Ansuel
