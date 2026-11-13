Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63283606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oMR1Wc4x;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ydt/0ZvP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFB73805E6;
	Fri, 13 Nov 2026 06:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dj2gNEdtRJ1G; Fri, 13 Nov 2026 06:07:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EDF2780E50
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794550038;
	b=BkIbRQl7g/Ew3EMJ9nB6V3cOPj2CIB3ZkLLRiZQkK2vt8nuf4q0kSd4IK7Yt0rjl06OU
	 cl6PfPsdV3SysWKxxRPpq4bJ38KbNJ+KqJjmTKzJzoa2KRrVTbVvDatrFNmoEHmeVlh/h
	 B6DWDjmFFJytK8/XQ7+5F7hTrxbpJrY7TJmVUGi1wDhlYhaCKmjT9o0x/JXJ/O16NDbdM
	 dCjobIRxeu4Mk5Yy2Yq7qIBNhxg5IKPQ57PeKQULCyXQPKplGQVHn5j6WFKCmCvf7G2FC
	 SNM+uvg21/FZOBCDYN87eDHb4Di+Pf5CkHTkyO317IO21ueDfAq7KLqtqz9h1gsLFBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794550038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=T5ADJBKrMv88PLMVQPUtaW+NO8StslLl2ygCNlUdZIc=;
	b=rCr1JklKjBjsBoKju8/T/7oBeij9hNJzgnjHMi1xY80NqJ5JSYAqu1CBkUk8a8/EnQLR
	 eXAaYbsye7S7WETYBpxJIyI9FGsrvNa9xyyX4FGZdAQQ77pgHS1JepZqe0FC8X5nhe3tZ
	 nchE6OkcLQM+rppj0hmfceK+lMp0McVced17VF2jHPrn8KSHfMcjXbMZI7tM4RblsaD0d
	 3LO95JyjLf//NT802+9LvR2h06AiNRwy8dTwQO/RZneyHI3wnAYZqwCdqERiJU4iy4bgg
	 wlRD0Di/wSVmaH0QOXSfrDajdX9nG7XpbvgeOBD+tVqQo0BXDj7yMagLHomLR06rtTA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ydt/0ZvP";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794550038;
	bh=T5ADJBKrMv88PLMVQPUtaW+NO8StslLl2ygCNlUdZIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oMR1Wc4x8doi2ZOs+qBVVRVZB/2ezZgdxFLB/ugNl8mGEcRHqVGrwT91hmvInqv73
	 tzj3o2lBFOs3O5X42TGWN8Zy9rAAY+BH2A73TLWI6FdEY3CJhXR+WXFuHCITQObgFH
	 twJqOWkqKh37JxgFtnBiACRwqdyVeu1AprTiMAPAtUO8wxoFi6hG1RuPxZh9mVX1N0
	 VFM/2KXuHFbw3vRHou4hiAlnBLNnldJsUwGSRXY6Ca+w+Yf2cWKPiUQXpRLUZfMbzb
	 KoT7vptPHm8OTg8KH6NPlU9n/yUvvw2gW2gJrqwdNLKrSyC4NZCkh+lGHyzWKtbSZn
	 DqkgJ3AS/wwrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDF2780E50;
	Fri, 13 Nov 2026 06:07:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ED9A61790
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3D3080D7B
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:07:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L4w228jONpai for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 06:07:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F05DD805E6
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ydt/0ZvP
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F05DD805E6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:07:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A94B61EE2;
 Fri, 13 Nov 2026 06:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651211F000C4;
 Fri, 13 Nov 2026 06:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794550033;
 bh=T5ADJBKrMv88PLMVQPUtaW+NO8StslLl2ygCNlUdZIc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ydt/0ZvP8BK2OcuT8tjmJBBa7Aq7T08Wm+MX0OnyvWfOo3aeaaCnvQSeMFXsmNCno
 lNjR8X6qcZe0XGxyMvReQstgg60kc5XWvEQW2Vgw23OxiJp8NFovvuNgAVH9Ygn7KM
 dUC/a9zWHzAinzlD2i00eJXWYrQy9lua/j0znPWvZu12QhnumSmo6+QciZtE+Mflb9
 Qdr2b9vudJ5DIOm08CMrGgM+omKjGQiUVuaeKlGC2vxY8209FfjnYjAFsEi6kOuNdC
 9b6Y2FmqZ6lxBFvbZ8EfAjhqsa+5cOFdcxCLraX/t7ka05aZtZuCIis0g1Q1qr3bPX
 onjImNh1yruWA==
Date: Fri, 13 Nov 2026 06:07:08 +0000
From: Yixun Lan <dlan@kernel.org>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/2] usb: onboard-hub: VL817 support for SpacemiT K1
 boards
Message-ID: <20261113060708-GKB62271@kernel.org>
References: <20261113031613.435429-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113031613.435429-1-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hung-Chun,

On 11:16 Fri 13 Nov     , Hung-Chun Tseng wrote:
> The Milk-V Jupiter and the Banana Pi BPI-F3 put a VIA Labs VL817 hub in
> front of all their USB ports. Its supply and reset are GPIOs, so
> `usb start` only finds the root hub until someone powers the hub by
> hand.
> 
> This adds the VL817 to the onboard hub driver and enables it for K1.
> 
> Tested on a Milk-V Jupiter, cold boot from SD: `usb start` finds both
> VL817 hubs and a USB 3 stick at 5 Gb/s, with no manual GPIO setup.
> That test capped DRAM at 4 GiB to avoid the K1 DRAM sizing bug, which
> is now fixed in main by commit e6308cc14 ("spacemit: k1: drop the CS1
> DRAM map on single-rank boards").
> 
> Changes in v2:
> - Rebased on main.
> - Added Zixian's Tested-by to 1/2.
> 
> v1: <20261026092432.769146-1-alan.tseng.cs@gmail.com>
> 
> Hung-Chun Tseng (2):
>   usb: onboard-hub: Add support for VIA Labs VL817
>   configs: spacemit_k1: Enable onboard USB hub support
> 
>  common/usb_onboard_hub.c      | 14 +++++++++++++-
>  configs/spacemit_k1_defconfig |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)

The series looks good, with
Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
