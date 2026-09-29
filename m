Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E29CA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4933940372;
	Tue, 29 Sep 2026 00:22:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tgyjoBORM147; Tue, 29 Sep 2026 00:22:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 56F48403AA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641353;
	b=CKWL2O+tTAO6EU9sbZI5IMdh1bCa3aM42WK39Xf3arEzgApz+/qDPbYyxW9+lRYxiy9N
	 poa2Ugqh3pqSCDXoOUR1pIvp9I82CX2oibi1b6cw2odUuQXtsyd+S8Z6OwHukTB+N0WkC
	 0maOBW151zlYCSu7TJx/fEQIbJkK7uer+qmmU2aY7wo/3QG+ZTd1KLhIFdANKCs+/G9qh
	 3UkWSPCExx48NElEk/WIijEVY/idScLGsoLVOmjUYgcWILvs/tmfCmCT4CvmBybHT3ixT
	 saJ/Mby++ubR198QIN18B579sMWBKnjJMcluKJ8Gm/0gqS4BiNd0tSu2TWXKov3sJvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641353;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=++OUM/1O4N4uWLejDztYIfnDLwIuTIvhg2qLIwWWHME=;
	b=F9xw/7e8LMddUf8rtwmyOWHD8/ro1k82gnzjlNd6kFOAXlV3v54wNOUzzwPx1Tr4UUnq
	 d+jl6cIHUxg7VcEgtOchS/qvl4IyCgK+s0Qg4RQE7n8DZ+XMCs8Y5lOrYQJGelegLCREV
	 KTQTc3hTghVE7dJ7KqmRupW9HXdeHIwMZNEJIEEOvJ8NI+llqXgcY+aJxXZQxmQ0+mv1Q
	 cjXbklsmLuZsccqXo4UCsJNN74wnOP56fGfdeCIY7AtufTjnIvemWxeX3mBBL7Dd8aA1M
	 rokI8eE9PKiBdo7j0Dlq8GsQAWem23+7aS9kaPWiwhEE+MTcT2whUuhkI6F66l+U/RA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641353;
	bh=++OUM/1O4N4uWLejDztYIfnDLwIuTIvhg2qLIwWWHME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q59sClOGt7Zfy3DtHgugdMDqmmzgoBuBuD1JDR37AlqdQW0l5e83IQHXDpoiPPPC2
	 7nRSWDve40YSkxzOQatprfE4f2R9uSEWZNpRakGK5RnxiywNH8uN4ABIRI/e0+BLsP
	 PdawDqju6EC5a/1OQnQPEoiyYNEE5fJWxVBLQNbzLEMY6tqwbXP1QtmDG09Pn4Ntve
	 mJVUrw4NC8SnBbO6pu490SZEhZRdEV6elDdbSLCphJFr2Oxs4HkWyVvCrJsQ2sM3dy
	 HQPNudcHuU9pKX74taI/mjpA7fkgR3Kg6ZQJRCwxlswwk9HgV2yEVUlg+b1Rn3jKKe
	 qbr/O6NYCz/wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56F48403AA;
	Tue, 29 Sep 2026 00:22:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EF293417
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBAB56075D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rZwpN-qeEEn0 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4AEE260767
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641343;
 b=eWXM3ZvZG2KFRiVh2SXdKPuIqof9fKnfnZL3IIbOtF5clHDMeMguDaZvD7TYggnUYhgM
 a+6DgDnVbh+fdbY82/gRom9mSMwPb58gygi1jjnSDrQrI5sPUX/on290qWXAmFuHy2Cq1
 4lRMKFVL8raV+rkz6l/FQcdaFqhdDhx0tKb04qmyxT+3CpeidmxhparJDr4Z2Q+7Tv0r+
 qeObtVepgT1aG4E0GEvLkn7GiTy2FiW1QZJ9lgOPbh+ffYx2opvh0YDV/MeWmk/+gCe/h
 1T9pR12UHtrJDguLhj3K8yrqximlyMuThMuGev66jYFQqv90Xvn+l4vWNEASNqZehJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641343;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=++OUM/1O4N4uWLejDztYIfnDLwIuTIvhg2qLIwWWHME=;
 b=IIG7x1SJC0rqz7MzA9lYh3viUZDGJULnuiv943caVUv0zhXTiuaUJsUcjgBnwqDEAglw
 4ghjdnA339zwQVWhN7+KMDBUJflxPqOcz4gLGEukizDuZvcJLzg0WBUMAZhYgy69JuzAT
 a+3KlC9KKlwDzdgw2AgzShtLb0gtSvFSYMxTiwVyaiuoHhKQmMsg3wNA2trVUbsCpjk+s
 XiXKnWiCa0Wvt35tzW+kq7MttWKbY2Hv0k2qwDRlBw9KOnlTtA+4Og//zj8kcvXFxDIKB
 nNUJI9t5Fm3vndUTtRBnu/Iino7VPUIbwzeFjVMWQXTRuCkY1Avi9IWG3CALty/4mfw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=e3lckTRm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=e3lckTRm
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4AEE260767
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:22 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-483c65c2fa7so2069775fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641342; x=1791246142;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=++OUM/1O4N4uWLejDztYIfnDLwIuTIvhg2qLIwWWHME=;
 b=e3lckTRmQdKk1Bv5+UEUZ6Vb5lSuWzzRg6dtZKLrJm8DKhRLXmj9Ki88J3sunwPyWe
 1yvg8krlWrSQPb4H/vGRexpsPV5bLI+mzeMAnKwFwJQfscHA4LFNWSkkXqxWAIeQP0bn
 rUecgLGDD0WJsMQ3ZOtPgaQFFbRvCUxsrhS8xgE/3GKpl5S1SUJPo1FVIYLnbCyc2oBm
 ycXc1XcCntDJE9bARpCg+ZY9mv0pXCDbmStFoOhZT3mNlTMkm4kYlwV4BAYhU11T3lR1
 xB3O5w9CWHA2rc72DJ+8y80r6G7FKo9sz4laEGmnusI9kaGALX0+X92Hb9riOYHZCvDj
 xPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641342; x=1791246142;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=++OUM/1O4N4uWLejDztYIfnDLwIuTIvhg2qLIwWWHME=;
 b=zNDJF3htHmiImMJQbl0sfPr5RPDUTnwcdz1mpgYu2MO/GuEoq1nMIIBjqesylZo9kV
 LweiEUCTuNNYv04EP+W3hMkXp6WtiUvq1/FEv7LoybkS9wqXDeTkxfL/9Lc6eGbbCQaY
 w/1hOLH+SBOYRD/zJUoKZbFUj+aCSXxdM7VKYdr6Jfw0W55Vki3p1lacHz2fonK5wRuX
 xQM96IvJjF/M+b0c3qtECmSms0lE7rrbBNV3PO5Gf5Udt/Lh6emu4QjTM6XVNb2vou28
 skIfYb8NIBxBmeJ3DbIZ5fWj/UXt7pVBSrF2O6MOGzBRYqXpQICoOe45dUIkIfoXcRf6
 ID2A==
