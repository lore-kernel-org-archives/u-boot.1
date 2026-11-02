Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AF60A5BFD
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DYZYJvTF;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=m/X+P8nr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A58381080;
	Mon,  2 Nov 2026 15:23:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7QiO7jEwJ240; Mon,  2 Nov 2026 15:23:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E993181090
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793633000;
	b=nGidPWRLytQMc0zyP1Jia4lRVQbOj6Up9lKLxYO1hEWZHMtpnWDAY7+MedY7jHdPb8nW
	 Wr8M97PgeLE/3ogNJFDme7+tXH7z55zyCydhA5uCacoUCTnJ5FJ/rNkZUjD2mXCc87OMl
	 8SCisNxNRkQP3y7rTI8qWJfl7LpxFE2sRdZUiw8HZusGyQBMP/mit/+3BWYBpsDkbJL/6
	 4R0OwkONzX0wSIjhTboAqk5ZzNDGL4xLmpiC6/tI5golxFZHhAk87rbZjwY25AjfHLaFn
	 kzH3toLL4wcWRYuhe9LaD+JD/jfbnc0KJiXHSHH6/18sHuiy/00TN4QjfFP5v5VDyMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793633000;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=D8bLl1rLGSjiL3Gikn8IDdo4Ey93z21R6Kx6//asiJg=;
	b=oUU1GhtyQx6TTX/6au1FibFbOtHL/iuMMQP9cFNCkxsiml2u1cgbs4pq2SdiVJ3q2OyP
	 1EVDLSl90FatsKoOK1YpEacvZnMPxyJgh5qE0iZ9w0zDNYfoDSjrclhLoAUQKp5YoUnY6
	 XGNNWGVoLSgIoBCa+62NQI1KBuS752jp7Q/lqwIc5QucMIPd1GqhIOQENFEIW831/8aT6
	 gSOoh3VZkNe2WjEFFewtxDVCPYDxZgfWTKc9TdZeQAt9fj/GhG9+RkZNf5hNsSwuLZf0E
	 Ea1ryuGwhTTRHJS/iVdRNy7mNgc21mf0x59C5FKlG/Elq6dSaMQuMRTCx3fMpD7H8Og==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793633000;
	bh=D8bLl1rLGSjiL3Gikn8IDdo4Ey93z21R6Kx6//asiJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DYZYJvTFdNwWDJvYD6icyUpw5VSLDsjTdOU1N4pbrv+9Wq9o2uUMVtsaHK2ovOsHm
	 e2GbMalPFc8J1LwHLb+t0NzphMm9VfNaXDj8QRfpk49p6Pt7UTaB/Q7EGpOvu8oBJm
	 2FzZ8Rbi07V/9LZp72ccL/GxmK/ez5XNsmJCuV4umT6dcLaCxr6YtOoRLUe223aal6
	 Vei+cOFn67aB+JJqonIZkuhlPj582LESWGeKOnAXoiIQeFO68DuOFsHTR3nHqLDJTG
	 isAEt49QWypf1JhO3il1VD9sXiV6AJz/X6JPIwPW2bFOgIAAt4Te/sH36aRRuzJtvt
	 6aJN2Ni/NGegA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E993181090;
	Mon,  2 Nov 2026 15:23:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EA8BD2A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC3DA40661
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:23:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s3FM4RvJqekq for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 15:23:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9CD6940685
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793632993;
 b=CJOKHucyO2BaMJvC9rDqXeTuniFtkEsX/grBDPiqIhdX4Q5B2Ou0XnLtICPkHLNZvSt7
 Ucflv57W6UJoTVG/7i+o3DU6a0WaP0x5FDhYrXXZNQuaCsiTHy1INRdSDPnAwVMgzFWXV
 zbmltoMPkD2wZ9+U4LAoNOgVJKnELipSJDsnte10umi233sBGhtIgCzhlTB60Mfi307OA
 v5MT9ldd6EcVbIuSd5g1Ry20K+gXb0LhVLmcpVyJ67ueLE3/EcuHRl65hjKy5fwG1Fqn7
 zJbQMMm0A+npYFYBJTZaYXyUzDMQ0qsIrG+kM6PTBGuKDVtT1jNeEcKAfKpOsI+fTbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793632993;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=D8bLl1rLGSjiL3Gikn8IDdo4Ey93z21R6Kx6//asiJg=;
 b=p9qyMXZtTzYCYeUv1iZhFu7HisYR6ZZAlH1XxqfI6f3BXOI85Jwbzvw5K70tnFk5i0nY
 p8GYOPjEXT9LwZ9brJHBpsD7ZSnqOCJYqpu3JlU9emkq2SchwGPJv+6OCR2NRaSUFG0K/
 GAqPqalCUBWtE8MJXc2YiBcpM8vyF3KhArWuRIURHTpq3NCXtCSCxaa1ImbR17kc09R39
 A6CiZc1T4Q2KwApQRIULW/cFVy7L05z0/54axf+3Fo9jd5qcdNg9nsBOyPMSkTP7Edoik
 pb7q3Vasif5T8eaHJsFKk0MzFj7eIfDvOvv1sQ+qo1C8GsmOLMgeCWUo/DROpfPWLkg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="m/X+P8nr"; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=m/X+P8nr
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CD6940685
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793632959;
 bh=D8bLl1rLGSjiL3Gikn8IDdo4Ey93z21R6Kx6//asiJg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=m/X+P8nrOeHswich+/3Fead4zpGEPhCx3x3Ex5DUQOT5/CqHxCwzIMPI9A8Q+pLNu
 82nB8HevHeccGmAqqWk7F3MhHSLPBytUq2tJ56VVJcCoFTrOyxjRIRJVBXTavJEsUN
 9XeaIeeG6jl3Edc5gk0B6Kw079QUeWsP0iLKy/3GcqHO6V4gkVOgynuBrbhiBlHw23
 8iTY/7HtDq5VHQim5hl4jtZp+h+zOlHx6utQqdIRUPNs/VIzUNUOAZ4VQQ6oX4wUN3
 QYljzvnRYJP3ZXVRekHLLKioDvjQbUNAiSDXQEGk+9Vhv5+m0aldGfm1Oz30dPicrC
 RqS0ct9XAulvQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id CDA02B220765;
 Mon,  2 Nov 2026 16:22:37 +0100 (CET)
