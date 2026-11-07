Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE19606A32D
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jgmyFEoY;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T7rK5+ik
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51CE360904;
	Sat,  7 Nov 2026 12:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xBsL7zGO8I_I; Sat,  7 Nov 2026 12:50:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 63C6E607E9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055828;
	b=K03BnJYxYarL0jKySJr/UXLPCbJIh26/s5Db34UeC9pV1enaTeL3qbyo8detworbP61T
	 T9bZHjclSqT+a4hdTfdSlAWY99yDBxhW64IJr8dU/v+gU/SjqHGD9dAL354aWrCmZkNDC
	 Bu3jMV3H3M82Cb4pCrDmSNoDNOVRs4NhCtb9SamEzk83j/TBLjTWbGiKwa9EjzO4DqyRJ
	 how+PLtTYRy4bwhF9A8o1UeOAfL7bLHOc4st9xvPAD/wVo27MpcUZYg3OYQbh2F350UVB
	 idGbrL7Map/TlZrHtvfG/TmDWFhWG5027R1sqPO0DuPuQ2kzXuytmN6lHSPeYtmeSwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055828;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NE/lIKgu3sp3YG0/sADeEU3kLhDS4WYiOsU6g7IFV64=;
	b=bHC5mJ0GRYgU0JFgACsjhOIcz6j2I2u43FMRzib2erNIlaFgdDWH2B9XuWR9MxmBbQc6
	 MtIN8/kzn+0ARvroogCc4+NUe9z2ePwAsKqBzY1X8qVy7QxNKbbzRM9vqAK2FZ/ipRmGA
	 jTNJJChyCcU1dmNXYtEEbTJooCTNyJgSJ5gLiTGI1uVj1GDGyvkgK9nksJ789WJcBhMRq
	 hZwXiZQKTGKUMfw28mvKo1RWIAXNi2lJEQjCrY20z7YkD3Lt5mVTQCzreQBcReTegveBa
	 NDpEyROXhxdSshQ3mjWATJzc3q1hlztc2YGIyMUUpvjBmZgcrP1EHov1q38p+Mbe/Aw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055828;
	bh=NE/lIKgu3sp3YG0/sADeEU3kLhDS4WYiOsU6g7IFV64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jgmyFEoYEyt+aNq6yn4JmYJpoTSe1DmCEZAWE+jLXZ+1FkQVmo8/PcxntLkDoqp0H
	 cwSyev0q1nzglypqkKeYWKmllSkH9EzaE3gX2g23Pi1groVBG4Nm5Nc8AJU1Gt11xV
	 KYEcgjrrHLW+v829z+dgSEubhPr9gk/G9CVWZLJ1KmCPHMUjIzywlJAl+RMMVuD+uP
	 l+WBQ/+THZJT0mobDnoi25a54QPFPxfSVmi65tcApu1P8fgdO0FU4mnDvZDAKcVFAu
	 PmJbwpjtHH2Pj+xQBV4u5SiQDThw3ck+svjdIkQ+HaJy/bAI3IYc3/8colh/n6qmUI
	 0uYW82/z9KIdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63C6E607E9;
	Sat,  7 Nov 2026 12:50:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB1062AC
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8FC21811CB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qm_cYxxumY1x for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:23:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7D524811BF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=T7rK5+ik
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D524811BF
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:28 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b5869223e9so209561a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036206; x=1794641006;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NE/lIKgu3sp3YG0/sADeEU3kLhDS4WYiOsU6g7IFV64=;
 b=T7rK5+ikP53TspvWy8UFPWRzIL7dKVpcohdQJxUncRyRwOIOufX1/smLWqakq8VN+k
 3UBeiAWbYYzXVlkaeIW/gdB3l8Jltx5V+1WLzrRWd5ezuX/18lqwVBIr/xa/S5UUzDCY
 ncx68jYvJpEtRtRlKcCvi7cUGeZq+FepsrU2NS6wSXkKdSfr+KuIa6URYT7hIUkGm0qq
 wVKI2hEfvinurh4abkiwbCVbkIuTXuGEqaRz68VeaRpS4lnnduiT1/0jHJP3c93jCEJB
 I2CX7jHztYQnyFqNlXcMi4pFSCEQ1myyy6VYNHvwIEkHxIXmHhG6Q4eWR5U9aQp5HD33
 Cxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036206; x=1794641006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NE/lIKgu3sp3YG0/sADeEU3kLhDS4WYiOsU6g7IFV64=;
 b=gwU2YRQltzs3lZowl6GLftZU+xHjDdeFQo5QHdmlALr1e8ARt9Wc0rrKnCL7vj78qC
 Ku6W3SbUc+4eo3pSljMNwMCaS43x8N+qgJ02dsGegg1OZMGbM2hBNBE0bnzA5oWvmaSg
 LPJ8z0sgK71P696wRRN6DbYvmGzQoWTUFm+mwQlyP/AShIdasFDb/jAYLlCU8SvFZBGv
 PnXTx4/udIJg6wO+lBTAMZkQv+HN6f9MXZG4A5XILrZhYLp/YlA1m/HQeUMSofkL8VTZ
 cEqirmYQVSUB1BStRRt6PCOB93ripyM5HnUjBR6Fx8bV2TBakmv4ea440GsB5n6DYsRM
 EB2w==
