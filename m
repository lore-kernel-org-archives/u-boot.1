Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D91CA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB18E60720;
	Tue, 29 Sep 2026 00:22:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ESxeaCH2pZDm; Tue, 29 Sep 2026 00:22:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5E90360740
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641328;
	b=JjicLyfhxKjBlzTo2SDNUE+e3DGyKzgZtC+vy6AOdPQwrA2zp5MKmzeR809kYAwJwyY2
	 TRVZBkmyuXmJirBZmF40rbttI0d9MIl8rIPdblMleMZT3LW7IdXwGmif1sUUhDqmmpozb
	 iI8O5jEvbDGWXFAvVzsCctef+NCJdVgcy0qSYg2mwqIVMV5AQMsAWROGyhIW/tQF968e6
	 bW7sEy5EkcgqKj4cIr0cDsevE8UUzFE+6HgsrKcKDanos7ata6weMiK/D3a9g4Th/W7Ph
	 kStLBI0oPcbA1V50B0rxCuzFMKVvONXVgxutods91n4or9oZlg5zH8UqhER7ERy79fQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641328;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Y46QUQJMxuWSaZQWmmGDpvR6dYmODnjASpuRNWV8itE=;
	b=dn7yvY8qIM0bU46JfBKyKJilpqXqwpB3jqMbvY6BmTbKqhQlozYoxQ5O7CvwMZABYKLs
	 1+A2SdJqZVoQZG6LWqC68dcXqg3QDG4/SWEArZsd3eoHCAs51kx6WT667JR9vX+Y8xKq6
	 I2mzQhE7ETwOXfWhU8TO/aMiqfopH+JseXzYI9tFQZ7HCJN3J5BqTgrZq64WA7p8x6m5f
	 A4n9NaTLkmx68nvd67Dyza8OamFDRvhvmWu0w44nAGRx9wAo+gS5WNdm7pzJot5N7ktXV
	 fHR/HxMrw5+mhCgrNtX2XZCAbvka0OLwH86cQV0H49qoQVcdFxtuTxdEIP7kp/IpZTg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i+m3TlfU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641328;
	bh=Y46QUQJMxuWSaZQWmmGDpvR6dYmODnjASpuRNWV8itE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l+7Wo84qFYa7z2jGwXw8mUAVczB8F3/hzGC3fF29CDtBaRkylEvAsqeBQwD/9vjrP
	 o8S8M5C8R1Ho9NO/z0HyRknvLG9PCkmVf5mZ9XGI4xP1XFfYYcidPwzbKlzS5KpWzz
	 pSYy+gkOwurWGTSeG3YXVMULr65/yEOVx2Wy+2ksQeLcZvN+sUEpwp4VyE7j5KqNJM
	 6BcoGRauRH80C2XmjsIzq6siD4/JHvd0QbBnZzSrLyNuWfwfKpjZH2a5u1al1BkwFL
	 u5qSD89c/Mz6hbMQnP0M6XCBeg8vVbyTC+huXf3uQuF6I9KCk8A79jA7dJnxnJMdZC
	 gnSOfZZzpjjDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E90360740;
	Tue, 29 Sep 2026 00:22:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8356A4CD
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8043F60743
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id abHtM5te3qKh for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BBA2460724
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641324;
 b=Zudmdq3YnmIaAaYyjIHo174TTHsGKwcL04fRfK0MhAkfXCqmVQ4G9BOjp5DNeljfYcXE
 U0VGNhXmyz12S0VyylXSQK3TSxazwLyqKzpr9DcsLE9vP15/rXc9E5juaiKf5iX2t/DNf
 k12aquKfe7Oey9QpEYEK77pjmD48TpWTHwcBBb5/8CmNvOS9FP8KzMVzDQ0U3e1sWH0mK
 fX286+25AyPE6+Ul92dupVPI3xz8dNDJJh1Gp/ooRttDxW/3I0b15vCKhfodooPyjtp43
 wtJROxcMZEv+Ixc+H1tqKVKNKKyiW2p5hYhweuVUWvloPqzx8ccUrlz/mA/c4kKIILw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641324;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=Y46QUQJMxuWSaZQWmmGDpvR6dYmODnjASpuRNWV8itE=;
 b=FKDadunj/4n3o37ckT69Vfro9NtLQ5q/DcgtFvpKbN1+xXFr6jbwVK6+ko353hMfOmFq
 BML3GXfyaz/jVWjBTV7h/eZyAQaPQ4+m4gTF8htQJ6Hubgonk6Y9XffWxikcCeKY6NnVn
 LnbJo8+oK1unYrTMQe0pz5U/l+REVvhLDJw4tg7U7WsMSFj/b/fHRkO+O2p+ENZeSGXnA
 R14y8XLTbz2niPJoo+sjX0s0h0CJ1Esr0wUFhgzm9z4VHIu82GzIPjuEM0jPCEsBMiHO1
 Jbjh4lScqbTyDKh2DysAHO5GwxuSexVtF0qXXTU6Nu9MtvxGC+xpLlPQoTyDLBz5czQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=i+m3TlfU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=i+m3TlfU
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBA2460724
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:03 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc88a0d7so2460514fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641322; x=1791246122;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y46QUQJMxuWSaZQWmmGDpvR6dYmODnjASpuRNWV8itE=;
 b=i+m3TlfU9ZP3fP1jdOaYrdLwYDU6pfm9XbbXX5Fuufx3n6534vG2VsbkN9U9R+QYZL
 8Sy0P9cS5B0L+qD4br28ur6UdjZ73O3L7nRZ2Bvh762Ir/Uk+A5QTvAFBVPUaJDqVMBc
 fNEwImW+sghz6UV+8ImtavIPgZi0XE0Xk4fQpCGfWd8KJgkMBuRWOMDU/VTSZlA2Ggj5
 HxKzLAII88t9+tgCPrsOInJ+wEcRv40gvEJNSziV9MLEXik/LHC1Fsmf7iJyLy7hvOWO
 Klu7vXtyoC9pqmxBx5Hm+IPGF87qY5lOqKgOWMOXKxztaMjhuRv5iaZfyjlWbbPJwVsH
 4VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641322; x=1791246122;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y46QUQJMxuWSaZQWmmGDpvR6dYmODnjASpuRNWV8itE=;
 b=uh95ETywJbeRcQd2hSNdYfoXnKSsRTNXDrgU9sH0thfE1zj9O7bFr274emXbeIJ1Xm
 cdHk/byZhKUnhKXOohhcVfYQjmgkXrkzWUzkyZiHn3ViPrXohyntHLN/orSIJpl8dgak
 3awRLleZT9myz9yTm1Kgj83UmE9AFk8u2GMclHilcguNQyMyu+c5uYEUFDYolCXNqCxQ
 mmvxjimHdKEILEUKwSDTAVy19SYVO6dVGPplHSQ2aFU+CGhHW+U6PCefCNxlF0aquCiU
 bVRE1DZrHxA/OLmCJgFoOZYt1HIJV+yHj0mzAy8C6rYnJUfe0UJ5YF/zNTmC+cVYwoKV
 1ZSg==
