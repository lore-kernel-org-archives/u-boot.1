Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9145C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 14:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCEA81671;
	Tue, 11 Mar 2025 15:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X2c4Ouv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F83A81197; Tue, 11 Mar 2025 15:44:28 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DDC8807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 15:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5dc299deb4so4883661276.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741704264; x=1742309064; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmBQXd3PiBHhx119Syx8sAw9xeq2QT+y5nPU2LlIepo=;
 b=X2c4Ouv+iu5N9wuhUZLMdB31JU9eLOyoquEZlJ2gJcwhs9SHo+AAYsTXGbz8n+qbdj
 ngiMzcvHeu1T5KwhDGQDJfuJrSmmjfW7r7kb1ypxWE8cI1K/5gySrV1L+wso8p/y8xoY
 FFnG5zH6Ti/n+ac6+7N83PJvQZc0SsSV8OmCyYymUgMexBmRc6QuFnWmrPElW4//KZIi
 bGeC5Nmv361BBch/nE34KsobxhpA7qsEz3U7triVOH+KRl7Wcvgr9vuw0cogN66NArEG
 Lg4ulgxwmXiymH5uUC7eIasPXziRyEtmYrcHO3Wbh5kGoBZRNiS7IlB8ATdnsYcTDUPd
 vnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741704264; x=1742309064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WmBQXd3PiBHhx119Syx8sAw9xeq2QT+y5nPU2LlIepo=;
 b=syyFOzy/qyetFWyKiH15EJ8qkgweKZPzjDMWsywmeo7aLHcHYkPYIF26XrXulPD7zG
 fW/bUGY0fViCxc4KKIn+OER9C7sighAdRCYmPwMtAM4WresBSzXiGuLP41cezeurSkRL
 NjzFrVjtzxz0nPYQukb0PVpPVHbJc104tF//gvgE2eoR++nlyGkfNCNZIewuLA5Q1kja
 rlpCtgId9ASY+mUt0GHP1NbGJrGCTgTUj6m0F6XnWUscOqD03QeMahvET5rZXI0aTqAg
 qY6qPiKoBkD1msvnb8O/Dc0e5A8FT30opj43PuBUb46naO728M+9j8g/CKbpe+gdB2ar
 bCuQ==
X-Gm-Message-State: AOJu0YweuqadDhZdHosVIMS27T8KMcIkT3r6QZ8RJPuQkd8ipoZVCIOY
 Ws6kb36FbH4kO7iYUMWiMwBek9zkpS/2LSJEBoez34Bk7eZTYr88A1h08Aqd/17ERqMciS0cVSe
 S4WsA/PEpc7DRBdco9ZabT0ajMHXctsPuCLJHIg==
X-Gm-Gg: ASbGnctZx5YKfHxbZkKv6JTR8TJ8CHe9BLJg8jYg+qMtnWcOldzOeL1mtI1zF1f1iJW
 LurMAd723XG3UkQ1Pwv7XKRFmI6SMk+I1o1WqY9rPR9hUqq/I8Tfy5eyU0xYubvFwXYhvn93UiG
 B6CU8e3puYsW1VJ4xtsFxi+5aVvT0=
X-Google-Smtp-Source: AGHT+IGSXdUCEWKVUv/pTH2q/L7d7uX5KglmdZZl3gHI2+bhxkhrai2c2I88fl6j75jeQ4c08EJMkwJSwENLDZePl1A=
X-Received: by 2002:a05:6902:2081:b0:e5a:c837:a8c7 with SMTP id
 3f1490d57ef6-e635c136db5mr22577077276.11.1741704264162; Tue, 11 Mar 2025
 07:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <AS1P250MB060864865460745C69F23D74A9FF2@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <Z7Q43GmC4mpcG249@hera>
 <AS1P250MB0608391F8B37E8E9292205A7A9C42@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <CAC_iWjJ6cbx2CKhEf8iBZoW0R3Hv3WZ=buQXc+RdyJENrfYwtg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ6cbx2CKhEf8iBZoW0R3Hv3WZ=buQXc+RdyJENrfYwtg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 16:43:46 +0200
X-Gm-Features: AQ5f1Jr26AV2uzgdbc-MdmFBcsqDd-5On_yScFDiccUYTtNiUKLxQa_f-5e70Ag
Message-ID: <CAC_iWjL+QOMBPvk+ZGgivDFt+foRcm8WyAzTWTRmEXfXr1xd1Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: fixed the nv_define_space command in TPMv2
To: Michel Alex <Alex.Michel@wiedemann-group.com>, niek.nooijens@omron.com
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

