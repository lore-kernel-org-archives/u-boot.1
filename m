Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295F2606A33F
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cL5ZTQNP;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=euRHq7+r
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 094C681053;
	Tue,  3 Nov 2026 16:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-uZ1cq3sPCz; Tue,  3 Nov 2026 16:50:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3D0B880E34
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793724655;
	b=iknrkC/ZFH797c1o3155fnheJqD9JbOC+SwwjQ0djSUKWWqR3Tc0Gf2StkPLlQ+0zfxq
	 vZBA/DhfuYDidAHaFDAdgQ/5lQ7kE0unnKaP0qkSn/XlxJpqRvckudsy2JQr7euWI6VlP
	 LcW9rgO383TlBqP0YWBIJtHn+p6MK0t0ThXRQF0o7SAHN+kzBtEjomOSIODXjF2JRDpzh
	 3bIYjk/d+1faCcjXv/2oUfVMcqC1aWT1l1Lp+/oB3gpbKtI/tt9uU4hQNIT/osZN+oygD
	 4idJP+VCoThPBxhilk5zVKg17p4Kk7IDE6iVhovZgl9ILidjQNZvnRwYKX39iNhnlpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793724655;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S61wdyt2MSYB+Q0g3jesQekcZ9UhXoXvbZe6Z/oT1eU=;
	b=UTt+fwwBD+rkFZMsjs0y4pavqztndDvi9k7SIXJI91fXFwfyD8DVfA0fH8KCku0nQcvO
	 o8ZvfBYZXbR+UXzR26dqBT7HEve3MunKikVmFmUGENqXK8QgBgH1uHDe9dEEQrHl0SBP5
	 yK6TgdnvawEpq+/VkfcsI3e9iC/qs/Vf2aUhTXSrK73N4sH6uoPOUdKFU+BUvet00EaFd
	 DiRv3qQbNApMWnwlFD0g32AQiugGoT16Fn/H1+r2bQetF/rqR94XM+XEeIBScch978lhm
	 Q+AZTDfjUrFYFwL5Ic1s0J+omRkFk4s2THeEY1pjysHsw+8jrXooFUUq5l0Cs5m3LMg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793724655;
	bh=S61wdyt2MSYB+Q0g3jesQekcZ9UhXoXvbZe6Z/oT1eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cL5ZTQNP29Fv2HpDj4LDhfUpzgXn+2UQ8K0SvYPWFNH5TsXg90MndjcMqNxNvIKTg
	 HcwN0/0ttgifUn+yQbf4CrcQ7Urxg5H4DO6YfGrRWiUrM0rouy2HOe5cr1ZA1Ec4LY
	 awS0cDsZE9gDJdK7rkWx9LrBklMfcXmTK53DdHesq8+4ygFf8HGrlqpQhU5JN8KdqY
	 /W8tAn2lOC96FyTLgCStmU8dMkSG3WLToPaBWKao6KW0RC0682NiBUHTF4x+ns5NDb
	 smF5ezunv5U2xRHBqfRDIcPvaFgBB8EvgSEkMz0VeT24pmOjkCFe/yDiZ9WuK6CgU5
	 TyZ0jvLxGoe+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D0B880E34;
	Tue,  3 Nov 2026 16:50:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 46B234BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BCA0606D9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8DVGNDcC9Siy for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:50:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9EB72605B5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793724653;
 b=ceJdhl/Um09AfHVki6h5N7oeve5qvOThTYvWnL5qoXACCW19MxccrjMMqKXPxJZMoVA/
 JUOZ++hCby4xjq1kiHzXaDSC4xrIfls75LOYXdQ/OB8WG5WK930GCjXVpEv7UyWa30zEC
 nGR2514tbJ0HgE6GtGFvxe9hwNwpUdNbM5nvXUrXoZqMi+QlN2Pqxbpsk5IYewG8Bxlol
 E2u6tENztqmtiQ2nQPz+DEqhQ1TzJ8ikWIr3pu3BXvHfz9eFKeShcj9M4xcuAMrf+7/AL
 LRjqCLcICf2nQr1ov/LCTbjAAAaqYlKiTqxYhUUWDjaq3+pCdUjidjimI09xPAUPAyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793724653;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=S61wdyt2MSYB+Q0g3jesQekcZ9UhXoXvbZe6Z/oT1eU=;
 b=gzGy5lgq42heIG7hWs1pKkmIM7p+W2jgFRZsPKUd6qJiipP663qXZq+LE5xx+BRv76lK
 gUjCT3MkhpHOi4Yyvd9kVXghQiGmtaejzR84h2Iyw/MIQsIh9twYP1ansNfJTDBBNqpY7
 vQ2QUQ4L0LH9bwdrlDiwkRgcIi7TyT3c4ftF/4alR2/bkBvfiL+xxvrXz/3JDl8uP2IKQ
 PiCl44rDXmDoiZcqOfn/4OFZgbAzcgm9TAcHOAWZQBHAopHK1t29ownaNaVzt0IyLB/CW
 efkj5CiLrrDCrnV2wRu3t31KtVOVcR4OxIKzM64faIrac9KqcuJbDwSurvbwBJxnRgA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=euRHq7+r; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=euRHq7+r
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9EB72605B5
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:51 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so44765895e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793724649; x=1794329449;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S61wdyt2MSYB+Q0g3jesQekcZ9UhXoXvbZe6Z/oT1eU=;
 b=euRHq7+rMH7SZ0hAOez//XlZxSBT+X2hscs8L0wrfJntSDRoRlz8uTJIEk+Ukcu8V6
 atRrNNL/9EI3yI9I0VY3SjwdJEEL2qnteYneLYua1RBuUf7xg/5VSDeMDIn1BuBWKHlt
 CvBxpCBZizb7dRg2wqs60xHdRKcwCxwp2vGTzkQNhFCH3/umfeuPUfcTKRxWFYejO8KT
 0LYSvrq3psFkqpbIq6LnS+pSgtLqeXdNES1UgGUVEcHsOfiHLn9F4vrd8aQZZDdhjSrA
 SMVJQY2AcAI8Q9ja40QMuvXAzsNoc6BN4S0lrCH+xuYhCkfuWoCSRAPeiUWPqFo5B/DN
 yPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724649; x=1794329449;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S61wdyt2MSYB+Q0g3jesQekcZ9UhXoXvbZe6Z/oT1eU=;
 b=hRPaCrcCwl2rN9jhEIKDytbev13j50RNo6Xx4srf6qKHRhbVoDzINVNV0iYg0u1h1y
 MnWmCBKDgrrFGxZWBcxy/y8yrG1eQ5vKopaCn9wJ+AqLIbtNo46nHqXlPEKYz+WXjpt5
 +5JKYx2FKy5SPhmWzDhqgO50L/L2q/DIsdGh6MhvbRviJ/lBTMeK0PhrhjsQxh2u3Lbn
 prkIK/pSWKoTdHKeGyHQsmEYlQ/onHT6BAC4ryuxWx+ehWl6yEwXFOCKgkQ4bL227lnt
 fAbnQ2S+qq6ViOqe9duRqQ3f2BWW9Q6J8xCPhw6KubEaeeaPFfzIe6nSD2Xqg223SEQ8
 jldA==
