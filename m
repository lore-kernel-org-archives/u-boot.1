Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D860CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 19:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B4583927;
	Wed,  8 Oct 2025 21:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V9xlkfbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE3B8392E; Wed,  8 Oct 2025 21:11:18 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B9883914
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 21:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-79d36a6298dso90646a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 12:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759950675; x=1760555475; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4Wp5vVdUQxuT6p/4H2GbnT+JlQbPgLjjBVK8VNc3c0=;
 b=V9xlkfbRqRPY29Zo6Ffg4H9AG/btg4xjK8QRt7qfWjbYfLVMTsiUpVmBvjzS3G1ykX
 hnLcPgMCTLgpckdrxARU4PRr4breqeO7owU/5nRKy1zn5+1MVE1Ua/wAmdgPq5XS7N0w
 94VfQ3l3aGCadqkb7DyR/thqlIIRFl7Mkl+YdZvc+fOPZJaCkruWp6M/NW/Or1QS+KYP
 oNbDlRN4wS6UHHuyU1CLBNIQgLxBf4XpWBt2DQxJ5fwqKwqvf1dZD2Kd6Ppp58vxT/18
 3fT6S3fiTHa5X4p8/CSxW8pZxlWM/H1VIvKlNVDFs7yud5raVfWfvtFxwv5geS3Q9TjO
 /3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759950675; x=1760555475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4Wp5vVdUQxuT6p/4H2GbnT+JlQbPgLjjBVK8VNc3c0=;
 b=IxB0WsCpTm3S5Q8B0FEMwZh9bfUgXjaarzI94rSrkgzVgyQdu4Tre4HMCHfwil4PAW
 emp89yg7ol7ybd+0OkaDVthwLHRurdt4B/xDox5NVjMX17gW9pBssKwJQmifxBsiY/MG
 aUsrFLlQniWXukzq7W40E3FRzC8g+M36qHUvdTyqhcBEx/mxtAS+Si1fU2xRWnfh7WQC
 d7d+4HRdCwIJ6p+kPO3zlMhs880ebpzomBleXFh0yMBd8j4+B4w8aZ/h5ugY1yFUg8RZ
 RtcXHbkRH2zBPbxtZVa0ONjMsLIm4bBryA5zKCXjKIpW9EJbkTorh44T2ech1QRtrXyR
 gT6w==
X-Gm-Message-State: AOJu0YwqsaZ402qjolAV/U2KZAo2PRAy2mzJoumMxNQ9PPnDXfmcCo2j
 X7gmCTjo8PKQysjPmXwPw+Lnp5U8DY+hKK1nhj6RslBcfxbwWMw0uaAUq9UmD3uYBy0+bMYszWO
 X7XOlTrw31edWrBlzlYhs0WfTZ9GcFCmmIHmQE0SWHy8h
X-Gm-Gg: ASbGnct6/Mmoa+Ylsmw1aFKSAKSkvbppTNqcyoMJPTJqp9z0C7Us0FPM5xLZVqe/rc6
 +kDKx6oRu63+1wZI3TW4U8oXPxHOBfglKtPQRmxOq+TQquvBRREd6+cAS3OfkDdH5CVlehkAqqU
 S3tAP9Ln3OPV8bbFqw3zM8SjOIzjadzq9oA8iVroFP49d2ygTf1Rc3hKD6Tudn4bkBtso2iKT8C
 0eUgmjZ/ZP98E4wZVnUwPLCaXi40Wo=
X-Google-Smtp-Source: AGHT+IG+rwTPtJxWpSeRFebq+SLeBU07tXQy+6u31Fi0FOiJJ8rSnWZxDzRJieM9i6gGHUDJhkogg+0ozxKy84mrdpE=
X-Received: by 2002:a05:6830:2a0e:b0:78a:e6ee:a5e8 with SMTP id
 46e09a7af769-7c0df703264mr2770994a34.8.1759950674710; Wed, 08 Oct 2025
 12:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251008174408.381-1-briansune@gmail.com>
 <20251008190713.GH298503@bill-the-cat>
In-Reply-To: <20251008190713.GH298503@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 03:11:02 +0800
X-Gm-Features: AS18NWDr__fEeeKGAsDMrQOz2lSR3PrclkmPADfzhYnAfv5L6TtI5og-0RFa9uM
Message-ID: <CAN7C2SAaia8qV4sx-uMF2Y1GE4GW=WmmgSMHMApW0YoTzTqQOQ@mail.gmail.com>
Subject: Re: [PATCH v1] cmd/dma: documentation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B410=E6=9C=889=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=883:07=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Oct 09, 2025 at 01:44:08AM +0800, Brian Sune wrote:
> > This explains how
> > to use the new U-Boot command 'dmareset'.
> >
> > Signed-off-by: Brian Sune <briansune@gmail.com>
> > ---
> >  doc/usage/cmd/dmareset.rst | 55 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644 doc/usage/cmd/dmareset.rst
>
> This needs to be included in doc/usage/index.rst (alphabetically sorted
> still) in the shell commands section. Also please do "make htmldocs
> KDOC_WERROR=3D1" and make sure there's no complains for v2, I see some
> style issues it will trigger. To build the docs a python venv is

I used the the checkpatch

$ ./scripts/checkpatch.pl v1-0001-cmd-dma-documentation.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#16:
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 55 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

v1-0001-cmd-dma-documentation.patch has style problems, please review.

NOTE: Ignored message types: COMPLEX_MACRO CONSIDER_KSTRTO ENOSYS
MINMAX MULTISTATEMENT_MACRO_USE_DO_WHILE
NETWORKING_BLOCK_COMMENT_STYLE PREFER_ETHER_ADDR_COPY USLEEP_RANGE

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


> suggested and you'll need to pip install -r doc/sphinx/requirements.txt
> -r test/py/requirements.txt.  Thanks!
>
> --
> Tom

The doc uses another checking tools?

Brian
