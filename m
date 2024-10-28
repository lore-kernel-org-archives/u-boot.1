Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6E2D5B14E
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 21:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7263F89124;
	Mon, 28 Oct 2024 22:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Rj+Nthi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0167389121; Mon, 28 Oct 2024 22:08:30 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED83689099
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 22:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7828E3F2B7
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 21:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730149707;
 bh=IWFP8Sb1N3Xu62gCtgFSktIrexcn1h4yuPAqgkLgZXs=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Rj+Nthi6NGpZvPnSPORPBxOTqshtJ27WP4Rcue3kGUyeK2892WdYXb97ikD1srbze
 lM02mKGc8X6SMywCSBA00VEY4C+nWo0ixQL/L4LyUFWAvFAvLfYl1wTO6chdii1uLE
 bDILyNxw2eovbzDbxLQU1MZtqAXmwTgO24NqMhp0Dt/VlKOAZEB1bNlXUUd8l4qVGb
 x029YCpKbsFq6zPIxiIrVrqE8ZSD5CQCfUgQTPBaamCJ0Iei/QdUi1BRr0c/69CwtN
 M7BjToom/6LFCzZlRaT0/ye7oqIOfZP/I88KJk+BYEQv9q8uYzUF25qa9YPPZXqieZ
 MoxloZqZCqIPQ==
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5c934295846so2931291a12.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 14:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730149707; x=1730754507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IWFP8Sb1N3Xu62gCtgFSktIrexcn1h4yuPAqgkLgZXs=;
 b=uejI06cK5mmVrBwgNdmV7Y8SfcGl6rBi+9K8w4q4cjsbgLE63QXVxxNBTHssTyMX7U
 rDSGxSme5x6zASFTehIVfXOB6r6GgYfN+gUqiqLei6Z4Td+2gOT9c8NECkEM24eOwt8J
 5aBShdTZTF16DW9mcwO9R6C1YrtY8hkxzND0U63Nn1PLSeJIocZ5pAp8ggyuEeWluLAq
 3YKagNoO+SutPOAtAdIUmxizbL0pjxw9rb2Ol0VRUy0tZ4qAS46NjSVbBPxBcx5SVs+M
 ZxH+h7h4OZKiUE0DlYxzjmuGAvoECUzqtF5T/XicV5wEizz+Vj6NDwKwAyw7nIJ0EOzc
 sjzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPT53qAZnxj6EGSnoIm59LjZP1g8U7VdrEMfJqixl3O8g1eYKUZWcU5ydYGyJi1QVloJE8lww=@lists.denx.de
X-Gm-Message-State: AOJu0YwiboxxD7ZCDFFQsg9+uFkZu6Qxgo1EDzQB8HgQhLe8P7zRHp8I
 aohDD0LzfQxC5yYdRpzNOcOKxRVsPUIGtrz+er+C9rRg1kpozfzZCH8Ut7/7r9orP9rlzE2pWtm
 9TC0LfaY+SYso//Rrhyk46bjgd/BjxjvdS2+78ZEybwUYZMQurUMvzJAbu4JFyx6SphI=
X-Received: by 2002:a50:8dca:0:b0:5c5:c060:420d with SMTP id
 4fb4d7f45d1cf-5cbbf9402e8mr6598329a12.25.1730149706995; 
 Mon, 28 Oct 2024 14:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEivKV+87tpb1THDQxQluKmGieMVI3yN4dWvvJhMS0E1XPGQnYuUXd07TKD4L5PGaWQm8erpw==
X-Received: by 2002:a50:8dca:0:b0:5c5:c060:420d with SMTP id
 4fb4d7f45d1cf-5cbbf9402e8mr6598319a12.25.1730149706495; 
 Mon, 28 Oct 2024 14:08:26 -0700 (PDT)
Received: from [10.43.6.224] ([87.215.50.114])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb63197edsm3499395a12.75.2024.10.28.14.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 14:08:24 -0700 (PDT)
Message-ID: <774c1efe-f5b7-4581-abd6-714a9b24bc7d@canonical.com>
Date: Mon, 28 Oct 2024 22:08:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] test/hush: Add CONFIG_CONSOLE_RECORD where required
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20241028164844.2308549-1-trini@konsulko.com>
 <20241028164844.2308549-2-trini@konsulko.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241028164844.2308549-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/28/24 17:48, Tom Rini wrote:
> The "dollar" tests require CONFIG_CONSOLE_RECORD to be enabled so guard
> with that.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   test/hush/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/test/hush/Makefile b/test/hush/Makefile
> index a2d98815e501..4c3a0be857ae 100644
> --- a/test/hush/Makefile
> +++ b/test/hush/Makefile
> @@ -5,6 +5,8 @@
>   
>   obj-y += cmd_ut_hush.o
>   obj-y += if.o
> +ifdef CONFIG_CONSOLE_RECORD
>   obj-y += dollar.o

Or to keep it simpler:

obj-$(CONFIG_CONSOLE_RECORD) += dollar.o

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +endif
>   obj-y += list.o
>   obj-y += loop.o

