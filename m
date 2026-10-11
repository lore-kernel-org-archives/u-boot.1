Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE099CA9EC5
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 00:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F5C6810F3;
	Sun, 11 Oct 2026 00:37:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l1eJH66iYPLG; Sun, 11 Oct 2026 00:37:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 69A4C810ED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791679072;
	b=LrIDQEkaNPoUKAzrVcy6dt0qelqFuoUlwm1JPtg4oLpSJgJUtFbm8fFPvzvUjA+lMeWU
	 N/r2HTwcxWfrertvfyGfg+ZSKHVtZ5MIg4J+cKpXE4uBbXuELk0tOilxb19V+aeO8LjNc
	 t1pHtqYlwQY1ZRkej3mEjJBqLPtRAPqKLNNdCMZoyKIOd9QQL47hlq1L1aHojB2V2LTIT
	 Ew4+hV51ltVXisWZCVAuLOp+82Vle6C7o5PixyK4WuMoXfotutfYsRerVdNKuSv9+uCdB
	 0+Ftiyc+osmg1V4byBdZPMfeRcvA4jK90NyKnqfEDRIBye5hIv55c3dLcTSnxr/zrPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791679072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=e6KnOxy5T/BgHIziQPdHEdwjkSCJ9cxRM1G0zKpy4Ik=;
	b=kUyOXt8KlHEJkUWm7Vs2hnGJXo9I4WHkM8qycsy4sD0PGHG7IpF0GlZzuNp8ILhvk6VB
	 cnZEZS/Exf7vXAbNw+oeMKlTYYQcF3nQy7Sasd5yfMKd3e93fEZ/4GtrvHMIwSFi22HpN
	 E9/55POQJbx/6cJ18QDjPTyD9SNmF6kGB/vZ7Lo4sscQj9C+2JLSByBaf1neTxhgmmFoh
	 g0dnMmTi8zvEZ3J03Mw5UeiNU2uynfZgCf/g8zjxE1VZlfD95HK5vHMxOJWJqWl/r0iH0
	 92P0qvl8p5UVBlubucjoSfKQt6uQQIjR7BrcPLxq7JeQUGOm+rk2cbwBTYQM41TB/yQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791679072;
	bh=e6KnOxy5T/BgHIziQPdHEdwjkSCJ9cxRM1G0zKpy4Ik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DEu3p0Fl8HZYyoGu6nJs5mTksxKzlYsabaE93WuUyJwHT/QMwN4CGwWatKhSaDPJ4
	 /7QBNClS7dI+cANV665NQPYH6waabftidhYkdH6DG+U8CtbEVWlN2vEXB6xG2F9yKM
	 vNTWL3UbkVGF4hz5yh4dLENQ/jVmNLaZaXBPBTRmuS2u2APWVQ/zvug9rE6srE8gPE
	 SzgVHB28iu/g7F0R8v+eRouTMe7d/35QaXjOqVbzF4kkiA2dtWAD9K2DpDZjz39wZV
	 stO0P/oE0RUH4T0GFwPgVCy+bI6O8sEz51lqi9801FGfT/tQ2eF9h8y4pCRymsn+60
	 AZxRes0kPoRgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69A4C810ED;
	Sun, 11 Oct 2026 00:37:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 34E9B9D1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 00:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B06F400A8
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 00:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kYx0c2_k_Nl2 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 00:37:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 018904008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791679065;
 b=GnrLOuDjjpt73yGY2i0hkJXtfNO0YxKHbB57cbSKZoBOIklSR1mAZp2LTmlMLVyjCLWt
 2j0JNDCu9dYeqaUlq06ndEMwc1o4yY9h/OH9/owIn6DkJOFq+fB0s7TkbYFxel0OIN8T4
 nhetL8mL/wuXNQTTATkx9MYpQdoqUtA+/x5vMDGbmiRbFIP3hffjRRxmbqyP/Zp+IfmUV
 RC7ox4tExvb7Td5a3Tm0VIdLJJjJHwELwVcFXo0bCkt/TbJLikQLfbxknz0QwE4ZHsW0C
 sHhQF+DJly/tK5rDpnbf+lymIrkv04d0scgSeY19V5GZ18ETkEuYyGnv6uKDpVVKWMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791679065;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=e6KnOxy5T/BgHIziQPdHEdwjkSCJ9cxRM1G0zKpy4Ik=;
 b=Ake9L4Txwjo/AIr1Fhj6sp/LySuGijUoYTvh2G649ooZcD+kFPDqWIcFhSPKuw8pIf88
 Dd1WxdiWQ62en1aH3exYdZ9ejc7q2fdkvBy1Dp0A2tjf+QsNKPm+XbNsAXIoLsvdyEnTk
 a4Q3AmIfu4SIx0ant4lvf6R1IfNU8/rAo9RJ7B5R8LA6Ciz38wB9sWKBEASqhOH4RIrYj
 A62QOF+vFo/6nH3vFWEZUjVtsV2ljTYgX3suv3V1JlWuorHpVWAsj7YR28TZTQ73gYxo7
 eviM9kfaayP4mxRIbM2xufRbqmwKo4L2GIUYuYFzuuk6Y08drooYQm8MbaGkYNqsFjA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=j6fPLXQy; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=j6fPLXQy
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 018904008A
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 00:37:44 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6ddfe39131eso703604eaf.0
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 17:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791679064; x=1792283864;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e6KnOxy5T/BgHIziQPdHEdwjkSCJ9cxRM1G0zKpy4Ik=;
 b=j6fPLXQyfIZzQVGoRtF2CFdndcNwAFbOpALiENvxcUtxtjqKVsUNQ/NYGDikIlWxHk
 ecdtBzn8/0N5ko5G4Ztb+ZRiY///qPiHaZ5PVIIy+FjSSJ13Ok13MvAlhmXx+UeDB/L2
 lQoTBeGlJJ15V2oOG1bhJcOpN4VjDlOrN/Yea5oElVothopA6cEUMP9nw+IOJ6591wVk
 3WqlDIulWdn/AF1m5DBmq72HSswvkVGmLGHvsft8Oaf/SFG9hK5kcJy5ery1ZZ6lyQtb
 i1QPViRYRse+VieitEtfOIqf8GYMCZCdDv39ghS2r1Wy8TAeiGnbEEEtN6lzWcx26Njm
 cqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791679064; x=1792283864;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e6KnOxy5T/BgHIziQPdHEdwjkSCJ9cxRM1G0zKpy4Ik=;
 b=Q6G5/GxGmcmHFE7NAtPCifCA0HCA+lx2qL2WjUYmf708MoEsEywv1ZEAr9g12h2HhL
 7buZIybNiq8gS9eGaaehA47TkR6SuR8pQhyjpiuD5Y69boGjO8kEbluBEaARFfLPWBip
 4uhKY9fNU2LLHdRXqNlnb/W3KOodCcrkDKpGrnBwQf2sqPlonwk/2AAgwjeaFSPtIaKQ
 qdVXUZ9LjmVi9MWkOlcFxAG0Gx+e7jp4BrHqEnsfjXV3YmOevHw9Ie3GYenkGzdWr+2O
 Z0gZfUiynGB0ju/+1BJa3dn5EUs9YWeuKS1oQZKYSfEXBFPqT3M4CvohqytFl/cYzgvA
 1Yeg==
