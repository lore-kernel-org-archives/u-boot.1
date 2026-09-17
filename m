Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F789C982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1478580FA2;
	Thu, 17 Sep 2026 12:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CNFymn_QudJp; Thu, 17 Sep 2026 12:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3F24980FB4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789649462;
	b=NnIbkOxlZ2ifnCAiEoLj6PJMM0sIEkoKlpmBMtOgj2P9dk2mclwQi2bY0NPsdSaMgrqc
	 6RbuhhMv5IK9PCB98QHBwcSW2mpc3HqyjzYUZgED0inM/8raXq5MeL4VtksjkeQZAqBYb
	 AQZq//b87nsSuHPzAWMZqvRcvDGNdUOVNNCQiDaDzvgs0Xy+hlNQ1eMWM1GqporB8IRYY
	 YhXKJ0c33qk1ICUgHjVzn7vyuDHJBDG1QozpuwdBi0YqQMLScwN8TrDRMApNHzEHGy4Dj
	 HNCD1dCM3yikwpBbCaAcDk0wgy2qFoHh7QhCPdLZZItQ7zJUhza8WPOGw5gHgV2afGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789649462;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GvaI5B7BcOyuX7rOa9VIDjKzHTbnEunbuZlWD4OcCBE=;
	b=kk63nKW9mv1wZCopcYQOj2UtdTZCUu64mVOC1zA6ZITN0cgbb9FrAIecLkB7DwHL5bva
	 V9fALrLcwmmaXF09QnwytSzfiOvNOKqV1ivF2ux0C3M23C4aYSiWSQ3YZ5VCYtLAC3LfD
	 r5CtgkupfgKwZPypdnt76IlIH5kfRTRQkGpCOI7PHpSkfGEHOPP6yD7ZuFJoPsu0st7cx
	 C+slBqqgBXRtuMIwj2HHqEg69JpvzZ5tQvejNxoCy6tBcTrlQbCk4YxIl579P4pa64KGN
	 ZIj7r39GALNZj7Dv/xKBrgrr851pCLGJInuRXBMrct+YFB/6KDU/Nb48QvRyvPQdoEA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789649462;
	bh=GvaI5B7BcOyuX7rOa9VIDjKzHTbnEunbuZlWD4OcCBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rOx9ybchz7JUoVesdnTgYAWNu6diT4pHquTRyXpuYvUTneFJ1ihg7vJBACAjmtgxg
	 2O19J2aMmAWdCCftz67TyApfXOzqCfYUqOUQtkS9iCsrehW6IsheGc3In/is+o9LFc
	 BuzZ1AwTPubi0Va1hkXTYKpYhqPO2XVBX9lEqJcB0jCUFsvEUw3gcgAtyo41QxyaE/
	 ISmGmRK4v3JAjdFk1ScHl79xbRbx5QhNUXBVh0QHMCoxpy9qYFNfYLoXjlvAq3BrCB
	 MJbzHVi8nXnNnsQEiEDpUh1J87F/QWnI7zXmTm7zCrUxSD8M329GhqeL+oZzZhpwnR
	 RaLk9Xe0C3FWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F24980FB4;
	Thu, 17 Sep 2026 12:51:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 26562465
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0798B407F2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z-ASA6VLbi15 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:50:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B7815407CC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789649457;
 b=XfSnNyBpQ+tSMq6OUKSmOX6cGBrCVHXd3qGmoP9cuFVmxr2/poZoM/5cQi00S4n8o9B0
 /3ZoZax77IrH3SXswPTi9cIGF0liJvxvf+J5EbtjSM69T2y5wMRi19/Ft6kEqdCk5XJU4
 WMn3g/bX3NFYHtZhtNkGoliks2FxIJ2kRZHQRYNcdrOtxgiXfoG4CShrnVIwVTMNwEdRe
 EJs/Oh7GdREA+bGCMHKdRev8KIsqCUhbzJmAbhIuFlVSWZBMNVU/CKH+Momdi7yz8g175
 v683EtXwtux15CdsZwCmlxvsTcEsSROlApEQWvhiuBlG2Vd0aR5ERtEBAPGsZtYsGEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789649457;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=GvaI5B7BcOyuX7rOa9VIDjKzHTbnEunbuZlWD4OcCBE=;
 b=BF3D/ue2q2IZ+pcCnAAM3xiURN9N/zqVKn3S6HDpbB7AnuydvBMMtvkXtpTZCjApo/mx
 Lc6ciPzyM9Rq8d2+duLpCPbIT02AqjKA8NqHgAY7ou2KM6CXA3Ua8B/uKTa634nZQThBl
 /AIOzZ+cOni8NxEv40aid0i/bO6TKCwwf6izYCrzD175O8HzBMN0+7VQQLmgs2nFNL5xF
 wGfBmZcRjLegp+JvZh0e+tI+3TSOV1q8uOFMSi08nSQNdKbLCrHzDC03ZRv+P0qb5VT+/
 NKv4th7a8pC7DoxpkzhWjRV+nHJrANOgCwL6tM4H1gKcgXl5i2USwNxDV2OqB7644jQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Kt3Wc395; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Kt3Wc395
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7815407CC
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:50:56 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so5809845e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789649454; x=1790254254;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GvaI5B7BcOyuX7rOa9VIDjKzHTbnEunbuZlWD4OcCBE=;
 b=Kt3Wc395Z+9IwVfaOZQisUyl1i7KpHiDK+T2gLDAFvxNsZoIB2tf7yLjyRj66jeK7d
 ECSHGeMxeeBu+yfZhCaT1zCJOWOmP4lVQcQ6vZRUsmw4uk2x2pGdEamb88SwwSnOaJOF
 tecE1ZuPjqLCEq+nc5xPt/voB33/Pwp5kmAyew1o7iAehJWne/HPVezI7Hp/wyIgR4uH
 vl8hjLEB4XbJf7+nOIkSyDsIo30/EL7XU0MDgPQVTdrQqZzRXyfCYZknsCkxvexchEWF
 hVn6OL80keXSsrhZ0Kh+b60UQRbPNgcQ6wdBIN6sT4wDMnFGxgSQeaCy5wER84zSfuii
 gwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649454; x=1790254254;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GvaI5B7BcOyuX7rOa9VIDjKzHTbnEunbuZlWD4OcCBE=;
 b=hUcHAfMBamxM57weqvC2LqOeguPHjhwxxgZ4aGt7yHEW/1fc5LHnBH/ulkrrlFdsM+
 mxEt6vBDQ95hwjQZXlXlcjJqvRyZNxTNJ3HL5tpFDmE20MZWqy9XyUGBklaAQM+e3kGi
 KcwCHwTlqa5YNHcCO+Dp6r6dtbgpvt4KQe5SD7iwBUaMrvzFiES9XQMrzNcWhK/QjbzK
 KqBK+NUnH3sFcyy1dt66uxSQFOEHhgCymHcAAkWZ6tw3+1MiHTw4niggvmRMuaEXxCFW
 89zDgh6kdMCB0lW9htS7GtnbkYwRAX8mknEsC4OFWLtdLgNrVKsBYvDczcgcoYbk5mqd
 4l+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHzvTvAqWjU7OjESDNlmP1EJfpzNmF7uqelDSX3gSPAHLlUUW2zvFTr966RcbWXbbRMswMkEc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lsRlzx/e9zN8WDaRjCBdUXdvYxjinFOrDQTkKOKM8q2tKfnR6+
 ibWOufRG8H7mUR+PTpwamVEcqIgX/2ZAsWW9O7HfVnBG+1If4nBXDJ6OgW8N9QdgvVk=
