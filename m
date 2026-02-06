Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB8FECD9BF
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 03:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E6C831AC;
	Fri,  6 Feb 2026 04:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bdiUc6+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799A98341A; Fri,  6 Feb 2026 04:59:35 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F2583015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 04:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-59dd9aef51eso2128398e87.2
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 19:59:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770350372; cv=none;
 d=google.com; s=arc-20240605;
 b=YfN2Zo5qMY43NDvyaAHhJm1k6XSSZXSqWeo3ZfK57iUG/U7BtEZxdfuMEWLA8bd5MR
 B8ASFjv8AkyqbaCziPUIb18RP5St4W3bP3CpFjKBhi5wgKaMKxouX6VNc+mVtPGAe2y/
 88UIHyc06wAlbyHHBxNQipyEW58n2Th9kpvQW0/+IhmeLdHiXKoSBC0QZ2RQ2eABmp/0
 N9Ke/jn4iMte8bGmm24ajK4OWJdVSLXrIPcPRf5mx+QXcR4qQPTih7Hd/m5/7cNQn/mU
 aMrIMNQgIsnaxojsOS51PdSFrhXvNez7Yr1yllxDOJoWgulbc1EiHCe/j1SnKHV0I+Dl
 Tncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=C4EWUPcYVAchjFVclvwZlMDE/Q5y34nRV19ndegaah4=;
 fh=pX4gXAv7Pt369UE5N/cjv8kwNYhexxsvsOUh+SqvkeE=;
 b=HIWWTMW8kMd35TIAsbUZrT4CRrvIsgGUMyTQvf9fNLCfccN8Z4mO6QaBO9VmjXYE82
 cOPrb8ol0nVXGXxNI/XQiLz9yHp36h7xaln0qhjkoLwHCqXHzUBWuRC3D9GRjcrq/J39
 BuyMbkSDBXdn/zy5W0c2hIUXZxWW3MWVWE5Vb4oAInQUI46oOYi7m9a9BV861SiGBDd3
 spMPxxG7/bwFRLGqIYowLUa/9BSr1x8Bl0JBcrKCOJr5plpgjddcFy08R55xlD8+I1uQ
 KHPB5D1Fo6mPtMLJGD5XScjoqgmgy21eUF20G+AOiPpDO/bHC3WwqhuLbXV+s9+2SlcJ
 GQpg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770350372; x=1770955172; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4EWUPcYVAchjFVclvwZlMDE/Q5y34nRV19ndegaah4=;
 b=bdiUc6+e/TN0OoqCsDU2Z4vh1ZmnHER/SLa+txRQXLsE+P6donBvYcTEL5dScrfNO1
 rqiaEP/FYw+LCdg7uKdh4X3fssoZu9nPDzw2TbsbZa+F2f61vdOfuEnW8Tf+b679XLJj
 1DixCwwIg3YYEeffriUtLuelPvD/0mdRIrqEM6VCmp2x47rD6Xg7F9IeWjqSEr7aPkQ3
 m1RHgQEdgxSiRf0uGwH5v4Y8h503H9ky4o4GehA9KQxqRp51+X0d4WXDp6XgC2IaCSwg
 IcjNJQlgmPAwORqsKZBtHaxEza02QQvis2jeL0DnQoLohTuzSAJuc9We0vtTeld6JTNe
 nejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770350372; x=1770955172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C4EWUPcYVAchjFVclvwZlMDE/Q5y34nRV19ndegaah4=;
 b=Hop6yyQY1lN483WKoPSowjFg9qNgxzY0UQC3Gted5YOEUBxg/iREijrQtXpmpAhMA0
 Fk9+Ggl4KxUl8XKni8WoEkbua8buCeEd3ysNfRjhGoBZLueDH+Rea6UoiBEwj1zbhjrS
 ytWzIp2lF23cj2CaEFOuVxgE1M2v5ijXPzIPwOBCx5kvYMO1ct3u6PKKzEM67ZK34pVA
 Zvzn41bPctPTuO+wWv4LbXsXGcUmGGWZK08tUmjRpiHOlrKlII0CU3x29nv0+M7SOvZy
 5VupeaICfWNiCJgWgfFHigGWRuxsq3efyhjcbRJjPiqnx/F9pyZPcB+Bi6z/Dzu7T8FF
 Lk9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIOUC/mpqSzqdewUUcgV+XsF799nM52FT+rqR8Y5pLe98ETBkmohHPJmh7v8iTgCsOEb2JMAM=@lists.denx.de
