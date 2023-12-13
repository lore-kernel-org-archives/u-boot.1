Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3404CC41535
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0492A87846;
	Wed, 13 Dec 2023 20:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y8a60jo+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AD4C87824; Wed, 13 Dec 2023 20:52:20 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 874CA87837
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dbcd7d63789so577099276.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497136; x=1703101936; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KKfogzoVpZb2tlRM43epqfmFy12hmPjN1bnwJ3fCyto=;
 b=Y8a60jo+IgGjBE+Sv1mrKPHu2vW0288oqsNOzF5bDwbPb8UnzsbmsmLloVHIfSBIqz
 4neusUcjdzoL+AdUkuA99RJYXDN1ngCTSHCbVghNTEAuZ8JX2gyr181EBiKci3VEvSJ4
 yeW5ql+7pygeFPrsZK0x240jXpcmMklY8csCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497136; x=1703101936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KKfogzoVpZb2tlRM43epqfmFy12hmPjN1bnwJ3fCyto=;
 b=ll6FtAkrZMZiR3T+7G65qvb2PLMunskxdZ6SrVCwNZwXypw4WQH2ITHH36nUSET3w7
 CHZeV3qCFCs1N5fgydPj1f1OvPmfvZggM/kFBQwN6q3qe47Wx1JH5EEHjIjd/eVygZvO
 e0t8EWy3L2D8LN4N2Ez1fnxXcRaLT+EoHvrVYcruEnfExL5agUv+6PtvHHpcDjHbHkIZ
 4UghS7OyHB2N49X3T3irhc95eYg69zaG9PVrPu1C7kWlgToskmMbRDrjw3e8AM8m7tiw
 yDA6Fjhi0ftTqPEl0FAe60+Bu15VmTpkA+c5q6/347ELeyAx2D89ogHePtbrAkx8Wk1V
 QmnA==
X-Gm-Message-State: AOJu0YylbU80n6IS5WiVJ74iAV6EQOATRa9DkCxTOyV9DO0VR9085+ts
 gwmRsaiuaWVUXBXjF5P8y2Dd+RStlW58NAYZ75bSiw==
X-Google-Smtp-Source: AGHT+IHqbYDHpaCgE8cYXaNO/HAig5Zhxlbzg29mV7LibzVy+1iqL6x3TcbT8n70u8+a7ExjgiGiqEFMZ7V1b43tc2M=
X-Received: by 2002:a25:27c3:0:b0:db9:565f:caf5 with SMTP id
 n186-20020a2527c3000000b00db9565fcaf5mr3500102ybn.115.1702497135963; Wed, 13
 Dec 2023 11:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20231202153400.537050-1-sjg@chromium.org>
 <20231202153400.537050-2-sjg@chromium.org>
 <20231209154839.GG2513409@bill-the-cat>
In-Reply-To: <20231209154839.GG2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:50:02 -0700
Message-ID: <CAPnjgZ0TxjEf-CvN_jC-c_7yVMb473YAjy-GH=Zrj6wwb4fqFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] cyclic: Add a symbol for SPL
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Nikhil M Jain <n-jain1@ti.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>, 
 Stefan Roese <sr@denx.de>, Troy Kisky <troykiskyboundary@gmail.com>
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

On Sat, 9 Dec 2023 at 08:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Dec 02, 2023 at 08:33:48AM -0700, Simon Glass wrote:
>
> > The cyclic subsystem is currently enabled either in all build phases
> > or none. For tools this should not be enabled, but since lib/shc256.c
> > and other files include watchdog.h in the host build, we must make
> > sure that it is not enabled there.
>
> This part is what I see as the Wrong Direction. There's some code we
> really need to share with our user space tools, in order to not
> copy/paste the same code. In turn, this code must be as user-space
> friendly as possible. Maybe even we re-factor things a little more, if
> needed, so that we _just_ have the library functions in common files,
> and u-boot or user space only files have the make use of logic. I don't
> feel bad about tools/ needing:
> void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>                 unsigned char *output, unsigned int chunk_sz)
> {
>         sha256_context ctx;
>         sha256_starts(&ctx);
>         sha256_update(&ctx, input, ilen);
>         sha256_finish(&ctx, output);
> }
>
> (and so on for other algos) as a duplicate bit of code. Much less so
> than I do about adding <linux/kconfig.h> to a direct include list (since
> we should never be doing that) so that later on we can if
> (IS_ENABLED(..)) the existing code.

Bear in mind that we have the CONFIG_TOOLS_... options entirely to
deal with the need for tools to enable features in common code. This
SHA thing is a very small part of the code, compared to common code in
boot/ for example.

So is this really a win?

Regards,
Simon
