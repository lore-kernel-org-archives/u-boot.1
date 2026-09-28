Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED545CA5FA3
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 18:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A91D580B09;
	Mon, 28 Sep 2026 18:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GytbF5E4KBZF; Mon, 28 Sep 2026 18:54:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DE86E80AED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790621678;
	b=DnBTgKeZy+KLJfM7WFqIZ9/ZCIvZja7TPbvPA1ZIv8FC1HaDclMLd45pfCedZsLgdCAq
	 VqWWZ1UZtNaGHbQQQsh7eqohKxqE9a2mi/FiZRwa+FgDnjG+3dfJKSOAR3/ahEMsXQNbS
	 jwxDMgeh6nfTqhap08k9AeWAjIKa0CPPhfpE4C4om9+XYkxZ8unUQzuNefb3lRhp1ulq1
	 YiqahYtHUCA5dGuEexgvXLjA+GxlUgiakUqqD9txDo/ffVMu0atcVL+ajFSjbYYP18cnH
	 xscRjqZuSkk5GyBKzn5E/xCj2LcLQtNkIf5iTwANzt6S+wKjuHdKTm1OKOoUN4MXWxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790621678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uqRmoUhA9wz1JaqeT8/Xc8vva6CJuQyXLue4CxgY3b8=;
	b=LQHLvULNmC4+KS7h0ifxe/ilWDzy38ZSRDxhOx/aFB79UbeWZVeBxZguS/O5RznXG0sb
	 KVUFacpVm45JSj0KpkWS083KQ5QT2zrtyojP3uRGZuI1l2uLWFb1SIQJRTFuiThgfRyc4
	 8Jnq+zAzGzbvpmdAR9FyXLwZQMnMqBhLAIAefiEgwG2ej2idIC263Pk3T+d6TiSuftoT3
	 xXjY+WvjLpPA+13rtZP2mIvvbndXs80rbq2kEDUxbyCUY/ULzBdyrcNLYlVKOrCkw0GKJ
	 gobNeOBlk0Ie2CzZnKc0HxfiyV6gymsk8UK46D3yB29WSDC9eIkYOsix5oHJaCw/G0g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790621678;
	bh=uqRmoUhA9wz1JaqeT8/Xc8vva6CJuQyXLue4CxgY3b8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YsTw3D18g9nU1+fUCqcfdsdYtdJduVNqeYanxjQHt05sTxqzAW3Ggrq5SHNMYbPfv
	 4uFFxSKG4Ro17LgE5YcJfASQfZ1zO069S1L3ehuZ/b9C6eeriINE5UypLrj/CpZODh
	 dXxPlVBE5rLAkSF3Nll5jR9sjyITu7XwdTMhzN/FS7JUAsDU1gctmkdIQLpxqbIfIQ
	 VFJgG3XPYTW9v7mxrFL8NsTXYaIn8l8G8TJEj3RXBA3rFfGQSZNM9LwH5kKBN4tjcz
	 wVq2Bs/eYwQC5smm4OMNXujlaMfINTG5J0GUPBaY2R1854eDFLdLL1YVYTnh75YCPC
	 eLfEeS5j5X4Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE86E80AED;
	Mon, 28 Sep 2026 18:54:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E1573A0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04C274054A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:54:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OEoUdKbZqiap for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 18:54:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8485D40547
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790621672;
 b=buQX1AwzIvtShxKZ0Vbm8UZJ27/ljuRlIwgoEjUe9xp1SZVeu3OCfwKUcsPN1h2Thcye
 m84aIJ9KyOJLiYA9cKuAa311P58oKgKCFIuNkpz/bTmwFclYgi5jVpSryA1UeEiTn/fmt
 2RJotmCtTF1oGVCecQoFfJKOPtgh9tcsLdxdYReG5tMSlvVb2pcG2usDZJybpl5az2Zhq
 9cVW1Pr374k8P6YL9bDHOuWW3kNc0s5Iug3RZV0nw7VtNC+06sPidl5wYiwYV4zf+o4fc
 7RdewQdWWvXeO1NQptt72EVeJxvIndQCzCFSBmc6k0ZsmzaCyHh5ka6s+wbYf3otgtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790621672;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID;
 bh=uqRmoUhA9wz1JaqeT8/Xc8vva6CJuQyXLue4CxgY3b8=;
 b=PWdbxQkjeXhDRhu6F0epMIVgLGWNjE/xZDR2pioBmpU/Fb8tafHOeBm1+2B+FHD7oEOG
 OdTNwmXrtZBCY0z+PY2Knd1g16a0x0ExSjX1l8uR82ejQABzYqbEiw8Xt9gglekPgVdRr
 bX/jTwpmn+rPcaNf8upmEWRGRFwA7jbNSt2wZlKLL0s1SbA5h/f8xcNq4tS5su+Xp3IDA
 KIA9Tom8JpeHHvfPvn6fD7Rksy4jO9T7bcUMhBojFuGdh8EkvwdaW7UWROhHh06oD0V/G
 UJAqelmS+H9lcOkVFaHXsOGG2bwBlfwnmNJm5K1E1LGpRb8to9TvjDeN9oOaiAzxlcg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=MJQUfAoC; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=MJQUfAoC
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8485D40547
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:54:30 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4htr834SRvzKp6C;
 Mon, 28 Sep 2026 20:54:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790621667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uqRmoUhA9wz1JaqeT8/Xc8vva6CJuQyXLue4CxgY3b8=;
 b=MJQUfAoCaP0Pa1fp7eLPKzfq4xdeIVobmab9dkBnP71KXMvB8ToFSju5zs7LMK+UEU1ViL
 etYa9LCgzS8TibajgQfy6r9/+6l3tLJQdYwCrHM7Stl7ZIRlzVtHkkVIT1znlv/l0jZ7uw
 qaxYRIb61B5JNpI5kEkRY+kOhf6zCOrLz9Ait3H2/yTk+W6qWYTNUuOruUmz+SVwOs1Ro4
 dTmUGmK4LE844RtT5np+WSSM7wvDpoCyqIyoT69yV3z+62UiUFrpFkjsW7pqI0fR33aJgm
 /4eIihT5tbZ3vEimC/XuQykW9O1o2xAn7x7FWwE+BzFQooRXwewhzIL0kqeDSw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] clk: renesas: Add SDK SCP 4.37 map to Renesas R-Car
 R8A78000 X5H CPG clock driver
