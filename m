Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083F3C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 14:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E01187EDD;
	Mon, 15 Apr 2024 16:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sVeSnJyg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C3088050; Mon, 15 Apr 2024 16:12:00 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B6287C82
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 16:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=123a=LV=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1713190296;
 bh=UPwPTGGWVlPcnG811e735cZQ7JpkxAdY8/2VLmhg/oY=;
 b=sVeSnJygDEqNg3SmLPDfHowgE4WXg69V07HEpenlknEKKiQJ1wObbcvUmVx9wrI9NrzLYTJAD
 tQcF/4LXk7wfAxutieFlqU9ZZRpHlUxm9VIO6phL0R1/sKuw4/Bx0ylvP5iy8+DV7UEKJ2c6CTm
 8wosutrattPVv9mPPSa+M+cgvcHqNpXqYlSO8517pvI3m0ML7Rmauw2w771H0MUbax5NluOLwv8
 RtiJzQcKRs64OgttHfpTiCU+JvCDfOejzZ/s2LGfzazRuzQPCnuAmIgztJGbq3nF0Q8VMMfX+/X
 iZTHK58MaibmGJx1/S4oguyRy2aRdumO9impQGLe3Gzw==
Message-ID: <4b6f9196-a5a9-43b6-911d-4dee7576e872@kwiboo.se>
Date: Mon, 15 Apr 2024 16:11:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/23] rockchip: rk3588-coolpi: Add boards to
 documentation
To: Dragan Simic <dsimic@manjaro.org>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Andy Yan <andyshrk@163.com>, u-boot@lists.denx.de
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-15-jonas@kwiboo.se>
 <ad8440ae-d02f-4b02-be58-a37369f3eb52@theobroma-systems.com>
 <6b46f02336966f5fa1af927101e65298@manjaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <6b46f02336966f5fa1af927101e65298@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 661d359791f33105f12c2722
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

Hi Quentin and Dragan,

On 2024-04-15 10:58, Dragan Simic wrote:
> Hello Quentin,
> 
> On 2024-04-15 10:56, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 4/13/24 20:13, Jonas Karlman wrote:
>>> Add the CoolPi 4 Model B and CoolPi CM5 EVB board to the 
>>> documentation.
>>> Also fix .dtb-file entries in Makefile.
>>>
>>
>> When one needs to use a list or say "also", "moreover", etc... it
>> usually is a tell the commit should be split.
>>
>> Here the changes are not related, so please have two separate patches.
> 
> Agreed.

I will split this patch for v3.

Regards,
Jonas

> 
>> The sum of changes is fine though, thanks.

