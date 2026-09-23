Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEECC98302
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 14:50:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25C9C40699;
	Wed, 23 Sep 2026 14:50:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 22EB52IJ5TWy; Wed, 23 Sep 2026 14:50:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3463E40688
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790175019;
	b=fyb9C1MR6vuYCYb73aW/WISHWcfr8KFHRqocqoYfQegvb7bUzE3CleWdAiRlH+aWQHy2
	 wWsGku+iEaC+Uwv2sxhchCJRe1IpjPCOhoiFsT8xifohPOYeZCkumwxTyKHY+dX2Kv83l
	 apTKZ6TVO8fwovnig8SILRicPMqescuNqsph1nGhmCeUSgMWB5+41ryaPCY0Lp0GQT2ZH
	 Pbmv/FZwhLqp0rTCQLCQrdcXrpOag6GVKm2JUnD9xDGma6z1vDsOj4k6sUHFI/aDGPrXB
	 XtuxU8TrTKoiyYE+j0M4NhpncXumiQUTOd3tvlt4/7TMN5Q2bCo/QTGpRHaHUQQG8fw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790175019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=33P7gSH0nVjKfetfchSS2+77l3TES/tx5JeAqo4tvdk=;
	b=tMVt0hkDz3ZQt6JQVe/3B5rWf65wV3t1JRMpzDapd+PX1PZbM/w0ZFMMeCiRyPzDT1AI
	 WV0v4NWimX54dlyldoFqYAh1Fqloc5cZVQRW/U85vHU0kht2TYLis2FxmvwulUxX2aPUC
	 Fsj870LUu+fj+52Egp12QY1u269FQ0GvWPomnjfvy8oLRWYYmhdvmrEmD89KpTYM28Uk0
	 StEJGmphku8AIzRB36wO7pC4wvYPGC8mX6XVk07ReU/wsXyFAnKYUK3rOLZbfwe0Bl5VP
	 mu+DIqK4E5XAShWAo+AWstqMyEaeRrHFA/En62QMAvxC3Obayy1d4bvvRmsV3oKIbFg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790175019;
	bh=33P7gSH0nVjKfetfchSS2+77l3TES/tx5JeAqo4tvdk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MqgZ7fqgPKX4gVwRv0nW+76Ao3Xq+LroWsq3AlBpFYQ0pf02WwPJkLfWU3ZMY94U8
	 6y3k/DQI0rpCBBY/V3F4raVZogBdCmbYTBIqoqFw3L5vZMWbhEW4VI/lV5QFAGjcpO
	 FLmWAgTQV7wfJjTeP0QDoSylU+8av7xUwn/2F4Grw6Q2jbsMBEK0zDZRX/ADIwlMBa
	 sTxfrnD1RVakcTP1POTOBjKjHsDaIG7JZZ33waXwtG1+rmme/aSHEDa4/FJpkBrff9
	 IhlPhHYtjNBDl4mfyRN3Hzsu3KInM+hSjwTbp1udD4AIl1vKYZTUV8FVUrlH97HRPE
	 PtXAqZFaD8RJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3463E40688;
	Wed, 23 Sep 2026 14:50:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A0603498
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91F2640348
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dE7KmqqxIanu for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 14:50:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E0414400B4
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790175016;
 b=SLmFDIc4YTYsRjjtBz5YXhdgPpNwaD2jadZ8ts+Fkusy0gr0mH/yLi/hLwOnFOIEP7it
 2yjO33AF2M7dwDD9gJSeTXd5Nj6AwS7i119XTnaERIhMboi6n3F/vFASWesq+aMUMQI72
 OCMCVKgmazRJ+BYlDVyOMBTJSH6LAzNpKWNnZi2XMD0XgVL5X2mIHiUt49x3tfiEUguKi
 yl/cSvJ8zzj8aMYhjUs441rPqWX8DFXqr9EDsxLcdphNbjwvp5rDXELCIcBS5AIjR+QMp
 nx1jBEduhYejONT4RLnvyUDAxzoN0p0SyWfdMQ78ayjjuKi3DS4wcob1WOimfDn/djg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790175016;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=33P7gSH0nVjKfetfchSS2+77l3TES/tx5JeAqo4tvdk=;
 b=BRtNkASCnkH8B+mfL+cfSminh3noJu+aS6Sxa6bjN9Ive9+XXVcuFaIY0Prx8ZpX8J3u
 OLXhC70aF17DM53NEmg4v9Wb0LDQ4aHDojYL5x/arGbklSECmvxhhnDfTB6hMq9fOAvUr
 1HEdWBx1Z/6wvbIzTkL2HKK0Ih9XJA+nY9xYgXMxab8WQQph5o9WrZrGtz8anNYfUvHfc
 4GV7jQtfQzVYR1b+h7fS6BsvGSm3CN36SxXqUNOaX9Zx+mSPEHylRl7f0wN2Sm9L2vKEZ
 yuKW7uhGsmKke5Bm1yGZRkLc+VYYesFcJqMlHdjjVCs6oMGCPWn0jxAUNSJ9mwYDs9A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=nwZPGSqt; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::c;
 helo=mail-yx2-x0c.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nwZPGSqt
