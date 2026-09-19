Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75360C982DA
	for <u-boot@archiver.kernel.org>; Sat, 19 Sep 2026 11:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EB1460B9E;
	Sat, 19 Sep 2026 11:21:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8XDUl0kO_8QR; Sat, 19 Sep 2026 11:21:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1EA9C606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789816862;
	b=Pj268A6mmhU4jiIg3BcaVuIOc32R+jlmAxafhGFUKqrHbvIyclQUG+V8RDgCCPM29/Kf
	 Rw7qehDC6c2VRfJRr5X1cuJ+eTL/QGa/WDqQdrcirrBqjCXqxWKBA9xeDLHWrU4FyhNdL
	 UDnkEI30NZFUjhoiIHwFAC8q21yKvkVUy5Q7EYEzo3I5jOpZlKPYT3+cFBnxVaQLTumZD
	 dR9YJHhap9lnZ8XmTHiMU83KXqNhJSjquF+2PhvFH4LBC5HqhyuaDswmI2MOTrH5HeCzk
	 JeK/BGT6Cccl1LoUatutGz45GiCHfVkmSaoh0p7d5NBIh9cc8STZtUu3ywyRW+ezuLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789816862;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1S1HEJbhO2Oe1SnTjQwNZ/RuXwtlHYgZwj6Sfb/6j00=;
	b=XZOJR8XtRSy4Mpte2ix02A6/KkSkfJiYzeqeJ6NyK2q7DkvS6uuEkqWlfq8FTtmhc+pu
	 w1LE9ltEZeYPfWnYRTB3TiX/hMRL3mOh7H0nbeWV67Z5u8ye8KnDtJa3de0sEfT7AQ+9s
	 LDFaEMkf4H8c8s9qPbWi9IAOFfrDo+asdWlRftEYkpxotNn5H9uVIXq4olvsZHneZglc4
	 O5DK9y/l0XQgJosGyQYidbWzB2Yj++K3nqBhL9DGK9Rli7fsJk4JGAMAz1PbwpiYgTTzI
	 oLh9dWfVHAItV2ksHuY/v1j3Y3nlwZj3jPggJ0uxq6BlNKDinSgECwByfJYbmlvsdpA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=embetrix.com;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=uUtZ+mJL;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=XWMpHcsB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789816862;
	bh=1S1HEJbhO2Oe1SnTjQwNZ/RuXwtlHYgZwj6Sfb/6j00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mhD/CSS+mV7EvcIJQ4ObSuAQLZzb1yCgzW3sVoMjbpkGjbVvkK0N0oEATByCZNOlu
	 0EcYu3pIrVGipweeEyyp5DX2T8ZZy3KeSSuQBKqCuNmVh2mDv3rWaOs+2/bYfsLQlL
	 uYiVh5jxgT4Rm8ZdHdoU49CqePKEhDZBD7yxpVVVA1lHEZDSK5xE60jUrQ5DUemmR+
	 mfmO0UcT+qA3nnliA7iEiP+izMKEX/eVkgXKE/7/rUwhFFYasegz9K3L2KwopeVkcx
	 c4QA+MKjoFiPZAZryodUFkGS/urBQdbD5XdoZS55fjczS3+zdREEhU7PMrreLCw6LR
	 rIjzfJTTo5qBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EA9C606B0;
	Sat, 19 Sep 2026 11:21:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B7565237
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 11:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D2C5606B0
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 11:20:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G1rLsafdnRdZ for <u-boot@lists.u-boot-project.org>;
 Sat, 19 Sep 2026 11:20:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7371760680
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789816857;
 b=SYTVJZcpLRp4KN4Vuq9+OWYOXfhXPWxZIO7dhQK8DjsANgf55BHAFz6ufk0y9yirwwX4
 0m0am9oUhy4qWljmNZtO+9gpMTAxTSL8oFqecSEE/UpwJqI/VK/MuAN0+KwOeGzc3rJOO
 XHsHbh/ClveqOJSIg4bRjVACB7xlt1+WGBIlPLs6WevYjDJu9LcZyoy1eL7VUVodIKpQ/
 UckmN9FsfayELKFI13nrNMvgrprxpemvA+cnR4LjEf5uIVJjLP6zVjlKJdt08KRZp0Erw
 7yYCHi/doY7w5nq7HxU6nPAs76zLK6TeP5kZoeBjiWi8wKOt0VxwBmo2RNc/mELKhBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789816857;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=1S1HEJbhO2Oe1SnTjQwNZ/RuXwtlHYgZwj6Sfb/6j00=;
 b=lrtb401s52Khmng8f5K4YsWhAdCW0rJBlSutOMrt/nm55BdPBudYMQqaHUmVdt/hH3oW
 lTr4E/deiFHvduayWNF7NuKugCqfJlMUqsXyFpDyLV1h1zfwtdyCd9iVE+rd+8dG1cbSA
 y0UfQT8uIyBxxotpcqMtw53q5cohczLWiNIHMTyAZng0fBEbwcwafhMNVljeA0aXG/j6E
 nuxk1drKc7FCKz86276Z4kzHZXTFes6Tkaf1eUqOXGXnYo3gsxHCD+bf5efG70yqx5LSm
 eB+1HKHg0S0tXXeLL95vAQAGg7N2Vp0VVNeG35eNihNWhHDUIA+HMXadzPbK8gH4wyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=embetrix.com; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=uUtZ+mJL; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=XWMpHcsB; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=uUtZ+mJL; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=XWMpHcsB
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7371760680
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789816849;
 x=1790421649; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
 subject:mime-version:date:message-id:from;
 bh=1S1HEJbhO2Oe1SnTjQwNZ/RuXwtlHYgZwj6Sfb/6j00=;
 b=uUtZ+mJLyvVZKhcS2dPgz49bIAC0Hsc/POR8nmj7v4s49nZ9WtefwI8wsTif1spu4b/jWeUKCyBEl
 fg+w84uY5uIEwq4LChhQ+SgY2+1xhse0aEHLQRQhxiwggoBOT0dz6aksg8eX5Ts6rRCxGx+091xhEA
 7I3ApIFCCP5tKgiLSPmE7zapHqmiSQh8uKJtfuzQdAS5d5kWvDFMlcFx9zOZnnmlFuGTEnMm/bZor/
 AUhA1oj3rSp9bcKhjLvcsk9EOkwm0OayBcVlgjNGBtXfNJFBkUcicv11hys6Og4ULlK4Xx2IgFkhA3
 wIE0R17J5VQMRh3c++8lFDHAB6o5t8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789816849;
 x=1790421649; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
 subject:mime-version:date:message-id:from;
 bh=1S1HEJbhO2Oe1SnTjQwNZ/RuXwtlHYgZwj6Sfb/6j00=;
 b=XWMpHcsBYybm8bODkOdT9Y/fWTdY4ZgNQ/BhLtP/O9CjSde/DRyoL7+Cm31WY4kWs9+id8BfkbotZ
 cLk4PxMAA==
