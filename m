Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026F606A322
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QQhIkS7Y;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KVdyPk3V
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F10040445;
	Wed, 28 Oct 2026 14:48:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z3VSjiMggOeL; Wed, 28 Oct 2026 14:48:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7699B403B5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198927;
	b=DCdQ02BLXoxn3WqSXEisx/p5nZK73Fb7xZvc4UUVrloEHbTU3n6gfR8JQULnCgGKdw8l
	 8J7HwK08eZtbR2kfAijZywPyC3r5opN7Us3DtGOAo+fsspLsESqsiyzq0JRWTRYaQum9l
	 oASc6v3NeB7hb6r5GG8E5L/U2QXYbdjpDC3LpdbTh9NvLJgQdvGp8PTj+qh7QPVLFHPAR
	 yCysZFWPiuWZwOvpMGP2aYfTDVudN/s0fm6y1LIRKCRHZc83ScpeVfrkcoRHevOR1PNCK
	 J84pCBO1nDPNsDoV3/99RpRYCNwA0Mqu1dQICbarwQ0FS1MJtGm00G/yKCA65OluFAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198927;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
	b=DfK15PSib2CEtVP+hyhEd/Sm8IoD4zMtk7qGGrep/72zWW3GrE7R0yOOmCdUO2pccx9a
	 9cBJYSwzYheLKKpg7Rg7XqrCA16NvrEvN7b4JQCyP7yVYT7zjoC+f4BW4kpwOEURxyznS
	 xg/F3cMnxEfn5+U+tTYFXV213wcNn+ZHC/iLijCmniiifT4GvuBIHoyLPXXJHUvgD1gIw
	 IJHjF6DaUg0GERcbH1QAEEXya1VEN+CoYnefdzQApEehEB/L90bwUG1Yq3RoiDblkxBmQ
	 IDcXKfyoqMJ1LerLCiA+AtN/hBIRPOoI/hZ14RDhlTqHzw5LQugMhKS0C13Z1P791DA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198927;
	bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QQhIkS7YPcfbTiK+4QPo1dkeKphfUN1A7ZU9+D6dj6Rdg+kgAYOa381mlgTj6Ol+o
	 Jtwgr8qQNWVkczrERlMH4m/UOrrg6Equ41Voq4qQtl9LCHxfgKyK7kPwBtwVhc/Goe
	 QXwlWcTx3SXgJpK3alsqdRcbjEfGVjJABBjg/43Hvuvd15hgaJf36FcLhHHJl/bXgS
	 sMd9LtIMyazwPtOF591+rAhrRJp3kWeSieSJvlX0tUwWjvtiNNnfLt9MafyiN0K1C/
	 o0JGtSob3g2l110sQokMIi9M/JdcSzikmLgMbRoWFT8O5SQ/16xSc5+szKHxVwe8BV
	 6zOyqnIsKR/UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7699B403B5;
	Wed, 28 Oct 2026 14:48:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 44758235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36F564009E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U9Ik6HLfCpnp for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2EFB54008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197070;
 b=iD4iAIQ+kAjiXTOfCvQnZ1X4hlpNGYZpSwbRCDNiqU3ZJ5HerYY3rtdcPjpCAyoro6jX
 T/nCXLK2auHBkBmWvUQDPI32q7o880CjF/u2kBD/PJESw221h4xYijeJopeJqjUwCJUwr
 T5k3KE5wmf7UZ4PmgOOgRnrfY69KTb2TC42YlkusK/RHCnTNPvAwOX8ALYKV0FbmnjR+S
 88OLoE74KWjsRGl7ECy4J0w7yG1usoa2YAH7IWwBOx5CuhJCFX/aZMF4ppnukAjSLjGzg
 RqeI7NiNflhXGO+Tf6/piN/2B7Hc8r5nL/OJhyOmjIdXMoOZe75wVpqhKfgbwwvUxDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197070;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=DooQXKn7ePt/tEZwHa85ZXL2HqD0NYQDwzCqKm/7wn6cgCP+gmeJIddZ+uci73Dx7byu
 gH/dVs9vWQwqEvBsnfy7G0Mhb9iBX0gZ+S2bPvsmunj0XYKZPtV2WfTE2UI8jzajrEZ9M
 bQkqVkT6vx4WlrNSeLVCfjWPdsQK76TsrDj8ud712ch0g3dtj6iB6ZW95zP5T/7K/XItR
 VFN4H9mWx3YSfcBNAO0Ahf3S16aYko9MZDhQTmNAxm+KJu3rPPCb/NSjt3E3jt7YPOiaM
 Gw0O2rebc01kUAypBXF7FDB+aVOdYSyHso1PZXz8GNgkWoKlUUGPhk2vFR2SQUgcleg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=KVdyPk3V; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=KVdyPk3V
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EFB54008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:50 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c33700b6435so16305166b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197068; x=1793801868;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=KVdyPk3VjEcV3gEj47G4yARhYgzTttOXoPYcypN3TzPF4XIZl4HMkT70V6PZXnQ4RG
 A+gpkuvQA+MY6+p0/+mzfnORDq/nBzmODpxlKGYydfJUlrZaiHm9v+u4bPGgSIPB8Bsk
 HA14MySinsUDMetM7iUkmUaff+xXU4w1vOwnHpZ51MVChuEkI9SJc7OpbZmFr/yC8hDZ
 lek9FYmj7DC9UtwvTF7Yb/KPi9/SCTn6Ec8u8MSOmluGuVVr0PZpd6fW2IkRWFR13QnU
 cw6n/zs7qalNJtOx/rzMpTgyI6NPL+YZEtNCvWc3l6iGWn91BVXKW+z+VC7tYW00t3tk
 Rzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197068; x=1793801868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=fPU8zB1aLrT/dgVOEKzEjaYYi8+6o3uBxWc6Naa2msLc+897PWzmd/4aEb+Rxq5EhX
 64vqA7av0lS7LZxr01ENsMXy6OP0x7t7tPvnGHcNokSEA6TcemdQQ4ZMA3g08l7EkXSs
 FZl4qPDmBNjbs8zT45Vyhlf4CItLcdshsg0GDrZrp9pDXCJVgFbigkFQiYTd8XuoWzTa
 sTiH873qwgxzMs04Gset/wGPd67ls/0rdH230TBY9jMbQopimLNzLmJoX2Coua48u34T
 RMI9TepkfPP6zVS6WTIb40KKyR8ryfHNg5rgQkQ56PfskjtV7F8OgOmIb8j+NtBp96S/
 vZjA==
