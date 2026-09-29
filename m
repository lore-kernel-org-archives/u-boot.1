Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537F9CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C33660732;
	Tue, 29 Sep 2026 00:22:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOEdpEv212qO; Tue, 29 Sep 2026 00:22:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7AB006076D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641346;
	b=fvR6ZwRwcpj+UnjYfE0XCLq2p7UTMddl+xzwJ39OfbeWcf9qgmEgVv+kIlZNYoFsRq+6
	 ciGQj2KvoN5bm8yCzJWy8JhEjLP3EEUGT+3YwfRD7mjFdDCJtfBFo4CaBZo9CPALpoohH
	 aKRRpFQw+s+q/n+wYCA5qXXK0MhYw2YU05F8MNgoKpWeI5OjM37dt76e7nNCY3yweHFlk
	 zjY/Jn/zPbR0p+lWwkyrV1NdUbX2Z2Am72Z4PQfiZMVlX8KvjhnO9LouxGf8SnP+4X5zE
	 nVrozvAqHsS/UD805D7ATjL4vzr0/v1/VVDM4/FGE8F93PPsMCumuxfqIHnCdMOUWPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641346;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YSNcdG5wBS0QFLpR1gisHDXbglTEvZAvL/Pe2LIAk+U=;
	b=JNtDpzuO1ToLtfRcs0h0jduKbqHwmfcO3rlgXWcVPkZ1KN/RabEyX6JlD0PPJtjrYI/I
	 J1tZVgkrgL8ccZPB2oFL3xnVM+pDP6+d8x8I8GmPEYXbl4RWHSe1P7vY3Pg8JCeimKrax
	 YiPZnXHnumgXjvVoG2EnWWWScLUyHH/9i8AqordMZtAJrksqp3yC5J6TwpTuVXHJbJzbM
	 dArzTUCUWpmm1YZePZzODqJw17E0XWW+F1wIXzjEkU5TjAQieEGkz6knhdRnfW44Q9tqL
	 f2ZZj2jl7YtIbmukYK9AMXJvHab26t4GpAi5ECBfcHMDoZdQAZo89g3Tl4RB5pFnv6Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641346;
	bh=YSNcdG5wBS0QFLpR1gisHDXbglTEvZAvL/Pe2LIAk+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FcfzhiEAVeYtZs0bBhACDJFL0JmQP9O8g4kfw6LXHS9QV3iG+Xwf7nK808DsxebSM
	 DlLMmvA/Mfo8gK2yb5izGyRHCJvAtwpcE/zTd2benBLptlZpTuRNAy7hqgDd9arLxu
	 By6jvAywAIxg6oMeiEktFSvljsTs/CaxbTDvGs714APYmkme6kB8g7NtneEla8RHRI
	 V1Od+UXgvBVc4metBbHeEqrx9v0ZVWKYCHI2UFNRNkgl1zbdySI7qcyHKcQUELeoPu
	 y+nFOTOPVQr+1Vlyv8D0mG4P56Ox/AR8p6G12TiwVGAVlWcNHhx6jIr41WLC0CJYWI
	 qqU+wCBZwekWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AB006076D;
	Tue, 29 Sep 2026 00:22:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 57D0961
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 49DFD40252
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1PNI4JQyZ7vD for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E58C340247
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641339;
 b=IQas/5o5i990JHNMqzWl69TPZsRSB3VP7NxUh5qSGdDVDRcSGAi5d3Ka3GsQRt7c5pZg
 mEFLBdjl3L8sIrAi03qhVV6ZK8kiZBBOrd/OPQ9hCE0sxfj4+YdsO9J80NLSCSKtbc2tp
 wET33DEpjmauQwq8ejELisZEem7cZvuovYCT4RAs2cDg+Xg491tiJF7O9G5PJN8hu7yjy
 vPWOZwi4LN/u2HhIJ/jVH03uPGVALcExFNfsKQSnVDAsegQIOfd9o09ogYNpmrGChVj+A
 DZB4T8ijDOoe2BgaoVW0gJ+FcbeW7VAx+S20+uy4dg4xCcSnAWUp52noB4sx3Xzk6DA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641339;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=YSNcdG5wBS0QFLpR1gisHDXbglTEvZAvL/Pe2LIAk+U=;
 b=cAdG5BLSErKqyztISsTxqjo3CqT/30BmFmwqTOCAAcOHNnZLqc6enWYzSCModceHndkm
 wvT47YheyZ0S3azfc3Xf9fXvtnKzNkFrcO1DOwHP2wHphz9nCnbC4zck0hwxbkwt0H3WC
 +ebxvFrVlr2n1ZL+A4JDafHb3piE1OJZWLHN911qfPlgOykXKaKP4dBm7JYARuOQsC57K
 D/3uDam42zOwmVwKJ7kXRz70fkjIAiJtwxdyHqJ6a9QaUkjl/PlBAHfZcEMo9Kesx06pI
 fDYRFKjH76biQHFQc30ynuD2+4mS+goYtfG9NiHqHsB+5uRG7yaTOUrrTz0hPClKoow==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="F76qmz0/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=F76qmz0/
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E58C340247
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:18 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466ccde2ad8so2294848fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641337; x=1791246137;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YSNcdG5wBS0QFLpR1gisHDXbglTEvZAvL/Pe2LIAk+U=;
 b=F76qmz0/3RvZH4VVS7drIt2ufWELO7PGPG7LLEtLBLvP5EPN4th+PBz7bnb8jadP17
 rV0tdUzJe8mRJKE+Y9HJWyOXGXtk1SZr+sXy1lh8Q+Nc1DkCr/biq+mVLjrD/uMyxnuw
 3qEVC9rAQK4NgOOF8nNSSt0LD5B0xDnGmqqQ8ov3qlsChmozacH+irJFODLAAorKNoe4
 1YWkDyWikghzqsPtlKu5Qw0vEWeUbUzlq+T3WCZpWI286ktqBVSkewAdsYEJTEcSVFBB
 9NOmPlttn9eiaV2YhosKcOte3TPDn5nhIYMxRjIv9kKdIWlbn2/3GZBO5+dQM8kcJu2Q
 0pEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641337; x=1791246137;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YSNcdG5wBS0QFLpR1gisHDXbglTEvZAvL/Pe2LIAk+U=;
 b=utrVZMQJQVTYD37vtrJfr5rlEFF+cV/30/c1zMxEQQKyAjVnt6GXiXCFpZkPKBZu11
 29hnrYXPXotYcYVUklCd+dbeK40OQq+c552u3YpmwGVGAXcJOAJQTgD2YlroKzMhw3E2
 JVxszcvQFovnK9y78aUy7KRyQS5UWInUR8ES1E0iD9B2Lm/9rPy/ywPbZmSIVo0m7flY
 2NN+qE9/qkRtVhLAtDH9Dz474xCN3ER/2hXtpzEDpuQpLhNcvhL4IrnYVUnvF/zKgJB3
 6FVF9c5B4CRL1pK1UQ5gdg6Fz8XNXMPJltlv9l6Hz737FAnV9EVUanMPDKjxD+F10tv0
 vD3w==
