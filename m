Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D66606A322
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oCjQHn1T;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Y4ijh7QY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 684DC6069F;
	Tue, 20 Oct 2026 13:53:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xBvYm5qlKBoA; Tue, 20 Oct 2026 13:53:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6876F605F8
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792504438;
	b=FjltPZwaWlrDCeRfp8Ch3xGxpwQ7q2BiOpXmsL2qcdI1mF2iUe7+OtjTZDafzhWSMJMK
	 l3oqplGZmmyswZZsplVtuRdTU5ReN08DTJWjkB//zw3lS1DXRK1nsDp9FB13qrENm8AfB
	 DSOn+NgpzD3FCYMcBbFQprr82iT+I9p+VbGyXiinrCpdRyxD0l1Po1iRUS+7vwLNci8qe
	 opQkcq/wvS22A9PfnwEKNxZXmNxNQxL8f8NJAuH/oQ9WNyk649w3YMkgXyF28WbSZtPge
	 U1Zvj72rEvwV+JFHwbljFaAv3H4I4ROQzDvseNiXOSK4DOkkeEwKmzucLx/N3Ym6inw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792504438;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hSgQaMd1c6JdtlX4WEjTETTi5y6VOzv8PfQoOkA1RlQ=;
	b=TL72dLVSovVCYqhO8HUCmEeQ8tnGEZM7GzZ1alqMgARwaZbjPw4Y9L8XQRPX027wgouI
	 hCcL3EnuZATNUQ5Hjge1WVuswF1iu8sh7eAShA4d8pXq4h1NSOlGfJd3CpvBhox6Rg24c
	 seIiqxKWvicmy6j3AVq4BVfQu6fWO1/1z01dS7uk7++mDmRJpmeQ5gOWMP3+JnSewraK/
	 kULHWpRc8/ov3HQPNH5rtTPjaYKw5lbPwmHHeK1A3+VGjYPDKhhEH7+ZSURMOs8xFXZYw
	 FiOvL7RW5wZWOEeHBIEVbRHu3F/AnzqFpC0wRcJH+k1w+aN+cKmgEGpLJ7y4iKLezog==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792504438;
	bh=hSgQaMd1c6JdtlX4WEjTETTi5y6VOzv8PfQoOkA1RlQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oCjQHn1Ttu1FttGbuZUvuKlS/6fkq2V3qli8wj4CAzk3cIVyuNb2tZ2lbkxGvNBeO
	 dbIbIqy9HHP1pPJEic7QGZQxaNAYhRvSycQnKfRxPsZm9VmkGcF9Zyqzk5fuPPAJi3
	 z6w6EgzHqPM0pPAKlL9C+0vC0vpy5/g7xqYutTSRY6Z3rQngXuKQmJC3D7a0J6Pl4J
	 QNlzUfNWqnPFQ0EWKcf06zAeb2ttOIbYLgUjybZ1jgLQwyyrq7w87F87IaScxAg8GE
	 NcE5s05xBoWQvjZzM4g36HRiOll/fPC5/lu68eTO57oYb8PLL3K84uTDkDtQAqvFWZ
	 i490XaZwFAf0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6876F605F8;
	Tue, 20 Oct 2026 13:53:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 533EF1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 398EC80D45
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:53:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uk840vXRNNmf for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:53:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 78D0280D3E
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792504436;
 b=miNY3OhTS3wHeFgb59foF3mE9x2jYD6HVxvxBoAvvqSAFOKwRHtcXbPAZnJdtQj53J+9
 mIuOGkEJ3tDgGjx9zIfv2gP5PCAaFskQQN1Kh05ND+dHFtmUBHC9RgcT30xhjbt0OEmND
 OLiX7IACnozAdOq4pqwhRCAJA6Lt5KgaCM2nSljjcWTUxI9UTxiKezlOHzlcNxPabiH31
 QPxAKGq8EjIpXieib1yze4MNcgi/zhR8sTwl5qKfUN74JGVUZlqHIl3TBVVDqerZzbR4O
 BQc3N+ctBZT4/Mvf6++qSh/dlGQmpjTNREtk6situia3pZSig7w53/RH80mh1R2cZgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792504436;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=hSgQaMd1c6JdtlX4WEjTETTi5y6VOzv8PfQoOkA1RlQ=;
 b=LWlNLf8gr+3TdGAYwYbm0yBN3F+jcVtVth+VczlnS3Yr1vCfsKGiMO+B9085CyCbH/aC
 o05b/m1poA2s11n90tlO40f2UdJYTSL48UzfZcey7cp/rs5ie9ENgLqjlOJWUWOMjpJ0a
 XmLwux2LKtim0SkEamtQ0QzI2S3eFRcoISsHhnBVYc65VsoHVTq6pB7QTJZNRMd3lJJrH
 MoqVsw3OSHt9fVOorVOHWJ2DwWAjghEmbMz5coVKkS+c5fxrU/M8avTN/LKjsfayFCh+m
 BJHW/kaVzsbclnQmFOdujIksPRcvsVDwrJa1QnM9VWCydZXQQNUfBmfjtg3WPA7yaOA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 spf=fail smtp.mailfrom=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Y4ijh7QY; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Y4ijh7QY
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78D0280D3E
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:53:52 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 837048432A; Tue, 20 Oct 2026 15:53:49 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D6C8056B
 for <u-boot@lists.denx.de>; Tue, 20 Oct 2026 15:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-53ec2cc397aso1934813b6e.1
 for <u-boot@lists.denx.de>; Tue, 20 Oct 2026 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792504420; x=1793109220; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hSgQaMd1c6JdtlX4WEjTETTi5y6VOzv8PfQoOkA1RlQ=;
 b=Y4ijh7QYG6jD3vsc3Lr/oRXSBJE0BcJJUiHOyhSfOBipxA1+pwHVWPmzrtC0Djk70N
 iq/xLTwEXv138z6gKtNsdF4zd0F1UKKAcuv9mjQNuA4kn+f31wq/J6A9YQ0ffV9Oc7fY
 Qbg6RPAI0f/D1oddRQR4rV8c+GKofXuoLRREc7tOCIPFdvIpcghv3fciupQs8Lml2PVS
 37h9PnDnzqmmzRV/RXTDaZ1UtUDHYgyjDBhKJHY0raOPjhFjhFBLZK16VQEnqv8XQx85
 1knIFW/b4qoguqCKFALTnNyEnqMry33yZWrU4ooVU6S5aX0mJN1IuSIyqQhwWkl9zGT3
 xJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792504420; x=1793109220;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hSgQaMd1c6JdtlX4WEjTETTi5y6VOzv8PfQoOkA1RlQ=;
 b=sNiI1ZEsJAXwHRLECElbiukQNhGUW+MK1b2MtImyqvwA7yINOh7lG/e/5dB+u5hDSL
 vZmDtLmEcEx/EogSLXe/FOOXUDaE5aaEESQvOGAzZThVPT8QJh4lDuIkkiA3he/uXHCy
 rSnJTZWbVyzpiolwiPF9WEtUwV9XXzGZnnH3ZDuNvKoakwwtZOS5IyIsaeUxbKNM3nu+
 Ma1Cyl9pCKxhwu6eOx+DLWGrO40dHZhKF9fVZ1VSwySTtF4EQmwBacwOIhad87S2kXoz
 hkZfRFLPBEb7I8qkly7dyKmHlDs34bMk8+ZFxwQ9QZO1lu0xb+jjsO9VjKA/ST9Y3Wpc
 WHYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSX7W/I02QL8ZFzRS3JeJTf+j842Hz4huvniT/eG4vbDudJnQi5X1Ob7Qxs0S4rMaxOaXQRBo=@lists.denx.de
