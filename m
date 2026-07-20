Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98009C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:09:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57CD06073A;
	Mon, 20 Jul 2026 18:09:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IiASQH3I82MX; Mon, 20 Jul 2026 18:09:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22FCB606ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570996;
	bh=SiMvf/w1IPZ1Z6IocnW8dvZXWVcg+hS1rmyrq7/K/y0=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=srcWcH6IAby81ObhS1wwisIjmAPVmA8TVEXx9RTd9bI51Ez1WnP/SD4Lk6U9T64lc
	 OuNQmtiNQ60SYH/uTP75r58qGvQ9UBjdgbv4hZKQyMb3Q5WY/GwcVIwphbu+/WMiaL
	 iEUT1POPaRgfEw89xG1dNXsfS1+FJ/Xd48DE2GPuREM1Cd8s0alHozSP7YeR4gE4V6
	 7lRBb8nyH4pqBLuFpKy48lbOKfkIJLdNFa6kdICBDL/RRY0saUaeJmt7rqYHO9J+aH
	 yxIUvr0ZFr9n5soKHt+uZ46AMqcU+xE05UjgfM1oJrtZ03R7GS3ZpchD9Do0FR4I4v
	 rVFz9iHWfpaMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22FCB606ED;
	Mon, 20 Jul 2026 18:09:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F00B1C6E
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 737D280CED
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j09kSmtxZq2H for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 45FDC80BFF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45FDC80BFF
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 45FDC80BFF
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B41CF84A67; Mon, 20 Jul 2026 18:42:24 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7ED684A60
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:42:22 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so72852565e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565742; x=1785170542;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SiMvf/w1IPZ1Z6IocnW8dvZXWVcg+hS1rmyrq7/K/y0=;
 b=Q0PI8iDGFYkSrt4wC/UhuUeyQMoDz06/4HYHfZE7Jiz7Q0VZt30vCkhNI45TjqGwBP
 dvMB7WksgY++bjJp/hhl/hBqamYrmqnLyGV2dzjz3i0HzHrh5YMjMYSeWhVxHDqPHnlx
 DdX+z8YlfLAVXUr4DcDZMd4Z+9gcjQ12llTx1Go9/j/dEXuWZlh0vS/8BmLXJOrEUJ3p
 8paZzbN8RO/CkSQPcTURczQ8lI5PalgqJMxpK2C03Y2L52Buj1lvEq6vPOuEKk5lyEji
 QgjzZ/FtiVzXGRQRzuFcsi+8yZbry2lsVSwkXn2uVieyq4duHYdd9WA3Gyg6Wmpu3/pd
 x1ig==
X-Gm-Message-State: AOJu0YzQGVDEErXStFCfqOXhzb2g4L40EDU7q0ThaZmAfvGIIv8GJNWO
 CsD7Ljx6J6imaqh3rpQjMNlibMds8DozC6Da4P/KR0WPYUu7RmGx2UE4bvab79DcyiI=
X-Gm-Gg: AfdE7clZ+1kQELGVtJs32Nnub/7ddExYC+brw246PhYIElFuTlv6nQ1biM/L8VnVx8/
 KfgrUcltZUZqa0UFrOMdkDTeMSwbFGeQH2mCzLSqkARmKUDbVZYz1Z5/XPiSXauvAD+dZXeI0sE
 hGLw2zdThJnWxvlcrfIAMDo+U57R+knPiJPZYKthHlAvzR2M4jiX6SL58/RGa1pji38MDzNNtFt
 ddegq4RJ8K26leyhfX7NhvQn3yLOvfyD3JkMe55BAHkvdXWxzXfYJUr1STAkehXJwr0KOByEOyD
 zfC9kLZxfDW/ji7Qp6Nu1Yz6JeFKvg++v1YJhJ8G8/P1S5nwMn7+Q2wQund6ucte/DXsoWPHYlD
 FxKmP6NqlE1FDdFDsksfocr1m5WAnvA5HJlmqndFAaCezpK8nY+BMvrewLENak3KYq7HinxZhg2
 r6ZIYBB/svbi0Zwflea40t7our9vq+mkgCOfe6FlWI
