Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD65606A31F
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e+mAwP6u;
	dkim=pass (2048-bit key, unprotected) header.d=pardini.net header.i=@pardini.net header.a=rsa-sha256 header.s=google header.b=Gvuq4b3B
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC7038121F;
	Fri, 27 Nov 2026 13:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9OB5zYSrMvtX; Fri, 27 Nov 2026 13:25:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C4F8D811D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795785947;
	b=F8xA6l2b8xwOa2u0h2JvuWcgK6SEcpdpl0j0/AqnWWb6YdBRVyZgf5lIPUIxaVk9N5uO
	 TFuinu9SPZxviwylhzrQtlQ7R4S1mLCYjcXrwo3TEGvN1dhqpIfOWd/86HVEtNQg1/hE1
	 C8/JrtDPPDmqs154GM0F8vqLEW9S1gPN67MpJjK9FLcGtncXF9EIwV/zlZu2ES7i9C9sz
	 TceT+Q5OQgaBaV61UdXv7ohHlNuyqVLAkXEI5rLvoEbEUZpBEJvlb4h4Sxs9+uIqcIFEU
	 4o9y5xeJYHSU5dVoHsv7leS2/lpRwnLu080Zm8fohdQ7fGjv8S8rX3LC7iKA3T74Rag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795785947;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ihk0HyPYqZvZZhU3hgWnhWMyKzIfueGG8nkuz4EfRQk=;
	b=IB0FElCvjB0UvD62HUx7dWTy4krpbvRJDKgdzoNdjCts3UAWOEtoLgPtEjj+4Fm0ECqp
	 bo0wVwJdlfNKZ65hJ2oWSpdJO4lJBg/o43hDRSvo7B0dkj79oqhPUhXH7pw+5N83F3Xgz
	 m8t9ro7tKXYFYKiQnJ+Y7RH8FFO4I/gVRx/XPKq0m4vgLRy/56zpqcomHvxl8u7oErAVf
	 tw5zLwysRYSiqw99Yv3Mfqqxy/89gbX+Ff+UGiEIM0EBwrU5N1oybRZwVMdZ433aY8OWg
	 2CzhPNK2Tgd8bQCHaBbumpHHKsLd5DtuMUnHsGAGBiRYQ09VF3ydIaDjMz2FDag7ZUQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=pardini.net;
	dkim=pass header.d=pardini.net header.i=@pardini.net header.a=rsa-sha256 header.s=google header.b=Gvuq4b3B;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795785946;
	bh=Ihk0HyPYqZvZZhU3hgWnhWMyKzIfueGG8nkuz4EfRQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e+mAwP6ugt5ibIsjgESmH1G9rPoeY79qlef1mPW93/gSnirnQH3fugnv/SHti7bU3
	 pbBRsTM9nsyHakD9HkiWFBuQLNJ6TzfCEw6jvPvqw9iGn8s1N4hoUqiQ3jbGKUkbDh
	 7yHFqSY1pZ6xasJZmiJeYvgtRROxDY1roFQrBkhvUDjO7MWk2jnXruIsDEHoCutLhc
	 3e7a5RZALbd0KO5qbMnZGpfElXdEWeMjhSFVpRDdGzFc4SQDk7qScfBbTykTgiDAVT
	 vP1g3VyeX3xTZTAU9jAAOhWIJr2huN0xHou5zUA4Zpskw+xvia5OdHTrpXfZQYCGQv
	 QAP93M2q1+9Rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4F8D811D8;
	Fri, 27 Nov 2026 13:25:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73550311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 654C58114B
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DsurQ01fytxG for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 11:17:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B47A81144
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=ricardo@pardini.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pardini.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pardini.net header.i=@pardini.net header.a=rsa-sha256
 header.s=google header.b=Gvuq4b3B
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B47A81144
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:17:40 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c506a231b88so1062642966b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pardini.net; s=google; t=1795778259; x=1796383059;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ihk0HyPYqZvZZhU3hgWnhWMyKzIfueGG8nkuz4EfRQk=;
 b=Gvuq4b3BcpVNK3RjoVao4IttWn4MltI1LTfbeigiLuzDlWy8xjJR6gxl/MAuoskjh3
 ebWYfz0d6Y3M95doamoVvB0d41/WS0TkxZII6BIII8IBjLoQRN7lo+tY7bTJFD7ALU9c
 A70gXpTNQjRBSToxPvOlIhx/d6JbUM9OKihDCOaTUtz4mc7IFewrpJ50TBGiItc5H16Q
 4mN7Y/EKC1P/9HoVg9kHWD9f/dOii6Sir16/Ydf9tyeNJ+iWanXDi7lsVdOVfbhxk1Np
 xYvXJ9hMAt2E/mS+DZhOG+MpBxJVsPprv7DBsVepY2phNXGO0+o+V+XtC7VsJnk6kobG
 MNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795778259; x=1796383059;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ihk0HyPYqZvZZhU3hgWnhWMyKzIfueGG8nkuz4EfRQk=;
 b=G7h0KVcLYeHRZCpPH77bVXKuPDIFQ+OpUhIzRxK57a1q1+SeLybQbabnKpqVyA/jSE
 dROFrI6X1twKteJ2JoxavqPLXBMXSb9daqcIxwRJKJO0BN6YCspiMo9SdjB4rWy12P2y
 I4GaWrAffmgR645tUa1hfUO51ibhACT4VD/HsZKdh61KkXCzKB+RWG5v69fyNTrglPwd
 h33KZumZSxEUSWRBhWBxRTpKwq6AIcj3DBtn5ZJnf0eRuHlglUW/bu3boalVN3cGyWU9
 QS/EsiIyB9UP0qVYMVyo0wAMBUn6XhN2W9zi/df8+lp5ux8tP458Vlbgh1eT+zIbdHAv
 +j3w==
