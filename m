Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220E7C61CE8
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 07:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 807B78144A;
	Sun,  8 Jun 2025 09:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TQ8ea8B9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95F8582B07; Sun,  8 Jun 2025 09:42:45 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53AEB82A65
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 09:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E6EC44710
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 07:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749368561;
 bh=JnZgTLmE2VIqKXb7xUTxxUVlrbBG8lz5+JUBZIutomc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=TQ8ea8B9B75eeTxxsJisDeiUJ8hnQnmZJkrjNinf+leVi25ccTOcnvv7NeFo2LWl/
 hRUMRpWfPfOQx5jHMq5MoMAEmCXWP9nLbVmdkX1Dg9JF+ZFsGZN5gDAd7xDxuLBc9q
 J47NU4fm/SnnoVHQAItPMmFhNDg0SUaTSNQchclV5/XMCTbca51QICZ2A9NRJeqv7g
 4icRg9EOKYQ6cpBgL/UG+/iu/EPlhHbN+jfFsAH+e34/xi4+YI08XMMi7cG5pr2+A+
 s0R5KyYwGKvX4p5MlAGmeO4vpn3xId89FEffyHPeR/YbP60NhCdYfTITIHc2AzunQZ
 dE4N5FnUIm+uQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-453080e4741so4420725e9.0
 for <u-boot@lists.denx.de>; Sun, 08 Jun 2025 00:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749368559; x=1749973359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JnZgTLmE2VIqKXb7xUTxxUVlrbBG8lz5+JUBZIutomc=;
 b=MFGMV4yAzHVHtmMYbwSOIkYNoR1BClNAtb+WYn/DgzBMJuGXUH9FVIXjkzE4bZ7dt5
 4JLwjySAWK4MbGqICq+N0ezCxQbhotsufkhRoXldiNOC5hnvjDAaN6O1F4k0ugsGzUmr
 LSJW6UHwgjrdt+jCit2OYzCryRnKBF7pHfC7LioHkSs6e3MesDGi7bFPGQPeh4626sk9
 ygXs+/gOglBm8zd0GVmUAYww59CMR+6n2KzvslrXxOlRthZ9rbHKEo2ajWEyQxd+klXI
 Mit/Kv3r4igSeSMTT0r2rfVfZUDIsJ9w9drot14Rk/bdKPV1v2kaxrJYTCmcdZn7fwnJ
 j6jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9VfJ/5xvOi3BAff2J1+n6UeglSXBWcFfAf8BCCOZPuLmUeycYTiWtKwoADs+9gmf74sNvrfw=@lists.denx.de
X-Gm-Message-State: AOJu0YwyfSlFr3E1PmW0wmq6okCcW5A0Fw9DB7Ach+HKVV3eFlmwUDIr
 C+w1ztyc7sPKpWTVMTLvDCWWDrQ3b3gmU1uLslj2i4TR9exL+xv4cX0bjnK2R7UtmbF+nNcRS9t
 u9tNWmpnOra8z10qXD4prNfATMzGHrghIs41I01i06ZeXi0fH1w23VmjyFZCrPmSQtR666Eo=
X-Gm-Gg: ASbGnctwU71spzQ3fS3qARXDehylFWXW+bgo/QEyHZSNmtaOo9vgFky9IdrcoN66xeu
 Kp+WBn9kUlHmWp6T39QqhhvH68gZc1f0lZrh1i/bd/TJcsiOu4NyM9YsHVTWhQ2fAx4Gi9J2wtt
 WhCl4kRo5z9548MSyjCzhwtrC495QVH5inrhmJMO2D4FJyELGlXAZnNdA3VwX5PBMg/xrRr5Of4
 bP7wwGsshJtuYcoHGGWqPvhJCeUc9dmtU/+LXoyxgVaxjz8Ng4m1bCKmPdtBhUGGc2TMeO/ma6U
 aT2WTeXrM6uaajxNmA5saw3frdDjNeAZEtfG5apW6ifSOmHdB3d212voYXicOgh9CULs3qf3JcO
 Sf8+6izP9H/Pbf2r5QBmID095
X-Received: by 2002:a05:600c:1d28:b0:441:b076:fce8 with SMTP id
 5b1f17b1804b1-4520138d52bmr80977595e9.14.1749368558735; 
 Sun, 08 Jun 2025 00:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7RCvnnYyb3rs1lEfyq46kJiAH3lTRkEOmbfAK9E0Pn9tlGB3lacTkh4nAfC6ei5VM3WpyVw==
X-Received: by 2002:a05:600c:1d28:b0:441:b076:fce8 with SMTP id
 5b1f17b1804b1-4520138d52bmr80977405e9.14.1749368558347; 
 Sun, 08 Jun 2025 00:42:38 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6c6csm78285635e9.2.2025.06.08.00.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 00:42:37 -0700 (PDT)
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
Subject: [PATCH v2 3/3] net: consolidate PXE processor architecture type
 Kconfig
Date: Sun,  8 Jun 2025 09:42:28 +0200
Message-ID: <20250608074228.12407-4-heinrich.schuchardt@canonical.com>
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

DHCP and DHCPv6 use the same value defined in
https://www.iana.org/assignments/dhcpv6-parameters#processor-architecture
to encode the processor architecture type. We should only use a single
Kconfig symbol for both protocols.

Furthermore we should make the value customizable. This allows for instance
to choose between "x86 BIOS" or "x64 UEFI".

