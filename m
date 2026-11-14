Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150EB606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yeZNaE92;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eNs8Zttd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D75F381B99;
	Sat, 14 Nov 2026 09:11:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EJCyrQuwcIbk; Sat, 14 Nov 2026 09:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0FBB781BC5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794647504;
	b=OD0TIJNSE/uiL5O4ih3MZouACRIxKv+ZmLY+/kXkJc+HlAmWfaPuPZpxN53FRUKxbLaE
	 DgLkz4eQb4xk7JUKPeKueCDkJ8I1DIyIJ3YakAqnrIyXsuFMr2yfuDoDyDAZWNvruohb0
	 MM6oBh+ClbOc4n+gCc8f42KIUTgShAORxqHFVvV5GPgszHA7uPlCwKxXF06oLdItPBGyw
	 otSarJkVfuTBmw3/veMvC/owOEq1gdcBxaitFnImv3A3zTG7bq02bdx/9cherYc6AmVm9
	 3cbaQQYEYDAfAboIfHiqAWWyGD8qDYW3MjdNa6KJWrHP5/KuF38jlXtwI3Eore/eMlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794647504;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6Ik4QMFLN99CZC7MekchoPThxl5lAEFaXdoguWT8wyw=;
	b=DtBfA4Z6WFuw0YJsM72miU5vW51HKWoyZXzWJAPaenajQ3wQV+wddCnHnZhBXLQMYTCv
	 n5b9FWg955QT9gfq0o3YrsK91eyZKctVQw26aZ1STwdJadpNh08xIFtjIa7A9hY68hf+3
	 xtVsImlVHsJqAf+JFplT94ukOZZdrQJel+U6cvgM4/3urrafO5WmLN+LXZzfR1an7rUO9
	 va+zKgK0jiRKTe1M1CFAoWe/mlEkKdIOMX1VPqlZkLfsoNCPxQ2uxXVFZtVKLcC734obp
	 bSte+UX1JSfzD0pRzTG3rfDxYh4pJUTexkmO/CWUz5ESnuLkhSmmtUiLZiTQj5LxaIQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794647504;
	bh=6Ik4QMFLN99CZC7MekchoPThxl5lAEFaXdoguWT8wyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yeZNaE924fKBlNate6i+5XRZMonhL/7zI9No9n5PqLgtyiUKc+ghWKpAsPqZxyNYx
	 2Y8KSOuWT12XLi4rEd/NQXLEjXEQ9wkaiNfXgHytdp/KwEVj4hUtRP3YTtsV+9o6eE
	 5RbbmINefyoGxmPSjsElAvo1tDTkupXHKF+2yRdNrEOwcj+CXPvALpJEr9x5ATuR98
	 81PKcpi/J53yyyoetPHTEVH96ZR+QujeXKP2TO83DKGer7WEzNLcmUsDltJzO7lZoL
	 in09/V29knZvupoDYRehmGi/aFSO609XyJXU3WKwe7QlXrxqlVmJ7fCGlo2UhLhiqZ
	 VLFvJLXaMdS+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FBB781BC5;
	Sat, 14 Nov 2026 09:11:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7808E28C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 69A4A60699
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:11:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bIgsDgf8B8S6 for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 09:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2545B60628
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com;
 envelope-from=csharper2005@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=eNs8Zttd
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2545B60628
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:11:40 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3ab43d1dbceso3467321fa.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 01:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794647498; x=1795252298;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Ik4QMFLN99CZC7MekchoPThxl5lAEFaXdoguWT8wyw=;
 b=eNs8ZttdghnrIsSBOFgrByR2wWy12jyeZmVzwsWfZJYKw7XTuW2eQTL9ED6HJvPlW4
 h6iNSdTmvzM9+c8IntImUsoyBKet6DEaw8/OhzneuosMNbOLROwc//dPvb5XmqTBKBCe
 6+NDkufysg8T4zZSU62IytyZymIGMgfP6AuhFUTLB3HlPy6u74GK4OeRiY4WGb6JG4+b
 LAWJSN9e0nijL8HKd+OnpzWQzKihGFNOi4kG/oST9EHmwxC3kbXQjdNw0qf+BgStYeKt
 CaPGX1Wdm+vrkLbCm3/5xKpXdFBN9F1hA/FbJWoWbePMWuGg9Zr48/q1h+80RTIVIx4F
 xgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794647498; x=1795252298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Ik4QMFLN99CZC7MekchoPThxl5lAEFaXdoguWT8wyw=;
 b=VdJuCobpzPAl2bRn8mVPvWyzbgEj1f9jRfnux6FaW0Npb2/5W470BPIqx065/gdJHd
 59JFbzWZ/o1tqThkzipfrtYTSJ6wjoFTMxe4VM+hWzHFFbvhdE/k1AWA0+GnpDqQgXBq
 Yq1eqHGnXeBYTzJReWGibFbE4Ol6kSGWZNY6iNRDDserbylCmbw7S8SPzsvtjfORbxc4
 pqTLMDWYElQSzvTepmTqdg4G/42b/omTJ9S8n5IVC1Jp0/Fw15KktxyiXhBCe93sPzSP
 kmNF6WWNvE25KrziECKNHGD695PuLxQ0x24wgSD+f9V1K565eI9dArXr4eeLVmWMsEtv
 1ACA==