X-Gm-Message-State: AFuF++kXeLa8IEB1FVE7jEihLGfAlYujhiCmYTtv58C4fEaUkOeLWtEE
 QjZaCxkRRqyE4mppVLKMbynqziFd0skMYG3kcWJThvRTL3Tk/CGhAi5c
X-Gm-Gg: AYBFou24SudhvxHM1bJnUHsQxY5bkbLllZVp90GXCI6EJDiKhhAygXSp3hNtoNI5lpR
 qoeKio6w7aIp5hl/NFPlCEYhPeyogxjVZjhlTpuU4HWRlMxXm5d8n8mRHM9/ZhYBsexG0ioL1CX
 0ClDp8ltlWj/mLvhh6O5yBpz/2Z8EIlvxPpLziVCCKYPJ8lkh0PAqPUkhR2CjxsnSdO+3p915Tb
 BmQiMtDKdnaeb1xhc88yXCKRp78svdiO+kwsKDX8F8MasDvDQayPKTSZm3Qglpra5flhhvuDzHu
 mgW0x8sj8f2KR/HGE9BBwY1A3wjJvhEBszbODu2Xmb+PaLFEypwWz4Xi0YLYNENw7+cDYWvakWl
 pIVcsVsDobWqdj1a6e3iZkx6+lL8M56CqkxCALDrUIdgXfv176k7De7P7FVfmnwjvD+97UX9Hqx
 a2YApBHh0AiFA9NeojKidDRC+ZZ6MLsKAyPLXRVkDeZDj4KIrzV0cmwvWFcdQJIVvmt+kni42uC
 rGxyCptfYea3lyeY1umTaZYOg8vfTGzltSc/anbiROLfSUsQSJyB40/C7+V/TQllaMnzV0XmNny
 wew5pIgn8DZxHalxO77G5rU+rxcbYLqjoPCpoUn5my+9mWN8n8o1wbOcr/yt/x1UZHkusPaRmwp
 7QZhcxYbUriWzAso/lHLI
