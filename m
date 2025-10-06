Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B24CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C8D83DBF;
	Mon,  6 Oct 2025 17:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eBbIldhl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E989483C98; Mon,  6 Oct 2025 17:20:08 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25B7783DBD
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso3862344f8f.0
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759764002; x=1760368802; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nkstG0FDixFiosIwfzzzTVdR3bt6L7lhWRi9T8Pai3g=;
 b=eBbIldhlzj6W8MvKGt7tXWG+wVpKWpCCcGhXp+WxxxKW5UtaCvYkpE4fmSAhx+6dV+
 TGjUhjz8XIzQzLKQ2UhQt5gqlEQHAyhE8jM6XHPM9A5tQ/f2LWGOxWzoZD4wTi4IVyeA
 M7UpH6RTRTePXao319gLjWJfN8V7knR3T5i9ebNQVcSqlS4u4bZ0KBfZQ6e14PhHBdWY
 aGCbOBXrHB9euRd6KpwiiYSH+1CYAlf9KxC3awoyfqVu2gc6LOl+p9gntYuuil72Mb/z
 snewN4adibvcW5A6iG0iaEe7iK7j6aP2SK1I8W0uL8c7GFSwlXuWKcydgAAr7spyo6od
 yTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759764002; x=1760368802;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nkstG0FDixFiosIwfzzzTVdR3bt6L7lhWRi9T8Pai3g=;
 b=kda20WVAKKQTPNMkH5fIwzWqvpIP8nzp0vcRvTGq2R4KnUtEANxU0wzcKllwOXGt4+
 yQGqAalw5X0CLU/Cpi5bGKIWFUcoavg7LmrGoCuDMO5dShe7Tx7qJcJqg/53Z6ZTNXnm
 GJJ6UlhFKuFh4xYHocIyoUbkkzBy9QJIiph39LS6jKrrGCsHIvObp6Ud+SpjUg38pzrq
 cKJKVcdVtC2p4RyUk0wJy1h8AIMPnLEgfaj3raotDkM8vTaINsTG2kT2+LE0gdWhxEZ3
 gWwVUQuVHrTfaAQvp8EAf4OJfSTfxnwRUFiA30HuVnaeUCY1Bjw/iALrDQLFjA+bzt08
 5DLg==
X-Gm-Message-State: AOJu0YznJGBLxTVMe1uYQ1PAHzYWk7Ej2dkOsa25iAKyuWRVCKBYDdSp
 CqhnFAwxPanFR88BS3OC6fbl8TimDSd6Q7FiOcIsAl7KQucdx26mnpzxdgY198WLPFM=
X-Gm-Gg: ASbGncsTmCYX5C1lJ5EBEPiL9cph4v9+8n9y48kode3fqA7ATofqemAujWY0o9SdrNT
 CfqAMabX6oKV5YNXE45wJAbrBtZND+TjsF7MLBk57MugkEVPlcUacWOE0OCBkuyQirnuqC7Qu2r
 k2Cfkah9fh2bL0VfjYX4fxAT8t0OUd2PQpRArJeqAusiWoAU4AmcUnu1YpgxHRkG8C8hrXpKFgp
 JjFm7tmmE6IkuR32W2vV25cm1Sjuelrzgc/V9wSMCgd3Gyhw01aARe3FY0BLKxA04cs4/1Ihk0g
 3zC1cfdPhoIHOmlgFHykYb506Cj7bPE55fQyKlinznYJagJ1LG5kyLZg2iKEhC9zD1hqH7IP991
 mq6B9Uu8zKo5YdeKoyLhx6NSQ91ZzNX9G3XFn9H+SQk2pK6ILziNhD+QA2qcxXyiGWH4xeIoWGD
 U95s86Tnc63syd
X-Google-Smtp-Source: AGHT+IGc6QR1HV/Ceho+b7PL5FJN4BV4wxc7gArfW0mu8mBEn40aWpSXYwytx4FKX2cd89jDQWVEfw==
X-Received: by 2002:a5d:5f93:0:b0:3ee:1578:3181 with SMTP id
 ffacd0b85a97d-425671c0c13mr7512023f8f.49.1759764002506; 
 Mon, 06 Oct 2025 08:20:02 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:d8c:ebdc:373e:b4a0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8b0068sm21304971f8f.26.2025.10.06.08.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 08:20:02 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 06 Oct 2025 16:20:01 +0100
Subject: [PATCH 3/3] ti_sci: Pointer is never assigned to
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-ti_sci-v1-3-9cef92e1022d@linaro.org>
References: <20251006-ti_sci-v1-0-9cef92e1022d@linaro.org>
In-Reply-To: <20251006-ti_sci-v1-0-9cef92e1022d@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, 
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

The pointer resp is declared but never assigned a value but is then
dereferenced. Fix this by assigning the pointer to the message buffer.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/firmware/ti_sci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index bd8a8f6c6b35e9038f5fb9927927d5b664ae5a3a..6def152f00a9442fcd0037c8f4032235d8c7fdab 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1365,6 +1365,8 @@ static int ti_sci_cmd_clk_get_parent(const struct ti_sci_handle *handle,
 	if (ret)
 		return ret;
 
+	resp = xfer->tx_message.buf;
+
 	*parent_id = resp->parent_id;
 
 	return ret;

-- 
2.47.3

