Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E153F606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 04:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zUnzHIsC;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=bmgYn8JB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF4C8405A1;
	Tue,  3 Nov 2026 04:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9hq0HUmh_0iT; Tue,  3 Nov 2026 04:17:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E2F0E40583
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793679433;
	b=VPnA0yXpj843gOAUp+aVXkhTK+OY2IxyNwQlxn5IDu+kcvREq1gMsWEe6KQn2kPA92ld
	 g6KijRdk//fXaP3HuLIi66wiMVa22Dy6N/xnKta/pfFQDwEb1RPhCbe9PvhqS9iEK8zMb
	 rR5QSFYsNOR02i6T5abUSxU8iezrUfOV3Nz7AHWbiCX9iQdMw654ZOfUPM6KWKChnJyJx
	 ZV+b0tMoAEgazIcxhfvpf2mccbz0DrwHie2GsEJsiKTp2NIudQfaYeUB0S2ZVJtHayXaS
	 5S8D7lOzX+UdhHedInLYIocEgKmh7uZ3e9W8VWZ9TQVyae8a1RZOJnANLd7KyodYpJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793679433;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jTGkE9mNhQyrBV0SmAEduvxK5JmMrl7q3hsxbjtZaog=;
	b=R+L1A0G6Gd8H39QJS4KFrM0iZ+BE9Mcr7gaxEAYG8HoiHw2nLx3jR6zPB5gZaR6IAPk/
	 WIgKiWO8sAKsnXo4IrtMsta2tOZhWWh45bTpQglhn1njXquxFA5MZCE/bBvGrmDGQKlY5
	 rMa+E5pqaawJxaH3FEAJsXEVFzYDc74e9chn05RZYQVGjgX69KDqxFoDo+a8lflRW4xch
	 z5ELB+OCVjtPgKT7Hi/bbPF1IZie7D9BzBX/qy+HQv+D2B6X6s/+pVTmM/RameVOMBKhY
	 a1woNMpvUWKIGsK4/QnwukJ/vWA0hLZziuqmsK/0h7ymR9pwyAreAhGyDhp1E/GCkvQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793679433;
	bh=jTGkE9mNhQyrBV0SmAEduvxK5JmMrl7q3hsxbjtZaog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zUnzHIsCxFPMAbjTrRD9I6r7FelPsVEYFXx9aTHYLVKY+RfyGLmIMCmkvUc0Yoft2
	 UtdmBD09nAAC94zj7tCit80g6NxIaJ9H5/ioYGYg4Zp+aZn+h4zDv4L8ysIPis6b7I
	 Mtmo2KQeAwrhkAuT2RaOF3NntchltvmggONNsCixfrowM/h0kvy9sQosT0I+DfEDsw
	 EskVnqtYZhe33rEnvY2m2NL3Xn2w6HKIt9N67TNS5IGRyw8vUyo23mwPjfTNJwkETo
	 b1ev8k+sL4S61vXcA/Ud8rhbMbXmKdmvjFReetxP9Nq3vv9IAz0Zf9Q7xmtxYEQWS9
	 CIDl92lHai8xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2F0E40583;
	Tue,  3 Nov 2026 04:17:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D581C411
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 04:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C741880DA9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 04:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id atCEGrh91M-e for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 04:17:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0DFA980DA1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793679429;
 b=avR4Ny+AsSjPL77Jm4/RT69gQMaxt//3P8whbXhIk5XlrcCwPiTWePUteM4O+0VTPZjn
 6zQDHxyntrp8AVn/GQXtaYpWt9JvEmyGQHHDMqBojKcSBSaZwV9Lk4FkhCuwlkOL1dguh
 sS1TpwRgvPPdBitu14lG4LgK/AAbEK5Cnly3Y8YRoIiJ+GaOQzJmvhCQ+1QP5iEGu6MDN
 Am3HVuEf0ekw+tUqEeZReKqPc0qQZ0vwe6bAybSKPsWKbVBPBWAuAYd7I8oi196Cmwg+G
 3Sj/xTHU3GEfo95FPdq/eFE3jjhhmalQPhoAgZYj10CAgzeK3w4kh1TvB29LB7GtDsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793679429;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=jTGkE9mNhQyrBV0SmAEduvxK5JmMrl7q3hsxbjtZaog=;
 b=S2VymsMbsc8OVzDUZBWfqs9qX6SWvA9b4Sz8I+kT/HjESuE4JRvIhmIl4fYCjfJHygoP
 EiGJUzYzDf0DyFKgixYOYnRU5EzrnfLwSCi7BuVI1JvLeAPBegcJxHMAlXCvJ/QnQRDPI
 4kH7vlB0niX5XtmoKTdli6PGgU+CTms6/ns7Vi+1DLXW1Spk0neuzSYO44DYckQpTxjx7
 RRejtWgVuifTo0Dohixf8viAYTco3hqMAUEcOxPE7JvnqYHc0sZ12Cy3mAhZQwtOfUgGB
 Bxcuk6FvcAVa3vpvqqOwIab/CS37ujdz8L/SmHIc8ECkpSJW3dxjwepQG+uFykfPD/A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=bmgYn8JB; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=bmgYn8JB
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0DFA980DA1
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 04:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793679406;
 bh=jTGkE9mNhQyrBV0SmAEduvxK5JmMrl7q3hsxbjtZaog=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bmgYn8JBccYIjEy1EsU2m8Z0l9JAnoK8P2E4bOb1Mv0lF0axzkWXxR5t4Fts9qMUI
 SytgCxXiYTEBUCLpqXa6HalVvZusfOr0Mj4bRY1BTtmO+8acs3GxU69+1DUplbZ43d
 IzPfyeNL5SXd0qp09P5rmHmAmtM4T0/RNSRb0G9dR7ZY8B9A5gxYKDTqAxYTz8/yy/
 GeQfmAALAs6M160G9Hj1HR0mEra3epENEWckQS8wMXLeImwFhsOEA7/TFmHs0Ak9SK
 xkmr2vyrTnmrRkRwN7OEjPONkbt1SnHKQ3hgZqUNfwWJdADEtpUJNBWSa4pHRktrwC
 N9K6KBrh/WPig==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 65D9FB22046C;
 Tue,  3 Nov 2026 05:16:44 +0100 (CET)
