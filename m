Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EC2C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 08:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD76F80EC0;
	Thu, 20 Feb 2025 09:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ytDRJttI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACFAF80F32; Thu, 20 Feb 2025 09:27:41 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0463B80A46
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so555822276.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 00:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740040058; x=1740644858; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wcQKms0FtrqJxpw3z+KFLr+oNlfTe7mXy64C5mjMO5g=;
 b=ytDRJttIV4VcgGnXB8gAS8GXzkA8A6Vuva6JRdRCAkWrgaWD7Na+B5B7P1KArBBl8c
 nCpE0NBUyvQLQuA01nGxFSfjUUdrSGWB/s8bhjai8HnDmGIGce7dUff2vi0/5kQbvrQB
 sVYPVCPrtrcT6qQl6kIy0oAMclHzPjT3BxRp3q+s+dENJkOZ59FlY7nKjU6u9R8LB+0A
 WcGP/oqypge9Kug+R9CqerMmpfbb7e6CRDLyWbVaXRFiXp0SteveDqVE66z/i8pFFDbn
 24Ntr47Cu0m3Vy+n3/jU5lStnZjDzd1ngeFrI32wcBfB0uL5xxrk3kJkAjcgNl/RVxz2
 TtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740040058; x=1740644858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wcQKms0FtrqJxpw3z+KFLr+oNlfTe7mXy64C5mjMO5g=;
 b=TCV93YLqkooC980orZPJnDrONEQbKSca7mh0o9oXqVFlPH5YkX67cGa4ocpHLIWAEf
 PzZSzYSCJ9iBNCQE5Gj4LhBMfJ9bQ50sYrlJ81Z+7+ttoF69d8C6fzbmGogR+dPKrXvG
 piDSoLs0Y4EV1jBsuvIoXKtsMXvRsRSSxFS/DPI4m4xT4NITCNGNvRnFwcQMf6TGHa0E
 HFPi8EDGFXUpybnC6mTXudRygMSj6E+jMPwkh0ncZ5pqOT9ivJ8bSbLlUrZchZ2WePzq
 UgBml52GzIc21G3V0EvzBFGIylnm45G1YmBFdO225qGi+Uy/awuU4VA2Dbof5RQP+aiU
 AT4w==
X-Gm-Message-State: AOJu0YwS+mVIYS6EwrVVmIzX6pU8+ncRkzzrMjedNtu02mSHZABhabj6
 QowojbFVBZObTRKH+Zizci/ZHUW1/3TegEMHhJ1/GPYboY2xuozSSF9WFuf5TT3LthQQQ7B02CN
 qkwFkB37h7NB56LBM4pa3eCNFwvreH/jAccEKXoEbdcL0imMx
X-Gm-Gg: ASbGncsaJTxMGMXgT8r2l+/lcAay8lDXkVaNfCf589Q4SDsTLkxwWUJU1fZMo0b7UHh
 VAmsXNQpHQXQyxOw548xDCG/kAt8ZGNTWUN9v/ipcbID/+9zNLzkwzhDb2ilwtF2wSbpxn7nlqQ
 ==
X-Google-Smtp-Source: AGHT+IGcx0ikzJo7IOBQ1d0lStFaKyfR0sh3IJr3ysPr0o0FyOgcuByMUa9ZP5g5BsflAa2JCek+7ArhMtq4kNYgyeA=
X-Received: by 2002:a05:6902:e03:b0:e5b:21fe:d9bd with SMTP id
 3f1490d57ef6-e5dc902674bmr16730497276.10.1740040057806; Thu, 20 Feb 2025
 00:27:37 -0800 (PST)
MIME-Version: 1.0
References: <AS1P250MB060864865460745C69F23D74A9FF2@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <Z7Q43GmC4mpcG249@hera>
 <AS1P250MB0608391F8B37E8E9292205A7A9C42@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
