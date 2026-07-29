Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF0AC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E106460ACD;
	Wed, 29 Jul 2026 12:28:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v0iFsYrGSi4A; Wed, 29 Jul 2026 12:28:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C8EC60B9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328133;
	bh=osi1LANQhOEjX2G9IoY7fWp91dS0zsJuKS+K2U8FEhQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vQSd0EhulV83FaG1TrXZN4fDias5k0RwoUkjz/rmkg74E9c4WQZoqzvXimhrdn9Dn
	 rWCyz7t/XU+5nHSQnN0NjEzZXp6KYCPsRxJVr6FBjwTbEnUpwSXWzHwHFR9Gnjr4zM
	 51ZG5NEhbMKOIBArKY+ebGyropqqVPo7ZQLAWSEPpNtmjdpXbn2PTkSM08giackuix
	 bqodteRDgsCam/a7BpwZgja+v5ogjpddndfPQnB51nffRnvRI4YBGoT7dTUTge/7Wk
	 riRL9oV19XqciWmcifkS+xejxMG/E4pnro+acPZJIEJdTfB0Grd6MPgtCskWay3aLz
	 ZRQsVkYeHwvHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C8EC60B9A;
	Wed, 29 Jul 2026 12:28:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B60E9350
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95BB2401A3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:12:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hV9PhdVYp5zQ for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 11:12:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=bhimesh.matsa@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C1AB4400EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1AB4400EF
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C1AB4400EF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:12:28 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so807516a91.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 04:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785323548; x=1785928348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=osi1LANQhOEjX2G9IoY7fWp91dS0zsJuKS+K2U8FEhQ=;
 b=MjjeOKYxW3gs6ZwsSFwHRPkUSGpSY/GjXesqf+O1JgBd3u+4laN0j1289DfgXHQaBC
 fBrWBlJ/MncFj5dGA6a+9YVos9njChEys67bgyboV2DvwQOGnH9SXHuCxcQcju/oDPWZ
 7Om7SZBzVE0RSJMD7A5aaoUVDJ6UGyc1b6Vk7cxDuSlKh8VW9WP5lnQS0JRGz4kbPTMz
 KKfC0o/olaXfMfnYKUX526OYjlUuW01L4mGoFbgETFy32ZrTWpN9mBpPKizsaiL2/+p5
 kcY6/YOiWGL6J+LYbij1CsTj69Hv8uIvGWKx549wEdqORv7d3lcsh1k268hnWbbofJPq
 DzqA==
X-Gm-Message-State: AOJu0YxPxcvbTYSKYfW1ZZ6PUPr+BIyMTE4u8UQ4/GmtFjDH8uODoAPs
 FESkyqJrWEgDsMZo6Kpp03bBKNr7Cp6Ow0+cY+zQ1pD7aQKUTEeL9hqcS3Yo05Vs7MKzqA==
X-Gm-Gg: AR+sD12oeLYiuLQ2wM0szNElpovbtg/hGgzNu2BTMSrVD54eiedYCjvxzSEuX4cf+nv
 1D+jtDxZ0YILFe+pEXO34H/+RHESNtI7+NmZhP9cpqun9cGQYOEJuHrRRkmT9zBj/pueZsZaFgX
 DrWctudOPAs9uRJvD65YrOsnW0dyEFaJO/v6Yvxjd3m2y8RN0T36jtP8w5/N9VEzCRL+fqRNxrg
 QxlRYEg3Sy3arS3VztfG1xvSmeeBKz2lyIpjpoPnQXjJfQEQs8hgP27a9btwjMA9ZNp/hwadR3r
 f6sGn1pQv3hGsi2+ZvMEXumdxfONY3bnnHEa9ttQdYDCLD+c2YvSZTSpgEFva+mQSOaFWSy6Gul
 jlooT0/reczZxtq8T7+brjhOFhaYBm7j3xrrFgzWqwmVERQ4KUCLp5zjPXIvg1frxMhFl8F53PX
 dLG9dpNle3hXSmUnjCcrwRJ4NkYtcO7slTqVhL5EyeEV/QEhykG6aegsJxz9IHcYNY5EMqAdpDW
 bmGgdTY
X-Received: by 2002:a17:90b:390d:b0:38d:eaec:4396 with SMTP id
 98e67ed59e1d1-38f6a33d7dbmr6236437a91.11.1785323547974; 
 Wed, 29 Jul 2026 04:12:27 -0700 (PDT)
Received: from kumara-Inspiron-15-3530..
 ([2406:7400:63:a95c:e7ae:91b6:90c0:a107])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d373c3sm9084394eec.23.2026.07.29.04.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 04:12:27 -0700 (PDT)
From: Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: jh80.chung@samsung.com, peng.fan@nxp.com, trini@konsulko.com,
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
Subject: [PATCH] power: pmic: tps65219: fail if regulators node is missing
Date: Wed, 29 Jul 2026 16:42:18 +0530
Message-ID: <20260729111218.28598-1-bhimesh.matsa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:28:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785323548; x=1785928348;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=osi1LANQhOEjX2G9IoY7fWp91dS0zsJuKS+K2U8FEhQ=;
 b=jQy0iVaWb8BkNqOsPcsfskrUf+VD94pxWWLjmqGKSdLe2oHb4SbKgHxLHFPSqhNtIZ
 TnY6lngeKOLVPlxzFfRF1uw6QdAgFn2BCdOkZjCwhiITdrSF0JCbR8Uyx1Qe++bj4cnk
 O4ylr4lsUcYWDbFdQXhZe5RdkPL0wN7WGe/goTOOyy7JBg267t0PluJQXTTAzJScVW3j
 zRRzbpeTRAumgPpohhf3UaiHuNUt9809IhJPBP3slSh6Q0GFtVE8Xvn/5LDGySyiCMKA
 Qvv+MVJXTqkE0OpjiVkiMgxtz3h3TRPlZtx0GuHA+AIMeGlJx1txSUcFKwQ4vQ3vbqAe
 mVCQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jQy0iVaW
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The TPS65219 bind function continues when the regulators subnode is
missing. This causes pmic_bind_children() to be called with an invalid
ofnode and permits a misleading message indicating that the subnode
was found.

Return -ENXIO when the regulators subnode is absent, matching the
behavior of other TI PMIC drivers.

Signed-off-by: Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
---
 drivers/power/pmic/tps65219.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/pmic/tps65219.c b/drivers/power/pmic/tps65219.c
index 0716af027a3..1fecde84795 100644
--- a/drivers/power/pmic/tps65219.c
+++ b/drivers/power/pmic/tps65219.c
@@ -55,6 +55,7 @@ static int tps65219_bind(struct udevice *dev)
 	if (!ofnode_valid(regulators_node)) {
 		debug("%s: %s regulators subnode not found!\n", __func__,
 		      dev->name);
+		return -ENXIO;
 	}
 
 	debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);
-- 
2.43.0