X-Gm-Gg: AYBFou3XWVAes3zc6snPrmUbhv9I1FHiBsJ2tSIxL/Af//1T1wMlJ+ktnWeeyx8va9H
 FLTrWX60FQkFMATVBzX9B+fURvgvy2lEkO0a0Nfv+cX7pjNQZpirFkljHatIxiracqZ6z9n9FM/
 HWyo6WbhzmC5KmH4Kb/JJHRTQ92HK7L4KuSpTVTPJ9SFS70GVZs4Mfwpw219HPRZdVk5kk3j7li
 QNbH1rjYEAvBh21qpy8aPAUUdt9vEpIjEVNMK4EoHfElT647RwA740CQJ/kvaN+OjeO3RY79Vxp
 4NLnTo8X7HbnFRBEJGvVtY3eFUw/F6AObShIjuxm4e8KV1KUyOif9pvrTfnZXeov/11v/pF7hQM
 CSK8daZaBr05O2vtIPEfSSXpEABRMCSpG1ZNB9Gsr2rrJrL/Ry5I4N97ivXVpuDU2PXJtyT0Lkk
 cLXKY5KhvtHm5DSBvcp3l00RJ6DSc8qFJS/WRnol7PB8SRHexvV/QsebCx5ANXTIeYm2maaDOHA
 IE+HC14dBG4qtajyR+m0NKXcz7ErIYkDmrVwopPzj69Xr6NbVElGJheMudPS1/CcF3Ty35HvPkY
 VL78hqkp34ZKSTcS6GZtspT4q3GpJbVxP8RwR7vbpMUV9rGUIpIMnwFuSfW+kqK7kg==
