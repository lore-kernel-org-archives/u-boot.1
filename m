Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BA8CA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 770A260757;
	Tue, 29 Sep 2026 00:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GqiA-_elpku9; Tue, 29 Sep 2026 00:22:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3640D60722
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641334;
	b=efpYeb6PuJpLyaP7Khyf33/KReeGBR9C3VI1JrpyurAsABYmUxELbB8QkvPQS2MRBJpv
	 ju9QqUlcNc0Xr8XEdbGi8pJcx40IJvZO+HHx2fnuF5itHreXEqydHmU4WTZjftqNYuaUo
	 oix9zfjsnL28dRmpqhjRi8SfDo+C3fRja3XLrQePfHnp5hmLo3dcmcgv4pJEHMcheZ/im
	 JtIcsd5/JS5G/m5nj9B0jRTdkF9/SIv/2ww809TNW3iufky2ObkupwqWGJagV31UZQamX
	 766g9P+yTQZAU92JTDM57PLOeF4Lwgh7rSCJuJN9bQMVrjHV5WoXqK5ec4fNk+7QGWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641334;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5QqdFWqKmsd41z1Aeja4v4GRMtY7rHYX6mY4I0045Z0=;
	b=INuPhUciEYGj7hkb8LnqNLXHGzionWRhLTpcDmx/C0tpdk6Jo519feNbpNFUvpIdl7Tq
	 Saa+stzmFxZNnxFwySGTFwyqZ8RvLPSxmWWAe6cQQNC4uX9MEln2Jn0zuneoL0kgrgsnM
	 DiRwJzNKO3dImWPzSbRfObIIbbNyONeZgx/67JiHqeZRXjNdGI41ZoZTelxj0e44O83YM
	 dGrYoqL/hdof8H8hClOxRVc8r8RTV7CrcH6WKm3J3lWipQi0sOlWagcxO8vOhGRzdiW2V
	 6OQOP7cSFWXG7y0KO0FtSKQgU2qAsNtcbUVHjkIK52uWEhn1y0UOzqedWuipfxjS/Hg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641334;
	bh=5QqdFWqKmsd41z1Aeja4v4GRMtY7rHYX6mY4I0045Z0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DtCNmiE6SqLVMiHfn1gdQiSDi3PdQZLLBoLXdjVB6iHu6GF25YbdAqNewFZxn5So8
	 mlBdhfX+hZCFO7M7zYu5guKa2URJZ+mlX8ffg9/44Hks3awalUf6Gio13RF6wQk7n0
	 sZWMa3vyXUJF3bB7v+VozACoHsS/X1GBKCtVZD2nVa+tYipWfjNb2fdLjZGvpTWTX3
	 w9uQxtZBxFsCb4W8LZYfZeZKPwtqQImllm9z3NCLSqfq3pHvMv3RaJ0EgqPb490iWL
	 Sz81nOgxCgaPORQ0ENv+6ecH18/kv94cUgowde7hZFS6x5gktBydpIK8be86RRYvf8
	 VR0XGNfcq1NLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3640D60722;
	Tue, 29 Sep 2026 00:22:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D56E1335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE25C4057E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zxZ7PWMR-tYh for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 84D8A40580
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641327;
 b=LgAF/7pq0ydnH8PK7Qb5h7J594DsP4M3cjNPosy0ibXXVGJ4e2Pgcn/ds6vxjEiFLqr7
 RB+1UjsDJnDZ3HgW9QWa7U4lz8YN8WE614GdgQyjVr2nJ+V1GVUTPDCboaJSKJzIz/589
 Z5kWD9LTq1T554oTLQUkawFB3hsCWFojn/3a6Zx2G+YPtMdnyIZrEwN1P+ScW1kHmCgsY
 E3+6BIg6MXYfXV2OvcNFEAzMm9n2+AKsmiyNygiBwwsQtRWPShnCL7QShI8wfhxoOcN58
 rfZenBkPZ7XzcNSIIIIrNZKi9RpfilhL63QITVVPjXXyqvnzk93OStpyElqf8MVilRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641327;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=5QqdFWqKmsd41z1Aeja4v4GRMtY7rHYX6mY4I0045Z0=;
 b=Iffst2QAv4ykAftqRsxoxqNxSA+ySAxyRkNJR2MpdcB5YPa3s0MWtoN/J8dUv26gF7cV
 ftHLiNFpJiVuX8/XiJ9k4eYKKi9IvyhUeWPF7V/7ac1dKmt25A/jCwhJBcXxaUGgWdxaT
 iqiGhMF4kPRKm4KEkMGZsfGo6Yxy4VFNGv+l5J3SE9VGi63K7V5kb3wMgfbpX+8xxN52z
 QDvjN+PUPCcOgBEXXDSXKejLYmr+voQTAwY4Ldqwxh2qlJ4A7XPlcdFLMmuvjDCLbynWA
 pdgYQBLAM3UtvqeFGhQOm76aZukXGqNuwpUVoP7VBBOj3k235wkIISSilBavcxO0zng==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZIxzLauB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZIxzLauB
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84D8A40580
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:07 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-46ac6e5d8f7so1701885fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641326; x=1791246126;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5QqdFWqKmsd41z1Aeja4v4GRMtY7rHYX6mY4I0045Z0=;
 b=ZIxzLauBp6etlf7UcaAowgj9wFy/j7b8e6vi5blw7PpMoHuMxU5ktvnNCQNf5bR44N
 hbt34P1SfftNPM8djSdEKrU4d9WOATwce7nCkaX4YsmBjQEHelcNQXSk0vUZW0JwV5Ma
 igcST7//nEX3vaVPkJIWVXG36ZT9n8LQQ5d59JlK9ai04yubwjOD4+BVtxTDD9tiDhfQ
 E0DWvvQ1/5AKUDyQxezkcfecCyRbci8AwG9Gjnl9aOZoE9/PiHM/bYWCieF01QKPRcgA
 QHeLoAiXWiWQQg2xfo8jZGmLmopgSe/ATPofoA9kM67QR487SglVvKbW5ROg+hSk+D92
 fxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641326; x=1791246126;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5QqdFWqKmsd41z1Aeja4v4GRMtY7rHYX6mY4I0045Z0=;
 b=dPrQ9MvLLaukaB3PQ8Qml4rw/WHHqkMbbMQ/euZC49dyHz2KIesuA3R78o4PWiYxff
 npB8O1qZoRIC006uloBo5RO6uk9sFHwsX5J2G3KLNI/iKKqSzVkQG5wKCJYLs0ZHx2bt
 boRDunckxbaWUrMqhU3Fm7zJMBb0IaYfyQ/B42SiQyOYftsbsjd/n6vsa1JkkTp/heCV
 U0V+CPd31wShhZsGXHnh9pp12IjIhVIwFnf5SIoeOa9vCDDn6oP9OWyjb1FdRnRZSrbX
 OlA5zHvEGK7oDtA28Rlkik5j1blpPRe7QDmR3RJI9f0bhocjAmEgWiDZKZtCWvYOwzKl
 EZYg==
