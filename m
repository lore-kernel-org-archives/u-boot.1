Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DE210F9303
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 22:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3781184020;
	Wed,  1 Apr 2026 00:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="heDhxy/N";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DW5Mt2ge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D7884035; Wed,  1 Apr 2026 00:01:10 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1336283F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 00:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4flhry3FHvz9v8c;
 Wed,  1 Apr 2026 00:01:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774994466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h64xNeUy1HFWAxa3tYPHgMw2su0hn1Hnv+yAVJnu4CI=;
 b=heDhxy/Nb22F4WOdtcZDgsM5FUPZztYtaDsILAGPkmj83ZNEir8JEkF9UDvujol4zZGamk
 mRtFt/2melTCH/JvmGh9fEihI1U/HI/3u7MtklsoEgKg68lpLHBsYlf50aY1dINMkLPsuf
 sfThY0DEKjd1ch04LvD1TeeqGk7yHezIsBGMNd3DTEwFHBgwqWKxybttNf6gNzB0cggHlv
 bZrovSQDVvASOc0gRwkWPlLt1OLr4SYquWr3f1CLm1EpJo8uqSv+4GmzB6hEV9+2rHs6ue
 VF5woHc1Tco7icJ+swLe8aFYuKvxq2uchO4EU40dVyYvlRHZ44YGPncE/TFilA==
Message-ID: <cbe4109d-7290-4104-8142-076b3296e13a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774994465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h64xNeUy1HFWAxa3tYPHgMw2su0hn1Hnv+yAVJnu4CI=;
 b=DW5Mt2geHWgZ+kWr7WfXCYYVxlQOP2CDzDu75tmflmw74h8t99J/xRfUGTIUx+HIj7H3Vm
 rnWSiGLPw8jQm1Imghul2z33bG9tqfkocDEF3UElYmHpETg5L9+q7ZS1O/mnI7RwiDQwL/
 tHmqiQxt64R8+LltRiUJv+J89ldJdJWrsnK+WBu9URuzSJDgLGlR+IlW4hETOqp4Q/u7Fr
 BOnRGyO+JSgRn115MAKCoz1DnDRiVrKxjG/Tzg5lcnS2ZPRTSxkOywXP6KphM1chApuHk2
 UOFnJCQR6xwqPIs3peF7+4rbaEwNZhhOOCIFI0wJXIAyqNoNBxsV68G6JFi3nA==
Date: Tue, 31 Mar 2026 23:43:14 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] fdtdec: Introduce fdtdec_setup_ram_size() to
 determine the memory size
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 marek.vasut+renesas@mailbox.org, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-4-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260331080117.2370092-4-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: snjxh14bi5f1xbmp8fmioc1kb7ug46gf
X-MBO-RS-ID: ed5ff41d33620b83aa5
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

On 3/31/26 10:01 AM, Ilias Apalodimas wrote:
> We previously added a fdtdec_setup_mem_ram_top() to determine the
> topmost address of the last DRAM bank. Similarly the overall memory
> size must be calculated when U-Boot gets relocated to the actual end of
> all available DRAM.
> 
> Pre-patch:
> U-Boot 2026.04-rc5-00012-g5789f787c8a6-dirty (Mar 31 2026 - 09:13:34 +0300)
> DRAM:  4 GiB (total 8 GiB)
> 
> Post-patch:
> U-Boot 2026.04-rc5-00012-g5789f787c8a6 (Mar 31 2026 - 09:12:59 +0300)
> DRAM:  8 GiB
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   include/fdtdec.h | 15 +++++++++++++++
>   lib/fdtdec.c     | 18 ++++++++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/include/fdtdec.h b/include/fdtdec.h
> index 26e40c3cdb46..9bccd70bbdb6 100644
> --- a/include/fdtdec.h
> +++ b/include/fdtdec.h
> @@ -965,6 +965,21 @@ int fdtdec_setup_mem_ram_top(void);
>    * invalid
>    */
>   int fdtdec_setup_memory_banksize(void);
> +/**
> + * fdtdec_setup_ram_size() - decode and setup setup gd->ram_size to the sum of
> + *			     all banks
> + *
> + * Decode the /memory 'reg' property to determine the memory available in all
> + * banks and populate the global data ram_size with it.
> + *
> + * This function should be called from a boards board_get_usable_ram_top().

Is the board_get_usable_ram_top() really the right place to call this ?
It feels like it is being conflated with ram_top here too.
