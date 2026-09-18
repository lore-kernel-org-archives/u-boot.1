Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6411C982D6
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 10:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53C6F60D6C;
	Fri, 18 Sep 2026 10:52:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PqvLCIPPEP_w; Fri, 18 Sep 2026 10:52:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 86A6E60D69
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789728777;
	b=j6ZvKFY1oZboJ4kDLV5tGgiUmxkMaJh/F5FUKg8VXNvKJvuUPF0W65mmq52FZbWtlFYk
	 sUdv9kb6YrtRZyj3NDmP/6W59z3JetHiI4TLa2rgpTQAqCEROIzjR60r3isD2kwY4oWWN
	 Ha9MRDZWwdwwTZ6USpyC3FeIM6jMbEuckXn3xIYcfDrQVDGzB3w+OlwAFH6TeUv8ZzNXF
	 jzfyA48XP814QoOj4dH8ZLuxdGJJKRKGNFmsD+VZ7YRECFUAwpqEJ586jjiU7jloKoxy2
	 T5ao677aco8vgpPf+yo6+YSsffUvxWChPNXEB5tjzPvbDiHqOQCkGnoJyOWpn6zO35g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789728777;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LO4w6mGqlDtbdVbs6RMe+RWhAYobmOq7LH1OZFZRbaQ=;
	b=B8MDryqhy/dJc2KFmWHbT9qrr9xu/WJWYpfK9ZKCrnCdsFEedIuXdknoTOp+BPLM24m6
	 JskauTFotCQ5lkmTV9z47s/8HX/tcmMLZf9jTtpIM+6M87jdKjXmzVshnr4lxZK2m+Ulo
	 K2eX+d9b5rY9c1C27vfBaVL6ZSPEEh8PypA+dxZHNIcptSSCQlU03XkJzUwa+hrpL1rnq
	 7OJBaI24BBUAXU4AbYutXWkYgds6PpCA65pk7Ar8AYef84/qJWzNa2YLmQOQJ1TX3dg07
	 eeG45xgHteEBB6RdDeCcsaxrDRMScJ9GdLZM9T6TsShHRm1FqJobtg4q4sonGB14rAA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789728777;
	bh=LO4w6mGqlDtbdVbs6RMe+RWhAYobmOq7LH1OZFZRbaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c7BcuCGxdPKX8W4QO8WLlReYstANxEaYv1bGzv0QSpjfT1mDrVQyhWMcYB38v00dk
	 z8z4dJe8DQk6fA8iPF1xFYkFD8ma4AhitrdWAt8hSrSjCrm0RWWUzBM/BJKjtD731f
	 cmMsdz/HsAlQmCgXyDj+UV7j+Ep21EZVvZOsjy84AVI478h+YLLNKimy/lXyqoid0H
	 L5qsPO894NQYj/UGrhf1QGeGngT1pKkvldu+7JOa1Q7eNKY9jicmAPEkL/l7iK3e5B
	 6A2Y4jS1w5m8BK0xfSE/d/U81Z+a3NuXBPIniWHm/huECmdSL/+IW4s1zhZRoA5HGr
	 xFqtN/dBm50VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86A6E60D69;
	Fri, 18 Sep 2026 10:52:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 62CF6279
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 47F3140AF8
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:52:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j39CeXEom1tN for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 10:52:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 615FE40AD8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789728774;
 b=SXdvjHBF2NfDm/1PMM3pGRXSAFoiw/CWaRn8ZMcW5+LBSlN/7AeU3uK8UAQHuybVL5nP
 HCU/Vx690WYsYtz5kAbGHqSq0iNoDnO5BJrbBTZ5pNhUs3VeDZLUwsbpc/3x4YXM9GOsx
 AZuUvdGG2Wd9147h3wApaapOCgm2Dn9B2QSScCf7n7Vol1dD/dCbEX3aU8VUNiF5ZoQIo
 X4D2xbUwV4JPQybClR2KZoPEa4WDs4YjM+3HX/muiG6t04zBYjJNQNGVbXpy5dzC1S+/c
 +eEWVxzuKz3F5G5fgpy97AeMNerblqof63RfXi2RgvVhxIbHyxS1cTlvqoJc8lULLFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789728774;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=LO4w6mGqlDtbdVbs6RMe+RWhAYobmOq7LH1OZFZRbaQ=;
 b=r+cwxQpF3sty1yjopifMrRKcff9d5yroAhwHt/B4j0gIv7B3QTd4IXnFlA3XjG5TXpT/
 4sszvbrf4zkXVBEAddFlkAUN6LBMzOW1JKbbp8zV2efdK+TkEXSHkL3NXwIymliELLsr4
 PhRA77U1XNc4w3Bv9RZiQv5FSo9i+84zIYph3Yh17kLwKofU5rCYjmKyAEkuVyjYxUZAa
 mLXNeEJdjlABuxx/sOKLSxYN7fBGDhCJcem5rXhl7cJaN6Peh50T2Zkq9VjNVNj7UIIFy
 tf4/COy/sjFcDCRD0qysZyR/gy/MfVZb4ZesNkm94LM8+SYIFRUxruRRN0BEQBIkoKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=mwNLikdZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=mwNLikdZ
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 615FE40AD8
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:52:53 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so3480015e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789728772; x=1790333572;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LO4w6mGqlDtbdVbs6RMe+RWhAYobmOq7LH1OZFZRbaQ=;
 b=mwNLikdZ/tCX26n32+hIZstMgm4uTTxZjvSQy0z1wyhI3yLwWfHU3+ScO37VfR5SZe
 MZI3vgl0luaEkc1d8MITrr6FqJWnb74xC/twRRG2A8xtoSBjHcY2n13JEyI6IFnRVbFa
 FltVOXqPS05Qha5j5ufRyyeGPjKKmmxB7U1bT37FMsltIbImvk0xQzru+Z1fuQ1tw2dk
 myHFOcn+dqZ+cUIo6JEEnWpw5TfWBcfQeCHXqdIoL7dOxrfozsJfiJnDV8FiLDnCiKk8
 72ZDoJ2AAqcGygrjeeKSQsVGV8R0czJHAABEdtTuJLAN8TVT9btPGPZCo2WhAtV33EFe
 eViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728772; x=1790333572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LO4w6mGqlDtbdVbs6RMe+RWhAYobmOq7LH1OZFZRbaQ=;
 b=afaGKasZyb3IPFzmuy/PH59q99hF4jEj5vZ1KgsEqZxuZeAiUaQWeGSyhvHc/yN9z1
 Pl7sZRo13F+TmICk6SkH+sK8HEp022mqpZcsYrvX1NPMeRMRYCs3vTQTO57xbqYqXxr9
 QuCheqHPzECexogPeL/zZplNpnNq5PhDclTQa9PLIhxx/cOn2xPSyIIcadkrj516KjcS
 D3PlIk/DQ00BpWBd/j3K1msF6/J9L+USIvjNPf65hl1tDZIo6kEY4ubX/twNYiUxS5mP
 gaRRiLyYeVKGNz1BUsgR61SpEWFPgdiR7ISQiPG4QvSfw7Hiq/6+xd5YOhJNBElPXx43
 17qg==
