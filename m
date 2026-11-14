Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83618606A32D
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D8/gVe2w;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JgiSzmwt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E03481B0A;
	Sat, 14 Nov 2026 04:05:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OLvxfGyWKj7M; Sat, 14 Nov 2026 04:05:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 839D381B8A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794629120;
	b=O+tD1fqgDJTdDJ3BUUJ1takKmCBpaVoI6adRjGxj12Xol3dDVc1kNepWIhsASis+VjHm
	 eblYijcKW5414e9qQMKzmNDoGcvixSpgCYgbhbx9KgoP1LOnycOEJD6kZF28xxR/NGdUT
	 m0B9r4z3ivLAkpnAmGDnBb0HRp8/mHFusVfCCBt2S3GnJ21fs0UXC162/6YvNYF0uqBb4
	 DTE8I/2acAQocgdCOxFD5bJ6bRjL2SsN0qmmZ3cszXRYY+KFgMD5GFmIpK/O5Jg/v+r8I
	 Cai1TjrRNK+8hgNQaV/WTn9LgJh+1TkNxerhsdb/UFfyM0V8GxOuLC0XQGv0Mca8YIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629120;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=czSsKqPdNSvu8yAnNG7xa1lCKRu5Opf+WbI4YY+ccH0=;
	b=HOKK+qKzXgtjCYtQQQ68udfTXgxaesrWxVYEtvnkek9uvoY1m41fUNan6GObggaz3FjP
	 5cl1JBhGrv0OHSjFIEQhn9KTp76hf6jftJzH5C+gvPoYBmSzsQIVUo1llyAe3gZ1PPQ1x
	 zhB4npwGEsvVZn2M5Y9wNwgQqdJxOdqiWPvAfYa6wEYd+Drt5km8o4ADfGQuZ9wHdmmQy
	 ubGscxaZ2uDAnhDmNKT0xYL6jl9AM//QpDGS0sEnam0cRjEYtn6tMhgxwWv8OM1w2B65F
	 68L2mRwLziNUriSByXsb01BhJqZ7t89NR3NLJ93nWHVZaNtAy4/6nwT1piiAPo2soqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794629120;
	bh=czSsKqPdNSvu8yAnNG7xa1lCKRu5Opf+WbI4YY+ccH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=D8/gVe2wg6drnVbwhbb6cS8eNI2wEMN7XV7jT0NRouwsKd+legvjTkl1oGXjm+3a2
	 t6sF8RV4Ljc2WZhAOsHWHjIYdnL1y5D086ZyZbCp738+qFXUscOVgXX+YEt/riWsNp
	 ArDqP166tDj4fhBc0e+IT3WiGrq2QJ10NFiRdGS04itrH4nNaQkjjO6FAvZv2HwC0E
	 dmgNsdtq5d+Sdf77jMIYXBWcDn3dsw5jBe24lleXA8mFA4kKAXdD4vTGAaR6xI0ver
	 y2ixSEsg4cjSAIE9IaLFqQDMUKQgvXh8ii5ivfhrCEKZJTiVH9wYmfM+nmTS8MejOJ
	 YeMrjClF4o9tA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 839D381B8A;
	Sat, 14 Nov 2026 04:05:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E52C81E7
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D77A34025F
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pr_gWQj8QNjy for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1D956400B1
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+me.fromdisposition.org@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=JgiSzmwt
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D956400B1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 865E461EEB;
 Sat, 14 Nov 2026 02:22:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 3B7F11F000C9;
 Sat, 14 Nov 2026 02:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794622937;
 bh=czSsKqPdNSvu8yAnNG7xa1lCKRu5Opf+WbI4YY+ccH0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=JgiSzmwtfDjcb2WjEXrkpkHGe2QN6k+zBobnewUfyaHXtQtJJDZ6ldxcb5DhT0FsK
 dL8fqFX06SgTsUMiZLidBYThpvplFX8G+wXQo5NJ8EJ4C/j5CBXeQKMukAi3R4ykgW
 pk1BfKg+8tbWRqL4pUonXgRcp6e9cVMwuSEw+bFFueGAOITPRb0eSN7p0kWfBKytWP
 Zkf8GB6RYnEbEB5Y5SjHnPGuqXyMzNi/IGuPfndt+M4bOhjevpWw3LUIeIg9ofuerQ
 QGQW8GN4llHI7H0Hc4M0d7RXH47Yvyxee7CsF6/FuOwo5eaGNOKVGni6ZGF2Zo+7FY
 yalAQxfcpkGrA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D1D1849C37;
 Sat, 14 Nov 2026 02:22:14 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Date: Sat, 14 Nov 2026 02:22:00 +0000
Subject: [PATCH 6/9] iommu: qcom-hyp-smmu: Add SM8350 compatible
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-sm8350-support-v1-6-414271f59474@fromdisposition.org>
References: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
In-Reply-To: <20261114-sm8350-support-v1-0-414271f59474@fromdisposition.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Erikas Bitovtas <xerikasxx@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Demeter Barna <me@fromdisposition.org>, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794622936; l=806;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=jt5v3+ugvdaP8Z/aaDMUW0xCt7He4rvF+Tbjb8GneYA=;
 b=nkHXPk1DxifdKSI23UJdNGwRyOHZobyOIh66H6Dtr14bOfhvBX6NXMg4MYE+l13CqI/WAsIYa
 qt2XTG2DvlsCnvGCNZc9t8PPYh/FeIO7+W8MvW2QdEgcemD03Cnd8S0
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 04:05:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: me@fromdisposition.org
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Demeter Barna <me@fromdisposition.org>

sm8350.dtsi describes the apps SMMU as "qcom,sm8350-smmu-500",
"arm,mmu-500", which nothing matches, so every device with iommus fails
to probe.

Signed-off-by: Demeter Barna <me@fromdisposition.org>
---
 drivers/iommu/qcom-hyp-smmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index 5b37c21f66..bafc34fcf1 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -392,6 +392,7 @@ static const struct udevice_id qcom_smmu500_ids[] = {
 	{ .compatible = "qcom,sc7280-smmu-500" },
 	{ .compatible = "qcom,sdm845-smmu-500" },
 	{ .compatible = "qcom,sm6350-smmu-500" },
+	{ .compatible = "qcom,sm8350-smmu-500" },
 	{ .compatible = "qcom,smmu-500", },
 	{ /* sentinel */ }
 };

-- 
2.53.0


