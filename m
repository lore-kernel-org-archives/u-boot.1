Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9C8CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 14:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32E7B80DC1;
	Tue,  6 Oct 2026 14:33:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vtQuep14IbvL; Tue,  6 Oct 2026 14:33:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5C57880DBC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297205;
	b=VzXZLvWESXg5BRWjKI5UlO2v0dw5ZbYRh0OE2vnK4fjDKWcHeUef89qOYBQShU0fEKa8
	 cyRYGR9i6ukpbuMElNxZXKcAzIliQoGQv5rhM5LAoMoiDk1P8nbcoqN3OJk4bYdkiJrCI
	 r+tWe7V5hwJrqZnMr6Y8TfOcQWgWEU0HbTVvevpgNBmwo+50MGlhiQ0xAfvqh0wn/9PaS
	 sztZyLBBYphcHgLhpaNmce/ybth95jDMJ+tPaIm4ddNz/IXlStyCq72lyyoTxvKSjlKXb
	 1wotzAHZp/1+okLBtyYjqAohPupOr2mA038vL94yW6Dr/Ibhmg8TIXH6qJRmDes1Hiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NdgbdaG3ec4hZZ9mcoVejkOlz7SNzZEoiWA/98De9Gg=;
	b=fCrKlRKSDNNUABdr+Yjde7i8TkYAa+3w7CvA9+euTBB2s8+PXOAUeIb/XRVBNKbg/8CV
	 OQH/NHvVyAeqhnEk+8/S/x4Q4VR5dfJ4Hfl5HDYB/3NmYBxW+Hr39wzfgX+6BV97CysHG
	 v7p7VPSfGnAJEwOVdhkWjPW4pg1B58Ghua/Fgwwryoq1ggNipZp14HCEL0Shz+i4sWx+3
	 ygAU3zcue4LimeVu+Oh6jNZa3V+KojtD1JpwhSLo/1brfrsFisz5xCjm8lvyVUTnVPylZ
	 iu4zEH6nFgQ++Q0zm31wXszbE2zPwWmsxraFpSSAKVc9smzVHDhC2Hlp+TBVOQHdk3Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791297205;
	bh=NdgbdaG3ec4hZZ9mcoVejkOlz7SNzZEoiWA/98De9Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=glGm0d83KSpW1hAm4P1s8K9iIJ+hUrXsK/tRorfOrDQP8/aYVHGzZsrjpcMmDKr6d
	 p7bvw7++pKVwZrbNaBgSKkul24xFGX3yPd5SE7Nik7T6PtBnnpppw+WrFoFM46aeKD
	 M7jbYcQqALLexhecTVMj6DfhOusjrvMBwxhu5EtpE4M8zLUvQEXNR38YJOuFqg5R9p
	 SroDghonyaiHfXs3+7Zh1+T1z9//USGlrE3S8ycYEuZqryxNCywNEuscEwffjdTn2D
	 87lRJFfu/AYlFr3huMwBAL84mHgqQ6DChA84HtdT/+/vG+LCck54C3VOE5CP259rrt
	 RV/jcVymnq/IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C57880DBC;
	Tue,  6 Oct 2026 14:33:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D4CBD341
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 14:28:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4F67607D3
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 14:28:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SOQFtcmLXYtM for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 14:28:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1F9CF607CA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791296885;
 b=Hq3AvsXmcyLEIpGqoLeymnd/2r0adH8fLSIumd9mlkwu690q6YIhGTJl3Zj3myyOXmwA
 cQ5gDsQlopmmUYQRCeX3t82dfVpupy7bVuCGwd7I+6YWAguUVVAB/cGuaZ9ZNjDh2qt3e
 kkd4fdOcG77o+3635KwI81t/BzjAmhO+C6/0L/0GBPZday3yuswykk1o7qW85TWnIRVHI
 T2BiuGCj2qtSMzZ6lAzaBBIaG+7dsuOqmj0/wSQzZJqO6V6gBxOxrApAVBM7VI+I2rnSU
 K/o2wcuQX3WWjE6I6GiZC32n92Bn8vTB7DhpFspRlbVAkOdhGk06uHrCo7uVpeKUpEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791296885;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=NdgbdaG3ec4hZZ9mcoVejkOlz7SNzZEoiWA/98De9Gg=;
 b=aGwzZZItrHfMR0KxozIC6Jzxpo7EmYbAVkITEGHvyBYb4AoOvwqh+qZLl/3/JFkvh4/x
 cUYXBweuzDtAcY7pwb9dbCnDJoyqAu0ZET96DeJgvANWB24DzueOaIiycOFlkJRxfEF5+
 okHaBazjEUcdgAj8VIEUmcgE0b29YhrfqtaxxJzGEfHM6o4DxWurUL4uw+WX+mio4SyZ7
 Z0Us7YArs5OIZwO29W8P/rvZwd2tlS7pw1FM02YFqn136IsKYy4sgd/2bKxPA6tBys6Vh
 Udi20fAspJvfWaHiHhJMRc7onSOW4HukulmYbVrCVkDrnC54TpfUCTsZdVJGtD2Nx+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mqaZd0gd; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mqaZd0gd
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F9CF607CA
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 14:28:03 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48b0ef9c76eso2648279f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791296881; x=1791901681;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NdgbdaG3ec4hZZ9mcoVejkOlz7SNzZEoiWA/98De9Gg=;
 b=mqaZd0gdjeIzCzvrAAJm4I+BvK6a/1J3rTj4VWt5GXsM9IKHtjYkuREh3UbHzrmED3
 hdsTkUlPv5+Zeud1V81GMornyAQmNt2/vSqwbdjYlqJnkEZ/pcm7+y0wnLKzBE6T07kH
 ISBdmea9VU4GvxvnYnJK97qYVbl/93eWcfcpIA6zNjhGg2x6AWC1mRjAbcLT9Iotpbf+
 pVaIdlm80/Y28KxHqJpGegvMp8K1GjpojtfPU5dk63AyVr9DYfvcwq62ATAdpmkACpN8
 qYYGPhBLGo07rv3RZdTETRSmtHYot4bAKj2xnexwnk+LBWK5WrO8+2YETWpFJS50vlvW
 9EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791296881; x=1791901681;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NdgbdaG3ec4hZZ9mcoVejkOlz7SNzZEoiWA/98De9Gg=;
 b=bq2ZHJit3cg44n2jrTuOfkQqT9tEyAXQepaQmPYKg8w3ir7mhvf1XNPhjq+PeyugZc
 qPmLoIKgKoxsesTZe/jdug3M+fxWay4hSobF1xmNtUA4TvxhxGKH/eeMr3MPUV9Fw2wD
 6cBoOOBKNpbTZTzsI3mhSYJpk98mKwyz9+2ovD+IL3U58Z/Bs9NyRGLM2mFUT4BZGduX
 Pn6IctjWE5hPFlaYSMw0A9L5AqdgOmMOHTovkUOTI0mkCkGgLi3dKGvakfE5b8bb63I/
 M9B+ljLRXvvMH5iZR8tQCCX0sJeN1/0mRcVduryHCv6akWbH5MojMHWH/fxxTrQ2Ujw5
 WGMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwb47T3qnNKIdfmhlpWFD6V+GB7x5w1W/YXoDJn33zCacHjoe+JqJp+ip7rlhbZa/ZWe3PWMv4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIodkq9KLDMCqVmeqHgt9fGQOantyEASn9vSghmiGZdwygUkGU/
 0ThPuUl8BQQj3m2QT+2wZnMlf77P2FIIQMNOQGzdPvtxp0rPV7M1RdMJCPADxJ3uLAY=
