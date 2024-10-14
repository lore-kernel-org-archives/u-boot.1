Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079A8D24469
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 11:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6270D88DA0;
	Mon, 14 Oct 2024 13:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728903794;
	bh=cMs0dVE8LaEH8KKHFnqEbv/ZkQQriMA4JmmRYesk2RY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=mzoY2iQ62+DjwvDhMAk0NrSTkG7z4Q45tYbzfEqHKNibEjEeLkFoHm3UCuWqHG/w+
	 a8D3T5JJgFoowtt4UKx7kVhG6x/G7I78vLqu+iC9ThaYK/xf6dqZEyLNdgCHpRy+s4
	 gzvdU5KoKgIG8MQdD9IGM0mZWqY8MYJIBCpBiLFa8+Zv/A4ZdbNEdnZzTrdYN7fVoE
	 LYpz5o1eEB27vhdsJhFhfk+i1yoNYhaYcysIWhH17mBOrL+r8DhH78OqTHOMn014d7
	 LmEszfaaj39ODbK5nX7gXoDmUnX1i+oxd9hButTNWVt3TEljv/umXTPgRlJh9Fws2N
	 S7ALrg58j41Iw==
Received: from [192.168.1.107] (87-97-107-160.pool.digikabel.hu
 [87.97.107.160])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2051088E3F;
 Mon, 14 Oct 2024 13:03:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728903792;
 bh=cMs0dVE8LaEH8KKHFnqEbv/ZkQQriMA4JmmRYesk2RY=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=fcJyxzBYQvKfVNM5Rh8f8czXLT0sPmv5IVooqUOMgleqTsePYA+va7Pe3gIdxeKoN
 Pjp8NlvvodlBdAFUupu2SZ2k1ldWUIA4NLjZNtmZfnPvbcKZbM5amXocuDhAKVpulV
 MHo29Qmxj/IW4EWoYQ/GQKqgmbq8wC7IZrvXiEQVnXwyqZExdiBdrT6aacvfIH0OTo
 JWEGGlG6wdNrkKnBr+DyiOVaSIFEOV9FBqyNVuijv2DvmWDoR2EqMD1btXGE+LllGl
 wvLvCWc77XLZDczXKAmoN57f4oZ9BN4OFKCFOzSs9btd6Ne64XibxKF2dp6I+yr2PS
 IkyHq6C5j0tVA==
Message-ID: <0ad2ec37-248a-8a42-7f56-bad4e450601c@denx.de>
Date: Mon, 14 Oct 2024 13:00:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
Content-Language: en-US
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Peng Fan <peng.fan@nxp.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefano Babic
 <sbabic@denx.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20241010082831.19983-1-hs@denx.de>
 <DB9PR04MB846127A928CBE4AB1F373DFE88442@DB9PR04MB8461.eurprd04.prod.outlook.com>
 <43ea1972-ee4f-ab25-aa98-2ae3fc4f20fb@denx.de>
 <DB9PR04MB84613CEEBFE7ECE0B249DB6A88442@DB9PR04MB8461.eurprd04.prod.outlook.com>
 <aeec07bf-6a3d-08c5-2786-5a7c2bfe92b6@denx.de> <87a5f7assp.fsf@prevas.dk>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <87a5f7assp.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Rasmus,

On 14.10.24 12:21, Rasmus Villemoes wrote:
> On man, okt 14 2024, Heiko Schocher <hs@denx.de> wrote:
> 
>>
>> Board boots fine from emmc, sd card. Booting blank board with
>> uuu works with posted RFC patch, as it seems to me code in
>>
>> spl_romapi_load_image_stream()
>>
>> waits for more bytes than flash.bin currently has... appending some
>> zero bytes at the end, and U_Boot begins to boot and works fine, uuu
>> tool ends with errorcode 0.
> 
> Sounds like exactly the symptoms I fixed with commit 89f19f45d650.
> 
> So yes, you really do need to ensure that flash.bin (or rather the
> embedded u-boot FIT image) has a large enough size for what the rom api
> expects, and that number changes when HAB is enabled.

Yep, sounds exactly like this... and my change in the RFC patch
should behind the line:

  #ifdef CONFIG_IMX_HAB

or maybe we need to look into binman how the "nxp-imx8mcst@0" stuff
is created...

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
