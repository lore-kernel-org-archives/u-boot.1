Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F38C88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 078D480EBC;
	Wed, 16 Sep 2026 13:09:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qRfcujOUnQdD; Wed, 16 Sep 2026 13:09:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 187FC80EB1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564141;
	b=Q9BF3t4q/ZGONwJgG36EayIaa/Y2shCpqoVnMlF1rwNmWKUVWzX+HBoWTDqo535WZYMu
	 6buuYIdaQ/b0P4f09am4/XXQN/T+BzrvGBTWAnMCzFulom5zB4EiKByIRcL4RQQBn0kpL
	 p/EyNnExiCKAuixqt3QUjtKzeUEcmiwRDHbLOlrGbu6aufOdIK+13SDkD6ea+Ld0zaMaZ
	 1E5g3Aepw1iHD8IubIDtf0+8+N1i7ezySZgFONgrEDzUSVQboRvS8y0MOjpeszs70E1uL
	 rciNqYXHQe3mBHNTz+HHLrvL7oNc97kHMlgqOIB2/aMehmQdVGKIkK11E2qcPFP39uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564141;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
	b=qKziEWFrmN3SDQpejlrx2dQ17L5ofalq63VaF3n4uPm8Mw3pq0r1+kvO2KYXexQjRDgE
	 ETagY6hYZ5wag/BUEB8rmDm8d+6sydvksgxz1m4yrff7X59BOvr2pDqthibR/htdgYCft
	 iRBFhx04QIS5uNKc/1kfD2uTCD+SrPDNBQeRi0JWoRZJdfeidiHY4W3DmR1CR5sEEFgXp
	 zHH0PTvpqmfnralqwN8PCSPhUDyBsDwq1lXNRvL20pGDOh0IUDudFg/7njDFh88UfjokJ
	 n6crQgQNykNn2AHzsXRQ+o+mtlD/lxR6cJVVLG+XOw5RTcWVkdJ/vqAvDvwLQ7cZlDw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564141;
	bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iMNys5Dqo0JeW/r035oTQBHfB4vMzKw+Jw+p7Gu3c8dEetD3cVQe5WnGTmAmqMzgG
	 iNpU8ybt3HW00wsyHpcFD3YCZK4z6/1Sn+Ki5UTcnlFHTTNtp56T5prmSu8vFjePTp
	 5LJr5mA/Nebig1z0Ot8gAwPEt+7da+KIMyU/Y4XvxLJU16mq7p/X1+C+jZp5v3YxEe
	 9m+NU0Ed/3/qlNkrxW3bO6trc71spslMK9VqpGO2CsGBHaf7k1I5LPB+2EzHVpxYJp
	 FcWEOsJP6NzMm7MVFKwHlmNENPalvVAiMhUysfDeWSmPJSIPj8m6WqeZF+I79OjZqP
	 3Vz2dTgu603+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 187FC80EB1;
	Wed, 16 Sep 2026 13:09:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 527A524D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38860406FB
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kPzvs1dHDmk2 for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:40:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 11926406F7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562430;
 b=PcFOOV7fXsQyqcCTTvm6iI/u6q1MgJBVBhopOF531mgeIlXF3TzYjAN9PMViIK2fCexE
 KxA9WvvY3N+zZ6di+6bwzzvqyIaCgQ95VrtES997gBuF1I10/iRh9drqRp9fiVix78UCv
 YPZdANFuowuiw6VthmNzKbCXAbMjggMk2sIJmbyivLss59LNeZu7pPgvki5UjDzFrpWiK
 QwqjF/88rhunysDUrz1LNG/tH9lSAtzCG/P3W5s4HrQgjQphUvKuOGO8IYABYf54qZWQe
 4ALUn3zrLZ0QQOHaqLC4OUqf0JI95FYeanTdSKQoWAfeXcira69v7wfvioet9Mv0ypg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562430;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
 b=FW81x3eDpu3K8+auq21e27oWbVAn4WKuT2qhRU8HwZFEXJVCRsn68SVLVCHHt7MjUyyZ
 wDwk7Zr6TqlkkVOZhVmm88ezCHFIHrt/L5w8G1T52OYwNqTZk+xp+IeG+y2pjvDG6VNVB
 c52MdIJ4Am+1/KXqKUAX3PdvGFgb+6NqELTtA3f94URklNuXFvIU2tgQ0tP4W6qnxSZdz
 pn/SKIaKuYFLBc1MvylOaxejvWJ/kHUy+x7qpl8xztY0f/wlsJaa1f8mmn7yLL2LEvrdC
 QX5LqEzQ9+HTEAsI/stndLCb3OUApu6zc+mm+6wZFQxTUETzHaLOAOzCYNboR6Te+WA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zKnXn+0L; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::c;
 helo=mail-ej2-x0c.google.com; envelope-from=anders.roxell@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zKnXn+0L
