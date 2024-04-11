Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DD3CD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 02:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9247088149;
	Thu, 11 Apr 2024 04:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UmW9NlaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1844F8816C; Thu, 11 Apr 2024 04:42:11 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03239865D0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 04:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6964b1c529cso54814746d6.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712803328; x=1713408128; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PsEaIPXEAsLbV/VgWFeGRtvVM0PrzJqqYnte6mqBg9k=;
 b=UmW9NlaRFyq/3x7f+uV8VoAJmYy1YKODPBg27UvHQxFlogyqgR7FxVV/GXKHX4CeiA
 CGmMZSrb+D5+Qw08oQWJIpQ5N8StRGR6BbYcDYEFeF0Rhi5veUGx6GZ2+drW5X8QtY/g
 YMpRv31YyBaARHyUdEZsLSvZO3QaJYQpXpd3ASVokPZBiq2yVE06yXEG7jHJMe9syu+p
 ggr9ZIFsgE4CQ2NbekhcQLX2L0H2/pidqE44PFtYky+1ckGYkUdMTBLGQkGqeY5A0S2D
 7NOB2QI5DEcsexvYL1F7OofXCiwB9KxCrhgfIBLqLyxBygAPxIOcW5z4xxwUmA8Rg7nl
 fzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712803328; x=1713408128;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PsEaIPXEAsLbV/VgWFeGRtvVM0PrzJqqYnte6mqBg9k=;
 b=gR81cAUXCMEPs1p6B2C4958GsPimLuJ5S1NM059Y7kAp+gqjzxPuCUqRURJgMvvkcg
 tJixhF9us7RxL0cXtDpoMyv8U7f8fBXG4tV+naQ+58Ulu5XZAXnS6bxBWQmVHvapmtK5
 6BkV5f0nYDLu8fpereHy3Ts7/3acaxqnLBwxZDbVTm6Tn+obytBdZu6oibpN1bdZYcnF
 Id1/S6flG4B9uw6hMUgdTu5RcVoR3QoRuwzybZZIb5hrQ+tDYWsRvjxLygambQhX5QTF
 sgczI5AffpN+NudwrS2/YXRVUAAKqleNvAUU34BCE+uw4ZihVOWCqtXl7wWv4KcKSlzk
 t+2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8SatFGszfj5TR0LTyQO3jR9gUja1dr7rjvdBqMbM+ya1z+r4ac+J7iLXhMM97wJXLsIm07njQx5Wq5BguUsmSpO0/uQ==
X-Gm-Message-State: AOJu0YwSJW4o9hCjLIMWAqQoEJgrbTRE0G09D23TSaAp3pjnPUH4d1v0
 be6Aimbnog60OeInOQP3xt445OFzhgtz4ylZr9AnFroG3oraQlUqauHolQ==
X-Google-Smtp-Source: AGHT+IGFFv9xisNUU0KckI+kQ424703+gr2z7VMQMWwGrhRM46dKUtTJN73lPDY3SGjxg/Vwn9KFCA==
X-Received: by 2002:a05:6214:1c46:b0:69b:1056:242d with SMTP id
 if6-20020a0562141c4600b0069b1056242dmr5507555qvb.30.1712803327864; 
 Wed, 10 Apr 2024 19:42:07 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 l2-20020ad44082000000b0069942271b41sm345777qvp.24.2024.04.10.19.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 19:42:07 -0700 (PDT)
Message-ID: <566997e4-a429-5bd7-6e5f-26e19700786c@gmail.com>
Date: Wed, 10 Apr 2024 22:42:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] sandbox: use sane access rights for files
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Mike Frysinger <vapier@gentoo.org>,
 u-boot@lists.denx.de
References: <20240410083828.20650-1-heinrich.schuchardt@canonical.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240410083828.20650-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/10/24 04:38, Heinrich Schuchardt wrote:
> When writing an executable, allowing other users to modify it introduces
> a security issue.
> 
> Generally we should avoid giving other users write access to our files by
> default.
> 
> Replace chmod(777) by chmod(755) and chmod(644).
> 
> Fixes: 47f5fcfb4169 ("sandbox: Add os_jump_to_image() to run another executable")
> Fixes: d9165153caea ("sandbox: add flags for open() call")
> Fixes: 5c2859cdc302 ("sandbox: Allow reading/writing of RAM buffer")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   arch/sandbox/cpu/os.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
> index cbae5109e85..1cf41578010 100644
> --- a/arch/sandbox/cpu/os.c
> +++ b/arch/sandbox/cpu/os.c
> @@ -109,7 +109,7 @@ int os_open(const char *pathname, int os_flags)
>   	 */
>   	flags |= O_CLOEXEC;
>   
> -	return open(pathname, flags, 0777);
> +	return open(pathname, flags, 0644);
>   }
>   
>   int os_close(int fd)
> @@ -746,7 +746,7 @@ int os_write_ram_buf(const char *fname)
>   	struct sandbox_state *state = state_get_current();
>   	int fd, ret;
>   
> -	fd = open(fname, O_CREAT | O_WRONLY, 0777);
> +	fd = open(fname, O_CREAT | O_WRONLY, 0644);
>   	if (fd < 0)
>   		return -ENOENT;
>   	ret = write(fd, state->ram_buf, state->ram_size);
> @@ -791,7 +791,7 @@ static int make_exec(char *fname, const void *data, int size)
>   	if (write(fd, data, size) < 0)
>   		return -EIO;
>   	close(fd);
> -	if (chmod(fname, 0777))
> +	if (chmod(fname, 0755))
>   		return -ENOEXEC;
>   
>   	return 0;

Reviewed-by: Sean Anderson <seanga2@gmail.com>
