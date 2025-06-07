Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A233C61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 08:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D356828F8;
	Sat,  7 Jun 2025 10:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MtqbHPPp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2E682998; Sat,  7 Jun 2025 10:01:00 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB343826AA
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 10:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=db21=YW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1749283256;
 bh=/uoZF9asRukmXm1V8TpQx2wHKrbLJQ4Z/G/ka46EsYU=;
 b=MtqbHPPpXwCBvN6gM8jKTCeMlL7HERnynERgyV98bysox3Iif92EcPVSSTWpU3UlgsbKVImZT
 5+M9Kq/dVHN6rJH9HTevUUFdoxubtA5ze3cwUQ0PnUizK7FSpMXLjvXW5X6+2vyxDWJb63CwHQQ
 XJUWwAL9iI+/ZmFHI4KBq5S/09SsG1HH+OvwL7IrUXYLioQarGv36Gd0oLme/0Jp10V/+duO+33
 /2fuwO5M+eoTItN6LsAjO8JLMQ8k6gjHJV10+7BMvYtnu6HyrDmGaiIca0C05DQ5UkLxzWSKtCF
 /FZXwyOQoIRv9pVJylp3xuIk2tDct9GqVs063IkwWOGg==
X-Forward-Email-ID: 6843f1b5205d874ee64799f6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <82a14d8e-c444-45b1-aa99-ec6ef0fb064b@kwiboo.se>
Date: Sat, 7 Jun 2025 10:00:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] common/spl: handle properly images with bad
 checksum
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
References: <20250606205410.GC1382132@bill-the-cat>
 <20250606223109.502055-1-mikhail.kshevetskiy@iopsys.eu>
 <20250606223109.502055-3-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards
 <cfsworks@gmail.com>, u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250606223109.502055-3-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
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

Hi Mikhail,

On 2025-06-07 00:31, Mikhail Kshevetskiy wrote:
> load_simple_fit() returns -EPERM for the images with broken signatures.
> Unfortunately this may conflict with image loaging selection on the base
> of boot phase. See commit 873112db9ce68c38984ff25808dde726f8dd5573
> ("spl: Support selecting images based on phase in simple FIT").
> 
> Thus loading of
> 
> 	configurations {
> 		uboot {
> 			description = "u-boot";
> 			firmware = "atf";
> 			loadables = "atf", "tee", "uboot";
> 		};
> 	};
> 
> with damaged "tee" image may finish without errors. This may results in
> board bricking. This should not happen.
> 
> The simplest way to resolve an issue is returning the different error
> code for the cases of broken signature.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  common/spl/spl_fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index ab277bb2baa..783bb84bdb5 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -322,7 +322,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
>  		       fit_get_name(fit, node, NULL));
>  		if (!fit_image_verify_with_data(fit, node, gd_fdt_blob(), src,
>  						length))
> -			return -EPERM;
> +			return -EACCES;

I think a proper solution would be to fix the bad use of EPERM in the
commit 873112db9ce6 ("spl: Support selecting images based on phase in
simple FIT").

That commit should never have used EPERM in the first place, it should
be reverted or its use of EPERM could be changed to something that is
currently NOT used to block loading images that fail e.g. a signature
check.

Regards,
Jonas

>  		puts("OK\n");
>  	}
>  

