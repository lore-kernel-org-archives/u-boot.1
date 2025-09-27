Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BC6CAC5B0
	for <u-boot@archiver.kernel.org>; Sat, 27 Sep 2025 15:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E659280819;
	Sat, 27 Sep 2025 17:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dPiiF/CV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37C8D82A9E; Sat, 27 Sep 2025 17:48:15 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3CB28006D
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 17:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7a79efc43e5so2183522a34.0
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758988091; x=1759592891; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1CylS4QZ/ZJ9+Uyx2AXFwtROlqzuiL2CxctBM7l6j8I=;
 b=dPiiF/CVPbOgvjdCw8vD325Uo5fmJlJApthVcDDaTLaHDMWoG3ZPDo8qOgAbxwYLcr
 ZIT7ZxEDqhFUHzIadC3ilrW7paz6ISkmRUIi2AHbfWT4DPEG5/piZ1dXvjoHrPRKninw
 jrqR5zfOf7ffSehNGXYn59TwNJhTzjE8fD94Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758988091; x=1759592891;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1CylS4QZ/ZJ9+Uyx2AXFwtROlqzuiL2CxctBM7l6j8I=;
 b=kIBHugiQf6CPSt6pAouNBG3ll97FIjV0keqcB23kY5JOhAdlVxYulrwQ0sjBsNXSNo
 4qCZUhtaxsy8urAzQRW8V5auNdx52hbzgbtd5sd2gdWdmzlRS0E02ZvXAkqAdn7sD746
 F6J+wPweMHqsmE34SBARmDqSamANvcbXPIRN5vbC7YD+5MWf24gt1L33p+ddz0Mgk3zY
 qQjLPbnfvFKIR1PnnijCq8FshHXIJJFvhzRL1Afa10sjFaSHj7D0k73KZQptbPmSO9Lj
 948RhEtxDojDCZ6eh6cnqHIQFwA+/TJENKP6F/6sODhVMjHbWgZGUqgzxyPK7OKbY4w8
 yR0A==
X-Gm-Message-State: AOJu0YzDxuaTE76hvE6ogTpBwgOksqPyfpB0JH2g72LUvhh4QZYcPhc8
 Fh2GtqC8JRukfF2yiPAPAORwqKxE5zP/MMUu2lrVlrAgUvkjkNumwU4FbNAXESG47sM=
X-Gm-Gg: ASbGncu9/XZGfqNdkFL1iy/jsfl5QHpiwpvr+Y9KkeZqmcmi/flR9TtMfFkVYbrME33
 4ztUQRiZn6RjBpTy4Sqio2r+QLTK6p/eT64+U/RgWzQp6Y/aZWHi/nWM++pCrklo3rvMTx60aQ7
 wh2GBfPPNJh5IUowcx3cLw2wMAVfwQHAOsapXaIE20WmC+d70teeOVShPzu12f4YvwNFMb6Zpdr
 kMuFAnBW1zDAUOxUY826fWDBDbK8hZJPpS139J4bw8D3tarnPdfXdW9zoND9/daDGa9on+vk0hY
 UHL84Vmd6aqjQ5tOxnRn38i5WCCeUrQeeUpTYtFPuszyYsd+e9ur6lwSBU5YxRTyxoovsoMGK49
 sQY4ZoTWhbpddJbCBc72y0DIu7ttx29iw5DDEnEcHCAuZRiOWhyBbmju6Sd/XP4LhJA==
X-Google-Smtp-Source: AGHT+IFEMz/C0r5NTF+Ff9+22E5EDNOoUp71lUC70CO51uRe0/4+nrFoMWrI935lvMSF3Hh6iWqmWA==
X-Received: by 2002:a05:6830:d11:b0:75a:f207:18ab with SMTP id
 46e09a7af769-7a03f29cf9dmr3867502a34.14.1758988091473; 
 Sat, 27 Sep 2025 08:48:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a241ad75desm1576707a34.38.2025.09.27.08.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Sep 2025 08:48:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anshul Dalal <anshuld@ti.com>, E Shattow <e@freeshell.de>, 
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Ricardo Simoes <ricardo.simoes@pt.bosch.com>, 
 Sidharth Seela <sidharthseela@gmail.com>
In-Reply-To: <65571c10-0146-4422-b7c7-888db609a848@gmx.de>
References: <65571c10-0146-4422-b7c7-888db609a848@gmx.de>
Subject: Re: [MASTER] Pull request efi-2025-10-rc6
Message-Id: <175898808976.9030.10765348347367821244.b4-ty@konsulko.com>
Date: Sat, 27 Sep 2025 09:48:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 27 Sep 2025 13:55:07 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 9b45d574af1b64fcd997f08fe702a2d0ecfccbe4:
> 
>    spl: nand: initialize writesize for am335x (2025-09-25 18:54:07 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-10-rc6
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


