Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752E5CA5FCE
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 19:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14B97406CA;
	Sun,  4 Oct 2026 19:59:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8PXJuzlLgO-Z; Sun,  4 Oct 2026 19:59:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 45DDC406C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791143950;
	b=LUxbD/MparMI4cfaHUsvPRSjf1xBYNVyMB3mn9uwVVszrKNM/yFQajMpsTuft0bQS55h
	 bGCz5MUY6UbmGLh+WQ5zOGTaNITcklHMMj/ramEuMq9wieW07IBk5Per6v8vQ5s9qyNe9
	 VDGs0WGo9QPh8QZIjziqGjNj86s5lGl+zdl9ReCscYEixtkovfnrdAAwFvwlCqJYXDOkV
	 0t4XnzQts9SNGC7cAjW3Q0eQKPooxSKH+6m4DRlR9kDgSM/zfJiuZwhCZfzsaZRH+VzUD
	 UF2+v09e0aQIVLecWLBrloLgxCkH3AKUsVYWhTb9kSmGJsm/36evS4konS8lQN7klwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791143950;
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
	bh=bPmU/qgHga5krdDBtEU9qKy8d1lyi24pqmV9J7zrF2w=;
	b=Obfqye/WH+3km91gzcSH+SqWH2T2qGC+UdxOl7/BwoVnwOCTwqMK7zJ4MQfON60/5Sqd
	 9s6HDxIBU25nj9HcW+vozG0jh0nGpAko8zJzvDSW5Q6wNaFWbghdXfSwg+M6dI71J+JlU
	 pxVSlLJmCCGPDJEkqflkg2+eFhcgz7/ZtROaATWenyvFjYDjaYr4WaUtpSx00n3ynUZBJ
	 CWT8qBiO94kDE/QCS85pgROYTWBxNJ+fnjokItKl+cjQRTFyX2JSOIX87WK0B5xtsSAm+
	 5m7mm/5M7BTGElCixnDiGKoc3IrniT4gVmooDIfjnvu8gfSgZt4Wh9Mpm+y98nf6DOw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791143950;
	bh=bPmU/qgHga5krdDBtEU9qKy8d1lyi24pqmV9J7zrF2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hl4WVCfWGV330GZHV31Z57O2bF3prc0MTURryLAZ1094zxMDgjqxHA5/kram6OpXz
	 f2+0wqfnSmaLkqFn7FlEbr/3NshWOp0x1Pyre7AKeX9hGAj7zCKFz6fMHjHYWkh1Xl
	 e22rF4+qVRghjLjfOo5d6blgopru/H2mnbF+h+6Yzgx/jt/cfm6hqbPyR4bFZYiaAA
	 CsYCByehfeUeNHIvyVmPipXgw9yGeWBSSh/XHu8QOIKmc7RXPQ9Xf1egrEU4aYrrYY
	 642+lhRH4aE1IgmzIxEmeeciOD2BijZ5M3Mh+ZNkJh5VwCLvf36mvB1BjEiwEW10ch
	 fxILnyN04/MdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45DDC406C7;
	Sun,  4 Oct 2026 19:59:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A664032F
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D31140075
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:59:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-Yae-JIh2eL for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:59:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 500A84002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791143946;
 b=EOLl1QIyiSJgVy9NNJFA2AzEikEbEfaopYgOLWhgQya3VK7H0vm/qx9tZZVuQu4g90uR
 hCXSxRV/+yHarNN62uqRr2f+XMiKA5apbZNIiXj8htQ7bYrvmgJusTqFAuVwwgwvqsH6g
 BavZiY6G27W0hLEE5r4OZZCtVWc/Zy+BvIwBCA7dN4WFVTVG+Ou96e5RvernqiOOwhuP0
 zoecisHu4xl+xrUdRfjymNwVbf0w5pd8dtlMlL0Yt+OazvlcqatdPrVud/BQbjmlTXxY6
 O2nJTkn5jmL6ZSVzzlHTnOgyGGxvGwDSyv+67gGIynM7bboBLsay+ZnmXVrqd9DkEEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791143946;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=bPmU/qgHga5krdDBtEU9qKy8d1lyi24pqmV9J7zrF2w=;
 b=mEC6A6gMrNYGEnSJaP4EKQuku0xOSqEhipz69wJQHtYV9WzLcYIOVEoLY/WqOTpYrVJ7
 EZ0nSEgXrVoKn/tqzenvR5+vYlQtIOpE9TJx6I8iC0iJZbp1VUpf2iunpEGKD3l6jXsNc
 rN0kmfP1+VSjJt/EQuoJ12FV1GXKZQngN1583YEdEqafEbOMb7/jWtEaKEtL175TDC2cX
 15/yZgpwuEzE3YLnzUzgItcx5s01deUMt8vfTX/4LH7DJ85e4QjU6t7L8ZaAcb1e30D2K
 DdgXDI7xRn7hWSGSdY6udfxKChHpxghpokDqufX0X7ltg1u3OHApBoIa79tb9tlXV2Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=fmgqLSIQ; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=fmgqLSIQ
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 500A84002B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791143942; bh=bPmU/qgHga5krdDBtEU9qKy8d1lyi24pqmV9J7zrF2w=;
 b=fmgqLSIQ2D2hm9LLGZDYBQP3ySEwWzX0OVV5ayUmzOwpShNRpXrDSkayRgwPqghxJrKLz3lT7
 vtHgl8PbY6np2igtU9VbAKesLds0wgFCe+4aOYbXGIzEG15R9Q/U2acoHs/LmmFvblK5T1FX/5a
 hNGzK9X54M+owJB2EAtRlPLt2dXascXguzC9aC0XdgL6biDAKKjMz01lFQeFvH+kA+KJHsd0GB/
 xYZMDSpgnEALNQNvVb22bmSJ3vvqL3lh2fH4kc+XVcQd3Va1Bkf2RflliKMp8gssBrn+4cvQE6a
 N37AjzU1m43b6sdv158E3rO5rTx/IxEgJIlzLFRvxzng==
