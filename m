Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27192C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE76C607E5;
	Mon, 20 Jul 2026 18:10:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g8YZGWRD9EH7; Mon, 20 Jul 2026 18:10:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71E11607E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571033;
	bh=qz26O8Zs4VSAz9kqDuu7J0ckuIDBUx/QPo323JKhrPQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YFr2ROwlrgrtbpiygsk6hH0gvwO29oNF9EHEjMU+KakOgtFfnpWTvchMdIoJNIIUM
	 Cy9ngAKDwJTm1/7+O47g4Ga7RlKZS4FH7IGRmma6dGQIBYN//aa96TQ1jwN/k9TmMJ
	 SZLpPZTY+8k7JCyRrc7WXG9jYTCQ5K/LJiT88zGeVf934nN7WtOT3X8IlbqJ/oghll
	 d3v7iBu7YOeAK2KzRpeCx+TFsCGd5FDZNfKDgn9RYy8py022fNfOLjI0mInnH2vyMF
	 Im0/n4K4AVlHpFhCJCs6jZe7pEMOJQ+oNKzYu8JCHImq0GYVE23VU9JdpFbCvsAhTF
	 GP20Q8HncoI0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71E11607E0;
	Mon, 20 Jul 2026 18:10:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC8A1DF0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9C8740154
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MeEYPWQTtvn7 for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:03 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C84B840136
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C84B840136
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C84B840136
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:02 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4023184A4C; Mon, 20 Jul 2026 18:41:53 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4498D8493F
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:51 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso23102395e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565711; x=1785170511;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qz26O8Zs4VSAz9kqDuu7J0ckuIDBUx/QPo323JKhrPQ=;
 b=WrptMxoF8UsKWthzTZ8DVCkqkEjNaEPvNDCD7cpoKSJmKFWkWbDdhutp5LMjRbJBFN
 8MkTeFeY0pqxrQdK/ylhK9PnPLDiYYdI82Sr6bLkSQfSBAoYbBBGMfPhrW0nBzScl7Tq
 3gD+9EqpNDgG+BzxKwyCkfDE1Y3E5nwgZo5LgaQ3Xa5tOuZSbTF5qZDaAyxFPLi7V6GA
 BXzD8Xiai9ovK+MY3TCrBvvjpUUyUe6I/Gs2K9Bx9hZuknZUq04qntdCoAQi0uuaRuPU
 kv/9QBschCMEOoiMoSE+cHzLQ78SLWIVKIE8KbooycOZdav12q7B7RsnfbOOG/EP8jkn
 B/XA==
X-Gm-Message-State: AOJu0YwAklsVji7TEmHqM638Klfm9NeKlH4GMpwgDpnKipgjnPj9UcRz
 3mFGUlX86gJ6j5M9m+LSvFdNz2HowWKuNQXcBIwLF7jAO8zKGMbtP2yrEx272TUCbUU=
X-Gm-Gg: AfdE7ck9G2y9KXsA3WgY+mQw72MqmGFiB+qEIqXVxjPUNdMFWFBDc6nVx4vcv/y5P8Y
 YYTsbmUYr8ur1WXaFjzLjUnjHObR/XysI/zsM5TFrJEBbcdFljuMzlaNbJzmyG7lN2oiMxj6gJo
 uaKb7TLlefkCEJvclLfcK7J1o80NnQglia7YRAYurCECwJNot4KKc2wKUFMHlPJiyJG5Gdin6c5
 g82qJo0bEV3o9JGsDzFXmjBGpl+BBrthaMXbXB796vf9+OpI9ctlLupDvjXXUL+bUPXrnWU/x1Z
 uF/EAg4DelFCeo7OXQ4VgfbUnH4KYQyHqOX2/yl+Z8jwJ/lLHF5WPb/fRS3yazISUHv7Mx3yMNl
 l0V1mNICMEelon3kuVWXz6GDGk30bJfRCtm6Og0aPqgDNBhvLV9Zv+ncu2geA5MrWnguF/5iHKu
 feynGuScOitrOL4b7gWPIMlndyew5AUg==
