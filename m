Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC75606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iYl7mqHo;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=NKULjhTl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C48A6073B;
	Tue, 27 Oct 2026 17:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i4pD2Klw-7m4; Tue, 27 Oct 2026 17:55:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 943A660699
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793123733;
	b=An6JabMB5fX8aLYmBvrgJZxpw0mOfxW4QyA6QS2U9pICLomGKsoijb3OY6/CmVwNjw4U
	 hbJeilMSAsDzw77ExMw5uwjJZ30jLzhqltyjjdUq9o4IpakbCxTSvxZBuGdawVHf5lTGJ
	 misD9qceMR70j3IDKLGaVDvGuVXSgA3FGwVAvorEA+ln1wBCl9e40hERQdzrbkfdTxYv5
	 R38Q2PThjptXM+GJz1QJF8xtjO1TWUVy6g/MXN36YzyKO8eIyJ9zB+yRUmRWw+uSzXjsg
	 DyZuK2dD6xNbwLmqEWT3fjUZ2SxWNkvf3qNHgRJ0T5s+UuQS0ZG9flB1viYX/ggVJWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793123733;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=koiNQXL36yrkUDvCM4kZIZT4OGobUCvP7GcTMJpY2FQ=;
	b=GCrg+qOvqaGYj6UQ/7q//z0EXbPY5ZN6n40depqChASOa3BPaLyzFrYohC/uMrIeJwN0
	 bb1TB3YjyBDvQNC+nBETf5D+o14DwvMXkQB1BBixyLzLR1BKRxI0id/WTos6EgzCKyInl
	 jSrJ+vtw9ukWzpRiEUoLZLYhBDhjN+Sdn+fV7NsTHzVtJpM+jZhAZ5jTesEcKekUQHshr
	 7yWx2Kg5f81GeAIUBcaZ4D/QkS11JVH99dZDriAF1shzJRVmS2/eoIQeUlOD3YZeExk3L
	 TqkGRQ07nYcUU48GhcdTw6mtTdbwNDuxZuETa0LANq8bZQ+UJpdREHhuurf/sHwblxw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=NKULjhTl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793123733;
	bh=koiNQXL36yrkUDvCM4kZIZT4OGobUCvP7GcTMJpY2FQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iYl7mqHotaDnGc/nNXNBs7zQEGudmeLl3x89dV4gPrtmdIRF891JcRH9hOlDxUS7I
	 22pFAPFCMakxsTpPJBQZJ3QmMg1JdysMr0PmatMLQTRGaSVfe349NE0NSnIXL7tlJn
	 W/hg428Bnf7rAA/GFtBrTuGdrXDhsncpq3xZuMQ3zoBRuXp4gHuX581a7lMJr/VMmf
	 J3+3QQcIoN3cI44aTApRpWD3W1HdCq4MsP2ZwHUJbc0ocBWAfz2lk0OJ5nfz6f9uEI
	 isxaUApU0miTruFnY/lWPHa9UMgIVgfoSvNbLJuMz2lLOeNjG4EITjtUzxKx7bHc3s
	 kXjk1TOoUFFTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 943A660699;
	Tue, 27 Oct 2026 17:55:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BE31235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21E6D60699
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FyLYgt7uovIt for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 17:55:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 51AC26068F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793123731;
 b=BdfFhNL9tWxbe8FTgxWkVhQXH2dC0nYt4bfBH84rRg1yC7P3TMef8XH4toGvlUvkqlbQ
 E5tbhdaVlKGlZG1igT5v8jwXels8KjDQpLAx+DCqyq+jSU3OssnW0UM/nh7xslBVK7ym2
 1yPMBNPCSbD0kg3et7LJXQPnZgveXDZIQlkLfztYaqjBrMABjTiJIsQNbznSD0srof4oE
 qeOtoFHJo2ZVus9gsYjyzzALh1xpTZ1M6/jbQJPfoeTGlQqo00WjxmvIMQO83CoHgXiv9
 OpSXCz9u5o5kuVZNoo+PmLhAGnqy6a2qh1Gy9pNzpFTCMq80beAJxe8dMjkwlu6mncw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793123731;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=koiNQXL36yrkUDvCM4kZIZT4OGobUCvP7GcTMJpY2FQ=;
 b=W+jOUda4zEN/Zi/1Rj19n+L4JWN3g1L4EAjdC+Cs8NC3P+ugX0SfCWsUnVvDW0WZLrUB
 dXSP0zJ1ygNVu3daU3QxBA+ZGdBts85FWmfE+vC9Cp3OHrGGe4eJsdn4VuO+vftxHpAos
 ElDsrYnto+m4A8XmXjqLSk2x0Xkc/BamxR7hqMV+dWA5jC1rwKUQPSEWULrnMZLD+kGAv
 0t1VfO8nVhqA6MD6wFvQjcCsJYzt7ufEHqLdLJoF3XOA3vk8ZXNft2veiOcWRRb6cuy50
 RY6+bnV3DSIUXKfljFqIGYN2vxdDErr/QxKps2HNhbqES+5idsxbdaghcNhqWJUma+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=NKULjhTl; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=NKULjhTl
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51AC26068F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793123714;
 bh=koiNQXL36yrkUDvCM4kZIZT4OGobUCvP7GcTMJpY2FQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NKULjhTlUWtnt6HBr7WkoeQ9SRxFt4pEEEZn0BMBkuq9p/Y2bNnlxRYXbKLFw+vFe
 S9FCFZkmj1mNlWJ61wP0onQYjB62/6kKvtJQCwY6WqpELTJWtYR6PvraxJgcElzK+P
 1VIlpTc01Lh1B65r0KsKDu8tHeOPYP8/Ohas+dUH82jf47DExQBWJ8j2dIm6qTt0wg
 6lFVKyCioaovA4xKc9/+70BmYXUVKvypnppVqaXtvSz6sF4UiBy7ATqFanYtSUDiue
 DWOMl2NQ5kqj2rYghlFBx6CY2T9PNho9Fk6LRC0mSxqFeVR9rmfNKCexFIYkwl815j
 5l6bZz+UIEsWw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 4C472B2205AC;
 Tue, 27 Oct 2026 18:55:12 +0100 (CET)