X-Forward-Email-ID: 6ac2b003550bbe43c208e0a2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] rockchip: mkimage: Update init code size limit for
 PX30/RK3326
Date: Sun,  4 Oct 2026 19:58:51 +0000
Message-ID: <20261004195853.59863-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004195853.59863-1-jonas@kwiboo.se>
References: <20261004195853.59863-1-jonas@kwiboo.se>
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

The PX30/RK3326 has 16 KiB SYSTEM SRAM at [0xff0e0000, 0xff0e4000) and
8 KiB PMU SRAM at [0xff020000, 0xff022000). With 4 KiB of the initial
SYSTEM SRAM typically reserved for BootROM during early boot.

BootROM will load init code of up to 12 KiB (0x3000 bytes) to address
0xff0e1000 in SYSTEM SRAM, before jumping to it.

BootROM of RK3326 typically jumps to init code with following registers:

  x0: 00000000 00000000
  x1: 00000000 a000414c
  x2: 00000000 00000000
  x3: 00000000 00000000

  sp: 00000000 ff0e0f50

mkimage is enforcing a 10 KiB init code size limit for PX30/RK3326.
However, the BootRAM can load up to 12 KiB of init code.

Change the init code size limit to 12 KiB using the <size> - <reserved>
pattern to closer match the actual limit of BootROM on PX30/RK3326.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 tools/rkcommon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index b39777fc0607..ccd1cb5b1ef6 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -137,7 +137,7 @@ struct spl_info {
 };
 
 static struct spl_info spl_infos[] = {
-	{ "px30", "RK33", 0x2800, false, RK_HEADER_V1 },
+	{ "px30", "RK33", 0x4000 - 0x1000, false, RK_HEADER_V1 },
 	{ "rk3036", "RK30", 0x1000, false, RK_HEADER_V1 },
 	{ "rk3066", "RK30", 0x8000 - 0x800, true, RK_HEADER_V1 },
 	{ "rk3128", "RK31", 0x1800, false, RK_HEADER_V1 },
-- 
2.55.0

