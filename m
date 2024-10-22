Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BA4D15D9D
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7861788F4D;
	Tue, 22 Oct 2024 13:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595525;
	bh=+fQOMZN29G83EpBeyZY5LcpKzCt3pIMQI1aZ5jztgwo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SA/mNuBDud5uhBp+iE7Bp+KkycTi7zsPAOvHeWoHSnB4eTTFdAD6G9QECM1TqGnxB
	 mJjnydErtLZK4gRQsVRwE4feH8h+WNExqqZTu+ArrnDIv655RFQYKUtmZkaZzmDbI2
	 W3vtS5Nf/QNQlCAAQltd4ma8YErJpdYUlc1kvQXX+mGRe5/FB1giFen1+1uq50so2t
	 CUvAOsVV4BgBvr1XTjnnTYTKz4K85dtcP705QUhWefxVOOTUgkCSrLCRIm6gNEseTP
	 fq6YIZwFQAYKnEUG3e6XeMFSBg0R2t/pMzkp/Nhx2kG3AlOaODqZdFY7a3FA+638cH
	 Dh5iJu8FKsmEQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9EEA88FA8; Tue, 22 Oct 2024 13:12:02 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEFEE88D5C
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XXqJG4nwnz9sng;
 Tue, 22 Oct 2024 13:11:58 +0200 (CEST)
Message-ID: <9d48e6c8-f53d-4dd3-be1e-e36d8f7fc64e@denx.de>
Date: Tue, 22 Oct 2024 13:11:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 05/13] fs/cramfs: use schedule instead of cyclic_run as
 callback
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-6-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-6-ravi@prevas.dk>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/3/24 23:27, Rasmus Villemoes wrote:
> Prior to commit 29caf9305b6f ("cyclic: Use schedule() instead of
> WATCHDOG_RESET()") we had
> 
> /* Currently only needed for fs/cramfs/uncompress.c */
> static inline void watchdog_reset_func(void)
> {
>         WATCHDOG_RESET();
> }
> 
> and .outcb was set to that watchdog_reset_func().  Said commit changed
> that .outcb to cyclic_run instead of schedule, which would otherwise
> match all the other WATCHDOG_RESET replacements done. As the
> HW_WATCHDOG case is not handled by cyclic_run, this seems to be an
> oversight.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   fs/cramfs/uncompress.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cramfs/uncompress.c b/fs/cramfs/uncompress.c
> index 2141edf22e4..97af8cb2b4f 100644
> --- a/fs/cramfs/uncompress.c
> +++ b/fs/cramfs/uncompress.c
> @@ -21,9 +21,9 @@
>    */
>   
>   #include <stdio.h>
> -#include <cyclic.h>
>   #include <malloc.h>
>   #include <watchdog.h>
> +#include <u-boot/schedule.h>
>   #include <u-boot/zlib.h>
>   
>   static z_stream stream;
> @@ -63,7 +63,7 @@ int cramfs_uncompress_init (void)
>   	stream.avail_in = 0;
>   
>   #if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> -	stream.outcb = (cb_func)cyclic_run;
> +	stream.outcb = (cb_func)schedule;
>   #else
>   	stream.outcb = Z_NULL;
>   #endif /* CONFIG_HW_WATCHDOG */

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
