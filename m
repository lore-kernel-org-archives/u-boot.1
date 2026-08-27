Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A771AC61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 12:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E07160633;
	Thu, 27 Aug 2026 12:38:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OnKwne-hQX2e; Thu, 27 Aug 2026 12:38:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787834290;
	bh=TLpyY0EdnINdSyYbMydVeKXoXKnoLgen35HKp+58LBc=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MZKKF1un5/A8Q0BxuTni5nnYheKr3aM3fkptW/3VgIUvrP9AfpHPB0Vcx+YNAvc1L
	 8fOLN6LWizrpVpbT5/kYulKqgfChjK+OFlCSJa0T6Ih/THWTjng+995VQdeq5Zzo8e
	 e0oWR5vNK8zSny4bdzue6fna6VAf5BAIEUajrLn6LANc6dhAC0bwFqetzLYb2zFdOS
	 YofnXeLGI6arrERk5gn0HySl4qREt+TDZ+VdRw7iYMoKjw5HR3JbO8nVu9WXdfQwZb
	 nM1uw6CjlUDg5Aa1uz9ElZn8jDVl63YJMd1wWkdCEEdUVpVgMY/Z+uX3tgOWLcWzS1
	 VsMAIck3iWv4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A08766070B;
	Thu, 27 Aug 2026 12:38:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DA4533A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CBF716070B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:38:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LRo3wr2c8CqB for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 12:38:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lSRMk/cT
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B23D560633
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 12:38:08 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-495437bb891so7346845e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 05:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787834286; x=1788439086;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TLpyY0EdnINdSyYbMydVeKXoXKnoLgen35HKp+58LBc=;
 b=lSRMk/cTBdq+1O26r+w90/vytONR4gX9puXuJa9fO+TvPDHx1K8Ol5HzaU96vEXNbs
 3N51UPTruHU62YF4fbNPWL7PlrypZL6JHI9oLTApsaF2bGrORpBLRlzR4Z/7er7NRmT6
 yK2K2TwyFRzO4nYD3gjzpzodhOoe6xe/SR+Y++2ZpGFvAO2MA36j519etVf4XCqlysU+
 oEViIFF4tW/expawZbgk6dabCN2U5s5fKoAUX+BfN/3iiPClCcreIkCextOAUCwMIxJ8
 4OBgRGnXIaEz/TbJdUmahLSTXr3f79aCv52I9VofvW2ZrOVlh8umeLBGr05wcKqThueo
 nq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834286; x=1788439086;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TLpyY0EdnINdSyYbMydVeKXoXKnoLgen35HKp+58LBc=;
 b=rixWjodYC6ORCd80Bi+ls/Va2yc356X+OrI+l4oRafeby/F22JG7F5gAIyyZNCuC19
 4dnLdUrRdS7lVsNget7QsD7Q/kt12ck6mUr0WipTuJjIg33GGSNZXoLNvd7Morv34eZk
 BeLKx/4bWLFqsFXz3Jf7yHCqk7FtD8HTu0r1ZIAyqqPF2gk9HS4nbRsko3PLaLUpAgF8
 YnCCsbG7kPP101CWadhThyFrOgt9NgcUjhMoS5V5xxH6RuL7rKOhmJD4mF42KaRD5UG+
 GuLW/g2hbDFMEouVbR1MibDsjuTW68qD4ESv9Kgs4SfMjl81wWeLfsgZHnySz2gDyMAb
 k/3A==
X-Gm-Message-State: AFuF++lZrUUB7BM+co43ncz7R+sMSVIYUcbmIfq3HXzD/WpeU23/zTUN
 T8fpDfwhx5Jcgs/bLcSdbzLukxFJt3JqaGe35O9eryh8aGWuNOVv2laBrf1sGcy8BtU=
