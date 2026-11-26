Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE9606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i0QihCyy;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=FIPvW3jv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B01260AAA;
	Thu, 26 Nov 2026 17:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0qV8kUaUattb; Thu, 26 Nov 2026 17:42:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 248D260A9F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795714954;
	b=hcOKqKY0vHyPB7BhJeKVleCEvYfEE8cpZYy2QRAcg/fO67THmZgsnNtCVzhGjxia+iLU
	 jk5x67YrVDCbQ6SSvPXzBN3aYNnkmD5PqbF8EwumacnpW63p0Z7zQAho0lYYsXkgiSqAP
	 jvwYTPZHrCsUzDC0yYFMJczZC5Cgaw6dHvRKac59Rnln5nXBrWHAnZHFEJxL+0+5lOfBN
	 V+bDL1/2gRy5KM9aFWYiaGe0QYVr+ybWZn1cq5UnT7WC9mUWHtbLHg/nbcbwnGcGpjCsF
	 njub//pKvNLxb8oJWuNe4zeNB2ncZvb9S32kGzLGKYXvRkuiIEL7et60+oitSiclW/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795714954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2/Dpi4P9qEhoKUyEKdPiB502QLk53VDCi/sgZt/wF0M=;
	b=JrKyd5PBPwPBRgpxCZrTEauwkHGoEb6dD/KQFExYVgKuluQiUk5hqeSJ1qoaED5m4t2S
	 3OVBYfO+jgtCB8fsXq3X/BLq0AkUyVOlR+8DzGIOfIhjbbiDCQwoDE9crXqgcbF29C/8l
	 i+6tHa3vBytorOrbmRPZjnnwgZmWprmgg14ohzakhdPDHm4h+VZ6c2xFOncX357bFD37S
	 pI+OvRqmv7NEYvD+2PfF+dfp2zCmvnxQCQdfzfvZIUIQC/ERrW8juEAGG+DcmnHI7Os4k
	 qS/YLe0DmHFqksMRd+6IBSLDpIJlfcfgnsQRVHgXY3R6ZaTaftftp+rr3ztbkrfyvAA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=FIPvW3jv;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795714954;
	bh=2/Dpi4P9qEhoKUyEKdPiB502QLk53VDCi/sgZt/wF0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i0QihCyyb67psAP7iV9lbBnrcZQS2ECSkbp5R7UdOXpOovRSzGDRmF9LLzUdGm++a
	 42PhgLQeMBT78OLHnZ/P+hAB2J0/bbQ+7IALLrilMkWRWCHi8ZMfy71V1k380bjzHO
	 IywCAhGJrGoME+ZUsIbn3jYO8jQeOw+n6SKa/O79FSdf1PGc2NBtPSYRmlCGntAtuJ
	 nJ0qkPr2jiQ21+ad/bwPCG+TaZBhkwcXqlFqL6+3gC4cK7IMuHlbYkVr3B6x9qFPR1
	 lc0bHIHLYlBdwla5PD4wjpYvlwMYAoy+DQS09hIb2F6AkuP0lN6yU1pUMsM8T305G0
	 813aJhOt1qjGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 248D260A9F;
	Thu, 26 Nov 2026 17:42:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 014C010B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB51F60A9F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:42:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8r95BoHXYYpk for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 17:42:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 23DDF60A6E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::42ae"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::42ae; helo=smtp-42ae.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=FIPvW3jv
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::42ae])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 23DDF60A6E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:42:30 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000 (Postfix) with ESMTPS id 4jb3lm1trQzsdv;
 Thu, 26 Nov 2026 18:42:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1795714948;
 bh=2/Dpi4P9qEhoKUyEKdPiB502QLk53VDCi/sgZt/wF0M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FIPvW3jvxtfH0lVVYUaVDxSBRquHpo8XscfuzaafKqOLRvsSOUHiS14MGq/TRFLFo
 Ivmk6u/FvhrW4WksPGGy32rDKlBu1T++kwfqIWDbiYOtXvNCCYKnXjs+pQOyqi4UzJ
 nBQLV/Jx86OO8E7fvn7rvSldmS95T+ww4LRsfA1NJnMg7mALFTdC/PgkkE9zEeOLPw
 KCkmW9uAD4LhQuUGSGDQW9Cnt6yimqQ/eujG/gSLKLJHtrcxQBULgxBN8L/BJKBSCQ
 Pjb6xxaJEr8dqetOwKwd1CL00lf81nWyQpoJk/O/33nWsvXomMwiwXeYNB8rzRNZTQ
 r5dlHsdkp2/qQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jb3lk2mTxzdcS; Thu, 26 Nov 2026 18:42:26 +0100 (CET)