X-Received: by 2002:a05:600c:1554:b0:493:a570:df7d with SMTP id
 5b1f17b1804b1-4954a402f91mr179503265e9.20.1784565710749; 
 Mon, 20 Jul 2026 09:41:50 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:49 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:51 +0100
Subject: [PATCH 24/36] CI: add sandbox64_ccf_full
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-24-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=787;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=TgXzQZaxSFqhFD4S598LbmGC05ME2U6VLhYUAYlmOuE=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+EGOHNzoYVYKv8f3XLme1o7x7Qyrdvv9A7v
 GRZytqIqR2JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PhAAKCRAFgzErGV9k
 tlvlD/9u06KSuesVSVQ02mtweaZnJ0ZTc/0QJMU0zlilITmnoLngiUqbI9UuVizoORAIWyHRFGq
 pP2g1SxhYAO5IbCbtHIP3ws4y9k6Yu6bPfgO9efbQFQiD5tWL9Zg2X6jjS3eK0Js6iHLqcgJkN0
 bhhJeeJX6+00xvmtZYQoHUhA4rytbpJ6wePKew9HTIzdm0ezVpKwUSqlSZ77cDdlC2gZMUOKYVQ
 JspaSERfgmtMcZz7r5i12G4H2QuK8VDAQPJzKCQKYRWgQCKc5qErRcUuLEYlYUwXyQopl+B2AGc
 V5uCYvfmYHxso/Zkk/2FD7KtwPRNJBPF860TGrFPUT3iQeACZNq8WTkowSxhjjcbWSUeDWCjLN1
 UTNCVquLjkY/+LNCo1CDVpY9/zNPC+1CCxZ5/WJfxhcKeG7wi5ubnTIuSAhAjEMfpuPwk76d+ey
 /W10Dclawz97nonQbdOsGyBI/Zl82FhXVv1iIkwr+zULwTpGFUM+GHdre+eMpn8EYohk87woOyu
 Elc1pPQTsqagfTSsPu+BLQhrQw2mx2sdqYAEMv394nyG14V+dNeKlANXMCpq1G6FUTJJPwYrG/F
 CcINtTjjwp8KKnKMcRq2ZmTksa7kP6zw3kgYEDDApomY89ZtQZm6XsckVi9SzChvcxdXuvHZ6aX
 I58yvBsOuwDcoAw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565711; x=1785170511; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qz26O8Zs4VSAz9kqDuu7J0ckuIDBUx/QPo323JKhrPQ=;
 b=vcm9lNEoO/SdKXjF7agADkj+f6R8y5w0VkZbVbNMppz9nuJIU9CFlciqWTLU4Dm+rc
 T5v9al2+/TWc71dMX8+v04LPtHaRl9y3wCjrgos25CKipmrm1lD+msMmg1oRT9yEcXTe
 wWloAraMu9MNVuUQqWofohr6Ib9gPfRZwJV/PXuPA9C0wTYCxmGr+WVzd8RzeF5Efe3+
 Tyf8TnEEXDflsTMtsa7014ic0FPzUsbHIm5mpMDXUfwxQhBGoUra5kllhIK6mvBVocyU
 VWH0RlPCmHVxcjtRViexEk5bQaP2XdjJzKwmMBv2PeWSFZTM7SwB4JOacOTjGaaltnF3
 37HQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vcm9lNEo
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="vcm9lNEo"; 
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

Add a job to run the test suite with CCF_FULL. Mostly we just want to
run the UT clk selftests to ensure that CCF works as expected.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 .gitlab-ci.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index eb13fde82b86..20a91a7e0477 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -315,8 +315,13 @@ sandbox64 with clang test.py:
     TEST_PY_BD: "sandbox64"
     OVERRIDE: "-O clang-20"
   <<: *buildman_and_testpy_dfn
 
+sandbox64_ccf_full test.py:
+  variables:
+    TEST_PY_BD: "sandbox64_ccf_full"
+  <<: *buildman_and_testpy_dfn
+
 sandbox64_lwip test.py:
   variables:
     TEST_PY_BD: "sandbox64_lwip"
   <<: *buildman_and_testpy_dfn

-- 
2.55.0