X-Gm-Message-State: AFuF++mUoR/+nboGNwv5emWN0Z6wVNujDXHdvNKaVbw9UcxE26VZms2Z
 2H6pcqfrQj0hWx4cuRPjLoqJXbh1Ofz8kzqzvgUkILoSerNoequECX7n
X-Gm-Gg: AYBFou1YQ5JqbMi6ZjYyAAJKsw1YsnXEjl0LstcXC8HN1x25XZUOQbIco6aAAq9MKn0
 uYMffJAgOVWiw3Ok9xASvFehnaLvt9UfJpmP8/C9Nch1uDCG1amG3gr27GiR1o0L+MblvwBujAW
 hlCGGyaGJzO8wS3w6UC+9/OR3mt+1XWpBnjqdiZnLC0LDRTnYu+BqdSWARPYgD2Ws005N9vwEF0
 8Vo0Z5lnX6APj4ZdfautrNPDiesCdvL/XuaSAQYPMnKlnZRTt0guLxE/eaSAO2OxZ2KlIqGXCk6
 /uAYWRsGf0jQ3Jady0D/ubCg3DX9TN/Fm8wa/4B9jl8k/BM9yciFFn38s4bmCQ7xUnGGDXKsYHt
 GLwFD+MWbGlecqfgQqfZB5aP46LwVCQVgquOj/cGXLFuZG5nPgzbjzhGrpPPM7+e7xNbYzRdZKY
 /XdhuZdLuagX9zzzJkk6H1VVse40KtXUILS7f0z5B3DhOvr5F8ejCI9l44tnxzm8bgpB5YV/GBF
 8gty25mraucIucbJL+2cDN3+wi13dZTe39dgc/LGZ6oW2v7FhqXT1COEVgKHuk5NP3EtRg7fkz5
 DS9txA6VeJ8aQnDUgD7zS/NcNDdse8RbsfKIcUpO6/2cxWAaKYk7dthUorrspeeCaVMGE/p+Zg2
 ORI0ZV31qMbzTKAFhWOnk
