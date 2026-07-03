Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C56C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 13:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D5684A63;
	Fri,  3 Jul 2026 15:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KemX9VoZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 339D584AAE; Fri,  3 Jul 2026 15:30:00 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D6684A4D
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 15:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E0EE260051;
 Fri,  3 Jul 2026 13:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75AD1F000E9;
 Fri,  3 Jul 2026 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783085396;
 bh=AtYNa8W9/Rn0dpE7oLGvjThxp1BiZxXm0eoNnDUfwX4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KemX9VoZMAoJx2GiM2cqax1Bz/iiGKDtld2g0HfqBwlMlIxC3ooCVORaSQqHfs/UY
 Y7o+bRN+6A8uFZ3mYg8WliTtfAeFWRaDXEwzHMZvybIdw+X0n9FbXluy2XcUZTQ8J/
 eMqJCYs8pW/bvecLGQEMzKWSSaughnf1pMLLBNfas9nZPv+wpxZ9MgtCTdZd95Cu+r
 pIbuAkwKQIm5uTnwfwH3vAL7so/7frxK19TUrTrjTLKin2kPaHlCpDJwsjqUXFOhW3
 7JOJnywVw2eFICyRR2xX7lbYnIrcQ45DSuB4miJ1BdOK9Z5JcCoVRc/KCiEYlRoX0p
 yJcng3TvVaGFA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Fri, 03 Jul 2026 15:29:37 +0200
Subject: [PATCH 2/2] usb: gadget: dwc2: Set endpoint capabilities via .caps
 field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-usb-prep-dwc3-sync-v1-2-1352bc238c9b@kernel.org>
References: <20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org>
In-Reply-To: <20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=G1UxpMvrBIythajt9u98sIV15+GZGkn0laGu87kRu3s=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBqR7lMiN8gQ/Kity7yx+LmqZmqtoJgipDEXhT9o
 uSLt1HtvOOJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCake5TAAKCRAZDR20Zk4Z
 NTvDB/0RVESxNjCj9qCeELQba+diaRR6rjOp5QAP1tdG5z/goxxR6+vk3P/OWe/WOTpZDZ1Y89z
 CbZBj5cgI9S0WPr9cToXAVvRgbx375is0U/0pTnr54DBwNESxnWlVpdxE9Q7wdGwEU6EIhyDxed
 XxJtM4kE6sBiHyDdQMy5COG/FztvImioo3nBaE7LDsDIckJdhd1xDrkhKPVTbyOjOvzZSocUQxK
 zBDXITCHE0zbfn+fRXPxZTRVIDCte3MfgxfmHW7+ayA72/RRZmOArD6Bz7WZn9USvfeLG9fAlJu
 AYgaZ3zUP0IOhf5hqdmKK5pI6ng1sHqKClpn+CNNofDLTPw7
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
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

Endpoint capabilities can be described via the .caps field of
struct usb_ep since commit
77dcbdf3c1ce ("usb: gadget: Add match_ep() op to usb_gadget_ops")

In linux, the following commit introduces it:
b86f33a3a371 ("usb: gadget: epautoconf: add endpoint capabilities flags verification")

Linux's change also reworks the ep matching function by relying on
these new capabilities instead of guessing based on the endpoint name.

Prepare the dwc2 UDC driver for capability-based matching by adding the
required capabilities for each endpoint.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/gadget/dwc2_udc_otg.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 9c85383fd62a..570fed347c9e 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -828,6 +828,11 @@ static struct dwc2_udc memory = {
 		.ep = {
 			.name = ep0name,
 			.ops = &dwc2_ep_ops,
+			.caps = {
+				.type_control = 1,
+				.dir_in = 1,
+				.dir_out = 1,
+			},
 		},
 		.dev = &memory,
 
@@ -842,6 +847,10 @@ static struct dwc2_udc memory = {
 		.ep = {
 			.name = "ep1in-bulk",
 			.ops = &dwc2_ep_ops,
+			.caps = {
+				.type_bulk = 1,
+				.dir_in = 1,
+			},
 		},
 		.dev = &memory,
 
@@ -856,6 +865,10 @@ static struct dwc2_udc memory = {
 		.ep = {
 			.name = "ep2out-bulk",
 			.ops = &dwc2_ep_ops,
+			.caps = {
+				.type_bulk = 1,
+				.dir_out = 1,
+			},
 		},
 		.dev = &memory,
 
@@ -870,6 +883,10 @@ static struct dwc2_udc memory = {
 		.ep = {
 			.name = "ep3in-int",
 			.ops = &dwc2_ep_ops,
+			.caps = {
+				.type_int = 1,
+				.dir_in = 1,
+			},
 		},
 		.dev = &memory,
 

-- 
2.54.0

