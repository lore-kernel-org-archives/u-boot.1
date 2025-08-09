Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58341C87FCB
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 04:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 777A383D4B;
	Sat,  9 Aug 2025 06:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QTKy9h3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F0D1847EF; Sat,  9 Aug 2025 04:09:06 +0200 (CEST)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130D7847E7
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 04:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-88ddbdfc234so1934424241.1
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 19:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754705342; x=1755310142; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONKYNaPJrdTl7+BQENWBF2JNd5j5K7JNI+H0Ss3Ur8k=;
 b=QTKy9h3Iakgo6WyS6I3QxKlUP4fVc2rXGoykDRlK5YYcwHjYrdH91DDO0+kVHWiNDp
 bdN66h3awaFScYf8yqDUeYppwSLpOTrIuU7Ju5kSeU6AdePg3TIpF/vrcbatCz9Ryk9P
 lJ93e1qKFBBcwbVJ/m/Y3dqocGSczR4YaIgXM3ANPujq4vRb3mAdy3KrnVggYWmOra2q
 r7Ifud3wz5+roB4iz0JrZqLxbf+6yvNhuyljskccUYjHGkiKHWXsalenMMQKWZ6FyYRH
 9rxnXry+rH2oGp9PZC0/IEjWWosczn91DE6A2Z+dzeVPXnz8/REAnLtxkuco5r91z41u
 8saQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754705342; x=1755310142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONKYNaPJrdTl7+BQENWBF2JNd5j5K7JNI+H0Ss3Ur8k=;
 b=qGKZOCSTD+BvFr1tiZDzUb9FHcMuwySCWVCaQjREI1fHtijrCynCJIHvoxAT4+Apct
 qnwYDqmfYhCpJK/BaqWA2nq83S4XdvtugqALUEz/2d0h7EqBYqUEjNetXs2NgsBQ1oS2
 SFfj8IK04v35ifU2UPYPDlrIYfiG4RoOVmhWbwbmA0+XHqjpV3506jh3638T+BhnU1TK
 2bDphK1yPLkOoY/RBE9W/GYklcVYBwS8YWZMcjUV8xcxODisXEYJlY5hurZcZONnmRsB
 aGPTM6Tn+8QNO5GbtXg3KCKX4JzbtXMXKUhtaSbpxLZLz85uzWmkAGOpvppHF1GkPqjD
 /tCQ==
X-Gm-Message-State: AOJu0YymPDJxXLDTt+5FuW9THmiMJFlwKnOHubZoNPJvcXPd1UJSTbSx
 VN4hIYy2VIhWu9mXfiOpeXd7QyY62EioEBEDxEutFHfvXIHrnAgJiX0MhSbw4laLBvSvDjuUXmv
 RvjlZlrDx2xEqe3kQOftWSNnBUi6OEFw=
X-Gm-Gg: ASbGncuCJI5tpU8HCdku832FenMdkj25Q/LrbSVyoHUt/7PxBlKNx16700YMGNxoQhY
 SRLbjWQ8ZJwbkOHqtPiREMc0HCwZeqNjGAWFhH5vET3eE2gIjI0lsCQjHphB3dPjilbvU2zZvkZ
 aow14DCHGRJ8U8XfmrBfGy++OVTVeazrOBNkHsohbyKATgOUS1fobeEtHPfuUjDoXG0JiJgD7lr
 Uz10oHb
X-Google-Smtp-Source: AGHT+IHkdCveC1c1heJycqpFPaO2zS3nK26RQO2YAebqmEQbyhDQLGWO0DtTSZk2hoTVq8tnmCiQUqwvC8MEEGLwfUg=
X-Received: by 2002:a05:6102:449a:b0:4eb:efc6:740 with SMTP id
 ada2fe7eead31-5060eae45cemr2300845137.18.1754705341668; Fri, 08 Aug 2025
 19:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250729125022.4220-1-aristo.chen@canonical.com>
 <20250729125022.4220-5-aristo.chen@canonical.com>
 <cec9682a3821dc6d0c95ad0fbe91106e2fde4923.camel@phytec.de>
