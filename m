Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A59CA5FAE
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D478E60760;
	Tue, 29 Sep 2026 00:22:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Do5JZllUZG7; Tue, 29 Sep 2026 00:22:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A20AC60762
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641340;
	b=rQQd3oKDaTPERcEF12sKcs7h5Kv1qB4QUtixqrqRO774GLN7KL+b4u17C+HWXOrluFpP
	 meavmZXdRsXsMe6yMpiQpRoLfP6VoMW7go8B4EH5kkt/5jCUitZpTysypCDaqGED7ERsn
	 j44AhJdBLWRvCgly5gBItZYXzK29+n9kFaH9HHKi64jR2ivRljc//ekuzJJR6C5aslgmy
	 UzIERwtXhpJl12+z8SxqnJehQWM3rx7VFobAQ2R6ZUDTOe/LVJ92KS2hIKvj6eoDpC5CX
	 QNIZ/XVlIW57ZMIcyYfrkv3mTxQ/ZL16ALjOTC8lIUi3CtTN48gBXWTJkXLb7sS/gFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641340;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=yjYfIoEvUjQnfuR4BaTQzcHqlPePYXZtDwGPZoOXeew=;
	b=cWwGKEjVmAkZzW4JpYPlIoXLmv8CAJK2uNlquwrcKFq+CJHsYIrD18kdzpCmehYDbe/9
	 b5BLoC95gdIZIvhvoU/Yrphcw2W08zErH/zLl7/wsr+OvH36XgEH3kEPm8yQQsgT4p3wq
	 ND80v9BWeZMV8tnWdUQgpfJuBHTeznvD5FemnvKeTvrgY2Nyxe9ljJ4QBDzgackl0N09L
	 2qWitlEgD/A0sBDHVTEnb88uRA0c5x9PjcJu8/U8fHspEXwTDJXZ3CA9B2cbJDIoyfuQ2
	 iudILHHFIcU7MKajUHoHsDyS1NiagkdxaVNReUqDwUedYM02Rh8a/z3cfbgVeGF5sIw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641340;
	bh=yjYfIoEvUjQnfuR4BaTQzcHqlPePYXZtDwGPZoOXeew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Az1NBhPfYkzBFGuHEd8l4PVLRVvha5G3WLkXtQt+bNj/2tSC9lkA+GiBrPuNprQrK
	 3KT4g3nWlwupKN7d0gGT8sx+xZ0WLNYTcgethc4fownRqPzd9w/wUtqo+0sQ7bQlcj
	 jgLz0XI0tPAgAgaxb7OfQJcAx29GnCug+1jPromHyX3taDy6mlXoZAPGU2JJeUeuxw
	 hEbBGtIXAkA/WZmVsg+1mE/lFU7JH6JIekzL9l08hnfw45kLHIKVnrJKHTxEPzszUr
	 hHGhLklTCdQSY7vpu1zONo+OOepk23BhZPa3EJLpNLOlM9SvUJzZuJ+KsRPkG0fBiP
	 j4vOs4eqC8m9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A20AC60762;
	Tue, 29 Sep 2026 00:22:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B891E335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E00E40557
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F4ZHP1o4bJVT for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6EB3C40580
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641332;
 b=ajRsqDxQ8cSaipQTFtFAbrRcvGbdW6iL7/J3zm+lLDd++UDJRtq9C9QJ+iNmuI32FFJY
 LBtqTH8LyB0XZ+bjzB2rI2CX6UyPm4YCyJEbayA76z6u0cS4uJ2Dvm1gx/+n1pTbjAOHj
 5hwtctU+Q3S+1rjfbLGBXq3LGpoy9RlxBDyzZQj3R4WCVLzlasKOl4wkhBraQxeZdKNLW
 WSrJf4xRrKM05ikhT7RP+CvKnWJ/5TiUjHB0OgqKk+dCl4SS0BMnb5xyZu32AtAY+ZAtz
 HtGWTSC3P0YPKCeL/YvTYACACf2LR2KnfzPiE4dnqi6VKfSyUOtM4PmjG/hqPRCwM9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641332;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=yjYfIoEvUjQnfuR4BaTQzcHqlPePYXZtDwGPZoOXeew=;
 b=pGmE5COeZZz3kSYcu8ZvUx4sExdzncrmwhEb8SulHCwXhQkEu/49uDiCtKusCiLya4al
 enWm3biazv1N+W+kijtUCBetx5hecP5fAmswnKiGzepWKztfaaeQi8g2QrYTWUhY4EmKW
 Y//zmi8GHFqajXpYdUsuMPagsS2MefJLRRN8uU6L/bhjTTeSGSj/+iTtCWCbtGxvz6ZHA
 r9qiYJm1R8SFosP4+l8pHVkL7jhn6+aJ9Z4RvZ7OO7Vo9nczmBcP2ma9uS4Qovm1TA9xv
 bKLUdl+qUSzZwGFyWaS2cLBZmPYaEsuAKiQBzLPjQDFrkf0P920wHvamKimbMYooi+Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ul1tVPWI; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::e;
 helo=mail-oa2-x0e.google.com; envelope-from=james.hilliard1@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Ul1tVPWI
