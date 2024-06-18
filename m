Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35B8C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80104882EF;
	Tue, 18 Jun 2024 17:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RX3KCE73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C8F883BB; Tue, 18 Jun 2024 17:34:49 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D6B98834B
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5849261A02;
 Tue, 18 Jun 2024 15:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E43C3277B;
 Tue, 18 Jun 2024 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718724885;
 bh=MPlblwN3eISBv5Uf6HhRVKiDEPr8Q8Kkp+s/+WnyXMI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RX3KCE73f4fo8wYkEltQYzw8Nj0eN2PUHbC39RVzzXsQxt/kLYfqNxJMKmHLkqfYW
 uLyy6HrURhyR/9UrJZLaD8/LrUnP6mMln1+PdTWVxWfIgDf4l/v6msPBhA6fwHbqR9
 lDtJTOPvVXCqTF+m4eHXuPHmBRRQO0YCyWJfTBl+TIUbKD9JAI4ctVtvhfWo44tVyf
 x89X1+oZip10vAQEMpHdP2T//34q80zGafTdgAnPMcUUe4CqkDbRTixusDwESL0p1h
 ybBREv51zxOuH9UlDsiJgsQpTb7HchlNFlrEz4oMGnoMt+Wt/i6YB//wh7FjkB/HK3
 HHqRVzt6bcVRg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 01/16] arm: mvebu: turris_omnia: Disable ext4
 write support in defconfig
Date: Tue, 18 Jun 2024 17:34:24 +0200
Message-ID: <20240618153439.9518-2-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240618153439.9518-1-kabel@kernel.org>
References: <20240618153439.9518-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Turris Omnia defconfig is nearing image size limit. Disable ext4 write
support to reserve space for more important stuff.

This reduces the size of the KWB image by ~19 KiB.

If in the future U-Boot supports compressing itself and decompressing
on load, we may enable this again.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 configs/turris_omnia_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 225a76f993..d5699782d7 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -124,4 +124,3 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_WDT=y
 CONFIG_WDT_ORION=y
-CONFIG_EXT4_WRITE=y
-- 
2.44.2