X-Gm-Message-State: AFq9FYIPYuyP89kmhWxMJPMDpAWcxvleNyuS8Hu38wRvL0A31CIfqVxI
 3+U2SQ2junz6w6VfL+fHhzxcAR5bcjSe+0FwbrSwzQETwIoUlaa5xibS3Urmm5cWZu0=
X-Gm-Gg: AYBFou2Zar08blY/qsoBTWum37GJdiIOyFN9h86iGoCfGJC24ENQa/ZSACFHouQ8qp/
 Pzb50/WXGeCEfwleeqHcC1+zo35ULU22TrXefHUm6LJIFHUk4R6CCI5e/80oKelXakBN21yUY08
 QEyKynQlkellGdLgb/Zv1CxqbPtuBHY6aOQuldcnsHVdiBvYanfrt80iG+pmZ5Qn342jMKRuyd1
 VGC8MfEDl8R6kT7BnzfS6Ca3PVOStAtJ3ej8l8bmz5uIKyGFDtsvi8a1VWcQsKU7GLJu4Wh639u
 j7ayHN8bRTiSKMPemr/nr9hWwFdcb6tvGDQ1YqyXowBjQQEsxBdwg7d4wIkqv9osm+gXOeA/05A
 Eoc+r0TBrZgOI7tHcK3IpTmJi8s9Xg597vrfKiufHx5g/pKthOLnI8ZWpen/f0sAYRc+nEq4lhc
 pb3e5ajcQyZi7D8JKg0ti7eKtE7VAR3Zip41rjqUAo+cFHYmYTrYL/iRg6MzekCKSJxVFD8q2eF
 lluMAywsden3yhdtAW+a7iar9z5Mz+fX/v3etXMJ/rw/f3ySYkFzcZkhZTCSc6kBl3VNjsj2wc+
 Rky0CovFAs00NMC6O96v5+6G+EJcSQ==
