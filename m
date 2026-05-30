Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F19CD6E49
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 18:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B6F984884;
	Sat, 30 May 2026 20:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jna7yuoz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 792708485F; Sat, 30 May 2026 20:37:06 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ED478405A
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 20:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e6b552ac99so33010a34.0
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780166223; x=1780771023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwkBGbt8UlWl03hDVfyNHh+Catz1mKil7LpQT2I3caE=;
 b=jna7yuozRDEc0x2r4rdCmEHch2/8p2ldfJx29rcgpjXkjHkKcKSD4FqwxV4+lVEsGe
 nbfFpa73YKCbdv3u9QC0N7jf34umJ+mJXfs3yeQ+rvvK9gtsG1tBc1b5xARQgc8rWfM5
 UFVMSs92CI5c7kwJKxqaMIyS4a+5/4EXre0No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780166223; x=1780771023;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RwkBGbt8UlWl03hDVfyNHh+Catz1mKil7LpQT2I3caE=;
 b=lCZz76IVfB4u26fjMAL/tBKuIGKgfZoypCbuVAGnoqhxuQcQeIENV/VxMTgNZnB2vX
 P2M1/bgwH1xuzXM1MulHnzhPN5fgZktsL2H+0UU2abuSnsD8XoMIwI8s54DeXJT2IkXq
 EYfIlgUDnSRyccP795+VNeFprEl/I9d+2nepWbxWzJrHP2og83kIkPyR2OlBwB1bfQNU
 1i4R7D26hfIkEZqHhtGyMkKG7b9juL7v/RzU9WyP8KhRYkNSyei2xBvz0S1pACcgqt8M
 Q9Y7WYjjIk6IZAo6wsaqawbgqWMyhdPQvjP9czFT6MhOnAbnBq5QZY8Jl6sthzw6ls9o
 4Bbw==
X-Gm-Message-State: AOJu0YxDYzxxHMgKilOTH1i7K6as4XGJeOXUtJmmyOmVAtm6Te3bAbVS
 5wkP/4uDf/KSf2WW6uEka3DqD94z/8lZcjZMydW/h+4LVj/cmzh+BVtNUwRWYxZyALA=
X-Gm-Gg: Acq92OEAZmkPM+cR6d40TGLbhvyCYZNQgSvWELMlf3mxyIlIDHN1cu0xaBiYzwobXsd
 c19fYA+tnK3ms5KVEDYEnFEhuu7vZvkZFq+Fd/DP/bgzJDeKvswzUXROF8K9vqiSa56pgizn0Gr
 Qeha5YSr0nKcnN1+Vv9YwPBPz8qkuvUEIVXH8UQY1CNjxX83WQlcMIxUQvvmRdfEklcNVenvm7x
 NR7BXJIhuUEjS3WZHf/V6aeGvW6EIHMIP44+l1sC7a7PgwjHRCfYcWswAxLWx4nvsBnqsnrhP4R
 WuhP7Cc5Z8AGzS3ghfPzjO9iwMu9uWAKGFpqCi13T07mk9hya6PP/Zk05Rdzsmy8ygKf8Piy/Lf
 yNGE6tx0x3gV0c4SSGrM3YqIdWDGeH7KVKv2CCgzASHI2grIeOhAmNE5HAIF7qlKwUfUY67Do5q
 tUwGIqucH2jnhb7bYBhodi8jr30Jyfhcwoh+5jfqeTSF76g+xDr6U9obvb+UyfXp1dq7w9JmG8O
 qg+MybUPy82cvgqUci3Hw7CCydfcT6HMtGbX0VeFDyciAL2KYpgsHY=
X-Received: by 2002:a05:6830:44ac:b0:7dc:a6f8:e3be with SMTP id
 46e09a7af769-7e6a1e92001mr3262525a34.26.1780166223135; 
 Sat, 30 May 2026 11:37:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695b8f662sm4245130a34.4.2026.05.30.11.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 11:37:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
In-Reply-To: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 01/11] video: bridge: anx6345: Staticize and constify
 driver ops
Message-Id: <178016622261.1038765.16039537464769200931.b4-ty@konsulko.com>
Date: Sat, 30 May 2026 12:37:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sun, 10 May 2026 19:16:56 +0200, Marek Vasut wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> 

Applied to u-boot/next, thanks!

[01/11] video: bridge: anx6345: Staticize and constify driver ops
        commit: 6da8ecc5189d36221211956cb3e7097db7f15267
[02/11] video: bridge: ps862x: Staticize and constify driver ops
        commit: af65e247e7718e7b16d402f3e7d17844e3ccc677
[03/11] video: bridge: ptn3460: Staticize and constify driver ops
        commit: 772ef8b0890565cc9645336d9539b49863e7891b
[04/11] video: console: normal: Staticize and constify driver ops
        commit: 3ddd78074e87abc04e662dedc2a0b1a39cb2eb26
[05/11] video: console: rotate: Staticize and constify driver ops
        commit: c6266daa1e22e5f3e27960b4f306f1f0e7006798
[06/11] video: console: truetype: Staticize and constify driver ops
        commit: 8f7717c756652bf7fa168be675a91b55164d4334
[07/11] video: dw_mipi_dsi: Staticize and constify driver ops
        commit: b2f7404fd8ad03405aa75ad1bdbbba01e144785e
[08/11] video: imx: ldb: Staticize and constify driver ops
        commit: 7e7b3106a50b72ab78e28f81e9ab9f96817b5e47
[09/11] video: stm32: Staticize and constify driver ops
        commit: dd2f4d967f12b896ff976b3b21311c1000aece2a
[10/11] video: tda19988: Staticize and constify driver ops
        commit: 16185d7ff317b0406b6386e67ebbe175377449b0
[11/11] video: tegra: Staticize and constify driver ops
        commit: 674afbcf6e9f838cc34425972e893e233835364a
-- 
Tom


