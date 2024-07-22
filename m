Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2216C3DA70
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 829D48872F;
	Tue, 23 Jul 2024 01:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XPymkV3D";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mm8bY8Eh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CCF387F82; Tue, 23 Jul 2024 01:30:02 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BC7E87F82
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WSc291MDDz9sWt;
 Tue, 23 Jul 2024 01:29:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HdLInLhcMD/TtnjR9pfgRwDDv75Eti09cmRAB4yUB7g=;
 b=XPymkV3DibphfKSUsF47mE0WfiC29aufh15LrzRPlvKQU+v/kEANHvIKPSMXIViZlMvjT5
 ywvCLrIhdHeUBUbwL2V5ibxUPpZUNCcpKgWctmG07DwZUph/JVLcp8kWFi834xeLjD/Fqc
 Lms0lamu3Y4I7zZJHXJgciu5eV4zqhfo3/QyM2ZypNrQyav6ZS6jJ8b35DPmGrkrgEiDdQ
 lqlsEYowdVRfIWc6DbKBTbtwpMN9MUDsuUPCzzoMopRZsN0j78BDkfigdVUMl8J5hWP1up
 RFJ6mCICXwU31Ji1AH/WxyVZwLJB23a1XH4wX5VbKBlQqUGh+nNdzK0x6ySk6A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HdLInLhcMD/TtnjR9pfgRwDDv75Eti09cmRAB4yUB7g=;
 b=mm8bY8Eh53Mp28Ex8/p6CDq7dU/Cpq45jjolyAQZHPj3lAS9rhXbzUyGO4ZbhkBLaG5FLK
 CerB3nmx0+CUo8VWGJ/1p99QFTC+s2EhUmIN74TZMJfh352nsNl1QWoQCzWUPw/u26lKjs
 M1NFQ43Wsbdj4Y+SGqF/+4nc9LT+W+TCHe3Gd4Jr8A80kmUvdhI4hS+T69IO/QpoCpeEmF
 xBrwUpcMiu+hUGL82qCOXtBAW0Y8MbSAVFCIgEJYqY/obsPWw5Yp96PY+PSTGXjq4iKCuH
 NuheJPu2JrFLeRTo08HxdIM2OIZwM4jecrGGhDAnhMONVjYmI+YMVr09TLB5Sw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 05/15] include: fsl-mc: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:24 +0200
Message-ID: <20240722232910.91249-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 014edfed45bdf5623d0
X-MBO-RS-META: wrf9ntm8u1jqyjsfh5h6z8qh3pxhh5ap
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/fsl-mc/fsl_dprc.h         | 1 -
 include/fsl-mc/fsl_mc_cmd.h       | 1 -
 include/fsl-mc/fsl_qbman_portal.h | 2 --
 3 files changed, 4 deletions(-)

diff --git a/include/fsl-mc/fsl_dprc.h b/include/fsl-mc/fsl_dprc.h
index fb95ac544a0..22240d88a33 100644
--- a/include/fsl-mc/fsl_dprc.h
+++ b/include/fsl-mc/fsl_dprc.h
@@ -149,7 +149,6 @@ int dprc_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
  */
 #define DPRC_CFG_OPT_TOPOLOGY_CHANGES_ALLOWED	0x00000008
 
-
 /* AIOP - Indicates that container belongs to AIOP. */
 #define DPRC_CFG_OPT_AIOP			0x00000020
 
diff --git a/include/fsl-mc/fsl_mc_cmd.h b/include/fsl-mc/fsl_mc_cmd.h
index c239595ed57..3acc427f99d 100644
--- a/include/fsl-mc/fsl_mc_cmd.h
+++ b/include/fsl-mc/fsl_mc_cmd.h
@@ -68,7 +68,6 @@ enum mc_cmd_status {
 /* Command completion flag */
 #define MC_CMD_FLAG_INTR_DIS	0x01000000
 
-
 #define MC_CMD_HDR_CMDID_O	48	/* Command ID field offset */
 #define MC_CMD_HDR_CMDID_S	16	/* Command ID field size */
 #define MC_CMD_HDR_STATUS_O	16	/* Status field offset */
diff --git a/include/fsl-mc/fsl_qbman_portal.h b/include/fsl-mc/fsl_qbman_portal.h
index ee0e4aa50dd..11905f491d0 100644
--- a/include/fsl-mc/fsl_qbman_portal.h
+++ b/include/fsl-mc/fsl_qbman_portal.h
@@ -23,7 +23,6 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *);
  * dependencies we just pre/re-declare it here opaquely. */
 struct ldpaa_dq;
 
-
 /* ------------------- */
 /* Pull-mode dequeuing */
 /* ------------------- */
@@ -110,7 +109,6 @@ struct qbman_eq_desc {
 	uint32_t dont_manipulate_directly[8];
 };
 
-
 /* Clear the contents of a descriptor to default/starting state. */
 void qbman_eq_desc_clear(struct qbman_eq_desc *);
 /* Exactly one of the following descriptor "actions" should be set. (Calling
-- 
2.43.0

