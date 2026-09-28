Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657FECA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CC1480ADA;
	Mon, 28 Sep 2026 22:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ycJS7lf-ZmOE; Mon, 28 Sep 2026 22:31:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B452280BB7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634713;
	b=P86Lj1e2NG4YNN9r9dOMHPcLS85QR6ME2n4ysY8bnIEDpohYfRr8pOGYaGS4sOixbq2P
	 NCXO4We6vmDB3CTW8Spn0Ik0cTkpPCkONjgh6wf9uKnWbPUSC570SXJbBeSLLQWfMHlzL
	 4o21aIYIRo8W8QA+1428dMOgEc76NUQMxSViVMTk4LLAFZ+SWS4Xgt0DFK4AwMZgvu0id
	 08HS+ef2eGniN5P0yvvMIb697DbA6buYQRdUtewQ6+S8PPenEJb9Ih5Nrrwf2fzN57srF
	 ugW3xA6xwW4luHKi5FZpUKuNwKKIjdfqot2v2pWhw4dIM7yXm/eMMPj/3tE07YkwqQg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790634713;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vD6+DPxR/RgH0thmLJ0RssR1ZX/bHelxiWTOBS09RRY=;
	b=U1oneKY9QcA/M/rGqpPoDOyR/F1PdYr0a5aLd3KRS9hVbK2IgHJE+hBuQ9BZFiKpIARk
	 z6MtdHe8nd6PP+nhwCnEtK6z7ZY0zstz8/dRfwspauqztvHIoyaO9IQpU7Eds4giegzRs
	 NEsM72SE9TXRXXnzQ6Xm3ncKnkv44UlCXOAJ6yUpECtTeCrZbS7scJASuM9NVt5aTBRyT
	 RgqUr2waUYJ4S8xiroma3gJpcJsNHgSU9kPHEf/2IZMO18RadxN0TmGjO5sddw5mbxjhy
	 VGAAtv/OwkXQ7XncH2rJJzG8a3gTFemS6W4cWgAZymcCSpVgsYHgFwkRkNrINNsbutg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790634713;
	bh=vD6+DPxR/RgH0thmLJ0RssR1ZX/bHelxiWTOBS09RRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mhj2/b8OW5AFdR6PA5YQO5BP4ZmRzhiSR/SSnkar3DDw+FlWksr0jUM4OVGgWXFOS
	 RBH1Nm0FoCrMEVYyMK6mEF0iHg2wKk4v9XQPxfK9F9B2EXvgfLo2RFbQMkAGBf9xSR
	 Z4x2QM/UKhNs0GBfXV4VOJBPrE6wonJS0XZtu4r4V5+nPZTxJq6msADOu7SLR5FOzR
	 Izvd0t7RBK9xFPt39NU5A4jZaSrsBbwZM7amZU/jiShoqIHguvsM2A4hyiwRHtVyLO
	 6u/ydFXSQz2PvcNQbv49yhZgOcc3zcsZ+4fiV6jT9c8ERbs6i+4Zam/b3qSBOQHXNw
	 soNp5wLp8qWsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B452280BB7;
	Mon, 28 Sep 2026 22:31:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 52DAC61
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 327F840508
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:31:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zUDjfrvrBsmP for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:31:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0B55240507
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634711;
 b=YxWQrkMCjOtsDr/Av9d+fBGMHeluLT5xTbz+9SMuf21jmGayGFSAyz6itlTZ7nToNy+S
 rYSfaQCTREG+WF5K/e6TfDOeQ7Kgd+2/eXap6gUlwFX7dy1j27fAeETzRhpbs3KJjBXJ9
 JiZDJPJTsCOoLnp0WGBRGAazA+9PeZCK2WDORBRzFH6bOT30Tol9PsWVt91DynC2mTETa
 q19D8VtQIau4oJs1DZrFu2J1QG5XcRkJG6KJb6ycyz2+X2kx0cUnDrLYszpDarmOISk8S
 ux5LHkusYoiOfGTxYGUDAyuyyT6L+ST9WFuWdnhOSWYBQtgQ6SgHOtz/6/YeK04F8yQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790634711;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=vD6+DPxR/RgH0thmLJ0RssR1ZX/bHelxiWTOBS09RRY=;
 b=YbBC0xWjudEwNTuw1xMXTitMol7vZUzY2pfZVBmdRdvgY3aZJOvC9mIEp5RCXjSFaq3E
 QdVWwuq+q0ScqFYWskBNww0zKqTIKdReR5H703DIVZ5HjFrJTTVHLQ5Hp/SeQ5Xu0EeOw
 rVQMbDM+i4xWWXWUn6T9MJnGu/dsZrDhH6FO/yYFZzgT3QoDtWqXR+czruupm942Zy6NZ
 BjPbHPnIJ/D91dFwDHynbJb0AijvvrQne8vgXeoPOACVRCRltpLJNs/HGlh9mZk3Z1p4h
 vlzTEzoovLe5xrf8/z5XaidZpbcn7vvieslnPHLqi407DLx2dFC5ibzaCjg6eHFynHg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LQ6CVVvO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LQ6CVVvO
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B55240507
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:31:50 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a9984f9adcso6019356a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790634708; cv=none;
 d=google.com; s=arc-20260327;
 b=IQio20TJcs8w2qdK0WQnpSUgjh0VAbmgb0qIncXmwxNGSz6ZDY0vMx4eVrc4eSO48y
 G2Fzu8qsIRK6HN8JYvNDfHRAaOesdvTUYUl3KgNgF3vD4PvIC4pnswwHC4TTmuj1Q+Dh
 BhIECfKV3bnnTCkwyxqbgOvAs6ybb4nT64l8TK/Duv8tk7CglF7YqOipJFOvpBrB5JuD
 UqTKiMiisTsU78OAywXdAKmgxwSKixZnOp781GaDaihUC4KqfCGK8HosfRa/kZLUEVU4
 FQgNqaAqS5J5xzqtCaFNOMFwA1j63zO3n23QbODWJSgMltw1XoU0Ygk1heOwM0Rlu+AS
 hDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vD6+DPxR/RgH0thmLJ0RssR1ZX/bHelxiWTOBS09RRY=;
 fh=Tc1wbtTi8K2Luyog/Lo0QKDcIVTdXnXgzUsh3LLAkOw=;
 b=fMbegKC8ZYyE0x5c513K9QN8gOnYvR2XPbH8fLxHUzwfAv/b6yM0sSPvay1TQNvrPT
 1QmLT09oUpS3kIfXhwdgsI2bF3a/GSfrZZ82Hxc4iENfFEF7KSXKgrRsBtOWDW7V7p2M
 e/86if2OvJL1FOSuuMmZUteeZHh/xcPnhUpv/s70Bnq5We6SepzHv3d9wTOTcEfuBaze
 Y1GzzU9emLco5ohhbScgqTv6gC0Zy0AJ6f1WDsqVuS0s4HeyX+JdVzR8NlJJnewFJ8TS
 g3w1iOzmLPd9yy+/GDluTUvBtbah4JhWtJcWyh10BYO0D94vddLwXaRp59tDMFolVn2a
 mvBA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790634708; x=1791239508;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vD6+DPxR/RgH0thmLJ0RssR1ZX/bHelxiWTOBS09RRY=;
 b=LQ6CVVvOhU1o6Dpbq2TV4LjukXsZCbpsMRGKqqY35ZrWBwC+7LMtbZxDPu/NxWVEuR
 JZopW/VCsA7/hngGlMrq1vweRB8rlYF3HiRmb8jSP8AviW8MPxa6Pz1IF7jJs0/B088z
 CYalps6k4rSy3eEzfg7pOxbi7HkOBHpgkv6z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790634708; x=1791239508;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vD6+DPxR/RgH0thmLJ0RssR1ZX/bHelxiWTOBS09RRY=;
 b=NgSNl6xfhxkTtaN0uBDqh0fRibxqCYKPQ/3vMlTasW0V68Zs93nb+kZHFS8fQRmFex
 QI4ALh6BvU6fFvwtrTcM7nQlls0PjmAWXVScTvlzz0tWoDhci7RoNKOlPVbhfUSJlO7P
 nyNTG/bSaaQJEFt6qmIC59NVhYB6kQGqwN3SC47Ozvldt0C3xTxabDShuyW2mN1eJk+j
 NtbrQF3FMW1dBDvxX9w91dKu81H3lcqyCyKnyckOezvZAiYvyH5cylQIYQ7CpW3Wrs+C
 FloK+r6UHbDWk79Mq+/J+N4RmNJ7djRZva+E12ocdLz4NFEyU2D2sHf6S3U3PsnAnuzK
 TQTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbtx+11u7Tf2427GATJoizzekzPWtxWDry67+g2eyrVfH7as9Rc4MguEX2AXrChqfTTrt+gsQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIdkzJIMdHiYWBy4+uPKkOdr/1z8BMcDvnSVJorCK9L3UukCwH7
 E8A6XfBRl6GbCmsyQuRW2tHSO/cAGzeTZtxcU0uVACDqPnOdIdw+u9aOVH1iemxyl1ULb/Fanlb
 2wwyeXPpq87JiKp1r6Ng91HVRa7bdxw576RSA0aR9
