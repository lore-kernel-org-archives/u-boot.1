Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317A9C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 21:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABFF0830EB;
	Thu, 17 Apr 2025 23:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NaYuXLZ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3F9582CF1; Thu, 17 Apr 2025 23:36:05 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEE6883039
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac25520a289so180659966b.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744925763; x=1745530563; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GxWz1dYRJ2WaeJYCkGMc9DL6onL06ca3lPbwju46oE0=;
 b=NaYuXLZ93eojunnABXDyfjKDpfWFDtkqhJrUOCMRzVkStmtf7M2dttopvXm6bwnLbJ
 TzftcmzyeQfwqPwzwtWxZVnSb5n0iC5R2xTHYURdpYPEuOtWD/7T+CqXVBD62waasUeP
 S9RDiFQyptps+yE94ZcHMtwobR06/gPKRByb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744925763; x=1745530563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GxWz1dYRJ2WaeJYCkGMc9DL6onL06ca3lPbwju46oE0=;
 b=pwbN7AioDv7rOIf7e2CrvqdFFrhaDUaESwEy/LSG9t0mWeY2xFOgjsgGqul7G7s7hr
 RvODGUB2KuxafuPTg2bQhChAfM/+qv9wPACdiAScZLLlO9tVEqtlPHnjra4N7JEJf/qR
 XA54R52lsM0Bb5QuyEhxoxrLoAHPB/2mY924pVP8TutK5dY0im+rHj2LNF3G0W33VkZt
 /x/hcCdMSHFenyMg/cRXeW4nGERrtPZkqYMfgYWUixK69s6/KeyS0lPyxbBGROuyO3MI
 E0NxGesc8DTNsv8H21nNOnbHqKaY/7iKjydZgF+mU8DM2SGmvR8HFH3X81GOWv3LCat9
 Kg+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuBsVl6EXucJrFD7mqm/YA1Mj3xiSD6R8ybeLegVqLnQYmDtYXIx0mKBz8kdK2ITBm4X4/pM8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywau1NbTNuW/Hg+iJFkvuZ8ydZDsSqRgQkq3bObv9xA16BTWeF1
 5pczY8yI43hCUqQcmQQFd6scMawAhyda0LWcWzDf4bTyrZRMHAhwZArNRa/fTP8L6hqk/G1+bY3
 jc5HMPnTXOThbPbCiZXpOtL/Z8/zePPYusLU8
X-Gm-Gg: ASbGncvpvhpi4eNryZRQ+VuVuIoX8XZ/NywB2NjU5npuXuqIa1wdD50fKR2g9PZ3TS5
 MkQFYN5Qe/Unb0xv54VQXQXVdiz7vzW1nU2o8GERruHXMUbbOB31BBKWMetdm63tsCtptr3Q8Xa
 jZSzKes691RaMmc/M+3c2VfRM=
X-Google-Smtp-Source: AGHT+IGx3ES/NlN0IPvARq6PgMMnqeyTYW3qJ2yYYfCgewmJ6fx6cpN/VFjTKTe2SwFzN6LhwM90HuSBZjr1fR7Z24E=
X-Received: by 2002:a17:906:dc8b:b0:aca:aeb3:c220 with SMTP id
 a640c23a62f3a-acb74720810mr38649466b.0.1744925763166; Thu, 17 Apr 2025
 14:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250416162533.1396-1-ziyao@disroot.org>
 <20250416162533.1396-2-ziyao@disroot.org>
In-Reply-To: <20250416162533.1396-2-ziyao@disroot.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 15:35:50 -0600
X-Gm-Features: ATxdqUHcYS9gz01cmli723NgSMdZBcJewtL-Y4PXFp5vtFZsBQ1gsS6AEAVoZbw
Message-ID: <CAFLszTjiRKMLny_RcRB4sUV75c8_QLFkw4u_x6qfs3k1q=KsDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] riscv: dts: binman.dtsi: Switch to u-boot-nodtb
 entry for proper U-Boot
To: Yao Zi <ziyao@disroot.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>, 
 Yu-Chien Peter Lin <peter.lin@sifive.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
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

Hi Yao,

On Wed, 16 Apr 2025 at 10:25, Yao Zi <ziyao@disroot.org> wrote:
>
> Switch to u-boot-nodtb entry which precisely represents a proper U-Boot
> and could be matched with u_boot_any. This allows RISC-V ports that make
> use of binman to be built without disabling SPL_BINMAN_UBOOT_SYMBOLS
> explicitly, which is set to y by default.
>
> Fixes: 0784510f741 ("riscv: sifive: unleashed: Switch to use binman to generate u-boot.itb")
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/riscv/dts/binman.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
> index 0405faca574..b7656423b69 100644
> --- a/arch/riscv/dts/binman.dtsi
> +++ b/arch/riscv/dts/binman.dtsi
> @@ -35,7 +35,7 @@
>                                         compression = "none";
>                                         load = /bits/ 64 <CONFIG_TEXT_BASE>;
>
> -                                       uboot_blob: blob-ext {
> +                                       uboot_blob: u-boot-nodtb {
>                                                 filename = "u-boot-nodtb.bin";

Also you can see the default filename for that entry type in
tools/binman/etype/u_boot_nodtb.py:

    def GetDefaultFilename(self):
        return 'u-boot-nodtb.bin'

so you can drop this filename.

>                                         };
>                                 };
> --
> 2.49.0
>

Regards,
Simon