X-Received: by 2002:a05:6871:8289:b0:486:a82a:a204 with SMTP id
 586e51a60fabf-491e9750977mr14086649fac.5.1790641340982; 
 Mon, 28 Sep 2026 17:22:20 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:53 -0600
Subject: [PATCH 16/20] net: lwip: retry DHCP acquisition using the network
 failure policy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-16-2060c7365b0c@gmail.com>
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

Distinguish an acquisition timeout from cancellation and local errors.
Retire the old DHCP client before invoking the exclusive-runtime
restart helper, reset per-attempt metadata, and preserve shared users
on restart rejection. Honor netretry, ethrotate and BOOTP_MAY_FAIL,
with fresh retry accounting for each command.

Use the first retry to remember the initial interface for wrap
detection instead of an unchanging net_restarted flag. Add sandbox
coverage for backoff bounds, request fields, invalid controls,
deadlines, NIC rotation, numeric retries, cancellation and
shared-runtime cleanup.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig                |   7 +-
 net/lwip/dhcp.c            |  52 +++++++--
 net/lwip/net-lwip.c        |   6 +-
 test/dm/Makefile           |   1 +
 test/dm/lwip_dhcp_policy.c | 286 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 334 insertions(+), 18 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index cf4dbb77fda..975b8374832 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2005,16 +2005,19 @@ config DHCP6_RAPID_COMMIT
 
 endif
 
+endif
+
 config BOOTP_MAY_FAIL
 	bool "Allow for the BOOTP/DHCP server to not be found"
-	depends on CMD_BOOTP
+	depends on CMD_BOOTP || CMD_DHCP
 	help
 	  If the DHCP server is not found after the configured retry count, the
 	  call will fail instead of starting over.  This can be used to fail
 	  over to Link-local IP address configuration if the DHCP server is not
 	  available.
 
-endif
+	  With lwIP, do not repeat the interface cycle once every interface
+	  has timed out, even with netretry=yes.
 
 config BOOTP_BOOTPATH
 	bool "Request & store 'rootpath' from BOOTP/DHCP server"
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 98f6864144b..8898fa4efd8 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -609,7 +609,7 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 			return CMD_RET_FAILURE;
 		if (ctrlc()) {
 			printf("Abort\n");
-			return CMD_RET_FAILURE;
+			return -EINTR;
 		}
 		if (IS_ENABLED(CONFIG_SERVERIP_FROM_PROXYDHCP) &&
 		    !bound && dhcp_supplied_address(net->netif))
@@ -631,7 +631,7 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 	}
 
 	if (!bound)
-		return CMD_RET_FAILURE;
+		return -ETIMEDOUT;
 
 	dhcp = netif_dhcp_data(net->netif);
 	if (options->have_proxy) {
@@ -686,6 +686,17 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 	return CMD_RET_SUCCESS;
 }
 
+static void dhcp_retire(struct net_lwip_ctx *net)
+{
+	if (!net->netif || !netif_dhcp_data(net->netif))
+		return;
+	if (dhcp_supplied_address(net->netif))
+		dhcp_stop_without_release(net->netif);
+	else
+		dhcp_release_and_stop(net->netif);
+	dhcp_cleanup(net->netif);
+}
+
 static int dhcp_nfs_autoload(struct cmd_tbl *cmdtp, int flag, int argc,
 			     char *const argv[])
 {
@@ -758,27 +769,44 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		free(options);
 		return CMD_RET_FAILURE;
 	}
