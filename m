Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9FE606A889
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PQyk4M3S;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=B4XCRca0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 289C440811;
	Wed, 18 Nov 2026 07:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JMAyxpZoBvGM; Wed, 18 Nov 2026 07:24:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6140340576
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794986683;
	b=spRutyDj2JE009Dg2PmabBDuFJsCqDMFY8n/7i4QZSttfxf+V6iNXcQTpsbmQX88tY4v
	 icHqTwOi/6OWJ6poNbyH29GomnbyJtRqDx3oZT+5YpR7SEFwMlMaTav/6swqi5aH9NJZ3
	 x/YMRI9ARTUFPpXaozsEj6idFz1pYO7Q0v2he4dyZ8/izmYlf8HD3CqhzwxUhivElP1OD
	 3PK/9ZoinumEf3CW6iZyyX4UsXjTnf/txbXH4GHzQigTnSFuOGC8s1lHDt4W6owGtE06v
	 g9VNFNza1auA6b88pUteH3xY8kWkFr1QsYl/lQ54y5V0ehWQ2Fb/KGJeoTh6PrX5+QA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794986683;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZpVamJk9B1Yv8trk1P/8GUPceE6VVOLD9zC/r95MqJg=;
	b=CWSyAOM3w0T4GDTlgFlVueRZTgRLNTb/VMECCVIIy6NRe+yOTrv3eJOv/VKxhS+f25ll
	 p42dCMKI7/bHaBOIpIWyNgn5zzCJjuPbw74rxIWW2QXmdumnK6ObmEVwhjIxPwbRIuHqf
	 zCJhYfhoOhRXptiUvPBg2FFmPfFhQ75ZCKqFOAcXQ48FqPza25rSo58CUpddmhBnEwVN4
	 xB9LLRzeNynBo/vgkudRzslEYmJVUjckY8pfMkY/kA6qJlAGR9Ug2hgLrLt1OCaOFFN7W
	 m/PIHYwfIxKOQNIR9UUFX551Jc5U/9w+u4i0wP5oCKAHMC04CmSi2hkAt0n01mtgjuw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=B4XCRca0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794986683;
	bh=ZpVamJk9B1Yv8trk1P/8GUPceE6VVOLD9zC/r95MqJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PQyk4M3SsyAwwBe615uw1gVpDc8Ypi6A+CN+j1S3g9aCdj0vWiH+weChLD4MebZ7W
	 YjMEwf2Kd+Ca7TJ/bg7bU9JaSwD3qDiSbEsm57IpYKXLji5sulxV7Y6mYtYLck15Cg
	 Kwu9xpxKDASMLVAOCCqdQUA9fJrWHRZFevuqBNBqhFuJgBd7O5UPxaqzunNcRo62+9
	 6kaKRZTJL78hVmz/tyP/6tksnVH3VzK5TABEysXpALSzXHMtujKy12oOblu2u7iJ7s
	 PwFJ+AMm4COc5oKM4Kk6A3o6mqXYl+Vw4tWnqThyICTJKQBYxoe26TasxMXSjVDU1k
	 FoUPGSAGoblnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6140340576;
	Wed, 18 Nov 2026 07:24:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80C7A1E7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7DB9240576
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:24:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JFqk8pwsIllo for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 07:24:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8BBA14055F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=B4XCRca0
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BBA14055F
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:24:40 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jTtQZ2Cp3zKvht;
 Wed, 18 Nov 2026 08:24:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794986678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZpVamJk9B1Yv8trk1P/8GUPceE6VVOLD9zC/r95MqJg=;
 b=B4XCRca0TbUPNB3uO9MymIwrV4czAXFKtbwAbc/pmuU0DjZgFy6kPlAmE+m437Rd6SX9Yr
 WKRBlXbCIzSC5sgIP4Xf4gYemw7KE/Glx9iYzlJPG4LQHvl4wmyDuPmauRCMVt/73ZtnpR
 Ai/bWQancGt5XgmMGgzUIR90c8rsbsFRK1Nu3uRWO1BG2sXy0gKwBjos6DuW56sUNwRMKu
 l7DWVgxQTltpZX3qlfK5eMdzyH+EwVl9gOEJ0369+jEArx4AEL58jWn4Bg9R1sUTCderds
 Xgt1h//njHzhKdOs9GUPiJNRXiASWXsWfjRIShllkZEhZZSOXUBW0IzP2V4EiA==
Message-ID: <2ca62998-18f4-4d20-8a0b-a4dec28ba34f@mailbox.org>
Date: Wed, 18 Nov 2026 08:24:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] clk: altera: Constify driver ops
To: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
 <PH7PR03MB7063CC325305C2B9A92A091EAD7B2@PH7PR03MB7063.namprd03.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PH7PR03MB7063CC325305C2B9A92A091EAD7B2@PH7PR03MB7063.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 759e8aeef09a971179e
X-MBO-RS-META: hrd3eqr3kf8of18hcoptfg5e7sxmy4hk
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 3:27 AM, Alif Zakuan Yuslaimi wrote:

Hello Alif,

>>   drivers/clk/altera/clk-agilex.c  | 2 +-  drivers/clk/altera/clk-agilex5.c | 2 +-
>> drivers/clk/altera/clk-arria10.c | 2 +-  drivers/clk/altera/clk-mem-n5x.c | 2 +-
>>   drivers/clk/altera/clk-n5x.c     | 2 +-
>>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> Looks good to me.
> 
> However, drivers/clk/altera/clk-s10.c still has a non-const socfpga_clk_ops table.
> Could you fold the same change in here so drivers/clk/altera/ is consistent?
> Thanks.
> 
> Reviewed-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
I sent a v2 of only this patch in-reply-to the 01/20 patch v1 to avoid 
flooding the list with the entire series again. Thanks !
