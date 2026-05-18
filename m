Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F603CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 09:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 550C883FEE;
	Mon, 18 May 2026 11:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="uQcnNob0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEDFB84119; Mon, 18 May 2026 11:48:34 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DE3CA83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 11:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E83F62328;
 Mon, 18 May 2026 02:48:25 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.Arm.com [10.34.111.147])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87F0D3F632;
 Mon, 18 May 2026 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1779097711; bh=j5OaPcM7nZpLxrLJRbsNrt7i5lLwSOuDEvP+0mUSHoI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uQcnNob0SGqYVpDK5SYB7/7fq9F+Ecyh1X04JvGDYUPRpCOGyXnOLN0xp2LOrA33/
 MQlRjLqlOLWu71z6pB70Y5U3TwNFiTRGm/LZi95tMpvNzKlwfDyijPcVXpANpYYiAv
 VLLNBusz7GbMhuvJJIh4/pynn3XfkSkzjQPzRzn8=
Date: Mon, 18 May 2026 11:48:27 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/2] efi: fix and test hii keyboard layout pointer
 computation
Message-ID: <agrga7jakYcRlzEK@debian>
Mail-Followup-To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260512-layout-pointer-v1-0-c0981e907274@arm.com>
 <B11344DB-FD58-478D-A9BD-5081C48116D3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B11344DB-FD58-478D-A9BD-5081C48116D3@gmx.de>
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

On Tue, May 12, 2026 at 09:05:29PM +0200, Heinrich Schuchardt wrote:
> Am 12. Mai 2026 19:40:32 MESZ schrieb "Vincent Stehlé" <vincent.stehle@arm.com>:
> >- Fix one scaled pointer arithmetic bug in EFI Loader HII implementation.
> >- Enhance the existing EFI HII unit test to catch the bug.
> >
> >The unit test can run on the sandbox with the following command:
> >
> >  ./u-boot -T -c "setenv efi_selftest HII database protocols; \
> >		  bootefi selftest"
> >
> >Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> >---
> >Vincent Stehlé (2):
> >      efi_loader: fix hii keyboard layout pointer computation
> >      efi_selftest: test hii keyboard layouts more
> >
> > lib/efi_loader/efi_hii.c                 |  3 +-
> > lib/efi_selftest/efi_selftest_hii.c      | 67 ++++++++++++++++++--------------
> > lib/efi_selftest/efi_selftest_hii_data.c | 12 ++++++
> > 3 files changed, 51 insertions(+), 31 deletions(-)
> >---
> >base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
> >change-id: 20260512-layout-pointer-29d1cd52c070
> >
> >Best regards,
> 
> Hello Vincent,
> 
> Off the list:
> 
> Did you find any real use for HII protocols in U-Boot except for running the SCT?
> 
> Are HII based EFI applications a thing?

Hi Heinrich,

A fair question indeed, as the HII protocols do not seem to be used that much in
practice.

The UEFI Shell seems to be using them, though, which should be a sufficient
reason to support them, I think.

Those protocols are used as well a little in systemd-boot and iPXE for example,
but as far as I can tell, they are not used at all in Shim, GRUB, Linux, Xen,
the BSDs or Android GBL.

Best regards,
Vincent.

> 
> Best regards
> 
> Heinrich
