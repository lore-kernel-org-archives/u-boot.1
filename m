Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D54CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDA0E80E5E;
	Mon, 28 Sep 2026 15:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Ii3hOi_rOhW; Mon, 28 Sep 2026 15:12:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 19FE980E75
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608376;
	b=hMz1nYM4IFWQ196ALHWujhhNzX7FQ2M6uP1nmOJvthrh8git1UhLH1hFQbB10RoyHNhL
	 B26o2wlwol6yDOVzTCrX2cqIqwvzcNtqNbudtul89rKHYZwhrKU/XUx295zCe8VNV0tj3
	 424hFIzTxOyh0VC9N4Mif+AVUmHhTd7iPSioC+v72lNlf5qvRlSgJJNBIykAPOMFWWnwg
	 y/94lJOltj/2arQFexzcXo15g2FZvX0kaUatZorTOnQN7F2UGPEymMOjY7HKSaRIfmO5K
	 neIJDNzQKkQH7jZW2zKQaDCYFGmE1ub087lw1Ifa7FwPfivjYlRH32ct895/cnYH/lw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608376;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=noBXdB3CYgXq2f/E4obmms6knYOWOTRNtYH2URQusxY=;
	b=brd9P78/eO4RcbBPncgYOUoT/FzBTecBTfRMHbTBH7TeRijWuqedCuOYx3B7xT17uwEf
	 hpavZpJN6WyGmlgR3VW6yMNZ4bypRXIHObtwP/lsa69mOwhT8YS471YBhCJQNI0Ow3j3T
	 vrmt312kKBILP6MyyS+iMq6qSrwSj1/cPsyNDpUWI9+HcAEAZbdA/LyjqLDE4f4eETROY
	 wEiJ3ona8ac5kH+LAO+b8Qt8GW3c+H9uxKiKjviAa0qHN6n+3ACwS2bXaBkFEljMXOll0
	 K70txE6DtwkhkbGJtpjHES+pSaLVqCf4cz4WESX6sjPEYpA/YLJNeZBoSDY8RIHIPmA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608376;
	bh=noBXdB3CYgXq2f/E4obmms6knYOWOTRNtYH2URQusxY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RzAQJRwK85hSARcKzbag8nyLLVa6pfqk55/etoSQi9afYYI0gJI/DeFsp3jra7twT
	 rSDGeUyjp5JcGvsO0REOpm+ECB7uJUQ03LfKVJt/NO3QgxHPCh7VkfJUNVW8X5Ppxn
	 Q2ot5Fdxe0YGg8pqyQw9CVJVKcwp//zCcPTzz3GHi3qd457DjgsLTn/ZZTNrbmr9vn
	 plQNc+h+gtGPDcD2BTBtnzLU0m7gums/mDYHUk2YOZ3qx8QglJ4MV8t9HAMfpCn7TQ
	 gWGKKgab/U36+yFHxYxepn2BlpCNjf8JYJCMoDx+UJGOSnHiOaFGHMQwsyp7zUWEgK
	 a4Gq9RHmhlhfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19FE980E75;
	Mon, 28 Sep 2026 15:12:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C384C3A0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9349606C2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WduvHF9M2lIj for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:12:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B53A4606CC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608374;
 b=UNTUvr62/hteAko/xHVQn1ESwjEUPiUoWgl/o0zl2B/dw2rqLefyPX6LNco4gEjl5Pg/
 qb01J1J/Lt4Sk/74jUKWokeWPolVYbSjMozk4FSuDCM4MRz9iEYPBaqfrVNpdBjuDwHSB
 NdRFGY48sXKT7IwDHBMLTO4QXQFoyIVDJ0cqQ1WXcdnFHCK8DRXuaRxOerKt5SIVSxCsE
 ce727NEsqnTgtWCpcGfR1Nj44m2pvGAeObhtCoDcyFQKIg5/kXfVq/iWUoiOxKDKwc4e5
 WcXv7q0zu1KQscbbu9uzOxyvdT2hyYI1N4EVFVLESM0DiwzVke2BW3tJlQKLFDp4YIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608374;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=noBXdB3CYgXq2f/E4obmms6knYOWOTRNtYH2URQusxY=;
 b=FYyx1IQ/EQ5VpuqB0iX4UxtNXceYy1EPJjNkAF5geIDdJ6mF4RD7Lim+yr/5pFtXhdny
 bVzVCs5MXKpfACWN1Yvl4BNnJ2OLllcSz9/LYR/+XaLhTK26ORWzqUA0hcNj75/x+vbpu
 oqYk6fQ4LJBr7llsSIUCXc1soFAs1N/z448qOad3A1K9RvY7+e5ELReEH1WqPteTZlcU1
 sjoFEDuscbho6H8w+IP/n+mJBjuNDmu5NZeHHWi77VEk7NSKTEnFLCA3gQCPYUXg9X5FE
 SRqhHVmLvMCdVJ3dkxni8cK3T5jLW6DY5QSrFM6wDqCJkWS3E68MNQnJ6+JEe30cxUg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RFsxvi4P; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=RFsxvi4P
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B53A4606CC
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:12:53 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6abe19c4262so2238116a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608371; cv=none;
 d=google.com; s=arc-20260327;
 b=Lld6UyUnqkXlAW6eLLHMExO0WwF9E8g3dCbXiXWzVA80xoqsTW0cvYiCOf4eHppasR
 Cf1t5OFlvunb0OSJk9KieCCyzK/HSMr9crXnOwAkR0qliK4RZ52AgiJyjddxfC1e0xlw
 SUFOuYKvIOCJRFVQ1y2y7j/O66wfTy9bjDubJtDb4NP8YvyDOsPqCA5MQba59kgRUDH4
 xsVkX/QFe9+SVnPyTZYWaGq0GtqcdzoLv0ITbnKKCjWoIpTlJ66V/kTBRxM8Rc6qsXlz
 Xu+D4ZPxiK9/LIAZoX6bgkT8Gd6KkDLr5nBLoTKxA0DOtTrOSDxw2czwgIQjst53YmZl
 vtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=noBXdB3CYgXq2f/E4obmms6knYOWOTRNtYH2URQusxY=;
 fh=7Z5pCYEK0li0Ul9uQaF5cUgWUuYTSV8CbmC3PFKHU/o=;
 b=QDSoTu8SrxQhm+G8HjQLWrh4ifbCM4WPSAt8NvzUYHdjCES2MxS77Qem+HbM4xLYLA
 NK08/IiJCQK18IxyBREKtOC9yca5Iz5TI/DVBh5Bd9B09uXld+cGKviJiGh5Ryp0bMnh
 cz3QAjDS3tJXFrXQqR+4jxcLwFII+YQjKwRxmxl1o4hsYP4Bku09QuxR9eYXoL+ZwEkK
 WZRGfZK3QvGnns3QfU+tUA4oRAUhvR9h60hZGHa828QSBhLy0VgNnGgz/YICfiI98eCj
 hFCEHjiNzjjr1JgfGl3/1i7Mkctr3oOlZd6S+EiKJRr0ryYJU+Pvs3pzpX5lgQoRIiIB
 1NXQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608371; x=1791213171;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=noBXdB3CYgXq2f/E4obmms6knYOWOTRNtYH2URQusxY=;
 b=RFsxvi4PHiIBEEHHsmo4h6lSOI2UAgqtE/c6umrqxy6At8C2judvLd8ds6HY8YqEoz
 0oLJau/kt/05ntZ6w/4PKuHP6CCXbYtBGpONxi0/DmEWgcSCFrSEFtTg8EZfmXJoIB8N
 Diwy1QkXdKiP4r3erb8gGnyZd12iHku73LP0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608371; x=1791213171;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=noBXdB3CYgXq2f/E4obmms6knYOWOTRNtYH2URQusxY=;
 b=EmbnmvyDxbara6HLHmubUJrpznbOncXVRD+GwtfMHmf4SH/VqHaxxLYabWYkSbFZPz
 Do6UuefB0/RdCdJO1UWrL1kpSO36ce1vzypIygSR23wYMCMFaty6rLMD3zQqQJbXSk/6
 /32yaLpaORZuDBTTjBjUXZXn6GV8lCnCp3+XzNTioHRRCI3yUI59vgaTai4imXCxQNot
 pUEVEdiKB8OwqeY3IbJ8nydOrTQR+r9ZB/L3lF4F+xGlu7rvMhS81ltYBA8+zpoghuIS
 a7uhKbPqiSOy5b/Aag5Ukhg7meb1xXQtQEREfmbRgfJtJcJX7OIjZ0Rkur2fC5riQ89U
 HBIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDp3ued7ITKqJ+cxbMz0cpG+HWae31bsWjNSZd1F607o04j5PikvUIAE4F4zV60D2Tn0FYSek=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLKvAwQko4K/MneIBFCHu7V3LadnQ34NWaJd4maUzDn6ud7KZpg
 XzyYvN3njxfDBEIzUI+MkcGjrw49mtyFwZzNKzH9oiniqXe+sKGpoenz34L1m+mkz+oNnOeCsGj
 ym3vuPHEuMM++3/83+bgv5TQ11QotoiP5OxiCg0Xc
