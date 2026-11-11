Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84660606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0zQAUoq5;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=k3J7c8gS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5385F60D7C;
	Wed, 11 Nov 2026 20:03:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2u2k72Cw2NZ9; Wed, 11 Nov 2026 20:03:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 96F0C60D79
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427425;
	b=OUwcOYVqzVm2mTid9veowFIteAOkVT1Y5xB5uiSN9SREwRQNVBzQx6s01qad23PjkWY2
	 oT6ma/DmGtFzot1zB7EN29FzlNY0mGlj0sc8meiXM7lXb1Zaj/upi7vD0wF/RUzEqjvJW
	 gwwdb/RZiV/2ZrTjewjF3v8h6qAUn7+xanfE4UOaWB8jZtZOOOvo+JAYpNgUgVJKgZlqO
	 Aa0vezyolnjTyrkaUsHmZb2dRd4GSXNfT/xPzctq04u/FcOvntNbiOG4ieC5XsOUgTLCm
	 ivq+g7zXLHngpz32QzdfycuLiyMUvQhvRoOakbGXac+EJLZTwV0CHibBLn+E/rhcsJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427425;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/sfmDwC/LQpVJEi0keIDxDqHBwEFSDcwBskMdofC7Co=;
	b=aAF1J9oJxH3FtqLm/ukG9JWkOYp0+yuioyQjGSNCj9/htayjfh3xRhhwCbNR6fXeUxNK
	 wwSDSmDlt6EbcdT1u00yTP6RxrL6AbJHfTAeF+CiXt5xUUpovCZoOyoYe20t6E5APRptu
	 eWMyTiyqg4PIARtoaM6zUtsXfIxvIe6JLZoOvnxzFjOFHF3Gbp5l2YPpkv1HobasEBIqg
	 YDdNm+UwqVK4U4YyFx7VECCA7SMaB9uy5/PO01teMatKgRiCGo/BTjida+dHZZsv5vEkG
	 0Z1VMVWEyqbGw8SDbO2/GdYOtPgveKw3e7LFMDTvl9oqsx7FHtAX+zu53pfRfIcOp5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427425;
	bh=/sfmDwC/LQpVJEi0keIDxDqHBwEFSDcwBskMdofC7Co=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0zQAUoq5QLZsVn6Mte+7h5RPSS/jbE9EtDQ2CvRv+GQPYxUfNaOhmHM0vN+e9kwgW
	 x/i3HS2s0XXq30Y7lxxeSz1ZI4Ex2NXodDylYBm617CFaEXnyBwDTPD2WfagG/TuQ9
	 WibcfiOKF3HT77OanCMBWt7xi7CZWmJ31itlCIfxMGXL4gN9YvKU9JCXEuki2o0UB4
	 Rg73Gqx+iFP2EPNAtIkllXfCeLdDN3fGfupL4Asw8Mp0FSdtkyq/qsTLmdvgdTouzk
	 LEpdjtKGW2g3bRmwrld004u7er83Zeenl2K5AL6Ly7nQ48mPAaMoLt8k4pgQ6a1mSQ
	 a7xPF4RZuuIaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96F0C60D79;
	Wed, 11 Nov 2026 20:03:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ED6C4335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D393781ED3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:03:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wu_LiVrLrGD5 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:03:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D2AE681ED1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=k3J7c8gS
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2AE681ED1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:03:41 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4b28d7c729fso2250399b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794427421; x=1795032221;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/sfmDwC/LQpVJEi0keIDxDqHBwEFSDcwBskMdofC7Co=;
 b=k3J7c8gSpnHt1rald6wqFCmPVg/274b/pfM4M190Kxl5SpkLiYr4U9tVxXbMjsBijR
 SuOx+Vw+j9Q6NF4g3JbwFRyXjqdZn0kf459hM69ABsCdJSfBbw4my2FD6chQ3yJFNDNF
 8g4X6RAt+M9yBUjf86trP8xspJl+6/S/E0h/yPZZ9VPE/DpIH/XxXn31c7wbQ+/5/LRf
 OByYJ+P5fzSzdboIzFjjYBhpsd+L1Mlf+wlgQuJUBBgkTUw6D97Yk5cl8s4c7jtT3Ido
 XDSD7Nk+cCuX2qUs6eS/tk+0/dGw4940GXEyJ5fBiJY3e/+9C5ExF0WyjTefdCEJR074
 nO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427421; x=1795032221;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/sfmDwC/LQpVJEi0keIDxDqHBwEFSDcwBskMdofC7Co=;
 b=MYa8PVDjR7B78xs64b95wq2lxWK7MahDtGSfrz43dnavrGXbocha+mVnI7MtPCqJla
 5wLJsRCEaZlVqr6qWKmBfpIxI11OLr9paDNOmOYETrBgr+OiHH6JFVcTKQUOIeKLqgwR
 3dH6K5aEcgCPvr1OAScavV8+yXdWHRxmdxv8XmJ1oacXl/fyXSFDGZdlDKL7xWvmcoop
 MZMaNnHhCzpMc3z+8GVrOtgmUARyZVvOdL90YlBR7RpNmFi+cbGxtnkhfGDHt3tJeNMl
 rwt+rsKtboY2kj+p9k0SScjg2WXB44UVUjPkQGzo3ccMd5ZtyCjOePQN1VGgxiO8f64Z
 KgRw==
