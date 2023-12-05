Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100B4C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 00:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84C9E87889;
	Tue,  5 Dec 2023 01:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n3lO3GMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAA0A87890; Tue,  5 Dec 2023 01:52:20 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8107F87885
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 01:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a196f84d217so522868366b.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 16:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701737538; x=1702342338; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZkvnG+3ZowpCjvA3+A3L9MbvRaMNj7ym+fhAggXPC80=;
 b=n3lO3GMPNfSOP0Ohy8ukWR6+qq4J6odETIj3SZULWPGuAc1pDcpZKuUGQgOfAG5ipP
 BTg5uAQ4HlPsoe3pytyk7/BMn1DjjSbx/EQcH6nNWCwhP3Ae3A0PvR6BNSUbysuysI3n
 XZydzwICQcUA1x3fnQKx5THhGfR49q6P+eHI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701737538; x=1702342338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZkvnG+3ZowpCjvA3+A3L9MbvRaMNj7ym+fhAggXPC80=;
 b=PyiBUlJwDCPoQlnvcnsIx5RiO5Be1w60dx+RiKHgCPSnlmPQxdq2nKGAuKdA0rcW8t
 4zULgRpG+eHz/mMCuRs2cetYTEuAFfLklfUGKpACwQEiJHp0K7MoCB2rpVH2PRq8cGHA
 qEExCIuAxLTNjzdzsFIf5dXatC9CUZN8mILbcLOgdrjgxpRp9fsxiDSO8/CHq379XHeq
 f4tkNaFS4/iNpn3/i2nt7DjamhXInsj+8aoqqslpOe1JRolofazBPav+Wswf3DnjmTAs
 cujxo/kvXb3TRaUJqu3HADFhX8OgkHDrIEE6RWn96H4Nw/RAgEuZBmGsa7Zwl2PZJC7P
 SjaQ==
X-Gm-Message-State: AOJu0YzXj0vmRWGMTJg6MJvj0497u5QZ3SZDp4xDeH+yEHWeDzX9V75Y
 RlGTxDvsSe3ADGiFBhWzVYECl1AP3qFHAmOUkCux8Q==
X-Google-Smtp-Source: AGHT+IHtIRihOpHCObUKupPP+jcd0EBKGYRKPuXtT2f23UtilSEqd9mWKSENiSDjTnIgxmKw5yEQdLJfaffY2yWcOok=
X-Received: by 2002:a17:906:dc05:b0:a1c:2eb:3839 with SMTP id
 yy5-20020a170906dc0500b00a1c02eb3839mr291335ejb.67.1701737537951; Mon, 04 Dec
 2023 16:52:17 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-13-raymond.mao@linaro.org>
 <CAC_iWj+z_g4JdATWyYXDuAuUuFgCOEHzsVSwn89phnimtkvtEg@mail.gmail.com>
In-Reply-To: <CAC_iWj+z_g4JdATWyYXDuAuUuFgCOEHzsVSwn89phnimtkvtEg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Dec 2023 17:52:05 -0700
Message-ID: <CAPnjgZ3yxwfU=2u22FPzUq=z_TM3Vrme9kxGh6gqNeoq14gcJQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] bloblist: Reduce bloblist header size
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
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

Hi,

On Mon, 4 Dec 2023 at 01:39, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Ah I guess this fixes my concerns on patch #6
>
> On Mon, 27 Nov 2023 at 21:53, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > The v0.9 spec provides for a 16-byte header with fewer fields. Update
> > the implementation to match this.
> >
> > This also adds an alignment field.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  include/bloblist.h | 26 +++++++++++++-------------
> >  test/bloblist.c    |  6 +++---
> >  2 files changed, 16 insertions(+), 16 deletions(-)
>
>
>
>
> >
> > diff --git a/include/bloblist.h b/include/bloblist.h
> > index 745bcdd227..57625ea004 100644
> > --- a/include/bloblist.h
> > +++ b/include/bloblist.h
> > @@ -164,30 +164,30 @@ enum bloblist_tag_t {
> >   * from the last.
> >   *
> >   * @magic: BLOBLIST_MAGIC
> > + * @chksum: checksum for the entire bloblist allocated area. Since any of the
> > + *     blobs can be altered after being created, this checksum is only valid
> > + *     when the bloblist is finalised before jumping to the next stage of boot.
> > + *     This is the value needed to make all chechksummed bytes sum to 0
>
> typos checksummed and finalized

finalised is correct

>
> [...]
>
> With the typos fixed
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

REgards,
Simon
