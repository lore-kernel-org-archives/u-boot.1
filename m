Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF9AD3E77D
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 22:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F84588E96;
	Tue,  5 Nov 2024 23:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VA9XdX3J";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CyxfUxTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D394288FD2; Tue,  5 Nov 2024 23:57:06 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A999488E74
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 23:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XjkHN33L9z9sp2;
 Tue,  5 Nov 2024 23:57:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730847424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2frTt0GKL2sCNQIvivVB/Lyg/5LeVqy6wgNEvSajXwk=;
 b=VA9XdX3JIOhKfgpMRKVjcOrgawJG/Sad0/BlGU3dUqppL+5pNVpoaBPO2p9uR+Q0kZHLWd
 dUHTvkv3y+gd7aASVPWeNMf0IbdwLHknuNItQKZ3BZygj4HbJkCa+LJrzCTJKv+pzgEoY2
 N1w67mYcUJgF/9lZSFfNp0cU2DoezEairoTZ2APvycAOEGgjpmrRrnaAhJ+sThl+d4hWcs
 034C5Fus4SOgRM5WUKuFJ+6I5YZWiHP/IYNv9sK2LUgCS5KuQEHtCMkvnQ3+TWrsePQusm
 6VjeCnkv9pYE08UH5fqrex6IEAxgZl6EqqNJiSwZmwelmgSAdF02XzviWH4A0g==
Message-ID: <a3ad60cd-c8f4-4377-a30f-80f1530313eb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730847422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2frTt0GKL2sCNQIvivVB/Lyg/5LeVqy6wgNEvSajXwk=;
 b=CyxfUxTlZotnBvl2ZUPiPFJykiylH/vW4upnkMXfkwDlBxgRGd/P9aw1XLG/qSiBzwSx4u
 bDXo8Tg1ZI+TC3bb9J22GXEc5AxxtM/31ig23HeMLLlatSAY7xo4vKUUXHU3GfUjz/Wc8B
 gq6/HtLDrzf6InX2/o2tj35y+EFHwo5+r/Oq1F8M6x7Pa4T8fkq+0adacJuUON9Zxmxjuz
 Ab1n0/qrueW6wuiDmqCZq8CJA0FS3MDw0rVp/6RCZnrzlNdUNLhWI3PockrXpEwkWlYoic
 wbkVswRxBdXEvwiIOVKKNJcFFWNyehsEapSMDn7NhdSwZwZMs3dC1/Z3oEKrtg==
Date: Tue, 5 Nov 2024 23:57:00 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] boot: image-board: Mismatch a type between variable and
 return value
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, marek.vasut+renesas@mailbox.org,
 laurent.pinchart@ideasonboard.com, m.szyprowski@samsung.com
References: <CGME20241105221151epcas1p2096fdad52d8b4977f707e4b1b3a47849@epcas1p2.samsung.com>
 <20241105221149.507119-1-jh80.chung@samsung.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241105221149.507119-1-jh80.chung@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2d3d5371bd5ae117f67
X-MBO-RS-META: 3tpzuujasgt3wkyudyazt544xwwr7qfr
X-Rspamd-Queue-Id: 4XjkHN33L9z9sp2
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

On 11/5/24 11:11 PM, Jaehoon Chung wrote:
> phys_addr_t can be used unsigned long long type with CONFIG_PHYS_64BIT.
> But hextoul() is always returning to unsigned long. It can be assigned
> to unexpected value. To avoid wrong behavior, change from hextoul() to
> simple_strtoull().
> 
> Fixes: a4df06e41fa2 ("boot: fdt: Change type of env_get_bootm_low() to phys_addr_t")

Looking at:

7e5f460ec457 ("global: Convert simple_strtoul() with hex to hextoul()")

do you have to update any of the other hextoul() calls too ?

Maybe we need hextoull() ?

> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>   boot/image-board.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/boot/image-board.c b/boot/image-board.c
> index 1757e5816d84..977343a8995c 100644
> --- a/boot/image-board.c
> +++ b/boot/image-board.c
> @@ -547,7 +547,7 @@ int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
>   		/* a value of "no" or a similar string will act like 0,
>   		 * turning the "load high" feature off. This is intentional.
>   		 */
> -		initrd_high = hextoul(s, NULL);
> +		initrd_high = simple_strtoull(s, NULL, 16);
>   		if (initrd_high == ~0)
>   			initrd_copy_to_ram = 0;
>   	} else {


