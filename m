Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231E7C25B7C
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 17:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D24EA88908;
	Fri, 24 May 2024 19:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nwnxl0DQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2470F88851; Fri, 24 May 2024 16:26:20 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 427998882C
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 16:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=net147@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e8a8ff4083so30455381fa.1
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716560777; x=1717165577; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ROqYNsYCoz70viFcGB4AP2EFPxkBToICk7x0Lnkd92o=;
 b=Nwnxl0DQ2A7gD2VgtKyzQmq+cvFZC4bvJJqohlPa+K2Ij0oXGdL2tbvsujJO92zq11
 v+Im3TRlb88sukajEC3cWMn9chU/+fCOuoviehlnsqNHQnlaY1EMC+oBGdGMBMM/mzBk
 7SF+D96U6oDgv5w1xZefU168/hWk1jdyNM1scFf3OSxNMsykTiNK3GUny9IDwT7WPAJa
 AID8GUp3o7GtCUd/eI+kw13CLOEAZyV9AmPAriUSyvxb2OVsB6RkD0LZp2k4Zdfxhv3w
 FdTEMmnP6Oi5Q9RuIVsSV14fUnPsKfNYLVdsxOLdjLJ7LWMRCQ5QdPGOiOjCFjahToA7
 Xm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716560777; x=1717165577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ROqYNsYCoz70viFcGB4AP2EFPxkBToICk7x0Lnkd92o=;
 b=QmLdxgZBwNeGO+tFvR4jlmbvjwHM1jG5Y+cI83k9zXslwkaVDab4NWgNQkq2Or8kru
 p1ni/XGd7D89xomdIhp6BWFxBX9L6w1XDsyl0n2lMB3WK9E07Iqn/gZgc11K7zM7Da5B
 RLxyjvb6JdZxhHj5TCBZbNH8nXHC3y9ERJ7UuMCeZYQmFYJaRcm0aB6pYDpICdQEm2wh
 7WEDyu07h3y5s45xsWnVBhlXtMNjmnu6s6TjRin/43gCl/oCuBOlYW2Q10iGHgXDIzRu
 EMZrdxTTPZ/paFI0yf6zDJMGHNBAPlOG7BG/BqhbdN9QxHNafFbCjOp9ZWSDnhGPWftB
 nx7A==
X-Gm-Message-State: AOJu0YxNgUeGGfHhM80U1hQxKCRRm6WtKdcW246JIca4nKdNpUvOFwfC
 PWoEIZOnwyl/ajQY5hG9Pfc+Hw9q+sNr9FIX9Z2wCYhLbl+e5xm9FqkC6xb44Px6KSPTl0BZeAo
 px9oTjecyEtkOcQp9TYubv757VY4=
X-Google-Smtp-Source: AGHT+IED7THa5K9ZS5MM/UJZySNFqddmZWUvCFVFXZJy+Db5MIobLYVha/fHTauqpSC+xLEyz3B9rJFYYqIscp6XS9Y=
X-Received: by 2002:a2e:97c3:0:b0:2e9:5543:8a74 with SMTP id
 38308e7fff4ca-2e955438b8fmr14048191fa.6.1716560777254; Fri, 24 May 2024
 07:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220226070551.9833-1-jnhuang95@gmail.com>
 <20220226070551.9833-3-jnhuang95@gmail.com>
In-Reply-To: <20220226070551.9833-3-jnhuang95@gmail.com>
From: Jonathan Liu <net147@gmail.com>
Date: Sat, 25 May 2024 00:26:04 +1000
Message-ID: <CANwerB2SBe1+0sW1OXHEfSMA1z-vyAvLfAqVOKdsM-ap=KYbCA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] lib/lz4: update LZ4 decompressor module
To: Huang Jianan <jnhuang95@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, linux-erofs@lists.ozlabs.org, 
 xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 24 May 2024 19:00:44 +0200
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

Hi Jianan,

On Sat, 26 Feb 2022 at 18:05, Huang Jianan <jnhuang95@gmail.com> wrote:
>
> Update the LZ4 compression module based on LZ4 v1.8.3 in order to
> use the newest LZ4_decompress_safe_partial() which can now decode
> exactly the nb of bytes requested.
>
> Signed-off-by: Huang Jianan <jnhuang95@gmail.com>

I noticed after this commit LZ4 decompression is slower.
ulz4fn function call takes 1.209670 seconds with this commit.
After reverting this commit, the ulz4fn function call takes 0.587032 seconds.

I am decompressing a LZ4 compressed kernel (compressed with lz4 v1.9.4
using -9 option for maximum compression) on RK3399.

Any ideas why it is slower with this commit and how the performance
regression can be fixed?

Thanks.

Regards,
Jonathan