Date: Mon, 28 Sep 2026 20:54:01 +0200
Message-ID: <20260928185422.113757-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: q7ozw55zcnup5td68d5dokjsh5rayac9
X-MBO-RS-ID: 03335daf500b49012d2
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

The SCMI IDs did not change between SDK SCP 4.32 and SDK SCP 4.37.
Add SDK SCP 4.37 as supported version and reuse SDK SCP 4.32 remap
table.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/renesas/r8a78000-cpg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index 67d820bbde8..dc24bcdc000 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -106,6 +106,7 @@ struct clk_map_in {
 #define GEN5_SCMI_SDK_4_31		0x010d0000
 #define GEN5_SCMI_SDK_4_32		0x010e0000
 #define GEN5_SCMI_SDK_4_36		0x01100000
+#define GEN5_SCMI_SDK_4_37		0x01120000
 
 static const struct clk_map_in gen5_clk_map_dt_sdk_4_28[] = {
 	{ SCP_CLOCK_ID_MDLC_UFS0, 202 },
@@ -188,7 +189,8 @@ static int gen5_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
 		map_size = ARRAY_SIZE(gen5_clk_map_dt_sdk_4_28);
 	} else if (priv->basever == GEN5_SCMI_SDK_4_31 ||
 		   priv->basever == GEN5_SCMI_SDK_4_32 ||
-		   priv->basever == GEN5_SCMI_SDK_4_36) {
+		   priv->basever == GEN5_SCMI_SDK_4_36 ||
+		   priv->basever == GEN5_SCMI_SDK_4_37) {
 		map = gen5_clk_map_dt_sdk_4_31;
 		map_size = ARRAY_SIZE(gen5_clk_map_dt_sdk_4_31);
 	} else {
-- 
2.53.0