X-Gm-Message-State: AFuF++ncwfG4oDv4qs3pyksQW5Ef60xZmmbGtGty7tXKZTDUQ26BLnF0
 gKBfy1JgEfsv5xthOqKHvnRYYCtm3ITN8m2rnsmpVKu6n/lL2iujNc3gjQvjoUmBJtM=
X-Gm-Gg: AYBFou1SJTUhs5Qwdj2SXPhnFyv6xb4lrRCdgjEGqocjLrt1rerp0jF1pxKPhQf22Ha
 tYgS3ZckzFHDpm9okFr2egVPoT4gV5d83ETL5NpuLinR7ZAeIyS0suTFt0RXRoiC6RHGDJXM7Yz
 Ya9bgHJ3lY8XApNvI/q1OUgAQBUlplF8mBPPVXnEyB9F+0gI7Lq3kMWtVkqbIAHc39JPwYC3xxF
 bgXi1uwUwwZMvNZnmerEBiEeg8JgbX3v6g5RK8R0j5VGsuvPnzeOISqju22FMPOgUVnXKs1kb53
 9yBCqU2EsBWmTqkoH+GWWu5KzVnSKTqSTZ9M9ylgyCl3O4yShGbaW1rMmbjBn6VF+Ky7ksmqQtJ
 5bqCluY4R620Q/iDR8Er6uNDUBKFt3jK4Z5rGO7uTE+Llqs6LVXivjqyEuEwKbD2/4u7xtiPKpi
 GtK3zQ1M0Vq5TYJnVpnwT7jn3NQsqIe/NG+/fXgAz5rnOSx21XHy6lGJaawoU/XYT3h8VbqCsIK
 GD8c3p51VzfQ3+hKvixXL7KA6C3KnEGrMuWAwbhRRQl4VmehDVsFRKVrCNunKg=
X-Received: by 2002:a05:600c:4e8f:b0:49d:1916:59c7 with SMTP id
 5b1f17b1804b1-49fc5687e05mr26545615e9.7.1789728771902; 
 Fri, 18 Sep 2026 03:52:51 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm3673449f8f.32.2026.09.18.03.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:52:51 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 14:52:28 +0400
Subject: [PATCH v2 01/11] boot: image: Keep the image-type table out of xPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spl-fit-compression-v2-1-28e946f57357@flipper.net>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=alchark@flipper.net;
 h=from:subject:message-id; bh=qnCYhMi+nvpbMWu6wsi0fkJdn0X2/A7OhTTOlASDx3o=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStFf/bvKjjpLNfzMQF8mHN0dMEPB9HJv5RWKWksfzh7
 mWL3klJdkxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVAbYM/0P1Cx42qSnd9GVxtzh7dz33pwWRs38/PPRmEYuU0FIvzQaGf0bCCw5
 rXfULvfj1/4zkyHl8Sq+Z1qyfl8aorf2Dee3ZRC4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

print_decomp_msg() names the image it is about to unpack, which drags
uimage_type[] and its strings into any phase that links image_decomp().
That is about 2.5KB, measured on a Rockchip RK3576 SPL, spent on one line
of progress output in a phase built for size.

Name it "image" there instead. U-Boot proper is unchanged.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/image.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/boot/image.c b/boot/image.c
index 185d52ba492f..a7dc69e858ad 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -416,7 +416,12 @@ void image_print_contents(const void *ptr)
 static void print_decomp_msg(int comp_type, int type, bool is_xip,
 			     ulong load)
 {
-	const char *name = genimg_get_type_name(type);
+	/*
+	 * The image-type table and its strings cost about 2.5KB, which is a
+	 * lot to spend on a progress message in a phase built for size.
+	 */
+	const char *name = IS_ENABLED(CONFIG_XPL_BUILD) ? "image" :
+			   genimg_get_type_name(type);
 
 	/* Shows "Loading Kernel Image" for example */
 	if (comp_type == IH_COMP_NONE)

-- 
2.55.0

