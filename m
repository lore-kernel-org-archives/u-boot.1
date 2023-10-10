Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E2CCD80A4
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 11:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85CC68675B;
	Tue, 10 Oct 2023 13:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="SEis5JT/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E873C868E6; Tue, 10 Oct 2023 13:01:16 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EED1864A0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 13:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Tue, 10 Oct 2023 13:00:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1696935672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=Y+Lz/YaZzRNtkMFpkebVrSzRUuXNm3fFFXwibna1A3c=;
 b=SEis5JT/Z9Xw06Gli4605nVLWSZ1gKqjdDqHZXx4648H5aehhjBQVkEKDPmG2anvo0UAGM
 RDZdGjWNX3Usd0QjbsDMeQVDLQIckFNLdpXraMNsx2Gma7MfqCZ1Ths1oxwRWAPY5qj1qv
 ePnAUyxmBVdAJNV1u2OkzKxWLW+OM12x2VMMvBRTp1mQcmLjBmuM2ISaQayvmWc+D/tKzK
 vE2nlIx3PSmPTAdqbBhZLI9dRIoHeuWF72bph94cC3Al6GWbjJ1XKEKtq/6+fOqeGs/ioD
 EjxGkABcr0Ed80GoKDm0dS3troPuI9O4s4eW88QgBmsr64dDK0t1jkoGAdFZzg==
From: Alexander Dahl <ada@thorsis.com>
To: Stacey Pellegrino <stacey.pellegrino@gmail.com>
Cc: u-boot@lists.denx.de, zhao_steven@263.net, wanglimei@orange-pi.onaliyun.com
Subject: Re: ZFS support in custom u-boot build...
Message-ID: <20231010-dragonish-harmonica-d28cc5ac811e@ifak-system.com>
Mail-Followup-To: Stacey Pellegrino <stacey.pellegrino@gmail.com>,
 u-boot@lists.denx.de, zhao_steven@263.net,
 wanglimei@orange-pi.onaliyun.com
References: <CAKNxVbNWrLrX=rzb4RONo96AtM+G2NKs_2g28WohgCwVkFstSA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKNxVbNWrLrX=rzb4RONo96AtM+G2NKs_2g28WohgCwVkFstSA@mail.gmail.com>
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

Hello Stacey,

Am Thu, Oct 05, 2023 at 11:22:14AM +0100 schrieb Stacey Pellegrino:
> To all those of concern,
> 
> I am in need of help regarding building u-boot with ZFS support for the
> Orange Pi 5 Plus.
> 
> I have tried working out the following...
> 
> https://github.com/u-boot/u-boot/blob/22ad69b7987eb4b10221330661db4427e40174fb/doc/README.zfs
> 
> The URL link above specifies using the board specific config file, which
> for the Orange Pi 5 Plus is (so I believe)
> orangepi-build/userpatches/config-default.conf.
> I therefore edited this file in question with CONFIG_CMD_ZFS="yes" and
> uncommenting the line install_zfs="yes".

In that regard this README.zfs is somewhat outdated.  You should set
CMD_ZFS through Kconfig instead.  Which means: pick the matching
defconfig from configs/ subfolder, then run menuconfig and enable
CMD_ZFS, and build that.

Not sure if that Orange Pi 5 Plus is already supported by U-Boot
mainline already.  From a quick glance at the defconfig filenames I
would not know which to pick.

> However, it still does not allow me to boot with root ZFS on the NVMe SSD
> with the official Orange Pi Debian v12 (Bookwork) ARM image. ZFS does not
> seem to be referenced in the custom u-boot source code build output as
> well. I followed the build instructions located at the following URL link...
> 
> http://www.orangepi.org/orangepiwiki/index.php/Orange_Pi_5_Plus#Compile_u-boot

Oh you should have told before.  This uses a custom build script not
part of U-Boot, probably to call U-Boot build.  Please contact that
project on how to change U-Boot config instead.  Or look at their
build.sh and figure out how it configures and builds U-Boot.

> ...but am I required to apply a patch to the u-boot source for ZFS support?
> If so, then that could be my problem. If a patch is required, then how
> would I go about applying this accordingly?

Although they seem to use an outdated and patched version v2017.09 of
u-boot: probably not.  Please try with enabling CMD_ZFS in your U-Boot
config first.  It's in the menuconfig, also in v2017.09 already.

Greets
Alex

> 
> Thank you in advance for help in this matter. Kindest regards, -Stacey
> Pellegrino