X-Gm-Gg: AYBFou27v8IMPm5UZ+xqnCuNvQw7+6JEavxI6jkrvfDIQ8GQKNqyEBKfKjUGdm20v9p
 9HzkSeqJvJiyW/u64Im7gNkXLMX8OOuWtgMAoG2CCJ1NLPsZapmh584sXV/0U7DPvCfm/EvPsYO
 ivyj5BVKA3OAOUNVuYbEX4HOWBMfbFstK2YD1S5xhCumMDfVpI9/fWMhtPeNhzJ9re4/Rh/N8OV
 xwt1r0XinTiGZ2RknOBhfaUhHvAYQN/3zbL64nawIUgoN5D/Y2O1D4SwXDS5+/S270+fiiR5aQe
 qh8LH3WdF9M5iHCaAcdWrjT7NeNrboh/4sTqzabXTXj87svA6Z7Dz7CgSnM+D/az5x0lbK2PfzZ
 zCzKfiidZ0+HiW+wMZPWCq8zNfz1+/EN1eTcdlVHeSpEcHNFodrg53GP2L6JkGSD2SFQvTpDcK0
 Txafm1q7/ZZKucHxX81KrVxwcXsKcI7PXkow8W+Ln4SrFOzUVYN+xo9iKzqVw3BcaoZdhxppIyf
 iY1da+gzEPX5Q0iVALbHPqlKtkN8SZe3P8ZwAasZ39Wb6XRkXghQ0k=