X-Gm-Message-State: AFuF++nKGb6tzzItHYnhL36ynzdNeleIfmQElrlCh3TLmS65tT8yBeW7
 AiZus4UYoksMuYz7QLnVSI87+/m+UyAuCG0Oj5b06UhD0nXnHPV7JDDL
X-Gm-Gg: AYBFou38Rjd4UZPVw7FUmdFCEzz1yK0fs6Q+a0AZfwniogOygdzCOp0bBWEtZ+w/W8s
 bDiB3zsrpYi6F18hkUos1FP3ISpOu8z8mylXuiina8OfEuGLm7EAq1/oVVrPdoG/MW7Mm4w277o
 RS3LgAp8qaAYmzmesZf8iyvmlhO6YvKAwWDW0mAonMhDvK9Qc94L+bv1ovT7LnX3lfsMYFHbCKN
 hUT+Um70RIOCoHczY0TL/omH6ZXgp7vqs7pLWeZrIrjjnuYEg7Vk0PrqROtt5Ch5/QIY7xvyxXh
 kt4WfeZemoS8JlBxDPmk0lGT8m6hWk8BXg21T5f3HsQQ9RYA+PNf3GwGjFZ0Utmrezv+gus/nkS
 6XksT9qrlT3+66U4XCyUyRBRA9A0A6HNLQ2ZBnXWnWO2WignobioLgk8xXTEOw9Wx8WpGP5Ho9P
 M+e38pVawBITxCGh1eco/oTGaHlAMIvFP7pC5wlJgMHB9s8DFQbYbI2JvyPUMHMVO8vHBRUdbrb
 WNCDw0pJVj0Fys2bIcQNKevHeKsN9fpe/LZuawPnRacjfbzYPNFikCXqugbiYpLAYcigoBxB7Oi
 L7wCaaRTkn3jtakDq7dDH70IzC2PuKD7u9dcWyh/95xDp8sNH7+kdCLKtrJy8nQJnewdMUWFi/k
 9X131XvxEPMLeqacY1NPv
