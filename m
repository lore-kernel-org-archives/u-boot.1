Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3F2606A320
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Cv0u5s3y;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=dHeXji+M
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55CD0810D6;
	Wed, 28 Oct 2026 14:57:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ziQXcZh6T3Wv; Wed, 28 Oct 2026 14:57:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A32EE81027
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793199446;
	b=GYUXJd61QdWb9tpYpvLMBv2oxtBm47I765399+vLkkxeSxBPSxCwIArct5/Ad/4Ds0n0
	 xxAdfhtsolB9MCh2AyyPXY/4UxeD8lFXW22EsPAloJDSmTFtB5grYPVlKdpeVoo8DKb48
	 mgXYgsDYDaphPzYKfazyXwIIrj/P/jvErtFcfeWKs9VN/M2H9J3bJrgFS0trxL7DIJxIN
	 FqzXFX6VI5Q8OfJl2gDSS3y9euEIVngqq5OZJ7IwPAUAkQ8pri9rPMXqNIQbFyh/V5jWH
	 Bavs8jmgNpA6TPQBQU8BtqImOomScTgK7i35WSsoOYfASJGTHNt3Ox4GpB3wS+8a+LA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793199446;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EbgjwdwElV8WdSrU38arveP3dQ/gQh7i83OHPBOSUJE=;
	b=e0hBL4uX6KGb1c24bfN+aIzlIXkjKkFlDHX2+VOjgfsia2pvccC6EVpNXHJkluEstv0U
	 nx3Qby4BV1YrPtSxUaKGyRH47vuIApX3dRwzP8pxHwWzMBn465varxyhjpun32jBxYbMi
	 2Qii9LT26jcf8Ut2UZo/9Qt4dzaRAzsdYiu2jHPBv7JczHlSmkGLB+iIR+2Y+WzMp8tzf
	 bRc2a9z4qxOOThTHuIaQlGQQhKSkfmKZLEtn1ncLjCM+BghboRv4YQ0zcd4DG1JK7qw7E
	 MohA5X5u38iEd4JCzZpLr46gLFNzeYpvEOJO0VjKohPvH/sHHeHRgVLt2JBXbrmjUHw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=dHeXji+M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793199446;
	bh=EbgjwdwElV8WdSrU38arveP3dQ/gQh7i83OHPBOSUJE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Cv0u5s3yYQmsnikbcq7SZchfv6GEUeNGlYZefsk74812wPd71IK62ug4fnXezfw6X
	 8gW1uzxKE6z4DaNH5gGfy2hdWzvSy7DpSziAGyvh6E3NxbpzUVvjo9+68CU1GM6piv
	 NCDc9xkb+Pap0ahQaj/CIOe0Xxn5zXPFI0pVTsFjLaYxg+GfGsVqm29iBg4NsJBDzs
	 VuBS2rNm2HC9AvI2Mo9t6P2CpFSD+LNtovBiK2aNGMgnXlF+vnNKR3TIl8fIr8WUYI
	 IcvjTwY8R10voOwDPZ/MyAd7tTNNTk5h0KdErrJAGmNiYkTitTUAiyHlaEysdMOA0U
	 g12QG5kRctm+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A32EE81027;
	Wed, 28 Oct 2026 14:57:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B55E7D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:57:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6B1481027
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:57:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qwlwfrgMGkvv for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:57:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7DDD581010
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793199444;
 b=D3vybNNX2E+S2c0FYSkQz/spXF9e+JBZYHNw5Y/2D66mQFFq/ioUuYNz+f3LOFl7WT6J
 rN3cqKjCgTvt//1S7XYUWkoMIcClLoP19r8YVGiKMdZS7lI0UjTmD3U5fAJvBVGXqLp/7
 rHSDt1CM2/fL0HcgKUEVFMQQleL/Jtttk247GG2omJf+RJWONjYm0D3wBtBPEawCDE4gN
 x3QT9iJ7BnikGRNMC2hviT8re++fdAg0YlM7yiwS08mOxtoMMvtF2BRAOiQryGtiP/Rqz
 XfWNSg2aPxndBe2useMYLaxpOjBHNGxOoi9+lqkljZveitlm4lCFD0s/MEE61H6MG4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793199444;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=EbgjwdwElV8WdSrU38arveP3dQ/gQh7i83OHPBOSUJE=;
 b=TcJFATNeY/GhmbBASgHEK4zFKydkq7I80chKJFAM5pyH4OaBDjTS94RdbTu+q2cPN9Bc
 2P9jxoNBpEAEMMHkGhqohRGuYZJK/1UyNfFcdmUV3c03ae6JlcDFBnvXxmoLN7Hs/tGZv
 btu2rgZy3G9BkOBvebqfkpKEU7ytfwghiZyNVb2Kqc4r5R2VSwVzjrD/wBVhLWcvQa6Z6
 y0RTX+wN7Szs+NklrMupFjyxkGDmL98uAEwDW1hEuchCOdiJWiox4oqITVLfY4I/ulFQ0
 dRj56H0BAOlmjHKNoi4yEhdwo+50fE4D+vxd1dt6m5MGhHyLfgdT7y3tFOJg80wxL1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=dHeXji+M; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=dHeXji+M
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7DDD581010
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id EEE3EB0051B;
 Wed, 28 Oct 2026 15:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793199441;
 bh=P1IVjaD7S+lcxi5ZmewYdZt/A3Tu/9mm7un5rqasL/s=;
 h=From:To:Cc:Subject:Date:From;
 b=dHeXji+MytiPG8VzecwAdEKQNl+Y1plj74NAQxpkbtKZEN7a9rwXX5ki50G5hoW2I
 uaGPjQLelJi6zamcIFjQ0+qfgIXN3uOhjWmpjnpA03I/lIyD7NSdeGghFeLTPvQGaj
 VYPr8UoTpDbGDthoDkqcOdmC9Sh2gZdfUUosdWxqpQ6yCJfxp45DNckejuuHSlZCl8
 Z6E59a3QC2IvyfmLHZJWZVTKqMiObVdb3luatyR99W1IC5gth1G2rOCG3yRp+pbRKB
 LBLfR39oSchHJsrGpjC72Vipu1vUG17qJjjyTTauWORhwpykEN7hKZ6jPe0gey2h4Q
 gEZQcdV1lQRgw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@oss.nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1] pci: layerscape: bind LX2160A rev2 aligned with Linux
 kernel
