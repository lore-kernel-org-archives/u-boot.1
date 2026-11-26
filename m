Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5E606A334
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V6DQWDEX;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f1MJ9zlp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BD53409F1;
	Thu, 26 Nov 2026 13:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6iTx8RlTCNZS; Thu, 26 Nov 2026 13:33:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A1524409DF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700009;
	b=p1AcV7oB9IU688+xju/3mgAg0UZNC6O8P/Jkm+bRopvYpYrDSV4PrBrQMWiyNQTG0l/u
	 gFD41OgN6bha5gdc5eWH8cYycgQ8ULDJLx5cN7ds3qEIP7ErpGx23BeQ4C48ZU/28go6o
	 auyLNVHygl+6BIAKg3vRy4svrCVG4z/2UrkYazouLMt0AK2HrzQTH4JMZtw3BBi/sWeuy
	 Ozry7TKcsCnJt3Ajc/ZN9VOs+Mx0zgTUKaQ3zcBlf/43k1wSHsiYNvRHDCwQ5O5dn8DRx
	 7+xiGssodheMigWPp6zf5xiyd4p76cTFEFw8QG6SUyT8f6m6014tI9mGwMmYMOy2cgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nGeylHJeKZM5qAH9Nhfd674ujF4DruWZHxfQ6kBsQ94=;
	b=tXpg6DCQsmMyVn+gtbFmpk6aoL9Qu2Ljt6H/AM5R3clppFxqO9/RsS5AXFYhyBmvG8v7
	 U5hsIudLE8XZ3uONNjs74jVxYwTtXosJfbD/lD0vSFAn5nh81dRjszWUtOMPLBniVletj
	 pDkkHE2gBTb+gDP140BYuNEhMh0s6NM1W1w7rXV776UuL8j09zvHFa0CDKhyZmbxXy9pY
	 mtCk1YRy5f8VitqfsdoRblFTx2J3rfYHX7ORhMnNg4GogE/E3BduGXFPN8A7iflFxuKOm
	 92cfYQM6l2pBJxCj+R3Cpw3Cek9ME2K1yj93BHa8M7++9DELVrqdZVqfBRHo8sNI4xA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700009;
	bh=nGeylHJeKZM5qAH9Nhfd674ujF4DruWZHxfQ6kBsQ94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V6DQWDEXWmyxbew234Pf1OPBmQF+2Z6q9mSlNyN4+msDwehCE7+jcqw/GigjDCjPp
	 Uy97KxiEAXCJHTiap5iulmYrfilnVU1IASZ8E0GuCIaMdOTtKOTHZHxzyQhISl2de/
	 UQHgMUWCBRK6IpZfFXB6AJ6ENQCEELw5VKL6c15QvKz1AGYeVq8AuuUaAOPung9NH/
	 Avua6/Nray0wDvkhOkDXq2xFPyvV0/bMOwNyXa3rRK9myQtKPQ4HUVCXzNhrbH7i1I
	 hAA7t+jf1ggar6OkhlxLxdnjIleDuoxsJ6+fcu9mxhxVN05+jB4nuha1TUn6udibw1
	 21bHJmmf+V/oQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1524409DF;
	Thu, 26 Nov 2026 13:33:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A541260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C2A1809C0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbzHeRtRAlDw for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 37723809EE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=f1MJ9zlp
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37723809EE
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:18 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-86298f9267fso3535493a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795675998; x=1796280798;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nGeylHJeKZM5qAH9Nhfd674ujF4DruWZHxfQ6kBsQ94=;
 b=f1MJ9zlpsxkJzKiYXBGmysRrinV/oi0i+m4JXoSmckU+0ttwlK0io1AO581iu2iwLa
 Ak+ai4kYbYGoQQKwAQbDYj3m5H/C93IAtPp1M4lKtgjWP/gUf4wqD0M9j5CLPDGlH4Zx
 /6+QN9qZZfE5vYJr5PGJtbBJMVtl1foZFCh3A+wUFCzVXzglEbf9qUIL+g5jcx35oeoD
 OiPHD/lOzHcgYfsVrYK5nSqSQ2hjECKq7mQYgod5LM7m1v3mjl58grUbqQJOxul3bVb/
 1ZDlsGOl/KRXNdmz9Ijq8V4mFPLPGRuh4sEYDaMUu9hgXNa9ukgK3aUnQS99oPdK29TQ
 9jUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795675998; x=1796280798;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nGeylHJeKZM5qAH9Nhfd674ujF4DruWZHxfQ6kBsQ94=;
 b=locFZEyVZpXuP3StGfZ9VcJ1DFAgxx+VJY2SoIlzJjMoBOrSzu/GDoznXbXWk4u7A6
 lxUH6iypf8Wtc/Y0usHBkAFyKRjX3QDfaVRb6w7pHJZhd9BM5AJjwZOPgp0GPH9nkQB4
 d4PQkPpTLxICg7dtqw+TV6W9Cde2fgk3yQd4oDHdaBsH/yvtbTbgQfy70PJx2QnMq5y2
 sGaR/XsF+cmwubPZbv4qzZwZc5okDWc63RvXgK2+l7egCuV/OtHOGi9WzGV+SXeO6MbD
 YJ4P2PKn3jQHjqyXHFJUYa4VQRTqImRjPc3okpxl3JqfLgdh4o5ykUa1dWEq4OjI8dQP
 nfFw==