X-Gm-Message-State: APuU4Z9a3ABJN2cSf91pwslbRS6rSLAEMcsDtx3IYWJBPPpVCWQWV29z
 6MmldIcchM+Kf7v7wdVAP+IFs+MiYFP8sneItvSck6N0xAmjxqavMVbMkcuegc4bH7pmLw==
X-Gm-Gg: AYBFou2lFoINmQabSjMS/SKVhAyQ+0zQQOx2Q+ok7o1sLghqERqrgtrM8RGZhKpBYLH
 JJHmAgEkgVrj1QivzkJgody2UIzE6TmBsRAppuDkNCQop5tPJT5wkaIs+TWNWuphBOhnUZs6+MP
 lh+AcnCD/RzXKs7iENVEE7WWo8tlNouFZxDvyFFgh4+GWjVLT/eP26VxlIEf7yE2mu206bXcYC6
 Xsg5S3xfKhXQk9ve8nTSDHPf3KyAm3OIgziEHbdm+KO7KKT7GR53P/STapi3D8hq3RBOCTdEaf3
 uKwiUK6UKomL99y5IFMz5olL61gcLMDC595LPulqup/bBn8kVH/3MjCjuifnn1nXA6jbFURwGN3
 i048wEXRqQwGXREizVmKWMnu1Nt/kfjv14L/NaMw08PoeKkwPqljL33fMFAyr0yjW31hxY7vJD3
 tD3zlOevwoKDmX/wp8r2YLVmkg0THVFwglbl0t0rhsl1jT1ljMJOuTs7xHX1YbqBOvPQWh5mmr+
 zxVLknta8xcwWNX0TR4SP7u2sDddbrjY9PejswYxcosnMeiIc3LKQfy5tO4Tf1MOkeMG5kE+x5p
 IRq4oLCOPo67odXZQPbx3XrpGV+YhYZ6MiCfbNM=
X-Received: by 2002:a05:651c:e112:20b0:3ab:1d67:caf with SMTP id
 38308e7fff4ca-3ae2b394355mr14433681fa.0.1794647498298; 
 Sat, 14 Nov 2026 01:11:38 -0800 (PST)
Received: from OpenwrtBuild.lan ([178.207.14.215])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae2b7aebd1sm17097191fa.29.2026.11.14.01.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 01:11:38 -0800 (PST)
From: Mikhail Zhilkin <csharper2005@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 jstephan@baylibre.com, GSS_MTK_Uboot_upstream@mediatek.com,
 trini@konsulko.com, dlechner@baylibre.com,
 Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v2 1/3] net: mtk_eth: an8855: fix bit collision in RX_CTRL_8
 register
Date: Sat, 14 Nov 2026 12:10:47 +0300
Message-ID: <20261114091049.2418574-2-csharper2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114091049.2418574-1-csharper2005@gmail.com>
References: <20261114091049.2418574-1-csharper2005@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In an8855_port_sgmii_init(), the bitwise operations for the
AN8855_RX_CTRL_8 register contain a shifting error. The code attempts
to set a value at shift 16 (0x200 << 16), but subsequently applies a
mask and value shifted by 14 (0xfff << 14). This creates a bitwise
collision where the second operation overlaps and overwrites the bits
configured by the first operation, resulting in unintended register
values.

Fix the shift offset for the lower bits from 14 to 0 to prevent overlap
and correctly apply the exact values used in the proposed Linux driver
[1].

[1] https://lore.kernel.org/all/20261009161102.38961-11-ansuelsmth@gmail.com/

Fixes: cedafee9ff39 ("net: mediatek: add support for Airoha AN8855 ethernet switch")
Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
---
Changes in v2:
- Dropped the unnecessary `<< 0` and parentheses based on review feedback.
- Changed "upstream" to "proposed" and added lore link.
- Added Fixes tag.
---
 drivers/net/mtk_eth/an8855.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mtk_eth/an8855.c b/drivers/net/mtk_eth/an8855.c
index a2589a2ad31..663cc5d935e 100644
--- a/drivers/net/mtk_eth/an8855.c
+++ b/drivers/net/mtk_eth/an8855.c
@@ -627,8 +627,8 @@ static int an8855_port_sgmii_init(struct an8855_switch_priv *priv, u32 port)
 	an8855_reg_read(priv, AN8855_RX_CTRL_8, &val);
 	val &= ~(0xfff << 16);
 	val |= (0x200 << 16);
-	val &= ~(0x7fff << 14);
-	val |= (0xfff << 14);
+	val &= ~0x7fff;
+	val |= 0xfff;
 	an8855_reg_write(priv, AN8855_RX_CTRL_8, val);
 
 	/* Frequency memter */
-- 
2.53.0