X-Gm-Message-State: AFq9FYJw8bahVFqygKCFTt76DvJmSkdNpqHDLj62rbdov3tCtImaZa/Z
 lNfuuRaMC/t+T15LQCRFUn/558gg4fgZDHuBFlr0zDDEwE0OUFjDSfk5
X-Gm-Gg: AYBFou2cias9tAp89v+QVhX3RRt610TsUZVW2hi++83GBgH6shsil0quDFiCEQxNEXv
 gY29HVJmKMJKzVv4hrmFGzYjqQvEPaAHj/QSTGXCrZVUFzi5NosBcvPRNuX91RDT0P89C+7LdRu
 bPPcCZ9/WcSJ/xHEkMqeXPfEwOTw2oAQqSI1hgLUhC+fGGZZZq3qvl749yjO6EuTNJLBN/mzVNX
 3VC+hWdaEDLr55y6AERQczM9HaxOLOCsDYRyegApSxUjFvQQ3Ou8pvuCMPq76j4Jebra9/g0AfA
 ZsuReyveDBc2qeGHhvnFX0DvzXzWX063vrTbbrp4ziLoNqirhilG/8nlbMh7mWaFbFHSAkvUYxu
 xcN73BhUABOtBlNenxoXmL95bQHkv/Yh6TuZS8/PDmd8KnRFFprbRtFgTxOTUi8i9xs7PosBUxO
 zPsecJkF4xECHESo4nhEf0gT3Zxil4Nbs8uWg4TxfSXEsW9opOvHKy8/QQophYY5DJk5/um1aZs
 cwJtbAiOJx0VYMEXrXsg23EauZK1tYAH0bRc6nmBqDmxX4Z4ATFeyFCngMoMBVZYtoK4td4N6qE
 keIkOtj685yTpr+KwS6qLnF2BrbBryDBgpyX+s7jaAMRlhycuHqIyg8nYHPNuyeSanNBWz9IZ9/
 i3OV+RAd6bL+Yw6BD/kgE8QwPVJVT0CI=
