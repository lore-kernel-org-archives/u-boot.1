Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB689C56201
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 10:51:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EC1C80BCC;
	Wed,  5 Aug 2026 10:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uQzda7rywRai; Wed,  5 Aug 2026 10:51:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E796780BBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785927108;
	bh=nrLzw+/VdQs3twlep4R/YDzKBB4T9r4laL7qb1LzgL4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=VvEzxSZdH9elbXJxo3qFuyn58YlQ4MX1nzrvLu3yI3hrjz5BJqOZEGBwfWoOHSM/1
	 LGT6XAIhptFm2d3qo74kmf579ETikADw7S/68059nEUQSH43sc2us/YNCrVBn/je84
	 KRdsL3om5WbW4f5MOztAg93GMu4fqPdLfqd98szf/kEz7QikVIOROIh2IeyHMd9HHc
	 0HDAm28aPPCj2A0GgaqroFqaVQ6SU0DocaNVXvl/GYaeTX4IE5SzdsMhRl765czLSf
	 PtO8/Y38dR8rySR/J/ZxjpdhEclHIbLQ4U6WOItg45sqjEHePCXdGRopDjDWSCz1Ax
	 8O/ps4YM/zAzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E796780BBE;
	Wed,  5 Aug 2026 10:51:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 786A12B6
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 10:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5DCDB40061
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 10:51:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BsfREkOtGkj3 for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 10:51:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 28EA84004D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 28EA84004D
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28EA84004D
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 10:51:44 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hFRzx2CXszKnXV;
 Wed, 05 Aug 2026 12:51:41 +0200 (CEST)
Message-ID: <e86f4c8e-7043-4272-85d5-a3cb1b851a2e@mailbox.org>
Date: Wed, 5 Aug 2026 12:51:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5] usb: mtu3: support the upstream devicetree binding
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260804-ccaione-upstream-mtu3-spl-gadget-v5-1-5c3b6ec44eb5@baylibre.com>
 <d1843b10-df7c-4f65-ac1f-0c2f5c6cbe3d@mailbox.org>
 <DKGY0BWU7SO0.3L78LYC856KGI@baylibre.com>
Content-Language: en-US
In-Reply-To: <DKGY0BWU7SO0.3L78LYC856KGI@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: jxibs5d6i67d58fxq95ar6fmouzw39r6
X-MBO-RS-ID: 01cbbf372bf680702c1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785927101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nrLzw+/VdQs3twlep4R/YDzKBB4T9r4laL7qb1LzgL4=;
 b=GYOl+lYg2QN1PdBKizlhNTslwVqbSJFIY8Ebjz8JLSjTAZEf7wJYNBqG3fbGqro6ppWjrs
 IM3h3KhFcrpUbTqpGw0LwbSbQPcuKvhm5SGoLc+ooGde2otfigwJmKewqd4kJuXZwewVsh
 DusLGShCsiMqOd5AkYAbg/zfgK6JDtaCC6LVBWugLS1NMoBm7q++KD2prcCF91HCtz7f7C
 eytfFgMaFUcdkv0R5tCzMD/wlEQ39bB1Y2saQMydqpBGhOte4NawqUvhgrKVPqimJ1/kGC
 d6s3UK5iFSMf1n0mtsIt/wC8QPPfSEiiNJtK5o+j21q88vSx3HMWSz+gEZJPZw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=GYOl+lYg
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

On 8/5/26 12:37 PM, Carlo Caione wrote:
> On Wed Aug 5, 2026 at 4:37 AM CEST, Marek Vasut wrote:
>> On 8/4/26 12:05 PM, Carlo Caione wrote:
>>
>> [...]
>>
>>> +++ b/doc/device-tree-bindings/usb/mediatek,mtu3.txt
>>
>> You could easily swap in Linux
>> Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml and
>> Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml instead ,
>> and drop the mtu3.txt . But please do replace the binding documents in a
>> separate patch.
> 
> Shouldn't we just drop both
> doc/device-tree-bindings/usb/mediatek,mtk-xhci.txt and
> doc/device-tree-bindings/usb/mediatek,mtu3.txt and automatically fall
> back onto the corresponding ones in dts/upstream/Bindings/usb?
Even better, thanks !
