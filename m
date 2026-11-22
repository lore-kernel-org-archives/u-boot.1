Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4E606A31A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DzMzOzjo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=gGOdxGcM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=QARvKd6Y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F2E980D2B;
	Sun, 22 Nov 2026 23:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hxOiiVM_53Kp; Sun, 22 Nov 2026 23:54:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 465F680C42
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795391662;
	b=R9xEufAr/E7HANeCnxhWYCqo8Rab/87x/i5BKTVeRn3hbf4ZBN9Xm0xzkHbbuyQC+d4M
	 8uKFE+Dui6r6wLuAvJMWsFimsDK9S0FvJK7pEiV8tiBI3UbRu3AMZPHAnF6AhY5rVKoHX
	 4gUbP6gH3CIvOCpW2vMzQNCD4g8JcqXytIntENyOB5qTTzV49+3GvDlkU5p3nUv3auiJ+
	 kQlZFvbYuKwc50NnT8OSuphWySxR1GuY6zN5eTR2BPTb8gB/XRyAamTG8y5b+oXPmi/jJ
	 FzbsJ3ZJBkYnqAXqVkWhaMPb5M3rDb712Jc1PxI46JXHONWeL6rFGaASPH3pKmKiJ/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795391662;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:X-SGantispam-id:
	 X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:AntiSpam-TS:
	 CFBL-Address:CFBL-Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ljQSI0tC0tYWrLUY8k1uNF9JYn+htTXxjoMMFO6vPJk=;
	b=kPFgQJ9de/SXg+c7ooTQGUhBWw4+G43pWML1OH+72mIYio/e8Ksh0OVESzEZIl6DnDAa
	 ZeLp/OHnnj6b5PHCiEMXdSmgZ2H92ppuT5zKBfcxVhw1HROQ+aFKv3MI0aFNV7KzS+Wj7
	 iGp+4sv1ybCAMFVuDvjZEWhKTw+nmxXsu+kMWfrbDEojJXzFwoyPtoyL2xvzq2nxWdJHO
	 3Wth/xmAQhYP2Lb4j2jyil26QN/+7IWtRj81xmgV11c6KZPmGWUTLFoDxQ6xjfjzfo4f9
	 aYAAG9eHC8qIMR9ZUN5N2sW0vVIzEmiHkJfZfs+GPjmQxSRRkBYWDslfxz3Q+LD+RuQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795391662;
	bh=ljQSI0tC0tYWrLUY8k1uNF9JYn+htTXxjoMMFO6vPJk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DzMzOzjoObuM6I48ZSgGlaacTihrghGj3UHibD6ktkzxVdQkaEhH5/62YuIu5aDGN
	 uUFFbBeovfOUJbmNN9vqBbEMavNs/82dYTP8YcIFbLZ/RREbypWIrjyGUmX2E6wFW2
	 +716S69JfEP9cwv1qXLV6Wq/WC5Vazt4CEj0BYJRZ6PZAzO4qHTwWKkfqK3zsqR/J3
	 IOp/ev58M47GSdo0SGf0Ait842nLCKikHbYAMvOLuGeAHdb/OBIMH/33Rxd1JIpnlS
	 ui7r118jh7BaqE8QV91gKVY/MOm4Un2t+UlygRRHMj4Qo/BYX9x3/h9NwzhbXbdqV2
	 5/vBCHyMA7MqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 465F680C42;
	Sun, 22 Nov 2026 23:54:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 81A0A392
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73274605F0
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VP2sxuZ3dU2q for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 23:54:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B79AA605E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.12;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=gGOdxGcM; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=QARvKd6Y
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B79AA605E9
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
 Subject:From:Reply-To:List-Unsubscribe;
 bh=ljQSI0tC0tYWrLUY8k1uNF9JYn+htTXxjoMMFO6vPJk=; b=gGOdxGcMPoangwgz+68I9WG39o
 oWqUBuzmY0IqzfSOzGS3lFTSPEeZALMSt8t7x+s3tACVntWP94ITIjibgjwb9yTJ7TWacStEhdkLJ
 Bkkm5k2ljaWyCXFM3RLvHkCwELMh10fHasJnU8kAFpYNe/W7Wa8gNnYqLmGbJ7oSV/qw=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVHNv-0000000B2YX-2d9U
 for u-boot@lists.u-boot-project.org; Sun, 22 Nov 2026 23:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=ljQSI0tC0tYWrLUY8k1uNF9JYn+htTXxjoMMFO6vPJk=; b=QARvKd6Y8g8qHwrZtsYy9c+on8
 75mdbumM6mZunqYDj+krapFQyzDwHJJlZR90l5OoM1QVtzI2Dzuil94m9RoVwZRwtdSn/jVqpzk6i
 AzL5slKp4KLZ0KclLFTpd7JZRTy4iX//KM9woCiOM+fU0Gn7MJw1u4dMA1Bn76OqjfiI=;
