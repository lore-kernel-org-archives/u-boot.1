Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50707606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SZEEiJ9N;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ha84u7uI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 782324073B;
	Mon, 16 Nov 2026 17:18:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lK15KTTNWnGv; Mon, 16 Nov 2026 17:18:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40DC940730
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794849480;
	b=ltKp75WaOlM2yue+amzbmrGRCvG7la8iaBPfyHuKRW+hZQBB8pX1mLvkt7JIocvBYGsF
	 6VuNah37GHczsd7ovKD1udhSE5U7giYA4jIKbvnkJc9VZZLLOMpmw9OpZ3ptlmcf07ixZ
	 /QBhOXAtD3HCQkihh+6gFF7NaQoseo2StucdpD4xNRqdv/Hq24j7L5hGHSAAFL01bEhYh
	 6Yj/AqSuOLdkfA8YvoUFdHntlFYQSE+OqHIbr0mCgnYJpk2dHPpxGv1tn+JV5FYfQ0dm0
	 LvAkrbXd/HDl8scBJBYsvv6fFp9LTi/EzdDa/HWVoiH233jylj8np4LMvn+y6jbhdrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794849480;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bD2FUx3OVty3BbPY6bHAObUBEcwu+ogIgxCHsvPPmPM=;
	b=Rb4X1sW9UXkxGuImnmGSqcpQvgX3WBtJeAQBaqENyTHQaFpr7OveJIbEbNJ1AeonBeV1
	 CqGsTIr+82ujtLWtVn/XJWeaM88Ix8plKr7ZqI9JDzyLW/rauK9L310B5hzZ8O6SPCZXJ
	 qt8SNCYilrBIaYqlqO+H9CVbsbYH60HeK3xcBQP1+h9rCo9AopqJIZOumpOUmrZ4mpBzW
	 2MsgAGnKjYzEuu5Ml0fRS3dEP106NVCISm9HnksYeqCgldEJpoisCHKnfxLCQFTjg6f6u
	 ycHMS8UiCCs91DbhLTupVPK4CdBaUsgIQS+ldeCRzrbww8IVG9TnVEg8AK+xEQOd1cw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ha84u7uI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794849480;
	bh=bD2FUx3OVty3BbPY6bHAObUBEcwu+ogIgxCHsvPPmPM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SZEEiJ9NN/XfUD92RWN+unVZ2exf+o5keeTO+zXnO8kRy7il2bYADWZsYV97kxDZS
	 gdTUJ2pQjKk0JbzCnqd70Saefw3vjBqgdA8vZra6sA+om0IuZL79yDDCxH7NcswUOd
	 iFzrmorWQL/wxfgrFe+up1YwwYAnKajF1faI8opz6V8zeAAEqi8JyZFTMP2f0XNtfb
	 +fRYWwkq8JTa3OXsNdg40rnEJ+B9YDuLJzSRgdSoQNZyW2BKbva+sX7b8vNYGFVae7
	 R1jCUnNllivrThwe4z/WsUEMTNOA7zV81LEVWkmchpb08gTgUDMwP7fhexASUrvQUH
	 CqapzVIGJ5U6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40DC940730;
	Mon, 16 Nov 2026 17:18:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B0614DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E807D40730
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:17:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CWizaFMATXAr for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:17:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC1B64072E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ha84u7uI
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC1B64072E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:17:56 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-48e9476e26aso1030712fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794849476; x=1795454276;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bD2FUx3OVty3BbPY6bHAObUBEcwu+ogIgxCHsvPPmPM=;
 b=ha84u7uISFjVxno8UnK31geltcj5iSVvBJBz4Wr94tjoFA2gyVRfI46LIZIXtjU6YY
 p4jKG/l5ewITqsOOeE6Pub43eOdmiBQFXAAIfCorluS11sfrKrfCLFzTIpgIbnGv8LlZ
 lQwsdKIOyB5ELzwx8lgk1znuzW88zOYlVfKA91/TmIvAgTuFDOn1Lyz138/dCabKX3tg
 eAdgT3GtNgLD9TBJH+A943qOV+ll5WeQcgB6Zm706j12y612uOBUZs81SERioNMxFKsQ
 zM8FMjj2+Tp5igMcLDQrvLA+anRxdbYGhjhHZRY+mX0lWPDr/IJv0jaeEbKHTvMsY0tv
 oQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794849476; x=1795454276;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bD2FUx3OVty3BbPY6bHAObUBEcwu+ogIgxCHsvPPmPM=;
 b=gnrW0w1G4GU6lCbxM/UdgGnkNSe/demiKxqkCmp1RuG33Z2oZsDyCYOVduu7N5y+I9
 qstux136uaadnW/enOlDOiMmGw7FqwQvTzDW65WCHQJWgzXIx5AFOZmaNy000WXJdwOD
 j/bQ3CtqlN3prJHdafq5wuRnweeadCh77DMwydKZl3P3cUmjfampoqB8hGM6MIlu/1AX
 LlnAX3+hLSkGEF2r7JQ9R2nwjXHWiCVsUZy4HkL7aWsrZFB7f+N0XMYDRjsACASzrJNB
 9TaOpXvmoL0Zv/TB+JQvovVd4dfTSTiC9k/5LbXTdVcZmL3iuKuV8Qo6EhoqEDnEi7oz
 SzCw==
