Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32612CA5FC4
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7307F81118;
	Wed, 30 Sep 2026 17:38:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5io3QgxSw13h; Wed, 30 Sep 2026 17:38:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BEB2C810C3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790789887;
	b=fcWAdigberfuF6QQl4GxRZc2513DQ1lTOq4FRcXp1ZocNyQfiKy9y0Mfipu7xGhMFu1c
	 PiAEFiq2f6Uhr2oIcyweNbByoJczWzmNgkIarQhjvElBjnGl4i6y9Jls1+vbmHfRluQpp
	 Q8iGRL/djwXxelyz+h/So0m0x5I/1GKcm0txpz+jLgZEY/7Q7+7irIYpKKYG8wwPnx/u2
	 +3zqYNYjKUyhsVsGNJ+Otwq3hMfUEiHLAg4jfNjzGCEB9SEZaeMX7cT3u0x1xQjzu1Nnh
	 1Vno8RPfdkUB4C6LxVT893sj10zSr40+5kdIrO+iX1GFhej5rbgT7dbvk+e7taUIm3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790789887;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JBZRehtqwBW1wRiv4m6eV0GsWLlsqmk2Mhq5qV4z790=;
	b=ceYqB9hGsJeIcuT3BLqdV8CvTQfmIIGGCIg/sd6h1a2CCxmV/R3uR7KpUeEPzOFqhx6R
	 VIXO2//b0uOwLePWnSfQ7CImAaz0l3fNfUm4RXnzXRqR9OMai0IRRr5NKGJ9G3pJnQWk8
	 wTwaHJ+8XMmc1f8zWFXSSlEw/yUrjyb53/CRB6WbxNWBfqRIXinATdNpYPUKk+2tOBYxs
	 BSPPrWkm7vHi134UwNmN1AypWeYQIyfZ0hR2EOW+fO0/C5drxZSrXKX0VmofZORMVWNgd
	 3JMVsS5cqhm2hZCPYmDCeWaFrv4Fapm5b4FM0eHhIsSS9z0Q50kr2Zbkg2weV/n0f0w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790789887;
	bh=JBZRehtqwBW1wRiv4m6eV0GsWLlsqmk2Mhq5qV4z790=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HJHEu/vV6ATsu1X0WyiUw6sa0wLf4iHSm4rg4jOnLWOoMgHLGVaMCLMEjrAouBbds
	 0UT5JUdvtob34aUe0L6ye5mG1E4zqFk15P6s/bZcKxg5cpbtESrJ1ifkzCGzstshPX
	 zm4MAdXWDMqC51qzS/sRvi6+oeiGSXWwybH5/tapqWDAe37v809XwznivIEOZ5YC22
	 oN5GeAEHzM0rQZhD0UU4QQbaW89G5sAaCSZuwKiDjDHq34BWmXw+CdNy+pMph5xrhi
	 9JS3mtuEi22syZbz8i1o8j1WI+VUEECpD7SAnJRcaxcoy8RXpikAZf2il2tLoJlmwc
	 7vrVc3Ax6DYLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEB2C810C3;
	Wed, 30 Sep 2026 17:38:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 91D6333B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83FB960B63
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:38:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2hp_w0ILHOV0 for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:38:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9419B607E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790789885;
 b=lfAUkdk+Uqjr0WmoNDls0YWxPwCilzD6yfGyt2Lu3ucJ/iFCHUZr8gp9Bjs9wRf5YVe6
 StHuritAW9AGYJs7hHTq0mcCnXEwPzNtEh/j0v+ss3L5Nk7cUyKmSmXLZSEyvlxJus7gW
 ErVxMwahh9Cj3WYPAIUY++IETGc8vd8nQOVWy4cGvALmW8jLo/L1eIkAKgurQhIYxkXM+
 3uVxGoibqUcgLIp07Lqv9oKYYTheqvkHBJrhIsIxDbjGL+Q3o/nMTviOtui+OXKiU6jhp
 3nQnm/D6ApgXYzQn/+0Zg443TFKrde9LAXTsd/t4is7EL/wKcgbhbtPe1l/pxe985sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790789885;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID:X-Rspamd-Queue-Id;
 bh=JBZRehtqwBW1wRiv4m6eV0GsWLlsqmk2Mhq5qV4z790=;
 b=gUQieQ4BZpmontK+wnrZwYj0G/C6GXLS31am4V59sgvOCfMBOUrOFR4c1lKto/ZsRm4H
 Uc2xRl3nD8mg9ZjV5JfQSU70g/vGJUWLoVU7FY/ibkfscIam6/LScovksKC4fCbpxJ7cu
 zPSiIvvFL6U66UMzeH1b+gbDMH1W1XEMs4o1Zsf7WbG6ZJx9JJ+79T+GKuhqxhN+FLQwL
 +wH9Qdgjp/M3AENw0E+d4RLMAIfXSilEAxFgEXkMH0v8BcvEf+GDLQTPDPiRBDGIhi6l9
 j6Lk/J7EQSJRZdAwl+Gtksql2lw4OP/wB45afrY0/mjz1Gyu0SOlPoW3hMj/MtxuxHg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=COqKJBm2; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Wy6ICUEE; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=COqKJBm2; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Wy6ICUEE
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9419B607E4
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:38:05 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hw2Lz0S9JzKp6K;
 Wed, 30 Sep 2026 19:38:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790789883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBZRehtqwBW1wRiv4m6eV0GsWLlsqmk2Mhq5qV4z790=;
 b=COqKJBm2H15utbDbIuM63HGhWAmo2Lh1ccTO5XGp4g8r9yqlH7NRwVxIoj7XONxVdhKRPi
 yxQQy7K7hH3NiJ6qZle9ceeL43a8D09vNNcuP8YvHPA4flHD7dRuhFCQcvfRBulVEuDltC
 YgsD0H461hGtUbinzpjKUIpPS+ki+CymtjRNW8ExUGNOfyC3nIuAnXEzRcmn4AH57rjHt2
 w37AQW2kJN+hOKgno1SNsqVnWbNQLhCxVkldzdO9HOPL6E4sLLiefS/20CZcCPtEQmfJDr
 73IrNrffrBTF7uMJfBy1G8IAkKxBDakdBKvNJNfWMn0lVbNfA5UjHOkXnAQJLg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Wy6ICUEE;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <60d018d4-fd00-4c26-9b0b-f1ce288d65d2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790789882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBZRehtqwBW1wRiv4m6eV0GsWLlsqmk2Mhq5qV4z790=;
 b=Wy6ICUEER0CkpcOk2YGGqWOPwoehdWldXGXfmquA9iPtRUIdzw3Ch18gStZTkOJngH4bbO
 UDoD8kA5Q5iG67BDYgq2vQYP7xh5VE1gJ38TzmmesFbLNu+fqJeWkWldFBuMuCQ8M2OHDd
 cQjQZEB7Qe8TEc4SY3LKbVdrMYuByE3KNl9IoDjaqJCLqaoRLMVJXhu7hzxpsh6UMz0as7
 VT6Dv9lZ9cZES4+xXRwhle0K/3WawHbFYU+iDvC0OOYbUE3nlsT8EaJ94ocjODGP2nbHyC
 7D/lGRfJ8oY6gF5pSVpYEDfwwYK5iu2xdbRmKkPDJNJgKMYmM3eD4hOml0c/4w==
