Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D394CC6B27
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F4AA4061E;
	Wed, 14 Oct 2026 08:38:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wFuVBaxIOt7E; Wed, 14 Oct 2026 08:38:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4CF0E405CE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967133;
	b=OwHZLFUDzAAWmMi8fA4ncOeIuTclhrxvp9XtWi5LynYmFpSfvFVhiweqGTnuNHFSwoRK
	 sdRBUE9oV702UKtPqlYl+YM2jdDXnO+nc45XhCAq0GPIbD581EwRm0LVLkAtmFFngEBjV
	 tZKsMfLtEJ81uyHwQVZ5XQGYvsm6GqBq8VgZgCO1GwCs59B6ZeSSOT+C3QydvnSGgVxV2
	 bXwOMQBgWlSq8nU1TuuBCTwez80h2EOVcDrNCRofkoyOJkUiCnuCu2EDsqQpKglKAV98B
	 bmfAQfBMH/kpNY+wP89PDemxyyXoJuNOS2Q8FnUObz+ZxNH6noDHw71EpXrSXFkXnOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967133;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vfGZQlVRnu//sNwO3BoU2Bv2FLa6sgaB6z1eTllGF9U=;
	b=YIaD9vAZm/w/MLA+C7s5c9GaWgLQCYYmsasHde2oAhR+LhdEZsVS3znSzYpATMo3ZaUF
	 hALDdTit8UAUa1cn/X2yW28wyGkiwQqAUqpv7usCsLu5eI9HHCFy6uXJxkw2DzwvhrboM
	 L+28wOmTMbhstvsK51X4Ixr9+xFvashUUdKhgnSzZH5jtdl9OfIwvTX1eXLPtw2zsUw1j
	 a52fe1xwX1uEgvqsbvCbrHQXC2B4QXcoj+9RU9CL2+gJ4FZ1QempY1MnbOaEwQdOWCuAI
	 CBUYeRiWEezlsm5ARYeGj8RVelt2Nmsn6gE9Lr9949sb6Bx5kHgavZ2kAJ1tk5KHu+A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967133;
	bh=vfGZQlVRnu//sNwO3BoU2Bv2FLa6sgaB6z1eTllGF9U=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LVRx3GdV/pda/lg2txF2i2q79rYQJCnC3sj6sc4u3EAVRgMUsMZURsxo3UGnLFfv0
	 StWwvhQkMsGmsejUl3QNi8P6Lt4eEJYgJGyynZbEqQKno+X0RpgMNz8S500HNn4tYq
	 H9jx47Nk5w3bUGk2JEwgP4HD/ql+mOljyikW3Yy0cWa4gA9+mrGB4Htp1nmM023aUY
	 iqFYUplNcO9Cxqm3aIl8pwD1uQ9Or5wOTjTr++XikDbKYfpeY2aYiZX4MKoinlRMf2
	 RfMtJIGwuyj4qjW7JXnmPrbDQ7EAAAljk5+5MVyHMOyw0aQhNVViacA/+w09hwKF+m
	 sYZBkaqlgX8AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CF0E405CE;
	Wed, 14 Oct 2026 08:38:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD292255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA9E4607CA
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:38:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wG5TBXKpaD_D for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:38:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A45DC60728
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967131;
 b=l4Okj4Fo9e8jPTnBZZUdW3mtFNZw2cLpZzV+L6VWVvP2uKwRCpKBbJhyz8NJXcvzPexm
 b1b0zFLKekmzfols3nqTNOGfToVVTedDAP+5OV8hUHueNg8nxv0na6Ga3RexdXOeoAK57
 gQ9trvjSXM0oF0xl1m5cEYrTAjaKsWd4S53Hua+MXUWF/o6cdoEwWNaUzBZcv3OLe7UrA
 tBiGQKY8NdctQGehejGT59LPl/kjEUpq6tXKgfZzbmm2te7YBYl7vRXzJ/KelsSGUGAn4
 mECq0QbMwJIZ8u/qifKIp+RXAcvNTVMvCn2qz2RYY3PFh5z4COiRxbenuiJNkcUAZkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967131;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:MIME-Version:
 Content-Type:Content-Disposition;
 bh=vfGZQlVRnu//sNwO3BoU2Bv2FLa6sgaB6z1eTllGF9U=;
 b=H+lefvia0rfV7kLsRUANIBy/KNUs3lVc0BDRX/oXvNPmTwasQcotHwQmpeZsemmZ35Bn
 AhTyA8c8gZyIMXI78I+vQP+q3YvW+YWRSxbkfqPQ0fcfz/kA43Q17tXcTJY/vEEiFNYvM
 cc2bjk2l172y8XITCeviM6Fo3SV5sSZSve3knpNKys55gtox8Si8Vi4nHbJYm+TTPhMQ6
 6edykQGjhmxViHUH/Wj6icaDh8OvRmZcXTiw2zYkLWE6DgdUtAvBYd2tEniXIv7tyNGqz
 stHZr7fLHcZzMFjQDCYtYyWm1Y/crf4504RyGl2r4q3AOS0lnRLwEYYZe5VY5geLuFg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A45DC60728
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:38:50 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xGuVV-000000005Z7-43Wa;
 Wed, 14 Oct 2026 08:38:42 +0000
