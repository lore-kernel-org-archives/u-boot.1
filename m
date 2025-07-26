Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0C1C87FCE
	for <u-boot@archiver.kernel.org>; Sun, 27 Jul 2025 04:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9EA08307F;
	Sun, 27 Jul 2025 06:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iro.umontreal.ca header.i=@iro.umontreal.ca header.b="lQ9R+TFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B1F830B3; Sat, 26 Jul 2025 19:46:38 +0200 (CEST)
Received: from mailscanner.iro.umontreal.ca (mailscanner.iro.umontreal.ca
 [132.204.25.50])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 063328307F
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 19:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=monnier@iro.umontreal.ca
Received: from pmg3.iro.umontreal.ca (localhost [127.0.0.1])
 by pmg3.iro.umontreal.ca (Proxmox) with ESMTP id 347B4440C92
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 13:46:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
 s=mail; t=1753551993;
 bh=l6KRsCssSlBs5uZ5qR2aF9ufwVlyl0XeKt2Gw4k/yc8=;
 h=From:To:Subject:Date:From;
 b=lQ9R+TFq9zGjTMlLXlDwGqpWozTqBKDAVREUOIoJvmBMFziEdwgBOD/ln0XMXi7fD
 zqGj7Xru9khm54KUTzt7SNWSgq5pM3Netrx/UYqHCAhlEUPDPc07PxN5+Qe2Ks4Mb5
 LKpzf0Bpd1MxisYo0IOurDJXKBsEcOUMYkItC/hOuCJntj7cNTGKjYKfQ0ULVDhU3U
 JqyeloNGcyMO62PCj+RIKlD/WkIi7W1/JXJ+vaZXAW0A4/3AFVj9gcIXeE87AYxr4V
 EDC+DFPLMIYE4AmkY995aE0GS3EO4/NZ6f6spGHq3f/SSv9Hno0YOGJJ1a1SC1czgN
 CMYjl0pFy1YsQ==
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
 by pmg3.iro.umontreal.ca (Proxmox) with ESMTP id 208D4440533
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 13:46:33 -0400 (EDT)
Received: from pastel (unknown [104.247.225.139])
 by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id 04F2C120372
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 13:46:32 -0400 (EDT)
From: Stefan Monnier <monnier@iro.umontreal.ca>
To: u-boot@lists.denx.de
Subject: Bootable partitions in GPT
Message-ID: <jwvecu2lvj9.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
Date: Sat, 26 Jul 2025 13:46:30 -0400
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Sun, 27 Jul 2025 06:56:38 +0200
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

AFAICT, U-Boot relies on the "Legacy BIOS bootable" attribute to decide
whether a GPT partition should be among the partitions it searches
for bootflows.

AFAICT it's being deprecated in many tools: e.g. under Debian, neither
`gdisk -l` nor `fdisk -l` display that information, I can't find any way
to set/undet that flag in `fdisk` and in `gdisk` it is hidden under
"extra functionality (experts only)".

AFAICT there is currently only one non-deprecated alternative, which is
to use the PARTITION_SYSTEM_GUID (C12A7328-F81F-11D2-BA4B-00A0C93EC93B)
for that partition's GUID.  But IIUC that GUID is meant for the EFI
partition, which would be a weird choice for partitions that hold
GNU/Linux ext4 rootfs.

Is there any hope to see some other option (not sure what that would be)?


        Stefan

