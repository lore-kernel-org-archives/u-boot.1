Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE58C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 12:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D68884F4;
	Tue, 25 Jun 2024 14:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SC2S98sN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F868884F4; Tue, 25 Jun 2024 14:30:35 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F0B1884CD
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 14:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b4fc5c2f08so23362446d6.0
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 05:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719318632; x=1719923432; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fpFtBV8mA1djt87YpEDdbuprUGfsX9B24AWZCpqhuqE=;
 b=SC2S98sNmeamnQmswhuYg3YcSRB7v78mBKKtV9faAYIpHF7GKeS4pd5Di/38qsz0uk
 irulVCrOIoa2OxCbeosbc2hKryRuR8fL3xRbW9bfiZQ/NYWVAe/8cUTx2unfWzwygpaG
 A2nzVkse75XuC55PG/L91HVpQMK19Z9zZyD+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719318632; x=1719923432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fpFtBV8mA1djt87YpEDdbuprUGfsX9B24AWZCpqhuqE=;
 b=fZd2c6W3qofz5uPEoFcKpW1uuZ5yrSHXlFbQCAph4WKErUPCo6XvTDRRce1xfV4hAD
 Dlti0Nioypge5TBjXs5aGZFA2Vcv4WQmav0SQ9N+Jw1FGfw0AkP4FVjE3y1h7geoB+gw
 a338aDZa2abbhHn16DV0CbtdYogzGD1BL7cQkCiOKlLDppSp8djipBcu0FDwZzkxGFsl
 LMh/QV64YbxwfOfVo+rPZXfnczdijVlo8brXAlG0E5+jGaX/ujIQrdIssxj039WwmbT9
 lUsrWvee2jDj0Gjju+1iCs4epkFDfSReAxz0dBW1id324v1r+6ajSih+PiOm8VbTFNmG
 QO6g==
X-Gm-Message-State: AOJu0YxadRZGNY/30nAbkGUa8XlAcHmPUW/zxFWwdoI+rdNwbI4KcXBl
 g6MJ7tBlyPQdCcQQ7P3hG8FmKLoqchnuzNaC9gQg7knH4g5Z7wrbPgVBavRhUkAdhZWWO+QpHyu
 VVTgeVJvTy2En4AoO83HwoO2tONVNy4gjmeTy
X-Google-Smtp-Source: AGHT+IHP/nu2c7UseEYpe31gk0NIHwUKGgSnivCdZ9JIfnbdiBj7sAs9yLwS5nzsrgRYOn8LezLdfX1ZGhBaS4gJR7c=
X-Received: by 2002:a0c:f74d:0:b0:6b5:5c9:d1d9 with SMTP id
 6a1803df08f44-6b53bbc4818mr76599696d6.35.1719318632371; Tue, 25 Jun 2024
 05:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240624083450.90297-1-pro@denx.de>
 <20240624083450.90297-2-pro@denx.de>
In-Reply-To: <20240624083450.90297-2-pro@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Jun 2024 13:30:18 +0100
Message-ID: <CAFLszThMCOvbKdRTUJ_kk_uj31dwnuwgjK6AZwuLrm0_aZOEYw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 1/5] x86: provide mb() macro
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, bmeng.cn@gmail.com, caleb.connolly@linaro.org, 
 christophe.roullier@foss.st.com, epsi@gmx.de, eugen.hristev@collabora.com, 
 festevam@gmail.com, forbidden405@outlook.com, ivprusov@salutedevices.com, 
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com, 
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org, 
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org, 
 n-francis@ti.com, patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com, 
 philipp.tomsich@vrull.eu, rfried.dev@gmail.com, seanga2@gmail.com, 
 sebastian.reichel@collabora.com, sebastien.szymanski@armadeus.com, 
 sumit.garg@linaro.org, trini@konsulko.com, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Philip,

On Mon, 24 Jun 2024 at 02:35, Philip Oberfichtner <pro@denx.de> wrote:
>
> Implement memory barrier using mfence. Linux does it equivalently [1].
>
> "The MFENCE instruction establishes a memory fence for both loads and
> stores" [2].
>
> [1] linux/arch/x86/include/asm/barrier.h
> [2] Intel=C2=AE 64 and IA-32 Architectures Software Developer=E2=80=99s M=
anual
>
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>  arch/x86/include/asm/io.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index 5efb2e1b21..936ad6f588 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -244,6 +244,7 @@ static inline void sync(void)
>   * have some advantages to use them instead of the simple one here.
>   */
>  #define dmb()          __asm__ __volatile__ ("" : : : "memory")
> +#define mb()           __asm__ __volatile__ ("mfence" : : : "memory")
>  #define __iormb()      dmb()
>  #define __iowmb()      dmb()
>
> --

This exists in arch/x86/include/asm/cpu.h so can you please remove
that one as well, in this patch?

Regards,
Simon

> 2.39.2
>
