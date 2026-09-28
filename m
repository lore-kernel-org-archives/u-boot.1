Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFE0CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 14:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABFD180D64;
	Mon, 28 Sep 2026 14:30:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id brO2zrCa4VV7; Mon, 28 Sep 2026 14:30:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D5C9980CE9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790605836;
	b=K6BQ0bMZs6uf4iGkbG07vNDJ/S0bHpdiOnQTZKxI2UU2XpezpFHCCBETllSqE+afJc5x
	 FXYUtVMnn9HB1hEgHoxfF4w8GLzBYV/HlG8P4HZ9ELRJPL3Uqwgxkxduuo9gG+1QTIJ9Q
	 9NwGguagm/4wswsRMgN6Fbfu4yjVnKtdmdFIi1eK3dQZdMpy/4CoS+vbfHvvt5DWzvvkp
	 GxNoBQvUtIBs0KaK9bIaWA+iRg+xf7ItNtZIBwpji5sSF8qyo1SU/EGSl7i9WO7eW68cJ
	 Z41s7F83AzWKhpJ94q05ajy+T3svo8Rr196PUkKd80ovtiGMIywmDf0Xi4k0mnMXMXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790605836;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zPMRV2rAQO+l9XcPoBLd8RPHylfKxH3l80ndsboJJ9g=;
	b=kAitcq88wOaseYE+4qcPAWUkzEeWogSHe2cyup6THmaqykI1MfpD8mKosr6Xkx2UbimE
	 ByWOTwQVkzkQCKheW385Bhhbtr4iWWBLHCWDzQ+OdDr6/EK2g6ofrG+0Y0U2c3CdAMGKV
	 sN3bNskgrlbgpAha6j7Lq4bcN5ei5AQV2N5HLdwr9bWJaMvRMsKJaqpQ7sS8p7HD+dctL
	 2YJCJrUobvQM5Y3Nnbi1AWDIZbNI15V9K+5o+OgKfLopBrEiltJ5zJ/MXjiGDKCILjw5o
	 mcezH88noqPe1LQd5Mw3EG5XXXYF118AwOPfAXja3xEZVx8y/kJfSR2aFisYg+pliKQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=N+95OGI3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790605836;
	bh=zPMRV2rAQO+l9XcPoBLd8RPHylfKxH3l80ndsboJJ9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m/hUZz7dRArR/6oC7G5v8QZe8aMY1GZ4Z/3NoaIV11hMkyO2TRDeIyKjfQuHNh7ac
	 gCqWwa3PlvwO45n2pCdj9E6sdhY9MHS8C4IdzqKDHt1DftaC+jXUyUJGd8/UdXHPqR
	 LNc2QeE8Radhmr/T3hveWaXSBqb7CmE1u8NnkZpj1pKq6Oi4brPiBA7+QidanUHXhX
	 NHxISYrGk9MF+9mNl+LUWYrKfAHxM4pZJUkeU00btKgDBZaOA0BpxuUFSk6ihJmz3R
	 6hpLjhTBflJttVcSm0Z+3Nl+ErtVBIVpkdJtCa5k5RJwXASTDooJIM29rd9dqVZ98D
	 cWS+igF4uhdTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5C9980CE9;
	Mon, 28 Sep 2026 14:30:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDD27361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B39D780CE9
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:30:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wV14TKy3kKu0 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 14:30:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7DBE780BBC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790605832;
 b=OBv2ZQVoQIANRv4zNukLB9ZheWGjoYTkPT36FBQdBxAA0nbLq4R8nk2OWqvptyOgfzMF
 BjaUCQavCoQq4tLjzKVFNyGRUmGSuGCf9TVzbSkZKt1CiLkLiDC76yIeMPdViTbcu/R8V
 /HPNuf/n3Y7Jeuo2uUR/CqBAfbDc6YVJcVPz3T859iSntyKD1cqiyuUwFwQvdAzKaV9fc
 X8z+WW5XxE35czqcDPcF1WODgP6XmzweW9vl0FPk+tbczNaBnvdQO4Vq4Lmr0C+nW2Vfh
 klAKlIEIZlqqBb/2eZofIvM0dLqTbDGDvJO7IW48L7AHYfte0kI2UJrDEMS6uC6bTiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790605832;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=zPMRV2rAQO+l9XcPoBLd8RPHylfKxH3l80ndsboJJ9g=;
 b=p54CjDNCaRLJMXjfyZuCpVS7PkxMvCVritWGjga6NshDO4lVrWrhQmZrp+c9htc26YAm
 XztDn7uL11BB538ruVo+JjvcgGb5pIZxrcjN0njbGu0iYTqtGKC4h6WvMAJF4GDtAlnZ1
 nJzFRPuD/hxVY/fD48KFMmja+uDADtp8N23QaJpUo3TyRMpjOQc/vvQCtA/3gMBmaEHI1
 H25uvaSFjJtvAerREb5r1EnsVDn6mrdY6oY6nx1n/pQwGXnCaotnn8RGuLDEnTp5mq7Cc
 +vJ/pF8JSWz8nqFlodEx38GrkO/+P3pAxyUpjbfQJtYZGVmu+nwXtW6e7jl8Rf6Uc/g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=N+95OGI3; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=N+95OGI3
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7DBE780BBC
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:30:31 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4htkHQ3vLKzMltL;
 Mon, 28 Sep 2026 16:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790605826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPMRV2rAQO+l9XcPoBLd8RPHylfKxH3l80ndsboJJ9g=;
 b=N+95OGI3h65J1ASh1KeVKLaIp9+ruRo//OeyybotC12KoXjlSlB0qYyKG3vV6tnBKQreEs
 ElPL9vayYL3K0obZJ75FbDecI+5hKHhw7sv8VpPCILp1be8Vv1hXxvof+88AGKkIRPPxbl
 10mWgHOXQu43kV0r04vNBol4YgTulQXvFxSC6iH64BSA9TjZmphXWMwFgNc89rDxK2p7Bs
 qN61bOKIdVl0qbfNILaieNtpJYOKAA8FRxYlbQrwnBrNTW/qiSZF2rUPdcXQB+x0VeaiJW
 /rqEZmfiIXc6GgexWr6qnPVSckMf2kU1n/+XmXsw5OdGKZz4aLGdCnFShy8nZA==