X-Received: by 2002:a05:6808:11cc:b0:4d6:9252:48cb with SMTP id
 5614622812f47-4d72b83b8fcmr15153237b6e.55.1790641337022; 
 Mon, 28 Sep 2026 17:22:17 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:51 -0600
Subject: [PATCH 14/20] net: lwip: accept direct ProxyDHCP replies without a
 lease
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-14-2060c7365b0c@gmail.com>
References: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
In-Reply-To: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peter Robinson <pbrobinson@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Heiko Schocher <hs@nabladev.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

Consume matching zero-address boot replies before the lease parser can
select them or clear the accepted boot filename. Require a valid PXE
vendor class and server identifier, validate the complete boot
metadata, and retain the first usable reply for this transaction. Keep
DHCPNAK processing and discard stale proxy selection when discovery
starts a new transaction.

Continue polling during a bounded post-ACK wait instead of blocking
after an offer. A missing proxy is not a lease failure. Take only
boot-server, filename and configuration data from the proxy, preserving
explicit filenames and configured server preferences. Keep host network
configuration and the EFI ACK from the address server. Publish the
separate proxy packet and its validity flag alongside the ACK for EFI
consumers.

Expose the existing ProxyDHCP controls to lwIP. This does not implement
PXE boot menus or port-4011 boot-service discovery.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 include/efi_loader.h        |   4 +-
 lib/efi_loader/efi_net.c    |  23 ++++++-
 lib/lwip/u-boot/lwip-dhcp.h |   2 +
 net/Kconfig                 |  21 +++++--
 net/bootp.c                 |   2 +-
 net/lwip/dhcp.c             | 149 ++++++++++++++++++++++++++++++++++++++++----
 6 files changed, 180 insertions(+), 21 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 830b086e6a2..7b865fe900a 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -81,7 +81,7 @@ efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64 len);
 void efi_restore_gd(void);
 
 /* Called by networking code to memorize the dhcp ack package */
-void efi_net_set_dhcp_ack(void *pkt, int len);
+void efi_net_set_dhcp_ack(void *pkt, int len, void *proxy, int proxy_len);
 /* Populate PXE mode with the newest cached reply for this interface. */
 void efi_net_get_dhcp_ack(struct udevice *dev, struct efi_pxe_mode *mode);
 /* Print information about all loaded images */
@@ -103,7 +103,7 @@ static inline efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64 len)
 
 /* No loader configured, stub out EFI_ENTRY */
 static inline void efi_restore_gd(void) { }
