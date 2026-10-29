Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49B606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cCVoOlzl;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=DAauNunF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A0C740884;
	Thu, 29 Oct 2026 00:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QochvZQlPC-K; Thu, 29 Oct 2026 00:17:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC52F40856
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793233026;
	b=TqGDTkTIJJtZ6ZPJIke8S7pG5lG1oO8wjRgPrfLpeZ9kyWH+dEjBBMpK+3hGPPDkwHSU
	 k4ESGv7VexFoO92KOQbWLVd39q8l1cq5UpCxsyPbaIypxggXfvomSSBY8g0oZi/BOpJjo
	 duXnvueEtwbKyr2Z6GPC0NtxcFWluKRgBGcUARc7lGxq6Kgg1Q2wsrVZmd6qbGNagDFdj
	 5NBiyK+XmSiySGj8r0/Z2E3NaiD+E6QmvsFems/c/bPFelj+qdXCiejQe3fhaHvcHrIpF
	 k012pjN4sFbxKGeiWYXnXhnt21npZZMWERIw/3HVhYTnGiq/hmX0Z8KAOJMuxMp0Z3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793233026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2MLfQzhsk2JLkWAKtlQyBx8ZVWfAHVM8ooT4rvldNcA=;
	b=V3zSYW/9DgQ7LMX7J+fvOLf32O1r+oCiYOmQkOn4mFKTVtaJ/ty5WjCQqCtGY/W8fsya
	 dT4PoggdHZwaWo25pnNw955+kQWNJLtVci5fUel9+mhRSpTRabhltuIYYvpTFPiHrp6Jk
	 2KqOEYobfL7xHs6m7qp16jNICHZJc5PyAJvLM3VL6Nmka7wL6CiQed2pQO/pD9EffP+PN
	 cQ6H3MrBnFo6gRuBhw/kzenD7PBgrkgY9qncoeSdr3W3WqhyUcIqAMYo0Y9W7535kgFqJ
	 lksZpPuJK1ELCZtdP/ddBNJmIvJQeZKIdmhF13Ty4oVih0EekE+APyM7fzloQdnx/2g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=DAauNunF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793233026;
	bh=2MLfQzhsk2JLkWAKtlQyBx8ZVWfAHVM8ooT4rvldNcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cCVoOlzleIFP/tDkHrJAaWF76qfZluBCqwN77zflgfcmNQq287VSfd7oJsLIdAKEJ
	 LQjVO5hr9qFBxy46R3wvbqQKD2dZFsfkAcEim2ErSeYISYwbXS++fo3KsjNKEZ4u43
	 eVV3GsJXOZMWfitGXiGc/S5GL4+mI9YXBiyemFhlXZtoMfSe8Ec/g2zAJAkVZiLdCX
	 Tj9w5gcaaIIwyG7sD9fqODFusvl0T+Pd1E6GZZhLse7inI8cIgfTh6CWOd54KB+GYJ
	 nJymIFLDdhhgr8crmgX09hZEKy0Zxeqv1oBms6tVKrqBr79tMupdq9u/2lwNy0kEVp
	 ISQF9oTn6bY8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC52F40856;
	Thu, 29 Oct 2026 00:17:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F833356
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E82FA404E7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UkXCj6Rqz6mj for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 00:17:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 340EC40852
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793233024;
 b=cDV6wbRidi1idUym7DXkDSDRP0HPJ0xEiZBauF6TWPFBiQAQTOKoajXf6qr8MF3H3xOY
 jXV7EJ4RmV1X8b3JAP31PQJm8d0kxd2kqLAfBP8sIxQAy4spWgIaVTKJcx9qe0ZjGJ84e
 VfFLjvJAk6LLkm/F8uKsDDfLB39xqOPRZNzFFB6jWgyhpj0zWYtfDxc9016tUiNtu8pQE
 7O+HGTavyjmfxWZOtzuE0cl1vSoH7txkBwfC3RdgCu6+5BAlMPQJwF9Fzm6XfwTmosbeq
 GQmYo6Vg7dIY1iiWuOdFQrboG74cHF+XIWzx3boirvImq6CzcXdvKbE3sIwJqrepmTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793233024;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=2MLfQzhsk2JLkWAKtlQyBx8ZVWfAHVM8ooT4rvldNcA=;
 b=sxPIBYiNHCIg0Yi0lmkFxa1YsciqAYa3mGVzL36O0bYPP9RPRckdQl8ZrlHMEO60rVrk
 380JVAnEeyxnOHTkvHT5xC/B2Itl//vg++Vff5VcBSu04qMWezvJj/xjMQIvqCIspOrLo
 ZledvqloyuiFmZ0A/VvlFK1C9Bm7k2AAbkwZTIWOgn7/VELCeLoqv/ruYOFHVVI7HLo0N
 7vsaxca7CZQs835MIcOhalSkiegOioKPuU4x4II6Kor47qh3lqqvfQOEgpf1FvkPHqzwz
 /G6T+L2l/jGI+VEzEfGLk80Aa2l2BddAgupb/2qK3EXDs3TV7Tk0tGUBz+NIhc4lOAA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=DAauNunF; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=DAauNunF
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 340EC40852
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793233011;
 bh=2MLfQzhsk2JLkWAKtlQyBx8ZVWfAHVM8ooT4rvldNcA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DAauNunFYGPVg3mSZ9vaygOCdqrikx7wiOcvvE4U4p8j5k+RDwfK5ssk8eNFYnHoQ
 WS3RS3WGuj+wSiYjxGZLIEcSp544ybd7QiSP1lFUUU/8fVzxUlm8Tl8Y/tLTTwOpsY
 Vc3NMQAcwsYs1Fz1cf6jc2ryDJg09j7GrTMjgmB5v3Psfjm7oTf/hoj50zc2tKYtDD
 th8UV65J3/5pNeM/TV+R7ifQxYJVG0Iq2Ajv9kbrWLwv02jN1g/6rX6I4ufnb8vUNm
 nUbB2tzeISwm521zKoX5MA9K28qY4mAgWecqh2WjqH2rJ7wmH6G0VIgs3rULWkKjfi
 pQFYDDRoyQNZg==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id C9AF0B2208AB;
 Thu, 29 Oct 2026 01:16:50 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org