X-Forwarded-Encrypted: i=1;
 AL+hErHcwulTxUChvUdAuWa3MG1Z6tH3ZJJFGa54PsdpsKRpZwi3DnqVJfW11J1E6TYMgTL6eqBgxBk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+1JOlpWNi/bxeDmtIMrTJZgDHeCuPrlETMoFl65da7jmKVTDjl
 YZzHRYzSSEdXj3hDIFTl/8E1L+t6uDTBusfs7zGX/M47fbOKShnE6UnCF5QBvjMB1A==
X-Gm-Gg: AZFdTZfs0Q3Rc/cC8ISRsV8aGw+gpOJdelmwUcWJ1VRTiwHtzVaiHNz+bop4stcBUh2
 97ZQMalC98a61Xovu7xJ+mxndGSKiUZN+wB7Nw0HlZBvORRcIr38IzaRMHaf+MlvpNRHJL/ZOX/
 eL2ddWBfqS17fPv248pI6bMCGnI8z7r60vBDWfWm9PU/xz4RQwWEHbw4N9KnbsHlSiUcIJZF1uQ
 NgSUltFLN63TPqZcIssp7wBNKHz1NdX3VFVRiS+5ZBO/yj3k82O4CCpMpHyUtduLMIqKYpGIaFf
 EY/Yd1Fv7eiLGqT7YwdHDNpG6jT74etcpTfYIcrnnITZPtyQDpVSrzu74cPsqwDtsLPzSjKR+aA
 wuONjABouPw7vji2dyRcvnS8LqqOAKdrQAneBtPWjNmhtlvB1Oqbfb2w6pebhXapTywdET3ODIq
 i3FYa1OK2xbg4xfOh+8cqdbL4GA9lcBtjc2Y979EzLbQFmetqPILjF4OHR0a8nIRJohzEFUrzKF
 6Aymfcc/6s/+TK590sUB2GOshLMOsFfw+H9EKNyIIEmYa7gH41TUfa+5BP2VmL/rySciFrT9+y3
 zu9pQ9Qch9BYKgBDLtl2JaxrdxuZXxDiXl8St9cYp64Yf6cEnWM34yQIzT37WJWyB9JmsSCQaW8
 nxvov4kyW/lLPR+Ol1mE/fuOwcsC+4Cdw964Jil1n/qcZAjtuo1Uz+puMwXNpx0DJ
X-Received: by 2002:a17:907:9306:b0:c42:fc8b:6c7a with SMTP id
 a640c23a62f3a-c513aab4a0amr2012171566b.41.1795778258544; 
 Fri, 27 Nov 2026 03:17:38 -0800 (PST)
Received: from ?IPV6:2a02:a466:4d7a:0:a160:ba2:f93:fdb?
 (2a02-a466-4d7a-0-a160-ba2-f93-fdb.fixed6.kpn.net.
 [2a02:a466:4d7a:0:a160:ba2:f93:fdb])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b01e242sm829214866b.82.2026.11.27.03.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 03:17:38 -0800 (PST)
Message-ID: <7319c8f3-575c-461b-81b6-b0ef79f85723@pardini.net>
Date: Fri, 27 Nov 2026 12:17:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ata: dwc_ahci: fall back to the PHY in the sata-port
 subnode
