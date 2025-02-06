Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D04C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 21:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F82780EEB;
	Thu,  6 Feb 2025 22:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XWYTKvY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFED680EEF; Thu,  6 Feb 2025 22:32:19 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA5A80C6E
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 22:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f9e415fa42so2471988a91.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 13:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738877536; x=1739482336; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WQ3hH/6IbNDxwKB2Ljr1aqF2nzFrcdYsA+Xs1oH4ymk=;
 b=XWYTKvY+g2Gcu+GIRPUgPJukMelf/B/qryVNGzDfBrr65lhuUg9Ve8oQUAQaDFOFsM
 vzbei2pjngyPkP2g8QYRdmSQCyIkMMaYBnanp20+v1OMNEfdO6jdEDiTcWgrXLE4Cjxk
 xg+/lzu/2yd/hcTh3X04CCymKfMcfP1dVj3KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738877536; x=1739482336;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQ3hH/6IbNDxwKB2Ljr1aqF2nzFrcdYsA+Xs1oH4ymk=;
 b=YXhBJKCgTAdZ32fqZ7+mlefBDfbNXZx0tqUMG/z7c8Ct6mtnNrFzlBPcE1NQoOSyY7
 YlULKWw9ujBYVD/kvRRnCvWEbhoPBGmh8oddWtMolDw34/BA000G911xCaK1rwjlc8l3
 wWNLj8qz0GwUBUKES6qukgNU78L/j0Lzlrde3NtqGstXYyL9w0IWNXaHCB1B5gvnNcvU
 MC3UZ93E63Yze3cBJoGqM4Tabo3886st+NW5WztaCfSAVlhmFjqWK9JjWjfugorQ6jHg
 rXrrOGs/w9IAUX/CvNGq+SOdzVhh1/dFxte06BdUyo1vNjpGi8Av/ra0yOX0chfN/sKR
 Gc7A==
X-Gm-Message-State: AOJu0YwO52z17YDkQo79ZMrR3K4ZC4A9RfEKWlOjkkZYIgvf0NJbYrQu
 GyreEMm+rUMm97yaC+VDT9VUstIBi1APikY0xGrK4H4jSjI3gT2KSQRBmM/AItYMo7dV0IZBoUm
 3j2bF8eYYWakhNr1UqqEwuUnJ4dJm6Zo/+brl
X-Gm-Gg: ASbGncvddoHqi9m8tO6kGXMM9FI07iwLV1aF5QynsOtfl2kedHMr4adHwzxpMa1WeoQ
 b0R9vfNrDaqGKpCUg51r6sGT5zjmT9wKnPTBAll6zGn5w45jkpt945iQwzdXZBzha20ipPowCDQ
 ==
X-Google-Smtp-Source: AGHT+IHKWceOvETcZ1l+fzpbS7MgwArD96qaxV/Jm+j1NZzNSUe9Xa3eRQwHeEWPI/xPS6uSkm8j78wpZhRZ152UARQ=
X-Received: by 2002:a05:6a00:340a:b0:724:59e0:5d22 with SMTP id
 d2e1a72fcca58-7305d539f85mr1626606b3a.20.1738877536091; Thu, 06 Feb 2025
 13:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-32-sjg@chromium.org>
 <20250203201036.GT1233568@bill-the-cat>
 <CAFLszTizPJX0pQs9UG7trXXfUbU9CnMzjWOQPMPLx_aeiaqsDg@mail.gmail.com>
 <20250204021411.GE1233568@bill-the-cat>
 <CAFLszTiEZnqckUuRW1OvtEv2D_6cL0hQyf9SVMvZNd6EcMFFnw@mail.gmail.com>
 <20250206170807.GI1233568@bill-the-cat>
In-Reply-To: <20250206170807.GI1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 14:31:59 -0700
X-Gm-Features: AWEUYZlsQrUqaQulUmT3YXwfLijDnUBHdER8tdS1w9MCfQ364fu2ONFMxNpZ9Pc
Message-ID: <CAFLszThRD3d-mSOauJ7W2qwsVUoa=ppYBvUbY88wsugFFjtRdQ@mail.gmail.com>
Subject: Re: [PATCH 31/32] efi: arm: Simplify the crt0 file and update link
 script
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 6 Feb 2025 at 10:08, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 06, 2025 at 05:33:30AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 3 Feb 2025 at 19:14, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Feb 03, 2025 at 05:38:16PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 3 Feb 2025 at 13:10, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Feb 03, 2025 at 10:42:24AM -0700, Simon Glass wrote:
> > > > > > We don't need to manually add the PE header, since binutils has support
> > > > > > for this now. Remove it to simplify the file.
> > > > > >
> > > > > > Set the link-target to efi-app-aarch64 so that binutils knows what to
> > > > > > do. Add rules to pick up the arm64 files.
> > > > > >
> > > > > > Make some updates to the link-script for arm64, so this all works:
> > > > > >
> > > > > > - Pass  .hash .eh_frame and .reloc sections through to objcopy
> > > > > > - Put RELA pieces into a single section
> > > > > > - Put linker lists into .data
> > > > > > - Embed the dtb
> > > > > >
> > > > > > Note that it does not seem to be possible to use this approach with arm,
> > > > > > so this is left alone.
> > > >
> > > > Thanks for looking at all this stuff.
> > >
> > > You're welcome.
> > >
> > > > > Did you mean x86 in this last comment? I'm not sure about the rest,
> > > > > either way, so I'll leave it to others to comment on that.
> > > >
> > > > No, I mean 32-bit ARM. For reasons I don't understand, it seems the
> > > > toolchain doesn't support PE on 32-bit ARM.
> > >
> > > Ah, OK. Were other parts of this series really laying the groundwork for
> > > EFI_APP with 32bit arm?
> >
> > Not intentionally, since I was trying to get the series as small as
> > possible and still actually get something that boots.
> >
> > I'm not sure that anyone will want a 32-bit ARM EFI-app. I would much
> > rather that we had it for completeness, but it seems that the binutils
> > people were not that interested in it. What do you think?
>
> I would ignore arm32 entirely and make things depend on ARM64 rather
> than ARM within the series here.

So are you saying I should remove the last part of the commit message
("Note that it does not seem to be possible to use this approach with
arm,
so this is left alone"), or something else?

Regards,
SImon
