Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26795C61DB9
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 11:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F91C40848;
	Fri, 28 Aug 2026 11:23:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FwCC_zV_UTzV; Fri, 28 Aug 2026 11:23:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787916224;
	bh=SwsnwjPDIxmx8JsE3it0f7Bv34mrfIvKdtBIJxck66A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=reiQpDENXgaDBH2FtF8VLE5bfHqLQHiGAdkcOt1iqf4n5XGkWeR02ACM6FbkD4wPQ
	 O+pvjcC3DHIQppcmpOJ7roR+4KFZ2bNwSisrfwQNa5H3HsK+npFgnW237w88tcBuPP
	 mNgkKgJ3rPDqeebyPF4iMuZTXSmyaNnFyMCpio9ei9JuXVEGM+UNJoMeJ6/46BHjTe
	 gXTrP/ski3k+3uFS62XDxUWJUBztjzFo6zs8Ocav3JRbVbNZ/eBYFXzVeSAijthuna
	 ijSl/dXSDDz1zQl95kEj8X2sULLEHBGBZAKBEZAY9DPLdzlgmdlxtyOKNRMaUTUm80
	 FuzaFi/C60IAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A449A407D3;
	Fri, 28 Aug 2026 11:23:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 23970465
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 11:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1571640121
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 11:23:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 35P_8k807DkY for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 11:23:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=AbLFtIzU
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E3064005A
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 11:23:40 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso5412935e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787916218; x=1788521018;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SwsnwjPDIxmx8JsE3it0f7Bv34mrfIvKdtBIJxck66A=;
 b=AbLFtIzUkVCxAI0kOhDVpjHx+iSshxU1skn/vn3cVA01+dHFigzZQcefctiohqrGS6
 lVkgaRkiT3YzueJP1fGk5157GRsa4HMDkORWAp8pTT1CgZ54GJ+hZImT/R7wFXzIVQY4
 iMP2c7RtbVP2Q5e+vRyG+sEI/2njfGZPqtKcsCpZC5AzrjCL1QxWzexVCve8jGP2R6Wg
 T6W5veJjTBE/2ewmpYesGmg0TRwcwkESTNsRIaEExTm3Pz99yP1lLw5JraK9fSU0mOnu
 GnGct5YeFQh0LBdubdfdVYibEWu+Kr5ukMHPO6/hPErtMgJ/qWiX7ZdamZcIUhEoBPbm
 Yhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787916218; x=1788521018;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SwsnwjPDIxmx8JsE3it0f7Bv34mrfIvKdtBIJxck66A=;
 b=Qty90ds/daPRJXjSYeA5+a1AjOYhFPSqNR/tgBcPQoSvtJIsq+rB2opsasBeGBoUJ6
 EwXn0kcCe0M/UTxy6MldbFkhKIaGyhr3uk8j996Q4ive0FR7bPq/hngl+oCkzK7KU7aD
 bKwxbrx7FAfWuOQ2p251/CWt0wnJyk3OG2kSJcIh84D/tkmeRJ2oYH71fOSGvudWdMxm
 qFfMYxbfImyQWezczQBHG5ymrTx5WFI3QaLTVlHcNXODVmGz3pgRWLnqbucP2G2BGqT3
 1g2airubj0SJLHtitwHyidzB9U5aKAlTAkG3E8pUp365x8BrbevogrbMPzD/kmhGMLGp
 QTxA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqs3PPOOcmwvpIm9YdX/xw/mOhnZimnRr5gpGIUMm6wsaw4BapnYqLmMRO85XgOJUch1EPcFTk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kXWcmI59OGy/3ESNRzluJZoNN/ehFAi7v/r8buNysV1pljSPtz
 +x5D2qb1F5kq1RS4fqCY7AvMi5BwsKhl1oxQM0EVPRAWrvWsR1/tG7mS
