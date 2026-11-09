Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F85606A323
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DRt5CRxM;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=IsLtDMdF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48CE8607BC;
	Mon,  9 Nov 2026 14:43:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o4D_cwDcGKAW; Mon,  9 Nov 2026 14:43:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6E222607B3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794235409;
	b=ZFrJ6vBEaYl/RP6aoVL958GJbs9YrAuD5I6rWyjwkxy9lKptOFhKpiyWTutwUUdkXGfk
	 qfJ8RuZZookJlTOZDk6DWUHjLWdBBV+BLMT7SkUp6CF9ZXmBLKeVI4jA9CSxkdU/xWQtQ
	 fLte0Lu1uDLBlIw+VCrBsBP5lkCP9SO7g2srRJIp5VBhqSrUiAKofxLbJBYSG2Thellog
	 7/gEhszkhxYYW9EMoZhFAhOJCpM1PktFXYME07uk+9FoUimV4j84VW5ZqRajx9nY9YtSi
	 TNlTL7dcRHvNqRWj13GkE0hexVPcGsCYmCXxdEVrow7HRKcOPIR7U+Rlub5T2b4xVBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794235409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MQPH4cCVc0C3XntBaiPnwH1k/7rRjqypEm3DVUb3hpw=;
	b=c06Wwk7FXLSqWKmieiZVWtnelJbBJbrxGk5UZJrYv3YyD1UBplbLPfCLrfbbM2Y62Bsc
	 nRwnfIpgp+vZ/VKbsIpiungYshKwCktVsAJmLpoG3PGZf7sBVNzZN0xxFB/winzRcg/SC
	 Mi/dwjVkhUGCsuRRdtHY7jHWJAX7g0ZTKzemprAi3+sRqCyB1kE+FGFaSZsGrDxVxLagI
	 ZTKqci1IyYNd2k0fGMtI71cys0LzO26PWByRWTo1Sk164q85zyxU/efGoAuWaLn+dj1bt
	 SYqd0lmRl/nEdL0lOMujzQ2AuQaMpEG1fMl11NQvjoTdIQXRC0486At2lyd6yc4X6zA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794235409;
	bh=MQPH4cCVc0C3XntBaiPnwH1k/7rRjqypEm3DVUb3hpw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DRt5CRxMv9fOg4MbhW/ASI1rbM1/AXKd+E8sAUkSxm2su1or0jdQgQU6IDfuz6CPO
	 c3fvNmGlQlaH41qyn01c4rlqRFgmRvJCQeaeXqAYfI5pJNfHMg58xKMxwTJeiTR/FC
	 8atiE9mn9SRcV1NUDF/LX/xEJvVCJAJV3H39La+pOLIBG7wMPN2bbEOyvOhnG8gQc7
	 xLZxMA475j7FbRpgfal929WWsrtO9hn96yRa9hLHIq1r3wx2ort01jDId1ipjfRiWR
	 zw9u1yaa8JomyFv/47QVSsujMn1qYjWkiFfjki+aOpnEIUkK5LbP3bF8Px6OUAuYSi
	 cqQdA8mj4T/8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E222607B3;
	Mon,  9 Nov 2026 14:43:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D7F84B6C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D568E80F76
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:43:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P5DaGRcZuUlM for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 14:43:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6E77680D3D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=45.157.188.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.11;
 helo=smtp-bc0b.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=IsLtDMdF
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E77680D3D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:43:22 +0000 (UTC)
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jNXZw23jnzwrB;
 Mon,  9 Nov 2026 15:43:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794235399;
 bh=MQPH4cCVc0C3XntBaiPnwH1k/7rRjqypEm3DVUb3hpw=;
 h=From:Subject:Date:To:Cc:From;
 b=IsLtDMdFTnP1Gi+P8d/ZE5WcHtfwKJHd2Xg3phqYyarZxLnMHYw1WNhXL1vLSrX0/
 w+TQ8FgJo0CBud+8KjYrosbiQiCp8b+Tp/d+19MmB/jr75P0/YHIXdJvunMKVADyuc
 jAaauHDmMjeXPhy2LpvKR5kL5YScTHHIbUk3+YAnQOPsbsk2eNBPyf71A+eNlJNHsu
 t5LNK5WyDh/j8EFgYVs2HJo7uA8gXI96t5D8YOs3TjPCy36mjcBkSi8+6TpNSTwWaT
 t5c5Oz49TG3s51Nr604374MFg6xPrKbh3fDWIpTNu0t7Y52hYsduwksQ+6tTYiYcaH
 HuxoFLHeMvdGA==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jNXZt4GfkzrQ6; 
 Mon,  9 Nov 2026 15:43:18 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/2] doc: follow-up to linkcheck fixes series
Date: Mon, 09 Nov 2026 15:43:07 +0100
Message-Id: <20261109-linkcheck-follow-up-v1-0-64ee7d115a6c@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMTQ6CMBAG0KtMvjWT0Ab86VUMC61TGWla0oqaE
 O5u1OXbvBVVikqFoxVFnlo1JzgyDcGP53QT1iscwbZ2Z0x75Khp8qP4iUOOMb94mXkfDqGzvfS
 2EzSEuUjQ9289DX/X5XIX//hW2LYPH5ojlncAAAA=
X-Change-ID: 20261109-linkcheck-follow-up-7f8f425e524e
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Viacheslav Bocharov <v@baodeep.com>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I got some feedback on the v1 that I haven't addressed until now, so
here are the two requested changes, sorry for the delay.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      doc: arch/x86: update link to ACPI specs
      doc: board/amlogic: jethub-j80: update shop link to .com

 doc/arch/x86/x86.rst             | 2 +-
 doc/board/amlogic/jethub-j80.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 934995f642a21ca7f35fa9aed5f061394fcba243
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
change-id: 20261109-linkcheck-follow-up-7f8f425e524e

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

