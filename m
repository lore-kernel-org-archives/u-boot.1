Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BF6CA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 16:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E0DC6066D;
	Wed,  7 Oct 2026 16:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ojlbw4nSvFR3; Wed,  7 Oct 2026 16:07:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 91D32607D7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791389237;
	b=N7VDdRuIKjUEYe0Qkc8Lx3firkiJZeg0aMzzW+n8PdijbVqa0wdRVbOB514MrulCaMg6
	 C7wtpRZjvYPttBwivjfPk33pONmKCPE7AicW9jLa/GzKAk6OlmSI6jTnldoZ/Mg0lz05W
	 qUgWD89nO1TufsblQwUF2mkVtecsh66RgVZsa1iEB9XGaAIGtrFVjwyyQayMk5Abx8Hg2
	 WL9u/MZn+6MJhMyt4FZvGJ1ecam4reWJ95RLOpvglxMc3r0lqbV4vv6Pk/LsN8QMswDkB
	 ycDHnAFVm3iZh1bIiixfs+fch6UPUFr2RqW6hiYqOtfe0vXJo3sPnk0CgIIP4ISUTKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791389237;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9yZMDj23Ay4XjSMHx1V0M92/FPfHIIj2GfLPo2CX020=;
	b=Zxd0O45DHRdSptXrwURlj/BJb2/29pMwB43tlml7a37ugbpbAOpT/OkXTC3y+qqTjqbC
	 RQ14DkWgoBDTkwuKw4P3yCG5YpJg8XyGPBPIz5Kn50t92ZyLqepcKNbLOStUab9GUyjAb
	 PY0Cz0TAJ9W0dN4p9XH0mHy6s0IyF55m/mWouE1a7XJotL0lIj200LVYjGSm6QiOWy7YC
	 GVJ8yyynTRO67QYN1KI2+ByZaFQTZRxJZ40AU+XEyE7pp/CQqNLHMFh4I6hEpr6FvHQKN
	 KMzhQqa9QETLRaD/MhQucseelEuruKFLXJom6mi+/ZWO6y3auQ0IlLpudbAlAnzkrjQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791389237;
	bh=9yZMDj23Ay4XjSMHx1V0M92/FPfHIIj2GfLPo2CX020=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z5kAzuI8cHkoKnj06B+uA7fi9/WOz4F5KZVapTL6Bsjy36O3d303X89BU7IzbgZZj
	 Fma8WrdOUJUwlmJGRKTFZi1ZpsF5pvrqIER7x2u126KH8ZbZ9Qrd5IRvUX3CRRrPYi
	 g7pq+yU60A43lOBBt/Prfj2rUqMw1ubraoPQ0EJYbm8aDGQnxjHXX7JOsk3z7izjTU
	 8SqJmj/ZXfAWj5td7JbJQcUFQAC7RKPRgRuZ//VoxK1IdzuqBuD0OeGGx69kjar/Sb
	 qZFfCKHbBpTfCmUqyigvloO+GKyTJjs+eWJmrmM4q293OmSQqSsqH3gJ0xkK8J5zA6
	 7LjTdyt6A07lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91D32607D7;
	Wed,  7 Oct 2026 16:07:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DC57C32F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE97E80ED9
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UDj7bQMIFJga for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 14:45:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DFB5D80ECC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791384352;
 b=M5zRcw1oKouZ8eCRTUu72ho/XdI2EK1mFDMn3joSm9hErgLXOvFH0CynE3D4gfiGmZ8h
 rB8BBNSpl9jZw1e0znxnSGi4esspznNgKH3B6+hFSe6q6iLOsZO1p1yrvSfQ3T5rXbMcS
 +JOmq7jWUtQIc/hY4oE7aGYjAt5CL/+IbLkdkf49f4K8ek03Ekyj0jYYIDnAa+ebPbuJ5
 ZIF0Uz0XRMCQj4yLVscQG2RRSBvyH8OikArPI+QY3lAb0PBTSElwNFQpWr7tvR/lqlTJI
 2QnnJwp51qG0K456XdZr4/nEiDSC6VIs0353PbS8SW173VOApTDB8c7FKFvtNmrg7QQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791384352;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=9yZMDj23Ay4XjSMHx1V0M92/FPfHIIj2GfLPo2CX020=;
 b=SiHV4JaZn9AcMMK0T8P2SIC6VMfV9BXRBC/K04DOLdtRLLo0eywCpl2BHc6a8IzM0soB
 XN3HRQdZ3UcN9JA6qgkwqTl8kjZwThtVvjNOa42/KgMRz++HfRgIIkRFB8jR9mw4l548D
 0bofc3ohR11N2dIJmsPcMEuxaWR4TzmAMxLX6+V5JLRF3SKMlPgzxHbgM5WvdcPqYdEg/
 YBmqgkhAEgILDXyAlMjMHYvXqVxMgS7EArgQwLmmETyAnTaKgJJ1tNrxz2CB1SrmUY7NY
 6hrlfac989dRZ/hu1e63sdDd49420lsxR6InshU4+6ufAnEMhu3zhJ2UyFjTqn00RsQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HsTuZCnY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HsTuZCnY
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFB5D80ECC
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:51 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-487048857f6so1614404f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 07:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791384349; x=1791989149;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9yZMDj23Ay4XjSMHx1V0M92/FPfHIIj2GfLPo2CX020=;
 b=HsTuZCnYU921bFLulE/BpMbDYmlJCNecs764lqHb/DD1U5ldtoURltuWx6MpQId9qm
 5ETjW7fcLl7otRG7bKahUvHPRjar/L3oYtVAun8kq/9aQx2WxUgjnmFbPPNp0l+b+3QO
 1S8Skbp2lB1hRv9ncK5xOJQBnFn5S6GArhMBqUGoCRtN3tANcokiOrNXGIy5HyEhOTIP
 wbDqC6wmd4ITHHeu3/CzgIq4pmxmTC2C/B1CQovUF6IA8TYoipbIW7uImHDmMF/VWbeS
 5m3D062dTF4y/QSr23EFaSKr8kMEgxCw0ikQpAT/gHj5JmLlYM7Uj7IRoyAXNXg64y78
 yVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791384349; x=1791989149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9yZMDj23Ay4XjSMHx1V0M92/FPfHIIj2GfLPo2CX020=;
 b=UYSlwJxpdV3FG4yoCKRpoXewJI59H6hxlM2iM3aWHgxxbqoOFexFMRlYUtaHglktVM
 QKtR6KDQhbxrLJ7Q+NxQ+tiw88hLnk9it36ZRKITUR1xYR6ILbLdeR4SwXkTM/QLyQww
 YwJ93JNkb1WUWDXn3FG3U/GzE2Wz4WT1azJFT1Xjnpfsob6kuE/6txaSdRtUopcNYlUE
 z4LUM/RZWwWVeVbSNxhYIj0R8vGyaK1q2Y7bg+R6D/6ZWtjlugCEUY25dE7Qd/rekpDq
 Kxx6WPlaq4k2TV+6r/JSU7txHZQGwcdFRr9AFgFrIJ3Am7xoFzbAxcOXNjkbcF8lStDr
 XWVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByw9Z4jHE28hHzy/wTBFqvgK7XjB7qZWNcc0nD3MB5kyOwnUEiYWd8X78xoSbvyuTnW5MC6HZk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kDGBOXDJ/UJEeRwRYSxP+AFCbO4J03hRJlq/S6PZL+K9f8V0lS
 8JcRlYR1bx0hBYqZaOpcY8MGqI0GH+OpbsOh71EAQ9nPkdeTViyJ6Zk9
