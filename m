Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427CDCA5FA3
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 18:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DCFA40550;
	Mon, 28 Sep 2026 18:54:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AaCC354AUPCX; Mon, 28 Sep 2026 18:54:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5584440552
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790621691;
	b=CXvLlcbbUg/ovjwwo6TPrj/SgMAMsTf//iVg2O0jBnCdvgbkzfQAs+QsFPQQlD95yZwt
	 V9iEn4OruH2JDgcqE92I8bYTnU1dxt5CvWdB8IM97O/4wE6anbJ8IOUAc2si3CRvgM/ZT
	 v7OA1i2ILBfEFGZSG1ZaAMEuOt5cysgc0jeK1RZmuV9Eb+NsnjZfiwFLkHXkw9KBI2ZlE
	 Rh8L97fWDoiXQR4JrcBrLllf0khoaBhzNGYihGwpgNwqHAqUDMtT/lNYcvhaOcgKWHeCJ
	 L6NGCK+tK04KCShFJxZaa3rvWf6URtqTekyynEUrbFM63swJ3epymfvOoZO36CDcMig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790621691;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:
	 X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vBnbc4Qip6Uz7+hNFt3Du6VwcJ87rKRsbtZBIUen/c0=;
	b=d1SvNrqrnR4iQx31up4omgQLslKkDIy6BXgKxQaHjBiI46cHYvTFTSXHaw7/qit71VLm
	 ZPL/oaDKioQDVztndA+yDNQMEeLe3KSAm/M5rgSYC6OQtVXoEdTVD9igkoHxbNZPNATka
	 4JYkTu9XVglWvCY09mffiN2/8dQ8SOD+p4z94VprwZNBt/dvVGp3q8Hu+qvyfX5s/wlek
	 XUie3c1bunqs885GpazFp33YzZuPrIS9EnI/N9ol3mg7NLFatoOrO+bKffvvtm9aIKnLY
	 MhGd2I+n60fbTG42ktDb0uj47fdfqTKH/vldrsHSd534prxnhyPJvn4MGCgD0SkcTwg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790621691;
	bh=vBnbc4Qip6Uz7+hNFt3Du6VwcJ87rKRsbtZBIUen/c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E0hWFmfkJvUycU/XAv2d6NYurjX462M1iuFgKWgRGa9dc97zd5StUDL2oWeQyotqc
	 RemUs4f3yXXGWwYCjJznERbhD8YiUZzdPVY5uh5Lzd5v0B5dyFEBUXfKw+MCJ1n7Xw
	 Eoh+SjHjaLRmbc6jMtXnl1lRG/8zlyD08D4WrMEKo08Qyg+W7nw0M8PT3D2RFDfYvZ
	 8Mg/FkHGpETDAo1oshWnVQ2uZlw2Qd1GmE+jmh/PPaEkH324AAsRREoastwULklAuK
	 oSnklcV3qTS7r5jcrOAdyaojFstG0wedmtCYbORGCgF1lX6ujKaV/1djAMILTT3Edc
	 MZNoSVFTbxECQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5584440552;
	Mon, 28 Sep 2026 18:54:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 10ED872
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB0E480BB7
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:54:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dDl-5eH76_oZ for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 18:54:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3D04280AE3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790621688;
 b=MsW7aQ+nfqQoSloKKRGmS0oVRMKhggRNXbweaLAu5/Oy6057uVdvxJvFq9Lx2iphTx5l
 48+iy9jHx6gvbU5LTNliQ+8KQLuaerXiqNkx8oS1R5nVntMXic2AsuE/LZqiMjjAoPVub
 4MFqz6odyPTBQdn25JX0Ah5WA+DELwjoLiSMyOkm09MtWvZPDY4+FrryB+/LOASeJVNXR
 DAZ3gjc098m6JIYKhl7a3Yc9fpZmHxWkYFn+EAhwJjOi4QCNsgaEtbk0M9FRpeeZ2IuYa
 0YJFm8E1iMSHACMxHdBHrMo560hCHffpt7PXGOUQEOvxvVOOzCgGF4y8XYawuk7XjeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790621688;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=vBnbc4Qip6Uz7+hNFt3Du6VwcJ87rKRsbtZBIUen/c0=;
 b=Y8eMx2tlY6DEe9uvlsI329tzFBMNZ/c4smRUKMLUnTQcTDvI6IVwM0XndST+0E8VSkk1
 CICQmwz9Svr3lEMUU+f1+elt7uxLE4IDXQvXsY280YGAy7Ey3CBGZCj1kquyFIzeH124r
 FAEforJ5yE8K+PIJgvCRmN9q+WK3RhPv5Mgkwhd8i3M8s4/8FJfJrPJLB/ySnlw0AAVea
 AuOv20BOZTrrycz427wDxWZRCO+l03/D5XNxJwm24C66VJidu1Gcu1aoOPkxAKaoP9KHJ
 fcQBPwIBdXzkrxClEGnsvOqVy0r5mPNg5JJWEagm7Q+9k5wYJQZi7sFkpXeBaBaxJEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=CUoSFijO; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=CUoSFijO
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D04280AE3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:54:47 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4htr8N04Y4zKp6C;
 Mon, 28 Sep 2026 20:54:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790621684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vBnbc4Qip6Uz7+hNFt3Du6VwcJ87rKRsbtZBIUen/c0=;
 b=CUoSFijODlYJMrvXxT0lupqac4eQNTW0fwCMkWBe0agY3z3GKlXJZk3U6I1IHrl4ITeBDB
 /DpzlnkXFD93dSWn2QqvnV0A3in8qPyaSoP9btt4SXEO6zhas0F+6pxwGaxWf5TJoQEq3o
 es3MVMhX1TxzIIh9p9w50B88PGBlUWTrsP9ybca96tZly5wv6QEc5YmLzw1SYllTI98sAZ
 ZhK1IjVjfX8hvDZzybAtb13o9wVJ5Wm8gYFZpa8lQ+RBnVhwZ+e4hr4+qlJz+WfEQ2cpeC
 uiiYFp0sf1h1yKwC59OE6Db6ub8sG9wA8QEHJeCGPQmfloGnE8wHP4NvmOMrKA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] power: domain: renesas-r8a78000: Add SDK SCP 4.39 map
