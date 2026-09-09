Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33173C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 18:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2695406FB;
	Wed,  9 Sep 2026 18:27:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RYIh8rBe37OH; Wed,  9 Sep 2026 18:27:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EEE15407F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788978453;
	b=nDPjg73yFgURlheyHzlEYaKCTHXGcDSwiOKQvM5nWFbyry+ohT6MTjV14LHN6Jfc+XWb
	 0s2dDCwCc8Pjkm7Tc7kXe1+OTlwEUOiYe8KqGNNydULckZm7QvMo29Dtn2NHfw811t4ZP
	 7E6XfR1NM0KwSofiYGllM+AnuZ06ejDiGY8rUmafzXigrqHx8Kpgw+xnrjW4m1xzZ7pqw
	 ISqS5xaAoYgmD69fauMSJduW2NQVBMZNVcA0ZovR0JwMHWndEwBro15WkukrGZMg/tYbZ
	 MxNTeFLiHYhnFiUm/GPNgt9wsLykELbaPs3Q4XipH2Ndo5HbtRpFS073nYKsOSGlM+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788978453;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hop3c9HNuKJe76gzIdOeHy1bm4vG0f8w3+5bRvAaPHM=;
	b=ghs0eC9A59VNydDCAlEIOSYHUlWVfMgWPXGsLbczxGbPttuyDC8C17gvQXJQ30QBMaN5
	 yTVj+eVIW8EVWgTb89A7/9uGAw/VlTTFC8i8jJdEMRsaZbuvJOmKZomqLcwcPYnfGQtWg
	 JT3Tix5etrrXosEeJ7otNxV4pPffDZ95SEhK4PAnf9Pp2CSfp9nfhQE2mDd7UufThEfch
	 E5PsjK/ldSfSOAcG1IJdvEam+ng+4zyLQdndSWv4gYsTKSfjn09paXtLtbbyFKIXsL7By
	 SCuAerZf8UqW04LYSAPBoRIU4xkaXUx+M+p04vbbX+0SO7zXNsamkXtBuIiUGXt2dcg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=YtgUA1Ye;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788978453;
	bh=hop3c9HNuKJe76gzIdOeHy1bm4vG0f8w3+5bRvAaPHM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gc1IlXlaAfA+PMnR3N4xUajBQ+u7bN6ZBZAgvFQAUqbiugXiIxYtfvB8ZchPa8PvQ
	 RL9WTn2J5rmegVJ509k/TyZL0/4tRan4BtqVYvbzpm923rYVjLnAcZDGV+vhT0orfU
	 YTq+7gZY5I+SLrYnzdfTvEQ96S30c91kuiiOTbve4or34P0upft5tnhloAruzK2vAk
	 x7zPRf2Ig4BdEItnwO6tQdB7nHtPzr2VtAUuDvy0VD8gJxDV77Zjv6qjTIO/dW7xQs
	 WE10+LqiyTV16BzYrWlmofTm9eq3ITMiyE3j1ocxEqmJYSaT8kmVT2c9ZtA+C9yF/p
	 ESbLsLerxrePA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEE15407F9;
	Wed,  9 Sep 2026 18:27:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D83E6528
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 18:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3DE1407F9
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 18:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nCHYG_O8_dXO for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 18:27:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3230B4046D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788978450;
 b=EV1UhVx8J3wc7UCQspmm4p2JolKPJqQRMjMS50hT0hu1Fm3tZRHTZzwmd3YGjRlFzea2
 1bMCaj8YrrDV5UyNu+7ift9QWJaWLTqC2S3CGbkg0zzQI932FuJp+t4QV1oRwreWJ/N6N
 CF3+IoK4Kyf+mmYW54SOqtLeeXXxkdCaDXLqPGyfc7ZTshaGWhSERR/1q7oA3+AJACcjM
 NyCYyOHvWN0ZSRgPbwxquwMuuWWX1N3TO+yrtwZeAnwGx1eLjp7bRQwkJSJUjtn4nzoQi
 EbV0/I/T9W7eaR0h2cRTlUrk7pbx0rzHocrtx/9iq4G2Ib7gg4+JxGKyo97R+PZcbmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788978450;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=hop3c9HNuKJe76gzIdOeHy1bm4vG0f8w3+5bRvAaPHM=;
 b=Ptn0mxTrGvzabFh4IgunlPBY9wrhFAYfFImNM95c8xxJfDjkxz2nMoWMN/BkNd5denDa
 nafcsXuqB/6mYHGuOwzvD2GDHveWFcnVuu/wY0wkvCSS1J4gKiEPgJOoOKTU0DR8OKTVA
 s6yHgrtkYTR1FZNwe+PHL6C2CuntVlZgsPpDXeS242CZONUWcBdA0x+QUpgou24r/OBAW
 tAb6aKCd3aCQYWAHv4GIyeL+Kp7n7BtFcDiuHVUrTBxJDYYkDZDa+cezNql2bDpZwPwJN
 YhUqjOkPzgn/O2vYJSvHx7tCCGkz8vCo5ZZiuwSvw1AP7rsR8ACkV5qzkoSop7k1dfQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=YtgUA1Ye; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=YtgUA1Ye
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3230B4046D
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 18:27:29 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hg8Rd10PhzKrxq;
 Wed, 09 Sep 2026 20:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788978445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hop3c9HNuKJe76gzIdOeHy1bm4vG0f8w3+5bRvAaPHM=;
 b=YtgUA1YeR6+lk3G6r8AXloHgJrHtwFSSCVlasoKUqYMWYhBl8fu3Uvyqj7vfD2h06XbbAo
 CAtDOGWuGb1SSpmfh1SKy33IUQiu40z7LFmO3EJo8NRKFcx8j/yTEf6KkhVseN1IwgWs30
 pGXrjaz1WwtNQ6tofeol7Zfb1XbcCXgZNeuu4PhslL03P5HZX1Aj2u4pggC2uzunPgkP1a
 tjcT8oItqwkDF7iGq7GF4kJgGflSAjG5aaUDMXubpCjzcChbQHzjgMYxJLA7toug/x7njp
 wQ2fJIGMYO1fz0wZDtVLve7ng1NoIxUPr2ByvcFR3Pp+5aeSQ/Z9RzjClMFPQw==
Message-ID: <590ebda6-c1b4-40bf-a48e-f872929ba699@mailbox.org>
Date: Wed, 9 Sep 2026 19:53:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v8 00/25] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@denx.de, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: tgwfi3oq7kmes33hqbr1ognifr6n8gst
X-MBO-RS-ID: e7c75fa53f1f39adf54
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

On 9/9/26 10:49 AM, Anders Roxell wrote:

Hi,

> This is part two of two. It applies on top of part one [5], which resets
> the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
> the build for every board that enables DWC3. This part adds back the
> U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
> builds and the gadget works again. It builds on Jerome's work [2].

This does not seem to pass CI:

https://git.u-boot-project.org/u-boot/custodians/u-boot-usb/-/jobs/87618

-- 
Best regards,
Marek Vasut
