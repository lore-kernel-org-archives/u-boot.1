Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F31DCD68E8
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 09:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D70BC86C9B;
	Tue, 10 Oct 2023 11:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DAZ7uzDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F85986DAF; Tue, 10 Oct 2023 11:05:59 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1CFE86C67
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 11:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-538e8eca9c1so9426936a12.3
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 02:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696928757; x=1697533557; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoVBGch+433sgA+5DA/zxJ0ybmHyPSq7qyG7U6/Rik4=;
 b=DAZ7uzDrcbVMF01yupir8mgAj+yoIM8fbXscDDI482bGCxCQBY1wIo+78PfinF6E84
 xQx8GpN3ZmLf5uxrhvTYDDSvDA2vImpSJm5U8ThPmgVPXU3VrWb+Os0WKm+bBC3qZvhd
 kI9cl012FozRE8PT5qO9ioP38p3chQYilN96H29Ckfy69f6xRQXYjt8AG/97oob48TsO
 i9B0z5vBL6dQ2qSPl4p2AYouqo29gpMAOCv0V71PKB3vn+lUC/UFsF0EKHMV7gnWeM6p
 M9JsHz0uA+s1iJ6ecGu3MxHZB5c3cGPimXXj1A9bLqKHDgNfL2BLuL4y9+QpfpK2P9aj
 inVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696928757; x=1697533557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QoVBGch+433sgA+5DA/zxJ0ybmHyPSq7qyG7U6/Rik4=;
 b=pjRx7jEhCqq2LJaHQLoodz4Xu94bxiFJ1EqzhhBX1yGCNmZL3faVJuoQwyk+Uqxi0T
 2Z8k2c6AMTXWskZuCQKuc4lZm3em5i46flTTU40NYLuk5U/lJenDy8jlitZUtLAfjYJy
 xyRJc2en6pUYDd7pIJFEhQgPT5Hh7XKjPDyHsdVytlMhp5kh3jk698Ml5/cYE/mnUFvs
 ch+TsLmVX5Q+AuLpvcINAngaWeUpRA2Y1C2ge53NbVUDNdFssi2P+DHh/kfi7/pBAAQF
 kS+sPId18vJjS1TSFgVHVdWY3NOQXtjd7MNd/wUvJwLq6JuYmaZq7jZDCW0gauGFHCjm
 Azwg==
X-Gm-Message-State: AOJu0Ywf9SfIYAZk9y9CfNFRGqlcg7ujBXj5Worv7Hz7eLFm/qOONy5V
 F5ifa9+Op5EdaUNixzfY/EEGxxg86JUtKL3d6hM=
X-Google-Smtp-Source: AGHT+IF2MiSnnNEzVn4kkDMce13yrpcbx0WcGF1qvZP+tQdg7QDL3oNXPzAaxoOFiPgpQaikgyv+QgEagEGCAyzRma8=
X-Received: by 2002:a17:906:151:b0:9a1:cfd5:1f3a with SMTP id
 17-20020a170906015100b009a1cfd51f3amr15082714ejh.13.1696928756853; Tue, 10
 Oct 2023 02:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-11-bmeng@tinylab.org>
 <CAPnjgZ082BzO4AGXvYqkaZPC_BkF1zc_AAW1zV9k31GnZhwpJQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ082BzO4AGXvYqkaZPC_BkF1zc_AAW1zV9k31GnZhwpJQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 10 Oct 2023 17:05:44 +0800
Message-ID: <CAEUhbmX3hhOkUqj-2bj6BvrmE3zvsbeOtGUMK=mAs+Pg-Ay94A@mail.gmail.com>
Subject: Re: [PATCH 10/15] cmd: blk_common: Use macros for the return values
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng@tinylab.org>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tobias Waldekranz <tobias@waldekranz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

