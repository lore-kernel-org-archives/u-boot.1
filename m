Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB747CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 14:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44EC2809A5;
	Tue, 19 Aug 2025 16:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eX+LvkP5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A92809A5; Tue, 19 Aug 2025 16:45:53 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B02D480FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 16:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B57CF3F5DF
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1755614750;
 bh=cZh+XK9gtvbhJfmeQ4PSy4NxlrTY45calF/p4yO8fJc=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=eX+LvkP5JTMgcEuCHLoslaUxV2AWaKtY9V4hPy+CA5+rHMWSQLY9645Kg+RBXnngU
 b8tO2pKjMz+sJtM605KKO7PdQx/2MiGY00gECdv+dlolnTEt45GRfQuVL2vyaGouT/
 cD29ExadQYjHS6ro2ff5tfkXRsc0OWIol1S5WHrVdhkI0tvZsGMTXDetWJQIGpRu7o
 G1I4XQoTYvTlogqM2gTyzQyTq8fJGbWM4iz+q5qm+zGU2NbGlzbUOED3ZK7NQ+OoG+
 +I4xLrkzWHxtlb9r767CBxRwRKltpqmgNBM2KSWkNonQznRDcjWXZyoSFroibH2nvq
 BUgiUNlmHmIjA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0bd6a9so23451845e9.2
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 07:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755614750; x=1756219550;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cZh+XK9gtvbhJfmeQ4PSy4NxlrTY45calF/p4yO8fJc=;
 b=X4qbWb53aoP46dCr7Bz8xt4NmWgZcRfvuKzA9M5PDzb7j7eDPThH1bkKiTsxP0H7NX
 wxLJhXeXHIwzVWHLUXTESQUapLT3j2tESY0IJz76j33X6OlFfVswV3HJvdKUvgOw8Bqz
 75/JJfdDxXaaIb4ztKc1MVqa93fVdWp2DDC6VOD06usANtbHzU4uBuMnegW5qp1xLCN+
 Zvew4q1nu2x8YAFH2ijAgODzpUXo2fCIOMAp9LyWmmChDgu9F1ZJaeV46P25Das1l3lq
 +D37fquWLUF88O5/aOnSnKUxUuQke5rs8m31YHLWpy8QtaX7KVOX2RLwpG9FGYUL+rel
 Dxpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2jplZI7fXmHyYCVHsJnScdyRI3/OYGbnJzqYpWLUfQOXWGmC61Hd9eUhCcwWX0v6OVpw9hd4=@lists.denx.de
X-Gm-Message-State: AOJu0YxSts4RUu7NCW7DAt6zD01DjWJXqq4N9zpAnrsNTnwVhj+btqiN
 Y06iin8IWI+2iSiQF7Bk0HoWyrUR5l4NaPpddotWOzmM+7wapiqMRLm6STv3gaq9aaSk7AuZGM7
 Nw3NO7IQHEHz5iZSTnWt0wLXSlMWZ0XqwLDKDi3NnlAvX2mcIuAUJDiILwEu4QaTE990Ax3I=
X-Gm-Gg: ASbGncuGRx4g62OBAT08drM17s5YEBZP6+rk8IyhYEBJnS6dMaod6P//b+AFcIGJMEz
 JEWZghXyUznCorLq2cFwJ8p+fZAYfds1vNVyqyfSwPnbDFWcApDvt44qhVoMmCmZ/veWFZ7Q2A/
 COaM8EBA1cWv3zop69J4+n1omb37Id/m33FXPE2kt2FClB1sBL1bWw8RqgXxTAy+g39S+xEcsof
 ZPw2dd95lYskErYxTEy29P4285Jrd9KA49ejmxE2auRr9UPfVx7yRhwM9ShJzuo9eIDMy2GWYdP
 8KHh35k8ezgCRyxUif5ZhdeaaE2sD4/IL24im0/xvJ0NEk0OPN/ak+QdN6MM6x286z771CNeVqo
 b1UA9Xo3ubkjfs+a1+P4D
X-Received: by 2002:a05:600c:1d25:b0:456:2698:d4d9 with SMTP id
 5b1f17b1804b1-45b46c9c8b8mr4517355e9.3.1755614750163; 
 Tue, 19 Aug 2025 07:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExWkhwzT471w2ZreI7ztp1QoNgbX8L3b8p7LUuM4PpfXOLJZUlMokoeMFV32+2iCgri+Pg2w==
X-Received: by 2002:a05:600c:1d25:b0:456:2698:d4d9 with SMTP id
 5b1f17b1804b1-45b46c9c8b8mr4517065e9.3.1755614749732; 
 Tue, 19 Aug 2025 07:45:49 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b42a8f972sm47624325e9.20.2025.08.19.07.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 07:45:48 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <b89b50af-e37a-4d7f-b08b-918a1a6839fb@gmx.de>
Date: Tue, 19 Aug 2025 16:45:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Select also CMD_DHCP from EFI_HTTP_BOOT
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <fffc4713-4f89-4a04-acc6-8b295e453226@siemens.com>
Content-Language: en-US
In-Reply-To: <fffc4713-4f89-4a04-acc6-8b295e453226@siemens.com>
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

On 19.08.25 16:33, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This is needed because distro_efi_read_bootflow_net will then need
> dhcp_run which is not already enabled by CMD_NET.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   lib/efi_loader/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index c2aa88f59fb..a4055e1cb43 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -564,6 +564,7 @@ config EFI_HTTP_BOOT
>   	bool "EFI HTTP Boot support"
>   	depends on NET || NET_LWIP
>   	select CMD_NET
> +	select CMD_DHCP

It would be preferable to get rid of all CMD_* symbols here. They are 
just the result of missing separation of CLI and library.

DHCP is not needed to boot via HTTP. You can manually set up a network 
interface.

Please, change your patch to use "implies".

Best regards

Heinrich

>   	select CMD_DNS
>   	select CMD_WGET
>   	select BLKMAP

