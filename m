Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13BFCF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 06:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 229ED88F3F;
	Mon, 14 Oct 2024 08:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728886330;
	bh=7EpOQm2YDQqN0b5p+uZw3doJoOqCA7izEmCIj8AdWdk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=WWu1sqIuOLqEjaOBWv+ZFdD3gB9ySeum75EfD8bDP8W3At+kA/hclLzRVIVAyWu6w
	 5Y9trMruyP3xwSn+SbA3LBHvEubO8IIGtVObJQWTA2dO5QPHcpRP3bIiiKxhYuywp7
	 CZ1AfIk+kYQM8LGP+1YLYR+5nm5ylc5JB1IG0HwsvSRoVv9JTxrwsT9iCkMfzii014
	 wqscHFYZknSWqKAWowYwZpxEnD2h8rYwvG90UQyvBxqfFyxyLo46y/2yY2Mt/cD/Mf
	 SHNy9OGkle7jZBBopHIWLWyTQ2k66761iz6kqSkk/KrmqFxk+JR58734+WXNUmb2cu
	 Pb3fHfzMm1Gqg==
Received: from [192.168.1.107] (87-97-107-160.pool.digikabel.hu
 [87.97.107.160])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0E6EA88EC6;
 Mon, 14 Oct 2024 08:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728886328;
 bh=7EpOQm2YDQqN0b5p+uZw3doJoOqCA7izEmCIj8AdWdk=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=kBoRwXfFOn1n8wd+QLzVAwHplFY+uebxxf7yM8HJKC71pnK6Q03RzZQ9OvuYPjqQM
 m9VVxnsupIYV4xNCfVsTLawqTWxZad1vQP48AsFwjoee+GpnFK6VRYpf7LWxnv7ruh
 l0awZnddZU315pnXQXVJBkNYvJ8Gz726wO1QCPPcWEhoKoAupkbVksyLSpO+szhLjg
 VM75si8dZinBDH9ABfgGJed9gHTGdHGSznudO5sctB6ecvZ/j0jxO9vTRZ5bgJyPCX
 LkrJgwEMZpsx24/0IBVtx2GnVIHKJ2EJCOVmVsR3Lenf2NYaeNkUHBYdytzQ9GIrbZ
 h3FefNzTFGNNw==
Message-ID: <8a5017a6-564e-4c65-cda7-912338990ba6@denx.de>
Date: Mon, 14 Oct 2024 08:09:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefano Babic
 <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20241010082831.19983-1-hs@denx.de>
 <20241013124213.GA15299@francesco-nb>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20241013124213.GA15299@francesco-nb>
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

Hi Francesco,

On 13.10.24 14:42, Francesco Dolcini wrote:
> On Thu, Oct 10, 2024 at 10:28:31AM +0200, Heiko Schocher wrote:
>> trying to load current flash.bin with uuu tool
>> leads in not booting U-Boot as missing some bytes.
>>
>> Align flash.bin in this case to 0x800 bytes, to
>> make uuu and ROM api happy.
> 
> Are you sure that the issue is on this? Can you check
> https://github.com/nxp-imx/mfgtools/issues/416 ?  Just sharing something
> related when using UUU on OE generated binaries to confirm you are
> not chasing the wrong issue here.

Thanks for the tip, but I do not use meta-freescale... but yes,
I build with oe... the issue is, because

Okay, I tried the following (flash.bin created without this patch):

$ cp flash.bin flash.bin-tagged
$ stat -L -cUUUBURNXXOEUZX7+A-XY5601QQWWZ%sEND flash.bin-tagged >> flash.bin-tagged

and loading flash.bin-tagged... which leads in uuu reaches 100%
but U-Boot does not boot, as rom_api_download_image() still waits
for some bytes ... simply sending more bytes by starting uuu again
leads in starting U-Boot!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