-	options->netif = net.netif;
+	net_try_count = 1;
+	net_restart_wrap = 0;
 	active_options = options;
 
-	ret = dhcp_loop(&net, !!filename, options);
+	for (;;) {
+		options->netif = net.netif;
+		options->have_offer = false;
+		options->have_proxy = false;
+		memset(&options->reply, 0, sizeof(options->reply));
+		if (CONFIG_IS_ENABLED(EFI_LOADER)) {
+			options->efi->ack_len = 0;
+			options->efi->proxy_len = 0;
+		}
+		ret = dhcp_loop(&net, !!filename, options);
+		if (ret != -ETIMEDOUT)
+			break;
+		dhcp_retire(&net);
+		if (IS_ENABLED(CONFIG_BOOTP_MAY_FAIL) &&
+		    (env_get_yesno("ethrotate") == 0 || net_restart_wrap))
+			break;
+		/* Other runtime clients must not lose their interface on retry. */
+		ret = net_lwip_restart(&net);
+		if (ret || (IS_ENABLED(CONFIG_BOOTP_MAY_FAIL) && net_restart_wrap)) {
+			ret = CMD_RET_FAILURE;
+			break;
+		}
+	}
 	/*
 	 * A download needs strict addressing, incompatible with DHCP's
 	 * address-less runtime attachment. Retire DHCP before handing off.
 	 */
-	if (net.netif) {
-		if (dhcp_supplied_address(net.netif))
-			dhcp_stop_without_release(net.netif);
-		else
-			dhcp_release_and_stop(net.netif);
-		dhcp_cleanup(net.netif);
-	}
+	dhcp_retire(&net);
 	active_options = NULL;
 	free(options);
 	net_lwip_stop(&net);
 
 	if (ret)
-		return ret;
+		return CMD_RET_FAILURE;
 	autoload = env_get("autoload");
 	if (autoload && !strcmp(autoload, "NFS")) {
 		if (IS_ENABLED(CONFIG_CMD_NFS))
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index eb9eebadaa1..4319f4441e8 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -30,7 +30,6 @@
 void (*push_packet)(void *, int len) = 0;
 #endif
 int net_try_count;
-static int net_restarted;
 int net_restart_wrap;
 static struct {
 	struct udevice *dev;
@@ -753,11 +752,10 @@ int net_start_again(void)
 		return -ETIMEDOUT;
 	}
 
-	net_try_count++;
-
 	eth_halt();
 #if !defined(CONFIG_NET_DO_NOT_TRY_ANOTHER)
-	eth_try_another(!net_restarted);
+	eth_try_another(net_try_count == 1);
 #endif
+	net_try_count++;
 	return eth_init();
 }
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 00e2e52af59..564980c122c 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -55,6 +55,7 @@ endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_DHCP),yy)
 obj-y += lwip_dhcp.o
 obj-y += lwip_dhcp_options.o
+obj-y += lwip_dhcp_policy.o
 endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_NETCONSOLE),yy)
 obj-y += netconsole.o
