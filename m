Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810F606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MRk8TTKV;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yujBNr60
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92ED6814C9;
	Fri,  6 Nov 2026 18:23:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KFHRBPFcEDSL; Fri,  6 Nov 2026 18:23:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E34588146D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793989394;
	b=VnN+fUjbSI+aNNvWGwmkz2Wmot808n3PNtcYSMyHJourb+gQFThJtTgghe+8abeEgL+Z
	 EXKoX+nwkSC8idwbFIzkfQFjqwmFOpBJFxpH17WRVGYNBji9O/wQMa0L67is8k87eJDUv
	 WiNX4Z1AUcUIGxoD5RSJUcaZMelBgTOcHuoN1AofjDECHwhFJyiQZRAyJkPRJaTKn19yz
	 RHbDLvlNNNnv4Edf3jnMqlGkFVY2A1naKhJsNHquh1sTBm1k5Zx9KkRPDSEjeILToPJdK
	 ScXL7YDuv/S508niG+1ARfOjbiff83MJS+iA3+MuJ64asrAI+jSoxgFzYScmGlngcCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793989394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zKx9P64Tbhc8Sc0bOtk1dvS/qREIkS+15GgBVIFtZ3s=;
	b=EhW/ZoxKy2yS2f3WJ93wnEjKsY4754SBgFoxHT7oRYRBxSgT7kgD3wkcpkDT6+TnfyP8
	 Q0EvjB02dCr47hiazgmxuEZtuPMPAYjuRKJosHPT3jpIMA3ZFROGR5LDo79g0Iyt5xoHb
	 ppBts1r2WR+NQir/mW4kKwSTBnf/70NEQAIxZ3Jjo5jHiosEDWsz8B+uFU++RjSymg8M7
	 akJXxw4AI/5rwPdAFumLY+xJpByJ9tbGMvW3cy7xLPvlM8Yi5pO68yOJYbz/gnndQ1EhO
	 TVvnORxAJiR9yiW/l68ahwvDQToE/IVtouR4jLhpn5McKJKmT7ePueujrepX+J98eLQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793989394;
	bh=zKx9P64Tbhc8Sc0bOtk1dvS/qREIkS+15GgBVIFtZ3s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MRk8TTKVHnh4AkZS5Ecgm7vnczvXIcAdm1OOCE1v6lVi1THXgrXarteebrUAx5ANy
	 dFBv1VR39lHkgn3+rLvkLznojF+vZhveKqrrG7noYGaeaRlRx1s3IOOVo5gMZ370vs
	 wi18Mjizei0qwpz9uxUnLjrYw2pvPuVzCdEJZLt//Zh4PacZnteyT7sJwXB7ZXLRRP
	 FjHfgo/ZI7Awl3LkPWihVfIaNFq6VhaOeLSGQMReyqKGI9YQwk63r1HHwI1Be0MBn/
	 Q0EA8mdu7ChmAck5KWLW6/UX9GhiEtHlMiKB6sKoOHEEudTeXSRGcOZySJ2DntpJ38
	 XGRLx8Q1kBmHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E34588146D;
	Fri,  6 Nov 2026 18:23:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CFB7F31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B45E260744
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:40:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aJou98gv_iZj for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 17:40:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 61192605A7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22f; helo=mail-lj1-x22f.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=yujBNr60
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61192605A7
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:39:59 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3ac97e45a79so8288411fa.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793986798; x=1794591598;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zKx9P64Tbhc8Sc0bOtk1dvS/qREIkS+15GgBVIFtZ3s=;
 b=yujBNr60HVgL9dY8wU5vf7CHWiUZSZ8BjwUFUnot2ahkDYbP7wMAF6FO6T9tGgcu0N
 nzDZBIlGYW2Tinmk3ceztQ1xMem1yQ4ObZLDIgpF4j8DpjUq9UIrWk4/8Q5qKdp4pGAj
 eqV+F6/CCHXZedV0EkuXU56qPSC4osdfhV+cXsQt1NcFtqG+ea0Inp3DcW/ML8LpX1C8
 ZfIhloaINC5v27I1O1TT9LZ7dUqnfYGQwRH5JV5XyKd89Kh0QjgoQzYLv/fX2qyCJuaM
 0knZOemM1CwCJVawOnJQ4uh7dBxg0GbenfaOX/faPtdreZxGgucErfAlbm/Xjucl3704
 rgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793986798; x=1794591598;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zKx9P64Tbhc8Sc0bOtk1dvS/qREIkS+15GgBVIFtZ3s=;
 b=xhF9l2TQesMol8qUBt9SjulcTh7FWezOaFeKg2XGCa9LE+GTzwApjhVBKokl5r4ehP
 8pE7RbugtHP0I/ko9SA4niP3gl3aOBOT1QaOGFPuCNIW1ubwclYl3aAwI/lIEf21GzS4
 Z82f/35D8PHiQguJlVA4n6GI/m+2X9879nEkXF/8Gkv+c8+mcBFcEl3v2wjxXJNLS1Y/
 u1moz6tCkdkf0VIemLIwd4qHfZMbLDdeJcF8+TxSxxBbOpjisoGV2iCaYOB/4FmjDpte
 F5ZXfoj0CK6R5v54dVYVxAQaDV2gvcP0LXqw7SElzn5+Sqe5EP0Ri+YK4yoZezfOar05
 A2zw==
