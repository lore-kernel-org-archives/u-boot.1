Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF4606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r9a8MPjE;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=IEaXRbHg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD131407AD;
	Mon, 16 Nov 2026 17:36:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YsXcZCw6jwzP; Mon, 16 Nov 2026 17:36:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00C844079D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850574;
	b=bVXFPIpAKhLMMzVZ4pSC6awrG5cxLa+Pqei0UTRcY+2yRNeHJLiMi1ThRGm+Mf43ScBo
	 dfDLbXXhg5KYttaK6zV8rgLlac7amY4hYSW3t7RuLaXlOV51zAh9Ki6h13AMJ5fGDLJY6
	 e8ZSmsjhqXCMtYPxiwHXx/9WiWTvoIYF7cyC0tneIfDa18Gp3DUrhcnVV4fgFUFQlZoDL
	 Zf2PywppbF6B7t6EphQFjl8fPQIa+F7E/bjvRNoKnly0kHjAyjvdhSNK4/2V7FIojOj/1
	 rl2dMBk46EFz9GM6XVw1EITzM9miDykIe3ZoyU506VjrCs+7iUTx60AmP4VyWJZ+Z7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gjAueiVHwm2eRbnW8+OqCz2y7kBvUj7mYUEeL5sjeTY=;
	b=dA10dT+Xyz2PlqMnOj/gL0KfVstMPYvH1hpAHnVosR/DgqNzuVVLSaYPLfu40XVdMotf
	 t+sWDjMGGfgOPU/bUcyu5oJAL2P7Q4QQ3O4OTMikdI7bPoHNQL9w2nIWP2oVkkt+kZ0Gi
	 rvAE2mTRY0Abqem/8wPMCTksV1nR5iUBXcmPlV+mIvm85grvwcqJvKi0eqpfasND44bD/
	 53k4Wf2jjihDktGIoWiAwQomcR1jif3373ZvC5EQfzVhqoOf5jr9YvWom2avo1qanT867
	 tPtXvrthxlkTzDSHty3VpHQEWieQWMzF7AM1/cok63ish0H0tYEisQaA8TbdkO6Jq9g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=IEaXRbHg;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850574;
	bh=gjAueiVHwm2eRbnW8+OqCz2y7kBvUj7mYUEeL5sjeTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r9a8MPjEPx7K4/VIFOddwd/Ev47JoAL63wBkBbq3RtrY+6LG/Gxf/Ogpi8q1QLJgj
	 L++FmmW6vZ8nlDHhwzKPPDDCLnc3ufhNouw3EgMi7cR1gvPDHh/42loyelFAxtuL3i
	 xmNbk9Ohy/F62wKUWQVrOgmV9oUZOeZdHIyKu14UzDQ62WKRI+JZUPxvTWLhtOLzLj
	 D3gm8JaAk/Q60sWkW0GYNR1AY7GXQVSQ1ffRhWSxfar6EGQ4srNf1pcy0t+W2bDomp
	 zots1rOj8b3RK3vuLr1k1OsYu3jbY586qix//pg1GJVhUuoGaG+n9H+tF+6TAdJEZk
	 +K9YUMHM62F9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00C844079D;
	Mon, 16 Nov 2026 17:36:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B00BD70B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 952EA405F0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N8-iWrt8ANxv for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:35:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E9DB940753
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=IEaXRbHg
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E9DB940753
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:58 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jSw4q1qQMzKmKJ;
 Mon, 16 Nov 2026 18:35:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjAueiVHwm2eRbnW8+OqCz2y7kBvUj7mYUEeL5sjeTY=;
 b=IEaXRbHg5l0HLMdoR9iGX+1IankHMsx/Jxfm/5QsE7swIVRyjFvKgWwAaSzNatQQqmcSqv
 kTRHwh8HvMWAj+FQt7q97/xSLC6ViY7ygXKRjQrD8ZNUChIyXpKVrcFKriBAax2xyMZYM9
 wxSpTHMhyzohDTBMkXBUmou/EjZO4bgEGLf+aZc8U1B6/CxJaQ8IjTvfMR4gaaQjOcCqIo
 sno8BaaQvNOxq3PmqPpQ9WFa4QCpqsc4dQeFmAhQefZfE+D9DeChWvYqDlamCZUHJ/39lx
 +fcOKx3brrcfJk1J6HlVyFfedXtwx9KUHHRob+kTcyJgv4Ob15AOVCZtVvFoxw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <sanderson@brivo.com>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io