X-Gm-Message-State: AFuF++nzpv02YumfBmECtCqeMTjG3crMF5lA5ndd1Mku1g4+NpvOhipP
 bhbwgJcdToBJe2TVy94jynZG2hrZE6fAt3IMRRD2IH2y0RZE6/XRz13+
X-Gm-Gg: AYBFou0vodXunVjXvwzP34NRLAunBAaNiBciFzVtpXQJPoBOAAssxO13egyTmjE1OF/
 Zj19RsslPSb2vg00bzpwIOVY589+P7M0i4EZu1GIk9JtweFC4qYAKfAs5ndgoKBPcb5XTl9bOHv
 oWS2TZPz6HpJiiuzLOapzo3XTZnBDXEpFjez0EKSBKe9I/FCEJs9eVgm6Yz8ML70vrvYmI1rZsu
 h2NMcEjABDbhSIMCM7DxcZfMom4fxhSBQ1qypmUhNTPZRVaghwMLgS1HfaMMzPoUhcIOApVkH+B
 NbbjQdKqky0jEqfUusR/DfINfVv2aTUoxoSYG+LeH9iI+iFcgR1CihP60T806vWCMQa0BvM9amj
 N7hJdHc7YagMZg11bU9ZQ/BP06T85xXlzpz8lFjAYTgEl9d4we7bo2v+nUDsPLMGTXDA3BcOgst
 DkV/gFMOfrrLnVBM/HYIDKjaxG4ttWDlN12q1MyUBrSLLjUkWhCOVloRyC7lmK+4JD+VXiFZlqV
 pS3iv6sc+cPnsqawEYngSdEFnwoKgIKUIIYHIA5m/1v7W1nT8TSJfPhLzKHCFEFgELjAqUkIebB
 aZL1uFWmgBrmF0JEl1Fndpj/YAbj6bKA8DdCBJ6EHati2SvWLkW053ylTAqcn0maz3QsPiNQTkx
 f5IcAwPyW1e3sF2ZuAUrO
