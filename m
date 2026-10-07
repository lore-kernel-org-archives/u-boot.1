Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA05CA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 09:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC9FF406CC;
	Wed,  7 Oct 2026 09:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V57y2XbeJeBx; Wed,  7 Oct 2026 09:45:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B45DE40634
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791366305;
	b=IzOvWFopFAw/NXnfOaoqRo6+jiZ3rwmQR+Fnxajgrfj0rLiqOiozRnmVgfDprjRzAKQb
	 6qYCpmAQ/ifREOlWoyLr+OzaJLV98VdayWOHOVGA3TxWHJaSqrhIhS9x/saEOfCGzKgr9
	 eZ63BZ3vsZsKtZPZORX8UsvUa901BMf6S1O3pYcPAF8Fef2sBO1tpMq1dRRwp4jn6myt3
	 oYQu2hwtD9kiTPBuWpcISRyEdlxEu+aeg/ekZITquN9Hsy6itahvyzTbO9v5d5u1y7nRv
	 AsaIWJ7ZRTox26FknxagEfzP0h8fF4lGO5UfrfiofEVRO8CZh95aPXmXEHXUDtK++WA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791366305;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VODJN6BXnLqahT8JrN1de6v9A1X+J/FAqI9FRf7wdNY=;
	b=dBQ/SAVdN/4ZyDdRTUg4i3uYDiSLV0G2RdElRm4Vv1NWU+jTH06L9gOVu2kWBHqXx1Kt
	 c0tKWQgj11pATs0nDiUssxQKYIH4gQTt0GuSDoODZg886wO/lMV0rdHSLEqu3w63aBZpL
	 1VHMZyf0j58RLs5nKDAKSAC2E6PDo6HMQmgSz+4sOOK8bYr+DhtxMjRa/JJUdvmXMbvvC
	 rqy8vvc/yuF8IzrlGY6nNEWcG7unzi6kHsmE5FBOzzdVEpX2tp7JJVn0RoBsiB6cTD9DJ
	 OCVzPYU8YSU7ABBMtcvGDbJ1JPRkOAFmkWRgZup/mpP+vtC+Fi0Fpr+7MQajnb3u8Cw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791366305;
	bh=VODJN6BXnLqahT8JrN1de6v9A1X+J/FAqI9FRf7wdNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KX/odLqvyCjj4Mg8KAblo3SjvEo7IKWjJ1Ri2IXDOkkdouHuDUYdgheVTmwNDqJBZ
	 KNSQeXlzJ0nHJXKG6GBtVMgIvhoUKZ+WF0b08PbrIal3IXvWwxE90HXJGvXujAvhYO
	 grH/eDj9Vw3a3ucdYfYIzgZ1X+3sf/oUj2YC3teYkrcJfRSylWbb1iueIROQk+G7wW
	 pCkcdWypvkLHTAkfVaTyG6Uc/ZUrZyilu1TBUuXTJqqM+aTPPbBBDUzLqFkRCNknQf
	 iD3PVo8OdlKMxfll/D66ZOfX9o6cwyAGn9iCQXSaky9DW1hdEM1WHg2kNp8VyZpqPj
	 mQ1u15o7EPEDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B45DE40634;
	Wed,  7 Oct 2026 09:45:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C377032F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B499580ED3
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4sSYMADW-CY8 for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 09:41:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A666280970
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791366074;
 b=gDm0HqjJ8wJ7mv1jOvEGaoGt9I2N7MRF0cmpnUdd11tAxWkaeDBDNMPGhAd2AuT9h9yW
 M2PgNF5D9YzkfSsdDG3ZoeGhsraUS0QA7bgUfmePY2EOjzx/Yz9alxW3CSr58pO/2u3Qs
 1gX3fbJUHRlAoRwGad9VPZivVWh7y0w30C8E9T0013aMt7X53S9gV/zRGMrMmCw1lRJaR
 HOVETgw1N8zB44nl2HnCZEhBwUM4OrOD8iIOnhc16b7NPhhJzjPzPMs+ULgCVfL2q35T1
 sM+Mwv9ypAcMk7PnL+I9QQkcO0gSci/rxIIJ+eQEb6QoMmFUGVzm1eNREtfd+Zvcvqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791366074;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=VODJN6BXnLqahT8JrN1de6v9A1X+J/FAqI9FRf7wdNY=;
 b=Wr8VTC6ZK+NrApS35JS+S+YlBbTgj6EfLg51p3VFXbJg7ZaojmwDX85PoPqC/g+CxI9Z
 95DZtvRtNgUZCy/FxoBhJJROgIzQ75Ec/lihRk5+tz9rxO85Q2WNFOynlaLKmBIGsQzMP
 onB1Z/1JHPzfxgKOUw7R0xjWWIhAbhXacmhMmj/aOJbP4HjNFapvBWUExQ8Df1T6UM4hQ
 ObdXuNuGCqyGYdQY+6Ra/FDofvMzdXScg4yd+ibeiKscbG4yEwqXJ1cJsJ+gMzv2e0Iw0
 APYOhAfsBOrt7KCFLOcTZY4HrYGCRO1stDjq0hMkigUsg7O0Y2fMchShed9Ouc7utpA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=US5MU8z5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.12;
 helo=sender6-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=US5MU8z5
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com
 [165.173.180.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A666280970
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791366067; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bPC7NFfCjd3YfQDOa92Hc6+TcdX5VHQobjWlKLBCktxKUdwh536JCz90gA06JA3+UNDFJD3mdjw4voJ/hlMDNSuiOtYiMa3kN2NWGQHS/FobofrebiW3lX0gBn0/G6zudXHf2XPyBa5c42QEnQFUDpnn/fPjLdZI1/Ghjt4oJYM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791366067;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VODJN6BXnLqahT8JrN1de6v9A1X+J/FAqI9FRf7wdNY=; 
 b=JFMwj/JSG5aZTRd9enXJe4bU7t1vltFRliqXCja0nXabaCNVH6qWAyklJe4CUkdHpSvxfXGLl2FeED7IH+ZWGAhv9h/MFpalSbc9JIQ0S2UNB0eoyE8pticPMHc6UsM5VnIkjwn8C8MDj1xdAMsEdui2hnddxms6+mhJG9g6B50=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791366067; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=VODJN6BXnLqahT8JrN1de6v9A1X+J/FAqI9FRf7wdNY=;
 b=US5MU8z59S3gpg7iDNN1HufbC9ZP8QJAWc4QLPaQTil58nUyBKmEHIeThs1K4td7
 2QEsoEg7fWwNvWpMW6lHK6gn39h55D3niu2LbyUJ7QEgRHovvGaFwrv8ytZ/4+ePEpD
 hmMlZbFinDB0s2PmY4/szpMvMvGC/Nl6RoIy1sM4=
Received: by smtp.zohomail.com with SMTPS id 1791366066567941.1490553155144;
 Wed, 7 Oct 2026 02:41:06 -0700 (PDT)
Date: Wed, 7 Oct 2026 09:40:51 +0000
From: Yao Zi <me@ziyao.cc>
To: khaliforce <kforce@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] serial: ns16550: make probe clock enabling optional
Message-ID: <asYTozF_pL1xVHfr@pie>
References: <179128521949.5.18128894373298117517.uboot-uart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179128521949.5.18128894373298117517.uboot-uart@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.359.0
X-ZohoMailClient: External
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

On Tue, Oct 06, 2026 at 08:14:01PM +0900, khaliforce wrote:
> From: Samuel Holland <samuel@sholland.org>
> 
> Some platforms need the UART clock gates enabled before NS16550
> register access. This is required by the downstream Allwinner D1
> port used on the MangoPi MQ Pro.
> 
> Add CONFIG_NS16550_CLK_ENABLE to enable the UART clocks during
> probe when explicitly selected by a platform. The option defaults
> to disabled, preserving the existing behavior on other platforms.
> 
> The clock-enabling code originates from Samuel Holland's D1 work.
> This patch makes that behavior optional through Kconfig.

I think the appropriate way to model this is introducing
devicetree-compatible-specific behaviors.

> Link: https://github.com/smaeul/u-boot/commit/0617377a2555031f02a459b3451fa33ce53e9b74
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Co-developed-by: khaliforce <kforce@gmail.com>
> Signed-off-by: khaliforce <kforce@gmail.com>
> ---

Best regards,
Yao Zi