Received: from [79.28.115.6] (port=62562 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVHNq-000000005H0-3jFN; Sun, 22 Nov 2026 23:54:10 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH 0/6] Ethernet boot for BeagleY-AI
Date: Mon, 23 Nov 2026 00:54:03 +0100
Message-Id: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw6CMBRG4a2QO/YmbYX62Apx0OIPXBNb01ZDQ
 ti7VYbf4JyVMpIg07VZKeEjWWKo0IeGhtmFCSz3ajLKWK2NZve0J8coM1JAYR9j4XPnrFKX1vg
 jqJavhFGW/7W/7c5v/8BQfivati/CCsC1dwAAAA==
X-Change-ID: 20261121-am67a-ethernet-boot-85a600942b3e
To: Andrew Davis <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037; i=francesco@valla.it;
 h=from:subject:message-id; bh=RTBKm/Niy9gxnlDw0Q91e0ZnqC4HQH7YQBCXgm+Glls=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNnMDXMniL/5kHJzftqN2zHlZ+9otrRs3Spm+D/xg8XT6
 adUm7N7OkpZGMS4GGTFFFlC1t24t2eu+be0DYyPYOawMoEMYeDiFICJ/CxiZGgL2XU6dZ3+srPX
 dKb++PT1h8LFBXOXrQqvm/C9ddOcb2adjAx9e9WfdUtzW0Tt0o3oNL+coJz0j+37oltbS8W8TT4
 xC/EBAA==
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: cc54537b6ab6b096544688543403423b
X-AntiAbuse: ID - cc54537b6ab6b096544688543403423b
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVHNv-0000000B2YX-2d9U-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

this series introduces Ethernet boot for the BeagleY-AI. Ethernet is the
fallback boot source for the device when a SD card is not present, so
this addition is the natural complement for the current support.

The first patch is a fix for a pre-existing bug (probably introduced by a
copy-paste), then the functionality is gradually introduced.
I tried to align as much as possible to the same functionality offered by
sibling parts (e.g.: AM62, AM68 etc.), in particular in adopting
separate configs.

This has (obviously) been tested against a real device with the setup
described in [1]. It depends on [2] to avoid a boot hang (seen also when
booting from SD and thus not part of this series).

Thank you!

Regards,
Francesco

[1] https://wallaceit.github.io/beagley-ai/ethernet-boot.html
[2] https://lore.kernel.org/u-boot/20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it 

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Francesco Valla (6):
      arm: dts: k3-am67a-r5: Fix DM2TIFS secproxy thread ID
      arm: dts: k3-am67a-r5-beagley-ai: Use dm_tifs for DMA controllers
      arm: dts: k3-am67a-beagley-ai-u-boot: allow SPL ethernet boot
      configs: am67a_beagley_ai: add configs for Ethernet boot
      doc: beagley-ai: document Ethernet boot
      board: beagley-ai: add network boot targets

 arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi   | 35 ++++++++++++++++
 arch/arm/dts/k3-am67a-r5-beagley-ai.dts        |  8 ++++
 arch/arm/dts/k3-am67a-r5.dtsi                  |  4 +-
 board/beagle/beagley-ai/beagley-ai.env         |  2 +-
 configs/am67a_beagley_ai_a53_ethboot_defconfig |  7 ++++
 configs/am67a_beagley_ai_r5_ethboot_defconfig  | 13 ++++++
 doc/board/beagle/am67a_beagley_ai.rst          | 58 ++++++++++++++++++++++++++
 7 files changed, 124 insertions(+), 3 deletions(-)
---
base-commit: e578056c766d653270b14557c2a9d8daec414c17
change-id: 20261121-am67a-ethernet-boot-85a600942b3e

Best regards,
--  
Francesco Valla <francesco@valla.it>

