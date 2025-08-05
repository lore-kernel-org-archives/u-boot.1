Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4833C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED4183560;
	Tue,  5 Aug 2025 16:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="Db07v/nT";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="PWTnoi3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB22581D5A; Tue,  5 Aug 2025 11:41:10 +0200 (CEST)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org
 [18.158.144.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB246803CC
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 11:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tomas.alvarez-vanoli@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=xbcSkC5+AQkm3W93UBMC2cO9A3GIiTMVLE6pu9IMuz8=;
 b=Db07v/nTfd4hwWAEdLoy/ZZYgYtY+ppF3wSJZEqW8E5M8k0b9Rr7n9WWlNr4oxjQPjQLNGV1ws3Fb
 064tHiHSFe5lSDU3Tv9y58x7Bm+CSbhqYi4fQA4Nzo0c7gIA9/KF/1TPCy9yvGEKpEaJi4wneD/9pE
 wPSfPU/H8aABqV5A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 cfbl-address:cfbl-feedback-id:from;
 bh=xbcSkC5+AQkm3W93UBMC2cO9A3GIiTMVLE6pu9IMuz8=;
 b=PWTnoi3uqcxqyUDhu0TGXZce2WIapDHh0FRBWWN4kveespMa/cJoY4BbyUFVlMchkV9WBW3v9iVUT
 xznAeBE6MASkiZQ2cdTo7BNM0Xux01eKfd9i93zv+H4aPW5IcFCyBWPaSKj//oI0mfhr/+qgC7nA6v
 yJJoaHNybgIUjS8WHwtmiNmV4UYGQE4mlDQG5TjNJ5ZQz4AUqEERZBaEAB8yHfL2/2uji+NSqpSYZv
 BMWfOPk1Md3XreOucjjK6NnOfmoBBAvk6gjfT5O+zdKDYLbIUE6jfyoIZs4HBvh9RFLNo7W7lh1cjJ
 /0bxO8D9Q/ODoQ0HBSRHeKPTy1JvxnQ==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 4c34436e-71e0-11f0-b288-878ee10b8a33
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 4c34436e-71e0-11f0-b288-878ee10b8a33:7
CFBL-Address: prvs=0312fde91a=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown
 [20.62.140.138]) by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 4c34436e-71e0-11f0-b288-878ee10b8a33;
 Tue, 05 Aug 2025 09:41:02 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with SMTP id 9D1EA171C; 
 Tue,  5 Aug 2025 09:41:00 +0000 (UTC)
Received: from chbrn3-p-dev026.keymile.net (chbrn3-p-dev026.keymile.net
 [172.31.41.203])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id 271B260B7D47;
 Tue,  5 Aug 2025 11:41:00 +0200 (CEST)
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sughosh.ganu@linaro.org,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: [RFC 0/1] use lmb to calculate ram left for the kernel
Date: Tue,  5 Aug 2025 11:40:11 +0200
Message-ID: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 05 Aug 2025 16:21:58 +0200
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

Hi all,
=20
We recently updated from 2024.01 to 2025.07 and the changes in the lmb li=
b
required us to add some custom code to it.
=20
I would like to ask for your opinion on if we are overcomplicating this o=
r if
it would make sense to add this functionality to it.
=20
We have a booting mode in which we load a root filesystem in the memory a=
nd use
it to emulate an mtd device.

For this, we were using the lmb library to calculate how much ram was lef=
t for
the kernel, based on the size of the rootfs and other reserved regions.
=20
In the 2024 version the lmb library was working with user lmb tables, so =
we
were able to create it, initialize it and then do the calculations there
without any of the tftp allocs bothering us.

We were just allocating a part of the memory for the rootfs and then usin=
g
`lmb_get_free_size` at the start of the memory to get the kernel memory.
=20
After the update, the table is globally shared, so now there's regions of
memory allocated by tftpboot (but with no flags).

To work around this, we copied the `lmb_get_free_size` and created
`lmb_get_reservable_size`, which is the same except it counts as free any
contiguous memory regions with no flags (see patch).

The functionality could also be extracted to be in a generic function tha=
t
takes 'allowed' flags as an argument.
=20
Our platform is armv8, our lmb table looks like this at boot time:
=20
```
reserved[0]       [0x83000000-0x83a9afff], 0xa9b000 bytes, flags: none
reserved[1]       [0x90000000-0x9077e417], 0x77e418 bytes, flags: none
reserved[2]       [0x93000000-0x930089d3], 0x89d4 bytes, flags: none
reserved[3]       [0xf3113180-0xf51fffff], 0x20ece80 bytes, flags: no-ove=
rwrite
reserved[4]       [0xf54fc000-0xf7dfbfff], 0x2900000 bytes, flags: none
reserved[5]       [0xf7dfe000-0xfbdfffff], 0x4002000 bytes, flags: no-not=
ify, no-overwrite
```
Where  0 to 2 are allocated by tftp, 4 is where the root file system is l=
oaded,
and 3 and 5 are added during the init of the lmb.
=20
Is there a better way to calculate the available memory for the kernel th=
at we
might be missing?

Would it otherwise make sense to update the lmb library to cover this use=
case?

Tomas Alvarez Vanoli (1):
  lib: lmb: add lmb_get_reservable_size, fix ramfs

 board/keymile/common/common.c | 10 ++++++++--
 include/lmb.h                 |  1 +
 lib/lmb.c                     | 31 +++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

--=20
2.43.0