X-Gm-Message-State: AOJu0YzRIA1DNV6/TEHS/7k3TDZHmQzZgdto3awszuHzKzuafuiPaMJ1
 0kX1jMhuTxWF8digvAix63jxU46aCTPcZxWhXjwUIRD+XDn52KE4NMAN71E8zGY35mfPsLSIHtJ
 VQdn9J0mt8ppugSb4sN/3UmOK5a/HiuA=
X-Gm-Gg: AZuq6aIe563rSCaMmR9UD2kF3wlSjHDMMq96Q6XLQPDtLm/LpW+X1i15848Ad6Ci9ND
 RaNydavUylfRZu6KHwxyAPjFvJ+JCUf476nF7rgaG0uNHBfVCeUAZCEzvIcFCROyEGtcNInxKt/
 iOTlaGoCHHnCd0IJVfHVEME5V54gYgPumJpMjj0/lqFHOrGDQ3hoM43UWEXylG0JyFUiVmSk0+H
 drS3/JtWPdL2lI9bASnK/xgjbmvkfPncZK1n/NIzss27lOBCW+jEBTpbP/amfvfkvaAzRgNY9NX
 1o59Q6TeCWCVyDzk7yxm0pBp17Y=
X-Received: by 2002:a05:6512:1154:b0:59e:f90:2d0f with SMTP id
 2adb3069b0e04-59e45150e93mr369552e87.27.1770350372102; Thu, 05 Feb 2026
 19:59:32 -0800 (PST)
MIME-Version: 1.0
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-7-2103d0222a0b@nxp.com>
In-Reply-To: <20260205-imx952-v1-7-2103d0222a0b@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 6 Feb 2026 00:59:20 -0300
X-Gm-Features: AZwV_QhrjcDNWW-JjqllWI8AeHnGdM7UHiwb3BGwXmvOBl6HIfa6IlGgF-Zui-s
Message-ID: <CAOMZO5C1KB+PyQ2Kgr58uCKLE9sJPtws+OYwShe4fgkm_ZdTSg@mail.gmail.com>
Subject: Re: [PATCH v1 07/12] arm: imx952: Add watchdog base address
 definitions
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Adam Ford <aford173@gmail.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Alice Guo <alice.guo@nxp.com>
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

Hi Alice,

On Thu, Feb 5, 2026 at 12:16=E2=80=AFPM <alice.guo@oss.nxp.com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> Add WDG3, WDG4 and WDG5 base addresses for i.MX952.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  arch/arm/include/asm/arch-imx9/imx-regs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include=
/asm/arch-imx9/imx-regs.h
> index 2d084e5227a..7c7a34f74af 100644
> --- a/arch/arm/include/asm/arch-imx9/imx-regs.h
> +++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
> @@ -17,6 +17,11 @@
>
>  #define ANATOP_BASE_ADDR    0x44480000UL
>
> +#ifdef CONFIG_IMX952
> +#define WDG3_BASE_ADDR      0x420b0000UL
> +#define WDG4_BASE_ADDR      0x420c0000UL
> +#define WDG5_BASE_ADDR      0x420d0000UL
> +#else
>  #ifdef CONFIG_IMX94
>  #define WDG3_BASE_ADDR      0x49220000UL
>  #define WDG4_BASE_ADDR      0x49230000UL
> @@ -25,6 +30,7 @@
>  #define WDG4_BASE_ADDR      0x424a0000UL
>  #endif
>  #define WDG5_BASE_ADDR      0x424b0000UL
> +#endif

Can we improve this and retrieve the watchdog base address from the devicet=
ree?