To: Quentin Schulz <u-boot@0leil.net>, u-boot@lists.u-boot-project.org,
 Kever Yang <kever.yang@rock-chips.com>, Eugen Hristev <ehristev@kernel.org>,
 Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
References: <20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net>
 <20261109-rk3588-sata-fixes-v2027-01-v1-1-e54ca8e68f18@pardini.net>
 <fb5f21e7-ac32-4d0d-b825-5aec96ece829@0leil.net>
Content-Language: en-US
From: Ricardo Pardini <ricardo@pardini.net>
In-Reply-To: <fb5f21e7-ac32-4d0d-b825-5aec96ece829@0leil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 13:25:43 +0000
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

Hi Quentin, thanks for the review.

On 26/11/2026 18:42, Quentin Schulz wrote:
> On 11/9/26 3:57 AM, Ricardo Pardini via B4 Relay wrote:
>> dwc_ahci_probe() only looks for a "sata-phy" PHY on the controller node.
>> The RK3588 device tree, as synced from Linux, describes the PHY in the
>> sata-port@0 subnode instead (the binding allows per-port PHYs, which is
>> how Linux's libahci_platform consumes them), so probing every RK3588
>> on-board SATA controller fails:
>>
>>    => scsi scan
>>    scanning bus for devices...
>>    can't get the phy from DT
>>
>> RK3566/RK3568 sata1 and sata2 have been affected the same way since the
>> v7.1 DT sync (d0a838bdc62), which brought in the Linux change "arm64:
>> dts: rockchip: Add port subnodes to RK356x SATA controllers" (linked
>> below). Only RK3568 sata0 still has the PHY on the controller node.
>>
>> If the controller node has no "sata-phy" in phy-names, use the first PHY
>> of the first enabled subnode. A "sata-phy" that is declared but cannot
>> be resolved still fails the probe. Only one PHY is brought up, as
>> before; the RK3588 and RK356x controllers have a single port
>> (ports-implemented = <0x1>).
>>
>> Only tested on RK3588.
>>
>> Link: https://patch.msgid.link/20260201191804.41421-2-heiko@sntech.de
>> Cc: Jonas Karlman <jonas@kwiboo.se>
>> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
>> ---
>>   drivers/ata/dwc_ahci.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/ata/dwc_ahci.c b/drivers/ata/dwc_ahci.c
>> index 0431d370716..8192d2f5f34 100644
>> --- a/drivers/ata/dwc_ahci.c
>> +++ b/drivers/ata/dwc_ahci.c
>> @@ -57,6 +57,19 @@ static int dwc_ahci_probe(struct udevice *dev)
>>       struct phy phy;
>>       ret = generic_phy_get_by_name(dev, "sata-phy", &phy);
> 
> question: relevance of getting the phy by name?
> 
> Considering the Linux kernel driver completely ignores phy-names as far 
> as I could tell and simply get the first phy listed in phys, and that 
> the dt-bindings doesn't require phy-names to be present, should we 
> rather switch completely to just get the first phy listed in the phys 
> property too? There's only one Device Tree which has more than one phy- 
> names when sata-phy is mentioned, and it's not one handled by this 
> driver here so this seems safe to do.

Good point. I hadn't looked at how Linux does things, and went for what 
I thought was the "minimal fix" on the u-boot side, as I feared breaking 
the original user (TI DRA7?) and possibly others. But indeed seems it's 
safe.

> 
>> +    if (ret && dev_read_stringlist_search(dev, "phy-names",
>> +                          "sata-phy") < 0) {
>> +        ofnode node;
>> +
>> +        /* e.g. RK35xx: the phy is in the sata-port@N subnode */
>> +        dev_for_each_subnode(node, dev) {
>> +            if (!ofnode_is_enabled(node))
>> +                continue;
>> +            ret = generic_phy_get_by_index_nodev(node, 0, &phy);
>> +            if (!ret)
>> +                break;
>> +        }
>> +    }
> 
> issue: diverge from Linux's implementation
> 
> Linux has decided if there are subnodes, then we should only parse 
> subnodes, no fallback to the main node. If no subnode, then parse the 
> main node. Please go with the same implementation.
> 
> I know the Linux kernel iterates over all subnodes, but in U-Boot we can 
> still decide to stop after the first subnode with a valid is found and 
> let future contributors handle cases where there are more than one subnode.

Deal, will do; I'll retitle/rework this commit and extract a function to 
get the phy in similar way Linux does and send a v2 after testing it.

Thanks,
Ricardo

