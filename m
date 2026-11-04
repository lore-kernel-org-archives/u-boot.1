Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F43606A329
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qk1/SL95;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=TqMpOIdQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0988406F6;
	Wed,  4 Nov 2026 09:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oXyNxWP4yQkb; Wed,  4 Nov 2026 09:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DED5540740
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785724;
	b=iEh/19IfQ7TQBRVoe6xRliQvD2Thr2SrTXHxxNJ7VjBxisbbfYdFdB+PEnCxzzKhw2xq
	 rf1MyCH8djtp730XIn/XirHedYLCx07ghMOSAgOJJCSReEZimCP6bYao3G3nuz0e06y4N
	 wPHwP8V1VSShX68a/QUcis4TWoHHrNIHEsPN4DtMj/Efb8/05IafrjvQ6FGirwZAZovH1
	 JQfVTpTpjaHj1JdQMnIYT5x/7HABavUWkFYSykAJ/BuL4qVi2m5nBtz2NztZVX946cBZS
	 sXz/XCjYOtBL8odlZPZ9c2lpjl/+an5xpE5qnNMTSlK9F8Z25WivMgHRqC5dbH9HFWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5rDjxfJfoVFLLMs7oRm8AEpZm50JXaqeYxP9VMcqLwc=;
	b=M+6EBcU9UPsAzlBf2OFWcNIywTKE5SxTmKwBYKyTq5uDjIHDJwjrUbG/kiNd5A+x1O2a
	 YBBQ6UI6CEgBp3oD31TJu0kHwq/XcDk2G2sTGjsxR5H6KVgR1tSbPdcO/3OnPL/0Vx+Of
	 FU05gIKFtOR5/sKKsZ9CoVl+NGrd765RpEfmdyU6e2ZR11QfQMGMU0U/aL1Dbv2c4z+bW
	 +tGgpnNS1usiBGtv3BcWRx/5HS7Uw+mI6F/Fww1ZoIhTFf9HFAIHzbCqyzn2wLFTrtSuq
	 NONjpmf4pMPBcNEo0GcUDmda1V+sVbCq99PIfhw1g5xIej71l+WtNFvcbJd4l0F3WKA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785724;
	bh=5rDjxfJfoVFLLMs7oRm8AEpZm50JXaqeYxP9VMcqLwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qk1/SL95hidy2JenUCkmPwkPHzdHJ5WaOV02JA+oWo5NZim6ULTtjgouSuakDDA0G
	 SVfyChyPw4YM9qEtLbqw4s2WPVSIvR4uhlpMQlnaVuDrHG5x+N48SJrU8ts6phWDaF
	 BEwXKmiZSiOY4r2nmAL8CSZAEEPAPwMqYiA3AZgB39EBGNnrZ45mUrScUnUOWSXPbg
	 +aTpIAbOvcqDygvvgFz3ZTQIjbBTI3mqv0j1XahOnwxY6yIWn1V3BmMNQ1VglH+Qyw
	 8ofnX+dy8hY/wnPeK/30QEMLWWQwEUdCjuYBYywBhg+mhGO1ZZXeqOgk3oiS+PeDmp
	 k6l41eXagpxPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DED5540740;
	Wed,  4 Nov 2026 09:48:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BAAC37B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3FB580C38
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PeK_s_NjhIgM for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:48:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F35A180A82
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785718;
 b=i6tEKUol+vwVMnlVpv83Z2jJ0JqPHTFyApciMJXuIawhpgHGu5iH8kLdlPBZTPx55jjS
 FBft/zwNVhQ4FzSkFn4++06HVFFo7fvJhw3oYwIjzJw8GOJDmP/gkk7O3EaebvItZ9rdD
 rLdUO34txqOg7K47G6ZaWh773/OGQkZm/47wECv7KEREi5cLUZL/dB1bYnDEx2VQiBQ0x
 NYM/cG/snp7kAoyXdyB+vtXE5sU1vNmgwZmDDZx6kkroYjKpprQBMt/mm8IVK6Q7FPO2b
 mtQm7bz1dzsVL3ydOaNaZjF0tjMH85OeCJd4Zv0m54O2BZf4QnwO353dbXazPn6gkjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785718;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=5rDjxfJfoVFLLMs7oRm8AEpZm50JXaqeYxP9VMcqLwc=;
 b=eKal+qYwsBN9+qMtF3HWNzbHDanov1WAoogCI8R91yo9CDB5GdULr91nHpjKFFcX2mMA
 WYKzTUwPTmzpb53Gj1kuwG+P0T4OSGd66ch9mIabGU8907v8K/cjczDHhGH0YUlCJtIYV
 4vmCMF/TesRypOuE4egZ/+t9GqusP0ZuJrd6vTkAUTA/g0bQUCSOC3kmQlqZ6kQxVb2+K
 iULsA5CE9yFcqaWwKmYVWldO4+VAw7nUULMSNQVes+YRo1XuDsjVKArZAugkRzPYuC9oJ
 kf8Fti9kycHT7LYH8izdxYxx1e2LLocN6Skgyhqmvacw4FBwf0ruKUQU3udcRKSYzzA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=TqMpOIdQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TqMpOIdQ
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F35A180A82
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:37 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so9326745e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785715; x=1794390515;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5rDjxfJfoVFLLMs7oRm8AEpZm50JXaqeYxP9VMcqLwc=;
 b=TqMpOIdQa4VEjD3Ljfhc7qtmo1hlOHDeZ/hIMrZNrw+ooD/KwZaJzVtjo/8QwTFGt/
 eZj3YpSvlOXKaik7c31tXWMj5P93XP5URUD1ogFVU3MwSY32+vdfHIUVvH0JIfE1hVZQ
 DUL9XCImpnEQ0BLD69h1nyMqpMYx7VvtrxU1zSlz+HoVToerZqRQEZhajFrPrS4OlV5n
 ZJP0Mx+pJNtt64s3FdDf2yQ79ANgRAelT9+k7GzS09jNLd/M1N28dian86pmrSdNfwQt
 SUf6YF+HbduXSbjt4s6JAECwhKedLvkUNuR1Y43mMNNcZTzlvIKl773/8lsgEoQ6Q3hL
 FAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785715; x=1794390515;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5rDjxfJfoVFLLMs7oRm8AEpZm50JXaqeYxP9VMcqLwc=;
 b=UtV4Y3YxDhUy8IuEsyknQ/LypcxUaanTZC0IScyVP9ZB1OmUMcZhZHVeso2VZvOWaD
 +CTKo70foLsuYzgqE/gj7cOvGWvtrNb1UXe4KNHIb+gj/YwQLv/LK8dv5OWu5KLlIrog
 srhQlKuI5GqKI4PVhuJfk/GMZOpABEJY0bRosqyTOpFIpQi8nHOG+MWqQVhEcs9ukopf
 D3zVqIBlFUIXc1VG5Z91KpiCZlpSjMcpm2pDBCAGoqvgaou+FCmNAV6wchzKHnc51myJ
 ouRPDx9h7ia8lNiCfkqjcb0ScO6lRt4YjktyQfjovq3MXrO2jQENSsvvISPGqLPwgiMM
 oTqw==
