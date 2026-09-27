Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA8EC98338
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 22:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1F494065D;
	Sun, 27 Sep 2026 22:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qHGBha7WBAHU; Sun, 27 Sep 2026 22:48:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C2E234069F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790549295;
	b=bTmi+WeTwPTeZtMAE/QXPAYlv0cSwyWr8CKrv1F804O8juQSvNdbnxsOFkFP0OKhvsli
	 2MIf9r+QaTRiIlyNOJMF/6fe5FKOdMu4S3bUJPQdrJ7w/gHkj+zGRZlk5UjYhpKhvm7e8
	 XPoSELe1HcWfAvb4Jt2e6sBB+EU9oV8KZEg5srOvLN9SoBCMUjd6YuQm+8w+K8Du9/WWy
	 YhCqdQzUE3v/3Z62qxxUpIXZXQCb10GGG3OZnaI2h8iFcuaiJ9J0TkTtfXx5UzZkUm7Py
	 spyFTbmZy/EPj44oljR6giurKsZT5B7CK7tC4ibO3eG6xrqs8ku3GZEoDjwSNPzBc5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790549295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wATRyQmZbpEolfwupGPwVGukuLA/XIlYznHnU7UX3LI=;
	b=VQ8rKeg9tFvBiifJkJiG7+jqvVVvc2QDDMx1QZMM2lDKGTKBdfxo1+cm21WBPTMC+Ddf
	 ecJ3V6N9IkxNE9NUr8ux+gmYVt+//gKrD7H6Ap8bjWG70QVaG9wjDJj6X3zZKhKmPRTSM
	 mhDBwxf+jAnfPvSZLLMeFQQlV5FdU7xBHs1DlpdopatE34wvnYT/oDdBQgi61MelmtqD4
	 vBbW6IFOCopOotNdJ+sjR9oU5t506aIOFrp2PX5PQORV9DvAcXhgemfb7pzAGeloSIKMp
	 uFQ3GKQ/PX3roWHSSgd616wS+Z+rpdGrTmI7cPyMzFrcN4P9JPR3nhMRTucM8cq7vsA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790549295;
	bh=wATRyQmZbpEolfwupGPwVGukuLA/XIlYznHnU7UX3LI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JjHviLRtoBKHhH1UFUMRv4Q6BR8AMdERp74kIAKUTEYV2f6PVrtq60PMEhGdmybal
	 LlctSzXWMhnyQ/7JgykEipcfE7qXibFL7K+euQgpBbopi4dR97GeiEwrfrRtdjtq/f
	 iLWluoCtx0MThx52E7uppmyo2JMhHeHgLhMhQo5usQCaCFAU4G6uCphXyh8Li6uE2u
	 8UX/dgkLJHUaRF9ofJGPwlvcOnCdA3B2TLh8n8pd0aHSYuu4BeypjgcNYwCQuo8NH/
	 Kxa5yzb04tKQ0BmQkq6p4rpTjEfeP+XzWM4X+BF4B3UHAy8aDe8S7M09IGQbfHKI4e
	 bouPNrfUjIU2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2E234069F;
	Sun, 27 Sep 2026 22:48:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B4F513A0
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 22:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9AAC44007D
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 22:48:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TMBMsuBNf0br for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 22:48:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 477884002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790549292;
 b=flgA4R7qO2MM1ob2C4alUg3iJOyee0k6PP5Bendx3UjeFZahj5/Xpvdb/bbOxaOrnrOb
 0Uy8y99S41QKOzWmESONWcBnigVLwJC+8r14WUeWE7O0zInEjvAxOSJm4yohdoR0dWPOH
 l4hKKCbrqjlKhaYSI48RDMMyutuck06bCh7NyC4PCIMCrylublo03aU/RKuYj7S0m5wou
 L1908V24OLUTHiAu/SOBSsr4kxrKqKVOary2OfcYaQCEVw3KqDObFQi811nMLb9HC61QM
 rypQwe3XxW94S9Ox6O28ENdd7RNwh+mN55HrRtlMz+3RAAHsCfNEN6Gvhp+eSnt1TJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790549292;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=wATRyQmZbpEolfwupGPwVGukuLA/XIlYznHnU7UX3LI=;
 b=dIR8yE0SC/c3qDQZIGbayTDKzutpncTHsnFF8xULoV3JTkG8XrKIVxFc8RB/4BWZwys/
 eaPCH4d5N2hai0xBdhbD/2BCYsmue2eFl/rZkApTBWYefxDZQ71xuXZoYuRRkbFX/G/Np
 ISNQBKgS8oJsBGEqOQ5WHc0MLepdG1EznrcluEGXYzHXn2zWj8462+S9Kd6cB6wNroBh+
 GxP5HdTZWoP5kVPU1ffA+pbICvi7RpFUy8UsKnIh3FONOoVFTD6uThBAR0iKI4wssRpdu
 qzR7uzCca8fz0Rb76t+bYG3uPGa6q4ed9CoCYIsQTpLpCmJppHIUhxSVXsOZvmKjGaw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=CvHDO9Bo; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=CvHDO9Bo
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 477884002B
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 22:48:10 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4htKN42ck4zMlqZ;
 Mon, 28 Sep 2026 00:48:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790549284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wATRyQmZbpEolfwupGPwVGukuLA/XIlYznHnU7UX3LI=;
 b=CvHDO9Bo7hz1HNYPAgEVV/GM6um30AW9I8J0k5u5/Kqyr/RvZcodEpUmCuJ8CgjDnuKn/M
 p4+/cvAD3Bm3Kw4asAyLuqfcY2iz8Bm5JoWBHyXE/5ANOagPjc8HAs0pECjghaSxmiJ2yI
 4yrxIkF/FCvNDuXe7cWl48zvYHQTzD0hqZkphSXYK4KDg/j21dlEWCdTQkCJ3rr2STfjpX
 iHrbjF1Mh0TaUByDGg6wGE/uEDeCz2iYKmT8SJ0oPexQ2ZxNhssYuwu53mCSeg66f3nWqZ
 u62zFBmY2diIjdgeHThrAnt0IVQeru84Q8FaXpiyvPgPUhH6T5HuTCG/mWXXwQ==
