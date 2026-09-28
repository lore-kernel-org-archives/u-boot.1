Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA3DCA5FA9
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 14:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B653405A1;
	Mon, 28 Sep 2026 14:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 19lBNRJl_Ssd; Mon, 28 Sep 2026 14:28:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 70B82405E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790605723;
	b=NgyxfxztUw586aAbAYyU2umbsbVqOVnEiBGl8GmFpg5zRIcg/BL3EdgmhGm1af1zOisz
	 OSHvTGJtJAO4Qeb9B0Qs4Z2uIbCjgZOhwinvBhth/KK8rNo1tW2l2lN72fw83onEBbzPi
	 2/5k1eeKmgVoCvkdNyHi4jHYs9ATF75S8tami0LVldB35i8WnqeIsS5sJO4n0Czg5Abil
	 YMHqwHuLR5T0di7pCu5YZ6rWkPvsL2uQXk6Uz1axogTNR7bzsVEE679ZYKpmXIc401LFG
	 pa/f0yquGhSCB99gX8AQDuafgZmz1b8rXhrpg+k2GS9R6i5h2KzMQIvqDFRkJ7oCC1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790605723;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SJ7QT0mvi1R04mipBE+jZsIFOxM9RgBLhqCaK5rZ+mA=;
	b=BH7bkWzF4hTaRJAfzebCX9C1i3lQX7F95HhGZA9RvmPdDjTGq0qA9Mg1/YF18Vvh2TeM
	 lTjzp+YXf6ZDKo+pGvGva0ksS5jHehRVDM7jpXv/orZOEJ0FNAVuB3SMQ7dDowQsyPROa
	 G/h6Lwy7z59vL+DhWysBo5ubfQEYKP8o8+AC39dxr/85WKnDxyrUXskfN8AWqXElS4QJm
	 WXgEMCUNPJcm7Czu6brxXiD4eN80mFKMXhtvuqYCJlr/MjMJkQEg0iJ2dHSdRP2ZhEBGS
	 j7T5TZsKk8D9dGVvVs2Hu16II5V31vGtSVCGNTJRi//MGOc0m2OQNTHyKUoH+XZ80nw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=JCcOFibH;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=mxVHFcwM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790605723;
	bh=SJ7QT0mvi1R04mipBE+jZsIFOxM9RgBLhqCaK5rZ+mA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Az3T312wOlp6GhB0mlj1CBqMqtoBZp/jUDaOBjo29ChXI6Q5CrbydAeMaEEyjR5ji
	 EpIH2ouM9LljzO1uoXsPLxa3ameK5AgI0VgPf4SUR/dQXjcpXh+5Hv8N7AZ2G5Agb3
	 XhYn/4BVmuzfw6g9IVmC0WflqOgZGbiG1vVtBeyITKpkGg0f8onE2Wb2CdH9TsNCYp
	 MRUsRWUsrBQKPBSSn4Kx/lX9ssedkDdiS3OvuZZiDmbvLyYGnP7Bo0hoBkvgLh7BpD
	 w8bM7UXv4d/kc3o0bdVXuw9+inCt5k7/fJ9+xt0izHl3ONiUK30baIfIOENcjUmqp8
	 N5jAdtyg5qN/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70B82405E6;
	Mon, 28 Sep 2026 14:28:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 084CE32F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E163F405E6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:28:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FvE0_2Ci1qKN for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 14:28:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7D0CD405A1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790605720;
 b=j6VsvrcS06ZuAuDw9ZP7IP+dml4MD9B36UHX9G+HqMXnRUkMqUPTrDhu7/NxdWbDO00A
 YlfMWHUXsbBpnVuH6HvsCZi65TunUBqgk/1h43KxzBV++hUAOmJ7MUViXLZsiCp8s1cQv
 L7vZ95HNHtYSJPkAIKKdqu0WwC6JRN79yabKV7ynR7r3IgzzZs0554wC5q+bDTYdChXQ4
 /eYNdw3Ka9c0Lx+dawaqNNEEy3bJytiRleOD6FHw+4fXGl87xpSCUhYGEXi+eYllbCCPw
 OSf7hMDTeQ7g3ONTk+8xKJkDtr7ntThn8ayv5syUZjQGU9Q9pP/u4FSLhbXVP3frryA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790605720;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID;
 bh=SJ7QT0mvi1R04mipBE+jZsIFOxM9RgBLhqCaK5rZ+mA=;
 b=eiOyxvO1s6caS233kOnmXoaK7x1goD6FChzbnrWQwOrQCTDYBGEh7GgAg0v/KV6Xcc99
 uYITtIZ2BCYzlKEtL2cKaojGYPzy2toXzZVwCbpiT5xKFjk8GgScdHgvhPhM1gHv+gxku
 S+HG86aMQ+/b6YaklYO6NTIT8mV8RMO/b0ATVG4JENboy/wTx8JDgDXy6vBy840jovEm3
 YINOXcKLFkvYIOg2bnS0IZgBlDpicZf/TJ9V7LrO1s0hYnlPMx9mQXPKJ6LqBf6IaOLSH
 YrXQNg3pSdoOQIBsOHIIhae+mzNr+gPJV8Rw+bR57+MaHziFzK5jNBEFeUGmyMD6vqQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=JCcOFibH; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=mxVHFcwM; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=JCcOFibH; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=mxVHFcwM
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D0CD405A1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:28:38 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4htkFH4Hd7zMlWg;
 Mon, 28 Sep 2026 16:28:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790605715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJ7QT0mvi1R04mipBE+jZsIFOxM9RgBLhqCaK5rZ+mA=;
 b=JCcOFibHgQ3/HIYZq74jztuP2b4KBM+ItCKtAzxE8spUqdh0Ly5kjsTK75vcle6lzqkXuD
 RIIeeDWkhyPCQTmgEMs/70s6ZoHhEuCLqmX3rpRkm48OGuriwWW8lY+fdbq+StTZjwyAJO
 nthnB3+ycmUg8s979CMquL/G1K7tlBhJAElOWQh8uXbUeSdtAjsWkuBvE05yfi2wDbUrC0
 4T62MSAt3a8d0nkY1bxNhWLGtambUW7n+kGf468ob/+A8C8NY0rbJzPowobH6fIKcpQxLY
 Mg/5Pt4Wlsh9ekPdn/VGmQgVP2aZ19zManQ0kzkuVkERBnHKJ1RFA1raf4ohWQ==