X-Gm-Message-State: APuU4Z+wFvhZsLRovcUhihm/cOZt15rXCv1m9n1ILkXX0FGzyqen/v66
 XE/6nSk1mXd2NF4A3GmSvg3qu3ix5E20XjLNk7D9So6Ah9rJoAkWnNyQOkajDPcebeA5DAqqgde
 QlCqWGBhRe4j1A6cyrxsMTe/N4wV3i8bbnkLp
X-Gm-Gg: AYBFou0fdCGMCMnXwnLTuHL5k/YkTyLxxmx2uK13o2Xh6ZPZ0UR2UoHN5tiYaTdb/AL
 MP7rERdAUy6Sfd8pXSBc2VzgtbByk8gwIbGqZ3Ptr/nQBOxPwmY9piQ/xPjIt+QgG1VzATqNbS8
 Kiq9dHxYIEfLw45gBQz7jmogAKtuK0+lyQObG3w+5UX65XWlwiyvZaBkbUERXvBzsu9MQBF0BsH
 s9m21cbAFi1Ka1eaUnpIEYPkYqIN3bRp+cgw3LqBCdXARrtdfKopKQ8YByCx9bFD5pxTHaCmsw8
 5OYSFRbXq7azLXKwv3VbCHELEa8E2AY0q3nMvBGsQIe/ScDZLLkiz14uI375XPbh2LUR4AiEQeh
 BqpXKqlpzucnZOzK72EcqjpqAsGrAM/mbb6B8BLzLaQANJNK1CvEGTrwrruG59+IGZVtvkReA
X-Received: by 2002:a2e:a882:0:b0:3ac:de52:8f39 with SMTP id
 38308e7fff4ca-3acf388c21dmr7374431fa.3.1793986797453; Fri, 06 Nov 2026
 09:39:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
In-Reply-To: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
From: Mateus Lima <mateuslima.ti@gmail.com>
Date: Fri, 6 Nov 2026 14:39:45 -0300
X-Gm-Features: AclHuK8ATYnmmZ3Mta8JzUE4h3xB9XsCnUaxMPh1b9auhcYL8cENY2ApitbGMp4
Message-ID: <CAP8WwTHaAnbrpwcFQd0MZdH_jUxpJQf8z1XyicRaOhW=qKHtJg@mail.gmail.com>
Subject: Re: [PATCH 1/6] armv7: ls102xa: Apply erratum A-008850 on all LS1021A
 boards
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alison Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cb4565065f9f19d0"
X-Mailman-Approved-At: Fri, 06 Nov 2026 18:23:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000cb4565065f9f19d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @peng.fan@nxp.com,

What changes were requested for this series? I noticed the status has
changed to "Changes Requested," but I don=E2=80=99t see what those requeste=
d
changes are.

