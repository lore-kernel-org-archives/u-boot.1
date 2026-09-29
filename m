Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C70CA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA2F64057C;
	Tue, 29 Sep 2026 00:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7VWdafu7Avlg; Tue, 29 Sep 2026 00:22:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1B88F40585
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641338;
	b=Oj4UedJpp47zUDk20+b9psFD0aqOg/+HyAWNb6Akbk5YNkHNE8VB77Kh4Wn7PLKn1/Pn
	 zKNQWo21SsTZK1J3Y7dCJvRSOk9FnzWOQSitBBUGIOt4VZ831yjw2hZ/Xlt5K9m9vRwWZ
	 ci25QQjeuOnl/qgg5suJlxDMTx/PA/eAFgTUQF82NMFuZP6FzKgP8aUucUc2PxRNPnHDo
	 mnYHrSMp4xrTdDP1RzD8UND2IgLMMtxXNt1rv9qWdgHDmK0VcQtUgO0GR2wsx1PCwXY9c
	 DqV8YC5f4N8GyxkmaLhVpax2eP2b3/QItpmCsBIROou5wz1hAhXdLCe37YNX9RIo7ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641338;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sU8vS8R3CQfX4IX0WK157slS3PoMCQTwT/VrCfqa4CU=;
	b=VUCAtfa6BDq4fAjtvqjf3p71E5tVwEFfttTrElQ6ITK4nIYQ+MuyEL+OS+JRmH7qWffJ
	 kIvlhAMVENbxb1FQ+aDigrMdCxUU4fLKLGa+0/3Dt6cfcMBYJv6RpPyZslkfL9ZO8AkNZ
	 9uEWp/6Ljty9w72LpFPpMtuVPUqY8JkpevIDMYqZn9uqs5X5S7ufZWAjMJfhTqjmu2sPz
	 ageMCiXWp0zwMrQm2auPjnH1AqrAfzX2f7QCUoch6kohtBQGJknhcOl8ZBvD5ls0Qqsd+
	 cyFCaWuFGge83G1NqjgAYhYom04lKxFq5HNCSeB1+DsREo3BovRCIppoP1zxY7upiyw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641338;
	bh=sU8vS8R3CQfX4IX0WK157slS3PoMCQTwT/VrCfqa4CU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V/nOXJxIZ3f/33d40NvoV3oAjHW7MRyJOjYfKYtdtMQewDU0Ef61Kbi7e7YERaXrH
	 5Kgurj89CW2IL7Pmv2v/N5EIjuagh7OukPu8ABarCDiBihqcdkD7ItGU5vqXXFE7i/
	 x6wVM40lUoIFfARjCt3zPbJZMho5k0IEY6u7jH29hjw06D/uihh28YajXbewj/9EO+
	 3+FVzVlHY7ZE6K3SBJjmwnZczAcQ1c812RDeliA7zXKhf3npBTXdVQe/zCTEwTBaOd
	 oPgnLbHzw64PLL7x7Sp+yb+vAANI7okE4TKPEoKVdyxBc1utrBHhaeEllnRABQOwAp
	 edeN0iynF6dsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B88F40585;
	Tue, 29 Sep 2026 00:22:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F3B561
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 350EC40247
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NFZ9cYvQ2jpc for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B3DDA40252
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641331;
 b=YS/+DM6E1sGjC9M7TCuE6WBa5oZpMA9Ddv46spHRC0qdgmdDt0JLHkBBP1LgIkBpOOOt
 g4E4TYKi1AxSRd+OGV1bL/+dC9z2p2tQGbDacjefnlgXP/azk8SUd7zOCx8HeD60w+Hy1
 uq4HoyqLRFrFDUZFDgOtfFU3jrwbTjmnu6jP4VBBgN1yw2AjcLT1OTspY6HGVgG7hiuIW
 XvaGsHvjK+Yf+55pmtiT+qtFsjp1V7K124yn1ax5Ui0okjc50QL9uXnBIo+rKt00MG+tR
 5Avo9SCcdS8HufhatEAs+6xxJ/+utkoatbLkYgLUrI5L18WF0U038m4iQlq5ZNKwEiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641331;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=sU8vS8R3CQfX4IX0WK157slS3PoMCQTwT/VrCfqa4CU=;
 b=cVcbbB0RGwbRPeg+Ru54T7r47ZabQ7GbIMNooNOFzmCGCHW/iFWztE8BKFjh33rJinYX
 2fWO2tFxnaxGG/eQLcWrGOEPDjTsqH/HA6HBXG6sChaWmYm8UVaTH/4Dd4Ey+xydVenLA
 wY84kFGZGXkPh2CXfI19b37e9xu+bInqrTQ5W9w5SVZZEYnLZL+EgXJxE3o1AFLhIheMj
 o3NAviQoYJZWNxv7RQ4VufyAqtPOaLudZH08Nb3chloIedbQIpioD79lMRaR5Uvvv12jg
 78YON5Qjv18MpK7fQPIUacQrWvAqcnySd2MM0HSkO+RwGUwCRn9o+zijwHNveQIWVEw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TJEGY2bu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::e;
 helo=mail-oa2-x0e.google.com; envelope-from=james.hilliard1@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=TJEGY2bu
