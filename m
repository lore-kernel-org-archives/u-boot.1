Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38A8C52D6F
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 00:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B1B88D50;
	Tue, 20 Aug 2024 02:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rsesMkWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E5288D41; Tue, 20 Aug 2024 02:29:45 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD0D88CA8
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 02:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3db14cc9066so3239413b6e.3
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724113782; x=1724718582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TNz7ixFE51n79p3R9OdyYBMVUQu0iGjx6e+lNCqFKC0=;
 b=rsesMkWywBDnCPzkodl2HQKhsn2IxCJMlDEpYTOL7Y2++A8eA0eq1j+nJsif+4bmKO
 +tzTzlbdT2nP0tbzfyLXwQgEXbJpea0/mILKJIjBkjBZXx7gQgUbB2DJR2L6o4FPyeSC
 imQ+2FCpNlWuYItDKUlNlrmqUK5ea3KjILM2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724113782; x=1724718582;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TNz7ixFE51n79p3R9OdyYBMVUQu0iGjx6e+lNCqFKC0=;
 b=m0sICce8UzqXg+ECM+rgL5HEAYdVUMNcRANoCEf+3m43rlsAttK9VtSd5uXupp5doW
 l0IFPfGZwmLKamD9kt6o+gEjiJrf01O1PJLi2zlDhTEXpOIJMTlabrVpG7bmhtZGaXZL
 C53JH8dps2t3uy1aunmGOjUyyjJSENp2DDprW4dKOs5qXufLMIH5U1ZmYaD6OCbSRUD0
 fDn6lAAcWVTz8O3IziXnDcyIt6eRGn/g0x1LSQ2ZXQwz8mOjcCx9AqyODLsj6csQKB5V
 mYCohIWJOftxfUoYdscN/mLuryQASGTbeI59atTsTN2ZKoFarnPjj2Hi1Tk6S3L79NBP
 lFCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXruMlpgFNrZQfnh/8LiQRf45y+k+bJXohi5/qa30dz94cFtCW+BBEKmuQSpQhWDJ9Y1skTnP0=@lists.denx.de
X-Gm-Message-State: AOJu0YxBJwk1x2i6yb0ja/vWHLHeMDaefjh1vYpK6g6NX1L67ZA592WB
 yVPXxWB28eJy+ycwRyRtUP3KnSL/bUEygMSKEpEpqU+hoMu9klzQ/AFwd/u38b4=
X-Google-Smtp-Source: AGHT+IFOMHppWHrhgyzpCYJtBuHTG55p48ZVq0t8PZTqU7PZCnLeR2jyVANyh2zAKyZGhfYd3JnLxg==
X-Received: by 2002:a05:6870:b4a0:b0:270:77d9:d69a with SMTP id
 586e51a60fabf-27077d9def8mr2723544fac.4.1724113781857; 
 Mon, 19 Aug 2024 17:29:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-270046a6208sm3319572fac.27.2024.08.19.17.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:29:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20240802134511.23608-1-ansuelsmth@gmail.com>
References: <20240802134511.23608-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH 0/5] clk: mediatek: mt7623: clk migration for OF_UPSTREAM
Message-Id: <172411378092.165406.8848084941240447497.b4-ty@konsulko.com>
Date: Mon, 19 Aug 2024 18:29:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 02 Aug 2024 15:45:00 +0200, Christian Marangi wrote:

> These are all the required patches to migrate clk and correctly support
> OF_UPSTREAM. This will align the clk index to upstream to support the same
> clk implementation with downstream and upstream DTS.
> 
> Christian Marangi (5):
>   clk: mediatek: mt7623: fix broken peri_cgs clk with XTAL parents
>   clk: mediatek: mt7623: split clk tree to dedicated topckgen and
>     apmixed
>   clk: mediatek: mt7623: define id_offs_map and import clk ID from
>     upstream
>   clk: mediatek: mt7623: remap apmixedsys clock ID
>   clk: mediatek: mt7623: remap peri clock ID and add MUX
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


