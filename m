Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08348D15DBB
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9551588F8E;
	Tue, 22 Oct 2024 13:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595658;
	bh=3Dq7y7+UlxbOvwbsNJ2hByn/8k32Z37zfb9DmmKohqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fg0DBz2Te5Q4N+YZGlBbN9Dmn1ci7SIk0ZylonYuqauJUECiJE8AA1mviv0Ju2OGy
	 3nTielTwwzdmmm+3Imdts3GWB3CLmZtY+9e/kZCP/VqGFISVLMR3nWtjf6bqA+5TBk
	 Gs4agGtT/3Jy1flvxV6RIP6DFlQhX+0Uv0I2iUudTys4sLq0grbvXukUb3cRoah56b
	 LA45ZR4adyWSvK5nW5jRvf4YZdgattjT1faP2daEOF3upgaOg9FkHrfapFob66q0Y3
	 myn2lbJc1zcEnhB6ctBbxINKBWTC5D0xSkJXBL4dyDy9tPs8J7wR+ctdhLnQceRhei
	 di6xxSRaosUmw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E52888FD6; Tue, 22 Oct 2024 13:14:18 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3919C88D5C
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4XXqLt1NQsz9tPw;
 Tue, 22 Oct 2024 13:14:14 +0200 (CEST)
Message-ID: <61c763e3-ffa7-458e-a19b-e79617e4cc80@denx.de>
Date: Tue, 22 Oct 2024 13:14:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 13/13] global_data.h: remove unnecesary include of cyclic.h
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-14-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-14-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XXqLt1NQsz9tPw
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

On 10/3/24 23:28, Rasmus Villemoes wrote:
> Nothing in cyclic.h is needed to define struct global_data, so do not
> include that header.
> 
> If any .c file relies on getting cyclic.h through asm/global_data.h,
> it needs to include it itself.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   include/asm-generic/global_data.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
> index 27aa75e7036..1570ad8f0c0 100644
> --- a/include/asm-generic/global_data.h
> +++ b/include/asm-generic/global_data.h
> @@ -20,7 +20,6 @@
>    */
>   
>   #ifndef __ASSEMBLY__
> -#include <cyclic.h>
>   #include <event_internal.h>
>   #include <fdtdec.h>
>   #include <membuff.h>

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
