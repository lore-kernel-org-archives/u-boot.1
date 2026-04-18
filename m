Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840ACF99C8E
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 19:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DABEB83B99;
	Sat, 18 Apr 2026 21:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RMk2I6eT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC07083BC8; Sat, 18 Apr 2026 21:46:52 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2239839D9
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 21:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 04A853F181
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776541610;
 bh=5LJbTD52cXOmeB3S8dHi6Bo82WXTMAeVeWR89Pj9DKk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=RMk2I6eTfwf0sjE3GAhMMC4dVp72i9lpJ47yV3B+A6OB6mfbJL0tN3vGwMeLzPJbw
 pt8kETKWdRmFQxx3ifoazpo/REt57cuffBKNsu+OQMSpWwae/XXKeFB5TgFe0QRJwF
 atqsBggwaFdO6AxqVz2//VcqZVWWWE/t+dDjhdDJNS7tQKrhAjRtAs1SKzbYSHrV87
 cOlIsnFoIJMBwdpEef9aTaried+SsbKvawjDH/OqHyr1kg/NEngSEJ0ZmstA55KAWd
 dKnR4/GQHYrhE0sqBDF22iaBg+H6fMREhrUOnGRLb774c78a9HDlZ/S+nTklWTrziS
 a3u1IHy+IDPA++sPRf6qfaL+GQPTVtCJzWPzgF+R2jLSqpmbhQ5TWAeyXTYptYHDQx
 rlAYlDgulGZU+KUOcdIzeEIfG939/JObjKW6HKYTR3fLj1UfE/5FwIdWIqI9wj178E
 YOjwHgX4cLD8NdQJITt8MPbC7KNDHOfQ9mn1G3/Oavw68HEiwkahr1beCaoHhdGhA8
 4Kv9HMibiKJ5Ds05eFNIllpfhwvxExO1gORo4H2K2gKC6xeAJnjS+h1RhHlJ/xLgh7
 VoiZ4r8tME2HWz73supgcc4td4cNV6QQHK3FJ/2229r+MdNiWnnykh6zAUQ4ON3bzX
 yx/VTZVhclqTmA/yGi3rKdOk=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43cfb72377bso1695710f8f.2
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 12:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776541609; x=1777146409;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5LJbTD52cXOmeB3S8dHi6Bo82WXTMAeVeWR89Pj9DKk=;
 b=Pmm6FScQTijsUxoY4tjtvUgDKN2oxG99Bx/7a44CtpahH0wHeJ+C0Duo0dYzysbWQT
 JwphwJJ+zaitWD1Pt9IlQYCZ12JfssoC1Agw4eWBumwZcXvrRDRcbXEp4boqKP4blRmV
 qnPYiUXV/xTirwiTPJyQhB+N+i8IzI6ZOZE+8BsDJXZ2PcsJ5IrUmHJajY20FE8UFrMF
 dXXgcVFvEViqyVGkPgiVCVPmP8VB4r1KESyutWqos/+IReCumnHd2nRKT3iyEvytGv3n
 hzsLuUEaCH835TWRNrOZ6kCEx/QdjxuQ/5jmI7ToKyHZgxuy3AdMfF7owCOQ1RK50QqH
 2Hnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4oqDgkB92p75eZWkvM34eOFH0C+r+3wa8aZavIa2gb0ProfWlMluChJOB9okEFLEg4L3wA/o=@lists.denx.de
X-Gm-Message-State: AOJu0YxWc8vEL5rqGCGCQ/O1LjHVi8etyu8DH5jkqoVKHWEsCrsqMqr0
 boFuK709pshUR5jcikBCeddVnTPGt8uUmuXTXdbD5soHbVzJxB17KokhLELEAZYpkgurwQf+htV
 EGOWeSNJG7UQ33VftgUEDeKTXzVUGoWLn+IOrvdI+ZOye+COQudE6kZFZfIhV5tPMmK9Qxmw=
X-Gm-Gg: AeBDieu1o+BSTwUtMRO5C3+HSVd26Yrywm85UjApBNk8R8U4Js/ECIDfeaTJP2yxrPI
 gUQq6lcI2DN6lMDcpBb1wxgU363LzLUCAf8wG3KwweOneLwou77dJHe4EiSbf1cq0v2nkrtnlS/
 rPYUg12DYayODjK32K0OrthpPpInQtB14lEoK1QwzMcmzYhyeJLGD6KTR3D7tLqS9b1cBoRwvOg
 Tvbys4v+Hyh18rcuWS/mZjT3OqhUARcnCzc9G6isFR//Le+1V0agP1GTvnBzpYFJFOQUMJ0LAzg
 wqYzCPpnf9yHJtp/+k+dEIUXFcS2+dl+X2ZuU5gwN2UoN4ytwTdz48CC4AN5iifVlRYk1yWQbeQ
 c8dQKxcvsyVC57J5N74Drnx0ZXneDSqZ8YHuwL2kMs8r9+4WaKBtzIeMB+kJ91w9fS6O4MrWV0E
 VNv181TxnUgMqmzXx66NumxPCuu6yLb73ZDmGheKsymDhRGA8CvtMfgKcCQEfCN+Dk1wA=
X-Received: by 2002:a05:600c:8b68:b0:488:fe40:2014 with SMTP id
 5b1f17b1804b1-488fe402016mr92739345e9.18.1776541609476; 
 Sat, 18 Apr 2026 12:46:49 -0700 (PDT)
X-Received: by 2002:a05:600c:8b68:b0:488:fe40:2014 with SMTP id
 5b1f17b1804b1-488fe402016mr92739205e9.18.1776541609110; 
 Sat, 18 Apr 2026 12:46:49 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc189f2esm255326825e9.7.2026.04.18.12.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2026 12:46:48 -0700 (PDT)
Message-ID: <b67ed115-b040-48b0-b7d3-936dc8fb7dd6@canonical.com>
Date: Sat, 18 Apr 2026 21:46:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] scripts/dtc: avoid discarded qualifiers in
 overlay_fixup_phandle
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20260418181510.51490-1-heinrich.schuchardt@canonical.com>
 <20260418190921.GS41863@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260418190921.GS41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/18/26 21:09, Tom Rini wrote:
> On Sat, Apr 18, 2026 at 08:15:10PM +0200, Heinrich Schuchardt wrote:
> 
>> When building with GCC 15.2 the following warning show up:
>>
>>      scripts/dtc/libfdt/fdt_overlay.c:422:21: warning:
>>      assignment discards ‘const’ qualifier from pointer target type
>>      [-Wdiscarded-qualifiers]
>>        422 |                 sep = memchr(fixup_str, ':', fixup_len);
>>            |                     ^
>>      scripts/dtc/libfdt/fdt_overlay.c:432:21: warning:
>>      assignment discards ‘const’ qualifier from pointer target type
>>      [-Wdiscarded-qualifiers]
>>        432 |                 sep = memchr(name, ':', fixup_len);
>>            |                     ^
>>
>> Define sep as const char *.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   scripts/dtc/libfdt/fdt_overlay.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Is this something already fixed in upstream dtc?
> 

9a1c801a1a3c ("Fix discarded const qualifiers")
in git://git.kernel.org/pub/scm/utils/dtc/dtc.git
implements a similar change.

But the patch is not applicable:

error: scripts/dtc/fdtput.c: does not exist in index
error: scripts/dtc/meson.build: does not exist in index

The change in fdt_overlay.c is identical.

Best regards

Heinrich