X-Gm-Gg: AR+sD11wIW0UEw2cnuffOBg/4hHtM8z0tVFavW6z62kd0qG4t+mbT1Cgr80i3vmhgrT
 FChZn3KVZCUMtGicO3upZWNlqE/OSQ77PSNvxeLPPRyvDJ01g4Aa0CT4jJHpagDjzWenvRj2AOx
 jj03OT3KV3OZ04SMIXNwERIFWPOcGjWiBESFe6ELlwsOn8hXGs5iegrwC8PMhUCZ7v/H7dhGJZe
 IaTyHbCWMA2W4QN+D4prhcKtJLtvl5cwLKIAgsbQgpg/rKvbrEoAUIrNzE6hVyvv0O/ZNcDuHxD
 RNdqT6ZJ6fm/7qEXOYhEJY6C/IFoKwHZtCraMO6oGFYV1EzwUdXDb/e8PK3msZm6XeG7KnQKK/a
 oFMI0s90Ty0yBEJqKVLNWq9VOpFWY6B9vUyv4qd4BPiNMvnVba7exNzfbUti0y+tDPZQFBtVzin
 SauYFjykj4x3jrK/Iep049PEgNgv4mFsiV9OdPvDFswQ996GOIVf42o0PexNpv7R0MeA==
X-Received: by 2002:a05:600c:c4aa:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-49b91c56cccmr67737015e9.9.1787916218184; 
 Fri, 28 Aug 2026 04:23:38 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b90f78244sm79535595e9.10.2026.08.28.04.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:23:37 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH] doc: board: toradex: colibri_vf: flash u-boot-nand.imx,
 not the plain image
Date: Fri, 28 Aug 2026 13:23:35 +0200
Message-ID: <20260828112335.40695-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The BootROM reads the IVT at offset 0x400 of the NAND boot device
(VFxxx Reference Manual rev. 8, table 7-51), but the page tells the
reader to write the plain u-boot.imx, which carries the IVT at offset
0. The BootROM refuses such an image and silently falls back to the
serial downloader, verified on a Colibri VF50 V1.2A. Point the NAND
flashing section and the eBoot flashloader section at the
u-boot-nand.imx make target, which prefixes the image with the 1 KiB
of padding the BootROM expects; that is the file the eBoot flow was
verified with on a Colibri VF61 V1.2B.

Fixes: 26e89c626827 ("doc: board: toradex: add the Colibri VF50/VF61 page")
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 doc/board/toradex/colibri_vf.rst | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/doc/board/toradex/colibri_vf.rst b/doc/board/toradex/colibri_vf.rst
index f9c81d70214..a010f9f5a2d 100644
--- a/doc/board/toradex/colibri_vf.rst
+++ b/doc/board/toradex/colibri_vf.rst
@@ -25,8 +25,18 @@ Build U-Boot
     $ make colibri_vf_defconfig
     $ make
 
-This produces ``u-boot.imx``, the image with the IVT for the Vybrid
-BootROM, ready to be written to the ``u-boot`` NAND partition.
+This produces ``u-boot.imx``, the plain image with the IVT for the
+Vybrid BootROM. The BootROM expects the IVT at offset 0x400 of a NAND
+boot device (VFxxx Reference Manual rev. 8, table 7-51), so the image
+written to the ``u-boot`` NAND partition needs 1 KiB of padding in
+front of it:
+
+.. code-block:: console
+
+    $ make u-boot-nand.imx
+
+The plain ``u-boot.imx`` written to NAND is refused by the BootROM,
+which then silently falls back to the serial downloader.
 
 Flash to NAND from a running U-Boot
 -----------------------------------
@@ -36,7 +46,7 @@ Load the image over TFTP or from a FAT formatted SD card and use the
 
 .. code-block:: none
 
-    Colibri VFxx # fatload mmc 0:1 ${loadaddr} u-boot.imx
+    Colibri VFxx # fatload mmc 0:1 ${loadaddr} u-boot-nand.imx
     Colibri VFxx # run update_uboot
     Colibri VFxx # reset
 
@@ -62,5 +72,5 @@ offer a ``flashloader`` command that writes a U-Boot image to NAND:
 
 .. code-block:: none
 
-    > flashloader u-boot.imx
+    > flashloader u-boot-nand.imx
     > reboot
-- 
2.54.0

