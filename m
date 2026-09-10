Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEEEC79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBB2340A8B;
	Thu, 10 Sep 2026 12:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PPjLXTIsk3al; Thu, 10 Sep 2026 12:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 079DE40A84
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789042457;
	b=qzeGLnU2wRgWZJXp6Gqs2+VJ191YOxOMUYfs/tPt98wdzJsKF0m5NFSZvS8gz2O3PvEY
	 hYRLdX62a0bxB3WcbjcIKFX2G3wKgovkZQ/LGQTboSjp22vOGBoKLXhppQUkZKnV8A9Gd
	 RabEx3yErBrT+6bdKEzN7kGtQhXroZEynqpFBs4LQ6FG/eJQGu72OCL6aPYqgv0MU5nUa
	 u0vTsMadtQKHTAR1BPL74E+c8dWBDC5VncDAnJvl0bDmbINEvpN4nEW0L/PR2yOhH7FOK
	 vW3v+zX2k8Tx8fBtqVNtKzLuhgxBhEZVCyl8RY/kTblWeXuyaxfHcfHwndybLEGrbNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789042457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OfE57VWx4A6ehW4EBMIwZQ2HZAarA4KsKDJdt1D7o1E=;
	b=R4YXDT4WfE1OMldeq3iE/Bz/iPiGWqoJMSCmp1dW0wmICyOTHI71yIAarDt5zWA1bQj5
	 SgWupMVgDgtsSl5JYWWysJFeImllkLb0hTMrBosN5NcnLuvL0EnpMdJxHhPcGN565gs7K
	 TrYxuBA7oIsX9SuSq0tmkl5VaYfvsU3EEfQ+WWZi/VgiQisMtv+Nelq9lVTEBEglOBqVh
	 1qo3noueZhmwe/t04JKSa7e+5iIFJyieWzemBLsPdoQf7TJCwydIdNrITKSDkGVok+QAX
	 K/ZLVp/9esQt/EUPGM2JMH6m6qK4ObQMwRIlRbsJdoJdL6DhX9myoP/6DhDJf+ai+YQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789042457;
	bh=OfE57VWx4A6ehW4EBMIwZQ2HZAarA4KsKDJdt1D7o1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ptg2tnHCNqB/DxguHqoxvbf+p6FGJbqXCruZxhA4hulWEPoNxocp63OBJoGvkA9YH
	 Z7xhqu/hZOYCfP0XaH9LMaSGxwik16t92wl34p2zwppl+m1Q7hQOsgIZgzYsU+3dXw
	 cpv4miYmfQ2M5CLraNz9vhc3TQlLBbWnVkgNHHd355pmAqRvA1wlcUqg4X+2S+Eovl
	 c0AwyGZ5YuZ1icn47xjZ1IMG3pzbftwxV7S3gjKZ4+HUe0bbINZPzZIhYFv4InNbsp
	 tME0tiSxmX0R2DT5xFEks2oTopK++vst2p+m74IGfxWxNYfMdS/L5PQWb0kY9MPnKT
	 mCUBu9NXOnKpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 079DE40A84;
	Thu, 10 Sep 2026 12:14:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C74B749D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD4BC80EE3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9yYJtPIxGpCC for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 09:54:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0D90480EE0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789034044;
 b=kzKpCVEIjsC3JKZ/JmJARHV5wFwXw3czKLkj8Mg/z00Dg1ShSc/IvQ2tmbh/8PRj+UiK
 mHrPSZAOwEKhgwzFSQzyMN++91ZnxZ8nOio247XUGvgx6O9X3A3Rd00UAqy6MIV9j4PPp
 8MWhNgvPMo7XC3FWa8aRsEpS1hh8Z45eVRJ+E4dLyMuHpMfEWpdWb7SiXO/8krmeG7DKq
 qy5qcUgzb3dpVSkGYAUGhe5q7dUHvmPnJY34IgC7N46TVH4qvuwB1TkX6zNXpr/BlHi9F
 jEEJaDWGBs2mbthnqfML4HFX4ZJZvWTAMAV0JLT9AR20CQi11cyYTcEvlILtpZM3M6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789034044;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=OfE57VWx4A6ehW4EBMIwZQ2HZAarA4KsKDJdt1D7o1E=;
 b=WGSBScB46gDAL550t9NGZrXu6dVqs+peZNO4+lKJXbxeRn3tuoH9B36YvgY2ovcoCNp5
 NPLjwF53l2LzItfOcUgpebhafGYf3PU6b4+BRUuru/ppFRXOJXQ9z0FutKSr+BK5aKSdT
 eXggD/8M7kuZo96kbs5Xt+0kChFEF47vWJ6LBaYpn1zrbukdsYn7fisSlDASTPnYtsnXb
 Bk4mNb+P3BkVWrIoaW7kBx0yrPRvuHZZfC9hYViT0DgUz+WEvWf1jY8sVqh4e1UqOQDVQ
 92xEn9L5WNVzUNvZ+W/j9UJFmD0OlybZOsCH3VecNkWJgkzQ58zb8E0qHe1FAh1fUYQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jg+SmnX0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jg+SmnX0
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D90480EE0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:54:03 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccafb750so1986680a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 02:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789034043; x=1789638843;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OfE57VWx4A6ehW4EBMIwZQ2HZAarA4KsKDJdt1D7o1E=;
 b=jg+SmnX0DC6g0HhsrkMaZdQ4NOKXu+Pap+aWALB90jI4jrvtJBz27ExJ15LOJ6itoT
 lMsif2fVdbII5iH47cqi4CBqUB97QezdnQKVra7yuz4QPQGwKllznsTn0i5wZPRtIwm9
 ETSrOiL+SksfQV0MByEkGcJcBmLRmNZ1VULhTAIt5FlW0Tnmg8zaTXOZtGPvGOID5lyQ
 Vd96Wt22qZaMbnNflStgPpy/euoE1rjcPkFeI0zHdI8VgN4yWyfDhKBRMxlQgrAerSUU
 QnYWo1uR5y8B2aVYy5qL9ccOD4lKaS+sjUb2/se/dFg6In54fW/0/GV9CTQbTPU661Ou
 NOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789034043; x=1789638843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OfE57VWx4A6ehW4EBMIwZQ2HZAarA4KsKDJdt1D7o1E=;
 b=Lfc78oG7pzSIdOMdceLoT/CljWRUigl3ztRqr5rN0WCFgkE+EiktSdAf1jjQupBbss
 iq5bMFCFsHFguQH7oCUFfOw09zvJXr+mEfVo3KnfMZsfVuFUIJyJCgba0blmSsFl1Mlf
 lxpDVYoELZoN8tpIwHCtunsFG4TK0PAv663VZ+vec6/FasdNIqib3yDDqOJNv0hVp/68
 o6YRhxmwU+aOPeDdm3Ea7cLfdc7LIuFloGKOiRq5kGwScIk2gW2sAD9eG/eyJ6JUQ0NE
 DEdgu7/PFdOTUW6s545yP7SAdJ8sghoeYEXTCXw93lXU2YOEeOSF+9RGycIm532qFryI
 uxHA==
