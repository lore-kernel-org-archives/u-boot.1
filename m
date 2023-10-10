Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06121CD8CA1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 14:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 088A286C56;
	Tue, 10 Oct 2023 16:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AUUkbZrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64ECF86CF3; Tue, 10 Oct 2023 16:58:43 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8168886DEE
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 16:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9b9a494cc59so966584766b.3
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696949894; x=1697554694; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=01YxeWVc2qlNz6oqWLNzmEL0GKbpz3LoqGpXxDHIFKY=;
 b=AUUkbZrB/IzcGkY73gjlDcB2RYQe1HnCYsEwCJ1zA6p3Kr966ImlbimHGOt/2r8I/o
 +N06ZGnuqgkzKANfgkLJwf49eH98QNnF00jIUdwKEDvwV7t+WScJPJ0kMZyxNHoNm+QC
 HFcHdra0bh12IRxlDhmiTwAQ/OxJV6YxA6WC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696949894; x=1697554694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=01YxeWVc2qlNz6oqWLNzmEL0GKbpz3LoqGpXxDHIFKY=;
 b=xNyWExXQSP+P+d3SZh0nMUZYpPwL46axMU1bkgBz4UexLQki0JCyD0PmhiNOvv2kLW
 jB/pS7pnPmqseZYWo4rEzw8SeDuZZqQm4jeuy3amvgRdBGY4xII9YkXeMCpCrTT4LLAV
 e3Z0KmouuXbojVLW/QxRM1gQZcd+PCR+F1iAJs2l6bLIZswDzuTaEC+OSBEbWWDbtJkH
 aIFVaQBHg/klhyeFg8ZNrLUWRz0/MdzMcLm8HXz8/WxM8KM6+XO4XJMvTGtxyUCQ6ZXG
 Bc4TCG1Bm/JbeDTVfShRoPS498+TJCaJoLOwBhPkSgNqkk91YVpL17KqxVnug6Yn4T/Y
 9Wbw==
X-Gm-Message-State: AOJu0YxQwhGu8w4f9fMbeW30+amL+y/GOIP5P62TuA3GKJ7IqUb9JKS5
 BaxIS3PJwQLJIITxL3OEaiSbkf9pi73kPd82pObZeF1UKIZ3HO2eNhc=
X-Google-Smtp-Source: AGHT+IFzH+sVHZ1ZxaLlfLzLwAbXg1Z7/W5+9RKhG3AfMYoUBPxCyEcyPbJO00vae3pazgaAkgT0UhKKb5ADzfuc+EU=
X-Received: by 2002:a17:906:ce:b0:9b2:a078:4461 with SMTP id
 14-20020a17090600ce00b009b2a0784461mr15404641eji.44.1696949893887; Tue, 10
 Oct 2023 07:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-11-bmeng@tinylab.org>
 <CAPnjgZ082BzO4AGXvYqkaZPC_BkF1zc_AAW1zV9k31GnZhwpJQ@mail.gmail.com>
 <CAEUhbmX3hhOkUqj-2bj6BvrmE3zvsbeOtGUMK=mAs+Pg-Ay94A@mail.gmail.com>
In-Reply-To: <CAEUhbmX3hhOkUqj-2bj6BvrmE3zvsbeOtGUMK=mAs+Pg-Ay94A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Oct 2023 08:58:04 -0600
Message-ID: <CAPnjgZ1uaWkf+yWQ2_UiyYca3fNgLw0izRE0-zm0oeWybc4o9A@mail.gmail.com>
Subject: Re: [PATCH 10/15] cmd: blk_common: Use macros for the return values
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Bin Meng <bmeng@tinylab.org>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tobias Waldekranz <tobias@waldekranz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Bin,

