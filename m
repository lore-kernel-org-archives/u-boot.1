Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF005E7718B
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 18:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19411803DF;
	Tue, 31 Dec 2024 19:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1735668805;
	bh=Be0+ZGwDVFUtq4NokCWC+5L0G2/7kiLP2BTq2tm/Av8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XQl3LJzD0EyEcg5jOH6aqFmdzqRxhZsRX+mjdn+Q7SZe081uYsDB4MoRLYV9HybAS
	 ltpPuUW9uv2rQ+KVYrQtgygJFe2bDS1Z4uV5WICAeWMKAz6RepBxEyhBHywMBlk3nu
	 XjoMZOmcPTNJPzfMbe5yU24c3Xr0yiw34ODOg0MyqH25zjw6xu+dVnYJIC+Vbr4QxM
	 8pmJPdAFN7BFdSrTOqfDAE/MBHmnJwhAH3rfL2Q7Cgbv9YZkRsqDiyO72qmrtAZ5y5
	 mo/D+ZBEPw52gnHp30zMhvWkws7ZihLmrO36WeM0vvqd0P5pV9/ZBHe7jW7uzRppFo
	 ZITk77JSwM6IQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 933F4801CE; Tue, 31 Dec 2024 19:13:23 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC7280374
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 19:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="HBPhyQHv"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 228F810486D91; Tue, 31 Dec 2024 19:13:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1735668801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Be0+ZGwDVFUtq4NokCWC+5L0G2/7kiLP2BTq2tm/Av8=;
 b=HBPhyQHv1IC8+r1KFm/D9IPyJS/S/mAbe6pqV1Z10gbDLCUznT2mVurznqbnfPvxb+m0UI
 MD9p7QZI75NfVUfvVO54Ayeyf5z8jftVaKbUYCG0fG4Dx9/dTLIY5eCGIE2tiWkVo3xs3m
 u3CFEVVfJEGpkFNBF1f2ajkxnpH0Rjg/9RiKS8G6k2imH++O9tG5TA+RSgXOyWduBr61vn
 bYyOBeMnaJYTdg21h2v4Ni1KXyyADTKPFWeNvAc2ywgnvelxsEWlsXx9Ak+7A+U7CVlX4y
 4ZmAS4KFdZKEmmLZf3IE9mrNc/SJ6UnI1PfzBf4oFqVMpInNEWIJ5WIRc1EaAg==
Message-ID: <66766bd5-1397-402a-9605-187eec1ee905@denx.de>
Date: Tue, 31 Dec 2024 19:10:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] usb: dwc2: Replace uint<x>_t types with u<x>
To: liujh2818@outlook.com, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
 <20241230-dwc2-dev-v2-8-12cd9b8a2358@outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241230-dwc2-dev-v2-8-12cd9b8a2358@outlook.com>
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

On 12/30/24 4:30 AM, Junhui Liu via B4 Relay wrote:
> From: Kongyang Liu <seashell11234455@gmail.com>
> 
> Updates all instances of uint8_t, uint16_t, and uint32_t to u8, u16, and
> u32 respectively, ensuring consistent use of kernel-preferred types and
> resolving checkpatch.pl warnings.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Signed-off-by: Junhui Liu <liujh2818@outlook.com>
Reviewed-by: Marek Vasut <marex@denx.de>
