Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE07CCA470
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 08:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA947836C1;
	Fri,  3 Oct 2025 10:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FjAbzuac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4484F836C8; Fri,  3 Oct 2025 10:56:33 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D4B8836AC
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 10:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-421851bca51so1271202f8f.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759481791; x=1760086591; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bQviYp84JciVky/cMfWzLwyOaJqzhDmDsna3rw9ihM4=;
 b=FjAbzuac4IvFRMxYsLulZHx5Rv/ku2WBUV9C5tVz8EhkVYXfZJaDzAbA1nV9G25zN+
 G2xZV39Mcekyf0ZFnbvEZ3oc1z+EJ6Oxqx//dbwn7WIqDqPkHzdMak9YD28q4hVQEsJm
 cAy1f6Fxrgqmcmi8cNFhDFg0k+AaazZ3c+MYAy/K2LOi4hDBgT1k9iwUds7RR3Lum9i6
 zb7nrr+iDMN9V0YIRF6RwX+xjKdTA8RBYxMp6kvfkNoFmHE101LopFYxo7CQJah0514w
 0IQwKXhAFubbjgsW7we4KqGrmnvtvUtoa+mSxprNe9lI/GpE4f1Yr7895Zt1P+pUl+FB
 2Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759481791; x=1760086591;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQviYp84JciVky/cMfWzLwyOaJqzhDmDsna3rw9ihM4=;
 b=f4JHmrSje4Gartlz/OVUCa1czjVIy8imzQRB/Sz5UuLGIdkEdr3PSTBwlbFoLbbNeF
 KuqhtY1urCjzfLidL9JcPinrANoT3ghv9CyuIzppjZ+s7oRfoDtK6veaSk/MlpiXqAl2
 DfG/fGwT6xvwkbQB/bIPWcGXPYLaCFfhKXGFG09RW8WmQGDw0G/6vVg8BXqE6aNc/Kre
 EZjiY/++wiCZ3eFf5X6SnVBEMdljZU7rthyKY300Dj39BNJ4F9jz3L+fv5y1K57dpc0P
 ymLCLOosB0Rc+3cz1YxiRiFAeUWYAszQcAtWhXZE6tObeIcVEE8T08OOvEw/z84HrXBa
 FzJg==
X-Gm-Message-State: AOJu0Yyn6HnWMgDfF8EJxx10bCkn+sNsg8Roay5hlRBM4V08a0rKC05L
 7emjhg4RxWPdnvclGw3EDeRPyzdN6NxY5hx2DxmbGvJUyHs3AVnewKx/HgFoPDNqCVg=
X-Gm-Gg: ASbGncst/TlcXQl5hUZTtxk/c3vOpgG7D4A0R+6r9qv8SGWO2nqef8plAtIeUyWOZrP
 ll21usFm5QsfBlPnT2O941qe+36IAU0hB+HnchFldkHtX/tHW1xOppkm7omKyWFiyr8xsUJD152
 8oAdZiV2rwZ3DI54QZZa0ZHR5wlljyeh29ZX0DHRFZlG/UuAts5+ay0jA/f0TncZ7WA8UgLfq9C
 IfppEQJyjdwGEiklnDw1jbjmJCd8+svrE/aRbi8dNVXCFR5UyGG+dwvdu3cxeQ5HqmfNnmfwfPG
 F/aQbJjba4pbIxVBvoamJFmYnAOVF9fXCyXg+1/nGfljB8Ly+qDzl1GTfnl2BkSodRqWot8XTQ2
 cVu7EjJuINdxInpRDlnBWsf+Iv6r4F5JIrzE7hUvfsBf4xaDAuySANt09VoSygNNW+u4me0heYE
 7ESXDyUg==
X-Google-Smtp-Source: AGHT+IHIETwxTbV71gmubyfLx8ZujEAyAMPzeFTn+qV5udJf4Q/FT+UyiZP3uIiUYSFQcOq+kw5NOA==
X-Received: by 2002:a05:6000:288a:b0:3ee:1233:4681 with SMTP id
 ffacd0b85a97d-4256715327emr1489238f8f.23.1759481790607; 
 Fri, 03 Oct 2025 01:56:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8efffasm6951709f8f.41.2025.10.03.01.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 01:56:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 03 Oct 2025 10:56:25 +0200
