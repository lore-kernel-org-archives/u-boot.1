Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9F5C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 22:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB6886FF7;
	Mon,  1 Jan 2024 23:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HrsbNOYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ED6B8780F; Mon,  1 Jan 2024 23:41:44 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEEB68780F
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 23:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-67fe0210665so44723736d6.1
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 14:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704148900; x=1704753700; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2J8ypaD/PuNY/oTeivQk/FzPUgCQntE6RAXdkqYZLs=;
 b=HrsbNOYC5WxQkbmjUbVtBak3ngQDIVy/gvJxd9WewIBx+wF3XEZV87QZTbwGZrlm20
 WlfZ9WlarTb1pEVArLSTBViv+CvNFQdYgl+jANtlrBTs8ps0FL/GFd9tWuKe8dZ4llYm
 M/+svkFfc9pEf1IvWf51qdOrWuOg5wNPUuP+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704148900; x=1704753700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2J8ypaD/PuNY/oTeivQk/FzPUgCQntE6RAXdkqYZLs=;
 b=nilV4/RdqGBHjuT0WGnbv/xTwppfbRRmtUNl9iQuhrMRGFZ/qHP6c7/kRschfDFb+e
 fHvcFuPYGEdHwDuMLi+EOQHn9fUPo+VSmL+YQ8O+AN673f68evGqKE5a2xZ9H4qILYWk
 pbrpsLPnAxESa3UWU2kVakq1q7aoJ7lZIIMLWRxXbDKbGauy31NLnEdN2jtb6SEyF233
 KjRSdWzD9T42aaap9hvm0RZRhavhvdARGc+sMAgMjJyu8Y/Ze7DjRy6aM27EeRbxp2It
 dJ02I1GKT0GAtqV6VB1P0ftlKxNVJK3Skv3+KEt+8KVmZAQUTKkMDmP2zO4IfRQ0aOzr
 cOtw==
X-Gm-Message-State: AOJu0Yx3lRIQiwZy/XFrLmlAa2pnYSIrFJK2N2DD3JdyIEsyWbO+mY1N
 TsD0Xn3k9qHoFzDJAvQYtmTSGQnZfkvjL4VyRLBLMEG26dV/
X-Google-Smtp-Source: AGHT+IGvuaUH5B3acGQwxkU4QcV2QXm4dHffSq85Ybr5LbpdsfOd+afT8/ABoWYgi5yJqfkoiW6YjaYyH44mVTrq8j4=
X-Received: by 2002:a05:6214:21c8:b0:67a:2493:fdf with SMTP id
 d8-20020a05621421c800b0067a24930fdfmr29041902qvh.17.1704148900678; Mon, 01
 Jan 2024 14:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-5-sjg@chromium.org>
 <3ea1e2b4-8a52-4e20-beb8-6520f7df0139@gmx.de>
In-Reply-To: <3ea1e2b4-8a52-4e20-beb8-6520f7df0139@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jan 2024 15:41:30 -0700
Message-ID: <CAFLszTgJzD0w3GTtkVVYoXkX+r-2_GC+aoxYOK0QTNAiPrkWCQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] smbios: Use SMBIOS 3.0 to support an address
 above 4GB
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Mon, Jan 1, 2024 at 10:34=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 12/31/23 16:25, Simon Glass wrote:
> > When the SMBIOS table is written to an address above 4GB a 32-bit table
> > address is not large enough.
> >
> > Use an SMBIOS3 table in that case.
> >
> > Note that we cannot use efi_allocate_pages() since this function has
> > nothing to do with EFI. There is no equivalent function to allocate
> > memory below 4GB in U-Boot. One solution would be to create a separate
> > malloc() pool, or just always put the malloc() pool below 4GB.
> >
> > - Use log_debug() for warning
> > - Rebase on Heinrich's smbios.h patch
> > - Set the checksum for SMBIOS3
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v4)
> >
> > Changes in v4:
> > - Check the start of the table rather than the end
> >
> > Changes in v2:
> > - Check the end of the table rather than the start.
> >
> >   include/smbios.h |  6 +++++-
> >   lib/smbios.c     | 30 +++++++++++++++++++++++++-----
> >   2 files changed, 30 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/smbios.h b/include/smbios.h
> > index e601283d293..77be58887a2 100644
> > --- a/include/smbios.h
> > +++ b/include/smbios.h
> > @@ -12,7 +12,7 @@
> >
> >   /* SMBIOS spec version implemented */
> >   #define SMBIOS_MAJOR_VER    3
> > -#define SMBIOS_MINOR_VER     0
> > +#define SMBIOS_MINOR_VER     7
> >
> >   enum {
> >       SMBIOS_STR_MAX  =3D 64,   /* Maximum length allowed for a string =
*/
> > @@ -80,6 +80,10 @@ struct __packed smbios3_entry {
> >       u64 struct_table_address;
> >   };
> >
> > +/* These two structures should use the same amount of 16-byte-aligned =
space */
>
> I cannot see from where you take such a requirement.
> By chance it is fulfilled by the current definitions.
> If this a leftover from debugging we should remove it.

Oh, I just assumed it was a requirement, perhaps. Yes we can remove
this, if you like. In fact perhaps we should remove all SMBIOS2 stuff
as a follow-up?

Regards,
Simon
