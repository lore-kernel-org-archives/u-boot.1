Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C9CCA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7238F4056F;
	Tue, 29 Sep 2026 00:21:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oraAhhFDz7m2; Tue, 29 Sep 2026 00:21:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 644B940557
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641315;
	b=anf14PyUhfTmXTOpMsg08+N3Hy9GlUA1VClx6cz+KXxUO0rXywZCnbM0Zo5AnnhiycW2
	 mAF+PdZsO/UGJdUzBTa0y3al4BT4NlUYdRDvXa8SYMaTzE+SsbFdQhVDwEodNgOJljTWy
	 Lb1MuyhK+UCmKrKbMBiKb3iqfMZA0eJa8mfXvvBEzsQmaI8nBtGdFVDKa7MC2CXpOD3Vx
	 t5RsRraTIfOO3QeMqUaFBWryPRqlu1uvlhtfCXPrZ/VpNaphRSCrx99vA5FuTs4OXg3Dx
	 dK3P79zC+QcGN6xOcwGFDujqAjiEy0H6+Fsikygcf0CHD2AsJaycy+WLF8fopSHf1sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641315;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=yaSM2TVVG56znu3+EOot8lw+kSu9uIrR/lAXlJhWsps=;
	b=Z56BTMJNxDpDcluCQb3Lv/mzs0A73HU1/yWlLKVwpMCCies3tUCOkbXrSJxoFMs+XOha
	 kc1NYZw47NN8NA2r+MCD4U7kJkZg/DF0tg+QgMNZHo4xAvuN2/dHZwkCWQmPTkGJMiOt6
	 S6jPXPkZGVt5fnLzRhhiNU4Ow/IRF4tv28s+CaO2JwS93hBi+4RVJIHofj/IHkB44oq6O
	 JunyWcYMx/z4TbEgqqLZHfzgxh9VGKoeuzLkAVMbj3YAyOWA2Rp1w9lAXdccby/qg1BP1
	 GpFEwBS7UmoTInLczrRP2lmTD0uZVNeNFocY6s1A2HJK1rpO+eFeJEcVS119okZSHGw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ej46wAR8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641315;
	bh=yaSM2TVVG56znu3+EOot8lw+kSu9uIrR/lAXlJhWsps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DNq5EM8iEH/G3bY38oEdyJcuX9mZeEjsP5EBPigkYdt/7kXfIYdc7U5uRPkbZsVt+
	 ZNLdBJ+3rlSyzPOfUvuuSBT2VjDRsXMi/bjX0niA8EufXQC8DWCAG3DqcbMc1ui90R
	 LWlhQ6gUnLjIBCRquGw9TXcMIny7fN6kr0e2OogOSUPWk6Ls75HwalFE04z6faeG5L
	 +yGKdISm7GCT9StocKlaotgbMPqNa6EVmFBJK5Vp6KWIuJaVibd09AtH4GUZRBj80C
	 bctQCIACTgODg59NRYnfvEnOa2WuHoI2/G0qAXDzOFt55wynjAIEM02ajuSSdBNWIh
	 Iwxfdgdj/B+tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 644B940557;
	Tue, 29 Sep 2026 00:21:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C890335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D3C540557
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:21:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1C1ovAkW9xHA for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:21:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9AC234054F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641312;
 b=kISz7ayylPhJNXnL3oOzjBFsQtIYZpFd4UdJ3ywGDIuN0lYuz2ttkdjGJooAxSger8PT
 /LrGmqUxag+2F6DE+oMD1Hyyzv9pS+56cWY3fI9RlfHSl8gvJWlFmxx52F3LFBp3sDzOQ
 C3Iu1R2ByCgkhhGhdXQQcrNnAYaswPHfVh1paYNcEPR3rIBztf0WB7wY00x0AgrzLvb/p
 7fzSBxImdI3cIJyDJBZ1Ei9vJDqeNHtpAvsitxc92Tcxm3kDR0KcWppkkAyNxqSC2KHhm
 iu+J7moO1397kQXhEd/T5C1fq+j+EmG3+MOd2VACczj4goHraApFSHGli6NL++yTDNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641312;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=yaSM2TVVG56znu3+EOot8lw+kSu9uIrR/lAXlJhWsps=;
 b=MZ0IIB1sLG+E/NEnp5+ScTOw5iUT512Zqu9+HebzFsD6zpuoC9WzUnQiiS7nsDV/FTNQ
 OxVNi0QR90jqdXwzqwm+9dLdX/JGcsHFExV0YxneLA7iYYjtF1DJIcRcWpEWbBCa2zvWS
 Z1P+sDN3qvx8TzvkB2oSgDeTDLkIwQ89WbOWGNNX/e7JdqqbazjCQSoGJDtFClbXlL5bB
 5zjB5TJQZywdESPaGWDnwc8rHGKeNWKoKxBya/j3nZoftGi3x2gJ4gnymfT8BUHierxOy
 /6mzMHel/pu6q4XA1bNN+6rn0SgyoeOKTPcPXSxlt0dYdy9yGu+rOAkmOdnRNgXD5cA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ej46wAR8; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ej46wAR8
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9AC234054F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:21:52 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-47bc923fe6aso2363586fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641311; x=1791246111;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yaSM2TVVG56znu3+EOot8lw+kSu9uIrR/lAXlJhWsps=;
 b=ej46wAR8+/mYhTY48874n1oSpIMf1m7VPB3PV9BJ2IYKj/7wS+6udIhLt2lKeJ1Xn3
 AcRfAzLuKzChE7kv6D3ruXwf5ZBNrMlVwNw3Guthv4IZdejxneSfkMHbLfIckvP3G92C
 Hjc4u94holF5sGmLzt3G3D1RznprifBF2wdr6mODBJQFrA4TfHrWlpNNpPC4euvsg6FZ
 I7HTJWmyrpLMLDVrmrFZXAhTUmAec4qqsPFOo5DbqKxdz8+WjTIAoox6xh8UlPCdVeC5
 M+2JUAY+uj8yz/gTAljKBAv1E410GuRSoGIRM+KKGLyHFcNVoXqRLkS4VLfQNzJIqDjZ
 q+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641311; x=1791246111;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yaSM2TVVG56znu3+EOot8lw+kSu9uIrR/lAXlJhWsps=;
 b=NZHs+p6zRRGa3jPqvoxY9LGVZ/EpMX6JCPoIKNQpoa1TTfUhFxIe5+ROY5il3IvQJz
 +97Amn8mkPgQNe853Y8VrbmM79xgml/rRmov09kdME2cBKYJUlaMqVz1agfBrHBgg9qG
 /x/SU/jVxwBSQOQI3uXIaP+RMXYNFSYyndtbqKkiaJonWmPSwa4GzSmPah1nB0VTIUbf
 UxEPqky6TqFA9pIZIUS5B50R6LZ9Kp2xqcx68WxMisrMgXkJv7Pnb0j3l8vOle/Sn7Wv
 B8EN0E/kLHWolE+yjqZnl0KmxylyfupM34gw0xdXha35Kt31K9Pg7gL6Oa/N91z7eAKb
 w9kQ==
