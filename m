Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB381C02191
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 09:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F24781B4B;
	Tue, 28 Jan 2025 10:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kRVWEKUQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F83381BC0; Tue, 28 Jan 2025 10:11:16 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 550258197D
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 10:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43635796b48so34044155e9.0
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 01:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738055474; x=1738660274;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nfnPXD1Qg+P4zdn2zi1ewTYkttu0IaiEMp446GaYfTA=;
 b=kRVWEKUQpAcV2B8mg1vDPKjkHl89Qaqth+x5JgJjnyke8ivku9taw4RWl2QJll0vXU
 b1n+lQGMo5oNvp+2TmDdJdgDboPHOieq9dn6X5/812KOu8HaoEXFkbuFJv+9HLo4vRxn
 Nw1vRLD7+le6TChoEqZjlQbuTC3frczyk+lCXWUZ7Qx4PtqT3RW+egG+XE40vZlY7M40
 3srUs5kUdJcHibZCKq3kDZbT2u9v8m0r1aTLUDS3RXe3gRZr/jtRLexm9HB7Vrp1pZNn
 3beG2vFnXqyIhD6JU5aAHSjYDyVos2cu7Uu4iEMiN5yaZysR3W3O+hc1QF2V+rquU0UH
 UkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738055474; x=1738660274;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nfnPXD1Qg+P4zdn2zi1ewTYkttu0IaiEMp446GaYfTA=;
 b=TWNXmd0upkTdeAVwED/XTiF6xpr76lEOiixoHZem1fq/9Uz8a8z39OqDchMZplXNdj
 gi6VBvLeB1XHu0OMuQ79CbnU7DjeI2kvNLWig99hqm0o7S5ylSdniIwiYL242tufMjoV
 Nyz3uCR/4oHMnW7d+09GTBgLdoQbWCiws7EBGNzb86XJ+OFUK8+/uyjHaqyOT+nqPFQb
 KUnFl7+St7j2fX0QFkV8/bpK8XRH2Gav9ym7DfC13MIUFuHEDZzBbjRwCNfZbrpH7SoB
 f9vUdor13BOctQKrZFamCMpvNHpqsB/ppo9dNX5YQfX7kbS0zVKBqQS+2B7+QsORtn8s
 OZpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhmOuHq+BqbLXm0weUzR8VIysqGxHByPMUArjDzJEoMlv3kcqjZVMhJgmiSXV0M4HWNQ0sF58=@lists.denx.de
X-Gm-Message-State: AOJu0YxGy1Ua23iB6AUbz8XRDAIZLY7Y76DGf7NcgIAinxv2H3Oamct/
 hOz0L+PD6o3gaqvTlQJQSHxKIfdIjGvdKu01PkGycaiB9BVuZtfkVJWf9XUolgc=
X-Gm-Gg: ASbGncuOBLFA+tJmvmP29qvE+1W7gqsLG9UfmYk+VyMsBxt0wm2bsv0bDm5+DAFqaYs
 lFdez7/g/sFn3sRXqp2xGdkq6gyHj+BfOZP0OEGAZH53zfx9WVvQ/n6IXuGN+TY5moQzUU1k9yj
 PO85q9EyG7CnWqOh0qGNdZsY+ctJj5tFH74xEWJa87XyIOPId2ujaIL+0eYudxNWU3mnOEFE5QW
 3LSkFvvuQ5WPZ0uGSQVRQYMQ8l/kEEM1cHWeQr2gJQV2bbaszBHbJRPLgsofEsh+PI4sNAA2SAu
 Aq6Tj7I/4M5qvuaMVLB+TRfotBKPPNz2mWU=
X-Google-Smtp-Source: AGHT+IHeCW++aMLoBbi42bx7ukcmEsi6XGt2fbt4TV2dqppoc9vfz9fVJkUrm7s7XbzMkdebWHr0Xw==
X-Received: by 2002:a05:600c:a012:b0:434:9e17:190c with SMTP id
 5b1f17b1804b1-438d57c2f7emr18369115e9.0.1738055473770; 
 Tue, 28 Jan 2025 01:11:13 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd501c2dsm159918065e9.13.2025.01.28.01.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 01:11:13 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Michael Ferolito
 <michaelsunn101@gmail.com>, u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v2] USB: Fix NULLPTR dereference when serial# is unset
In-Reply-To: <2f367a3a-659b-4fe5-be34-e270ee941866@denx.de>
References: <20250128003010.971175-1-michaelsunn101@gmail.com>
 <2f367a3a-659b-4fe5-be34-e270ee941866@denx.de>
Date: Tue, 28 Jan 2025 10:11:12 +0100
Message-ID: <87wmefqp5b.fsf@baylibre.com>
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

Hi Michael,

Thank you for the patch.

On mar., janv. 28, 2025 at 02:49, Marek Vasut <marex@denx.de> wrote:

> On 1/28/25 1:30 AM, Michael Ferolito wrote:
>> The current behaviour of this function will dereference a null pointer
>> if the serial# environment variable is unset. This was discovered on a
>> board where U-Boot did not have access to the first 256MB of ram,
>> resulting in a board crash.
>> In the event that U-Boot has full access to memory, it will still read
>> from address 0, which is probably not optimal.
>> This simple check is enough to fix it
>> 
>> Signed-off-by: Michael Ferolito <michaelsunn101@gmail.com>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Heiko Schocher <hs@denx.de>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> The subject tag is "usb: gadget: g_dnl:" instead of "USB:" , with that 
> fixed:
>
> Reviewed-by: Marek Vasut <marex@denx.de>

Agreed with Marek on this. Please add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

As well.

Marek, since this is gadget, can this go through my tree?
In that case, Michael, I can fix up the subject when applying (to avoid
you sending a v2)

Let me know if that works.

Thanks,
Mattijs


>
> Thanks