X-Gm-Message-State: APuU4Z+0A3F+jxCXXOFPl5CD+3lpt0UXskisOp8P6LgTa/KC46RkmVMF
 Xar8vQac8GbuqHNaTSzgR4Cf8LILkdjlmoHCZKhMzu9fWFTceMkPTy4am2Rp6hZzOZE=
X-Gm-Gg: AYBFou3zB80W3XeubZbmTKIS419IuheNIiqUUjh3E1xu64BzEnQYa1LkJtH8hFRAxYA
 CACDT1rwf3Hg8zpOOD4Z/0suYF7mo5t3bIMW4we1dFN+EmJHBm+F0aGChNv82T3tZh9fsP5zyxX
 vdJZYijAFd9iuSFoOq06ohDfLq0tub1rUgwOGCXJlXQHL/eIpGuidqx1pb/4zyPmRzIQfVlwvnP
 hEZnfZK9EI7EKtnQRWUak5a/DkLi9kMP3PPGUz+oI5sNI+vlwMKtcxAt0eW7CGn5BZ4dcoS7efG
 8gZrcXHXiRA7Z5AsDsmh2D4qWVI2wOpMdVgZw2PMXq54AX6BKqD4eXHKGpTX6JDxPJAu7SXVfp3
 gDJbKcWzJ/2DFX0dPWA39cwLncxpJ8dwbLcPQITH7conD09SNUdQTd0H3hO5JVNwXNIotrL5FgM
 ZDPNw3JfPcyDf6qFEAN8NwilxsBhntguvqnzRB8ikItpEwlPnb9ThoHCWw20ZKCXjccjWBTiQpM
 M829yU+kcVkH4Rp161g85uuZaUMYaPsYjgjAhO9OXD3AWqJKFIXRZQAqFZNN4ApyqrCYi2gI9id
 purT86m7OygAPa9ZZBIgWS5T4z4Ubd9WLbMr9QJTOOdmusje++uxb/aLyqQrSnedS7g+vuvnOh2
 +0Dg=
