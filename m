Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B235C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1D53809A4;
	Thu,  6 Feb 2025 13:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BLodIbCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C54DF809A5; Thu,  6 Feb 2025 13:33:45 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74636807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ab7800d3939so30691266b.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845223; x=1739450023; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6XNaAys3i7+WbnZDcMD6OMGbEApCPbAfcUP7kcdHx8Y=;
 b=BLodIbClQgYr8rDYAOJw5N7jXKBOOl99dTp4vqQXn0kEQ0t1nJi1Q2/ATnHqtFoLl8
 fEIYrvwyeiDQnXsPKZf2+2FcBa9Ds/NOyb+kwbsHApsmgypq7lc1MSbqC+ZFzWr5VgMe
 Cnaf12VdYe9UNJSxv9OFH08TfZn2+hByqH6wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845223; x=1739450023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6XNaAys3i7+WbnZDcMD6OMGbEApCPbAfcUP7kcdHx8Y=;
 b=ODFXNdDYHwShPHVudGt/DyMnc8DVbaN8T5hnCeHaw4Ctvzxm/+Xa2TimSZCHC1eEXX
 0KqMF5TLmSMrXua4rzlCFD0Y6qCMx8yUR4p+LJhXUgpCtMZ099gGTgt45lwwbg06KvzW
 ap1sR5BcED/QK2No06NxD4CrD5+cV3rta9h3+uar7Elc3vYDzOj1iBgSc13oG/Su4T+o
 7IMHO8osTalAmNURpTQjCCepWcmJbtijPB+Ql1ayGtV6sGqlnRbFsp5dV3NrNWJXsRCL
 mDdTrdQTa2iuZCkWsShijwJwcIidJsnD1zdh6kXKp4uOCdU/YJXrHAR0nEa2N/QFN369
 GLIw==
X-Gm-Message-State: AOJu0YxtKR4hUQ9Eme6rjM0yg2DiAykUojURtRflNm4z78iV1PXCsE21
 L1jci2+B2XxuMQ7kgJbma2j5z9giAWd1/81sB5C3iFouEOOiWRBvCSRlBWmJTFFoWr+XKJggkRT
 EPalLTUSFx8JwUI0D7yxdN8CI21dX1N7BoWjN
X-Gm-Gg: ASbGncsqUQsRCpHKySKi978QpVDA7arVJawunfeOs9DfMoNmMSTACt/yT5jgLA+g0tF
 r6iU7Spm7+oPMZRzjr/eScEfUxnGVP0nBKTpRZiTVB9Ci3ed+xMsfCk4b4/6h44Jrr84eeOwiwg
 ==
X-Google-Smtp-Source: AGHT+IEjqNOmEEwYhOuGS3mL2mv1TCAXiduG5jgMxxuQYBxDPPbAsHDxHdOIw20Mj7RpxzI9MwOmKzbNfLKRJ7AFzxM=
X-Received: by 2002:a17:907:96aa:b0:aaf:1183:e9be with SMTP id
 a640c23a62f3a-ab75e215547mr716200266b.2.1738845222933; Thu, 06 Feb 2025
 04:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-32-sjg@chromium.org>
 <20250203201036.GT1233568@bill-the-cat>
 <CAFLszTizPJX0pQs9UG7trXXfUbU9CnMzjWOQPMPLx_aeiaqsDg@mail.gmail.com>
 <20250204021411.GE1233568@bill-the-cat>
In-Reply-To: <20250204021411.GE1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:33:30 -0700
X-Gm-Features: AWEUYZkMb1uJFhJC9rRePWm8O5c8rViwHfjxfQHYZJjmuiAnuQz6q-pvaoI9ilc
Message-ID: <CAFLszTiEZnqckUuRW1OvtEv2D_6cL0hQyf9SVMvZNd6EcMFFnw@mail.gmail.com>
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

On Mon, 3 Feb 2025 at 19:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 03, 2025 at 05:38:16PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 3 Feb 2025 at 13:10, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Feb 03, 2025 at 10:42:24AM -0700, Simon Glass wrote:
> > > > We don't need to manually add the PE header, since binutils has support
> > > > for this now. Remove it to simplify the file.
> > > >
> > > > Set the link-target to efi-app-aarch64 so that binutils knows what to
> > > > do. Add rules to pick up the arm64 files.
> > > >
> > > > Make some updates to the link-script for arm64, so this all works:
> > > >
> > > > - Pass  .hash .eh_frame and .reloc sections through to objcopy
> > > > - Put RELA pieces into a single section
> > > > - Put linker lists into .data
> > > > - Embed the dtb
> > > >
> > > > Note that it does not seem to be possible to use this approach with arm,
> > > > so this is left alone.
> >
> > Thanks for looking at all this stuff.
>
> You're welcome.
>
> > > Did you mean x86 in this last comment? I'm not sure about the rest,
> > > either way, so I'll leave it to others to comment on that.
> >
> > No, I mean 32-bit ARM. For reasons I don't understand, it seems the
> > toolchain doesn't support PE on 32-bit ARM.
>
> Ah, OK. Were other parts of this series really laying the groundwork for
> EFI_APP with 32bit arm?

Not intentionally, since I was trying to get the series as small as
possible and still actually get something that boots.

I'm not sure that anyone will want a 32-bit ARM EFI-app. I would much
rather that we had it for completeness, but it seems that the binutils
people were not that interested in it. What do you think?

Regards,
Simon
