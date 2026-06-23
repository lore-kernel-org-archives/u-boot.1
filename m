Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BB5CD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 17:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3174C849EB;
	Tue, 23 Jun 2026 19:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gnjtxjdU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574FF849E5; Tue, 23 Jun 2026 17:42:32 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 594DE849BF
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 17:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ECC123F584
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782229349;
 bh=00Ima/pLjBVZ79euCybcE/qS+fJJY3n+ya7J/PXl7Sw=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=gnjtxjdUP+HAYXI/Y7H9AaNLufSAKmnJXsb6KjYVkK8NfEqLh3wyeX9D3XeFdf3UC
 b1o02HMt5gcqP58sTe/4JsbpSbExakBrn+32kJYEuVPUAfxCEXow6xxbw2hxsPQUlx
 j5gdgB+B0/UUBvgqeLcPNtF0Clah+/tMWSBhGNz6VS7cp+iD2Kqf+47eqKJeZJxKMw
 EWqJ72tV2KU0KOmiR5HlltHQievYs7r/2btasLXTPHTe+385RsC25L8cOJBE1Kml4N
 8Stxbfvf9gWgT77pI+zhClcj8VjkyrH03OSV61auV9cc2niKVH9PiAIAM7pvKwC6Bj
 GHP90Tvya8NMVR/Q0XlX1WW0bu/L2MgznfoL71iDZGPK/XPqAmU5SboZHzqGn2pULx
 QvaDDRGMmihzThD54xAPCWFsw0OvdUJIAnvewuIFkPcmeUt8LhgAewI7IZJQC6O1xx
 SJ6DcPcTYDzQeWdl+eetWVbHlLipyl4gJ6ddnHZv/a10LhmPZ4U6wljmqkkcTuOMTM
 f7U/EK/QOZrm/BKL7CUsOBPnbdlxPi7aRIn0CUu7jHbP5fqmSSY6H8taP/YsWHrMZE
 jv5Psso9QWvH69WRM6iC4Nj0P6vCOBz005Jz6xFzAmfOgi4qWUAO5HxWMdlMCucPri
 s1WUS5gR0tFtTb+11XApemL8=
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-695c0775f8aso7180522a12.0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782229349; cv=none;
 d=google.com; s=arc-20240605;
 b=W14gAUU6J96pxbUctbzuLrmnup8FWv0nxyfVtVqh84HD2YCDTp6a1HmiwBTsQCSKU1
 qXJSFQ8deAoPcJNolr28bA0lguVZnp/O3Tk4iy2SKgS25L8cfIMSvgAFPwIeH/jmBGX6
 0c/8L8go6Q5on3pUBatQ6Lxfch2sxRZvrkaGPy0GuMuVLfNyzb4AtEN/hv9We4WDWuBR
 HmJ5es+UGwPrSmqRouOnEWQW1dzZQsYLXKV0qZloqYugJ8FKVZ+rHaQpfMbo/qkSj563
 7i3c7CUfhRGtaujaMoYv09vzAp5Y2u5YEikkVfPpS6j2w7jwPRPc8Ih1nMpt9TdPJFMn
 kT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=00Ima/pLjBVZ79euCybcE/qS+fJJY3n+ya7J/PXl7Sw=;
 fh=RdGkvKMvuRusWJvZUna/mKxw9cwzaobPq8+52GVNl1g=;
 b=KoJLf3s1N6YS0rNTE1lCeJBu3OPVQqlOOfW5IpGpa3CCBsf4IeDwRI57PaAoyn/Se2
 WwyESoQvwp5ePK0r2rKqxCJ5IoYYzgvOJ0DITpu6BovZYr0eSWxyGHVFOwOCehpP1sbn
 7wEZo/iVS1SkvXeXIqaCqru11IytSXMWmJ4a57p6Q3z4SxRVy2zNMB66IS0Nkrz+yEe6
 U+lMik1tx0yM/OJZzik8N35eIwUlj9fD5KDUYAt72HvGx74JyZxxyeN0rxX5jtNZHR0e
 ochoj+bWU3ymbhtq3SOc4DPGCEMjy6dwSO/Q2KJW1Dt2oPDx1oA7nSfSVzc/4P3gMNlJ
 YsaA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782229349; x=1782834149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=00Ima/pLjBVZ79euCybcE/qS+fJJY3n+ya7J/PXl7Sw=;
 b=JDWIXBXLAjvcyJ7yQqoL0VoPCAXDPQd2JVjthwU2x/ja3wzdq3gYMtLZl7/EGtqOc0
 Ua+4gyZYOjS2+uDrmbp4Yc7EWq7H6hYEu2E3iy5Y0NiCCPOSazlii+82BVcS0No9WIRn
 2HRZqaNW1ftSVOOD70JUbxz6xJ2ydJ9mMxM40UGNM7YulqjSZ/ko5Wx88o//igI8TKTO
 7oyha2z5tIwD6kpbBqeS0NU3HVBmRnXlOngbO+pSSjYba8HIsWCae3LkDbPPH68HLclE
 j3O1vvGis7kSI8PV0EkshzAtBRZXx/q8WJXk9BnEOPfAta8oQpRPaROw6uM9zup3f4EP
 bOTA==