In-Reply-To: <cec9682a3821dc6d0c95ad0fbe91106e2fde4923.camel@phytec.de>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Sat, 9 Aug 2025 10:08:25 +0800
X-Gm-Features: Ac12FXxd7YjrWAK-PKa_DL_yadow9rbGVXU952OjibIBaO75lkJBJXKJ9lI5OfM
Message-ID: <CAJwFiGJSgys8ZTo+A8iOx0W5m790tmpK9vg2ELm7GV5z582EfA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] tools: mkimage: detect overlapping load regions in
 FIT configurations
To: Yannic Moog <Y.Moog@phytec.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "sjg@chromium.org" <sjg@chromium.org>,
 "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, 
 "al.kochet@gmail.com" <al.kochet@gmail.com>, 
 "paul.henrys_ext@softathome.com" <paul.henrys_ext@softathome.com>,
 "bb@ti.com" <bb@ti.com>, Wadim Egorov <W.Egorov@phytec.de>, 
 "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>, 
 "n-francis@ti.com" <n-francis@ti.com>, "afd@ti.com" <afd@ti.com>,
 Daniel Schultz <D.Schultz@phytec.de>, 
 "d-gole@ti.com" <d-gole@ti.com>, "ravi@prevas.dk" <ravi@prevas.dk>, 
 "carlos.lopezr4096@gmail.com" <carlos.lopezr4096@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 09 Aug 2025 06:48:41 +0200
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

