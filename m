Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D849CA5FEC
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 22:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A0E180D7F;
	Sun,  4 Oct 2026 22:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j__JmGslEkOz; Sun,  4 Oct 2026 22:13:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 616C480BF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791151999;
	b=ntMu1t+BX3bZrcaSD19YlQw616/BEqB7LGFtVYf3NPZ2A5+/zvyavYuzgIs1XKGEkQeI
	 cZZcH92B+s85guA6zuva7zn61baLhPRQ2NYNv9QnrO0wTJSlJPbPTZYBnlY0kfRFIkFSh
	 2/867ohUktZNxtLzeiG4RDlbwZCZ1vbuX2wXMyxDcj3ziYaBxfDqSRrUTije7yVUk4tG2
	 A1aJTCUWlu/+mVOJzyzjE62kT3F+YMSXZkjRoiWacTl2hTzl0X8FTlB4DZsYmg6Ic2+Ku
	 Zxa9YdD35qWB0UuMfR0Kb2SrunV/GhM8tDp6cYmiNC++ywNYmXpkYtRZ5txClhoSqaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791151999;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eu4f1ZB6Vu8Cw35QmjCDNOIaIrgsmq57wN5c0zhVZ9o=;
	b=UbbEeCdQ2YpjlzMzBCappe90KMH9ZNwyblHtzKg87IhIjyPwFvLtJEhKtFC3/YGGTDHP
	 U7wwHhAVVB+4IqOCXQTOpA40SoRv+Kid1f5/j5N9USwiVMiEWOjPAPGhnLR7a+75FYkVS
	 EDs4j7fMnnceIdeX5Nd8zB096WT/EZb1MKP1Ysb3SU/uF5hvwxD0h9qESGHf0xcOzOkto
	 omaVgNlXyiGPcJ9+n6Vg5eMhSIZNG6hEc7eAOqiAqkEJQ6K51tn2fcoQp4FiORPxgAK2u
	 i/hqEA4yxZ2HByg+QdWzSgbUNxrRjbrXxW6+cpLgxYmaSlkNEZw2nLDZX/0Vn9VQGoQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791151999;
	bh=eu4f1ZB6Vu8Cw35QmjCDNOIaIrgsmq57wN5c0zhVZ9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BvgvLkm2Mdpa1r/0r5HKl6JKgPc5E/qdmOSg8maDkW5NQbZeJW6FvZNzuNxJLHfSq
	 bslOwWsM8XAszuyw85mjePPIKtl1nDwQJ5T6FKx6pa4TDBRDeFl7cL5wcYwMY24u82
	 xZbLM7C9PcuECO8+2VS/RJcZ/k/WUpoBau/SMcyIVYJGfu1NIX20cxZOamx7dF9+74
	 NgLlrtXlsu3TdQseVZVopxXmNwIHl5ZUvuPCyDMHTQ1RcaCvaNEbQiRkJ1avGJvGbv
	 5IjwjTo5cX/HvsGBDHvsq9rWmuaImTT+XZqq4SU+Q4W18eTT/K3ZpS4GsLRJRARAwH
	 RpAX4m2cBXUIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 616C480BF5;
	Sun,  4 Oct 2026 22:13:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E2EFC323
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 22:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4A24400C8
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 22:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gTs-zZjvxAhe for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 22:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E21C740004
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791151996;
 b=ca8YUqxPkXFJrrP9V2PKW471RVOGjarBd9pJtzVjGKg5XSp9xbIDS70NHve68v8AW3i/
 EDRrskvk5+W5tCc6RMBJpPqALDHF8+QG5zSyw5YqNkUERUPrrzsoZk2kM+s62BAZmE1GI
 5ZnJ/OotLkkjtYYBJl6ydCb2SLoOLPVZnQ6pFCrZE327mf5E4C3BgEfLf3gKWkobjDlV0
 PdDmQ01K5IvbonsyuC/jawcbhkmSIL3fCreuDpPtXP+dc0kgaVD4WSXy9uVgEE6wvcnOi
 xE6fKEyOCaozdE2y6kiL79TBprgu25iuYdfzNDPb2t9mgvioFZsHBf9czNnBQnjLzzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791151996;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=eu4f1ZB6Vu8Cw35QmjCDNOIaIrgsmq57wN5c0zhVZ9o=;
 b=sU51UXAAThqZOGyI9qkf5kxxoeoc/jsfrWrBCb+LhlSP2qBtLa33vF4Eqm28+3kfmTjv
 xgM4havAeDUhIyDYJJRmEwJev8ep/I+F7D+4polCZaZkjBgY/hPCMMSTUPRls4lj5qMdh
 BMGQ2/o8tQdiNmQ82KiVZIrhUV+ywMe1bXXl4oFGJdPV5M49zu8RKb+cUlHWsKXvRy1Ld
 9c0AGcQj6V0PGOMFA9DhbxkbgNqZBtJFpQLMwqR8cSAySg2QSOEs/BFvTBoCcgjDXPMZn
 NyD0i5T1WStifqkEmo/gKl9/tQ1Wnc2Cl31+bSMYipAlgya/xT2WyuLzKPJlpk/pXhQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=NN4FA47t; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=NN4FA47t
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E21C740004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 22:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791151995; bh=eu4f1ZB6Vu8Cw35QmjCDNOIaIrgsmq57wN5c0zhVZ9o=;
 b=NN4FA47tIpHqHJ97ANBE3bZEcirgJiVHEW1F9d7ff5jG0vRli0Ymvmlb0w7IehBNlP7PFX/iO
 wn5pk5Sz99n6ThBfjwZkgGwC5Lnp3n8xEjDCZwfz6/4GFJ+097SlVTcIHTAkAOUnjhm2OocM7bw
 Yw0gQVH9Dr/CUZcbbH1xx7mhW5lAIIJ99unj/sBz9Uccd9yKl2BY6demQ00ATi+0ZHxAV2ZZcPn
 OzG6Ntu6xqlSCMIjM9dsRnJ6F4z9AtapRQ9gBy8DMv5+t5A5XaRI7u/ZGE2JWKz5VsW7LH03191
 h2F2plImzUr3Yh2LX5AKXZxx50Kc4DDyRAGf9Kb7B7VQ==
X-Forward-Email-ID: 6ac2cf77ab896cf9f2e42810
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] net: dwc_eth_qos_rockchip: Relax dependency on reset
 controls
Date: Sun,  4 Oct 2026 22:13:04 +0000
Message-ID: <20261004221306.67476-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004221306.67476-1-jonas@kwiboo.se>
References: <20261004221306.67476-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The GMAC typically does not need to be reset prior to being operational.

Remove the strict dependency on reset controls and DM_RESET being
enabled to and allow GMAC to probe without any reset controls being
defined in DT or the existence of a fully functional reset driver during
SoC bringup.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/dwc_eth_qos_rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
index 4ccefda0ef5e..04bc6006bc3c 100644
--- a/drivers/net/dwc_eth_qos_rockchip.c
+++ b/drivers/net/dwc_eth_qos_rockchip.c
@@ -744,7 +744,7 @@ static int eqos_probe_resources_rk(struct udevice *dev)
 	}
 
 	ret = reset_get_bulk(dev, &data->resets);
-	if (ret < 0)
+	if (ret && ret != -ENOENT && ret != -ENOTSUPP)
 		goto err_free;
 
 	reset_assert_bulk(&data->resets);
-- 
2.55.0

