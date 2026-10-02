Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAADCA5FE2
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81BF7404C0;
	Fri,  2 Oct 2026 16:47:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QUd1HqVrlmKN; Fri,  2 Oct 2026 16:47:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CB05140A18
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959655;
	b=ESlg7ipMaFZ6+9bmuXhovHq92Ok6DhzNNVdHjMzA6/6gmyed+3osc8qJtkqBkgRCYxl2
	 xLpndcTlmOiE0Lg4dO6ZCVMuQDrd33s92G+M+OYqAN6HbVkMkqgL77QRjpFXnZQnYSzTf
	 rYDELZjTv8HURJlK8M5Xdo4LtHdWRuA2lSLO5sL1HmsOoLFguj7AoMWpxCPm1hfs0en5N
	 OkoyMsLyvbxEH7Q8Xd98+S+jPdtopqhnpotM+ouW84nJfEhRmUXmv6atwjBqX8DgiHiK7
	 AoCxN6if/lKAJ8KtyyXHK5yNLZA2z06noHLNsjOVGLdATZgcbsDREear6w7XyWi2KrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959655;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UFNXiNq55ZqG5GfmYVAcbN6nrME2ZEndiYfFq5nEZxQ=;
	b=IQJBt0t2tyIceQBWjLS/Qzrx3qOtiHTn/adjjtAcaje029VL+6Nxl+oveZxHd8UxVBUZ
	 m/CZPKWkAMvHzdSoDv8dT+i3ov4QhEo6NuIXhKN8Hw9PJ+YerTAKKlFlX2+jsQcUtPaTh
	 S3rEgYt2bpTGgXd6b0gnRggEvAmeA9jaVm8b9II22e20TCfhSSJqz7qDy5u9Zt96YoTlG
	 EwPVt4lbj1h8fN9X+gUI84bBa5lJVkirXbtSc6c0ZL5LBtVwKW1y9WoexX2nThBttFhiF
	 2IQuG2E6x/Brhu/wGuXhY3sv4pP7xFaEJtgVdpuQQZ52Za6E1zJUIqxpg8K2f3LO+Wg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=m3GgS3Db;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959654;
	bh=UFNXiNq55ZqG5GfmYVAcbN6nrME2ZEndiYfFq5nEZxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zA3637k6NOv0R0FqYiIwVS8hYwgoZpETblO7uu6w83yWpqtodSmEQIzv//A/KCFm2
	 C2K5v0Xofs3ztQnvbziiuT9w9bQ8XOJRQ4lXb8lt2VY+6U5T8wNzngX9DvSCGGQx2P
	 VR3EaBVmakIOdz37Rg7Pq37NMxe/bweMU+hSmmoLzaVtIvqQkevMFPCvU8isGSN4qf
	 0852oLRmjDl5diBD4Eh27ahOXNOUTkAHqbDWzVW2DDgOkLK676A/Ecbq83Q63CZtPU
	 lvQSG47PEwzufkqDk6zOzZscPdIYv8Uo5X6qFI5HLwqTUKsLraijpC2o78LA7+x4mT
	 1NWxlmRBd0jnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB05140A18;
	Fri,  2 Oct 2026 16:47:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BCFC282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5943C40D93
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gbMB5fOqACp3 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:14:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 04EC640866
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946861;
 b=A07jpvwtYDzC5NBW/EJzdds02mpxZVtSdTvRorZ/TqNog7q9kVxU/RPtWi36E06dcrsP
 nGBNMGFMPwZQKI+pUCOG5ciN/1mmj/VEujXj4bYlWtcufp84XtuvXC2spI4l+QIfNlAcE
 9QpCJhY6XO82RiUxuYMKOgw/2qdYLt3ckaWpU+ohH4oI+JeemNoiVWr9zWWG4ukeYoVu7
 TM/dFrJZBDjZORF+LXSBOlvmZHd+3FMOUYfJbFZRId8Op0iSdzYN8u4aOzSwutD/90A0P
 8kVKkehpX5/ZiRjUL6a5vgqLRxhHwtHVFpkqqSJFNHnF60uNPgv2cNvchgXwvKA9M5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946861;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=UFNXiNq55ZqG5GfmYVAcbN6nrME2ZEndiYfFq5nEZxQ=;
 b=RTeGdIiElmY3+EiVPuwCXGDXoGQCyojFpA3oIcMdJrZ9KzS4TredP8pWNNK5LzQdIH7Y
 sftOH0/rRS5YDb96xN607QSxFSme6JB1jP2VPan6faUKKJTd5AcysY2xw1q7dlZcDsBhk
 fc4oI8Q6FEa8dFrs49aXjstk4Aatprbolsp8WpJjNsDO9b+SR/6YSXA22Dr4pt1vbpM0f
 4Ltozi9csMTQs8x6jfV6bRLpqPjdSr/OGS15Ka8pbmGglTwBERH8J3w8NEbXDIBUhlAiB
 br0Mk5CtEoXzcHZ8qhvZjXUcQbztx8vu4uUe/pW/+SonIaaqpjcQnZB/xjnJJe/G1iQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=m3GgS3Db; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=m3GgS3Db
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04EC640866
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 96DC01A10E3;
 Fri,  2 Oct 2026 13:14:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 68CBE603DC;
 Fri,  2 Oct 2026 13:14:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6881010328212; 
 Fri,  2 Oct 2026 15:14:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790946852; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=UFNXiNq55ZqG5GfmYVAcbN6nrME2ZEndiYfFq5nEZxQ=;
 b=m3GgS3DbMklfNHqpHGU1sgMAVEEmGvUbwAIQCtxCQaNxuLwHLP6P7KVNN/RtB8asRbEaWE
 672lTkws+xHEsp896+cz5UKvkmoKYmJ5A6IwR4oWdnYnwVnR3O3QJxnWDbpo8E0chJiWll
 pjvDRz3zzOsSNS7GMPMA6FrtTbD1OnMod6YyaI8yJhc4VOJ6XegGELDaNgMHX6xmEYxQZq
 pzqv5ReVF1p8/+yzrUmGwcZ2jjbd7RKiY9ful3TM0cYSU1bIKCeeAgurRyc2hoQ2aESWnX
 4PwN4B6gePzpHtk8kcNc9xcy+dZslfJyAsWJCnCTvQGCc9L5EpJ7h4BGbg+GJQ==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 02 Oct 2026 15:02:23 +0200