X-Gm-Message-State: AFuF++k8uX+lwTIAVDd0H9699fukBkYubtluyUnRvq710oAjqvhMSDKc
 y2OnZlnw4cLKQpIoJLWIwCGT/pgufc4PbGw160KreC42H6tCWjApREn8PODr1A==
X-Gm-Gg: AYBFou1e+e37fnq7G8k97exflAvZKRn+cEOkrg8GtF7k/ymUjV2AYdw3M4R5hZIyDkH
 e9T1Gyu9qCGNC5E/EniIsGyddSYC39zcsCvxR+lusfYsfQh3vzNbjSHgsNxpZoVvY9N0/QM9euR
 sx+ZnRw8Gn5bLoMftV3VcwWDFh65LKuR3TlUMU/XiOanhEVZvQRDo3C0+XyWnYwgYFn0R1aYR/G
 BhWL+O5tKyjop7am+NXWdVZxxvIorrOR4h6KvKdhiMcRdMSQIPID96y7DVFONwAQoAuQwWTOxMP
 hHR0TUjHSjrWBki9/bJwCamyipz6XuiNQXqXP4zRoGnC0IEn7aSHQs1B/7fZCo+Olyfb9U0v1GK
 7JNRzRbaXJ/jdV9vO7L4MIlOVpmZCThWPojoxdCdyemHWcqC1V/ezQRpDuHJGUKqTTsvPrhd0XI
 k2n7v3jpSZI3PNp2yrFN9Y6G+XQ89CSgS1/yc2rLSDgAHprn4bGNGOBTulREpgmQTiu7YxAD0c
