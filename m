Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEA5D13569
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 15:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EA7389030;
	Sun, 27 Oct 2024 16:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=khoahoang.com header.i=admin@khoahoang.com header.b="KUIpn5G7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35FC688C10; Sun, 27 Oct 2024 06:13:26 +0100 (CET)
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com
 [136.143.188.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86611889DA
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 06:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=admin@khoahoang.com
ARC-Seal: i=1; a=rsa-sha256; t=1730005982; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RDiPSMzYqJRzV8B4Tym/kNo7Ud5DCCBrZMY6iORigZIKFychwN3MYVzrkPOyOgG43q4Ies547ldKCcwsGt2qRanQUOVYTPpVDLCUqbt+c6dWC/B6hvKf93J/ue3yRaX/dz5P3sdO/Xrs+xng1hUiod04jC0w26P13INNpI8asFo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730005982;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Vt69X50Le4EDPB64EpgZqbde2EuhQWi/VoxI38iLpNs=; 
 b=R1k01YGDTIZQ3VOb+TUVenHv0iJDyIwxJ4IvUYVNK78frm2non3sXBMrTD+o+aJ5yE1+y3FqxBjyeDxECiGN3dapZEl6QkzgdA3WFWxV+6nBM5Z1kr58PWc6dUljiG8kSLOLGZwhbIAahX6x4xUvKwVeOhNzbadVfWUCR8tRgdU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=khoahoang.com;
 spf=pass  smtp.mailfrom=admin@khoahoang.com;
 dmarc=pass header.from=<admin@khoahoang.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730005982; 
 s=zoho; d=khoahoang.com; i=admin@khoahoang.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
 bh=Vt69X50Le4EDPB64EpgZqbde2EuhQWi/VoxI38iLpNs=;
 b=KUIpn5G7wBROzF3M5XKKzDd7rOsgg/n4emvZjp/vH4/tUqmAvJi7rAJtfnKvF9BF
 x3tutINAQH93A3X65q5zprozp+bH8UtntXASHhkrIh1iEEibIzPl+nC/9K0962eT/P3
 EKbqO8b85Z1wT535jP/jaJ61ruKL1x7wMWLuAsc4=
Received: by mx.zohomail.com with SMTPS id 1730005981632228.07480966063747;
 Sat, 26 Oct 2024 22:13:01 -0700 (PDT)
From: Khoa Hoang <admin@khoahoang.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Khoa Hoang <admin@khoahoang.com>
Subject: [PATCH 0/2] eth: asix88179: Fixes for ASIX AX88179A variant
Date: Sat, 26 Oct 2024 22:12:48 -0700
Message-Id: <20241027051250.35627-1-admin@khoahoang.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 27 Oct 2024 16:06:22 +0100
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

Hello U-Boot Maintainers,

I am submitting two patches that address issues with the ASIX AX88179A
Ethernet driver in U-Boot. These patches resolve problems related to
PHY hang during auto-negotiation and stalling when handling large
fragmented packets for the ASIX AX88179A variant.

---

Example of AX88179A hang issue:

    => dhcp
    Waiting for Ethernet connection... unable to connect.
    Reset Ethernet Device
    Waiting for Ethernet connection... unable to connect.
    =>

---

Thanks,  
Khoa

Khoa Hoang (2):
  eth: asix88179: Fix ASIX AX88179A PHY hang
  eth: asix88179: Fix drop of large fragmented packets

 drivers/usb/eth/asix88179.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)
--