Date: Wed, 28 Oct 2026 15:57:05 +0100
Message-ID: <20261028145705.2407296-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux describes the PCIe controllers of the LX2160A rev2, and of the
LX2162A, as a DesignWare root complexe: "fsl,lx2160ar2-pcie"
Since both commits
  1a1bf58897d2 ("dt-bindings: PCI: layerscape-pci: Replace fsl,lx2160a-pcie with fsl,lx2160ar2-pcie")
  a8fe6c8dfc40 ("arm64: dts: fsl-lx2160a: add rev2 support")
in v6.13

moved to fsl-lx216xa-pcie-gen3.dtsi by
  8f69555ef54c ("arm64: dts: lx2160a: extract the PCIe from LX2160A Rev2 into a separate file")
in v7.3.

Then the U-Boot's dts/upstream has been imported.

-> let's match "fsl,lx2160ar2-pcie"

Then, LX2160A rev2 boards can use the kernel DTS.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 drivers/pci/pcie_layerscape_rc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie_layerscape_rc.c b/drivers/pci/pcie_layerscape_rc.c
index e7913d43a8b..b95c989d25a 100644
--- a/drivers/pci/pcie_layerscape_rc.c
+++ b/drivers/pci/pcie_layerscape_rc.c
@@ -403,6 +403,7 @@ static const struct udevice_id ls_pcie_ids[] = {
 	{ .compatible = "fsl,ls-pcie" },
 	{ .compatible = "fsl,ls1028a-pcie", .data = (ulong)&ls1028a_drvdata },
 	{ .compatible = "fsl,ls1088a-pcie", .data = (ulong)&ls1028a_drvdata },
+	{ .compatible = "fsl,lx2160ar2-pcie", .data = (ulong)&ls1028a_drvdata },
 	{ }
 };
 
---
base-commit: c267fa81d42b5a5bd1055d3858f74496faa6082f
branch: for-upstream/pci-layerscape-lx2160ar2-v1

-- 
2.43.0

