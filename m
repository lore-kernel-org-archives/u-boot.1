Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01CBC79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BDC7607FA;
	Wed,  9 Sep 2026 20:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gz2oqNEf3zuZ; Wed,  9 Sep 2026 20:54:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C74D4607FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788987253;
	b=UIU2pLbPvWZPgwJnPIIjQ9lqhi0COEJAyoKqCcFOhvBX2Lwj0rQ4/GGIm4QO2W2AjCAV
	 HHZauHw0cdiJB3xAajiY803A4PHwPLPiAmu99AeHPIcjBEYAmhrBNjxbVUh+A/jjdu5pa
	 AqJ1EY5DWMnBDBhaeB/ob0TvYI0Of9PzGePxi8KUGLm0CjyLgptIm7o6Ug8jtPkc8gJLJ
	 3r84jQWHhiJhurq1fJQFgHpgg0RJ35J/LJZLt8dVoKMFl6HsBH+Irl+ogkE/3yKcg3XCG
	 MF9fSdAoM1n0j0TehEzjpPCXAprI/dN3CZEY0sXYHW6U2EFm77jMTLeHy74CGxIs37Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788987253;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YcNpdGNQ+S3Y4v26J+qz1Dg/+v9x9NRSqGLauZ6bfIA=;
	b=ejUoSphDFZR2mdEzg8ao9estjB/6Fp29lrwaXPj9aZIj1P91F6p/v6OWdU86y1DOlSqH
	 1q4LYG5zQJiweQIh+fYMLnNqUCZVgX4YlIbQuvVZw+Nvkt03teHwE7G/Ont0c5gUXvtXf
	 EP2nNnTnw5Y/Aur5lAuzszTyOx+0xYsV6kXr9x4it3D+1eMeCpD4fiiZLWLIkk+DzSSZe
	 G7BkAlLRD/mv3Pm9ncVzGXT05th+y/qMmsnk4ouI4D2wOmRSe0eC4rIgYFuPZZs4ujbvV
	 nQMfWWma+/gXA89SJZqhNkeKXWfgvz5xEauzVLotKuiftO+Qaj6aYTm2gVslpMqQzcg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788987253;
	bh=YcNpdGNQ+S3Y4v26J+qz1Dg/+v9x9NRSqGLauZ6bfIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VfOjx6amsd/wIYrKbmdEPQv7tB/5z3wu3Ywyg1uK26sebRo7TaYvOBn/ileeJ6GY2
	 33juKRqObARytAKGnnGxnxxG+NjtBm9jwfFbfwn/tQaH48w1irvACvmG47GrSeDqXg
	 VvjC1Soe0X1ksRjRcuaituJRtYA1iAd4eSzBlV3Mn1qqoY64Si0Hr4lPArOkIAiYI2
	 s9xYtaO5fvi+T5/rHo78WXhPrM9BSAd3MTMDJmeXS4ANtux3FMEgTY8MFJprtCMXJJ
	 RUIbWu7io2l0EDpGeF49/dRdJM6u9gG425ASmp+jA0NMSA/46uN17luN/cMis8XB0b
	 8vUSEaXfsMxxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C74D4607FF;
	Wed,  9 Sep 2026 20:54:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 03037528
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E898840A6B
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:54:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-iCFesybkBe for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 20:54:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A9EAF40A59
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::135"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788987252;
 b=Py3o0hvLOfO5xQBP4jd/0aG2yOQ8Kh74uf8g+OeO0qwL7u9BkIbDP/64nwUIsuV5qVIE
 1wKjArIddU19rITSB3HVhRp8/UVjBtn94n+bYkKqpU6JI1SDlW3bu5oNumfZXcPiDoGWf
 U/6dnijsKUjYNbgFSbKKQKknVb6HnXzuqFoyp9148H59VJytSuyjcRZKAfhwyuJSXqkWf
 HULzNftBThhOSrBE3jCUX8O3cXE2tj7KGj+8H1NrH3LFclPTpBKmhu5UpyUhmr3K/lJSc
 GhwDrkg56NCrrma4j0khrWt3O5Jrko/HEWDpLWRQgGCDOTVyFJtUAVjgpz/qAzphg2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788987252;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=YcNpdGNQ+S3Y4v26J+qz1Dg/+v9x9NRSqGLauZ6bfIA=;
 b=mUt993xHYtXwy9+v20XtbFot4W1j/dCHjG9OqShGshSAsoFyPhZokNCyNSTeJr7byB3S
 qmJEysoC/UuGs1YDFv+9R9L48++FcJsTEEgANfVBCM9OmuP9M4eg//owg6EfOlCbi6MQ0
 u2eOyySOmLBebHRObM8HifBo6odOYqemm4+4dVDcBcOYa4JmZR34Bzj89aZRmitteM04u
 DozrWIU6cn587x9F0oNUVZ/WfeaCkaxbJL2H0kN98NjuWGShw5+0+WLEys46RTb6hZJUk
 PO9YOoK/aittc7llSbdVMFl6PGSNFiJDuzFHASVPGVtMEIN4HM8mMhsc6JXxjav85VA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=LK0+Xbp9; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LK0+Xbp9
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A9EAF40A59
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:54:10 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5b8997bc6e6so223009e87.1
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788987248; x=1789592048;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YcNpdGNQ+S3Y4v26J+qz1Dg/+v9x9NRSqGLauZ6bfIA=;
 b=LK0+Xbp9c5fk/PPUbAmhZB5wpLkOzGDWgjeTc106y1uG5e5Rw2fuj/PVru365PDKMv
 1+py399PxbZEIm608+cBaKjPRtspaS9WV9qSyzmQh3oLd9MSWiUfECJlP8ADGze0nM5n
 f84nNM2s+zgC6YP+OzSnoT740HjnX4xuUbWIJNmoLJ/c8aGTCp8U+0m7vTRgUJVM/dF8
 nKtRavqsBOXhgML5FRnWZwi5M2B2UnntXzQ+uNtlDDRkCx9HDY+m1Z+koyMn+mHYQKvT
 JcdU87x3ck3Yx/t1mwqH8CuN1mKk6EMvCi2qd7kQrFZ4dU3m5d3LFxigr8V/xq0mXvbG
 JIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788987248; x=1789592048;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YcNpdGNQ+S3Y4v26J+qz1Dg/+v9x9NRSqGLauZ6bfIA=;
 b=lR19YxJvZIcYZiVs4S7tklj3ykHftGaOiWPGNFghdNlphNqdX/DcAielwtlsqrjUFn
 j6gGbi79TKUL2VUET0WpSm0v3SoUAKKNOWsnP0tMWr8p/4HVXTTLp0kH7SsPkhlnEN9H
 zt4PjkYh/ceFt3bcF47Zx8Zw0oHdSCBTw+c6ZJGkXz0GXI0YGcisCeX89c8cIKe8dpJA
 +TPYgWVb0jkjNx1Z4akrmQqoiEq3eZXGOrwgsswqHfevnxkdFvqhyyn+fmQ5ltoGUra7
 nsx9TYWnmp7ERFsvrso/hQK4ehVLcrS1RpNlPBP2gwG2jTBbslPdPPQlAa8NJJGAzbg8
 DFQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxG2mvJ4r1rb8fZiUEDu+Sd6WMyx9YDYX3+fzO1Jb5aCefquCSkwdRO7w13cIBu0HfI8IjTFc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lmWL3niKNsL9/qr4Rsiw8jRlN3xBEgVkfhZFULEzeCEGj4fjNG
 bHDjQyGBI5zsmzg0hOmYIDq5ULY+5aOHZ7mJi2uCXIpyUvFf9kEAUF8F2uIcxeZ7HXc=