Message-ID: <0c71d3db-1116-44f6-bafb-c2a5ab7158ef@mailbox.org>
Date: Mon, 28 Sep 2026 16:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: Fix ref clock enable error check
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: u-boot@lists.u-boot-project.org
References: <20260928064053.620519-1-jonas@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928064053.620519-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 7i5w6c18artd6ny8enxgwu5nsaihixdk
X-MBO-RS-ID: 47c3044d664319813fe
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

On 9/28/26 8:40 AM, Jonas Karlman wrote:
> The commit 84de44e5e71e ("usb: dwc3-generic: fix ref clock lookup
> indexing wrong clk_bulk array") introduced a clk_enable() call for the
> ref clock.
> 
> However, clk_enable() may return -ENOSYS when a clock driver does not
> implement the .enable ops, i.e., for most Rockchip SoCs where most/all
> clocks typically are un-gated out of system reset.
> 
> The new clk_enable() call may cause USB to fail on such platforms, e.g.:
> 
>    => ums mmc 0
>    UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x3a3e000
>    dwc3-generic-peripheral usb@fcc00000: failed to enable ref clock: -38
>    dwc3-generic-peripheral usb@fcc00000: failed to enable ref clock: -38
>    No USB device found
>    Couldn't init USB controller.
> 
> Ignore -ENOSYS errors from clk_enable() to restore DWC3 to a working
> state on affected platforms.
> 
> Fixes: 84de44e5e71e ("usb: dwc3-generic: fix ref clock lookup indexing wrong clk_bulk array")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

Tom, can you please pick this directly into main ?

Thank you!
