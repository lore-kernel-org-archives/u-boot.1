Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FCDEDB7F2
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 10:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7231A83A41;
	Tue,  7 Apr 2026 12:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TTi7WTDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E834F84034; Tue,  7 Apr 2026 12:43:44 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB5358352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 12:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35d932cc948so2835883a91.2
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 03:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775558621; x=1776163421; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B0wG/Z2TOWRDtWhNHfDppOEjfP1XlYkqucCdQha+2j0=;
 b=TTi7WTDc52N1JeBiOX4DZQB/qEqYnOgJif/VyOjjI6SrioqrBeYnDRMXophFiAww8h
 EgtkLPRa8dd6kTZKfQoIn7fG4r8z2/+7jESiLM6G7u68ctTsYgrILfHMRFOtxg0ZV+6K
 PtXSSt2vtzg1zIbcc/vh1dDhJu4uTEfkh3ssT8EiJvTBzLL5joayBjiNie/1+6zrPR4G
 zr941vqMYWuXC75s/cTzzpWeP3nna+xmbqtegnnKZkrefIGQz01J+eAR/cGe/DAgTPhr
 3PSXzjDQb6YFx2tWExMhDuqbGTGbmimOfEXyyGh9inDU7E7mwXBuawhVpXVY/4q8bqqJ
 +lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775558621; x=1776163421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0wG/Z2TOWRDtWhNHfDppOEjfP1XlYkqucCdQha+2j0=;
 b=dRWs8UVLatUgcU53+lmyUltbByU5Dp4OMGG9Hr2FnHeONB3BjzTfmDAzISkWpKWLye
 A7KCnS0Zu3bNcskoowO5bxaPvHmJZfKgWoQ2eDDVRSQPr8o+1H6cmHKdat+o8Ivu7dII
 mYjvH49PPH2SdU2MaZ8Q0BBx6sTqNn1aWjndTS6XOyb5XyrmKF/Ry2Sm+07y0N6WpOi1
 q7a4hL/RtmRXDw6jMLC/pADtRR5E34jTGpdtahEox72dVLqNIIZVqvZhxXznaXnTKbbl
 hfujYf4m46xpcmFZVAgfUNykZ0yDZHnEk3b2ZeDdb+iX2vTaccc/vSepFpd0fUQ8g0qn
 CqRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiInKpqkBRVfY7JGBAqjIavr+jZNw34YeSjSQkCMhz6CYkk+Tuntc9rcqL2cTt52fwwA/a2QI=@lists.denx.de
X-Gm-Message-State: AOJu0YyoxiZxgcTh1olP1Y2bbfpJfjlB8FFWRH3sFZ/X0EBajUA0v0ur
 5OgKbPry8lSHcGQFY2vzJyiUnJ0459l12rwv2/i1V4fnYewRQXwHxnkY
X-Gm-Gg: AeBDieso0i9EtklAgw9K/+bwDhK1Q/x9DXjABI/LtEqcvG0sSkX6VKLFO8j83BpZv5O
 yc2EDtynmweQXncEWTvc20upT12jgq189wgs1RKzYZv+5k7sFdxPFABKBqOQt7UMXbRT7k7yt8K
 91DyXA6zJhpH9TTTNxwrWH+zJJr4Bfi64PCCdmRMv3cBJIkUy37dUqaWh9XRcv11u3CTtPwxskW
 c6RticwFo5RQjpkSR3+SPLeHWRwdkjfDZPb23I5bhSzJlFF5k3FZz6uPpveHpANkwV8s/s4mBC/
 aWiPCYOtV0vkt1vh2XEFLlZDcfjN5BgwHn1SvvBdPbpSYyBmyhk+P2we9bv99adb1tnpaERAjMq
 YSTyi7pRU9M0Xl6DoTmxDoB1e1cyHsAgJqIfA/LaBnW49vLywQR1AUUB8l4qwJDbtwEXP/jiOsf
 c9TFwyiPGZjWxDXwuvCyro12p00+9CnGtscT5k1+Zd3w==
X-Received: by 2002:a17:90b:2e49:b0:35a:189b:43db with SMTP id
 98e67ed59e1d1-35de6810e49mr14487673a91.4.1775558621141; 
 Tue, 07 Apr 2026 03:43:41 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:a7ad:ab31:6142:da2a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de673110dsm5961864a91.3.2026.04.07.03.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 03:43:40 -0700 (PDT)
Date: Tue, 7 Apr 2026 18:43:37 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: lukma@denx.de, trini@konsulko.com, andrew.goodbody@linaro.org,
 aford173@gmail.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] clk: versaclock: Fix incorrect error check in
 versaclock_probe()
Message-ID: <adTf2W5YY3oz-Fro@google.com>
References: <20251212180615.4112751-1-visitorckw@gmail.com>
 <6b40a19c-3fe6-40ef-abd8-66939eb0dfae@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b40a19c-3fe6-40ef-abd8-66939eb0dfae@seco.com>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, Dec 12, 2025 at 01:40:39PM -0500, Sean Anderson wrote:
> On 12/12/25 13:06, Kuan-Wei Chiu wrote:
> > The error check during the registration of FODs is incorrect. The code
> > currently checks IS_ERR(pll_name) immediately after assigning
> > fod_name[n].
> >
> > Since pll_name is checked in a previous block, this condition will
> > always be false, causing any allocation failure in
> > versaclock_get_name() for fod_name to be ignored. This could lead
> > to usage of an invalid pointer.
> >
> > Fix the condition to check fod_name[n] instead.
> >
> > Fixes: dcf2cee77f2d ("clk: clk_versaclock: Add support for versaclock driver")
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >  drivers/clk/clk_versaclock.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/clk_versaclock.c b/drivers/clk/clk_versaclock.c
> > index 19a787eaf0c..1dbde75f180 100644
> > --- a/drivers/clk/clk_versaclock.c
> > +++ b/drivers/clk/clk_versaclock.c
> > @@ -945,7 +945,7 @@ int versaclock_probe(struct udevice *dev)
> >       /* Register FODs */
> >       for (n = 0; n < vc5->chip_info->clk_fod_cnt; n++) {
> >               fod_name[n] = versaclock_get_name(dev->name, "fod", n);
> > -             if (IS_ERR(pll_name)) {
> > +             if (IS_ERR(fod_name[n])) {
> >                       ret = PTR_ERR(fod_name[n]);
> >                       goto free_fod;
> >               }
> 
> Reviewed-by: Sean Anderson <sean.anderson@seco.com>
> 
Thanks for the review!

Just a gentle ping on this patch from last December.
It looks like it might have slipped through the cracks.

Regards,
Kuan-Wei
