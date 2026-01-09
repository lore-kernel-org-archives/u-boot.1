Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C61D1A61C
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 13:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F4A384358;
	Fri,  9 Jan 2026 14:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="BbQAxpEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06AF284166; Fri,  9 Jan 2026 12:24:45 +0100 (CET)
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch
 [185.70.43.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BCCB83CB1
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1767957881; x=1768217081;
 bh=8Z7Xd7BfM1iKA7fu5lPsDB9mjSJQOn886kD+RnMu2U0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=BbQAxpEL1sM7hN6N4FhOizqXbVhNj95HkQj526yIeJubRjSgC54teQqQjjRwaJvZh
 X76rI78km3yygMh/9Mi+cB/4aABzBKBYTJsoy/z/h5ly/co3gGlZVebu/WELaAiH+X
 YR4ocEKWEFCRnPF5+xUcBBX/GY8twkelh0r80jF2rDAzt0hbME+C6AjmoBEnJt09u4
 Q+HWyvSbVnzD95k9XhJKD1HdrNZUgTYTvxepVCtSoNJqGrdES9ILd0v0GZ8uFNggV6
 4uWPYFA5H0tRJiqKSlZmVEWMzR/j4CbZsRugapCbv+9n9VtBIndCC/ud8OI2nRXvcg
 mVlo+Lchy3gYQ==
Date: Fri, 09 Jan 2026 11:24:37 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH v3 0/4] fix integer overflows in filesystem code
Message-ID: <20260109112428.262793-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: 685183b44f2ea81e6668f4e971cf5739b39d7ed4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 09 Jan 2026 14:07:59 +0100
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

Changes in v3:
-added missing variable alloc in fs/zfs/zfs.c
-small coding style change in reply-to Simon Glass's review
-reversed size_t to int in reply-to Simon Glass's review

v2:
https://lore.kernel.org/u-boot/20251231100831.119142-1-t.preissl@proton.me/=
T/

v1:
https://lore.kernel.org/u-boot/20251231015450.GW710860@bill-the-cat/T/

Timo tp Prei=C3=9Fl (4):
  fs: prevent integer overflow in fs.c do_mv
  fs: prevent integer overflow in zfs_nvlist_lookup
  fs: prevent integer overflow in sqfs_concat
  fs: prevent integer overflow in ext4fs_get_bgdtable

 fs/ext4/ext4_write.c |  8 +++++++-
 fs/fs.c              | 16 +++++++++++++---
 fs/squashfs/sqfs.c   |  6 +++++-
 fs/zfs/zfs.c         |  6 +++++-
 4 files changed, 30 insertions(+), 6 deletions(-)

--=20
2.43.0


