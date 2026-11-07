Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3BB606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EV6YroyO;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=rPuI/op5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB5C34087B;
	Sat,  7 Nov 2026 09:02:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 00ApXHZgFrFe; Sat,  7 Nov 2026 09:02:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20889407CD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042153;
	b=r64qxvpnVbsLbBY513IUf/J+6ujyN3lIGu8n7Gfs/4LYpYhEzWlGNdQAJkgfsG+AkRfm
	 LRozR+Esud/LhBsyC20Ue82gJTuHnlXbULXB5gsAWiFXUbpeL8mhQ6iv1tRMpWhWGywZh
	 +X7/BPcd+AXRDRhUM25/f/QVgt4+ELeJ3DXRCRsZT8VV1k4tAoW/dx2zXApeUkzIZSKWL
	 yvK7mPkkY7kHvtE25ywQ84pcFlqGkR6RBHfXH1c7WGncgHC/WEA9fj1yTWFkfkLsa73lq
	 Daiq40n1GhlSFkFy3TErCltcdJ+Y1hAoT6vTbdNaatQuE9RlhRMyjB9NBvjLTJccLdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042153;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=URjQwGSrlWQushNs+FgPOSkH/kObnz//HNvwtfYgaoU=;
	b=KfUWo6FLJyH8Z5r1fMC/YG5Q2/NfaDOOHYkx87jciMZuv8x8lDUSToLyrcga10hmS7e0
	 8hApKxb10qOZN6l9aNg5CS+p5UJU8fGD77VGQT4RcugXp/65GD5Op21bs46hRUbkrsZp/
	 jckakfCAgUBMiJY5H+5ZdxvM7oEV2U+z53D+jRC9d2vks23XcpATyb6tzBtKgEI2jXV5W
	 AOWnijCkl/4iWlfvb/1OexjzkA37kEOdT/DcXxQLOSLuP2d7O4UVPkEvIL5m/0hlauUE6
	 xI7rccSX2t827IYDRHEOVkFAYzyqAXyiAnM+DJQlcg8JMspdCMS0oCp7CgHfPIhdTPw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042153;
	bh=URjQwGSrlWQushNs+FgPOSkH/kObnz//HNvwtfYgaoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EV6YroyOkBWefZFM8qIkmgQr1rDjWlRpmpls4FDUtgqgJW94m87zbSFFQ8jmNKgZa
	 LcEP+VX8+xaiu7KYFGr+rFoVsspHy6o7LtU+HTDsqJTDqsHBPg5f+5a/ZHeRBaQnog
	 N69eNYSvcMiR0n4WK0kECa/vVMzRikiMum2hatAfx1qyIVcEyXvWnHU+I2MQgkyiCl
	 opYxzf2/SuCdfX4KSVPqXpIX8NqPEweQbOVUmFhNjy+loazof9Qdr7HOniQG8h5gk5
	 BfJQhU7AVB+YJkdvRRUUUBmtLmLakjxcCV5ZSmjw9xD5PoWL3R6gVWqkZp4aySsckx
	 sbirCTY0KyAMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20889407CD;
	Sat,  7 Nov 2026 09:02:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EF6A11C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D9E6460712
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IZtmc7dYjgvB for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:02:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2CD4D607A5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=rPuI/op5
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CD4D607A5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:20 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jM96J1gSRzMldj;
 Sat, 07 Nov 2026 10:02:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794042136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=URjQwGSrlWQushNs+FgPOSkH/kObnz//HNvwtfYgaoU=;
 b=rPuI/op5qAh203WkQj71Itbb9PViKpsQCokUmcIzaJrsEuJKJt1HXMgCLKMAZsWDtMIYnC
 ubUJ5AsH7s5BcHprx10JgLOkhllpdvBECUz/Ml0tAvlkB0gbRpbJ65Il+/lewU9gtRsCAh
 181wwCSs0k25KkzDQSiFI0uf30NzEouSnGx5bZdBfT7C7xUpkxmEloszSB+UZ64sGTa8RJ
 SoAWHpNPI8IZvVlbBDuQ2wyfPcoQ9SONj7TE2csodOefnX66HkgchLgI/yJzH4UE2AIS0p
 fw6RYWaJFqOmMo9L8ddEjc+Ccutbx9R5shRc1xLedO53e5UBgd5KGlTLsT7OKQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 8/9] watchdog: sandbox_wdt: add get_timeout operation
Date: Sat,  7 Nov 2026 10:02:02 +0100
Message-ID: <20261107090206.2015512-8-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-8-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-8-07de25b6312a@nokia.com>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ca53f6fcd86e4787d83
X-MBO-RS-META: scp898nfgrgapioap99soqhie3hanoq4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 11:34, Juuso Rinta wrote:

> Implement the get_timeout operation for the sandbox watchdog driver.
>
> Round the timeout in sandbox_wdt_start() up to a whole second to
> emulate hardware with 1s granularity, so that the effective timeout
> can differ from the requested one and the tests can check that.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/main

Thanks,
Stefan