Subject: [PATCH RFC 5/6] ufs: qcom: vote for interconnect bandwidth on
 probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-topic-interconnect-next-v1-5-955eef068b6e@linaro.org>
References: <20251003-topic-interconnect-next-v1-0-955eef068b6e@linaro.org>
In-Reply-To: <20251003-topic-interconnect-next-v1-0-955eef068b6e@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HGjAeo99U8ytQ9lxmyzlg3znvKIGM1GFqv9/Tqd3110=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo34+59Jpie5lvmb3zk73Mvvg2MColZ1uu6pBunMDP
 8gCH4MmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaN+PuQAKCRB33NvayMhJ0VtLD/
 9patRZcFVYF5i7A0Q54aJ1Lw62HeZKAsZ/RziNW6+MARDSxE2jfG4U/NNAnpkA0alBR6lrvjv/ch3r
 ypHRJzHvzFI1TeldwMxlpKs+z9BDoq49eFLFUOebx90FYpCBVJVSnDmHq3QAog4Oa+14nJSi/aerR7
 KrEda2HlVOR2FlzouR3BwR6/9sQJJ6AaUNlfjfVFzFyO6Ud1trmw/X++1bo4JhcrhkJgDTg2zf7Ydk
 rV0swA4tg+RZNPWMr2keIERHC0UGxefS1N9z/q6Mcgm8QR/8FZiHsFgxMgvGemcg+7wCTzTdAUsfIU
 GSBAWxWPfA1z1+ahp20Lo+aADwUhDSTbkiQaLkKWGmEn9F2+vCZBEYFF1zbP5aYXx6jQYyn5g0ENOQ
 9vJUJT6qhmSm1S4BXjGLvXGUzZSsG+DTHvLjRMdVpBOhkMXfq+zRqrRiFpbmfWK1437aN+EwWODXCB
 JOlQrY/EOJYdzBLoj++EVtNH7Tbj4gwrycfeRsrE0r8S4ScqbvyKwyty9TUzJxRCU4impK700+EJIb
 hkspPPcdDoRT9TAIWJUDMOCyw9eWvsncEbSvfxQlrIyb31rCtgsUBVpHZVNUmZxmCF75ndzIzH6tF1
 /wRRxz0mqqRGtYvsDk3WtqmcDtZ6kaWZgV4KYwE9isxeEfJEXO+HV+eBeR8Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add Interconnect voting on the UFS probe to ask for the largest
bandwidth possible.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
index 843585726c7bf001321d927a4daceb64d0d6f153..c21a7b9947c96af61eeb33a2f06d48b2e71afe41 100644
--- a/drivers/ufs/ufs-qcom.c
+++ b/drivers/ufs/ufs-qcom.c
@@ -16,6 +16,7 @@
 #include <generic-phy.h>
 #include <ufs.h>
 #include <asm/gpio.h>
+#include <interconnect.h>
 
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -26,6 +27,9 @@
 
 #define ceil(freq, div) ((freq) % (div) == 0 ? ((freq) / (div)) : ((freq) / (div) + 1))
 
+#define UFS_DDR_MAX_BANDWIDTH	7643136
+#define UFS_CPU_MAX_BANDWIDTH	819200
+
 static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable);
 
 static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
@@ -625,8 +629,17 @@ static struct ufs_hba_ops ufs_qcom_hba_ops = {
 static int ufs_qcom_probe(struct udevice *dev)
 {
 	struct ufs_qcom_priv *priv = dev_get_priv(dev);
+	struct icc_path *path;
 	int ret;
 
+	path = of_icc_get(dev, "ufs-ddr");
+	if (!IS_ERR(path))
+		icc_set_bw(path, 0, UFS_DDR_MAX_BANDWIDTH);
+
+	path = of_icc_get(dev, "cpu-ufs");
+	if (!IS_ERR(path))
+		icc_set_bw(path, 0, UFS_CPU_MAX_BANDWIDTH);
+
 	/* get resets */
 	ret = reset_get_by_name(dev, "rst", &priv->core_reset);
 	if (ret) {

-- 
2.34.1