Received: from mail-ej2-x0c.google.com (mail-ej2-x0c.google.com
 [IPv6:2a00:1450:4864:34::c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11926406F7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:29 +0000 (UTC)
Received: by mail-ej2-x0c.google.com with SMTP id
 a640c23a62f3a-c29d7878688so17729166b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562428; x=1790167228;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
 b=zKnXn+0LQ2v0VYIuB0UYJ49vxFmbcph1nhs66QubF1om5O7T9K4XZB8SwIO/ULv6Qg
 2h008YrWe07exg4Nuqp7Uhk6+IgLlIAG8bX2DhPYF/A+dJkFXAemJYbdy5PcA108EJxd
 E1TsLael9ASqPXQKl84CxoDz0QygoTfOCK/IqZxh31vioeLJOIpcHdbFs7n+WUPIpJTO
 JSNppTX0PSbmzfscz1+R79Xh+8ueRuGBAvKj1BdS5nEjUN6toM9EQ3mJPOs2LQYe17kW
 SWm0lcEMIjOXFWDvq4KbVXZ4R3J4oCHe700hG8RcGDr31aoGUxd5l08fyUra4P4Lph8q
 C8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562428; x=1790167228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
 b=mpee8zlwZaBRdETuOwmXpQtbN3kBczXYLuUNdat3uiqMf+52JaA9aEKyEcqscVi9UA
 lK6YfNbJ6IkBuy7aG+z+Itj0HvmfVC/JfVFPjs8DRBReb4EGGs4rESzkzTRkJTiAUBJ6
 70Vz3XcgzVmm4zqXzVPbN7YPArkoHctPBTHO+H/vs6xEmZ9AuouRzvOsmqYk1Pz6DD+0
 /7S+J4MN8NmCALIX3jYXp9OqzbkbKRxB+7pqbEi/B2q41kiwAy0sqYPHVyQlmpw2HJ4Q
 ZsOTfROlrD6ECQGfuS5+Rly4dIvRXnEB29/kXE99XI35nVfycV6BVPjSK7i/3MtbKsIz
 QC2A==
X-Gm-Message-State: AFuF++mgK3Z52l7r20MwySbvgai3YjF2ZS0kml3hSr958BsBJ0STCkxD
 sHtMqObBgcPi5qEb+4gU4Ouirg/Wc4Ci0qcJpVvt8NNgk2exgp5zHy9OzB+7frRVHREwPmctgF0
 kG5GT
X-Gm-Gg: AYBFou1aUJRszmNQ4/PsTDeTOBDA0no6M/eu27m33xhWPFn5vXm5nHgV9WwJH+CpWXU
 4HTkhCIK9thzqoWkvF4n0m3sHmpCMNkL1vscJc38j+cJhyGqd3XPXklvWuURUR2oIV0q1F+RCkt
 qQ1QlQCPPNwCvzFB4qDIUu25RuxQUBdz38622EYtjKurvXxU/XLAjasHww62+T3OLluwfX64B1F
 fO8L/rQBqvFsv4kn/OhlV7EnhqCS+PqusoV3Ql5loHae+cRS/7p7YJ7925OTnNjDqQIWtHgyr+E
 d2oe85tYfh5cRWyboSbQKtEHzz5e2OkxYOKZtI8l8KmVxVasCr2C8vNZq/liAz3VfkaRFKp9/q0
 bumcrBxZLsaUO7V2cGCO4FMimSbdEWTCHtVgxAIVPd225lIUH5UEXIBUBSzvCGD0rjy7y6iC8sj
 YpvZHUBy5k9LCRQ9S0DsHNTV0vhoEdUMHqGNdueAl9Y03cNBjG0azQFmgtuL8304zx48r9UMkCl
 9+lwy1QTbcMdfigRP6W9sa8Iqkk7Pgq4WlnbvyLM38z2+snXp6077AEaY+/MF/a4qs=
X-Received: by 2002:a17:907:a089:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c29e54132c0mr165627766b.3.1789562427537; 
 Wed, 16 Sep 2026 05:40:27 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29e801cdfesm82430466b.58.2026.09.16.05.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:40:27 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v9 14/26] usb: gadget: ci_udc: set endpoint capabilities
Date: Wed, 16 Sep 2026 14:38:14 +0200
Message-ID: <20260916123826.517181-15-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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

