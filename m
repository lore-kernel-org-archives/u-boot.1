Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88931C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B8B88C53;
	Sun,  1 Sep 2024 22:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GiTZyIt9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 020B588C3E; Sun,  1 Sep 2024 22:10:26 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD37188C69
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71456acebe8so2763655b3a.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221422; x=1725826222; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ODXwVXm/4DYlzqW/oGmEn0JN5Qf5+sNSNcqxQXq9f4U=;
 b=GiTZyIt9W8rHTTkrJvX4qFmD8lTFTA5p2ch7swuYH2nqH+W0NdCEHA7B8fSfyIvfih
 kwZaMPC3vQN3RpJrSpzNS8fhsS4aFv0uA6KIyqlqaQGNa/d4Qqw97O3/Gijdua+ipTtp
 RdprKA/sIlx5mFL/LnG1HYVM/XQabM+27QgoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221422; x=1725826222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ODXwVXm/4DYlzqW/oGmEn0JN5Qf5+sNSNcqxQXq9f4U=;
 b=n+C2Eo4qJKkxtt2yYPU8EcwK5N8oDww/EqxqqebZ6+Jl5YmbZqK8B/OlFyBNJwEGD8
 mFH+1BwSAHz999txfemD/xbSq17DDymbZ7g4IKypEUcidjSqyIJXizFxTSFuBvkJyoN1
 34chgZpXLFOsc/U7GoobfL8Lz1XtyVkL6uFsn273eUpymrwj0bsjg/9rwciXIZsQW5Lp
 dN6gUC5SLAghwEyYcMXNRKU8YhxJP8XR0V2PyPKL2HzVyIaH+1sKub0UzwODmlzHOOCf
 gqt9qGXqjYxWGKe+YNf3nJiVFw5s9BEAP3uQRlv8U82CSvObekZFRLJhUeHbnJa4ASig
 dZOQ==
X-Gm-Message-State: AOJu0Yz59O3UIShoRMcG9YlCVTS48oute+00PsK82/jzrWawsOLOfVhI
 ruRiOmLN0zV7zyE9xh53kBvO9/duHf0Si21+uhgu5w5Z3/b+rC+ZVTAs8zUC/7HmtjKYtc2Q/eQ
 tOpJjTlpOKfkCUSgx3iiCK1B8VLskHcbjxngU
X-Google-Smtp-Source: AGHT+IH/fOH/7AI1beQM14S/kfkcSXvimzbT2Dtwm/BtGebXPyjHZ+MLEY9AoGkGk/FYRVgil1g0AHx6LdNFfiief5A=
X-Received: by 2002:a05:6a20:9e49:b0:1c4:ae55:2b5a with SMTP id
 adf61e73a8af0-1cce100ecd0mr12723068637.18.1725221422170; Sun, 01 Sep 2024
 13:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-20-sjg@chromium.org>
 <CALeDE9OE1n-9uATQrUi-qxsa_-cvBbfvj-_WaWF16PShNZ9Rgw@mail.gmail.com>
In-Reply-To: <CALeDE9OE1n-9uATQrUi-qxsa_-cvBbfvj-_WaWF16PShNZ9Rgw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:57 -0600
Message-ID: <CAFLszTj87YjhUCUi0UsjFGTYKUH=BwYZ0pmzaswvTAs0Ho-Daw@mail.gmail.com>
Subject: Re: [PATCH 19/19] hash: Plumb crc8 into the hash functions
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Peter,

On Fri, 30 Aug 2024 at 06:17, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Thu, 29 Aug 2024 at 16:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Add an entry for crc8, with watchdog handling.
>
> What's the watchdog handling do? What's this used for?

It does the hashing in chunks and touches the watchdog after every
chunk, to avoid the board resetting.

>
> Looking at the use of crc8 it's minimally used.

Yes, it's a cheap algorithm which provides some protection, so I am
using it in the VBE relocating loader (to come).

>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  common/hash.c        | 8 ++++++++
> >  include/u-boot/crc.h | 3 +++
> >  lib/crc8.c           | 6 ++++++
> >  3 files changed, 17 insertions(+)
> >
> > diff --git a/common/hash.c b/common/hash.c
> > index ac63803fed9..43c4e185750 100644
> > --- a/common/hash.c
> > +++ b/common/hash.c
> > @@ -304,6 +304,14 @@ static struct hash_algo hash_algo[] = {
> >                 .hash_update    = hash_update_crc16_ccitt,
> >                 .hash_finish    = hash_finish_crc16_ccitt,
> >         },
> > +#if CONFIG_IS_ENABLED(CRC8)
> > +       {
> > +               .name           = "crc8",
> > +               .digest_size    = 1,
> > +               .chunk_size     = CHUNKSZ_CRC32,
> > +               .hash_func_ws   = crc8_wd_buf,
> > +       },
> > +#endif
> >  #if CONFIG_IS_ENABLED(CRC32)
> >         {
> >                 .name           = "crc32",
> > diff --git a/include/u-boot/crc.h b/include/u-boot/crc.h
> > index 5174bd7ac41..b2badaf6a97 100644
> > --- a/include/u-boot/crc.h
> > +++ b/include/u-boot/crc.h
> > @@ -25,6 +25,9 @@
> >   */
> >  unsigned int crc8(unsigned int crc_start, const unsigned char *vptr, int len);
> >
> > +void crc8_wd_buf(const unsigned char *input, unsigned int len,
> > +                unsigned char output[1], unsigned int chunk_sz);
> > +
> >  /* lib/crc16.c - 16 bit CRC with polynomial x^16 + x^15 + x^2 + 1 */
> >  uint16_t crc16(uint16_t crc, const unsigned char *buffer, size_t len);
> >
> > diff --git a/lib/crc8.c b/lib/crc8.c
> > index 20d46d16147..811e19917b4 100644
> > --- a/lib/crc8.c
> > +++ b/lib/crc8.c
> > @@ -32,3 +32,9 @@ unsigned int crc8(unsigned int crc, const unsigned char *vptr, int len)
> >
> >         return crc;
> >  }
> > +
> > +void crc8_wd_buf(const unsigned char *input, unsigned int len,
> > +                unsigned char output[1], unsigned int chunk_sz)
> > +{
> > +       *output = crc8(0, input, len);
> > +}
> > --
> > 2.34.1
> >

Regards,
Simon
