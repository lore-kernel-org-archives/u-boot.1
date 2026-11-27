Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1069C606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yvQT0Tj3;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=G0XXnFsH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6F6440A01;
	Fri, 27 Nov 2026 12:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OMgQkeZDGca0; Fri, 27 Nov 2026 12:02:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B6257409F4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795780972;
	b=CIc32aimlztWR/dFfrPi6tTyhX3zSMPFR0cG93BnbC2lF64p3OzjCit/+71WKBmhzIdz
	 yf2c6v47HQFztKiPGi3YtslQq7qKf2nReznuY6G0vnTN5lnfSHnLgtSbrocl3idm1WLGM
	 5Im5rI3wzN0jjmrKrWenbEsK9P2CptNwJ7aUBOaZBa65NZhskoqE2JZtJDI4zPNTNCon6
	 8xzFiTaoOZwwBbhpGvQ1J6dTtT9MemElNeR6WKQVeanEbTZMcs+pHmN9uCMy5EGDyb1Zf
	 fVG5C1biBvhEYLbSaAxVyL5A3s63RudESGZijAEH0cZmP+s0BdU7JMTLO/S4uQDweLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795780972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F+TckSB8nMcsWzKHExDV4i/685OeFHybs4Syw7DiJtM=;
	b=mT6JUl4SdIXySQuLeNWukoUZeicGcu+8wonKj6VpniW2CPXZhLgTmOm/5mgKeadgcPD7
	 n5SccbQQm7s6/fggXPH+2QTAKpMsQkzzEj3KN8LIdq6VuITqub06PZ+J3/N5bYhys7bVE
	 qLa2TedoX9dVHgvGzw9b0rBk4HlKMnf1i832tuQvklUL/b5rbkfEyi2UYRAOQRBfk2OXc
	 fXVYujZKz1aY2mmz6jzr/6lPfNfFfuCHw0t0/8DJo8H8bQw6EycWUV6utbI6vSl+c2Sp/
	 gQcQlt9TYOO6eJb6IzSx0e5PKQkkPwyK1PCVyDI1pQisUtxnE8Q7P0SCZ7KqP8tq+kg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=G0XXnFsH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795780972;
	bh=F+TckSB8nMcsWzKHExDV4i/685OeFHybs4Syw7DiJtM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yvQT0Tj3lDu2GmnQbzX1zPzZx1tXCfbdKvxLVycAC3YrdkD5/FX2dPrVX5lGot7NH
	 on8tdrpwqbElriAtmJ9FbWvEavJnRcv8iEHoSaddpfHl57L/6T3l7L3NHUSRm/PoB1
	 KVvm3ZJTuzGsI0lait7FpYTDodIbRodzGPvjCWDudoh8Ohl7StNn86cuxtCxwFCIJ1
	 RFOkkeWLOcCO04J+8AdUetYMad2acDU/Gh14khKh4+Jkw5GinVlEyYcRYnPm5jFbuD
	 J9yU4Hw0X5BQe7Xa20btm91P3XngnIIdwwqKe//eBJFfyzrvoT0+INJaqmhXbHzsGW
	 P9J41NyUDhZog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6257409F4;
	Fri, 27 Nov 2026 12:02:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D548A1C9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C5921409F4
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nH8WeimOPPB0 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 12:02:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B6366409F1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::bc0e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::bc0e; helo=smtp-bc0e.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=G0XXnFsH
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::bc0e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6366409F1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:02:48 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107]) by smtp-3-3000 (Postfix) with ESMTPS id 4jbX9L2F03zCW;
 Fri, 27 Nov 2026 13:02:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1795780966;
 bh=F+TckSB8nMcsWzKHExDV4i/685OeFHybs4Syw7DiJtM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=G0XXnFsHfjPw2sm+14T2yWtwCURDyYmb44MxNHMoWS7ZJjDlGwPxgBY3lbWpI83S/
 jmV1s/NhwRHCcVaukqlBe/T+eVwBa25lLtnkwiPWCXGjKcz+6fa8tbmS724lSIIEse
 AZPmdgpVNxIhXMegbklc0UoCO8QifKtKnkqChvI6VvtK8YrqOsHbquQw6piLzZE5d5
 O1ZTr5WIDQARpPX3+GTdFqEJZPRc2R5coJaBr7COzxVHgH3b4sIOA2bwL/aBwdQeix
 pq/yZd8tZz8EbG6INpvlGH6RbXPX+ThUKbb7ICsxzveWXLP+sGEsUp3dd1wLzdudcF
 OrBn1zTEM6dHQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jbX9J4Hlhz9vr; Fri, 27 Nov 2026 13:02:44 +0100 (CET)
Message-ID: <d76caaa3-8dc0-4eb5-80de-a412888ec046@0leil.net>
Date: Fri, 27 Nov 2026 13:02:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ata: dwc_ahci: fall back to the PHY in the sata-port
 subnode
