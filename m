Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192CFE77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 07:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D7EA80600;
	Thu,  9 Jan 2025 08:56:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736409401;
	bh=yIfBuAQ6gmStr5ps/gr2hUX8ZkWrMUQGVdnBkwTdkc8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ADKpFgGFhew/K3rugklfKm2xE89dA6KncVnXwjv/SH3Y69kfqjwgkqdGRVkDonLUy
	 qy1lyelB0huWyzzUeOvcA4F5OfbVCCy1MhPFVCHc2FLgZ8uPYJTKLVFXZl+VmOvPTG
	 0sCR8TkxwVHUoGeQzfa5vJdPXeqR/RA03DUkpgVI4aZ5s1lKvx/M2T4MSPCAejJgcN
	 WOlQFkZJ8skMo8VJWLwyGmpPFD7dqG8d940HS5CjocMV6hN7URhx+bi9nW5GEc4qEb
	 clhusna7rzbBmMiUZtlZUDeaDgSeMvr6Td7CtOUokeir3Zgtg3dOAB0xRDa+OOe4gy
	 Z3rFsR/oUP6QQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A4E801F5; Thu,  9 Jan 2025 08:56:40 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1421580600
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 08:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4YTHDM5XSpz9sV6;
 Thu,  9 Jan 2025 08:56:35 +0100 (CET)
Message-ID: <ef52a3dd-3851-44e8-878e-09c10265ff7b@denx.de>
Date: Thu, 9 Jan 2025 08:56:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] cyclic: Fix rollover every 72 min on 32 bits platforms
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250108150940.558671-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250108150940.558671-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4YTHDM5XSpz9sV6
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
> On 32 bits platforms, timer_get_us() returns an unsigned long which
> is a 32 bits. timer_get_us() wraps around every 72 minutes
> (2 ^ 32 / 1000000 =~ 4295 sec =~ 72 min).
> 
> So the test "if time_after_eq64(now, cyclic->next_call)" is no more
> true when cyclic->next_call becomes above 32 bits max value (4294967295).
> 
> At this point after 72 min, no more cyclic function are
> executed included watchdog one.
> 
> Instead of using timer_get_us(), use get_timer_us() which returns a
> uint64_t, this allows a rollover every 584942 years.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
>   common/cyclic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/cyclic.c b/common/cyclic.c
> index 196797fd61e..e3f03a19d55 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -61,7 +61,7 @@ static void cyclic_run(void)
>   		 * Check if this cyclic function needs to get called, e.g.
>   		 * do not call the cyclic func too often
>   		 */
> -		now = timer_get_us();
> +		now = get_timer_us(0);
>   		if (time_after_eq64(now, cyclic->next_call)) {
>   			/* Call cyclic function and account it's cpu-time */
>   			cyclic->next_call = now + cyclic->delay_us;

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

