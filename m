Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A030C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 19:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0C068110C;
	Wed,  9 Sep 2026 19:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wdqPsXhpulvo; Wed,  9 Sep 2026 19:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DF35F81115
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788983769;
	b=iSo1AO62pPDoYngaL8aNpTzs3hsutVpReh/UR9+5fD9TrjOWVDBIKZ6yiCi27W51yARI
	 gSYjDQPR/AlHBUFENAWcmS34aLDcJKwnvjUSXIJa8rYEAzjXysf8/1b9oiwwzNPwJ5wa4
	 l2qAANTkCl28I0sNY17kQpR08kgOP7aJbXS/nhp8a+20Ex3NJTApTvl1ctv8bKsDFF8tg
	 NUZu3BrA2bJYUsaN5xsBjfpV7s1TQQb9ta9TWDpzEP3XjavHkog0syzEPSPU6qsSqVEI0
	 KjTYTwp2kIuEFkh8PuWugzbe6x1sfWZVJlt9cQpVQsKd+9qMgnp5BSy669guT8eub4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788983769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qiynfWzmdqI1+NHSH26sHLB+3gT5m7vzKIL86mBvn2Q=;
	b=dovv2afuRIrvW8CPkzgEWaey6vNW59br+a4B9XBu13KfkdVgzV9YftVt35ufuvVxSpcF
	 BZw4TOBV56EMP1z7YfajdVPyyNwiy1IPibPJBzb/bXhrqFdE8lKAjf4jNgbiyVe3fdLaG
	 qpld1xlAQbYyK0J/jMsXBz+17F5ZUl7VtTSeYYJ1xqjf2vGn7xctcTXmVCpEj6kv4mt7h
	 CAGH/hXTFyQQgIvYGBWd1Ri5b8S/7mtHimVzrgsYej33qoUncuYiHmRy47eZ30z9WjOZU
	 1KnxbN9nVvVOBK4nhDEuUv6SK6DsUd9nXRb5HfHcqyoINi+La/TUJkH/qJy3BidEErA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="IaiJPl/g";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788983769;
	bh=qiynfWzmdqI1+NHSH26sHLB+3gT5m7vzKIL86mBvn2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xRBUAk2ycgVTS37XNPbALBE41YO4RaK1GKuKxFrR/hn+Nok+xtm7qqnnx0cLRxfVP
	 hyLbwc4UR4nxasmIy2Y32m2FKu2uGP24BNeKTUh+BcIoGFO8YGyLqnAq1Wfik8v0no
	 Vn1idA13ly8+1gaaxf8JDaFoFf0FXkWGkGmO3vdQwpmVoRa0rNIbxxTbtRZrXZU5IF
	 NdGxTw1kT4azkSI6sLObcrLL5wvO0bxN0BpOeJ6Ui0mT9hTuffQQwouiU/wac24zTw
	 bRirmA2j4kvbv8UBp+JBQIlTMCQRT5EV9rSwfbH65a8m+gSuUwjiKvohP7GxMnmO3d
	 8M1mW+vUEl7ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF35F81115;
	Wed,  9 Sep 2026 19:56:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 319772D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2331E81115
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:56:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pmQz9aBz99PZ for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 19:56:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BF5288110C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788983767;
 b=iJteIff5Yt5Ya3JnHWehu51VTVf+KixvlDO6Gdw07T1KpHT0qVDSA2wgRwXNjyFgVENT
 lXBTDREAa28x3JJgbcRXJn37b3/C1LijCDRAEKilAE4Tn7+pdx64HHnazBGni7r63nyla
 I3JYB9FdHC4ABYUG7S/wtL+OaTScu8MKmEx8kMs5/G9UnL5XChza1PFIUNHbA15EK8J5P
 9hb8QrZErREqClSrJCZ0dGg1XFZ9zuZVYRkQM0nOmWuZ9oByd9aKRch1Ka+D71FLrmlyN
 bXjzFernt7SwPtIT1RUC8hA0dSedLP8gHOWG7ke0wOIE4w4T+NGzSYheInd4Q4f7rqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788983767;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=qiynfWzmdqI1+NHSH26sHLB+3gT5m7vzKIL86mBvn2Q=;
 b=p8oqpXNFotL8AB8Z5LhtfFEkv9dqA5H30mB7GuIRDTha2ffdSIrdkknMbyW7zU3ogt4p
 hjmjk+i5x/HKVhDLB1C4JJHhV/M0Tj5wBlKZytD44cF60I4VcM5ZtLC5K6wa49CB0K+Go
 4kszeoNLZotFRxEnPZu9KI50qS+FwqVHwsYpt8/BV0btY7u7TMhVG1n3eDXvR3xXLVsfB
 b54CZEm45vkZm8vzzd/ajjKg/0vxxvKqmUbxP4abq97VU1EY/FzHF0W3eCa2tTqtYDKiB
 LLulbMxZoFIVrfe6tXC/Eu/qCWU4i/tk2tp6ut0EhkWQWRY7tETjnRBoLG/fajXiKYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="IaiJPl/g"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=IaiJPl/g
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF5288110C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:56:05 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4b28d7c729fso4255756b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788983765; x=1789588565;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qiynfWzmdqI1+NHSH26sHLB+3gT5m7vzKIL86mBvn2Q=;
 b=IaiJPl/glfPQl7JYQV3kQ8JUX647Ai5ykwCAEHNCLAcjyVKOqnI/QHg/4SJMid/i+E
 E+2KmipkPeNspTryVkOgyBgJsqrXuOP6WLegmv+bE67JjAwxTE4IozeNu2RUL9YCcjKT
 92d8butf2LYFhdhI7qiNYpe4qazMRvLA8V0IXPk747uLOP6WK8vhflGoQTZ1TQeS/91j
 f8YxrPAgbbDwtEADNW38HgFAfypYPBcFWKmIiUlf1ZJOsFQP9WLfRqyzKW3j3TZufJaO
 Zs5peF5jf0izFPqqT7lD3ZkAqk9vJmHNkYQ3x7gkaGpMVCk05Zkb3Xn92+UxsuB/W6RH
 Oi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788983765; x=1789588565;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qiynfWzmdqI1+NHSH26sHLB+3gT5m7vzKIL86mBvn2Q=;
 b=MviAPZyk+Fa3/WXmGRt2hEL+Oya5e1KFsCRMSXPpDOua2yDkdFQNELBcpQrGVAo76T
 855e2KQnl8WHFgfYjzCY5SLo04B5T1/92FRDyuXwN06VkO6htdMeRe3KrkBiowQyV022
 mb+FCDOHEZN4XkOfk8jHmUZxq3PW1zhNzwRW3M2sdufqVneORS6IJE/w1PkblhwgyySa
 OUwdtA9Utrbr+0CvZ+lD4fQGZis7tyB7M4jleY0Rm7Eq7av6Z5Sh0C6D7B6DSwLtMYyd
 s1wojWBwaP9fZGd08DOjw/n1dON5lC8V1MYjQ4w8t9zoByp6YMVVDMZfrVG5fanzC75z
 ykQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9JaHGYjenpDcBnMzcZlpXbk++AhF0cWvlrkJ+WoQz1+/x3e05VrxNixoigTfgr74UjAX99eE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kb23ZrkyKE0XeJiT9I2n9xuAtSKZhYcda/l0NmZm7IdzdiWqtL
 Ed8t7diZiitl4dLsmLN9pvLGcLsOTJR/+pDFKrh+7GewDrm1pffpQ7s7OL93tSB9N90=
