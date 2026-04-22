Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BF0FA1FC0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 15:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FB9D83BC8;
	Wed, 22 Apr 2026 17:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="omuoo7of";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B10298431C; Wed, 22 Apr 2026 17:39:31 +0200 (CEST)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [95.215.58.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE1C283BC8
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 17:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776872369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lOuZz7lvQndsIyML4zQVJ7hX8vwExcnhjD2pWkXMGLI=;
 b=omuoo7of+N8mEE/5kTz8rkw2Cv6z/9mqC0Weg1F5Ss2Qz102X9QC1nQ0R+Kdvf9P5An0CG
 +YRKLJjRFuMy5HC5oDF5u0Jhfhwo+41Jfs/SnyYC4qynmkMZQ6xl/OfUn6ttc2tjdRMgu7
 mm8KdTPALig1iyrzcvrAMYGNt3yk4gBpc/rWGhQkEQ953ud8twVf+GmwO9fWLpTjGouXCR
 RCPQ/6wB0ZDu2sS2Hrpu0vbq5I8Vhev1DPYAUl9n7JzXTSPWTZOSf6mQtVHD0z6/E3ef0C
 vrXI4DdHgFSiH4aCTMU6vEx7TPXbAty0b2f32u6J5NxfXFD/yczSjlWyMYiJNg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 22 Apr 2026 15:39:06 +0000
Subject: [PATCH v2 3/4] configs: libretech-ac_defconfig: enable EFI Capsule
 on Disk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v2-3-e04e4c9e69f9@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=771;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=lsFAb6WIU7UkZswT3Jl47z04z/J3OIDZgcTSN4HJH+0=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp6OurznQytNRqzroVSWlPpm9hHrZbiAI3U4fjz
 IihpWQsCFyJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaejrqwAKCRCEr8vQ14ma
 Ay+MD/4hJkYtTOocUQjsCaRDsjp/LINEeFNH1CP896f1BBBICKJs27dXWTfGZyb61d30hsnwA+g
 +mStGnsxXeT19nqC8cFGOzM4KRGNXV2SakmI/MgkxxclePy1d58GYMNeG1IdwOzhDVtMnPwFmEt
 TJIpziJ4iYKP4pLYTxghRaYhuVuN9lYIqn6d8muaNryCahDCs8FyvIs6CXX5c+zUfa7yoHUTJwu
 eH0Bi2l6cfe0cvsFIKRorvDPVH6DrhdJbnuP6nbcRWcjUxAzaUtFzoR6NrMEDUbF8lmNUoNZirl
 u6f6yS8EfwBAsC/6rXgR4b5N1Lnx3Fiu6GZouOT2R4qN4Ao1V0CQxQwJ9hwh2+o538k8viyu4M6
 EDP5D24ttPwzYyzi/1T392S94yj3uNC4kYLkK03PEkuZdbxwQ2vxXQdJjzA9rXS9mf71tSMt7nD
 +NDoNpD1cqkSPmJu5Dj0kbrWEzJo1fVio0jgKc1OWPvgVsE9b5BYor/FostT1KmpmngTzGdqPgk
 1/W88RNWruPRrEzdmuZ6OxULbTtj2U5xW3hsO/A2MAH9artFXOlfBvhV1SVCJ9htII5Qc86sSFh
 26hiQC7TscBHu+PhUjroVweOaF+H26sSEPR9wrkTIRdSg9JgATKbmy6/yXALeJCB3q1Y7RK/lvd
 2JyB6Wi0Snl+zPA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Everything is already in place for EFI capsule updates, so enabling
Capsule on Disk is fairly trivial. This allows updating U-Boot on SPI
flash from Linux using fwupd's Capsule support.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 configs/libretech-ac_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 1a67ca734b8..17d54655017 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -23,6 +23,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y

-- 
2.53.0

