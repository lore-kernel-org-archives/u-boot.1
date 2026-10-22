Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758B606A31E
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JxZPJdIF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=neOu/LFN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BE9F4055A;
	Thu, 22 Oct 2026 17:20:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9T9MryWYbVbv; Thu, 22 Oct 2026 17:20:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AFEC840987
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792689611;
	b=Z4AnNN2toFQ9HqG6mowErPYCNLFCGEJ+KScS9c3Ep9pwv1SHFW/9I5tQMue/wyHRw1pS
	 u8qhiUexAw3q0AhRcV8oWJ6dVmiuh6k4N2fVo6zHLdxsdPu+qDCozQGY04Sfa8f7/5xbz
	 oealG9mhPXRVtRz+5xpdKZfH/z7WS5K2vZ0+JHRGoRzZtkLKgAqIbovYFrrwCSa8RXupF
	 8NDZFQOQQKQdUKlCAmVGWCByoZDfQXY9J55syJuPLciIaLw+dTeGUD5NdTY5XxGwNqWj3
	 JALexAi71remD/lmOjwqkrWkjJS79V8AqFYDsWsM1po8OLd35dCXakjpwuDD8G+uuqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792689611;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2Nny0Z60vaW/T6pcOA+4gNciJfIpyoEAhl5i12WOJFI=;
	b=lmPdt2Qa6omMbfyGruAoiFimOwRce2lSvw1DTU5AySFM+C7F8Jcwp3vkn/50a6Dkk5nl
	 eu8PB1KkMPMkvXokzq23vVl9+BUxlc9j6CvxWIbHRO0TbI0pPPm86GMzhjL1eAiUejXSj
	 lVAs70yNdFg95FOV8TGTN6RaCGzaN//uNxOhnyXJYslqRN/AsN2D0CAMY/gxiNis4ARzG
	 gEcqBUzUhG86IgerO1BlK87CkHt8NGJT0FdJ+wrgx3mWngt0d95EbJOccYVx83tLPPOST
	 KZN6nHGbNMMdFfHHaCPph/0JaNdpqovbg8nsQN4qUcVqP3OwvdJGBOCleG/sgc2KiqQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792689611;
	bh=2Nny0Z60vaW/T6pcOA+4gNciJfIpyoEAhl5i12WOJFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JxZPJdIFk9Pig0o2qfG8a9COV+aQBmxnUspsto78a1Gs0cu7CrxV0m/6b2DJ1Inxc
	 bC72xYVzIzLGORDq0Paoxo7wQy7wFWn5iwnzuNitDTjiOlYIsHg55YH3jasMC966ct
	 5zWJ2/fq4OpW2FdNwTJcDadK15Et6K0X+iIAVpVA0SX0x3nvpj/dmv7duok+S1/EdL
	 EejJ7ZPpCw5KpkLjcNK42FYdH7SgcK9R79ZibK7GR4Nwr1vxByvtI9LUfkvZG6pqwV
	 bpdnqnMFNTR4uJLvCXTmUKohEPIesADShMUiZBq8S7N89X13LYhD6DCF8/ZDDqj0Yj
	 5TnwH8wep+oVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFEC840987;
	Thu, 22 Oct 2026 17:20:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 21E6B3C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 17:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07D28811DA
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 17:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NhXRH_Zmrs3I for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:59:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 27B61811D8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792688399;
 b=iipTRmDLT0nmeqbDVBDtLUJgamQoVULuY3l9GpnCbTRbAGQGx8y+NXIbgwJ4CBGARW2F
 d0fkxhkK3XF5Ino7onskZ8RLk2m74RpttLq+qhXLrqeDwioaotMDZpXYMWmiW/Rn1iLoS
 5bFRjSzzqzUHtYqG6XtwOPiBYvHfeAI0elBarhIwAN0x3i/cxmRsfC0YSyloozCrdDo1b
 vhsZIYj0/xCKWFNCVinq05WfCKZFZv1Ys0vWE0S4SieCHyxEv0NY7KhvyMtwc9UXCgKP6
 gTMuU7SKxLjxC7pCRWDWvqiPFnYgR8F7oNooOygODyMT2/ptRRC+0QQ0RooUoLsZ5qQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792688399;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=2Nny0Z60vaW/T6pcOA+4gNciJfIpyoEAhl5i12WOJFI=;
 b=mgRtqrQKS5NdxUJmSRnK9pVlXIm94j9/YP152rcDstAj0dMekuwR0h8VxW5QxafGTG5K
 5kVIXecW8h5FBraTU33pgrkzU/+T8PrwZ19F20/0jkQhAcy9jz5NKOuxZ9m3psaGUtt50
 ExubtDC+cst73DWahO1Wrh7zWUWGvq3B25D7b5iYXa6ClgwxSnAGky9DIZiuq9hpgej7O
 +4v1Bb46m/L2WAJ+TXYWODZQk84lsZFz+oXdiz4Et4nM01bNPdXv30H0eQcvhjG7SYw5g
 rLe/Pug2ZYWTY2H24Ym2PEnbRUSlEkQ6UDzG3CxufkcFdBbi9MWTz0dZ7ER50z7RkbA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="neOu/LFN"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=sn125164@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=neOu/LFN
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 27B61811D8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:59:58 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c423b145922so2631866b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792688397; x=1793293197;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Nny0Z60vaW/T6pcOA+4gNciJfIpyoEAhl5i12WOJFI=;
 b=neOu/LFNwypOFm14+VZNobgp/P+v/vzxAvKYaJsMIry4p6+RqLYt1jgMH00LKmbNKJ
 JGETUqdKeKNEz0+a/cOK0j794AYAtvzQaoTq34GAYcXWSOFxkLcFzWmeVABDGwMAsK6U
 iKWlGWIUooffnoZd2zDUNupHh9G7mKUsnTnEyCm1isAMCMyKfeVXO6f1FpdYJbkUVSre
 LtX3yhvpb9TjkInZTyK0B1b7A7yKDYedUTIbQJAwSdMYmPWW3oEGdDLQxtHJnUDZhdIp
 XuXM989e8QtZpQ8NTIM0cmPa1AEiuq+ExaALfNECQbiOXybtdcC1LNXceu1u0Ea0H+tk
 5ZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792688397; x=1793293197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Nny0Z60vaW/T6pcOA+4gNciJfIpyoEAhl5i12WOJFI=;
 b=vwNbpcxn6h0rneWZ+0IIIFtd0W4IsngnS8gptUpbyWMJL3begyKWJAT/h6VuS9aDjR
 O1SK59be19cp3Qg0MjBnre3dkAdncdkExAAiQG+3dNSrT9lu/6pSgsd9GFYl5V75clK1
 2FCEMvWlDhEWZmnN3KwEUzC+E7thSoHKfSZt8LzpfquJgrBmPr2XnK9t5ehsds/YIIZC
 DREgnf6gEPnM6FBcn2CyQm1vxsVzMZFl9yPr75A39alg1/WPNo3J1PQF0tPPQtrhUg/6
 WfZ73Buus8MxyzuDQo2f6PuW+6FrF5/jV+l5Nhl+784r5eouIKjp6UIpp5GEn868/Up3
 LF3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKuw9qWW51nZXxR1QNF50e3wSwgqzdYU6a6FEyM5G8dl1rjOynCJGLNqIMv7TGfCD7qQvS5ks=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLn+fVkKKcyJBctvyda+Ep/EzqGvNnVXVBrDmtbWw35ohYs/MII
 c3BBPv90Dpx/8k1hjvvPGFPTGYa4CeiNTkorYFKjBKL+9KjSot4x+Ql0
