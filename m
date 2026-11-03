Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB51606C561
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yREb7/mX;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ry2h17ZR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C3EF404EB;
	Tue,  3 Nov 2026 10:09:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id we-MRmY_z_W4; Tue,  3 Nov 2026 10:09:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 57A42405C9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793700590;
	b=qmecLM/Hsw6Oo2wly+BWfDoEGWLRZptzJxN5D0oCt67zKyhyQWLeJfp6Np8cuzmN+wxO
	 t4kETGf6eOaS9KWoFCMa9TZTHtJvhP7A0OlO7Vm5k142o72ZMNWHLs03zCGnyqRflY0gJ
	 1qHcUUJo6RNVV5ucWSoPdfZshxm5wLu/1lt50+VFfYL4KxDcc5DhxXpn31MBeVHbWTzjz
	 fx+w5QhqQjJf/u0prbdXQx7VvW48+OwHftRgjjtmq2xVXxq29lrIb7Yltr5BRIFdQfOxL
	 kk6DtNFimBeYHG9GiURPysjHyFNYYjZwo26Yr9CUsAjRjaWAqo6+uvtL8OxyHecGQZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793700590;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=562skWyxtJqcf0cg1QGirZ/LPr1Mld+Zox6yNoX+3OU=;
	b=iHi3nDRu5Gt7OMQleAo9C/PkS6n3KQFrEkO9J8lYy0hHDe2+PwkDbopLqsl46r3Q0cz+
	 Lbu3hQleDkOveEJo78zVZ28lYIGPgD5RjoG03OVdegqBLubbVL066XkjRawrnvKL4eSQJ
	 uBOzoyw5AaFWXt9eHBfzGSwNFJdo3E2euLXRnDGKN+BDbNLp77gj4K0Nikt7oYMuK1n6c
	 Uf6FoR7b9BDp/p7Qa/HAeRVi450rkfEHxAk4aPlxlaWL8yTUwwWs+7opEy3Lg/0eF/Bqr
	 AThkXrVVoM4n2EnYbdK/Z6xl9JX0P1SbA/sxffqfJldJGmjjK6vqAnld6CO0nz+mUeg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793700590;
	bh=562skWyxtJqcf0cg1QGirZ/LPr1Mld+Zox6yNoX+3OU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yREb7/mXS8fEJv8/Yxm5oJSZdcOZMf0g4MO0q2vOyJ4vs4h20wt9oVOE2dW1IAnJe
	 oJLeXFoLWGZC0xESufBlzlm5E2MTdn/VABP9AJzp9yk2PYxSqKA33OLHuBDBBmFwxj
	 o8fhBnVC2j3NoateUI9T5f4BRRT0eoVjlNZW/6edF7El45VGF0sN8sM3V81ABCrFTl
	 Zmu1rxkA1jr+g9jlxheTd4SUueP1Oh8KkW5Hk1nlRE8LuIfnZzXU4vNa/Njn/pEiLL
	 Ssju274YUIOdfQ3Mt3naneg93G3UFi+xfFHZ0lfzoEPX9kp9TwvA+PrTJV+gqoR6J8
	 GFgllfjqw331w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57A42405C9;
	Tue,  3 Nov 2026 10:09:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 15783356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9C2840080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3D7CLYXWWvSS for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:09:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 130E94005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793700587;
 b=lx4C81rsu408a/OynXu2sGb1Y/guAdFlqlKdrzq1aPdjC+LSNBgvwtUzjhLL42Z6lXn6
 c/92YEjRf2sAGP9gZhz7AzjVEP7sE9ZwL9dQ00Hkj6eKiXUI6LtgAA/Roo7iszTe7ADXg
 U8ICQhkmATeQn4yh0RFUYnSsvsEFmho5Y4zMVdgg+FwGUtopcGViJNXd5hUjqWXYv7UfI
 zbEjHkCz0m8cZ89It6ktcPj8PHyjiuFx+JXJ0re7gYgi+HP7xa8sxyFRkG5lUBIXlMBEZ
 3bT8bPZQs2vOASKA+h+brDguAzR8gVnKByA6MFuBiBAlQYN8MXHxmM9fXEdQubm45dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793700587;
 h=Received-SPF:Received:Received:DKIM-Signature:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=562skWyxtJqcf0cg1QGirZ/LPr1Mld+Zox6yNoX+3OU=;
 b=Cvj4+HiygWnOS8DEwrOp9tNZDGfHTkVJrVP6pfqZrlfLqvxFZGJlXDLZ8EmfSLWujDU0
 08+80tPTXI+ZdK58lLB0L05VNRdtv1rWGzdyY6PJ64sQzLRhFC6oTyn8Rjb4o5ZyFvmtU
 HPzY6nbrFd8vc51HVIyz6zxyEUlUVNb83DLNLXS+WpIzrKJ4Vya5bKbeQnjF4fW3rSdp0
 oRXQvycMhevoBK24E+6yWN4pLJBUT1Y/d2ttzKreK8HVsoV0YS9VBBA1qmY3CaoXXjRNw
 tiDt2JRbp+c1ANcpIs8UU3xcpCvfke+oJIWsEbs+FqHZWWZRYArCcDE1hcTaTp4ayIw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ry2h17ZR; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Ry2h17ZR
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 130E94005E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:09:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4DB0143D3C;
 Tue,  3 Nov 2026 10:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C3E1F000C1;
 Tue,  3 Nov 2026 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793700586;
 bh=562skWyxtJqcf0cg1QGirZ/LPr1Mld+Zox6yNoX+3OU=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=Ry2h17ZR/sy812ZDeQaBX/S7Mqwbn70Ll8I1QWso1uQTdh/62GvPPyOS6jcacNWxJ
 K5IJukGFtlnYJmQL9wDS/41xBlURr0UW4YpV66IhuJjX3miXedVHT6UYBLy8P0Lvwj
 rUWksQ3IimAbdjS7SzV6cQZaoJRP0R8Se6ktG97YePu8jdX3Fy73FMg3s6l+E+q6Y9
 Bw7qsEE2sqVz4lrj4YA4Pkx+sZ91fFTBKMyBr5rQc42NcTfSH3EsiDBD7feJ5Xfrkx
 RHrcdixEkWpF6yLnc1MmGpTTHy0RZHhyjms2tA4h7nhjAabwZp/9aNlDtrt+m9nPlT
 cw+uWRl7h6i/w==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/6] spl: ram: allow loading FIT images from a supplied
 buffer
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-3-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <20261014-ccaione-upstream-spl-fastboot-boot-v1-3-d29df15fb9b8@baylibre.com>
Date: Tue, 03 Nov 2026 11:09:31 +0100
Message-Id: <179370057187.349126.11782363973041228093.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=d/SRsoIdnvPaRrJLU4ZBYybnUufobSi98txmjlmK2T0=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq6bLiK5CKcdZp6oKY60iISozUwZKv0GFDR3W7i
 kbGsmGxOyiJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCaumy4gAKCRAZDR20Zk4Z
 NXBACAC90//pvYhL8TNaVkff4De2sgyCZKhl8GWLLvqLPTyz6A0GZVfcWReJGEAiy0HZuVBnXL+
 TY89zpVGhC+njoFuzlqCvJeufnTYBGmd2Fx3S2avLF/kM14SIr3OaWdYiuR4Ls/lbtZNBtE94wS
 zaHvWxvBpl4kF7YFD1otmOQ9IpQiO63QTNb9hP2OAakzOcaGanciV+g0jfN4xa5UkmdtmojvWym
 ucpdVyL4cG9bKSW4ZDdUs0T/flUZakPmTMTeWobU2zmfmyn/5bAt9EqXVHpXhdE7iHmd0S04BM8
 Yl8ybMAtM51qbw6h1seZaYAFmWADDbnOHHYhrHyeZPsfjxBU
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Carlo,

