Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7A8D4335E
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 13:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 915EC88EBA;
	Thu,  7 Nov 2024 14:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hiJ/ODy+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62F4889287; Thu,  7 Nov 2024 14:45:24 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3711388581
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 14:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7eab7622b61so768691a12.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 05:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730987121; x=1731591921; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UR0tCp70+5UFXtO6lWxmy0BhyjLem3R9Ug5XX/bV044=;
 b=hiJ/ODy+gcjFdk/cI/unwADDZcscujf99cGdZ9qYLsj8pbvUDreLHieEl8U4LUSsdB
 3FKkcfeprnCW1AjkEoJUyryjfD6T96fxds8kPxMVsvxxJCJ4mzrCYOx7/+9tuRYcJTr5
 rYWevVFbPLw81BdYgFUdrT26YAvcZxYii/fLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730987121; x=1731591921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UR0tCp70+5UFXtO6lWxmy0BhyjLem3R9Ug5XX/bV044=;
 b=DVFD9KYDLEuL9x9QRHsgh0YqQB2Yo9zN82djAi5JOuN/eBuKTPwbGNZfL/OTg0tafr
 OjZuxCq/iDdbrFAvrT2XqEdn+H1EqwFpX89iQQAbZMNuXWNuNiSUAlyM+SiXtKgi5XXN
 PqigEo0GV37PCUjbBx+HxyFmalpWhHVrbxZW+YfgPmMQ0pqwVY8VfTA2hbvTuPy8gqfA
 PZ8RVfTUpb7ojeXpAMfa2VGWCvCWzAAzOqP4vGKbZcpfH41tSoRp6mB+yz+vWSS1ix3r
 vWmZgA8Q+yBAE0D7afmfuuMUNtthsq7YOneiQpqw6l7heTzwdjelfLP7CCl0wAWk/2pI
 Nnvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH9ZtrUZKN4KZMGJO0VoqsBmwslqaE76A1igXdGR0J5VOHVlk/jmcDBDUsAp+IJOLfjSDU18A=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7/lg8kSUPSXJ2wJUSk4vg5r/te8cGzYM3FjclM9uPHta/+Q22
 K+GwEpWqsIJZAWcUM2JgmUOYAJRmqvL6CCvRptiQ8Ej8EY36OFDz6zMbee46nFeK5OB/oVFoIhc
 SmrOekEVyaaIACs9o+Z/ONRCalrpECAWtmf+0DM1TouFnW6M=
X-Google-Smtp-Source: AGHT+IGcw65Do55yUQW+Gy99pvFcBf1Tka6HYFZqpdqN70AqxGj/Fa253hVLmiA/GCKDJRVrbEHP3sMA1DG4LNT8uQY=
X-Received: by 2002:a05:6a20:8426:b0:1db:f07e:8ab5 with SMTP id
 adf61e73a8af0-1dbf07e98ecmr13515468637.36.1730987120781; Thu, 07 Nov 2024
 05:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20241102143020.129450-1-heinrich.schuchardt@canonical.com>
 <CAFLszTi1r18JmfdZtFLOrUPa1G0m3r5NPajUadkO5tGqXXNTDA@mail.gmail.com>
 <3cda4d67-4ae6-4449-8fe8-6a1eb4c89c0b@canonical.com>
In-Reply-To: <3cda4d67-4ae6-4449-8fe8-6a1eb4c89c0b@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Nov 2024 06:44:28 -0700
Message-ID: <CAFLszTjHtmGa2Ogvmm8ZwvA5Cv9esDo-BsakbPFbeLYwiWLdFg@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: upl: initialize unit test state
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 6 Nov 2024 at 09:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 05.11.24 16:12, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sat, 2 Nov 2024 at 08:30, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> do_upl_write() calls upl_get_test_data() which may increment the fail
> >> count in the unit test state. We should initialize it.
> >>
> >> Addresses-Coverity-ID: 510465 Uninitialized scalar variable
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   cmd/upl.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/cmd/upl.c b/cmd/upl.c
> >> index 4996f36c787..c9a823bbc06 100644
> >> --- a/cmd/upl.c
> >> +++ b/cmd/upl.c
> >> @@ -50,7 +50,7 @@ static int do_upl_write(struct cmd_tbl *cmdtp, int flag, int argc,
> >>                          char *const argv[])
> >>   {
> >>          struct upl s_upl, *upl = &s_upl;
> >> -       struct unit_test_state uts;
> >> +       struct unit_test_state uts = { 0 };
> >>          struct abuf buf;
> >>          oftree tree;
> >>          ulong addr;
> >> --
> >> 2.45.2
> >>
> >
> > This already exists. A memset() is in upl_init() which is called from
> > this function.
>
> My patch is about initializing the unit_test_state variable uts (and not
> upl).
>
> upl_init() is called for upl and not for the unit_test_state.

Oh, duh, got it. At some point I will have to make time to come back
and tidy up this UPL thing, perhaps when I test it with Tianocore...

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