Cc: E Shattow <e@freeshell.de>
Subject: [DNM PATCH v1 4/7] reduced SpacemiT K3 vendor BSP: force UART boot
 when YMODEM_SUPPORT enabled
Date: Wed, 28 Oct 2026 17:15:52 -0700
Message-ID: <20261029001555.1890775-5-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029001555.1890775-1-e@freeshell.de>
References: <20261029001555.1890775-1-e@freeshell.de>
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do Not Merge

Informational purpose only, to aid mainline development of SpacemiT K3
support.
---
 board/spacemit/k3/spl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/spacemit/k3/spl.c b/board/spacemit/k3/spl.c
index 522f3977c485..8f640f1affcb 100644
--- a/board/spacemit/k3/spl.c
+++ b/board/spacemit/k3/spl.c
@@ -867,8 +867,13 @@ void board_boot_order(u32* spl_boot_list)
 	u32 boot_mode = get_boot_mode();
 	pr_debug("boot_mode:0x%x\n", boot_mode);
 	if (boot_mode == BOOT_MODE_USB) {
+#if CONFIG_IS_ENABLED(YMODEM_SUPPORT)
+		spl_boot_list[0] = BOOT_DEVICE_UART;
+		spl_boot_list[1] = BOOT_DEVICE_RAM;
+#else
 		update_usb_serial_number();
 		spl_boot_list[0] = BOOT_DEVICE_BOARD;
+#endif /* CONFIG_IS_ENABLED(YMODEM_SUPPORT) */
 	} else {
 		switch (boot_mode) {
 		case BOOT_MODE_SD:
@@ -883,6 +888,9 @@ void board_boot_order(u32* spl_boot_list)
 		case BOOT_MODE_NOR:
 			spl_boot_list[0] = BOOT_DEVICE_NOR;
 			break;
+		case BOOT_MODE_UART:
+			spl_boot_list[0] = BOOT_DEVICE_UART;
+			break;
 		case BOOT_MODE_UFS:
 			spl_boot_list[0] = BOOT_DEVICE_UFS;
 			break;
-- 
2.53.0