Thank you for the patch.

> RAM FIT loading currently assumes a configured image address. Downloaded
> images need the same loader with a caller-provided buffer and length so
> reads cannot run beyond the received data.
> 
> Expose a reusable RAM FIT loader with header validation, bounded reads
> and overlap-safe copying. Keep preloaded images working when their buffer
> size is unknown. Add tests for embedded and external FIT data.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1f51d9197d9..f464e0bd2bce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1923,5 +1923,6 @@ Q:	http://patchwork.ozlabs.org/project/uboot/list/
>  S:	Maintained
>  T:	git https://git.u-boot-project.org/u-boot/u-boot.git
>  F:	configs/tools-only_defconfig
> +F:	test/image/spl_ram.c
>  F:	*
>  F:	*/
> diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
> index 0c501cf02f28..ee588ef4718b 100644
> --- a/common/spl/spl_ram.c
> +++ b/common/spl/spl_ram.c
> @@ -16,32 +16,39 @@
>  #include <spl.h>
>  #include <linux/libfdt.h>
>  
> -static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
> +struct spl_ram_image {
> +	const void *data;
> +	size_t size;
> +};
> +
> +static ulong spl_ram_load_read(struct spl_load_info *load, ulong offset,

Why changing sector -> offset? It makes the diff more difficult to read and
as far as I understand, the callers are still passing the same argument to
this function.

>  			       ulong count, void *buf)
>  {
> -	ulong addr = 0;
> -
> -	debug("%s: sector %lx, count %lx, buf %lx\n",
> -	      __func__, sector, count, (ulong)buf);

Why is this dropped? It's not mentioned in the commit message.

Rest looks good, thanks

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
