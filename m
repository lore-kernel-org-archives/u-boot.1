Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19BCC5DF80
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 09:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97180810D6;
	Tue, 18 Aug 2026 09:00:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xRkxBdSZQEdl; Tue, 18 Aug 2026 09:00:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02F5B810C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787043649;
	bh=ADVlmkf2Xvu/vbH2HzX+SeJTIbolQxvnUwuoN2DUJwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kDhRY1GN7/mcvEWFAmEa0elvFmwWnyzVTNxPe8d4A3Ce51ih7ISHBR6ewwF78yMka
	 hkEu7nBz8MkHR/w0lxO8dr4q312z9xUciTL7XTeSTfVZdkMASq7qGkLvUjSCraM8Ge
	 oWchQ88h8BcMEpFUn/cr8SaaSeTP9CmODiL2KcuMyyU+kpHavze2oFZNbXZFWq/ZMk
	 gYXk6NSgYGUPkak0rJ8oIMM3J2NGZ3prFpJ9x+kYojvxaXzZJMnruoyDHKkse+D9YX
	 emfOwV+e1o3d8BPr2U4f85J3OL4au+1sS60x89MZGB7K5OIhwPKLHP+dC7GQ19rZts
	 apppq1pmx4uPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02F5B810C7;
	Tue, 18 Aug 2026 09:00:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F112333
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 405AD40738
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J9Nf2f5GqQXV for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 09:00:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E98D3407A2
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E98D3407A2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jv85bfmX
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E98D3407A2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BF934023A;
 Tue, 18 Aug 2026 09:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BEB1F00A3E;
 Tue, 18 Aug 2026 09:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787043642;
 bh=ADVlmkf2Xvu/vbH2HzX+SeJTIbolQxvnUwuoN2DUJwc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jv85bfmXaSlybXhFaCLS/ZEkXeukfIG5AOy9MLp3Shgyhr48dR4zt3caO6OwphlZQ
 pIXEl5fvfCF0aqUkpijPK+YmXxZdssZPcgZd4VnAyGjKm1Kv+bsCx1/L+ls2OduBcd
 sVOr98bqFqBX8HCnCb2mt0pF5GrrNpd5+J5+yBNm5WQQp1pUC1YvXbVr2Pz4y649ks
 DeHTcxJgkn8sZrd3CVmDuRfj83jZO+l3EbuTYgdLzpp3oBGrCKKAgKRmhkuJd957PD
 tU8Sls5Nr+kyA0TFnbLjncSgwuDWl2mONfdfUJkDTy9PN000w1ofv4KIOnUvb8k7VN
 KZIkbgMc9eUpg==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 18 Aug 2026 11:00:31 +0200
Subject: [PATCH v3 07/11] arm: u8500: Enable SD card regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-ux500-external-sdcard-v3-7-a5d94930f3bb@kernel.org>
References: <20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org>
In-Reply-To: <20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

Have ARCH_U8500 imply the fixed regulator driver needed by level
shifters on the supported boards. The architecture already enables the
regulator core and Nomadik GPIO driver.

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 62aa9e8cc565..2a01ac9b7675 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1276,6 +1276,7 @@ config ARCH_U8500
 	imply CLK
 	imply DM_PMIC
 	imply DM_REGULATOR
+	imply DM_REGULATOR_FIXED
 	imply DM_RTC
 	imply NOMADIK_GPIO
 	imply NOMADIK_MTU_TIMER

-- 
2.55.0

