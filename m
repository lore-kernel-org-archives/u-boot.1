Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D2ED116EC
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 04:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B5E88F47;
	Fri, 25 Oct 2024 06:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729830982;
	bh=ySkmF9IxoKKuAN4s+1hYUyDoo9qJRqEv3vUzcQcHjNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=bVQCE1U/PJFfiG0DY5zf8cbJQ0G3lIPQJe4gBRw0i/EgbQoC2xLa7MUTEtCdWfVa8
	 1aHp8HkOwWsQ5tZPNk8UdCCseoygSqxvrXEycpxNK1A7OMS+gAcpy6mn9vx0urTkyh
	 s7uuc9Co7G2mfx/iHs8VRUOGFJSQo/Hhycmbm+hzUGa56A2iZKlSkZn6uZZYY2edPd
	 NkCsaKRi6fuhVw+7IoGBk8Ud2G0ouXF+LnX4hz+vbcFhBZpz5iVdlEMYp/W3jEmn/b
	 PgWKzRKPS13s4U1PK0UbN00YUIDNwGjYDxYfZBecQVDtlDVcSTX2V2G2WA1rqnFola
	 v40MHI2dWq0Zg==
Received: from [192.168.1.107] (82-131-200-27.pool.digikabel.hu
 [82.131.200.27])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B14B388FC0;
 Fri, 25 Oct 2024 06:36:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729830981;
 bh=ySkmF9IxoKKuAN4s+1hYUyDoo9qJRqEv3vUzcQcHjNA=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=r6/Awq5By29y363YwS3iyIL25D1cMzhz0RarjFU9dVqRIRmtDIIUlBvZwhD4B5z45
 igpgeq9P2ZwXYiHvp997FKEWluezsGCKWF1QNH6pjqLpdPQzb5+8WmCJWgZZnM74kE
 6b6mda8EtQLMbxnLXqix98SjH1+xWJqW+PXJfWn/2WTraUqXTljXWywUh4dJiqUSo9
 JUPRHAgOoinuzVtnvSDkEDRG/Knfc4wus5xicus8/wGsEPksn9uTmUsOSAEOE5Qvrz
 cftiL2RzR9ykd8b9K6Z83jmjrkanyvFfCa7MD+o1DtCjy4s4dnMAzB4NBi9l6QFAVI
 SUDN73YrgnsXA==
Message-ID: <3606fb53-c36e-93c7-6ff9-9947ae43c408@denx.de>
Date: Fri, 25 Oct 2024 06:34:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb
Content-Language: en-US
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
References: <20241024122735.893319-1-ravi@prevas.dk>
From: Heiko Schocher <hs@denx.de>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Rasmus,

On 24.10.24 14:27, Rasmus Villemoes wrote:
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

Works fine for me, thanks!

> And if somebody wants to pick this up and knows how to get at CONFIG_
> values, feel free to fix up and take authorship. But perhaps it's not
> really configurable at all; imx8mimage.c has the value 0x2000
> hard-coded, so I don't think anything good could ever come from
> modifying CONFIG_CSF_SIZE. If so, the right fix is probably just to
> make that knob non-settable.

Hmm... I don not know if it is a fix value... added Simon,
may he knows how to use a CONFIG_ option in buildman. If I
find time, I will take a look...

bye,
Heiko
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
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