X-Received: by 2002:a05:600c:4e94:b0:49c:fa21:1c89 with SMTP id
 5b1f17b1804b1-49eb7335846mr74158405e9.30.1789649454240; 
 Thu, 17 Sep 2026 05:50:54 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23f4e6sm88614255e9.8.2026.09.17.05.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:50:53 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 17 Sep 2026 14:52:01 +0200
Subject: [PATCH 06/11] clk: mediatek: mt8189: merge the clock drivers into
 a single driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-clk-mediatek-cleanups-v1-6-4dccf8ed98fc@baylibre.com>
References: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
In-Reply-To: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 "irving.ch.lin" <irving-ch.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

The topckgen and gate clock U_BOOT_DRIVER entries only differ by
their of_match table: they share the same probe, ops, private data
and flags. Merge them into a single mt8189-clk driver, the way
clk-mt8366.c already does, so that a new clock block only needs a
new of_match entry.

The MTK_GATE_CLK_TREE() declarations are moved above the of_match
tables, as the merged table now references them. The gate entries,
which used to be written on a single line, are also split over two
lines, for consistency with the topckgen entry and to keep the lines
short.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 73 +++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 8df09f4a129..a5cb387772a 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1970,6 +1970,14 @@ static const struct mtk_clk_tree mt8189_vlpckgen_clk_tree = {
 	.type = MTK_CLK_TREE_VLP_CK,
 };
 