Message-ID: <fb5f21e7-ac32-4d0d-b825-5aec96ece829@0leil.net>
Date: Thu, 26 Nov 2026 18:42:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ata: dwc_ahci: fall back to the PHY in the sata-port
 subnode
To: ricardo@pardini.net, u-boot@lists.u-boot-project.org,
 Kever Yang <kever.yang@rock-chips.com>, Eugen Hristev <ehristev@kernel.org>,
 Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
References: <20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net>
 <20261109-rk3588-sata-fixes-v2027-01-v1-1-e54ca8e68f18@pardini.net>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261109-rk3588-sata-fixes-v2027-01-v1-1-e54ca8e68f18@pardini.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Ricardo,

On 11/9/26 3:57 AM, Ricardo Pardini via B4 Relay wrote:
> From: Ricardo Pardini <ricardo@pardini.net>
> 
> dwc_ahci_probe() only looks for a "sata-phy" PHY on the controller node.
> The RK3588 device tree, as synced from Linux, describes the PHY in the
> sata-port@0 subnode instead (the binding allows per-port PHYs, which is
> how Linux's libahci_platform consumes them), so probing every RK3588
> on-board SATA controller fails:
> 
>    => scsi scan
>    scanning bus for devices...
>    can't get the phy from DT
> 
> RK3566/RK3568 sata1 and sata2 have been affected the same way since the
> v7.1 DT sync (d0a838bdc62), which brought in the Linux change "arm64:
> dts: rockchip: Add port subnodes to RK356x SATA controllers" (linked
> below). Only RK3568 sata0 still has the PHY on the controller node.
> 
> If the controller node has no "sata-phy" in phy-names, use the first PHY
> of the first enabled subnode. A "sata-phy" that is declared but cannot
> be resolved still fails the probe. Only one PHY is brought up, as
> before; the RK3588 and RK356x controllers have a single port
> (ports-implemented = <0x1>).
> 
> Only tested on RK3588.
> 
> Link: https://patch.msgid.link/20260201191804.41421-2-heiko@sntech.de
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
> ---
>   drivers/ata/dwc_ahci.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/ata/dwc_ahci.c b/drivers/ata/dwc_ahci.c
> index 0431d370716..8192d2f5f34 100644
> --- a/drivers/ata/dwc_ahci.c
> +++ b/drivers/ata/dwc_ahci.c
> @@ -57,6 +57,19 @@ static int dwc_ahci_probe(struct udevice *dev)
>   	struct phy phy;
>   
>   	ret = generic_phy_get_by_name(dev, "sata-phy", &phy);

question: relevance of getting the phy by name?

Considering the Linux kernel driver completely ignores phy-names as far 
as I could tell and simply get the first phy listed in phys, and that 
the dt-bindings doesn't require phy-names to be present, should we 
rather switch completely to just get the first phy listed in the phys 
property too? There's only one Device Tree which has more than one 
phy-names when sata-phy is mentioned, and it's not one handled by this 
driver here so this seems safe to do.

> +	if (ret && dev_read_stringlist_search(dev, "phy-names",
> +					      "sata-phy") < 0) {
> +		ofnode node;
> +
> +		/* e.g. RK35xx: the phy is in the sata-port@N subnode */
> +		dev_for_each_subnode(node, dev) {
> +			if (!ofnode_is_enabled(node))
> +				continue;
> +			ret = generic_phy_get_by_index_nodev(node, 0, &phy);
> +			if (!ret)
> +				break;
> +		}
> +	}

issue: diverge from Linux's implementation

Linux has decided if there are subnodes, then we should only parse 
subnodes, no fallback to the main node. If no subnode, then parse the 
main node. Please go with the same implementation.

I know the Linux kernel iterates over all subnodes, but in U-Boot we can 
still decide to stop after the first subnode with a valid is found and 
let future contributors handle cases where there are more than one subnode.

Cheers,
Quentin