X-Gm-Gg: AYBFou0DFE0zzUtAWWpkTtHq1Es2vHSp2UwIPYoON0UCwakKS1X9hDy4LWf8N8BIXvm
 9204pxpxDH4wDH208BBdB3iJPZlRGcYm9mYn2BVu37MKmfTzMOODWOWefU/ThGp+9sw3XocwNxv
 w+S6kBd5Xxso2sUFY+HI8BL6JyeEpvFXpfUTPpDz/FVzjx3sldHWK/00VmuwpzbgVe6Ms2fbd1H
 UYrIYjR9ZK4bDEoptuNCdm0m/8AiKFIAfF5nXrvz/vxIrWkM/svdS3keBEKAS8WVfJipnTuN04b
 8YdGNCKYMfOwRCNJvoiBQJtbrHxb8ReJlhPIxot9KUAM1pYRgSzeWoxPJ0lEOhkyiujoW42X0s0
 WIwDtmxZtRJMwYT0uvv4BNelch3MPrwxgmdeCKA4jhEWS7ccE86gVshwJ3d2lGjV3DDOK3Yrsx+
 K1ZjdZlRpdq764BtfZVSVqrkMaM8qlgCMrF8wf//iYhYcjRjMETAGxs4rnvfaIAa4JP9wPFz1yS
 HFe9w==
X-Received: by 2002:a05:600c:154a:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-4a18043b5fcmr39533075e9.16.1791384349157; 
 Wed, 07 Oct 2026 07:45:49 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f557bcbsm111620105e9.9.2026.10.07.07.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 07:45:48 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v4 1/6] usb: ehci-vf: take the controller index from the
 device tree
Date: Wed,  7 Oct 2026 16:45:39 +0200
Message-ID: <a10a561eff429011f3bd19d49e4f6c17f227c09f.1791381507.git.mehmet.fide@screeningeagle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
References: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

"usb start" on a Colibri VF50 or VF61 ends in a data abort and a
watchdog reset.

vf_usb_of_to_plat() takes the controller index from dev_seq(), but the
usbphy0 and usbphy1 aliases count as "usb" aliases when the uclass
numbers its devices, so the two controllers get 2 and 3 and index past
the two entries of phy_bases[] and nc_reg_bases[]. usb_oc_config() then
writes through an address read from beyond the table.

Follow the fsl,usbphy phandle, as ehci-mx6 does, and map the PHY node to
the index of the table instead of trusting the sequence number.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
Changes in v4:
- sent alone before, now patch 1 of the series
- reworded the commit message, no code change
- the test note moved here: on a Colibri VF50 V1.2A on an Iris carrier,
  "usb start" brings up the controller instead of resetting the board

 drivers/usb/host/ehci-vf.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 96d1363a76e..32fe05920d0 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -221,8 +221,23 @@ static int vf_usb_of_to_plat(struct udevice *dev)
 	const void *dt_blob = gd->fdt_blob;
 	int node = dev_of_offset(dev);
 	const char *mode;
+	fdt_addr_t phy_addr;
+	ofnode phy_node;
+	int i;
 
-	priv->portnr = dev_seq(dev);
+	phy_node = ofnode_parse_phandle(dev_ofnode(dev), "fsl,usbphy", 0);
+	if (!ofnode_valid(phy_node))
+		return -EINVAL;
+
+	phy_addr = ofnode_get_addr(phy_node);
+	for (i = 0; i < ARRAY_SIZE(phy_bases); i++) {
+		if (phy_addr == phy_bases[i])
+			break;
+	}
+	if (i == ARRAY_SIZE(phy_bases))
+		return -EINVAL;
+
+	priv->portnr = i;
 
 	priv->ehci = dev_read_addr_ptr(dev);
 	mode = fdt_getprop(dt_blob, node, "dr_mode", NULL);
-- 
2.55.0

