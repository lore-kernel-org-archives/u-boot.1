Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C263DC46CA1
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40C5D86EC6;
	Thu, 12 Oct 2023 04:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CVL68FkA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A94E86E7D; Thu, 12 Oct 2023 04:01:50 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D7BE86E82
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77428e40f71so29736385a.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075806; x=1697680606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUNlkY5TsiZEcu02jk2FAQ0cCSkTToiL+R8v5ZtV7Ww=;
 b=CVL68FkAd2Z5ZSdRP0Km6FpxMVb0HCh7XWoq1GiANBFMkLbLMNOsGXZ9en+AnSWK/Q
 d3HBEKnWU7v25ue8ibqbfYoOzhp/C3DkNMuw7oFNvb0W979+V/mzynzAaam76Be0JtaB
 ieY/+QNMhIP8C4+cSrVkFamZ81sTPJsctNFR6bkod4yJzVmxLflBJszF98LlxW4reEOu
 vqOBoV9JATjIleizXhmHfaIeqaENXg2R7gWXc2bC9rQstoA9AOdfFCvGGFUSH3Vq6DKT
 ZmAG3wawJuV3sQoRUpuRbB9YvaZnVsc2uwep5NcoVsccJjqPN7fzanZZ42NiCDNAjq0p
 aShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075806; x=1697680606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUNlkY5TsiZEcu02jk2FAQ0cCSkTToiL+R8v5ZtV7Ww=;
 b=cI12HhyWcfjuKisSS32mOFIXwUvuhd+toAVVNUHLdkn81SvToOZmV0/wuNYZ9gNdiD
 0EoeWFrK7MSQsC8cG9lwQ3DRMlC7UWUVwZnehFQ7hiV3wymq4LPpstwyH1Ze1CJMa07N
 e7yGeqKkF0URMCNsWoK8wWeqGGP3mJQEifYRLgwcLkpD/A1iQAU5EqH1jAXX7MOPinMV
 PnEMfcnxPnRO8GWrif5jGFP8o9hi2uGWW8kmBijb/gXuS1S74zGJ/QyeSeybXyOBfEII
 29qMqWX4rWqVJenpD9YPctLblh+6Se04vGOeKEAG53GhXhjYaVH5B4VSl6n+RpdiKExg
 2HTA==
X-Gm-Message-State: AOJu0YzKy9MfSNyaI3aRnXJHTfaMf0ocRHlIeY7DFlq7M07hdlS6PZbI
 K+jKEH7WJp5RokqtikHZJQs0BmFmZfiE+w==
X-Google-Smtp-Source: AGHT+IFPSV5SsTUN3IJGlEx1n9fuSOyK25+i2sK5Ko4souwzAxT+55xqvIJ/SlmTcofVwyIU0v5FDA==
X-Received: by 2002:a05:620a:21cc:b0:76f:1e31:93cd with SMTP id
 h12-20020a05620a21cc00b0076f1e3193cdmr23113377qka.43.1697075806449; 
 Wed, 11 Oct 2023 18:56:46 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 m10-20020ae9e70a000000b0076dae4753efsm5645625qka.14.2023.10.11.18.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:46 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 15/26] net: bootp: Fall back to BOOTP from DHCP when unit
 testing
Date: Wed, 11 Oct 2023 21:56:15 -0400
Message-Id: <20231012015626.3487451-16-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

If we sent a DHCP packet and get a BOOTP response from the server, we
shouldn't try to send a DHCPREQUEST packet, since it won't be DHCPACKed.
Transition straight to BIND. This is only enabled for UNIT_TEST to avoid
bloat, since I suspect the number of BOOTP servers in the wild is
vanishingly small.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 net/bootp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bootp.c b/net/bootp.c
index 2053cce88c6..7b0f45e18a9 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -1073,6 +1073,11 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 			    CONFIG_SYS_BOOTFILE_PREFIX,
 			    strlen(CONFIG_SYS_BOOTFILE_PREFIX)) == 0) {
 #endif	/* CONFIG_SYS_BOOTFILE_PREFIX */
+			if (CONFIG_IS_ENABLED(UNIT_TEST) &&
+			    dhcp_message_type((u8 *)bp->bp_vend) == -1) {
+				debug("got BOOTP response; transitioning to BOUND\n");
+				goto dhcp_got_bootp;
+			}
 			dhcp_packet_process_options(bp);
 			if (CONFIG_IS_ENABLED(EFI_LOADER) &&
 			    IS_ENABLED(CONFIG_NETDEVICES))
@@ -1099,6 +1104,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 		debug("DHCP State: REQUESTING\n");
 
 		if (dhcp_message_type((u8 *)bp->bp_vend) == DHCP_ACK) {
+dhcp_got_bootp:
 			dhcp_packet_process_options(bp);
 			/* Store net params from reply */
 			store_net_params(bp);
-- 
2.37.1