X-Gm-Message-State: AFq9FYJG+yatKWJ3T8SQnyS/Uq/XzrgCWUJ5pozXvjaa1Qh+g1fbhtAE
 7ZTJK6v9dJAfXjM/Pq8ma2+T9M0GpTOHv0EdZnM88l5AHh7NbybUiaNH
X-Gm-Gg: AYBFou1LlJj2i1ZSr3+r6MmGDessvdHYlaoc4FdyPggTBvwPprvNdWWrN1cfpYD5uv4
 mFgZneXIQPW2WgHqkghQSYP36GptsbpRkmuQIzybJVlRA9Eph9Chb7PZGYocQXzDG8s9o7XXKnO
 Zz62D8GfiGZUKyO5ahwmDPQZLKMPCplx5UGTj/eMzyjlnSfpG1qyTeDeVfWRVF/eIJrQtPoZ4Mi
 jl577o/VzwbhgCyYduBH2UXt9oRI/N3ovCeceKNFqb1chdYfs7MdtFWjQmkH9WmWoi7aQ7rUAwH
 6KeTiOOWR/zHskX/890IMDELuEGu/StQGUV/g0EiFAIkxN8ThIdosJelJKqr9saaCVhhwaVZgDI
 cxUhBX/KjIzJZwOABs4mQxJYw7X69xru0J98DvoEwbXZbCK3jGr2U/UBslseyvljyP7BRshf5ui
 vE4GUvMffAdZWSj7D+DUEyNc1Z782lXss44MrduhVqkEdupHzDxps90B13q/m/N+X9Nl/zaT+tV
 AytuVQ2jMxx7WGX246o0/s9jEH/cS6MjEdQZSXPR5Qf5+mg6ZeIJSz+hy+iLuTFkHAOVWMbwfLn
 nx9Ps5hK+6VqqFHZT7tGsyziBRioAU6awRHANFEIW3LoMIocMxtqpGPy+THDY2R6lgOhYNsdeRe
 KqiHWRH1l8gBXOTs8RTk+rHwoCY6E1DaAaIEafn1kzA==
