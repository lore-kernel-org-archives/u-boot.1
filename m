Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7CF109B481
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 15:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4292584011;
	Tue, 31 Mar 2026 17:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L6ZcMj7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC0083A41; Tue, 31 Mar 2026 17:00:30 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74DB384010
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 17:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9c01854477so116290966b.0
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 08:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774969227; cv=none;
 d=google.com; s=arc-20240605;
 b=KkPNkmoW+IT6VA5ll2tHh7nAWP4kogUaqZzjL+eyFbb3H6uxecY6D7zWBNzmd5brnu
 dN5pz/vbThIJNdrWTP64HsOaoVBPRtgLTGH5AY0hQQgqHwjqcthRk+GkyEVDJHDaArwd
 K70CW3gDxM1Hvm+1wmjQD0/uE6H8CPQOoT0fdEMa/CjfdflKd4Wa9TR9KDs77UZN+xa6
 EHCGv3NeVT1/GUv2fScF1giB3pi7hQ6Uz4gIwULfcoJgyO5jO+TMzFGFm73T+nP4IBPo
 +3SszvSAmuYvVdB6lD4fBvZpnp3Ju1ILBt9j+KTdfTUTcOstbZwAQx57zf6MlvSy5Lya
 HxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g/lVllOkaqNHKkYHYSzm67VxMnWm0LeSguVGxHpYdUs=;
 fh=qjB3nBOJ0/N7iM5BUDghjmyYYspP4cX98xiGXQpl+L8=;
 b=Mdz5uX5kF4bYXE33tL/iCCjtO5MJOMI969oAqGOpKDwD/vGJwT/vmeozZZ7ENVVOwg
 TsRFjZPfOt2c0Ur/k7q0jT8e5tvhqawvh8n2wV8wwmaZUQbHlBAVmMHbHxzl0kQvZi51
 d9TAKXLZyzBob84IZgsHmF/0LedEkuNX3x8x6y9eo1fjMTuGnTI2lyaZpCSinyd9C4C4
 iWwPbdYbMleWE0gUUcJH+Oo74wg+hxvGqa8VBagRZBO5KGJtuBZTiKzUBrT/UiC0stVz
 0P9GPi//HxZgurkmkQthV9BvBydvFnaXKVx7wcycy3La+SX/MPj1IGsRUzz/ysQTbNSk
 Zhow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774969227; x=1775574027; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g/lVllOkaqNHKkYHYSzm67VxMnWm0LeSguVGxHpYdUs=;
 b=L6ZcMj7rNnsP73WGeR0i8+mzb09oBbxl9zPP9U61Q9utRPc8s0UqeMNSkBaLAuT2Di
 xHC8yZVmw7zLIGzxhTsAxhogN45hBxFx139xxRdPO17sG6TCXFeIU869kKTkRUoGZxUB
 N5RfAPFshzyCpkviAwFue6DmVrmakc/c7oEyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774969227; x=1775574027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/lVllOkaqNHKkYHYSzm67VxMnWm0LeSguVGxHpYdUs=;
 b=Z//Aw18r4xy4D3VX1r5EqlXcDgGGQ3LqLPw96eoIUxkx+L0AxQftWPEZa0BrugEfv6
 v+CgMEazRdNuCS7/2iKBd/yNovtPA5SseoTrnz15sprEbB4XYsoM8DZx5AS0wv0tFaQn
 iRhG9qbh7K00eps/oxvWbRZgAivgxuZcCLVys9VCk5AOnpbqY3DeSqmA1pqEY40X6+Hq
 NTCNGeGyZODcM83xciqpY4ESbsIcsBAdrm6DHG7vT/079Ax2v3Q3ndjiUPxOrkFRcCUd
 Hyr+M4myh9ePY/eTX69qms8xyEmkMkamMPnK5JqBxGaxKzXAji+7H5rWyjGTTY4irPdf
 1YAQ==
X-Gm-Message-State: AOJu0YxdmEWzRpmGx+8HOHRPWsT4ZBENtUcSTHMk2kmYyqCL/4R+8q46
 zLp/RAVUlq0f7MCnkambXXtPVPF6Vyhq9CPbIAZ3fClqEsaGTDnHW/5duqrJZv29dHZGT3gzyr1
 c3GwhrGciNNmijB0zeOOyifRgjz0YKkn1nMlqDI6/
X-Gm-Gg: ATEYQzzmlgN0VdOwc/nU0j9KQyB59PGPJs2mAgzSo7cHEPE8oWrt7LO4624PyrMZ8iB
 aUPcjgWG1X1s1kGIVSmkqa7aoZeaKTHxulZCnQQdj/9QRz8Dv/r31Nv3wJaxSZAIyI5RqGbjcTa
 jqEDSbakxwTMWkaa4f+HzTR1Ea6Dt7F/x/hF+oj565XhtY/gznx9RzVHBkTm7wtJY1J5xixXpBk
 Lwbg5YVhtNP3DdoLcYZISOr0PuQZugE3AGlHt1QB6YEW1HWLaHsUH+5MY4kF1S4f9lxpmUAJA+X
 b/hJUg==
X-Received: by 2002:a17:907:3f9b:b0:b9b:6869:bab0 with SMTP id
 a640c23a62f3a-b9b6869babbmr1011699866b.2.1774969226005; Tue, 31 Mar 2026
 08:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260328171624.2377527-1-dario.binacchi@amarulasolutions.com>
 <20260328171624.2377527-3-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260328171624.2377527-3-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 31 Mar 2026 09:00:13 -0600
X-Gm-Features: AQROBzBXseBsdBTsu13eAOP2tSgh1OQNlKd1GqWFTZQdu5yAmvPvJblGemrBYIM
Message-ID: <CAFLszTgDLJGtNnHafAG43B+o_egxkevJ01MVWu=gDGYoYmWX-w@mail.gmail.com>
Subject: Re: [2/4] cmd: part: support lookup by UUID in 'part number'
To: dario.binacchi@amarulasolutions.com
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Tom Rini <trini@konsulko.com>
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

Hi Dario,

On 2026-03-28T17:15:13, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
> diff --git a/cmd/part.c b/cmd/part.c
> @@ -139,6 +139,10 @@ static int do_part_info(int argc, char *const argv[], enum cmd_part_info param)
> +     } else if (uuid_str_valid(argv[2])) {
> +             part = part_get_info_by_uuid(desc, argv[2], &info);
> +             if (part < 0)
> +                     return 1;

Please can you update the help for 'part start' and 'part size' as
well so they mention UUID?

> diff --git a/cmd/part.c b/cmd/part.c
> @@ -139,6 +139,10 @@ static int do_part_info(int argc, char *const argv[], enum cmd_part_info param)
> +     } else if (uuid_str_valid(argv[2])) {

Since you are adding a new feature, could you add a test for this in
test/dm/part.c?

Regards,
Simon