X-Received: by 2002:a05:6871:e494:b0:49e:486d:3f41 with SMTP id
 586e51a60fabf-4a2a8948d98mr4770223fac.20.1791679063836; 
 Sat, 10 Oct 2026 17:37:43 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a84a1457sm5386985fac.4.2026.10.10.17.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 17:37:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 10 Oct 2026 18:37:08 -0600
Subject: [PATCH 13/16] net: lwip: use the selected interface for TFTP
 addressing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-submit-lwip-tftp-combined-v1-v1-13-cf8002c6f401@gmail.com>
References: <20261010-submit-lwip-tftp-combined-v1-v1-0-cf8002c6f401@gmail.com>
In-Reply-To: <20261010-submit-lwip-tftp-combined-v1-v1-0-cf8002c6f401@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
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

Validate and report the selected interface's IPv4 address instead of
the global ipaddr variable. Derive automatic filenames after the
interface has been selected; indexed interfaces may use ipaddrN.
Keep explicitly supplied filenames unchanged.

Accept physical address zero for client and receive-server transfers
when the target memory layout permits it. Retain the existing range
and memory reservation checks.

Exercise indexed interface addresses, invalid addresses and transfers
at address zero with the sandbox command fixture.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/lwip/tftp.c | 75 +++++++++++++++++++++------------------------------
 test/dm/tftp.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 46 deletions(-)

diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index f29a20f518e..41ea12ed486 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -55,6 +55,16 @@ struct tftp_ctx {
  */
 static struct tftp_ctx *tftpsrv_active_ctx;
 
+static int tftp_check_ip(struct net_lwip_ctx *net)
+{
+	if (ip4_addr_isany_val(*netif_ip4_addr(net->netif))) {
+		log_err("error: IP address for %s has to be set\n", net->dev->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * store_block() - copy received data
  *
@@ -346,7 +356,7 @@ static int tftp_loop(struct net_lwip_ctx *net,
 	u16 blksize;
 	err_t err;
 
-	if (!fname || !*fname || !addr)
+	if (!fname || !*fname)
 		return -EINVAL;
 	if (operation == TFTP_UPLOAD &&
 	    (size > U32_MAX || addr + size < addr))
@@ -373,9 +383,9 @@ static int tftp_loop(struct net_lwip_ctx *net,
 	net_boot_file_size = 0;
 
 	printf("Using %s device\n", net->dev->name);
-	printf("TFTP %s server %s; our IP address is %s\n",
+	printf("TFTP %s server %s; our IP address is %pI4\n",
 	       ctx.upload ? "to" : "from", ipaddr_ntoa(&srvip),
-	       env_get("ipaddr"));
+	       &netif_ip4_addr(net->netif)->addr);
 	printf("Filename '%s'.\n", fname);
 	if (ctx.upload) {
 		printf("Save address: 0x%lx\n", ctx.daddr);
@@ -475,18 +485,11 @@ static void no_request(void *arg)
 static int tftpsrv_loop(struct net_lwip_ctx *net, ulong addr)
 {
 	struct tftp_ctx ctx;
-	const char *ipaddr;
 	int ret = -1;
 	err_t err;
 
-	if (addr == 0)
-		return -1;
-
-	ipaddr = env_get("ipaddr");
-	if (!ipaddr || !*ipaddr) {
-		log_err("error: ipaddr has to be set\n");
+	if (tftp_check_ip(net))
 		return -1;
-	}
 
 	memset(&ctx, 0, sizeof(ctx));
 	ctx.done = NOT_DONE;
@@ -495,7 +498,8 @@ static int tftpsrv_loop(struct net_lwip_ctx *net, ulong addr)
 	net_boot_file_size = 0;
 
 	printf("Using %s device\n", net->dev->name);
-	printf("Listening for TFTP transfer on %s\n", ipaddr);
+	printf("Listening for TFTP transfer on %pI4\n",
+	       &netif_ip4_addr(net->netif)->addr);
 	printf("Load address: 0x%lx\n", ctx.daddr);
 
 	tftpsrv_active_ctx = &ctx;
@@ -563,12 +567,6 @@ int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	if (!laddr) {
-		log_err("error: no load address\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
-
 	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT)) {
 		ret = CMD_RET_FAILURE;
 		goto out;
@@ -586,22 +584,14 @@ out:
 	return bootm_maybe_autostart(cmdtp, argv[0]);
 }
 
-static int tftp_default_filename(char *fname, size_t size)
+static void tftp_default_filename(struct net_lwip_ctx *net, char *fname,
+				  size_t size)
 {
-	const char *ipaddr = env_get("ipaddr");
-	ip_addr_t addr;
-
-	if (!ipaddr || !ipaddr_aton(ipaddr, &addr)) {
-		log_err("error: ipaddr has to be set\n");
-		return -EINVAL;
-	}
+	const ip4_addr_t *addr = netif_ip4_addr(net->netif);
 
 	snprintf(fname, size, "%02X%02X%02X%02X.img",
-		 ip4_addr1(ip_2_ip4(&addr)), ip4_addr2(ip_2_ip4(&addr)),
-		 ip4_addr3(ip_2_ip4(&addr)), ip4_addr4(ip_2_ip4(&addr)));
+		 ip4_addr1(addr), ip4_addr2(addr), ip4_addr3(addr), ip4_addr4(addr));
 	printf("*** Warning: no boot file name; using '%s'\n", fname);
-
-	return 0;
 }
 
 static int do_tftp(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -764,26 +754,12 @@ static int do_tftp(struct cmd_tbl *cmdtp, int flag, int argc,
 		goto out;
 	}
 
-	if (!fname || !*fname) {
-		if (tftp_default_filename(default_fname,
-					  sizeof(default_fname))) {
-			ret = CMD_RET_FAILURE;
-			goto out;
-		}
-		fname = default_fname;
-	}
-	if (strlen(fname) > TFTP_MAX_FILENAME_LEN) {
+	if (fname && strlen(fname) > TFTP_MAX_FILENAME_LEN) {
 		log_err("error: TFTP file name is too long\n");
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
 
-	if (!laddr) {
-		log_err("error: no load address\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
-
 	if (operation == TFTP_UPLOAD &&
 	    (size > U32_MAX || laddr + size < laddr)) {
 		log_err("error: TFTP upload range is too large\n");
@@ -796,6 +772,15 @@ static int do_tftp(struct cmd_tbl *cmdtp, int flag, int argc,
 		goto out;
 	}
 
+	if (tftp_check_ip(&net)) {
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+	if (!fname || !*fname) {
+		tftp_default_filename(&net, default_fname, sizeof(default_fname));
+		fname = default_fname;
+	}
+
 	if (tftp_loop(&net, operation, laddr, size, fname, srvip,
 		      port, srcport, timeout_msecs, max_retries) < 0)
 		ret = CMD_RET_FAILURE;
diff --git a/test/dm/tftp.c b/test/dm/tftp.c
index 45612e066e5..62a0a887150 100644
--- a/test/dm/tftp.c
+++ b/test/dm/tftp.c
@@ -47,6 +47,7 @@ struct tftp_test_context {
 	ulong ack_delay;
 	unsigned int advertised_timeout;
 	char filename[64];
+	struct in_addr local_ip;
 	u16 blocksize;
 	u16 windowsize;
 	u16 port;
@@ -148,6 +149,7 @@ static int tftp_test_tx_handler(struct udevice *dev, void *packet,
 		if (!ctx->requests++)
 			ctx->request_start = get_timer(0);
 		strlcpy(ctx->filename, (char *)(ip + 1) + 2, sizeof(ctx->filename));
+		ctx->local_ip = ip->ip_src;
 		ctx->blocksize = tftp_test_option((char *)(ip + 1), request_len, "blksize");
 		ctx->windowsize = tftp_test_option((char *)(ip + 1), request_len, "windowsize");
 		ctx->port = ntohs(ip->udp_dst);
@@ -439,6 +441,79 @@ static int tftp_test_protected_autostart(struct unit_test_state *uts,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_NET_LWIP)
+static int tftp_test_addresses(struct unit_test_state *uts,
+			       struct tftp_test_context *ctx)
+{
+	int i, put, ret;
+
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("ethrotate", "no"));
+	ut_assertok(env_set("ethact", "eth@10003000"));
+	ut_assertok(env_set("ipaddr5", "1.1.2.4"));
+	ut_assertok(env_set("netmask5", "255.255.255.0"));
+	ut_assertok(env_set("bootfile", NULL));
+	ut_assertok(env_set("ipaddr", NULL));
+	for (put = 0; put <= IS_ENABLED(CONFIG_CMD_TFTPPUT); put++) {
+		memset(ctx, 0, sizeof(*ctx));
+		ut_assertok(run_command(put ? "tftpput 2000000 20" : "tftpboot 2000000", 0));
+		ut_asserteq(1, ctx->requests);
+		ut_asserteq_str("01010204.img", ctx->filename);
+		ut_asserteq(string_to_ip("1.1.2.4").s_addr, ctx->local_ip.s_addr);
+	}
+	/* A valid global address must not hide an unset/invalid indexed one. */
+	ut_assertok(env_set("ipaddr", "1.1.2.3"));
+	for (i = 0; i < 2; i++) {
+		ut_assertok(env_set("ipaddr5", i ? "invalid" : NULL));
+		memset(ctx, 0, sizeof(*ctx));
+		ret = run_command("tftpboot 2000000 explicit.bin", 0);
+		ut_asserteq(CMD_RET_FAILURE, ret);
+		ut_asserteq(0, ctx->requests);
+		ut_asserteq(0, net_boot_file_size);
+	}
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("ethrotate", NULL));
+	return 0;
+}
+#endif
+
+static int tftp_test_zero_address(struct unit_test_state *uts,
+				  struct tftp_test_context *ctx)
+{
+	static const char * const commands[] = { "tftpboot 0 file", "tftpboot 0", "tftpboot" };
+	void *buffer = map_sysmem(0, sizeof(tftp_test_data));
+	u8 saved[sizeof(tftp_test_data)];
+	u8 received[sizeof(tftp_test_data)];
+	int i, ret;
+
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("loadaddr", "0"));
+	ut_assertok(env_set("bootfile", "file"));
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		memcpy(saved, buffer, sizeof(saved));
+		memset(ctx, 0, sizeof(*ctx));
+		ret = run_command(commands[i], 0);
+		/* Restore sandbox RAM even if the command failed. */
+		memcpy(received, buffer, sizeof(received));
+		memcpy(buffer, saved, sizeof(saved));
+		ut_assertok(ret);
+		ut_asserteq(1, ctx->requests);
+		ut_asserteq(0, image_load_addr);
+		ut_asserteq(0, env_get_hex("fileaddr", 1));
+		ut_asserteq_mem(tftp_test_data, received, sizeof(received));
+	}
+	if (IS_ENABLED(CONFIG_NET_LWIP) && IS_ENABLED(CONFIG_CMD_TFTPPUT)) {
+		memset(ctx, 0, sizeof(*ctx));
+		ut_assertok(run_command("tftpput 0 20 file", 0));
+		ut_asserteq(1, ctx->requests);
+		ut_asserteq(32, net_boot_file_size);
+	}
+	unmap_sysmem(buffer);
+	ut_assertok(env_set("loadaddr", "2000000"));
+	image_load_addr = TFTP_TEST_ADDR;
+	return 0;
+}
+
 static int tftp_test_download(struct unit_test_state *uts,
 			      struct tftp_test_context *ctx)
 {
@@ -463,9 +538,11 @@ static int tftp_test_download(struct unit_test_state *uts,
 	ut_assertok(tftp_test_protected_autostart(uts, ctx));
 
 #if IS_ENABLED(CONFIG_NET_LWIP)
+	ut_assertok(tftp_test_addresses(uts, ctx));
 	ut_assertok(tftp_test_options(uts, ctx));
 #endif
 	ut_assertok(tftp_test_filenames(uts, ctx));
+	ut_assertok(tftp_test_zero_address(uts, ctx));
 
 	/* A previous DHCP/download must not override the next command's env. */
 	ut_assertok(env_set("autostart", "no"));
@@ -616,7 +693,7 @@ static int dm_test_tftp_download_only(struct unit_test_state *uts)
 		"ipaddr", "serverip", "netmask", "gatewayip", "netretry", "tftpsrcp",
 		"tftpdstp", "tftpserverip", "fileaddr", "filesize",
 		"bootaddr", "loadaddr", "bootfile", "ethrotate", ".flags",
-		"tftpblocksize", "tftpwindowsize",
+		"tftpblocksize", "tftpwindowsize", "ipaddr5", "netmask5",
 	};
 	char saved_bootfile[sizeof(net_boot_file_name)];
 	ulong saved_load_addr = image_load_addr;
@@ -637,9 +714,13 @@ static int dm_test_tftp_download_only(struct unit_test_state *uts)
 
 	sandbox_eth_set_tx_handler(0, tftp_test_tx_handler);
 	sandbox_eth_set_priv(0, &ctx);
+	sandbox_eth_set_tx_handler(1, tftp_test_tx_handler);
+	sandbox_eth_set_priv(1, &ctx);
 	ret = tftp_test_download(uts, &ctx);
 	sandbox_eth_set_tx_handler(0, NULL);
 	sandbox_eth_set_priv(0, NULL);
+	sandbox_eth_set_tx_handler(1, NULL);
+	sandbox_eth_set_priv(1, NULL);
 	image_load_addr = saved_load_addr;
 	memcpy(net_boot_file_name, saved_bootfile, sizeof(saved_bootfile));
 	for (i = 0; i < ARRAY_SIZE(vars); i++) {

-- 
2.53.0

