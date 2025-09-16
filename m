Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C011CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 13:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E82C80325;
	Tue, 16 Sep 2025 15:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="c91lejMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D308309A; Tue, 16 Sep 2025 15:29:36 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A0E18004F
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 15:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cR2n71ZPvz9t6q;
 Tue, 16 Sep 2025 15:29:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758029371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kaTbd51oy+FTt4VoQ5M6c0oG87hwNrXMR6/B4iqYUPU=;
 b=c91lejMg7aznEV2wQTWQzL92ZMNdkQ0wVt5y5d8/VT0Lj6ki3KfcOePvPepCWNOblE1AL8
 6EEAWeEbUtiTY0NXOR0oFnOEASbIA+o36BpycDULzHhspgyC7C7/8uL+qvIqkUIWZxMA8j
 04uVcoCNhA5QVmU6y/3iWO/2hOXzGr9E/Pq8O76ntGvu4Mvk6CS+SSDca7Tcj0Uj0YmjBk
 ebtif3KVFJSg+vxWa8tkGgH/mF2rdnEemW4KcJOSmW/USGZMcRONq6iVU/s0vt6SKHZmE4
 xPL0QRSkDUFdW2/35St3acXjksR+zCoPr5cTgrVlj1mBFcrAjQOBfgTzGrPc2g==
Message-ID: <56857fb6-e3d4-4069-afde-57b43c4d2442@mailbox.org>
Date: Tue, 16 Sep 2025 15:29:28 +0200
MIME-Version: 1.0
Subject: Re: RZG2L and DTB blob from TF-A
To: Mathieu Othacehe <othacehe@gnu.org>, paul@pbarker.dev,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>
Cc: u-boot@lists.denx.de, anton.reding@landisgyr.com
References: <87plbqd0kk.fsf@gnu.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87plbqd0kk.fsf@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: x1g9ey8zmkd6h5s7nhrgn4erudbxhyyt
X-MBO-RS-ID: c2346a400e14bcebfcc
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

On 9/16/25 2:49 PM, Mathieu Othacehe wrote:
> 
> Hello,

+CC Biju, Chris

> I am working on the RZG2L devkit from Renesas and trying to get the
> mainline U-Boot working there.
> 
> I have noticed that in several locations, U-Boot is unconditionally
> expecting the TF-A to pass a DTB blob:
> 
> In board/renesas/rzg2l/rzg2l.c:
> 
> --8<---------------cut here---------------start------------->8---
> static void apply_atf_overlay(void *fdt_blob)
> {
> 	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
>          ...
> }
> --8<---------------cut here---------------end--------------->8---
> 
> In arch/arm/mach-renesas/cpu_info-rzg2l.c:
> 
> --8<---------------cut here---------------start------------->8---
> static const struct tfa_info *get_tfa_info(void)
> {
> 	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
>          ...
> }
> --8<---------------cut here---------------end--------------->8---
> 
> Now, the TF-A that I have compiled (v2.5/rzg2l-1.00-43-g950d6a6b9) from
> https://github.com/renesas-rz/rzg_trusted-firmware-a.git is not passing
> any DTB blob:
> 
> --8<---------------cut here---------------start------------->8---
> INFO:    BL31: Preparing for EL3 exit to normal world
> INFO:    Entry point address = 0x50000000
> INFO:    SPSR = 0x3c5
> VERBOSE: Argument #0 = 0x0
> VERBOSE: Argument #1 = 0x0
> VERBOSE: Argument #2 = 0x0
> VERBOSE: Argument #3 = 0x0
> VERBOSE: Argument #4 = 0x0
> VERBOSE: Argument #5 = 0x0
> VERBOSE: Argument #6 = 0x0
> VERBOSE: Argument #7 = 0x0
> --8<---------------cut here---------------end--------------->8---
> 
> That results in dereferencing a NULL pointer and failing to run U-Boot
> on that platform. On the other hand, disabling the two pieces of code
> mentioned below is enough to have a working U-Boot.
> 
> It does not seem that the upstream TF-A has support for the RZG2L
> CPU. So my question is, what is the expected TF-A branch / repository
> that is meant to be used together with the renesas_rzg2l_smarc_defconfig
> U-Boot configuration?
> 
> Thanks in advance,

Software versions would be good to include, U-Boot version, TFA version.

-- 
Best regards,
Marek Vasut
