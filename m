Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08806C7EE39
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 12:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB7BF82F49;
	Sat, 28 Jun 2025 14:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VXAAhLJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A5681D5D; Sat, 28 Jun 2025 14:25:33 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D941882D21
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 14:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0935E46308;
 Sat, 28 Jun 2025 12:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D12B1C4CEF9;
 Sat, 28 Jun 2025 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751113522;
 bh=yMroc9X5hcg55ifEH084fzwjenGZxz5gMEDtSnLBPgA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=VXAAhLJ+4lfOOt1xy3Z5mob9dB3S1EDeNSeo5AW8JL5GXLKSs4eHuIzJFBGFwCRcw
 As+bNVQSVkQCAB7+irOkeykKAkN82WX+qTpIte52i0aH7uOBdJ7lA+lEqI5gBrrZkb
 6vpfig5g8ZwYOhXU7NHmN4ONgGxEArG4OtX9lPKUulTFnvi506Pk5mwp6r8QTaAe24
 kdSLvcOygF6DOFYZ7JhNmXwmQqqo7DdbKmzFk8ZPkxv1YH1We4P+cTqYajmlVbzNkp
 plguR13Z9zMDUsVg6hMQnoCZ7ZtYmn8/4F+oI9Nw9mXWWHut3jU/DfEj7BbOoxXLT0
 FCrIn5LYKNa4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C9BF0C83026;
 Sat, 28 Jun 2025 12:25:22 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Sat, 28 Jun 2025 20:25:24 +0800
Subject: [PATCH v3 6/7] iommu: qcom-smmu: Introduce sc7180 compatible
 string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-sc7180-android-boot-v3-6-105098a19165@gmail.com>
References: <20250628-sc7180-android-boot-v3-0-105098a19165@gmail.com>
In-Reply-To: <20250628-sc7180-android-boot-v3-0-105098a19165@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com, 
 Vitalii Skorkin <nikroks@mainlining.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751113519; l=870;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=42TwfPn6+UwUrF0bHJRtbT/XxJmf4Tq0MSQfLwkdXQg=;
 b=eJC8o6sZFHQmCZN4f2bOkFBVLXWJXeaBw3W0DBtVkeFBhmGUEdwUnz90m4hMUd5y6tCqMVo4k
 PZ1JN+lhEoOBDCQV5wI9/KiJsDNX8+lt+Usv8u78MvjE9QoWxegBpsG
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sat, 28 Jun 2025 14:35:07 +0200
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


