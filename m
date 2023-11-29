Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F42C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D59E875CC;
	Wed, 29 Nov 2023 19:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dietpi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C500C8773A; Wed, 29 Nov 2023 19:47:48 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C85D86FB2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dietpi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pom.pumba@gmail.com
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-a02c48a0420so10782266b.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701283666; x=1701888466;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DeEJPVYI38y7wikxDaZ2qTr7N7Ieib7E3HOxoWdzqPI=;
 b=cHWvkNOHhqDLt63v7ZBdWzRZxhyMtJbb+cUtTWZXaF0WHdX4vILXdGa0AktjGNHwgO
 Z9c5SG2XItlctCfYAJ/VAACgU35p2fXxncs11V6GpQaQW2oC+gIfbxUN6nj9w+9jkigK
 fzIfYqcBA1QdyTEmiFXoaTjUWOfg1mOhaXJ7ES79hc2n5/k6E3ffjqPubfH7DVgTzw3l
 xSEvgzY7W5bjUlkC0cmw1n5fJtLllHixzM46Qk7c9P8ARq6vbU8pJhgeZTMZZBhmLao0
 hGfriP43brBEBfHFkGalMVcVjodLEXIkGDWavfj6xnIupfagCFCjOWYgqGTzRA6hbMFU
 KkkQ==
X-Gm-Message-State: AOJu0YyR9Q+CjOumXACbWNhvc8nc0hmB8NZDWR97EnEBiQrm4rut+177
 DuPQrm0wYN59dsv8oOidYQ+ClZD5KFs=
X-Google-Smtp-Source: AGHT+IFdQ0VtPYNitHAprG/kjjp99Nd5GLTLOz24pqoE4g8IGgsw4atl5Y+r8C80xkBXRzToCz4dHQ==
X-Received: by 2002:a17:906:b75a:b0:a00:acb:e789 with SMTP id
 fx26-20020a170906b75a00b00a000acbe789mr15051006ejb.48.1701283665887; 
 Wed, 29 Nov 2023 10:47:45 -0800 (PST)
Received: from [192.168.1.46]
 (dynamic-077-191-029-012.77.191.pool.telefonica.de. [77.191.29.12])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a17090611d200b0099297782aa9sm8172876eja.49.2023.11.29.10.47.45
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 10:47:45 -0800 (PST)
Message-ID: <3d28c8ad-f8e4-44d2-ac32-04dbf689279f@dietpi.com>
Date: Wed, 29 Nov 2023 19:47:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: u-boot@lists.denx.de
From: MichaIng <micha@dietpi.com>
Subject: [RK3568] Default kernel_comp_addr_r can be too narrow
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 29 Nov 2023 19:59:39 +0100
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

Hey guys,

for our PINE64 Quartz64 images, I am working on moving from an older 
U-Boot fork (by Peter Geis', but rebased until v2022.07: 
https://gitlab.com/MichaIng/u-boot) to upstream U-Boot.

But I was running into an error on boot:
ERROR: Did not find a cmdline Flattened Device Tree

It turned out to be the different kernel_comp_addr_r:
- I implemented it at 0x10000000, hence after fdt_addr_r: 
https://gitlab.com/MichaIng/u-boot/-/commit/170514b
- Upstream it is 0x08000000, hence before fdt_addr_r: 
https://github.com/u-boot/u-boot/commit/e1962a9

I am actually not sure why 0x08000000 (128M) causes an issue, since with 
kernel_comp_size=0x2000000 (32M) it should end just before fdt_addr_r 
(128M+32M=160M<161M). But "setenv kernel_comp_addr_r 0x10000000" was all 
it took to successfully boot the image.

If someone wants to try replicating it: Our compressed Linux image is 
13M, the decompressed one 35M.

In case the smallest RAM sizes of RK3568 SBCs are 512M or more, it 
should be safe to move the default address to 256M. In my fork we also 
allow a compressed kernel size of 128M, but I doubt that more than 32M 
would ever be required (not in our case). I can open a PR with this 
change, but probably I am interpreting something wrong, or it is not 
wanted for other reasons. Just let me know.

-- 
Best regards,

Micha (aka MichaIng)
DietPi project lead