X-Received: by 2002:a05:6870:469f:b0:47c:d058:5aee with SMTP id
 586e51a60fabf-491e91f1ddcmr13180149fac.31.1790641310962; 
 Mon, 28 Sep 2026 17:21:50 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:38 -0600
Subject: [PATCH 01/20] net: lwip: bound NFS filename parsing and release
 its copy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-1-2060c7365b0c@gmail.com>
References: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
In-Reply-To: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peter Robinson <pbrobinson@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Heiko Schocher <hs@nabladev.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
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

The unbounded strsep loop writes past words[2], including the
terminating NULL for an ordinary IP-prefixed filename. Advancing the
allocation pointer also leaks explicit filenames and can modify the
global boot filename in place.

Split the optional IPv4 prefix once in an owned copy, preserve that
allocation base for every exit and validate the load-address argument.
Preserve the command, global and environment strings. Test repeated
error cleanup and names containing additional path colons, and include
the byte-order definitions needed to build the existing NFS tests with
lwIP.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/lwip/nfs.c     | 70 +++++++++++++++++++++++++++---------------------------
 test/dm/Makefile   |  3 +++
 test/dm/lwip_nfs.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 test/dm/nfs.c      |  3 ++-
 4 files changed, 101 insertions(+), 36 deletions(-)

diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
index 42ce5dad946..b435403169a 100644
--- a/net/lwip/nfs.c
+++ b/net/lwip/nfs.c
@@ -3,15 +3,16 @@
 
 #include <console.h>
 #include <display_options.h>
-#include <dm/device.h>
 #include <env.h>
 #include <image.h>
+#include <malloc.h>
+#include <net.h>
+#include <time.h>
+#include <dm/device.h>
 #include <linux/kconfig.h>
 #include <lwip/timeouts.h>
 #include <lwip/udp.h>
-#include <net.h>
 #include "../nfs-common.h"
-#include <time.h>
 
 static ulong timer_start;
 
@@ -183,21 +184,19 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct net_lwip_ctx net = {};
 	int ret = CMD_RET_SUCCESS;
-	char *arg = NULL;
-	char *words[2] = { };
+	const char *arg = NULL;
+	char *arg_copy = NULL;
 	char *fname = NULL;
 	char *server_ip = NULL;
 	char *end;
 	ip_addr_t srvip;
 	ulong laddr;
 	ulong addr;
