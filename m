Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9697AC47073
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 08:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F12CE876FF;
	Tue,  9 Jan 2024 09:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qucCHr1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A14B8786E; Tue,  9 Jan 2024 09:53:51 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DFE886FBF
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 09:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.home.xypron
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 922464137A; 
 Tue,  9 Jan 2024 08:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704790428;
 bh=l/15bgDywWZndIV/uebUnVx+eMYW6aWJBUIyjYo1who=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=qucCHr1YfH6A2CQ3qwwR+SkBA42es0UNm12HU3OcxJaYQ4J2/uV7GQQwC38HG3WeC
 ldX/hj4wi3NMRufq0tVmNCbPaFEGCCKAjgFtCMmC+w4J+aDX/Z8sB+2gF/XgjZ/Jy9
 BqQC7YRZ28iRHMR751NwO2Rm8RpcClr9gFCj2f1Dvdgu/e8S0eC36NtSCut+q7aonE
 u6hTou3iZwV6sfHA37SYBvlkTEtpeHHuIhdUSzoPNtlwQCOXVJZ1qx5mmhgr2+0Crc
 pdd1CQG0guNF0yRIMY//yoPrjAFhagRzFMYO/ULJBVEfKBkqFzCRDeuQLcZiJUx6Dy
 udUuxgms/xbFQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/2] lib: smbios: verify_checksum() is duplicate
Date: Tue,  9 Jan 2024 09:53:32 +0100
Message-ID: <20240109085334.41481-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The function verify_checksum() duplicates what table_compute_checksum()
does. Replace it. table_compute_checksum() is always compiled.

Adjust table_compute_checksum() to accept const pointers.

v2:
	Adjust table_compute_checksum() to accept const pointers.
	Correct sequence of includes

Heinrich Schuchardt (2):
  lib: make table_compute_checksum() arguments const
  lib: smbios: verify_checksum() is duplicate

 include/tables_csum.h |  2 +-
 lib/smbios-parser.c   | 18 ++----------------
 lib/tables_csum.c     |  4 ++--
 3 files changed, 5 insertions(+), 19 deletions(-)

-- 
2.43.0

