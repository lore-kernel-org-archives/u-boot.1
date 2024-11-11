Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0632D12D71
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 05:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA02E89171;
	Mon, 11 Nov 2024 06:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731304688;
	bh=JaJWB99/y+hD+kmvEc2hsvPqxrkCCLXQJLyJPoSBpgM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=W1iAgP64nrPlZ7o0zIS1h45LRI5cRAfQxug+1dFc7hjE5R7KnpIEWd5bbOjy+nPT9
	 ixLoSL6nzBVeU4CpQfoWOsq4VRLlkcssqv82TtxryP+rhQzGfPTh6NYYPhEJwwuhxq
	 bgUtBxe2//zeClVCN81mWHAzksRoDTFRKp3x9AYKXt8c0VHpzHu/rtWp5F6fZIubvT
	 QkGJCq6GOHP4taIceHkdMXUQNwK9S/QOJoiLEVXzNSwdB/qRwwc+uf0IrURzYYTOla
	 oagK/pUWrykTxTndgUZg3uzKTY5oWFS5j+7Z4v2YNnTtsbliut63z91qIjnsrBYXpZ
	 bAO0aCjnKpXgg==
Received: from [192.168.1.107] (87-97-106-70.pool.digikabel.hu [87.97.106.70])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 76B108911D;
 Mon, 11 Nov 2024 06:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731304686;
 bh=JaJWB99/y+hD+kmvEc2hsvPqxrkCCLXQJLyJPoSBpgM=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=DICxn4Hv35Q47oLVQmKM90uGVTmM0jSVDy41KrEO7b8hsjsusxP4LkYV0HD4d7WEs
 T/XJqEsVaX8L/12ValYc78c8S0Z1tVGp+8U/n/7xmU68DJYonyiUfXe7n7fnIWgVQQ
 IEd5f/rhIy6BuyjfWH2lGM5uVVhYeYDHcPQkAw0IGxyzbyRgJD5rtLjnNACFdZoYKW
 CuMahajMilJiPl9mTbS2gyPmGnH8gpZlaNTTewDaXW9FsSSEXZQ6HjjrReVEb+G3lY
 nW4nAM5uReOZjXxb0toRbdxKjBOCQncOrkD7f/FjllK/O6q8JNGe/XCBqux5TmWw7/
 nPLNx4yQykvMQ==
Message-ID: <6e1933cf-64de-a02c-e6a1-6e8e5a7eed39@denx.de>
Date: Mon, 11 Nov 2024 06:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 20/22] siemens: add ddr full memory test
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-21-hs@denx.de>
 <CAOMZO5Btc3grPOChT5VQyaLWSx1uyKHdBgH5q3m3b1s_neiCrw@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOMZO5Btc3grPOChT5VQyaLWSx1uyKHdBgH5q3m3b1s_neiCrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Fabio,

On 09.11.24 13:06, Fabio Estevam wrote:
> Hi Heiko,
> 
> On Fri, Nov 8, 2024 at 2:24 AM Heiko Schocher <hs@denx.de> wrote:
>>
>> Add siemens specific memory test. Enable it through Kconfig option
>> SPL_CMT.
>> The test is required from our HW team. It runs over temperature during
>> many days:
>> * must run indefinitively through the whole DDR area
>> * must write/read/check all values
> 
> Isn't it better to run a utility in Linux like memtester for this purpose?

@Enrico: Could you answer?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
