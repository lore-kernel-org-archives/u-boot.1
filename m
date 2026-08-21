Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B7CC5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5536840E7F;
	Fri, 21 Aug 2026 13:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FT8iCIPx187Y; Fri, 21 Aug 2026 13:16:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318148;
	bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vgw92wgOncomB9Qt63QTfUK9ZTb9jU4ii0To3bKXun6rU1xpWivrXcDzRR7cUxuKH
	 ziI4maWGhRt/wJfDKxjJkyG3YMtVuIrOtV3s/8u3Zo7qFquscb0Ow4WiKcg3hG6KNw
	 SnL9quixrkIFrZySbJQhCcQuBalwH5ItenAtWPx9Ij03/pLJ3cAkldustVtc8tqsln
	 EiEuYefkdvO0QVSOfxn9bA1b8Hmi89iJH1KjdwSbMeMzsztJMUulAFALC9V7/a0ale
	 QwlDDaRnNL5rN9an+i094yq6nxqsVwH2R2l0rcPqeTsEeJkUosdsnVCX75m1cYDVg7
	 A7KRuznMLYKNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB6AF40DE4;
	Fri, 21 Aug 2026 13:15:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 67BFF263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 22ADE4006A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JCqr_Zz7_r7a for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=AUfQZnIG
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5A1140090
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:38 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a18d89e4d9so168486a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302357; x=1787907157;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
 b=AUfQZnIGzJhDgKgLj2bSomuKOKK5rCsXHKHfWFD8jj5Nn4WbH8OFPzVXjhgL7nK1nJ
 aFvXGZbsCAtcOelglEvDHFtCK3yjXNE/+67w8tK5CNe9NpIGIZxpaNUl8vr6fnjjoGYL
 EimR4u1NyszBWI2K5ERD/8UB++QT45c9UAwqzmwPiwjT8b30FHwdjppjfKo24SkgFSdG
 RdeOzQLPnSm+H9Dm5rI4N1Ao0thYU3jm2SowEXG0/y/yMIakvoD1SiDTJqf89U5hP5Av
 9kgIjwxiXrjJpVIMiQU2sw5YM1YbbiBGxXwfo9SI93WHQ0+bCJBcNPVDEagSV+qnck04
 4+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302357; x=1787907157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
 b=sstHBnGPo2Ht7MLPAwBs89HdDfZIWLSSycfhXgpIxkx+mjLkxluPvytmRyCEcciHNI
 N8086RylrBTnIq7K2o1Rxyyz2Lwmo1dAoTGA9amnWYlhFLxQQ9taT3Eq7SYy9UL4tFhd
 w9rtvypBhxJgGbtu1eehr4ByfLXYzpFjUQgQSR/4EVcR/dml3UJ2uouzyqBhymVsUqJo
 3gTmC2jpghUJGKeuGnaAGXPbkFZDld20tytha6UDJ2TAmY0q92EfwrLOooQBiGUT0bxO
 zHMnJdrrL6BSKEXaAVejSKScovgbrZdZefc6kIpI80xbEVgpenps2wcspXJ5XTrXSsnl
 FtPA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7bb2Zcix92E2p/z4X+Ogaq6zoo7liuP/eZdMIQKSDZRG+m+xGk9uTK95M4dmGEzqv/eUfQiU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lCQfCFDT2M5r+emIzts0fPux07RYVsQqQvgnLVKI0UTUKHkriE
 i54+LJxtmXiyeq4J5yOA2Ye1Mn30/Scp8jTEJNEvPlcan5WuNLg5H3dZeCD7SehskIQ=
X-Gm-Gg: AR+sD13Znmx+3Dg6CDblobUTYzr4htqG/aULiVcyoV0a1uTT64C9bPTuYBWzSH29QWj
 L78HLDN1ThEtp3bYN0zByC3UeChfujMnYNCYwEcKqpA5gzk6gSwhM069xFJxWkdPX/uzx8grNr7
 hKN6G0EZ+sbWnA8kSHc4lpPOUGGEinURm0VAmrxtb3TTb41xWte9rOapawUFDCPQtTwgVYv+gez
 2aqwJtBOfo9biuhrGwsrOcwb6pXoBlLrCigYivYLtDPf/Mzhm3jvvLcCx6gblnBpvYHuUJ3kqu2
 DhIleECDfOWXBxzv/kvcVtkd7muuNogyuHhDfw7BvPhIN1E4jK/oRgpR1fnn8i3QNmzD0o9IZGI
 Sqfb1yrBVt8+xloguxGvBMJ1TP0YFTcs9UQF6Ppn5EXswsbvxhaL3Fo6R3HctuEkDhdIYx0a9N6
 zFCC8PlcsqQHM7i020YmyjoU0lTG9NUiu8W53ilLdqJ6tyFUuyUi+yCZYyUAgYizxQK1zRYrRzJ
 8e+up6q33Fs9BAcMGhnn83D
X-Received: by 2002:a05:6402:44cb:b0:6a4:32c0:3e96 with SMTP id
 4fb4d7f45d1cf-6a432c0408fmr1479694a12.1.1787302356843; 
 Fri, 21 Aug 2026 01:52:36 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff0c30casm5329536a12.7.2026.08.21.01.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:36 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 75/87] usb: gadget: ci_udc: set endpoint capabilities
Date: Fri, 21 Aug 2026 10:47:51 +0200
Message-ID: <20260821084829.2070426-76-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:41 +0000
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

