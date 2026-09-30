Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F064ACA5FAB
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0827C40A44;
	Wed, 30 Sep 2026 06:40:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FXJ9disXmpaD; Wed, 30 Sep 2026 06:40:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A58B040A3C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790750445;
	b=iRTBXZ4cleHIMJU8fXtgyfIT+Bpa1UqEPuNyObOiYgpE/2un87ye9Ta7seeCNHtu6BrY
	 6CablScrWcG4oA10Eqw41z0DBRCSt21m36YrVHeOvL8uDDQTo5OSqCJZJpe/G6Oyg0dTk
	 lSMUc2g7t3fs+53S6wzJx9SnM47ps76FezVKTwCz66ui6/xbydfL4MmQUW3E/d7i3OQia
	 k2pUvzKsFIAMwH4DxrjjKlD2+gEW15gYeB3qIHio4wk8L2YHRsn6ouAxWIqYBnpEF6IUL
	 X1K0X515JvnyyOm6L3yBLw7ikAcdobiLCDFxPTBRvkmRgXQcfO/aOpsDCY3756aQOqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750445;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ewLOiCaTAJGFhVEG07ukzRw2TKEQktYF/4SyfxcaYyk=;
	b=Ci+HIw8W1rpnDF3MYvEwKivADyQksBErEU8HK3Bkt4pLqp/g/rvyJ9N5Of2DRnt1M0rs
	 5zWeF5OeWnUhQayQv3vmymIVilcLMh9Q9sMATDXI2R3yR4DdCgSsamPWkBI1gzdW0KccP
	 7ZW0rGhrSm1JDFn9M9UQWeqCvrijyL+4h3rwSck9uCnPe0uQzrehwFOZ8TtVE6uCJtS5/
	 lA6meOSuBj/jZ5f0OiUDmUkwNUry6Sx/7yY4ilqNY7DUA6YXRzqduajfZPg1qgH+QzotX
	 PbPcn7ZfkasGEBAunhUPV8MqZeVicdrQNOL5ECwzMo0k8yEu7Tk0z6o/anOta9YQ4Ww==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750445;
	bh=ewLOiCaTAJGFhVEG07ukzRw2TKEQktYF/4SyfxcaYyk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w0QV2BLst8vkIb8MChiCLjdW6yTfPz71TbCzC3waj8+4JQSbVz15PMUcWMhHUJzZK
	 BbUOrwl+jWTRgjfSTYxdpXn3+fTAcsqbAI+G+N+5WJsFhXWCEmwfX1YoRoh6UleZaA
	 9WeN0/kqAhAkiQ1eDEN3NkqhvPyADAmOh2JrVhXLInYydb9YtOi6Irezyh7JxWvHsX
	 lxUTEuGn+Q1snN8Hpag/qqKo0Z9yyqyqgckYyAv3i4r9VoybK9XvtgJc3FLBPlTVuw
	 KBIdI+s/djQdZ0ENKlw+Mowenzc9rqhlls/hZvkYc2gkcEbAJ+TLg3fcEhe6GuLLRR
	 qID3NV3wgNFWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A58B040A3C;
	Wed, 30 Sep 2026 06:40:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7066033B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6122A40369
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iasa6OC26pKe for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:40:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1CB844009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::13"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750442;
 b=mAo2pzm/xYGwKZXruWQMMvol4yx2rlhmtsMdm+YLctdwBFwv+59goOjwBUCw4VA5lhuq
 JICHrFWRH2HWI4xma1uNLUavzlZj6MEDBRsYlbsPJITJKbxhmbeZHuiwqeSpRhPInh3Oa
 5G2Zy66oe17fO6aoS6Z3Ko2EBEbwJLyhDscFeKLoP2i0K/td2x2GR9rlGe6VTPMA9ci6c
 jVDFtJTjJANmyyyvnsj1mGUresNLvbcI+BjnlD4J9/yPzfz+yrWRUy8AmIGd3r1AqMBUc
 eZFDjmAN2+O+kwcDSBUvu/CTFXRPrruYLQoxVJCkJTbfh0wVb1Z/TyPEI+xbIvHWALg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750442;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=ewLOiCaTAJGFhVEG07ukzRw2TKEQktYF/4SyfxcaYyk=;
 b=YFnCtHa2CjYRxeqDGtjBKc1hULnxSxMrhM2aTyX1q4H0Bi1buXZZD9FyBNKUp4r1TNnf
 prNhW5k71vxBon/daJS7KdR7K8oqUWKT8X0Zp1v001poTab84UxdJ+3jYFNLed7Yvulcr
 0rA4c2pproSf9AFW5LCux0ANFfnvUkqef/BDn4ZmjfRYhygasIEruyqDZD+R36ynJZ7bV
 fl5tdHjLJIhCEIS29vj2NQyGceS1KEzyrfZG+UsNddjPUSNwhIO7cvAdc3bPFGecdPbRQ
 zXkekXYwTRg8oRatGD5FRZ8NQ5Ul5LyImxyrXdjH6f/OzxbRa/906fQEMa/gLJpUb5A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=MppAONBD; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::13"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::13;
 helo=smtp4-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=MppAONBD
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1CB844009D
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:40:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [88.175.0.64])
 (Authenticated sender: vjardin@free.fr)
 by smtp4-g21.free.fr (Postfix) with ESMTPSA id 4C90219F5B2;
 Wed, 30 Sep 2026 08:40:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790750439;
 bh=bxorNFLQC/rfzAfbsUoW6ePWNGesM90TgHmQgyu2WRU=;
 h=From:To:Cc:Subject:Date:From;
 b=MppAONBDBphjigOvIL+lgUjkA8pYsqXp36Syzgx2yCCbvAmMzaV4CPM1MxXxzXHv3
 sCfMZm3bXzC7urP6A+bRUgSSOb/sBE/rNcvP7O0JJCDP1fbcgtD5RGNuIq9dfk/8Ep
 +AqmjwzEmxdo2CO+ZuxelYF5kFOe3wA3bXMd7DXPlQaVV4z3uW4sGUH96TFQBKtDce
 wXAWRAQaJHOYLKlt8i6haXUy/05pzm7ycVlfU9ZYjAxGNYRkOHg04x0LQuLdAQrW3h
 jjg6rdkuGGvpc+7wa4SMF3TEEIyi1+o6URiOwFnj3BbY+rnIAn+jLEFamOrHSAQhDl
 jPOngt4WQhpNw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Frank Li <Frank.Li@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1] armv8: fsl-layerscape: icid: also find DWC3 nodes as fsl,
 ls1028a-dwc3
