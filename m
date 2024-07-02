Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D033C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 15:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72BF87923;
	Tue,  2 Jul 2024 17:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jlQQkN+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD7C87C86; Tue,  2 Jul 2024 17:51:29 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 798B587837
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 17:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b593387daaso41074046d6.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719935486; x=1720540286; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eeqUdGd3mA3GE9ngVaOruV+dJjvRy+h86XmIqMrD5hw=;
 b=jlQQkN+fv5AgSzam9rxcdo2FRK1LkD54ZOHhelpuZ4q0Hy37LvGom18PXQ+l/7wVun
 4torOm6KLNfMAkMAywGfG7+4KPFQpymklz8HoR+QbX+ZEWzIHQHgudaYvRLL2V0GKSfD
 eAmDiDZW4sDcJqckj+i9QX2OamYfqbMK2Mhxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935486; x=1720540286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eeqUdGd3mA3GE9ngVaOruV+dJjvRy+h86XmIqMrD5hw=;
 b=dAFvARjRbUmHEnAXyh8NkhFtUb7957DMuxCv5sn3K/PBhPaHOM9TJyz9eTdXsgQImf
 hWlfn9syERmO39T03CuILhOH9L7K0+IAzOw8S4VONzi6CboN7ojTjU/e7/3CSpgAPlDL
 6XfUEp5htt/9lJIWh8ZPMgvKassVp3kyrByTf1D7WZx94bkKOHjed35JkCbVhV/Ws1lQ
 mqJLGdpa/pPwDctWx2i84TOlfKeiRPO5Gv7AjSZA0qdG0Ruc4uAw1byhpFBOHn22w6cy
 kBYN+gYgLMPKZ6ij+HOgNFOzZGl/c4deA9ZCH1GSzafXocXZ2k4xASBk9zxzUDfssFrk
 dfGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNyu1y2CVgOJXvm13g8VC1sYQfENK8p9hpOQwNMZgPtn6aC4/5lu4fYyULY9Z6B8e5L9VQt13PHbUykFfd5SRTveFFhA==
X-Gm-Message-State: AOJu0YyiEyr1fd1EVOakT+6ebHUuxBVGB25fV/uPMGPUmynMcR5QL7Zg
 5UmUPUt35gO5ckkK1JxrnSXVUY0dYd/NMZOODcrRxRFaoo6PxLbRuzz+A60km5P00IzbApMPbXd
 ClJ36Gfaw9KdJNABTueOL0/H8SWZh6fp/ecPF
X-Google-Smtp-Source: AGHT+IHZFhjTAvakYb3s0KMYCn7EIJdzsN5fh7Xb/2gkI3DGSTYTFUYf/bSHv4qjvYSaFp9ORGOZ7Q1ms7fiG5yiCaw=
X-Received: by 2002:a05:6214:1c0a:b0:6b5:1d2f:1d3 with SMTP id
 6a1803df08f44-6b5a5321281mr203621376d6.0.1719935486377; Tue, 02 Jul 2024
 08:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240627112904.99969-1-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThsS2oYVx3zxZhN6HSzHkA-NStydZfS=Jr25FpwRimJNA@mail.gmail.com>
 <dd3453b2-2ad6-473f-b419-88a7577fded9@genexis.eu>
In-Reply-To: <dd3453b2-2ad6-473f-b419-88a7577fded9@genexis.eu>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jul 2024 16:51:15 +0100
Message-ID: <CAFLszTgtOWNGQFwKnyAADXVgbpiBR3d8NcjaG3VpUQbnnhboeA@mail.gmail.com>
Subject: Re: [PATCH] gpt: allow spaces in partition list
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Joshua Watt <jpewhacker@gmail.com>, 
 Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>, u-boot@lists.denx.de
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

Hi Mikhail,

On Tue, 2 Jul 2024 at 10:42, Mikhail Kshevetskiy
<mikhail.kshevetskiy@genexis.eu> wrote:
>
>
> On 27.06.2024 22:05, Simon Glass wrote:
> > Hi Mikhail,
> >
> > On Thu, 27 Jun 2024 at 12:29, Mikhail Kshevetskiy
> > <mikhail.kshevetskiy@iopsys.eu> wrote:
> >> This allows spliting partition list to several lines in environment file
> >>
> >> ex:
> >> --------------------
> >> gpt_partition_list=
> >>         name=boot1,size=5MiB,start=0x100000;
> >>         name=boot2,size=5MiB;
> >>         name=rootfs1,size=70MiB;
> >>         name=rootfs2,size=70MiB;
> >>         name=overlay1,size=20MiB;
> >>         name=overlay2,size=20MiB;
> >>         name=art,size=4MiB;
> > Is this referring to a .env file, i.e. a text environment file? If so,
> > I would hope that spaces at the start of a line would be automatically
> > removed.
>
> This is refer to a .env file, so starting space/tabs will be removed,
> all '\n' will be replaced by spaces. Thus we will get a single line where
> each partition divided from other with a single space (like below)
>
> gpt_partition_list=name=boot1,size=5MiB,start=0x100000; name=boot2,size=5MiB; ...

Reviewed-by: Simon Glass <sjg@chromium.org>

But I wonder if the \t is needed?


>
> >> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >> ---
> >>  cmd/gpt.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/cmd/gpt.c b/cmd/gpt.c
> >> index 7aaf1889a5a..2b29ab98ccc 100644
> >> --- a/cmd/gpt.c
> >> +++ b/cmd/gpt.c
> >> @@ -117,6 +117,7 @@ static char *extract_val(const char *str, const char *key)
> >>                 k = strsep(&v, "=");
> >>                 if (!k)
> >>                         break;
> >> +               k += strspn(k, " \t");
> >>                 if  (strcmp(k, key) == 0) {
> >>                         new = strdup(v);
> >>                         break;
> >> @@ -151,6 +152,7 @@ static bool found_key(const char *str, const char *key)
> >>                 k = strsep(&s, ",");
> >>                 if (!k)
> >>                         break;
> >> +               k += strspn(k, " \t");
> >>                 if  (strcmp(k, key) == 0) {
> >>                         result = true;
> >>                         break;
> >> --
> >> 2.43.0
Regards,
Simon
