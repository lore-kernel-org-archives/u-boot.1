Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BB7CEBF92
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01AF083EA9;
	Tue, 18 Nov 2025 09:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GPamjLxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D35383CD3; Tue, 18 Nov 2025 09:28:30 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B4283C16
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 09:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477632b0621so33985225e9.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 00:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763454508; x=1764059308; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oJmISXKsl7w1HYA3F2D3dkwyBHvNv/12pnGKsi/68EY=;
 b=GPamjLxCYlf0Ukn97aDAQp+EKn4dwyXBfI1XzCoz+9P/cYStqU3OIx/YXga+ABF2ke
 FDX5Qy2OovWXZiT17e9EkcfaBStLB5kDeOE7+8pHvQWWaWGm5sVt7Do9y3pfbBf3FCKh
 tFOLRh+XBxfkvNKTO9ds0GVJ6SXm8rpwS2QNVpzCFgscSn58cJ4dVUwGcyzJlYq+gbuu
 JjnVv5zFSQvq3UHViRzxg+3o27nn9Y8Ihj8zPwfe6EdY4C6wRFoN9BYONTyMeCaZ8hNz
 6lYpvE1wrevuf1korJp/Jkxl78r4mW2bxJFrJXqWZFdwwsf7Dc6t8sSrbSUo+BI5dDkQ
 BmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763454508; x=1764059308;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oJmISXKsl7w1HYA3F2D3dkwyBHvNv/12pnGKsi/68EY=;
 b=gmRAU6mxH/To+xEh6qsYpPwV5OUBggVC/7pigiH8r5i+YOoQbi9Ngf6dwebJzH/0mE
 6KkVV92H8IG2Esu3OnrBHqWz0jV/vN667+YV9vz+yAkY5uZ72ltn63rhBc9jbHuebTU5
 LejdKHTzxGEofLVSAurGniKtpXOfP9vTxp4qI1pDLpjZ2H4nOZpr5Thlq1XMtEKG7APu
 XzV+j8ZYCvyFR71a/+dlq36RkpbMq5+E3KPShw/fcyph6nkmrlkOWdmk8beHbR/R3Zrr
 VRf83Rh+XWYZBugHqhYUfjhKJijAT3d1igbNgAJvyjqXTwW9kV3EMMXOKR+QRHkjjEXG
 idnw==
X-Gm-Message-State: AOJu0YzQlslCnSMDF7i/ajlJab4ZwE7WzmE7Xmy8o7XItnhDh6DztfUk
 5JZxdCe9NafpOy2cv0Of3kAjrUM0Tw1cJ9Mh6dCxNxWR/b1NBK6Pm3uv3X7MZ2h/KSk=
X-Gm-Gg: ASbGncuZ1ieBxR35r0Hc4lwyqrxpp7bXayaIULBYsB+A2sAKOd1AIMAF/nWwNV62VN8
 Pq1DwM5JoZzg+sK1+HqX0mpTKDJi4tZ2GEa9hPUP1eKq1ODuIsuo0rE+vqr9bJnTixXxdSSIt1Y
 mNF64DdnKK7OVA01sSsCDqmmu6JKYokcVkxGCWrgdWepQZOhMlsywCQzQKfi4HOzIGHxy2lwL6G
 KJLtTFeoQcHWUiLrkCD5UEEyz4qFg8SPbEB6+tko0vcO/vKJrzNujO5F4LPrlJOJ0MTPUbQ8EzO
 J04zomfSn0a40EuCUUWcCHyBfHadKtAjNU2LvBBOdUIRtYrhVRcDJ8Ldit97EjaKknGHVKESTMO
 +FkL9bGNNx1H8710XZnW3g4EFkHvVe9i0yC56RWmKHaLjGWf0yL7l7JKOv3K6kLXWuNBRibMHR0
 3i3wIRNVOIpvti5OZ+8MlQqUDxsmetAyY=
X-Google-Smtp-Source: AGHT+IGcPksxlpogZPxmlr3953HK10ucpBgOEftZayDXXQdveNvxTPlC2duPKXyOjcIyS3bmX0TjGw==
X-Received: by 2002:a05:600c:4685:b0:477:8b77:1575 with SMTP id
 5b1f17b1804b1-4778fe5dcbfmr136438505e9.12.1763454507492; 
 Tue, 18 Nov 2025 00:28:27 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a7cb24dfsm72698875e9.14.2025.11.18.00.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 00:28:27 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Nov 2025 09:28:16 +0100
Subject: [PATCH v4 6/7] ufs: qcom: vote for interconnect bandwidth on probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-interconnect-next-v4-6-9c00d6b19add@linaro.org>
References: <20251118-topic-interconnect-next-v4-0-9c00d6b19add@linaro.org>
In-Reply-To: <20251118-topic-interconnect-next-v4-0-9c00d6b19add@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Anurag Dutta <a-dutta@ti.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Alexander Graf <agraf@csgraf.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, Sam Day <me@samcday.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1450;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=CvpCEKFxB+isktJw+V5Y+wRub94e+OdAuWFNJVHgqno=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpHC4gJsCO0lLD6jMTlcOICy3dL82SA1z3IX8rYWzp
 Md/vrb6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaRwuIAAKCRB33NvayMhJ0WbRD/
 wP3OmAPuP6hbP3cdgvUNqd2S0pn641pth5/FUUykoPiHO3D8wR4b+3LDp/oyYGCkJPanCXrbUWTI4I
 p2db6yNPj8LIFG69oHPfFaNSI8gIa2UTWdTYU3DaLVV2Rb4wsPHy3+uPUXFugbM+V8OU0AcroGMQZ8
 Fq9iTvYBWFhn0MMv7cHsoN+z8AiLzbcTxusUKvSsvcNz2Y17xqVdHAod1mk753+ov3LBYqa8COnxLH
 T495z3HR7DAZdtbrbXpCzsYUxYouh+wP7meGLCxyKrmvixMiIJA0eSMHeuxn2oX7pKvqgPXZvAfwsW
 dHQBjD8AjspfN6DV5/HwbUlimqv7XltgvtNWULhUtVGGzCWqIwIW8D0q8kqH3aninoAjLNVo8VNUSp
 FryEL9aANHWkmerjecmrRhMSI0zP3bZaTU7aQQan/jWaeuQNtkR2LKTC1N3OpuMxrVmu6uH9vDw2Bs
 OqSe8945eDTMnoDQYatuw0CRFyZuOD9LVIh8EBM4TYzkcqjWnti20cRzP4XHtwfAEbd3AvbysGzs94
 ilzl9Lo9rDM9dVA82vg+K8snkQeUjrDlCPOAmg/DsO8q5QfxUf5/vZN8Z8EgTZOkubb2CxoSrrWoYx
 2ZXo6CW5rUYpBTrZA69OXqasYR8L1ePepJNXUNVtv3a6MUPDvyOKlettiqLw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Approved-At: Tue, 18 Nov 2025 09:30:32 +0100
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
index 9f0a6940d98..ee43958d5d8 100644
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