X-Gm-Gg: AYBFou0AVDDZtr3ylSASUQPMrxrymOA9QkjgNT0BAPoY0J/ik/7sGMZk9AD94WkFGcz
 362oloL9YW7mIInTGdbHkKjxMKTCuuCAfdNWFMRGHofb8Nf70xN2GjU40NhpE0lFHlTDvYWURu7
 qgwnOQDkoF02xObPzr1EtpB5gtVFv0f7zCxes9syHyaCbzTQGXUbkrnf4epR9QDgdQAimULX2kD
 rLf/WVEy5q9OX3CtVD6UiINQCqzu20s/zm4yyebf8xg2osFMdL+sDOOeFWS2ntvBWiDI8UzpXLG
 MmwXudETzvtQf28M7H/pM54t8UPfNxQ3wGIMjEZZio6wKoPVyxMzmph2CHVBhXo3vTSN+gdgERb
 l2NeCXp948zMxvOAXxTXHItoJglHihMZz3dr3dzJVqRbeBCdR+xeBY5RbmPuDYylZQbrFIQaCGa
 34Bbnvd18MdN3uuYMukGAn7SFPwOq1mZP1IvxUiIH6h2mPPJCmrD1MIzOCwTCtmU/yArDsC5Zf7
 ASAIu6vcGUx52fAK7jxefGRyKXOtCtB+9xFx5VYDNcZVEwHACsO1hB4qw==
