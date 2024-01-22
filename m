Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3BAC47422
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 00:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF834878FA;
	Mon, 22 Jan 2024 01:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="F9tOFJAd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nbAnsdyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C0908791D; Mon, 22 Jan 2024 01:36:58 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDABE877EC
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 01:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TJB9y4Bcgz9sbM;
 Mon, 22 Jan 2024 01:36:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705883814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aVsgLgVPMwvYGT6aRuk2Q3LR/FCXfp5DvFlQHgRhe20=;
 b=F9tOFJAdHV0ZwkvZb50ycZ6fMsR0dM9DpWQpEqaaTaOR/rye0OZNILjFVLixMByY48ah1i
 d4c+q3QfmJeN+RlLTMVJ3cVgDuhEcluOut9SBSWg6sxqd8sgjqS9+1iajpCNM3wwMANz9B
 IW49MIN7FnuLbWUQOK8K/mym8qPl5uLoDhZiTFWjLkq2IYu/ejfiabDdD9X56o78UFKyLa
 u116yWb1EXZeWYlk7qXccNpMyXZox89mxoFyCLWHfCD301QHkn9E0QD0OtQxehc0ZzSoHz
 lwHH4gJixijeaHYPmCXrzbru/ZkS8A2LdmGhy9zemXpsUqGiBqyW1T8Jsljj2A==
Message-ID: <91bc8e87-edb2-43a1-bbb3-4dc2649c1033@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705883812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aVsgLgVPMwvYGT6aRuk2Q3LR/FCXfp5DvFlQHgRhe20=;
 b=nbAnsdylTl4VtnJpn5U+W8ixzvxQqA84tDmI/hgBqtZSdbDo05rEKGue62WYdoatrs9qyx
 7vtPuaX4xD3p+9sYiGRxdr5tZ/HaIbOBMbsSPNQzRNuV6ETyPFrZdSkUtVPduKYuou4XHB
 54fUcsBZyaKVYHc7WLdE7a92I8i6njCSeTWDhj7nmFsJlZA/QO7sFfYuxF8LnWemWCYeVY
 M5onT7vJncGpddgS3TnDZvwTZVYXuJTOiyx23S1Po+MYRODjVNhPfKYAZ9ej73LlgS35wb
 S6wj8j8Y98bjIKqYk41ZsnOHl9D0ElfiuxyIq+u+8oclVnNLtvEfNM2L5dJCdw==
Date: Mon, 22 Jan 2024 01:36:51 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 03/11] clk: renesas: Add R8A779H0 V4M clock tables
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
References: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
 <20240121174340.279465-3-marek.vasut+renesas@mailbox.org>
 <657bb8dd-ceb5-4c55-978b-bb5f0bcb49e4@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <657bb8dd-ceb5-4c55-978b-bb5f0bcb49e4@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3ipkzxqbjapr6bz41pycaog3rf4fe4ds
X-MBO-RS-ID: f7efb2c5e482903583d
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/21/24 22:08, Paul Barker wrote:
> On 21/01/2024 17:41, Marek Vasut wrote:
>> From: Hai Pham <hai.pham.ud@renesas.com>
>>
>> Add clock tables for R8A779H0 V4M SoC.
>>
>> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
>> ---
>> Cc: Lukasz Majewski <lukma@denx.de>
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Cc: Sean Anderson <seanga2@gmail.com>
>> ---
>>   drivers/clk/renesas/Kconfig             |   6 +
>>   drivers/clk/renesas/Makefile            |   1 +
>>   drivers/clk/renesas/r8a779h0-cpg-mssr.c | 294 ++++++++++++++++++++++++
>>   drivers/clk/renesas/rcar-gen3-cpg.h     |   1 +
>>   4 files changed, 302 insertions(+)
>>   create mode 100644 drivers/clk/renesas/r8a779h0-cpg-mssr.c
> 
> How does this relate to the Linux kernel clk patch sent by Geert [1]? If
> this patch is based on that, then we should have a link to that patch in
> the commit message (since it hasn't appeared in a mainline kernel
> release yet).

This is still pulled from renesas U-Boot port, once clock/pinmux/DTs 
appears in next, I will sync them from next into U-Boot.
