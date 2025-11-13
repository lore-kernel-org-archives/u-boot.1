Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D54CD98F6
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 22:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2078683E23;
	Thu, 13 Nov 2025 23:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FYetFXAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4880E83EAB; Thu, 13 Nov 2025 23:47:06 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3809783A94
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 23:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b472842981fso172127066b.1
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 14:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763074023; x=1763678823; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6gG1Ar9Q5J6kIeX9QEpAHDJFAE3qJzVcojI3iufJfrY=;
 b=FYetFXADQRlwj8KNiZIVqYxbx6FvoQMV/wVLV3ROo/weyU+xHKek49mjqA161CXpdF
 ZM0NNaerUGsdRJ2re2d9Elaic5AZMVvKySLebjTo6vmNyxX8XdhRG1AokztblAjrTl/J
 HQx69ErbR+83KdimTQDtVNe4HsnXN4Wk6ZJlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763074023; x=1763678823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gG1Ar9Q5J6kIeX9QEpAHDJFAE3qJzVcojI3iufJfrY=;
 b=rvYZy85mnDFMEVIJDcq0S6CiKFSkcWrrl0LgQj5UoSBtsdmxAn2aiA8PqHO0o6dAZ0
 mOogiAIAQwppUurjY0uHMxeqiKVdzDaxvxG4V4/tMql3ZhUJfFIZwYMauEDdobqbh/b9
 QwrLU4Kcq5fE//kGH4Qac7uzCJzTmC19DmkL+RVvnax/4PszA4+WC++wBoFVR70Hn14M
 IlIKTUDkOCqVZJVxbZGKNTAYeJgyoLRIElXLyRIJMYi1lEb+B7hVG30i9s50yyxta9Tu
 AUFoxC5mSw2mLsoMKqZfFGVVlS+n5mjJvQiyO67+lFWRhpNSm6krLk41P3toqejqZxsZ
 xl9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXM6woGlj5vI/Dyx+YebgSHtBjgnBmcZ63Gu3Gaz7oznBUmeb6TphD4xkEYj2VQqunH2WsI3o=@lists.denx.de
X-Gm-Message-State: AOJu0YwNrV6q0Pp+E7LgNY5g8eAdpwi/Tm40sne1aGJj225cqX9xSwzZ
 ZaeE16LMdlyhWTv7agznZXguuLnXgpWZsx+zUjY9ITK0cSqcRwCkR9+Q0FdOXEZW3kVqB1zqf0R
 RGvnbVo1npU3/OTNd64Ow26Wnrf9FbdTxGA9+9F2+
X-Gm-Gg: ASbGncsR9mAXw5K5DP9JEkfzSkVeO9YWxmvwtivFMTqlyfe/g27JptifQ9hlkxTciSK
 tSIr/tzuJ24Pv4RR1CwKVPgzvf73jd2hziLVaYYmJg1y81td8fJnSV5koUMJ5VM0Ty2fpSpk/WS
 JTtZ+jOjVRw34WwqkhL62X89RDvRSpwZEgTAyMoHy9VWZRys9slEFGYm45huNZY2Hz+lwGLZBMq
 pHwtoJ4wCeC/ba/A3o3Pl2/bLl0TC6S+hKWCTCbEmMSjXrY4ahueC3dxt3zpxsw2HwQIQ==
X-Google-Smtp-Source: AGHT+IG8adhbRvZGcQHjrtTxTveRoG9wGb4KQGw29NK7iBKRw+xzG7Jb2zkw6YtOyBVZOXrm4Q+nP2pOeEET1YaDtTc=
X-Received: by 2002:a17:907:944a:b0:b73:21a9:d3bc with SMTP id
 a640c23a62f3a-b73677ed400mr65900466b.11.1763074023616; Thu, 13 Nov 2025
 14:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113122145.949112-2-marek.vasut+renesas@mailbox.org>
 <CAFLszTigJHK9H18rZG=AHRo09RPqKGHQmmVrHZ40mHPk-KkwqQ@mail.gmail.com>
 <7a083302-1096-47fa-90a9-aa350eea6884@mailbox.org>
In-Reply-To: <7a083302-1096-47fa-90a9-aa350eea6884@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Nov 2025 15:46:51 -0700
X-Gm-Features: AWmQ_bkEX7B3dUXgzVO51_Oa9my0WmyhVWm6Cneg4kWZ4nUgi87ir9CPdLUlvZs
Message-ID: <CAFLszTjktw3yS9Dp9KGC=BAnpJAHg46f--NRRfnzXApQVOiuUQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dm: core: Check ofnode_to_offset() return value
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sam Edwards <cfsworks@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Thu, 13 Nov 2025 at 14:57, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/13/25 8:33 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> >> index 071d998a0a5..55c2b3a10bb 100644
> >> --- a/drivers/core/ofnode.c
> >> +++ b/drivers/core/ofnode.c
> >> @@ -335,7 +335,7 @@ bool ofnode_name_eq_unit(ofnode node, const char *name)
> >>   int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
> >>   {
> >>          const u8 *cell;
> >> -       int len;
> >> +       int len, off;
> >>
> >>          assert(ofnode_valid(node));
> >>          log_debug("%s: %s: ", __func__, propname);
> >> @@ -343,8 +343,13 @@ int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
> >>          if (ofnode_is_np(node))
> >>                  return of_read_u8(ofnode_to_np(node), propname, outp);
> >>
> >> -       cell = fdt_getprop(gd->fdt_blob, ofnode_to_offset(node), propname,
> >> -                          &len);
> >> +       off = ofnode_to_offset(node);
> >> +       if (off < 0) {
> >> +               log_debug("(not valid)\n");
> >> +               return -EINVAL;
> >> +       }
> >
> > Ugh this is really horrible, sorry :-)
> >
> > Better to put a wrapper around it than add all these checks, extra
> > code size, etc. Also in many cases the ofnode is known to be valid(TM)
> > so it might just be a waste.
>
> How would you propose the wrapper should look like ?
>
> Keep in mind, not everything is fdt_getprop( ... ofnode_to_offset() ...)
> in this patch.

I was thinking of

my_fdt_getprop(fdt, node, propname, lenp)
{
if (node is not valid)
   return NULL;
return fdt_getprop();
}

What does fdt_getprop() return when the offset is -1 ?

Regards,
Simon