X-Received: by 2002:a05:6512:3d9f:b0:5b6:172b:7ba1 with SMTP id
 2adb3069b0e04-5b89a2e997bmr200133e87.9.1788987248381; 
 Wed, 09 Sep 2026 13:54:08 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166f6c98sm3954819e87.37.2026.09.09.13.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 13:54:07 -0700 (PDT)
Date: Wed, 9 Sep 2026 22:54:05 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>
Subject: Re: [PATCH v6 6/6] doc: board: mediatek: document Genio 510 and 700
 SPL boot
Message-ID: <aqHGk-XC59Ddhcl-@macbook>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
 <20260906-ccaione-upstream-mt8390-spl-v6-6-4d4a11d5741d@baylibre.com>
 <f12ef161-582c-458d-b49d-974ab55e7788@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f12ef161-582c-458d-b49d-974ab55e7788@baylibre.com>
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

On Wed, Sep 09, 2026 at 14:56:02 +0100, David Lechner wrote:
> On 9/6/26 10:30 AM, Carlo Caione wrote:
> > Document the common Genio 510 and Genio 700 eMMC boot chain,
> > board-specific external firmware prerequisites, binman build invocation
> > and generated images.
> > 
> 
> ...
> 
> > +DDR-loader handoff contract
> > +---------------------------
> > +
> > +The DDR loader and U-Boot SPL have no parameter-block or firmware-call
> > +interface. Their contract consists of a fixed image layout, initialized DRAM
> > +and the execution state at the SPL entry point. Different DDR-loader
> > +implementations may be used as long as they satisfy this contract for the
> > +selected board. The BootROM loads the eMMC boot0 payload to
> > +``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``::
> > +
> > +   offset 0                                     +----------------------+
> > +                                                | DDR loader           |
> > +                                                |                      |
> > +   offset CONFIG_MTK_GENIO_DDR_LOADER_SIZE      +----------------------+
> > +                                                | U-Boot SPL           |
> > +                                                | CONFIG_SPL_MAX_SIZE  |
> > +   image end                                    +----------------------+
> > +
> > +The DDR loader then performs the following handoff::
> > +
> > +   initialize and train DRAM
> > +
> > +   copy:
> > +     source      = CONFIG_MTK_GENIO_BROM_LOAD_ADDR
> > +                   + CONFIG_MTK_GENIO_DDR_LOADER_SIZE
> > +     destination = CONFIG_SPL_TEXT_BASE
> > +     size        = CONFIG_SPL_MAX_SIZE
> 
> Do CONFIG_MTK_GENIO_DDR_LOADER_SIZE and CONFIG_SPL_MAX_SIZE need to be the
> same or just CONFIG_SPL_MAX_SIZE >= CONFIG_MTK_GENIO_DDR_LOADER_SIZE?

They refer to two different things: CONFIG_MTK_GENIO_DDR_LOADER_SIZE
reserves space for the DDR loader while CONFIG_MTK_GENIO_DDR_LOADER_SIZE
is the size of the following SPL region which the loader copies to DRAM.

--
Carlo Caione