Received: from mail-oa2-x0e.google.com (mail-oa2-x0e.google.com
 [IPv6:2607:f8b0:4864:30::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3DDA40252
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:10 +0000 (UTC)
Received: by mail-oa2-x0e.google.com with SMTP id
 586e51a60fabf-49936e6edacso480510fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641329; x=1791246129;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sU8vS8R3CQfX4IX0WK157slS3PoMCQTwT/VrCfqa4CU=;
 b=TJEGY2buYleC5oa3iBfHxcRGtdJKfx0XDjH+x1cOLQ5ZmXeisQuZmoNleHVcpsdaN5
 qDNz5VJw7cL5J89MGgtmdR/6QmYHiNF2tQLSe73oYOCSkyvyr3JfF0z6pg9f8f+p4mFV
 6LnIcmo2rPIM/wUL/BS4R06ClaenVsWrL3Wy/jpyNUKmVuXorax3x+jRZMpY4J5SEymD
 kigwd9RevJbXvboQgzwgCXO5TlMcP69SomAIaVtojBDdOJKD0zba17ScQdK8ejxibPSC
 MQQ/LUK3XL1wlN6ZKKnsYNgoB6bg3ExFyJf+ByaWFMYrrD+kd/30qVn7ridAby1QrIdo
 RQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641329; x=1791246129;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sU8vS8R3CQfX4IX0WK157slS3PoMCQTwT/VrCfqa4CU=;
 b=QGBIOiJ96mOzs3mnzq5axUlkCnu7v2atQlb9dIkzmmqGGmh2Rhy35PX7kJgW/dSy71
 AIgjpTqKJ524G0BZiF1NWsAbcD2WNabn9KKvMwSomjpWcSGclALTNlVCbLF5egCDafoB
 d2VVs68Y7uhFo0iFIOCB2Qo9fmbBTTpF5oR49Ay2F76rdTGNRtrhbjqz/p3YULRGoDut
 lwr315Oc7CqrwmdLLNN8fc0Lwlz//5jBWSmOH21SZzTOf9O8TC9hgj8OXL8EysRru8Qg
 qzDV8ujXqxoBaewmOxt1L7eNikwYU1CNRklw2zHMAc9vm6RoE2+y3G14BSVVJ31jTxEI
 Eadg==
X-Gm-Message-State: AFq9FYKsVQjJ+1PUxu7+P+G2I2qiM9glmkNLbSKlS0E9o+ir88TJp5ih
 uyKqJXrvjciAkzQn+rJNIywigyWFQBN9UHy9sb6P7d8AGYFGSn6wotG7
X-Gm-Gg: AYBFou3QVpPAjAf3JFtxO9/78stUcjxJqWEq1dJc9O/M0bEdt6/cBQYN86XmVmzhL21
 CFU3JvVSqDdX3EyT0a8gPp/BQftL7eopKNbO48UFLe3/RGyY+JjjcqpQWxu/ntv8U1nGSvSdgSQ
 vBMfGbf6sEJz5T0Pn94tWS3e40NzaFmhnVHpUrBHOxC78Hkv154VXqpgONtly0TXFo8azS/sHQL
 qsJPRaXzEaFLB2OxuxjrKdgMqlXURr23WFO1+196yofe+ASLSDdBewgSN/OTxfbst7t/7N3oeB2
 usNQXLazwR8t3isFtETtMpF7iF11N7jfQFTA66M5r7+xh1W2OIoTGGAGroQmLXQLYeIavjwQcV/
 usu6nxC7fPWY51Kn7NuVtR/OxRvGeE8RUjajkRQWsaL4bqVo+AhW0uOdPSh4LTb1G4hgRcwBKiH
 hLDmyL4LIZx4pO28HmYMGasA2UIDuqNIYV6IDybFdiL2i/etvMawdZVsf8E44hbkm94zFe4KN6+
 R6DxLqBFFktF5W3WKVZuozcMM/lrUqLOUdjA6Iqt9eYczCuuff65maFh8pZVzwI+evvllKBlNZg
 gu4POrSPoJlIw62gePI2dMMT8dv/Y7B/LN2poARtQWUJcptCI93VpQMvd+OqT66rZHNRkDGM/dy
 vPOpoZaboHixDGCOljrHL
X-Received: by 2002:a05:6870:8125:b0:48f:e107:9094 with SMTP id
 586e51a60fabf-491ec0cb354mr13151640fac.58.1790641328991; 
 Mon, 28 Sep 2026 17:22:08 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:47 -0600
Subject: [PATCH 10/20] net: lwip: support PXE client and configuration options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-10-2060c7365b0c@gmail.com>
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

Send the client architecture, UNDI identifier and configured PXE UUID
in DISCOVER and REQUEST messages. Honor the bootp_arch override used by
EFI boot methods, and reject invalid or out-of-range overrides before
sending. Preserve the legacy UNDI revision and UUID byte order.

Expose the existing PXE Kconfig controls to lwIP, request option 209
and retain its accepted configuration filename for pxe get. Replace
this DHCP-owned string only after binding, clearing it when the next
lease omits the option. Reuse bounded option concatenation and overload
parsing.

Extend the wire tests to check both request messages, maximum option
sizes, malformed PXE metadata, configured defaults and subsequent
leases.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig                 |   9 ++--
 lib/lwip/u-boot/lwipopts.h  |   9 +++-
 net/lwip/dhcp.c             | 119 ++++++++++++++++++++++++++++++++++++------
 test/dm/lwip_dhcp_options.c | 123 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 234 insertions(+), 26 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c1ae7a382bd..cf4dbb77fda 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2091,10 +2091,9 @@ config BOOTP_TIMEOFFSET
 	bool "Request & store 'timeoffset' from BOOTP/DHCP server"
 	depends on (CMD_BOOTP || CMD_DHCP) && CMD_SNTP
 
-if NET_LEGACY
-
 config CMD_PCAP
 	bool "pcap capture"
+	depends on NET_LEGACY
 	help
 	  Selecting this will allow capturing all Ethernet packets and store
 	  them in physical memory in a PCAP formated file,
@@ -2103,12 +2102,12 @@ config CMD_PCAP
 config BOOTP_PXE
 	bool "Send PXE client arch to BOOTP/DHCP server"
 	default y
-	depends on CMD_BOOTP && CMD_PXE
+	depends on (CMD_BOOTP || CMD_DHCP) && CMD_PXE
 	help
 	  Supported for ARM, ARM64, and x86 for now.
 
 config DHCP_PXE_CLIENTARCH
-	hex "DCHCP client system architecture type"
+	hex "DHCP client system architecture type"
 	depends on BOOTP_PXE || CMD_DHCP6
 	default 0x16 if ARM64 # arm 64 uboot
 	default 0x15 if ARM   # arm 32 uboot
@@ -2129,8 +2128,6 @@ config BOOTP_PXE_DHCP_OPTION
 	default y
 	depends on BOOTP_PXE
 
-endif
-
 config BOOTP_VCI_STRING
 	string
 	depends on CMD_BOOTP || CMD_DHCP
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index e49475d2e0f..217ce6f7977 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -129,7 +129,7 @@
 
 #ifdef CONFIG_CMD_DHCP
 #define LWIP_HOOK_FILENAME "lwip-dhcp.h"
-/* Core options plus two maximum-length hostname/vendor-class options. */
+/* Core/PXE options plus two maximum-length hostname/vendor-class options. */
 #define DHCP_OPTIONS_LEN		640
 /* Stage NTP after concatenating fragments, not in the core option parser. */
 #define LWIP_DHCP_GET_NTP_SRV	0
@@ -180,10 +180,15 @@
 #else
 #define UBOOT_DHCP_TIMEOFFSET
 #endif
+#ifdef CONFIG_BOOTP_PXE_DHCP_OPTION
+#define UBOOT_DHCP_PXE_CONFIG	209,
+#else
+#define UBOOT_DHCP_PXE_CONFIG
+#endif
 #define DHCP_REQUEST_OPTIONS	UBOOT_DHCP_SUBNET UBOOT_DHCP_GATEWAY \
 	UBOOT_DHCP_DNS UBOOT_DHCP_NTP UBOOT_DHCP_HOSTNAME \
 	UBOOT_DHCP_FILESIZE UBOOT_DHCP_ROOTPATH UBOOT_DHCP_DOMAIN \
-	UBOOT_DHCP_TIMEOFFSET 67
+	UBOOT_DHCP_TIMEOFFSET UBOOT_DHCP_PXE_CONFIG 67
 #endif /* CONFIG_CMD_DHCP */
 
 #define LWIP_AUTOIP                     0
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 2267a78f21c..f41def23112 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -4,6 +4,7 @@
 #include <command.h>
 #include <console.h>
 #include <env.h>
+#include <hexdump.h>
 #include <log.h>
 #include <lwip-dhcp.h>
 #include <malloc.h>
@@ -17,6 +18,7 @@
 #include <lwip/dhcp.h>
 #include <lwip/dns.h>
 #include <lwip/prot/dhcp.h>
+#include <u-boot/uuid.h>
 
 #define DHCP_TIMEOUT_MS 10000
 
@@ -25,6 +27,7 @@ struct dhcp_boot_data {
 	char rootpath[CONFIG_BOOTP_MAX_ROOT_PATH_LEN];
 	char domain[256];
 	char bootfile[sizeof(net_boot_file_name)];
+	char pxe_config[256];
 	u8 file_size[2];
 	u8 time_offset[4];
 	ip4_addr_t ntp;
@@ -41,12 +44,42 @@ struct dhcp_options {
 	struct dhcp_boot_data candidate;
 	char hostname[256];
 	char vendor[256];
+	u16 arch;
+	u8 uuid[1 + UUID_BIN_LEN];
+	bool have_uuid;
 	bool append_failed;
 };
 
 /* The address-less runtime attachment excludes a second DHCP command. */
 static struct dhcp_options *active_options;
 
+/*
+ * Parse decimal or hexadecimal settings without allowing the accumulator to
+ * wrap before checking the setting's limit. strict_strtoul() does not check
+ * overflow in U-Boot.
+ */
+static int dhcp_parse_number(const char *str, uint base, ulong limit, ulong *result)
+{
+	ulong value = 0;
+	uint digit;
+
+	if (base == 16 && str[0] == '0' && (str[1] == 'x' || str[1] == 'X'))
+		str += 2;
+	if (!*str)
+		return -EINVAL;
+	do {
+		digit = hex_to_bin(*str++);
+		if (digit >= base)
+			return -EINVAL;
+		if (digit > limit || value > (limit - digit) / base)
+			return -ERANGE;
+		value = value * base + digit;
+	} while (*str);
+	*result = value;
+
+	return 0;
+}
+
 struct dhcp_boot_option {
 	u8 code;
 	bool enabled;
@@ -121,6 +154,8 @@ static err_t dhcp_parse_boot_data(struct pbuf *p, struct dhcp_boot_data *data)
 		{ 40, IS_ENABLED(CONFIG_BOOTP_NISDOMAIN), true,
 		  data->domain, sizeof(data->domain) - 1 },
 		{ 67, true, true, data->bootfile, sizeof(data->bootfile) - 1 },
+		{ 209, IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION), true,
+		  data->pxe_config, sizeof(data->pxe_config) - 1 },
 		{ 13, IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE), false,
 		  data->file_size, sizeof(data->file_size) },
 		{ 2, IS_ENABLED(CONFIG_BOOTP_TIMEOFFSET), false,
@@ -206,38 +241,74 @@ err_t net_lwip_dhcp_ack(struct netif *netif, struct dhcp *dhcp, struct pbuf *p)
 	return ERR_OK;
 }
 
+static void dhcp_append(struct dhcp_options *options, struct dhcp_msg *msg,
+			u16_t *len, u8 code, const void *data, size_t size)
+{
+	if (!size)
+		return;
+	/* Leave room for END and the core's four-byte padding. */
+	if (*len + size + 2 + 4 > DHCP_OPTIONS_LEN) {
+		options->append_failed = true;
+		return;
+	}
+	msg->options[(*len)++] = code;
+	msg->options[(*len)++] = size;
+	memcpy(&msg->options[*len], data, size);
+	*len += size;
+}
+
 void net_lwip_dhcp_append(struct netif *netif, struct dhcp *dhcp, u8_t state,
 			  struct dhcp_msg *msg, u8_t type, u16_t *len)
 {
-	const char *strings[2];
-	const u8 codes[] = { DHCP_OPTION_HOSTNAME, DHCP_OPTION_US };
-	size_t i;
+	/* Match the legacy client: no PXE ROM APIs are provided by U-Boot. */
+	static const u8 undi[] = { 1, 0, 0 };
+	struct dhcp_options *options = active_options;
+	u8 arch[2];
 
 	if (!active_options || active_options->netif != netif ||
 	    (type != DHCP_DISCOVER && type != DHCP_REQUEST))
 		return;
-	strings[0] = active_options->hostname;
-	strings[1] = active_options->vendor;
-	for (i = 0; i < ARRAY_SIZE(strings); i++) {
-		size_t size = strlen(strings[i]);
+	dhcp_append(options, msg, len, DHCP_OPTION_HOSTNAME,
+		    options->hostname, strlen(options->hostname));
+	dhcp_append(options, msg, len, DHCP_OPTION_US, options->vendor, strlen(options->vendor));
+	if (options->arch != 0xff) {
+		put_unaligned_be16(options->arch, arch);
+		dhcp_append(options, msg, len, 93, arch, sizeof(arch));
+	}
+	dhcp_append(options, msg, len, 94, undi, sizeof(undi));
+	if (options->have_uuid)
+		dhcp_append(options, msg, len, 97, options->uuid, sizeof(options->uuid));
+}
 
-		if (!size)
-			continue;
-		/* Leave room for END and the core's four-byte padding. */
-		if (*len + size + 2 + 4 > DHCP_OPTIONS_LEN) {
-			active_options->append_failed = true;
-			return;
+static int dhcp_pxe_options(struct dhcp_options *options)
+{
+	const char *arch = env_get("bootp_arch");
+	const char *uuid = env_get("pxeuuid");
+	ulong value = 0xff;
+
+	if (IS_ENABLED(CONFIG_BOOTP_PXE))
+		value = IF_ENABLED_INT(CONFIG_BOOTP_PXE, CONFIG_DHCP_PXE_CLIENTARCH);
+	/* EFI boot methods override the native U-Boot architecture. */
+	if ((arch && dhcp_parse_number(arch, 16, U16_MAX, &value)) || value > U16_MAX) {
+		log_err("Invalid DHCP client architecture\n");
+		return -EINVAL;
+	}
+	options->arch = value;
+	if (IS_ENABLED(CONFIG_LIB_UUID) && uuid) {
+		if (uuid_str_to_bin(uuid, options->uuid + 1, UUID_STR_FORMAT_STD)) {
+			log_err("Invalid PXE UUID\n");
+			return -EINVAL;
 		}
-		msg->options[(*len)++] = codes[i];
-		msg->options[(*len)++] = size;
-		memcpy(&msg->options[*len], strings[i], size);
-		*len += size;
+		options->have_uuid = true;
 	}
+
+	return 0;
 }
 
 static int dhcp_boot_env(struct dhcp_boot_data *data)
 {
 	char offset[12];
+	char *config = NULL;
 	unsigned int i;
 #if LWIP_DNS
 	ip_addr_t addr;
@@ -270,6 +341,16 @@ static int dhcp_boot_env(struct dhcp_boot_data *data)
 		ip_addr_copy_from_ip4(addr, data->ntp);
 		sntp_setserver(0, &addr);
 	}
+	if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION)) {
+		if (data->pxe_config[0]) {
+			config = strdup(data->pxe_config);
+			if (!config)
+				return CMD_RET_FAILURE;
+		}
+		/* Unlike environment defaults, this string belongs to DHCP. */
+		free(pxelinux_configfile);
+		pxelinux_configfile = config;
+	}
 
 	return CMD_RET_SUCCESS;
 }
@@ -424,6 +505,10 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_FAILURE;
 	strlcpy(options->hostname, hostname ?: "", sizeof(options->hostname));
 	strlcpy(options->vendor, vendor, sizeof(options->vendor));
+	if (dhcp_pxe_options(options)) {
+		free(options);
+		return CMD_RET_FAILURE;
+	}
 	if (net_lwip_start(&net, NET_LWIP_ADDR_NONE)) {
 		free(options);
 		return CMD_RET_FAILURE;
diff --git a/test/dm/lwip_dhcp_options.c b/test/dm/lwip_dhcp_options.c
index a02fb4883a5..ce391f5e20e 100644
--- a/test/dm/lwip_dhcp_options.c
+++ b/test/dm/lwip_dhcp_options.c
@@ -26,6 +26,8 @@ enum dhcp_reply_kind {
 	DHCP_REPLY_ZERO_OFFSET,
 	DHCP_REPLY_BAD_NTP,
 	DHCP_REPLY_ROOT_OVERFLOW,
+	DHCP_REPLY_BAD_CONFIG,
+	DHCP_REPLY_CONFIG_OVERFLOW,
 	DHCP_REPLY_BAD_DNS,
 };
 
@@ -36,6 +38,12 @@ struct dhcp_options_test {
 	bool requested[256];
 	char hostname[256];
 	char vendor[256];
+	u8 arch[2];
+	u8 undi[3];
+	u8 uuid[17];
+	unsigned int arch_count;
+	unsigned int undi_count;
+	unsigned int uuid_count;
 	bool chain_failed;
 };
 
@@ -46,6 +54,7 @@ static bool dhcp_options_chain_check(struct dhcp_msg *reply, size_t len,
 	err_t expected = kind == DHCP_REPLY_BAD_STRING || kind == DHCP_REPLY_TRUNCATED ||
 		kind == DHCP_REPLY_BAD_SIZE || kind == DHCP_REPLY_BAD_NTP ||
 		kind == DHCP_REPLY_ROOT_OVERFLOW ||
+		kind == DHCP_REPLY_BAD_CONFIG || kind == DHCP_REPLY_CONFIG_OVERFLOW ||
 		kind == DHCP_REPLY_BAD_DNS ?
 		ERR_VAL : ERR_OK;
 	unsigned int i;
@@ -141,6 +150,7 @@ static int dhcp_options_reply(struct udevice *dev, struct dhcp_msg *request,
 		pos = dhcp_test_option(pos, 6, dns, sizeof(dns));
 		/* A trailing NUL is legal and must not become part of the path. */
 		pos = dhcp_test_option(pos, 67, "option.bin", sizeof("option.bin"));
+		pos = dhcp_test_option(pos, 209, "pxelinux.cfg/custom", 19);
 	} else if (kind == DHCP_REPLY_OVERLOAD) {
 		u8 overload = DHCP_OVERLOAD_SNAME_FILE;
 		u8 *field;
@@ -150,13 +160,16 @@ static int dhcp_options_reply(struct udevice *dev, struct dhcp_msg *request,
 		pos = dhcp_test_option(pos, 6, dns, 1);
 		pos = dhcp_test_option(pos, 67, "subdir/", 7);
 		pos = dhcp_test_option(pos, 42, ntp, 1);
+		pos = dhcp_test_option(pos, 209, "pxelinux.cfg/", 13);
 		field = dhcp_test_option(reply->file, 17, "/root", 5);
 		field = dhcp_test_option(field, 6, dns + 1, 7);
 		field = dhcp_test_option(field, 67, "overloaded.bin", 14);
 		field = dhcp_test_option(field, 42, ntp + 1, 2);
+		field = dhcp_test_option(field, 209, "over", 4);
 		*field = DHCP_OPTION_END;
 		field = dhcp_test_option(reply->sname, 17, "/fs", 3);
 		field = dhcp_test_option(field, 42, ntp + 3, sizeof(ntp) - 3);
+		field = dhcp_test_option(field, 209, "loaded", 6);
 		*field = DHCP_OPTION_END;
 	} else if (kind == DHCP_REPLY_ZERO_OFFSET) {
 		static const u8 zero[4];
@@ -183,6 +196,15 @@ static int dhcp_options_reply(struct udevice *dev, struct dhcp_msg *request,
 			memset(root, 'r', sizeof(root));
 			pos = dhcp_test_option(pos, 17, root, sizeof(root));
 		}
+		if (kind == DHCP_REPLY_BAD_CONFIG)
+			pos = dhcp_test_option(pos, 209, "bad\0path", 8);
+		if (kind == DHCP_REPLY_CONFIG_OVERFLOW) {
+			u8 config[255];
+
+			memset(config, 'c', sizeof(config));
+			pos = dhcp_test_option(pos, 209, config, sizeof(config));
+			pos = dhcp_test_option(pos, 209, "x", 1);
+		}
 	}
 	/* Exercise custom options before the message-type option. */
 	pos = dhcp_test_option(pos, DHCP_OPTION_MESSAGE_TYPE, &type, 1);
@@ -254,6 +276,22 @@ static int dhcp_options_tx(struct udevice *dev, void *packet, unsigned int len)
 			memcpy(str, pos, size);
 			str[size] = 0;
 		}
+		if (code == 93) {
+			if (size != sizeof(test->arch))
+				return -EINVAL;
+			memcpy(test->arch, pos, size);
+			test->arch_count++;
+		} else if (code == 94) {
+			if (size != sizeof(test->undi))
+				return -EINVAL;
+			memcpy(test->undi, pos, size);
+			test->undi_count++;
+		} else if (code == 97) {
+			if (size != sizeof(test->uuid))
+				return -EINVAL;
+			memcpy(test->uuid, pos, size);
+			test->uuid_count++;
+		}
 		pos += size;
 	}
 	if (type == DHCP_DISCOVER) {
@@ -304,11 +342,29 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 {
 	char * const argv[] = { "dhcp", "2000000", "explicit.bin" };
 	char long_name[257];
-	int kind;
+	static const u8 uuid[] = {
+		0, 0, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+		0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+	};
+	static const u8 undi[] = { 1, 0, 0 };
+	static const char * const invalid_arch[] = {
+		"junk", "0x", "10000", "0x10000", "100001234", "10000000000001234",
+	};
+	static const struct {
+		const char *str;
+		u16 value;
+	} valid_arch[] = {
+		{ "0Xffff", 0xffff },
+		{ "0000000000000000000001234", 0x1234 },
+		{ "0xff", 0xff },
+	};
+	int i, kind;
 
 	ut_assertok(env_set("ethact", "eth@10002000"));
 	ut_assertok(env_set("autoload", "no"));
 	ut_assertok(env_set("bootp_vci", "U-Boot.test"));
+	ut_assertok(env_set("bootp_arch", "1234"));
+	ut_assertok(env_set("pxeuuid", "00112233-4455-6677-8899-aabbccddeeff"));
 	ut_assertok(dhcp_server_check(uts, test));
 	for (kind = DHCP_REPLY_BASIC; kind <= DHCP_REPLY_BAD_DNS; kind++) {
 		bool supplied = kind == DHCP_REPLY_BASIC || kind == DHCP_REPLY_OVERLOAD;
@@ -323,6 +379,9 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 			continue;
 		if (kind == DHCP_REPLY_BAD_SIZE && !IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE))
 			continue;
+		if ((kind == DHCP_REPLY_BAD_CONFIG || kind == DHCP_REPLY_CONFIG_OVERFLOW) &&
+		    !IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION))
+			continue;
 		if (kind == DHCP_REPLY_ROOT_OVERFLOW &&
 		    (!IS_ENABLED(CONFIG_BOOTP_BOOTPATH) || CONFIG_BOOTP_MAX_ROOT_PATH_LEN > 261))
 			continue;
@@ -352,6 +411,20 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 				"8.8.8.8" : "1.2.3.4", env_get("dnsip"));
 		ut_asserteq_str(supplied && IS_ENABLED(CONFIG_BOOTP_DNS2) ?
 				"9.9.9.9" : "5.6.7.8", env_get("dnsip2"));
+		ut_asserteq(2, test->arch_count);
+		ut_asserteq(0x1234, get_unaligned_be16(test->arch));
+		ut_asserteq(2, test->undi_count);
+		ut_asserteq_mem(undi, test->undi, sizeof(undi));
+		ut_asserteq(IS_ENABLED(CONFIG_LIB_UUID) ? 2 : 0, test->uuid_count);
+		if (IS_ENABLED(CONFIG_LIB_UUID))
+			ut_asserteq_mem(uuid, test->uuid, sizeof(uuid));
+		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION), test->requested[209]);
+		if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION) &&
+		    (kind == DHCP_REPLY_BASIC || kind == DHCP_REPLY_OVERLOAD))
+			ut_asserteq_str(kind == DHCP_REPLY_BASIC ? "pxelinux.cfg/custom" :
+					"pxelinux.cfg/overloaded", pxelinux_configfile);
+		else
+			ut_assertnull(pxelinux_configfile);
 		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_HOSTNAME), test->requested[12]);
 		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_BOOTPATH), test->requested[17]);
 		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE), test->requested[13]);