Message-ID: <ebb40fe4-cc95-49df-8a90-73db8b2e3bfe@freeshell.de>
Date: Mon, 2 Nov 2026 20:16:39 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cmd: fastboot: default the buffer address to
 $fastboot_addr_r
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly
 <casey.connolly@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot-qcom@groups.io
References: <20261102-fastboot-addr-r-v2-1-65ee21f29fec@oss.qualcomm.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261102-fastboot-addr-r-v2-1-65ee21f29fec@oss.qualcomm.com>
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

On 11/2/26 14:08, Igor Opaniuk wrote:
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
> Changes in v2:
> - Leave the command help text as it was: it describes what the user
>   can pass, not how the default is chosen (E Shattow)
> - Reword the fastboot_addr_r paragraph in doc/android/fastboot.rst
>   (E Shattow)
> - Link to v1: https://lore.kernel.org/r/20261102-fastboot-addr-r-v1-1-7ef1a2ac8fd1@oss.qualcomm.com
> ---
>  cmd/fastboot.c           | 4 +++-
>  doc/android/fastboot.rst | 8 +++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> index ace877b6e28..795c3138cbb 100644
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
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 8e15f287f9b..ba817e8c1eb 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -68,9 +68,11 @@ General configuration
>  The fastboot protocol requires a large memory buffer for
>  downloads. This buffer should be as large as possible for a
>  platform. The location of the buffer and size are set with
> -``CONFIG_FASTBOOT_BUF_ADDR`` and ``CONFIG_FASTBOOT_BUF_SIZE``. These
> -may be overridden on the fastboot command line using ``-l`` and
> -``-s``.
> +``CONFIG_FASTBOOT_BUF_ADDR`` and ``CONFIG_FASTBOOT_BUF_SIZE``. If the
> +``fastboot_addr_r`` environment variable is set, its value is used as
> +the buffer address instead of ``CONFIG_FASTBOOT_BUF_ADDR``, which lets
> +a platform choose the address at run time. The address and size may be
> +overridden on the fastboot command line using ``-l`` and ``-s``.

It looks better than it was, and now I do understand what you are
writing. There are three-or-four sources of information here into the logic:

1. Build time

2. Strictly U-Boot environment

3. Fastboot server/client requests  (and here, does the client request
override the server command line? so... potentially split to #3 and #4
sources of information here into the logic)

Does each source described after the previous source implicitly override
the previous source?

Is there a functional reason we did not mention both address and size
configurations for all of the above sources (notably no mention of
fastboot buffer size override as environment variable)?

The word ordering flows more naturally if it is "here is a stack of two
related things A1 and B1, now we override those with A2 and B2, and
again override with A3 and B3, and finally A4 and B4." If it's more
complex than this perhaps we should just dump this into a formatted
table and not bother describing it more than "Order of precedence" table
name. If it is not so complex then it should be said in one or two
sentences that simply list the order of precedence.

>  
>  Fastboot in SPL
>  ^^^^^^^^^^^^^^^
> 
> ---
> base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
> change-id: 20261102-fastboot-addr-r-28fe6ea5615f
> 
> Best regards,

I do not want to go far beyond what you're trying to fix in this one
patch but it does open more questions for me now that I understand it.
Let me know what you think, thanks!

-E
