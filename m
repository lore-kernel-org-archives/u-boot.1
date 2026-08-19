Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536A0C5B572
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 20:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59AE2405B9;
	Wed, 19 Aug 2026 20:53:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5HYUUdYL5lgv; Wed, 19 Aug 2026 20:53:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787172788;
	bh=ldM+GlfnUMzQGtWrq8X0BMyb0F+8MdcLYTJ57mFN6x8=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D6uy2MK2gnlBrDJPLyISqpbcC9LE0IrjHGCZZY90oAwlLIXS+zvGDwk7/lAn2jC50
	 eVpds6llb1bnz6WgWNg0yxiMeARMUxMMKCEMQxxxZX2v8d0WsbovCTlfBH+jh8wXE2
	 kpoWcPLGcTYXqoS+XaFz3znoMAHFighCCooBWv5ds0SVv3LP4Flt0nNJT3rcEtbTTM
	 NkbF2WHKbskjcO0cN9GxAdkbxQNMF4gzsww8RBxi7qgBVNMcZ3ED4L52RDqnol6LWx
	 yULHL8yP95fL3lMH76S0bI4b80Cv+DomWUUvrnczIcdWMev/uILw4OTDxlDyNF9rYH
	 b7dxTfxEFC0ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73ADE405B1;
	Wed, 19 Aug 2026 20:53:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C5A8C39E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 19:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ABAB240243
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 19:10:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6_5FP6FYQZmq for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 19:10:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1046; helo=mail-pj1-x1046.google.com;
 envelope-from=3uv-fagskbi0hdgrjxiqjwppxxpun.lxvd-kxxcurbcb.d-kxxc-yaxsnlc.xap@flex--yuxiaozhang.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=iy0sYd/+
Received: from mail-pj1-x1046.google.com (mail-pj1-x1046.google.com
 [IPv6:2607:f8b0:4864:20::1046])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E81D440240
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 19:10:51 +0000 (UTC)
Received: by mail-pj1-x1046.google.com with SMTP id
 98e67ed59e1d1-38f57e31b6eso1393292a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787166651; x=1787771451;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ldM+GlfnUMzQGtWrq8X0BMyb0F+8MdcLYTJ57mFN6x8=;
 b=iy0sYd/+TgQCr9C2fuTyo08yQbGo9r+WW5+DlhU3K2avCb3PviQc2BS8AnpsQbTU/7
 HC2F5sXgV1Xp2mo2rtcoeAIt28KyKWICr0IJDS9fGwFCdE6Xu5oM1ZYfveo0pZdMh7A4
 3P5LSuzpZLWbIFEM9nFrijRvFrGDWTzHyUrT/q31f/sN0GTL5+mCNCGwsqWHBFGu4QM7
 8p5O7Z1vJQ+ckdOAORMUoI+MWqJwOPxLq+XYjZTQxajbJNRC4acR8LnpwTUcqAwMfKmH
 gmdFsNhiz8HosAaL9oJQb96jRkA8WMV0fIFASbwEdV1jFbbiKxvdjbyz8gh2B4XfvbBw
 nzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787166651; x=1787771451;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ldM+GlfnUMzQGtWrq8X0BMyb0F+8MdcLYTJ57mFN6x8=;
 b=qTcWOkAxwrKAryMCqYndFS7758sYA+1qQMAKQBuz2NmT8fm7hcugbbGNP58E+9vinp
 bD0McGbp8I5nNQdY228U9eGh3eVnBZpQ+em9EmaiNwl4SC2jeQP+NcA2iz4t3nTnm76y
 MBVmZ/HJLqa3I2iItsce+/hdTiZeOJmBsDYIdWrfzu+bNTI3faH7cw6uchyVAqRbkq1y
 lfvjxeFTaspP914xUwmjcqkFehYIeOQV2qLgIRkkYEfXKcpixYMpgeMv6Xf2bVVSAATk
 raDhKSyIMG0h1GciNhh42ZhBBXxmP63guDmm92q3wIjN9CLhB592nzIOqu69jMhrbGAE
 zzFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RomP411MxxBYucRdGJgIwE3Rz4JqUFKdI6e6++bwJCCxtRpRFeCt+zOs/ai5OK3P9AQyhycg/c=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mCbMxYfCZK1xn0OJ2VUjbk/MxPfjd1e+WXa1g71Q8GU8P1lvov
 qhZyr1KhDdAAO2pP5dPhu1grIOOeqJHuzhXdjngw5jyfrT7UPNKcAScW2iIY+LGhCLfqp2PPQGd
 HQ9EcCsVxu1lG7fF90Sql+Pa8qw==