diff --git a/test/dm/lwip_dhcp_policy.c b/test/dm/lwip_dhcp_policy.c
new file mode 100644
index 00000000000..d60bebcd86b
--- /dev/null
+++ b/test/dm/lwip_dhcp_policy.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#include <command.h>
+#include <console.h>
+#include <dm.h>
+#include <env.h>
+#include <lwip-dhcp.h>
+#include <malloc.h>
+#include <net.h>
+#include <time.h>
+#include <asm/eth.h>
+#include <dm/test.h>
+#include <lwip/dhcp.h>
+#include <lwip/prot/dhcp.h>
+#include <lwip/timeouts.h>
+#include <test/ut.h>
+
+struct dhcp_policy_test {
+	unsigned int packets;
+	unsigned int first_packets;
+	unsigned int bind_after;
+	bool fail_first;
+	bool cancel;
+	bool ticking;
+	u16 secs;
+	u32 initial;
+	u32 second;
+	u32 maximum;
+	char file[DHCP_FILE_LEN];
+};
+
+static void dhcp_policy_tick(void *arg)
+{
+	struct dhcp_policy_test *test = arg;
+
+	if (!test->ticking)
+		return;
+	timer_test_add_offset(500);
+	sys_timeout(1, dhcp_policy_tick, test);
+}
+
+static int dhcp_policy_tx(struct udevice *dev, void *packet, unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct dhcp_policy_test *test = priv->priv;
+	struct ethernet_hdr *eth = packet;
+	struct ip_udp_hdr *ip;
+	struct dhcp_msg *msg;
+	struct dhcp *dhcp;
+
+	if (len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + DHCP_OPTIONS_OFS ||
+	    ntohs(eth->et_protlen) != PROT_IP)
+		return 0;
+	ip = (void *)(eth + 1);
+	if (ip->ip_p != IPPROTO_UDP || ntohs(ip->udp_dst) != 67)
+		return 0;
+	msg = (void *)(ip + 1);
+	test->packets++;
+	if (!dev_seq(dev))
+		test->first_packets++;
+	test->secs = ntohs(msg->secs);
+	memcpy(test->file, msg->file, sizeof(test->file));
+	test->initial = net_lwip_dhcp_timeout(1);
+	test->second = net_lwip_dhcp_timeout(2);
+	test->maximum = net_lwip_dhcp_timeout(255);
+	if (test->cancel) {
+		console_in_puts("\x03");
+		return 0;
+	}
+	if ((test->fail_first && !dev_seq(dev)) || !test->bind_after) {
+		timer_test_add_offset(4000);
+		return 0;
+	}
+	if (test->packets < test->bind_after)
+		return 0;
+	/* Exercise command policy, independently of the wire parser fixtures. */
+	dhcp = netif_dhcp_data(netif_default);
+	ip4addr_aton("1.1.2.3", &dhcp->offered_ip_addr);
+	ip4addr_aton("255.255.255.0", &dhcp->offered_sn_mask);
+	ip4addr_aton("1.1.2.2", &dhcp->server_ip_addr);
+	netif_set_addr(netif_default, &dhcp->offered_ip_addr,
+		       &dhcp->offered_sn_mask, &dhcp->offered_gw_addr);
+	dhcp->state = DHCP_STATE_BOUND;
+
+	return 0;
+}
+
+static int dhcp_policy_check(struct unit_test_state *uts, struct dhcp_policy_test *test)
+{
+	static const struct {
+		const char *name;
+		const char *value;
+	} controls[] = {
+		{ "bootpretryperiod", "3000" },
+		{ "bootpretransmitperiodinit", "500" },
+		{ "bootpretransmitperiodmax", "2000" },
+	};
+	static const char * const invalid[] = {
+		"-1", "junk", "0x100", "99999999999999999999999999",
+		/* Values which strict_strtoul() would wrap to zero or 500. */
+		sizeof(ulong) == 4 ? "4294967296" : "18446744073709551616",
+		sizeof(ulong) == 4 ? "4294967796" : "18446744073709552116",
+	};
+	static const char * const invalid_interval[] = { "0", "32767501", "4294967796" };
+	struct net_lwip_ctx other = {};
+	char * const argv[] = { "dhcp" };
+	char name[256];
+	char max_timeout[32];
+	unsigned int i, j;
+	ulong start;
+	int ret;
+
+	ut_assertok(env_set("autoload", "no"));
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("ethrotate", "no"));
+	ut_assertok(env_set("netretry", "no"));
+	ut_assertok(env_set("bootpretryperiod", "3000"));
+	ut_assertok(env_set("bootpretransmitperiodinit", "500"));
+	ut_assertok(env_set("bootpretransmitperiodmax", "2000"));
+	memset(name, 'x', sizeof(name) - 1);
+	name[sizeof(name) - 1] = 0;
+	ut_assertok(env_set("bootfile", name));
+	*test = (struct dhcp_policy_test){ .bind_after = 3, .ticking = true };
+	sys_timeout(1, dhcp_policy_tick, test);
+	ret = do_dhcp(NULL, 0, 1, argv);
+	test->ticking = false;
+	sys_untimeout(dhcp_policy_tick, test);
+	ut_assertok(ret);
+	ut_asserteq(3, test->packets);
+	ut_assert(test->secs >= 1);
+	ut_asserteq(500, test->initial);
+	ut_assert(test->second >= 900 && test->second <= 1099);
+	ut_assert(test->maximum >= 1800 && test->maximum <= 2000);
+	ut_asserteq(127, strlen(test->file));
+	ut_asserteq_str(name, env_get("bootfile"));
+	ut_assertnull(netif_default);
+
+	/* Invalid timing cannot send even one packet. */
+	for (i = 0; i < ARRAY_SIZE(controls); i++) {
+		for (j = 0; j < ARRAY_SIZE(invalid); j++) {
+			*test = (struct dhcp_policy_test){ .bind_after = 1 };
+			ut_assertok(env_set(controls[i].name, invalid[j]));
+			ut_asserteq(CMD_RET_FAILURE, do_dhcp(NULL, 0, 1, argv));
+			ut_asserteq(0, test->packets);
+			ut_assertnull(netif_default);
+		}
+		ut_assertok(env_set(controls[i].name, controls[i].value));
+	}
+	for (i = 1; i < ARRAY_SIZE(controls); i++) {
+		for (j = 0; j < ARRAY_SIZE(invalid_interval); j++) {
+			*test = (struct dhcp_policy_test){ .bind_after = 1 };
+			ut_assertok(env_set(controls[i].name, invalid_interval[j]));
+			ut_asserteq(CMD_RET_FAILURE, do_dhcp(NULL, 0, 1, argv));
+			ut_asserteq(0, test->packets);
+			ut_assertnull(netif_default);
+		}
+		ut_assertok(env_set(controls[i].name, controls[i].value));
+	}
+	/* The acquisition deadline retains the full native unsigned-long range. */
+	snprintf(max_timeout, sizeof(max_timeout), "%lu", ULONG_MAX);
+	ut_assertok(env_set("bootpretryperiod", max_timeout));
+	*test = (struct dhcp_policy_test){ .bind_after = 1 };
+	ut_assertok(do_dhcp(NULL, 0, 1, argv));
+	ut_assertok(env_set("bootpretryperiod", "3000"));
+	ut_assertok(env_set("bootpretransmitperiodinit", "32767500"));
+	ut_assertok(env_set("bootpretransmitperiodmax", "32767500"));
+	*test = (struct dhcp_policy_test){ .bind_after = 1 };
+	ut_assertok(do_dhcp(NULL, 0, 1, argv));
+	ut_asserteq(32767500, test->initial);
+	ut_assert(test->maximum <= 32767500);
+	ut_assertok(env_set("bootpretransmitperiodmax", "5000"));
+	*test = (struct dhcp_policy_test){ .bind_after = 1 };
+	ut_assertok(do_dhcp(NULL, 0, 1, argv));
+	ut_asserteq(5000, test->initial);
+	ut_assertok(env_set("bootpretransmitperiodinit", "5000"));
+	ut_assertok(env_set("bootfile", "default.bin"));
+
+	/* no/unset never rotate; once permits one retry, also on the next command. */
+	for (i = 0; i < 2; i++) {
+		ut_assertok(env_set("netretry", i ? NULL : "no"));
+		ut_assertok(env_set("ethrotate", NULL));
+		*test = (struct dhcp_policy_test){ .fail_first = true, .bind_after = 1 };
+		ut_asserteq(CMD_RET_FAILURE, do_dhcp(NULL, 0, 1, argv));
+		ut_asserteq(1, test->packets);
+		ut_assertnull(netif_default);
+	}
+	for (i = 0; i < 2; i++) {
+		ut_assertok(env_set("ethact", "eth@10002000"));
+		ut_assertok(env_set("netretry", i ? "1" : "once"));
+		*test = (struct dhcp_policy_test){ .fail_first = true, .bind_after = 1 };
+		ut_assertok(do_dhcp(NULL, 0, 1, argv));
+		ut_asserteq(1, test->first_packets);
+		ut_asserteq(2, test->packets);
+		ut_asserteq_str("eth@10003000", env_get("ethact"));
+		ut_assertnull(netif_default);
+	}
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("netretry", "2"));
+	ut_assertok(env_set("ethrotate", "no"));
+	*test = (struct dhcp_policy_test){};
+	ut_asserteq(CMD_RET_FAILURE, do_dhcp(NULL, 0, 1, argv));
+	ut_asserteq(IS_ENABLED(CONFIG_BOOTP_MAY_FAIL) ? 1 : 3, test->packets);
+
+	/* Neither an interrupt nor another runtime user permits a retry. */
+	ut_assertok(env_set("netretry", "yes"));
+	*test = (struct dhcp_policy_test){ .cancel = true };
+	ut_asserteq(CMD_RET_FAILURE, do_dhcp(NULL, 0, 1, argv));
+	clear_ctrlc();
+	ut_asserteq(1, test->packets);
+	ut_assertok(env_set("ethrotate", NULL));
+	ut_assertok(net_lwip_start(&other, NET_LWIP_ADDR_ENV_FLEXIBLE));
+	*test = (struct dhcp_policy_test){};
+	ret = do_dhcp(NULL, 0, 1, argv);
+	i = other.netif == netif_default && !netif_dhcp_data(other.netif);
+	net_lwip_stop(&other);
+	ut_asserteq(CMD_RET_FAILURE, ret);
+	ut_assert(i);
+	ut_asserteq(1, test->packets);
+	ut_assertnull(netif_default);
+
+	ut_assertok(env_set("netretry", "no"));
+	ut_assertok(env_set("bootpretryperiod", "0"));
+	*test = (struct dhcp_policy_test){ .bind_after = 2 };
+	start = get_timer(0);
+	ut_asserteq(CMD_RET_FAILURE, do_dhcp(NULL, 0, 1, argv));
+	ut_assert(get_timer(start) < 500);
+	ut_asserteq(1, test->packets);
+
+	return 0;
+}
+
+static int dm_test_lwip_dhcp_policy(struct unit_test_state *uts)
+{
+	static const char * const vars[] = {
+		"ethact", "ethrotate", "netretry", "autoload", "bootfile",
+		"bootpretryperiod", "bootpretransmitperiodinit", "bootpretransmitperiodmax",
+		"ipaddr", "netmask", "gatewayip", "ipaddr5", "netmask5", "gatewayip5",
+		"serverip", "tftpserverip", "dnsip", "dnsip2",
+	};
+	struct dhcp_policy_test test = {};
+	char *saved[ARRAY_SIZE(vars)] = {};
+	char file[sizeof(net_boot_file_name)];
+	char *config = pxelinux_configfile;
+	u32 size = net_boot_file_expected_size_in_blocks;
+	int i, ret = -ENOMEM, ctrlc_state;
+
+	for (i = 0; i < ARRAY_SIZE(vars); i++) {
+		const char *value = env_get(vars[i]);
+
+		if (value) {
+			saved[i] = strdup(value);
+			if (!saved[i])
+				goto out;
+		}
+	}
+	memcpy(file, net_boot_file_name, sizeof(file));
+	pxelinux_configfile = NULL;
+	ctrlc_state = disable_ctrlc(0);
+	sandbox_eth_set_tx_handler(0, dhcp_policy_tx);
+	sandbox_eth_set_tx_handler(1, dhcp_policy_tx);
+	sandbox_eth_set_priv(0, &test);
+	sandbox_eth_set_priv(1, &test);
+	ret = dhcp_policy_check(uts, &test);
+	sys_untimeout(dhcp_policy_tick, &test);
+	clear_ctrlc();
+	disable_ctrlc(ctrlc_state);
+	sandbox_eth_set_tx_handler(0, NULL);
+	sandbox_eth_set_tx_handler(1, NULL);
+	sandbox_eth_set_priv(0, NULL);
+	sandbox_eth_set_priv(1, NULL);
+	memcpy(net_boot_file_name, file, sizeof(file));
+	net_boot_file_expected_size_in_blocks = size;
+	free(pxelinux_configfile);
+	pxelinux_configfile = config;
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		if (env_set(vars[i], saved[i]))
+			ret = -EINVAL;
+out:
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		free(saved[i]);
+
+	return ret;
+}
+
+DM_TEST(dm_test_lwip_dhcp_policy, UTF_SCAN_FDT | UTF_CONSOLE);

-- 
2.53.0

