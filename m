Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE865D0E6FC
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D58C88EEB;
	Tue, 22 Oct 2024 13:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595561;
	bh=HGSKBAx2f+GISHwW1mZUdCJea0sBQLBG2oSsiUdvPI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TrWq/kMPB759Lxh0F8mkNu+ZA0ErkPFy2Zb39PzzAjuYDMt9Xy3vhLSdJapPxMExu
	 O2BU78W7GxXmTHZL/fCAduCmyV6aNefmqb1RjoK1hl3WQubYnYLUyewooJ5/0oGxZQ
	 Rv1bNFM8W0ykT8QP+f1PSWJrpI45v/9khDNtDLOKPKw1J//BYfLilg9S0nQsv8g2Nc
	 /emcbU9RmlesxyT20BFte9IoQ7qv3dyHq+ZMAT+dI3+waZ0D5Z5OaqlUk/1v0slNau
	 U/j3RdkAdksPW9McGB+aDEdJzhaA17Q6sUcqymD11HkGCVDXU8N4DcgLgoCgfVKei2
	 xSNK4sUw3Oy8w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A19C88FBB; Tue, 22 Oct 2024 13:12:40 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F50B8641A
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XXqK03R17z9sRJ;
 Tue, 22 Oct 2024 13:12:36 +0200 (CEST)
Message-ID: <e241dec3-de47-4b4a-b8bb-f0e4c2cd7f40@denx.de>
Date: Tue, 22 Oct 2024 13:12:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 07/13] cyclic: make cyclic_run static
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-8-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-8-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XXqK03R17z9sRJ
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
> The only caller left is schedule(); everybody outside cyclic.c now
> calls or references schedule().
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   common/cyclic.c  |  2 +-
>   include/cyclic.h | 12 ------------
>   2 files changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/common/cyclic.c b/common/cyclic.c
> index 38d815bec35..196797fd61e 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -45,7 +45,7 @@ void cyclic_unregister(struct cyclic_info *cyclic)
>   	hlist_del(&cyclic->list);
>   }
>   
> -void cyclic_run(void)
> +static void cyclic_run(void)
>   {
>   	struct cyclic_info *cyclic;
>   	struct hlist_node *tmp;
> diff --git a/include/cyclic.h b/include/cyclic.h
> index e8de616dcd5..c6c463d68e9 100644
> --- a/include/cyclic.h
> +++ b/include/cyclic.h
> @@ -87,14 +87,6 @@ int cyclic_unregister_all(void);
>    */
>   struct hlist_head *cyclic_get_list(void);
>   
> -/**
> - * cyclic_run() - Interate over all registered cyclic functions
> - *
> - * Interate over all registered cyclic functions and if the it's function
> - * needs to be executed, then call into these registered functions.
> - */
> -void cyclic_run(void);
> -
>   #else
>   
>   static inline void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
> @@ -106,10 +98,6 @@ static inline void cyclic_unregister(struct cyclic_info *cyclic)
>   {
>   }
>   
> -static inline void cyclic_run(void)
> -{
> -}
> -
>   static inline int cyclic_unregister_all(void)
>   {
>   	return 0;

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