Date: Wed, 30 Sep 2026 08:07:41 +0200
Message-ID: <20260930060742.1446427-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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

The ICID check the USB controllers as "snps,dwc3" to add
their "iommus" property to the device tree passed to the OS/Linux.
The upstream Layerscape device trees imported since v6.19 (dts/upstream)
described these controllers as "fsl,<soc>-dwc3", "fsl,ls1028a-dwc3"
instead, since the Linux commit
  7b204755ebc2 ("arm64: dts: layerscape: add dma-coherent for usb node"),
so on LX2160A boards, it fails:

  WARNING could not find node snps,dwc3: FDT_ERR_NOTFOUND.
  WARNING could not find node snps,dwc3: FDT_ERR_NOTFOUND.

The tables cannot simply switch to the new name: older device trees
still use "snps,dwc3" and carry no "iommus" property of their own.
So, let's keep "snps,dwc3" and, when it finds nothing,
then retry with "fsl,ls1028a-dwc3", which every newer
Layerscape USB node lists.

The stream IDs themselves are programmed by set_icids(), which does
not use the compatible, so the hardware setup is unchanged.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 arch/arm/cpu/armv8/fsl-layerscape/icid.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/icid.c b/arch/arm/cpu/armv8/fsl-layerscape/icid.c
index aa0af077d2f..9b6d5225799 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/icid.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/icid.c
@@ -5,6 +5,7 @@
 
 #include <config.h>
 #include <linux/libfdt.h>
+#include <linux/string.h>
 #include <fdt_support.h>
 
 #include <asm/io.h>
@@ -71,6 +72,19 @@ int fdt_set_iommu_prop(void *blob, int off, int smmu_ph, u32 *ids, int num_ids)
 	return 0;
 }
 
+static int fdt_icid_node_offset(void *blob, struct icid_id_table *entry)
+{
+	int off;
+
+	off = fdt_node_offset_by_compat_reg(blob, entry->compat,
+					    entry->compat_addr);
+	if (off < 0 && !strcmp(entry->compat, "snps,dwc3"))
+		off = fdt_node_offset_by_compat_reg(blob, "fsl,ls1028a-dwc3",
+						    entry->compat_addr);
+
+	return off;
+}
+
 static int fdt_fixup_icid_tbl(void *blob, int smmu_ph,
 		       struct icid_id_table *tbl, int size)
 {
@@ -80,9 +94,7 @@ static int fdt_fixup_icid_tbl(void *blob, int smmu_ph,
 		if (!tbl[i].compat)
 			continue;
 
-		off = fdt_node_offset_by_compat_reg(blob,
-						    tbl[i].compat,
-						    tbl[i].compat_addr);
+		off = fdt_icid_node_offset(blob, &tbl[i]);
 		if (off > 0) {
 			err = fdt_set_iommu_prop(blob, off, smmu_ph,
 						 &tbl[i].id, 1);
---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
branch: for-upstream/layerscape-icid-dwc3-v1

-- 
2.43.0

