Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4559C5DF66
	for <u-boot@archiver.kernel.org>; Sun, 16 Aug 2026 23:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80704606DE;
	Sun, 16 Aug 2026 23:44:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GWoEt-6oMrrW; Sun, 16 Aug 2026 23:44:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2595606CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786923886;
	bh=fqGklr8zM2mQVV2wuFZJ9+0DFzj4Seu+XHu5eBv7jB8=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=EUKsQcvRLe5mAY3B4Tn8KZ0ugkuKmi3i/K9hsScH4spJxmCx/tRi3YvEQ5jw7/saK
	 vHlbgkHkiddyIBCyCt6hfO4csqQ5lu/eiNmgAppsqDJBUYFfCGKoGgjKJdUdYfuSON
	 zNkPJ0x26hPZfj/A0aIPnnQO8iqvqmgFIWTOD71o060RenOvBdNHW478Jfpqke2IIV
	 d1JwEsV8O7kF+qMoU8EPWOG9R5SrycZOlUX2vItd+0nUlwfuUUheB4kJEvb0/zE669
	 +u63gqH3LF3fxPuVuPl055ZAVuZtX2naqWSQutzp8rJBHdPCxQ1v5gZw6RvqqwLkef
	 cRU7F5FfTwYOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2595606CC;
	Sun, 16 Aug 2026 23:44:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CCE1194
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32AE580C42
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:44:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5jvP4eT-zvAY for <u-boot@lists.u-boot-project.org>;
 Sun, 16 Aug 2026 23:44:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7D41980C43
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D41980C43
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D41980C43
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 23:44:41 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hNXck0CzpzMlHc;
 Mon, 17 Aug 2026 01:44:38 +0200 (CEST)
Message-ID: <610a7b4b-1cd3-4fbd-8afd-1463df52b915@mailbox.org>
Date: Sun, 16 Aug 2026 14:07:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] pinctrl: renesas: r906g032: handle pin subgroups
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20260814-rzn1-2026-10-pinctrl-v2-1-95dec872b1ca@linaro.org>
 <68bf41a9-8b6f-4d55-a0d4-9b999022b06a@mailbox.org>
 <aoBvY59NI-gp7lpk@maple.netwinder.org>
Content-Language: en-US
In-Reply-To: <aoBvY59NI-gp7lpk@maple.netwinder.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 43fmiwfebm1gaixpgoi5mofhp4p834b6
X-MBO-RS-ID: 08a58257f763ca038a3
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

On 8/15/26 3:53 PM, Ralph Siemsen wrote:
> On Sat, Aug 15, 2026 at 12:00:23AM +0200, Marek Vasut wrote:
>>> diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/ 
>>> pinctrl/renesas/pinctrl-rzn1.c
>>> index fdc43c8e714..6c8d40e9639 100644
>>> --- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
>>> +++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
>>> @@ -298,11 +298,24 @@ static int rzn1_pinconf_set(struct 
>>> rzn1_pinctrl_priv *priv, unsigned int pin,
>>>  static int rzn1_pinctrl_set_state(struct udevice *dev, struct 
>>> udevice *config)
>>>  {
>>>      struct rzn1_pinctrl_priv *priv = dev_get_priv(dev);
>>> +    struct udevice *child;
>>>      int size;
>>>      int ret;
>>>      u32 val;
>>>      u32 bias;
>>> +    /*
>>> +     * Handle subnodes recursively, so that pin groups work.
>>> +     * Note that properties are *NOT* inherited from parent.
>>> +     */
>>> +    device_foreach_child(child, config) {
>>> +        ret = rzn1_pinctrl_set_state(dev, child);
> 
>> Can there really be infinite nested subgroups , or are there always 
>> only groups with subgroups and that is where it ends ? Linux 
>> Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml 
>> makes it look like the later, so maybe the recursion is not necessary 
>> here, instead call device_foreach_child() { device_foreach_child() 
>> { .. } } to prevent the possibility of infinite recursion ?
> 
> Realistically there will only be groups with one level of subgroups.
> Perhaps if there was a phandle it could go a few levels deeper.
> 
> Unbounded recursion is not really possible here unless:
> - the device tree is infinitely deep, or
> - there is a very serious bug in device_foreach_child()
> 
> As these both seem unlikely, I opted for the simple recursive call, but 
> I am happy to change it if you feel it is better.
Let's go with bounded one-level-deep parsing, that's what the bindings 
describe too.
