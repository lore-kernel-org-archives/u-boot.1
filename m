Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033C5CFC53F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 10:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F48988D72;
	Mon, 14 Oct 2024 12:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728901917;
	bh=Ct4bkpArqx7eDkVrJ0mKhVDS1+MiHhat+TMeMr1z4To=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TCr/9+sttFV5sQ6FTk/Wdn+cBEDmSy2ZGsDnrB45ZtJOmKxq/Ti/Tsi28JpJbuhHm
	 +vVwtDOKsMVcdzvhaMvGCrEalX9A5ySb6jyn1SAQWLrpai1hQSe8wja5fkWWuY1qA0
	 nVC+5dbMvXygD3/gXh9U5gpwzTlFtRcGqrbk7bibQe1D+4aNzvHdMaOPhmO+kFO4Gc
	 TnvWIj/cG/lx0fKaanPnqzGmr63QtRkJ8lEnUPyyGkU6sKyE+lwXfyP31PMvZEoWK/
	 I8Ojtc+Ng9nSMgExPjTp8yuTziC1VcpzU+rvnfTbCdXfI3djaGdB170fQidEo7Y6Fp
	 NvbJHaX/Qhrow==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BB80288A4C;
 Mon, 14 Oct 2024 12:31:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728901916;
 bh=Ct4bkpArqx7eDkVrJ0mKhVDS1+MiHhat+TMeMr1z4To=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=M8k3tlJu+27Wa9PUQ+NwciAp+Md3PZdOjZageet+Ct52EaTF+Du5E44hlmwqqMqq3
 qaQG5ridQCtw4TpLiafTvarIjNjHPE0EVmHa1jZtUik03Tal5gjSrMb9oWq1rkDf49
 g9mSXWrsbUlodgLTTN2ecLK1um/aUVPSviS0tLAL65phCIYpro7RjHRiv3GY+4AesQ
 GVUKQbiRZuQvK6/HQNDHyRHh6HUWgsAVq19AbJtvEd7ZP8VQPfqDL3NLHmm9eVxnmA
 vmoYSjas/1HAylI6Tyhixp9SYAsU25AX8cGtU2HmfZ0l7Et/Zw2yonScZ0QwnzHExS
 NmJRXEWqZy4Hw==
Message-ID: <36a930c4-5b47-462b-bcf5-862816ac1d57@denx.de>
Date: Mon, 14 Oct 2024 12:31:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
To: Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 dl-uboot-imx <uboot-imx@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefano Babic
 <sbabic@denx.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20241010082831.19983-1-hs@denx.de>
 <DB9PR04MB846127A928CBE4AB1F373DFE88442@DB9PR04MB8461.eurprd04.prod.outlook.com>
 <43ea1972-ee4f-ab25-aa98-2ae3fc4f20fb@denx.de>
 <DB9PR04MB84613CEEBFE7ECE0B249DB6A88442@DB9PR04MB8461.eurprd04.prod.outlook.com>
 <aeec07bf-6a3d-08c5-2786-5a7c2bfe92b6@denx.de> <87a5f7assp.fsf@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/14/24 12:21 PM, Rasmus Villemoes wrote:
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
Is this missing in the binman implementation then ?