X-Received: by 2002:a05:6870:a094:b0:48f:e137:dc81 with SMTP id
 586e51a60fabf-49358a38c43mr10436399fac.58.1790641325174; 
 Mon, 28 Sep 2026 17:22:05 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:45 -0600
Subject: [PATCH 08/20] net: lwip: export DHCP DNS settings without a resolver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-8-2060c7365b0c@gmail.com>
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

Expose the remaining DNS, router, subnet and default-autoload controls
to both stacks. Keep the legacy defaults and preserve two-server export
by default for lwIP.

Build the DHCP parameter request list from the configured controls.
Parse and stage DNS with boot metadata rather than reading the resolver
cache; this also works when the resolver is omitted. Validate
fragmented address lists before acceptance, bound the exported
addresses, and update an enabled resolver from those same values. Test
requests, two-server export, overloaded fragments, invalid lists and
absent options.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig                 | 20 +++++++++-----------
 lib/lwip/u-boot/lwipopts.h  | 18 +++++++++++++++---
 net/lwip/dhcp.c             | 32 ++++++++++++++++++++++++--------
 test/dm/lwip_dhcp_options.c | 28 ++++++++++++++++++++++++----
 4 files changed, 72 insertions(+), 26 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 0da16a4a343..69451cabc86 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2030,12 +2030,10 @@ config BOOTP_BOOTFILESIZE
 	help
 	  Save the expected file size in 512-byte blocks for download progress.
 
-if NET_LEGACY
-
 config BOOTP_DNS
 	bool "Request & store 'dnsip' from BOOTP/DHCP server"
 	default y
-	depends on CMD_BOOTP
+	depends on CMD_BOOTP || CMD_DHCP
 	help
 	  The primary DNS server is stored as 'dnsip'. If two servers are
 	  returned, you must set BOOTP_DNS2 to store that second server IP
@@ -2043,6 +2041,7 @@ config BOOTP_DNS
 
 config BOOTP_DNS2
 	bool "Store 'dnsip2' from BOOTP/DHCP server"
+	default y if NET_LWIP
 	depends on BOOTP_DNS
 	help
 	  If a DHCP client requests the DNS server IP from a DHCP server,
@@ -2055,9 +2054,7 @@ config BOOTP_DNS2
 config BOOTP_GATEWAY
 	bool "Request & store 'gatewayip' from BOOTP/DHCP server"
 	default y
-	depends on CMD_BOOTP
-
-endif
+	depends on CMD_BOOTP || CMD_DHCP
 
 config BOOTP_HOSTNAME
 	bool "Request & store 'hostname' from BOOTP/DHCP server"
@@ -2066,10 +2063,9 @@ config BOOTP_HOSTNAME
 	help
 	  The name may or may not be qualified with the local domain name.
 
-if NET_LEGACY
-
 config BOOTP_PREFER_SERVERIP
 	bool "serverip variable takes precedent over DHCP server IP."
+	depends on NET_LEGACY
 	depends on CMD_BOOTP
 	help
 	  By default a BOOTP/DHCP reply will overwrite the 'serverip' variable.
@@ -2081,9 +2077,7 @@ config BOOTP_PREFER_SERVERIP
 config BOOTP_SUBNETMASK
 	bool "Request & store 'netmask' from BOOTP/DHCP server"
 	default y
-	depends on CMD_BOOTP
-
-endif
+	depends on CMD_BOOTP || CMD_DHCP
 
 config BOOTP_NISDOMAIN
 	bool "Request & store 'domain' from BOOTP/DHCP server"
@@ -2177,6 +2171,8 @@ config CMD_RARP
 	help
 	  Boot image via network using RARP/TFTP protocol
 
+endif
+
 config SYS_DISABLE_AUTOLOAD
 	bool "Disable automatically loading files over the network"
 	depends on CMD_BOOTP || CMD_DHCP || CMD_NFS || CMD_RARP
@@ -2186,6 +2182,8 @@ config SYS_DISABLE_AUTOLOAD
 	  is complete.  Enable this option to disable this behavior and instead
 	  require files to be loaded over the network by subsequent commands.
 
