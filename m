Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E0606A326
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d6ZN5Tbu;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=jkaViklD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C22B60E1C;
	Fri, 20 Nov 2026 07:54:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZZ6B1n4QLcmI; Fri, 20 Nov 2026 07:54:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59E6C60750
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795161298;
	b=S1OI4vNzG7tmT+I3/bxDdY8QZF+QSZmqMHGyJa5ny6VpA3S/pSiofqdZ5kglsZqKaXUG
	 yLqWShc40mS5+J3pWyn8qlq1GQ2YoStO7pCosUdEdugLoFVSlj8dqcPLv5y2JdRUg+nx+
	 j6SlFEPV/+e/hcczTpyfy9kIJgKc2QG5ZW06LLsKLkq+g6zxHjkqo0okN8+VArZ8WbKps
	 +d4D0S24o4mS6CawKocTwLNR2dKnAqjJolp1qc66LsSC2mVRiR9btTRGrVGBgqYUNiCln
	 fhgIprTr7pwe8GvNp6EcWQHSe+obrId9LELLsqXCirtcEPagxSIQ3ow/0PzElZNOXNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795161298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dOT3WONuSem4lBtK4qCTRqQz5IVikD35h+8qtaEiRc4=;
	b=YwhX5HT+n7YFXI2x1HZejCZU7AIhf6mMVCFCZSvDo745KG9Av0grJnQvNkdJ5QNFMDVK
	 HLKCKi/s6ZuIVJhwbcZI5fck3qafZm8ed3DCIn8tKGYwqS5k9W7Z3V7LjEpBHb0+mwO3+
	 QB2iYQCHdgYlWly2xtiVoKQaeKJJzNIybS0Ybr0p/KbZQzlXimifgH+wm+1T2agVxiMb1
	 jwkIsxfjLiA6suMz2r+ko3hxhus2By766oI78R0rWlmC9oZWC/LaNUcTHY1Xf1NFfN7Ip
	 e09nFGn8FHgcnBawCuCiAgodHKZQ1D5e+X6fuI7btAe3+sbeCT2BEpLLfCxb1C6WyEg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795161298;
	bh=dOT3WONuSem4lBtK4qCTRqQz5IVikD35h+8qtaEiRc4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d6ZN5TbuaIvuQZKWELQmXiYno/B3JhzEl/QyCFXD6OukO0/TM+UK+wC7AJDPuYQB2
	 ZoR0Iijt02pOw/bs/3yTx5boS8a7oUlg8Q2yAINg61+IpI9uKx9bHUtP0VmMMOQZ1f
	 ZEhEMWDpE435f+hvCcQ4oCo+Ik9GnW0WsfwqfIaLutAyoRsJSgWwsHK69bl38wccyh
	 Y8L82eQyFqSTNUKl/36e77RCzewTmShIEX57B8dKXjcagCMWmY94oqdsT3k9twC2Sb
	 of3YlFggEsRhkiXJn9zXjjXcdqIIGwcIpZQ4t5RAhqxQJGN+hXpp6X11gHKhCWRiei
	 vizvMHw8oYwjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59E6C60750;
	Fri, 20 Nov 2026 07:54:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 72C3379D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 07:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C9AE4020D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 07:54:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MX4ByagWgeoh for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 07:54:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 11F1C400D6
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
X-Greylist: delayed 1553 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 20 Nov 2026 07:54:56 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=jkaViklD
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11F1C400D6
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 07:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=dOT3WONuSem4lBtK4qCTRqQz5IVikD35h+8qtaEiRc4=; b=jkaViklDNaEYmVJPv9XkiypZ/9
 NLABEX3z96ZMfYc+JtGh6i/4IXrOqMv/HcW/dzT0iqpFxfKmAsvqmdMfSgFskPntQKKD59tmMYEHP
 HOrSwt2rokL5oGGkTDHMkzyy9/loCRyqGifo8DxZBm8yDIAjC5u+AyYe5fXyZkeE0MwtXMw/i0cX9
 3RNpLGMzm3Qo3efEtcmsaj8l70t/Hjc0VAgw211LDI7bnHUNenICMZ266TNWfEYi3rotcq9UmHKJ5
 QvvGG40az/Di9Ww6BXftMk086SYkOJbxkzDnwDEemtNvGhW1TRr90MRc+QlZpshulo8p4SX3l4wyU
 l3zn2GRQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xUJSN-000GR8-2f; Fri, 20 Nov 2026 08:54:51 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xUJSO-0001eL-05; Fri, 20 Nov 2026 08:54:51 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 u-boot@lists.u-boot-project.org, u-boot@ew.tq-group.com,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH] include: spl.h: add return code documentation for
 spl_load_imx_container
Date: Fri, 20 Nov 2026 08:54:43 +0100
Message-ID: <20261120075445.2545358-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28189/Fri Nov 20 07:29:13 2026)
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Document the return code to improe readability.

Fixes: dd7d0911e004 ("spl: mmc: support loading i.MX container format file")

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
CI: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13774&view=results
CI has Free disk space warnings: Free disk space on / is lower than 5%; Currently used: 96.02%
CI has errors which I consider to be the following.:
e.g.: ,##[error]We stopped hearing from agent Azure Pipelines 2. ...
---
 include/spl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/spl.h b/include/spl.h
index 390d18fd9d5..3683a08b80c 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -572,6 +572,7 @@ int spl_load_legacy_img(struct spl_image_info *spl_image,
  *
  * Reads the container image @sector in the device. Loads u-boot image to
  * specified load address.
+ * Returns 0 on success.
  */
 int spl_load_imx_container(struct spl_image_info *spl_image,
 			   struct spl_load_info *info, ulong offset);

base-commit: e6fa1282975af50acf44be7aa678b89e187f0860
-- 
2.53.0

