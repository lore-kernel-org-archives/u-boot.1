Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322F2EE6432
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 13:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 789CD84065;
	Wed, 31 Dec 2025 14:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="fl33dWCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F60E8401F; Wed, 31 Dec 2025 11:08:49 +0100 (CET)
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch
 [109.224.244.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 089A083F36
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1767175726; x=1767434926;
 bh=0+mkU3GztJsz8bIuFgngj4mRhWS7HxGxe+KeaeMBVD0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=fl33dWCf8T6xSbhCx8U8CfJwJI40LSvtxfqoq0TxwefR23UQWXSjSmtz5jU25sqga
 ++IHzr07swDKVSREAPIkaR1uNp0FkKsdDzcmriyG8Pd0LfQfiwZW8NKzsZld97vjOm
 rMfZv/Fcpo0lxjOzeP7bP37z2D83/nOPv/rNhPSGwBqAogtQsvNCw1RPsaM38uRFlq
 7/X6H6SUkpDKUZqXKpLQez2TACDOKQwVxBdayQ2h1bjLWkjcW9pedmkXIW1FzxERmK
 qHTdmM7eGV2stfiVGxegltUPhjvI0/woQ8a1xp35I4AqVbaFWTy0L+Own6adskI2Z9
 BoGX3vzjY85Gw==
Date: Wed, 31 Dec 2025 10:08:40 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH v2 0/4] fix integer overflows in filesystem code
Message-ID: <20251231100831.119142-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: 830d39981a05a2fd47a625971dc4520bedb879c4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 31 Dec 2025 14:17:47 +0100
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

Changes in v2:
-rebased, added changelog and bumped verison number
-formatted and cleaned the patches in response to Tom Rini

v1:
https://lore.kernel.org/u-boot/20251231015450.GW710860@bill-the-cat/T/

This patch series fixes potential integer overflows in U-Boot
filesystem code. It includes the following patches:

Timo tp Prei=C3=9Fl (4):
  fs: prevent integer overflow in fs.c do_mv
  fs: prevent integer overflow in zfs_nvlist_lookup
  fs: prevent integer overflow in sqfs_concat
  fs: prevent integer overflow in ext4fs_get_bgdtable

 fs/ext4/ext4_write.c |  7 ++++++-
 fs/fs.c              | 16 +++++++++++++---
 fs/squashfs/sqfs.c   |  8 ++++++--
 fs/zfs/zfs.c         |  5 ++++-
 4 files changed, 29 insertions(+), 7 deletions(-)

--=20
2.43.0