X-Gm-Message-State: APuU4Z9U6ELop0FBq7/buQWGpFupbl8Ijx3JnnLZfx/IrfzX5kC+VwOS
 YdEZ/Br/uA2E8CWA2h8baG47IQvz1GaAvFzybXhSKrvfvkX5EB2Ot1zc3kOK/n9NG5o+02Ue+LT
 tJaJ4
X-Gm-Gg: AYBFou0YdG92n31Lu53IYg5Mib+NBWMsA9uXRENomOCy2D8Hdi0Han7GpKV17KiR1dM
 1U+/Dnfv2Qligc89LXySF6B3/Pulyo94v5FeO9TUphQroGWyVhJ+fctENPjrEdXm114B34oDZms
 AtuQlBiOmedibmPDcMYjLzsSaSHc/QdWWhmdyjtySJP4NA1+XqWZBc/FCgUuDrdwQOr94C8hLLi
 vSAgmsUzYt1Vn5GzARRj1YkZW8PLEkrQ5U9OgoxtCBN/FCfXwyzvl+VOEMzWtT6QE1Ev9rAAdJU
 0JYhvQepyJGRAOOFn9fAbtQOZdaglGhfZrVy8jY3ABlYqFQVRF793h2TntW7XNiO5bVxX7aqZcG
 ns9lFaOh+u5tVgecEhtQriVNtUTUct1pyHeMXNhC4KX9IeIWv5EAy8D9Ztj/u5EX7KTcyjyR/u2
 +tijHIXlVGSM0sSv0wANoHrIr4bGihCYz1jzruWt3k+kgyOZq//boH4abyMO9ZvDGvqfDj60o4R
 cUGQhSRNtQ4YRlXcZcBXk5bymFD1QzsEICmBMTdm9B+bLtNEaXBge7uN/2DQ/WZ8xx9xs4kFGEV
 38Ni0LMmOwuSteLdLSPyM6uyDmA1NLBy1WURml5l7I8KxmCfupxrLP5aXAIdy+CbSVgKlGNzrt+
 QL+ssH5f5tQ==
X-Received: by 2002:aa7:d7d4:0:b0:6b1:bfa2:28b9 with SMTP id
 4fb4d7f45d1cf-6b5977d30a4mr3616951a12.2.1794036205999; 
 Fri, 06 Nov 2026 23:23:25 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b664afe545sm1490649a12.23.2026.11.06.23.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:23:25 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v11 18/30] usb: gadget: ci_udc: set endpoint capabilities
Date: Sat,  7 Nov 2026 08:22:12 +0100
Message-ID: <20261107072224.3492260-19-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 9291cf9e61ef..26c683448f4a 100644
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

