Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66755CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 12:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA3B8848C5;
	Tue, 16 Jun 2026 14:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AAm+k/H8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21C8B846A4; Tue, 16 Jun 2026 12:17:30 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 113D684105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 12:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A6F9A3F633
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 10:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781605047;
 bh=4Z8dx8ZVUYGUykgCq8qXf/4MVuA0eJDgjE3lGTXXfhU=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=AAm+k/H832FDWa2fSs2BGtRru0GjM26NVNY9CaehY2ow9qd5KIYrzUAcIVcUKuBcU
 hCOeWkWOwsPHLJwP1hP9nZnTvfB9vHO1zXesFmReaKREBysJA1wg/SWrLqMCi3qg5y
 bwPh/zqNbbl8HUBxxB0+A9gHHoRf7Le9vpjxAxFAmsFNhKttCQP6Ncf2qvYUzpGTye
 NQPM++K4NBQv/0j+fOoz1s8prAmlWcFhP++oxjiOxKtotiAISjA+Hafvhhx6hf/XME
 mD/DuvnQQLO4ivQqCIcrVIWg/bhLOOFRM9NaeCXo3eG0O3QTKtpNNMhs0UIo2rp+0s
 yDNituNuFycJR7/k/4J2UV9TIAyKrXntMIdr7bv+RIKkN1BAkw1SYcahMkRfw4d5V1
 MgFpdLIx8q7DPjS6MTDJFbNjMSPks6kQQmzCV0j4QyUXKdcvbTb/qtZBafW1I3YYky
 pG6iObhUus0NMMWCH8eUqgBabO/jqhp7AHQMjA+ayMZJLyLfL3FAuqdUVLKICKYheZ
 jAnTLn0iUIUJgXPi+nb+sPPKg4VvbQE1HNjdWR/TwITXabq6W0VzpEGkJQfG6u6Sga
 V8lLGLxCnZHYkKVdIWmgxz5qr1dQRVHywigIJBtPGGY7gP2PH3zzip7BauMysK8cWC
 XviWeNT4negaProFhPxbqfvs=
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-68d232dc704so4257685a12.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 03:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781605047; cv=none;
 d=google.com; s=arc-20240605;
 b=UfRspbbY0Yv4L7B94CV+AXIwamovzrvQKoQL/Jh+gEh3yP1mvApHqduRu1C36lSVvy
 OanrzWq8NTCunvj0pUkRlp/pGEJEUzhLiTi98YwYXcFhzd/qDG6s+IbMhCRf6CfVECXg
 IWqzipOIIXxH2WtVL/BkBEE7TrL+g0rAUup1kG56W/HZtxe4s1vVWgYXF9CFE3Qjl4S3
 JoMwSE2rdeKWBWJFw3iumbp1/Qui3IWddxQcoo8YvW2i2fI426zwokBFRLGzq1Mng3Su
 K7F2GN4hnTfQE6Iv1DpTgWcmHfo4P6exiSeDeJkUxWItx9ubRnku1h1Lr9sj+YOKw0k0
 vBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=4Z8dx8ZVUYGUykgCq8qXf/4MVuA0eJDgjE3lGTXXfhU=;
 fh=LyxjYsB6YlvtvdB45rC+mR/+KUXxYixPI47TrlqkeUI=;
 b=Ur3osbkwAMmpDHQQTKs9yzDRz0eu0Nn6yGdAS/cJyy5JDRZiEyeSjXfEonyacrxnBp
 r7KhqQEevRyare2bpw3xijbi4LqQXjvdvkT9zmcq+4DHIO3+oRres3gyhE80e9RJ9K+X
 YaZnW27jDCZTuq9QqZaKEeXhDi+ukzjP0p4LMCXqb/VdIqcJCScUtPQCSLIY631bxkzZ
 bQugKoPVlS6b1ZTh1/QiKJOEF1MrfJU8PojV203RHwcu535lWT5FSyOh8LbZGdQKuDMh
 BTddhPikJHp+e3yaPB147V0cTqiVwd3cXqoGwvpDShNd6L27qedWdNB65jrqqF7YsbNO
 32Lw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781605047; x=1782209847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Z8dx8ZVUYGUykgCq8qXf/4MVuA0eJDgjE3lGTXXfhU=;
 b=bxas6Vgs4wPhlAeAkeMk1sgNh8MJlvbHoOi9jTat03qLgRdW+4M9OQhCwipjk8YHXC
 452AIM0m9EehqKcnwwPVXMKifvcZiA+f81CVrQAgPgcDEoeLB/drsT5pGt+NSHd2npuA
 coHRIG1c6MsVttuMLtFNrUhbX7CRV5knukYRqPz8CqOpi+/XzUeE22RsaoEZEKWLNH27
 mEzQbK1O/TEzVXnzpK3jhHbyUpy19hDGksq+EHpvSO+fjPxrYTgUVSpUQAt33cANIuRr
 eqKdataJ0JR/cnRDYPeYzv/IwrRISX/Sz0dGEOqpITNJbJz4fgvANrSdXkNZauLQ/Ou9
 vdQw==