X-Received: by 2002:a05:6808:250b:b0:4c4:a240:9c3a with SMTP id
 5614622812f47-4d72c0429famr13153255b6e.4.1790641321224; 
 Mon, 28 Sep 2026 17:22:01 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:43 -0600
Subject: [PATCH 06/20] net: lwip: carry DHCP boot options into the environment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-6-2060c7365b0c@gmail.com>
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

Request and stage hostname, root path, NIS domain, boot file size, time
offset and boot filename options from a matching ACK. Publish them only
after binding the lease. Concatenate repeated options across the main,
file and sname fields, reject malformed or oversized values, and honor
explicit filenames ahead of the supplied boot file. Stage the fixed
BOOTP file field too, without consulting core metadata which an ignored
reply may have overwritten. Parse each ACK into a separate candidate
and commit it only after validation, so rejecting a later ACK cannot
overwrite previously accepted boot metadata.

Request NTP explicitly and concatenate its fragments before validation,
instead of using the core parser's per-fragment address-length checks.
Export the first accepted server and update the enabled SNTP cache from
that same value. Keep environment defaults when an option is absent and
handle a zero time offset explicitly.

Share the existing BOOTP option controls with lwIP. Add bounded
hostname and vendor-class requests, including the bootp_vci override,
without retaining environment pointers during the exchange.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig                        |  37 +++--
 doc/usage/cmd/sntp.rst             |   4 +-
 lib/lwip/lwip/src/core/ipv4/dhcp.c |   4 +
 lib/lwip/u-boot/lwip-dhcp.h        |  21 +++
 lib/lwip/u-boot/lwipopts.h         |  51 ++++++-
 net/Kconfig                        |  14 +-
 net/lwip/dhcp.c                    | 291 ++++++++++++++++++++++++++++++++++---
 7 files changed, 383 insertions(+), 39 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 7124b961dc2..0da16a4a343 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2014,17 +2014,23 @@ config BOOTP_MAY_FAIL
 	  over to Link-local IP address configuration if the DHCP server is not
 	  available.
 
+endif
+
 config BOOTP_BOOTPATH
 	bool "Request & store 'rootpath' from BOOTP/DHCP server"
 	default y
-	depends on CMD_BOOTP
+	depends on CMD_BOOTP || CMD_DHCP
 	help
 	  Even though the config is called BOOTP_BOOTPATH, it stores the
 	  path in the variable 'rootpath'.
 
 config BOOTP_BOOTFILESIZE
-	bool "Request & store 'bootfilesize' from BOOTP/DHCP server"
-	depends on CMD_BOOTP
+	bool "Request the boot file size from BOOTP/DHCP server"
+	depends on CMD_BOOTP || CMD_DHCP
+	help
+	  Save the expected file size in 512-byte blocks for download progress.
+
+if NET_LEGACY
 
 config BOOTP_DNS
 	bool "Request & store 'dnsip' from BOOTP/DHCP server"
@@ -2051,13 +2057,17 @@ config BOOTP_GATEWAY
 	default y
 	depends on CMD_BOOTP
 
+endif
+
 config BOOTP_HOSTNAME
 	bool "Request & store 'hostname' from BOOTP/DHCP server"
 	default y
-	depends on CMD_BOOTP
+	depends on CMD_BOOTP || CMD_DHCP
 	help
 	  The name may or may not be qualified with the local domain name.
 
+if NET_LEGACY
+
 config BOOTP_PREFER_SERVERIP
 	bool "serverip variable takes precedent over DHCP server IP."
 	depends on CMD_BOOTP
@@ -2073,17 +2083,22 @@ config BOOTP_SUBNETMASK
 	default y
 	depends on CMD_BOOTP
 
+endif
+
 config BOOTP_NISDOMAIN
-	bool "Request & store 'nisdomain' from BOOTP/DHCP server"
-	depends on CMD_BOOTP
+	bool "Request & store 'domain' from BOOTP/DHCP server"
+	depends on CMD_BOOTP || CMD_DHCP
 
 config BOOTP_NTPSERVER
 	bool "Request & store 'ntpserverip' from BOOTP/DHCP server"
-	depends on CMD_BOOTP
+	depends on CMD_BOOTP || CMD_DHCP
+	default y if NET_LWIP && CMD_SNTP
 
 config BOOTP_TIMEOFFSET
 	bool "Request & store 'timeoffset' from BOOTP/DHCP server"
-	depends on CMD_BOOTP && CMD_SNTP
+	depends on (CMD_BOOTP || CMD_DHCP) && CMD_SNTP
+
+if NET_LEGACY
 
 config CMD_PCAP
 	bool "pcap capture"
