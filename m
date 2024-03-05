Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888FAC54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 18:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C81EF8809A;
	Tue,  5 Mar 2024 19:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=georgemail.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=georgemail.eu header.i=@georgemail.eu header.b="NwXUT61M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 757EA87D07; Tue,  5 Mar 2024 17:40:47 +0100 (CET)
Received: from smtp6.goneo.de (smtp6.goneo.de [IPv6:2001:1640:5::8:31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D0B68809D
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 17:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=georgemail.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leon@georgemail.eu
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp6.goneo.de (Postfix) with ESMTPS id 4A862240AB2;
 Tue,  5 Mar 2024 17:40:44 +0100 (CET)
Received: from hub2.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPS id A88CA240891;
 Tue,  5 Mar 2024 17:40:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgemail.eu;
 s=DKIM001; t=1709656842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3qejo66E1CJbP91QD98CyzSF9skD+pGzPz/VYks72g0=;
 b=NwXUT61MPAxEoDxJnmZURh6I6uNidv5Jk5mZ4GONp8DZeeZBezcH5P5vLKk4BaUpO8JHhx
 G/s4f5N5ulukuiWRIkZUzRIDwysOV02TlZpl6zjTKKhlvb3h80Z0hwzhw+xaL2Zrx5jW6s
 dTFuLKv9iMysMmQmPDawIvug9Ral1fYZxDMCV7cTCIf4fMJhP40D/T6nLxTrOhyh6JP5hf
 lVkLGcZ9w44uxtHEWWeBT5G9LliEWHcDYGQ29Umkkg5g34XF05XBTZ0aYXkzdaufQHEhQN
 LBoXzkmIKP7HzWYhNOXiLR6+hbqaL5pGDyQP3mxIeXPaHHCc7hZ93NIrNxs3yw==
Received: from couch-potassium (unknown
 [IPv6:2a02:8071:5250:1240:f4e6:f6d2:6d95:e0c4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPSA id 676122403D5;
 Tue,  5 Mar 2024 17:40:42 +0100 (CET)
Date: Tue, 5 Mar 2024 17:40:41 +0100
From: Leon Busch-George <leon@georgemail.eu>
To: u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v2] Makefile: use shell to calculate map_size
Message-ID: <20240305174041.55666d62@couch-potassium>
In-Reply-To: <20240304203909.63796-1-leon@georgemail.de>
References: <20240302131728.148251-1-leon@georgemail.de>
 <20240304203909.63796-1-leon@georgemail.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-UID: c29373
X-Rspamd-UID: fb2000
X-Mailman-Approved-At: Tue, 05 Mar 2024 19:10:25 +0100
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

A colleague made me aware that the '[ -n "$$end" ]' is not necessary since 'read' already returns an exit code.

v3 inc

On Mon,  4 Mar 2024 21:38:56 +0100
"Leon M. Busch-George" <leon@georgemail.de> wrote:

> From: "Leon M. Busch-George" <leon@georgemail.eu>
> 
> The error message "bc: command not found" is easily missed since the
> build continues.
> bc is not a part of coreutils or base-devel. POSIX sh can also do the
> calculation.
> 
> Signed-off-by: Leon M. Busch-George <leon@georgemail.eu>
> ---
>  Makefile | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index a2bc9d5903..e8e794368e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1275,10 +1275,15 @@ OBJCOPYFLAGS_u-boot-nodtb.bin := -O binary \
>  binary_size_check: u-boot-nodtb.bin FORCE
>  	@file_size=$(shell wc -c u-boot-nodtb.bin | awk '{print
> $$1}') ; \ map_size=$(shell cat u-boot.map | \
> -		awk '/_image_copy_start/ {start = $$1}
> /_image_binary_end/ {end = $$1} END {if (start != "" && end != "")
> print "ibase=16; " toupper(end) " - " toupper(start)}' \
> -		| sed 's/0X//g' \
> -		| bc); \
> -	if [ "" != "$$map_size" ]; then \
> +		awk ' \
> +			/_image_copy_start/ { start = $$1 } \
> +			/_image_binary_end/ { end = $$1 } \
> +			END { \
> +				if (start != "" && end != "") \
> +					print end " " start; \
> +			}' \
> +		| sh -c 'read end start; [ -n "$$end" ] && echo
> $$((end - start))'); \
> +	if [ -n "$$map_size" ]; then \
>  		if test $$map_size -ne $$file_size; then \
>  			echo "u-boot.map shows a binary size of
> $$map_size" >&2 ; \ echo "  but u-boot-nodtb.bin shows $$file_size"
> >&2 ; \

