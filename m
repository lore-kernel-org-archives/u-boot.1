Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3D3C2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 07:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7742688581;
	Fri, 28 Jun 2024 09:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RX+gfHhT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BAE687E3F; Fri, 28 Jun 2024 09:33:02 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED5887E3F
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 09:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-643efaf0786so2676737b3.1
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 00:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719559978; x=1720164778; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjjR/7XuWlrrlViuS8GuBLnVxnV2nfqXOn+Sm+zf5wY=;
 b=RX+gfHhTMRjpM2UWWjkfm7n+QBAlPNHMOS4Sb1Px8GlVL2dqScw80KJU3ZxNsZrmw6
 jBbkuQ9yN0BTu5AuSx8Yv+RCZuCSfbiZsaREMebNpE9/FxJWs4ikCrl9ecBCfcXEZ0ei
 kKSstaHUfFJcmYnscRKCXSQrca62yyDWhQ7sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719559978; x=1720164778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XjjR/7XuWlrrlViuS8GuBLnVxnV2nfqXOn+Sm+zf5wY=;
 b=fFqr/kuKKAECNLD+l4bjy9Sr3vWscsBmA54w8MUgaSZzFYNCDdMitHMLENpZecdWya
 CFzGvFwjtY697veZ7H5iJMvEvxnk0xS2QNC/1yKXFJ17lDTsTnAiWuvNY4mdOisoxCi/
 DXmrWcuPsWWFywvK0yHHnG9EKJpdyqwicNZ7Re6J1ELvJALh8AzYZRv/y6DinZDKKDff
 tWp+Hgmx48KnXxMyK0LkF27P9y1krbHKMVOxhKR4UHKHo0n/OyDfH3Ld923igEybusAJ
 Hrm+pHUWsPVuWyv8yFdF/YfBu85a8YafLwYKTYkfI/3o+sr5yTZL8VxINy2unyM++925
 Ne6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhYlEdsvbgZG0E9ijBBujvHrIBjt4kWSxkyvZU8ALCzLN/obTlSOGRxRPrns4CW/IOSjjEl/vGkQpo8pHxAqOBihxNSQ==
X-Gm-Message-State: AOJu0YxRhok6wKFyY8mymiZWjX5hNfk8ia8/+V2mEsPXB2sdk+TW6K+c
 EMMzj8DBgqcsNpD+2kZzb01RcsdmFo28P6rWxFgcA+ZdMGSNAUeonxwbFDPmsl5XngWMZr+3PFQ
 B+ZUyoMRoZelZorv7r+RoM26ioqqOeYfww8Ip
X-Google-Smtp-Source: AGHT+IHmw+NQmBGakZM2LEF3KJQYFOhYSLBJoq5asEa+fMSQv8lpMo+k4ceA+5lNNeEdoQpUkdOMe1tTuQbKVzjt4DI=
X-Received: by 2002:a81:8583:0:b0:62d:45:4098 with SMTP id
 00721157ae682-643409d8c17mr137411737b3.26.1719559978374; 
 Fri, 28 Jun 2024 00:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240627170629.2696427-1-vincent.stehle@arm.com>
 <13D2D563-69DD-4BD3-8A97-37B39A0B5D52@gmx.de>
In-Reply-To: <13D2D563-69DD-4BD3-8A97-37B39A0B5D52@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Jun 2024 08:32:47 +0100
Message-ID: <CAFLszTgJSW+UO=CPjMazaqeQFSF7GPUDXLuKJCNALboUGqNLzw@mail.gmail.com>
Subject: Re: [PATCH] bootstd: cros: store partition type in an efi_guid_t
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi,

On Thu, 27 Jun 2024 at 20:28, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
>
>
>
> Am 27. Juni 2024 19:06:29 MESZ schrieb "Vincent Stehl=C3=A9" <vincent.ste=
hle@arm.com>:
> >The scan_part() function uses a struct uuid to store the little-endian
> >partition type GUID, but this structure should be used only to contain a
> >big-endian UUID. Use an efi_guid_t instead.
> >
> >Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> >Cc: Simon Glass <sjg@chromium.org>
> >Cc: Tom Rini <trini@konsulko.com>
> >---
> > boot/bootmeth_cros.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
> >index f015f2e1c75..1f83c14aeab 100644
> >--- a/boot/bootmeth_cros.c
> >+++ b/boot/bootmeth_cros.c
> >@@ -148,7 +148,7 @@ static int scan_part(struct udevice *blk, int partnu=
m,
> > {
> >       struct blk_desc *desc =3D dev_get_uclass_plat(blk);
> >       struct vb2_keyblock *hdr;
> >-      struct uuid type;
> >+      efi_guid_t type;
>
> Does Chrome OS only support GPT partitioning?

Indeed.

>
> >       ulong num_blks;
> >       int ret;
> >
> >@@ -161,7 +161,7 @@ static int scan_part(struct udevice *blk, int partnu=
m,
> >
> >       /* Check for kernel partition type */
> >       log_debug("part %x: type=3D%s\n", partnum, info->type_guid);
> >-      if (uuid_str_to_bin(info->type_guid, (u8 *)&type, UUID_STR_FORMAT=
_GUID))
> >+      if (uuid_str_to_bin(info->type_guid, type.b, UUID_STR_FORMAT_GUID=
))
> >               return log_msg_ret("typ", -EINVAL);
>
> struct disk_partition containing a string which is only needed in the CLI=
 instead of the 16 byte GUID was a bad idea to start with. Shouldn't we rep=
lace it or add least add a GUID field instead of first converting to string=
 and than back to GUID?

Yes I agree, it would be nice to fix that.

>
> >
> >       if (memcmp(&cros_kern_type, &type, sizeof(type)))
>
> You could use the guidcmp() macro here.

Regards,
Simon