To: Ricardo Pardini <ricardo@pardini.net>, u-boot@lists.u-boot-project.org,
 Kever Yang <kever.yang@rock-chips.com>, Eugen Hristev <ehristev@kernel.org>,
 Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
References: <20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net>
 <20261109-rk3588-sata-fixes-v2027-01-v1-1-e54ca8e68f18@pardini.net>
 <fb5f21e7-ac32-4d0d-b825-5aec96ece829@0leil.net>
 <7319c8f3-575c-461b-81b6-b0ef79f85723@pardini.net>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <7319c8f3-575c-461b-81b6-b0ef79f85723@pardini.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/27/26 12:17 PM, Ricardo Pardini wrote:
> Hi Quentin, thanks for the review.
> 
> On 26/11/2026 18:42, Quentin Schulz wrote:
>> On 11/9/26 3:57 AM, Ricardo Pardini via B4 Relay wrote:
>>> dwc_ahci_probe() only looks for a "sata-phy" PHY on the controller node.
>>> The RK3588 device tree, as synced from Linux, describes the PHY in the
>>> sata-port@0 subnode instead (the binding allows per-port PHYs, which is
>>> how Linux's libahci_platform consumes them), so probing every RK3588
>>> on-board SATA controller fails:
>>>
>>>    => scsi scan
>>>    scanning bus for devices...
>>>    can't get the phy from DT
>>>
>>> RK3566/RK3568 sata1 and sata2 have been affected the same way since the
>>> v7.1 DT sync (d0a838bdc62), which brought in the Linux change "arm64:
>>> dts: rockchip: Add port subnodes to RK356x SATA controllers" (linked
>>> below). Only RK3568 sata0 still has the PHY on the controller node.
>>>
>>> If the controller node has no "sata-phy" in phy-names, use the first PHY
>>> of the first enabled subnode. A "sata-phy" that is declared but cannot
>>> be resolved still fails the probe. Only one PHY is brought up, as
>>> before; the RK3588 and RK356x controllers have a single port
>>> (ports-implemented = <0x1>).
>>>
>>> Only tested on RK3588.
>>>
>>> Link: https://patch.msgid.link/20260201191804.41421-2-heiko@sntech.de
>>> Cc: Jonas Karlman <jonas@kwiboo.se>
>>> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
>>> ---
>>>   drivers/ata/dwc_ahci.c | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/ata/dwc_ahci.c b/drivers/ata/dwc_ahci.c
>>> index 0431d370716..8192d2f5f34 100644
>>> --- a/drivers/ata/dwc_ahci.c
>>> +++ b/drivers/ata/dwc_ahci.c
>>> @@ -57,6 +57,19 @@ static int dwc_ahci_probe(struct udevice *dev)
>>>       struct phy phy;
>>>       ret = generic_phy_get_by_name(dev, "sata-phy", &phy);
>>
>> question: relevance of getting the phy by name?
>>
>> Considering the Linux kernel driver completely ignores phy-names as 
>> far as I could tell and simply get the first phy listed in phys, and 
>> that the dt-bindings doesn't require phy-names to be present, should 
>> we rather switch completely to just get the first phy listed in the 
>> phys property too? There's only one Device Tree which has more than 
>> one phy- names when sata-phy is mentioned, and it's not one handled by 
>> this driver here so this seems safe to do.
> 
> Good point. I hadn't looked at how Linux does things, and went for what 
> I thought was the "minimal fix" on the u-boot side, as I feared breaking 
> the original user (TI DRA7?) and possibly others. But indeed seems it's 
> safe.
> 
>>
>>> +    if (ret && dev_read_stringlist_search(dev, "phy-names",
>>> +                          "sata-phy") < 0) {
>>> +        ofnode node;
>>> +
>>> +        /* e.g. RK35xx: the phy is in the sata-port@N subnode */
>>> +        dev_for_each_subnode(node, dev) {
>>> +            if (!ofnode_is_enabled(node))
>>> +                continue;
>>> +            ret = generic_phy_get_by_index_nodev(node, 0, &phy);
>>> +            if (!ret)
>>> +                break;
>>> +        }
>>> +    }
>>
>> issue: diverge from Linux's implementation
>>
>> Linux has decided if there are subnodes, then we should only parse 
>> subnodes, no fallback to the main node. If no subnode, then parse the 
>> main node. Please go with the same implementation.
>>
>> I know the Linux kernel iterates over all subnodes, but in U-Boot we 
>> can still decide to stop after the first subnode with a valid is found 
>> and let future contributors handle cases where there are more than one 
>> subnode.
> 
> Deal, will do; I'll retitle/rework this commit and extract a function to 
> get the phy in similar way Linux does and send a v2 after testing it.
> 

Can you split this into two commits? First one ditches phy-names check 
for the first PHY in the phys property. Second one adds support for 
checking in subnodes before main node. They are separate changes so 
should be in their own patch.

Cheers,
Quentin
