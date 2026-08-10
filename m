Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4357BC5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 20:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F355080F1C;
	Mon, 10 Aug 2026 20:48:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m6b39hMbUdnp; Mon, 10 Aug 2026 20:48:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7250980ED7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786394926;
	bh=lzzOYyoenm8FWaFOOyWIzDAUlnhM5xBpwXneX9kXle8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DCYrn6MGTT1ngESPLgtOme16x89OzlL2Ml9SwYOQ3HnOCTP9IpUgzP7XDB/3uU3iE
	 LlM7yDasosrJ2Gd3vFGnGuu4e/8bszgBL70AjwIb+o01JmBrpT8m/1uOfMmAgiFktp
	 92Z+kxQrq3xFo9sGAEsuEfG8moWbChZVdPongOKqF9syKhwmlonzfVEAalx6HTpikx
	 GfTOjwQnFSdvCE3iF4JIQTgLIdZW4zfDRLTcoImbzf9bPRqANr9iFfSPtB176N+7VZ
	 eMueUfc10vjDIZe90oJ4nR7CwmgMeGUFhf01eX2C5dJjuFZSxG0MoQRXzBC7sdLN3t
	 uHSe4a8kSQbjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7250980ED7;
	Mon, 10 Aug 2026 20:48:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 296AD198
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:48:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B06F406AF
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:48:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4BDPKeF90H2f for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 20:48:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=63b0=ge=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 460E2406AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 460E2406AB
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 460E2406AB
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:48:42 +0000 (UTC)
X-Forward-Email-ID: 6a7a3922060e5517e6e2bb4d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] global_data: Only include driver model fields when DM is
 enabled
Date: Mon, 10 Aug 2026 20:48:28 +0000
Message-ID: <20260810204828.2836359-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1786394921;
 bh=lzzOYyoenm8FWaFOOyWIzDAUlnhM5xBpwXneX9kXle8=;
 b=ic52uSGcvZ6ctnTYLYM8ZDVeXdeiQJXH61ukrU7pavN3BACScbUWMbdc+pv535Id51Ubmoe0B
 ToVcTve0HeEPjwbWyHBnA7PkmNBFlR0iTD7CWRCGIturG253m5X33ICSBOGGJbJJfJjZ3mNHqsy
 Hs/imPoZMO/3EQqgSbIq5kMpU+eK2CQ9C15uaWPqD+5H/SLWeghfV4Hh3NbNHX3/NF2cbK3Dytv
 XB/h4aOKo9reXsYPv9G721GypM1YjVApMhXBz0W/HGWfupcJDsDWYReNkfqFWn62cLZxF6TDjxc
 zGS2cHRGcVsd/Me5q0TyBvby9chkixTQG5SiiykETZvg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=ic52uSGc
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The struct list_head dmtag_list, struct udevice *dm_root, struct
list_head uclass_root_s and struct list_head *uclass_root fields in
struct global_data takes up 24/48 bytes of memory on ARMv7/AArch64.
However, these fields are only used when $(PHASE_)DM is enabled.

Guard driver model related fields using CONFIG_IS_ENABLED(DM) to save
memory space when U-Boot proper is built with DM=y and xPL is built
without xPL_DM.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This change passed CI pipeline #924 [1]

[1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/pipelines/924
---
 include/asm-generic/global_data.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index fd116b0cebf2..886c12900ddb 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -174,10 +174,12 @@ struct global_data {
 	 * @arch: architecture-specific data
 	 */
 	struct arch_global_data arch;
+#if CONFIG_IS_ENABLED(DM)
 	/**
 	 * @dmtag_list: List of DM tags
 	 */
 	struct list_head dmtag_list;
+#endif
 	/**
 	 * @timebase_h: high 32 bits of timer
 	 */
@@ -228,7 +230,7 @@ struct global_data {
 	 */
 	long precon_buf_idx;
 #endif
-#ifdef CONFIG_DM
+#if CONFIG_IS_ENABLED(DM)
 	/**
 	 * @dm_root: root instance for Driver Model
 	 */
-- 
2.54.0

