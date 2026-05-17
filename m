Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AC9CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A35438468A;
	Mon, 18 May 2026 00:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FgwvhIpn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF7FE84683; Mon, 18 May 2026 00:52:17 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F09E084659
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd36614d329so244529066b.3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779058335; cv=none;
 d=google.com; s=arc-20240605;
 b=RuLkeO8J737UP1LZt76A8R2kvO8hXjp0J5fXig6OXXbmCDRKEyiILrxV3H/+Tfj+Hp
 g2+ZdefRZEMRyVDgewDl9MZmxuF6r+eC/89KjCNt9S/Nqy+kZLuRZ0AV+bOofWA5vkVb
 ac1PtaE4UBRPh6oDfJg0q1gUxsggpGjVJJ7q/me3UpB2yBrsqRbnx5KaUDO+ewyeb0jw
 WLYDdhfrG8Q52E34FyPj5A44zw8i7oH5YW+gQDcH/pwoTYJ8R4M0d7vAdNynAa8lTph/
 G8XaQBeE9Pk1LYJwtgOvfD1Sxgr+H3Iag+1p5jvtyFP0slhmuaFyXyVjDK1ixgKC8B9s
 YKYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kVWSYhbmem1d4s2gxvdVvav6sQxUzTBatt0Fo2c9Fro=;
 fh=Ba4hdmvaL8Iqn+laLAZ6Zwq6KO+OgpTCF9Lsg9Ghi9E=;
 b=c9M4pc9VPh7IiCS5wCUUmULaUqIpPFWsNxcLkW8x5jyLQ9ijXBwrMEDYh6rnSLhZGb
 nAHhBWllOfmR2F+nZaDKVpNJ+6Yu9AwSqaUN1m7XLkyNpkSaqrMQxwWD3/2vvDzD7OBu
 ObKv6lYQCqPYbf1RF3atw/z3E44sWcEL1loV2pFt7O+bPfjY5nb1BaL19j82j+0RWJir
 1taLr8bp4K6ZVUA+gY+qI3Sbf1ODZVufyarCGSG5joPh1jCJPhmIoXl2xsqFVknpriAJ
 Zxnv4IuV+pHTYJm6B/fIWIgH8KI1XdyV9oo/Oi9kwUrF+ow+o9t+b1U9j8zZM5VmjwHw
 lfJA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058335; x=1779663135; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kVWSYhbmem1d4s2gxvdVvav6sQxUzTBatt0Fo2c9Fro=;
 b=FgwvhIpnL4O8Y7vCYXp69b+db/IF9vv0sSGukvoLXRfSVRNwRSZCEoKYStLt+RsPZX
 p0tTyQGhiIOaSv7sZ2aP0SUUGIVy2rzXDds6tVnQv5RqEECvlS7ReTI0MET2yk5ed4I9
 ohqeK2u84FiNdERAkbPOS1tT2T8M10Cjow2ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058335; x=1779663135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVWSYhbmem1d4s2gxvdVvav6sQxUzTBatt0Fo2c9Fro=;
 b=d1tZyGMQOp/paKIGguExtCXVVuiq74PGCH9aFZRoiCsVP4pGiJrmg0dVVDspWkzCmI
 0AEbnn2JMrSGr50CIRfgoRXbnMJ13drQVKY0U7AVLt26XyYDPagpAg+8zL0N9Eos9MD5
 hG6R4DpN+91lNnTo2W8B8ngCq9nZYWedajsbhsWr4wZdGUdsyFrmR39ZRQWSs+V3Z28p
 y01g1S982rdz14zCwKsvzbGl2912m/cqN0AXXM/gRtXRwuo7WiT/Bi/Hupvo3AaIkabk
 awU9M0+5YjLuYPPXr87lX0crv0RDfqklFOBvHktZ3PLzyPUn4dF8ynmFOSma0b+q3tCM
 TIyA==
