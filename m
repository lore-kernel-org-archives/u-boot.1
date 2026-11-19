Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E20606A33E
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G3aUUpnP;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u2i/QZhs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5239C40ADA;
	Thu, 19 Nov 2026 13:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W6i6QH2E1byP; Thu, 19 Nov 2026 13:33:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3580040AE4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095208;
	b=Z/2bL0jJDfMgzIKrqivF/kXxulVyYT35xsgaDWi79+zN1ivgbRKFQunmmgsyNIMwt2eG
	 gIAnk7/VC98qUS2Is1Af2sLmjfHf3sQxAhmam1G3AdlnW76wIngzGMaqf4pPjS5Csd1w9
	 Cchzgh8WbCmfCWwHjekhjCOqYXimy/uAeiVHd51F1/C8Fub+5R9aPWGfzqJHDPlwCyPjk
	 iGteKfGlrhg1yFPp/QsN/KHK4eXum/tmJ0mxIIdGeCinVmwXwlK9Cc3J9MagPGvJgY0gb
	 wt/oz6JZSDIQlhHsj4DuHCnCuBaATzAVzHdotPOliKzfgEokZgyfwEedDbPb3U3vnbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3J3Wi0fEe6pHa4CkySVdxWy/3BAZUKboXH2UiuzUZTQ=;
	b=dDM+WG4T8qEByz+IhDa7Gih6NMIuAjBCzaHRAUj4rgIv8c2zjAktcxDOlTfTehhlzVrZ
	 uVC3ndk6p94rEDg4VkSFirBiIsl11VIA5YkSPDIYMnidnryFD5HpmVpsVHEA3JmvxOxVz
	 PNh19Wf47zZeqNbzIwY69aDiYRbb/nTa/vE1zXC5DE3h9coXDg7XgRR0onDVs+r70jFsN
	 c4zLQ4IhOtQZ0kw3ZtOqQvmDG63/fngZBXlz/a9pY9vlub9hTQZkHfHhAZ7J21F0GNT74
	 KRRo8HNx9C6kXgCqAWvcMsGI2qHCKiWDhNFL8dB5UuLBsEMq2b7BSaxmd8XC6wNip2Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095208;
	bh=3J3Wi0fEe6pHa4CkySVdxWy/3BAZUKboXH2UiuzUZTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G3aUUpnP0zc2bGk87yFpMMYstW8iqgJtQUngmLoMhMsrINZ/+/0nDEbH9aFaeBOrv
	 95wv4Go9uXvuCLw6UUsbguWBFD08unHwZu81dQmpf4YSZ4eLvudrLaQSCGcwrEbDcf
	 7adFgrd1bbbDWTwx+y3q+K8bZLuqnjHu04uHlwfZbgUDhlSiw6/0sluqtAoVt+ysaQ
	 P/z+HAysVTRpT+eOOAKiIHdg5GRp1RyUqm7fgqvkRVkiAxUQXP5nF0T3pSNvU30OV4
	 QCHtfj38NaV3OWxZS1f1DCKY++yhg0qdGx7RfzyQpvcqJiekvBqfOQo/G1nYoIkG+I
	 uz/tJESYUio0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3580040AE4;
	Thu, 19 Nov 2026 13:33:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A379BA32
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86B034052F
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nJjJcpZ64cHR for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A41D440527
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=u2i/QZhs
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A41D440527
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:21 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so1395055f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095199; x=1795699999;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3J3Wi0fEe6pHa4CkySVdxWy/3BAZUKboXH2UiuzUZTQ=;
 b=u2i/QZhs9n5wscyWf8ZngeXagoXrwb1zjBCIlZ9MA55JD4y2czeyTP1IjjIy8el0BA
 +2GJ6BtdggffM8CXJs2TYeaX7VU34MVYy6BNTTk/IjA4g2MmzeD5ToaIC4aHlRJV/1MS
 ZJuyNLJAzR5vQUBkudMuKBVSKMxOyNLt5GaCU+CgNjhAVk2llgckB+Ox+YL5uFDooz/4
 Q/mrWGA4j/9JKPV+O1RckOg14WoQ+r5t21UNeBbyQLYJG3NipAJV2ph48+PMOqYVyq/E
 WgRv2EFw+X2F/QsRtCQ0IGnbeJhuOhAeLavKf1Cvy8ci2M3F0zuKvq+SVSDV7rcRKQME
 wEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095199; x=1795699999;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3J3Wi0fEe6pHa4CkySVdxWy/3BAZUKboXH2UiuzUZTQ=;
 b=jb0apd5lboPEye72omxOZ6ypxcmiMlvxU9HuzlKQ0YTviXK70K7OoT1R7KspaOjuHV
 8CDr0tg0B9m3QfTvGgsfyAonP57WSgwV1AiTwRaBWYrfkK6yzEtTmvA4sAg8slEUyQGy
 5Zt5ZDtUVAFDxn60/X2a8B/8ftNsbQclBIp7nizRvpVAdUAIfjLJez79ijzMpXi52HKU
 s3ISWHXExLkbSdCVoFh9vxV1tDBiQFrZg5nnEuI4Aqm3juAKRW3nTQ7iAQ411+P2TYFX
 zfcO4hxaYV9pF5Ewyo4h1loXnSfoHoYS8T5PGs0/1bYfoyUNZvRQaXz8ePjDIJeZKb2I
 JX2Q==
