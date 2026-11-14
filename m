Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36826606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DlXIEsjt;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmjTtF/i
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1387E60E1A;
	Sat, 14 Nov 2026 04:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IdyryRdxgRMN; Sat, 14 Nov 2026 04:05:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 53BBA60E24
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794629117;
	b=KqwKIYNpEY57aA3uNn+D/D3CQopDNTo1oHVrR7shXZXnNtREsXOKqzc2M7WhEJ7Plsp4
	 d6M7UEQAQYq+6UaYJJhRb9aV52Hd5DKQTGVyJ4Mj6t5CwAHo2dGvI1+IFkkrY/rPTdwdt
	 +n/GxkN26NxTX0X8QlDhYAvj4oQuRJOFLzHPJ7ddTETSwLu5RXYJweHwWcSeRTVJhNM9g
	 WGv11GK7hmI5E0tUaGFwBCt0GUURI611EmDbtM145QyFLsoPd07vB7EdYf7L9HWHktso+
	 b/t3WHSo5Nu2i+vTFNuoSu3VdUtrtHz2C+czVs0SjkhvR/WodSV+xHDd3AicXci0m6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ZV61+Lat7BXSqsFRQS5zZopzfSAir+LFZnlWbGcnPts=;
	b=q32x4r707ai/cxaLI+wzqYuwiuY06jdeh9fcS8ezGqjWtcEyuwRHGSVXukEo6YTTjM/s
	 KYKBNNF+l9knacefQDVRsJBcOKzuCMTLcBPchOui+xJOzfOpOr0fPznnHTtmjbjKjxO6K
	 4D8NVOufYww3avHocEXHzEj+pP95ZPEmTlxVxT3a5JrG7kbXohAkprmfG6WGqpqdoJxOk
	 GOLpUbC+RJtnaass32qht6sDGNW23a0gJnjEB7qV6k2K1Ms8iJZpllWnevqpIw5gswxbE
	 PCZtq4Rc3BSWr+YKkkJGKMuvcMhcTI0yCibV0RN8ZUVEnXq3AfQCOtZaEHp15V3LjEg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794629117;
	bh=ZV61+Lat7BXSqsFRQS5zZopzfSAir+LFZnlWbGcnPts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DlXIEsjt6pAYuy8E3jL50YcujrH9eGZQDtdG2OUjwSqEDZoiW4U18hN2wzvADNEVP
	 D11d0vNneJxf+XvpRuAvkahNWG9YB2FCe0ElJsxM/EdY/6bRVzG9EAeZYS1KBeL7eP
	 ies00rx/L+CQKMUgnVBtHzkU8Rfk6NaXnpZIVvNRYWaxGIgV++hwcFYxQS6YzWtCSL
	 REFaMHDIkGnpeFopLMG4WAOQaIJ187J/O/uphc9wOgp0uVqHYCCwMw36NXqKHPYnnb
	 73poPImabkyXj4zGRErJJVpPQhnhTnphqkKM+bqLbT3IfZkRp05L1t9YeZidUQDQpZ
	 086AJrSS18stA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53BBA60E24;
	Sat, 14 Nov 2026 04:05:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 832942FE
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 746CB81779
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vP8EdzCkLKMF for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 02:22:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B0ED081774
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+me.fromdisposition.org@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=FmjTtF/i
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0ED081774
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 02:22:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A739C61EAF;
 Sat, 14 Nov 2026 02:22:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 246B41F000C8;
 Sat, 14 Nov 2026 02:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794622936;
 bh=ZV61+Lat7BXSqsFRQS5zZopzfSAir+LFZnlWbGcnPts=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=FmjTtF/iatqv8U6/WZEph/1zFj7I05GpVGhzImkljzSrzmPD0tjFl/p6Bw61Ou16H
 R3m0RHUZ9CRWUZanqqDFfhXEFR3utm0pS7ctm1SYRhkebos6ulBrAnBJFZd7k/8j+B
 AkFVZfX4N9Teq4IUhMRD6eKLI8csUSJ66i6BMZPXxjdXDE0Wkg69CAjneq9pvV97Q+
 2MLwIS++Vz0x4M1R89nCHN3pLdSY7YmKeffZbx3jSQN5v0DA2okbsHZl9T4tq78H43
 gxaiwAIk5AvEQQH6ZG5KyzeVT91FVitMsgk/ywsgxkdIQsFPKJ8YGm/dBOn6n3b3x2
 /41mOzzIhRuXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A3D7249C2F;
 Sat, 14 Nov 2026 02:22:14 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Date: Sat, 14 Nov 2026 02:21:58 +0000
Subject: [PATCH 4/9] clk: qcom: sm8350: enable shared RPMH clock driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-sm8350-support-v1-4-414271f59474@fromdisposition.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794622936; l=1465;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=j7bDsytLsG45Z1AQET6GAc/Xk0WNVLXBc1WOuCBRuNc=;
 b=EOKX1irs+kWy6w7hroMigxdti+FhiV0l/N96p//f9e2FyQBH23IR4ehhPqw9g4LMtixYQoUcA
 K+thMSSmGQcBmthDeiGWQglZcTduRacb+mCLB+hYrhTYZSpWV4qmKhs
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

SM8350's RPMH_CXO_CLK is bi_tcxo_div2 as well. Register the
"qcom,sm8350-rpmh-clk" compatible in the shared driver and have
CLK_QCOM_SM8350 select CLK_QCOM_RPMH.

Signed-off-by: Demeter Barna <me@fromdisposition.org>
---
 drivers/clk/qcom/Kconfig      | 1 +
 drivers/clk/qcom/clock-rpmh.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index e18d7c1c58..ba27d4ba63 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -163,6 +163,7 @@ config CLK_QCOM_SM8250
 config CLK_QCOM_SM8350
 	bool "Qualcomm SM8350 GCC"
 	select CLK_QCOM
+	select CLK_QCOM_RPMH
 	help
 	  Say Y here to enable support for the Global Clock Controller
 	  on the Snapdragon SM8350 SoC. This driver supports the clocks
diff --git a/drivers/clk/qcom/clock-rpmh.c b/drivers/clk/qcom/clock-rpmh.c
index 5d01b482fc..0154ad930d 100644
--- a/drivers/clk/qcom/clock-rpmh.c
+++ b/drivers/clk/qcom/clock-rpmh.c
@@ -48,6 +48,7 @@ static struct clk_ops qcom_rpmh_clk_ops = {
 static const struct udevice_id qcom_rpmh_clk_ids[] = {
 	{ .compatible = "qcom,sa8775p-rpmh-clk", .data = TCXO_DIV2_RATE },
 	{ .compatible = "qcom,sc7280-rpmh-clk", .data = TCXO_DIV2_RATE },
+	{ .compatible = "qcom,sm8350-rpmh-clk", .data = TCXO_DIV2_RATE },
 	{ .compatible = "qcom,sm8550-rpmh-clk", .data = TCXO_DIV2_RATE },
 	{ .compatible = "qcom,sm8650-rpmh-clk", .data = TCXO_DIV2_RATE },
 	{ }

-- 
2.53.0


