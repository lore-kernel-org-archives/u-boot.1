Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD05CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 17:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0269836B2;
	Mon, 20 Oct 2025 19:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CfQDczBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57918836B2; Mon, 20 Oct 2025 18:24:33 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 626F382E34
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 18:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3692362076;
 Mon, 20 Oct 2025 16:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC704C116B1;
 Mon, 20 Oct 2025 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760977469;
 bh=yMroc9X5hcg55ifEH084fzwjenGZxz5gMEDtSnLBPgA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=CfQDczBssTspaSiex29cWSdD4Bic0v7PzKPKgp68+Omrv/Ucmkx+K8/R8NADaKe3T
 soZxum1oUXruL1xzQpNUhhovMljan7OcW7Vq4dRJoVSrdBCLriBVklDUSEnjLnWIV/
 004SkIuRJBrL9qbATnon8/pinIZ3WX3539N8aQ6oJLUM5KCQ1ZJxdRxJ59Li6ygW4Q
 QtuZD0u0DCUHb1u/HoMskl1fMyzBCsjr+hMubyIhyxuAr9uv6zrXoKOB/eiV/taUpr
 sQ4LeE71Ta8KRp5tJU1hFFtAxTvNFurU2ynMAAsjnrrkaeZJo3t4KmP0c76F0zj/e2
 i4Uwwpj8rcHNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BB46DCCD193;
 Mon, 20 Oct 2025 16:24:29 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Tue, 21 Oct 2025 00:23:58 +0800
Subject: [PATCH 1/2] iommu: qcom-smmu: Introduce sc7180 compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-sc7180-minor-v1-1-9fe33c73365e@gmail.com>
References: <20251021-sc7180-minor-v1-0-9fe33c73365e@gmail.com>
In-Reply-To: <20251021-sc7180-minor-v1-0-9fe33c73365e@gmail.com>
To: u-boot@lists.denx.de
Cc: George Chan <gchan9527@gmail.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760977468; l=870;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=42TwfPn6+UwUrF0bHJRtbT/XxJmf4Tq0MSQfLwkdXQg=;
 b=mLucF3kpxtdM/+LDjmZAbW1EPCXbNKH2a04t+swRguDbad5RzhiadW+J7py5cOzyoeBe8olCd
 V9FwvR5o5iSALUE8jkDw1itb9HbOJHmFjfp7JevCDkXrmnNJjvsTbeA
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Mon, 20 Oct 2025 19:17:28 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: George Chan <gchan9527@gmail.com>

Add basic compatible string for sc7180 family soc.

Signed-off-by: Vitalii Skorkin <nikroks@mainlining.org>
Co-developed-by: George Chan <gchan9527@gmail.com>
Signed-off-by: George Chan <gchan9527@gmail.com>
Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/iommu/qcom-hyp-smmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index 2e51ce4f242..519e7f4e7b2 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -389,6 +389,7 @@ static struct iommu_ops qcom_smmu_ops = {
 
 static const struct udevice_id qcom_smmu500_ids[] = {
 	{ .compatible = "qcom,sdm845-smmu-500" },
+	{ .compatible = "qcom,sc7180-smmu-500" },
 	{ .compatible = "qcom,sc7280-smmu-500" },
 	{ .compatible = "qcom,smmu-500", },
 	{ /* sentinel */ }

-- 
2.43.0