+MTK_GATE_CLK_TREE(perao_clks_tree, perao_clks, ext_clock_rates);
+MTK_GATE_CLK_TREE(imp_clks_tree, imp_clks, ext_clock_rates);
+MTK_GATE_CLK_TREE(mm_clks_tree, mm_clks, ext_clock_rates);
+MTK_GATE_CLK_TREE(mminfra_config_clks_tree, mminfra_config_clks, ext_clock_rates);
+MTK_GATE_CLK_TREE(ufs_config_ao_clks_tree, ufs_config_ao_clks, ext_clock_rates);
+MTK_GATE_CLK_TREE(ufs_config_pdn_clks_tree, ufs_config_pdn_clks, ext_clock_rates);
+MTK_GATE_CLK_TREE(vlpcfg_ao_clks_tree, vlpcfg_ao_clks, ext_clock_rates);
+
 static const struct udevice_id mt8189_apmixed[] = {
 	{
 		.compatible = "mediatek,mt8189-apmixedsys",
@@ -1978,11 +1986,39 @@ static const struct udevice_id mt8189_apmixed[] = {
 	{ }
 };
 
-static const struct udevice_id mt8189_topckgen_compat[] = {
+static const struct udevice_id mt8189_clk_compat[] = {
 	{
 		.compatible = "mediatek,mt8189-topckgen",
 		.data = (ulong)&mt8189_topckgen_clk_tree,
 	},
+	{
+		.compatible = "mediatek,mt8189-peri-ao",
+		.data = (ulong)&perao_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-iic-wrap",
+		.data = (ulong)&imp_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-dispsys",
+		.data = (ulong)&mm_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-mm-infra",
+		.data = (ulong)&mminfra_config_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-ufscfg-ao",
+		.data = (ulong)&ufs_config_ao_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-ufscfg-pdn",
+		.data = (ulong)&ufs_config_pdn_clks_tree,
+	},
+	{
+		.compatible = "mediatek,mt8189-vlpcfg-ao",
+		.data = (ulong)&vlpcfg_ao_clks_tree,
+	},
 	{ }
 };
 
@@ -1994,25 +2030,6 @@ static const struct udevice_id mt8189_vlpckgen[] = {
 	{ }
 };
 
-MTK_GATE_CLK_TREE(perao_clks_tree, perao_clks, ext_clock_rates);
-MTK_GATE_CLK_TREE(imp_clks_tree, imp_clks, ext_clock_rates);
-MTK_GATE_CLK_TREE(mm_clks_tree, mm_clks, ext_clock_rates);
-MTK_GATE_CLK_TREE(mminfra_config_clks_tree, mminfra_config_clks, ext_clock_rates);
-MTK_GATE_CLK_TREE(ufs_config_ao_clks_tree, ufs_config_ao_clks, ext_clock_rates);
-MTK_GATE_CLK_TREE(ufs_config_pdn_clks_tree, ufs_config_pdn_clks, ext_clock_rates);
-MTK_GATE_CLK_TREE(vlpcfg_ao_clks_tree, vlpcfg_ao_clks, ext_clock_rates);
-
-static const struct udevice_id of_match_mt8189_clk_gate[] = {
-	{ .compatible = "mediatek,mt8189-peri-ao", .data = (ulong)&perao_clks_tree },
-	{ .compatible = "mediatek,mt8189-iic-wrap", .data = (ulong)&imp_clks_tree },
-	{ .compatible = "mediatek,mt8189-dispsys", .data = (ulong)&mm_clks_tree },
-	{ .compatible = "mediatek,mt8189-mm-infra", .data = (ulong)&mminfra_config_clks_tree },
-	{ .compatible = "mediatek,mt8189-ufscfg-ao", .data = (ulong)&ufs_config_ao_clks_tree },
-	{ .compatible = "mediatek,mt8189-ufscfg-pdn", .data = (ulong)&ufs_config_pdn_clks_tree },
-	{ .compatible = "mediatek,mt8189-vlpcfg-ao", .data = (ulong)&vlpcfg_ao_clks_tree },
-	{ }
-};
-
 U_BOOT_DRIVER(mt8189_clk_apmixedsys) = {
 	.name = "mt8189-apmixedsys",
 	.id = UCLASS_CLK,
@@ -2023,10 +2040,10 @@ U_BOOT_DRIVER(mt8189_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mt8189_clk_topckgen) = {
-	.name = "mt8189-topckgen",
+U_BOOT_DRIVER(mt8189_clk) = {
+	.name = "mt8189-clk",
 	.id = UCLASS_CLK,
-	.of_match = mt8189_topckgen_compat,
+	.of_match = mt8189_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
 	.ops = &mtk_clk_topckgen_ops,
@@ -2042,13 +2059,3 @@ U_BOOT_DRIVER(mt8189_clk_vlpckgen) = {
 	.ops = &mtk_clk_infrasys_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
-
-U_BOOT_DRIVER(mt8189_clk_gate) = {
-	.name = "mt8189-gate-clk",
-	.id = UCLASS_CLK,
-	.of_match = of_match_mt8189_clk_gate,
-	.probe = mtk_clk_probe,
-	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};

-- 
2.55.0