-static inline void efi_net_set_dhcp_ack(void *pkt, int len) { }
+static inline void efi_net_set_dhcp_ack(void *pkt, int len, void *proxy, int proxy_len) { }
 static inline void efi_net_get_dhcp_ack(struct udevice *dev, struct efi_pxe_mode *mode) { }
 static inline void efi_print_image_infos(void *pc) { }
 static inline efi_status_t efi_launch_capsules(void)
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 331efb9a5f2..a572a35d340 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -59,6 +59,8 @@ static struct wget_http_info efi_wget_info = {
 
 struct dhcp_entry {
 	struct efi_pxe_packet *dhcp_ack;
+	struct efi_pxe_packet *proxy_offer;
+	bool have_proxy;
 	struct udevice *dev;
 	bool is_valid;
 };
@@ -770,9 +772,12 @@ out:
  *
  * @pkt:	packet received by dhcp_handler()
  * @len:	length of the packet received
+ * @proxy:	optional direct ProxyDHCP reply from the same exchange
+ * @proxy_len:	length of the proxy reply, zero if absent
  */
-void efi_net_set_dhcp_ack(void *pkt, int len)
+void efi_net_set_dhcp_ack(void *pkt, int len, void *proxy, int proxy_len)
 {
+	struct dhcp_entry *entry = &dhcp_cache[next_dhcp_entry];
 	struct efi_pxe_packet **dhcp_ack;
 	struct udevice *dev;
 	int i;
@@ -792,8 +797,18 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
 		if (!*dhcp_ack)
 			return;
 	}
+	if (proxy && proxy_len > 0 && !entry->proxy_offer) {
+		entry->proxy_offer = malloc(maxsize);
+		if (!entry->proxy_offer)
+			return;
+	}
 	memset(*dhcp_ack, 0, maxsize);
 	memcpy(*dhcp_ack, pkt, min(len, maxsize));
+	entry->have_proxy = proxy && proxy_len > 0;
+	if (entry->have_proxy) {
+		memset(entry->proxy_offer, 0, maxsize);
+		memcpy(entry->proxy_offer, proxy, min(proxy_len, maxsize));
+	}
 
 	dhcp_cache[next_dhcp_entry].is_valid = true;
 	dhcp_cache[next_dhcp_entry].dev = dev;
@@ -820,13 +835,19 @@ void efi_net_get_dhcp_ack(struct udevice *dev, struct efi_pxe_mode *mode)
 	int i, j;
 
 	mode->dhcp_ack_received = false;
+	mode->proxy_offer_received = false;
 	memset(&mode->dhcp_ack, 0, sizeof(mode->dhcp_ack));
+	memset(&mode->proxy_offer, 0, sizeof(mode->proxy_offer));
 	i = (next_dhcp_entry + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES;
 	for (j = 0; dhcp_cache[i].is_valid && j < MAX_NUM_DHCP_ENTRIES;
 	     i = (i + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES, j++) {
 		if (dev == dhcp_cache[i].dev) {
 			mode->dhcp_ack = *dhcp_cache[i].dhcp_ack;
 			mode->dhcp_ack_received = true;
+			if (dhcp_cache[i].have_proxy) {
+				mode->proxy_offer = *dhcp_cache[i].proxy_offer;
+				mode->proxy_offer_received = true;
+			}
 			break;
 		}
 	}
diff --git a/lib/lwip/u-boot/lwip-dhcp.h b/lib/lwip/u-boot/lwip-dhcp.h
index fd60dec2dcc..03f8a6a2a14 100644
--- a/lib/lwip/u-boot/lwip-dhcp.h
+++ b/lib/lwip/u-boot/lwip-dhcp.h
@@ -15,10 +15,12 @@ u32_t net_lwip_dhcp_timeout(u8_t tries);
 #define DHCP_REQUEST_BACKOFF_SEQUENCE net_lwip_dhcp_timeout
 
 err_t net_lwip_dhcp_ack(struct netif *netif, struct dhcp *dhcp, struct pbuf *p);
+err_t net_lwip_dhcp_recv(struct netif *netif, struct dhcp *dhcp, struct pbuf *p);
 void net_lwip_dhcp_append(struct netif *netif, struct dhcp *dhcp, u8_t state,
 			  struct dhcp_msg *msg, u8_t type, u16_t *len);
 
 #define LWIP_HOOK_DHCP_HANDLE_ACK net_lwip_dhcp_ack
+#define LWIP_HOOK_DHCP_RECV net_lwip_dhcp_recv
 #define LWIP_HOOK_DHCP_APPEND_OPTIONS net_lwip_dhcp_append
 
 #endif /* __UBOOT_LWIP_DHCP_H */
diff --git a/net/Kconfig b/net/Kconfig
index 93f80eabb18..f732da4e2fc 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -116,19 +116,30 @@ config TFTP_TSIZE
 	  size from server, and if supported, limits the progress bar to
 	  50 characters total which fits on single line.
 
+endif
+
 config SERVERIP_FROM_PROXYDHCP
 	bool "Get serverip value from Proxy DHCP response"
+	depends on NET_LEGACY || CMD_DHCP
 	help
-	  Allows bootfile config to be fetched from Proxy DHCP server
-	  while IP is obtained from main DHCP server.
+	  Obtain the IP lease from the DHCP server and boot information from
+	  a separate ProxyDHCP server. With lwIP, accept direct boot replies
+	  on the DHCP client port; PXE boot menus and UDP port 4011 boot-service
+	  discovery are not implemented.
 
 config SERVERIP_FROM_PROXYDHCP_DELAY_MS
 	int "# of additional milliseconds to wait for ProxyDHCP response"
+	depends on SERVERIP_FROM_PROXYDHCP
+	range 0 10000
 	default 100
 	help
-	  Amount of additional time to wait for ProxyDHCP response after
-	  receiving response from main DHCP server. Has no effect if
-	  SERVERIP_FROM_PROXYDHCP is false.
+	  With lwIP, keep polling for a direct ProxyDHCP reply for up to this
+	  many milliseconds after obtaining the IP lease. Return immediately
+	  if a usable proxy reply already arrived. Missing proxy information
+	  does not fail an otherwise successful lease.
+	  The legacy client waits after receiving the DHCP offer.
+
+if NET_LEGACY
 
 config KEEP_SERVERADDR
 	bool "Write the server's MAC address to 'serveraddr'"
diff --git a/net/bootp.c b/net/bootp.c
index 320a545ad5d..cba0608009c 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -1154,7 +1154,7 @@ dhcp_got_bootp:
 			dhcp_state = BOUND;
 			if (CONFIG_IS_ENABLED(EFI_LOADER) &&
 			    IS_ENABLED(CONFIG_NETDEVICES))
-				efi_net_set_dhcp_ack(pkt, len);
+				efi_net_set_dhcp_ack(pkt, len, NULL, 0);
 			printf("DHCP client bound to address %pI4 (%lu ms)\n",
 			       &net_ip, get_timer(bootp_start));
 			net_set_timeout_handler(0, (thand_f *)0);
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 94d4edf5c98..b223261ff23 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -31,6 +31,9 @@ struct dhcp_boot_data {
 	char domain[256];
 	char bootfile[sizeof(net_boot_file_name)];
 	char pxe_config[256];
+	char vendor[256];
+	ip4_addr_t server;
+	u8 type;
 	u8 file_size[2];
 	u8 time_offset[4];
 	ip4_addr_t ntp;
@@ -43,7 +46,9 @@ struct dhcp_boot_data {
 
 struct dhcp_efi_cache {
 	struct efi_pxe_packet ack;
+	struct efi_pxe_packet proxy_offer;
 	u16 ack_len;
+	u16 proxy_len;
 };
 
 struct dhcp_options {
@@ -55,6 +60,10 @@ struct dhcp_options {
 	u16 discover_secs;
 	struct dhcp_boot_data reply;
 	struct dhcp_boot_data candidate;
+	struct dhcp_boot_data proxy;
+	ip4_addr_t proxy_server;
+	u32 proxy_xid;
+	bool have_proxy;
 	char hostname[256];
 	char vendor[256];
 	u16 arch;
@@ -205,7 +214,8 @@ static int dhcp_boot_options(struct pbuf *p, unsigned int pos, unsigned int end,
 	return 0;
 }
 
-static err_t dhcp_parse_boot_data(struct pbuf *p, struct dhcp_boot_data *data)
+static err_t dhcp_parse_boot_data(struct pbuf *p, struct dhcp_boot_data *data,
+				  bool proxy)
 {
 	struct dhcp_boot_option opts[] = {
 		{ 12, IS_ENABLED(CONFIG_BOOTP_HOSTNAME), true,
@@ -223,6 +233,9 @@ static err_t dhcp_parse_boot_data(struct pbuf *p, struct dhcp_boot_data *data)
 		  data->time_offset, sizeof(data->time_offset) },
 		{ 42, IS_ENABLED(CONFIG_BOOTP_NTPSERVER), false,
 		  &data->ntp, sizeof(data->ntp) },
+		{ 53, true, false, &data->type, sizeof(data->type) },
+		{ 54, true, false, &data->server, sizeof(data->server) },
+		{ 60, proxy, true, data->vendor, sizeof(data->vendor) - 1 },
 		{ 6, IS_ENABLED(CONFIG_BOOTP_DNS), false, data->dns, sizeof(data->dns) },
 	};
 	u8 overload = 0;
@@ -269,7 +282,7 @@ static err_t dhcp_parse_boot_data(struct pbuf *p, struct dhcp_boot_data *data)
 				return ERR_VAL;
 			if (opt->code == 13)
 				data->have_size = true;
-			else
+			else if (opt->code == 2)
 				data->have_offset = true;
 		}
 	}
@@ -284,6 +297,73 @@ static err_t dhcp_parse_boot_data(struct pbuf *p, struct dhcp_boot_data *data)
 	return ERR_OK;
 }
 
+err_t net_lwip_dhcp_recv(struct netif *netif, struct dhcp *dhcp, struct pbuf *p)
+{
+	struct dhcp_options *options = active_options;
+	struct dhcp_boot_data *data;
+	ip4_addr_t offered, server;
+	u32 cookie;
+	u8 type = 0, overload = 0;
+	struct dhcp_boot_option msg_type = { 53, true, false, &type, sizeof(type) };
+
+	if (!options || options->netif != netif)
+		return ERR_OK;
+	if (pbuf_copy_partial(p, &cookie, sizeof(cookie), DHCP_MSG_LEN) != sizeof(cookie) ||
+	    ntohl(cookie) != DHCP_MAGIC_COOKIE ||
+	    pbuf_get_at(p, offsetof(struct dhcp_msg, htype)) != 1 ||
+	    pbuf_get_at(p, offsetof(struct dhcp_msg, hlen)) != netif->hwaddr_len ||
+	    pbuf_copy_partial(p, &offered, sizeof(offered),
+			      offsetof(struct dhcp_msg, yiaddr)) != sizeof(offered))
+		return ERR_VAL;
+	if (!ip4_addr_isany(&offered))
+		return ERR_OK;
+	/*
+	 * NAK also has a zero yiaddr and must still drive the lease state
+	 * machine. Leave its full validation to the built-in DHCP parser.
+	 */
+	if (dhcp_boot_options(p, DHCP_OPTIONS_OFS, p->tot_len, &msg_type, 1, &overload) ||
+	    msg_type.len != 1)
+		return ERR_VAL;
+	if (type == DHCP_NAK)
+		return ERR_OK;
+
+	/*
+	 * Zero-address offers must never select a lease, even without proxy
+	 * support. Consume them before lwIP clears the ACK's boot filename.
+	 */
+	if (!IS_ENABLED(CONFIG_SERVERIP_FROM_PROXYDHCP) || options->have_proxy ||
+	    (dhcp->state != DHCP_STATE_SELECTING && dhcp->state != DHCP_STATE_REQUESTING &&
+	     dhcp->state != DHCP_STATE_BOUND))
+		return ERR_VAL;
+	data = &options->proxy;
+	memset(data, 0, sizeof(*data));
+	if (dhcp_parse_boot_data(p, data, true) ||
+	    (data->type != DHCP_OFFER && data->type != DHCP_ACK) ||
+	    strncmp(data->vendor, "PXEClient", 9) || ip4_addr_isany(&data->server))
+		return ERR_VAL;
+	if (pbuf_copy_partial(p, &server, sizeof(server),
+			      offsetof(struct dhcp_msg, siaddr)) != sizeof(server))
+		return ERR_VAL;
+	if (ip4_addr_isany(&server)) {
+		/* Menu-only offers need PXE boot-service discovery, not TFTP. */
+		if (!data->bootfile[0] && !data->pxe_config[0])
+			return ERR_VAL;
+		server = data->server;
+	}
+	if (ip4_addr_ismulticast(&server) || ip4_addr_isbroadcast(&server, netif))
+		return ERR_VAL;
+	options->proxy_server = server;
+	options->have_proxy = true;
+	if (CONFIG_IS_ENABLED(EFI_LOADER)) {
+		struct dhcp_efi_cache *efi = options->efi;
+
+		efi->proxy_len = min_t(size_t, p->tot_len, sizeof(efi->proxy_offer));
+		pbuf_copy_partial(p, &efi->proxy_offer, efi->proxy_len, 0);
+	}
+
+	return ERR_ABRT;
+}
+
 err_t net_lwip_dhcp_ack(struct netif *netif, struct dhcp *dhcp, struct pbuf *p)
 {
 	struct dhcp_boot_data *data;
@@ -294,9 +374,14 @@ err_t net_lwip_dhcp_ack(struct netif *netif, struct dhcp *dhcp, struct pbuf *p)
 	/* A rejected renewal must leave the accepted lease metadata intact. */
 	data = &active_options->candidate;
 	memset(data, 0, sizeof(*data));
-	ret = dhcp_parse_boot_data(p, data);
+	ret = dhcp_parse_boot_data(p, data, false);
 	if (ret)
 		return ret;
+	/* The lease comes only from the selected DHCP server, not the proxy. */
+	if (data->type != DHCP_ACK || ip4_addr_isany(&data->server) ||
+	    (dhcp->state == DHCP_STATE_REQUESTING &&
+	     !ip4_addr_cmp(&data->server, ip_2_ip4(&dhcp->server_ip_addr))))
+		return ERR_VAL;
 	active_options->reply = *data;
 	if (CONFIG_IS_ENABLED(EFI_LOADER)) {
 		struct dhcp_efi_cache *efi = active_options->efi;
@@ -336,6 +421,10 @@ void net_lwip_dhcp_append(struct netif *netif, struct dhcp *dhcp, u8_t state,
 	if (!active_options || active_options->netif != netif ||
 	    (type != DHCP_DISCOVER && type != DHCP_REQUEST))
 		return;
+	if (type == DHCP_DISCOVER && options->proxy_xid != dhcp->xid) {
+		options->have_proxy = false;
+		options->proxy_xid = dhcp->xid;
+	}
 	if (type == DHCP_DISCOVER)
 		options->discover_secs = min_t(ulong, get_timer(options->start) / 1000,
 					       U16_MAX);
@@ -429,7 +518,7 @@ static int dhcp_boot_env(struct dhcp_boot_data *data)
 	return CMD_RET_SUCCESS;
 }
 
-static int dhcp_server_env(struct dhcp *dhcp)
+static int dhcp_server_env(struct dhcp *dhcp, struct dhcp_options *options)
 {
 	const char *server = env_get("serverip");
 	ip4_addr_t addr;
@@ -440,6 +529,10 @@ static int dhcp_server_env(struct dhcp *dhcp)
 	     ip4addr_aton(server, &addr) && !ip4_addr_isany(&addr)))
 		return env_set("tftpserverip", NULL);
 
+	if (options->have_proxy)
+		return env_set("serverip", ip4addr_ntoa(&options->proxy_server)) ||
+			env_set("tftpserverip", ip4addr_ntoa(&options->proxy_server));
+
 	return env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr)) ||
 		env_set("tftpserverip", ip4_addr_isany(&dhcp->offered_si_addr) ?
 			NULL : ip4addr_ntoa(&dhcp->offered_si_addr));
@@ -452,6 +545,7 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 	char maskstr[] = "netmask\0\0\0";
 	char gwstr[] = "gatewayip\0\0\0";
 	unsigned long start;
+	unsigned long proxy_start = 0;
 	struct dhcp *dhcp;
 	bool bound = false;
 	int idx;
@@ -468,24 +562,53 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 	if (dhcp_start(net->netif) || options->append_failed)
 		return CMD_RET_FAILURE;
 
-	/* Wait for DHCP to complete */
-	do {
+	/*
+	 * Keep the lease and optional proxy reply separate. Continue receiving
+	 * packets during the bounded proxy wait, without delaying DHCPREQUEST.
+	 */
+	for (;;) {
 		if (net_lwip_poll() < 0 || options->append_failed)
 			return CMD_RET_FAILURE;
-		bound = dhcp_supplied_address(net->netif);
-		if (bound)
-			break;
 		if (ctrlc()) {
 			printf("Abort\n");
+			return CMD_RET_FAILURE;
+		}
+		if (IS_ENABLED(CONFIG_SERVERIP_FROM_PROXYDHCP) &&
+		    !bound && dhcp_supplied_address(net->netif))
+			proxy_start = get_timer(0);
+		bound = dhcp_supplied_address(net->netif);
+		if (bound) {
+			if (IS_ENABLED(CONFIG_SERVERIP_FROM_PROXYDHCP) && !options->have_proxy &&
+			    get_timer(proxy_start) <
+			    IF_ENABLED_INT(CONFIG_SERVERIP_FROM_PROXYDHCP,
+					   CONFIG_SERVERIP_FROM_PROXYDHCP_DELAY_MS)) {
+				mdelay(1);
+				continue;
+			}
 			break;
 		}
+		if (get_timer(start) >= options->timeout)
+			break;
 		mdelay(1);
-	} while (get_timer(start) < options->timeout);
+	}
 
 	if (!bound)
 		return CMD_RET_FAILURE;
 
 	dhcp = netif_dhcp_data(net->netif);
+	if (options->have_proxy) {
+		struct dhcp_boot_data *proxy = &options->proxy;
+		struct dhcp_boot_data *reply = &options->reply;
+
+		if (proxy->bootfile[0]) {
+			strlcpy(reply->bootfile, proxy->bootfile, sizeof(reply->bootfile));
+			/* An ACK's size describes its own file, not the proxy's file. */
+			reply->have_size = proxy->have_size;
+			memcpy(reply->file_size, proxy->file_size, sizeof(reply->file_size));
+		}
+		if (proxy->pxe_config[0])
+			strlcpy(reply->pxe_config, proxy->pxe_config, sizeof(reply->pxe_config));
+	}
 
 	/* The core's file field also reflects replies it subsequently ignores. */
 	if (!explicit_file && options->reply.bootfile[0])
@@ -505,7 +628,7 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 	if (env_set(ipstr, ip4addr_ntoa(&dhcp->offered_ip_addr)) ||
 	    env_set(maskstr, ip4addr_ntoa(&dhcp->offered_sn_mask)) ||
 	    env_set(gwstr, ip4addr_ntoa(&dhcp->offered_gw_addr)) ||
-	    dhcp_server_env(dhcp))
+	    dhcp_server_env(dhcp, options))
 		return CMD_RET_FAILURE;
 
 	if (dhcp_boot_env(&options->reply))
@@ -514,7 +637,9 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 	if (CONFIG_IS_ENABLED(EFI_LOADER)) {
 		struct dhcp_efi_cache *efi = options->efi;
 
-		efi_net_set_dhcp_ack(&efi->ack, efi->ack_len);
+		efi_net_set_dhcp_ack(&efi->ack, efi->ack_len,
+				     options->have_proxy ? &efi->proxy_offer : NULL,
+				     options->have_proxy ? efi->proxy_len : 0);
 	}
 
 	printf("DHCP client bound to address %pI4 (%lu ms)\n",

-- 
2.53.0

