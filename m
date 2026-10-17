Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA008CCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 17:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF6A76067D;
	Sat, 17 Oct 2026 17:34:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xQi8RZAOi-cQ; Sat, 17 Oct 2026 17:34:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 12A6960632
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792258441;
	b=O48iR9JzxsGUWbkotyUcDcUr5rG2GjxRtPS69tbw8TbSpGei0ms2KtVPn4JaMKnBIpyo
	 xqxBue8c9ijC1a7BJKIRxK+aH+4l/6RqycqSlEzo2P2p5k5SkayfoMbjQKx1C8Byxx+1d
	 o5SLzmdqhvIrTqdcvCOZxlq+5pKa4FUp9SD0ZvQpPDMMy4dQ9xoO72lrKAHXX4fCbHSIS
	 h6TYWXrkhAkiHWjsr+NJDVXubmwINGMU8vMmYtSFyXX7beody0R4wVa2our61XpnzxlxA
	 PjQEj/jyoIUfYv6PsiDCbmbl7yBM3fC5B5HI3lcfMkbp7Bp3sCOjBRDuE4ztYijDKZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792258441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jHgjZcGbZwCvo7vR8V3WRC9kGBlpQO3sDCZoZgoBu5g=;
	b=HXW4tc7KsG7irkKCblH0zo9h2I2KqKpkQzEFrezuic6ndPP7oE5L83sd1dcUdIjY4CUh
	 XieiOMU/1GY4qsCE1sXlzzmjJ0TjpERn1KO+HsW2iIcR3f+PHZ11iLVeCQKY/lmtxSmOq
	 MhxEWAbCRR5gU2JYYUd0HsEonykId57O47c5q5VLQ8cnJNYHonJ5L7M1cBjVi3BwVkJDj
	 uD+6U4f/1J3ZrmgSk8pQjO9rt1A3l8Smz00JlF8hZpUjI999UJ2l1dSBkRybETLdDTDa2
	 dPHCUOK67xKikhE/HwKxkRuWaqBBxPb26hedqfFzOnOp9KGzGITL1/qgsFTWIVH1tVg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=GxnsgYSv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792258441;
	bh=jHgjZcGbZwCvo7vR8V3WRC9kGBlpQO3sDCZoZgoBu5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m5RsJqEi7rxkY0NJ0/HGjT3rlPNnjTj2QuLhIU61Xu1HLDTszD6WBvaCAFBqIuyQB
	 s0QCefmafdwNjIL3x1xGFQGCyCSUV9IySwCcuq6jn9oiMB4OlP0wcjIsmxdzAVW75g
	 e83+uCWtQ2H5UasYQW+r1q8duaLC2iiyTHLD91/HfFeS4Rcr4YaF4aBZEpPV0WzYyd
	 3iFKcbv2JcY6LCIVjrNVCw+Rs+MLBXD9DD5pjNn91EFpemQk+ojUsscQx6idJIQPZq
	 qsBLcIAKQoIPFXv4U+403B7rSfBEVMIyBwrx15vsl7p5d0Aj1cwFM2ZRz+9wOA0SF/
	 bctfsHr8gHZFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12A6960632;
	Sat, 17 Oct 2026 17:34:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DDE8977
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FABF6067D
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r-46Br5oILAA for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 17:33:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6897F605F0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792258438;
 b=I3ieHqjmbKWFW304gVwD4GqCnpV9NOT2X6tHFTPHGu4LMLy8pWynnK36dJEo0rOLpr+e
 32WqjRDQsvlBp/cWNsUJGCYdvmpoDHBZr/3BeV0yAqbcrQ9C9qp+phTV0YhzKGjR5vgUj
 lnZI2eHU4na89zp4xxJxPnfvWTri486AvSk1sI2J0uCxkmL5wFH+7Bb6Akgy8GpK9SAzQ
 2aty8/EO3qvhzIaiEbS34SxgQoOft+9fiPUBiYpeg0k/EaK/jj6USRXQOpWzI3kZ56agG
 d3bgFK1HZv8gtDCRbm8exx0ydNdOyKGkKv3vflA7iAzP1OQmwOtoY5ZTvpxNvbObntQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792258438;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=jHgjZcGbZwCvo7vR8V3WRC9kGBlpQO3sDCZoZgoBu5g=;
 b=O5FCtDXzmUCo3/e131XnQJNVMEnDdcUy4iivQ5oImuBJSJbafMD5cpM//hN9rycpVW1j
 BWLPUXBLtcGT6FOxD9nDet8+uCDW4irUEQq7If7J5ln+GXUqOJ1kBkrR+FvUvFVT2GHew
 cZV3p33srqyVS2jupfUTasL3y60Dmf/OGSDrkOi8Ry4saC5pmpz75ZnkOZ/ITIZOxixFN
 k576PGFirRkIL4JwLbvzIP8zMXrb9Qaj6ZZ0VMsSXhoqosZRCQdm14jVcVY4LOzsyq0Ni
 SdEDI+BVWuEfmVB9k0mghn6kj3IlAaTo2DnidtD5Z6PFjZUrnSketdwriywgTqE07xg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=GxnsgYSv; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=GxnsgYSv
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6897F605F0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:57 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j6TSL20NlzMlhB;
 Sat, 17 Oct 2026 19:33:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792258434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jHgjZcGbZwCvo7vR8V3WRC9kGBlpQO3sDCZoZgoBu5g=;
 b=GxnsgYSvOUPKtGJhlkpo2DXaslhLtkPJAXwpxRiEhB2NmvHfJuRRQH08V+gmS1xaxUikGc
 +Pu//iLRzfgT3vBsVeNBDYvrJeLdhDf/ggQli2tu46jLz3Q288sxnYAK369ifUGpbjStNq
 VHJQXufyc/vbAHPJeTSzAFWakJFklqL6eGsc+YubSIr71ozOSfgLVb4dA081aMmBZnLmdj
 XbZQqhThyW7aBFaw8DMj5rwQ5A1vuTM48pHgLsVsseZjLDT/19gzkS2yw28SGTRV7K9Tfr
 JhM/nHvp6yQgAdScsWMOYjJqRTavdifPl+GQdBWzlU9hT/uEekxm2WPyOQ/7kw==
