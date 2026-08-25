Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F2CC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93C4860702;
	Tue, 25 Aug 2026 19:08:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IejvE23RlHPw; Tue, 25 Aug 2026 19:08:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684901;
	bh=wqUBfn9jP/tH2PKyo0TnsEKXc9n7dYc9tQ/Z27OSvc8=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i0YJvA68g7R5ua0GuR6RlM2w2Q/9tHs608p7ScQ6p9Pfoyx27ve9DnaU5h/mRRrME
	 m7YqhGEZs8mLhRYt28sdJlX74XQvNwj3hKQZLciSMSx5ZCs86a43/oJkpVPboE242k
	 +G6fvLleebHurMz4YyyBNuB41KziIA4TscgLOFf3ARxF6f7Gi3s8Y3/+e145OGONhK
	 EBI0rttXoTi42ppKlbCUe/vpzFgrU76bmJ2ghYPKGKsz6BOStAfQISHpqAk6an0t1P
	 V/hxXMu/84lwtX0u7ByTNBrDWrSvWeqS1hxmpbkiit8p98AXHOi4Joerlf3B/nkLD8
	 GBzAG94XzxDEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5E3360706;
	Tue, 25 Aug 2026 19:08:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD2B63DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEB8640629
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:54:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6BublUFU9_uW for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:54:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1045; helo=mail-pj1-x1045.google.com;
 envelope-from=35nanagskbiuzvyjbpaibohhpphmf.dpnv-cppumjtut.v-cppu-qspkfdu.psh@flex--yuxiaozhang.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=Y/Ki9Owr
Received: from mail-pj1-x1045.google.com (mail-pj1-x1045.google.com
 [IPv6:2607:f8b0:4864:20::1045])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB08D4061B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:54:45 +0000 (UTC)
Received: by mail-pj1-x1045.google.com with SMTP id
 98e67ed59e1d1-388cfc4848dso115761a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787680484; x=1788285284;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wqUBfn9jP/tH2PKyo0TnsEKXc9n7dYc9tQ/Z27OSvc8=;
 b=Y/Ki9Owr3gFjqcxq0pzxDYWMZ8FRI2gbEYBVoJdXL2S1RZP9wT1bF+MR2+IpauxN7R
 1cvkJdLXTyXjvtzRQFgU5J22lwm2iAG8CDx9sy14dPiCZdPSjn86DEDyjjIGJNUaL06w
 ijGlOxBqUrUeiorgjELAaJ2KWZPWB3sOwwDxUGax63uPw0+zS2lS2eMyqsV9KwpvZhdP
 k97me3fKDNIYRCrKhnsaExhvDbseIgvrkgrqAr3R0cF/3dHWmCRaC3d0nCahPTU2XCsi
 1X20sTe20mlHKs06ePXzCVrw2eHFDiB2a1zj4PBy1i3b2DEJRXBpfGy9GEJps7itJ8Eb
 wI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787680484; x=1788285284;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wqUBfn9jP/tH2PKyo0TnsEKXc9n7dYc9tQ/Z27OSvc8=;
 b=Wc/mjlzObh3nkBADECSGtvHPzUGtB1WjAS72ayC6bKIKRDHBRwlLt4WuH+AQNztvmg
 FndNFsFzEJgmsFiVgfyts70o4vHHMyGBaKkeo1B/XePhhe+7giQVHHZGi6dVJwbTYCs+
 DsZAEYLouFKwHnv62glLJ+O6Pog0TiDyoR4eWyfz7jYQdYzp+VYjh1Ua6yhkfR+l+zKs
 uCMLX4aBBG8dWo0SZ3RyqRySFY2U6BugP534y/tLBLJ+kn9plb5/13TEK1heGvoE0vRh
 4u9+tGn9MQNTLpJgvraZMxGOPpzJ62EA0M4s2FOoqgEBZ/CUgPi58ZjhiZNhtW1rTPNg
 Q+jw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrY5JMLaw/iwqQEC30IosIVXz2EYJd18orWe/BtrpOg1h1TWlDmenaI4DNYNFkzEDRUWaJwRuE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kx1pz4qCbsTCST2wBXMEWkHb5PPoOQQcbTZKstXvH9pURmmJua
 LhXl5hDzsYS670MlFhYktUuq9XKwBUpmvrLjUTtmVt95pv7jzVD/jSTFvN2bRpMVyYmUySdVlV2
 7BpmVy5XDjvPttrnEkV81DIwp3A==
X-Received: from dlbro8.prod.google.com ([2002:a05:7022:1588:b0:141:4f31:2f75])
 (user=yuxiaozhang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5107:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-3966d9e5ecfmr1636967a91.15.1787680484420; 
 Tue, 25 Aug 2026 10:54:44 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:53:56 -0700
In-Reply-To: <"<53437d4c-a21d-496c-9587-c9832d76a1de@arm.com>">
Mime-Version: 1.0
References: <"<53437d4c-a21d-496c-9587-c9832d76a1de@arm.com>">
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260825175417.1068611-1-yuxiaozhang@google.com>
Subject: [PATCH v2] dhcpv6: support rapid commit dhcp6 option
From: Yuxiao Zhang <yuxiaozhang@google.com>
To: u-boot@lists.denx.de
Cc: Yuxiao Zhang <yuxiaozhang@google.com>, Francois Berder <fberder@outlook.fr>,
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 25 Aug 2026 19:08:20 +0000
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

Changes in v2:
- Reject rapid commit option if option_len != 0
- Drop redundant NULL check on dhcp6_hdr

 cmd/Kconfig  |  8 ++++++++
 net/dhcpv6.c | 43 ++++++++++++++++++++++++++++++++++++-------
 net/dhcpv6.h |  2 ++
 3 files changed, 46 insertions(+), 7 deletions(-)

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
index 640f089a2e1..5ed8449edb5 100644
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
@@ -448,6 +453,16 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
 			}
 			sm_params.rx_status.preference = *option_ptr;
 			break;
+		case DHCP6_OPTION_RAPID_COMMIT:
+			if (option_len != 0) {
+				debug("Invalid rapid commit option length\n");
+				break;
+			}
+			if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT)) {
+				debug("DHCP6_OPTION_RAPID_COMMIT FOUND\n");
+				sm_params.rx_status.rapid_commit_found = true;
+			}
+			break;
 		default:
 			debug("Unknown Option ID: %d, skipping parsing\n",
 			      ntohs(option_hdr->option_id));
@@ -618,14 +633,28 @@ static void dhcp6_state_machine(bool timeout, uchar *rx_pkt, unsigned int len)
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
+			    dhcp6_hdr->msg_type == DHCP6_MSG_REPLY) {
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
2.55.0.860.g4b6b3295ed-goog

