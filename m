Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941A0D3CCA1
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 08:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB45380325;
	Thu, 15 Jan 2026 09:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aJTeM1FQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2824082BF2; Thu, 15 Jan 2026 09:24:05 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA0580077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 09:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 88506441EB;
 Thu, 15 Jan 2026 08:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E32C19424;
 Thu, 15 Jan 2026 08:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768465441;
 bh=+QxslZZxTMR1S84NLYA2+zyBXqQpXxAB5sB8cAKl/do=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=aJTeM1FQj53w/ZJowzt86ZAFolyztOM/l4j8h3KL+BsF8pK8yKv57fR7e2q/Y4LII
 K3o2jbFeUn13hmR1ApYqJGN3ZgeW4CnVtzY89p07zAkd+7C1lZeOjG/vOBecPcWrFt
 F2CKc0UaSMzuHBe2qrwGKG8K+PFJl/MqO0Z8jP5QcTmY6isJOukTcCfLNiWJlvl7H4
 6CP/+pW/1en+lwdcSC6/T0hbPopY3CpVF4AmU1sUsTFySUyn83UvS8R+9pcSIKQJxG
 s4bLamzuUs3/Omlcwn5OpvDCo3xiRa7SxMlJOStYvlMimlqQtF5hzGwjN1xM2Amrfy
 58/7Hv1gawahA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] bootstd: android: Add missing free in
 android_read_bootflow
In-Reply-To: <BESP194MB28052734FD0361EA602F6360DA8FA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB28052734FD0361EA602F6360DA8FA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 15 Jan 2026 09:23:58 +0100
Message-ID: <87bjivffmp.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Francois,

Thank you for the patch.

On Wed, Jan 14, 2026 at 10:14, Francois Berder <fberder@outlook.fr> wrote:

> If strdup call fails, one needs to free priv variable.
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>

Good catch! Thanks for the fix.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  boot/bootmeth_android.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 1374551dbeb..1d70e8d5c05 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -252,8 +252,10 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>  		priv->boot_mode = ANDROID_BOOT_MODE_NORMAL;
>  		bflow->os_name = strdup("Android");
>  	}
> -	if (!bflow->os_name)
> +	if (!bflow->os_name) {
> +		free(priv);
>  		return log_msg_ret("os", -ENOMEM);
> +	}
>  
>  	if (priv->boot_mode == ANDROID_BOOT_MODE_BOOTLOADER) {
>  		/* Clear BCB */
> -- 
> 2.43.0
