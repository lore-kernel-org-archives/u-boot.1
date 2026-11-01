Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661F606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xASqkojB;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=cm08AU8a
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CA43405F6;
	Sun,  1 Nov 2026 16:21:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id azx06Syo3P8E; Sun,  1 Nov 2026 16:21:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3455F405E5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793550062;
	b=AOEGPKDC5so/gZLJre9GYDBMcT6XsyOnYrGjX1sYMdg+tlM2e5VTeMXuXQ/9g3zGIUAK
	 noJ2miUEITLclP9ixePpSH83KalHL4MCSujs30+GZ9jGUMf6JabGkm3kQ14H5vE8hEhxj
	 YnNIWjOwHjUp7iIFzPep2pbYnvSbwE8Vu9IJTjjRul68WcMONrEzclISIOAYXhHPwePBP
	 /uIKF1t+pF5iEySmPFqBqVOd4NLJe8UnaxKiIGrMm10DF4wBhL/nrQqPuYPlub+3cdDvH
	 4iHVJKAyPjpVYUinXg2ur4fLcvICllmD7aRGrz4XYmY3hicd2Yj1Wu3ygrRMEmGAqlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793550062;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k/w8D59JFEGMao7ANJhk9cl4yn1QIBLzSAnabKHo6Ig=;
	b=PmJga0A2suWGaEkxCeiygsWUnDfrlBk4+h2Ggohn32y3cF1NWKNNjIsQKr7PAp190T6t
	 GRGU2MIRRZ5zYg4m35EcPAcQ9KV1/CK/o0FoEQPhQ5SJOrTdDOzZdR8VW9E8O4VdbYk05
	 bq6PV490ISgWqlVA1W180rGtKDgxiC0T7y1Fk+/RE9+6+8BT3Nds3//annR9uNupZtvXy
	 JOfcoDJL6sJRUCRAcCnKv0f7pTk/Ot+AfEAQ4JvI/A2uEuM5/GT8ZioMVm5fUi2Vpqxfu
	 RV8qjG8wZf6rlQD9LaJJxMIOpUk+Q/ybY8umP4PBDCu8tAVvpirc/WBvK8vRWhxL4PQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=cm08AU8a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793550062;
	bh=k/w8D59JFEGMao7ANJhk9cl4yn1QIBLzSAnabKHo6Ig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xASqkojBn0+hAfTLapYAU1gcqG2rjba2TyMMI0ea1WsdP8XQ6nb0miLHZwtcimmGr
	 RM0WEVfWcde573pwzSWoIo0nuP81h+p0u0WfBJ/h1bp1NtRYmKb7fgNdD/eEzKzLze
	 UWldmVlsWdFIszOLMwHt4l3S/eLa1V7mMkFJWQoECQjxDAF+rqh1NdlqhLlzhrxF/m
	 WvvsZjwlJXk3ArHwytBBNji2B1WvNogHQ5P5gsdP/pRr6vos1KBlBhAsdOwQpFQSW0
	 vjfaVkbRsJ4RYqeJ1Y7Q6Xk4KQYvSOB0tcQB/1hGeAd1dnORVvF4UAPZ9XcgAx6FzU
	 TlcUYXgGtfMnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3455F405E5;
	Sun,  1 Nov 2026 16:21:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 68188323
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 16:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6190F405E5
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 16:21:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BmnPI_a_oZY1 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 16:21:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B08BF405A4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793550059;
 b=OU4owaCoZRiPZymiEK+0MjQEs/vr5e6QaBmbGsknqQNKkwPPAAZd/RV/DSpU7ZA00sHk
 8w9eUk2O5gDVuKySl44jtmNJSG/hTA7OziYuXtHfvSc3W98132lYMzgKuRrnSHrR31QOh
 wRLbVUrLsFxzq/CHsX7A0VkWstztQC4J0GoZYKrTJQtoirIi2H+oRJ/hYGO1wpp42YQsd
 JzbWbHvEdttFlNPsktM7rhWFIh7eP9wb74dbR5W/QpOiXXOQiEonQb/EWbuy+J11cnmXB
 UZVlGJoR6ArAuhxvBcvuYjoDgAwTUS3mLzl8sN1HmvVMa8Sbn0PUfxPmB+A09EU8EMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793550059;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=k/w8D59JFEGMao7ANJhk9cl4yn1QIBLzSAnabKHo6Ig=;
 b=I0CCVW8VeqpnT4wcZovDpFNF5181XOFKVS1x68Ette99IhakZ5u5D1oOp3tvtIGQ9pBT
 1Xlf2Nx98WBHUpn74XRk7cprorMfnyUwEYFwqU/UJkZa9A+Gqo3KIFE5e03xgWvUoiLfx
 I7v7a34ijturNy7zZUlcd/v5TiR4b6dQZ3WPqqub0A0ooXC53saxRHpyhKnowfAg+L5CF
 CzORJTzSaogflOcvQC9mBGuR/G0Rut6rJM871VWKunWnryChECcMq56kbtbmg6g4lUKoK
 cebMC61uzeWAnqhHmiKlh2ugChZ1l6ALqSNdW0hPs97Sz+8PH9nrHHZ7R8VfeNGwmyA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=cm08AU8a; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=cm08AU8a
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B08BF405A4
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 16:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793550038;
 bh=k/w8D59JFEGMao7ANJhk9cl4yn1QIBLzSAnabKHo6Ig=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cm08AU8a7Nmq1DRHdtqezOu1cvhmhKvFPEfaniqF3zbKwHL3BJInDbqtYTVxbYd1r
 0DNUwAFTDXy+llbjlN4qYArMOnZy5E6FNyNtasNdwtJHpIwRT4BGkpgi0hPgu4fIse
 dZULLkcQYHIKG/GdWlHKP9S+6Q0VdhkJcq+pio/Rp1ojGUKDQBPlX6VcS3btHCvFoR
 rMheDlGM6+z6s3vC9FhNT+HvrVDLMI9JTUkxfwQP4vnDGFVqsNkqEIHgfRRvlBLOnO
 utqtX0vCDiAs6reNge3G14N1UtKTfnMIo53Krq7dhhXMt1x8zGJD7G9z21W043E/+B
 /iYCjq57USakQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 41893B221993;
 Sun,  1 Nov 2026 17:20:37 +0100 (CET)
