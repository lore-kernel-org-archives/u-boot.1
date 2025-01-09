Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D49E7719B
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 07:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFFFB800D0;
	Thu,  9 Jan 2025 08:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736409461;
	bh=6hVI0NOCdhUbWvC69eAhzn5LMe4LdNvHqYrFK4+zQG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zw02LCYTsTqg5A6ZeokBOVmjWLXdmI+cFrahZ2Z0MkkK6DhjmYVulktxClX0XaV6r
	 ecLzmDLBPPSk95a+l6PLUUYdj/JtYJi+lI0DRa55lrgVXmEx+Np4PwIuyliFJKLA2u
	 0lhnvsYGTHS6t8+FDPP0B0rcx+I3rT58ZqvXsnH5qKDMsAaQJ1RKxBqdErnQ0LoSHa
	 06S4v+/kUVE0Za9+9Aki7VUQ9DdXoXr5dTWs5JBCNHfEcGkVBlH2uMfRPVqribEiN8
	 +zBGaCqilPicW+kwaJ4kcjDY1rTnYrHCiiX1tjXzwCskxhcuUlNcDYAUxdBdy3za5L
	 ekdKujD7eSmkA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36415801F5; Thu,  9 Jan 2025 08:57:40 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2823B80017
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 08:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4YTHFV6FR3z9tMt;
 Thu,  9 Jan 2025 08:57:34 +0100 (CET)
Message-ID: <db64ad14-b7b7-4143-8c0b-597f08e7c0df@denx.de>
Date: Thu, 9 Jan 2025 08:57:33 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] cyclic: Fix typo in struct cyclic_info description
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Devarsh Thakkar <devarsht@ti.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250108150940.558671-1-patrice.chotard@foss.st.com>
 <20250108150940.558671-2-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250108150940.558671-2-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4YTHFV6FR3z9tMt
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

On 08.01.25 16:09, Patrice Chotard wrote:
> Replace delay_ns by delay_us which is the field name used into
> struct cyclic_info.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
>   include/cyclic.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/cyclic.h b/include/cyclic.h
> index c6c463d68e9..56190db0599 100644
> --- a/include/cyclic.h
> +++ b/include/cyclic.h
> @@ -20,7 +20,7 @@
>    *
>    * @func: Function to call periodically
>    * @name: Name of the cyclic function, e.g. shown in the commands
> - * @delay_ns: Delay is ns after which this function shall get executed
> + * @delay_us: Delay is ns after which this function shall get executed

The comment still references "ns" above. No need to re-send, I can
change this when committing.

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