X-Received: by 2002:a5d:6f01:0:b0:48b:11df:c496 with SMTP id
 ffacd0b85a97d-48c47fdedd3mr17565810f8f.28.1791296880964; 
 Tue, 06 Oct 2026 07:28:00 -0700 (PDT)
Received: from macbook (host-79-45-166-197.retail.telecomitalia.it.
 [79.45.166.197]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c63f6434esm10234962f8f.22.2026.10.06.07.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 07:28:00 -0700 (PDT)
Date: Tue, 6 Oct 2026 16:27:58 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>
Subject: Re: [PATCH v3 2/4] arm: mediatek: enable SPL fastboot DAs on Genio
 510 and 700
Message-ID: <asUFMBMogDmO8Lf6@macbook>
References: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
 <20260930-ccaione-upstream-mt8390-da-v3-2-ae6091c7eda0@baylibre.com>
 <b8e3b2c2-6eb0-4d16-821d-9e39492ad2ef@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8e3b2c2-6eb0-4d16-821d-9e39492ad2ef@baylibre.com>
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

On Mon, Oct 05, 2026 at 18:05:54 +0100, David Lechner wrote:
> On 9/30/26 7:51 AM, Carlo Caione wrote:
> > From: Julien Masson <jmasson@baylibre.com>
> > 
> > Genio 510 and 700 need a way to provision blank eMMC and recover from
> > unusable boot firmware without relying on the installed bootloader. Add
> > a BootROM-loaded fastboot agent that also prepares the eMMC boot
> > settings so newly flashed firmware can boot.
> > 
> 
> ...
> 
> > diff --git a/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..fb6fadb492f
> > --- /dev/null
> > +++ b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
> > @@ -0,0 +1,16 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> > +/*
> > + * Copyright (c) 2026 BayLibre, SAS.
> > + * Author: Carlo Caione <ccaione@baylibre.com>
> > + */
> > +
> > +&binman {
> > +	da: da {
> > +		filename = "da.bin";
> > +		pad-byte = <0>;
> > +
> > +/* DA authentication is handled by the BootROM download tooling. */
> > +#define MTK_GENIO_SPL_NO_FIT_KEYS
> > +#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
> > +	};
> > +};
> 
> Since the download agent and MTK_GENIO_BOOT_IMAGES are mutually exclusive,
> could the loader dtsi just check !defined(CONFIG_MTK_BROM_DOWNLOAD_AGENT)
> instead of a private MTK_GENIO_SPL_NO_FIT_KEYS define?

Good idea.

> > diff --git a/arch/arm/mach-mediatek/download_agent.c b/arch/arm/mach-mediatek/download_agent.c
> > new file mode 100644
> > index 00000000000..e73b6a6b161
> > --- /dev/null
> > +++ b/arch/arm/mach-mediatek/download_agent.c
> > @@ -0,0 +1,69 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2026 BayLibre, SAS.
> > + * Author: Julien Masson <jmasson@baylibre.com>
> > + */
> > +
> > +#include <dm/uclass.h>
> > +#include <fastboot.h>
> > +#include <mmc.h>
> > +#include <stdio.h>
> > +#include <linux/errno.h>
> 
> Also spl.h for spl_board_init() and init.h for board_late_init().

Ok.

I'm going to push a V4 right away because I'm adding one new commit on
top of this series for an important fix.

Cheers,

--
Carlo Caione
