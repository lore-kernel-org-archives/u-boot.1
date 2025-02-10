Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEF9C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 11:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F001780AE1;
	Mon, 10 Feb 2025 12:18:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nWjn2cGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D68D80548; Mon, 10 Feb 2025 12:18:52 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3049380A2A
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9653D3FE7B
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 11:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739186326;
 bh=2oC2Ir7pXO6WXDj/khp8oiUQwfdAZz6lvLBIZ+ENruI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=nWjn2cGtLmIGGPdhlFCRIJWlo3IE3YPbIBeoLhZDrVeJse5QS/HXYCUq73iE+nC3Q
 /B2IWUtFPfPWDTrq3a9wwQlk6f9z1JCrHh989CjHo/qxKcYOiTYgrQC4XVfOBJu6tx
 6Ls9gTGazHVlBU8Q0vENyseBcT2VWKe6eGCRCaAtqzqW9Za+3DcUNaxbMTHvL8Q3Tw
 Ao3ljvV5+7yYRJGpPtwcxK9f8w6GbhMWt5O+TaMEmh1yWZ17PCdw5dp3EIYoiCksnb
 h7Q9GZVPaBMqa9fshzcJsY76JztKG3UIRbRAxbsTYrZVQcsstwXwZ2OnPfAh9f9GpK
 Igb4PSaT0P1Hg==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38dda790cfbso904196f8f.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 03:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739186323; x=1739791123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oC2Ir7pXO6WXDj/khp8oiUQwfdAZz6lvLBIZ+ENruI=;
 b=KmawgZrnKEVKxnCZV5zAAQl5/xko6xvK5x7/6UZuCg7tWEfFTaY5F0JQGydgNDWvzU
 o9oc2F82R4MkRcJkAJQnGBiumO0IsSvEMjZ8Ud8juFJ1kUNffe47L9t//CgzIyPfOSgb
 e4fl59OmHkMNKJE2AQOtjzo2khxNLRnijy7erda6F60kVPImBGK4gXGmQ7CwyX68023d
 oFi89+TQKreE3KNuCRUpwsxZht/ZR2JIH0QuyRq42IjSt4Pm2duRbrEu2cAJWOQX92JZ
 L1586WNvqAvTnAo2y/B+nyCxxrpn/q/5Z+x/tZp6rvO+i0868qahXfuWjMZxynQ3qhfY
 aLvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/nQo3fUQpW96yDNZloRJk6Vw5OrkypGvMHQzPfoE3duFIwSA14vOo3kATa9CMS83XhfEqNcY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2NhYYiZ1laTwhadOMDZX5JATNlOWY+K3MVuUDXXFj6oFQAFt3
 juvgqzAYf/SYvm1e9T4d5vgdohT5BJO+igTyijiAmtPLvm9CAb3IcVhi/glUpPqeOblEeSrL69W
 ADe+yqnQy3hNYstGGDuNvHfur5FjPZ3zinsUgnVpcztSYK0BzD2uZEw4/tlpt81HOY1U=
X-Gm-Gg: ASbGnctY3rUKGeVdl06NgwkEyI4EtovYR4+NdRFmxV8T/odVshDHfldWNty9SAZMeCE
 FYhraRkeQRVVuyTJ5s17D8TmIRZdF6TL6VLembebBfUdj730HqAKIDAuXtN4bGa6MbTd18trXmG
 7K2Ngwm/3kAgswOUq5aZKOvGYhMtCK9cQ+8i0IhJ71WhCWNP5iLlyKjkVX/gPWpnrVy3kpeuOqT
 IpheNpHAx7Nbmdynu4K896pJ3TkaGO48f6XNRaQjki4zBSfYWRfIeNZcbWabX0dI6VvTLb3NQmy
 1FGbzigI7Oq+dTCAwwxv9acLGkSPp3/e7Z4ZoT0j+9nSmFDDwTtG46gFgi1lDH5ZvKAb0iKoT4h
 q5GDuxMA=
X-Received: by 2002:a5d:64cf:0:b0:38d:e33d:d0eb with SMTP id
 ffacd0b85a97d-38de33dd358mr384292f8f.9.1739186323210; 
 Mon, 10 Feb 2025 03:18:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx4XZuA2dAc7Z44fLkVDKdPOZcS9It6slCbvamTkycy7uTPmwRBOkog4XJh5mo7JFs0eZsAA==
X-Received: by 2002:a5d:64cf:0:b0:38d:e33d:d0eb with SMTP id
 ffacd0b85a97d-38de33dd358mr384260f8f.9.1739186322861; 
 Mon, 10 Feb 2025 03:18:42 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dda26c6f5sm4194243f8f.68.2025.02.10.03.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 03:18:42 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Andreas Schwab <schwab@suse.de>,
 Nam Cao <namcao@linutronix.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/4] board: starfive: spl: strip off 'starfive/' prefix
Date: Mon, 10 Feb 2025 12:18:28 +0100
Message-ID: <20250210111830.72055-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210111830.72055-1-heinrich.schuchardt@canonical.com>
References: <20250210111830.72055-1-heinrich.schuchardt@canonical.com>
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

The configuration descriptions generated by binman contain the vendor
device-tree directory. Instead of adding it to all match strings just strip
it off.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 board/starfive/visionfive2/spl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 22afd76c6b9..d63eb1abe6a 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -118,6 +118,10 @@ int board_fit_config_name_match(const char *name)
 
 	product_id = get_product_id_from_eeprom();
 
+	/* Strip off prefix */
+	if (strncmp(name, "starfive/", 9))
+		return -EINVAL;
+	name += 9;
 	if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
 		if ((version == 'b' || version == 'B') &&
-- 
2.47.1

