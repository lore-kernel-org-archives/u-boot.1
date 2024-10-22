Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8829CD0E6FC
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2317488D8D;
	Tue, 22 Oct 2024 13:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595591;
	bh=nx3Y4fD+cMxxe+LqzsJvQt2ldClOuuTMrsRn1io6c4c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bZFQhSUYz3Qsm0/ThOWtBYXkOfHEMQ40hqyL0Nq2esyQATC88pfgCLURMxwULSeEt
	 pnbvRxBjJHJrzb5pqzH295ek6TTr1lw8yzrGTRVusZxLoPcttXpz3Bi17ZkKSrNfhh
	 6hnIlUL5eIO0nWCXK5BTCWqw6KeJu9OTODHPSYzMrzPC8OfQsctYka3yypL4X9JHRA
	 BSZG+mR1yfcyraVv/aDpBmYOYZ4OZgk1ByzXDExGjY5aiKupcOJssJwHb/daicuIBg
	 JNwCJg1S4VW+uRwXE1c2Tk9cWvCULF84449BKX47+hGUSOAoBk20efUOZJeewMhPe2
	 WQw1vH3hwM2ZQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E36D88D91; Tue, 22 Oct 2024 13:13:10 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 376FF8641A
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XXqKZ1Hwcz9skj;
 Tue, 22 Oct 2024 13:13:06 +0200 (CEST)
Message-ID: <c41c9dbe-8286-4d0c-baac-d824fe80750a@denx.de>
Date: Tue, 22 Oct 2024 13:13:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 09/13] lib/sha*: include u-boot/schedule.h instead of
 cyclic.h
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-10-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-10-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XXqKZ1Hwcz9skj
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
> These library routines obviously do not make use of the
> cyclic_register() etc. API, but do need to call schedule(). Include
> the proper header.
> 
> Eventually, their ifdef logic should be updated to avoid talking about
> CONFIG_WATCHDOG.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   lib/sha1.c   | 2 +-
>   lib/sha256.c | 2 +-
>   lib/sha512.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/sha1.c b/lib/sha1.c
> index 7ef536f4b5d..233bd9145c6 100644
> --- a/lib/sha1.c
> +++ b/lib/sha1.c
> @@ -17,7 +17,7 @@
>   #endif
>   
>   #ifndef USE_HOSTCC
> -#include <cyclic.h>
> +#include <u-boot/schedule.h>
>   #endif /* USE_HOSTCC */
>   #include <string.h>
>   #include <u-boot/sha1.h>
> diff --git a/lib/sha256.c b/lib/sha256.c
> index 665ba6f152e..329802fd827 100644
> --- a/lib/sha256.c
> +++ b/lib/sha256.c
> @@ -6,7 +6,7 @@
>    */
>   
>   #ifndef USE_HOSTCC
> -#include <cyclic.h>
> +#include <u-boot/schedule.h>
>   #endif /* USE_HOSTCC */
>   #include <string.h>
>   #include <u-boot/sha256.h>
> diff --git a/lib/sha512.c b/lib/sha512.c
> index ffe2c5cd964..ea555ff33eb 100644
> --- a/lib/sha512.c
> +++ b/lib/sha512.c
> @@ -11,7 +11,7 @@
>    */
>   
>   #ifndef USE_HOSTCC
> -#include <cyclic.h>
> +#include <u-boot/schedule.h>
>   #endif /* USE_HOSTCC */
>   #include <compiler.h>
>   #include <u-boot/sha512.h>

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