X-Gm-Message-State: APuU4Z/q/JwVc7TJnzZoe5m5AX+9z59+1DueVzL7dELlMWIEwABpyWHq
 /UZTvJMWqSvbdHRbwmHWO922lC3dD+mog9WZK4RLCfJYLg9n8lHFViSv
X-Gm-Gg: AZFdTZcEbtWNAq7SRs970oYvTBq5dszahgeBknztax7v2BQ14kTc8EkmgaUukB62wSK
 gMcnO94ipc0oc64/DrRe+Jcv2JiDM7krfOqWGgcjJ1mXJnyTAigtK/KhCEKoGNFXwPO5zJm2Yfy
 5m2FA9Mum+Jdeeh2IxEarDXxggEsjdcAEm+TYsERfi3OQrZcBIxQoqdxmgnQZM4nzrC3tqTKNTJ
 Z0bGgO3o5iK1/inSpte4tMIKLck2FVY7p83JG4PuSUGGnyGQ701wGCBPmDQvqoWD9X5bpsajU2T
 F03BIirOWGOCXTbgmMXuezIrbn9LXGofagSKU3U3xgMDB53WjfNyCqSvBHbatz6bgvBd+xH52+T
 0hLOpdhMpPyH+BfV0PG66jtE5n75VgC2XdYEvmZy1J4SbuDtl+3HvN2hPkh+j/o7ncYUuSOMsiZ
 Ma1atX6nJCCaJxSdAWigEwTefBmbeSdYaH8yFeXk+Db1lBB9bU0ERNKIG+5k6kJVP2puvtsrTTK
 eGOc+xqCNBFS5VfVDElIvAGbjNzCkjxzfjfqqbxNngZlcxYeF5J8smGbJrRAvGwioad+hWqGqPO
 KWm0qgvB7LzbZ2MMH+vNpgSRaXKiaGSmfFevMPrUDCkDD1wXmXqhWMRV5d79GIqg0cCOZ/EIjz8
 iZa8wIDx/84rSkeYx5Uh9rGE6DChtODx0uLsbWxyFkfDfSMJ3AcFMmFyV26UU4fG6ZA76xOLKVV
 uRk5+mq08asEqBjP99PwaS8yIwp4v135+HbUzJfQYpWmCyyZaFl3I=
X-Received: by 2002:a05:6830:2709:b0:862:b748:25c2 with SMTP id
 46e09a7af769-863159a6f90mr20414169a34.23.1795675997613; 
 Wed, 25 Nov 2026 22:53:17 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:16 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:52:54 -0700
Subject: [PATCH 05/19] net: cdp: decode advertisements from the complete
 Ethernet frame
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-5-63df291d9392@gmail.com>
References: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
In-Reply-To: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An ordinary CDP advertisement uses an IEEE 802.3 length field followed
by an LLC/SNAP header. The legacy Ethernet dispatcher consumes that
header before calling the CDP parser, which expects to see it. On a
short packet Ethernet padding can also be mistaken for more CDP data.

Pass the original frame to the parser and limit the checksum and TLVs
to the declared payload length. Read potentially unaligned fields
explicitly and publish VLANs only after parsing a complete advertisement.
Zero-pad outgoing triggers to the Ethernet minimum without counting the
padding in the 802.3 length or CDP checksum.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/cdp.c | 246 ++++++++++++++++++++++++++------------------------------------
 net/cdp.h |  15 ++--
 net/net.c |  22 ++----
 3 files changed, 118 insertions(+), 165 deletions(-)

