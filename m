Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E045EC5B548
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 14:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24EFD88892;
	Wed, 28 Aug 2024 16:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2542888A3; Wed, 28 Aug 2024 16:44:36 +0200 (CEST)
Received: from eclipse.jkvinge.net (eclipse.jkvinge.net [217.170.205.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51AA588754
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 16:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jonaski@opensuse.org
Received: from ni246.in.jkvinge.net (ti0116a430-0074.bb.online.no
 [88.91.110.75]) (authenticated bits=0)
 by eclipse.jkvinge.net (8.15.2/8.15.2/SuSE Linux 0.8) with ESMTPSA id
 47SEiXrd029946
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 16:44:33 +0200
Message-ID: <155e70173b52803c2bc79e978c31be3b2d9fdd5f.camel@opensuse.org>
Subject: Re: u-boot on raspberry pi with secure boot
From: Jonas Kvinge <jonaski@opensuse.org>
To: u-boot@lists.denx.de
Date: Wed, 28 Aug 2024 16:44:33 +0200
In-Reply-To: <ff64557053d3f00d42c1b3a8c0d9237e870b30af.camel@opensuse.org>
References: <b24ba149599b9e0261676110894d14a0f69eb6a2.camel@opensuse.org>
 <311e1dd1-a887-461f-b984-bfc1807c63e6@linaro.org>
 <ff64557053d3f00d42c1b3a8c0d9237e870b30af.camel@opensuse.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
Received-SPF: pass (eclipse.jkvinge.net: authenticated connection)
 receiver=eclipse.jkvinge.net; client-ip=88.91.110.75;
 helo=ni246.in.jkvinge.net; envelope-from=jonaski@opensuse.org;
 x-software=spfmilter 2.001 http://www.acme.com/software/spfmilter/ with
 libspf2-1.2.10; 
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

Hi,
I have produced a signed linux UKI image.

But I need to build u-boot to only allow booting with the signed
certificate.

So I need a ubootefi.var for (EFI_VAR_SEED_FILE) according
tohttps://github.com/u-boot/u-boot/blob/ee2af844ba1b27b2e959c4e649e4b769fbe=
b4074/lib/efi_loader/Kconfig#L146

How do I produce this file?

https://lists.denx.de/pipermail/u-boot/2020-December/433925.html

If I type saveenv on the u-boot console, I get "uboot.env", is this the
file that's needed?

I've tried to sign the file using the efivar.py script, but I find very
little information on this topic, I've found this from the
mailinglist:(https://lists.denx.de/pipermail/u-boot/2020-December/433925.ht=
ml).

Here's what I've tried:

./tools/efivar.py set --infile uboot.env -n db -d secureboot-db.esl -t
file
err: invalid magic number: 0x756162006d72613d



I've produced the certificates according to the instructions on
https://github.com/u-boot/u-boot/blob/master/doc/develop/uefi/uefi.rst

Jonas