X-Received: by 2002:a05:6808:130e:b0:4d6:90d3:e18c with SMTP id
 5614622812f47-53cd076574bmr7774636b6e.53.1792504420304; 
 Tue, 20 Oct 2026 06:53:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a238:1d98:cbad:952a?
 ([2600:8803:e7e4:500:a238:1d98:cbad:952a])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-543c90f6758sm4706107b6e.17.2026.10.20.06.53.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 06:53:38 -0700 (PDT)
Message-ID: <6c5172c5-8286-4194-bdfb-fdc56b289bc9@baylibre.com>
Date: Tue, 20 Oct 2026 08:53:34 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/24] clk: mediatek: more clock parent improvements
To: Shiji Yang <yangshiji66@outlook.com>
Cc: GSS_MTK_Uboot_upstream@mediatek.com, chunfeng.yun@mediatek.com,
 igor.belwon@mentallysanemainliners.org, jstephan@baylibre.com,
 lukma@denx.de, ryder.lee@mediatek.com, trini@konsulko.com,
 u-boot@lists.denx.de, weijie.gao@mediatek.com
References: <20260710-mtk-clk-parent-lookup-improvements-v2-0-f3f3a4a28dca@baylibre.com>
 <OSZPR01MB814012AD1C6775FB201D727EBC8A2@OSZPR01MB8140.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <OSZPR01MB814012AD1C6775FB201D727EBC8A2@OSZPR01MB8140.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/30/26 8:48 PM, Shiji Yang wrote:
> Hi, I noticed MT7981 doesn't boot on v2026.10-rc5. I guess the
> regression is caused by this patch set. Is there a quick fix for
> this issue before v2026.10 release?

This message ended up in my spam folder, so I did not see it until today.
Sorry about that.

The fix is commit 3ffad26f17cb ("clk: mediatek: fix using clocks before
relocation"). Unfortunately, that didn't make it into the release.

https://git.u-boot-project.org/u-boot/u-boot/-/commit/3ffad26f17cbe32df9b37f407b8984adecd97c0c

> 
> ```
> NOTICE:  BL2: v2.14.0(release):mt7981-nor-ddr4
> NOTICE:  BL2: Built : 08:05:04, May 21 2026
> NOTICE:  WDT: [40000000] Software reset (reboot)
> NOTICE:  EMI: Using DDR4 settings
> NOTICE:  EMI: complex R/W mem test passed
> NOTICE:  DRAM: 1024MB
> NOTICE:  CPU: MT7981 (1300MHz)
> NOTICE:  BL2: Booting BL31
> NOTICE:  BL31: v2.14.0(release):mt7981-nor-ddr4
> NOTICE:  BL31: Built : 08:05:04, May 21 2026
> serial_mtk serial@11002000: baud clock not defined
> serial_mtk serial@11002000: baud clock not defined
> serial_mtk serial@11002000: baud clock not defined
> serial_mtk serial@11002000: baud clock not defined
> serial_mtk serial@11002000: baud clock not defined
> No serial driver found
> resetting ...
> ```
> 
> Regards,
> Shiji Yang