@@ -406,6 +479,49 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 	ut_asserteq(0, test->discover);
 	ut_assertnull(netif_default);
 
+	ut_assertok(env_set("bootp_vci", "U-Boot.test"));
+	ut_assertok(env_set("hostname", "original"));
+	ut_assertok(env_set("bootp_arch", "ff"));
+	ut_assertok(env_set("pxeuuid", NULL));
+	*test = (struct dhcp_options_test){ .kind = DHCP_REPLY_EMPTY };
+	ut_assertok(do_dhcp(NULL, 0, 1, argv));
+	ut_asserteq(0, test->arch_count);
+	ut_asserteq(0, test->uuid_count);
+	/* Overflow must not turn an oversized architecture into a valid one. */
+	for (i = 0; i < ARRAY_SIZE(invalid_arch); i++) {
+		ut_assertok(env_set("bootp_arch", invalid_arch[i]));
+		*test = (struct dhcp_options_test){};
+		ut_asserteq(CMD_RET_FAILURE, do_dhcp(NULL, 0, 1, argv));
+		ut_asserteq(0, test->discover);
+		ut_assertnull(netif_default);
+	}
+	for (i = 0; i < ARRAY_SIZE(valid_arch); i++) {
+		ut_assertok(env_set("bootp_arch", valid_arch[i].str));
+		*test = (struct dhcp_options_test){ .kind = DHCP_REPLY_EMPTY };
+		ut_assertok(do_dhcp(NULL, 0, 1, argv));
+		ut_asserteq(valid_arch[i].value == 0xff ? 0 : 2, test->arch_count);
+		if (valid_arch[i].value != 0xff)
+			ut_asserteq(valid_arch[i].value, get_unaligned_be16(test->arch));
+	}
+	ut_assertok(env_set("bootp_arch", NULL));
+	*test = (struct dhcp_options_test){ .kind = DHCP_REPLY_EMPTY };
+	ut_assertok(do_dhcp(NULL, 0, 1, argv));
+	if (IS_ENABLED(CONFIG_BOOTP_PXE)) {
+		u16 arch = IF_ENABLED_INT(CONFIG_BOOTP_PXE, CONFIG_DHCP_PXE_CLIENTARCH);
+
+		ut_asserteq(arch == 0xff ? 0 : 2, test->arch_count);
+		if (arch != 0xff)
+			ut_asserteq(arch, get_unaligned_be16(test->arch));
+	} else {
+		ut_asserteq(0, test->arch_count);
+	}
+	if (IS_ENABLED(CONFIG_LIB_UUID)) {
+		ut_assertok(env_set("pxeuuid", "invalid"));
+		*test = (struct dhcp_options_test){};
+		ut_asserteq(CMD_RET_FAILURE, do_dhcp(NULL, 0, 1, argv));
+		ut_asserteq(0, test->discover);
+	}
+
 	return 0;
 }
 
