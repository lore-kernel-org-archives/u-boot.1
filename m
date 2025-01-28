Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BBEC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 09:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73E681B4B;
	Tue, 28 Jan 2025 10:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y2F/RVmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DA2581BC0; Tue, 28 Jan 2025 10:40:06 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56FC8819B1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 10:40:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so4259839f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 01:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738057201; x=1738662001;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XJsXYEz8EhfTr6dDIbRXyalVLvLtmdGoDIEaI+YeU8Y=;
 b=y2F/RVmTtl/E+OMYO8Xg/AQPqN9SWaHw+2G5iYEeOwuld7XWWPKtaHvtq/thwbeYPh
 QgPgbcMOjbHezXs8G8kRlFUt6naOqWYpBhJGAq6wAJF38rEWqvyoA/PkmkgyFhVRYX59
 /66h5hO2/IkmX3PSeGinAVDrg1wP9gglImidAFKNMXtdVfbjr1h+zeLbhczG/O8segc4
 ZqPptA08lOuKWlD25s5I/7X52ixHKODYt1YdwpnJz122AWZH6PWao0zt8Ez0ClKerQh1
 WliE6bPZbUf9QtZRYvInjAvp637Vl9DVV+D4SQQlTgRVE+yL1WfAGRExgUYWb0NDveiQ
 XPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738057201; x=1738662001;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XJsXYEz8EhfTr6dDIbRXyalVLvLtmdGoDIEaI+YeU8Y=;
 b=EfZTiCWYlMiUgm0fqAyixkg5C8plckqbRDaNWbuDqwbdfLJWQhjHQchTf3EcF5M6QI
 R8yrlFw4NEx97994naFYqxO6c+Ck4dsLro6rZo56N7uA5eN+pkhPlP3xwG5GXog5/nKi
 MffsoIItFqHqn6GKre01n5g+k3SXjM+aaiHJ8MxGvnYl6VmTbS5SDsDed107yOpx06YI
 a/wpSXrt2yr5DqXw/7neXFSoZ1+vajxa33Vle9UA3CVQn0de7JhQLPnNSwpzagySYKSv
 bzgNxuy5OYMc1ieqveArQ3IGvg6KrjXrhnpx4zWZVeEwArQ9x6s9RaJh8U8+jB8xz4v+
 4irA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEC0qK5V5rLkSq89/zt/pj2bkyYZb1Yu3fQrR0Jq2KuLO5uulschfac8n9rnx6cBqgTkBCRbg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyto2HQHOVowvoujAjDjrplIX5Pl/Yc3c5mpRrgh5qop3rgYVsJ
 HC3Y8gRVYbFeHJV9h4Y+1RitNAhPaROVCsHLbtxvn7WuhA9JCzYLiOD9ePOuyOc=
X-Gm-Gg: ASbGncudfQwQIp+5Xo+CRiYWjcN2qTT47w3wQSuF4S1bo0W3tU4csJyjNPkKjJYWweJ
 Jir2fBxpBO4/Fe4uBrPft6o8uPdQ1Jim2stdBCd4Md6zXpflfobOwPHQTQ1sggZGowbw1K9z931
 bwe/PpwH4kDz6HjsAF8n+ECmRwULiHY6H90z54PfdVK+6BV/Twxap9yc6yjpc7Fg3+Ll1Bw087/
 jMP7EQAb3sU+E7s8Qdm8LLq8zfT9UCEYJ8ZLzrxGCCu150tVOQHLCnvtimfNqvuMpiYLH8fJX2x
 OYa6O7guyNnKd/CuFklbXtQT
X-Google-Smtp-Source: AGHT+IHMqqCIkFEYbigNMuLOfEEdgvbOa59wuQOMJDB0L5EJe8kc+Q0mbrzUvSKnEzQsx1kk7S1vcw==
X-Received: by 2002:a05:6000:1f8e:b0:386:4a16:dadb with SMTP id
 ffacd0b85a97d-38c49a271famr2194350f8f.11.1738057200880; 
 Tue, 28 Jan 2025 01:40:00 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb0d4sm13926973f8f.69.2025.01.28.01.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 01:40:00 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: hs@denx.de, Marek Vasut <marex@denx.de>, Michael Ferolito
 <michaelsunn101@gmail.com>, u-boot@lists.denx.de
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v2] USB: Fix NULLPTR dereference when serial# is unset
In-Reply-To: <c502e02c-cb64-f0f5-82d0-9e8277fb956d@denx.de>
References: <20250128003010.971175-1-michaelsunn101@gmail.com>
 <2f367a3a-659b-4fe5-be34-e270ee941866@denx.de>
 <87wmefqp5b.fsf@baylibre.com>
 <c502e02c-cb64-f0f5-82d0-9e8277fb956d@denx.de>
Date: Tue, 28 Jan 2025 10:39:59 +0100
Message-ID: <87r04nqntc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Heiko,

On mar., janv. 28, 2025 at 10:17, Heiko Schocher <hs@denx.de> wrote:

> Hello Mattijs,
>
> On 28.01.25 10:11, Mattijs Korpershoek wrote:
>> Hi Michael,
>> 
>> Thank you for the patch.
>> 
>> On mar., janv. 28, 2025 at 02:49, Marek Vasut <marex@denx.de> wrote:
>> 
>>> On 1/28/25 1:30 AM, Michael Ferolito wrote:
>>>> The current behaviour of this function will dereference a null pointer
>>>> if the serial# environment variable is unset. This was discovered on a
>>>> board where U-Boot did not have access to the first 256MB of ram,
>>>> resulting in a board crash.
>>>> In the event that U-Boot has full access to memory, it will still read
>>>> from address 0, which is probably not optimal.
>>>> This simple check is enough to fix it
>>>>
>>>> Signed-off-by: Michael Ferolito <michaelsunn101@gmail.com>
>>>> Cc: Marek Vasut <marex@denx.de>
>>>> Cc: Heiko Schocher <hs@denx.de>
>>>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>>> The subject tag is "usb: gadget: g_dnl:" instead of "USB:" , with that
>>> fixed:
>>>
>>> Reviewed-by: Marek Vasut <marex@denx.de>
>> 
>> Agreed with Marek on this. Please add:
>> 
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> 
>> As well.
>> 
>> Marek, since this is gadget, can this go through my tree?
>> In that case, Michael, I can fix up the subject when applying (to avoid
>> you sending a v2)
>
> There is already a v4, see:
>
> https://lists.denx.de/pipermail/u-boot/2025-January/578746.html

Indeed. Seems I'm a bit slow today :)

Thanks for sharing the link.

>
> bye,
> Heiko
> -- 
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
