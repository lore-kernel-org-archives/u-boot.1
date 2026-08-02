Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82EFC55162
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 03:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B545C403FF;
	Mon,  3 Aug 2026 03:51:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bGz1F-BI8EpT; Mon,  3 Aug 2026 03:51:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0C4640352
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785729085;
	bh=YElmGtuNdrxBMQhx4PQrx2P8TOfT2xu0XWlb0ZtQ/w4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=yR7/roqSS6ZnsJWfN5HUywLR6Xz95NnXLs+Paur6Ok9WMJKRwt6e1PlZUXJ0V2Tht
	 Jr6LE8jXgwj6zQy6o65RExX631l4isOO/pruO+gce3eYyMhrwTa07uwlTkmm3jBPHt
	 wk9Q8MjVlnsVBzAtHtFXKqAdHp5TwPu7XOB8SuECAIU8SeUkcxu+rtowfwlljfhJ+J
	 f0c2NjKQb79EXpg0vd4pyUQmU+aNQmBPviBJsE3SzF8kl5LQCp7ph/pLNdqhDziQLH
	 S6AmirA4HGv0ruxLQhxSDTF8Lz1iqTwfzw786BoEh6Bq3RKj57RHmcBk+ThLRPpyx7
	 /1HAqOXswBo+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0C4640352;
	Mon,  3 Aug 2026 03:51:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 42180109F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 03:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F4DF60615
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 03:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L0jq4yynyM_P for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 03:51:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F293860616
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F293860616
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F293860616
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 03:51:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D20A384867; Mon,  3 Aug 2026 05:51:19 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B520D80087
 for <u-boot@lists.denx.de>; Mon,  3 Aug 2026 05:51:17 +0200 (CEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hD2ll42lSz8tx5;
 Mon, 03 Aug 2026 05:51:15 +0200 (CEST)
Message-ID: <223e00f2-4a77-40af-b7c3-2226f5a5bde1@mailbox.org>
Date: Sun, 2 Aug 2026 19:34:17 +0200
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
Content-Language: en-US
In-Reply-To: <a5ef6e24-cf8a-4463-aea0-8533de3d7521@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4du3pzi5j7r9t99nbrt18i47p11nbjgi
X-MBO-RS-ID: d694d7213f1a6e07859
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785729075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YElmGtuNdrxBMQhx4PQrx2P8TOfT2xu0XWlb0ZtQ/w4=;
 b=oiZ+OuVreFiMW/kjxziQNYRXkHbnQ+cH6PLBbC/9MFm3ccV/jMtWcagmtA07boMvvZajcB
 zQdRphDxx/cpc0LvZwFlS2hdBqqFxJpqG+vMdWgGgqSo/Cquomjz2iHqHXy8EvM/Vgp0rJ
 JB29rggTT9NrJDOhCpfGkHr021mEUI+Ss3qrtQQtgS1S4xsCR+Tg4IECHhWSHP/DMpos2n
 qdsBvVpZ05d3xA6m6fdAqE9k0+96THYNTRqXZ05S3n2M1dJit747z6N+u9ZRI99IikOpNM
 qMUQ4SzBx0dnpy7ZArVbO17v8Jf63Vy9GhpvK5l3r0O/4YjwMwOzgkP1YKcyAA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=oiZ+OuVr
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marek.vasut@mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="oiZ+OuVr"; 
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

On 8/2/26 5:06 PM, David Lechner wrote:
> On 8/2/26 1:57 AM, Carlo Caione wrote:
>> On Sat Aug 1, 2026 at 11:52 AM CEST, Marek Vasut wrote:
>>> On 8/1/26 8:42 AM, Carlo Caione wrote:
>>
>>>> Hi Marek,
>>>> can you PTAL? Thanks,
>>>
>>> What does this mean ?
>>
>> Please Take A Look? :)
>>
>> Cheers,
>>
>> --
>> Carlo Caione
> 
> The question I had is that this patch (v3) is assigned to marex in patchwork
> and is marked as "Superseded" [1], but there is no v4 that I saw that would
> superseded it, so maybe it was marked that way by mistake?

Probably, Tom ?

> I just wanted
> to make sure this patch didn't get forgotten because of that. (And I assume
> Marek will pick up this and the other mtu3 series from Carlo in due time
> rather than me picking them up via the MediaTek tree.)

Which other series do you refer to ?

> [1]: https://patchwork.ozlabs.org/project/uboot/patch/20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com/

-- 
Best regards,
Marek Vasut
