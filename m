Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDC606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=azCXjzz8;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYspGTjX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F18E403AA;
	Mon,  9 Nov 2026 08:06:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbeC3uA9QdDD; Mon,  9 Nov 2026 08:06:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A1D39403EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794211568;
	b=RF9MIcQyosG82pJ1g3lSIMBy+Cm5+X9GztyrZbGbGwyqlrg/uxnduZ7N/ucz8e439MTk
	 EirIVvJCjC+pGz7umhJJxUDXsW5iHw/Z6Yz2DKhNiPeBGkIDhsDYr9TvHAVjyQtSLuApx
	 OLEzFRza1rcKHXWctH8Ui3L9UWSdZ5UEXw3NbiqsPCd+rhYuojbqf5VKJCgFlh2AfAO/Q
	 3ZWLrWW8ukKB8BIx+khXBaZsDBZ/JPkqi0BTPmtcLVpMQRG3yr2qlIjgpnJlNp4GKyRDj
	 GKcOkDWmGRZOr7knXkf1GmwyMfPtWjnWmHlD5q3HaDzlvGdrK05LSfhIHCH76Cs6CVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794211568;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cG76ob4tDnJiCcQjiFa+CbJmh1Jlpmk2HwP0tyY1/2U=;
	b=EHrtRFmCPk8YhoyQXyv12ntbl5uKvhmFLlUv7EOQlcLqvfDSsqOdGhP+9QpD+q/HfgFw
	 1ukatrH+JGCvkKAtitebVptr4i/by81vfhCI8Lc4sgRThQYoJ6sX25Xso5Ue+UXK1yT/k
	 /D3XxhfQ44SgpR0CsXk9FI4SoFV1BlzAWb47X85qK6lmBBoNAifPLoHphIRswZBmBB6qW
	 v/GYb6LSE8dnp+911+K1J33UrNdMj6RjiIbcy1lqW/1fVeMoa3hHZOcMX+ziHYHmyrRFr
	 WlQ4ea7atMjd24rdxXuA3x0b7DZOt2EQhf07UmOjdu3uV086vSiw94a0AlUjsu6tI3g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794211568;
	bh=cG76ob4tDnJiCcQjiFa+CbJmh1Jlpmk2HwP0tyY1/2U=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=azCXjzz8J8lk8jMRTczOP5bNiGVF7QMBKvm2Evk0ZlBVqhA9bS4G6H1VTwkT3UdJl
	 dvNnXXPYZyXW8weD0swuZqQLLFphaaVpkF5qN44Eu9w5WM4IjtxHndrNg6SWmQTrwq
	 EKsyXqLdKZ8D1uc26W2ddTlu/lFm7IzlbZHMbTSi3jcGtnNKPCZaOAVMjmKmc78orP
	 byvMtEnGZLCkcjWO/O2gBT39Gvsc89UJpaHpzoci7FKP8NGpvys9SBYAIm+9P+RQQb
	 5saaPCXxybSENAYK85v2HrkZxgHQl5mCrMIw+RTYsK07NIEoMnemcd/K9WSe5wa/PP
	 kG8S+3FYwRJYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1D39403EB;
	Mon,  9 Nov 2026 08:06:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ECE8D235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB6B040242
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zd_fZfZwBNux for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 08:06:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1B5154022F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=PYspGTjX
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B5154022F
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:06:05 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-84d5e56f876so363012a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 00:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794211565; x=1794816365;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cG76ob4tDnJiCcQjiFa+CbJmh1Jlpmk2HwP0tyY1/2U=;
 b=PYspGTjXaLW0gSixCB1lEm3u5GY8+av3cX48dD0Xj+XmaV+sYeh3qjYOUMMPCVZP14
 8YbJtgg8FgVXZljp2qkQQxeXSs0dyq4jZ6zfDG2UmN5k6f2zTmtYw92hMZvZaiIBPopY
 w1z7LpJFbJVKZzARFFoXig+NWxnrPeZyChISrNf+peVSgRZ8d6/wRZMidIKfnWpFNaSo
 FohjGMquJT0+1uSEpOYp9Qk5qFwMj6jw//QkTh/1u7du/2jlvPZ3PN8uGww/CFW5Eh77
 d7saJW6WRL3umsHJXJV70L6RjRut0NpSJmP//2/5kBLsOkCMixoo0SAZu9BTXXExtlPe
 86aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794211565; x=1794816365;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cG76ob4tDnJiCcQjiFa+CbJmh1Jlpmk2HwP0tyY1/2U=;
 b=viXjFA2ew2pWS4vTTy148ydM4ieYVYnaHMVspR6NESX3PVU3Q6jicyG76+GuSATcnv
 kl34lRxKXtFOxeLx3D+VafB7PL7ijJpOo1xS3LWzEr012KYPyymtmgKsfaDWZR8rLVfU
 Zm0BRiuPjW+Dvtc8GeyftwNwOWisafitvhP5ktE64sj4Cwjw/f8DJuKe4p25bNkH2aAK
 f5O8wGG0ryFK5076LXEMxtjYY1Fdqa66ZDoo5RYFjmMEtjUGRar4Z7y+kxV81m01bN/o
 DwpHMoNGkN6nt5QpvoGmY4euWWDEGtEkshF3dSvnx2heMrszqWj8Q//7t06oEd+An0g0
 r59w==
