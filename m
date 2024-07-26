Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ABAC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA7E886F0;
	Fri, 26 Jul 2024 14:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vijzsc2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BBCB885B6; Fri, 26 Jul 2024 14:59:10 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43BC7885A8
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a1e2ac1ee5so14488985a.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998747; x=1722603547; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FRGEQ0Iaji14MBxQqvmVDMfmcJCzuK8lHDk3ann2R9Q=;
 b=Vijzsc2yyP+80JkHcdeFcwOIUTKX7GtxdMt/XS04zEv1DkgNNukEr9MoXqae+c02Jd
 BdaLDfh9OcPXlSsLSMeAaJhPpsYHcgFQTfnEzSdKwpPgvAQUAuO/WHTqfq/gHpiMcQQ5
 0+exAl6/JId9hAPSKy5LHqj2smlm6GOWSQhtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998747; x=1722603547;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FRGEQ0Iaji14MBxQqvmVDMfmcJCzuK8lHDk3ann2R9Q=;
 b=KQOk+cbDAcfpesh+sfNjoIMirBreH9xhLHP3PoiNE2aI2rjRDsIMPaqdY2nuKVHlMN
 wGAT49Dt/MwphTqk/+cbYnUfvbjIz8FoVyZ+OjGCcLdpL5yjpmeqE3WhfCGfCH5X6/DA
 PaM7i8IdPXq/t6IrPpfVUBv10Xa5fnytVazVVL2hvxEVox2tnHbDVRxkKdPnjSDJxZok
 9D7ZCXBj0r2g9cAjCcC9NKyfecZ62uvsiMIfTGGqH9KsFMxILmI7dfES3p4atgPv6flu
 6T527uIvFTWRStp/Xid94gfdhMlL4SUAnZYGQ74/3ZGil3PY8NXqj84nptST5u4NqqrM
 vrTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLSsLsH4VU8+e1JXHu6w3PXwt+29MXEfQidI6+SG4RsjsKpj0zzoLEve0l/CWdT3hQXM6oHaNr/bzEto2+91k+SrjY9w==
X-Gm-Message-State: AOJu0YygZpNMKiiU+0deNvSX5+CSXOGM4X6vhUGqUf/azvJzzu64Bp+8
 d2XQ9ijgwD2/lcTldJGLc8TDCdJcUAmFF4uajSjjXL93Dpw7A5rGGHXwy9c08blYopVAVMM5PMy
 dATiTdkOp7zA3spyLic179iqI/5vY5vpVEXkm
X-Google-Smtp-Source: AGHT+IGMmqQoJv47PfjDe6D7Zf9ufZjS7HwvfdmFwXkfU0m6iHWxfE5yHA765TLONCfu1L2FgKD5fvbkYP0wXohkQgA=
X-Received: by 2002:a05:6214:252e:b0:6b5:d311:962 with SMTP id
 6a1803df08f44-6bb3ca2baecmr77216396d6.22.1721998747130; Fri, 26 Jul 2024
 05:59:07 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:05 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-13-sjg@chromium.org>
References: <20240717155712.2913651-13-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:05 -0700
X-Google-Sender-Auth: nemH36JgkDwiwmcQ73F-QLeJwE8
Message-ID: <CAFLszTjuF4Z-663+AD2G-VJnYLf5kDg0_H3oddZGypN7b6_rMw@mail.gmail.com>
Subject: Re: [PATCH 12/24] qconfig: Move converting config args to the top
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Move this check to the top, so it happens always. There is no harm to
doing this earlier and it separates the setup from actual program logic.

Update the arg rather than adding a new variable, with the new variable
only created when moving or building, since it is used more heavily.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Applied to u-boot-dm, thanks!
