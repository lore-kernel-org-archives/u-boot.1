Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C7BC55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62B84407C1;
	Wed,  5 Aug 2026 21:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rCwT5BC87Iag; Wed,  5 Aug 2026 21:13:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94F7E405C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785964411;
	bh=RnWUBRtWJiplre4SFtkmAm3khbgZ8YOHcnoaGVBoGEc=;
	h=Date:To:CC:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=oxhKqVzJTGRR+tewaRAku3x/YchbDxzhFAVoq4IyY79C18Qb+8MsQuXi9xN8MYrsN
	 poVCJDob1D/1hmkCL7fCWqH5IAQZcNO20zVGVcLX54IxYe6orslYveoc4fS4DyghgG
	 tYyf9rG3IVkxTkhL0x1zQ0LxIh18qUBR9p8HInvHzliV/foydEDhI/mTazGEDSPOgx
	 0PC8RpEj8pXSzaqRwjtmaI30wcN9TaSrMGUP4XagUdDAwm7Nh1z9/4XAV+GGmPduQg
	 9sIjukd1HpF5RV8izMWRB0X4XafAmzCecv+ZAIkK4ghccfTsNGl5jNxfo0BwEd1qS5
	 PVcAomEuiQyKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94F7E405C5;
	Wed,  5 Aug 2026 21:13:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9241A29C
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83CA4607DC
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FukfbI-eVmiE for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:13:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.121.94.184;
 helo=ewsoutbound.kpnmail.nl; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 89179606C2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89179606C2
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89179606C2
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:13:27 +0000 (UTC)
X-KPN-MessageId: 7d896055-9112-11f1-a5a1-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 7d896055-9112-11f1-a5a1-005056994fde;
 Wed, 05 Aug 2026 23:13:22 +0200 (CEST)
X-KPN-MID: 33|fHy7oCxrxbBKU4AjmyJZeToEJFgTqw4alVdN9Fd/2ipNQH8HPvk0zPCdBMv3h62
 fxwMC01ZamnE0Pfh0oZSVPBTr3jJlJ+TRp1cIPaNnfdQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|m56hrOH1mpgVAMfKk5gP4iOd08Jt5PePV8YZczhCBtpE/RwbVmKwLqmz8AxShE8
 JRmez5dF+kIucu6XVQg4iWA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 7cf6d7dd-9112-11f1-8dda-00505699d6e5;
 Wed, 05 Aug 2026 23:13:22 +0200 (CEST)
Date: Wed, 05 Aug 2026 23:13:21 +0200
Message-Id: <878q6k2rv2.fsf@bloch.sibelius.xs4all.nl>
To: Randolph Sapp <rs@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: u-boot@lists.u-boot-project.org
Subject: Bogus error messages on Apple Silicon
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=RnWUBRtWJiplre4SFtkmAm3khbgZ8YOHcnoaGVBoGEc=;
 b=KDDUS+9drT3n92Kzn7YHjOu8aS5FojaP95wRYmdVyNsRaF6YfsFifj7miZjyFPEBcICu0NevM0KvQ
 huhS22Wp58AaHovHW/ToqTd+uASLlA85aGRZJvlfotqzOmy66ItKLBYUxXeW8eMngq81oPZwFAZymX
 Nr9qq/zKr7Pa4/V3gMiFu5Ukqko1E8OZk3LlX/xRcGHelTpN/uGUHnR2mwPlsjy1JEzT/gIw5yW8xP
 JZSoiQuIJXo7cPYNsWz3MljW+trioa/3YKcqrajDvShrLaQm9VjOSUlsfdau/1+pglW6Wfn+0ymO4Q
 /NPv9RkeXPJo9UbdiMMV9zEqS54NbJQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=xs4all.nl
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=KDDUS+9d
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
From: Mark Kettenis via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mark Kettenis <mark.kettenis@xs4all.nl>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Randolph, Ilias,

After commit 623f6c5b6ab7fa2 ("boot: image-fdt: free old dtb reservations")
U-Boot now produces some nasty bogus error messages on Apple Silicon:


U-Boot 2026.10-rc1-00115-gbaa64b2f8928 (Aug 05 2026 - 22:33:45 +0200)

Model: Apple Mac Mini (M2 Pro, 2023)
DRAM:  15.3 GiB
ERROR: reserving fdt memory region failed (addr=103d7f4c000 size=854000 flags=2): -22
ERROR: reserving fdt memory region failed (addr=103d6c4c000 size=1000000 flags=2): -22
ERROR: reserving fdt memory region failed (addr=103d7c4c000 size=300000 flags=2): -22
ERROR: reserving fdt memory region failed (addr=10000218000 size=604000 flags=2): -22
ERROR: reserving fdt memory region failed (addr=103fff74000 size=4000 flags=2): -22
ERROR: reserving fdt memory region failed (addr=103fff78000 size=40000 flags=2): -22
ERROR: reserving fdt memory region failed (addr=103fffb8000 size=4000 flags=2): -22


The issue here is that these memory regions have been reserved already
by the previous boot stage and have already been excluded from the
memory listed under the /memory node:

    Node 0x22568
        name: 'memory'
        device_type: 'memory'
        reg: 00000100.011e0000.00000003.d2a34000.00000103.d3c18000.00000000.00004000

These regions are listed under /reserved-memory since they are
referenced by other nodes in the device tree.

I suspect there are scenarios on other hardware platforms where this
will happen as well.  Can this be fixed?
