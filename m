Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64608CD4F21
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 13:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6FDB84671;
	Sat, 16 May 2026 15:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CtdOrrh+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D8BC8467B; Sat, 16 May 2026 15:31:38 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB97D845E3
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 15:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bcd0111ea98so142664066b.1
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 06:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778938296; cv=none;
 d=google.com; s=arc-20240605;
 b=gBuJW88gf9QAHzTnkHM9nYwSNrQmgboazuzfK30Xq1d6gGwMdlSCbRtow7QvOnSobV
 AtD9HeL9Jke3S+UuU5CsDc5KaX5IZ88lO9pkB7HtFMu3Vrht4snvPhKyZIqIJm/5kxIK
 1p6wuU5szZ9JZk/Vioma78V5pdXB9tY73hpHoS+RDBWNUP5e4rWua+JSlgw4EsbzOqjG
 cM0TbcIOl7IRTNI0WqfHV57p0I8DBIR31106clmT5i3hFWf/Wg23II0zGDfDsbfhya+L
 U0FJa8QXazNk8o4FTpbxIGB7FtKsydxXYWzjluQkQD3NeTDKSCT055Cdd7cpVa1qLNFm
 LDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dcE1UIzNDIOhRWwk0WuF6w6l9PK30jlgdHAGEfEZNho=;
 fh=5YhLnYExn+RFXJMHrXa6E+9YNQ7PdWKEtG4iQ2WFeRA=;
 b=EsvYDECCVK7i0lKs//sXhXqAmuUeCEaClAA2DJHf2dN+EXYptmSVi/TR6v7WwzCRkT
 O76FYKozSTfK29oProdyYVRK1aj4Spc+HSNAz9Gm8QRyqFqrWBSvMCFiryga1BLXyPWY
 ZimC1ErfEnYzvD8EBi0RcwUo73hpSXSiJcvrfzH4H7KcEK1ihioh31fwbTWyxgdHStWO
 FNtwf+yDP5rbu6ly2cY9Nt7ccbQ8Uh5/WM78p0JEgBa6NqUH5lf+zbiSRcNucF72KysP
 5HminVuDe9T0tv1nCpTzH/rx1rbHbm7zV1kjMy5V/QxfNctNziUXAbHdfDMxHTAezkL6
 O+sg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778938296; x=1779543096; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dcE1UIzNDIOhRWwk0WuF6w6l9PK30jlgdHAGEfEZNho=;
 b=CtdOrrh+uuHW6sLzVOw8jGaXaS/hjUcpSL50ZpKZIckpDbev/8Mc5hPcSpRprRCzYf
 xPfsxUmo3C0h41RKE/gGCFRFrfY4rlEPFZeWLXVmgASnH2ORvS1A28RokXbmsJc+rIrB
 Nbe8QAzbxY0DNQLvZDKGSc/MOEZuf81SmqO+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778938296; x=1779543096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcE1UIzNDIOhRWwk0WuF6w6l9PK30jlgdHAGEfEZNho=;
 b=i02YkfmX5F5xfA5iVZ4A1GWazP1Ywz/Yoe8saQDbYG+tbvmQMRmusBAmWhB/UqQ9lF
 zcWwJC1cHnMQLSqHuip/OB4zeS+nGTrpho+/oDDBv7iu5DavgKBHUycRJfpcO6RRgPYj
 t27h0SO3qYwfrDg7mvqjuUd1lbbU//IvYihvieXPQT/4RnueMsnq1z3fwYJw06rx4k31
 +xH6TOeeWZL/MDMkH/ovH09L45H7xves5wikPmlw8CaRfryAGBuKz2e2Ta+mM1DFtx6m
 0LVG/r19AZ7UCZW8c6sD0KqR6dJ0JUi5mHkLiUF92YuLPjb2FNfaG9AUvTkLXLq5QZL7
 a3Kg==
X-Gm-Message-State: AOJu0Yz/gG2kfDqFvtCscQp1T39dSKYba26kv1TilKl2Qpdz4/joVvzD
 +wAuG1rQg0DclkyTvqHicIpbukY8piB4XeCyknB+okJ4BubpbnYdWM6uI/Oyf8rdk9zx2zf83aG
 i7EzfVcXgk2vVd6r+Kg/jqEZJ3DuNg3ciDUpPUGMO
X-Gm-Gg: Acq92OGbM5Wo19tU2QflMHtFZLTeY2EuaK4wOAO86ijfkqITipU2BxaNSS/7YNVGN0W
 nN7ZjyeDEvV3CAtTtuBu9dUsGiSJTZaxemP1SnecAsFoBUjzpLDwaYzJRdwDg33az46xxznAfG4
 ce6fFjxMfpY0yddbcUvK2cRFWm0F0apOyxYNnMZAJ334xQa3JWX3u3CPjK7Rb4BedOutvUZOvUl
 VDSHWnCOYFwjh7XjRQHUyAz/yFiiR0N5MBrea27nd4ZbQTkgdb8h/cVdLd4szXyKUo+WxKSEdbO
 nXzuj9nGKQuMjzyskeElacCZvZ0=
X-Received: by 2002:a17:906:478e:b0:bce:b586:e683 with SMTP id
 a640c23a62f3a-bd517abe938mr424394766b.43.1778938296138; Sat, 16 May 2026
 06:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <BESP194MB28052CF65AFFB806C625EE84DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB28052CF65AFFB806C625EE84DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 May 2026 07:31:24 -0600
X-Gm-Features: AVHnY4I-9tHCdS1DczI0YIoJWxIsz7M_y5YAIqB5zg8-TAMONajZnRfWRrqfw_I
Message-ID: <CAFLszTjuy1N2huOeFVLEiH53EZ5mDU4ko5WiCMM_4mjkQMgNJA@mail.gmail.com>
Subject: Re: [PATCH] boot: cedit: Check ofnode_read_prop return value
To: fberder@outlook.fr
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On 2026-05-15T20:57:47, Francois Berder <fberder@outlook.fr> wrote:
> boot: cedit: Check ofnode_read_prop return value
>
> In h_read_settings, val variable could be NULL due to
> ofnode_read_prop returning an error. This variable
> would then be used as the src in strcpy.
>
> Add a NULL check after calling ofnode_read_prop.
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>
>
> boot/cedit.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/boot/cedit.c b/boot/cedit.c
> @@ -500,6 +500,8 @@ static int h_read_settings(struct scene_obj *obj, void *vpriv)
>               tline = (struct scene_obj_textline *)obj;
>
>               val = ofnode_read_prop(node, obj->name, &len);
> +             if (!val)
> +                     return log_msg_ret('tline', -EINVAL);
>               if (len >= tline->max_chars)
>                       return log_msg_ret('str', -ENOSPC);
>               strcpy(abuf_data(&tline->buf), val);

Good catch!

Please can you use -ENOENT rather than -EINVAL, as this is more
consistent with the SCENEOBJT_MENU case a few lines below.

Regards,
Simon
