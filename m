Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9124660A3821
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jjv12hB8;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=HThsJu2J
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 100D180DC2;
	Tue,  3 Nov 2026 16:42:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K5jAshgisd5O; Tue,  3 Nov 2026 16:42:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B0EB180CB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793724126;
	b=seaGtNorvXEhHq+rO2CKBlgZWjzFzPreZJWObZMEHcCrmAcfXkw3cYFbKqenZb9gXuNT
	 CjWZiyo1xZBv+EomX7qbSlqlfxAG32mi8xK+Lt0Xz50EUh8NfXyaomBMXWrj0HEE9X+D0
	 KCKThVdo/EVAMYaTWD3WvsWSxzNh57i5Qq6XS4Gb3L83zvKHyDG1WPUPS09EnHBstFG5S
	 4wl34Vt5ey5rDbhE2RMzNSGdiYv29KBCSd4vJgOv9bobpIbljKn77Ujghra6CEAkvPQcW
	 4OrW7Zou6rxPQby88FJH/JQk4Utr4UeJSnj8vjN04S2VFYdKbAAhhGv2/9igJDOZgsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793724126;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=38iGRtw9N7X7QK564Q3f7bMhbVH4HRVt5irQ1DOYeyM=;
	b=d2cCy1voaTXwMWFHfzGyKUjjFYNW51cYxPPElBpCvj7efEgzBfqjCqySAocjE0s4wN9d
	 qKnBI43Aj1NUUBaE3BE/gs/2baBbcByh7i7y7YqGAUnCoEsCsw7PsvJI/lK2YKELaeu5x
	 5+vs/acXRrZV8vaZx0GiXyImIXSzYtWfuDeU/tsMUDUbDVHSMAAAGRdg3A3QJWlAB7/QR
	 fkGss2eC0K7ddrV0CHIHLR0gsSxernf3zNODxo9mg2+GuunWsT37bfS8+RkBh60dfOP1S
	 gs/Z50cYWBrXQ3C4r7jmIeMHYUEaeOPHM5TpAsqKw14jSR9C8gFutmKR/QKiD1/WZ3Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793724126;
	bh=38iGRtw9N7X7QK564Q3f7bMhbVH4HRVt5irQ1DOYeyM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jjv12hB8rAetw0GupsEcbhEHJpXhQ8McaLpIW2jUwx5fki/a/I8z4eY1hQq4SaryR
	 ASjzL5m4/8el7jpVKZZHgYqxUhA+p7GhKhIvKWSfsapIG0HvZia43AYFYHE8KxH2jl
	 yH4iIQ9o3B7AN8TsEcso9P9XfBsX0VSiM56NOOmOVNs0+TLEwtnV5laJGF4AhPqIy4
	 uOJEjjg4CVRiOLQZV6kOiGM1nBrKGkIfFnsh9NlmDhpECYY/NtDRgzDDWkaF84wmEP
	 ngiOjgQST9cRa+NHhPpg7EumsOJQ5IYq2hMN5fxpUIkMcC4As1yuGeYOIQKvFNSr6T
	 IzwlEZi+Iikow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0EB180CB0;
	Tue,  3 Nov 2026 16:42:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B33A356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C53D40068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:42:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5PlTqO1Tq4ka for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:42:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2C94640062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793724123;
 b=rFhGt/IFBfMOp8Rwxsj4H8Jb0aTw1kNtR/aTUY//NpwhMkDsyi5W5MQLK7oq25MrMPmy
 dTkd+d3idbA4Se+hGs5YlkxrTlRf8VwBVO9HKH2uSkCYBYxBm1loiY+pXYwXuo7TQhZCE
 7lYhLuxsSUFgEIqAJJW4+vSnMlvO9NRP0JraYEdilr1dOBohXTl7hyYYLVPj9x9C0xNWK
 5agBiM0gByJTaBI4bJsZ0u2nQOICyVNyYOWBOKWfWKDmR1xN8Vngy82GTJlhdITmzj1sh
 /D5fTok518ewzw6PdxGBk9o0ZqG9KVD2cy+UF+/dMswhqGgExIMkdF3zmRu788oMAqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793724123;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=38iGRtw9N7X7QK564Q3f7bMhbVH4HRVt5irQ1DOYeyM=;
 b=gEIG16CsISQS1YGRAGvl41Mzzp+WwrMnRMjSq3f7GDJbojr4CV/dRSlXOR5rC6t0wfeg
 SvcLKzCTqMu8GxU++WLX3UUWQxQcHLBIVHoaN+ZYJ3JMGANKQk3gDoNUieJwgSQU3oATO
 ZMHZuDhHER9M78lCQCtzFoNM8dEn+fJXSna/6KbwObIpgkkqdZAiJ8Av2lrl1cmsM9Z5g
 8tROiqZVYgyDs+8flRTjveGo4RZvJGkR7UxhjHmN/SqjCam2ankAPbZzypLXnHjGxYaAf
 CSy4If56vcFEn3VRORSN6gK0+2UUueybrFiBnkK/ixvZYD3khccETSim+ol+juJ+2rw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=HThsJu2J; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=HThsJu2J
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C94640062
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793724110;
 bh=38iGRtw9N7X7QK564Q3f7bMhbVH4HRVt5irQ1DOYeyM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HThsJu2JVkf2G7vvDhGFWHKanV6h7LtTeR2FzjmOR2x5a+7UMCWXPZ7Y4jK5PgHf7
 F9cxMWVJCh18mr1egep/m4kLWfsyFUVtY1QO/iekGep7K6+9UF/wmiWWZ2uv8wAmSh
 XAOzduaCHrkXF2tVXtCnxsKe0vD/Aj18LmLKCGXO9EI8ICxvyWMWNIEcGQU5fz8UR8
 YgsiVSEg1YEJsK0P91EpZm6uhTVOEZ3D0xafrqr2MM8iGQ0BBbA0WRe6g2GwugPLy6
 s84sLoK91/00VRJluX+hGFNpKyJkk6RLXcIZgZNcbfS2kdWYepsmRlXv1CgKJ1brzv
 ryeDnzmfQC6Ww==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 96153B2202DB;
 Tue,  3 Nov 2026 17:41:48 +0100 (CET)
