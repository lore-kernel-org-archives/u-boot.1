Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB3606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C1WCzvqZ;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.a=rsa-sha256 header.s=default header.b=Jn6Ci0sr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B9DB80D9E;
	Mon, 23 Nov 2026 14:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fuF2DYqMeE-f; Mon, 23 Nov 2026 14:04:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BA6CD80E36
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795442688;
	b=gRemoMdYKjg2VTS/Iva/b/NHIV72+zHbkmv9W24vwV/RKmDDts9OsJTBOsaYUYewQkbT
	 w3oy1SAezKmg7aZfuIhQJH5E3rY8ewnytxCETnC+kDh2JcEnb6l9UkccXNUGMCJexxQIl
	 gUMp/gj/dlc5cezfmkAZ77mfN+ZW7BeDr/Nnya3y2zxsIblLofRHnhului2oXPqpVWugb
	 EErcJ7Fvxw7BmWeC2NNmRv0v8H3yPXJaE99QUqvOvFd1jb/VOS5XO4FnHGXZ2WdM7XLDp
	 xzYV41CYdbAs/5aKtvR89KYOrSU9TzLBCcvH5THfKUkTGM1DRfT4JY185MTi6AgZkUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795442688;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=I+Gt2FbW8NDzTde2QLkOuA09bfiqOM2JgYjVF2VB+hc=;
	b=cG47gyScu5z9/w9+IqAANzLkQAxuUT47Pcp36gE6AWPguplvT/F2wVuNhfp2g1FnZCbW
	 mmTz9eWvI0joBPsUfphZwbQxv1cyGNwwVTYhUI8eivpQFjVNCzsVH8h0sCtLlcpPELhg0
	 nbLketxq1k2abAkqodL3h9TRQGeD8GB2NmEg4kOZSFVnw6AtHBUY3YtxvDGtuXR+OmW1s
	 MnjYFRL4/QNJUvbexKknuJbzEGHuO/oRAuTSHNLGORCqEVCOpIwVNNFRIch4GjFgFmgD8
	 ugvlAX6I7YodcKT1nTj82NSSe7DE/qZD1XGcAPVX6fFJqvkhO+EZ4hDL6aFE51qnMwA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=norik.com;
	dkim=pass header.d=norik.com header.i=@norik.com header.a=rsa-sha256 header.s=default header.b=Jn6Ci0sr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795442688;
	bh=I+Gt2FbW8NDzTde2QLkOuA09bfiqOM2JgYjVF2VB+hc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C1WCzvqZpfZuCnYs+K5oiYl4b/8rW04OTF9JKRmHOu5EBvzm1g/UYJILoB3Htfhc4
	 kjfjiUT9zQy8/znSSZs5AIKHJFOsSlJvdXXsBqOSc6JIciy3DU/SfmGssg6hzV15iO
	 WvXn7Dacy8vAFCUs+wDWK0f27NNMe09J9BgUii6+M3wW6v4e1qoksOnniyKN5eT/7f
	 QF8Nb5mQmrnV6KAiQNJh3FgsvogO9OosTAX2Vd+caBGGdlgOXa7WCU8oJOTa3Ah2HH
	 69ZqGOSTH5Bul34aHi83H8VZ6I/PC+LmecmzQy0nv023wM/9C0vIwbK1UNuS7RSu2d
	 9IvtdsE8p3fVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA6CD80E36;
	Mon, 23 Nov 2026 14:04:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BD56FE0C
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AEDBB80D83
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:04:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nKYOj2qqxU5D for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:04:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6BCC280D7A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=46.19.12.180
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=46.19.12.180;
 helo=cp2.siel.si; envelope-from=primoz.fiser@norik.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=norik.com header.i=@norik.com header.a=rsa-sha256
 header.s=default header.b=Jn6Ci0sr
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BCC280D7A
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I+Gt2FbW8NDzTde2QLkOuA09bfiqOM2JgYjVF2VB+hc=; b=Jn6Ci0srU4k7zOYV6dKEKnhjks
 wGgn2Xrz4ejj1zocM9Szpjz7pOTK9hUpYhLcqOUGutPakilV2GuXb/W7OBoDam1XGQ8AvDwINgcs/
 bSQ+Sai629BwMDolTW3OjROjoAr0ls97ZvGp7dzjY4LaiqU4U/QP8azVAEKgcPxJn33gD8btWz8o/
 TmmdU0o0NiIynisL12jiVU0nhe9Q78bZEVTEY1p3fR/+LlwiARRh4FwSuq9piq0lTU65XYJIb4Gxk
 8NXUIHB20Ez0Ncy3Jn9zCk/I5NL/nuDqFQqJJu4IRDSO0fIJZ/LKRivxdQswhjEqsYDiUXlTNIMRE
 QzCea6xA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:59646
 helo=z840.taila37813.ts.net)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <primoz.fiser@norik.com>)
 id 1xVUet-0000000H57M-0hR8; Mon, 23 Nov 2026 15:04:37 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: upstream@lists.phytec.de,
	u-boot@lists.u-boot-project.org
Subject: [PATCH 0/3] configs: phycore-imx8mm, tauri-l: Enable crc32,
 mmc reg and overlay support
Date: Mon, 23 Nov 2026 15:04:34 +0100
Message-Id: <20261123140437.1526666-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable a few commands/features on the phyCORE-i.MX8MM based defconfigs
(phyBOARD-Polis and phyGATE-Tauri-L) needed for PHYTEC's automated
testing and for devicetree overlay support:

 - CONFIG_CMD_CRC32, for verifying images loaded into memory
 - CONFIG_CMD_MMC_REG, for reading eMMC card registers (e.g. EXT_CSD
   SEC_COUNT)
 - CONFIG_OF_LIBFDT_OVERLAY, CONFIG_CMD_IMPORTENV/EXPORTENV, so bootm
   can apply devicetree overlays from FIT configurations and the boot
   script can import fit_overlay_conf from overlays.txt

This series is based on top of, and depends on, Thorsten Schmelzer's
"[PATCH 0/4] board: phycore-imx8mm: Add support for flashing through
UUU" [1], which is not yet merged. Patch 2/3 ("Enable mmc reg command")
touches configs/phycore-imx8mm_defconfig immediately adjacent to the
CONFIG_CMD_USB=y line that series adds, so please apply that series
first, or hold this one until it lands.

[1] https://lore.kernel.org/all/20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de/

Primoz Fiser (3):
  configs: phycore-imx8mm, tauri-l: Enable overlay and overlays.txt
    support
  configs: phycore-imx8mm, tauri-l: Enable mmc reg command
  configs: phycore-imx8mm, tauri-l: Enable crc32 command

 configs/imx8mm-phygate-tauri-l_defconfig | 5 ++---
 configs/phycore-imx8mm_defconfig         | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)


base-commit: b6f1fae674eb2d7c558f2ddbd885f7bba70eebde
-- 
2.34.1