Subject: [PATCH 05/10] riscv: andes: Add Kconfig option for Andes erratum
 #35102
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-mt2824-v1-5-bc44cf0e0289@bootlin.com>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
In-Reply-To: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Chris Packham <judge.packham@gmail.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?=
 <randolph@andestech.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 02 Oct 2026 16:47:21 +0000
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

From: Jun Chang <jun.chang@metanoia-comm.com>

Add the ANDES_ERRATA_35102 config option to control the workaround for
Andes CPU erratum #35102. When enabled, non-blocking load is disabled in
the MMISC_CTL register during harts_early_init() to prevent potential
data corruption.

Signed-off-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 arch/riscv/cpu/andes/Kconfig | 3 +++
 arch/riscv/cpu/andes/cpu.c   | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/cpu/andes/Kconfig b/arch/riscv/cpu/andes/Kconfig
index 120fec5e540..a2e68b6ad9c 100644
--- a/arch/riscv/cpu/andes/Kconfig
+++ b/arch/riscv/cpu/andes/Kconfig
@@ -15,3 +15,6 @@ config RISCV_ANDES
 	help
 	  Run U-Boot on AndeStar V5 platforms and use some specific features
 	  which are provided by Andes Technology AndeStar V5 families.
+
+config ANDES_ERRATA_35102
+	bool
diff --git a/arch/riscv/cpu/andes/cpu.c b/arch/riscv/cpu/andes/cpu.c
index d25ecba0e88..44704a2359e 100644
--- a/arch/riscv/cpu/andes/cpu.c
+++ b/arch/riscv/cpu/andes/cpu.c
@@ -57,7 +57,12 @@ void harts_early_init(void)
 			}
 		}
 
-		mmisc_ctl_val |= MMISC_CTL_NON_BLOCKING_EN;
+		if (IS_ENABLED(CONFIG_ANDES_ERRATA_35102)) {
+			/* Errata #35102: Disable non-blocking load */
+			mmisc_ctl_val &= ~MMISC_CTL_NON_BLOCKING_EN;
+		} else {
+			mmisc_ctl_val |= MMISC_CTL_NON_BLOCKING_EN;
+		}
 
 		csr_write(CSR_MMISC_CTL, mmisc_ctl_val);
 	}

-- 
2.55.0