Message-ID: <5ff54e77-59b8-4a61-82c4-923242f9d82b@mailbox.org>
Date: Sun, 27 Sep 2026 19:55:23 +0200
MIME-Version: 1.0
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c5c115c6-dc8e-484c-a802-673b46be8174@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1pku5ahjycdfgqxfz61bc3bt41gob9dh
X-MBO-RS-ID: 6c2aff2db066082b8b7
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

On 9/25/26 6:17 PM, Patrice CHOTARD wrote:
> 
> 
> On 9/17/26 16:26, Marek Vasut wrote:
>> On 9/17/26 10:58 AM, Patrice Chotard wrote:
>>> On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
>>> it may take a while to get the control back on the console,
>>> sometimes around 1 second.
>>>
>>> By removing the if (k == 10) test, it increases the CTRL+C responsiveness.
>>>
>>> Tested on STM32MP157C-DK board.
>> I still have two questions:
>>
>> First, do you have actual timing figures here -- how long did it take from one ctrl_c() invocation to the next ctrl_c() invocation. Use e.g. get_timer_us() to time this.
>>
>> Second, does this increase in break condition checking impact throughput of the UMS ?
> 
> Hi Marek
> 
> Time between 2 ctrl_c() invocation is around 100us, way to fast in my opinion.
> 
> UMS throughput is slightly impacted :
> before : 7.35 MB/s
> after : 7.17 MB/s
> 
> A better balance can be obtained with the following update :
> 
> static int sleep_thread(struct fsg_common *common)
>   {
>   	int	rc = 0;
> -	int i = 0, k = 0;
> +	int i = 0;
>   
>   	/* Wait until a signal arrives or we are woken up */
>   	for (;;) {
>   		if (common->thread_wakeup_needed)
>   			break;
>   
>   		if (++i == 20000) {
>   			busy_indicator();
>   			i = 0;
> -			k++;
> -		}
>   
> -		if (k == 10) {
>   			/* Handle START-STOP UNIT */
>   			if (common->eject)
>   				return -EPIPE;
>   
>   			/* Handle CTRL+C */
>   			if (ctrlc())
>   				return -EPIPE;
>   
>   			/* Check cable connection */
>   			if (!g_dnl_board_usb_cable_connected())
>   				return -EIO;
> -
> -			k = 0;

If k is not reset here, then the ++i==20000 above triggers only once ?

>   		}
>   		schedule();
>   		dm_usb_gadget_handle_interrupts(udcdev);
>   	}
> 
> Time between 2 ctrl_c() invocation is around 28ms.
> UMS throughput is not impacted (still around 7.35 MB/s)
> 
> I will send a v2.
> 
> Patrice


-- 
Best regards,
Marek Vasut
