Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE982E92722
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 00:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 003BD83952;
	Sun, 28 Dec 2025 01:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="cU3iQDGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E265D8397D; Sun, 28 Dec 2025 01:44:25 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA3B083946
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 01:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=manjae.cho@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20251228004408epoutp0367b1adf5ee738b7da0a5fb4feba49a9b~FOmhkSGE21521215212epoutp03C
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 00:44:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20251228004408epoutp0367b1adf5ee738b7da0a5fb4feba49a9b~FOmhkSGE21521215212epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1766882648;
 bh=Rqk8DMM5v51C3vlG7SM8ck8NDHKkXg83Hz1cQB8229E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cU3iQDGtoBVOMikb/o2iDErpi4gjzNYrJngD5ovpK/NM/TEXTOanmxwguSgaraW1h
 taNBX/Txv5uQYg/+YTqoVkmt1cfCCt/ehLjcODLCWOTMIAiN4byWYbHWC6NAH4rvOH
 wdvyC1gXCZRfK/pzWVBdTM8ryIAJKJIh8/ZAxg5w=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
 20251228004407epcas1p117a259ecec0cd2a489f698df8c662096~FOmgf0pbv2564525645epcas1p1f;
 Sun, 28 Dec 2025 00:44:07 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.38.118]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4df0wR2Rs9z3hhT3; Sun, 28 Dec
 2025 00:44:07 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20251228004406epcas1p4147e9f1998ac45c5d3e0e38599396ba4~FOmfQzIKw3212132121epcas1p4S;
 Sun, 28 Dec 2025 00:44:06 +0000 (GMT)
Received: from manjaecho-VirtualBox.. (unknown [10.89.15.251]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20251228004406epsmtip2f990e89ffad61dc0b77ddacb433c1049~FOmfMULnk1614016140epsmtip2z;
 Sun, 28 Dec 2025 00:44:06 +0000 (GMT)
From: Manjae Cho <manjae.cho@samsung.com>
To: xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de, trini@konsulko.com, sujin.u@mobis.com, Manjae Cho
 <manjae.cho@samsung.com>
Subject: Re: [PATCH] doc: qemu-riscv: Fix typo and add network testing section
Date: Sun, 28 Dec 2025 09:43:51 +0900
Message-ID: <20251228004351.13949-1-manjae.cho@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251227142036.10661-1-manjae.cho@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251228004406epcas1p4147e9f1998ac45c5d3e0e38599396ba4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251228004406epcas1p4147e9f1998ac45c5d3e0e38599396ba4
References: <CGME20251228004406epcas1p4147e9f1998ac45c5d3e0e38599396ba4@epcas1p4.samsung.com>
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

Hi Heinrich,

Thank you for the feedback and suggestion!

I agree that network testing documentation would be more useful as a 
separate file. I'll prepare v2 with the following changes:

- Patch 1/2: Fix the typo only
- Patch 2/2: Add doc/board/emulation/network.rst with QEMU network 
  testing examples

This approach will make it easier to expand the documentation with 
additional network configurations (e1000, tap/tun, MAC settings, etc.) 
in the future.

Best regards,
Manjae Cho
