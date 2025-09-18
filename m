Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EDDCAC5A0
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 12:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D848004F;
	Thu, 18 Sep 2025 14:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="Q+4LvPRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30FF281E13; Thu, 18 Sep 2025 14:55:08 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5F8F8003E
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 14:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1uzEA9-0004Ew-Of; Thu, 18 Sep 2025 08:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=T9P2S/zM390wxqwbX74miGaLnIVJR3yWwr483amilHE=; b=Q+4LvPRnjEUI4wENwQOk
 9VShju8p6LAdSx1G2truxQKJDPm3ThU687XrTG6BeJ2e3Rz2ir6pjLx2+LhhiJHbHFe23a986vN8D
 zkyPEuoZiHSRNML1UZYX2fQnos8aObzHXdQ4vdk78ayQpCidBDnDJlAIDDs4l++T1xg4906/MxOiG
 etiI2ipiT41sqsov1FXcywCuu1+3UgeHD+0F+5NOD/Snm8V2+FsHCVx8GaWJdLLGTKxxf/hV7coMs
 aj7fdS6PxY5PGpxYkRhyOdjOE1FiVIpEb1qZv7VYW1HeGTpXU+h3UBry5oLmIPrL6S1OT0o0GujQc
 1lPrTPeO78VC7w==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,  "paul@pbarker.dev"
 <paul@pbarker.dev>,  Chris Paterson <Chris.Paterson2@renesas.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "anton.reding@landisgyr.com" <anton.reding@landisgyr.com>
Subject: Re: RZG2L and DTB blob from TF-A
In-Reply-To: <TY3PR01MB11346F452EAE530A0931C9D228614A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 (Biju Das's message of "Tue, 16 Sep 2025 14:02:36 +0000")
References: <87plbqd0kk.fsf@gnu.org>
 <56857fb6-e3d4-4069-afde-57b43c4d2442@mailbox.org>
 <TY3PR01MB11346F452EAE530A0931C9D228614A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Date: Thu, 18 Sep 2025 14:54:58 +0200
Message-ID: <87plbnhqe5.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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


Hey,

> Also, you need a patch to identify the device and pass it as blob
> to the mainline u-boot
>
> On TF-A:
> .ep_info.args.arg1 = (uintptr_t)fdt_blob,
>
> Also you should fill the memory blob(fdt_blob).
>
> Hope you can take over from here.

Thanks Marek and Biju. The current state is still that people will take
the forked Renesas TF-A, the mainline U-Boot with the
renesas_rzg2l_smarc_defconfig configuration and expect things to work
out of the box.

Currently, before figuring out that the TF-A needs to be patched
manually, U-Boot is just crashing without outputing anything, which is
painful to debug.

As the only RZG2L supported by U-Boot is the r9a07g044l2-smarc, and we
are not receiving any blob from the TF-A, I think it is fair to assume
that we are booting from the platform we are compiling U-Boot for.

I have proposed a patch here:
https://lists.denx.de/pipermail/u-boot/2025-September/598712.html

Thanks,

Mathieu
