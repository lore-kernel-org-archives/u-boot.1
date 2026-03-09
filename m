Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C94CF3C245
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 12:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF96B83BC7;
	Mon,  9 Mar 2026 13:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GWB4gshG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6859A83CDF; Mon,  9 Mar 2026 13:19:37 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 712B6805D7
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 13:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 06B6C3F46B
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 12:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1773058775;
 bh=lYMZxoYBJ2FoEXsMMNvLEyr6oO6xcZSOdZmXztrKuMI=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=GWB4gshGQ/vOz0mVK8IsB54vkIW9+94PxhhYRUlWZj0TeJ7+prssvMhjidtvtnDea
 Mr5q7/5dbFeLHxtm1VvAjaREJwWemiSOMpJhCpj/PUkjQzNv4GplOWDQbu/ZY5voMk
 7zzC2/LurFQ/1TyyW54yECCBitwT3dk1s3yxDgRUD3k7hALEPAJJ97eP2K04gigvxS
 4J4yOwqEmONAJ81MTwQyi0kt9+gVO9JMYpzR8NrUOOstkFDEfhQuT7jClkeAOsgya9
 KJikcvVULbhJuWNqwvkFAB+MXmNv5G0O7BRAzuyRFz3ZKc0hdEgc7Vn47+wh01qkeG
 MGWTmTtS55ln9t5p37RceSfGHb81TVer/Jj18ne58nKPVLmnSVUB6yHtz1dQXk9nh9
 IG4lx+GbEh85BUGAeG33yxHxYsfuuALGDba4w1AetyVEyRbbY50WM5Jq/fH+UJNbyi
 FTgZNU/J6rW46fx5fL8WRCyCe70GV8YdHOMG82Iq8w+UniVIcl9xmj5GmOiuIp3kC2
 gTmLKfkvHxCcMQpXuRgGrzNVW35KM2pmdUI/1NPlirndI0dqJFrIP89Q4hrC4HQcmM
 +CGNNjzCIdjVRNivufQGYUaarBNOHyKZbWwoYh7LcmeZKwpfmfrxTFW/+9QXdyCHHD
 wVPcXXHvHmkhPyKKVRosy0VY=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-485390246c8so12283165e9.0
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 05:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773058774; x=1773663574;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lYMZxoYBJ2FoEXsMMNvLEyr6oO6xcZSOdZmXztrKuMI=;
 b=f2pI5vAzF2uiiJT2w0Ofkaxm+EhVFU7OlNFQyvZV/TnKs/PqSKaSAJURT4fBxHjOxc
 D/50fSUDcPcIUBoS2OqG8gr5oMWsTFGZ+0j1P+VHGpH0IWXojbofcTwCd0RxSjnkCtqp
 opa+JzYLhCRzXfkw3S48Y1WR/VF7chJXeZCFUuIDM88QSYMV6SRW5FgeGpNCsOaYE2lK
 04sOlAaf405JC5nJV2Y7iuSsVUOXpGlUukpgs9lnjCDvAga5ZjuDHjaZlEvn14jaykpo
 VIKmoAhwRwai6OoSmv79nIHdzDO+sLONTrbqNlFljQaGq6Vo2m/I/ZMJTcDS51OKakBk
 QPoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvW4OxAmGuEcL0BxWvO/x5zG8ubMZ68pln16375Z6OmbMGGNLAHenLw8ZfhkamFtoaGnJF9Aw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+g4GP+neHzDNyRmRyReOthgWANd9JqQCcH6s57nn2AL8N6OGg
 3xkmlaUVx963iLmtbr43NtXddJl+YOwQhqi+dVjQtKpds/eyoNaKPRccbgIE5hbHYbX66yJBpFr
 eXC7k6Z+lT0wr3lIitM9E5Nbl6HsLXdPTWz+RSxSisir4vtLrzwO5x+9z09+h9SiMEi8VsUk=
X-Gm-Gg: ATEYQzzlJy6ey5/IPsJl5ublfy/N2p9nlK7RYPyLfTFgNVnLZBQpNNw2Rc+npix9z8D
 AdjuxBhdgnrHxo9YMULp+qO08noj3JDTqESk7vCnHabEwvSNdn5uuY/jYzu0tVW7KOTMNb9t3jE
 qQ9wyXj56KPcWQ7OuG2K2i1Wia7vq0sS/ada8IUrFYGlX6g3WX1UWGz7Y8v0QH+zBNeYGB2hCJQ
 D7Qs/tCwHOK0+SmT7c4t3Nm1rjvz9iiVX+YAnjq25TUAgzuxfilRewQWYJm9Es+it6Pn9rYA61w
 U43pG1KbAhnUzthIqdnmmf2YRTDA9S1ivAD7gtFjLG6Wno+4oQsajEHpopYPr+KC68HSRnSm7pq
 sDTmG8W5qe2NkKKowSrfpM3TJt6p0rd6Q/xfTWubXAXoNgKMEtj+HL8Hr+86aD1XjAdXCDARgqS
 WQfdYx4D1tVC2wg6i6x5KQA5B4R2PA7X7+Sg==
X-Received: by 2002:a05:600d:7:b0:485:2fc5:3a5 with SMTP id
 5b1f17b1804b1-4852fc506bdmr81353025e9.26.1773058774553; 
 Mon, 09 Mar 2026 05:19:34 -0700 (PDT)
X-Received: by 2002:a05:600d:7:b0:485:2fc5:3a5 with SMTP id
 5b1f17b1804b1-4852fc506bdmr81352645e9.26.1773058774002; 
 Mon, 09 Mar 2026 05:19:34 -0700 (PDT)
Received: from [192.168.103.129]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853927825csm35379975e9.9.2026.03.09.05.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 05:19:33 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <3d35df48-0669-4c0c-a770-86bfa6b65d79@gmx.de>
Date: Mon, 9 Mar 2026 13:19:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] lib: uuid: add EBBR 2.1 conformance profile GUID
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
 <20260305161349.2317130-2-vincent.stehle@arm.com>
Content-Language: en-US
In-Reply-To: <20260305161349.2317130-2-vincent.stehle@arm.com>
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

On 3/5/26 17:13, Vincent Stehlé wrote:
> Add support for printing the EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID as human
> readable text.
> 
> This is added in the GUIDs range, which is compiled in only when
> CONFIG_CMD_EFIDEBUG is set.
> 
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   lib/uuid.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 0a166320e07..d9d5414d4bf 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -254,6 +254,10 @@ static const struct {
>   		NULL, "EFI Conformance Profiles Table",
>   		EFI_CONFORMANCE_PROFILES_TABLE_GUID,
>   	},

Some boards have tight binary size restrictions.

If CONFIG_EFI_ECPT=n, we don't need the GUID text. I would suggest to 
hide it behind an #ifdef.

Best regards

Heinrich

> +	{
> +		NULL, "EFI EBBR 2.1 Conformance Profile",
> +		EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
> +	},
>   #ifdef CONFIG_EFI_RISCV_BOOT_PROTOCOL
>   	{
>   		NULL, "RISC-V Boot",

