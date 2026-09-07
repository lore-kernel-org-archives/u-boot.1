Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A4BC79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D301880C84;
	Mon,  7 Sep 2026 08:48:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PXi6P3L9MVu0; Mon,  7 Sep 2026 08:48:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B7E4C80C5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788770937;
	b=QDjhpibRUdk7bnOHvqKFJcoUV6nZUbdcjeUYrvtJ3I6Dhi0CzARsGlVUx9ei1AFqzXW0
	 klcqobEymI23uEmJ9i1eITBKzy1vuDrpT4RWHNajPRbMq8AnqCgrxz6LRGbc3Gq43MD1w
	 f2sjtqjy99mKecTMnOONHJZJO6ZZ1cKolVrgQAEN2UO1hvz6sbkkmL56J7UpckeMhutpT
	 ffcD1e8SiYAzZArmPVolSx3JV9n4S5qXuwZuZidxY5KFLfR7Owcto1REnVQFGmigYS8YZ
	 QhFwJAirmSNJQzcCHSejxdhONCew/RIghGfuBRoVT3XsZfoxy6Itmc078sciCXhg4IA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788770937;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q85g9LvzoALkp+TtOMgEIehyTip0mWxZO1RO3tAhHRs=;
	b=LqM2oTklHaRWMzFc815CEoqSmfaGg6pffNJcoWx7GcMX21TvpKdt/15uvxrkPbPvuUCU
	 MkNHCU9qzY+i47O4oBqUnAJU4Rd64mIYb3CcS9K/XYrnafs1auUXS7ZuGD8RxBzlfnRZo
	 0YjXKwK0YrUtx9yl2B2reZKdsUD5QiiBqrRz2w9aOJoBRL3LJhOuxmkYLgIi4qtKSgN3B
	 NoB+/tmiKVgmCLSWZEh/G1ErAukehxO3eY3rmKj0/ROItUOKxioez/FxP1thaw+Nu9DBA
	 JMrbeld/KsdL2iwX0T3W1kSPie6X6x/2WXK9T7aJD5G8GxlxhjugG9EvlwBYj41b+qQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788770937;
	bh=Q85g9LvzoALkp+TtOMgEIehyTip0mWxZO1RO3tAhHRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GGhCrSncF2HOUKGAWa99Z1hb/xDXLUWB4cIH7ji69Y/MK2iPxSnU8QVWog8hAzPtA
	 vFi7wXSfuAnhXjlrogRiYl+oM3iR9cxYjVizNJeNJAM02l7r9MDCUwDUZEYXa1ybVN
	 XrNO4OtX/1W7KZdQRXALnFUdqOSzFSZRb1NoE38hgDq8lR8eOYb4Ig9t6onfX0Qgqj
	 uKkDqEfvvEfngVpNJegycbo1PU3cn7GgWY53/KQQ55qi7Hdf4uEbx3b+SyLjaz2uMB
	 /AUPbaRTT8Ki5Ws6xLglbigA19oNLaRtVr9zAvLljGvUHxLZeZcRjh8pc3mt6ieh0I
	 4fpOy1VUv1LHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7E4C80C5C;
	Mon,  7 Sep 2026 08:48:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A2BCE2FC
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94CED40587
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:48:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V8z067Zyt3iw for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:48:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E14024055A
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788770936;
 b=Da3nQ5cbgUtCQtOH01P0hIRqCo/qBjfQIC3n3c6BjSzsx54RVDTpK/Uv4aoqNGFlvh6F
 NQU+HfjceDQTnIzYyThDoKN2NIUmJW2noSh9gX+4/wGGcxhCcU9Km/nLN1hJL3ljZ//JE
 5KKbSDqbGx4qggJu8zqzFyjTPlv+ie9wERkfOdrrDwMk8TLFTP2LndCxTLm3HWEyNBF1n
 WETRa/eSp1EPHr5azu/r4v3GF2xk/6hnF2n3apWcKainn/eM/b9ZzYLwLq5BGeWFbmMEc
 Pe+KTPIFVqvzDctG3In6wVRiCwvk0S3/rbaGSHNzxu+/rc1tVFW5Wa7lXvR3l+bp9tA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788770936;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=Q85g9LvzoALkp+TtOMgEIehyTip0mWxZO1RO3tAhHRs=;
 b=osVrTzBDjlrYxLpQCUVKpTRuBTuCtup6tn5nTF7EuTRNe4pTnsh/A3jQoB/K7UdZVoL5
 AJvMtSEfgcvd+8Gft+H+U3V7mNfRnpcJwkZNIphOEoQl7F4i8nNF4aI8/D3zcpOmCyec5
 i5dHTvyg0Wpdmbp3VnW0Sc7XLa/JitY1uN/uZo0Z5XBmLjt+kFIYnVpA5q1LWxn5gKnLV
 bH5nbI61jv0roPT1fOaXE+Ump6cJTSG5OZ7arnFbiZmvSXHhEKk93Qrooxfe0evPQeoXw
 YFOrU9cHWwdgZ60WhWR/c63MZhUdgbybJy/0wJVo7tv9ATgrUCZzwmF30+C1/8kUU/A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=J0XEoYHh; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=J0XEoYHh
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E14024055A
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:48:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9BB5860052;
 Mon,  7 Sep 2026 08:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCC31F00A3A;
 Mon,  7 Sep 2026 08:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788770932;
 bh=Q85g9LvzoALkp+TtOMgEIehyTip0mWxZO1RO3tAhHRs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=J0XEoYHhFFIq3EIhI5ezO07brkJ42oSfidsYiwR5CM2cvkTsTYaVb+PmUtLS5ICy9
 Y2XVILDpAD6iT4vCTcpnDw09pW7+uz0hNGC7lah5usUq8/XVdTyyKqNqz21rCN6a6o
 5fOmgZAN5ZwezG4sGPBld8chK+a4eX3s5fMw2u8VJHDRgDsC23m7FrbKDEwE3HdXTj
 rm01ssLgAAAClheG6N4CRktUDsogiO7Ez6gw3XtNVx1+XFlu6o3dIUEmReslZodD9B
 O+vBNUd2owaH3SbLuZ5xTY91uYAb6eg9vVeLMB1G2FyrfqgI1ABRovE6LU9M26KL40
 ROuI/Ypm+eQCg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, =?utf-8?B?TWFj?=
 =?utf-8?B?cGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sam Day
 <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, David Lechner
 <dlechner@baylibre.com>, Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>, Francois Berder
 <fberder@outlook.fr>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vincent Jardin
 <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v4 0/5] Add fastboot to SPL
In-Reply-To: <ap2LMlIywWYG9f20@macbook>
References: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d@baylibre.com>
 <apptlqfQNXrfESch@macbook> <ap2LMlIywWYG9f20@macbook>
Date: Mon, 07 Sep 2026 10:48:50 +0200
Message-ID: <87ld9dtpjh.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Sun, Sep 06, 2026 at 17:48, Carlo Caione <ccaione@baylibre.com> wrote:

> On Fri, Sep 04, 2026 at 09:06:39 +0100, Carlo Caione wrote:
>> On Thu, Aug 20, 2026 at 20:08:24 +0100, Carlo Caione wrote:
>> > Some recovery and initial-provisioning flows need a standard host protocol
>> > before usable firmware is available in persistent storage. U-Boot already
>> > provides fastboot, but the implementation can currently be started only
>> > from the U-Boot-proper command line.
>> 
>> Hey Mattijs (and all), could you please take a look at this again?
>
> Actually I got an off-list review so I'm preparing a V5.

I'll have a look at V5 this week.

Sorry for the delays

Cheers
Mattijs

>
> Thanks,
>
> --
> Carlo Caione