X-Gm-Gg: AYBFou2MgjzL2d8XmBSB9kL2wimOvSo2TpSDtAYjGo/FwUJtOpufxANpqwultK6dZdh
 gO6VK8XWJc2CUWcLVn6V+ezA/0REZh0L9v+RGKmtlsDqxPX9rSm1hbbR+KuEjU9QACxiHabi6Qd
 4XMJxQRto/LLF/EAWmGCX4d6jmfS/90qNJf1zefLauISGTufw1aDC/frtVUCb6io66lzxpnUorC
 PdYra/Ov3y8MnnwWBLK5wk0Itq+IKYbkDPGUn1GexK8LjfFMznEqnhXoId+xhlpwmwG3Xgs4bq9
 O1eYsWanPa/tja6XRLh6HYge8Ntttprg1Gy6PHSypSdPNuwbsW2756FJK6VkU0SomG65Ci862iA
 hGq1buS0FuufLHuXJX4M1N++aW5pt5kfguFccwWb8sMbqpStkBmcBcApdq/q1MnqCYqVVNBy5EU
 Bk8h6UNHh7GFcb6vVjM/aVSRAd5LC3DFJhx1TetHUcEz4yHy0cZGtNYl2MUwGX+XFnJbTaVSU8Y
 09rSVDfbUatCSrnZ4ab/soXS1J7D9Gjb0aEcEaNv/m5zb3t0S6LHkt9HnVxfn1Xz0vdkpr1lwTc
 +FBXbKBP2uPEXXpwmsPJdQgvQtiOzEOj6JTqzA==