As "x86 BIOS" is encoded as 0, we should not use this value to switch
off transmission of the DHCP option. Use 0xFF instead.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Kconfig  | 28 ++++++++++++++++------------
 net/bootp.c  |  6 +++---
 net/dhcpv6.c |  6 +++---
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c335eceea63..4eb0140c10a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1864,12 +1864,6 @@ config CMD_DHCP6
 
 if CMD_DHCP6
 
-config DHCP6_PXE_CLIENTARCH
-	hex
-	default 0x16 if ARM64
-	default 0x15 if ARM
-	default 0xFF
-
 config DHCP6_PXE_DHCP_OPTION
 	bool "Request & store 'pxe_configfile' from DHCP6 server"
 
@@ -1977,12 +1971,22 @@ config BOOTP_PXE
 	help
 	  Supported for ARM, ARM64, and x86 for now.
 
-config BOOTP_PXE_CLIENTARCH
-	hex
-	depends on BOOTP_PXE
-	default 0x16 if ARM64
-	default 0x15 if ARM
-	default 0x0 if X86
+config DHCP_PXE_CLIENTARCH
+	hex "DCHCP client system architecture type"
+	depends on BOOTP_PXE || CMD_DHCP6
+	default 0x16 if ARM64 # arm 64 uboot
+	default 0x15 if ARM   # arm 32 uboot
+	default 0x0 if X86    # x86 BIOS
+	default 0xFF          # DHCP option not sent
+	help
+	  DHCP option 93 (defined in RFC4578) or DHCPv6 option 61 (defined in
+	  RFC 5970) is used to transmit the client system architecture type
+	  to the DHCP server. The DHCP server may use this information to
+	  choose the boot file. For a complete list of assigned values see
+	  https://www.iana.org/assignments/dhcpv6-parameters#processor-architecture.
+
+	  If the value is set to the reserved value 0xFF, the DHCP option will
+	  not be sent by U-Boot.
 
 config BOOTP_PXE_DHCP_OPTION
 	bool "Request & store 'pxe_configfile' from BOOTP/DHCP server"
diff --git a/net/bootp.c b/net/bootp.c
index f22921ed388..95d906e3b2d 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -545,14 +545,14 @@ static int dhcp_extended(u8 *e, int message_type, struct in_addr server_ip,
 	}
 #endif
 
-#ifdef CONFIG_BOOTP_PXE_CLIENTARCH
-	clientarch = CONFIG_BOOTP_PXE_CLIENTARCH;
+#ifdef CONFIG_DHCP_PXE_CLIENTARCH
+	clientarch = CONFIG_DHCP_PXE_CLIENTARCH;
 #endif
 
 	if (env_get("bootp_arch"))
 		clientarch = env_get_ulong("bootp_arch", 16, clientarch);
 
-	if (clientarch > 0) {
+	if (clientarch != 0xff) {
 		*e++ = 93;	/* Client System Architecture */
 		*e++ = 2;
 		*e++ = (clientarch >> 8) & 0xff;
diff --git a/net/dhcpv6.c b/net/dhcpv6.c
index 0c2de75ba1d..5bf935cb6a3 100644
--- a/net/dhcpv6.c
+++ b/net/dhcpv6.c
@@ -128,7 +128,7 @@ static int dhcp6_add_option(int option_id, uchar *pkt)
 		break;
 	case DHCP6_OPTION_CLIENT_ARCH_TYPE:
 		client_arch_opt = (struct dhcp6_option_client_arch *)dhcp_option_start;
-		client_arch_opt->arch_type[num_client_arch++] = htons(CONFIG_DHCP6_PXE_CLIENTARCH);
+		client_arch_opt->arch_type[num_client_arch++] = htons(CONFIG_DHCP_PXE_CLIENTARCH);
 
 		opt_len = sizeof(__be16) * num_client_arch;
 		break;
@@ -194,7 +194,7 @@ static void dhcp6_send_solicit_packet(void)
 	pkt += dhcp6_add_option(DHCP6_OPTION_ELAPSED_TIME, pkt);
 	pkt += dhcp6_add_option(DHCP6_OPTION_IA_NA, pkt);
 	pkt += dhcp6_add_option(DHCP6_OPTION_ORO, pkt);
-	if (CONFIG_DHCP6_PXE_CLIENTARCH != 0xFF)
+	if (CONFIG_DHCP_PXE_CLIENTARCH != 0xFF)
 		pkt += dhcp6_add_option(DHCP6_OPTION_CLIENT_ARCH_TYPE, pkt);
 	pkt += dhcp6_add_option(DHCP6_OPTION_VENDOR_CLASS, pkt);
 	pkt += dhcp6_add_option(DHCP6_OPTION_NII, pkt);
@@ -244,7 +244,7 @@ static void dhcp6_send_request_packet(void)
 		memcpy(pkt, sm_params.server_uid.uid_ptr, sm_params.server_uid.uid_size);
 		pkt += sm_params.server_uid.uid_size;
 	}
-	if (CONFIG_DHCP6_PXE_CLIENTARCH != 0xFF)
+	if (CONFIG_DHCP_PXE_CLIENTARCH != 0xFF)
 		pkt += dhcp6_add_option(DHCP6_OPTION_CLIENT_ARCH_TYPE, pkt);
 	pkt += dhcp6_add_option(DHCP6_OPTION_VENDOR_CLASS, pkt);
 	pkt += dhcp6_add_option(DHCP6_OPTION_NII, pkt);
-- 
2.48.1