X-Gm-Gg: AYBFou3AbM4xj51Rsy8AcA+tHH1bftM2LvnLx9Y5koBJKOIkUCzFYodZvj98DE354wh
 4o3uS4NmyGntvSgxV9srY+6dRsIdNe0dENEe1Zq5x0C/ObbN4bKPCbehaCYypyHk5yRfwHZq1DO
 qZbiZDUoPeWBt5loiANhRFCvRXm+kAr2NRV3BDK26NT4al+t1AjL7+jcGKqrWi/wZgm5wF9O7KH
 DS1FEPnoQc93ARk5LPpqd6QrCFDtiRJ2dip2Z/Aqm3fgmTP5l87kThGWNgYXdaFDQoRlO8T4OFb
 4/js41l9grvbvPepIK21moK7c5bSFSqWYVMVPe3ki4Ve4DrQHHOqLw==
X-Received: by 2002:a05:6402:11d0:b0:6a9:aff5:c6e0 with SMTP id
 4fb4d7f45d1cf-6aac8f07897mr10691402a12.17.1790608371026; Mon, 28 Sep 2026
 08:12:51 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:12:31 -0600
X-Gm-Features: AclHuK-C5I3Fe7xEhsix7XoMYc77VflrSVMybsOcVNVufnXmMov65a87TPHeyYY
Message-ID: <CAFLszTixJ35no917ugrOabofU4t1fRLzY72VhKgPfwyG3TRjpg@mail.gmail.com>
Subject: Re: [PATCH 4/9] mtd: nand: spi: drop the eager ubi_blk binding
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Neil Armstrong <neil.armstrong@linaro.org>,
 Randolph Sapp <rs@ti.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
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

On 2026-08-23T19:12:43, Daniel Golle <daniel@makrotopia.org> wrote:
> mtd: nand: spi: drop the eager ubi_blk binding
>
> spinand_bind() binds a ubi_blk device at bind time. Now that "cmd:
> ubi: create a ubi_blk device when attaching UBI" binds one generically
> when UBI is attached -- with an identical result, only lazily and for
> any flash type -- the SPI-NAND-specific eager call is redundant.
>
> Drop it to avoid the duplicate code path (a ubi_blk is unusable before
> UBI is attached anyway). The mtd_blk binding is kept: bare mtd_blk
> access to SPI-NAND remains available for users who want it.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> drivers/mtd/nand/spi/core.c | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
