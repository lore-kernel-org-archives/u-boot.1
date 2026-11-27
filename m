Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B502606A321
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tNopcvNb;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=c2sz4isn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95F4240A55;
	Fri, 27 Nov 2026 21:45:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KElcROZB1Uv4; Fri, 27 Nov 2026 21:45:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC30840A01
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795815910;
	b=B9/R7mzKyHAIN8I8irafPJhhNGNiFimVj6IryI5QB/xSNteApsUYcna9kwFefX4ZCrmU
	 kX886evq0wUo1Al0eInlyefSNLXejAZFhg474x9MFjjZjn3kRSdFjk/hCoHurkg3l3MVf
	 uXvKSEFpeP7FGwIEDn0Yg0Y8UqHt+AxlTzveeI/KwhjyLELkFcrtQjS1xzcCE3Yz4CDrS
	 dt5S+brtnatp9CSAszmGLtH5RB7kYwNMsQ0dxQ6PWL3G9wsRH8CJ3Y3WUNZThf9abyJKB
	 xWmUDghkudKBM5ZQhRPEIhoZRyYUJA070tsAPJrpiDuXt7GLwDX6wFeyCAIoYitQF7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795815910;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fCLfwjK4EG6guxzK36UgdrBjf+HhPxcxbsGVl4qkGRA=;
	b=h57d0h3Ajon7OHjsCeLNvYoMaNCm3pM2HELJ6N5sH8kTsTHTI/x04aX5AtIPOYRRS/Kr
	 Vpqibn8UU7jJ6QWuHI8yrPm4nJGZN2sC4Hu3g8UULlN3s1Q8zdvEEm58cM7BAXWAmrLMr
	 e+PoK4uhb5sZWOOU+iSzLT5a79B9N9sC+22K774UK1I8iIdcnpdDFz4NZtWsKfxKJU16z
	 QI+VAfLNZ7yJ60jp4OJZdQwfA/vAHaqG7dvZPx9jQi9B7s38I4tvpLF8Exz2P0DAvSdxU
	 zbFaX+gVzoMmCk7m34l14XoSnJqCgmOsKFI2o8cGEoWETNbLsQHrID45YIHwDM5dlJA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795815909;
	bh=fCLfwjK4EG6guxzK36UgdrBjf+HhPxcxbsGVl4qkGRA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tNopcvNb/J/17ykwlXpmf7nSt66RQH/AxdtYx/pCsba7bToU4lK4VC2k/8Yp5G13H
	 +Zk1UcbaqKI9g/OrZMEKew1PZO/lK7L/NJG4vWt03TPJHjOlhCuvy+DI81wgX5HNPG
	 cauiFUg6VDLjIyQyKk38EnZN4ZXevIhP0qjplt9ea+LVCiXgWqh5wJbRzq30f0MI8A
	 jBC0JqWJ++ZxNa5OPs999Vv9tszmjVWn+w3rl4oIHfwsM1xgSn2S0ZcLCK/BxFDzRT
	 OFgYZxJ+hibecmk+w1FeWpanQf9wAsmyxAgueRDmpNkTVXUisfFShSawyeinrk4skw
	 IqIqlar8bLEuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC30840A01;
	Fri, 27 Nov 2026 21:45:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D39C32BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 21:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C47E9400BB
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 21:45:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YLKhgKAzBdhl for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 21:45:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 81ACE4008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=c2sz4isn
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81ACE4008C
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 21:45:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 72A93B0053D;
 Fri, 27 Nov 2026 22:44:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1795815904;
 bh=nfNpBdFhPNbW1sF2KHyfYtp0IuVVjjjE086qhHXKPe8=;
 h=From:To:Cc:Subject:Date:From;
 b=c2sz4isn6SBQfPgb7f47p8bjyJv+4GAhGNoXeymqKqz/vASjr2CzVcQ+OedGMSKIK
 4nG1WD6hxvQFLIVtowVjTXlDLqP0vhb/255rVmpjFUN3ij5++AB/cvC4JLe4dqRQqj
 5DDhzrjRErN+BtFHGtt2+jn7BUA8xuQQMj5kUrrGda+qsINvc8iSv9gsKRsyYtFZEj
 EpSPELj51kulekc7gpIhHeLzPsBzrSyE80CS5Bc6QPMoZbZQPyAnoL197z7sm4Qcg9
 0zwSfPtEtWWk3lWg4qjQLVqGs/d1MOZDNYDTXpZBvlm5/gWd6OyQxNNMDCwarvVJHl
 HSp3/sQJBki0Q==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Maxime Leroy <maxime@leroys.fr>, Vincent Jardin <vjardin@free.fr>,
 Florin Laurentiu Chiculita <florinlaurentiu.chiculita@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>
Subject: [PATCH v2] net: ldpaa_eth: track the open state in the driver
Date: Fri, 27 Nov 2026 22:44:47 +0100
Message-ID: <20261127214450.865924-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Maxime Leroy <maxime@leroys.fr>

ldpaa_eth_open() and ldpaa_eth_stop() use eth_is_active() to check
if the port is open.
But eth_is_active() tells whether the port is in use, not whether it
is open!

Fixes: 267c5146d3f1 ("drivers: net: ldpaa: add DTS based probing support")
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

---
It has been tested on an LX2160A board (Nodebox v3) on its RGMII port
(DPMAC 17), at the U-Boot prompt: 3 rounds of a tftp of a missing file
with the errors:
  "TFTP error: 'File not found' (1)"
then a tftp of an existing file, each load transferring the file.
Two loads in a row and a ping.

Changes in v2:
- Fixes tag: 267c5146d3f1, which added the eth_is_active() guards
  (Alexander Sverdlin)
- Add blank line after the early return of ldpaa_eth_stop()
  (Alexander Sverdlin)

 drivers/net/ldpaa_eth/ldpaa_eth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ldpaa_eth/ldpaa_eth.c b/drivers/net/ldpaa_eth/ldpaa_eth.c
index 27ae6747464..e15e5247463 100644
--- a/drivers/net/ldpaa_eth/ldpaa_eth.c
+++ b/drivers/net/ldpaa_eth/ldpaa_eth.c
@@ -380,7 +380,7 @@ static int ldpaa_eth_open(struct udevice *dev)
 	struct dpni_queue d_queue_cfg = { 0 };
 	struct dpni_queue_id d_queue;
 
-	if (eth_is_active(dev))
+	if (priv->started)
 		return 0;
 
 	if (get_mc_boot_status() != 0) {
@@ -476,6 +476,8 @@ static int ldpaa_eth_open(struct udevice *dev)
 		goto err_qdid;
 	}
 
+	priv->started = true;
+
 	return dpmac_link_state.up;
 
 err_qdid:
@@ -502,9 +504,11 @@ static void ldpaa_eth_stop(struct udevice *dev)
 	int err = 0;
 	u64 *data;
 
-	if (!eth_is_active(dev))
+	if (!priv->started)
 		return;
 
+	priv->started = false;
+
 	data = kzalloc(sizeof(u64) * LDPAA_ETH_DPNI_NUM_STATS, GFP_KERNEL);
 	if (data) {
 		ldpaa_eth_collect_dpni_stats(dev, data);
---
base-commit: 9d67454e920b3908529c9fc642a8c911db040896
branch: for-upstream/ldpaa-eth-open-state-v2

-- 
2.43.0