X-Gm-Gg: AR+sD10lAuu4TOL085Sk2RJ1qRUpuLH9Y3ubsWerUVvCo9xTpyq9JizyEj7wE+8yZMT
 9AM4Ds/alUED0YUz9mWSscOcJQdszmzTaR9gDzgbS+cDfSQP3vn9uOusZ22Cx2Pvuf946QU4g/6
 Tjt36H3MwE4FgX9q0wo4G2/c5vVVKwloA8+g7e4RbEnJjTgynJKDl1af1jiO70dbS1oH374Foh0
 ETHaEvd34GlcyGxFyMPaIBs/FWJCNoSoMS3BWYmspiDKBVqVmx2olJ3890rIHd7kMhLw7ehwVMY
 4AA7W+ZC1foRpp43gjbnVH2xuALhROVNTZoZmtuZRH8zBZ5CmTZUUWn32CXWpaHQv3w4ECGNTE2
 y7c0gKHgETQqiDHfAp/b0NBG0heLcePep8jkjc4bWWrPKCIfkX/KJwnFMKh+7Pfx6F98G+Pef01
 udyX5ZpyhFe569CvDa9Hr85EQp9VQ5jdlGTzAgyTrz6UA9nu2gt8mHEJp89Q==
X-Received: by 2002:a05:600c:5253:b0:49b:4eb6:6ffd with SMTP id
 5b1f17b1804b1-49b4eb678f0mr52978505e9.5.1787834286286; 
 Thu, 27 Aug 2026 05:38:06 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:4373:6c2f:4372:b8ac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd55283esm51538985e9.2.2026.08.27.05.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:38:05 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Thu, 27 Aug 2026 14:37:57 +0200
Subject: [PATCH] mmc: omap_hsmmc: Add "ti,am437-sdhci" compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-v2026-10-next-topic-am45-ofupstream-mmc-compatibles-v1-1-24299cefb42a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAKQvkGoC/yXNywrCMBCF4Vcps3YgDY23VxEXSZzoiLmQSUuh9
 N1tdXe+zfkXEKpMAtdugUoTC+e0oT904F82PQn5sRm00kd11iec9oW9wkRzw5YLe7RxMJjDWKR
 VshFj9OhzLLax+5BgGLQzzl1sMAG251Ip8Pyr3u5/y+je5NuegnX9AuAbGESXAAAA
X-Change-ID: 20260827-v2026-10-next-topic-am45-ofupstream-mmc-compatibles-f42b5bb9af5f
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=msp@baylibre.com;
 h=from:subject:message-id; bh=XQturqqvpfpKzZ9YUVEi0USIPNcYwVdir443bt/kDng=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwJ+stTZJYFLM9d9dHu1KyjFRsL5BRzla+8vMRkmSfxY
 +nevAV9HaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjARg1KGv2LZ/2Ztyp23ZnXf
 MXPT8tCjywr0jQO7F4glWc2SsdodYM7I8FanL/sfp9glh1mL68x1E81PcDe3rEt4uLVe/MNXttv
 iPAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

The upstream devicetree describes the am437 mmc/sd controllers with the
"ti,am437-sdhci" compatible. uboot's devicetree uses the omap4-hsmmc
compatible. As the driver works fine with the hardware, add the upstream
devicetree compatible to the driver to support the upstream devicetree.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/mmc/omap_hsmmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/omap_hsmmc.c b/drivers/mmc/omap_hsmmc.c
index ae7420806432..b56b6f75d70d 100644
--- a/drivers/mmc/omap_hsmmc.c
+++ b/drivers/mmc/omap_hsmmc.c
@@ -2026,6 +2026,7 @@ static const struct udevice_id omap_hsmmc_ids[] = {
 	{ .compatible = "ti,omap4-hsmmc" },
 	{ .compatible = "ti,am33xx-hsmmc" },
 	{ .compatible = "ti,am335-sdhci" },
+	{ .compatible = "ti,am437-sdhci" },
 	{ .compatible = "ti,dra7-hsmmc", .data = (ulong)&dra7_mmc_of_data },
 	{ }
 };

---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
change-id: 20260827-v2026-10-next-topic-am45-ofupstream-mmc-compatibles-f42b5bb9af5f

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