On Mon, Oct 2, 2023 at 9:42=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Bin,
>
> On Tue, 26 Sept 2023 at 02:54, Bin Meng <bmeng@tinylab.org> wrote:
> >
> > Avoid using magic number 0/1 for the command result.
> >
> > Signed-off-by: Bin Meng <bmeng@tinylab.org>
> > ---
> >
> >  cmd/blk_common.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/cmd/blk_common.c b/cmd/blk_common.c
> > index 9f9d4327a9..ad9b16dc09 100644
> > --- a/cmd/blk_common.c
> > +++ b/cmd/blk_common.c
> > @@ -25,18 +25,18 @@ int blk_common_cmd(int argc, char *const argv[], en=
um uclass_id uclass_id,
> >         case 2:
> >                 if (strncmp(argv[1], "inf", 3) =3D=3D 0) {
> >                         blk_list_devices(uclass_id);
> > -                       return 0;
> > +                       return CMD_RET_SUCCESS;
>
> I really don't like this...0 is success.
>
> >                 } else if (strncmp(argv[1], "dev", 3) =3D=3D 0) {
> >                         if (blk_print_device_num(uclass_id, *cur_devnum=
p)) {
> >                                 printf("\nno %s devices available\n", i=
f_name);
> >                                 return CMD_RET_FAILURE;
> >                         }
> > -                       return 0;
> > +                       return CMD_RET_SUCCESS;
> >                 } else if (strncmp(argv[1], "part", 4) =3D=3D 0) {
> >                         if (blk_list_part(uclass_id))
> >                                 printf("\nno %s partition table availab=
le\n",
> >                                        if_name);
> > -                       return 0;
> > +                       return CMD_RET_SUCCESS;
> >                 }
> >                 return CMD_RET_USAGE;
> >         case 3:
> > @@ -49,7 +49,7 @@ int blk_common_cmd(int argc, char *const argv[], enum=
 uclass_id uclass_id,
> >                         } else {
> >                                 return CMD_RET_FAILURE;
> >                         }
> > -                       return 0;
> > +                       return CMD_RET_SUCCESS;
> >                 } else if (strncmp(argv[1], "part", 4) =3D=3D 0) {
> >                         int dev =3D (int)dectoul(argv[2], NULL);
> >
> > @@ -58,7 +58,7 @@ int blk_common_cmd(int argc, char *const argv[], enum=
 uclass_id uclass_id,
> >                                        if_name, dev);
> >                                 return CMD_RET_FAILURE;
> >                         }
> > -                       return 0;
> > +                       return CMD_RET_SUCCESS;
> >                 }
> >                 return CMD_RET_USAGE;
> >
> > @@ -80,7 +80,7 @@ int blk_common_cmd(int argc, char *const argv[], enum=
 uclass_id uclass_id,
> >
> >                         printf("%ld blocks read: %s\n", n,
> >                                n =3D=3D cnt ? "OK" : "ERROR");
> > -                       return n =3D=3D cnt ? 0 : 1;
> > +                       return n =3D=3D cnt ? CMD_RET_SUCCESS : CMD_RET=
_FAILURE;
>
> CMD_RET_FAILURE is OK, but I would prefer not to use CMD_RET_SUCCESS.
> It is 0 and always will be.
>
> It encourages people to do things like:
>
> if (ret =3D=3D CMD_RET_SUCCESS)
>
> instead of
>
> if (!ret)

I see your concern. However we don't change the return value type to
enum, so people can still use

    if (!ret)

I would still defend that we should use CMD_RET_SUCCESS.

This is like EXIT_XXX defined in stdlib.h:

#define   EXIT_FAILURE   1    /* Failing exit status.  */
#define   EXIT_SUCCESS   0    /* Successful exit status.  */

One should use predefined macros whenever possible.

>
> It would eventually creep into everything, including our clean error hand=
ling.
>
> >                 } else if (strcmp(argv[1], "write") =3D=3D 0) {
> >                         phys_addr_t paddr =3D hextoul(argv[2], NULL);
> >                         lbaint_t blk =3D hextoul(argv[3], NULL);
> > @@ -98,7 +98,7 @@ int blk_common_cmd(int argc, char *const argv[], enum=
 uclass_id uclass_id,
> >
> >                         printf("%ld blocks written: %s\n", n,
> >                                n =3D=3D cnt ? "OK" : "ERROR");
> > -                       return n =3D=3D cnt ? 0 : 1;
> > +                       return n =3D=3D cnt ? CMD_RET_SUCCESS : CMD_RET=
_FAILURE;
> >                 } else {
> >                         return CMD_RET_USAGE;
> >                 }
> > --

Regards,
Bin