X-Gm-Gg: AYBFou2VC0nJM4GXFTh54ygid1KPKv/zFGjNeSVwWP9UOsHPNJYSfNJxz0HPipWVctR
 nh9WRApoCfZ8530hgxH/ppDS8IG7qbICXumuKtqVv8FD0CCWddhapC+2RF+0JBj2AzWYen/+Jkq
 mMrQc3d8A/dMDXoVbugMxzDkUhMfG694zT6JV1LNFmF3+WDF+Bqq0oA0aWT9zVC5t9J+0qJ5bSt
 mOJeIW2NXLg/lIcKDxMqWaLl1TcjHM+ZYx6ZP9cSavbklZGoRiP07zW/HCiTy0MpHpK4zTKKOcz
 O2JV6rrC8mFc61s/6FonUyFFmgSYUTXDKq2UgJP/wC7JcPMvRbK/vdRbJQ==
X-Received: by 2002:a05:6402:400f:b0:6ab:e19a:16c2 with SMTP id
 4fb4d7f45d1cf-6abe19a310fmr5228736a12.43.1790634708393; Mon, 28 Sep 2026
 15:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
 <20260911-imx93-secureboot-v3-1-542a99793af0@bootlin.com>
In-Reply-To: <20260911-imx93-secureboot-v3-1-542a99793af0@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:31:31 -0600
X-Gm-Features: AclHuK9RMAjjvNATKAmu_3gDAiTvKrGFvWtAFJNg_bri7q4esfLaS5GqaFpO16s
Message-ID: <CAFLszThGJc0oFwLN8FG3zsVGsBLWAazBmo0Y-YAMU9h+xLdRpw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] binman: add nxp_imxcst base etype for i.MX CST
 signing