X-Forwarded-Encrypted: i=1;
 AL+hErHA3cWsCkhfc9k6u4krJ4PG/+0Nf2yceiXbNYbl/BjhLrD4J7jm17hzYOAzkioewS4UKFaBpfQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9U90asUrwvZ0bvVf7ZbweCbLkHfEE52HZjrpGlFm2TEnGZyWb0
 a0Dn4ZWuPuop1SWFRQ5uaIqy2tPhD6a4DwzMuIteEnO1dTzHX7sfjIjdkLVgLtj9wZc=
X-Gm-Gg: AYBFou2uAMS7iNzf/PhKVMAWu39IjG0cwh5lwMhNgL+6/LGO1eaZOZsWnPP7lctd3Kc
 dfajcu45e9SZbL/Lc6h60/PPk/Ce1D2LgqwxJFpUfNuPmWSxeqhOTr/jSPhiwFA+8mRKH96Mfk/
 GfmoN9zG/YqDdEDasyIUkhGhgXJLsjPdybw+PDu40QL/KJqNQlzCZU0FdJ5oz7DE8csKZRsCop+
 q6TCiqbiFOP2UmWftXldwmsHHvKYsMrgRzvwGDtGdPDk5CbDcPkreT77bo7NJ4zfpfngiClZlLf
 /2p9Rgjv+dY32b3Y5DxOK2hmlIEv0tDpJr4zpdJ2OFrXWFqtpsAyGx1n9Q0dOFCQCPryNVtB9an
 ZtD3476E3p0ispzWARyuXgpa/MZkry1ZOoD85oGtbkcedYJwDKUSO9X5NCbvspP2p+8BhRltdv3
 JljZJB1Dw0Qk6ohftyjw+VXT0+GkOzxteYrDAs/Nm1P1zYMyifba2dTFDPsL3TPFjZ1+vuPDeym
 VUFPmxiC3HJmD2D8WVs8/In2vXDzLY+Hx3cQE7lYeE2iUhyKkTXL8deo4U7KlR5Ra9z5spGJZsn
 r90ochL0pe/xNnrxqwktM8v00OW+R6h5lz2tbnxYJkkHHWvmHcFZm5QJ6+r+x7y/hB0aFq6z+Wp
 0dmE=
X-Received: by 2002:a05:6808:3c48:b0:4f9:6348:cd3b with SMTP id
 5614622812f47-56e6542c18emr8143427b6e.41.1794849475684; 
 Mon, 16 Nov 2026 09:17:55 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7056:3b5b:7d85:4921?
 ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4afe242b670sm7040586fac.17.2026.11.16.09.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 09:17:53 -0800 (PST)