X-Gm-Message-State: APuU4Z9teinsbfj2uNhznu/IjBTWsA+MEUhQAkujNEKPUZCXHIi3YuST
 y8iSA3LBXegzNbE5MF9lXE8+dbaTvicmXApReSQsD8zrhboDtitFmiq5d3XOJC3gLdA=
X-Gm-Gg: AYBFou28XcJwgxNU4oKSKZfV9u9Z8JLeDkwC6REgWIJs+Mvp8W1E/6jhSk1hKySb7SO
 cpUf1ZcL6S8ptEqo7KtQl7xNL+C6Jy8E84E89LvZw6Un0zaklDJSHx8cXyW7PdC8AW2MzSyueyh
 Ow62wsPc3hegcxwP4dK/OWMQnyKfMgQ5xHG+8qPfZUWzq8NNmBs2K96SfSoBD6MyuYCyylWp8r8
 1pTy2LvXlOi90UnwIlPoYtgJdPR9OqkPojEkUdOwLsH0wTpRQEH16TrEnPQVS1HSPRwAJpack/Y
 3LcEhn5NA7neOdvMRWk2If4txTnI6osYMUjb9j/UWLvxKVtCfdm4hevIZy/Wcaci+gXxO0MmHkp
 UJ9wEKw6xHdWmmkk852LYgs+/oqoYMe3DFo5UW9H+ysUQLgEC9kEXfrf5FbZrRsPD3CnFv0mhCY
 XoF3/EU467yqVLCwP4EY5s3Otjq/ZlWNZvh6JDXK5wZIDXCmofVVBvgNU7q9gRPeNuSq8SRlN3w
 zO8XcYB+sqMuP0uxoLKUG9vG5jncEzQjHMJ+HbxXVBeauDOZ+gZA8dfDbxzWC5mXMQQ5jrDbI3/
 5uo+cexp24yA6uFgAYJHUgVIaQ==
