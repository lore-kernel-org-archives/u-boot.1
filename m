Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736D2C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 10:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 042E782F8F;
	Tue, 15 Jul 2025 12:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OnYffyG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA1782F8F; Tue, 15 Jul 2025 12:56:35 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FEB6801BE
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 12:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a257=Z4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752576991;
 bh=+86rPL67F9RFhWA+Ut4vH/visVlF1TqBb8vBzp8PvJk=;
 b=OnYffyG9xBJGkfr/lPRnwLmz4EqrY2dIIwAjkjXoc+Fdbu6cnHsfjkoFyxEQpU0yz3D+c1xje
 Q9dKp6nhOBJdm/XYVjkC0H7+mDdXKcuGcWRS/rPux+os9Mnx+4DIKlskDbTZhpdVGH7z/GDoXFs
 LhDqTiqFYOPBn+k9lwzQQ1f92yzGRCHcQ7pIq2hZFFggW/dA6W+qP7+6dD9Jwv8CWwN/56BzCAg
 qUzAG9Z5xSXmMJeNUcDPMAJEYoHUQ17uU8EVxkuwgK1iXskVkQoZAmYmxvmgP+PdbHC/g2G2Fbd
 RhvnaqQX3EJppM/sKdK1N26sy1aL35uhLwgzPNoT2epw==
X-Forward-Email-ID: 687633dd02da433925aca306
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <58122518-6a07-4dd9-8326-0ae6f5aeb9fe@kwiboo.se>
Date: Tue, 15 Jul 2025 12:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] rockchip: odroid-go2: Remove u-boot.dtsi props
 already defined
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-4-jonas@kwiboo.se>
 <4257f343-4353-4d8a-a633-24ca154bd4d1@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4257f343-4353-4d8a-a633-24ca154bd4d1@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Quentin,

On 7/15/2025 11:34 AM, Quentin Schulz wrote:
> Hi Jonas
> 
> On 7/14/25 1:33 AM, Jonas Karlman wrote:
>> DTs from dts/upstream already contain aliases for i2c, mmc and serial.
>>
>> Remove the aliases and status=okay that are already defined in upstream
>> board or SoC DT.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> This also remove a bad re-defined alias for spi0, SPI flash support will
>> be added/fixed in a later patch in this series
> 
> This won't make it to the commit log in the git tree but is an important 
> piece of information.
> 
> Please have a separate commit just for that or at the very least have it 
> properly explained in the commit log as I checked the diff and did 
> notice this was different.

Sure, I will split it up into a separate patch or include more details in
the commit message in a v2.

This series initially started out very small, however it grew into a lot
more patches than expected, so this was just me trying to keep patch
count as low as possible ;-)

Regards,
Jonas

> 
> Otherwise looks ok to me.
> 
> Cheers,
> Quentin

