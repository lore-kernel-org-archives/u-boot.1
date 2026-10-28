Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EFA606A334
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 07:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aejonBM7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D6E260752;
	Wed, 28 Oct 2026 07:02:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LjJsGCoY2DXO; Wed, 28 Oct 2026 07:02:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C0DA160658
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793170966;
	b=qbwMrBg04BvGVI14/rFGBK9Rd1Y9r4aOI86Cz3CdE779bZ6iAXH8kfx2NudxfJW4F/8h
	 qfEIcg4XW+pHe5h6XT+CX0xz5h/Hun1xbRadxCi/MUELAcN6GIgOkdF7Nn8Jr/x1FZR3J
	 O4N0InXgYGHB9wo179V7LVRMLKZDalAIp/I/UGfQ4iPir6woNtQnafB1Oy74gKUrFi1ql
	 FjjGTRe7F7yD+L2LucLxHp1XPZC7qAtBFn6PmBrfM4JpFlv2mDUabPXguwTAnp+Nun6mY
	 c+Ytb+7IeCJjKiIKYYc46TKTorxjkYNB6chUmptlWGa3QnIb/OpPA9f1zhTZhtgEUEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793170966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-DKIM-Results:X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eeojFQ6U8IvPwrgFYicdkyzxl+BqMZMeYGmycUnTQ3k=;
	b=cSgbxBSWLtO/YmsS7KnurhsvZ2jbdWV9qutr2bFWS38+QTaiaKfKWVOfmTe2Q5nwPtPp
	 bEQR/j6hA2zDC24hElWg7eXB7tqVm5+hvO/T31btyTqaYOEkMnU+8f439736gt7ZR6L15
	 KT5PjUChZw91i1YRv/vMpSkG75YJU3TBfZXfloq79H5jNjlpNe5pFEy90uV4bZiOAsA+s
	 uk7Bn61HU+i/KJBZusghNuFJNf9EbzwT48lRQ1qDJwnfblZNpPZ344XQbnYLY+1BCk4NP
	 nLNml1AX1sNrHSsiDtr7I6ckP7y4KkMPMCdhMod2iwFKfYsT37xo12RpudR9q8GlTjA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=andestech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793170965;
	bh=eeojFQ6U8IvPwrgFYicdkyzxl+BqMZMeYGmycUnTQ3k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aejonBM7K8pUaThyiqJ3rQ+ND2fgltuRWRP6qT0+RN+GjtMrv98Aafz1YZhvrNNHY
	 DKVpZttk0YhdM0E0CnChevZBGqlRKyf2vlJu9rauYscdm0O7By9YNM+ye2JQ7v+/ix
	 J+5ZFRa/ZTowia7OhilP+ovn+DflISKtdNiqtgzDCBslfcHZwx2KLEQqjetT4eqEt+
	 KkUwqq0HC2AXylqCXPKXfH1wnSVvvsLeLM4qmQoogM0C3qR8hUTP4RS3SjRhBnggXG
	 bK+urrrV/tYNPbm+l5hbFYptKJePZSbUDhooA7Ax8sZV5W/F+h33VS0AjVDIKxW6aH
	 JsoNfGkShY51g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0DA160658;
	Wed, 28 Oct 2026 07:02:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 379E7473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29AB060632
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ropG1e-ahPu9 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 07:02:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 30130605D6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=220.128.198.184
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793170961;
 b=ldUKV1CQnp2qbR5hgfKEueRQlo57p7W70piij96uHY7IDbdrsGIqSo2mvXbFslB6aR4F
 AYTE+sdkLf6EugDLHlHoFQnY4j9fUCQi1Y6NhkXKQLTIzp4MW1I4MtaU04Of0AGC9vbuq
 h+FjbKtwRTDWtmqYzPEohNpQOzujwbadNDxsEKI/1K4pTE7H+/RgGbjrqFxD/SrSSRFP6
 jGyP4qId5HynvQKHhIox1y2tvR5VIUlPeildirkepNwUqx6UtiZj6KYOQs0uzK5DpkBSK
 QwKNixJMube2baJNRfpOaDmacGBZApO/B7wn9U02IQ1QWKXbRhuEZyao8DmydI+kvVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793170961;
 h=Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy:X-DKIM-Results:X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL;
 bh=eeojFQ6U8IvPwrgFYicdkyzxl+BqMZMeYGmycUnTQ3k=;
 b=tSshMG76M/dHNRkxPTgeiYQgys5YUizPMzK/jfhH4Xsv9soGlq47yBCgt5KhHhconMb3
 TXhl+53F8ijkOheOdgvmBy57ewywLCQ/2R3/c8jiUXovr+hz7lhGTdSCirLmqa20eipZa
 KyieWwZ5xBaoWDNNpyW9HyJ9T4Lef6014qfCSYZFLs9/ea5PMRMh4dBWI46dU28Jc5qTL
 HZ+t5HGOgaF1VC9Oe+zCrh/4qiMlKdgXv4WB13lRGWm7d+8Z90MgIS+NWVFIKDQUYRIgT
 1dKpM/qodWYt1GoJ/Fz5qnukwxsNI2Hhqrypwi9hK1I6LXQLqauwE4UFtt39Ox+K/kQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=andestech.com;
 arc=none smtp.remote-ip=220.128.198.184
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.128.198.184;
 helo=atcsqr.andestech.com; envelope-from=randolph@andestech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=andestech.com
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30130605D6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:40 +0000 (UTC)
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 69S6i2SM035103
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:44:02 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from mail.andestech.com (atcpcs55.andestech.com [10.0.1.155])
 by Atcsqr.andestech.com with ESMTPS id 69S6hcxi034818
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Oct 2026 14:43:38 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs55.andestech.com
 (10.0.1.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 28 Oct
 2026 14:43:38 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Oct
 2026 14:43:38 +0800
From: Randolph Lin <randolph@andestech.com>
To: <u-boot@lists.u-boot-project.org>, Leo Liang <leo.liang@sifive.com>, "Tom
 Rini" <trini@konsulko.com>
CC: Randolph Lin <randolph.sklin@gmail.com>, Tim Ouyang <tim609@andestech.com>,
 Randolph Lin <randolph@andestech.com>
Subject: [PATCH 2/4] cache: andes-l2: implement flush_all
Date: Wed, 28 Oct 2026 14:43:27 +0800
Message-ID: <20261028064329.1986824-3-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028064329.1986824-1-randolph@andestech.com>
References: <20261028064329.1986824-1-randolph@andestech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs55.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 69S6i2SM035103
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the write-back-and-invalidate sequence out of andes_l2_disable()
into andes_l2_flush_all() and expose it as the flush_all operation.

andes_l2_disable() calls andes_l2_flush_all() before clearing the
enable bit, so disabling the cache works as before.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 drivers/cache/cache-andes-l2.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cache/cache-andes-l2.c b/drivers/cache/cache-andes-l2.c
index 45a4f216b07..007b23af2b9 100644
--- a/drivers/cache/cache-andes-l2.c
+++ b/drivers/cache/cache-andes-l2.c
@@ -91,7 +91,7 @@ static int andes_l2_enable(struct udevice *dev)
 	return 0;
 }
 