Date: Wed, 14 Oct 2026 09:38:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 00/11] imagemap: structural and cosmetic review follow-ups
Message-ID: <cover.1791966831.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The clean-up half of the v1 review of the imagemap series
(cover.1787272661.git.daniel@makrotopia.org).

Patches 1 to 4 are self-contained tidy-ups without any functional
changes: the suite list and the sandbox defconfig put back in order,
FIT_VERITY_NODENAME in place of a second spelling of the node name, a
derived size for the header probe in place of a bare 64, a corrected
rationale on the imagemap_lookup() guard, and test locals hoisted out of
an anonymous block and a mid-block declaration.

Patches 5 and 6 correct the documentation: the imagemap_create()
signature, which callers a reader can actually reach, bootmeth_openwrt
described as a future consumer, the index entry sorted, and the section
on phase gating that the commit adding the file claimed was there.

Patches 7 to 10 are the structural ones which do introduce functional
changes: imagemap devices are named after the partition they cover and
hold a name driver model owns, so two mappings on one block device stay
distinct. bootm_start() sets the imagemap itself, keeping the invariant
in one function. The data-position and totalsize-alignment sequence is
shared between fit_image_get_data() and the storage path, which also
gives the latter the range check it lacked and settles the two spellings
of the alignment. Finally the two imagemap pointers compile only when
CONFIG_IMAGEMAP is on, reached through accessors that fold away when it
is off.

Patch 11 adds a new unit test Simon had asked for in his review.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Daniel Golle (11):
  test: cmd_ut: keep the suite list alphabetical
  boot: bootm: derive the header probe size
  boot: imagemap: correct the lookup guard rationale
  test: boot: imagemap: declare locals at the top
  doc: imagemap: describe the API and phase gating
  doc: develop: sort the imagemap index entry
  boot: imagemap: name the device after its partition
  boot: bootm: set the imagemap from bootm_start()
  boot: fit: share the external-data offset calculation
  boot: build the imagemap pointers only when enabled
  test: boot: imagemap: caller-owned region not resized

 boot/bootm.c             |  39 ++++++-------
 boot/image-fit.c         |  94 ++++++++++++++++++------------
 boot/imagemap.c          |  33 ++++++++---
 doc/develop/imagemap.rst |  30 +++++++---
 doc/develop/index.rst    |   2 +-
 include/bootm.h          |  17 ++++++
 include/image.h          |  31 ++++++++++
 test/boot/imagemap.c     | 123 ++++++++++++++++++++++++++++++++++-----
 test/cmd_ut.c            |   4 +-
 9 files changed, 282 insertions(+), 91 deletions(-)


base-commit: 03e0ee96b1cf21a20def03c079ca05427ebff208
-- 
2.56.0
