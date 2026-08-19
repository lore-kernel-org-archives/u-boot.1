Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B30C5DF81
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 17:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7970D60739;
	Wed, 19 Aug 2026 17:03:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v2m_4fJwU5LI; Wed, 19 Aug 2026 17:03:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787158980;
	bh=NMbZhgt7cgmApBCGxzv+fqOAv2nbvPwnGM4aCD/c0OY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IBJ838Nqcsibk1mzg7quDLM3NrvayRETY0ZCFha9vQ9Zi8tDM3PGJ0lyI9cTFEBOl
	 nDrOfd5XoAaM4lSquPr1TUOE70eRPzjMqRBdDHtPqJhteqvrIkKih3dsF08JeAgWB8
	 mkKgWylDTrpqJyMbSzpzCmQx0INhYJB0P5+MeBvYjTDAm2zqmwssjl7EsvB4V9cvht
	 JKU6gTNVrx1yB4xoZJKcRWDcPRuQg4hA0/m0anJTWUNC+cm0bqQZM0mRjsIQtVjhs4
	 hYK3vQKTrckEBmdSwFJXLy86WSNgprCNGYJfhk0auG7+KOA4fBwiU99qYO3QpFmnxa
	 YMFX29cLoPhNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFA55606A2;
	Wed, 19 Aug 2026 17:03:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DD0A41EA4
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF37F60740
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:40:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MRoSQ04hgIKK for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 16:40:46 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=byteray.co.uk
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=jvogEs9L
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3916606F4
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:40:45 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a0c8283146so1725955a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1787157643; x=1787762443;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NMbZhgt7cgmApBCGxzv+fqOAv2nbvPwnGM4aCD/c0OY=;
 b=jvogEs9L0FB+j9dHUDCLUpt0zslgOY5f1zVmE6BADpimxkQqHzqBDPrdcaqsf72Cqe
 eY1T8SRqUQPokK+HX11dmHSg3vMXOulk+cGYtz9uT8dR0TZ+wEXYjx7cBxYPJ/nbAzsA
 LH1CWK6Xg7LsAMEZrvMYfltNQC/AiJzI+gwas4evTrYbyDWK9AWNIgIC3QEhw5xurbgK
 iu57Uk7Yf08QvDs7n5k66SEFpDhpFLd8KgrxKFdSnYPWrhXOrKI8xZly2i2cexzV/PwB
 RtLIDeEHmek1saA3zn7GLhv2WSHvWwGUgI8RmUf8aRa1feglwJbj9jxMXsJZPqdRitKG
 NJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787157643; x=1787762443;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NMbZhgt7cgmApBCGxzv+fqOAv2nbvPwnGM4aCD/c0OY=;
 b=SbazIxrVa22KXQnScaBIsqH+95rMM8MFxo+0FJML5xlusdYh+8x6A5Lv1L9ImReZHy
 S5zJiMWmbjWlltUkKc/HjddBMI+t9TR5uZMejEcC5Qy23ufLT7Fiap3mkswa1EqO/Otk
 hIg2AwV+7R2IgmSw05emBq8RyhfL8gBtwiaxf57AgeRkwN0ltKQGyDrI5j1vIxXOza6d
 NR52ypU5af/wzQF1g4/Nk1cQWrGc78iBk+D5pWveW67nWbaq+mPYeaIQkIA7zJQn3ZWo
 ov6ctiX96FNjrEHSihclU4Htz0Rf2zDLWKiSbiQllAxhD6TvT+RTJ6M3FA6uvhspNyOq
 g59Q==
X-Gm-Message-State: AFuF++lhd4c7sJCIk2VVaxpQIB+LnUDafl4fos/NosSBcfIWdYZZUR7l
 qhSo09CpzUdYKJ3vDvJbXgftb8/L0gfSEaox+n4MTD4no4cQFxuB2ym11/5ERIjnQ8FWebCNCAm
 DQC29Exc=