X-Gm-Message-State: AOJu0YyaTHmM1TQE8npvgMtyYqcsM6pt+ZsP057rC2xcMuiQBS6A39qN
 I6bJ44rW08hCtLS5YvAM/XVyfSx1FXNA62JzOlXB44kAUN7MKxFcGB884PCeKi9aRLv4n99ugs3
 pEUPaJ7jkg1jBp3ORYNHtcP1DLlyAEULoBTMDAmzThy7irTYZNG8SfXYwEGqrPL7fYorZfEITIL
 jSxnpb2fIBLxFjG2LZ2+0tCupRcx0NinZZ4jBsnSEp8aQzkw==
X-Gm-Gg: Acq92OHPpcjWZQ5rNGgjSf6oOZxnBNpp9yFwqGTP2hSmoySOtTaAzrbY8KxtIJAOJyl
 iGiplp6snx/3stGjk3J2vWzYyj2Yk54x6kaSaeNNvgGxxyeinyUfVPKWVTdi3mO/De9L4ONEmsN
 qs4l3WtUIg14p1FnSNsGBuhslqmkbvvQ1bGJibP5/KwtDNeQ+/7bIyvR4yjOWs8Rz60QfZ30TNZ
 QwS7KE=
X-Received: by 2002:a05:6402:4493:b0:691:af08:a9fd with SMTP id
 4fb4d7f45d1cf-69378a03b9cmr8464856a12.11.1781605047191; 
 Tue, 16 Jun 2026 03:17:27 -0700 (PDT)
X-Received: by 2002:a05:6402:4493:b0:691:af08:a9fd with SMTP id
 4fb4d7f45d1cf-69378a03b9cmr8464832a12.11.1781605046780; Tue, 16 Jun 2026
 03:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260526020917.8438-1-aristo.chen@canonical.com>
 <20260526020917.8438-2-aristo.chen@canonical.com>
 <CAFLszThhZPJv+WbMWPcMEydZKkQsfU0TzNM=syLBgAkN9SQ=0w@mail.gmail.com>
In-Reply-To: <CAFLszThhZPJv+WbMWPcMEydZKkQsfU0TzNM=syLBgAkN9SQ=0w@mail.gmail.com>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Tue, 16 Jun 2026 18:17:14 +0800
X-Gm-Features: AVVi8CcHy8lqBRUF-v4BRbnv4abv38mnv09n35YPrBDJZjltd4sHnyON_dEnAII
Message-ID: <CAA=k7==pROK1p8iAyJA4eSPVc27deUAeLkzRoAzN1MrtGnZxFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fdt_support: bound serialN alias length before
 copying to stack
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Richard Weinberger <richard@nod.at>,
 Adriana Nicolae <adriana@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 16 Jun 2026 14:26:38 +0200
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

On Sat, Jun 13, 2026 at 2:22=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Aristo,
>
> On 2026-05-26T02:09:13, Aristo Chen <aristo.chen@canonical.com> wrote:
> > fdt_support: validate dma-ranges length in fdt_get_dma_range
> >
> > fdt_get_dma_range() fetches the dma-ranges property with fdt_getprop()
> > and checks only that the length is non-zero before reading one full
> > entry from it. The entry size depends on na, pna and ns cells returned
> > by count_cells, which come from the parent buses in the devicetree.
> > A dma-ranges property shorter than (na + pna + ns) * sizeof(u32) bytes
> > causes fdt_read_number() and fdt_translate_dma_address() to read past
> > the end of the property within the FDT blob, an out-of-bounds read of
> > attacker-influenced data when the OS devicetree is not signature
> > verified.
> >
> > Reject the property when its length is smaller than one full entry and
> > return -EINVAL, matching the existing failure paths in this function.
> > Use debug() rather than printf() for the rejection text so that
> > production builds do not pay any .text or .rodata growth for the new
> > diagnostic.
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> >
> > boot/fdt_support.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
>
> > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > @@ -1640,6 +1640,13 @@ int fdt_get_dma_range(const void *blob, int node=
, phys_addr_t *cpu,
> > +     if (len < (int)((na + pna + ns) * sizeof(*ranges))) {
> > +             debug("%s: dma-ranges too short for %s\n", __func__,
> > +                   fdt_get_name(blob, node, NULL));
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
>
> The bound looks correct: fdt_read_number() consumes na cells, the
> translation reads pna cells from ranges + na and the size read covers
> ns cells, so one full entry is na + pna + ns cells.
>
> As a follow-up, dm_test_dma_ranges in test/dm/read.c already exercises
> dev_get_dma_range() and the -ENOENT path. Adding a node with a
> truncated dma-ranges to the sandbox DT and checking for -EINVAL would
> cover the new path. What do you think?

Sounds good to me, I will look into adding that as a follow-up.

>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Regards,
> Simon

Best regards,
Aristo