Message-ID: <1729b153-a747-44ca-a6d3-43580f111a6f@freeshell.de>
Date: Sun, 1 Nov 2026 08:20:30 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] cmd: lwip: wget: write the download to a block device
To: iav@iav.lv, Jerome Forissier <jerome.forissier@arm.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NUMERIC_HTTP_ADDR,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On 10/31/26 22:53, Igor Velkov via B4 Relay wrote:
> wget can write a disk image only after the whole file is in RAM. This
> series lets lwIP wget write the download to a block device while it
> arrives:
> 
>   => wget -o mmc 1 -b 400000 http://192.168.1.65/armbian.img
> 

Please write this as an user interface that is extensible to other
streaming data transfers like UART YMODEM or 'load' from one dev or
partition to write to another; or to/from a file on a filesystem.

There are existing commands for 'wget' and 'save', so we should re-use
the familiar user interface commandline options of existing commands and
add a stateful 'cc' wrapper command with some helpers to set the env
variables:

cc in wget [$loadaddress] http://192.168.1.65/armbian.img
env set cc_in wget
env set cc_buf_addr $loadaddress
env set cc_in_wget_url http://192.168.1.65/armbian.img

cc buf - 400000
env set cc_buf_size 400000

cc buf $loadaddress
env set cc_buf_addr $loadaddress

cc out save mmc 1
env set cc_out save
env set cc_out_save_interface mmc
env set cc_out_save_dev 1

cc dd
# begin the streaming copy

There could also be offset, block size, and count, for input and output.

> The target is a whole device, a hardware partition, a partition by
> number or name, and an optional byte offset into it.
> 
> [...]

This surely belongs as its own command with a build-time CONFIG option
and not adding forced complexity to 'wget' command.

-E