@@ -2121,14 +2136,18 @@ config BOOTP_PXE_DHCP_OPTION
 	default y
 	depends on BOOTP_PXE
 
+endif
+
 config BOOTP_VCI_STRING
 	string
-	depends on CMD_BOOTP
+	depends on CMD_BOOTP || CMD_DHCP
 	default "U-Boot.armv7" if CPU_V7A || CPU_V7M_V8M || CPU_V7R
 	default "U-Boot.armv8" if ARM64
 	default "U-Boot.arm" if ARM
 	default "U-Boot"
 
+if NET_LEGACY
+
 config BOOTP_RANDOM_XID
 	bool "Send random transaction ID to BOOTP/DHCP server"
 	depends on CMD_BOOTP && (LIB_RAND || LIB_HW_RAND)
diff --git a/doc/usage/cmd/sntp.rst b/doc/usage/cmd/sntp.rst
index bfbf75464c2..16848e98a91 100644
--- a/doc/usage/cmd/sntp.rst
+++ b/doc/usage/cmd/sntp.rst
@@ -24,8 +24,8 @@ the server's IP address to be given on the command line or via the
 `ntpserverip` environment variable.
 
 The address of the NTP server does not need to be given if the DHCP server
-provides one. The legacy network stack (`CONFIG_NET_LEGACY=y`) can only use the
-first NTP server provided in the `ntp-servers` DHCP option.
+provides one and ``CONFIG_BOOTP_NTPSERVER`` is enabled. Both network stacks
+use only the first NTP server provided in the `ntp-servers` DHCP option.
 
 When the network stack is lwIP (`CONFIG_NET_LWIP=y`) and DNS resolution
 is enabled (`CONFIG_DNS=y`), then the sntp command accepts a server
