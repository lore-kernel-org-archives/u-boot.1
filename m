Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E02CE8E7C
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 14:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 831F488F69;
	Thu, 24 Oct 2024 16:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729779277;
	bh=tEAQh3PzS65kywrF+hmxUZ1yBT8aTL1aEYhVL9lwaZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OnW21Fjw0zJFAB/caOPAgKo7WCm7P4aa2ZFMKqySTCpn0UlYMxVTNTDHtTO2F9kYk
	 pOBqdoQ+h2/7XXVfrwVy2cxpLXkwRxGAM8ZWZiyRWgSu/xd0KPn/H5DcM1tHRW7lqh
	 bajNFlD+ctExJNvL3whb4pEWKxTST6izGsRSIB5W5viKmAmgiDL1/h0Hn31Qm5Uenq
	 tqg1zfYshOK+Rd+RALaTgozLf1FUopCcVVxRVvBuFRLvuZOBatycufasVYHMJ5Jxnh
	 iiovCTXyF4gQOC23ivO1tCq5jLpchcCKOhWTXTnmRs/DtBrq9s7eTOdSydTjjO2LSG
	 x6JPpN7wdfDEg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5686F88F69;
 Thu, 24 Oct 2024 16:14:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729779274;
 bh=tEAQh3PzS65kywrF+hmxUZ1yBT8aTL1aEYhVL9lwaZA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Lmh0PGdaa+UKcm3SEH/wNfIh4fKd0OFZieMIdWsPovCJ09/Vryox8rqAg5v6+Az4P
 48Rtz4jbhrVgKkQhjZj4i0nq/vZ3MzXX3hCyD/SilP/pfM9WnS7q5qS6a6vLi//B5a
 M1XgZRRmRLl9YC/F6XDpVW6IufMcpTw2g8Snlkj4a2VMO7tOSp6ejuXxRvkEn/eKa0
 GarQsmVFU/CRwGExTkC0WUfcOZeBG+j1p9APFfPqe5mA8KwhWcGQD/KTSn59Ie4cee
 pe1T1dKdqYh47GDa/4M525EP6z9nUBPVH2mpmP+0BtLDUHBShK+TaL0vRhcF9U9ONe
 NkiiFzWDRN60g==
Message-ID: <3fa7049d-4657-4cae-9ccf-fac1c62ce529@denx.de>
Date: Thu, 24 Oct 2024 16:07:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
References: <20241024122735.893319-1-ravi@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241024122735.893319-1-ravi@prevas.dk>
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

On 10/24/24 2:27 PM, Rasmus Villemoes wrote:
> Loading flash.bin using uuu fails when flash.bin does not have the
> right size.
> 
> When flash.bin is loaded from some storage medium (sd card/emmc), SPL
> just loads some random garbage bytes from beyond what has been
> populated when flash.bin was written, but when loaded via uuu, SPL
> hangs waiting for the host to send the expected number of bytes. Which
> is (size of FIT image aligned to 0x1000)+CONFIG_CSF_SIZE. The
> alignment to 0x1000 is already done and is necessary in all cases
> because that's the exact expected location of the 32 byte IVT
> header. But the IVT+CSF blob tacked onto the end must be a total of
> CONFIG_CSF_SIZE.
> 
> This is exactly the same fix as 89f19f45d650, except that this time
> around I don't know how to cleanly get CONFIG_CSF_SIZE.
> 
> Fixes: bc6beae7c55f (binman: Add nxp_imx8mcst etype for i.MX8M flash.bin signing)
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
> Heiko, can you check if this works for you?
> 
> And if somebody wants to pick this up and knows how to get at CONFIG_
> values, feel free to fix up and take authorship. But perhaps it's not
> really configurable at all; imx8mimage.c has the value 0x2000
> hard-coded, so I don't think anything good could ever come from
> modifying CONFIG_CSF_SIZE. If so, the right fix is probably just to
> make that knob non-settable.
> 
>   tools/binman/etype/nxp_imx8mcst.py | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> index 8221517b0c4..9a1974cc522 100644
> --- a/tools/binman/etype/nxp_imx8mcst.py
> +++ b/tools/binman/etype/nxp_imx8mcst.py
> @@ -137,6 +137,8 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>           args = ['-i', cfg_fname, '-o', output_fname]
>           if self.cst.run_cmd(*args) is not None:
>               outdata = tools.read_file(output_fname)
> +            # fixme: 0x2000 should be CONFIG_CSF_SIZE
> +            outdata += tools.get_bytes(0, 0x2000 - 0x20 - len(outdata))
>               return data + outdata
>           else:
>               # Bintool is missing; just use the input data as the output

I have to admit, I never really figured out this binman stuff, but 
shouldn't the fix be also in tools/binman/etype/nxp_imx8mimage.py ? And 
... shouldn't it somehow use SetImagePos() ?
