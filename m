Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEEDC4829A
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 03:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3870987DCA;
	Wed, 14 Feb 2024 04:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="JqQ4rg0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72DAB87D8B; Wed, 14 Feb 2024 04:48:57 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D16B87DD3
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 04:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707882532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z/0/XU8v7O7K5HmdlLs/5LnTFJe0QksvMn8PC4W3c7Q=;
 b=JqQ4rg0K95VZJmW6WIGYSlVfkUPFonKswTRwR6hw1+gounUqNLi5sFeAdbkU8TbYW75hA/
 PHCBMb/iZ4VTNw3ZKIT3MLt5clW9+7p+V7C4tnZNNIMFcQZvBDlpZY98LoOs2kxFlwUkse
 2gHm0xAeXAp3UGPZVkmiiBPZLOmqM4RjvURoWDa1NEfEOV4vgfYIIo/lDSeGYgQ5ISalmx
 As6+8EjDarlgbgggLhZE63zk2E+KU6jxwf95vjihqF15ZhGgbW9ZK06cXVZGqVYTEutSVu
 EdJlpir4ctc1hJ0ZSeYLvxgMeheIttQ//UJ9M6NKFaptoTlbZxyJLa5dAYQ1og==
Date: Wed, 14 Feb 2024 04:48:52 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, martin@geanix.com, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v2] scripts: dtc-version: Don't show error messages
In-Reply-To: <5ece6e37de9321ad1c2e089659cbd80355181c4a.1707217112.git.dsimic@manjaro.org>
References: <5ece6e37de9321ad1c2e089659cbd80355181c4a.1707217112.git.dsimic@manjaro.org>
Message-ID: <3baedbe13804025441547b23949bede9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-02-06 12:00, Dragan Simic wrote:
> Prevent the error messages produced by which(1), such as the one quoted
> below, from being visible in the build outputs.
> 
>     which: no dtc in (./scripts/dtc)
> 
> This makes the build outputs look a tiny bit cleaner.

Just checking, is there something that prevents this patch from
becoming merged?

> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
> 
> Notes:
>     Version 2 incorporates the suggestion from Quentin to use a more 
> compact
>     version of the redirection, which is already used in multiple 
> places.
>     The original motivation to use the more verbose version was to 
> prevent
>     possible issues with some shells, or with some older shell 
> versions, which
>     may not recognize the compact version.
> 
>  scripts/dtc-version.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/dtc-version.sh b/scripts/dtc-version.sh
> index 53ff868bcdce..18c59ac1e255 100755
> --- a/scripts/dtc-version.sh
> +++ b/scripts/dtc-version.sh
> @@ -15,7 +15,7 @@ if [ ${#dtc} -eq 0 ]; then
>  	exit 1
>  fi
> 
> -if ! which $dtc >/dev/null ; then
> +if ! which $dtc > /dev/null 2>&1 ; then
>  	echo "Error: Cannot find dtc: $dtc"
>  	exit 1
>  fi
