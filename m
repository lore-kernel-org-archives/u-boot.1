Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C810C47BF5
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 14:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9EAF83F9B;
	Tue,  6 Jan 2026 15:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rPQwXn5E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A834A83FA3; Tue,  6 Jan 2026 15:31:04 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5877383F9A
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 15:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767709857; x=1768314657; i=xypron.glpk@gmx.de;
 bh=MhCu0RgnECQuEHiObV4WoKpcQe+uN2Sr8m6bF0445X0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rPQwXn5EVluE7fNfGXvsM4L+9jJFJxxnm4xlSf3irGf1LKNp7GSgsBvV79Rziobj
 a9rOaajlas9G6ORGSSYM0ZPbfCDhNy41z+sMi1Va+lOURd6w5DVbAqN2f79I0v9xD
 RBLU2bjAc+/ROBySj4eIXunVUhrYj1PkDPXUJMTa5necaFyvk2OVuq8dJEC6aulsc
 3/olFvVWLEEF3YT2wmHIWCiPzYxP9umXJ+aOV9Voa0QgvasJ67H5EyWt0tEtr4i1t
 pZDUdy6+hiLV7MeGgoTpbwWSgIZtH7V8NIRVxNhsaX9651yjCDyk1r1wZW0/LgASP
 X3UtwLNIXcUVtp7jkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOKi-1vsApj10r0-00x8iu; Tue, 06
 Jan 2026 15:30:57 +0100
Date: Tue, 06 Jan 2026 15:30:55 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, ilias.apalodimas@linaro.org
CC: cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: Drop default y from CONFIG_EFI_GRUB_ARM32_WORKAROUND?
User-Agent: Thunderbird for Android
In-Reply-To: <c999bfc3-e95c-4a1a-98a2-952ae66959d1@siemens.com>
References: <c999bfc3-e95c-4a1a-98a2-952ae66959d1@siemens.com>
Message-ID: <71CC4A73-1141-4B07-A766-98808F082734@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cM+t5R5LA6XzH0MMGHv0NGeDyj4XXjdI2ZxvP68qSFwSsZEP4iO
 O5hT+OMH0RhviVgsaqMkWTPz1lt0H25i8BSYG37uTp9jYNBcmYXgngc3C+iQKzVs225mwDS
 iRASQWOVwoASgA1+mLL2Yna53+l0EA801WjdcR5uelR32jPR7CXnjHf6QAW7VJH7Ddh8Xo7
 LroeJq5+ht3xbov2pDM3g==
UI-OutboundReport: notjunk:1;M01:P0:qF7njC+QZoY=;rEStOoqgFW6JTOgP99QDe/j5CL1
 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
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

Am 6=2E Januar 2026 14:47:30 MEZ schrieb Jan Kiszka <jan=2Ekiszka@siemens=
=2Ecom>:
>Hi,
>
>it seems that some kernel configs can cause problems with the
>CONFIG_EFI_GRUB_ARM32_WORKAROUND=2E Namely, 6=2E1-cip and 5=2E10-cip with=
 its
>current defconfigs [1] no longer boot on the BeagleBone Black (other
>boards still need validation), both with the more recommendable
>systemd-boot and grub=2E I do not have the motivation to debug the reason
>in the kernel / its config, given that everything works fine once the
>firmware behaves according to the UEFI spec=2E
>
>Meanwhile, grub reached 2=2E12 now which is far away from the old, broken
>version of 2019=2E So, should we rather make this workaround opt-in in 20=
26?
>
>Jan

Hello Jan,

Looks ok to me=2E Will you send a patch?

Best regards

Heinrich

>
>[1]
>https://gitlab=2Ecom/cip-project/cip-kernel/cip-kernel-config/-/blob/cda3=
f5841dec33b81f24cedcc32ea09bb58bbfb5/6=2E1=2Ey-cip/arm/cip_merged_defconfig
>

