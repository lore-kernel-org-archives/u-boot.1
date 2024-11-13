Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE92D462CF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86777891EF;
	Wed, 13 Nov 2024 16:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="DHcDq8a+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C32389269; Wed, 13 Nov 2024 16:57:18 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73B648916C
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 16:57:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 04475fa9-a1d8-11ef-bc49-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 04475fa9-a1d8-11ef-bc49-005056992ed3;
 Wed, 13 Nov 2024 16:57:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=9GhKgn+gL8iZctH2p0TYi+psC0feQqwLMXYnXvYVXeo=;
 b=DHcDq8a+Qe4wn/72PPVSFUIbdDfm81jyXa+gRSoMYxWSXahQ41uGrRwvMeMHeHGlRaoAJ0tSju3G9
 8SUb5zdRBZ+xa8jVCNlsu7iNHSkaAFwHEY1nkyX5S6mS+QgYlcEUmy7+7Bs1+BdF61zoLiL/aLbf8j
 ywLDpvt7zXhiD+ATL9b9VsdcLibZn9EuLessCiI1S5knrNY2/jXE1Uj1gfJQVgCuK3hbqQ6EWHkGxq
 /EZdlvgfz7n7gtr4kLiAo0EU4XW6SWJijNrQ7kbdZc4k3FH1aEwNiZUh2zegitbSA2T2Wzt2Gd+kEn
 1VR7R/TlUmGcuuKsZXA3s1CB3+XDEPg==
X-KPN-MID: 33|uKhuCsxQjIAONTiq0LXgLa6XnaUH0CpSst+f2mEubGLdTc1XMK8OuB8IR1fshJG
 OX3WWCYMZEUO87pJD4auof0yNF7L7tIYSjJxEfXe2Xzs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|JsMl1ZR5vJ9HTSKIy3YzElBo/2FZZ1yBBawjg//fswCwqh8YIwXFY6MSEx2BdSP
 DSWfh04FYje8LaqiskQRuhw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id f3bb9a3b-a1d7-11ef-974e-005056998788;
 Wed, 13 Nov 2024 16:57:15 +0100 (CET)
Date: Wed, 13 Nov 2024 16:57:15 +0100
Message-Id: <87ttcb1604.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: xypron.glpk@gmx.de, j@jannau.net, kettenis@openbsd.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org, u-boot@lists.denx.de
In-Reply-To: <CAFLszTjDaQGaaL9qM_s+oxNrAkGhunGkbAjyR1giEDgnShUfzw@mail.gmail.com>
 (message from Simon Glass on Wed, 13 Nov 2024 07:39:22 -0700)
Subject: Re: [PATCH 2/2] efi_loader: remove non vital devices first
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <20241031-iommu_apple_dart_ordering-v1-2-8a6877946d6b@jannau.net>
 <87zfmi4rzy.fsf@bloch.sibelius.xs4all.nl>
 <4ff61e8e-03c7-42d2-b2fe-8dba1697641f@gmx.de>
 <CAFLszTjDaQGaaL9qM_s+oxNrAkGhunGkbAjyR1giEDgnShUfzw@mail.gmail.com>
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

> From: Simon Glass <sjg@chromium.org>
> Date: Wed, 13 Nov 2024 07:39:22 -0700
> 
> Hi,

Hi Simon,

> On Wed, 13 Nov 2024 at 05:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 11/1/24 21:29, Mark Kettenis wrote:
> > >> From: Janne Grunau <j@jannau.net>
> > >> Date: Thu, 31 Oct 2024 23:48:02 +0100
> > >>
> > >> DM_FLAG_VITAL marks devices which are essential for the operation of
> > >> other devices. Removing these devices before their users can result in
> > >> hangs or crashes.
> > >> This potentially fixes EFI boot of Renesas rcar3 devices. Their clock
> > >> devices (and with this series the dart iommu) are the only devices
> > >> markes as vital.
> > >> The arm boot code already handles devioce removal in this way.
> > >
> > > There is a typo in that last sentence of the commit message (devioce).
> > > Otherwise:
> > >
> > >> Signed-off-by: Janne Grunau <j@jannau.net>
> > >
> > > Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> > >
> > >> ---
> > >>   lib/efi_loader/efi_boottime.c | 1 +
> > >>   1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > >> index 4f52284b4c653c252b0ed6c0c87da8901448d4b4..7db3c95782970f8c06a970a8ee86b1804cd848b6 100644
> > >> --- a/lib/efi_loader/efi_boottime.c
> > >> +++ b/lib/efi_loader/efi_boottime.c
> > >> @@ -2234,6 +2234,7 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
> > >>              if (IS_ENABLED(CONFIG_USB_DEVICE))
> > >>                      udc_disconnect();
> > >>              board_quiesce_devices();
> > >> +            dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
> > >>              dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
> >
> > Simon's patch 6224dc9ba428 ("arm: Remove vital devices last") addressed
> > the same issue for bootm on arm. But what about about other architectures?
> >
> > This logic should be moved to drivers/core/root.c instead of replicating
> > code.
> 
> We could have a common helper, but it should not be in driver/core as
> this ordering is more of a policy decision. Unless we can add a
> parameter telling dm exactly what to do...

But I don't think it makes sense for this to be a per-architecture
policy (like it is now).

Also, not that outside of the testsuite, we currently either do:

  dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
  dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);

or just:

  dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);

and I'd argue that all instances of the latter should be converted
into the latter.  So we really would only have a single policy here...