diff --git a/lib/lwip/lwip/src/core/ipv4/dhcp.c b/lib/lwip/lwip/src/core/ipv4/dhcp.c
index d416286c957..035df0f302f 100644
--- a/lib/lwip/lwip/src/core/ipv4/dhcp.c
+++ b/lib/lwip/lwip/src/core/ipv4/dhcp.c
@@ -210,6 +210,9 @@ static u32_t dhcp_rx_options_val[DHCP_OPTION_IDX_MAX];
 static u8_t  dhcp_rx_options_given[DHCP_OPTION_IDX_MAX];
 
 static u8_t dhcp_discover_request_options[] = {
+#ifdef DHCP_REQUEST_OPTIONS
+  DHCP_REQUEST_OPTIONS
+#else
   DHCP_OPTION_SUBNET_MASK,
   DHCP_OPTION_ROUTER,
   DHCP_OPTION_BROADCAST
@@ -220,6 +223,7 @@ static u8_t dhcp_discover_request_options[] = {
   , DHCP_OPTION_NTP
 #endif /* LWIP_DHCP_GET_NTP_SRV */
   DHCP_ADD_EXTRA_REQUEST_OPTIONS
+#endif
 };
 
 #ifdef DHCP_GLOBAL_XID
diff --git a/lib/lwip/u-boot/lwip-dhcp.h b/lib/lwip/u-boot/lwip-dhcp.h
new file mode 100644
index 00000000000..b3bbd9e5ba4
--- /dev/null
+++ b/lib/lwip/u-boot/lwip-dhcp.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#ifndef __UBOOT_LWIP_DHCP_H
+#define __UBOOT_LWIP_DHCP_H
+
+#include <lwip/err.h>
+
+struct dhcp;
+struct dhcp_msg;
+struct netif;
+struct pbuf;
+
+err_t net_lwip_dhcp_ack(struct netif *netif, struct dhcp *dhcp, struct pbuf *p);
+void net_lwip_dhcp_append(struct netif *netif, struct dhcp *dhcp, u8_t state,
+			  struct dhcp_msg *msg, u8_t type, u16_t *len);
+
+#define LWIP_HOOK_DHCP_HANDLE_ACK net_lwip_dhcp_ack
+#define LWIP_HOOK_DHCP_APPEND_OPTIONS net_lwip_dhcp_append
+
+#endif /* __UBOOT_LWIP_DHCP_H */
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index 1c1adc57c6b..90519e66120 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -127,6 +127,53 @@
 
 #define LWIP_DHCP_DOES_ACD_CHECK	0
 
+#ifdef CONFIG_CMD_DHCP
+#define LWIP_HOOK_FILENAME "lwip-dhcp.h"
+/* Core options plus two maximum-length hostname/vendor-class options. */
+#define DHCP_OPTIONS_LEN		640
+/* Stage NTP after concatenating fragments, not in the core option parser. */
+#define LWIP_DHCP_GET_NTP_SRV	0
+#ifdef CONFIG_PROT_DNS_LWIP
+#define UBOOT_DHCP_DNS		6,
+#else
+#define UBOOT_DHCP_DNS
+#endif
+#ifdef CONFIG_BOOTP_NTPSERVER
+#define UBOOT_DHCP_NTP		42,
+#else
+#define UBOOT_DHCP_NTP
+#endif
+#ifdef CONFIG_BOOTP_HOSTNAME
+#define UBOOT_DHCP_HOSTNAME	12,
+#else
+#define UBOOT_DHCP_HOSTNAME
+#endif
+#ifdef CONFIG_BOOTP_BOOTFILESIZE
+#define UBOOT_DHCP_FILESIZE	13,
+#else
+#define UBOOT_DHCP_FILESIZE
+#endif
+#ifdef CONFIG_BOOTP_BOOTPATH
+#define UBOOT_DHCP_ROOTPATH	17,
+#else
+#define UBOOT_DHCP_ROOTPATH
+#endif
+#ifdef CONFIG_BOOTP_NISDOMAIN
+#define UBOOT_DHCP_DOMAIN		40,
+#else
+#define UBOOT_DHCP_DOMAIN
+#endif
+#ifdef CONFIG_BOOTP_TIMEOFFSET
+#define UBOOT_DHCP_TIMEOFFSET	2,
+#else
+#define UBOOT_DHCP_TIMEOFFSET
+#endif
+#define DHCP_REQUEST_OPTIONS	1, 3, 28, UBOOT_DHCP_DNS UBOOT_DHCP_NTP \
+	UBOOT_DHCP_HOSTNAME \
+	UBOOT_DHCP_FILESIZE UBOOT_DHCP_ROOTPATH UBOOT_DHCP_DOMAIN \
+	UBOOT_DHCP_TIMEOFFSET 67
+#endif /* CONFIG_CMD_DHCP */
+
 #define LWIP_AUTOIP                     0
 
 #define LWIP_SNMP                       0
@@ -196,8 +243,4 @@
 #define LWIP_ALTCP_TLS_MBEDTLS          1
 #endif
 
-#if defined(CONFIG_CMD_SNTP)
-#define LWIP_DHCP_GET_NTP_SRV 1
-#endif
-
 #endif /* LWIP_UBOOT_LWIPOPTS_H */
diff --git a/net/Kconfig b/net/Kconfig
index 02b6e0de21e..e064c67e3ef 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -65,8 +65,11 @@ config PROT_UDP
 	  Enable a generic udp framework that allows defining a custom
 	  handler for udp protocol.
 
+endif
+
 config BOOTP_SEND_HOSTNAME
-	bool "Send hostname to DNS server"
+	bool "Send hostname to DHCP server"
+	depends on NET_LEGACY || CMD_BOOTP || CMD_DHCP
 	help
 	  Some DHCP servers are capable to do a dynamic update of a
 	  DNS server. To do this, they need the hostname of the DHCP
@@ -75,6 +78,8 @@ config BOOTP_SEND_HOSTNAME
 	  of the "hostname" environment variable is passed as
 	  option 12 to the DHCP server.
 
+if NET_LEGACY
+
 config IP_DEFRAG
 	bool "Support IP datagram reassembly"
 	help
@@ -149,11 +154,16 @@ config BOOTP_SERVERIP
 	  variable, not the BOOTP server. This affects the operation of both
 	  bootp and tftp.
 
+endif
+
 config BOOTP_MAX_ROOT_PATH_LEN
 	int "Option 17 root path length"
 	default 64
+	range 2 4096
 	help
-	  Select maximal length of option 17 root path.
+	  Maximum root path size, including the terminating NUL byte.
+
+if NET_LEGACY
 
 config USE_GATEWAYIP
 	bool "Set a default 'gateway' value in the environment"
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 411f0e68d75..2e0bf839b22 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -5,23 +5,260 @@
 #include <console.h>
 #include <env.h>
 #include <log.h>
+#include <lwip-dhcp.h>
+#include <malloc.h>
+#include <net.h>
+#include <time.h>
+#include <asm/unaligned.h>
 #include <dm/device.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <lwip/apps/sntp.h>
 #include <lwip/dhcp.h>
 #include <lwip/dns.h>
-#include <net.h>
-#include <time.h>
+#include <lwip/prot/dhcp.h>
 
 #define DHCP_TIMEOUT_MS 10000
 
-static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file)
+struct dhcp_boot_data {
+	char hostname[256];
+	char rootpath[CONFIG_BOOTP_MAX_ROOT_PATH_LEN];
+	char domain[256];
+	char bootfile[sizeof(net_boot_file_name)];
+	u8 file_size[2];
+	u8 time_offset[4];
+	ip4_addr_t ntp;
+	bool have_size;
+	bool have_offset;
+	bool have_ntp;
+};
+
+struct dhcp_options {
+	struct netif *netif;
+	struct dhcp_boot_data reply;
+	struct dhcp_boot_data candidate;
+	char hostname[256];
+	char vendor[256];
+	bool append_failed;
+};
+
+/* The address-less runtime attachment excludes a second DHCP command. */
+static struct dhcp_options *active_options;
+
+struct dhcp_boot_option {
+	u8 code;
+	bool enabled;
+	bool string;
+	void *data;
+	size_t size;
+	size_t len;
+};
+
+static int dhcp_boot_options(struct pbuf *p, unsigned int pos, unsigned int end,
+			     struct dhcp_boot_option *opts, size_t count,
+			     u8 *overload)
+{
+	while (pos < end) {
+		u8 code = pbuf_get_at(p, pos++);
+		unsigned int len;
+		size_t i;
+
+		if (code == DHCP_OPTION_END)
+			return 0;
+		if (code == DHCP_OPTION_PAD)
+			continue;
+		if (pos == end)
+			return -EINVAL;
+		len = pbuf_get_at(p, pos++);
+		if (len > end - pos)
+			return -EINVAL;
+		if (code == DHCP_OPTION_OVERLOAD) {
+			/* Overload is only meaningful in the main options field. */
+			if (!overload || *overload || len != 1)
+				return -EINVAL;
+			*overload = pbuf_get_at(p, pos);
+			if (!*overload || *overload > DHCP_OVERLOAD_SNAME_FILE)
+				return -EINVAL;
+		}
+		for (i = 0; i < count; i++) {
+			struct dhcp_boot_option *opt = &opts[i];
+			size_t copy;
+
+			if (code != opt->code || !opt->enabled)
+				continue;
+			if (!len)
+				return -EINVAL;
+			/*
+			 * RFC 3396: concatenate fragments before interpreting them.
+			 * For the NTP list retain only the first address, but validate
+			 * the length of the entire list below.
+			 */
+			if (code != DHCP_OPTION_NTP && len > opt->size - opt->len)
+				return -E2BIG;
+			copy = min_t(size_t, len, opt->size - min(opt->len, opt->size));
+			if (copy && pbuf_copy_partial(p, (u8 *)opt->data + opt->len,
+						      copy, pos) != copy)
+				return -EINVAL;
+			opt->len += len;
+			break;
+		}
+		pos += len;
+	}
+
+	return 0;
+}
+
+static err_t dhcp_parse_boot_data(struct pbuf *p, struct dhcp_boot_data *data)
+{
+	struct dhcp_boot_option opts[] = {
+		{ 12, IS_ENABLED(CONFIG_BOOTP_HOSTNAME), true,
+		  data->hostname, sizeof(data->hostname) - 1 },
+		{ 17, IS_ENABLED(CONFIG_BOOTP_BOOTPATH), true,
+		  data->rootpath, sizeof(data->rootpath) - 1 },
+		{ 40, IS_ENABLED(CONFIG_BOOTP_NISDOMAIN), true,
+		  data->domain, sizeof(data->domain) - 1 },
+		{ 67, true, true, data->bootfile, sizeof(data->bootfile) - 1 },
+		{ 13, IS_ENABLED(CONFIG_BOOTP_BOOTFILESIZE), false,
+		  data->file_size, sizeof(data->file_size) },
+		{ 2, IS_ENABLED(CONFIG_BOOTP_TIMEOFFSET), false,
+		  data->time_offset, sizeof(data->time_offset) },
+		{ 42, IS_ENABLED(CONFIG_BOOTP_NTPSERVER), false,
+		  &data->ntp, sizeof(data->ntp) },
+	};
+	u8 overload = 0;
+	u32 cookie;
+	size_t i;
+	int ret;
+
+	if (pbuf_copy_partial(p, &cookie, sizeof(cookie), DHCP_MSG_LEN) != sizeof(cookie) ||
+	    ntohl(cookie) != DHCP_MAGIC_COOKIE)
+		return ERR_VAL;
+	ret = dhcp_boot_options(p, DHCP_OPTIONS_OFS, p->tot_len, opts,
+				ARRAY_SIZE(opts), &overload);
+	if (!ret && (overload & DHCP_OVERLOAD_FILE))
+		ret = dhcp_boot_options(p, DHCP_FILE_OFS, DHCP_FILE_OFS + DHCP_FILE_LEN,
+					opts, ARRAY_SIZE(opts), NULL);
+	if (!ret && (overload & DHCP_OVERLOAD_SNAME))
+		ret = dhcp_boot_options(p, DHCP_SNAME_OFS, DHCP_SNAME_OFS + DHCP_SNAME_LEN,
+					opts, ARRAY_SIZE(opts), NULL);
+	if (ret)
+		return ERR_VAL;
+	for (i = 0; i < ARRAY_SIZE(opts); i++) {
+		struct dhcp_boot_option *opt = &opts[i];
+		char *str = opt->data;
+
+		if (!opt->len)
+			continue;
+		if (opt->string) {
+			/* RFC 2132 allows trailing NULs, not an embedded terminator. */
+			while (opt->len && !str[opt->len - 1])
+				opt->len--;
+			if (memchr(str, 0, opt->len))
+				return ERR_VAL;
+			str[opt->len] = 0;
+		} else if (opt->code == DHCP_OPTION_NTP) {
+			if (opt->len % sizeof(ip4_addr_t))
+				return ERR_VAL;
+			data->have_ntp = !ip4_addr_isany(&data->ntp);
+		} else {
+			if (opt->len != opt->size)
+				return ERR_VAL;
+			if (opt->code == 13)
+				data->have_size = true;
+			else
+				data->have_offset = true;
+		}
+	}
+	if (!(overload & DHCP_OVERLOAD_FILE) && !data->bootfile[0]) {
+		size_t len = min_t(size_t, DHCP_FILE_LEN, sizeof(data->bootfile) - 1);
+
+		if (pbuf_copy_partial(p, data->bootfile, len, DHCP_FILE_OFS) != len)
+			return ERR_VAL;
+		data->bootfile[len] = 0;
+	}
+
+	return ERR_OK;
+}
+
+err_t net_lwip_dhcp_ack(struct netif *netif, struct dhcp *dhcp, struct pbuf *p)
+{
+	struct dhcp_boot_data *data;
+	err_t ret;
+
+	if (!active_options || active_options->netif != netif)
+		return ERR_OK;
+	/* A rejected renewal must leave the accepted lease metadata intact. */
+	data = &active_options->candidate;
+	memset(data, 0, sizeof(*data));
+	ret = dhcp_parse_boot_data(p, data);
+	if (ret)
+		return ret;
+	active_options->reply = *data;
+
+	return ERR_OK;
+}
+
+void net_lwip_dhcp_append(struct netif *netif, struct dhcp *dhcp, u8_t state,
+			  struct dhcp_msg *msg, u8_t type, u16_t *len)
+{
+	const char *strings[2];
+	const u8 codes[] = { DHCP_OPTION_HOSTNAME, DHCP_OPTION_US };
+	size_t i;
+
+	if (!active_options || active_options->netif != netif ||
+	    (type != DHCP_DISCOVER && type != DHCP_REQUEST))
+		return;
+	strings[0] = active_options->hostname;
+	strings[1] = active_options->vendor;
+	for (i = 0; i < ARRAY_SIZE(strings); i++) {
+		size_t size = strlen(strings[i]);
+
+		if (!size)
+			continue;
+		/* Leave room for END and the core's four-byte padding. */
+		if (*len + size + 2 + 4 > DHCP_OPTIONS_LEN) {
+			active_options->append_failed = true;
+			return;
+		}
+		msg->options[(*len)++] = codes[i];
+		msg->options[(*len)++] = size;
+		memcpy(&msg->options[*len], strings[i], size);
+		*len += size;
+	}
+}
+
+static int dhcp_boot_env(struct dhcp_boot_data *data)
+{
+	char offset[12];
+
+	if ((data->hostname[0] && env_set("hostname", data->hostname)) ||
+	    (data->rootpath[0] && env_set("rootpath", data->rootpath)) ||
+	    (data->domain[0] && env_set("domain", data->domain)) ||
+	    (data->have_ntp && env_set("ntpserverip", ip4addr_ntoa(&data->ntp))))
+		return CMD_RET_FAILURE;
+	if (data->have_offset) {
+		snprintf(offset, sizeof(offset), "%d", (s32)get_unaligned_be32(data->time_offset));
+		if (env_set("timeoffset", offset))
+			return CMD_RET_FAILURE;
+	}
+	net_boot_file_expected_size_in_blocks = data->have_size ?
+		get_unaligned_be16(data->file_size) : 0;
+	if (CONFIG_IS_ENABLED(CMD_SNTP) && data->have_ntp) {
+		ip_addr_t addr;
+
+		ip_addr_copy_from_ip4(addr, data->ntp);
+		sntp_setserver(0, &addr);
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
+		     struct dhcp_options *options)
 {
 	char ipstr[] = "ipaddr\0\0\0";
 	char maskstr[] = "netmask\0\0\0";
 	char gwstr[] = "gatewayip\0\0\0";
-	const ip_addr_t *ntpserverip;
 	unsigned long start;
 	struct dhcp *dhcp;
 	bool bound = false;
@@ -33,21 +270,14 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file)
 		return CMD_RET_FAILURE;
 	}
 
