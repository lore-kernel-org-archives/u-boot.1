Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4650C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 08:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED45788155;
	Wed,  3 Jul 2024 10:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HBFToNp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4236C8838E; Wed,  3 Jul 2024 10:03:44 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2097988103
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 10:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b06e63d288so23173336d6.0
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719993821; x=1720598621; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XrDagMhq3taCdwnT1nIMvcZQiLLC11yV773P7s4U4rM=;
 b=HBFToNp0UY/9gdi8NH2pAy1Y+ySO7UG8KVFsjSo6srC1QQOyu5xtH259PxORpM/7IJ
 m+rtHcpcG+hp4jSjWiO1i3Kwpnx1whADJGxsSS1AEhfb6ayr2GYes1R+LG7/WqKbY+q/
 C5hfUNwp8JxRIPDT1O9IPPA7GCmFPf1vCUNsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719993821; x=1720598621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XrDagMhq3taCdwnT1nIMvcZQiLLC11yV773P7s4U4rM=;
 b=xQFdSW+pxXZeNlKJom+cMOdNTPufcZFwZ8+AAw3VuFZK1HwfK3J0jCxBk9wqkKXtTl
 qmgCrKHWNc/SnVXa4o/HludoOjuI/6JsyZoUnydR1basKjvPuwSL6c1rxAQgbWWR8ZN8
 OXagUVZaM6TL8upx3KdRyfktfHsBsxkGX3bbrD8lfVf3Vv96A64+G85KJmlrkrGP4a+l
 cebOk4B4mnrjpPjolP1GrOWiWF7aGxvJzmxwtqWTUjy0cbmQLWIZIL/BApCEdeqZdpbc
 ZSKrCyO86yTdVNJqDCEgzlgzU6F/XmIs2WnPJJj6LGCmqabiF/sWn7TWnDAGoZPxdKuo
 8YVg==
X-Gm-Message-State: AOJu0Yzzqex152uA73fclXn87HOJL8N3cY4/99kloPtP1H5ipq099tOU
 YPg2XlsSb+4HlRwjeldG/x77SIebc4e6QydeG0fZ9+AbP16C2vPj66Aul0bI3thWV8NW0Dr3Mdr
 SV25EQ4s1fB475s657Halryz7G5u3G8CIzsIiWxvm0DG9Dks=
X-Google-Smtp-Source: AGHT+IEbPB1V3tRXQ0Xo/xTZTrk8fshsyjpb4Fr3ulRgsWyc4By4H6FPxy+j9/i28I7AzywBt41qE73P/R/QRiIUPqQ=
X-Received: by 2002:a05:6214:f06:b0:6b5:6138:1a54 with SMTP id
 6a1803df08f44-6b5b717970dmr121872356d6.56.1719993821063; Wed, 03 Jul 2024
 01:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTicbbAAcx=Lpt7RxOAktV1Pn9avhLYbT6VXMF3tnZGyQw@mail.gmail.com>
 <20240702190455.GQ38804@bill-the-cat>
In-Reply-To: <20240702190455.GQ38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jul 2024 09:03:30 +0100
Message-ID: <CAFLszTj1Ma5pbYpNdu7_04U9qsPc4eZaaUbCHE_c_+7EbUv5_Q@mail.gmail.com>
Subject: Re: Please pull u-boot-dm/next
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 2 Jul 2024 at 20:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jul 02, 2024 at 04:51:30PM +0100, Simon Glass wrote:
>
> > Hi Tom,
> >
> > This is for -next but we need to figure out the patch I just sent
> > first. I can redo the pull if that patch is acceptable, or you can
> > pick that up first.
>
> I thought you meant the i.MX9 patch, but with that applied before your
> series, CI now fails on those platforms. So yes, lets hold off on
> whatever is causing that for now and rebase to exclude it.

Yes, I see it still fails in CI although it now works locally. I ran
out of time to look at it but I'm hoping that the maintainer will take
a look at the patch.

I also find that buildman retries each build that creates warnings,
including the missing-binary ones. It is mostly a waste of time, so I
would like to figure out a way around that.

For now I will resend the PR without the 'retry' commit.

Regards,
Simon