X-HalOne-ID: 27e38268-b41c-11f1-b11c-7d3e33f7de26
Received: from [192.168.1.127] (unknown [41.248.237.113])
 by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id 27e38268-b41c-11f1-b11c-7d3e33f7de26;
 Sat, 19 Sep 2026 11:20:48 +0000 (UTC)
Message-ID: <f28b0931-be5d-4017-8f37-121f5c68706c@embetrix.com>
Date: Sat, 19 Sep 2026 12:20:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] doc: describe ML-DSA verification
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, mkorpershoek@kernel.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 pbrobinson@gmail.com, dlechner@baylibre.com, hs@nabladev.com,
 heiko@sntech.de, raymondmaoca@gmail.com
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918172127.66014-5-ayoub.zaki@embetrix.com>
 <ECE3740A-001A-4481-8471-5157A934D25C@gmx.de>
Content-Language: en-US
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
In-Reply-To: <ECE3740A-001A-4481-8471-5157A934D25C@gmx.de>
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


Hi Heinrich,

On 9/18/26 18:45, Heinrich Schuchardt wrote:
> Can we add the api header to doc/api/ and link the generated documentation here?
> 
I’ll add the generated API documentation under doc/api and
link it here in v2 if we proceed with this approach.
That depends on whether Tom prefers the Linux kernel based 
implementation for now or waiting for mbedTLS support to mature.

Mit freundlichen Grüßen / Kind regards

-- 
Ayoub Zaki
Embedded Systems Consultant

Vaihinger Straße 2/1
D-71634 Ludwigsburg

Email    : ayoub.zaki@embetrix.com
Homepage : https://embetrix.com
VAT No.  : DE313902634

