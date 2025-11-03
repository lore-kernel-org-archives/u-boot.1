Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9B3CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 12:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9415B836D1;
	Mon,  3 Nov 2025 13:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lF2+xHz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4311C83700; Mon,  3 Nov 2025 13:19:11 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFF5E8331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 13:19:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 09E2143695;
 Mon,  3 Nov 2025 12:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A32C4CEE7;
 Mon,  3 Nov 2025 12:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762172346;
 bh=Ldy6DdkvWaqolHLXJVzwRRrvh26kkcyTd58T93JY0IU=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=lF2+xHz/2qZTvZdbNlyVTEUweZld4YMC07oE1yJKQ+/6lXtJ1y+LIazS5+gtUYQNc
 d0d0YPczz6AHHtsG0yjmvJwyLVa93ovzi8RPgjY6WpjC4Cg2oUO0Tvf9NjJCV5gKkD
 0MlTvYirnxIe866dh8yH33qM/pkyYCcp98Fob0xs6B6+Z5XdMmJ05GfAcvz355ilZY
 u8FcGqYcl8RVY2x/JYGIIYCEPnCCUE7a5uG4pumGd5wpSSXgxnLBqn8CS7zP1aKlDs
 IcgTRXmbVcMesGbTo4rDSsmGiTBf1UXHZ7pcTZa6/S8jX0hB9qMaaSPGNwXWmyc6QQ
 rUxItVAQSwEeA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 George Chan <gchan9527@gmail.com>
Subject: Re: [PATCH] boot: bootmeth_android: Conditionally dependent on
 abootimg
In-Reply-To: <176192343323.290092.16053648607478981549.b4-ty@kernel.org>
References: <20251021-abootimg-minor-v1-1-88a12f53d8de@gmail.com>
 <176192343323.290092.16053648607478981549.b4-ty@kernel.org>
Date: Mon, 03 Nov 2025 13:19:04 +0100
Message-ID: <87tszb2ts7.fsf@kernel.org>
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


Hi George,
On Fri, Oct 31, 2025 at 16:10, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

> Hi,
>
> On Tue, 21 Oct 2025 00:36:33 +0800, George Chan wrote:
>> If target u-boot img do not support androidboot v3 or greater,
>> abootimg might not be necessary.
>> 
>> aarch64-linux-gnu-ld.bfd: boot/bootmeth_android.o: in function `boot_android_normal':
>> /home/user/sources/u-boot-next/boot/bootmeth_android.c:541:(.text.boot_android_normal+0xd0): undefined reference to `set_avendor_bootimg_addr'
>> aarch64-linux-gnu-ld.bfd: /home/user/sources/u-boot-next/boot/bootmeth_android.c:543:(.text.boot_android_normal+0xd8): undefined reference to `set_abootimg_addr'
>> Segmentation fault (core dumped)
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)
>
> [1/1] boot: bootmeth_android: Conditionally dependent on abootimg
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4b493b9664390e16f61a6409ec60676df7759c7b

This patch causes CI to fail:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/1283315

"""
building current source for 1 boards (1 thread, 8 jobs per thread)
   sandbox:  +   sandbox
+cmd/abootimg.c:26:6: error: redefinition of 'set_abootimg_addr'
+   26 | void set_abootimg_addr(ulong addr)
+      |      ^
+include/image.h:2042:13: note: previous definition is here
+ 2042 | void __weak set_abootimg_addr(ulong addr) {}
+      |             ^
"""

This can also be reproduced locally by building sandbox:

$ make sandbox_defconfig
$ make


Can you have a look please? I will have to drop this from my branch
until the build error is resolved.

If you find a fix, please send a v2 of this patch with the fix included.

Thanks
Mattijs

>
> --
> Mattijs