X-Gm-Message-State: APuU4Z/hr+dGcxVYdTGamkA9SaYn0Q8YSDGx4mo42SkeNxL6xEcr7Jeb
 Pmhn2sg3HHLs1rj5jwNGN6zS+CToj3XK3AETyUuAT5NFCwZyZa/sFE6Z
X-Gm-Gg: AYBFou2rMmd18TVHjf54KJpB6haLruDjMHXOx3ytHdm3kJxKB725uJIBdWLrAdTjXyS
 j22lIFACa5UFMMfac6pEpoDRsRANYMLre8Z9uR1ApUcth1ibF2SfXVK1tWfolZPHVvNbS7zYCUZ
 bbjxJrMMILAQSLX/kTvyWeQjcAO6EgSm0ibYprEX8Sj9S+UZdg93YsJVzCRS3rf26X/TX2kLbxP
 edpJsRgC7HRMQVErZ6V/XhWXuscs+qyakqQhH4myak6Z4DrrjW2YT084HOLkdeHgjex1zxtnFIz
 3BU9e6pG/jLKtfJlecfa9fQMyBgvsLN5q+8pUtfrb65rbnKd+y6Sn7n4s9i+o2uBhusKw8+LibQ
 k3pKM7WljxwdL1NoTItTon0SxJLmHfO80X+5IN2e+h+di5BKTjLgm7ZpoB3oX4+3058zjLgOaTu
 J5a2vA/VpWsNgglQocfJgvDrHwfzFCZgnZ/Fu8rhnvMse/LlSyvE8FYWhx+fq7esuB8+1ywbJ2D
 6mUEmwrpkXxHLo34SSM+I/9oaikdgUiNo69/Ne1ZVGTfZwZtdQYFNeuBOqtGe1t/iCM62zVMP6c
 qhyvfKE5rEU6SmyLukxCsM9IEflAOO5QDcSUgwS02Rl0aTrNUAp8NwE2YEb7LMyW9xZUxqapjP0
 zchBzKZkQvbf2dX0hy16IVVdFrw2KQfqnoHWNPpuAVZQXUwXBRsUEEY2v3cNkhxnckQ0k/o0i49
 3sOGGlaICP5AnQWrlfNP1wxscngnRwmPGq04dOOoAy6MXZSBOW5wcLR2UBqLAmEaq4GVuRNygkV
 AQ=
X-Received: by 2002:a05:6830:640d:b0:81b:9d18:75e with SMTP id
 46e09a7af769-85f505376e7mr2244713a34.4.1794211564673; 
 Mon, 09 Nov 2026 00:06:04 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f4fbd422csm3071973a34.22.2026.11.09.00.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:06:04 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 01:06:02 -0700
Subject: [PATCH] net: pcap: make capture available with lwIP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-submit-lwip-pcap-next-v1-1-eb4c7657a3ca@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrB0wEQV7FXGh6Z92ShtDklZBv
 HujLr/FextFBEGkW7FRwE+izC5DlQWZ5+geYLlnk650q1TVcfxOH0n8XsSzN6NnhzVxp2GVnZo
 atqXc+gAr6/nth8s5fMGkY0b7/gdSJv5PeQAAAA==
X-Change-ID: 20261109-submit-lwip-pcap-next-92ef1fb53ef6
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>
X-Mailer: b4 0.15.2
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The lwIP adapter has packet capture hooks, but CMD_PCAP still depends on
NET_LEGACY and the recorder is built only for the legacy stack.

Allow the command with either network stack and build the recorder from
the common network section.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig  | 1 -
 net/Makefile | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 51adc0846c8..e7b1c1cc131 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2108,7 +2108,6 @@ config BOOTP_TIMEOFFSET
 
 config CMD_PCAP
 	bool "pcap capture"
-	depends on NET_LEGACY
 	help
 	  Selecting this will allow capturing all Ethernet packets and store
 	  them in physical memory in a PCAP formated file,
diff --git a/net/Makefile b/net/Makefile
index 7745607248b..df1a4dbf7dc 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_CMD_NFS)  += nfs.o
 obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_PING6) += ping6.o
 obj-$(CONFIG_CMD_DHCP6) += dhcpv6.o
-obj-$(CONFIG_CMD_PCAP) += pcap.o
 obj-$(CONFIG_CMD_RARP) += rarp.o
 obj-$(CONFIG_CMD_SNTP) += sntp.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
@@ -44,6 +43,7 @@ obj-$(CONFIG_$(PHASE_)BOOTDEV_ETH) += eth_bootdev.o
 obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
 obj-$(CONFIG_DM_MDIO_MUX) += mdio-mux-uclass.o
 obj-$(CONFIG_CMD_NFS)  += nfs-common.o
+obj-$(CONFIG_CMD_PCAP) += pcap.o
 obj-$(CONFIG_$(PHASE_)DM_ETH) += eth_common.o
 obj-y += net-common.o
 endif

---
base-commit: 1ed1749575f28b406c241218eb6a200574574a25
change-id: 20261109-submit-lwip-pcap-next-92ef1fb53ef6

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

