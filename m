Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4374B606A339
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vUGn1azy;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AEJzA7Ea
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D93F60803;
	Mon, 16 Nov 2026 14:01:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-k1iWTPbMkN; Mon, 16 Nov 2026 14:01:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6885C607D9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794837668;
	b=aeOre83BIR5CQr0QEqUWeITYxwqHmYrUWFTJByjCjR61qziWzA8xQT+JhD+dZ0oi98ko
	 2d1hlRHEwrgi9LrYJCcjqjJn0aBWnJRNkor9sy76mDjIgEWqP6Bzpr4xVWAPl1DtEnAuj
	 Bmy0CEKphUBKEzFBPbfEa0Rxg5SZpuypKswTULnlVNa8TzymZw6QTTHZfh10Ld9DNIY/F
	 NHoKLI0uuSFmO1Ld9wM/nVUpmnhPOElzTliOBKq5rikuVvd3hsZch741wkW8n/N2XfhQD
	 rVtrWUvWMApZs3iKwlP2Be/FQpjO/TD7DCv31Wz/kHyO83y9wF1fRaqQPwwJ0Mht84Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NIS9urSeK1rEQJOxAVpVcl6g8bkF4ecmpRsYvzNOXc8=;
	b=RfBhKR3Rkmn+CfzxX2Z1/HXder6/oRtraqvHEd2Qg0Bu0eJesDOhRYhL+ftNpZNvy8aD
	 NUDU/uIP1hUWayv+X5F186ayA9LRNRy2FBZgU6mr++6RBVA5L1451cZav+ThmO0EOA7sm
	 q3XsdKckHFfVefNf3Sl10qOW1GVYLz61xyLP/cDQeX6U+skgrlnrTle6WVybRRIlWRnjx
	 ZZEpnhIs8xYMv9vvmor2Pd9pJMKBR/GAgdhWX+Iyl8q8xvyarKdwj27XrmmFG92r2OgDk
	 dpJa/gW/TuZmh4qdTuBpGG+GHHEFoUcxN8Ve7gaq0R45JgfIIUby9M+ZTdUaQPUCkew==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AEJzA7Ea;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794837668;
	bh=NIS9urSeK1rEQJOxAVpVcl6g8bkF4ecmpRsYvzNOXc8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vUGn1azyBjTlWi4ubbzPIDj4ZXahgjAhhMdLw9DwBs3D3UjWLbLVLpTUVjBzH+6uw
	 En9qDvn+akCYWIZ7Lrr+p5x1KSPLhm6jKP4+u4ozlyD9AneEIvip9WpUWOdzqZSfgg
	 Ctk7s/EddnACHy2yKrbqCa1RW5wa2T8p8SuICeuludnPWRBySD8y0uv+7nMhU3zllW
	 cLPn1LYTI5pg4L0ml5OVsivkeugm/IAqIxex7tbDSkR8Ll+EbzztHNIkxjFCQBAp5Z
	 o++Pv61gI0RKEjPIHJshpwn1Viixn/BWt3lzUDHhYCGnsjMAwIuVsI3PAydx/pRoWf
	 6GNkHUHDP4Hzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6885C607D9;
	Mon, 16 Nov 2026 14:01:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9655B28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C6D66078A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0NTRbTv2CaQK for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:01:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7D8B3607F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AEJzA7Ea
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D8B3607F5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:03 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-49134c8509fso3439909f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794837661; x=1795442461;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NIS9urSeK1rEQJOxAVpVcl6g8bkF4ecmpRsYvzNOXc8=;
 b=AEJzA7EajI1fcwwh/9O51IQn8SR9iUTHmT+s5tO4BQ5K7ZA9Z7y9gwcPOBw5zHuSkG
 twjeorUr2JAJwnSL9q1ZMgNsFrn1q+sW+le3fk7u4O1rzMnNTrR3pHiHBOAxAXFbK3R5
 7N8E2mE6EmeCHU6/tkdcJVPxwlbxdf+j/x8GyWSP2LXILQpqlAEPncOsejZ/4FR5R2z3
 deeM/7ZSfHyyQE/4nmT5TwzCP1AQbISGhfA1T1I/lP/DL2s7mZtl6wlUuaw9j/kdXOuJ
 gwoYrvtHM8A+1G/oV5YiWvpnIPv7NAdb1EE29YZ3a0LH+9Ph0i9cDFPgK/hScVSReXVh
 mGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837661; x=1795442461;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NIS9urSeK1rEQJOxAVpVcl6g8bkF4ecmpRsYvzNOXc8=;
 b=vmCgJswRBNYBO/54hHHXfjhIToPKJBgLuDNQ/hJw3h1blQYXZ+5pm2UK52tFtU3WDt
 +IsX8sS388j1YTLj/Iq0rdxy3SdMBXsPrCiwKKCFozM5RqPMZqraxKZYIfAqtXz6kusB
 OfoGS2DOtL6MjfhSEerPoWztqK0LvKAignGa+dndWsj9vfeTkcnH56sIVQ33wVdt5s3g
 oX1Qj2Unj2NDOqM2/Pd3yM7ozwiVsLPkaFMNHRm1U54hsUDgHzE+va+yqhk6y1cUT6AM
 VnJcCdLef/TPBTlJOGQIRrYO4rzGI712YVNaDi0BaoOkD3n7hRuYHU1hhjCpRfYPEW3Y
 VGDw==