X-Forwarded-Encrypted: i=1;
 AL+hErFRBE0HM5ntuKXC4VmL5YuHvETcysLv56VI7z6R0pwABEsaEv5TZOho9JxkMjjRO+vdEWQ4yhs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+QWgj9sSjeM6tlg0uqMDRHv6LrwhYr4vBe0+kJGxs3g0dYxXpE
 5I33JLtj6OYNJ591BcdiHJmhcGhCpYKedhd4os8/Vjjgy+1Fm2PISHbyPcnk1Dn5PXs=
X-Gm-Gg: AYBFou3QO9VbK6gnk1wYhc6Zf5Lz1vdn3898h1zzSo5g970xMS5h4ojcdhJwB8iYJiV
 viutexkgf4HvDtOUHjP/4dzZrQvaqKyFMmUOSFJmZEuwpHVj7ZCVU1o+JTC04PWDgJlYXTNVMtl
 0/q02YEprPmhbmMccOkfIiiXE0XpB2xm1WSjgQ8tv9aQ/4DoB0jJ9iozkYfaCQs5K1/qf1/Nbxt
 tqS9vTIUyMkpcZcYJSkGISKiwmiMlIkDCEtG0O1qQmN5SX/0439k1DYc/GYexy6yTinuRii13lJ
 GH+qQ0/Jv9ezENvoz44TZU73d+VN3uT6K5HFX2KDodvfvuAUPXZ/EaqqXX2M7JM1RpYLyGMvdE7
 VcFGemdOIXy6r1rzJLD7qgXwFHuTLA8485b6wMHs1bDcTVxtv0HTGbAcT0O/Dz/t2ZYBHnFBSaR
 vwjWJbIuNxGNKwVBaDm6ZeQ2YTWcM9KzOnq36cyH9yhD4kJ2kHb7X5BtcJOBeCLQm51hRd0veil
 wIKuNn5QvT3AEi/ncI8rbQTR15TOuVTbGpdZFmkSHZRBs2xGAQO4xGhZzBJEcXfmnsTU+TAODdf
 yvTigHP+96343VzEtufR4H6Rl9QkQkAEVgqPCiwrdfpaAsLWF0MJp16RCRXA1no3jdUSE8Lvwp2
 y6nU=
X-Received: by 2002:a05:6808:3387:b0:4ef:e154:41fb with SMTP id
 5614622812f47-56b9375dcd8mr3112005b6e.1.1794427420623; 
 Wed, 11 Nov 2026 12:03:40 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7fea:2979:c338:d2a4?
 ([2600:8803:e7e4:500:7fea:2979:c338:d2a4])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae229c6501sm3970393fac.0.2026.11.11.12.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 12:03:38 -0800 (PST)
Message-ID: <2dfebf75-93df-48b3-a9e9-b75b3b7b08d1@baylibre.com>
Date: Wed, 11 Nov 2026 14:03:36 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm: mediatek: make the BootROM header info
 configurable
To: Carlo Caione <ccaione@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
 <20261106-mtk-genio-720-spl-ufs-v1-5-90c578b6c43b@baylibre.com>
 <179442384950.26078.9227626835965738462.b4-review@b4>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <179442384950.26078.9227626835965738462.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 1:04 PM, Carlo Caione wrote:
>> Add a prompt to MTK_BROM_HEADER_INFO so that a configuration can
>> override the per-SoC default. Some SoCs can boot from more than one type
>> of storage, and the BootROM image header has to name the one that the
>> image is written to.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>
>> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
>> index fec9601e80c..4f7bedcb28b 100644
>> --- a/arch/arm/mach-mediatek/Kconfig
>> +++ b/arch/arm/mach-mediatek/Kconfig
>> @@ -221,11 +221,16 @@ config SYS_CONFIG_NAME
>>  	default "mt8518" if TARGET_MT8518
>>  
>>  config MTK_BROM_HEADER_INFO
>> -	string
>> +	string "MediaTek BootROM image header options"
>>  	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
>>  	default "media=emmc;arm64=1" if TARGET_MT8188 || TARGET_MT8189
>>  	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8195
>>  	default "lk=1" if TARGET_MT7623
>> +	help
>> +	  Option string passed to mkimage -n when generating the MediaTek
>> +	  BootROM image (mtk_image). The media key must name the storage
>> +	  that the image is written to, for example "media=emmc" or
>> +	  "media=ufs". See doc/README.mediatek for the supported keys.
> 
> Should we have `default "media=ufs;arm64=1" if ...` as well?
> 

I thought about it, but I couldn't find anything that really made sense
for the ... part.

Since all of the Genio boards are going to be using binman and I have some
plans to fix that up so we can use binman devicetree fragments or overlays
a bit easier, I was hoping we could eventually leave MTK_BROM_HEADER_INFO
for the non-binman boards. Then we wouldn't need anything here at all for
this case because we wouldn't use MTK_BROM_HEADER_INFO anymore in the
binman devicetree.