-	int i;
 
 	laddr = env_get_ulong("loadaddr", 16, image_load_addr);
 
 	switch (argc) {
 	case 1:
-		fname = env_get("bootfile");
 		break;
 	case 2:
 		/*
@@ -209,14 +208,16 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		addr = hextoul(argv[1], &end);
 		if (end == (argv[1] + strlen(argv[1]))) {
 			laddr = addr;
-			fname = env_get("bootfile");
 		} else {
-			arg = strdup(argv[1]);
+			arg = argv[1];
 		}
 		break;
 	case 3:
-		laddr = hextoul(argv[1], NULL);
-		arg = strdup(argv[2]);
+		if (strict_strtoul(argv[1], 16, &laddr)) {
+			ret = CMD_RET_USAGE;
+			goto out;
+		}
+		arg = argv[2];
 		break;
 	default:
 		ret = CMD_RET_USAGE;
@@ -224,32 +225,32 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	if (!arg)
-		arg = net_boot_file_name;
-
-	if (*arg) {
-		/* Parse [ip:]fname */
-		i = 0;
-		while ((*(words + i) = strsep(&arg, ":")))
-			i++;
-
-		switch (i) {
-		case 2:
-			server_ip = words[0];
-			fname = words[1];
-			break;
-		case 1:
-			fname = words[0];
-			break;
-		default:
-			break;
+		arg = *net_boot_file_name ? net_boot_file_name : env_get("bootfile");
+
+	if (arg && *arg) {
+		arg_copy = strdup(arg);
+		if (!arg_copy) {
+			ret = CMD_RET_FAILURE;
+			goto out;
+		}
+		/*
+		 * Split the optional IPv4 prefix once. Keep the allocation base
+		 * for cleanup, and do not modify argv, bootfile or the global name.
+		 */
+		fname = strchr(arg_copy, ':');
+		if (fname) {
+			*fname++ = '\0';
+			server_ip = arg_copy;
+		} else {
+			fname = arg_copy;
 		}
 	}
 
-	if (!server_ip)
+	if (!server_ip || !*server_ip)
 		server_ip = env_get("nfsserverip");
-	if (!server_ip)
+	if (!server_ip || !*server_ip)
 		server_ip = env_get("serverip");
-	if (!server_ip) {
+	if (!server_ip || !*server_ip) {
 		log_err("error: nfsserverip/serverip not set\n");
 		ret = CMD_RET_FAILURE;
 		goto out;
@@ -261,7 +262,7 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	if (!fname) {
+	if (!fname || !*fname) {
 		log_err("error: no file name\n");
 		ret = CMD_RET_FAILURE;
 		goto out;
@@ -282,7 +283,6 @@ int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		ret = CMD_RET_FAILURE;
 out:
 	net_lwip_stop(&net);
-	if (arg != net_boot_file_name)
-		free(arg);
+	free(arg_copy);
 	return ret;
 }
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 5dd6b57bbe8..32eba8b5e20 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -55,6 +55,9 @@ endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_NETCONSOLE),yy)
 obj-y += netconsole.o
 endif
+ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_NFS),yy)
+obj-y += lwip_nfs.o
+endif
 obj-$(CONFIG_EXTCON) += extcon.o
 ifneq ($(CONFIG_EFI_PARTITION),)
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fastboot.o
diff --git a/test/dm/lwip_nfs.c b/test/dm/lwip_nfs.c
new file mode 100644
index 00000000000..f1c61b61c63
--- /dev/null
+++ b/test/dm/lwip_nfs.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Regression tests for lwIP NFS command argument ownership. */
+
+#include <command.h>
+#include <env.h>
+#include <malloc.h>
+#include <net.h>
+#include <dm/test.h>
+#include <test/ut.h>
+
+static int nfs_filename_check(struct unit_test_state *uts)
+{
+	char *const argv[] = { "nfs", "0", "1.1.2.2:/dir:file" };
+	char *const bad_argv[] = { "nfs", "not-an-address", "1.1.2.2:/dir:file" };
+	unsigned int allocated;
+	int i;
+
+	/* A zero address rejects the transfer after parsing, before any I/O. */
+	ut_asserteq(CMD_RET_FAILURE, do_nfs(NULL, 0, 3, argv));
+	allocated = mallinfo().uordblks;
+	for (i = 0; i < 32; i++) {
+		ut_asserteq(CMD_RET_FAILURE, do_nfs(NULL, 0, 3, argv));
+		ut_asserteq(allocated, mallinfo().uordblks);
+	}
+	ut_asserteq_str("1.1.2.2:/dir:file", argv[2]);
+	ut_asserteq(CMD_RET_USAGE, do_nfs(NULL, 0, 3, bad_argv));
+	strcpy(net_boot_file_name, "1.1.2.2:/global:file");
+	ut_asserteq(CMD_RET_FAILURE, do_nfs(NULL, 0, 1, argv));
+	ut_asserteq_str("1.1.2.2:/global:file", net_boot_file_name);
+	net_boot_file_name[0] = '\0';
+	ut_asserteq(CMD_RET_FAILURE, do_nfs(NULL, 0, 1, argv));
+	ut_asserteq_str("1.1.2.2:/environment:file", env_get("bootfile"));
+
+	return 0;
+}
+
+static int dm_test_nfs_filename(struct unit_test_state *uts)
+{
+	char bootfile[sizeof(net_boot_file_name)];
+	const char *file = env_get("bootfile"), *addr = env_get("loadaddr");
+	char *saved_file = file ? strdup(file) : NULL;
+	char *saved_addr = addr ? strdup(addr) : NULL;
+	int ret = -ENOMEM;
+
+	if ((file && !saved_file) || (addr && !saved_addr))
+		goto out;
+	memcpy(bootfile, net_boot_file_name, sizeof(bootfile));
+	if (!env_set("bootfile", "1.1.2.2:/environment:file") &&
+	    !env_set("loadaddr", "0"))
+		ret = nfs_filename_check(uts);
+	memcpy(net_boot_file_name, bootfile, sizeof(bootfile));
+	if (env_set("bootfile", saved_file) || env_set("loadaddr", saved_addr))
+		ret = -EINVAL;
+out:
+	free(saved_file);
+	free(saved_addr);
+
+	return ret;
+}
+
+DM_TEST(dm_test_nfs_filename, 0);
diff --git a/test/dm/nfs.c b/test/dm/nfs.c
index e18e5812440..bc92e454064 100644
--- a/test/dm/nfs.c
+++ b/test/dm/nfs.c
@@ -5,8 +5,9 @@
 
 #include <net.h>
 #include <string.h>
-#include <test/ut.h>
+#include <asm/byteorder.h>
 #include <dm/test.h>
+#include <test/ut.h>
 #include "../../net/nfs-common.h"
 
 static int dm_test_nfs_read_oob(struct unit_test_state *uts)

-- 
2.53.0