+if NET_LEGACY
+
 config CMD_PING6
 	bool "ping6"
 	depends on IPV6
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index 90519e66120..e49475d2e0f 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -133,7 +133,19 @@
 #define DHCP_OPTIONS_LEN		640
 /* Stage NTP after concatenating fragments, not in the core option parser. */
 #define LWIP_DHCP_GET_NTP_SRV	0
-#ifdef CONFIG_PROT_DNS_LWIP
+/* Stage DNS with the accepted boot options, independently of the resolver. */
+#define LWIP_DHCP_MAX_DNS_SERVERS	0
+#ifdef CONFIG_BOOTP_SUBNETMASK
+#define UBOOT_DHCP_SUBNET		1,
+#else
+#define UBOOT_DHCP_SUBNET
+#endif
+#ifdef CONFIG_BOOTP_GATEWAY
+#define UBOOT_DHCP_GATEWAY	3,
+#else
+#define UBOOT_DHCP_GATEWAY
+#endif
+#ifdef CONFIG_BOOTP_DNS
 #define UBOOT_DHCP_DNS		6,
 #else
 #define UBOOT_DHCP_DNS
@@ -168,8 +180,8 @@
 #else
 #define UBOOT_DHCP_TIMEOFFSET
 #endif
-#define DHCP_REQUEST_OPTIONS	1, 3, 28, UBOOT_DHCP_DNS UBOOT_DHCP_NTP \
-	UBOOT_DHCP_HOSTNAME \
+#define DHCP_REQUEST_OPTIONS	UBOOT_DHCP_SUBNET UBOOT_DHCP_GATEWAY \
+	UBOOT_DHCP_DNS UBOOT_DHCP_NTP UBOOT_DHCP_HOSTNAME \
 	UBOOT_DHCP_FILESIZE UBOOT_DHCP_ROOTPATH UBOOT_DHCP_DOMAIN \
 	UBOOT_DHCP_TIMEOFFSET 67
 #endif /* CONFIG_CMD_DHCP */
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 2e0bf839b22..570b21f278d 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -28,6 +28,8 @@ struct dhcp_boot_data {
 	u8 file_size[2];
 	u8 time_offset[4];
 	ip4_addr_t ntp;
+	ip4_addr_t dns[2];
+	u8 dns_count;
 	bool have_size;
 	bool have_offset;
 	bool have_ntp;
@@ -93,7 +95,8 @@ static int dhcp_boot_options(struct pbuf *p, unsigned int pos, unsigned int end,
 			 * For the NTP list retain only the first address, but validate
 			 * the length of the entire list below.
 			 */
-			if (code != DHCP_OPTION_NTP && len > opt->size - opt->len)
+			if (code != DHCP_OPTION_NTP && code != DHCP_OPTION_DNS_SERVER &&
+			    len > opt->size - opt->len)
 				return -E2BIG;
 			copy = min_t(size_t, len, opt->size - min(opt->len, opt->size));
 			if (copy && pbuf_copy_partial(p, (u8 *)opt->data + opt->len,
@@ -124,6 +127,7 @@ static err_t dhcp_parse_boot_data(struct pbuf *p, struct dhcp_boot_data *data)
 		  data->time_offset, sizeof(data->time_offset) },
 		{ 42, IS_ENABLED(CONFIG_BOOTP_NTPSERVER), false,
 		  &data->ntp, sizeof(data->ntp) },
+		{ 6, IS_ENABLED(CONFIG_BOOTP_DNS), false, data->dns, sizeof(data->dns) },
 	};
 	u8 overload = 0;
 	u32 cookie;
@@ -156,10 +160,14 @@ static err_t dhcp_parse_boot_data(struct pbuf *p, struct dhcp_boot_data *data)
 			if (memchr(str, 0, opt->len))
 				return ERR_VAL;
 			str[opt->len] = 0;
-		} else if (opt->code == DHCP_OPTION_NTP) {
+		} else if (opt->code == DHCP_OPTION_NTP || opt->code == DHCP_OPTION_DNS_SERVER) {
 			if (opt->len % sizeof(ip4_addr_t))
 				return ERR_VAL;
-			data->have_ntp = !ip4_addr_isany(&data->ntp);
+			if (opt->code == DHCP_OPTION_NTP)
+				data->have_ntp = !ip4_addr_isany(&data->ntp);
+			else
+				data->dns_count = min_t(size_t, opt->len / sizeof(ip4_addr_t),
+							IS_ENABLED(CONFIG_BOOTP_DNS2) ? 2 : 1);
 		} else {
 			if (opt->len != opt->size)
 				return ERR_VAL;
@@ -230,6 +238,19 @@ void net_lwip_dhcp_append(struct netif *netif, struct dhcp *dhcp, u8_t state,
 static int dhcp_boot_env(struct dhcp_boot_data *data)
 {
 	char offset[12];
+	unsigned int i;
+#if LWIP_DNS
+	ip_addr_t addr;
+#endif
+
+	for (i = 0; i < data->dns_count; i++) {
+		if (env_set(i ? "dnsip2" : "dnsip", ip4addr_ntoa(&data->dns[i])))
+			return CMD_RET_FAILURE;
+#if LWIP_DNS
+		ip_addr_copy_from_ip4(addr, data->dns[i]);
+		dns_setserver(i, &addr);
+#endif
+	}
 
 	if ((data->hostname[0] && env_set("hostname", data->hostname)) ||
 	    (data->rootpath[0] && env_set("rootpath", data->rootpath)) ||
@@ -317,11 +338,6 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 		    NULL : ip4addr_ntoa(&dhcp->offered_si_addr)))
 		return CMD_RET_FAILURE;
 
-#ifdef CONFIG_PROT_DNS_LWIP
-	if (env_set("dnsip", ip4addr_ntoa(dns_getserver(0))) ||
-	    env_set("dnsip2", ip4addr_ntoa(dns_getserver(1))))
-		return CMD_RET_FAILURE;
-#endif
 	if (dhcp_boot_env(&options->reply))
 		return CMD_RET_FAILURE;
 
diff --git a/test/dm/lwip_dhcp_options.c b/test/dm/lwip_dhcp_options.c
index eeb273da964..a584c9bb19f 100644
--- a/test/dm/lwip_dhcp_options.c
+++ b/test/dm/lwip_dhcp_options.c
@@ -26,6 +26,7 @@ enum dhcp_reply_kind {
 	DHCP_REPLY_ZERO_OFFSET,
 	DHCP_REPLY_BAD_NTP,
 	DHCP_REPLY_ROOT_OVERFLOW,
+	DHCP_REPLY_BAD_DNS,
 };
 
 struct dhcp_options_test {
@@ -44,7 +45,9 @@ static bool dhcp_options_chain_check(struct dhcp_msg *reply, size_t len,
 	static const unsigned int splits[] = { DHCP_FILE_OFS + 4, DHCP_OPTIONS_OFS + 3 };
 	err_t expected = kind == DHCP_REPLY_BAD_STRING || kind == DHCP_REPLY_TRUNCATED ||
 		kind == DHCP_REPLY_BAD_SIZE || kind == DHCP_REPLY_BAD_NTP ||
-		kind == DHCP_REPLY_ROOT_OVERFLOW ? ERR_VAL : ERR_OK;
+		kind == DHCP_REPLY_ROOT_OVERFLOW ||
+		kind == DHCP_REPLY_BAD_DNS ?
+		ERR_VAL : ERR_OK;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(splits); i++) {
@@ -96,6 +99,7 @@ static int dhcp_options_reply(struct udevice *dev, struct dhcp_msg *request,
 	static const u8 size[] = { 0, 42 };
 	static const u8 offset[] = { 0xff, 0xff, 0xf1, 0xf0 };
 	static const u8 ntp[] = { 10, 0, 0, 1, 10, 0, 0, 2 };
+	static const u8 dns[] = { 8, 8, 8, 8, 9, 9, 9, 9, 10, 10, 10, 10 };
 	struct ethernet_hdr *eth;
 	struct ip_udp_hdr *ip;
 	struct dhcp_msg *reply;
@@ -134,6 +138,7 @@ static int dhcp_options_reply(struct udevice *dev, struct dhcp_msg *request,
 		pos = dhcp_test_option(pos, 13, size, sizeof(size));
 		pos = dhcp_test_option(pos, 2, offset, sizeof(offset));
 		pos = dhcp_test_option(pos, 42, ntp, sizeof(ntp));
+		pos = dhcp_test_option(pos, 6, dns, sizeof(dns));
 		/* A trailing NUL is legal and must not become part of the path. */
 		pos = dhcp_test_option(pos, 67, "option.bin", sizeof("option.bin"));
 	} else if (kind == DHCP_REPLY_OVERLOAD) {
@@ -142,9 +147,11 @@ static int dhcp_options_reply(struct udevice *dev, struct dhcp_msg *request,
 
 		pos = dhcp_test_option(pos, 52, &overload, 1);
 		pos = dhcp_test_option(pos, 17, "/srv", 4);
+		pos = dhcp_test_option(pos, 6, dns, 1);
 		pos = dhcp_test_option(pos, 67, "subdir/", 7);
 		pos = dhcp_test_option(pos, 42, ntp, 1);
 		field = dhcp_test_option(reply->file, 17, "/root", 5);
+		field = dhcp_test_option(field, 6, dns + 1, 7);
 		field = dhcp_test_option(field, 67, "overloaded.bin", 14);
 		field = dhcp_test_option(field, 42, ntp + 1, 2);
 		*field = DHCP_OPTION_END;
@@ -168,6 +175,8 @@ static int dhcp_options_reply(struct udevice *dev, struct dhcp_msg *request,
 			pos = dhcp_test_option(pos, 42, ntp, 1);
 			pos = dhcp_test_option(pos, 42, ntp + 1, 2);
 		}
+		if (kind == DHCP_REPLY_BAD_DNS)
+			pos = dhcp_test_option(pos, 6, dns, 5);
 		if (kind == DHCP_REPLY_ROOT_OVERFLOW) {
 			u8 root[255];
 
@@ -272,15 +281,17 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 	ut_assertok(env_set("ethact", "eth@10002000"));
 	ut_assertok(env_set("autoload", "no"));
 	ut_assertok(env_set("bootp_vci", "U-Boot.test"));
-	for (kind = DHCP_REPLY_BASIC; kind <= DHCP_REPLY_ROOT_OVERFLOW; kind++) {
-		bool have_ntp = IS_ENABLED(CONFIG_BOOTP_NTPSERVER) &&
-			(kind == DHCP_REPLY_BASIC || kind == DHCP_REPLY_OVERLOAD);
+	for (kind = DHCP_REPLY_BASIC; kind <= DHCP_REPLY_BAD_DNS; kind++) {
+		bool supplied = kind == DHCP_REPLY_BASIC || kind == DHCP_REPLY_OVERLOAD;
+		bool have_ntp = IS_ENABLED(CONFIG_BOOTP_NTPSERVER) && supplied;
 		ip_addr_t old_ntp;
 
 		if (CONFIG_IS_ENABLED(CMD_SNTP))
 			ip_addr_copy(old_ntp, *sntp_getserver(0));
 		if (kind == DHCP_REPLY_BAD_NTP && !IS_ENABLED(CONFIG_BOOTP_NTPSERVER))
 			continue;
+		if (kind == DHCP_REPLY_BAD_DNS && !IS_ENABLED(CONFIG_BOOTP_DNS))
+			continue;
 		if (kind == DHCP_REPLY_BAD_SIZE && !IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE))
 			continue;
 		if (kind == DHCP_REPLY_ROOT_OVERFLOW &&
@@ -293,6 +304,8 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 		ut_assertok(env_set("domain", "original.test"));
 		ut_assertok(env_set("ntpserverip", "9.8.7.6"));
 		ut_assertok(env_set("timeoffset", "123"));
+		ut_assertok(env_set("dnsip", "1.2.3.4"));
+		ut_assertok(env_set("dnsip2", "5.6.7.8"));
 		ut_assertok(do_dhcp(NULL, 0, 1, argv));
 		ut_asserteq(1, test->discover);
 		ut_asserteq(1, test->request);
@@ -303,6 +316,13 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 		ut_asserteq_str(IS_ENABLED(CONFIG_BOOTP_SEND_HOSTNAME) ? "original" : "",
 				test->hostname);
 		ut_assert(test->requested[67]);
+		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_SUBNETMASK), test->requested[1]);
+		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_GATEWAY), test->requested[3]);
+		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_DNS), test->requested[6]);
+		ut_asserteq_str(supplied && IS_ENABLED(CONFIG_BOOTP_DNS) ?
+				"8.8.8.8" : "1.2.3.4", env_get("dnsip"));
+		ut_asserteq_str(supplied && IS_ENABLED(CONFIG_BOOTP_DNS2) ?
+				"9.9.9.9" : "5.6.7.8", env_get("dnsip2"));
 		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_HOSTNAME), test->requested[12]);
 		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_BOOTPATH), test->requested[17]);
 		ut_asserteq(IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE), test->requested[13]);

-- 
2.53.0

