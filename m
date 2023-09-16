Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76392CD37BC
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 13:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0A9E868D7;
	Sat, 16 Sep 2023 15:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lahfa.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2B0E86672; Sat, 16 Sep 2023 15:23:47 +0200 (CEST)
Received: from nef.ens.fr (nef2.ens.fr [129.199.96.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13CE286589
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 15:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lahfa.xyz
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ryan-uboot@lahfa.xyz
X-ENS-nef-client: 129.199.1.22 ( name = clipper-gw.ens.fr )
Received: from clipper.ens.fr (clipper-gw.ens.fr [129.199.1.22])
 by nef.ens.fr (8.14.4/1.01.28121999) with ESMTP id 38GDNd9C001720
 ; Sat, 16 Sep 2023 15:23:39 +0200
Received: from  localhost using smtps by clipper.ens.fr (8.14.4/jb-1.1)
 id 38GDNc4b128737 ; Sat, 16 Sep 2023 15:23:38 +0200 (authenticated user rlahfa)
X-ENS-Received: (bny92-8_migr-88-174-101-154.fbx.proxad.net [88.174.101.154]
 (may be forged))
Date: Sat, 16 Sep 2023 15:23:34 +0200
From: Ryan Lahfa <ryan-uboot@lahfa.xyz>
To: Ryan Lahfa <ryan-uboot@lahfa.xyz>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Zhaofeng Li <hello@zhaofeng.li>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ramon Fried <rfried.dev@gmail.com>, Artem Lapkin <email2tema@gmail.com>
Subject: Re: [PATCH] boot/pxe-utils: populate initrd_filesize for extlinux boot
Message-ID: <dmyr2w4nyag3yaoknbjrm7v2lqlcrqptsm4r4v7hsxaww6ufkc@x4r4m4yvuun2>
References: <20230916131812.4035430-1-ryan-uboot@lahfa.xyz>
 <20230916131812.4035430-3-ryan-uboot@lahfa.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916131812.4035430-3-ryan-uboot@lahfa.xyz>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (nef.ens.fr [129.199.96.32]); Sat, 16 Sep 2023 15:23:39 +0200 (CEST)
X-Mailman-Approved-At: Sat, 16 Sep 2023 15:31:28 +0200
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

On Sat, Sep 16, 2023 at 03:14:58PM +0200, Ryan Lahfa wrote:
> Currently, it seems like the `initrd_filesize` was uninitialized for a
> while.
> 
> This is particularly problematic when attempting to `zboot` with a
> initrd with a size coming from `label->initrd`, because it will provide
> you with a 0-long initrd at boot time, making the kernel fail to
> continue the boot.
> 
> This fixes the issue and I confirmed it enable me booting a U-Boot on
> QEMU x86_64 q35 with NixOS kernel and initrds.

The original message was lost because I do not use `git send-email` that
often but, this issue appears to be introduced in
085cbdafca9c3d7bc2f27523a343f61db82f2ccb ("pxe: simplify label_boot()").

Kind regards,
-- 
Ryan Lahfa