Yannic Moog <Y.Moog@phytec.de> =E6=96=BC 2025=E5=B9=B47=E6=9C=8831=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Am Dienstag, dem 29.07.2025 um 12:48 +0000 schrieb Aristo Chen:
> > This patch adds a validation step in mkimage to detect memory region
> > overlaps between images specified in the same configuration of a
> > FIT image. If any overlaps are found, the tool prints an error and
> > aborts the build.
> >
> > This helps prevent runtime memory corruption caused by conflicting
> > load addresses between images.
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > ---
> >  tools/fit_image.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/mkimage.c   |  3 +-
> >  2 files changed, 80 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/fit_image.c b/tools/fit_image.c
> > index 331be5ae71d..d0061adf051 100644
> > --- a/tools/fit_image.c
> > +++ b/tools/fit_image.c
> > @@ -22,6 +22,22 @@
> >  #include <version.h>
> >  #include <u-boot/crc.h>
> >
> > +#define MAX_IMAGES_PER_CONFIG 16
>
> How did you get this number?
>
> If this is arbitrary, add to the error message below that if someone need=
s more
> images, they can increase the size.
Yes, it is an arbitrary number, I am planning to dynamically allocate
the memory to solve this concern. Otherwise,
we may need to add a new variable to allow the user to modify the
value of the variable?
>
> > +
> > +struct fit_region {
> > +     ulong load;
> > +     ulong size;
> > +     const char *name;
> > +};
> > +
> > +static int regions_overlap(struct fit_region *a, struct fit_region *b)
>
> Nit: can you constify these?
>
> > +{
> > +     ulong a_end =3D a->load + a->size;
> > +     ulong b_end =3D b->load + b->size;
> > +
> > +     return !(a_end <=3D b->load || b_end <=3D a->load);
> > +}
> > +
> >  static struct legacy_img_hdr header;
> >
> >  static int fit_estimate_hash_sig_size(struct image_tool_params *params=
, const
> > char *fname)
> > @@ -775,6 +791,8 @@ static int fit_import_data(struct image_tool_params
> > *params, const char *fname)
> >       }
> >
> >       fdt_for_each_subnode(node, fdt, confs) {
> > +             struct fit_region regions[MAX_IMAGES_PER_CONFIG];
>
> init to {0}?
>
> > +             int img_count =3D 0;
>
> Nit: use unsigned
>
> >               const char *conf_name =3D fdt_get_name(fdt, node, NULL);
> >
> >               for (int i =3D 0; i < ARRAY_SIZE(props); i++) {
> > @@ -798,6 +816,66 @@ static int fit_import_data(struct image_tool_param=
s
> > *params, const char *fname)
> >                                       ret =3D FDT_ERR_NOTFOUND;
> >                                       goto err_munmap;
> >                               }
> > +
> > +                             ulong img_load =3D 0;
> > +                             int img_size =3D 0;
> > +
> > +                             if (fit_image_get_load(fdt, img, &img_loa=
d))
> > {
> > +                                     fprintf(stderr,
> > +                                             "Warning: not able to get
> > `load` of node '%s'\n",
> > +                                             img_name);
> > +                                     // Skip checking the components t=
hat
> > do not have a
> > +                                     // definition for `load`
> > +                                     continue;
> > +                             }
> > +                             const char *img_data =3D fdt_getprop(fdt,=
 img,
> > +
> > FIT_DATA_PROP,
> > +
> > &img_size);
> > +
> > +                             if (!img_data || img_size =3D=3D 0)
>
> be consistent, use !img_size
>
> > +                                     continue;
> > +
> > +                             // Check if we've already added this imag=
e to
> > avoid duplicates
> > +                             bool already_added =3D false;
> > +
> > +                             for (int k =3D 0; k < img_count; k++) {
> > +                                     if (strcmp(regions[k].name, img_n=
ame)
> > =3D=3D 0) {
>
> same here, !strcmp should do, right?
>
> > +                                             already_added =3D true;
>
> You can simplify and do continue; here?
> Avoids the already_added variable.
>
> > +                                             break;
> > +                                     }
> > +                             }
> > +                             if (already_added)
> > +                                     continue;
> > +
> > +                             if (img_count >=3D MAX_IMAGES_PER_CONFIG)=
 {
> > +                                     fprintf(stderr, "Too many images =
in
> > config %s\n",
> > +                                             fdt_get_name(fdt, node,
> > NULL));
> > +                                     break;
> > +                             }
> > +
> > +                             regions[img_count].load =3D img_load;
> > +                             regions[img_count].size =3D img_size;
> > +                             regions[img_count].name =3D img_name;
> > +                             img_count++;
> > +                     }
> > +             }
> > +
> > +             // Check for overlap within this config only
> > +             for (int i =3D 0; i < img_count; i++) {
> > +                     for (int j =3D i + 1; j < img_count; j++) {
>
> Nit: unsigned here as well
>
> Yannic
>
> > +                             if (regions_overlap(&regions[i],
> > &regions[j])) {
> > +                                     fprintf(stderr,
> > +                                             "[Config: %s] Error: Over=
lap
> > detected:\n"
> > +                                             "  - %s: [0x%lx - 0x%lx]\=
n"
> > +                                             "  - %s: [0x%lx - 0x%lx]\=
n",
> > +                                             fdt_get_name(fdt, node,
> > NULL),
> > +                                             regions[i].name,
> > regions[i].load,
> > +                                             regions[i].load +
> > regions[i].size,
> > +                                             regions[j].name,
> > regions[j].load,
> > +                                             regions[j].load +
> > regions[j].size);
> > +                                     ret =3D FDT_ERR_BADSTRUCTURE;
> > +                                     goto err_munmap;
> > +                             }
> >                       }
> >               }
> >       }
> > diff --git a/tools/mkimage.c b/tools/mkimage.c
> > index 361711c53b2..3f28918f5cf 100644
> > --- a/tools/mkimage.c
> > +++ b/tools/mkimage.c
> > @@ -520,7 +520,8 @@ int main(int argc, char **argv)
> >                       retval =3D tparams->fflag_handle(&params);
> >
> >               if (retval !=3D EXIT_SUCCESS) {
> > -                     if (retval =3D=3D FDT_ERR_NOTFOUND) {
> > +                     if (retval =3D=3D FDT_ERR_NOTFOUND ||
> > +                         retval =3D=3D FDT_ERR_BADSTRUCTURE) {
> >                               // Already printed error, exit cleanly
> >                               exit(EXIT_FAILURE);
> >                       }
