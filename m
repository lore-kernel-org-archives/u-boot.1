Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CA8C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 12:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4155182B0E;
	Sat,  7 Jun 2025 14:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QFKZ2eSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68FA082B18; Sat,  7 Jun 2025 14:03:35 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D9582AF6
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 14:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-175-200.46.114.pool.telefonica.de
 [46.114.175.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BF7664B66D; 
 Sat,  7 Jun 2025 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749297812;
 bh=JnZgTLmE2VIqKXb7xUTxxUVlrbBG8lz5+JUBZIutomc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=QFKZ2eSEUVIVytqScOPCh7k+o3yai5xupuXcUFe5DR4pmmmqqVcE+9+eyV26/wjim
 rU77sQKjCkWAJRZ+77C+bQuXhlLc7AjX7V4BEjKd1IAYNc6dea/ygM7wtA6mJzXr1U
 DPVpO2VPz0LUDbseqltaBaGYE53ALdhMR/o4lktjZYgiz19mk3nGL7PdCdyYxJ9R65
 X6ZL6kgik4ZqCPm3dRoGQg/oXltJKMheHgoB8g3HNF+LrGyuP5poF/Yiim3sTrWTg1
 NuGrzwYw1dYRIFkQIQ3td8rPHFafe0lzZenSVwj1guKVW32IXlNLy36dldhup+CM/8
 bgq40z8dv0Rtg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Tom Rini <trini@konsulko.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] net: consolidate PXE processor architecture type Kconfig
Date: Sat,  7 Jun 2025 14:03:03 +0200
Message-ID: <20250607120303.210990-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250607120303.210990-1-heinrich.schuchardt@canonical.com>
References: <20250607120303.210990-1-heinrich.schuchardt@canonical.com>
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