Date: Wed, 30 Sep 2026 19:37:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: beacon: Remove Beacon EmbeddedWorks RZ/G2 Dev Kit
 support
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Adam Ford <aford173@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Huy Bui
 <huy.bui.pz@bp.renesas.com>, Nguyen Tran <nguyen.tran.pz@bp.renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260913155253.84181-1-aford173@gmail.com>
 <179078865386.467656.9091674646926534530.b4-ty@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <179078865386.467656.9091674646926534530.b4-ty@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: gahufs5b9ekesoeij4qoyenfgtzj6nih
X-MBO-RS-ID: d29c70a9b7cc80a96e1
X-Rspamd-Queue-Id: 4hw2Lz0S9JzKp6K
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

On 9/30/26 7:17 PM, Tom Rini wrote:
> On Sun, 13 Sep 2026 10:52:53 -0500, Adam Ford wrote:
> 
>> Remove the Beacon EmbeddedWorks RZ/G2M/N/H SoM and Dev Kit board
>> support along with its defconfig, config header, U-Boot device tree
>> overlays, the leftover pre-OF_UPSTREAM DTSI files, the Kconfig target
>> and the entry in the Renesas board documentation table.
>>
>>
> 
> Applied to u-boot/main, thanks!
> 
> [1/1] board: beacon: Remove Beacon EmbeddedWorks RZ/G2 Dev Kit support
>        commit: 3f31d496ecaa6240f1e578cce389a06798d66c30

This is unfortunate, oh well.

-- 
Best regards,
Marek Vasut
