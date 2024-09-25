Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B9BCCFA10
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 02:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B47ED88CC2;
	Thu, 26 Sep 2024 04:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bnozFlSi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 821CA88BD2; Thu, 26 Sep 2024 00:50:20 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE9488BCD
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 00:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e1d1df0475bso38150276.3
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 15:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727304604; x=1727909404; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xi+UgK302RVmN9v+tYwtuARHyaoZi292tRJKyyDHaRo=;
 b=bnozFlSiRh4M41HMXFjsTTSi3SG/uCLYNQP0YN6n/TwuiOvL8HjzQtXTHZvLHCU3rJ
 Q+HZ7FNIaeX69JbpHuSjCfVUFLY9tUBPgahF3jcAYoFwONeqhlyPC5oUslx8ttx0X8rd
 8uuybm6lNqh7GcShXfkhfXrJ8RHRcW7jgNrFHzZqdsimP6/5YQvuVZ0PhTectLKG/s30
 UAE7GdMG5FlLSa52NYDCZ325Bh0KBNZnbmvkNBbw2BojMbLqujERUHLnMolpPtTanuzG
 rQHkt0nxdX9jsLnpgZT9Nye2mEbNevTsVIBjiEkg21rpoEjCsrb4cUSqNYl+Q9Him64F
 VfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727304604; x=1727909404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xi+UgK302RVmN9v+tYwtuARHyaoZi292tRJKyyDHaRo=;
 b=HllvIGfE6FwQgs2arTJshuA5zDUGMMcQZpFdFMc0Id9/C7lZ+aAT+G0YSlyKePFyGW
 pFkSfAu0qX+4l+yU7Yop2G90wcl0v7r4GX0MFUr3qE4Q9gGihzCn4BtYg2F6RppGFpTV
 1KblRBqABLKScOZ7WqRXOxKlyyOZXx0rtPqHSLsbV7cuJcLg86kuQe1lpgebJ2Uj7kVS
 6w+Qv5C2ylBVNdMcGLgwny7CMiCCDPeunSEoJzGdlTu7Ga87eva1M9+t/4UuB4wU6URZ
 f/BlPQeva0zVseueqayJyzWdBdRZNgc0tjCA5sDS44dLpaqLAbhMn2ScY92cLM6RloiD
 OiMw==
X-Gm-Message-State: AOJu0YzdbJQUvwgOdfCt+TBTUBsR2YtAPUThu82vVjYquCQ+O4qwq7wS
 pF6/NVaObrKFghpUmQBeFdyU0+MkQk5E9ni2hxmg5cmMMB95oWy/qqwrSjlB1BjYR+BrrvvRuxF
 UHOUeSveWmwt8b7OtiB1PFP0aar8=
X-Google-Smtp-Source: AGHT+IH0TtIMsGwlmktM6kxgD7GTTP6pzcZzsVE1n3FYw8aGxFNTBKwOGXzoU+9QfXL08Kvmz8fpwijiShMWAbjRwrU=
X-Received: by 2002:a05:690c:89:b0:6e2:1742:592f with SMTP id
 00721157ae682-6e21d9f1085mr18608427b3.8.1727304603705; Wed, 25 Sep 2024
 15:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-3-l.rubusch@gmail.com>
 <bf99c2bd-f43c-4041-907f-f60b42163cce@denx.de>
In-Reply-To: <bf99c2bd-f43c-4041-907f-f60b42163cce@denx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Thu, 26 Sep 2024 00:49:27 +0200
Message-ID: <CAFXKEHbOpv4g5LZ4dkUpwo1OBrRQ7YKZf10=S-2HqMtSK_OE9g@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: dts: socfpga: add Enclustra Intel AA1
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 26 Sep 2024 04:47:21 +0200
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

First of all a huge thank you for the time you spend in reviewing the
patches so far. This is highly appreciate!!


On Fri, Sep 13, 2024 at 1:11=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
[...]
> Is there any chance to upstream these DTs to Linux first , and then let
> them all trickle into U-Boot through dts/upstream/ ?

Preparing the DTS patches for Linux kernel, I noticed I will need the
handoff setup for u-boot. AFAIK there is currently no single handoff.h
or handoff.dtsi file in the kernel repo.

Shall I add the files to my DTS patches and ask for upstreaming of the
handoff files into the kernel?

Example:
In specific for u-boot I need a .dts setup like this. Those files are
currently not in the kernel:
    #include "socfpga_arria10_mercury_aa1_handoff.h"
    #include "socfpga_arria10-handoff.dtsi"
    #include "socfpga_arria10_handoff_u-boot.dtsi"
    ...

Since this seems to be common for all socfpga setups (arria10 and
cyclone5), I guess the situation is already known by a common
approach. How to deal with this situation in u-boot dts/upstream?