X-Gm-Message-State: AOJu0YwcPEb5P/OdEvrIoEXb2C6zDCqlaDT20D1kd61NLno20fpo/pRD
 YAjTY5SdlXhckXFDQNZZf3wsJAGfLCUPvJlBjiv9nu8krEtWb1fIOQpjt+gW/NLrd1acf8XGX5O
 7BjItooZplDCcy2foGOp3KLHVc7Xu3dF0bvdUVN/t
X-Gm-Gg: Acq92OGtu3jIr035lGGlq2gETMdvuusv3cYpJDgSvH/gZghqvmSNxklScL9RoZlwdbE
 Qmn9CyYIX2qWDFMkUTppPrLxuiskYBj465p4fgIUqoEmDiITALPjYrq3q2/WQ7QozU2wxnJ/DtU
 LBdnjJ91QZUPi2DalFaW3zAxDbgIwSFKhVuQTRn76rRd8P2/BsxQj9zyOlqJ/77dzXPcLUJWcdQ
 JFc7x3pt/TvHJw2StVszTpwPp90pk1Stz93z041iE4fRR5AB4SyuKhbw2RwtmbhMSebgx/caqBo
 +0bfU5kd
X-Received: by 2002:a17:907:c248:b0:bd4:9a54:afa2 with SMTP id
 a640c23a62f3a-bd5177f4418mr724503566b.2.1779058335378; Sun, 17 May 2026
 15:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <BESP194MB28052CF65AFFB806C625EE84DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <CAFLszTjuy1N2huOeFVLEiH53EZ5mDU4ko5WiCMM_4mjkQMgNJA@mail.gmail.com>
 <BESP194MB2805F515E21C1E89E869D33EDA052@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB2805F515E21C1E89E869D33EDA052@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 17 May 2026 16:52:02 -0600
X-Gm-Features: AVHnY4LY5KMPwg5kBOyVScGTrYl0jyUB8VJfD5qo0CyZaB8wtI8Ax9DmlnTE7Nk
Message-ID: <CAFLszTg6_46sEjcUO1xy2tXo=B2cHZ3itt8eQRt4fEvsp3Jqhg@mail.gmail.com>
Subject: Re: [PATCH] boot: cedit: Check ofnode_read_prop return value
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Francois,

On Sat, 16 May 2026 at 15:11, Francois Berder <fberder@outlook.fr> wrote:
>
> Hi Simon,
>
> On 5/16/26 15:31, Simon Glass wrote:
> > Hi Francois,
> >
> > On 2026-05-15T20:57:47, Francois Berder <fberder@outlook.fr> wrote:
> >> boot: cedit: Check ofnode_read_prop return value
> >>
> >> In h_read_settings, val variable could be NULL due to
> >> ofnode_read_prop returning an error. This variable
> >> would then be used as the src in strcpy.
> >>
> >> Add a NULL check after calling ofnode_read_prop.
> >>
> >> Signed-off-by: Francois Berder <fberder@outlook.fr>
> >>
> >> boot/cedit.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> >> diff --git a/boot/cedit.c b/boot/cedit.c
> >> @@ -500,6 +500,8 @@ static int h_read_settings(struct scene_obj *obj, void *vpriv)
> >>               tline = (struct scene_obj_textline *)obj;
> >>
> >>               val = ofnode_read_prop(node, obj->name, &len);
> >> +             if (!val)
> >> +                     return log_msg_ret('tline', -EINVAL);
> >>               if (len >= tline->max_chars)
> >>                       return log_msg_ret('str', -ENOSPC);
> >>               strcpy(abuf_data(&tline->buf), val);
> >
> > Good catch!
> >
> > Please can you use -ENOENT rather than -EINVAL, as this is more
> > consistent with the SCENEOBJT_MENU case a few lines below.
>
>
> When I look at the way u-boot handles ofnode_read_prop returning NULL, I find that it always uses the EINVAL return code instead of ENOENT. Let me know if you still prefer that I change the error code to ENOENT.

Well it's not a big deal, but -EINVAL is used in of_to_plat methods,
indicating that there was something wrong with the DT node. In this
case, we are reading a config-editor definition and it is not released
to a device, so trying to return a more varied assortment of error
numbers is helpful for debugging.

Regards,
Simon
