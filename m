Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFC5C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4347B8210D;
	Thu,  8 May 2025 09:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746689167;
	bh=ssVH/kpBrdMCtKalqtj3IVGcWYn8W9/VEwjBOKomAlY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AUxmiZUDMDLMNoEenf05C8NvueNYz7+e7tEVe57R5X7CyHkd2Z5VS6AogGfDHmLbb
	 FCG8tzJXRzieM1Vh7RNKOtYZFkl3JEXTzbtXC7Z+al5rE4cJ/7TWli1Vydfxs4ZpKL
	 YJGD70q0+o3VbSpw0ZdCF6f4Q5+O+OHQtpWYgjDdSLB1TO+7T/fv+y3bioBuiuU712
	 n+E60peIbktr/8RdX9zD1LN96u0Jg8B980Qv1VhIskfJdlJzjP4H8DkafoRmXOisqL
	 G4GOA9fjoyUE1uSrih9dH9ctU7IF3eF8a5otOK9vA8UpOoi3apZcwPkZzO6WkuU8KX
	 U2GfDGHOvc1+A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5208211F; Thu,  8 May 2025 09:26:05 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E2808059D
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4ZtNw938kRz9sqP;
 Thu,  8 May 2025 09:26:01 +0200 (CEST)
Message-ID: <490d79b4-9b06-439a-acb2-e321354e70dd@denx.de>
Date: Thu, 8 May 2025 09:26:00 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] cyclic: make cyclic_unregister() idempotent
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250507105821.484442-1-ravi@prevas.dk>
 <20250507105821.484442-2-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250507105821.484442-2-ravi@prevas.dk>
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

On 07.05.25 12:58, Rasmus Villemoes wrote:
> Make cyclic_unregister() safe to call with an already unregistered, or
> possibly never registered, struct cyclic_info. This is similar to how
> the various timer APIs in the linux kernel work (they all allow
> calling delete/cancel/... on an inactive timer object).
> 
> This means callers don't have to separately keep track of whether
> their cyclic callback is registered or not, and avoids them trying to
> peek into the struct cyclic_info for that information - which leads to
> somewhat ugly code as it would have to be guarded by ifdef
> CONFIG_CYCLIC.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   common/cyclic.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/common/cyclic.c b/common/cyclic.c
> index b695f092f52..75662d9f613 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -28,6 +28,18 @@ struct hlist_head *cyclic_get_list(void)
>   	return (struct hlist_head *)&gd->cyclic_list;
>   }
>   
> +static bool cyclic_is_registered(const struct cyclic_info *cyclic)
> +{
> +	const struct cyclic_info *c;
> +
> +	hlist_for_each_entry(c, cyclic_get_list(), list) {
> +		if (c == cyclic)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
>   		     uint64_t delay_us, const char *name)
>   {
> @@ -43,6 +55,9 @@ void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
>   
>   void cyclic_unregister(struct cyclic_info *cyclic)
>   {
> +	if (!cyclic_is_registered(cyclic))
> +		return;
> +
>   	hlist_del(&cyclic->list);
>   }
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