X-Gm-Message-State: APuU4Z+v9ixcJ+sqv9aTcwvVbv6M+/g/hWEU9Q/QLLkEnaFwNqnwE6ZO
 Df2jojPUok+4nguWi1IkwLzHBtOrnLk4YFo/OvxWg2bNod5eEkKsr7LOIgZa84b5
X-Gm-Gg: AZFdTZeE9m56fUYUZtwCqbyYB02AC9ZxItzvLPBHtxOgZHUEW1hIlbWIw+ckHKGsinl
 1JHHP9DFzWtdmGYtsCy4OY/GUKl1hK0181wX8pSWjl2PUo5eV6DJCOQXzwXn+lc3PDAHTaXtDw3
 OfzzyECRi+pxCz/CX51YSdnMAJEJCBCsZrKfrnwwgu8YAn9kOJewJu7QRjaz/mqKUyHcJFTIE+M
 x7Tvbho+wR1vSOXwnNNpaJywr0dOIe/hAZGZjwG1Mev0maPpNi1Y1ZrkMy/JiKIIR6XtUuIHm+u
 h4/A14k4ThK0m0dVQV0P1jdfIyDpFURtGlIafOZtY8f7ioa+TyTbrlljnC/Sl3hjEowmzLcyYx9
 rHRE1E2zREbkYbvprn4npFlw9ymuOpNyWO5yC9EYDuFuDoEHCZea3TxwmZ0ILagzXagYjMVIa2m
 evCTEHJmcQgUNUQmKhWt159YkX3MQFxJu1JdzPYEmnDxQBkYHpNcazblpuvhFWUGb5EypXw7n4S
 pfVPprC9SY9voZjYSKLNglggGZJeS1TE63VCrCAFuoxX4//M/p9C3i7KFnAePaP3pXwjxJ/w91x
 l1Lky6hI1nstJoZYW0RnzXYL9ZEMgmzbxh47snBMWgjrkP7U62VzrMW8Yk18JfzezN6nvav5rsu
 S8HgdweV8so2Eary2x9tfEumWB8Yu7/BdKa189V6QVVsjvbz0YqVQwFQk1afVqBtBWATfn5jh+g
 duRiMedME6QcqjT3h40N533uNcYmbMguKH6R36ArOd1UsBK23m2nsZXg==
X-Received: by 2002:a05:6000:40e1:b0:4a6:4b32:a2c3 with SMTP id
 ffacd0b85a97d-4a64b32a30fmr12433752f8f.17.1795095199224; 
 Thu, 19 Nov 2026 05:33:19 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:18 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v3 05/14] powerpc: mpc85xx: Use the private libgcc with LTO
Date: Thu, 19 Nov 2026 14:33:01 +0100
Message-ID: <20261119133310.22732-6-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The LTO link rules put $(PLATFORM_LIBS) inside --whole-archive. This
works with U-Boot's private libgcc, but pulls every member of a
toolchain libgcc into the link. With Debian's GCC 14.2, turris_1x_nor
fails to link with CONFIG_LTO=y: ld rejects the hard-float members in
this soft-float build, while other members reference __morestack_fail,
__tls_get_addr or __SDATA_START__.

Select USE_PRIVATE_LIBGCC for mpc85xx LTO builds. The previous two
patches add the routines it was missing. This has no effect until a
later patch allows LTO on mpc85xx.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
---
(no changes since v2)

Changes in v2:
- new patch, instead of "Makefile: Link a toolchain libgcc outside
  --whole-archive with LTO"

With the whole series, all 71 mpc85xx defconfigs link with
CONFIG_LTO=y.
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f20d58b4de6..b4883e00458 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -21,6 +21,7 @@ config MPC85xx
 	select SYS_FSL_DDR
 	select SYS_FSL_DDR_BE
 	select SYS_FSL_IFC_BE
+	select USE_PRIVATE_LIBGCC if LTO
 	select BINMAN if MPC85XX_HAVE_RESET_VECTOR && OF_SEPARATE
 	imply CMD_HASH
 	imply CMD_IRQ
-- 
2.54.0 (Apple Git-157)