Message-ID: <a3d05888-49bf-428e-9a04-d6be1de90ba6@mailbox.org>
Date: Sat, 17 Oct 2026 19:22:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kbuild: Do not pass -Wno-graph_child_address to DTC
 unless supported
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?B?SMOpY3RvciBPcsOzbiBNYXJ0w61uZXo=?= <zumbi@debian.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, "Rob Herring (Arm)"
 <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
 Vagrant Cascadian <vagrant@debian.org>
References: <20261004061826.1028380-1-marek.vasut+renesas@mailbox.org>
 <20261004061826.1028380-2-marek.vasut+renesas@mailbox.org>
 <20261005205924.GF3724959@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261005205924.GF3724959@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 49658f6e56d18028478
X-MBO-RS-META: nkam5rt1zryjb9rhsp6kt1qxu66zafny
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

On 10/5/26 10:59 PM, Tom Rini wrote:
> On Sun, Oct 04, 2026 at 08:17:43AM +0200, Marek Vasut wrote:
> 
>> DTC commit cba90ce82064 ("checks: Remove check for graph child addresses")
>> removed -Wno-graph_child_address command line parameter. Apply this option
>> only to DTC older than 1.8.0.
>>
>> This can be triggered on e.g. Debian Testing (as of 2026-09-07) when
>> using system DTC:
>>
>> $ export DTC=/usr/bin/dtc
>> $ $DTC --version
>> Version: DTC 1.8.1
>> $ r8a779g3_sparrowhawk_defconfig
>> $ make -j$(nproc)
>> ...
>> FATAL ERROR: Unrecognized check name "graph_child_address"
>> Check /path/to/dts/upstream/src/arm64/renesas/.r8a779g3-sparrow-hawk.dtb.pre.tmp for errors
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
> 
> We should just drop it unconditionally, both to easier match up with
> future kernel re-syncs and also because the DTC commit (as I read it)
> says the check itself was flawed / not useful.
OK