X-Received: by 2002:a05:600c:4752:b0:4a1:9661:14b5 with SMTP id
 5b1f17b1804b1-4ac18e5d4d0mr331016985e9.29.1793724649087; 
 Tue, 03 Nov 2026 08:50:49 -0800 (PST)
Received: from macbook (net-93-150-243-29.cust.dsl.teletu.it. [93.150.243.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b81c74sm25983436f8f.36.2026.11.03.08.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:50:48 -0800 (PST)
Date: Tue, 3 Nov 2026 17:50:46 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 York Sun <york.sun@nxp.com>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Day <me@samcday.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Alexey Charkov <alchark@flipper.net>, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/6] spl: fit: reject failures loading an explicitly
 requested FDT
Message-ID: <auoNQw4AW5xbCpqL@macbook>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <20261014-ccaione-upstream-spl-fastboot-boot-v1-1-d29df15fb9b8@baylibre.com>
 <179370057186.349126.13750066367082256700.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179370057186.349126.13750066367082256700.b4-review@b4>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 11:09:31 +0100, Mattijs Korpershoek wrote:
> Hi Carlo,
> 
> Thank you for the patch.
> 
> > A U-Boot image may embed its device tree, but a FIT which explicitly
> > names an FDT must not boot after that FDT fails to load or verify.
> > External FDT data is copied to its load address before verification,
> > so ignoring the error can leave an unverified device tree for U-Boot.
> > 
> > Keep support for U-Boot images without a separate FDT, but reject
> > failures for an explicitly requested FDT in both firmware and loadables.
> > 
> > Fixes: d879616e9e64 ("spl: fit: simplify logic for FDT loading for non-OS boots")
> > Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> >
> > diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > index 64e5f95546f1..a520db765065 100644
> > --- a/common/spl/spl_fit.c
> > +++ b/common/spl/spl_fit.c
> > @@ -491,11 +491,14 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
> >  	image_info.load_addr = ALIGN(spl_image->load_addr + spl_image->size, 8);
> >  
> >  	/* Figure out which device tree the board wants to use */
> > +	spl_image->fdt_addr = NULL;
> 
> What's the point of initializing fdt_addr to NULL here?
> It's assigned in both cases (whether node < 0 or not).

We actually have a way out if (node < 0) and (!gd->fdt_blob) and the
problematic path is that early return.

The problem starts in spl_load_simple_fit() where image_info is not
zero-initialized so ->fdt_addr is basically garbage. 

When we return early this garbage is copied into spl_image->fdt_addr.

Even zero-initializing the passed struct doesn't fully solve the issue
because the helper also receives the main spl_image, which is reused
across boot attempts and can contain a stale FDT pointer.

So, setting fdt_addr to NULL is the quickest fix for all the cases.

--
Carlo Caione
