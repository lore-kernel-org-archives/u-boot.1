Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA01FC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7995880F6E;
	Mon, 24 Aug 2026 16:47:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JeiX4bTBJsSw; Mon, 24 Aug 2026 16:47:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589947;
	bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P1Ca5YnJ6pJon0HzWJiND9bdjE1vVK2Rr/jWAdNhrraLCAYOtVGPDIC8Jvd8nYVDV
	 NgUQej18vmqLXETK2BV0fXYv6G0qcEcrIH0IlPoBU5iHV8/qHM0DmgJ4Buzc0O/pDJ
	 mG03m4k3GuHvo7vGlv8GaG1prmKiUQ5o6p1F2xzZ6tWmIZ7hUBcdc9L67T+GjZIaPP
	 NSCQIIoo1rBt6vBYmyhj/DKtV4DvLTlSCQhD3zyJjR6ENrYm6E8BxCTeNPpsUTeqdn
	 KoCoePKICWh6wZWxrtkRsJy1qy5WjzQeBhPbb0gaa0bkjL0RSdK0Ros9/XmGK39uuY
	 05IbXhENuYHFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73E7880F73;
	Mon, 24 Aug 2026 16:45:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E1AC72FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA02940540
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a2C9fOOsMJsa for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=l3BvTRKT
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C45F14053E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:04 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c166ec26696so31898166b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586182; x=1788190982;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
 b=l3BvTRKTVHXJBSOBWx408jICv0myIH1BfI3FLoiE77XNeCDA7SoVAE38AzoDhdGdhO
 NB7thGUOjETseB+yrJaQRtV8IafmSyPb9TRZxfxCSe8jIbENq9Vd6zpSjj6mvHGfiSRU
 gEMhkP8Ecl77vCt5cstrtLekPmiNbJV6/fZQ40JB/vjM/LQRBrShXR6OMRQutoSxmFB2
 iusir3BbfYrz2QE8Vk0KBe/witsiBsr/t9/cMke7BdrPyAZu0N+AmKiB0pqJASjB+Viy
 f5HK4w4JEl4CGLq+aKxfcAyZJft8o5opq/WBhEBKJl6TXvVJp5DLCTnQggJznSbd5mvN
 m2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586182; x=1788190982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
 b=c+fWbjwu4A/T4yTNn6hXi6aqzA31SLZ0IuV1MMohFtcsxJ0sU87t1UWgJjoyeIysgZ
 kYPCkUhLJxaVg/VO87PWgmZKq92Dga24pJw1oLkreyptIgx2SGGzG0yMfONdHPP3rrBU
 FDvvzRJ2dpp3hb4dbQX1S3FccfKeTPiumcTZ44dCTRuR0Kzy9HGUJW0zU9RhMhAHNXWk
 IXgQx5WD7dq+lcjI+JuTZ7xtNZsFXLYXzZsvvHKCeBFU5ijdbad5C8ewh3xYWvKWTLjV
 S07jiQgpmEf8l2yMUYc81QTIW85/VE69U73Xj7FVyu2V5fr6AGUOu0V4QRsdKJ84JOhC
 tYGg==
X-Gm-Message-State: AFuF++nHBbHm7lO+/GLRksdzYEVx3ueeqJXRCEF/ESqDL9mzGSlXb4DV
 vGSNWRw/d+qqNJxShofDy8lp6tzbXKD4ZTVhrQSujC4f0acE3/QEjmcLY7vrEiZWxQE420wfwTN
 ew5ax
X-Gm-Gg: AR+sD12uX47KXW1Dm2psk7npzyvkgmlIlsLJKsGVssrlfGICIU/qrtWm6nNmfh4tKQU
 I5CoVA8CvCD8R7hIdI2Zc/pUjRD4WdM4iiIOei631REcg8zLi/vbNW4d5D49kn4XUI+kIM5NukP
 mY8CxauiGyFfirFt2Rb5gl0PbXdiOKqVjPXD2LVMe7vIXquyCgWEryaM8Lfh+rAuaevuFcOWhob
 MnsBNrv9yiC2kNQOytiEuvaL1SwMX5KGksTOKycZM6MFHZo+XTME4T10G6FDFV9tG302D82Y+OL
 p/G3VLOTYEADthubM7fEUXFU32GXEXMfbM6CoESRLCYR/u7H1Cunve0dLKOffX33Y4UB3lKWW5+
 LchJsrdcm9YzftSj44wtvy3o1aVhK5gm9GdK02JMnsxU+xQKrSHs7VW7UrZMmoFmSbT3Vr3HACo
 dGDd1JZRWUXf7NP77vLaOGundu0PQGxhV/iRXBdKaRH8VAGc6OAi3kdb0EmjAnq2QVUYkk/npRv
 QoA5yYV8yx3Hxx4joTJ/w==
X-Received: by 2002:a17:907:cd0e:b0:c15:ccda:26d5 with SMTP id
 a640c23a62f3a-c246a63d6b3mr1734183366b.4.1787586182412; 
 Mon, 24 Aug 2026 08:43:02 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e19a05bsm13368763a12.17.2026.08.24.08.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:43:00 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 12/24] usb: gadget: ci_udc: set endpoint capabilities
Date: Mon, 24 Aug 2026 17:41:21 +0200
Message-ID: <20260824154133.217744-13-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

The resynced epautoconf.c matches endpoints on the caps field, not on the
name. ci_udc never fills caps in, so usb_ep_autoconfig() finds no endpoint
after the resync.

ci_udc keeps its endpoints in a static table, so set caps and
maxpacket_limit there instead of calling usb_ep_set_maxpacket_limit().

The names say what each endpoint is: ep1in-bulk, ep2out-bulk and
ep3in-int are fixed type and direction. Entry 4 is the template for
ep4 and up, those are free, so let them take any type and direction.

Tested on an i.MX93 board with ums.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/ci_udc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 87194601f67a..69616b16b052 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -121,28 +121,57 @@ __weak void ci_init_after_reset(struct ehci_ctrl *ctrl)
 static const struct usb_ep ci_ep_init[5] = {
 	[0] = {	/* EP 0 */
 		.maxpacket	= 64,
+		.maxpacket_limit = 64,
 		.name		= "ep0",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_control	= 1,
+			.dir_in		= 1,
+			.dir_out	= 1,
+		},
 	},
 	[1] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep1in-bulk",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_bulk	= 1,
+			.dir_in		= 1,
+		},
 	},
 	[2] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep2out-bulk",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_bulk	= 1,
+			.dir_out	= 1,
+		},
 	},
 	[3] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep3in-int",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_int	= 1,
+			.dir_in		= 1,
+		},
 	},
 	[4] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep-",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_iso	= 1,
+			.type_bulk	= 1,
+			.type_int	= 1,
+			.dir_in		= 1,
+			.dir_out	= 1,
+		},
 	},
 };
 
-- 
2.53.0

