Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737ACC47DDF
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 08:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D048587C4C;
	Thu,  1 Feb 2024 09:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ict42.de header.i=@ict42.de header.b="MGgWeQxS";
	dkim=permerror (0-bit key) header.d=ict42.de header.i=@ict42.de header.b="vBZs4unO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9759D87C4D; Thu,  1 Feb 2024 09:45:56 +0100 (CET)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE4B887C34
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 09:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ludwig.kormann@ict42.de
ARC-Seal: i=1; a=rsa-sha256; t=1706777154; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=JDLSUmHxYL24qhzdHe+EX54KpMZtiVGqcjyvL/vh4hqtBHfzBts/AzljSD7WEa1Ou+
 WMAFp7khwOLIFcX9Z4t+EpXOEKywveL+U+aQnYkK631ZMztL8h4knnOdEJ1tXbqMcci4
 pnjr9rh3tQmBnbevgLV4G7Xg5x1kg42D6+SQqUmXoSDT/p9a3B89uRYVthqGf+ObQHFv
 wdWPPi70X9HVmXOwon6+AOswJq/eDVf0EdrtCvvllbrcyDjrNV6kfoXhygELXmTXYLvk
 rSnf7hYFRgiq6P/2AUF/GR6N9wg4LZd63LicNCna6vyPMx8seeLY8IpaRIB49GkllpC/
 xKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1706777154;
 s=strato-dkim-0002; d=strato.com;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=JmNFLNjenaX5fRlOCX4e9HAM0NYAsrBJiyk3ByqYh8M=;
 b=Pa2I92P67wO44of3JXfTh+mawocbmTPbHYeBTKjmQIR+2WAns2sjt5M0dWrhPYlEd5
 NBPClf+1IWKDx7SQdFXhrFgH8fKJgYQbY1LlDJNiA6yr2E1mrTzSX4I2SIvftA0dZpYP
 xSbPiFERr6iqYjcFOurLLSpga8yct2464MGwofR/CSsFPt4ylgpj7oxBgKMxWmyTnEX9
 voaFLK2aiEEjhEjWWITh0MGMFSFmKtQUN0XhuwiOYwNwEF4YGIsxQelpQ7nF0yXhqsHu
 8Gf1i76pTHFXAFV6CrBWnFoZX8m0c6lyghUmvOZ9o5AGk73qMaTOoPOI8famcbRDhkFc
 0ilA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1706777154;
 s=strato-dkim-0002; d=ict42.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=JmNFLNjenaX5fRlOCX4e9HAM0NYAsrBJiyk3ByqYh8M=;
 b=MGgWeQxSmYBbKfec5ZeClB+tmQ7RCy/gcOGZNAaEFz8kysRj2rTClBb0Ykcaz0P9HD
 LyyxfKcfC+C5RfTDLc/u6wCzj7hKvFrCRSeqYd82Ku5yoiUSIhEW1u1xxhSp0uktltJm
 vl7MwMN5A1L8lEHWxhpJYjTrKgJst/j5ZqfhlMzBPmKqZKJrNULDgisD8QgpMt1PU0H9
 S+Ruu4wYAI6bU0VxQlJ/MyNSDUSwbzP+E+8875Izi1CXWcCwwg2VubS7tgxcKeoZ2cMI
 fbXUsbeTbSCNRcvkOQlB2h7TVdrd+JQ/PgPQ/fXIT/NiEWBQ0czSicEYRdqQrehJNBlC
 eJyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1706777154;
 s=strato-dkim-0003; d=ict42.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=JmNFLNjenaX5fRlOCX4e9HAM0NYAsrBJiyk3ByqYh8M=;
 b=vBZs4unOcmDizHaHUxjrmBnNBsFe97p98Fpm7yHBGjqQJXkOFPwoL8DaREM0q7nBmb
 feGi7fWYvnzo68Q1HcCA==
X-RZG-AUTH: ":IHkAYkmvNfSwjg/qSc4u8zZOVaURsoXe3UH2mQA0KglxDI1B7BeEcdPLARTmodKwkQi99jFCdZ0="
Received: from debian-test.local.in-circuit.de
 by smtp.strato.de (RZmta 49.11.2 DYNA|AUTH)
 with ESMTPSA id x7ec2e0118jsRNQ
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 1 Feb 2024 09:45:54 +0100 (CET)
From: Ludwig Kormann <ludwig.kormann@ict42.de>
To: jagan@amarulasolutions.com,
	andre.przywara@arm.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH 1/1] sunxi: sun4i: add missing sdelay() to clock_init_safe()
Date: Thu,  1 Feb 2024 09:45:50 +0100
Message-Id: <20240201084550.200913-1-ludwig.kormann@ict42.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This delay is required after switching the clock source.

See “A20 Reference manual v1.4” Page 50 / section
“1.5.4.16. CPU/AHB/APB0 CLOCK RATIO”: “If the clock
source is changed, at most to wait for 8 present running
clock cycles.”

This is already implemented in clock_set_pll1(), but was
still missing in clock_init_safe().

Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>
---
 arch/arm/mach-sunxi/clock_sun4i.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-sunxi/clock_sun4i.c b/arch/arm/mach-sunxi/clock_sun4i.c
index 8f1d1b65f0..ac3b7a801f 100644
--- a/arch/arm/mach-sunxi/clock_sun4i.c
+++ b/arch/arm/mach-sunxi/clock_sun4i.c
@@ -25,6 +25,7 @@ void clock_init_safe(void)
 	       APB0_DIV_1 << APB0_DIV_SHIFT |
 	       CPU_CLK_SRC_OSC24M << CPU_CLK_SRC_SHIFT,
 	       &ccm->cpu_ahb_apb0_cfg);
+	sdelay(20);
 	writel(PLL1_CFG_DEFAULT, &ccm->pll1_cfg);
 	sdelay(200);
 	writel(AXI_DIV_1 << AXI_DIV_SHIFT |
@@ -32,6 +33,7 @@ void clock_init_safe(void)
 	       APB0_DIV_1 << APB0_DIV_SHIFT |
 	       CPU_CLK_SRC_PLL1 << CPU_CLK_SRC_SHIFT,
 	       &ccm->cpu_ahb_apb0_cfg);
+	sdelay(20);
 #ifdef CONFIG_MACH_SUN7I
 	setbits_le32(&ccm->ahb_gate0, 0x1 << AHB_GATE_OFFSET_DMA);
 #endif
-- 
2.39.2