X-Received: by 2002:a05:600c:b90:b0:493:c42c:7e87 with SMTP id
 5b1f17b1804b1-4954a50885emr155657825e9.33.1784565742252; 
 Mon, 20 Jul 2026 09:42:22 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:42:21 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:41:02 +0100
Subject: [PATCH 35/36] qcom_sm8650_defconfig: enable CCF_FULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-35-8fece1b0333d@linaro.org>
References: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Paul Barker <paul@pbarker.dev>, 
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com, 
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=723;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=zYazqlETbNKC2mPejyY4/IyUPsLmcVW8tUwZxhcFWHc=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+HHt+jT5Zblxay6laHIL6Wu9GWiFYJxoLHK
 629I2vht2KJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PhwAKCRAFgzErGV9k
 tsxrD/9cXy3On12Q09mIt/BvUnh4l2X2s2WfRZlXI1Wq7ySTYAmamm575MNFfuDjFm7vRaoYYX+
 I/HE3RbzEGAou8gSCuS1lr0zB9Be/hbvjJl0FBzA78bfrxrCQn5gw433qZ2Wbtt/H/UaxUFxwcj
 hxshu2vvvEtPM2X/EkJItgyu0MFtStGBsmJ+2pAGHGfDjcZKy0M1reoNM0RZZnsI3stmgxZD7Jz
 9BUT5sL47TC1HFW/qwrLsUD8vCbk3fwgZS4JJ8VIa22Yn7eoNhlSh4CI/xXR4VPkoNySc2arjTE
 uevWF7gCselgNyEteZPL0VoEuwkb3nTJnEh0p4JjsI84/hOmaaKoCTWzHH0IZaqk6JGst/26wXO
 zeazlxOEV/nOa06aB28a4DR06wtyZTTn39tmC0VB6kHgprvedScHYLI8DB1KAtjsCOBF8foYKZ/
 NDswNjHn+2Xw+zVvL4u4d/2n0FlggBFAAhCJ7q/c8TtBi9oDMeys/YT+wQ+0m4Ou/4gbOzzBSv9
 aCw9rlaC9b0Lb6SD13egMO2uZixKQUbc5VU4dw0MDIirBmUGLJTU2V+Mh/wcKqOJ+TdidEWI+CR
 fFzpQHYeAcKJ8fyDi5LGwh2NZPYolygOpTGhU/QpXUI8HXM/8Ony9kuauueGZzk47m9yFEDYV9n
 G+3JTulcxUtdtyQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565742; x=1785170542; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SiMvf/w1IPZ1Z6IocnW8dvZXWVcg+hS1rmyrq7/K/y0=;
 b=UDMdFcQ1nfh9qGqsFwFp/cLyMBlfPhbZHGMo9y16VgocCDbRHV4tVoQlIxb0hGICDA
 nD6P56MCvxGtioSUURfBWYw1wUhXNik7H38hL0sj+UNwGbQwO5s3IEQWZFoe65FFzEFU
 44K8h5AMUc2B4/RjWZoHwtYTALQdoXUKDfU4Ntf9ZVeELzYrqSjv62ZJ09P8jItmjBE3
 EfFzVLvC2LsG2uD4krXt2zCTD+fp2CACo0Fdy4I7QWYuVf/hyqUcE5qS11DBnKfBzg6h
 7bdbXriEDEfT8yP6HUTitq0lYioDBIxuqab52qy4wGaFXqjtnVtSoDyLiNsEA4SVmfrk
 txYQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=UDMdFcQ1
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="UDMdFcQ1"; 
 dkim-atps=neutral
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
From: Casey Connolly via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Casey Connolly <casey.connolly@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable CCF_FULL for sm8650, this is the first platform to make use of
CCF, more will be enabled as we roll it out and port more drivers.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 configs/qcom_sm8650_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_sm8650_defconfig b/configs/qcom_sm8650_defconfig
index e0a82c460337..c1b42f3fe60a 100644
--- a/configs/qcom_sm8650_defconfig
+++ b/configs/qcom_sm8650_defconfig
@@ -6,8 +6,9 @@
 #include "qcom_defconfig"
 
 # Otherwise buildman thinks this isn't an ARM platform
 CONFIG_ARM=y
+CONFIG_CLK_CCF_FULL=y
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xa7000000
 CONFIG_REMAKE_ELF=y

-- 
2.55.0

