Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A7B606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RUNhbChh;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=CVVgn21Y
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02CD86073E;
	Wed, 11 Nov 2026 08:47:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8HXAOQZsMv-0; Wed, 11 Nov 2026 08:47:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E7DD606DB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794386866;
	b=Z/HksY9K/HuyRWVV9jeecYdf5vFQiWAtqJAeFCKVweF/ZHqXFwWB04h6XY8MtCLLs38t
	 adxPpTnMMkriJ7fuf+Xf4/32geHxrLHofjQCv4qzSGOYheErnO1o6EKOGPXFGHks0N6TB
	 qLroJghXLFaSiTly3Jmw6RP2OAdbh3qfNmGjjaO6bme898UlhmisDFYmAspG/vcxhDMRn
	 x/jUWQvA4EOYsRBS7lC6SdDLwuVp4wC4E6UKllp6UwuMUQqx8EfColyYdXxILC8HlpBlZ
	 tpZYA1CVulgLosscJGdfEI8sNturKvJhc3ePgvnu/fKbvUafbFwpRK1pWJYDYlqdVYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794386866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mDGiEvexDGI8W4Z0R7qJlPcqP1Y+Vg+yZOaCHSnbUMo=;
	b=V2G9FdENyCe6GlYAUykm801UOuZYkqT6kHt+I2wkhYvbrZJ7z/IgEqqEPOUdCwoTGpY/
	 qXgXB68/PLt3fQY4aDc6T5oU4DCWkUCv/ofD8LgGiY92V/LRa1KsA5/FojwB9rhYnkcwB
	 nk2K3QA/7Sp+Y48a6ZpCQU1jw2apuIY6eDzvPy5wj0gBtGcMJH31TaLRj9MbIWbImym1t
	 +hgF0tRRtsaajX0I2qxlGSeaxrYU+6pKcfKLfZ6fY/UCkulM4qTKblLBB9wQWCFdGCEJ8
	 xIoNZO/FSIzuFAKjX1p8xMljb50NLn9xcxvrbOlAwgFbWfQFpwl4C0gZSZSWdZ+5S1A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794386866;
	bh=mDGiEvexDGI8W4Z0R7qJlPcqP1Y+Vg+yZOaCHSnbUMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RUNhbChh5sbnm/0zBkbKJfCc1r39CpxW4uXnrI6nmyXyKvtVBGjZG3Qrh2rL/nwGL
	 UVylCEoWGz9zW7KDsgLa+QwR/mgjg2acZBl9+FHnJW3GNWOjWQ4AjWa32fjrNfVU7j
	 Dnav4ztwdqjvkGNzl52i1F/pKVl9Xaec8wicxthUVSVSgC0IXvLe3E2TkUMln34ZC3
	 rXHhKJF3hrkHCWT3DFmRazG96deFmpjpqGLBv0A472N42LwlIS9IbERSySle7zGLuX
	 srED789yimko097J6EzKw5oIEYAMT3HJt2ITTqrRQOwABJ1YIxc9Py8cBJjCxA4qsV
	 uFP59uoKLSBOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E7DD606DB;
	Wed, 11 Nov 2026 08:47:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3102E17CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:47:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 165F181279
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:47:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fTS0BbFieZde for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 08:47:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E146C808A0
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=CVVgn21Y
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E146C808A0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:47:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1968810DDA3; Wed, 11 Nov 2026 09:47:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794386856;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=mDGiEvexDGI8W4Z0R7qJlPcqP1Y+Vg+yZOaCHSnbUMo=;
 b=CVVgn21YguFV7caau81N5FmAk0eTK1T5zM2KRXCTxsMAKR0qYDpp17Z9eRZHPhI+RZ3LU1
 Se6oetRGTjBDgwefmBaI5YQ7sns3sqg/N4hJ3zgh35ATHuu1YXBoZZVJCl7hBIMWptmn5X
 LoeSn0bYRcuv7DOe4J7cgBhXRS/+Pu1GiW9Yty6YPdPmS2RMkfZATNDNqpGHjvrK2QVFe5
 84xv1HSxxkb3TfZJZYD0ASI7DiCocxsg/EHtfTxu/iO0CkZIuJTM5o9A79GVZE4bKQW3dC
 NvLlaHAFw1HjExqOpq8M5Npimbrf01F+BhjeNnW6p+p83ofhcuA76lpZX5Q8rQ==
Message-ID: <3057eb46-25ff-a3d4-41ed-3a776a9fe117@nabladev.com>
Date: Wed, 11 Nov 2026 09:47:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [resend 1/2] i3c: dw: validate device index and clear slot on
 detach
Content-Language: en-US
To: alif.zakuan.yuslaimi@altera.com,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Tom Rini
 <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>
References: <20261106031830.13625-1-alif.zakuan.yuslaimi@altera.com>
 <20261106031830.13625-2-alif.zakuan.yuslaimi@altera.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20261106031830.13625-2-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Alif,

On 06.11.26 04:18, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> 
> dm_i3c_read/write indexed master->i3cdev[] without checking the device
> number or a NULL slot, which can crash on a bad index. Reject out-of-
> range and empty slots with -EINVAL.
> 
> On detach, clear the matching i3cdev[] entry so a later transfer cannot
> reuse a stale descriptor pointer. Leave num_i3cdevs unchanged so the
> existing dense listing path keeps its prior meaning.
> 
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   drivers/i3c/master/dw-i3c-master.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

@Dinesh: The patch is applied to me in patchwork, can I move it to you?
(Please send me your patchwork username, thanks!)

bye,
Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
