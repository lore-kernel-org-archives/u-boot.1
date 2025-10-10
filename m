Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216F8CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6819E84565;
	Fri, 10 Oct 2025 16:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hWJHHY9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41CB78425A; Fri, 10 Oct 2025 16:35:23 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DF55844AE
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so14890685e9.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760106921; x=1760711721; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bQviYp84JciVky/cMfWzLwyOaJqzhDmDsna3rw9ihM4=;
 b=hWJHHY9kmK92Z0lBrtmJuyiEIPOuU8lX+VhAZXf92s6edkWnYmgjHJ7MYAxgJtGHsl
 BbXj2ks0julIDMv7JKSht9iFhlF8DwsfLjsJ9MhEGm2/rxsQYvuu82Rx7Nz5uprErdY/
 ChbU/L7r+fiCwXyCk3hZ6hIhu2kHr0zXP54TRk2NlW5IBn9NxavXLyv+XrIrUBUoDya1
 lV5bG7bFfMl/6ZGzI7smeH2fdIilB+igp+4HrShVSKmQFVzf6gc6A69ZfZX2PiNoV3Wi
 pVlLhCwN+7GOQ9UXVQ8+VTMHyR2ACs78hlla6M6fZgsae+NrwPcl30lqjK5YM+Ag+MyC
 cInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760106921; x=1760711721;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQviYp84JciVky/cMfWzLwyOaJqzhDmDsna3rw9ihM4=;
 b=eXvTENCQqERN5eM6FXbBtktCQRNsx6Hv7ZkNgGfh4plBcyjCc1n/JbwUvFFpD7tUww
 K6fihCY4vRdlzA5MtvEAcPF1AP2IIkjUrA+lfdBFDOrjHGF6KwcvWkpxw3/lRtQk2PBh
 UP3yH6/+3OqLq6xbxtnrnS7QZ/WqwI3bjYF3GYKF56ezjCNtfmMZvL4BlpK/o2LYIuhj
 ZURPCznxA5ueQBw7OHS+tN4WG3O+zmjhP94XT0jUSZ+uoxHX/1QA7lK/tfe2IldCOMNa
 I3RdAYWL/diMJCaX3JflgIou9S7bMtabd6cx8lc/zw4cLf89h22H6iOXsdjU6q9ChCyd
 2M8A==
X-Gm-Message-State: AOJu0YwKAodsf8+0K4j7Mryho99TUsA2R2OkQr11Pe69XzNo7O3h03px
 8km2rhoDHB/x8c7qgrtx15DLpkqQGGWUemszknwMZKvbu4A8DKRSoO9kltm2s0yIouA=
X-Gm-Gg: ASbGnctP+2X+B/i3H6/2xvAV0DdYbYm00DQNcSzWk2XrijMXe/RBCU44N9Nr7IH4JxH
 4/2pcieQo+aiTbJe2PmlHqfSI0Rqj5wcINNrKpOFb85RQfeKGOWsX9SksDKsJWKnm+oqNN1HN8x
 WKdwcRvjaH8H/znuRuZgVZ0o4cp2P5AauTi7ntYhyB4rzJEKNn0P4URHgJ8s3dtJ7SAOY7+SqQu
 FRrwSb296FzZM0F8Nsnu/UwT48Y0YTCgpAk8bfqk7s06vTP0swGE1PYW1C3yKTOzgvi+OrKqz2i
 tp2/JFPlfntYQdxU6Uu6/9tqlpvjR+ks7BKHWa3pSn/fhF0oH21MlNQi3Ez9kBEVI8T4QvC77Mu
 VNR0k2AXhFtqAt+Md3sfU18u8EJZhOjsnmYRG+Mz1fA7bpPB/c7cJEejhquXNK5ywYg==
X-Google-Smtp-Source: AGHT+IHAOGKz/2cBfx7D3EQsu4nZZwGZrqS0AYE6YBoaUGi6qSov8uYOb9B2PZZPyiudQTSynBm3lw==
X-Received: by 2002:a05:600c:138a:b0:45f:2ed1:d1c5 with SMTP id
 5b1f17b1804b1-46fa9b171f2mr81520665e9.36.1760106920657; 
 Fri, 10 Oct 2025 07:35:20 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab5250ddsm59878215e9.6.2025.10.10.07.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:35:20 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 10 Oct 2025 16:35:13 +0200
Subject: [PATCH v3 6/7] ufs: qcom: vote for interconnect bandwidth on probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-topic-interconnect-next-v3-6-b384713283a8@linaro.org>
References: <20251010-topic-interconnect-next-v3-0-b384713283a8@linaro.org>
In-Reply-To: <20251010-topic-interconnect-next-v3-0-b384713283a8@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HGjAeo99U8ytQ9lxmyzlg3znvKIGM1GFqv9/Tqd3110=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo6RmiP8Zh5Acq04mygt6Bshhl6ntyZNTyQEFxVnjI
 /G+NOXqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOkZogAKCRB33NvayMhJ0WwTEA
 CF62itto734dQDE48GqMyBujZZYK/uo5Zg4/SBRzkYgvslXY9jErUvEy1nCty3Nj5i9YCCfKfpqbdL
 ybY6LhiOF9Kl/ILspTy9JEvpUi8Avr/cUIML+HLy8JF5Gnt4lRmYP03EMypPinlDL6KbpX+aD8Ff8C
 7zcmXEzzmPP8xsoRUr7qVpPbNx4W1d+TvlUKWSwF9Yr3T5iNQ7emM4OGVTX/aSUZuE5XDGz1f4bk6u
 p4q5vv1/wW1bUI8lg367abwjRkHpdvMjow/AYwi9wThMVT38pRTKBvlVeD6NfYMysKErGagAqtTot6
 xqVYm1GbnwBvosmsCs8pBsbgJCd8PgGQCjyo/eh+vAYs0FFMF0UGirTxRfkm4h73VIKiCTNu9Eai+y
 ATrZU1+kxW0zITbW8/Z3lhkeXPzTICjz1j7/FVJBRSp/qDEtZs8QUpbdJ7bP5UFKw79+kTDpXkW+kJ
 6PwDQPGtmGt/m780qbBG3RguVJfxbDjjPmetXiV1P9KyutHFcBkHMieBl6QJlTDZ26SKKOk1AbhRJ6
 63UuTqMkEo0hHe5+brIMs2p/R+34UlASdO/k2hGleH4G52OByjyRJOByVjSJmcqYzPPn2L5z1SzquB
 FRMfmD4TmqMWlwPhQ9R+VwX086qZ2W9LvjEPIaIC3hLeqbDZuUy7aX3QHfIg==
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