In-Reply-To: <AS1P250MB0608391F8B37E8E9292205A7A9C42@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Feb 2025 10:27:01 +0200
X-Gm-Features: AWEUYZmzz880MUhMJKPupToqTZGaMvlNogTEQihWWk_uxd4_ADqk5cJQdhn0V50
Message-ID: <CAC_iWjJ6cbx2CKhEf8iBZoW0R3Hv3WZ=buQXc+RdyJENrfYwtg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: fixed the nv_define_space command in TPMv2
To: Michel Alex <Alex.Michel@wiedemann-group.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Michel,

On Thu, 20 Feb 2025 at 09:14, Michel Alex
<Alex.Michel@wiedemann-group.com> wrote:
>
> Hi Ilias,
>
> I don't know where to find the spec for the tpm v2 nv_define command. I w=
as just wondering
> why this command does not work in u-boot. Then I found a patch, that has =
never been
> applied to the master, see https://lists.denx.de/pipermail/u-boot/2023-De=
cember/542089.html,

Yes, that patch was useful but unfortunately, it didn't apply to
-master cleanly and I haven't seen an updated revision since.
I'll have a look at the tpm specs and figure out why this change is
working and let you know. You can then send a v2 with a commit message
that explains why

Thanks
/Ilias

> where the nv_define's message buf was "fixed". I tried this change and th=
e nv_define command
> is working now.
>
> Alex
>
> > -----Original Message-----
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Sent: Tuesday, February 18, 2025 8:38 AM
> > To: Michel Alex <Alex.Michel@wiedemann-group.com>
> > Cc: u-boot@lists.denx.de
> > Subject: Re: [PATCH 1/1] tpm: fixed the nv_define_space command in TPMv=
2
> >
> > Vorsicht: Es handelt sich um eine externe E-Mail vom Absender Ilias
> > Apalodimas <ilias.apalodimas@linaro.org>. Bitte klicken Sie nicht auf L=
inks oder
> > Anh=C3=A4nge, solange Sie nicht von der Echtheit der Nachricht =C3=BCbe=
rzeugt sind.
> >
> > Hi Michel
> >
> > On Thu, Feb 13, 2025 at 12:43:34PM +0000, Michel Alex wrote:
> > > Added 2 HMAC bytes to the command message
> >
> > Please cc the TPM maintainers, otherwise I might miss this patch.
> >
> > What the patch does is obvious, can you add a better explanation of
> > - what it fixes / what was broken?
> > - pointers to spec that define the hmac size and placement?
> >
> > Thanks
> > /Ilias
> > >
> > > Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>
> > > ---
> > >  lib/tpm-v2.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c index
> > > 9ca7933c094..4a082af78af 100644
> > > --- a/lib/tpm-v2.c
> > > +++ b/lib/tpm-v2.c
> > > @@ -264,7 +264,7 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32
> > space_index,
> > >      * chunks below.
> > >      */
> > >     const int platform_len =3D sizeof(u32);
> > > -   const int session_hdr_len =3D 13;
> > > +   const int session_hdr_len =3D 15;
> > >     const int message_len =3D 14;
> > >     uint offset =3D TPM2_HDR_LEN + platform_len + session_hdr_len +
> > >             message_len;
> > > @@ -277,11 +277,12 @@ u32 tpm2_nv_define_space(struct udevice *dev, u=
32
> > space_index,
> > >             /* handles 4 bytes */
> > >             tpm_u32(TPM2_RH_PLATFORM),      /* Primary platform seed =
*/
> > >
> > > -           /* session header 13 bytes */
> > > +           /* session header 15 bytes */
> > >             tpm_u32(9),                     /* Header size */
> > >             tpm_u32(TPM2_RS_PW),            /* Password authorisation
> > */
> > >             tpm_u16(0),                     /* nonce_size */
> > >             0,                              /* session_attrs */
> > > +           tpm_u16(0),                     /* HMAC size */
> > >             tpm_u16(0),                     /* auth_size */
> > >
> > >             /* message 14 bytes + policy */
> > > --
> > > 2.43.0
> > >
