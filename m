Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B09C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 12:44:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C81D82E31;
	Wed, 21 May 2025 14:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="ZGdR6bk1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB92282E9A; Wed, 21 May 2025 14:44:57 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB3E982E2D
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 14:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: f152090d-3641-11f0-beb8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id f152090d-3641-11f0-beb8-005056992ed3;
 Wed, 21 May 2025 14:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=u4YB8KX1ccGRLYMjysaEqE0qmDAnbpk0FVXuCxdJGfo=;
 b=ZGdR6bk1VuIgzT0zk4Mw3UQVkbWA8hY6UgvNODqhFR+zEppPlMIv3q+hrltx91ed62Xbk7BbaBctC
 8BJTbcV4lm1KyuUxrDF3YEneI2jsjIrzmfPU7l8GKih6DRlwAmsmsm96YGOrGiEHOR3R7gjSsg2JtU
 6w/uvTfstSW289+MDjgoevEQm4gT4NEg23ZGYA4bJ9QeO41RERSm/2RtxeEfsOhI3UwobMsmIm7OgY
 nbdqHVAsDRePXpduNdyFw07QRTMqhSUI7Stm+YiWDkOEsTZsgk4PoJxdeGdc3fkY5mIUWE31/QnrWt
 ObeCSZULkmQXwIHRoprZipJvaldivDQ==
X-KPN-MID: 33|OPMTyaziXyUimayterU2Rgi5DYl6ipmAoxrxkFOSeTks/2QAe258po9sqUMTsmF
 JCAZ3uPieQL2P81b2aYt64iRa/hsTx3BIG00vnDrgbk8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|lAc4GAkdtOjJ3ZgA3ymc/NdmEIo9U9CAL4udFn6lUslyH79D4ua08e52ji3XWsn
 fomYrkQ/gnkusdg7CacDoYg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 64cded12-3641-11f0-9800-00505699d6e5;
 Wed, 21 May 2025 14:44:54 +0200 (CEST)
Date: Wed, 21 May 2025 14:44:54 +0200
Message-Id: <87o6vm3zg9.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 xypron.glpk@gmx.de, andre.przywara@arm.com, kettenis@openbsd.org
In-Reply-To: <CAC_iWjJirOoP49HAzMSmnK0B5fZji9+-GAg7Vku3DWOZ6DQOhw@mail.gmail.com>
 (message from Ilias Apalodimas on Wed, 21 May 2025 12:07:40 +0300)
Subject: Re: QEMU & KVM broken for arm64
References: <CAC_iWjJirOoP49HAzMSmnK0B5fZji9+-GAg7Vku3DWOZ6DQOhw@mail.gmail.com>
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

> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Date: Wed, 21 May 2025 12:07:40 +0300
> 
> Hi all,
> 
> Starting from commit 53d5a221632e  ("emulation: Use bloblist to hold
> tables") I can't boot U-Boot with QEMU (version 8.2.2) & KVM anymore.
> The command line to reproduce it is:
> qemu-system-aarch64 -smp 2 -nographic -cpu host -m 4096 -accel kvm
> -bios u-boot.bin -machine virt,secure=off
> 
> commit 24768a23a9b3 ("emulation: fdt: Relax condition for
> OF_HAS_PRIOR_STAGE") boots fine.
> 
> Simon do you have an arm64 host to reproduce this?

Does the same thing happen without "-accel kvm"?