X-Gm-Gg: AYBFou2cVF4Kywwfr30HVl6dV8eGSAbUThJBSIMaIYaAhOiTfRFA5enflZjZVmeS0sK
 0ipEBByC3bJcjmP7PbNxUcLeKDbciKHBaHhhk11rtJLijH3czSVTfbVQ54lrpg9JDSqy4SQhUcn
 u56B8C8B9AUSEmufJFcuvZJTxUgjOVvWr6sVcDW7gbtAUTMqrcqlgCJBDzY5SMDqrHr2Ta7t0ER
 BYa7Y1OVsZtzxyTzs3ELIG33MXZSgj0AcrF2uJLjmBTAX0uWDTVocaFfX1JhfDZh4DzIDgpLSpZ
 1fljao+9N+Cbk0Wvm7SfbWUerjM5+23iE94C/2Vng6iM3vV2FJB9ptUpeb/xcTin9RFyBKVCz84
 bG3l7Zv1R5Sl00WwnPJY5CqX4fl4fP9TlAYWV0SnpnM2gRLWiuzRFqmR6ggXDN9FDhDBjzRkjBy
 Zuzlwl45OdVMsBofhb6FO80dGrm88Y7F2q1W3UmNu74KGZjn1PuI0WWo1W481/BxaZxkckC0g3s
 gFA0VDjnyuC3arRNPHnu1E8CmMHFECN+KLq2q+UF/3ZEEg=
X-Received: by 2002:a05:6820:198b:b0:6b6:c3d2:702e with SMTP id
 006d021491bc7-6b6f9fc97bcmr21539020eaf.9.1788983764608; 
 Wed, 09 Sep 2026 12:56:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a8c5:6332:5ea:5b26?
 ([2600:8803:e7e4:500:a8c5:6332:5ea:5b26])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47989a71ebbsm7924188fac.17.2026.09.09.12.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 12:56:04 -0700 (PDT)