X-Gm-Message-State: AFq9FYLhqE2WqpuzxNn53ZxPH0K5eX/s+pCjwoFhCZNIgejXsbYLg83p
 ekt0ZNB3PpeeTqpXe7NB9p9vNc56LzxDH8IYLDtUJU6NgVW9nK5vlorORhyl2yUmqixry3KBiZs
 DoqWR
X-Gm-Gg: AYBFou2rKgyoQSeYIDIasvsu/rL/KWQy15JDu5rteskQWnCUSGZnHIlorAb4HTyjyni
 rSB94qxQMm4MUosU1M4Ahu6huYlJYJNNuZR0SeMKXsgC7p1fhfReN0+U6CnM4Kh4+TcqupEPy2S
 jKwlSx2/de9EBEV7JgbUyoKcV9GOtg2pIlYcg31rC5abIklko3yDYUzKlfShAZqQju7TmFy9Ztk
 uyZ4+kmKG5oCsU4E3KOqrvvU8meOmOZFZJFlCx1AVug6YwimvHe/4lIgc8mQ5lbuC+/YqnyX6bf
 T4oeWyv6xk7LLEd4+a9LWl4W7owQajEUiAMQmZpHlRpFrZlsSqryEkwPtddR+FmkSkTEW/lv2rp
 Ywex+rtz/uyF9j3YWiseDXuBMIeL68fUuYuptZOecDWewfmypL9MvKxaE35LEYMajHQU2qcP9a0
 7MwmlMqcApYA/Al4EaTPK+sAUg+Y9vG8oj+fb2+8kYkOSDKpl2ft8l1e7GL5F/9KxzHa9jgCHQR
 BmNZ83wbjyMwmFUy8qDs9f1DOO1CfcZArh58X3HoJFLXCjQD4YJN7sOUFWmmUYhoYFS1FiTbSag
 eKgE1ykoeLApa1Jkq0MmYpmSpfpPmFbyEdYD+mHRy1ljoLoc7oOlcCXC4d7SkhvCp8c2GboEh86
 RV8OkDGqMHw==
X-Received: by 2002:a17:906:8f14:b0:c46:ae89:cd3c with SMTP id
 a640c23a62f3a-c49bddd28ddmr280898566b.1.1793197068166; 
 Wed, 28 Oct 2026 07:17:48 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd0f6f1asm618675366b.0.2026.10.28.07.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:47 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 27/30] usb: mtu3: set endpoint capabilities
Date: Wed, 28 Oct 2026 15:15:51 +0100
Message-ID: <20261028141554.3073545-28-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mtu3 already uses usb_ep_set_maxpacket_limit(), so only the caps field is
missing. Without it usb_gadget_ep_match_desc() finds no endpoint after
the dwc3 resync.

Set the capabilities like the kernel driver does.

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/mtu3/mtu3_gadget.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index da633faae7b2..f209bf47d073 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -591,10 +591,20 @@ static void init_hw_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 	/* initialize maxpacket as SS */
 	if (!epnum) {
 		usb_ep_set_maxpacket_limit(&mep->ep, USB_HS_MAXP);
+		mep->ep.caps.type_control = 1;
+		mep->ep.caps.dir_in = 1;
+		mep->ep.caps.dir_out = 1;
 		mep->ep.ops = &mtu3_ep0_ops;
 		mtu->g.ep0 = &mep->ep;
 	} else {
 		usb_ep_set_maxpacket_limit(&mep->ep, USB_SS_MAXP);
+		mep->ep.caps.type_iso = 1;
+		mep->ep.caps.type_bulk = 1;
+		mep->ep.caps.type_int = 1;
+		if (is_in)
+			mep->ep.caps.dir_in = 1;
+		else
+			mep->ep.caps.dir_out = 1;
 		mep->ep.ops = &mtu3_ep_ops;
 		list_add_tail(&mep->ep.ep_list, &mtu->g.ep_list);
 	}
-- 
2.53.0