X-Gm-Message-State: APuU4Z9DBmAqnQA0T7w1NmQPiFRi2K+X/pe3K27RMkHadbB5CN714UVx
 VYA9qDudjVK3dSVbC/J5GXFCbgGCMQ/da2ZVJuhMRNgsmyR3eh9XANg/mFEuNX+DQbw=
X-Gm-Gg: AZFdTZdknM9u8O5jujVPDwuRJv0wuTepK1ZG3UwOJ7N6BHYY9/SeRE4uewpr7vtV4vG
 TY7R/+qUKdoWZukpatkXJR3fI4OpgkF/gLmS089ZU86BoVdhQW/Bb0ajXSwqgL1qrgcZ6j1OMVm
 YlPbffNz1Vi5bpYTxDGLPwfwQq14Tu+1bLhG3gdN4sJaOj1aIY89fBNzVCjZD853ZRkTy+R4pez
 e0bsvWhtARPwVxun6PCwdSG/IYyCX9lnsk/IsekMraiCjOw+SH91AyiScN+lZGIkDuG6lAM0YTO
 mUJp33g4h5ZnXoIdT8mIUia56Skh2kHZFLgzX1bqE/5wUb+XSUK6SBVUmIAsx749HYVWoJAedct
 3l8Iy2Cq+R/xPdDKfsDVCVySE/DSHqc0T6wCV13k9bUnNVVvQW/kACe6hG5tsuX5ibGSTley03z
 xbpRcE9NoPhnReVSC6gD/OsbSX7gv9qG+khTr++XOonp6To7rfSv3/ZAmxxM9dtJJ8M2/95xH5b
 KnS+dp62aq8TWkXBeU3V10DyfnthAYZf/5rwWDorr56XTN/dgboGO4duitKE8wQfAgQnw35N9j1
 a36G24lJkbkIZb1NJgXmZDh345mOl3anfYG8KvDrSDHf/Adv16sDq4U3kOdLLXeNX3MnFADJ9ws
 iGXZTOGU4NX2uMbEOCsLYG4MgUozvOQQfYZ4DE6RPcFBYSDwmKVJf2H/BcS/ZTXDNJDk=
X-Received: by 2002:a05:6000:46c2:b0:48f:db47:6ebf with SMTP id
 ffacd0b85a97d-49c729bb31fmr15681314f8f.38.1794837661260; 
 Mon, 16 Nov 2026 06:01:01 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c69406640sm22119355f8f.12.2026.11.16.06.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:01:00 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 15:00:49 +0100
Subject: [PATCH v3 3/7] usb: gadget: fastboot: do not boot after a failed
 acknowledgment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ccaione-upstream-spl-fastboot-boot-v3-3-7b39e7a348c6@baylibre.com>
References: <20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@baylibre.com>
In-Reply-To: <20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>, 
 Rob Herring <robh@kernel.org>, York Sun <york.sun@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A failed transfer of the boot acknowledgment must not start the image
or leave a boot callback attached to subsequent responses. Keep the
session usable so the host can retry the command.

Fixes: 3aab70afc531 ("usb/gadget: add the fastboot gadget")
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/usb/gadget/f_fastboot.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 9a2e9850112..68fe657f891 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -492,6 +492,11 @@ static void do_exit_on_complete(struct usb_ep *ep, struct usb_request *req)
 #ifndef CONFIG_XPL_BUILD
 static void do_bootm_on_complete(struct usb_ep *ep, struct usb_request *req)
 {
+	req->complete = fastboot_complete;
+	/* Do not boot if the acknowledgment transfer failed. */
+	if (req->status)
+		return;
+
 	fastboot_boot();
 	do_exit_on_complete(ep, req);
 }

-- 
2.56.0