-static int andes_l2_disable(struct udevice *dev)
+static int andes_l2_flush_all(struct udevice *dev)
 {
 	struct andes_l2_plat *plat = dev_get_plat(dev);
 	volatile struct l2cache *regs = plat->regs;
@@ -109,12 +109,23 @@ static int andes_l2_disable(struct udevice *dev)
 				hang();
 			}
 		}
-		clrbits_le32(&regs->control, L2_ENABLE);
 	}
 
 	return 0;
 }
 
+static int andes_l2_disable(struct udevice *dev)
+{
+	struct andes_l2_plat *plat = dev_get_plat(dev);
+	struct l2cache *regs = plat->regs;
+
+	andes_l2_flush_all(dev);
+	if (regs)
+		clrbits_le32(&regs->control, L2_ENABLE);
+
+	return 0;
+}
+
 static int andes_l2_of_to_plat(struct udevice *dev)
 {
 	struct andes_l2_plat *plat = dev_get_plat(dev);
@@ -192,6 +203,7 @@ static const struct udevice_id andes_l2_cache_ids[] = {
 static const struct cache_ops andes_l2_cache_ops = {
 	.enable		= andes_l2_enable,
 	.disable	= andes_l2_disable,
+	.flush_all	= andes_l2_flush_all,
 };
 
 U_BOOT_DRIVER(andes_l2_cache) = {
-- 
2.34.1

