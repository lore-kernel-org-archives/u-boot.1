Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69892D3C91C
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EF5D89161;
	Sat, 19 Oct 2024 17:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="JWg6v0LY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90BE289171; Sat, 19 Oct 2024 17:57:53 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 759AA89137
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: d9eb18b9-8da4-11ef-8d4a-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id d9eb18b9-8da4-11ef-8d4a-005056999439;
 Sat, 19 Oct 2024 01:01:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=3tZ3kgETuDdg4A7RM5PLsi4J1/gL1/PbXu1lUMbTXX0=;
 b=JWg6v0LYa7WG/e+EDVmSmTaltM7lEwxEr3jQBdj79I2kBSZ7hdFUBAKoAEMj4be1M5yCD4U+kiPXq
 6DnIZPpk2r2v5wyucKX+2GboUq2jbNqdNLeadEW7s3nr3GZBYvGQ5r2JzNhu3MhMyltxlSei31yC1g
 WeffifIuq/2txI9C12VyMng2sWRMWRgZYiJ/nyUSPxiF/lWymkpm/+9lqopJbMewe/rz6ruCC/M4lk
 57tIawlC8ImRQepeL5OIhMPaxbA79qpmKPFgGEgZFlD2mFMuh2e8Iq7H+CKDZkmKtWL5p8B67UlJ7F
 AGw/8C5kGSk/S5no4W4RX0vmUfS+NyQ==
X-KPN-MID: 33|95h3YJLgiC7f+fvg30m7sxuFABmDPf545ylY2e4TyF68vmLW4r34xbHxJS4MsVN
 +iwczYbQSM3tEzWliVoi26BBJ71KBJ/hFjGOF+mlP0TY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|pw284MDLdrsYnnyy7KVRI3KX4G22lIPZ0t06jczlPZc7W3l01EiokuFXanYY+T8
 AHafiHXcFH1/7EYaiHix7Dw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id d96f30f9-8da4-11ef-890d-00505699d6e5;
 Sat, 19 Oct 2024 01:01:04 +0200 (CEST)
Date: Sat, 19 Oct 2024 01:01:03 +0200
Message-Id: <875xppggnk.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: sjg@chromium.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 mkorpershoek@baylibre.com, sughosh.ganu@linaro.org,
 kettenis@openbsd.org, u-boot@lists.denx.de
In-Reply-To: <ee96c1c0-c1d5-4f18-a1eb-f6460e859683@canonical.com> (message
 from Heinrich Schuchardt on Fri, 18 Oct 2024 19:26:01 +0200)
Subject: Re: [PATCH v2 2/2] sandbox: add bootmethod EFI boot-manager
References: <20241018011837.126813-1-heinrich.schuchardt@canonical.com>
 <20241018011837.126813-3-heinrich.schuchardt@canonical.com>
 <CAFLszTjjF1r4f6NjrYSFz36DK_X6v6rYMwDCUqiSLOPysGRC7g@mail.gmail.com>
 <ee96c1c0-c1d5-4f18-a1eb-f6460e859683@canonical.com>
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

> Date: Fri, 18 Oct 2024 19:26:01 +0200
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Hi Heinrich,

> On 10/18/24 19:21, Simon Glass wrote:
> > Hi Heinrich,
> > 
> > On Thu, 17 Oct 2024 at 19:18, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> The EFI boot-manager is the default method to boot EFI binaries.
> >> We should be able to use it on the Sandbox.
> >>
> >> * Enable EFI boot-manager bootmethod on the sandbox.
> >> * Adjust unit tests to reflect the additional boot method.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >> ---
> >> v2:
> >>          no changes
> >> ---
> >>   arch/sandbox/dts/test.dts |  4 ++++
> >>   test/boot/bootmeth.c      | 28 +++++++++++++++++-----------
> >>   2 files changed, 21 insertions(+), 11 deletions(-)
> > 
> > This is better, but I still see this.
> > 
> > => bootflow scan
> >       efi_var_to_file() Cannot persist EFI variables without system partition
> > 
> > Please find a way to get rid of it. I can give some suggestions if you like.
> > 
> 
> Would you, please, mind providing a rationale why you want this correct 
> message not to be written.

To me, warning about persisting EFI variables only makes sense if
you're actually trying to persist an EFI variable.  But all we're
doing here is scanning for possible bootflows.

> I expect the sandbox to behave as any other board and provide warnings 
> when they are adequate.

The warning doesn't make sense to me on non-sandbox boards either.

I suspect this is the code that autogenerates EFI Boot options, so
code that sets Boot#### EFI variables.  But do we really care that we
can't make those persistent?  The code will just regenerate them upon
the next boot...
