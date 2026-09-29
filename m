Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EAACA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA8DD407E8;
	Tue, 29 Sep 2026 20:32:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mCm-lVnh51tG; Tue, 29 Sep 2026 20:32:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D59D2407D8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713977;
	b=eMyhcjgQqjA00GrfDTDkrjKQIpy2Rgq7Onr9N3uZmYWj4fK9qa2vVvKIOYBSlJjLgJfp
	 FlVit5SK1A4jzmgq/h33oVuAQev4o63/S3G7vi7f7+3vJfUhc9TI5YoRUXlse8tX6YPhX
	 IsZ9VLc7IO3xTWY5Yen8M7G5h/xh9KWwY3L6bk1hKi6C2hVOACakjAeOCHArN1OjwNH6n
	 Y01DjkUmvD7oj1ZnJxDm/amcmVV34HXmznt/CSBwAS0swjbC9CBw2531tjybD98/d4ZqA
	 DGePNq6FWw34Msj3TEV56G6BrK8vBOkWz4LZkfRf3kiTOE8m+dnUZOzpaCQBitwPIxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713977;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7mpZf9zSG4aebIyRGKV83fhGT9psEYBk4ZzeKrNzVGo=;
	b=kqkUiGOwvhJhIYO9gXWXkT8lfSBSdeOlTd4jc4MVXsvcQfavyJT9SZQUx0xqMaigMUWb
	 2MGiKWw2WbP0qgyf3HnKCXutHzcHJcBzDBaiCMcFpciCqvLtPMDbc8l8v5T3dETrM2Et+
	 35P0vSDl+rBB9hKGStwFJ9kXdy0UZyUPpje7w8N6/q3+aj+l0jR9BQF3DrAcYeg0wumJJ
	 gpy7MqTtGZ/SkwZC5JKjJupYOBU0Fco+7lLSNh6x8ry5cjtA2zjr7EL4kBeGo1MGYtjqW
	 /1ywf5wXv0WZWMQ3RoyR4Py9Is8u+q+IrZH3CR7Ox5qf8WwRqTw4uPfho/zRyGbD/Fw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713977;
	bh=7mpZf9zSG4aebIyRGKV83fhGT9psEYBk4ZzeKrNzVGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xvlkRvH1OCD9WEpGU7cr6CDuth0J6m7PatKHfS5M5XGi4VjrUtPpYb/5Eme0fuMka
	 DVh6aFWma2yphaoBlHzquP/gYOz9JSP0FCzGo2y3Hx/worzXOtbvnxmDHGBE2fb9gX
	 r0szDSN9YrGRniAtIQehkuB5y2y1hbIpRlb86/Kzv+VOF8G/9/kwfOMMk1Sy2j0NmH
	 oUOZEyjNsOvrd60b3wj+LiMrVrYoDtBXP7TlLGyHcORojuG6UHRvK+7RfDXWeS1Fk2
	 OC8l79fxaQ9PcEcPAqJjFowfGQAbj74te7BwN9z6hQrG72MZLpaYcxkau0a8PaddPJ
	 3J2dyKRgTi5qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D59D2407D8;
	Tue, 29 Sep 2026 20:32:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DD76F282
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C337860699
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LvgrdgPrjaPb for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:07:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BADE4605ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790705250;
 b=sZ/359twg96Y6GiVs9Aa5hyjRRbiM0hfnEO5irB4V5igOGgCAk2HtOY9/l98cWluI6UH
 GQ8zKmGjK0XS5mmpZelaLGb2R4Yr0UOHjqx2vA/63fpeYoXdVpnmktORMz+4tIU+pja29
 k8rGrsvQNU3B800r4PLDCBKBjCqiMzYBhP2E8fYgb6C+ZXpiQSv9Z3cpaOSecKnpnSGEE
 YaHysKrm538WrR+E+dbO8NAPXAjlpXMImwg52OX93lFtjV0hnelsoDOOVvONY0Y9PzSIe
 FRpnFNz6JsjPvDJjIfMu017AEWz0zi3LaVNUQUK2HHT3yCmfCUWfcPGR8TYJx2vek/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705250;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=7mpZf9zSG4aebIyRGKV83fhGT9psEYBk4ZzeKrNzVGo=;
 b=ZsdcjUk3bwcB12M19vC3DeKnn8aG3DPQ35gqhzXqvihQWL2+3ix09G5/Ol/dzvIBSFc1
 4HShRoH1kKF7U3Dw5qonYAjsouubrnsTl/wyDtKbW09pvfNFh90xn3GDonvzYDMeksDqq
 9Zwk25QzhB6Af2S014IjGBP7TJ0Ww/UgTLn92VCkAUPmC7DV9o49F0QOBCLhZiMH8G+Il
 afxi5mDD7Z1+KkAvYpG2nGTrxVoKojRpkQ3gSUFDPR6YDGk/fS4RpXOmiOkS7uYd9bi3N
 DTnyQ/hhCdOLsomHA34XZUIq9yTNEJogFY/wKaqHlEiMpz+F8LIKtzwtaCYtnYMKusQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=o+hkmxDw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:34::c;
 helo=mail-qk2-x0c.google.com; envelope-from=sanderson@brivo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=o+hkmxDw
