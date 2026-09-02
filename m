Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1860C624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A84C281068;
	Wed,  2 Sep 2026 14:29:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GJxFEy_C-nAp; Wed,  2 Sep 2026 14:29:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788359392;
	bh=+t0WCGVVC2aWdgz5EtrGCWNJjH5s4HrxMxDrzgFyMCI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D1ll8pK8uPO/bA8jvNbsAiMzU41COw6UM4E7EPbpzWSckc2IFbJgTtzb2XuxL7+qY
	 uiuvqRurqOUaSLSd7gxrtxHQ78njb9W4Obo5aqaQlOQh86wz8J1Y7YHrTH18n8rARm
	 fmCa6DV54ZZDE6TbjWTqAN2JGZmoENJYS+wl/oxzEyXSs6D1uL/c9Spf/w8gdf97Js
	 1awewz4GKvJ3oJSiyOtHmWXJxUhgArOtYXJjz5utibzmkCEPeOVDh5BCoctKvR/UF1
	 yPh8U8zd6k0/Tb62GQMjpujsgNMtXvNHmhJdag4Nm6KCI3gIrVUbeCy/TmodDCUc1D
	 t/dSQB//ZE+NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25AA08104D;
	Wed,  2 Sep 2026 14:29:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09E7A127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E3B66606C4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6TY0BYV5mPDu for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:29:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RJLoRzce
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 75AA1606B4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:29:48 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-484392e3d33so695580f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788359387; x=1788964187;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+t0WCGVVC2aWdgz5EtrGCWNJjH5s4HrxMxDrzgFyMCI=;
 b=RJLoRzcesCDdSK878xzfXYmBUZmV+Z4cxY3azzd28PK0KWYPE7mXg7C41osFU5G/MO
 loLvKtIjl1HCt/yzz/i5quDZ/s0xTghVlAb+ymF4zyAxsFWOirrWj9XjPkjFUbxkyrs+
 WL7cGJHc1E3frelU30OkHsdHDlN3BwHJtu2vNl8LmTes1fzanKgnuaHhu1H+JvV5GTgN
 eGZipkLOy4pF328/Fl/MuXEVLE0z0OqxoxXVuJ8vdDdFsyavWHDEq0i0DexKQJV2F9yK
 q6GpM2dgoIe8uEkvn+pZVQxZIUjxFhgWPdmFBQAqJJAhBHK/jSOZHeeT/3aQZMEGIeTy
 Iq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788359387; x=1788964187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+t0WCGVVC2aWdgz5EtrGCWNJjH5s4HrxMxDrzgFyMCI=;
 b=sAyNM6TcrsoSemRN1ljDgnaGwaW1BfVNOTGn/aonxdMulqYPc8SokheNZ9T+plOh0W
 P8sfeiJHK5DecPQiVcfxiacPswq73DkT/rUI3bK5guw10IxdHyHPT+qdczlWMXDTx2C6
 tp2OccUo9cQ/ob9wiK491Ep4ZWsjHY1qBy4hfV/DUWu2URgj+2GJHmz/paWauq099/9j
 zliwlwdju6y2nwugvajZhtG6UbHU24oeKTCGDAVE5/ac6BfScw0cj7TMvaKBXLpDB3YY
 pV9sfvCzgpZOqTOUMAKXb76q7vtVlvi9Ju+P5Svg0PWvP2eyQDfiYbGOLhr796QzfXtP
 leWw==
X-Gm-Message-State: AFuF++k0X+ZnBk4S5qEMl2ZK5v2h89XUZD/e5vxf+hgZBRblc/jR9gU/
 6OfokDYkba9CzcjV68hav0lbcDDEQDDDjIcJuTfwl4b3HOOL4v7/we3a4/KpUV2iUws=
X-Gm-Gg: AYBFou36y43OHvjRXpMLoOflvLFSPoG8axE14r12uzAmzBnO7NcBuKLiWYp4qM/14jO
 OszbG03z0i+ffeBlD8bLmTnnhfL0IoK4DYA1KkNm1X6G6r9FTvRrLqIWDcSH7SlFQofclRLpMO4
 3ToDaq5bqgZ3AjHlCJnpApLr4iJQaE144akTRz8/yVEbWsm9QfRq8dPYfTmuNHi9mxZnZZpv6hn
 AlTJ0ZantZwbj9/2GGTYKi57hi/C7/9Nl0ddPqS8JIOb3xIHo4K6nctKBUKNUWYdtOfrOhgMq9A
 6cTylJES7Olptfwc7BxBL4iPbB62E7H5vQXithhBVKwzgMVghcF+YtlHxpn+Bztf7S1KB40eWJS
 YQ2mxoqnmqKs20AUydGuguFY2Y43iwm6cwLndlYDJjkaEaz7Aw72BNCDuIud3GtOZYSEzOVfwYA
 WTr2gW4y2gKl7ffXiYoPh05oHudsSaYMYF8Z2IOgnWIpC7iiJb0cVEEZ2qmS7p5+EvrHv5IXTNd
 cEuHXFlNmaWqLAot/a7FoalXU0BroeA6xh61w==
X-Received: by 2002:a05:6000:240b:b0:484:3317:a18 with SMTP id
 ffacd0b85a97d-484914c23d3mr10405778f8f.25.1788359386617; 
 Wed, 02 Sep 2026 07:29:46 -0700 (PDT)
Received: from lion.tail248178.ts.net (p549d4d01.dip0.t-ipconnect.de.
 [84.157.77.1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72f02sm6572876f8f.3.2026.09.02.07.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:29:44 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	u-boot-qcom@groups.io
Subject: [PATCH] gpio: qcom_spmi_gpio: add pmk8350/pm8350c
Date: Wed,  2 Sep 2026 16:29:33 +0200
Message-ID: <20260902142937.2422919-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.55.0
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

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/gpio/qcom_spmi_gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index b218a3d3d585..bf2c11ebf8cd 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -766,8 +766,10 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
 	{ .compatible = "qcom,pm8550b-gpio" },
 	{ .compatible = "qcom,pm8550ve-gpio" },
 	{ .compatible = "qcom,pm8550vs-gpio" },
 	{ .compatible = "qcom,pm8998-gpio" },
+	{ .compatible = "qcom,pm8350c-gpio" },
+	{ .compatible = "qcom,pmk8350-gpio" },
 	{ .compatible = "qcom,pmk8550-gpio" },
 	{ .compatible = "qcom,pmr735d-gpio" },
 	{ }
 };
-- 
2.55.0