Received: from mail-yx2-x0c.google.com (mail-yx2-x0c.google.com
 [IPv6:2607:f8b0:4864:41::c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0414400B4
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:50:15 +0000 (UTC)
Received: by mail-yx2-x0c.google.com with SMTP id
 956f58d0204a3-66e4aa8d881so1126011d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790175014; x=1790779814;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=33P7gSH0nVjKfetfchSS2+77l3TES/tx5JeAqo4tvdk=;
 b=nwZPGSqtcs8UL0jM1lWRAe9FKVPr/AIFEe+amqP4Ch57iixnr0HvhIB1rFcc+73R+g
 D/v3elH2hbN/eK9u8RHiBrohPPGtVVf1h3qRWRErqVrtTvFJjYjyIm/urUccDwtLlR+T
 vkRvu2PGe0JKbxeoFU4rbSitZYAybSw5aG3GeovbixGQhRcwX1HP2DA+lvi0pZbeG1no
 x9GeTGicJU22pcnJGEiUIcWOBvP2V28aWI5SuwQBQQ3+cfmKIfe7hL+wO2sZItEMCZNq
 y8xbasoDFt9rUzVbM7aT+jFmLZqkZztK0WiNTRPpHOhDthpubcobxxT1zsRacXzILuuX
 a7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790175014; x=1790779814;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=33P7gSH0nVjKfetfchSS2+77l3TES/tx5JeAqo4tvdk=;
 b=sYv0bBkgEJd0idjuEmTlhfzQ9KY7QcGWqPTk2RkwoGyBdlu6V3p8/qGmYxKYjZBtHL
 FU7Drs4OidbvOKXRmIK+MGmKr7TLSu+2Dy0dWeRIXxgLfKbAMugtGyFHSxuj76j7DeH2
 nzKLrzYjhgFr1h+axrIxvbVLRd52qQYJfx46eJ6C1jteudBu2/jXEG9qC8hKY5YMAdud
 9aqhMNn/d31j8KB8ODDNNa9gdeNtwN9aOVpBNQ/yUpnHX1DmQtkon9+bLqDH4h3VFwU1
 /R47CgNb37qgpGWGBgHAmINpiChXkZOSGGGgtEopV2xwy1zn6HcxlA9TCqbLntaQq7C3
 eoMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwe3mZ0X4gSxehqCt/qJp1cjGbUdliywkxAjYgN47jAjFEOOUXka4vgSxX+B6TcWlgMpfly104=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ly6RbEhBi2CHYgQOCtI73F3qq8Xj3QZJKEjBaNxl9uWDG24xwm
 eyWzh3uxPETahIWWJxvlVbzXARoLxvmpOG5xQZLCE5wmoOD5EDns9MBtiSHUrPZNG2o=
X-Gm-Gg: AYBFou2ZiVkuCVvOlGlXtSH4k7WyFD0AJPmRQSHSM24B9sqO52cBfMkxWyn9ex0ok+p
 BDGxqpQO9Q/puEWiVdgvXS/oOYkZPvCPSZnNsGiRKR1ADMa4xqtEk/Hvseo8WBHReSBriw6aoUA
 ERqQf98xhan3VAoz2zRif2usct5X5iSj/jJaKia6Tz2tHLsvvp1+KcWzh5gbyZKWunrXzjbeIF9
 lYAn6TGXwH3QyP3tmCV8uhDlvQd0lVXe4JBy3ORtkUAUT9t2NAjg0aHY1D+EsowMi1RVYnzlu6d
 II8B/BIXq9SvHGOfoHH73h8xJS1w1uZUpYMR+JZf+ZfOZtKyuLoIOusvXkriYMcxFzJRB8RKYO+
 oTkOZaqy3JGBiAHoRCwM1Fm9zC9A3OzxgrAO1XEfcjgkhNKu/J8Pi2EBDol2IBrCaL/PQ3zsuLh
 C3fWcj67yqCezadiIdgMAV44i/OUEfyfspmkJxQovzb2cibgB8m5ZX3ZXfX0nJt6IMTf2uyvmIo
 6Av59yByJGb6B1zKwcUAL+N1Qy79RlvDGQROiNk+wXzNfEc
X-Received: by 2002:a53:da0f:0:b0:671:4b8f:e8f5 with SMTP id
 956f58d0204a3-672d57b6f91mr1540626d50.35.1790175013869; 
 Wed, 23 Sep 2026 07:50:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:15b8:389e:2bba:8894?
 ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-672d8053580sm1032703d50.5.2026.09.23.07.50.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 07:50:13 -0700 (PDT)
Message-ID: <ee2dbb58-bad7-4bbc-a86f-5a93193df3f5@baylibre.com>
Date: Wed, 23 Sep 2026 09:50:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: mediatek: allow a board to carry the arm64 kernel
 image header
To: Aleksei Sviridkin <f@lex.la>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
References: <20260922193031.785941-1-f@lex.la>
 <8edbca32-851f-4694-965b-677af74e59e6@baylibre.com>
 <20260923072204.1248855-1-f@lex.la>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260923072204.1248855-1-f@lex.la>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/23/26 2:22 AM, Aleksei Sviridkin wrote:
> On 9/22/26 3:48 PM, David Lechner wrote:
>> We don't want to add an option that is only used by downstream (code
>> janitors tend to like to remove things that aren't being used). But I think
>> what Tom meant is that you should add a defconfig for this board so that it
>> isn't downstream anymore. :-)
>>
>> Then we could do something more like board/armltd/vexpress64/Kconfig where
>> we just select LINUX_KERNEL_IMAGE_HEADER on a symbol that only applies to
>> that board (so no MTK_KERNEL_IMAGE_HEADER and no config prompts needed).
> 
> Adding the board works for me. One thing to check before I do it.
> 
> Upstream would get the board itself: the device tree, the defconfig, and
> a board symbol that selects the header and carries the offset base, the
> way vexpress64 does it. The OS on this board sits behind NMBM,
> MediaTek's bad-block layer for SPI-NAND, and U-Boot has no NMBM. OpenWrt
> carries it for all its filogic boards, together with this board's boot
> flow: reading the kernel through NMBM and picking the copper or SFP
> device tree for the shared port on each boot. So upstream U-Boot on this
> board would not load the OS from flash by itself.
> 
> Reading flash on my unit also needs support for its FM25G02B SPI-NAND,
> which is still waiting:
> https://lore.kernel.org/u-boot/20260822205540.1223-1-f@lex.la/
> 
> Is a board in that shape fine, or do you want a board to boot its OS
> from upstream alone before it goes in?

It would help to know more what your overall plan/goal is. What do you hope
to accomplish by using U-Boot rather than the stock bootloader?

If this board simply isn't going to work without a NMBM layer, then we
should probably wait and see what kind of response we get to a patch series
that proposes adding it. I found something similar [1] where it was
suggested that such things should be linux-first.

[1]: https://lore.kernel.org/u-boot/0db3e5e9-d54f-4571-99a1-9e5f34bde685@kontron.de/