Hi Alex,

++ CC Niek who originally authored this

On Thu, 20 Feb 2025 at 10:27, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Michel,
>
> On Thu, 20 Feb 2025 at 09:14, Michel Alex
> <Alex.Michel@wiedemann-group.com> wrote:
> >
> > Hi Ilias,
> >
> > I don't know where to find the spec for the tpm v2 nv_define command. I=
 was just wondering
> > why this command does not work in u-boot. Then I found a patch, that ha=
s never been
> > applied to the master, see https://lists.denx.de/pipermail/u-boot/2023-=
December/542089.html,
>
> Yes, that patch was useful but unfortunately, it didn't apply to
> -master cleanly and I haven't seen an updated revision since.
> I'll have a look at the tpm specs and figure out why this change is
> working and let you know. You can then send a v2 with a commit message
> that explains why
>
> Thanks
> /Ilias
>
> > where the nv_define's message buf was "fixed". I tried this change and =
the nv_define command
> > is working now.
> >
> > Alex
> >
> > > -----Original Message-----
> > > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Sent: Tuesday, February 18, 2025 8:38 AM
> > > To: Michel Alex <Alex.Michel@wiedemann-group.com>
> > > Cc: u-boot@lists.denx.de
> > > Subject: Re: [PATCH 1/1] tpm: fixed the nv_define_space command in TP=
Mv2
> > >
> > > Vorsicht: Es handelt sich um eine externe E-Mail vom Absender Ilias
> > > Apalodimas <ilias.apalodimas@linaro.org>. Bitte klicken Sie nicht auf=
 Links oder
> > > Anh=C3=A4nge, solange Sie nicht von der Echtheit der Nachricht =C3=BC=
berzeugt sind.
> > >
> > > Hi Michel
> > >
> > > On Thu, Feb 13, 2025 at 12:43:34PM +0000, Michel Alex wrote:
> > > > Added 2 HMAC bytes to the command message
> > >
> > > Please cc the TPM maintainers, otherwise I might miss this patch.
> > >
> > > What the patch does is obvious, can you add a better explanation of
> > > - what it fixes / what was broken?
> > > - pointers to spec that define the hmac size and placement?
> > >
> > > Thanks
> > > /Ilias
> > > >
> > > > Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>
> > > > ---
> > > >  lib/tpm-v2.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c index
> > > > 9ca7933c094..4a082af78af 100644
> > > > --- a/lib/tpm-v2.c
> > > > +++ b/lib/tpm-v2.c
> > > > @@ -264,7 +264,7 @@ u32 tpm2_nv_define_space(struct udevice *dev, u=
32
> > > space_index,
> > > >      * chunks below.
> > > >      */
> > > >     const int platform_len =3D sizeof(u32);
> > > > -   const int session_hdr_len =3D 13;
> > > > +   const int session_hdr_len =3D 15;
> > > >     const int message_len =3D 14;
> > > >     uint offset =3D TPM2_HDR_LEN + platform_len + session_hdr_len +
> > > >             message_len;
> > > > @@ -277,11 +277,12 @@ u32 tpm2_nv_define_space(struct udevice *dev,=
 u32
> > > space_index,
> > > >             /* handles 4 bytes */
> > > >             tpm_u32(TPM2_RH_PLATFORM),      /* Primary platform see=
d */
> > > >
> > > > -           /* session header 13 bytes */
> > > > +           /* session header 15 bytes */
> > > >             tpm_u32(9),                     /* Header size */
> > > >             tpm_u32(TPM2_RS_PW),            /* Password authorisati=
on
> > > */
> > > >             tpm_u16(0),                     /* nonce_size */
> > > >             0,                              /* session_attrs */
> > > > +           tpm_u16(0),                     /* HMAC size */

So looking at this again, and the spec -- we are using a password auth
just above. So the HMAC shouldn't be needed. Any chance this is the
TPM2B_AUTH filed we add and it somehow fixes your issue?

Cheers
/Ilias
> > > >             tpm_u16(0),                     /* auth_size */
> > > >
> > > >             /* message 14 bytes + policy */
> > > > --
> > > > 2.43.0
> > > >