Message-ID: <f12ef161-582c-458d-b49d-974ab55e7788@baylibre.com>
Date: Wed, 9 Sep 2026 14:56:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] doc: board: mediatek: document Genio 510 and 700
 SPL boot
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Johan Jonker
 <jbx6244@gmail.com>, Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
 <20260906-ccaione-upstream-mt8390-spl-v6-6-4d4a11d5741d@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-mt8390-spl-v6-6-4d4a11d5741d@baylibre.com>
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

On 9/6/26 10:30 AM, Carlo Caione wrote:
> Document the common Genio 510 and Genio 700 eMMC boot chain,
> board-specific external firmware prerequisites, binman build invocation
> and generated images.
> 

...

> +DDR-loader handoff contract
> +---------------------------
> +
> +The DDR loader and U-Boot SPL have no parameter-block or firmware-call
> +interface. Their contract consists of a fixed image layout, initialized DRAM
> +and the execution state at the SPL entry point. Different DDR-loader
> +implementations may be used as long as they satisfy this contract for the
> +selected board. The BootROM loads the eMMC boot0 payload to
> +``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``::
> +
> +   offset 0                                     +----------------------+
> +                                                | DDR loader           |
> +                                                |                      |
> +   offset CONFIG_MTK_GENIO_DDR_LOADER_SIZE      +----------------------+
> +                                                | U-Boot SPL           |
> +                                                | CONFIG_SPL_MAX_SIZE  |
> +   image end                                    +----------------------+
> +
> +The DDR loader then performs the following handoff::
> +
> +   initialize and train DRAM
> +
> +   copy:
> +     source      = CONFIG_MTK_GENIO_BROM_LOAD_ADDR
> +                   + CONFIG_MTK_GENIO_DDR_LOADER_SIZE
> +     destination = CONFIG_SPL_TEXT_BASE
> +     size        = CONFIG_SPL_MAX_SIZE

Do CONFIG_MTK_GENIO_DDR_LOADER_SIZE and CONFIG_SPL_MAX_SIZE need to be the
same or just CONFIG_SPL_MAX_SIZE >= CONFIG_MTK_GENIO_DDR_LOADER_SIZE?

> +
> +   enter:
> +     PC          = CONFIG_SPL_TEXT_BASE
> +     state       = AArch64 EL3h
> +     exceptions  = masked
> +     x0..x7      = 0
> +
> +The loader must copy the complete fixed-size SPL window, make the copied image
> +coherent, leave the MMU and caches disabled and enter SPL with no live
> +dependency on its own runtime state. The MMU and caches must be disabled at
> +entry, and all writes performed by the loader must be visible to the CPU.
> +SPL does not consume DRAM geometry, a devicetree or boot-source information
> +from registers.
> +
> +SPL obtains platform information from its embedded control devicetree and
> +initializes the console, clocks, pinctrl, watchdog and eMMC through U-Boot
> +drivers.
> +
> +There is no runtime negotiation of these values. A replacement DDR loader is
> +compatible only if it initializes the selected board's DRAM and follows the
> +same image-layout and entry-state contract. It may represent the corresponding
> +addresses, offsets and sizes using any implementation-specific mechanism; the
> +contract does not require particular variable or build-symbol names.
> +
> +Firmware image prerequisites
> +----------------------------
> +
> +The following external binaries are required to assemble the complete
> +firmware images:
> +
> +``ddr-loader.bin``
> +   A MediaTek DDR loader built for the target board and configured to satisfy
> +   the handoff contract above. The input may be shorter than the configured
> +   loader region; binman pads it with zeroes to the offset reserved before

s/zeroes/zeros/

> +   SPL.
> +
> +``BL31``
> +   The U-Boot build variable naming the Arm Trusted Firmware-A BL31 binary
> +   built for the MT8188 platform. It is loaded and entered at
> +   ``CONFIG_MTK_GENIO_BL31_LOAD_ADDR``.
> +
> +``TEE``
> +   The U-Boot build variable naming the OP-TEE binary. A standard OP-TEE v1
> +   ``tee.bin`` image is supported. Binman removes its header and derives the
> +   load and entry addresses from it when creating the FIT.
> +
> +These binaries must match the selected board, its memory layout and its
> +firmware security policy. In particular, a common image layout does not make
> +DDR-loader or OP-TEE binaries interchangeable between the two boards. BL31 and
> +OP-TEE must agree on the secure-memory layout. SPL passes OP-TEE's entry point
> +in the standard BL31 parameters; ``CONFIG_SPL_ATF_NO_PLATFORM_PARAM`` suppresses

> +only the separate platform parameter. Place
> +``ddr-loader.bin`` in a directory which can be passed to binman with

Strange line wrap here.

> +``BINMAN_INDIRS``.
> +
