Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4BAC88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 19:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0BF24052E;
	Tue, 15 Sep 2026 19:13:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LIkRstrEnV2a; Tue, 15 Sep 2026 19:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0BF1E4050E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789499596;
	b=Mu4fddnJ9R0i3luHf8I4Lvu5q6Cby+EVS7yuneTwIjytJUoSqJ4S1+nWkjaMPcuTOc3O
	 s46VKFayMxeO/kevtnJ3DaGbjQcFz7PiEQ3L9Fq8EKSJI2KHnr9pR27ERdA7ovsuAxWCZ
	 mqUL/vqnw61Y6S7v5I+nTjjnNcF6ZAWflEaX+PyrxfH+DAB1Lw6+85g/v9yDC7iGSPdvr
	 6gr12FBKc3U7yR9YCAKfGyJL3KydkryM+yBNipIGwmYRp3TU4fFHYlbCH/Ty7nY73tMrA
	 2/pslXqORMVn3xtyfc8LYM8F2pogqOtXtomEBTRt+sxljHaBaXR7l3quyn7h6NDcR4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789499596;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A0w0qak/tUT3ryg8g6IKt8MM6AqomORh+3bQd8GPsqI=;
	b=ZipvTeoGa227CMom6Y+Mzgt9kkMECMIUBHaQhikmissxURsh2g2MQON9lop7XkKZqVGv
	 BsAfhwyi07Ymi4ZYEGAvhWT6nRR8rCEa8ho7emLiLfaBL6y7/QZvHhSQojEQLnVJI7cbj
	 dpj+bLlEndXx0mYKvWSlSKc0rKTzZDJAxZMiA+QYLIcQ18FY08bFHkJm8Pkfn474/4lkM
	 1fVq19/z82yFrK9nzcPhIaBkfqT/rp1Wiecmmi+KAt4z3CgyXyIucliUwU90K5t0G2we8
	 QOID6lJZBkglqBdyZM4aUStEDHgHkB1iY0xlKSSC0543LTe5yotjII7s8KejSH6NLgA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789499596;
	bh=A0w0qak/tUT3ryg8g6IKt8MM6AqomORh+3bQd8GPsqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dot4rwvc2HKx4s/VDl0S1oCajQZ/uuH5rSnnscgykM60Mk4RMgBGa5WeJl71z5Gwv
	 TBjN511tYSiLDDls/e1ggSqjtF/t2EPAPpYdHe+h+lgZlmhbicn9e5MdyKXGA1Ky3g
	 57Y6zyCROateeb/U6PqTAVh0UePzEDb5KWS0asXkUH4LBL1MF3F21CCGcCVmo0TJke
	 C8h0VB9zpiYkzj4xRu1QS4pl9LJeN+/TPgvstWOP3SuewPm1U4qwP0SJkY7MsTN4d5
	 mulKmxGDW/X0RuNBJIZbHAwrusflbD01CGIeeZa9BK2tADp5o69esHADk8pzg211Hm
	 QRtksqpFmJ+DA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BF1E4050E;
	Tue, 15 Sep 2026 19:13:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 08B162D0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 19:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E16A880790
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 19:13:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zE-7Od84df62 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 19:13:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D2E91806BA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=31.31.198.150
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789499593;
 b=OfQFgkKQsRaSo7jK/Ea4dcILIxbhnaUqdkWp+TTB7rL2VYnsBWlHMi3X4w0GoUwiuzt1
 RSpShhcJ0TZuoGzszDjIgA9TlJcNXt2cCwb/wneVjAOivz4RLuuYcGDTdCmeSwB5V5nLB
 qQBoPP69RmmjmiYU8vr8rbpb5JNcKYnFo32W6itG7FJGSmDH//2KknRXo+yZP3pc5/6PS
 cVUPUk+X0BGb8LrIeV9LenhVicdD+UDKxoEcFn8PvW93PkAVTsKJGEeDeplsSUOa3CvdY
 qtv7yZ1U5AIqo5XBppEcPVTyOIuSBP073gRTz7CCd6vJqBnUvTDkDCHcajjLVcZYpWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789499593;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=A0w0qak/tUT3ryg8g6IKt8MM6AqomORh+3bQd8GPsqI=;
 b=Vlk5Krl5ckkWAohHi9EWzm3IgWhxwMUhoALgQKZE4ZFRXqYLfaXX0sfMlhf+2MOdFvQW
 32DFu1YrCSP9crzKLlNjjmQhltfal7gSDhhTVK/EQ7i1L53AdPTkMG7cnAQ8L6isJ5gt3
 SbCuAVAojf4ppPG3xn3jsEQI7ttXDQ8+TgGR+jrSR3S63QKJZkaAjWiLctdG9bIO5pi6l
 t2Qmoxqp4FbsE7v09aWCHp+GS1Z74eLhBwZ33XjdQHKMCsJJrnEkkt/e/MpUvBf+lp+it
 m3XZOp9LVWVedbXZUZCIo9hsn8XtNeTgo2cu493Xk1MOC6UrDqMHyl2TH4RrhwiXA5g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=minlexx.ru; 
 dkim=pass header.d=minlexx.ru header.i=@minlexx.ru header.a=rsa-sha256
 header.s=dkim header.b=slD8iIt+; 
 arc=none smtp.remote-ip=31.31.198.150
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=31.31.198.150;
 helo=sm24.hosting.reg.ru; envelope-from=alexeymin@minlexx.ru;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=minlexx.ru
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=minlexx.ru header.i=@minlexx.ru
 header.a=rsa-sha256 header.s=dkim header.b=slD8iIt+
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2E91806BA
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 19:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A0w0qak/tUT3ryg8g6IKt8MM6AqomORh+3bQd8GPsqI=; b=slD8iIt+U97R3d3jFJpbufs9YT
 B+FQtNCwPJIkR+DuB75RsKUSt/no4DlcbOpnb8xL0qo8+QytS+NYpwtP1lpvkllTp2hFIRCMjgOnV
 4x4wETiUHQcJfZ1GOQg+eFKWjsT1WVIlHRfcY+vGYc1WSNjjqCa6AOEIwEM2lRu8DEYg=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_128_GCM_SHA256 (envelope-from <alexeymin@minlexx.ru>)
 id 1x6YaW-00000007PpP-2rUd; Tue, 15 Sep 2026 22:13:05 +0300
