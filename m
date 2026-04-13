Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C79EBFD38
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 11:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E39A3841CD;
	Mon, 13 Apr 2026 13:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y0fnwreT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31EA084119; Mon, 13 Apr 2026 13:06:23 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C5583F75
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 13:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48374014a77so60202815e9.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776078378; x=1776683178; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KuO7+RKIoPCYl+xOEAftzGlHG2Bn8WUqFrSXa3J/7rc=;
 b=y0fnwreT4sXOmtUX9hiw4VLso5bmvc7xKrn//BcBplms3KWWHVy0UwzkTOYxlsSYVq
 uLq2/eS4uADaBkpVeZVw/aZbraqvWErd5HL/5idFQoiBTulAy5KZonwb8XgsSFfxnPrb
 QcgidN9qUqcf9n6pZEimRORCF31oyx7aoT6NaPCB+jF4l1ezeLEL+N6tP3Lx+BTM3QEg
 MKkAnlCFiTmJQf3F9VOW1VE3/Bu+MRFmHyFs2/zlBQpCxPEbRlyvqLhsKfw+FLyj8RbY
 dmJGbf3ztxFisVJZbAxYHbv9VfQDK7A5jdz8dK0/AoxyxACHXNj7+AAOSQN0mC45eu+N
 R7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776078378; x=1776683178;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KuO7+RKIoPCYl+xOEAftzGlHG2Bn8WUqFrSXa3J/7rc=;
 b=HwizjuF08rGnTZRnLAjFK5Wt+00zIfAVXJDo5ATmHJbjgmzlvgAs1L85Ii9l3AS9vx
 OxJeETSDB/RPdPtD3SEE6D4h2zKuQB/xv+RrldB1mpyNkV0PPbQ5lzz0qMn3DxRHx/95
 l/BjqxLlA7avesAgCjCNh7f+wY3HRWIEZu9hObqUmcemHskSVUq/oTQeB4hpT0UvTvl8
 5hIQR1WqoK2qB+d9lKB0RlaO2ojb5/9r0HoXn54t3p0t5m6VzByzlCyQvNwm7deMq+v8
 iIaWvBjNLNYzL4PULXBo3QmBFJCJ3Agqy4JLvhHmD0DLp+tfRx5Z/60OoXORZSH5XO17
 QskQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XZntu/FZd+a9fajbwy4bju50bNla8C6gCObGs6VelpooLaTmoWLBAYGT7B2uJDT7Uc4ifPvI=@lists.denx.de
X-Gm-Message-State: AOJu0YyBWlb6SrW35YQWa74tIeB7kIubDs/Ht3wAA8o19wB5RQdboKFX
 1H+6dgQGXkFR4QqWCs+9yaOxbyWLQfQPHkWe14iOMRgdygRo9yfwnJomjpaXbcyDtPeiaxK0M1l
 ntXJTHS8=
X-Gm-Gg: AeBDieskwJAvoCpYHL5UOU+hd7f+XgUf14se/eVomAswgrcrbsl+0BDLdJ2vtVMKEaQ
 h8/NLJVbvFIToDw792bWnLtmlm0JgaM4XIDXeaobcSV6CCYp2qqQ/KspjnPeQDC7rNjzjpSVVWO
 O8MSHPumgM+R91foRp1RLBZyL1aJrvJRXGWdIb2bt9NI1yi9yq1mR6P5v7qmp76z++8oP7pmFlH
 GfuwsjUgzohbx3TqBs60TV5oQB5jwwQ5qwzijtZNMWB3KLNYi/Oi9LUXjzI0YGdvxLEOSJzvAB1
 bzt4cF+1yXpF/LOq/d963JX8U1JhnKA0B3ISK0gPNE78gCSPA0+ylXXTEMjrjfzqLCuKAx1x6P4
 XKX5GRJZ/Vi1UODhc2d/29Vg+XsKGTE4bqsc4YC4xZB8MPAjcAG0+BvlsNB883IXmZx9UEHFI5t
 /H+caAGZPuu+WfmzGq8wii5xOaCPNMdwwdezhKUv5oMzUJ0aKa9FFqyUUodLhTQOWtjQLt
X-Received: by 2002:a05:600c:8706:b0:488:a62d:76d7 with SMTP id
 5b1f17b1804b1-488d67df53cmr181160965e9.1.1776078378373; 
 Mon, 13 Apr 2026 04:06:18 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5347ea5sm327284945e9.8.2026.04.13.04.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 04:06:17 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 13 Apr 2026 13:06:15 +0200
Subject: [PATCH 2/3] soc/qcom: rpmh: only allow rpmh writes of a single command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-casey-qcom-geni-rpmh-fixes-v1-2-2a83a67ac0f1@linaro.org>
References: <20260413-casey-qcom-geni-rpmh-fixes-v1-0-2a83a67ac0f1@linaro.org>
In-Reply-To: <20260413-casey-qcom-geni-rpmh-fixes-v1-0-2a83a67ac0f1@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2331;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=4BBM5Z9rZMlSFJ/wYNUneY37xxkh5ZLsgZ/9c0ZNpoQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw759RYWz0PzcpKV3bMr153KaJ9zRHXyulT/nN+aj21t
 9jz76tpHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi/y8w/OG8/f4+t99U5vKM
 VTN4Wqsbp0ofSPTy09vq8Oye0kal3rsM/yyk729cXlI+jaPpVhG/+rk/6/lM96nk1nc+yp370nv
 P5VcA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

With how we currently handle synchronous RPMh access in U-Boot (being
derived from the async-heavy Linux driver), with available documentation
it doesn't seem to be easy to get multiple commands per TCS request
to work correctly, resulting in a broken state. This likely needs more
testing to find a better fix but for now this seems to resolve issues we
hit in Linux on sm8650.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 16 ++++++++++------
 drivers/soc/qcom/rpmh.c               |  6 ++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 361b03f207a9..5d284448fdf4 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -292,15 +292,19 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
 	tcs_list_gen(voter, QCOM_ICC_BUCKET_AMC, cmds, commit_idx);
 	if (!commit_idx[0])
 		goto out;
 
-	for (int i = 0 ; commit_idx[i] ; ++i) {
-		ret = rpmh_write(voter->dev, RPMH_ACTIVE_ONLY_STATE,
-				 &cmds[i], commit_idx[i]);
-		if (ret) {
-			pr_err("Error sending AMC RPMH requests (%d)\n", ret);
-			goto out;
+	/* U-Boot: don't combine votes into a single message since it doesn't work properly */
+	for (int i = 0, k = 0 ; commit_idx[i] ; ++i) {
+		for (int j = 0; j < commit_idx[i]; j++) {
+			ret = rpmh_write(voter->dev, RPMH_ACTIVE_ONLY_STATE,
+					 &cmds[k + j], 1);
+			if (ret) {
+				pr_err("Error sending AMC RPMH requests (%d)\n", ret);
+				goto out;
+			}
 		}
+		k += commit_idx[i];
 	}
 
 	/* TOFIX vote for WAKE & SLEEP ?? */
 
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index b55e23c4417d..685ac5d27cef 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -132,8 +132,14 @@ int rpmh_write(const struct udevice *dev, enum rpmh_state state,
 {
 	DEFINE_RPMH_MSG_ONSTACK(dev, state, rpm_msg);
 	int ret;
 
+	// FIXME: can't seem to get multiple commands per message to work properly
+	if (n > 1) {
+		pr_err("%s: ERROR: RPMh writes with multiple commands don't work!\n", dev->name);
+		return -EINVAL;
+	}
+
 	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, n, false);
 	if (ret)
 		return ret;
 

-- 
2.51.0