-	/*
-	 * Request the DHCP stack to parse and store the NTP servers for
-	 * eventual use by the SNTP command
-	 */
-	if (CONFIG_IS_ENABLED(CMD_SNTP))
-		sntp_servermode_dhcp(1);
-
 	start = get_timer(0);
 
-	if (dhcp_start(net->netif))
+	if (dhcp_start(net->netif) || options->append_failed)
 		return CMD_RET_FAILURE;
 
 	/* Wait for DHCP to complete */
 	do {
-		if (net_lwip_poll() < 0)
+		if (net_lwip_poll() < 0 || options->append_failed)
 			return CMD_RET_FAILURE;
 		bound = dhcp_supplied_address(net->netif);
 		if (bound)
@@ -64,8 +294,9 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file)
 
 	dhcp = netif_dhcp_data(net->netif);
 
-	if (!explicit_file && dhcp->boot_file_name[0])
-		copy_filename(net_boot_file_name, dhcp->boot_file_name,
+	/* The core's file field also reflects replies it subsequently ignores. */
+	if (!explicit_file && options->reply.bootfile[0])
+		copy_filename(net_boot_file_name, options->reply.bootfile,
 			      sizeof(net_boot_file_name));
 	if (*net_boot_file_name && env_set("bootfile", net_boot_file_name))
 		return CMD_RET_FAILURE;
@@ -91,11 +322,8 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file)
 	    env_set("dnsip2", ip4addr_ntoa(dns_getserver(1))))
 		return CMD_RET_FAILURE;
 #endif