X-Received: by 2002:a17:90b:1d45:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-39bac1d89b4mr16586879a91.9.1789034042744; 
 Thu, 10 Sep 2026 02:54:02 -0700 (PDT)
Received: from thefoxflat ([2404:c0:7029:b3c6:7b99:50ff:b405:5c31])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d7e77498csm3849455a91.3.2026.09.10.02.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 02:54:02 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Reza Kurniawan <imkyufie@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH 3/4] clk: qcom: Add an option to poll for GDSCR GDSC_POWER_ON
 bit
Date: Thu, 10 Sep 2026 09:41:46 +0000
Message-ID: <20260910095339.110427-4-imkyufie@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910095339.110427-1-imkyufie@gmail.com>
References: <20260910095339.110427-1-imkyufie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 12:14:04 +0000
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

Some SoCs such as MSM8917 poll its GDSC power domains by reading GDSCR
directly, as opposed to GDSCR + CFG_GDSCR_OFFSET.
Add a poll_gdscr flag to struct qcom_power_map to facilitate those SoCs.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---

 drivers/clk/qcom/clock-qcom.c | 24 +++++++++++++-----------
 drivers/clk/qcom/clock-qcom.h |  1 +
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db7..754ff4ff4 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -505,9 +505,9 @@ U_BOOT_DRIVER(qcom_reset) = {
 static int qcom_power_set(struct power_domain *pwr, bool on)
 {
 	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(pwr->dev);
-	void __iomem *base = dev_get_priv(pwr->dev);
+	void __iomem *base = dev_get_priv(pwr->dev), *poll_addr;
 	const struct qcom_power_map *map;
-	u32 value;
+	u32 value, mask;
 	int ret;
 
 	if (pwr->id >= data->num_power_domains)
@@ -527,19 +527,21 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
 
 	writel(value, base + map->reg);
 
-	if (on)
-		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
+	poll_addr = base + map->reg;
+	if (map->poll_gdscr) {
+		/* Some SOCs such as MSM8917 poll at GDSCR */
+		ret = readl_poll_timeout(poll_addr,
 					 value,
-					 (value & GDSC_POWER_UP_COMPLETE) ||
-					 (value & GDSC_PWR_ON_MASK),
+					 (!!(value & GDSC_PWR_ON_MASK) == on),
 					 GDSC_STATUS_POLL_TIMEOUT_US);
-
-	else
-		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
+	} else {
+		mask = on ? GDSC_POWER_UP_COMPLETE : GDSC_POWER_DOWN_COMPLETE;
+		ret = readl_poll_timeout(poll_addr + CFG_GDSCR_OFFSET,
 					 value,
-					 (value & GDSC_POWER_DOWN_COMPLETE) ||
-					 !(value & GDSC_PWR_ON_MASK),
+					 (value & mask) ||
+					 !!(value & GDSC_PWR_ON_MASK) == on,
 					 GDSC_STATUS_POLL_TIMEOUT_US);
+	}
 
 	if (ret == -ETIMEDOUT)
 		printf("WARNING: GDSC %lu is stuck during power on/off\n",
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 3a4550d85..0b514cc1f 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -76,6 +76,7 @@ struct qcom_reset_map {
 
 struct qcom_power_map {
 	unsigned int reg;
+	bool poll_gdscr;
 };
 
 struct clk;
-- 
2.55.0

