Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762F7C5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 21:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B167187DDE;
	Sat,  2 Mar 2024 22:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="p4jlOFJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD65E87D65; Sat,  2 Mar 2024 22:13:12 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7718387E3A
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 22:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1709413988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MpaYKopYNtfEdtPM7MLhHfiFRF/NHk56oiEcLb+fSwc=;
 b=p4jlOFJJh2pqx6sbThCf4FImu/mVR5DQS4uQLe66Y7w6mouJC0scL+bCAWs3EyqEfgYE5/
 W6LtSr9FB+bX0HVMIkjUwEa03mKOaGl0M9hjDt8v+WjrA6r03ADeQQDk6s0R/yiz9SvC0b
 gRYZHJo73sazCnEXuFwiMUEVETr0d8HfMFhqfFmUkLnnW9Calrmo3sGE9HgbLgWMBJzyhY
 hmGM5/LkXc+hnyhrwGS5mr3Xyw09XtBZRxk9Y2gOGB0Hb6tvCUgXMbHqiBdNNoWGFst5w0
 YSpPncArlTwy8no4iU9rSwgQEE/xOu5F4nu8aeeV1lkqvnJqOjV/kL/GCprIBw==
Date: Sat, 02 Mar 2024 22:13:08 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: "Leon M. Busch-George" <leon@georgemail.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Makefile: use shell to calculate map_size
In-Reply-To: <20240302131728.148251-1-leon@georgemail.de>
References: <20240302131728.148251-1-leon@georgemail.de>
Message-ID: <f27f49c04e7c4dca0112003e44bd9814@manjaro.org>
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

Hello Leon,

On 2024-03-02 14:17, Leon M. Busch-George wrote:
> From: "Leon M. Busch-George" <leon@georgemail.eu>
> 
> The error message "bc: command not found" is easily missed since the
> build continues.
> bc is not a part of coreutils or base-devel. POSIX sh can also do the
> calculation.
> 
> Signed-off-by: Leon M. Busch-George <leon@georgemail.eu>

Please, see a nitpick below.  Otherwise, the patch is looking
good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 7a3209bd9e..41dc4baad2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1275,9 +1275,9 @@ OBJCOPYFLAGS_u-boot-nodtb.bin := -O binary \
>  binary_size_check: u-boot-nodtb.bin FORCE
>  	@file_size=$(shell wc -c u-boot-nodtb.bin | awk '{print $$1}') ; \
>  	map_size=$(shell cat u-boot.map | \
> -		awk '/_image_copy_start/ {start = $$1} /_image_binary_end/ {end =
> $$1} END {if (start != "" && end != "") print "ibase=16; "
> toupper(end) " - " toupper(start)}' \
> +		awk '/_image_copy_start/ {start = $$1} /_image_binary_end/ {end =
> $$1} END {if (start != "" && end != "") print "echo $$((0x"
> toupper(end) " - 0x" toupper(start) "))"}' \
>  		| sed 's/0X//g' \
> -		| bc); \
> +		| sh); \

Maybe "sh -s" could be used instead, just for some additional
strictness.

>  	if [ "" != "$$map_size" ]; then \
>  		if test $$map_size -ne $$file_size; then \
>  			echo "u-boot.map shows a binary size of $$map_size" >&2 ; \
