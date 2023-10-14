Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF4ACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AF9786F04;
	Sun, 15 Oct 2023 09:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H0Cng+n4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2019B86F11; Sun, 15 Oct 2023 09:36:35 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2EF586801
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so30498685ad.3
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697355342; x=1697960142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=341wKDUYIh8tCxAmEOw1EmDuOye47CEGj9IhJmPKHRc=;
 b=H0Cng+n4mfLS0mEWchcSC7ijpSdl0GuGfirhx4tr3E3lzvJEd3RcZ6L73nfE75AnNk
 jSlDlaMRj+aKYBtRk4Mr+RJqclQYsJETo3SVduPGGKj9tpO/u1j/Y65iY7r5N/0RbKXh
 uKGlvzh8M+zCpuaaw4zgaDQq9q+oJkEH6GnDDceIdRwXRvGHJNwWYrkEJLpZdnAu20AB
 Wc8/dGK/uM1dcB9d2RakOgsMNe9UzIV2dH5gPZmd/6HqGankLh1UOvd57i7u75aj3Dxv
 9bPNiAw0GJ809nih+xlsckgenTQIRT1Gps2D641P5mTBIQB6I4MB5bG87EW0fSPAAzdv
 FB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697355342; x=1697960142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=341wKDUYIh8tCxAmEOw1EmDuOye47CEGj9IhJmPKHRc=;
 b=vsf+sXuNsKU0u/aHpS5YAaxu/NGSpUUDkaoNlXQMSRs3VWwq+obBUBXVl6h5Ch7ggw
 lcT4gJHQ8Oshrh8wS5f+3xWa4jc28OpHEKEkpzJskJpo/acT9mmE1seSe+Wk7xUGoJuq
 PT3yA3sWTxZ5B8OYZs7ROkAEdcMcaoUgBpISXTPIKLHd0LIIQ6BymtOwuiCh6GkOOk38
 745loP6nUR5lh+m8v1PBgaAqbvAbJa+rgyHo6Flphu1Ke9Um+mRRAntpicbwpPOqVahG
 ey3ai+N0Te6Tv4gDNKS7NapjfDKeiFxgXuFvEBA1xBiNYRvTp3qMyV6/M/rurF7AAgqy
 JJZA==
X-Gm-Message-State: AOJu0YxV1s1nT+8JJWSpnRrIXNrRNeI8v5z/THCNzdSJ+hsQjEGvlDDc
 UN+Ce63gqHjJWKvneGyK/Fqse+J/KR1HDw==
X-Google-Smtp-Source: AGHT+IHFnanrsyYotFaFSsgL+IkKju5VPIEO9nTfKwXgRgBfX3DxkgW0cbTiCDODh2SnjJeH26R6GA==
X-Received: by 2002:a05:6870:e392:b0:1e9:fb1e:870f with SMTP id
 x18-20020a056870e39200b001e9fb1e870fmr4129460oad.37.1697316507088; 
 Sat, 14 Oct 2023 13:48:27 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 iw8-20020a05622a6f8800b00419576c7b75sm1707043qtb.23.2023.10.14.13.48.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:26 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 17/29] net: bootp: Fall back to BOOTP from DHCP when unit
 testing
Date: Sat, 14 Oct 2023 16:47:53 -0400
Message-Id: <20231014204805.439009-18-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

