Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D22C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF22F40760;
	Tue, 28 Jul 2026 06:56:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Q_6h8l9unSU; Tue, 28 Jul 2026 06:56:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E463D40598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785221786;
	bh=yygg5Y/f38WM3PuANMZ+/X2xS7izXXcr5E+6A6W5s+o=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sz7i9AP/K5W0SZQpkntP3lI9agua9EbO18MjdFFl3Qp6DA8QL3rCwcFHFRKP9Skwi
	 sX7tr40BKCYL3u211O3+30YOOv469Pe9vnyEAHWtbKuDpVaMQeegjeLan8S0tzbrwz
	 cOlcc500KGx6Qr7BJY53hheCzlsupocFwZK/4Gs+8qF1vVauXJUtSXI/pIi2yq8JBP
	 ksjYoyOmSlZnae5HJK3zmzIaKOhLZhq8dyKAa+zh80A3dmBLFBfvru+H86+cazhnRH
	 v9Tq0feHPyN8OoWud+dwyfxOVaMVx+jTV6Vl7D6UlRkac58uiW3cJ5Psofl+cNSENl
	 UkfCfo4m1+y0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E463D40598;
	Tue, 28 Jul 2026 06:56:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 405E6357
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26A3360821
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:56:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3u1DThUVLhbQ for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:56:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C8BD36081F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8BD36081F
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8BD36081F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:56:22 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c15f025146dso42556666b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221780; x=1785826580;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yygg5Y/f38WM3PuANMZ+/X2xS7izXXcr5E+6A6W5s+o=;
 b=qIOEp/Ui2Y34VQF9KySOM859MjqWFh6M4G1HZB/0ET9CBSdi2wuwmttU5jsccsbWIo
 QLILoir4vCKgwOlxWOPF+PQHM9ujEmNSxiW7oLW6t0ylc9h/qmCsRrUf/oQ7j9j9X2CO
 FvB3+RQttTgJ1URJXX1grpCUKQdauE7Fc0kRXusDfeTTiGZexymR+Nd7uPCfFScPNRnd
 GFXzazMhNZuSerbqoBhfINV3bx6bqKg3gdYFohUT2o+FUjcS6oDEA/3rNAhPd7uyV5ef
 uI7+rcs2UsC86hAdz4QAUvtvQCiCBcm2z+e9r0WYoQ4g2avlZyfJXhV/UuTm78QdqFer
 RRIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDL5bxxaVlVIm0FQ2l5a0pxRWno5Y8l8rJWX7Tgng1YMglFtGgvFc3ekgQMkB3p8oo2MYStrw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxpLAGTzNVv5+ecIbhs677rEr/Q4jDljksDjhBk1lroxxJO00S3
 a02j0ejEl/vbTEghdSw2IodaDrVmDkHAipGVFPoEPrHgzR97P4+/wvdX
X-Gm-Gg: AR+sD10xvp8NsCILuf5E7x6/IdYOjwz4I3pp7TRuOmnokF48Cmv3eDh6JZK6iEselM3
 IHQAOGcF2A7oywxy12b4Q5Fso9X8k1QtPhUweO8HYsCEj+svxZfwycAZ/H7ed8f8/HM5Ej4LYLY
 +cGfGyq7lVLvDHw8IS53BpYWOPmSQ1PVZELMqiErdrZ+lACZD9nDiQXXuN5JlTlL5d9Nh3GOLpn
 9i8kVruI7lptQAhblk/0Mp3UCWBaDmTyqNsWYVPKmjGdg0LWer/mppImwzFjUaVBONzCqxByvMi
 ULF+Yapu0myGzPtBvEk4lgg2Mbxr6FxYfYmvVbIUT3HzhbjVQSqV7wLiZTimMHQ92JXNEQlwVL/
 M/b2qpvkPoUbUtWdZTXRxHUM8l3Tr6lfsf21pQH/vENwSWNX0ylwFBbvIe4/iZpreOSjYRHYMJN
 LeLN5X31K65pWHVPfeO72V64wIh3WUGltoEnQOKn5V
X-Received: by 2002:a17:907:3f07:b0:c1c:4820:65d2 with SMTP id
 a640c23a62f3a-c1f71cefca8mr24994466b.2.1785221780142; 
 Mon, 27 Jul 2026 23:56:20 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b42sm730247066b.38.2026.07.27.23.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 23:56:19 -0700 (PDT)
Message-ID: <5ab38df7-9065-4354-9b83-364d14efa390@gmail.com>
Date: Tue, 28 Jul 2026 08:56:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 08/11] rockchip: doc: add boot medium layout text
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785221780; x=1785826580;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yygg5Y/f38WM3PuANMZ+/X2xS7izXXcr5E+6A6W5s+o=;
 b=tCjqFAf6kgDNrIgwsqvx52S6IkqLZzngABpzJwnw4GhBZ8pCfMLZGs2TsWKHGJsKf6
 rGBRJ/wL5WD8BoyoShivNrsQ0i8V5oa0XfTIeWmfDI3KoFMPYOR6m+4ad5fkyhOPblj2
 7vnnKZpMKbfS0RiCc3mQRWpobeWfFqSZ9qkaoEvq6Qr2/Gm1qu7zhJrCvsvvLnCb46Wa
 VJGCJsS2n8i+QqTR43sUjEDNJ/+TzTyAau4X0PBOyvptGhs837VvkltxkKiHkvzGn3/N
 PnJMQ1ROrcH0nvoVlFcKsEUWJZtltObCGY6vK9oyVZa/AlTdA4oYWEKI0P36sO6ifBx0
 3C7A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=tCjqFAf6
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add text that explains the boot medium layout options.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 doc/board/rockchip/rockchip.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 7da74eb8fb12..e497be7db177 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -352,6 +352,31 @@ To build rk3588 boards:
         make evb-rk3588_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-

+Boot media layout
+-----------------
+
+The boot ROM only checks a boot medium for a limited number of pages or blocks for data.
+It is not possible to place these blocks randomly.
+
+* EMMC/SD card:
+
+  Rockchip uses a unified GPT partition layout for it's the open source products.
+  With this GPT partition layout U-Boot can be compatible with other components,
+  like miniloader, trusted-os, arm-trust-firmware.
+
+  There are some documents about partitions in the link below.
+  https://web.archive.org/web/20260501050119/https://opensource.rock-chips.com/wiki_Partitions
+
+  Write u-boot-rockchip.bin to offset 64.
+
+* SPI:
+
+  Write u-boot-rockchip-spi.bin to offset 0.
+
+* NAND:
+
+  The closed source usbplug binaries and RKMTD use the NAND erase blocks [2-6] for TPL/SPL.
+
 BootROM/MaskROM mode
 --------------------

--
2.39.5

