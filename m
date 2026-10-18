Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B85CCF2D4
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 23:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 562E380F71;
	Sun, 18 Oct 2026 23:08:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7xtkGaeHFXAc; Sun, 18 Oct 2026 23:08:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 95D9D80F6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792364914;
	b=YcITh/ppBEfIilCMwskHZfX+WSs6B8qSlG0/DLy7X6UEiCJqTk6qF2yyfeLgdu92ceBp
	 IbXF5VlVicvflwNPiqsM2D4Akx8J4ALC1cAntbytP1tbQoklyL1u+ziXu4HCh2VTiVoCq
	 npmZhVwDeBDxztl0bC7WkSf9D5a/y2rU6G5rYYPJyX5IiCnEQDGXrs7WReF3QQFzr/F/s
	 3h21pcM+dLjWdhyk77/rjfRYuPQbHyznMxGWOUC7ZXalw2hS/+AFDlw7auI8yrPfNz1ER
	 m8HZ3ggGKhtIJaT/zBP6qmqPa6QLWqlviyiFzq84ELrBUslZInH+3wmg8LRjoISWFrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792364914;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JJvS32CC7T0XqUm78ID6L+3lokheKK0+emfkkNlybzA=;
	b=RxcdJw1kJit4IpOGQ/oI4NeKw9ouWjwvem4GTOav0cSdYWYBL3ViXmm6kkqT49BqVspA
	 OMQWaHHHqN/eKnWp9FXrUqw0TsatSsSHtFEwWQe8vwAyoMNuA5GarC3+Z7KNA+FuURAkm
	 ScJwOGVdOr8MGUTBL6+o9ghOpceyUZKXB5/wS/cgw63LPH+khyVybrYeFoWFalYpBXh9R
	 KQkHdqlC556xpjZEmQtQIRdlP8RwgimgmKH3jtYgcJTw3B21okBzfBzSvX2JBeqycve6B
	 32InndQjpKx0WEjyDLZklG0TJAKmKHmMGuV2+ysEKeddjGylaFyO2GS81RIgOjWtxjg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=RJPo75M2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792364914;
	bh=JJvS32CC7T0XqUm78ID6L+3lokheKK0+emfkkNlybzA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DTqryS+bczKz8nzn7WL4p03ma9x3yI1/6hvNcJLh8KyXqod0CtZ7qugWEUvEqZwv/
	 WAsSXnIuE60lEW9Xko6H2EU3Z4rgA94sQBlRT3rVuPAaaTmgRQFGchQWsWF2X/+hKT
	 MLHfZz71KKE55HPkT08MV/0gnuBoLMMDEr2WgSX3Rk5b6T8HPeAJp3dmC5wsPe6Ppv
	 D6MsfKoEwbZkSLofQ6vSDYh/y2x9mDRZ6QlVSlijli0P+OXLkuxQHoOogpCGsDhI7q
	 KEsycJAqS1JDnmMXfAsoRfOrK+eL/2+EYBLbQweftEEkmxiY0huObFtWDQWtdVzec0
	 igrmLhwbF0hTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95D9D80F6E;
	Sun, 18 Oct 2026 23:08:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A149769
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FD9280F6E
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:08:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JzG5EZX_Qgpk for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 23:08:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F3B9F80C43
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792364912;
 b=pJuLb7RFP7O3R/a6j5r5+dsYOBJJTMt/x1XlcJFy8pUJVz8ZF2pY/RxXt24OY6GOjnlq
 h6javmZXR7q0kwAZs01bTQrfdejBN4cn95bw5Pmv+DhR78fjbAiYd1ay9BdORt9L9JnKo
 rGSwNQEhBcKiuZCH5XRdonAqaXblHBDthnP3toxus57P6Rib6iwVh6jqXFD0aGWQflapT
 tFPIMamdVA3rnYWqi559nePuOM+ImJHQeZkY8FyktjA+Mo9LGxL/qjbYdP32cehnU/Nd1
 41lGw8xapSxXNsFl+zYdvIKN2lgulscKrk8UClpH1UEyAF3n4xYebqrdLuTbKJny8lg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792364912;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=JJvS32CC7T0XqUm78ID6L+3lokheKK0+emfkkNlybzA=;
 b=g2Q1qn9hostQLRTG4gWoGVADna2m+49ISz2Xo/vqvMtgN+jaYVQ/mhWeikvjMaoDZClE
 DeBDg6+Zj4IOKHwb5QV8gKW1VzkrvR14lvs4Z+BOYRXeGJ9uHFMavtIFGGJQfJqFTfT0W
 esshUBKJPiRSUoNV0eNCdiLs/mFgRmRwe/Rv/DxZMKxNu4G2ncpM9KqHj0Rebb8ii07gF
 pedX0EgaT/0BrYgIn9IR52cJ9QO/vjKCxBxpxjuYaEw6Yvwcn1Skedqut+NQIBQnBuwJ6
 V4yknpR2mzB3ybLL6yWeQEEfjuF4mfirBFOP435nxH6wxSk/TLXnkUHc5yXA5k+EvWQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=RJPo75M2; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=RJPo75M2
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3B9F80C43
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:08:31 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j7Dqv2T4rzKnTD;
 Mon, 19 Oct 2026 01:08:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792364907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJvS32CC7T0XqUm78ID6L+3lokheKK0+emfkkNlybzA=;
 b=RJPo75M2MA2tdb48oIxAykOfWh8lKD65XlWDnTswJ77uZyp+jsTXy/HVrGpVxsgstR9MxV
 c7SeLdjPtISo65bdkl1VmkoF2EgeSeGsc+krW3Gx0TOr6oMBuwFLmX32JFK9G7ETOYUNMI
 albEhGQTF79HohyImLd7tx1VttmfauObT71LLrdQu06sS76/if81UMwyMEDK7p+Nc6YOfi
 IaTHCiNO89QhNYT35vxlsTaZUDLflFun4nJMWnpRPaXavGCXjJ+rnt5o+T/pwxvH+RNNZq
 Siw0/+lqKpnTV8aieB20IJz3zobHqcoeWK5kfPBU3V69XIJ+JUwa1hJSH2JxdA==
Message-ID: <17e7f022-45e8-4b0d-bac5-92064e545a6e@mailbox.org>
Date: Sun, 18 Oct 2026 23:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] usb: ehci-vf: use usb_get_dr_mode()
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261018193622.2896690-1-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261018193622.2896690-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 43af7f27614f1da8925
X-MBO-RS-META: 4ognrgqugiiyjjk79nwa93ie85i3gxib
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

On 10/18/26 9:36 PM, Mehmet Fide wrote:
> Hi Marek,
> 
> On 2026-10-16, Marek Vasut wrote:
>> Please split this into two patches:
>> - First - only the macro replacements
>> - Second - any additional clean ups
> 
> Will do in v7: the first patch only replaces the private enum and the
> strcmp() chain with usb_get_dr_mode(), the second moves the ID detect
> gpio request to the device.
> 
>> This has to check return value, gpio_request_by_name() can return
>> negative error.
>>
>> This has to check return value, dm_gpio_get_value() can return negative
>> error.
> 
> Both checked in v7; only -ENOENT from the request is tolerated, as the
> property is optional, and keeps the port in device mode as before.
> 
>> Thus far, USB_DR_MODE_UNKNOWN or equivalent undecodable dr_mode made
>> this function return -EINVAL ...
>> ... Now it seems to be handled as host ?
> 
> Yes, v6 changed that by mistake. v7 keeps the old behaviour: a missing
> property means host, a value the driver does not know fails with
> -EINVAL.
Thank you.
