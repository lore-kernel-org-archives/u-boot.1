Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18974CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 00:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B02E4848B3;
	Wed,  3 Jun 2026 02:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="UrYnrRmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9171D84868; Tue,  2 Jun 2026 20:34:17 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBB284852
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 20:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-486539875c1so275011b6e.0
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 11:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780425254; cv=none;
 d=google.com; s=arc-20240605;
 b=YRZIvK3qdgBncz5Qc5+iNYX+JED9hW9M7Sdu5/Lqr9j7DDdkckp21ERBPpsBtabNlR
 fKhYp1eyqHQP58nNwCx2ZjQ0ReoTKPVxS3j0O97AKuSBgTvAuXJ24gYyUaTKWGeI6ppT
 6e9PbTisMcrPfQP1pRHbCkP2wifMJSyelv9koi8ySOzE/Li7ExvAmdyj3+ujfzhbx7fB
 bSuPYSmHOfIatwOLXcJDLca8Sk9Oo6EF+eOb/7TqvMPtb51zSFToSJBPbSNlQrt/QlxI
 sEPgPos/fY2Vst78h3WAwftyT8X8IjTLm/mRGHR/R8mu+9I+nQvJXQpsLAd64ZIPVRJu
 Yqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iMI0MorUUEgLktRwIAxWmyybAQAWwZOjI9OQVsiUM8U=;
 fh=eRLhMVYjiCl2rcQv5adzD5Kj+Po2rC6iX/Ox7zWNeow=;
 b=CNtW19ASQggEgObmyyt4kVFEWNRmdDbED97dRyxI2+fZ8f74/wYdRXews2VxfQj8Bx
 DMCXWStNENTSUp5zTQ8KIwgT39GJsbX5bVq2VH8JuKLnwMAxTQFDiG0zvJb3z5bQPCWf
 DJ7R/41Us4GTzgabmV1bYF9X2qLlmbvJosDJxfCEwNtlfNDWLpwNTPSjHr8Up5D0l7/w
 csrsz2pfT1HEPK1GWu9p0fCQwIFfLKN6z1w3gP12lBod7qAXX+wUL2rHEWfFO1cJw+OJ
 nnHYhlHtXi4zVPClYqdOvhzv86H2TXo4k/Rb+FTio3L8w7+IpQDHkyP91hCxydT+YCBw
 ytQg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1780425254; x=1781030054; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iMI0MorUUEgLktRwIAxWmyybAQAWwZOjI9OQVsiUM8U=;
 b=UrYnrRmJTxSsjE+xBSVVpa150+8YcFxALOcd9EZ7Bc77kRr17tC2EJ4Mujos+atsf3
 uUOU8T9VSjfcRiHiRrxX6G06i0U3Ahq2qJqeLsL4ZVYR0/+VA0UX1K8gkw8IJeDM8fJj
 UNjJBj0+il8en3ZtzDPmqpwzkysxgUXCDBmAIqx/v9EBC9KU2wg4Rgjuf5W8NpovbX+2
 Z+JAR6ziaysdqWp5lQG6a+Il9NYkai8pk5R28xOJHFKlFKvYaZK0Wft02LwnHdN9rwMR
 yM6csd1CWeQrqoGpiQDV1ftjwBS+4P/AIciAtvb0H8BRul2PhbwKKASqTePe9y374gDD
 x3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780425254; x=1781030054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMI0MorUUEgLktRwIAxWmyybAQAWwZOjI9OQVsiUM8U=;
 b=fTAgBb/AIaOO9zz/inMqlh5ZmnAAH1QIf3cxuF7j026Ibd5FyFnv/5xMtAqYeft1wG
 pX2pW2xckHM6cxjBXW3W5usWfCVYTav/IH3sy/Hu8r2LmaFA0h/WkaMhLOcLyTyV/dAN
 GRTVmrDlWHw75JSg3ZG360zIc9L67NcdZaiQzXAeooYpdFR4DdiDSjsy+ymL3Eud5Orz
 n2VooYo56wxpNhAijiDcu2xyzHbAdx4m0Ve2cq43pBvDZ0QRx9S41tqMVYztG+KX4eW2
 3mzZny/1lg2ZsKTJgi30xQqDWeWR66MTp0xPUuLg+bPtvXpsI6JygcAqsVeq7v61+n66
 Gjzg==
X-Gm-Message-State: AOJu0YzN6Wy7b3RdH4hBNTWYL+9USYviE0Z7DQYsCPssjLRG9MKDl+9r
 isPONoyMfHTqbTT+L7rfNhDHQl5qa0DFAyea+3fecuaOws48gq7qb0TaGB9pDg44GQ7kpn4YfCC
 s2DaLS3toa8nAJj3OrCPig3sMY12Mg3F0s9+qXVjnDA==
