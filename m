Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E4EEE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 15:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2DDB83B86;
	Fri,  6 Feb 2026 16:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wZxBUdKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31C89838FA; Fri,  6 Feb 2026 16:07:28 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E85CF836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 16:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4096aab5521so651382fac.3
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 07:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770390444; x=1770995244;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P12P7Zm+pqeSMtc0FSLzmz7IdoYjGXdsLUOGJHb+nso=;
 b=wZxBUdKuHOzgwj+sEMGRg3szodIKGH+AiojNC/5NrNcIT1gTBQOTfAugxw9dTWiHFd
 XXLzfouV9kkQwHHnbf4gZ4STxwrKMrfSPhSOUrIT5FlwZWELl/lsTUthEKkaXTP9sAJJ
 QenCBoWrmmW6n+LYXeo41O6Q94oy/q/1zr9on4fnBQ/J/Zcs0YIhNPaTa9+lW1v8vgsh
 gnCWNlGieh7ZK/Ir2AnLSBtYq78XXoGlsQp2HzTUK0UKSaZ/WZKslbjVCacvbVQeirz6
 lylxFXkFFiTMJK68zWxbuGQtycV27qzXON8xSUmpK38X2uCJhOafdZpY1dmsnOQeBVd9
 MjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770390444; x=1770995244;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P12P7Zm+pqeSMtc0FSLzmz7IdoYjGXdsLUOGJHb+nso=;
 b=pC5UJcQIFRU3sb75gJGXU7cQxkb2/9Ka8KeH3narWTdSaCmcKdTxiB+2SZ6PHUEgJU
 3e58x0wayzCVlzfp3gCCwgVA3GDjPr8CnXgWoAokchpKRH9dpzIW7szgPGjVhvOhVMVY
 Yvtu0PBNdyIvvo0HM3LPHpWX2DllNcqKAhDiJacQ8z83e5j+DjP7Y8YiuFmmMC+9djGw
 vQJ9BtPbW7eUn2hOimfHWbjZRX3+1SEvv9BFH8jNMeJ7YNLpnDmUTb0TIQHKrm9ucLlb
 hhND3V067yAerK2VLbLrl9qOKqSjMetvrdamJ8bHcc9K6BmF1y0JvHj71Iu/c/jnTC6a
 S82Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnomGffrHuoZsesAKUbg4OpcgHDSjry5FpsE6Obp9hcO6QgQNyWeLxcDUxDmeYWpwQuP++ofs=@lists.denx.de
X-Gm-Message-State: AOJu0Yzu95ZM6o1cT+sEu9a+msNG94Mz2T7dKAcNZuNnDrSLxfmHCbNq
 BDCf9bnzHYdPbY/HYVp+oAn8uxAvOKbEdk4OxDU2dq1EE0R+W0SZdIiUGxIPoFd19voAzBNKQpI
 YFv3H
X-Gm-Gg: AZuq6aInOcpu0yc1/i8yokQ8Pzk4GKauku1LEWrdf4eZc+c6EJ2Xg/Hz/mUrWpCAIf7
 ylTiFrncmiSW0t4osnFowifSkVuu06uM8ty+0tCN+v8QNlh5m0qUf56fKXBgYuZO2oCfzAbHyTy
 3bOtrWtNy36cJbceML1XC2y4LF3jFs6ZllyRs4xsX93kNZ/oQTL3TquxVd3W7xFRVWCuQ3gigvp
 w8aMASh1LbhQNSuq/36CtysoDzgQZF6nLkmnId3WCbtIxxJOO6+wSSQt/Jj3/S34XIDxT3EptUA
 PCykCcwUabixXHloX9RhBnCLFx/vlUfSVo2nkq9Is/WGxU3L8AlblITlwhO3nErU1zX96oo1F2x
 Mq5c2wPBVL8SWIMhjwp5pXxtm4pJF5kgFwCsUY7wysbA7mXtfS2pjDw7fYVUVi4pAI4nhsjTZpO
 xfr78HXjpcqvzjKRKP2bMCSGWoCA5rWVlXmWII98SHVgy3XI8gUclD+HMsNJfr
X-Received: by 2002:a05:6870:c221:b0:3ff:4ab4:774c with SMTP id
 586e51a60fabf-40a97037182mr1464596fac.43.1770390444490; 
 Fri, 06 Feb 2026 07:07:24 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7918:a69e:53a3:9e1c?
 ([2600:8803:e7e4:500:7918:a69e:53a3:9e1c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a9978a3absm1837725fac.18.2026.02.06.07.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 07:07:23 -0800 (PST)
Message-ID: <1caea259-b900-48e5-a3c0-89645f312b52@baylibre.com>
Date: Fri, 6 Feb 2026 09:07:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm: mediatek: consolidate ARMv8 memory maps
To: Julien Stephan <jstephan@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
References: <20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com>
 <20260205-mtk-mach-clean-up-duplicates-v1-5-b7d4a43c18eb@baylibre.com>
 <CAEHHSvasBSDP8S+v5qbiAgJdNH9bvLcogi3oh8FJMgpfQ9VAOg@mail.gmail.com>
 <CAEHHSvZ2bQy+b7kjO0jZyFEo0e2pYsfA9YxBk2m3DCOrcRu2Gg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvZ2bQy+b7kjO0jZyFEo0e2pYsfA9YxBk2m3DCOrcRu2Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Feb 2026 16:12:47 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/6/26 6:48 AM, Julien Stephan wrote:
> Le ven. 6 févr. 2026 à 11:07, Julien Stephan <jstephan@baylibre.com> a écrit :
>>
>> Le ven. 6 févr. 2026 à 00:52, David Lechner <dlechner@baylibre.com> a écrit :
>>>
>>> Consolidate all mem_map definitions for MediaTek ARMv8 platforms into a
>>> single file. The size of the DDR and MMIO regions can vary, so Kconfig
>>> options are added to configure them by target.
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> ---

...

>>> diff --git a/board/mediatek/mt8365_evk/MAINTAINERS b/board/mediatek/mt8365_evk/MAINTAINERS
>>> deleted file mode 100644
>>> index e0d65efe812..00000000000
>>> --- a/board/mediatek/mt8365_evk/MAINTAINERS
>>> +++ /dev/null
>>
>> Hi David,
>>
>> You are removing board/mediatek/mt8365_evk directory (and mt8390_evk
>> below), so you left mt8365_evk_defconfig (and mt8365_evk_defconfig)
>> without any entries in MAINTAINERS files.
>> So maybe we should add them to the MAINTAINERS file at the root directory?
>>
>> Also, if there is no more board directory for these boards, I think we
>> should remove CONFIG_SYS_BOARD="mt8365_evk" and
>> CONFIG_SYS_BOARD="mt8390_evk"  from their respective defconfig file,
>> as it should be empty if no board directory exist.
> 
> I forgot but we should also unset CONFIG_BOARD_INIT in defconfig for
> these boards, otherwise we end up with undefined reference to
> `board_init'
> 
I did this already for mt8390 in "board: mediatek: mt8390_evk: remove
empty board_init()". And I used buildman to compile test everything.
Did I still miss one?