Message-ID: <908fe697-c858-4e9a-938a-d17d08556307@minlexx.ru>
Date: Tue, 15 Sep 2026 22:13:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] clk: qcom: Add an option to poll for GDSCR
 GDSC_POWER_ON bit
To: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20260912072619.244101-2-imkyufie@gmail.com>
 <20260912072619.244101-5-imkyufie@gmail.com>
 <461c7cb9-0e21-464a-9d11-72239ead6e93@minlexx.ru>
 <CAAq9HC4tA2CvgQxgT4fDKA7AJP-8vzOi_bOdBS31JpHcJSeDig@mail.gmail.com>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <CAAq9HC4tA2CvgQxgT4fDKA7AJP-8vzOi_bOdBS31JpHcJSeDig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 15.09.2026 14:20, Reza Kurniawan via groups.io wrote:

> On Tue, Sep 15, 2026 at 4:45 PM Alexey Minnekhanov <alexeymin@minlexx.ru> wrote:
>>
>> Hi,
>>
>> It's doing the same as the patch that was already posted, right? [1]
>>
>> Sadly it got no reviews, which kind of demotivates any further
>> contributions to u-boot/qcom.
>>
>> [1]
>> https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-4-27704470a24c@fairphone.com/
>>
>
> Hi,
> 
> I didn't know about the submission when I was making this, apologies.
> 
> Yes, you're right, it is doing the same thing as your patch.
> I also wish it could be applied first, then I could put mine on top of it.
> It seems like a more elegant solution compared to my own.
> 
> --
> Regards,
> Reza Kurniawan
> 

No problems! Your solution is also a solution, abeit very specific one;
I think the difference is having bit-flags is a bit more flexible than a
boolean true/false flag, and a bit closer to linux clk-qcom drivers.

I'd be glad if situation with broken GDSC hadling for older SoCs is
resolved in one way or another, that would already be a progress.

--
Regards,
Alexey Minnekhanov