BR,
Mateus Alves

On Sat, Oct 24, 2026 at 11:00=E2=80=AFPM Mateus Lima Alves <mateuslima.ti@g=
mail.com>
wrote:

> Commit f9147d636ce2 ("Convert CONFIG_CHIP_SELECTS_PER_CTRL to Kconfig")
> made SYS_FSL_ERRATUM_A008850 depend on SYS_FSL_DDR, since soc.c includes
> fsl_ddr_sdram.h for the DDR_EOR bits and that header needs
> CONFIG_CHIP_SELECTS_PER_CTRL. The ls1021aiot and ls1021atwr boards set
> up the DDR controller in ddrmc_init() and do not select SYS_FSL_DDR, so
> the workaround is silently compiled out there, even though both boards
> still call erratum_a008850_post() from dram_init().
>
> Move the two DDR_EOR bits next to struct ccsr_ddr in fsl_immap.h, drop
> the fsl_ddr_sdram.h include from soc.c and select the erratum again for
> all LS1021A boards.
>
> Fixes: f9147d636ce2 ("Convert CONFIG_CHIP_SELECTS_PER_CTRL to Kconfig")
> Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Alison Wang <alison.wang@nxp.com>
> ---
>  arch/arm/cpu/armv7/ls102xa/Kconfig | 2 +-
>  arch/arm/cpu/armv7/ls102xa/soc.c   | 3 ---
>  include/fsl_ddr_sdram.h            | 4 ----
>  include/fsl_immap.h                | 4 ++++
>  4 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/cpu/armv7/ls102xa/Kconfig
> b/arch/arm/cpu/armv7/ls102xa/Kconfig
> index 9ce94555ed0..70170e735be 100644
> --- a/arch/arm/cpu/armv7/ls102xa/Kconfig
> +++ b/arch/arm/cpu/armv7/ls102xa/Kconfig
> @@ -9,7 +9,7 @@ config ARCH_LS1021A
>         select SYS_FSL_IFC_BE
>         select SYS_FSL_ERRATUM_A008378
>         select SYS_FSL_ERRATUM_A008407
> -       select SYS_FSL_ERRATUM_A008850 if SYS_FSL_DDR
> +       select SYS_FSL_ERRATUM_A008850
>         select SYS_FSL_ERRATUM_A008997 if USB
>         select SYS_FSL_ERRATUM_A009008 if USB
>         select SYS_FSL_ERRATUM_A009663
> diff --git a/arch/arm/cpu/armv7/ls102xa/soc.c
> b/arch/arm/cpu/armv7/ls102xa/soc.c
> index 7ff59edd452..60f63da73f8 100644
> --- a/arch/arm/cpu/armv7/ls102xa/soc.c
> +++ b/arch/arm/cpu/armv7/ls102xa/soc.c
> @@ -12,9 +12,6 @@
>  #include <asm/arch/ls102xa_soc.h>
>  #include <asm/arch/ls102xa_stream_id.h>
>  #include <fsl_csu.h>
> -#ifdef CONFIG_SYS_FSL_ERRATUM_A008850
> -#include <fsl_ddr_sdram.h>
> -#endif
>
>  struct liodn_id_table sec_liodn_tbl[] =3D {
>         SET_SEC_JR_LIODN_ENTRY(0, 0x10, 0x10),
> diff --git a/include/fsl_ddr_sdram.h b/include/fsl_ddr_sdram.h
> index 182f5836533..650bfc29b49 100644
> --- a/include/fsl_ddr_sdram.h
> +++ b/include/fsl_ddr_sdram.h
> @@ -146,10 +146,6 @@ typedef struct ddr4_spd_eeprom_s generic_spd_eeprom_=
t;
>  #define WR_DATA_DELAY_SHIFT    10
>  #endif
>
> -/* DDR_EOR register */
> -#define DDR_EOR_RD_REOD_DIS    0x07000000
> -#define DDR_EOR_WD_REOD_DIS    0x00100000
> -
>  /* DDR_MD_CNTL */
>  #define MD_CNTL_MD_EN          0x80000000
>  #define MD_CNTL_CS_SEL_CS0     0x00000000
> diff --git a/include/fsl_immap.h b/include/fsl_immap.h
> index 54d6e0ab377..759a484a926 100644
> --- a/include/fsl_immap.h
> +++ b/include/fsl_immap.h
> @@ -136,6 +136,10 @@ struct ccsr_ddr {
>         u32     debug[64];              /* debug_1 to debug_64 */
>  };
>
> +/* DDR_EOR register */
> +#define DDR_EOR_RD_REOD_DIS    0x07000000
> +#define DDR_EOR_WD_REOD_DIS    0x00100000
> +
>  #ifdef CONFIG_SYS_FSL_HAS_CCI400
>  #define CCI400_CTRLORD_TERM_BARRIER    0x00000008
>  #define CCI400_CTRLORD_EN_BARRIER      0
> --
> 2.43.0
>
>

--000000000000cb4565065f9f19d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi @<a href=3D"mailto:peng.fan@nxp.com" target=3D"_blank">=
peng.fan@nxp.com</a>, <br><br>What changes were requested for this series? =
I noticed the status has changed to &quot;Changes Requested,&quot; but I do=
n=E2=80=99t see what those requested changes are.<br><br>BR,<br>Mateus Alve=
s</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr=
" class=3D"gmail_attr">On Sat, Oct 24, 2026 at 11:00=E2=80=AFPM Mateus Lima=
 Alves &lt;<a href=3D"mailto:mateuslima.ti@gmail.com">mateuslima.ti@gmail.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Commit f9147d636ce2 (&quot;Convert CONFIG_CHIP_SELECTS_PER_CTRL to Kconfi=
g&quot;)<br>
made SYS_FSL_ERRATUM_A008850 depend on SYS_FSL_DDR, since soc.c includes<br=
>
fsl_ddr_sdram.h for the DDR_EOR bits and that header needs<br>
CONFIG_CHIP_SELECTS_PER_CTRL. The ls1021aiot and ls1021atwr boards set<br>
up the DDR controller in ddrmc_init() and do not select SYS_FSL_DDR, so<br>
the workaround is silently compiled out there, even though both boards<br>
still call erratum_a008850_post() from dram_init().<br>
<br>
Move the two DDR_EOR bits next to struct ccsr_ddr in fsl_immap.h, drop<br>
the fsl_ddr_sdram.h include from soc.c and select the erratum again for<br>
all LS1021A boards.<br>
<br>
Fixes: f9147d636ce2 (&quot;Convert CONFIG_CHIP_SELECTS_PER_CTRL to Kconfig&=
quot;)<br>
Signed-off-by: Mateus Lima Alves &lt;<a href=3D"mailto:mateuslima.ti@gmail.=
com" target=3D"_blank">mateuslima.ti@gmail.com</a>&gt;<br>
---<br>
Cc: Tom Rini &lt;<a href=3D"mailto:trini@konsulko.com" target=3D"_blank">tr=
ini@konsulko.com</a>&gt;<br>
Cc: Peng Fan &lt;<a href=3D"mailto:peng.fan@nxp.com" target=3D"_blank">peng=
.fan@nxp.com</a>&gt;<br>
Cc: Alison Wang &lt;<a href=3D"mailto:alison.wang@nxp.com" target=3D"_blank=
">alison.wang@nxp.com</a>&gt;<br>
---<br>
=C2=A0arch/arm/cpu/armv7/ls102xa/Kconfig | 2 +-<br>
=C2=A0arch/arm/cpu/armv7/ls102xa/soc.c=C2=A0 =C2=A0| 3 ---<br>
=C2=A0include/fsl_ddr_sdram.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 =
----<br>
=C2=A0include/fsl_immap.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 4 ++++<br>
=C2=A04 files changed, 5 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/arch/arm/cpu/armv7/ls102xa/Kconfig b/arch/arm/cpu/armv7/ls102x=
a/Kconfig<br>
index 9ce94555ed0..70170e735be 100644<br>
--- a/arch/arm/cpu/armv7/ls102xa/Kconfig<br>
+++ b/arch/arm/cpu/armv7/ls102xa/Kconfig<br>
@@ -9,7 +9,7 @@ config ARCH_LS1021A<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select SYS_FSL_IFC_BE<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select SYS_FSL_ERRATUM_A008378<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select SYS_FSL_ERRATUM_A008407<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0select SYS_FSL_ERRATUM_A008850 if SYS_FSL_DDR<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0select SYS_FSL_ERRATUM_A008850<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select SYS_FSL_ERRATUM_A008997 if USB<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select SYS_FSL_ERRATUM_A009008 if USB<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select SYS_FSL_ERRATUM_A009663<br>
diff --git a/arch/arm/cpu/armv7/ls102xa/soc.c b/arch/arm/cpu/armv7/ls102xa/=
soc.c<br>
index 7ff59edd452..60f63da73f8 100644<br>
--- a/arch/arm/cpu/armv7/ls102xa/soc.c<br>
+++ b/arch/arm/cpu/armv7/ls102xa/soc.c<br>
@@ -12,9 +12,6 @@<br>
=C2=A0#include &lt;asm/arch/ls102xa_soc.h&gt;<br>
=C2=A0#include &lt;asm/arch/ls102xa_stream_id.h&gt;<br>
=C2=A0#include &lt;fsl_csu.h&gt;<br>
-#ifdef CONFIG_SYS_FSL_ERRATUM_A008850<br>
-#include &lt;fsl_ddr_sdram.h&gt;<br>
-#endif<br>
<br>
=C2=A0struct liodn_id_table sec_liodn_tbl[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SET_SEC_JR_LIODN_ENTRY(0, 0x10, 0x10),<br>
diff --git a/include/fsl_ddr_sdram.h b/include/fsl_ddr_sdram.h<br>
index 182f5836533..650bfc29b49 100644<br>
--- a/include/fsl_ddr_sdram.h<br>
+++ b/include/fsl_ddr_sdram.h<br>
@@ -146,10 +146,6 @@ typedef struct ddr4_spd_eeprom_s generic_spd_eeprom_t;=
<br>
=C2=A0#define WR_DATA_DELAY_SHIFT=C2=A0 =C2=A0 10<br>
=C2=A0#endif<br>
<br>
-/* DDR_EOR register */<br>
-#define DDR_EOR_RD_REOD_DIS=C2=A0 =C2=A0 0x07000000<br>
-#define DDR_EOR_WD_REOD_DIS=C2=A0 =C2=A0 0x00100000<br>
-<br>
=C2=A0/* DDR_MD_CNTL */<br>
=C2=A0#define MD_CNTL_MD_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x80000000<br=
>
=C2=A0#define MD_CNTL_CS_SEL_CS0=C2=A0 =C2=A0 =C2=A00x00000000<br>
diff --git a/include/fsl_immap.h b/include/fsl_immap.h<br>
index 54d6e0ab377..759a484a926 100644<br>
--- a/include/fsl_immap.h<br>
+++ b/include/fsl_immap.h<br>
@@ -136,6 +136,10 @@ struct ccsr_ddr {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32=C2=A0 =C2=A0 =C2=A0debug[64];=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* debug_1 to debug_64 */<br>
=C2=A0};<br>
<br>
+/* DDR_EOR register */<br>
+#define DDR_EOR_RD_REOD_DIS=C2=A0 =C2=A0 0x07000000<br>
+#define DDR_EOR_WD_REOD_DIS=C2=A0 =C2=A0 0x00100000<br>
+<br>
=C2=A0#ifdef CONFIG_SYS_FSL_HAS_CCI400<br>
=C2=A0#define CCI400_CTRLORD_TERM_BARRIER=C2=A0 =C2=A0 0x00000008<br>
=C2=A0#define CCI400_CTRLORD_EN_BARRIER=C2=A0 =C2=A0 =C2=A0 0<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000cb4565065f9f19d0--
