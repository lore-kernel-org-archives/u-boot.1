Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C467C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 18:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA9A87712;
	Mon,  4 Dec 2023 18:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W27SNadO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 092A98774C; Mon,  4 Dec 2023 18:59:59 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD2E874B1
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 18:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b538d5c4eso43032985e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 09:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701712796; x=1702317596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8KOWg0c793AA36Q8QFZqHeT1AW9T8lmslgvjW44SEH4=;
 b=W27SNadOdRHxwGCj9hxe2ozpICu8rRDhI0iMJxvoUeiuBDIpgd7FTES+vHGFQ4vPFo
 91Ux+34d2mPhSeHNwz0EOLvpbF9mJt1PxrM0UqzGGB9cXRSBjAEeS/juk4CspRmaUOxA
 PtT/nsJs6+pgnEFhWK/naK8D/WpiVZ8V9OvrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701712796; x=1702317596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8KOWg0c793AA36Q8QFZqHeT1AW9T8lmslgvjW44SEH4=;
 b=lD4zXzAmW6riLOKHN94xcv0NNlBBZMtjvf6eVAWinVPgjgIvreFrqOoWpNVTtk2IkO
 +4Voz0kJeEDkVquWxJbaysRJmbz8oEN7i1v1hiNawxEZQcUokSuadr3bRXlCtq55ARui
 d/C/x/jD44zhWCU4YTr/cqoGLaq1+BAZnwCW+GIpzc5khOIUiXC4BHADwVJtp8uab5TQ
 vyxWxOry3loKeX24kYC2n19Xww0/r5WwssisLyZSQy/RiTQcWHxcOvS7hyOKOvNepd3L
 mWm0mu5/YTaBu1rIYiTsYy1qYxlxc7/F3As0d6b8ykbakEHhVWL/RB+hfnC3W6+l3QnE
 l0WQ==
X-Gm-Message-State: AOJu0YxXdruY3SYK3KgmyK/H9mbnBHTXW6Hgk2m+vHCRE9om1liCA8cL
 G9O0jVj70jOHfbiJtRUcjy7T8BIZHC6inaDrmiNObQ==
X-Google-Smtp-Source: AGHT+IG9y2b3x3EFIttbTqFTC6lUNsW8T3erQgdzs+sKqO3l/YGV3YoWT8m4QD4w16gCT+utJ7qEYnOT1+OHrjImBF4=
X-Received: by 2002:a7b:ce0f:0:b0:40c:8ad:1ae5 with SMTP id
 m15-20020a7bce0f000000b0040c08ad1ae5mr1453493wmc.106.1701712796064; Mon, 04
 Dec 2023 09:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com>
In-Reply-To: <20231203153401.GV8402@pendragon.ideasonboard.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Dec 2023 10:59:44 -0700
Message-ID: <CAPnjgZ0XWDO90cq_h6V_EoOX+kmGLBRZwgT5RURCwQBQFONDYg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 Masahiro Yamada <masahiroy@kernel.org>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Nicolas Schier <nicolas@fjasle.eu>,
 Tom Rini <trini@konsulko.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Will Deacon <will@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org
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

Hi Laurent,

On Sun, 3 Dec 2023 at 08:33, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Simon,
>
> Thank you for the patch.
>
> On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > Add a script which produces a Flat Image Tree (FIT), a single file
> > containing the built kernel and associated devicetree files.
> > Compression defaults to gzip which gives a good balance of size and
> > performance.
> >
> > The files compress from about 86MB to 24MB using this approach.
> >
> > The FIT can be used by bootloaders which support it, such as U-Boot
> > and Linuxboot. It permits automatic selection of the correct
> > devicetree, matching the compatible string of the running board with
> > the closest compatible string in the FIT. There is no need for
> > filenames or other workarounds.
> >
> > Add a 'make image.fit' build target for arm64, as well. Use
> > FIT_COMPRESSION to select a different algorithm.
> >
> > The FIT can be examined using 'dumpimage -l'.
> >
> > This features requires pylibfdt (use 'pip install libfdt'). It also
> > requires compression utilities for the algorithm being used. Supported
> > compression options are the same as the Image.xxx files. For now there
> > is no way to change the compression other than by editing the rule for
> > $(obj)/image.fit
> >
> > While FIT supports a ramdisk / initrd, no attempt is made to support
> > this here, since it must be built separately from the Linux build.
>
> FIT images are very useful, so I think this is a very welcome addition
> to the kernel build system. It can get tricky though: given the
> versatile nature of FIT images, there can't be any
> one-size-fits-them-all solution to build them, and striking the right
> balance between what makes sense for the kernel and the features that
> users may request will probably lead to bikeshedding. As we all love
> bikeshedding, I thought I would start selfishly, with a personal use
> case :-) This isn't a yak-shaving request though, I don't see any reason
> to delay merging this series.

OK, sounds good!

>
> Have you envisioned building FIT images with a subset of DTBs, or adding
> DTBOs ? Both would be fairly trivial extensions to this script by
> extending the supported command line arguments. It would perhaps be more
> difficult to integrate in the kernel build system though. This leads me
> to a second question: would you consider merging extensions to this
> script if they are not used by the kernel build system, but meant for
> users who manually invoke the script ? More generally, is the script
> meant to be used stand-alone as well, in which case its command line
> arguments need to remain backward-compatible, or do you see it as being
> internal to the kernel ?

The script as written is internal to the kernel, but I am sure it
could be expanded in some ways. I am waiting to see it merged before
worrying too much about what might happen in the future!

[..]

Regards,
Simon