Message-ID: <1b9f2a45-4ceb-48d0-afdb-b406404d98bb@baylibre.com>
Date: Mon, 16 Nov 2026 11:17:52 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
To: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261113174852.GN554944@bill-the-cat>
 <CALeDE9PvZgwiAUxdX=-tN1fgDveNOkeM__xCCJeZrK3Di0WxjA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CALeDE9PvZgwiAUxdX=-tN1fgDveNOkeM__xCCJeZrK3Di0WxjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14/26 3:16 AM, Peter Robinson wrote:
> Hi David,
> 
>     > Anyone who has worked on hardware that uses a devicetree for the
>     > hardware description should know the mantra "the devicetree describes
>     > the hardware, not the configuration"
> 
> 
> Thank you for this, I never agreed with describing these in the DT at all.
>  
> 
>     > Binman is describing configuration and not the hardware itself,
>     > therefore it doesn't belong in the control devicetree that describes
>     > the hardware. So we propose encouraging the separation of these two
>     > descriptions into separate devicetree files. In most cases, binman
>     > info is not needed at runtime anyway, so combining it with the control
>     > devicetree is unnecessary, takes up space, and causes DTS validation
>     > to fail because binman is not part of any standard devicetree schema.
> 
> 
> This is great, and I look forward to this landing.
> 
> Forward looking and just a little thinking out loud here, forward looking is the device tree format the most straight forward way to describe the requirements for this? I wonder whether something like toml or even the in tree env format [1] might be better suited?

I was having these same thoughts. And if we were starting from scratch, yes
I would have advocated for a different source file format as well. Changing
it now though would be quite disruptive to those depending on it. I think we
would need some motivation more than "devicetree is not the best choice" to
justify changing it at this point. And even then the devicetree format would
need a long phase-out period to give people time to adapt.

At the very least though, it could be nice to eventually move the binman dts
source files out of the arch dts folders to make the separation more clear.

> 
> To be absolutely clear here, I think this series should proceed and I'm not necessarily asking you to do it, more just gathering ideas/opinions.
> 
> Peter
> 
> [1] https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/board/raspberrypi/rpi/rpi.env?ref_type=heads <https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/board/raspberrypi/rpi/rpi.env?ref_type=heads>
>  
> 
>     > Currently, only Xilinx is doing this kind of separation. This series
>     > makes it possible for more platforms to adopt this separation. The first
>     > patches fix binman so that the image gets the U-Boot control devicetree
>     > rather than the binman one when the two are separate binaries. And they
>     > make BINMAN_DTB work with OF_UPSTREAM, and document the recommendation.
>     > The remaining patches update the MediaTek Genio targets to make use of
>     > all of this.
>     >
>     > Signed-off-by: David Lechner <dlechner@baylibre.com <mailto:dlechner@baylibre.com>>
> 
>     My more direct concern with this series is, who has some review cycles
>     to step up and co-maintain this tool? It's already been privately
>     suggested to me that we could drop the lofty "one tool for every project
>     to rely on" goal since most projects continued to develop their own tool
>     for assembling binaries anyhow. And that in turn reduces the scope. But
>     it's still an important part of the project and so needs some people
>     looking after it with a more global eye.

I might regret this as I am as overwhelmed as anyone else with reviews these
days. And this is my first time touching/using the binman code so I don't
know much about it yet. But it seems like this is relatively low volume and
I know Python very well and this seems like pure software so I don't need
any specific hardware to validate it. So I could try to help here for the
time being.

As a fair warning, I do tend to want to be a bit heavy-handed with my own
changes when I am the maintainer. The current binman code looks to me like
Java written in Python 2, which I find a bit painful to read. I would want
to "clean it up" with modern automatic code formatters and linters as well
as add type hints to make it easier for me to read and understand so that I
could maintain it with less effort and also to find latent bugs.

I also see there is an active fork of binman at [1]. So I would be in favor
of letting that be the ambitious project and trimming down the in-tree code
to only what U-Boot needs. 

[1]: https://github.com/deinde-dev/binman

> 
>     -- 
>     Tom
> 