Message-ID: <e3ef6dc3-90de-439f-b46f-b57f9cfbe64b@freeshell.de>
Date: Mon, 2 Nov 2026 07:22:35 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: fastboot: default the buffer address to
 $fastboot_addr_r
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly
 <casey.connolly@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot-qcom@groups.io
References: <20261102-fastboot-addr-r-v1-1-7ef1a2ac8fd1@oss.qualcomm.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261102-fastboot-addr-r-v1-1-7ef1a2ac8fd1@oss.qualcomm.com>
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On 11/2/26 05:30, Igor Opaniuk wrote:
> The fastboot command downloads to CONFIG_FASTBOOT_BUF_ADDR unless -l is
> given. Platforms that only know a usable address at run time leave that
> at 0 and put the address in the fastboot_addr_r environment variable:
> mach-snapdragon allocates the buffer from free memory, and so does the
> Samsung exynos-mobile board. Their environments wrap the command in
> "fastboot -l $fastboot_addr_r usb 0", but a plain "fastboot usb 0"
> still downloads to address 0.
> 
> Use fastboot_addr_r when it is set. -l still overrides it, and boards
> without the variable keep using CONFIG_FASTBOOT_BUF_ADDR.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
> Tested on a Qualcomm QCM2290 board with qcom_defconfig: before, the
> first "fastboot stage" after a plain "fastboot usb 0" crashed U-Boot.
> With the patch a 100 MiB download lands at $fastboot_addr_r (CRC32 of
> the buffer matches the file), and "fastboot -l ${ramdisk_addr_r} usb 0"
> still places it at the given address.
> 
> Refusing to start with a zero address instead was not an option:
> sandbox uses address 0 as its buffer.
> ---
>  cmd/fastboot.c           | 7 +++++--
>  doc/android/fastboot.rst | 4 +++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> index ace877b6e28..ce4a32729ed 100644
> --- a/cmd/fastboot.c
> +++ b/cmd/fastboot.c
> @@ -7,6 +7,7 @@
>   * Rob Herring <robh@kernel.org>
>   */
>  #include <command.h>
> +#include <env.h>
>  #include <fastboot.h>
>  #include <net.h>
>  #include <vsprintf.h>
> @@ -88,7 +89,8 @@ static int do_fastboot_usb(int argc, char *const argv[],
>  static int do_fastboot(struct cmd_tbl *cmdtp, int flag, int argc,
>  		       char *const argv[])
>  {
> -	uintptr_t buf_addr = (uintptr_t)NULL;
> +	/* Boards which place the buffer at run time put it in fastboot_addr_r */
> +	uintptr_t buf_addr = env_get_hex("fastboot_addr_r", 0);
>  	size_t buf_size = 0;
>  
>  	if (argc < 2)
> @@ -144,7 +146,8 @@ U_BOOT_CMD(
>  	fastboot, CONFIG_SYS_MAXARGS, 1, do_fastboot,
>  	"run as a fastboot usb or udp device",
>  	"[-l addr] [-s size] usb <controller> | udp\n"
> -	"\taddr - address of buffer used during data transfers ("
> +	"\taddr - address of buffer used during data transfers\n"
> +	"\t       ($fastboot_addr_r, else "

This is not a good place to document the inner-workings, that belongs
instead in the actual documentation for u-boot fastboot. The command
usage text must describe what the *user* may input, not what the program
logic does with it internally.

>  	__stringify(CONFIG_FASTBOOT_BUF_ADDR) ")\n"
>  	"\tsize - size of buffer used during data transfers ("
>  	__stringify(CONFIG_FASTBOOT_BUF_SIZE) ")"
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 8e15f287f9b..41db4b31e16 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -70,7 +70,9 @@ downloads. This buffer should be as large as possible for a
>  platform. The location of the buffer and size are set with
>  ``CONFIG_FASTBOOT_BUF_ADDR`` and ``CONFIG_FASTBOOT_BUF_SIZE``. These
>  may be overridden on the fastboot command line using ``-l`` and
> -``-s``.
> +``-s``. Boards which only know a suitable buffer address at run time can

What is "Boards which only know...can set..." ? This does not make sense
to me.

> +set the ``fastboot_addr_r`` environment variable instead; the fastboot
> +command then uses it unless ``-l`` is given.
>  
>  Fastboot in SPL
>  ^^^^^^^^^^^^^^^
> 
> ---
> base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
> change-id: 20261102-fastboot-addr-r-28fe6ea5615f
> 
> Best regards,

Otherwise I think the functional change is correct.

Thanks,

-E
