Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B552CA9EC9
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 10:52:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB6E080D1B;
	Sun, 11 Oct 2026 10:52:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vrbSAcwUXjIh; Sun, 11 Oct 2026 10:52:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33B5680CEE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791715973;
	b=j3p6Re6RLaveL+amaL8YS9pkbwCcInxFHUC1oOiqdpdWfEBrmYpnWCh6C6xk8gf7D1LW
	 NJpja5tYFT51tevkor7FzQ8EvgNaSCebREBiGYI/nL5F1Svny6itg/YehEGCneFhMiZ7s
	 Ga6UVMx/Z4Xw/+dNp0GViW/ziRLyge6Vd3oA3PRPxtZ6x5sVGCcjsneiK1HIUoWo94fSm
	 wfPrKwdgBFAwIum09urn3BEUXC7cy11GW+ryf5f2LMO8PrpDwRSUmDvZJnvniVkpKnG/E
	 Vc/I+A9vqchv+wV9yoCc55qMQpsnKKQowBzmsMz+KHDqkDqk4WXgX3NkIzf7luPAumA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791715973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=t+LScBWQu13+2gKHyk/QJ+UF1BWqNWFoTdBWJy735fk=;
	b=N+L6uQ7aHh4ljPHstIZlOqx52qM7KRO1OgG8NKTnNeSh7nLE92jSRjSHVBHwbOuyDxBo
	 Uu10tEbU+z9TV9kRE2WsWVCwHKDk8Zqgvy8u5fZTNB09Cw8Dnyws5PtV0r6GCoNtxQURq
	 zTibSCeOaUrwoWqJYk5jDvL0zThl7C7ORo8WBO49zkwTW23A3wFPcio5ioiD4gVyCu8u+
	 HgR2GaqLB5hpiULU1VvUSLSgKlL9RVsP8aJN9bYo7GWKaPK18KobGGrCLHef1rq0d5HcJ
	 8Nyjn4JH34F5uLcpPyji8xAQShtYr02a4lMbjYgGQ5+bwdMfhOUcbaRppPNSSIiiWIg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791715973;
	bh=t+LScBWQu13+2gKHyk/QJ+UF1BWqNWFoTdBWJy735fk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e90M2IB7poIxIZWPzVluuaQdbqOyFosMyIbeQXKpHrgzKD3fsq9/i3SisR0O9wFZJ
	 lXwKWsdVDxo+aMIPWLfvzvsxLqQ/TxbNih0Pzbn8PpIk+QQDYNYZi56roKniJdOQRw
	 irj2FAPE/3uQq+4oTyDnxcjaf5S7UIcEKJARUThyvVG0xH9J3amdm1Z7FOKThBCbE1
	 zEdC3NGdW35b4qjeOvgUJLADwKS5yFMHe+jGqe134OUwsnwnR0PNBf10gkrveQUKAe
	 0e6B33fciYqMWyZ2n3DtVWWOPIEOzV5R18lBY9h6oQi4A+I7XOoviD6nVRImuYA3l5
	 Gjx5n1j4UQ2xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33B5680CEE;
	Sun, 11 Oct 2026 10:52:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DB4F51DE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CCF6A4054A
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:52:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wvPAjjvSMkSV for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 10:52:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2146840542
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791715971;
 b=APltaR42PJOKJ3fbPDFKZjOiMmLpzfdP9gcOyHYVkFqEx2If3iBTmITRSSkh9L7Kw7P0
 DWN4rq89fzVqyI9g8grIQ2uM/NlL+UAL3Lx+m7RdRxSicLXer/nU8YqMqlfdwJrGy2FOP
 i5tHonbFRuCh176yMDOWbMAMEQ2B6eimGxwchACogNz8wMHnqYY83r3MFlH/x5IhsPb/8
 utX3NXhIyPWY9pp21TP7cPzv8PAeMvaNKu9dx6m18lU/y1iZoMeKHxbzvDcbsyhSi1ZCs
 REwRKbjvR78p0dux/IyPQRa2BP9Cf4hFkQfGFjY2aowG9WjES7khi69mACOpR/FV2fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791715971;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=t+LScBWQu13+2gKHyk/QJ+UF1BWqNWFoTdBWJy735fk=;
 b=hy8LmiqvkzRSJ8G4wjKP5eM1jFWcSuewS6jtqmbJR1xZG9VLmp6ljG/nE84rnjwYg77T
 zMHG0FGiUWUmVG6r/vDMgi1DVmmVNt2hRUVq9DMEJsIIEuGtKwPuEKlyn2cqK6Uh+BloJ
 ZrVlzSoZP0mjAWbf0UbIlG3RdTo3EEmog8vFug4TthSjS4PkFb2RhgUtOmogVTn2nhnQ1
 1WVtVq7/hMXaWV1/Sfq+4tvhukjOyAzkPgsokzZVFrezTUmFs+O9Rl/RVYJJEndA+V+ak
 nM3bkvrdmyR2DRVov3N2xkU4A0DrfaMzoeTC2JIXUtx18DsWpnDm4Baq+lAn4idbzzQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=aa5PeSxq; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7247=ib=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=aa5PeSxq
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2146840542
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791715969;
 bh=t+LScBWQu13+2gKHyk/QJ+UF1BWqNWFoTdBWJy735fk=;
 b=aa5PeSxqEleeU3cQvtNd79nbUOSDRq+hD2R9iTPgB9ZNwKhAaPYOxqa+pMrAgebXxICIkQDyN
 9wr9y/MtGWxRUV2eZ0LGfstpTwt8Jo9NbeBy1/zRGspRuvteZZNE53AyjGdovkSCTw+ZWhvlcTw
 kKx99wszMc5ezVJQeS2oGVlwTVi/qt1d8lErONbtqPAZmsgb69Mr2OO1yk9p4AT+pQw6F5+MSQz
 UaKfUkfL8erWy3LltvYqxXKpdRRZB3OPRUNASftTWFDcbhxpuzS/Lgbn+YXaTxR7mhPbUm3Dq1H
 eSQ//hFGOt0OfLIFsJ2pZy/L6M8iBFUFZFipXMYkjrHw==
X-Forward-Email-ID: 6acb6a7e06adeb7a8a8942a0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <79dc978a-9e1c-49b5-8f45-d6a1572b427a@kwiboo.se>
Date: Sun, 11 Oct 2026 12:52:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] rockchip: rk3568: Remove unused
 rockchip_get_pmucru() helper
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-6-jonas@kwiboo.se>
 <71f2e618-7ed5-4790-863a-97318e051201@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <71f2e618-7ed5-4790-863a-97318e051201@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Quentin,

On 10/9/2026 11:51 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/4/26 11:44 PM, Jonas Karlman wrote:
>> The rockchip_get_pmucru() helper is only used by RK3399 SDRAM init code
>> to help get the PMU CRU base address from the clock driver private data.
>>
>> RK3568 has no uses for the rockchip_get_pmucru() helper, let's drop it.
>>
> 
> Maybe move this patch before the one where you switch to use hardcoded 
> register address to make the diff smaller?

Sure, I will move removal of rockchip_get_pmucru() before any refactoring
is made for v2.

Regards,
Jonas

> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