Message-ID: <c58b9c05-3c6f-433a-8333-e56ebd424e7c@freeshell.de>
Date: Tue, 27 Oct 2026 10:55:11 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spacemit: k1: initialise the EEPROM index in
 read_ddr_info()
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>
Cc: Tom Rini <trini@konsulko.com>, Guodong Xu <docular.xu@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261027154347.1392094-1-alan.tseng.cs@gmail.com>
 <20261027154347.1392094-3-alan.tseng.cs@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261027154347.1392094-3-alan.tseng.cs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 08:43, Hung-Chun Tseng wrote:
> read_ddr_info() passes i to read_tlvinfo_tlv_eeprom() as the EEPROM
> device index before giving it a value, so which device is read depends
> on whatever is on the stack. read_product_name() does the same call
> with i set to 0.
> 
> Initialise i to 0 in read_ddr_info() as well.
> 
> Fixes: 83026cf8f90b ("spacemit: k1: Add DDR firmware support to SPL")
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
>  board/spacemit/k1/spl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> index cc0e26bb0..60f5d8c56 100644
> --- a/board/spacemit/k1/spl.c
> +++ b/board/spacemit/k1/spl.c
> @@ -332,7 +332,7 @@ int read_ddr_info(struct ddr_cfg *cfg)
>  	struct tlvinfo_header *tlv_hdr;
>  	struct tlvinfo_tlv *tlv_entry;
>  	u32 size, entry_size;
> -	int ret, i;
> +	int ret, i = 0;
>  	bool found = false;
>  
>  	if (!cfg)

LGTM

Reviewed-by: E Shattow <e@freeshell.de>
