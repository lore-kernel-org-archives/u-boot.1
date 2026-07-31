Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B52FC5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 18:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17C4860680;
	Fri, 31 Jul 2026 18:06:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FMblD3pl0RKa; Fri, 31 Jul 2026 18:06:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22F9C60657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785521202;
	bh=9fZQa6/d3qvvY7XUdK3DUHJ4PMauw/6AwEQH1GNqOnM=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RB0iPUx6azYFhz9XoZktOxZ6KC2i066GjVIEdrwH6H2L6RsydSByMi39M/o9Y4ukc
	 bDP2uENBZZGFdPFZlpk5yEErajy9hnbGsWtypJKb0PPxvl5vcqGvf6v7j8AOJKZGu7
	 Tlk2QWkAg437s8ynAyeIszjwFBQCiuATX7ec8hNM81XjQEBhJ9l3HOx7q7r+qWCfMr
	 FiH9FiIqjbA8LYOKdBsGAoAW0SaAu4ceK4CYvptPeh1jWHg96ziJJGWtrBJQdZh/Xc
	 euc8JGmSoHQQUJvKNg09sHCVBDxh/594K0OczR6EkV/Dfh/LIkQ13rkU9lsiph3C6w
	 8e0uuvq4HuaOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22F9C60657;
	Fri, 31 Jul 2026 18:06:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A590D37F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9769D40FB2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:06:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x1sg8iMLhRn3 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 18:06:39 +0000 (UTC)
X-Greylist: delayed 323 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 31 Jul 2026 18:06:37 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F23B340F38
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F23B340F38
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=a5ca=f2=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F23B340F38
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:06:37 +0000 (UTC)
X-Forward-Email-ID: 6a6ce2e6f7c976cddafc9775
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e39e51e9-6a5c-444e-9237-89d541a233d7@kwiboo.se>
Date: Fri, 31 Jul 2026 20:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] rockchip: doc: add boot medium layout text
To: Stefan Monnier <monnier@iro.umontreal.ca>
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
 <4d7b7705-62d6-4b61-840c-ef1dd28f9435@gmail.com>
 <b18b9a88-11f5-4d77-a29a-e341695240ff@kwiboo.se>
 <jwvjyqbfbi0.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
Content-Language: en-US
Cc: Johan Jonker <jbx6244@gmail.com>, u-boot@lists.u-boot-project.org
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <jwvjyqbfbi0.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1785521197;
 bh=9fZQa6/d3qvvY7XUdK3DUHJ4PMauw/6AwEQH1GNqOnM=;
 b=P7myIKE0eZWg2e0t1fuxBe3MoJ84W0FYTbSauM0B3uHCtcyPEUi/A5CHfHhP62TNEbwc/wvej
 PHNF7TYXc7EGhjs+W6mMa7dsowvVNLp/r/VV3qrVIvx9Qwrmi3DTWI4sULgScPfawmwFwaaHHV4
 FdOteTW1nb5u8/DBswCje1sTZjZrhi9/UDyzHndj99js4ydW10/T6a0xwCTJKuRgz3W7PG2p8NR
 V04C36hYiM9/Osrm3ofUEx9+oJ7JNOiybWPyBAe2rpz285oJzkt29DazrwtfRAFOyanRA03Qt/V
 qg1bwGu/r9XyjBNZSY5+s35Co7JpZEQnGFOoZtgNHgaQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=P7myIKE0
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Stefan,

On 7/31/2026 5:10 PM, Stefan Monnier wrote:
> Jonas Karlman [2026-07-31 10:32:03] wrote:
>> On 7/30/2026 3:34 PM, Johan Jonker wrote:
>>> +for data. It is not possible to place these blocks randomly.
>>> +
>>> +* eMMC/SD card:
>>> +
>>> +  Rockchip uses a unified GPT partition layout for it's open source products.
>>> +  With this GPT partition layout U-Boot can be compatible with other components,
>>> +  like miniloader, trusted-os, arm-trusted-firmware.
>>> +
>>> +  There are some documents about partitions in the link below.
>>> +  https://web.archive.org/web/20260501050119/https://opensource.rock-chips.com/wiki_Partitions
>>
>> Please drop this entire 'unified GPT partition layout' section, it is
>> not something we should encourage user to use. It is legacy and nothing
>> in mainline U-Boot that depends on this layout.
> 
> At the very least we should distinguish what is technically needed from
> what is some arbitrary convention that's been cargo-culted.

I agree, and for MMC devices the BootROM typically look for the IDBlock
header at sector 64, 1088, 2112, 3136 and 4160 and does not care about
partitions.

U-Boot SPL will typically look for FIT (or u-boot.img) at sector 16384
(SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x4000). This can be adjusted or
re-configured to instead look for a specific partition with Kconfig
options, something that the khadas-edge2-rk3588s target does.

The legacy GPT partition layout is something that was inherited from old
vendor miniloader blobs. The miniloader looked for miniloader packed
U-Boot at the 'loader2' partition offset and trust (tf-a/optee) from a
'trust' partition offset. Newer vendor U-Boot SPL typically also look
for FIT at a partition named 'uboot' and falls back to sector 16384.

So the text to write u-boot-rockchip.bin at sector 64 is the only
relevant part of information for this section of the documentation.

It may also be worth mentioning that a filesystem should not be created
at 0-16 MiB of MMC device if boot firmware is also intended to be stored
on the same device to be safe for both vendor and mainline boot firmware,
at least for rk33xx and newer SoCs.

> 
>> For mainline a more appropriate layout would be to reserve initial 0-16
>> MiB of boot media for partition table and firmware, and use remaining
>> freely.
> 
> [ FWIW, I'm a big fan of having a partition to hold U-Boot, rather than
>   hiding it in the first few unattributed blocks.  ]

I agree, it can be useful to create one of more partitions to ease with
flashing a new u-boot-rockchip.bin to a 'firmware' partition or similar.

Regards,
Jonas

> 
> === Stefan
> 

