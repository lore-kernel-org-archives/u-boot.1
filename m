Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD888C25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 23:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 016DC888B7;
	Sat, 25 May 2024 01:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NXlB3aUj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FE4F888B9; Sat, 25 May 2024 01:53:22 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A339E87DCA
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 01:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcmvbkbc@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5b5254f9c32so3297927eaf.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 16:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716594798; x=1717199598; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=72EFcGc97zwEWn6VGVNyLGaee9pdZq/88LO/JTVQreE=;
 b=NXlB3aUjVdrBK5cEbo7uIwFR4PmjX8h5Vh1cI7d4xqX+3MatP/TXAMbzD1Db6fqn68
 vYwCr8ITcHqhiDgiSyXsmneBbgD7ANpnpm9mCwTPnp+y7fwo1L8ROOOruAjjSNgmxWxD
 P02as8dAjFWtNjv8keRJnfZ+rZ/GFJw0aKIZo2/4nArrwVIAV1oxepdCft+vBKK+ZZV2
 h69XvQgdcATKsxwtMIEQ1gSVqFt9qcvmZXzQOToOps/sXzQWZT13KXGaLVKLiloVK0eO
 Lqjwfaz+CpBl7PTc2TBtYRQtzjjbsY8k7Jko4HwUgh66jqacw5lKfbgzdpn82XY1RYYl
 omVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716594798; x=1717199598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72EFcGc97zwEWn6VGVNyLGaee9pdZq/88LO/JTVQreE=;
 b=uZAkK+uTc2ZfbZtZ36xcX+aGWXRBSKjQUrODgsDWOJeH/voGK6TAmOVLFD7VwarK4K
 O03V+DrqSr/Gh4QQtnysBvJPIGZ7hY38BswkoHXK1GKSPyTcyX+qSgawC3JyibcBXA9A
 ZfauaaOaZgpk2OmsmmKRCcnZbsE+W6GoR8atBNSLbLmzJgcVLQtUhC9IXH2+WrrKhc5X
 VlMODEqIyj42DCK/0fYVmWWogTa66u4BHfzXXad6nBAgu4K4d/ThCXXnjeuSyVkdyUUw
 /m0TIsaBtdkrbgkRsZAcGQ62IDa8FkOEoEKnDSfDJkYE8pFtr8RtBW7QhFOMwwLioGBR
 GS4A==
X-Gm-Message-State: AOJu0YwEzEcYPZ1bhfZ3CAMDBcV3Yvdp3a67pmROwm9+atUPQL+TxVbk
 QIJwhTVjdEvkA0SszeB5Sr+ZGwRQ82JdTe3iEO0wbqmhVnXr+386
X-Google-Smtp-Source: AGHT+IHVdysdEL2OP+l/7NNugcF5zxIe4jgs6K79WKdTm3HS1Tl/KNS3n0owVqiKNph1+fs3yTchoA==
X-Received: by 2002:a05:6358:5917:b0:186:29ce:3982 with SMTP id
 e5c5f4694b2df-197e5466632mr443039355d.24.1716594797990; 
 Fri, 24 May 2024 16:53:17 -0700 (PDT)
Received: from octofox.metropolis ([2601:646:a200:bbd0:424c:b9f9:20a8:b1b9])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6822198a705sm1718222a12.36.2024.05.24.16.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:53:17 -0700 (PDT)
Date: Fri, 24 May 2024 16:52:51 -0700
From: Max Filippov <jcmvbkbc@gmail.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 00/10] xtensa: Enable qemu-xtensa board
Message-ID: <ZlEoUz028kFSLrOO@octofox.metropolis>
References: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
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

Hi Jiaxun,

On Wed, May 22, 2024 at 06:07:56PM +0100, Jiaxun Yang wrote:
> This is a side product of me investigating architectures
> physical address != virtual address in U-Boot. Now we can
> get it covered under CI and regular tests.
> 
> VirtIO devices are not working as expected, due to U-Boot's
> assumption on VA == PA everywhere, I'm going to get this fixed
> later.
> 
> My Xtensa knowledge is pretty limited, Xtensa people please
> feel free to point out if I got anything wrong.
> 
> Thanks
> [1]: https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc232b-elf.tar.gz
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Changes in v2:
> - Fix noMMU memory mappings
> - Addressing Max's comments in other patches
> - Link to v1: https://lore.kernel.org/r/20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com
> 
> ---

Tested-by: Max Filippov <jcmvbkbc@gmail.com>

As expected the build fails for big-endian cores and peripherals are
non-functional on MMUv2 cores.

-- 
Thanks.
-- Max
