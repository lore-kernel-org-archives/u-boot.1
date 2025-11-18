Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B02CEDD86
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1FEB83CB9;
	Tue, 18 Nov 2025 14:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jAlAgL+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3836383CB9; Tue, 18 Nov 2025 11:42:27 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB6C83C96
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64166a57f3bso8327808a12.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462545; x=1764067345;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NQdKySszMWxZzfLpdSZ/3XPypDh6AjD3noEf0JGmBtA=;
 b=jAlAgL+gWqZLSXTb9cUxxCiptiU1MejlfzTfkptQ9IVT+XwoaHqbopQph6+Yajs3nu
 Q5obJgyQgX9S41fdMdjJlGGjYHLk6+LsviEqFq3iW1weqmsiT72Q152ayxZ3hvGLm/SL
 iWxtM1ubtThKtMizrGR6VN/uncIZh0pTslF+O4a/FlRju80S6NZC65yJdo8rN7yJY2/S
 249nPirM0kHbqO00lnxCo6Q4dbl/eKwHrra3woDyE5/rCWOoUE3265t4/I/NNqpwiaXo
 8B27qtG+hhGJ1iKS4oMJ3wL3+uNO/IsZ2MgXQCKTffeqp1ICBUMlHQV8hvNLnr7DTig6
 zA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462545; x=1764067345;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NQdKySszMWxZzfLpdSZ/3XPypDh6AjD3noEf0JGmBtA=;
 b=dTPNqlLKk7a2MSGy65aq1CHICcJ3xb8c1RaI8Zjd0xE79O6OQZ9apzDxBuChCcVnaP
 M+7cAgLsJjEV0KYcGUu3my+ipz5p2OQgk3W+v/+CLxMVtkAFXlcp1H2LHtzA+v7E4lZs
 WYc5/bFBcf7hX1eiZYWA1QP6ozuPu+k0RUXcRo7X0Q1z9NMBO72ymtxJeuvJO7nuhz2E
 tVFjPfMOI3nobgPtVd/uN5X1j0MHRotTNYuJN8a3GiYpUiYYLwfZx+D5PyFuP3FYUap0
 qpyzucCI5IR7fnRkrDnrS8HxBswPnHHAnJVKKICLFai75ZqrBCJkOzgQthC0AfOp7oQN
 MEBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHWfwb7aNsJ7RTZNoOEPY/V5CDnVAfrrQ+f7FNDQQCnHdV/7E6vVxKfnFIODFaaZJV8KeJt5s=@lists.denx.de
X-Gm-Message-State: AOJu0YyXCZNDxL1XcQxSF7Jq8dN9crOK1a2CO40qLilFHXP3sgxHhbZY
 HQsBu+/3hib+x7N58glXA7jbJ6OoSpVnWwoFjYSAmYQZUJGpK7KtdSG8h5E9Kp5yD5M=
X-Gm-Gg: ASbGncsVzqMEazeYcDnic6O06uJHDWR7SO+xV5oPP8yCLY0GASPgJHTnSmuRhNNa0qB
 cb22eOn/d6yRVAlrDCYqqFnVvmeU26aI5BctecFXyDX8pBURJistQOB/4pGoidxYaZMqKMunu/Y
 l0bI6LJVlvZyqc3qDu3rt1/PncaZ9n4NIl426N3gtOxDQtcnfF4WvbBB9K1+8Al6WbsCsg9sG2u
 Gx30lteZDrVXY7TyXBWpylfRyg4utYPWZZof6qCsrGP1IgtvwHti6Vdii6yX19ARplpq+la2HNS
 PEMACF21ySyrDbLrPU9Q984P3pKANIrRbHIXVPLYXc8QPN5pS6krs3H4bOk48X/eD5o4U7sYsKx
 pPXmSdFXEkRp5wB1ZXtWOR/mf2i51eYTTYLj8gqZX1g1UgysEsEjh4gX4WdK7qEX9HmfR0xjOcM
 A+p3ZaRzk=
X-Google-Smtp-Source: AGHT+IFqXwQYMx0qtclwDLxMMJPhUS9rwDdFAux74PcmMpjp5oQcQbK61hTF9Y7tU0oF5xLyCFC8/A==
X-Received: by 2002:a17:907:3c96:b0:b6d:4fe5:ead0 with SMTP id
 a640c23a62f3a-b73677edc91mr1716415766b.10.1763462544649; 
 Tue, 18 Nov 2025 02:42:24 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fad43dfsm1325153266b.20.2025.11.18.02.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:24 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:29 +0100
Subject: [PATCH 09/15] usb: musb-new: Relative ctrl_mod address parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-9-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=msp@baylibre.com;
 h=from:subject:message-id; bh=dDvD/x/4LymVEL1XBsIubCAquDLmvaK7eVpCHnTgwZ8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZ37ik7AX1r2vEXarT7UX/JCpcFPvhnq6rYN527uP3j
 llrAiQ7SlkYxLgYZMUUWToTQ9P+y+88lrxo2WaYOaxMIEMYuDgFYCKdjxj+Jz1sfv775hqJz/dM
 Ji3bNa/ieNr7LssV3vKtRnUnj95y7GJk2BIx7XmdStXUDfNckjw/SDarbmaY4x8jW3cs/uyuSX+
 ucQEA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

For the upstream DT the ctrl_mod node is using a relative register
address which is not translated by the current code.

Make address parsing understand relative addresses.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/usb/musb-new/ti-musb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index bcd31adba522fc55190fc43fd2dbd2dec93a2731..d3c3d3057c1df2a5cc62df3c57d8b071bb0f12b8 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -93,7 +93,7 @@ static int ti_musb_of_to_plat(struct udevice *dev)
 
 	phys = fdtdec_lookup_phandle(fdt, node, "phys");
 	ctrl_mod = fdtdec_lookup_phandle(fdt, phys, "ti,ctrl_mod");
-	plat->ctrl_mod_base = (void *)fdtdec_get_addr(fdt, ctrl_mod, "reg");
+	plat->ctrl_mod_base = (void *)ofnode_get_addr(offset_to_ofnode(ctrl_mod));
 	usb_index = ti_musb_get_usb_index(node);
 	switch (usb_index) {
 	case 1:

-- 
2.51.0

