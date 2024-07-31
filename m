Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD51AC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 13:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C23788A0D;
	Wed, 31 Jul 2024 14:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.b="DHSTiRQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E508882F; Wed, 31 Jul 2024 07:55:36 +0200 (CEST)
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [95.163.41.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC0D8889C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fido_max@inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
 s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
 :Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive:X-Cloud-Ids:Disposition-Notification-To;
 bh=EkkGAGk/oJs2YSkKmTxspc9mCo1r7MPE4MMnLLhvdY0=; t=1722405332; x=1722495332; 
 b=DHSTiRQ44NilOcbnsVpRM+35iwlkykDG63uyExeejiCmjeJGwtr82RqNuu3oLPQGdrx3vGLLB2h
 dSyaznqIuOX0jBP9e+2FTLebGtHtCoKOEy8p06L0v2jqo7iXoMPqnpYyqnhnkYjFPsIk6n74jVAWF
 Cbx+VxLFCyeD8bTAKSuQVpkyKIHitDKUVPOtMIJf8rlSWK0cLHBlqDhR79q7l8lxiS9mvTyuWZgo+
 vi1FMfyoPr8gABcYNh6KsQ6s5DkvsDfA1yewcOhacT6C9WiKZqMgzbcSKBV43chV9RWNX7kGWxy4b
 DdqH0mn3rdfX6zG8u8xwBMmZYyyEXfsT6uPA==;
Received: by exim-smtp-868bf69f6c-rs99x with esmtpa (envelope-from
 <fido_max@inbox.ru>)
 id 1sZ2J7-000000006PW-1TxX; Wed, 31 Jul 2024 08:55:29 +0300
Message-ID: <ce851b8a-3ee9-487b-8fd7-1d5b1647636b@inbox.ru>
Date: Wed, 31 Jul 2024 08:55:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] clk: fix clk_enable() parent enable
To: u-boot@lists.denx.de, lukma@denx.de, seanga2@gmail.com, trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, mkorpershoek@baylibre.com,
 eugen.hristev@collabora.com, ashok.reddy.soma@amd.com, jmasson@baylibre.com,
 forbidden405@outlook.com, bigunclemax@gmail.com
References: <20240726120309.150180-1-fido_max@inbox.ru>
Content-Language: en-US
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20240726120309.150180-1-fido_max@inbox.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: exim-smtp-868bf69f6c-rs99x;
 auth=pass smtp.auth=fido_max@inbox.ru
 smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C65D76B8F852291B0932227566A3E75779182A05F5380850409B08FD8AF5DE6A383DE06ABAFEAF670575F0BD6436F42A089ED983E75E8B7D90AE87E38DD37F4ED5
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70A10A23A3B64B805EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006375AC38C7EC4509C8B8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D844B26B9A1DD2886A9B5B392307E18FD692D387E1DCFB303520879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0D9442B0B5983000E8941B15DA834481FA18204E546F3947CA9FF340AA05FB58CF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006375FFD5C25497261569FA2833FD35BB23DF004C906525384302BEBFE083D3B9BA71A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F83C798A30B85E16B42539A7722CA490CB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A56C7FBC31CFF476F05002B1117B3ED6965DD6EF1B5290D12E886DC9BC01168B20823CB91A9FED034534781492E4B8EEAD220496FFA5CD4785BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34C6EC1BD9807109D23BC3723C3AED7FE224F4E0D0AF4C515A923C2DCD8493D8BD96D1EE95B7E330C41D7E09C32AA3244C52EE5CA74B8E565677DD89D51EBB77422637184EB5FAF3B0EA455F16B58544A20C45C0626CB26EE85DA084F8E80FEBD3498BCAF62EB65D490083D0702184784583DB18EBE73F7D69
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj2j9vV9f5a3vvfX+WVf6ERw==
X-Mailru-Sender: 689FA8AB762F7393C6D0B12EA33CAA9BE1B85F397C2F7FAFDC362194837C72A2C7F680098C6863B990DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Wed, 31 Jul 2024 14:59:20 +0200
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

26.07.2024 15:03, Maxim Kochetkov wrote:
> Move clkp->enable_count++ after clk_enable(clkp->dev->parent).
> It allows the parent clock increment its enable counters for proper
> disable sequence.
> 
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---

Please ignore this patch. Clock enable/disable sequence is the same as 
in linux.

