Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13F0C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 17:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FEB083327;
	Fri, 23 May 2025 19:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="DfZzLF/Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B14EC83335; Fri, 23 May 2025 19:12:29 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93E9F83285
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 19:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: ab1bf04f-37f9-11f0-beb8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id ab1bf04f-37f9-11f0-beb8-005056992ed3;
 Fri, 23 May 2025 19:16:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=rf95P2z43xREJpffZpEPRW3GoSVIACWDTDAbBYBJpPI=;
 b=DfZzLF/YU/aHk8eyRzrByyu0OL/zV7fSinUTreAMtGyZEjBMyx0276+S3C1Xpuo14KtKW/RqrX88c
 +3wQUFFtmB/LaHG72mjLrTKAerIJGWzKZwAfsAPZjmCsUOd+MbsBH6OV3UJ0bbKJL11yErCZBYgmU2
 7tL8Njiz5g258Ox3k7UUEe5AZerpX7W5jg0KVTw7wSCn5va5k2dfPlrsSTJ8y4avy/B8T5hVt/b9/L
 wBkN0rwphATI38IVL1a7olXPOYVSPlcZ6B4k9S5k9FKNbibnF+Pll+xKGMho30J4nWVu7O0uf5UtzU
 BfavP+qSn/9ghCpvidgqTrzwy8vlSMg==
X-KPN-MID: 33|sQSB6H6q4YZacd4WSWEXrwEO4a477t9agr+qM1Z6S3T2K5zUhlzt3TIcQqgFAP3
 /P7NaB9dKOnSxmwFBOc9vjczZEF9TcVhCWsxFcji+5Zk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|tbUHSK7ptTm5o5tvP5qxiuyWHlsOlMhQUbqKMF+4eZI7qzTEfYhY2+VkrL00J/1
 h8RkiZI8CaQjVCQ5mWdakDg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 18bf06a0-37f9-11f0-afda-005056998788;
 Fri, 23 May 2025 19:12:25 +0200 (CEST)
Date: Fri, 23 May 2025 19:12:24 +0200
Message-Id: <8734cv45fr.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, xypron.glpk@gmx.de, adrianox@gmail.com,
 bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christian@kohlschutter.com, daniel@makrotopia.org,
 ddrokosov@salutedevices.com, eajames@linux.ibm.com,
 francesco.dolcini@toradex.com, hiago.franco@toradex.com,
 ilias.apalodimas@linaro.org, jdanisevskis@aurora.tech,
 j@jannau.net, jeremy.compostella@intel.com,
 jerome.forissier@linaro.org, maks.mishinfz@gmail.com,
 marek.vasut+renesas@mailbox.org, marex@denx.de,
 mgarrett@aurora.tech, mkorpershoek@baylibre.com,
 michal.simek@amd.com, moritzf@google.com,
 Oliver.Gaskell@analog.com, patrick.delaunay@foss.st.com,
 patrick.rudolph@9elements.com, pkochanowski@sii.pl,
 pbrobinson@gmail.com, philippe.reynes@softathome.com,
 quentin.schulz@cherry.de, raymond.mao@linaro.org,
 semen.protsenko@linaro.org, sebastian.reichel@collabora.com,
 sughosh.ganu@linaro.org, tharvey@gateworks.com,
 vincent.stehle@arm.com, weijie.gao@mediatek.com,
 ziyao@disroot.org, u-boot@lists.denx.de
In-Reply-To: <20250523164909.GV100073@bill-the-cat> (message from Tom Rini on
 Fri, 23 May 2025 10:49:09 -0600)
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
References: <20250523130651.1329593-1-sjg@chromium.org>
 <3b23fc9d-345f-4945-b89d-153a18f5828d@gmx.de>
 <CAFLszTjofbRtjXxfR6MmnHP0hYcpg+pgLKLYDXN2KxLZ2rNPHQ@mail.gmail.com>
 <20250523164909.GV100073@bill-the-cat>
X-Mailman-Approved-At: Fri, 23 May 2025 19:38:13 +0200
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

> Date: Fri, 23 May 2025 10:49:09 -0600
> From: Tom Rini <trini@konsulko.com>
> 
> On Fri, May 23, 2025 at 05:36:52PM +0100, Simon Glass wrote:
> > Hi Heinrich,
> > 
> > On Fri, May 23, 2025, 15:19 Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 23.05.25 15:06, Simon Glass wrote:
> > > > Some functions provided in lib/efi_loader are actually useful for the
> > > > app as well. This series refactors the Kconfig and directories a little
> > > > so that code is easier to share.
> > > >
> > > > As a starting point, it moves some filename and device-path functions to
> > > > the new directory.
> > > >
> > > > The next step would be to move device-path code over, but this will need
> > > > some discussion.
> > >
> > > Hello Simon,
> > >
> > > Overall the ideas in this series look fine to me. But this series does
> > > not apply to origin/next.
> > >
> > > Applying: efi_loader: Separate device path into its own header
> > > Patch failed at 0001 efi_loader: Separate device path into its own header
> > > error: patch failed: cmd/efidebug.c:8
> > > error: cmd/efidebug.c: patch does not apply
> > > error: patch failed: include/efi_loader.h:967
> > > error: include/efi_loader.h: patch does not apply
> > > error: patch failed: lib/efi_loader/efi_bootmgr.c:12
> > > error: lib/efi_loader/efi_bootmgr.c: patch does not apply
> > > error: patch failed: lib/efi_loader/efi_device_path.c:10
> > > error: lib/efi_loader/efi_device_path.c: patch does not apply
> > > error: patch failed: lib/efi_loader/efi_helper.c:6
> > > error: lib/efi_loader/efi_helper.c: patch does not apply
> > >
> > > Please, resend the series based on origin/next.
> > >
> > > Patches that are not based on upstream U-Boot cannot be reviewed via
> > > this mailing list.
> > 
> > The app is quite behind in Tom's tree due to rejected series.
> 
> It was not "Rejected", it was "Changes Requested", please stop
> mis-representing things.
> 
> > In fact
> > the app is pretty limited on x86 and there is no Arm app at all.
> > 
> > My current plan is to move forward and eventually Tom might take it
> > via a pull request.
> > 
> > Do you have any other ideas?
> > 
> > Perhaps this is something we could put on the agenda for a future call.
> 
> There's nothing to discuss in a future call as step one is "post patches
> against mainline".

I agree with Tom here.  I did look at some of the patches in this
series and now that I've learnt it doesn't even apply on top of
mainline it feels like I've wasted my time.