X-Received: by 2002:a05:600c:848c:b0:4a3:5da2:38ae with SMTP id
 5b1f17b1804b1-4ac17a3628emr354735275e9.14.1793785715530; 
 Wed, 04 Nov 2026 01:48:35 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43c17ecdasm64799085e9.5.2026.11.04.01.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:48:35 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 04 Nov 2026 10:47:49 +0100
Subject: [PATCH v2 2/7] arm: dts: am43xx: Add missing board u-boot.dtsi files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-2-6091edbb51fa@baylibre.com>
References: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
In-Reply-To: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353; i=msp@baylibre.com;
 h=from:subject:message-id; bh=bqp7eHMhNkEmF+dhazdBl+IDmLa7/r8ylqOTI7Ox64Y=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqxX/wPtYjkmbhY23SGw84qfwv8w1bd5CWs09SWleJgnp
 SSKdaZ1lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwESeXmP4H5q74dNJBh3jaI57
 O+s5ZapYhIIWnyz5Jdxrtzhv+jzrQoY/3B1rIxb+vbeeadbXPROCpzGUL24yP1n7rbvumvwB4xd
 27AA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

am437x-cm-t43 and am43x-epos-evm are currently missing a u-boot.dtsi
overlay file. Add these in preparation for OF_UPSTREAM to include
am4372-u-boot.dtsi.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/dts/am437x-cm-t43-u-boot.dtsi  | 21 +++++++++++++++++++++
 arch/arm/dts/am43x-epos-evm-u-boot.dtsi | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/dts/am437x-cm-t43-u-boot.dtsi b/arch/arm/dts/am437x-cm-t43-u-boot.dtsi
new file mode 100644
index 000000000000..bb40317cb28c
--- /dev/null
+++ b/arch/arm/dts/am437x-cm-t43-u-boot.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "am4372-u-boot.dtsi"
+
+/ {
+	ocp {
+		bootph-pre-ram;
+	};
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&i2c0 {
+	bootph-pre-ram;
+};
+
+&mmc1 {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/am43x-epos-evm-u-boot.dtsi b/arch/arm/dts/am43x-epos-evm-u-boot.dtsi
new file mode 100644
index 000000000000..bb40317cb28c
--- /dev/null
+++ b/arch/arm/dts/am43x-epos-evm-u-boot.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "am4372-u-boot.dtsi"
+
+/ {
+	ocp {
+		bootph-pre-ram;
+	};
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&i2c0 {
+	bootph-pre-ram;
+};
+
+&mmc1 {
+	bootph-pre-ram;
+};

-- 
2.55.0

