Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1E6070CBB
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iQSq6wnj;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=XANfck39
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DE7A81090;
	Mon,  2 Nov 2026 16:20:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QUhS6m7t6Q2L; Mon,  2 Nov 2026 16:20:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E9B4810E3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636457;
	b=TME9SWXjOG8oAYc37xxVDQ33awo+R5j9CgcqCaF9lFrBa12gn5SjNXS6aozOW1ICF+es
	 nAUi50wpqDZGrSM1oEsbiuXBq6piWa3Z2bmqnpmtFV/7y8JppwhsDL7iUGudFv6AiFp0t
	 HZd8yj93vh3uSpF5fbZuw5O7f1vrBJh1W/7ihpgVjl01NnaN4AFtQ8x40/avo2T9EPg3q
	 +6SD4N05ylMf0MzAp9OK8qtZeLlSDEV4VNi17/n7b+vPW83tSiYPIA+aTdUpQZX3hpWGD
	 fmE/ZDKCA75h34eEeMW+eXNNtJy0HZiitp95eRXBzvY3ghii/Yf9IwUf5z3jobFdFGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xh+rEl79Vi5l2V39ULCyE4DnwB7PjqoOO5K2TMV5SpE=;
	b=dvn2mdH6aZx0kKsgyIcHISEqAnfVSJZRY7GRfnA3H5hcjxj0J/qJdK1ld0I1shQTXAeb
	 sFJyBNUrAZTZy3UKt1gHogbh9u4rVeBy3I2IlgH8PgNxzxXQyLNze4XgfNcY7/LOMfZPT
	 Rjetz5RE1cOxEPSYCFHLbaraBcmYX4Xy98YXdCF8X5Ge8EtKwBgWZcqMt1CisCNqNM/C0
	 dHF8fpUwaM0f2bhYlfro1bg6Ul7f2z99HT42ie/SQIu0QW1DkBRihFCcqihsgIwZ16BhT
	 qyF+axMfvZV2TAgl4q6V6Wrxi1F5jmrVYiwGCex7zPm2v/x1AxoOCHTkXhm89M8r7ow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636457;
	bh=xh+rEl79Vi5l2V39ULCyE4DnwB7PjqoOO5K2TMV5SpE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iQSq6wnjhtXUomiaeONjJ8yY2deDjQJF7ctdsb4Eed4G3tahPqyfYDwS5GKXyQa2N
	 SAmWwI5kbiRYcv0gSbw9SeBhj1jFXhmyH9AXo6P+atr4WQ4KQ3Ng2ufYPIMUURlXYi
	 EwQ+ErtSHJB/CZxp9gg2u2yk/0pAH7/ShZLkvcI3aa2hqkdFrIx7ATJv1DyKhOPz/X
	 TvadnMjRuFFB4yhKewMU/fXL2uhzadWuLFTanflIaRkM39/LrdIk2hzFj8aYyvt6gs
	 9cdgF5RWidGamQeczzR/gFDa1FiA8u5rGBfeB8oxkQfyxKKRW0tBOxB1LWyZ/2g/7Z
	 94RYfhUcbGBHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E9B4810E3;
	Mon,  2 Nov 2026 16:20:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BAB8D3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41F764018C
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q2sMARLFbs_Q for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B528F4007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636452;
 b=UNUmls0z3Cl7wRtU1lRZDNKfRKflfF7pw7jhbMfL72mBSsCF73T4MOhKW4zspqEvwebY
 lnKPSiENZfUdmrGw+QRwXa0UbR59jI/ucL1XoXxcBqaimVRL1hzSqNNK6ewrCz64cEwSo
 FRy60KoRr3ZRMYxdgxXaQUHAhWS/RkPd90NisSFZ0SL2/qIDydJs5SdsW05qTdhpv/tFd
 AL1zGH/vjdt8TiaB2oXWnGwB32Oqm0JivSKM38ayzmq1BdteO3jwQNehLkzWrme7kSDUs
 ZhJSb1vjl0+4qHio1RPe3rCI5cxuvWMyFIz/Qga1/jied0C+aIkMkgG4PN6/U5YMd1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636452;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=xh+rEl79Vi5l2V39ULCyE4DnwB7PjqoOO5K2TMV5SpE=;
 b=DpACukhZosFBkepM7oClnpc82Xzb2RFu24vR0qCjh+lYdYLtCaX+t9HJS1sFFbZwrzXQ
 gEyveJ/yqOZ39uvDafJtraBH7wTtAw53ogIF+U9y35Blg6e2GA4cKEw8rBp0YqCScTMY8
 bYN+J5aQRNo3ZiTXfWF2g8CbNVE7PxDGpkAEuNYSgQCZyA/SX0TEBa8MBNbJK2fFEF54A
 MqfDoU7bB7a0b/wJvl+kSnIlkXmJNpvwFpAhoaOpt6IOrynyaiZhQUHCHBy7Xe4C1HbHv
 Q4CssaHDXKFZqXDGnotLrlXphWb2ba8zgs5nG0G4nmYFR+ME4930eK3Z8TiV2apAjOg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=XANfck39; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=XANfck39
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B528F4007E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:50 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793636447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xh+rEl79Vi5l2V39ULCyE4DnwB7PjqoOO5K2TMV5SpE=;
 b=XANfck39f2QBphy8Hz4HtUAr5WXW0hnxFH1GTM7s9mG1asSol/2CcOmtXwqBJZALs6hN+h
 T0gtOwFb4ck9MJxiCn6o0zau+lE0hSVxhaxoCn8A/kNpd6OFKBk+o/q/0ueFkXX+bFIGgy
 dwmernY99inh50NQyIJhMTPJSWKFIDQI4BbnoW9cBWsCaEfRm8iEea2aSa/CUemfrF88iw
 GpiFaNn0+A86Iov3HvIMnyZylhMH6YYdeDQ7Nxiw8p5zQi1ZWIn0I3RpcOVaunb+0Q+q5w
 35/UP5/4OIhJ8wVE3CqVU1r/zjpzayrDpd53aL3OG9ZfZxWMx7WY10miWP74vA==
