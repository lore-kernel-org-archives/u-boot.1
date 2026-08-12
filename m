Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DD8C5AD5A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 19:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABA31607DA;
	Wed, 12 Aug 2026 19:33:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qAJHEcAXCwrN; Wed, 12 Aug 2026 19:33:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4C566078E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786563182;
	bh=vY62d3Z2mcXlAxt+kGiqvo7qGuLhyL4TRKY3K5sZ/j4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=tmpqFMF9ANswbnrXGTT6SBKivfoV3deBug002g+uIlkHubLnIaMCEyo0RhcDWj8Z1
	 Xu+FJf4bD5vWZOS0WT8eH1hPOCWPxWo+AWGlN6RAKaNohzBdf7yu931TpnaFs7RDCf
	 A1Tl7CaQhZnGb+1C0cUr6/LOh+gm6U65c3UIRdAs/FTxXzFbLtuYjdMKv3FGjJ+yJ/
	 1JV5URMDq1AHbDjeVSskhJ9DQeBy21ffReeBp60S5etwbPzWLqLkz1hs1c+qkevl09
	 TZtzJvuvXmWNo93bEFnELvIGJQWsbYoNugqCEz/gb7nWvHQu+xIQPkc11ClfaUbrfK
	 1MWt/fDZPTuVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4C566078E;
	Wed, 12 Aug 2026 19:33:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A1A25270
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 19:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B6FA80E7E
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 19:33:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R7liCNkc1Ofu for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 19:33:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BD9FD80E81
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD9FD80E81
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD9FD80E81
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 19:32:59 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hKzD82G4kzMlCF;
 Wed, 12 Aug 2026 21:32:56 +0200 (CEST)
Message-ID: <6bb58612-6b26-40e6-92f3-fcafae0739ad@mailbox.org>
Date: Wed, 12 Aug 2026 19:51:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: Add missing fragment for Versal Gen 2
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org,
 git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
References: <11956eca5ebd0b3626b7e2d0fa52331cbd3dc1ec.1786361819.git.michal.simek@amd.com>
 <f29ac2fa-4d73-410f-ace5-819c2a459cb5@amd.com>
 <f71ebcbb-6cdc-4c07-8d1e-0f39ccbfa141@mailbox.org>
 <5ef6b6eb-5f90-47cc-8c87-872c01eaf3bd@amd.com>
 <b3e35156-e1ec-4be4-9693-df16eb82016d@mailbox.org>
 <d0bd0863-e094-4b82-9635-6798960a08d0@amd.com>
Content-Language: en-US
In-Reply-To: <d0bd0863-e094-4b82-9635-6798960a08d0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5e94ee707acb318768f
X-MBO-RS-META: zpttkfwspd68kuxb1d8ekr5qjrs96dgs
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786563176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vY62d3Z2mcXlAxt+kGiqvo7qGuLhyL4TRKY3K5sZ/j4=;
 b=nVjmLDpWrZq0yJfqHFMZyLwOEOCaiK3IJ4I3xBPGXH55xGynQgcq5iMVBKzSFXc4Dkwei8
 BkhNzBve7xckij9EjR+mXxYkJzh3L3P/0KrVOstP/kxC3vqu+Vxbl2cnwBQW+Ugr1OH2sN
 eN5D3ce3aPq78QK/MPzJcEGFbVWWWtoH1/VEcCGV05Za9QkQt4+6qrf9jtE5n1+m0lbbil
 6aF38DLWDGQDXdK/8FKyE2URoKyg3/Hz+zIv56h8M3TJEDtzO6i0FnszJMW5wTq1/xYJtS
 XLU6HNtZG+mI8xlFpWI/YKW5dzmEc2SjwFUdiKj73t9eCPAcjGlDLsdSYz5R2A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=nVjmLDpW
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/12/26 3:33 PM, Michal Simek wrote:

>>> Before
>>> $ ./scripts/get_maintainer.pl -f arch/arm/mach-versal2/
>>> Tom Rini <trini@konsulko.com> (maintainer:ARM)
>>> Ilias Apalodimas <ilias.apalodimas@linaro.org> (maintainer:ARM)
>>> Michal Simek <michal.simek@amd.com> (maintainer:ARM 
>>> VERSAL,commit_signer:14/15=93%,authored:10/15=67%)
>> There ^ you are , what's the problem ?
> 
> Yes, I'm listed - but under ARM VERSAL, which is a different SoC family.
> Versal Gen 2 is a completely different chip with different features.
> It only matches the ARM VERSAL entry because of the "versal" substring in
> the N: regex, not because they're the same chips. (FWIW keeping "Versal"
> in every new SoC name is very confusing).
> 
> Also Gen 2 specific drivers/files are coming, and those should be 
> attributed to the Versal Gen 2 not to the Versal.
> Creating the section now is what makes that correct - otherwise every 
> new Versal2 file silently inherits the Versal.

Why do we need 4 or 5 MAINTAINERS entries for Xilinx platforms, with the 
same maintainer, same git tree, same status, in the first place ? Why 
not have one XILINX entry that covers it all ?
