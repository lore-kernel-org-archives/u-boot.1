Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04B1C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286788855B;
	Sun, 23 Jun 2024 22:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HAjtyXLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 487C0884FF; Sun, 23 Jun 2024 22:30:44 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4B787572
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-36da84df7adso10039995ab.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174641; x=1719779441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lq3h+GuSAudu1LsYAUPVwxxmFzpl9EXiEjgaRzLffT0=;
 b=HAjtyXLF0bOEiJc/5jjERA53mgGUbMYngY/tLeg0l5QdlESFzKr+z2Kxz/hWeC8hBn
 SsxktUD6bJR56yHE2Wk/i/PJXpbEBu2ooRqN6vuzdt2WoF8e7ZTz3Uoq/vL3vwfqzAIb
 7jDtWA6ssrBnmRfTl0CrLYR0bGe6TxEILPTXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174641; x=1719779441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lq3h+GuSAudu1LsYAUPVwxxmFzpl9EXiEjgaRzLffT0=;
 b=VXBuvKiTadwKnd8m5lmMTB6xZD/ge+njKAG97nD4EHRgqx/bEM6RmGgRgveFVPjDjO
 5Qiuflu2olFAuf+Gf4lqyBhrZqnXyY4ptZRuLve6GOSTyphgnHOVKOs7RLeeQJG/AEeI
 BUqoQeqCQpj0xdEXl1hY4RaPvakYp1kstwI63tbPkxB7cB5lhlX2XOEHgkewRJxzlzPS
 Tb1OJnm8W2MVeG2X8oiVhhuhUWFRNZtZeaDNdTkk1z7wTRpHZ0LZvqB1EXfeDbmJo3g0
 OitqB2mY0MLLjOIbxsKVPGZbJI9tNYs3Kzu9znuNifjk6fQKqnLjZBAt2G0XanVmOFal
 ko2A==
X-Gm-Message-State: AOJu0Yxf43l/yx6rdOng5dNLI3eHKteMS8yEUvQesEunIjzo5V2gErcc
 KmnM8OhBLiBOplwCsJCBkB1MmM0Kv3qMN6c/dggTd4huRisCnlo8EOKZ41xGF8kBqg1x4FUNEKe
 cxw==
X-Google-Smtp-Source: AGHT+IE+TWt+QNlTLH/90jZ6UoMZDlfxwZX9QE7u92qNdK12juRomUx2jeGmyUU836ipvAL3GWGyWA==
X-Received: by 2002:a05:6e02:1845:b0:376:2a41:5f42 with SMTP id
 e9e14a558f8ab-37639f690f6mr20615335ab.10.1719174640761; 
 Sun, 23 Jun 2024 13:30:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH 05/14] sunxi: Mark scp as optional
Date: Sun, 23 Jun 2024 14:30:24 -0600
Message-Id: <20240623203033.1566505-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This binary does not prevent the system from booting. Mark it optional
so that U-Boot can be built without it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/sunxi-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
index 0909a67883e..e1a9a7f5d4c 100644
--- a/arch/arm/dts/sunxi-u-boot.dtsi
+++ b/arch/arm/dts/sunxi-u-boot.dtsi
@@ -90,6 +90,7 @@
 					scp {
 						filename = "scp.bin";
 						missing-msg = "scp-sunxi";
+						optional;
 					};
 				};
 #endif
-- 
2.34.1