Date: Mon, 02 Nov 2026 17:20:18 +0100
Subject: [PATCH v2 01/12] bootstd: rauc: Initialise desc in
 distro_rauc_scan_parts()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-main-v2-1-4537bcb19d66@kontron.de>
References: <20261102-main-v2-0-4537bcb19d66@kontron.de>
In-Reply-To: <20261102-main-v2-0-4537bcb19d66@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=DIJFOvHqV/mjryMW1p8I6amxCpLF8IOvcNtfM253mYs=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevFjlixQKdXvluFD7FYlhzsFG0U54k9voT36AebnX1pO
 tujpC90lLIwiHExyIopskjxW7y2NYv1kT9WHQUzh5UJZAgDF6cATGTTPkaGK+l/F8lVGLYY8lXd
 2xR+YFa42zWmabHnZkyaysK+RN7+ESPDg+ct3Xl/3QKmirIt8DhVkiphdGfdkX+aTun3F7bsL1R
 kAwA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

distro_rauc_scan_parts() only sets desc if the bootflow has a block
device, but then checks desc before scanning the slots. Without a
block device, that check reads an uninitialised pointer and may hand
it to fs_set_blk_dev_with_part() and part_get_info().

Initialise desc to NULL, so that a bootflow without a block device
finds no slot, as the check intends.

Fixes: f271b0627001 ("bootstd: rauc: Only scan all partitions instead of boot files")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- Add Reviewed-by tag from Simon
---
 boot/bootmeth_rauc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 844df7576bb..4a3f05103eb 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -95,7 +95,7 @@ static int distro_rauc_check(struct udevice *dev, struct bootflow_iter *iter)
 
 static int distro_rauc_scan_parts(struct bootflow *bflow)
 {
-	struct blk_desc *desc;
+	struct blk_desc *desc = NULL;
 	struct distro_rauc_priv *priv;
 	struct disk_partition fs_info;
 	char *boot_order;

-- 
2.56.0