X-Received: by 2002:a17:907:72c6:b0:c46:645f:cee1 with SMTP id
 a640c23a62f3a-c46799a6693mr649706866b.42.1792688396653; 
 Thu, 22 Oct 2026 09:59:56 -0700 (PDT)
Received: from nixos-macbook.taile68cd7.ts.net ([93.184.110.190])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5ca94b2sm7516366b.48.2026.10.22.09.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:59:56 -0700 (PDT)
From: Jacob Procee <sn125164@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
	Bin Meng <bmeng.cn@gmail.com>
Cc: Jacob Procee <sn125164@gmail.com>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v2] usb: xhci-dwc3: Add DM_FLAG_ACTIVE_DMA flag
Date: Thu, 22 Oct 2026 18:58:08 +0200
Message-ID: <20261022165835.14798-1-sn125164@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022065936.125731-1-sn125164@gmail.com>
References: <20261022065936.125731-1-sn125164@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 17:20:08 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xhci-dwc3 is not removed before U-Boot hands over to the OS, so the
controller keeps running after ExitBootServices or bootm. If a device
was enumerated by "usb start" (for example by the default preboot
command for USB keyboards), the controller keeps polling it.

On Apple Silicon machines (tested on a MacBook Pro M1 Pro, J314s), a
USB device that is connected while U-Boot runs is then not detected by
Linux until it is unplugged and plugged back in. Running "usb stop"
before booting avoids this.

Add DM_FLAG_ACTIVE_DMA so the controller is removed, and its DMA
stopped, before the handover.

Signed-off-by: Jacob Procee <sn125164@gmail.com>
---
Changes in v2:
- Use DM_FLAG_ACTIVE_DMA instead of DM_FLAG_OS_PREPARE (Marek)

 drivers/usb/host/xhci-dwc3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 3504a7cf4..5b352866a 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -256,6 +256,6 @@ U_BOOT_DRIVER(xhci_dwc3) = {
 	.ops = &xhci_usb_ops,
 	.priv_auto	= sizeof(struct xhci_ctrl),
 	.plat_auto	= sizeof(struct xhci_dwc3_plat),
-	.flags = DM_FLAG_ALLOC_PRIV_DMA,
+	.flags = DM_FLAG_ACTIVE_DMA | DM_FLAG_ALLOC_PRIV_DMA,
 };
 #endif
-- 
2.56.0