@@ -415,12 +531,14 @@ static int dm_test_lwip_dhcp_options(struct unit_test_state *uts)
 		"ethact", "autoload", "bootp_vci", "hostname", "domain", "rootpath",
 		"bootfile", "timeoffset", "ntpserverip", "ipaddr", "netmask", "gatewayip",
 		"serverip", "tftpserverip", "dnsip", "dnsip2",
+		"bootp_arch", "pxeuuid",
 	};
 	struct dhcp_options_test test = {};
 	ip_addr_t old_ntp;
 	char bootfile[sizeof(net_boot_file_name)];
 	u32 expected_size = net_boot_file_expected_size_in_blocks;
 	char *saved[ARRAY_SIZE(vars)] = {};
+	char *config = pxelinux_configfile;
 	int i, ret = -ENOMEM;
 
 	if (CONFIG_IS_ENABLED(CMD_SNTP))
@@ -435,6 +553,7 @@ static int dm_test_lwip_dhcp_options(struct unit_test_state *uts)
 		}
 	}
 	memcpy(bootfile, net_boot_file_name, sizeof(bootfile));
+	pxelinux_configfile = NULL;
 	sandbox_eth_set_tx_handler(0, dhcp_options_tx);
 	sandbox_eth_set_priv(0, &test);
 	ret = dhcp_options_check(uts, &test);
@@ -442,6 +561,8 @@ static int dm_test_lwip_dhcp_options(struct unit_test_state *uts)
 	sandbox_eth_set_priv(0, NULL);
 	memcpy(net_boot_file_name, bootfile, sizeof(bootfile));
 	net_boot_file_expected_size_in_blocks = expected_size;
+	free(pxelinux_configfile);
+	pxelinux_configfile = config;
 	for (i = 0; i < ARRAY_SIZE(vars); i++)
 		if (env_set(vars[i], saved[i]))
 			ret = -EINVAL;

-- 
2.53.0