X-Gm-Message-State: AOJu0Yw3mN3sa2xr8Q1kZoNl7XpFpbYkxsBCiJwtJSGhTshlevquUWeQ
 DASiZn/sWap2prLLcv2+VlyZYiU04IE0SnZ1DIp+GZI3kz2/pCLv/yNc1ByICwzu3xa8Uxf66Ix
 79Z47ZhXVTYIn2AtD5Y1CnjcJb8mXB91ZSJmJZA/qflfYKedke5BRdJOxtxn0j6ChiM9yz3JlpY
 w794e9WKePIcT6ohQOVmm1wq3J8t/20e9BUsGC5fvotij4Fg==
X-Gm-Gg: AfdE7cl/zkkItzX3geCvT+vVuYc3A0liIt2v6Ih/dRy8LIlQKUOHLtDvEm2vblnWSqp
 P+UHGMQ8hxG9bvdgJmnqYwLWwmSY4uobGQKNRaBfr+MnAJUUlnEqEqorMuGOwH1Vhd2WaKU2BsI
 rwTJm49sdiucmRiOr8VnJ4mEU+W5GZm7tD+1Dse1FRdBNrVbffX2QgKDrT1ry2w6Z7Hag=
X-Received: by 2002:a05:6402:5203:b0:68d:d511:4a9f with SMTP id
 4fb4d7f45d1cf-6970f7bb394mr12887973a12.18.1782229349619; 
 Tue, 23 Jun 2026 08:42:29 -0700 (PDT)
X-Received: by 2002:a05:6402:5203:b0:68d:d511:4a9f with SMTP id
 4fb4d7f45d1cf-6970f7bb394mr12887955a12.18.1782229349196; Tue, 23 Jun 2026
 08:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260621143938.2863-1-aristo.chen@canonical.com>
 <CAFLszTjaFQL2jbAdn=E44iz1OHN=1PDEne9m+nwvRMHWA3y+bQ@mail.gmail.com>
In-Reply-To: <CAFLszTjaFQL2jbAdn=E44iz1OHN=1PDEne9m+nwvRMHWA3y+bQ@mail.gmail.com>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Tue, 23 Jun 2026 23:42:18 +0800
X-Gm-Features: AVVi8CfgsZgXSwG1uEJ_-RWOUc_-uJ6QsqDjal9awEOewXpgrx-2JjG9OMzWSq8
Message-ID: <CAA=k7=nqO5N99YvS1rd-d8k_c-fy=ymoHJMGCj6kow6S6+zFWw@mail.gmail.com>
Subject: Re: [v1,
 0/2] vbe: bound FIT external-data reads against the firmware area
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 23 Jun 2026 19:44:54 +0200
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

Hi Simon

On Tue, Jun 23, 2026 at 11:02=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Aristo,
>
> On 2026-06-21T14:39:32, Aristo Chen <aristo.chen@canonical.com> wrote:
>
> > One open question: should the external-data blk_read() in vbe_read_fit(=
)
> > also be deferred until after the phase has been signature-verified,
> > rather than just bounded?
>
> The bounded read is the right first step. Deferring until after
> verification touches the SPL/TPL/VPL call paths and the bootmeth flow,
> so that could be done as a separate series.

Noted, I will prepare a separate patch set after this is merged

>
> > Patch 2 adds the missing range check ...
>
> This could use a sandbox test that gives vbe_read_fit() a FIT with an
> out-of-range data-position or oversized data-size and checks it
> returns -E2BIG

I will figure it out and send a V2

>
> Regards,
> Simon

Best Regards,
Aristo