-	if (CONFIG_IS_ENABLED(CMD_SNTP)) {
-		ntpserverip = sntp_getserver(1);
-		if (ntpserverip != IP_ADDR_ANY)
-			env_set("ntpserverip", ip4addr_ntoa(ntpserverip));
-	}
+	if (dhcp_boot_env(&options->reply))
+		return CMD_RET_FAILURE;
 
 	printf("DHCP client bound to address %pI4 (%lu ms)\n",
 	       &dhcp->offered_ip_addr, get_timer(start));
@@ -128,10 +356,12 @@ static int dhcp_nfs_autoload(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct net_lwip_ctx net = {};
+	struct dhcp_options *options;
 	const char *autoload;
 	const char *filename = NULL;
 	ulong addr;
 	char *end;
+	const char *hostname, *vendor;
 	int ret;
 
 	switch (argc) {
@@ -153,10 +383,25 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	copy_filename(net_boot_file_name, filename ?: env_get("bootfile"),
 		      sizeof(net_boot_file_name));
 
-	if (net_lwip_start(&net, NET_LWIP_ADDR_NONE))
+	hostname = IS_ENABLED(CONFIG_BOOTP_SEND_HOSTNAME) ? env_get("hostname") : NULL;
+	vendor = env_get("bootp_vci") ?: CONFIG_BOOTP_VCI_STRING;
+	if ((hostname && strlen(hostname) > 255) || strlen(vendor) > 255) {
+		log_err("DHCP hostname/vendor class exceeds 255 bytes\n");
 		return CMD_RET_FAILURE;
+	}
+	options = calloc(1, sizeof(*options));
+	if (!options)
+		return CMD_RET_FAILURE;
+	strlcpy(options->hostname, hostname ?: "", sizeof(options->hostname));
+	strlcpy(options->vendor, vendor, sizeof(options->vendor));
+	if (net_lwip_start(&net, NET_LWIP_ADDR_NONE)) {
+		free(options);
+		return CMD_RET_FAILURE;
+	}
+	options->netif = net.netif;
+	active_options = options;
 
-	ret = dhcp_loop(&net, !!filename);
+	ret = dhcp_loop(&net, !!filename, options);
 	/*
 	 * A download needs strict addressing, incompatible with DHCP's
 	 * address-less runtime attachment. Retire DHCP before handing off.
@@ -168,6 +413,8 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			dhcp_release_and_stop(net.netif);
 		dhcp_cleanup(net.netif);
 	}
+	active_options = NULL;
+	free(options);
 	net_lwip_stop(&net);
 
 	if (ret)

-- 
2.53.0

