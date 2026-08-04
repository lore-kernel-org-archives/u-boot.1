Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBF5C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 04:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E824B406BE;
	Tue,  4 Aug 2026 04:33:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mSXPiTDOFCQl; Tue,  4 Aug 2026 04:33:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E918A406A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785818023;
	bh=q39IF3AsTRi9jne8QMGecY6D1WwL50wOVh82ND8hmH0=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mT+TRV0vNgQZED+Hr1Nn0Z3iiunAFSV7yGRypqzsCqHXP/a+2hLrjAX6B4BeGb0tM
	 4bDLd0B5sH4vStXbdxBph3UcaPnBu9BvkRevMsDYqk9V7E/bbVd3uWKa5KlJ3MDOST
	 i2cz3y2nFdOeqsdmffQhPWawM5PP4ulZrQqsG9fTQZMO5a4MVIiNqxRYgAkNUZe/A/
	 nTTHHH3q4Z7SbNZONwwCd2Wm/QK5bGpYDpVKpiF88CtLLY7g2OO2BwTUqvvAvc0g6+
	 yoCZBabKH1Ew/+2BigQuNPQf8UvgxnkUQaxtzOACV6JBOlM345bJqkDEOhLqXwHIzP
	 eBthyBUAUJgpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E918A406A8;
	Tue,  4 Aug 2026 04:33:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D96F3194
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 04:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CABEC80B8F
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 04:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CttDVWokwHAO for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 04:33:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3864280AE8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3864280AE8
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3864280AE8
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 04:33:38 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003E7842FC; Tue,  4 Aug 2026 06:33:35 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D42B80087
 for <u-boot@lists.denx.de>; Tue,  4 Aug 2026 06:33:33 +0200 (CEST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hDgf31DW8z8sxW;
 Tue, 04 Aug 2026 06:33:31 +0200 (CEST)
Message-ID: <f2c3fe0f-b5dc-42d7-a3da-d336438eede3@mailbox.org>
Date: Tue, 4 Aug 2026 02:51:53 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] usb: mtu3: wait for TX FIFO to drain before disconnect
To: David Lechner <dlechner@baylibre.com>, Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com>
 <DKDEITT18XJS.18WZM0Q9PGROO@baylibre.com>
 <4de93606-a4c1-4b69-bfc9-328c2aa29c4b@mailbox.org>
 <DKE9GVL7TX0W.2VF1JM6SOE2I1@baylibre.com>
 <a5ef6e24-cf8a-4463-aea0-8533de3d7521@baylibre.com>
 <223e00f2-4a77-40af-b7c3-2226f5a5bde1@mailbox.org>
 <eee9d4dd-a9ee-477e-b748-020577040f0f@baylibre.com>
 <62fde4b6-0e0c-4507-b081-a8473090e692@mailbox.org>
 <e241fa42-59fa-4aed-a92b-7e45f40fcf6d@baylibre.com>
Content-Language: en-US
In-Reply-To: <e241fa42-59fa-4aed-a92b-7e45f40fcf6d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1f10d9d4fe796b843ee
X-MBO-RS-META: 9xyi6pmxufxzjojarz1ziz435qwama6b
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785818011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q39IF3AsTRi9jne8QMGecY6D1WwL50wOVh82ND8hmH0=;
 b=YSvAR+fH1+6+hFP2NH3ZfI5uk4LZkamA7QYJLWG/zAqyMXKbK6nT+gVBZlAq1oeIWXaZ9C
 Up/nrM3CPWNRT9O5t27jGZPB5QavODMwnSwJ1hBeH/7d1cvENWQUDBkBTr2M6ngCjGwu9j
 WW1rTfuAmy6+ihbRChuEV3E2qDkBFD6ir79UBl4P3xMUaaKi6C7jpG0m/SJAxers/3mKWr
 nV9EtN62ODz/XmRUe/ychQv4JQd5haWpq+S9PMWRJ2v8n09NE03aKFSlvRMYkDmH8KjNg4
 DTVXuAObtvB3/jT/Hy6THeKMkQ9oRD3b8ccXxEzaBnfKEfs9SMfwkEqR2CRJfA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=YSvAR+fH
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marek.vasut@mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="YSvAR+fH"; 
 dkim-atps=neutral
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/3/26 11:04 PM, David Lechner wrote:

Hello David,

>>>> Which other series do you refer to ?
>>>
>>> v4 of "Add support for the MTU3 upstream devicetree binding"
>>>
>>> https://patchwork.ozlabs.org/project/uboot/list/?series=515127
>>
>> I think I commented on that one.
>>
>> Also, are your concerns from V3 addressed ?
>>
> 
> Yes.
All right. I commented on the V4 too, let's continue the discussion there.

As for this patch, this one is applied and PR is out.