diff --git a/net/cdp.c b/net/cdp.c
index 300b3d5c409..bcea5887bc2 100644
--- a/net/cdp.c
+++ b/net/cdp.c
@@ -9,6 +9,7 @@
  */
 
 #include <net.h>
+#include <asm/unaligned.h>
 
 #include "cdp.h"
 
@@ -29,14 +30,6 @@ const u8 net_cdp_ethaddr[6] = { 0x01, 0x00, 0x0c, 0xcc, 0xcc, 0xcc };
 #define CDP_SYSOBJECT_TLV		0x0015
 #define CDP_MANAGEMENT_ADDRESS_TLV	0x0016
 
-#define CDP_TIMEOUT			250UL	/* one packet every 250ms */
-
-static int cdp_seq;
-static int cdp_ok;
-
-ushort cdp_native_vlan;
-ushort cdp_appliance_vlan;
-
 static const uchar cdp_snap_hdr[8] = {
 	0xAA, 0xAA, 0x03, 0x00, 0x00, 0x0C, 0x20, 0x00 };
 
@@ -98,7 +91,7 @@ static ushort cdp_compute_csum(const uchar *buff, ushort len)
 	return csum;
 }
 
-static int cdp_send_trigger(void)
+int cdp_build_trigger(uchar *frame, const u8 *src)
 {
 	uchar *pkt;
 	ushort *s;
@@ -108,17 +101,17 @@ static int cdp_send_trigger(void)
 	ushort chksum;
 #if	defined(CONFIG_CDP_DEVICE_ID) || defined(CONFIG_CDP_PORT_ID)   || \
 	defined(CONFIG_CDP_VERSION)   || defined(CONFIG_CDP_PLATFORM)
-	char buf[32];
+	char buf[32] = {};
 #endif
 
-	pkt = net_tx_packet;
+	pkt = frame;
 	et = (struct ethernet_hdr *)pkt;
 
 	/* NOTE: trigger sent not on any VLAN */
 
 	/* form ethernet header */
 	memcpy(et->et_dest, net_cdp_ethaddr, 6);
-	memcpy(et->et_src, net_ethaddr, 6);
+	memcpy(et->et_src, src, 6);
 
 	pkt += ETHER_HDR_SIZE;
 
@@ -138,7 +131,7 @@ static int cdp_send_trigger(void)
 #ifdef CONFIG_CDP_DEVICE_ID
 	*s++ = htons(CDP_DEVICE_ID_TLV);
 	*s++ = htons(CONFIG_CDP_DEVICE_ID);
-	sprintf(buf, CONFIG_CDP_DEVICE_ID_PREFIX "%pm", net_ethaddr);
+	snprintf(buf, sizeof(buf), CONFIG_CDP_DEVICE_ID_PREFIX "%pm", src);
 	memcpy((uchar *)s, buf, 16);
 	s += 16 / 2;
 #endif
@@ -146,7 +139,7 @@ static int cdp_send_trigger(void)
 #ifdef CONFIG_CDP_PORT_ID
 	*s++ = htons(CDP_PORT_ID_TLV);
 	memset(buf, 0, sizeof(buf));
-	sprintf(buf, CONFIG_CDP_PORT_ID, eth_get_dev_index());
+	snprintf(buf, sizeof(buf), CONFIG_CDP_PORT_ID, eth_get_dev_index());
 	len = strlen(buf);
 	if (len & 1)	/* make it even */
 		len++;
@@ -158,14 +151,14 @@ static int cdp_send_trigger(void)
 #ifdef CONFIG_CDP_CAPABILITIES
 	*s++ = htons(CDP_CAPABILITIES_TLV);
 	*s++ = htons(8);
-	*(ulong *)s = htonl(CONFIG_CDP_CAPABILITIES);
+	put_unaligned_be32(CONFIG_CDP_CAPABILITIES, s);
 	s += 2;
 #endif
 
 #ifdef CONFIG_CDP_VERSION
 	*s++ = htons(CDP_VERSION_TLV);
 	memset(buf, 0, sizeof(buf));
-	strcpy(buf, CONFIG_CDP_VERSION);
+	strlcpy(buf, CONFIG_CDP_VERSION, sizeof(buf));
 	len = strlen(buf);
 	if (len & 1)	/* make it even */
 		len++;
@@ -177,7 +170,7 @@ static int cdp_send_trigger(void)
 #ifdef CONFIG_CDP_PLATFORM
 	*s++ = htons(CDP_PLATFORM_TLV);
 	memset(buf, 0, sizeof(buf));
-	strcpy(buf, CONFIG_CDP_PLATFORM);
+	strlcpy(buf, CONFIG_CDP_PLATFORM, sizeof(buf));
 	len = strlen(buf);
 	if (len & 1)	/* make it even */
 		len++;
@@ -189,7 +182,7 @@ static int cdp_send_trigger(void)
 #ifdef CONFIG_CDP_TRIGGER
 	*s++ = htons(CDP_TRIGGER_TLV);
 	*s++ = htons(8);
-	*(ulong *)s = htonl(CONFIG_CDP_TRIGGER);
+	put_unaligned_be32(CONFIG_CDP_TRIGGER, s);
 	s += 2;
 #endif
 
@@ -200,165 +193,132 @@ static int cdp_send_trigger(void)
 #endif
 
 	/* length of ethernet packet */
-	len = (uchar *)s - ((uchar *)net_tx_packet + ETHER_HDR_SIZE);
+	len = (uchar *)s - (frame + ETHER_HDR_SIZE);
 	et->et_protlen = htons(len);
 
 	len = ETHER_HDR_SIZE + sizeof(cdp_snap_hdr);
-	chksum = cdp_compute_csum((uchar *)net_tx_packet + len,
-				  (uchar *)s - (net_tx_packet + len));
+	chksum = cdp_compute_csum(frame + len, (uchar *)s - (frame + len));
 	if (chksum == 0)
 		chksum = 0xFFFF;
 	*cp = htons(chksum);
 
-	net_send_packet(net_tx_packet, (uchar *)s - net_tx_packet);
-	return 0;
-}
-
-static void cdp_timeout_handler(void)
-{
-	cdp_seq++;
-
-	if (cdp_seq < 3) {
-		net_set_timeout_handler(CDP_TIMEOUT, cdp_timeout_handler);
-		cdp_send_trigger();
-		return;
+	len = (uchar *)s - frame;
+	if (len < ETH_ZLEN) {
+		memset(frame + len, 0, ETH_ZLEN - len);
+		return ETH_ZLEN;
 	}
-
-	/* if not OK try again */
-	if (!cdp_ok)
-		net_start_again();
-	else
-		net_set_state(NETLOOP_SUCCESS);
+	return len;
 }
 
-void cdp_receive(const uchar *pkt, unsigned len)
+bool cdp_parse_frame(const u8 *frame, unsigned int length, struct cdp_vlans *result)
 {
-	const uchar *t;
-	const ushort *ss;
-	ushort type, tlen;
-	ushort vlan, nvlan;
-
-	/* minimum size? */
-	if (len < sizeof(cdp_snap_hdr) + 4)
-		goto pkt_short;
-
-	/* check for valid CDP SNAP header */
-	if (memcmp(pkt, cdp_snap_hdr, sizeof(cdp_snap_hdr)) != 0)
-		return;
-
+	struct cdp_vlans vlans = { .native = -1, .appliance = -1 };
+	unsigned int hlen = ETHER_HDR_SIZE, len;
+	const u8 *pkt;
+
+	if (length < hlen || memcmp(frame, net_cdp_ethaddr, ETH_ALEN))
+		return false;
+	len = get_unaligned_be16(frame + hlen - 2);
+	if (len == PROT_VLAN) {
+		hlen += VLAN_HLEN;
+		if (length < hlen)
+			return false;
+		len = get_unaligned_be16(frame + hlen - 2);
+	}
+	/* Use the 802.3 length field: Ethernet padding isn't part of CDP. */
+	if (len > ETH_DATA_LEN || len > length - hlen || len < sizeof(cdp_snap_hdr) + 4)
+		return false;
+	pkt = frame + hlen;
+	if (memcmp(pkt, cdp_snap_hdr, sizeof(cdp_snap_hdr)))
+		return false;
 	pkt += sizeof(cdp_snap_hdr);
 	len -= sizeof(cdp_snap_hdr);
-
-	/* Version of CDP protocol must be >= 2 and TTL != 0 */
-	if (pkt[0] < 0x02 || pkt[1] == 0)
-		return;
-
-	/*
-	 * if version is greater than 0x02 maybe we'll have a problem;
-	 * output a warning
-	 */
-	if (pkt[0] != 0x02)
-		printf("**WARNING: CDP packet received with a protocol version "
-				"%d > 2\n", pkt[0] & 0xff);
-
-	if (cdp_compute_csum(pkt, len) != 0)
-		return;
+	if (pkt[0] < 2 || !pkt[1] || cdp_compute_csum(pkt, len))
+		return false;
 
 	pkt += 4;
 	len -= 4;
+	while (len) {
+		unsigned int tlv, size, type;
+		const u8 *value;
 
-	vlan = htons(-1);
-	nvlan = htons(-1);
-	while (len > 0) {
 		if (len < 4)
-			goto pkt_short;
-
-		ss = (const ushort *)pkt;
-		type = ntohs(ss[0]);
-		tlen = ntohs(ss[1]);
-		/*
-		 * tlen includes the 4-byte TLV header, so it must be at
-		 * least 4.  Without this check a crafted tlen < 4 makes the
-		 * "tlen -= 4" below underflow (tlen is a ushort), and a tlen
-		 * of 0 also fails to advance pkt/len, hanging the loop.
-		 */
-		if (tlen < 4 || tlen > len)
-			goto pkt_short;
-
-		pkt += tlen;
-		len -= tlen;
-
-		ss += 2;	/* point ss to the data of the TLV */
-		tlen -= 4;
-
-		switch (type) {
-		case CDP_DEVICE_ID_TLV:
-			break;
-		case CDP_ADDRESS_TLV:
-			break;
-		case CDP_PORT_ID_TLV:
-			break;
-		case CDP_CAPABILITIES_TLV:
-			break;
-		case CDP_VERSION_TLV:
-			break;
-		case CDP_PLATFORM_TLV:
-			break;
-		case CDP_NATIVE_VLAN_TLV:
-			nvlan = *ss;
-			break;
-		case CDP_APPLIANCE_VLAN_TLV:
-			t = (const uchar *)ss;
-			while (tlen > 0) {
-				if (tlen < 3)
-					goto pkt_short;
-
-				ss = (const ushort *)(t + 1);
-
+			return false;
+		type = get_unaligned_be16(pkt);
+		tlv = get_unaligned_be16(pkt + 2);
+		if (tlv < 4 || tlv > len)
+			return false;
+		value = pkt + 4;
+		size = tlv - 4;
+		if (type == CDP_NATIVE_VLAN_TLV) {
+			if (size != 2)
+				return false;
+			vlans.native = get_unaligned_be16(value);
+		} else if (type == CDP_APPLIANCE_VLAN_TLV) {
+			if (size % 3)
+				return false;
+			while (size) {
 #ifdef CONFIG_CDP_APPLIANCE_VLAN_TYPE
-				if (t[0] == CONFIG_CDP_APPLIANCE_VLAN_TYPE)
-					vlan = *ss;
-#else
-				/* XXX will this work; dunno */
-				vlan = ntohs(*ss);
+				if (value[0] == CONFIG_CDP_APPLIANCE_VLAN_TYPE)
 #endif
-				t += 3; tlen -= 3;
+					vlans.appliance = get_unaligned_be16(value + 1);
+				value += 3;
+				size -= 3;
 			}
-			break;
-		case CDP_TRIGGER_TLV:
-			break;
-		case CDP_POWER_CONSUMPTION_TLV:
-			break;
-		case CDP_SYSNAME_TLV:
-			break;
-		case CDP_SYSOBJECT_TLV:
-			break;
-		case CDP_MANAGEMENT_ADDRESS_TLV:
-			break;
 		}
+		pkt += tlv;
+		len -= tlv;
 	}
+	if (vlans.native > VLAN_VID_MASK || vlans.appliance > VLAN_VID_MASK)
+		return false;
+	*result = vlans;
+	return true;
+}
 
-	cdp_appliance_vlan = vlan;
-	cdp_native_vlan = nvlan;
+#ifdef CONFIG_NET_LEGACY
+static int cdp_seq;
+static bool cdp_ok;
+ushort cdp_native_vlan;
+ushort cdp_appliance_vlan;
 
-	cdp_ok = 1;
-	return;
+static void cdp_send_trigger(void)
+{
+	int len = cdp_build_trigger(net_tx_packet, net_ethaddr);
 
-pkt_short:
-	printf("** CDP packet is too short\n");
-	return;
+	net_send_packet(net_tx_packet, len);
+}
+
+static void cdp_timeout_handler(void)
+{
+	if (++cdp_seq < 3) {
+		net_set_timeout_handler(CDP_TIMEOUT, cdp_timeout_handler);
+		cdp_send_trigger();
+	} else if (!cdp_ok) {
+		net_start_again();
+	} else {
+		net_set_state(NETLOOP_SUCCESS);
+	}
+}
+
+void cdp_receive(const uchar *frame, unsigned int len)
+{
+	struct cdp_vlans vlans;
+
+	if (!cdp_parse_frame(frame, len, &vlans))
+		return;
+	cdp_native_vlan = htons(vlans.native);
+	cdp_appliance_vlan = htons(vlans.appliance);
+	cdp_ok = true;
 }
 
 void cdp_start(void)
 {
 	printf("Using %s device\n", eth_get_name());
 	cdp_seq = 0;
-	cdp_ok = 0;
-
+	cdp_ok = false;
 	cdp_native_vlan = htons(-1);
 	cdp_appliance_vlan = htons(-1);
-
 	net_set_timeout_handler(CDP_TIMEOUT, cdp_timeout_handler);
-
 	cdp_send_trigger();
 }
+#endif
diff --git a/net/cdp.h b/net/cdp.h
index 606fabba957..e53d1f81e4a 100644
--- a/net/cdp.h
+++ b/net/cdp.h
@@ -8,14 +8,19 @@
  *	Copyright 2000-2002 Wolfgang Denk, wd@denx.de
  */
 
-#if defined(CONFIG_CMD_CDP)
-
 #ifndef __CDP_H__
 #define __CDP_H__
 
+#define CDP_TIMEOUT 250 /* milliseconds */
+struct cdp_vlans {
+	int native;
+	int appliance;
+};
+
+extern const u8 net_cdp_ethaddr[6];
+int cdp_build_trigger(uchar *frame, const u8 *src);
+bool cdp_parse_frame(const u8 *frame, unsigned int len, struct cdp_vlans *result);
 void cdp_start(void);
-/* Process a received CDP packet */
-void cdp_receive(const uchar *pkt, unsigned len);
+void cdp_receive(const uchar *frame, unsigned int len);
 
 #endif /* __CDP_H__ */
-#endif
diff --git a/net/net.c b/net/net.c
index f46cfee7129..0fa6178023b 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1180,9 +1180,6 @@ void net_process_received_packet(uchar *in_packet, int len)
 	struct in_addr dst_ip;
 	struct in_addr src_ip;
 	int eth_proto;
-#if defined(CONFIG_CMD_CDP)
-	int iscdp;
-#endif
 	ushort cti = 0, vlanid = VLAN_NONE, myvlanid, mynvlanid;
 
 	debug_cond(DEBUG_NET_PKT, "packet received\n");
@@ -1209,8 +1206,10 @@ void net_process_received_packet(uchar *in_packet, int len)
 #endif
 
 #if defined(CONFIG_CMD_CDP)
-	/* keep track if packet is CDP */
-	iscdp = is_cdp_packet(et->et_dest);
+	if (is_cdp_packet(et->et_dest)) {
+		cdp_receive(in_packet, len);
+		return;
+	}
 #endif
 
 	myvlanid = ntohs(net_our_vlan);
@@ -1248,11 +1247,7 @@ void net_process_received_packet(uchar *in_packet, int len)
 			return;
 
 		/* if no VLAN active */
-		if ((ntohs(net_our_vlan) & VLAN_IDMASK) == VLAN_NONE
-#if defined(CONFIG_CMD_CDP)
-				&& iscdp == 0
-#endif
-				)
+		if ((ntohs(net_our_vlan) & VLAN_IDMASK) == VLAN_NONE)
 			return;
 
 		cti = ntohs(vet->vet_tag);
@@ -1265,13 +1260,6 @@ void net_process_received_packet(uchar *in_packet, int len)
 
 	debug_cond(DEBUG_NET_PKT, "Receive from protocol 0x%x\n", eth_proto);
 
-#if defined(CONFIG_CMD_CDP)
-	if (iscdp) {
-		cdp_receive((uchar *)ip, len);
-		return;
-	}
-#endif
-
 	if ((myvlanid & VLAN_IDMASK) != VLAN_NONE) {
 		if (vlanid == VLAN_NONE)
 			vlanid = (mynvlanid & VLAN_IDMASK);

-- 
2.53.0