X-Received: from dldyq20-n2.prod.google.com
 ([2002:a05:701b:4554:20b0:141:2c5a:38a5])
 (user=yuxiaozhang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d82:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-39580ed143bmr12456426a91.3.1787166650603; 
 Wed, 19 Aug 2026 12:10:50 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:10:21 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260819191046.4125809-1-yuxiaozhang@google.com>
Subject: [PATCH] dhcpv6: support rapid commit dhcp6 option
From: Yuxiao Zhang <yuxiaozhang@google.com>
To: u-boot@lists.denx.de
Cc: Yuxiao Zhang <yuxiaozhang@google.com>, Francois Berder <fberder@outlook.fr>,
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 19 Aug 2026 20:53:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Support rapid commit option code 14 which bypass the advertise and
request state. The option is enabled by DHCP6_RAPID_COMMIT.

Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
---

 cmd/Kconfig  |  8 ++++++++
 net/dhcpv6.c | 39 ++++++++++++++++++++++++++++++++-------
 net/dhcpv6.h |  2 ++
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ff90a87024c..b3cf3a6d8b6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1996,6 +1996,14 @@ config DHCP6_ENTERPRISE_ID
 	int "Enterprise ID to send in DHCPv6 Vendor Class Option"
 	default 0
 
+config DHCP6_RAPID_COMMIT
+	bool "Request Rapid Commit (2-message exchange) from DHCPv6 server"
+	default n
+	help
+	  Request the Rapid Commit option (option 14) in DHCPv6 Solicit
+	  messages to enable a 2-message exchange (Solicit-Reply) rather
+	  than the default 4-message exchange.
+
 endif
 
 config BOOTP_MAY_FAIL
diff --git a/net/dhcpv6.c b/net/dhcpv6.c
index 640f089a2e1..1e51e6de256 100644
--- a/net/dhcpv6.c
+++ b/net/dhcpv6.c
@@ -115,6 +115,9 @@ static int dhcp6_add_option(int option_id, uchar *pkt)
 
 		opt_len = sizeof(struct dhcp6_option_ia_na);
 		break;
+	case DHCP6_OPTION_RAPID_COMMIT:
+		opt_len = 0;
+		break;
 	case DHCP6_OPTION_ORO:
 		oro_opt = (struct dhcp6_option_oro *)dhcp_option_start;
 		oro_opt->req_option_code[num_oro++] = htons(DHCP6_OPTION_OPT_BOOTFILE_URL);
@@ -194,6 +197,8 @@ static void dhcp6_send_solicit_packet(void)
 	pkt += dhcp6_add_option(DHCP6_OPTION_ELAPSED_TIME, pkt);
 	pkt += dhcp6_add_option(DHCP6_OPTION_IA_NA, pkt);
 	pkt += dhcp6_add_option(DHCP6_OPTION_ORO, pkt);
+	if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT))
+		pkt += dhcp6_add_option(DHCP6_OPTION_RAPID_COMMIT, pkt);
 	if (CONFIG_DHCP_PXE_CLIENTARCH != 0xFF)
 		pkt += dhcp6_add_option(DHCP6_OPTION_CLIENT_ARCH_TYPE, pkt);
 	pkt += dhcp6_add_option(DHCP6_OPTION_VENDOR_CLASS, pkt);
@@ -448,6 +453,12 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
 			}
 			sm_params.rx_status.preference = *option_ptr;
 			break;
+		case DHCP6_OPTION_RAPID_COMMIT:
+			if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT)) {
+				debug("DHCP6_OPTION_RAPID_COMMIT FOUND\n");
+				sm_params.rx_status.rapid_commit_found = true;
+			}
+			break;
 		default:
 			debug("Unknown Option ID: %d, skipping parsing\n",
 			      ntohs(option_hdr->option_id));
@@ -618,14 +629,28 @@ static void dhcp6_state_machine(bool timeout, uchar *rx_pkt, unsigned int len)
 		break;
 	case DHCP6_SOLICIT:
 		if (!timeout) {
-			/* check the rx packet and determine if we can transition to next
-			 * state.
-			 */
-			if (dhcp6_check_advertise_packet(rx_pkt, len))
-				return;
+			struct dhcp6_hdr *dhcp6_hdr = (struct dhcp6_hdr *)rx_pkt;
+
+			if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT) &&
+			    dhcp6_hdr && dhcp6_hdr->msg_type == DHCP6_MSG_REPLY) {
+				if (dhcp6_check_reply_packet(rx_pkt, len))
+					return;
+				if (!sm_params.rx_status.rapid_commit_found) {
+					debug("[DHCPv6] REPLY received without Rapid Commit option, ignoring\n");
+					return;
+				}
+				debug("REPLY (Rapid Commit) good, transition to DONE\n");
+				sm_params.next_state = DHCP6_DONE;
+			} else {
+				/* check the rx packet and determine if we can transition to next
+				 * state.
+				 */
+				if (dhcp6_check_advertise_packet(rx_pkt, len))
+					return;
 
-			debug("ADVERTISE good, transition to REQUEST\n");
-			sm_params.next_state = DHCP6_REQUEST;
+				debug("ADVERTISE good, transition to REQUEST\n");
+				sm_params.next_state = DHCP6_REQUEST;
+			}
 		} else if (sm_params.retry_cnt == 1)  {
 			/* If a server UID was received in the first SOLICIT period
 			 * transition to REQUEST
diff --git a/net/dhcpv6.h b/net/dhcpv6.h
index d41a3c30615..49f20390730 100644
--- a/net/dhcpv6.h
+++ b/net/dhcpv6.h
@@ -24,6 +24,7 @@
 #define DHCP6_OPTION_PREFERENCE		7
 #define DHCP6_OPTION_ELAPSED_TIME	8
 #define DHCP6_OPTION_STATUS_CODE	13
+#define DHCP6_OPTION_RAPID_COMMIT	14
 #define DHCP6_OPTION_OPT_BOOTFILE_URL	59
 #define DHCP6_OPTION_OPT_BOOTFILE_PARAM	60
 #define DHCP6_OPTION_SOL_MAX_RT		82
@@ -152,6 +153,7 @@ struct dhcp6_rx_pkt_status {
 	enum dhcp6_status	ia_status_code;
 	enum dhcp6_status	status_code;
 	u8			preference;
+	bool			rapid_commit_found;
 };
 
 /**
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
branch: main

-- 
2.55.0.737.g08866a6d13-goog