Message-ID: <5b2c35e1-8dff-44fa-9f3b-81f0fca530b5@freeshell.de>
Date: Tue, 3 Nov 2026 08:41:41 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] test: spl: Zero spl_image_info
To: Nikita Shubin <nikita.shubin@maquefel.me>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, Francesco Valla
 <francesco@valla.it>, Anton Ivanov <anton@binarly.io>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
 <20261103-riscv-full-fit-support-v3-4-e1dcdc9638e5@maquefel.me>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261103-riscv-full-fit-support-v3-4-e1dcdc9638e5@maquefel.me>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Nikita,

On 11/3/26 01:53, Nikita Shubin wrote:
> The next patch makes spl_load_fit_image() check spl_image->fdt_addr and

What is "The next patch" is it this patch? or the next one that is not
this one... confusing. The whole description could instead be
"Zero-initialize spl_image_info on the stack in preparation for any
writes to spl_image->fdt_addr" or however this is.

The "next" patch will appear in git history and explain further.

> write the loadables into that FDT. With an uninitialised spl_image_info
> on the stack this could end up writing to a random address.
> 
> Use memset() to make sure spl_image_info is initialised before passing
> it, as board_init_r() does.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  test/image/spl_load_os.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
> index ba9d7979a09..e2b55d66394 100644
> --- a/test/image/spl_load_os.c
> +++ b/test/image/spl_load_os.c
> @@ -15,6 +15,7 @@ static int spl_test_load(struct unit_test_state *uts)
>  	struct spl_image_info image;
>  	char fname[256];
>  
> +	memset(&image, 0, sizeof(image));
>  	ut_assertok(sandbox_spl_load_fit(fname, sizeof(fname), &image));
>  
>  	return 0;
> @@ -26,6 +27,7 @@ static int spl_test_load_fit_full(struct unit_test_state *uts)
>  	struct spl_image_info image;
>  	char fname[256];
>  
> +	memset(&image, 0, sizeof(image));
>  	ut_assertok(sandbox_spl_load_fit_full(fname, sizeof(fname), &image));
>  
>  	return 0;
> 

-E
