Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9196C7EE31
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 19:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DDC282CFA;
	Wed, 25 Jun 2025 21:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IT9bpNFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C2E582D21; Wed, 25 Jun 2025 21:16:55 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 726AF82B18
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 21:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72bc3987a05so91356a34.1
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750879008; x=1751483808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yb1lDwTxx9HdryouZseNZgixhQibhXlNQEoCcgEc9Gg=;
 b=IT9bpNFyTxGJyJcIfcfII51fMHajVvKf86lJU9XMMmyUBV9s7O9cH4P9T1YDUiOd+M
 JlWKPMSUWYFBJqsDkaH+0kDEvngYe+3BMoZyq13jzHFfO60pF/d/cfNcrbuEySYoNmP9
 rTO/Sfl4TLQZ2BGbLhFIKe7P9S6zmcPtnHbKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750879008; x=1751483808;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yb1lDwTxx9HdryouZseNZgixhQibhXlNQEoCcgEc9Gg=;
 b=o14zpJmRzpyQgnRyZk8UhKckLn3BuzVecA/IqWLZz31oNv/AOk6w+Q/jBe6ltjHH9M
 VspZ9A4Pjj2ZFdVzznVcJKy/VNlEiafEAtIvtMzNd3GQTo0T1VJ53AQsXAlumv8RPb+8
 BwL/7UpBQkDBu9x6wIttd7xb5VODDg6RjDhU+SOpDRNFQmv9/e+qcWU6R7DlEXXNnEvc
 xaZhPEouEPPDXlZdAMJ8AycZj5raOPtDooLwzo8R8peMpxZFhq4JJ5p0JO8A2gnNvAJD
 FFx2BpczJ+9/GTbbjOTdsiTbVgWggMkr2nwphQOF37cPsokfTouqABoBH63H5jv7fwzH
 GLCA==
X-Gm-Message-State: AOJu0YzIkV2tCgvM7E+OSBH8N4yq5zk2PZChXQKKN6JjzkCF1RkZeGr4
 8AMOB4yQMmN4RxNgDa9j6m23zy8FgcMq5fq3JmujozHZpJkj3GMjY3fQrPjYRCPMQoQ=
X-Gm-Gg: ASbGncuwr0wHuxhQucyZjRj1bPeI+99WSukS4L+7rH9Q2d8/FXZtoGbDg0cz1BOMx5f
 SY9IjOxO261GDy5aZKmkREZFDZRUaXhYT4oFlQo/421Ik9cqtSeVgm6ThA576TPjofqklfTSlfZ
 fyQCxXQpxs+Wuf8U00YSycWJSxbRddSiJXruFFPeJoxwSABNNAP1l3w3aekTktLBgITHOMK5app
 jDSr3LmzFWTEGrpJYXq2/TCOH9LLJhUh+LIxCB00KKATB0riF5it8c3LLlG5S/lb8C/iz9NzGFS
 pzxpTag0oxtxgyL8KTthHxwatoQ83i1X1IJPWZxy0nGy5rbIAc/kr6CrfVi3CPkETfEQTRPWzTP
 ajaiHvMY57r+ssPm7QT4XPA==
X-Google-Smtp-Source: AGHT+IHNb4h8d5k0ufJXYjZqX3uyV8js6S/+bh4AjHZQdeJ18OUoR0TbdovkgyEfcBZNC+FcMb1LJA==
X-Received: by 2002:a05:6830:4704:b0:72a:2b8f:b111 with SMTP id
 46e09a7af769-73ae9ddd3c8mr383465a34.1.1750879007864; 
 Wed, 25 Jun 2025 12:16:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a9db2f54csm1962276a34.38.2025.06.25.12.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 12:16:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20250617104346.1379981-1-sughosh.ganu@linaro.org>
References: <20250617104346.1379981-1-sughosh.ganu@linaro.org>
Subject: Re: [PATCH v5 0/7] lmb: use a single API for all allocations
Message-Id: <175087900665.1496843.3127867903467919831.b4-ty@konsulko.com>
Date: Wed, 25 Jun 2025 13:16:46 -0600
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

On Tue, 17 Jun 2025 16:13:39 +0530, Sughosh Ganu wrote:

> The LMB module has a bunch for API's which are used for allocating
> memory. There are a couple of API's for requesting memory, and two
> more for reserving regions of memory. Replace these different API's
> with a single one, lmb_alloc_mem(). The type of allocation to be made
> is specified through one of the parameters to the function.
> 
> Additionally, the two API's for reserving regions of memory,
> lmb_reserve() and lmb_alloc_addr() are the same with one
> difference. One can reserve any memory region with lmb_reserve(),
> while lmb_alloc_addr() actually checks that the memory region being
> requested is part of the LMB memory map. Reserving memory that is not
> part of the LMB memory map is pretty futile -- the allocation
> functions do not allocate memory which has not been added to the LMB
> memory map.
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] lmb: replace lmb_reserve() and lmb_alloc_addr() API's
      commit: 9d37a3d6e8b862071edfcb9ee95a0fbe45606918
[2/7] lmb: replace the lmb_alloc() and lmb_alloc_base() API's
      commit: 6e4675b8e5d8d52d871042d6ac3429d6d1daf875
[3/7] lmb: staticise lmb_add_memory()
      commit: 3faffba6f19834bdda12b7942e545ff4a4a6e18b
[4/7] lmb: use a single function to free up memory
      commit: 745f981f7083f70856b3db307b759774957a8082
[5/7] lmb: use a single function to check for allocation and reservation requests
      commit: 7aa19c3667d1cd23417f4ec7f5cb5dab260cfbf3
[6/7] mach-snapdragon: add a check before copying FDT to fdt_addr_r
      commit: 4641419f41b347a38a07f19c809b7aab63864dd1
[7/7] doc: add lmb documentation
      commit: 9b0ed9e69bcbc6af7115ddaee9536cf63b800c1d
-- 
Tom


