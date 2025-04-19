Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73597C369CF
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 00:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EAB682105;
	Sun, 20 Apr 2025 02:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745110109;
	bh=fCs+UE6DlQdyfxqfzUyjCi0U1nPYIjZnAdZk/FMu1vM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jpJnEVbcOQIXfCq4NF9m8Lm5yAWYpE8pQ1p0Yd2Tmz8PlcjqsxRkdqIjBLZ0tcnfP
	 eNjWF42RzIgfcWRJBIBJNngwgnM0LTx3uAWB2zEgUoY9YT2OfkiOUEcaxqtkcbz7cS
	 hC/M8rnyjoIyPbmxi4G3/xZH0FYl9rqwh1AdYWJdZa14ZV4QLYL2q8qbZmwSoeET5I
	 KgvvXNgQWrRwsR+W2BCZG/Aok3mSpqzmH3QmboSWWdxrSglJUX/n5KOByeNfqR3edO
	 by8JKtThEIVv+pOdrET/M+ZRKpvVL6j5TOQyjicaLuktmSnFjxKa86ww1+plMVQi3C
	 6GO07AZfEM+Uw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41E7C803CC; Sun, 20 Apr 2025 02:48:28 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF7C81F4D
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 02:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="KJjngNu7"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 287DC103B92BF; 
 Sun, 20 Apr 2025 02:48:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745110105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=fCs+UE6DlQdyfxqfzUyjCi0U1nPYIjZnAdZk/FMu1vM=;
 b=KJjngNu7UYg7nTrXeAVkom0ziFYMyM5OXOP+unhWXg8p4lIplVJwa284sxmQi+1QnaEOkI
 6Q4tzvMJZKyCwT2H9zAq18qbersf1F1dqDUIB8I6AOysrFMYaAWtOb0x7dd2lsJ6d8s/q3
 41mNcq6q3/7lHEVUcr6UFHeYQ46lbKc09NbZjISnhMq5AJ1hphC7Gvq1opYRrNgyBxI6fc
 dCVWkvcdlNLZfqz4hHFhtZaZMo9k67SHXYCudB5OO6UQ3ZM+8/3+3CH4FLjRUyk+gG+7Hq
 VIWRawxLluQMhy+cOCVMigzda0lgZUlUdHyM6d2Og/rlUh0Cqt5RBvRzauyQpA==
Message-ID: <38e9d808-492c-4840-baea-418617311ae9@denx.de>
Date: Sun, 20 Apr 2025 00:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 francesco.dolcini@toradex.com, aford173@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/19/25 9:11 PM, Fabio Estevam wrote:
> Hi Marek,
> 
> On Fri, Apr 18, 2025 at 11:53 AM Marek Vasut <marex@denx.de> wrote:
> 
>> The "clock-output-names" is NEVER used for any clock look up.
> 
> In Linux, "clock-output-names" is used to register the name of the
> fixed-rate clock.
> 
>  From Linux drivers/clk/clk-fixed-rate.c:
> 
> ```
> static struct clk_hw *_of_fixed_clk_setup(struct device_node *node)
> {
> ....
> 
> of_property_read_string(node, "clock-output-names", &clk_name);
> 
> hw = clk_hw_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
>      0, rate, accuracy);
> ```
> 
> In U-Boot, we should register a fixed-rate clock with the same name as in Linux.
> 
> This patch aims to make the U-Boot fixed-rate clock name conform to
> Linux standards.
> 
>> I am fine with the first half of the description, but the second half is
>> wrong and this actually does not fix anything. Simply remove
>> clock-output-names from the osc_24m and the code will be broken again.
> 
> In Linux, if "clock-output-names" is removed from the osc_24m node,
> the console becomes corrupted
> on an imx8mp-evk.

This is likely unrelated bug, see reply from Adam.

>> The clk_resolve_parent_clk() is meant to perform the aforementioned
>> resolution(), that is what "[PATCH v2 00/24] clk: Add
>> clk_resolve_parent_clk() and fix up iMX clock drivers" actually fixed.
>> It seems there is something still missing and clk_resolve_parent_clk()
>> does not do the resolution properly for some clock, but that is what
>> needs to be understood and fixed, not worked around this way.
> 
> Please try to reproduce the problem on your end.
> 
> On an imx8mp-based board, run 'usb start' in U-Boot, and this command will fail.
I'll see what I can do tomorrow-ish .