To: jeremie.dautheribes@bootlin.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi J=C3=A9r=C3=A9mie,

On 2026-09-11T16:35:05, J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric)
<jeremie.dautheribes@bootlin.com> wrote:
> binman: add nxp_imxcst base etype for i.MX CST signing
>
> Add a common etype which provides the shared functionality for signing
> i.MX images with the NXP Code Signing Tool (CST). This includes the SRK
> table property handling, the CST bintool registration, and helpers for
> writing the input data and configuration files and for running cst.
>
> The nxp_imx8mcst etype and the upcoming nxp_imx93cst etype will be
> converted to use this common base in the following commits.
>
> No functional changes.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> tools/binman/etype/nxp_imxcst.py | 121 ++++++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 121 insertions(+)

> diff --git a/tools/binman/etype/nxp_imxcst.py b/tools/binman/etype/nxp_im=
xcst.py
> @@ -0,0 +1,121 @@
> +    def ReadNode(self):
> +        super().ReadNode()
> +        self.srk_table =3D os.getenv(
> +            'SRK_TABLE',
> +            fdt_util.GetString(self._node, 'nxp,srk-table', 'SRK_1_2_3_4=
_table.bin'),
> +        )

Thanks for splitting out the common class, this looks good.

This line is 85 columns; the original in nxp_imx8mcst.py wraps at 80,
so please keep that.

Regards,
Simon
