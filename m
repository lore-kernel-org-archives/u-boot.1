Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAC4C5AD49
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 07:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37CD3810EB;
	Sun,  8 Jun 2025 09:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eTWjzhCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D84F82AE9; Sun,  8 Jun 2025 09:42:43 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2FA7826AA
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 09:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 55AF54470D
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 07:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749368558;
 bh=CESkNIe1xIzpMv76k8Lbwa9JcW8V3fAoxIyg1DjjCxM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=eTWjzhCYil45gTi+PGXHokPYqD6dtcQOXkzZ1+p/nIPF9HBajB7w7D4kSJ4KND2WL
 UNVvzSr2C5KYu8KFzn6sJ6qIIz1GpO4fnY1qVdxYY39dJuHx4ffNcjLgAIVLxHUSrn
 ZMhAsYV6mdEG2VLMrwgXhMmdShSwG/TQRNYWwK41C3oQA56V/Qlv0V7ExRtEAZRXNq
 Be+ijlEzaePL1qt/v+ztvwbJRTJxeSl5vql+/t6uL05nWKQCYfGFsium3TMbHD1uti
 1XSfYu2zEfiPY79NuPdBv4WM2zIeGntBsHpEgCH2LZIYV5k1ZKVralCZJ/WIkQaDqq
 xN0wh1azYsmuw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a52cb5684dso1683537f8f.3
 for <u-boot@lists.denx.de>; Sun, 08 Jun 2025 00:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749368557; x=1749973357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CESkNIe1xIzpMv76k8Lbwa9JcW8V3fAoxIyg1DjjCxM=;
 b=MnarjuB6u75/Rg8oWq2VXhQSFUTUJfU7h9bNbCEKl/BSJA2+8A0l5fyHrD/XG2oMW1
 964Q6ychjOrcwuWy/xwkP1h63kCpb9ZZZr0NIlU6+1vdzQgdncEORre4BjDszak98eaR
 le9hRbrKg4vXcaxGcmC3gn151+mIJUbB8/mGzjuUUjVgMbp5DuCHuxZXg26rT9J+vIny
 BGxdKYr16gipJyl3Oe8tAP90tfDm1hgm0Ad20LP3ufT8WiQcAKEO4NjomkBnD44Wh33Q
 yWfJpQNBfHgLTBVtpAYe5Kuk+9GaliF6C+Jq1sOVxVSW7953F+rDMBdYXN2WM+U3U69h
 ZgSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFIElsSnaYVcLiFfYgwXVYMPbmUaM6AuzwepBc42U9m17c3cn7i8oQkMTvj1tN4hlk1umjEzw=@lists.denx.de
X-Gm-Message-State: AOJu0YyWMl2dXFsRYsuOXXEScZf+9eYBmzHhu5/zHdAa5Z4+SG2fAtwr
 QCwLMGRtETjK2vxza8TQfya0AglhGJyH3ke2B1ZNq+DXOZM/QKQ7ZU9UHLSj21uLFz0U/LPSM6K
 Y5TYOTm5No1IfbPkDlWt3Dz5pl19qE03eU9zpl4b1P+yrXxXLlH/kYZ7sDkn1nbOVir0kwt0=
X-Gm-Gg: ASbGncuSsUKTKKNYa2mTYLWWX7gY2GVEb4p+o+wvJfIwcth2JcLPZWrkTzbQC+fzFrs
 69WYi7AMSe1EEIMlKEZs2YKJtZej/TbnTkbjt2Rs3kFYkByKkumjdFR0dd0oIhTA6ljOWPA5nND
 mIf4eGUDEHjJnYYtVsvS5NQCA4t9aCGNXQNMp5ApKVWaoTLVzhoaHCdbYsgtI11WHPE0pjUCCBc
 HNhUv4moi5bpindueDc5RiitvzsgMY28CyElE09hIohmVPJP1trrfDAL7X/efP84hNqxCGqZWcC
 ah2o/kv4wxwg+CWrp21Wdy3H66R00OAAeJAM+OwuhPf0dtMSdGFRWx4sUpFbz2oOTulAeQ5cspQ
 FX2gQ0XKIkN98h4ogQ/Fpe7Yx
X-Received: by 2002:a05:6000:25c2:b0:3a4:f50a:bd5f with SMTP id
 ffacd0b85a97d-3a5319a2a11mr7487523f8f.31.1749368557333; 
 Sun, 08 Jun 2025 00:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKUg5SZs56u2misE0JRDpuniyEYK+2FooIkOBkCzuWJNklp6ZIATGXTDYZ/NbR/KWQUW+6kQ==
X-Received: by 2002:a05:6000:25c2:b0:3a4:f50a:bd5f with SMTP id
 ffacd0b85a97d-3a5319a2a11mr7487508f8f.31.1749368557012; 
 Sun, 08 Jun 2025 00:42:37 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6c6csm78285635e9.2.2025.06.08.00.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 00:42:36 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/3] cmd: remove duplicate DHCPv6 Kconfig definitions
Date: Sun,  8 Jun 2025 09:42:27 +0200
Message-ID: <20250608074228.12407-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
References: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
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

Remove duplicate definition of

* DHCP6_PXE_CLIENTARCH
* DHCP6_PXE_DHCP_OPTION
* DHCP6_ENTERPRISE_ID

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Kconfig | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ed741d43cea..c335eceea63 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2004,23 +2004,6 @@ config BOOTP_RANDOM_XID
 	  Selecting this will allow for a random transaction ID to get
 	  selected for each BOOTP/DHCPv4 exchange.
 
-if CMD_DHCP6
-
-config DHCP6_PXE_CLIENTARCH
-	hex
-	default 0x16 if ARM64
-	default 0x15 if ARM
-	default 0xFF
-
-config DHCP6_PXE_DHCP_OPTION
-	bool "Request & store 'pxe_configfile' from DHCP6 server"
-
-config DHCP6_ENTERPRISE_ID
-	int "Enterprise ID to send in DHCPv6 Vendor Class Option"
-	default 0
-
-endif
-
 config CMD_TFTPPUT
 	bool "tftp put"
 	depends on CMD_TFTPBOOT
-- 
2.48.1