Received: from mail-oa2-x0e.google.com (mail-oa2-x0e.google.com
 [IPv6:2607:f8b0:4864:30::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6EB3C40580
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:12 +0000 (UTC)
Received: by mail-oa2-x0e.google.com with SMTP id
 586e51a60fabf-49499f845edso772009fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641331; x=1791246131;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yjYfIoEvUjQnfuR4BaTQzcHqlPePYXZtDwGPZoOXeew=;
 b=Ul1tVPWINv5AxNuJgCxV9idDZRUMb2y38GWDi8X1E0o8vyKjg6B72U5mzf4YOPz7M5
 aWvVAi+E454548sVVOx77GwKCFJ2H0uvhjD7Z1MCb7ujDoCmUbKpKb1dYBQEYwiUNmbl
 hzDSylE028I4qAMGk/qoiRt+In8whCt/50Q9mHgyYGnLSIvw/kXaFYgOGoQFi39VLTm5
 qxhLjDN8RoIEosRfsy6TRa39XowB9Qy2PzFspEJu3R4K2SajV+NSBbIh5RRy/oOeGfpY
 5ybxxdW7v6l1X0tqeC9gwGE64I3PgwFAIgTlpiXRb9fYgj0VpwGrkL8gxZ0BJ0BhBn85
 v7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641331; x=1791246131;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yjYfIoEvUjQnfuR4BaTQzcHqlPePYXZtDwGPZoOXeew=;
 b=i5FIQ9qAEsFrvGfVDvZBfsleanMIH4mdKYrjbFVTuYd7jxNkYFBay04qVxrQ0z2CBg
 Se936F28IK7tzE7ptyTi8ikDeoSE5DW1Dvut6Jea9iTtUS0YAcQzzrV2X2Bxs3RSjwGa
 2CEd/sye0t7ybGTZIdMOxo44P8OTv+nt8rmRKIV364jyTGckNZepryoaUSwWxqCrf72b
 IxJcqsnoTBrTaLXTA3tzSVFvDVcGhNzWYi4I1y3POjVg/2jJhrGhb1ayb3HQYb9rkInz
 0JzS6UfxtfVys0yzUI3fEgDGlMPT+PbAkdjl5AtPcX4PaNC8UZVcvK+h9Re3aSeUl74a
 Z08A==
X-Gm-Message-State: AFuF++kow1+0kIH5sY4SSTMM66xktm9+iHs1Yv2473sZBRW7IgX+rPUv
 mks+l5JpB5GKBQCQXDADFy+Y0jTGbMWwVAzBB5krvL7J0Mg6WHhubFWURBecxwv+
X-Gm-Gg: AYBFou1mBgkp6vjwlwwxFrLIadZ0Jqyq5jvYmcGrI54FmzwZbibDoAX398AV1cWxxRC
 O52ttTgLKw7tK7fIqERCTu3eFakLEFfK85V1FXExSFfuIYwRS+Y0J+qoLpv3B2bdmnXFOpX0/Fm
 wCpycc+5WVq7sKnYZ4CzlKzol1TlIPHXtir5t62txLEwt7+te9UCMWIhdSXD5pXTeUZdSi84XVk
 MmrQ5QKJDu1CUrddhy3szz+IpuRaUXaxaMADTE+RcGDqQXSwALcoSSy6WL1xcOtXXWuWXJdGCes
 OGr2Bjvhry9ePBEDpELS0AeraCnJyQvaT3i4bd03AZKIOn3wq/8wBFenfUaylmyMjO0sq8ViA/5
 YRn4ALmm3CvdIp+dvmFVkWXZ7JBbrJiRs7pPeeBgUu+yJcrus3xDfocqjVDxiLHUA4TveJT4e/R
 3BjUHI0CEQHTsdJBjSvtawPaKLl/UCy5KVjY+4TgzbW2amkssJvUX9gkcweayCFM03BsWapZzcm
 N+3yIyDj6arYoSMWAEfHLoLtswq9pCXlMZScpjeavIXhAr/cNoBhC7EW11owW/I2N8kXpiT1BwR
 SLChtzuO3LhFNDJhNYYlOc1SMIaSx2/qYajY21pibg7ciMqMX3ydlC1oth33iL5j3xkckXF9mhu
 Pm1brq/ky1gXvbvbhNuXP
X-Received: by 2002:a05:6870:3e04:b0:48f:e0f6:c463 with SMTP id
 586e51a60fabf-49358307ddbmr9730409fac.49.1790641330946; 
 Mon, 28 Sep 2026 17:22:10 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:10 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:48 -0600
Subject: [PATCH 11/20] net: cache accepted DHCP acknowledgements for EFI
 PXE consumers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-11-2060c7365b0c@gmail.com>
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

Copy the lwIP ACK from its receive pbuf, including chained buffers, and
publish it to the per-interface EFI cache only after the lease and boot
configuration have been accepted. Do not cache offers or malformed
replies. Move the legacy cache update from OFFER selection to lease
completion as well.

Populate DhcpAckReceived together with the packet. Use a common
cache-to-mode helper for initial protocol registration and live
updates, searching newest first. Exercise the same helper from the DHCP
wire tests, including malformed ACK rejection, repeated leases, cache
wraparound and interface lookup isolation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 include/efi_loader.h        |  3 +++
 lib/efi_loader/efi_net.c    | 49 ++++++++++++++++++++++++++++++---------------
 net/bootp.c                 |  6 +++---
 net/lwip/dhcp.c             | 24 +++++++++++++++++++++-
 test/dm/lwip_dhcp_options.c | 31 +++++++++++++++++++++++++++-
 5 files changed, 92 insertions(+), 21 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index ef25124fd84..830b086e6a2 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -82,6 +82,8 @@ void efi_restore_gd(void);
 
 /* Called by networking code to memorize the dhcp ack package */
 void efi_net_set_dhcp_ack(void *pkt, int len);
+/* Populate PXE mode with the newest cached reply for this interface. */
+void efi_net_get_dhcp_ack(struct udevice *dev, struct efi_pxe_mode *mode);
 /* Print information about all loaded images */
 void efi_print_image_infos(void *pc);
 
@@ -102,6 +104,7 @@ static inline efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64 len)
 /* No loader configured, stub out EFI_ENTRY */
 static inline void efi_restore_gd(void) { }
 static inline void efi_net_set_dhcp_ack(void *pkt, int len) { }
+static inline void efi_net_get_dhcp_ack(struct udevice *dev, struct efi_pxe_mode *mode) { }
 static inline void efi_print_image_infos(void *pc) { }
 static inline efi_status_t efi_launch_capsules(void)
 {
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index c2b85dac236..331efb9a5f2 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -766,7 +766,7 @@ out:
 /**
  * efi_net_set_dhcp_ack() - take note of a selected DHCP IP address
  *
- * This function is called by dhcp_handler().
+ * This function is called by the network stack after accepting a reply.
  *
  * @pkt:	packet received by dhcp_handler()
  * @len:	length of the packet received
@@ -777,6 +777,9 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
 	struct udevice *dev;
 	int i;
 
+	if (!pkt || len <= 0)
+		return;
+
 	dhcp_ack = &dhcp_cache[next_dhcp_entry].dhcp_ack;
 
 	/* For now this function gets called only by the current device */
@@ -798,8 +801,33 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
 	next_dhcp_entry %= MAX_NUM_DHCP_ENTRIES;
 
 	for (i = 0; i < MAX_EFI_NET_OBJS; i++) {
-		if (net_objs[i] && net_objs[i]->dev == dev) {
-			net_objs[i]->pxe_mode.dhcp_ack = **dhcp_ack;
+		if (net_objs[i] && net_objs[i]->dev == dev)
+			efi_net_get_dhcp_ack(dev, &net_objs[i]->pxe_mode);
+	}
+}
+
+/**
+ * efi_net_get_dhcp_ack() - populate PXE mode from the DHCP cache
+ * @dev: network interface whose reply is wanted
+ * @mode: PXE mode to update
+ *
+ * Use the same packet and validity flag for newly registered protocols and
+ * protocols which already existed when DHCP completed. Other PXE state is
+ * left intact. Search newest first, including after cache wraparound.
+ */
+void efi_net_get_dhcp_ack(struct udevice *dev, struct efi_pxe_mode *mode)
+{
+	int i, j;
+
+	mode->dhcp_ack_received = false;
+	memset(&mode->dhcp_ack, 0, sizeof(mode->dhcp_ack));
+	i = (next_dhcp_entry + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES;
+	for (j = 0; dhcp_cache[i].is_valid && j < MAX_NUM_DHCP_ENTRIES;
+	     i = (i + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES, j++) {
+		if (dev == dhcp_cache[i].dev) {
+			mode->dhcp_ack = *dhcp_cache[i].dhcp_ack;
+			mode->dhcp_ack_received = true;
+			break;
 		}
 	}
 }
@@ -1134,7 +1162,7 @@ efi_status_t efi_net_register(struct udevice *dev)
 	void *transmit_buffer = NULL;
 	uchar **receive_buffer = NULL;
 	size_t *receive_lengths = NULL;
-	int i, j;
+	int i;
 
 	if (!dev) {
 		/* No network device active, don't expose any */
@@ -1242,18 +1270,7 @@ efi_status_t efi_net_register(struct udevice *dev)
 	netobj->pxe.set_packets = efi_pxe_base_code_set_packets;
 	netobj->pxe.mode = &netobj->pxe_mode;
 
-	/*
-	 * Scan dhcp entries for one corresponding
-	 * to this udevice, from newest to oldest
-	 */
-	i = (next_dhcp_entry + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES;
-	for (j = 0; dhcp_cache[i].is_valid && j < MAX_NUM_DHCP_ENTRIES;
-	     i = (i + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES, j++) {
-		if (dev == dhcp_cache[i].dev) {
-			netobj->pxe_mode.dhcp_ack = *dhcp_cache[i].dhcp_ack;
-			break;
-		}
-	}
+	efi_net_get_dhcp_ack(dev, &netobj->pxe_mode);
 
 	/*
 	 * Create WaitForPacket event.
diff --git a/net/bootp.c b/net/bootp.c
index f0dc329d6e4..320a545ad5d 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -1125,9 +1125,6 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 				goto dhcp_got_bootp;
 			}
 			dhcp_packet_process_options(bp);
-			if (CONFIG_IS_ENABLED(EFI_LOADER) &&
-			    IS_ENABLED(CONFIG_NETDEVICES))
-				efi_net_set_dhcp_ack(pkt, len);
 
 #if defined(CONFIG_SERVERIP_FROM_PROXYDHCP)
 			if (!net_server_ip.s_addr)
@@ -1155,6 +1152,9 @@ dhcp_got_bootp:
 			/* Store net params from reply */
 			store_net_params(bp);
 			dhcp_state = BOUND;
+			if (CONFIG_IS_ENABLED(EFI_LOADER) &&
+			    IS_ENABLED(CONFIG_NETDEVICES))
+				efi_net_set_dhcp_ack(pkt, len);
 			printf("DHCP client bound to address %pI4 (%lu ms)\n",
 			       &net_ip, get_timer(bootp_start));
 			net_set_timeout_handler(0, (thand_f *)0);
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index f41def23112..c68f97c5d89 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -3,6 +3,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <efi_loader.h>
 #include <env.h>
 #include <hexdump.h>
 #include <log.h>
@@ -38,6 +39,11 @@ struct dhcp_boot_data {
 	bool have_ntp;
 };
 
+struct dhcp_efi_cache {
+	struct efi_pxe_packet ack;
+	u16 ack_len;
+};
+
 struct dhcp_options {
 	struct netif *netif;
 	struct dhcp_boot_data reply;
@@ -48,6 +54,8 @@ struct dhcp_options {
 	u8 uuid[1 + UUID_BIN_LEN];
 	bool have_uuid;
 	bool append_failed;
+	/* Allocate one packet cache only when EFI consumes the DHCP replies. */
+	struct dhcp_efi_cache efi[];
 };
 
 /* The address-less runtime attachment excludes a second DHCP command. */
@@ -237,6 +245,13 @@ err_t net_lwip_dhcp_ack(struct netif *netif, struct dhcp *dhcp, struct pbuf *p)
 	if (ret)
 		return ret;
 	active_options->reply = *data;
+	if (CONFIG_IS_ENABLED(EFI_LOADER)) {
+		struct dhcp_efi_cache *efi = active_options->efi;
+
+		/* Copy while the pbuf is alive, publish only after binding. */
+		efi->ack_len = min_t(size_t, p->tot_len, sizeof(efi->ack));
+		pbuf_copy_partial(p, &efi->ack, efi->ack_len, 0);
+	}
 
 	return ERR_OK;
 }
@@ -436,6 +451,12 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 	if (dhcp_boot_env(&options->reply))
 		return CMD_RET_FAILURE;
 
+	if (CONFIG_IS_ENABLED(EFI_LOADER)) {
+		struct dhcp_efi_cache *efi = options->efi;
+
+		efi_net_set_dhcp_ack(&efi->ack, efi->ack_len);
+	}
+
 	printf("DHCP client bound to address %pI4 (%lu ms)\n",
 	       &dhcp->offered_ip_addr, get_timer(start));
 
@@ -500,7 +521,8 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		log_err("DHCP hostname/vendor class exceeds 255 bytes\n");
 		return CMD_RET_FAILURE;
 	}
-	options = calloc(1, sizeof(*options));
+	options = calloc(1, sizeof(*options) +
+			 CONFIG_IS_ENABLED(EFI_LOADER) * sizeof(options->efi[0]));
 	if (!options)
 		return CMD_RET_FAILURE;
 	strlcpy(options->hostname, hostname ?: "", sizeof(options->hostname));
diff --git a/test/dm/lwip_dhcp_options.c b/test/dm/lwip_dhcp_options.c
index ce391f5e20e..1d3923291bc 100644
--- a/test/dm/lwip_dhcp_options.c
+++ b/test/dm/lwip_dhcp_options.c
@@ -3,6 +3,7 @@
 
 #include <command.h>
 #include <dm.h>
+#include <efi_loader.h>
 #include <env.h>
 #include <lwip-dhcp.h>
 #include <malloc.h>
@@ -45,6 +46,7 @@ struct dhcp_options_test {
 	unsigned int undi_count;
 	unsigned int uuid_count;
 	bool chain_failed;
+	struct efi_pxe_packet expected_ack;
 };
 
 static bool dhcp_options_chain_check(struct dhcp_msg *reply, size_t len,
@@ -214,8 +216,11 @@ static int dhcp_options_reply(struct udevice *dev, struct dhcp_msg *request,
 	}
 	*pos++ = DHCP_OPTION_END;
 	len = pos - (u8 *)reply;
-	if (type == DHCP_ACK)
+	if (type == DHCP_ACK) {
 		test->chain_failed |= !dhcp_options_chain_check(reply, len, kind);
+		memset(&test->expected_ack, 0, sizeof(test->expected_ack));
+		memcpy(&test->expected_ack, reply, len);
+	}
 	ip->ip_hl_v = 0x45;
 	ip->ip_len = htons(IP_UDP_HDR_SIZE + len);
 	ip->ip_ttl = 64;
@@ -310,6 +315,29 @@ static int dhcp_options_tx(struct udevice *dev, void *packet, unsigned int len)
 	return ret;
 }
 
+static int dhcp_cache_check(struct unit_test_state *uts, struct dhcp_options_test *test)
+{
+	struct efi_pxe_mode *mode;
+	bool valid, equal, empty;
+
+	if (!CONFIG_IS_ENABLED(EFI_LOADER))
+		return 0;
+	mode = calloc(1, sizeof(*mode));
+	ut_assertnonnull(mode);
+	efi_net_get_dhcp_ack(eth_get_dev(), mode);
+	valid = mode->dhcp_ack_received;
+	equal = !memcmp(&test->expected_ack, &mode->dhcp_ack, sizeof(mode->dhcp_ack));
+	/* A cache entry for one interface must not appear on another. */
+	efi_net_get_dhcp_ack(NULL, mode);
+	empty = !mode->dhcp_ack_received;
+	free(mode);
+	ut_assert(valid);
+	ut_assert(equal);
+	ut_assert(empty);
+
+	return 0;
+}
+
 static int dhcp_server_check(struct unit_test_state *uts, struct dhcp_options_test *test)
 {
 	const char * const servers[] = { "9.8.7.6", "0.0.0.0", NULL };
@@ -395,6 +423,7 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 		ut_assertok(env_set("dnsip", "1.2.3.4"));
 		ut_assertok(env_set("dnsip2", "5.6.7.8"));
 		ut_assertok(do_dhcp(NULL, 0, 1, argv));
+		ut_assertok(dhcp_cache_check(uts, test));
 		ut_asserteq(1, test->discover);
 		ut_asserteq(1, test->request);
 		ut_assert(!test->chain_failed);

-- 
2.53.0

