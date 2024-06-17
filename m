Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09845C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C291788365;
	Mon, 17 Jun 2024 15:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OvdbMWgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D26CA88356; Mon, 17 Jun 2024 15:53:46 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73755882FE
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dfefe1a9f01so4836220276.2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718632423; x=1719237223; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vkUsqBr2M0ymTlOPT4lcXLNU++dTrGYEt++UCGTwz7Q=;
 b=OvdbMWgnFtgf61lU2e25Lph944McDQrzhpYJF/eGZ7zdnXbRvhuf66UjY71v5Cm9GH
 qndXBcFJIcdNn6psDoX4/K7DXn7+ykHob0S2kkjOTkXfC4Fnlk/IomsCd9xQrd6WhkQU
 Wi3FuNNIcPiZWbYhIccqbmAF2jMh0+Ra5wr+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718632423; x=1719237223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vkUsqBr2M0ymTlOPT4lcXLNU++dTrGYEt++UCGTwz7Q=;
 b=PLtu5G6BiA966Acl/IhSTzoF7gn7AoOaLOCtsgztFa5r/C860IoR40bMayrq6Sw6GG
 loCLaSJGE/Q2mlHW6k5VSRHGL01LqzBjD8rkQL5oJAfreKtY0BTFTGTKy2kXAKTAG3if
 2APRjtY+33lWAqPchq2jOtEtlFHpC+wGRoXMt2qAVGhw8ia37rtOEPkD3JY1YmPgC27X
 fzbTn94Hyok98ypm5yzeKEbtsmT8K3kydYitHkaH51CCjdiExty3s6ErviRwGq28jUmM
 2mUUtaCa4t91qA9rQSRTRsu+OjVYzBcgXYhRQ+yrSoUd8vQryvdXfSz7RVmd80qYBVpC
 t1gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVODJmbLsMR8Oxl+TjpTfK/ULG5yqDiv4JwgBrXLFRMQa2tPf/Ac1mYgqqpL9d3qRKZ4XtQtnBdL5FV3MLUVFeyHQHl9g==
X-Gm-Message-State: AOJu0Ywqmda/xnzMrq3x442R2D9UBgNmNXEQUUzf3DcFMAq5CVP5SEaZ
 C5rMewyM5KpcQZ082zsi97trn4kTdnm6if8nJ4ouuzoqsN4PoRMadQ3eir2NvL0D2JzmPed0MlA
 btQZXS3sNkQce4IOiewwWSp5Mhm0uReMUr+An
X-Google-Smtp-Source: AGHT+IFQAJl5saiGITKtY8QQAy4ibRtxX34ZLZ/HKX0BDuEg75mD3sanmaAeul00mAUlGQNSffEIhOa5Du9bXaps25k=
X-Received: by 2002:a25:aac5:0:b0:df7:a75c:28e1 with SMTP id
 3f1490d57ef6-dff153adc28mr8111155276.22.1718632423199; Mon, 17 Jun 2024
 06:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240613220212.37078-1-vassilisamir@gmail.com>
 <20240613220212.37078-3-vassilisamir@gmail.com>
In-Reply-To: <20240613220212.37078-3-vassilisamir@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Jun 2024 07:53:32 -0600
Message-ID: <CAFLszTiD2k+fz-4DpX4rOGqvmT_r9vcTqKkBuMwTP1JTNjQ1Qw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] doc: api: bootcount: Convert to rST documentation
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: trini@konsulko.com, hs@denx.de, pro@denx.de, vasileios.amoiridis@cern.ch, 
 quentin.schulz@cherry.de, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Vasileios,

On Thu, 13 Jun 2024 at 16:04, Vasileios Amoiridis
<vassilisamir@gmail.com> wrote:
>
> Move to the new documentation style with rST formatting.
>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  doc/README.bootcount  | 53 ---------------------------------------
>  doc/api/bootcount.rst | 58 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 53 deletions(-)
>  delete mode 100644 doc/README.bootcount
>  create mode 100644 doc/api/bootcount.rst

Thanks for doing this. Can you please add it to an index file so it
can be navigated to? You can check it with 'make htmldocs'.

Regards,
Simon