On Tue, 10 Oct 2023 at 03:06, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Mon, Oct 2, 2023 at 9:42=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Bin,
> >
> > On Tue, 26 Sept 2023 at 02:54, Bin Meng <bmeng@tinylab.org> wrote:
> > >
> > > Avoid using magic number 0/1 for the command result.
> > >
> > > Signed-off-by: Bin Meng <bmeng@tinylab.org>
> > > ---
> > >
> > >  cmd/blk_common.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/cmd/blk_common.c b/cmd/blk_common.c
> > > index 9f9d4327a9..ad9b16dc09 100644
> > > --- a/cmd/blk_common.c
> > > +++ b/cmd/blk_common.c
> > > @@ -25,18 +25,18 @@ int blk_common_cmd(int argc, char *const argv[],
enum uclass_id uclass_id,
> > >         case 2:
> > >                 if (strncmp(argv[1], "inf", 3) =3D=3D 0) {
> > >                         blk_list_devices(uclass_id);
> > > -                       return 0;
> > > +                       return CMD_RET_SUCCESS;
> >
> > I really don't like this...0 is success.
> >
> > >                 } else if (strncmp(argv[1], "dev", 3) =3D=3D 0) {
> > >                         if (blk_print_device_num(uclass_id,
*cur_devnump)) {
> > >                                 printf("\nno %s devices available\n",
if_name);
> > >                                 return CMD_RET_FAILURE;
> > >                         }
> > > -                       return 0;
> > > +                       return CMD_RET_SUCCESS;
> > >                 } else if (strncmp(argv[1], "part", 4) =3D=3D 0) {
> > >                         if (blk_list_part(uclass_id))
> > >                                 printf("\nno %s partition table
available\n",
> > >                                        if_name);
> > > -                       return 0;
> > > +                       return CMD_RET_SUCCESS;
> > >                 }
> > >                 return CMD_RET_USAGE;
> > >         case 3:
> > > @@ -49,7 +49,7 @@ int blk_common_cmd(int argc, char *const argv[],
enum uclass_id uclass_id,
> > >                         } else {
> > >                                 return CMD_RET_FAILURE;
> > >                         }
> > > -                       return 0;
> > > +                       return CMD_RET_SUCCESS;
> > >                 } else if (strncmp(argv[1], "part", 4) =3D=3D 0) {
> > >                         int dev =3D (int)dectoul(argv[2], NULL);
> > >
> > > @@ -58,7 +58,7 @@ int blk_common_cmd(int argc, char *const argv[],
enum uclass_id uclass_id,
> > >                                        if_name, dev);
> > >                                 return CMD_RET_FAILURE;
> > >                         }
> > > -                       return 0;
> > > +                       return CMD_RET_SUCCESS;
> > >                 }
> > >                 return CMD_RET_USAGE;
> > >
> > > @@ -80,7 +80,7 @@ int blk_common_cmd(int argc, char *const argv[],
enum uclass_id uclass_id,
> > >
> > >                         printf("%ld blocks read: %s\n", n,
> > >                                n =3D=3D cnt ? "OK" : "ERROR");
> > > -                       return n =3D=3D cnt ? 0 : 1;
> > > +                       return n =3D=3D cnt ? CMD_RET_SUCCESS :
CMD_RET_FAILURE;
> >
> > CMD_RET_FAILURE is OK, but I would prefer not to use CMD_RET_SUCCESS.
> > It is 0 and always will be.
> >
> > It encourages people to do things like:
> >
> > if (ret =3D=3D CMD_RET_SUCCESS)
> >
> > instead of
> >
> > if (!ret)
>
> I see your concern. However we don't change the return value type to
> enum, so people can still use
>
>     if (!ret)
>
> I would still defend that we should use CMD_RET_SUCCESS.
>
> This is like EXIT_XXX defined in stdlib.h:
>
> #define   EXIT_FAILURE   1    /* Failing exit status.  */
> #define   EXIT_SUCCESS   0    /* Successful exit status.  */
>
> One should use predefined macros whenever possible.

I agree except for success, where I don't, sorry. It should always be 0 in
U-Boot.

People then have to look up the value and also we get things like

if (ret !=3D CMD_RET_SUCCESS)

It is a slippery and I would rather not start down it.

>
> >
> > It would eventually creep into everything, including our clean error
handling.
> >
> > >                 } else if (strcmp(argv[1], "write") =3D=3D 0) {
> > >                         phys_addr_t paddr =3D hextoul(argv[2], NULL);
> > >                         lbaint_t blk =3D hextoul(argv[3], NULL);
> > > @@ -98,7 +98,7 @@ int blk_common_cmd(int argc, char *const argv[],
enum uclass_id uclass_id,
> > >
> > >                         printf("%ld blocks written: %s\n", n,
> > >                                n =3D=3D cnt ? "OK" : "ERROR");
> > > -                       return n =3D=3D cnt ? 0 : 1;
> > > +                       return n =3D=3D cnt ? CMD_RET_SUCCESS :
CMD_RET_FAILURE;
> > >                 } else {
> > >                         return CMD_RET_USAGE;
> > >                 }
> > > --

Regards,