X-Gm-Gg: AR+sD11ROmxQTMhp4IxOBCnhovQMOp32vjR2h9VIGkoBdF/V1Wmq9RK3DDSUuLr5cGS
 w/wA/t8aAielv/GackYbO9aBWRorkgDsrARs5rmAfzNANThk4D5ko/lTrVw5Ev8eDzLKMX/vbS0
 7GeebD7hhgiFk5ksfmAAT3cWH4jeBXcWYcVdF3XJkq/Yz8V9uo1zMP80DX4tk6vxAwW8MYJ4OCr
 kBMX9FGavXBdY2WDWlRtA/yUD182DFkUpgOqifl9K1tYkuG7FVcb/Mlc+wJx/0Pyhq3XOrhXF8G
 /9HgZ7nEUF5KDIuyoyXM1SjvTvCpUVU2287L37VDljTyRIODPv85QhUi7WpyuekKIcRTmdTIyjx
 IHULx0XB862XPfwRDl+q00g/VxIYW9wpnsJf6FL3RMCZ9LCHDMElT/Lw3J9xI620O+6p1bHcvkC
 4hOXiXqjgETVQpZJjSXqRybJTeeODDGLxkTDdHoresvRGxc86LoT9Eb4d9+ho6bximc9QFCwk+h
 SfvmbD+uO9xU2iAceP7rUKJkELWPBqua7BEowbF+assvo70zcM=
X-Received: by 2002:a05:6402:5189:b0:6a0:927e:39e2 with SMTP id
 4fb4d7f45d1cf-6a4032f10a7mr3066648a12.5.1787157643278; 
 Wed, 19 Aug 2026 09:40:43 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f003bf9bad107298ed5.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:3bf9:bad1:729:8ed5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff0c327asm1219822a12.8.2026.08.19.09.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 09:40:43 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH v3 0/3] net: nfs: bound server-supplied lengths in READ and
 READLINK replies
Date: Wed, 19 Aug 2026 18:40:23 +0200
Message-Id: <20260819-nfs-oob-fix-v3-0-7f8158088b80@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHfchWoC/22NzQ6CMBAGX4X0bEn/gOLJ9zAeoF2kmlDTlkZCe
 HdbvKjxOJtvZlfkwRnw6FisyEE03tgpAT8USI3ddAVsdGLECKuJpBRPg8fW9ngwT8ypEpx3jKm
 WomQ8HKTzXjtf3uzn/gYq5ERejMYH65b9XaR5978cKSa4EkJoWWsmdXPqlwCuW0ply/mOcj2yT
 59/+yz5krQtbxpSUQm//rZtLxQxzVv8AAAA
X-Change-ID: 20260811-nfs-oob-fix-31c433a22c91
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 19 Aug 2026 17:02:59 +0000
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

A malicious NFS server can return replies whose 32-bit lengths are crafted
to defeat the client's bounds checks.

nfs_read_reply() keeps the READ length in a signed int. On LP64 a value
with the top bit set is negative, the bounds check passes, and
store_block() then hands a ~2 GB length to memcpy(), which reads past the
1152-byte reply buffer on the stack and writes past image_load_addr.

nfs_readlink_reply() has the same signed-length flaw. A length of -1 slips
past the destination bound as pathlen - 1 and drives a memcpy() off
nfs_path_buff. The bound is also measured from the reply header rather than
from the symlink data, so a large positive length reads a few bytes past
the received reply. A server reaches this handler by answering the READ
with an ISDIR status, which moves the client into the readlink state.

Both handlers are shared by the classic and lwIP NFS clients through
nfs_pkt_recv().

Patch 1 makes the READ length unsigned and bounds it against the received
packet and NFS_READ_SIZE. Patch 2 does the same for the readlink length
and its destination bound. Patch 3 enables CONFIG_CMD_NFS in the sandbox
config and adds DM regression tests that drive nfs_pkt_recv() with crafted
replies.

A reproducer is available on request.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Changes in v3, all following Jerome Forissier's review:
- nfs_read_reply() and nfs_readlink_reply(): keep the server-supplied
  length in an unsigned int and bound it against the received packet with
  the subtraction ordered so it cannot wrap, dropping the explicit
  negative check.
- nfs_read_reply(): take the NFSv3 length from the opaque data_size field
  that prefixes the returned bytes.
- test: also set the data length field that nfs_read_reply() now reads.

Changes in v2:
- Add a fix for the same signed-length flaw in nfs_readlink_reply(),
  rejecting a negative length and measuring the bound from the symlink
  data.
- Enable CONFIG_CMD_NFS in sandbox_defconfig so the regression tests are
  built and run under sandbox; the v1 test was skipped in CI.
- Add a readlink regression test alongside the read one.

---
Shahriyar Jalayeri (3):
      net: nfs: bound the length of an NFS read reply
      net: nfs: bound the length of an NFS readlink reply
      test: dm: nfs: add regression tests for the NFS reply-length checks

 configs/sandbox_defconfig |  1 +
 net/nfs-common.c          | 32 ++++++++++-------
 test/dm/Makefile          |  1 +
 test/dm/nfs.c             | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 12 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260811-nfs-oob-fix-31c433a22c91

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