X-Gm-Gg: Acq92OHHbxvdQSXPIPekkNcuxc9OGUBWshewYmV0yAaOVv6ge1/jEj2RoioNdCYLCZW
 DWDl+EZb3pRf1XvCgPBHKwE7ST+aXV1OjKlZsMVkEyxhK0PuqwV08Bmfvx3dx+RPQOG+AMCmGD3
 79B7n6kccK3coVnRbTAKVcITOltzhBn2R7v+WYzUg3xnHy+ihwVKQz7SQ+imlYXwuCkNKGWRjTK
 dDIyTwP5cBwmTUZHZBNk0nrmhfRPJnkvXpTFYLZCTP37FfqfMSPFviOGr3Dv+Wu7h99bvBYv1K0
 y+XshrRrbE7OS4HS9A==
X-Received: by 2002:a05:6808:4495:b0:485:7c70:f724 with SMTP id
 5614622812f47-486572aa61fmr534427b6e.25.1780425253740; Tue, 02 Jun 2026
 11:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260526105300.44523-1-anton@binarly.io>
 <20260527112338.9811-1-anton@binarly.io>
 <CAFLszThthARfp8Srhg0w9qfw6D0=nzLrPf=0-oDWsezQpODqsQ@mail.gmail.com>
In-Reply-To: <CAFLszThthARfp8Srhg0w9qfw6D0=nzLrPf=0-oDWsezQpODqsQ@mail.gmail.com>
From: Anton Ivanov <anton@binarly.io>
Date: Tue, 2 Jun 2026 19:34:02 +0100
X-Gm-Features: AVHnY4KvMEOSzqaf9uBfLaR5X6CYmvmPsxI8IX_lPQ2NVv0n9m2KkS6a_z01Brc
Message-ID: <CAPWaX568x_sWNr3fA6fb8-QQTR3NmkPN673AtTVaq=YqJHVbPA@mail.gmail.com>
Subject: Re: [PATCH v3] image-fit-sig: Validate hashed-strings region size
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, vr@binarly.io
X-Mailman-Approved-At: Wed, 03 Jun 2026 02:23:44 +0200
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

Thank you for the feedback =E2=80=93 all the comments have now been address=
ed.

> Since this is a security fix, please mention in the commit message
> that the OOB read is reachable during signature verification of an
> untrusted FIT

We did it for all five patches, since they are all security fixes.

> and add a test in test/boot/ (or extend an existing
> one) that feeds a FIT with an oversized hashed-strings size and checks
> that verification fails cleanly

We added the test for this, as well as for the patch with the subject
"image-fit: Validate external data offset and size". The other three
patches have no additional tests as they are basic sanity checks with
no logical validation to exercise.

Thank you,
Anton


On Fri, May 29, 2026 at 9:45=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:

> Hi Anton,
>
> On 2026-05-27T11:23:38, Anton Ivanov <anton@binarly.io> wrote:
> > image-fit-sig: Validate hashed-strings region size
> >
> > fit_config_check_sig() reads the hashed-strings property and uses
> > its size value without validation when building the region list for
> > signature verification. A crafted FIT image can specify an arbitrary
> > size, causing the hash calculation to read beyond the end of the FIT
> > image.
> >
> > Validate that the declared strings region fits within the FIT
> > before adding it to the region list.
> >
> > Signed-off-by: Anton Ivanov <anton@binarly.io>
> >
> > boot/image-fit-sig.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
>
> > diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> > @@ -512,8 +512,18 @@ static int fit_config_check_sig(const void *fit,
> int noffset, int conf_noffset,
> >                * The strings region offset must be a static 0x0.
> >                * This is set in tool/image-host.c
> >                */
> > -             fdt_regions[count].offset =3D fdt_off_dt_strings(fit);
> > -             fdt_regions[count].size =3D fdt32_to_cpu(strings[1]);
> > +             int offset =3D fdt_off_dt_strings(fit);
> > +             int size =3D fdt32_to_cpu(strings[1]);
> > +             /*
> > +              * The offset should be already validated by
> fdt_check_header();
> > +              * validate the size here.
> > +              */
> > +             if (size < 0 || size > fdt_totalsize(fit) - offset) {
> > +                     *err_msgp =3D "Strings region is out of bounds";
> > +                     return -1;
> > +             }
>
> Thanks for fixing this.
>
> tools/image-host.c writes string_size =3D fdt_size_dt_strings(fit), so
> the tighter bound here is fdt_size_dt_strings(fit) rather than
> fdt_totalsize(fit) - offset. The latter still permits a crafted size
> that overlaps the structs block while staying within the FIT.
>
> Also, fdt_getprop() is called with a NULL lenp on line 509, so
> strings[1] is read without first checking that the property is at
> least 2 * sizeof(fdt32_t) bytes long. A crafted FIT could shorten
> hashed-strings to make that read go past the property - please can you
> validate the property length too while you are here.
>
> fdt_off_dt_strings() and fdt32_to_cpu() both return uint32_t, so the
> locals would be better as uint32_t (and the size < 0 check then goes
> away). Please move them up with the other locals rather than declaring
> them mid-block.
>
> Since this is a security fix, please mention in the commit message
> that the OOB read is reachable during signature verification of an
> untrusted FIT, and add a test in test/boot/ (or extend an existing
> one) that feeds a FIT with an oversized hashed-strings size and checks
> that verification fails cleanly.
>
> Regards,
> Simon
>
