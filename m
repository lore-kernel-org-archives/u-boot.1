Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416B7CED63B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6420E83DEE;
	Tue, 18 Nov 2025 14:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="afTq4biD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B68BC83C96; Tue, 18 Nov 2025 11:42:24 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C76F783CB9
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-640aa1445c3so8252634a12.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462542; x=1764067342;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rMrqmMRYbGCsgJCJH7r/afXhZIz7oc+1EcsqXN73icI=;
 b=afTq4biDdnSsYoTHVdEPqrxv7LCF/q5U3VU4CvV/vzQdJvdEUYN0WIPh51iBDuYUUj
 En9MR96ploB9j16U1qvRj2cvkvouV0uTYHn6QFVX2PSBH+gkazZz9h2rcHC4T/ofkuP9
 b395Bh3tYJayiO/dAV9VKAe35muLsyTgh00t9A3lNWDaXHRlEX1IG22azRVGU/R+bPoG
 XYVbM5FIAtS2SNtCkSWwvk0kVw21lLWziZ+DcxODxo0ZL9U/uZMU3rhEAXlB/fT3xLbx
 EilhMZElDqqQLZceJTANFQTLiAhMcCLyx14zxMS+rs++HXjWEAmuZwkXTl0FTnZMmuO/
 oLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462542; x=1764067342;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rMrqmMRYbGCsgJCJH7r/afXhZIz7oc+1EcsqXN73icI=;
 b=f6c+lZxhjFfQREUuXVi3IrGxVL0jufjYb2ETYH9sB8bZ2aqd/mQvNPVNYddIDSLYxP
 2jJHoS9kcU7mgCMwsio2wGSnNNaqxoozbZSoX+qB9DwquA8VjbFTm1dA73y/tfTZninj
 vaAgc9JSmvRLA9AZzOdpjk1Pedkx0s6jqNP+6fjhqppwZp6hgSy/CmKOoLlqV8ZS+xsc
 rvbsBDUJJSisywnnPPyZWGs8USpp1oOQ4zYITk12o8pgCQWb7sgXNJxufUH0iDaIXz1e
 BiwS9KRCR1l0z22GClRHzSEv8XkRy+Owv+D60SwVTiI6yWgRj2F0BCS9eEsnpQAxWe7L
 9+eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx1OC688OkpmSw1IhczyKS+bdUtchG5lFWq5rqHWP3mPLgMAe9jWLLPNa5WwH/okMJFepVcRQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6UblWBN8aSxUgLkKZ3Bfk4q2IZMz/xqHtOkCYotdPFyjIPY8P
 693hyMN+jBfTqB9Y8SAJqG2XP3J/uOwIM0qduU0IwUnxNxC8c1fybbA5WlYDOYFpc7E=
X-Gm-Gg: ASbGncv9XEepaFNhkC7pW3g7wPyIA9Zxcxr/hSoBSGyJWVaatFuTWaldzXmUmmvhr+Z
 2lZU5qjKTcpeVrO82XNan3lwsmTNr/3sXayi0o+DlmIFDhKdig8oSpHdDsUqjKia+n4uL2hM4xH
 3H7PcW+ct9eot8qzNSLIOGdI6l14mNJlQCzYRRdB8L+pc/RRKxTyAg2v9KEvUlRY+e53Aa43ifw
 scqP4ZCvq3vCilZN4HlhQLqws4ul2wu7dX5ew6o52I0vuQq+Po/8LuroerJ72L1Zm9FkdtIugWZ
 uCRlScX9en9eOjjbQWR262AVJsGFpq8UnU1XRlod/etx8/tK7g4N+KTey2rnFRdYoQoH30TTC2W
 WaVFAyRiNB/f4Jjlpjg2sgThNDyhj0X1XKkDq5xqMQeZ9ieqRV8KyGiHBOUP5/+3cGjsrfNxx
X-Google-Smtp-Source: AGHT+IEG9duOwF2RUzM5PJX9xZGsFsXarc1y4+WJXLdOwvdZ9az+YjbmX3qAPxJ1gFMi2YS5eUtBDQ==
X-Received: by 2002:a17:907:7e98:b0:b70:7e10:4f4b with SMTP id
 a640c23a62f3a-b736780b437mr1794673566b.18.1763462542239; 
 Tue, 18 Nov 2025 02:42:22 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fda8d69sm1303892266b.50.2025.11.18.02.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:21 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:27 +0100
Subject: [PATCH 07/15] arm: dts: am335x-evm-u-boot: Add chosen tick-timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-7-91ce13c661e2@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=695; i=msp@baylibre.com;
 h=from:subject:message-id; bh=GIe+BiYG+LjgmFawt5AXEJQkjgioEcRjJ5oloAhP9Lg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZ35Dg2lLFG2VOEdLR55Ty9xZ4aH14dSzfxiAt43zZ7
 x7Wkyc7SlkYxLgYZMUUWToTQ9P+y+88lrxo2WaYOaxMIEMYuDgFYCLbDjEyfL+Q/+TmMq5zSyZO
 Tvl5/OeJoxPNljq5b9oaLLruxr8dvFaMDM9+GooKbf+y71327csMFzX95kboFikuL982LYkjt8P
 RkgkA
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

The upstream DTS is currently lacking this information which is
required in u-boot.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/dts/am335x-evm-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/am335x-evm-u-boot.dtsi b/arch/arm/dts/am335x-evm-u-boot.dtsi
index 72402c82928a72abe3847bfcc0771dabc571d8e6..2ebf60bf7d6ce007e033b75a25a10c60a83e218e 100644
--- a/arch/arm/dts/am335x-evm-u-boot.dtsi
+++ b/arch/arm/dts/am335x-evm-u-boot.dtsi
@@ -5,6 +5,12 @@
 
 #include "am33xx-u-boot.dtsi"
 
+/ {
+	chosen {
+		tick-timer = &timer2;
+	};
+};
+
 &l4_per {
 	bootph-all;
 	segment@300000 {

-- 
2.51.0