Date: Mon, 28 Sep 2026 20:54:31 +0200
Message-ID: <20260928185440.113788-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260928185440.113788-1-marek.vasut+renesas@mailbox.org>
References: <20260928185440.113788-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wee4xgjxp43tydt6jtncqc3hdpuudnsq
X-MBO-RS-ID: 5dbb5e2c29aaa7dcfe9
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

The SCMI IDs did not change between SDK SCP 4.32 and SDK SCP 4.39.
Add SDK SCP 4.39 as supported version and reuse SDK SCP 4.32 remap
table.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/power/domain/renesas-r8a78000-power-domain.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/domain/renesas-r8a78000-power-domain.c b/drivers/power/domain/renesas-r8a78000-power-domain.c
index 9b3205345a1..fa22a37f77f 100644
--- a/drivers/power/domain/renesas-r8a78000-power-domain.c
+++ b/drivers/power/domain/renesas-r8a78000-power-domain.c
@@ -168,6 +168,7 @@ struct rst_map_in {
 #define GEN5_SCMI_SDK_4_32		0x010e0000
 #define GEN5_SCMI_SDK_4_36		0x01100000
 #define GEN5_SCMI_SDK_4_37		0x01120000
+#define GEN5_SCMI_SDK_4_39		0x01140000
 
 static const struct rst_map_in gen5_rst_map_dt_sdk_4_28[] = {
 	{ SCP_RESET_DOMAIN_ID_UFS0, 202 },
@@ -224,7 +225,8 @@ static int gen5_reset_of_xlate(struct reset_ctl *reset_ctl,
 	} else if (priv->basever == GEN5_SCMI_SDK_4_31 ||
 		   priv->basever == GEN5_SCMI_SDK_4_32 ||
 		   priv->basever == GEN5_SCMI_SDK_4_36 ||
-		   priv->basever == GEN5_SCMI_SDK_4_37) {
+		   priv->basever == GEN5_SCMI_SDK_4_37 ||
+		   priv->basever == GEN5_SCMI_SDK_4_39) {
 		map = gen5_rst_map_dt_sdk_4_31;
 		map_size = ARRAY_SIZE(gen5_rst_map_dt_sdk_4_31);
 	} else {
-- 
2.53.0

