Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F212C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 11:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 809F78874F;
	Tue, 21 May 2024 13:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fujhsVma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7EEC880A1; Tue, 21 May 2024 13:57:27 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A868873A
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 13:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=766f=MY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1716292636;
 bh=0piRRgB7OYN9fL8xtVx25H1bXACI2sEOZ9Tev3Wov0Y=;
 b=fujhsVmaI4TubOainPoSExFvyJQHfHnAeOd0IjrprWFWdoUN5Fhh3Wy4tHq/yv5AUDHS3WW/Y
 BpWsw2g1zPQRO+u2/VmRkOX1ajWNFF3MynToBhs8O9m+raLR3q6jOnaRlSGwrz+XPBicv4OQ09+
 1E+Lo+D2UwXMpuxtl3A1csRRzE9QNy8Nz2oRdnceyZPQPsBnfAmF/yTwKB3XVWYHZrnAf+1FXal
 qxcFxx+WFCWzntBwKAFHwR837fWgskOuUIzScfy0MZaiUy+Nna8NYpeJRbr74OTsMw5MbOgQmxi
 olRrPldG+8XneSyJt+UqhnN+y3Vc17OWrAWsXO58NDqQ==
Message-ID: <6e7ab24f-1c01-426b-a57f-85f836a13171@kwiboo.se>
Date: Tue, 21 May 2024 13:57:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] U-Boot v2024.07-rc3 released
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
References: <20240520160635.GQ2568172@bill-the-cat>
 <7fc715fc-eb51-45a5-b7f2-71668bfd3eba@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <7fc715fc-eb51-45a5-b7f2-71668bfd3eba@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 664c8c1a339bba10bbf0781a
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

On 2024-05-21 11:53, Quentin Schulz wrote:
> Hi all,
> 
> On 5/20/24 6:06 PM, Tom Rini wrote:
>> Hey all,
>>
>> It's release day and here is -rc3. At this point, I think we're firmly
>> on "bug fix and documentation" ground moving forward for changes to
>> v2024.07 and the next branch is open and ready for use and pull
>> requests.
>>
>> In terms of a changelog,
>> git log --merges v2024.07-rc2..v2024.07-rc3
>> contains what I've pulled but as always, better PR messages and tags
>> will provide better results here.
>>
>> I hope to remain on schedule and that means the rest of the rcs every
>> other Monday, and with final release on Monday, July 1st, 2024. Thanks
>> all!
>>
> 
> Just to let you know that Rockchip PX30 support is broken since 
> https://source.denx.de/u-boot/u-boot/-/commit/1d01440b3f14f6648cd672da619489f635cb209c 
> (at the very least on Ringneck, haven't tested on PX30 Mini-EVB yet).
> 
> U-Boot proper pre-reloc seems to be running out of memory and we cannot 
> reach U-Boot CLI anymore.
> 
> I hope I'll have time to look into this before v2024.07 is released but 
> cannot promise anything.

On Rockchip platform all DRAM is available at U-Boot proper pre-reloc,
so there is no need to limit SYS_MALLOC_F_LEN to a small amount.

Ringneck seem to use 8 KiB for pre-reloc malloc() pool, please try with
a 64 KiB pool, same as rk3308/rk3328/rk3399/rk356x/rk3588 all now use.

  CONFIG_SYS_MALLOC_F_LEN=0x10000

malloc() pool size used by TPL/SPL should still work:

  CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
  CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000

Also check the "Early malloc usage" from bdinfo cmd, should show how
much memory was actually allocated at pre-reloc, from a rk3308 board:

  Early malloc usage: 2060 / 10000

Regards,
Jonas

> 
> Cheers,
> Quentin