Received: from mail-qk2-x0c.google.com (mail-qk2-x0c.google.com
 [IPv6:2607:f8b0:4864:34::c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BADE4605ED
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:29 +0000 (UTC)
Received: by mail-qk2-x0c.google.com with SMTP id
 af79cd13be357-93c5a24e868so388340485a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790705248; x=1791310048;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7mpZf9zSG4aebIyRGKV83fhGT9psEYBk4ZzeKrNzVGo=;
 b=o+hkmxDwXKQeiuZew0wHWYOSEm5E+9XCPMObm3FNptbJuvXY0+h48VYva8rkO1QTy4
 JJoRyhUyXWTOlCMgoWfldnoweaQxl6YMnja+t2Ei3UeBlmI5+Qa/Pb9MrLqYGEiz4MQ4
 a+dKgxAZe7R340bQgQjVSEBeLqGNESUyDHCNpU7Mmreqh6yRvsbzZMClK482I8ruHz1R
 lwuedrFu6MmfaCLX2+YlQ18SsHgVBKs1pa9BAzM+pjJdBDwvFc/yPc9L6291vGpfZl4f
 EGqOn4WjE03COeNAef31KOBIwO9aFsuUAsTlCCmnBpb0mSBZWv1mF1EO3lW2mIUYkrAQ
 f5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705248; x=1791310048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7mpZf9zSG4aebIyRGKV83fhGT9psEYBk4ZzeKrNzVGo=;
 b=1+b5ZdylyNh2ZxYIzu0p21xU+gbpBBzG8pJQZEvZJqF2aNCY7ZkixceowNwWocUc96
 P9hUWaTvuLZ3UKUkbMCVGeC1lZN+1ICYDVjgxb2pof3kdBq0kYFz0mKc1ayYXt4HZUPg
 HeKdlcaIMHd8Mm8lBARzn3mPF2BguWwH832ghzvCR0fVW3Nblc9Pv+brPiFBJ7Idxoxq
 9Xg8TAY0T1NYWdb9SZ8+Gus9Tx9fdguNVph2kglZNzckMe9Cq5dpBlkAHQCRsqh9tKVr
 PAf9o2cgem9ZLBTODt0aPbLCOUiu6UPLcN/TslnAEVFuR0G6GfgcgFO0o6IQLL5gmZYJ
 Ni7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUfa/5UxYYZJu/JaG8m9FEkJH9YcR3jA9KbZTEeZ6hC7qgYx2GUeIEenyZuDWnvR7vmKebs1Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nWsjCilQaflgYCL4GSzUatQVwXrTtTFd222F99EvU72X+XZKWA
 QwGfQvXk4NcoB9sLa6NoQr6Xanl8XQamFj9jjeJx3E+uszJNheuCwCbvxtziXtaRQJc3IbFOoz3
 Bss8b4ZcGe0idna4WzT5A8ho/0zdBKoTvXG9i5a9pX5XWOxlGByB/HOLs+f+MZ6evkXiP3RHhZy
 qbzO0=
X-Gm-Gg: AYBFou06HAA2sQjRXybRQb7TEFq3ONPWqavPuncZTZj0Esj9jGjL4wTC0HVsp7IydE0
 MBrHMznqyEvqu1062oKddB4Q7awbA1r1x6X6KE2SzuGKmJ+jeIRqOLVk5UiaNn7MsPqt/Xgp93X
 5IDxrdLORyVmDDmjxqH7CdsmcbvjxGLOlG9iUW+n7NWCwbhqfMhyW9SDzeh0ddQb5NwgdcpH4rn
 hRzrH2lfXb+52DS2xmKFZBULZ5+Ob0GgO/RT6rbADBPzpDNxxL4PowKlNVEpNPDoR2u0dGBAhMO
 ZByh38/mNSpS7R40TZm+g/OFPCioP8eHVDitmHXA86H/g7WW1aExtClUZ2dLG/suRyM03iInBfK
 0Wy1Oy+Yd7We4fTkiBmNSfjVAwWnI//A3Z9PKuWiVrkYKKL0RuCGVrFh0RV1Lps5MJk08n+2yB4
 fWijGJlUMi92tJ1KQOBD5CiCV6ZrREBxv5EsdoLpuUMcoJu0yoQHuBKkDQwWyXrcoV
X-Received: by 2002:a05:620a:410f:b0:93c:7955:afd9 with SMTP id
 af79cd13be357-93c9fc84b26mr59232785a.52.1790705247516; 
 Tue, 29 Sep 2026 11:07:27 -0700 (PDT)
Received: from strozzi ([71.163.254.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:07:26 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 4/9] clk: meson: Use soc-specific naming for common
 functions
Date: Tue, 29 Sep 2026 14:06:26 -0400
Message-ID: <20260929180721.3440839-5-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
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

In preparation for moving a1 versions of several common functions into a
shared file, rename all the conflicting functions to have a soc-specific
component.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

 drivers/clk/meson/axg-ao.c  |  8 ++++----
 drivers/clk/meson/axg.c     | 12 ++++++------
 drivers/clk/meson/g12a-ao.c |  8 ++++----
 drivers/clk/meson/g12a.c    | 20 ++++++++++----------
 drivers/clk/meson/gxbb.c    | 20 ++++++++++----------
 5 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
index 6ccf52127b0..3215391006e 100644
--- a/drivers/clk/meson/axg-ao.c
+++ b/drivers/clk/meson/axg-ao.c
@@ -35,12 +35,12 @@ static int meson_set_gate(struct clk *clk, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_axg_ao_clk_enable(struct clk *clk)
 {
 	return meson_set_gate(clk, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_axg_ao_clk_disable(struct clk *clk)
 {
 	return meson_set_gate(clk, false);
 }
@@ -65,8 +65,8 @@ static int meson_clk_request(struct clk *clk)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
+	.disable	= meson_axg_ao_clk_disable,
+	.enable		= meson_axg_ao_clk_enable,
 	.request	= meson_clk_request,
 };
 
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index c421a622a58..e20d3feaade 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -69,12 +69,12 @@ static int meson_set_gate(struct clk *clk, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_axg_clk_enable(struct clk *clk)
 {
 	return meson_set_gate(clk, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_axg_clk_disable(struct clk *clk)
 {
 	return meson_set_gate(clk, false);
 }
@@ -279,7 +279,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 	return rate;
 }
 
-static ulong meson_clk_get_rate(struct clk *clk)
+static ulong meson_axg_clk_get_rate(struct clk *clk)
 {
 	return meson_clk_get_rate_by_id(clk, clk->id);
 }
@@ -305,9 +305,9 @@ static int meson_clk_probe(struct udevice *dev)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
-	.get_rate	= meson_clk_get_rate,
+	.disable	= meson_axg_clk_disable,
+	.enable		= meson_axg_clk_enable,
+	.get_rate	= meson_axg_clk_get_rate,
 };
 
 static const struct udevice_id meson_clk_ids[] = {
diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
index 61d489c6e1c..e89638d65b5 100644
--- a/drivers/clk/meson/g12a-ao.c
+++ b/drivers/clk/meson/g12a-ao.c
@@ -35,12 +35,12 @@ static int meson_set_gate(struct clk *clk, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_g12a_ao_clk_enable(struct clk *clk)
 {
 	return meson_set_gate(clk, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_g12a_ao_clk_disable(struct clk *clk)
 {
 	return meson_set_gate(clk, false);
 }
@@ -65,8 +65,8 @@ static int meson_clk_request(struct clk *clk)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
+	.disable	= meson_g12a_ao_clk_disable,
+	.enable		= meson_g12a_ao_clk_enable,
 	.request	= meson_clk_request,
 };
 
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index f33938e1419..cc7bfe9e2a2 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -194,12 +194,12 @@ static int meson_set_gate_by_id(struct clk *clk, unsigned long id, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_g12a_clk_enable(struct clk *clk)
 {
 	return meson_set_gate_by_id(clk, clk->id, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_g12a_clk_disable(struct clk *clk)
 {
 	return meson_set_gate_by_id(clk, clk->id, false);
 }
@@ -858,7 +858,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 	return rate;
 }
 
-static ulong meson_clk_get_rate(struct clk *clk)
+static ulong meson_g12a_clk_get_rate(struct clk *clk)
 {
 	return meson_clk_get_rate_by_id(clk, clk->id);
 }
@@ -888,7 +888,7 @@ static ulong meson_pcie_pll_set_rate(struct clk *clk, ulong rate)
 	return 100000000;
 }
 
-static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
+static int meson_g12a_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	return meson_mux_set_parent(clk, clk->id, parent->id);
 }
@@ -958,7 +958,7 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 	return -EINVAL;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+static ulong meson_g12a_clk_set_rate(struct clk *clk, ulong rate)
 {
 	ulong current_rate = meson_clk_get_rate_by_id(clk, clk->id);
 	int ret;
@@ -1000,11 +1000,11 @@ static int meson_clk_probe(struct udevice *dev)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
-	.get_rate	= meson_clk_get_rate,
-	.set_parent	= meson_clk_set_parent,
-	.set_rate	= meson_clk_set_rate,
+	.disable	= meson_g12a_clk_disable,
+	.enable		= meson_g12a_clk_enable,
+	.get_rate	= meson_g12a_clk_get_rate,
+	.set_parent	= meson_g12a_clk_set_parent,
+	.set_rate	= meson_g12a_clk_set_rate,
 };
 
 static const struct udevice_id meson_clk_ids[] = {
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index bf46f4d50bc..24b5f9b5d40 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -236,12 +236,12 @@ static int meson_set_gate_by_id(struct clk *clk, unsigned long id, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_gxbb_clk_enable(struct clk *clk)
 {
 	return meson_set_gate_by_id(clk, clk->id, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_gxbb_clk_disable(struct clk *clk)
 {
 	return meson_set_gate_by_id(clk, clk->id, false);
 }
@@ -840,12 +840,12 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 	return rate;
 }
 
-static ulong meson_clk_get_rate(struct clk *clk)
+static ulong meson_gxbb_clk_get_rate(struct clk *clk)
 {
 	return meson_clk_get_rate_by_id(clk, clk->id);
 }
 
-static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
+static int meson_gxbb_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	return meson_mux_set_parent(clk, clk->id, parent->id);
 }
@@ -912,7 +912,7 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 	return -EINVAL;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+static ulong meson_gxbb_clk_set_rate(struct clk *clk, ulong rate)
 {
 	ulong current_rate = meson_clk_get_rate_by_id(clk, clk->id);
 	int ret;
@@ -954,11 +954,11 @@ static int meson_clk_probe(struct udevice *dev)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
-	.get_rate	= meson_clk_get_rate,
-	.set_parent	= meson_clk_set_parent,
-	.set_rate	= meson_clk_set_rate,
+	.disable	= meson_gxbb_clk_disable,
+	.enable		= meson_gxbb_clk_enable,
+	.get_rate	= meson_gxbb_clk_get_rate,
+	.set_parent	= meson_gxbb_clk_set_parent,
+	.set_rate	= meson_gxbb_clk_set_rate,
 };
 
 static const struct udevice_id meson_clk_ids[] = {
-- 
2.53.0

