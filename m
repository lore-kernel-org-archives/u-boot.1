Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98040E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 14:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E5B9801E8;
	Tue,  7 Jan 2025 15:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736261894;
	bh=sFSIZVc9U8ZRH4c6GJAF5sFnst0eFpNj4CamsMS0g/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iBCmFjtmgt8Ydsdljaxw9jfpKx6XhaMr9XoF7OdUH1rFmuyDVX0fv68fUp/M4tTci
	 NynfGOJZd+WKDAyAlf5s178JdGZT+izzqeseS5ZO00q0yuY9tCj83Rc/iZHEb55AtC
	 uAYmUlGSQjqATOrIr/9npYylx/IOepmGIW14iCH0BBhEyuSliR3l6ASSdk1FR4uYvY
	 Hbm0wUDbdPb8I4XSrKe7I9p5UQPDxv+W687S8pDOo7oIUcei1o8OYfiO4ZtQn9Rq4W
	 SDbvmLBTq6x9sMLk2qhG2KUWOXYvHOOdlNUOZEAkLIE4sG/9o8UcdB6BVpeooboJJU
	 O+cYwWWTz4gNA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 404DB801FD; Tue,  7 Jan 2025 15:58:12 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4431801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 15:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="DLu+65//"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B9318101C8551; Tue,  7 Jan 2025 15:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736261886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFSIZVc9U8ZRH4c6GJAF5sFnst0eFpNj4CamsMS0g/I=;
 b=DLu+65//SyhkNwvjuribQhbeoxUJoeOsHPF4tibJOGLOgXZVYKy8mh+LsYhCP+e4Q/bHye
 8t+xfhKKLz/GweUPoWvXGHRrRNDpqPvhFJzT3hgxt+pa3lH6NH2q4r3cbUpkj3llORk/QK
 qRW3am9CXUL50s3Yat91LRE/wAH8mg3FChrqsFWEELxy6WNDsksf0Dr0GQzJEsek0MaLvo
 aQ/jlhst1X8WUtqWFZxOogMQDyBPTz/Bf9DtFbOI66mkHzFQLY9OJgGwGLAyJTjc5mL0Ag
 VHOOgiJ5RWxc6SIIx1CORYn3igJipoNJivTSTfO5azggIAu9ERMaLkZqUG+ZyQ==
Message-ID: <6364ab97-51e5-4d9e-8591-bd6aa081f042@denx.de>
Date: Tue, 7 Jan 2025 15:49:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: Fix build errors when USB_DWC3_GADGET
 is disabled
To: Jonas Karlman <jonas@kwiboo.se>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240225152715.1821613-1-jonas@kwiboo.se>
 <d9d049c8-d498-48ec-87f6-4127dd7a4ae6@denx.de>
 <5bafad42-2c61-43eb-8fbb-cec7159132a6@kwiboo.se>
 <20240226014708.GH3040305@bill-the-cat>
 <81bdee81-2f8f-4fbf-a729-8fd543492adb@kwiboo.se>
 <a809eb32-ae70-4f69-b5f0-81488759e838@denx.de>
 <e14e9c06-ca37-4572-b410-c40a8c52898c@kwiboo.se>
 <1544e744-bbf7-4460-b2b4-12a971e70d49@denx.de>
 <7805b8d0-fb7c-41d5-8d74-f85dfd40233a@kwiboo.se>
 <87y1b2nfpn.fsf@baylibre.com>
 <6bf2af4a-740e-4cfc-9009-0892139738c3@kwiboo.se>
 <87a5jik9gk.fsf@baylibre.com> <5b5cba1e-b057-4d64-a836-603534d48620@denx.de>
 <87ed1edc3h.fsf@baylibre.com>
 <7893ae9a-3f2f-4377-90ec-f24655e55384@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <7893ae9a-3f2f-4377-90ec-f24655e55384@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/7/25 3:16 PM, Jonas Karlman wrote:

Hello everyone,

[...]

>> In both case, I could build succesfully on master with commit 6d41f0a39d64 ("Prepare v2025.01")
>>
>> So I think this is solved now. I'll let Jonas confirm.
> 
> Correct, this patch can now be ignored, this issue has been resolved and
> I was able to complete the move to use USB_DWC3_GENERIC with DWC2 GADGET
> for RK3328 in [2].
> 
> [2] https://patchwork.ozlabs.org/project/uboot/patch/20241008192719.2192430-1-jonas@kwiboo.se/
> 
> Please also take a look at an old unmerged cleanup patch at [3] :-)
> 
> https://patchwork.ozlabs.org/project/uboot/patch/20240121203818.2075381-1-jonas@kwiboo.se/
Thank you for confirming.

Shall I pick up the last patch ?