Subject: [PATCH 07/20] clk: meson: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:46 +0100
Message-ID: <20261116173546.3487841-7-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 40695da0516e36d6b28
X-MBO-RS-META: gfizdt1zrqt85hux5r8ye9bu3hbprb5n
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sean Anderson <sanderson@brivo.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/meson/a1.c          | 2 +-
 drivers/clk/meson/axg-ao.c      | 2 +-
 drivers/clk/meson/axg.c         | 2 +-
 drivers/clk/meson/clk-measure.c | 2 +-
 drivers/clk/meson/g12a-ao.c     | 2 +-
 drivers/clk/meson/g12a.c        | 2 +-
 drivers/clk/meson/gxbb.c        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index b6d1887c98a..01f364f8a8e 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -224,7 +224,7 @@ static const struct udevice_id meson_clk_ids[] = {
 	{ }
 };
 
-static struct clk_ops meson_clk_ops = {
+static const struct clk_ops meson_clk_ops = {
 	.disable	= meson_clk_disable,
 	.enable		= meson_clk_enable,
 	.get_rate	= meson_clk_get_rate,
diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
index 5f897d89e9b..e72eb839cfe 100644
--- a/drivers/clk/meson/axg-ao.c
+++ b/drivers/clk/meson/axg-ao.c
@@ -60,7 +60,7 @@ static int meson_clk_request(struct clk *clk)
 	return 0;
 }
 
-static struct clk_ops meson_clk_ops = {
+static const struct clk_ops meson_clk_ops = {
 	.disable	= meson_axg_ao_clk_disable,
 	.enable		= meson_axg_ao_clk_enable,
 	.request	= meson_clk_request,
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 3b5f4af9f4c..8aa3d18eb9b 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -300,7 +300,7 @@ static int meson_clk_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops meson_clk_ops = {
+static const struct clk_ops meson_clk_ops = {
 	.disable	= meson_axg_clk_disable,
 	.enable		= meson_axg_clk_enable,
 	.get_rate	= meson_axg_clk_get_rate,
diff --git a/drivers/clk/meson/clk-measure.c b/drivers/clk/meson/clk-measure.c
index f653fc63552..743fe6f310b 100644
--- a/drivers/clk/meson/clk-measure.c
+++ b/drivers/clk/meson/clk-measure.c
@@ -591,7 +591,7 @@ static int meson_clk_msr_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops meson_clk_msr_ops = {
+static const struct clk_ops meson_clk_msr_ops = {
 	.of_xlate = meson_clk_msr_xlate,
 	.dump = meson_clk_msr_dump,
 };
diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
index d9425f900f3..c0f11ce6928 100644
--- a/drivers/clk/meson/g12a-ao.c
+++ b/drivers/clk/meson/g12a-ao.c
@@ -60,7 +60,7 @@ static int meson_clk_request(struct clk *clk)
 	return 0;
 }
 
-static struct clk_ops meson_clk_ops = {
+static const struct clk_ops meson_clk_ops = {
 	.disable	= meson_g12a_ao_clk_disable,
 	.enable		= meson_g12a_ao_clk_enable,
 	.request	= meson_clk_request,
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index b1ba5881904..1ac2b39c417 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -995,7 +995,7 @@ static int meson_clk_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops meson_clk_ops = {
+static const struct clk_ops meson_clk_ops = {
 	.disable	= meson_g12a_clk_disable,
 	.enable		= meson_g12a_clk_enable,
 	.get_rate	= meson_g12a_clk_get_rate,
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 62c1e0eed4f..5c2601e79d5 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -949,7 +949,7 @@ static int meson_clk_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops meson_clk_ops = {
+static const struct clk_ops meson_clk_ops = {
 	.disable	= meson_gxbb_clk_disable,
 	.enable		= meson_gxbb_clk_enable,
 	.get_rate	= meson_gxbb_clk_get_rate,
-- 
2.53.0

