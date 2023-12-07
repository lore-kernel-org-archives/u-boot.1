Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87A1C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 14:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C2C6871F0;
	Thu,  7 Dec 2023 15:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B3sBnBXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29578269F; Thu,  7 Dec 2023 15:27:31 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59BD786F40
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 15:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wenst@chromium.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5c5fb06b131so652943a12.0
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 06:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701959248; x=1702564048; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FnUqi8dAEgGMyEzBxdD28hEtaCGQO1gXXHV0T1kN7CU=;
 b=B3sBnBXBimqKC1/jCgHKuAVwnE+3lo0tEubA9AwY/fAEGA4QHzDyvtajmoUMkCXmTz
 CvzU4VJlda7dQdAksImKwgarZw6I0fE469qRIfvhRHo0YIf7ZM6cJUUraiq17lYh7S4v
 OTDBTAd9t0pJbEvQh6+jjoUB/mIJKpHuYp1nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701959248; x=1702564048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FnUqi8dAEgGMyEzBxdD28hEtaCGQO1gXXHV0T1kN7CU=;
 b=jaNajDGdfj1kt/b7D6hR4XKhZeBPxrFVzr1vf5A1W431cR5gUyMQP7LGluHctQL0tW
 snBZMTh68I7rcoA20ExHb0CDEP3F00hCPu9y9Pb3PrrxyXGVuYnd+JVw2qWPkOOGlJSe
 WHFJZnC/7/EVrYE9B7eAXG3VjE6GHUgmzsD9Nl5l+f0N9GxKo1v2Vm8jhfQX+7vml8KY
 lF9Z+qx0aFDRMflYsvuafNFbgILHyx8ZamicPbYTfOAHmOisHeYc97jbxqW+u7/f+pXG
 rAGpLZPcDUa62IMnuKD6CpECX59K5/MqeMw8nYVQ+gfOH6QKRjkyTG7NtpoWeJ5mRwqn
 QWtA==
X-Gm-Message-State: AOJu0YzfXBUBSe3UwUJoxIkXFGnp0w6I+syJLO4Ph1XLUA1JgasJEpqW
 r2B+umEp64X9spqQ+f8FK7cDiQ==
X-Google-Smtp-Source: AGHT+IH8AzbuT3bEW5QtQ3VpbuixskHTKbrXXL1zs3HHhHdzRy4lAaYreOoFMvEXA8A9ADp82mykHw==
X-Received: by 2002:a17:90a:e009:b0:286:6cc0:b918 with SMTP id
 u9-20020a17090ae00900b002866cc0b918mr2087016pjy.79.1701959247711; 
 Thu, 07 Dec 2023 06:27:27 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:e0f4:e383:e626:f567])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a170902654f00b001cfc2d024edsm1507200pln.29.2023.12.07.06.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 06:27:27 -0800 (PST)
Date: Thu, 7 Dec 2023 22:27:23 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org,
 Masahiro Yamada <masahiroy@kernel.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>,
 Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
Message-ID: <20231207142723.GA3187877@google.com>
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203153401.GV8402@pendragon.ideasonboard.com>
X-Mailman-Approved-At: Thu, 07 Dec 2023 15:58:16 +0100
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

On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wrote:
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
> 
> Have you envisioned building FIT images with a subset of DTBs, or adding
> DTBOs ? Both would be fairly trivial extensions to this script by
> extending the supported command line arguments. It would perhaps be more
> difficult to integrate in the kernel build system though. This leads me
> to a second question: would you consider merging extensions to this
> script if they are not used by the kernel build system, but meant for
> users who manually invoke the script ? More generally, is the script

We'd also be interested in some customization, though in a different way.
We imagine having a rule file that says X compatible string should map
to A base DTB, plus B and C DTBO for the configuration section. The base
DTB would carry all common elements of some device, while the DTBOs
carry all the possible second source components, like different display
panels or MIPI cameras for instance. This could drastically reduce the
size of FIT images in ChromeOS by deduplicating all the common stuff.

> meant to be used stand-alone as well, in which case its command line
> arguments need to remain backward-compatible, or do you see it as being
> internal to the kernel ?

[...]

ChenYu