Message-ID: <bc11ff66-ea33-4509-8215-722357600b3a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790605714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJ7QT0mvi1R04mipBE+jZsIFOxM9RgBLhqCaK5rZ+mA=;
 b=mxVHFcwMgluLo4JGguLIz0EbcDUA9zjouZCZtMOIBpHVOJKoPQExU5PgKvuTnFvxBah9gU
 qbTVtgg+Sj0Vdt9raGTHpvxRJHghYDhqgbKZF7CdTXz7YJ5RYSnfZNdu82cCgUXFwTIqqC
 q9kcrsVknf5eTBFfeIRZEiR8c13LEwIgKKSE/Peu6FYqs6MDjjV8qahBKNoUQAxkJ6hWck
 uobAjuI5Bdn4bov6lcyEbE+/Kocvu3MaMbgIsJ75y9z9CjiwHvJIPKYG/zHX/+0hrvjd0/
 Cp/feJyzcPZbVK1LLzKUqr6o4JxHjtXtJnaxz9Fl8aWQbV0B0dkz0yHOkt4O+g==
Date: Mon, 28 Sep 2026 16:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Optimize CTRL-C
 responsiveness
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260917-ums_increase_ctrl-c_responsiveness-v1-1-95305f044ec2@foss.st.com>
 <d5d00e93-e803-44e8-9f20-915e324395c1@mailbox.org>
 <c5c115c6-dc8e-484c-a802-673b46be8174@foss.st.com>
 <5ff54e77-59b8-4a61-82c4-923242f9d82b@mailbox.org>
 <d9a28eda-6765-489c-a09f-1e34e07a08ef@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <d9a28eda-6765-489c-a09f-1e34e07a08ef@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5ipws3o5hba9r7339ituktpwaot9kfn1
X-MBO-RS-ID: c0fbcd3a19ce148c4a4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/28/26 9:30 AM, Patrice CHOTARD wrote:
> 
> 
> On 9/27/26 19:55, Marek Vasut wrote:
>> On 9/25/26 6:17 PM, Patrice CHOTARD wrote:
>>>
>>>
>>> On 9/17/26 16:26, Marek Vasut wrote:
>>>> On 9/17/26 10:58 AM, Patrice Chotard wrote:
>>>>> On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
>>>>> it may take a while to get the control back on the console,
>>>>> sometimes around 1 second.
>>>>>
>>>>> By removing the if (k == 10) test, it increases the CTRL+C responsiveness.
>>>>>
>>>>> Tested on STM32MP157C-DK board.
>>>> I still have two questions:
>>>>
>>>> First, do you have actual timing figures here -- how long did it take from one ctrl_c() invocation to the next ctrl_c() invocation. Use e.g. get_timer_us() to time this.
>>>>
>>>> Second, does this increase in break condition checking impact throughput of the UMS ?
>>>
>>> Hi Marek
>>>
>>> Time between 2 ctrl_c() invocation is around 100us, way to fast in my opinion.
>>>
>>> UMS throughput is slightly impacted :
>>> before : 7.35 MB/s
>>> after : 7.17 MB/s
>>>
>>> A better balance can be obtained with the following update :
>>>
>>> static int sleep_thread(struct fsg_common *common)
>>>    {
>>>        int    rc = 0;
>>> -    int i = 0, k = 0;
>>> +    int i = 0;
>>>          /* Wait until a signal arrives or we are woken up */
>>>        for (;;) {
>>>            if (common->thread_wakeup_needed)
>>>                break;
>>>              if (++i == 20000) {
>>>                busy_indicator();
>>>                i = 0;
>>> -            k++;
>>> -        }
>>>    -        if (k == 10) {
>>>                /* Handle START-STOP UNIT */
>>>                if (common->eject)
>>>                    return -EPIPE;
>>>                  /* Handle CTRL+C */
>>>                if (ctrlc())
>>>                    return -EPIPE;
>>>                  /* Check cable connection */
>>>                if (!g_dnl_board_usb_cable_connected())
>>>                    return -EIO;
>>> -
>>> -            k = 0;
>>
>> If k is not reset here, then the ++i==20000 above triggers only once ?
> 
> variable k is no more used, everything is triggered when ++i==20000.
Uh, right, I misread that, thanks. Please send a V2.
