Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF48CA5FC4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5FE88121E;
	Thu,  1 Oct 2026 01:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQHdvc-wZNtC; Thu,  1 Oct 2026 01:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C02D381214
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790817029;
	b=ta8SQjce12FobOfYUem8eGNkCzZ53Eok+tlv2UuBW2ss9Z32RyI0OsDG4w/30/R/3dVZ
	 TTtcRsXPKfAqb3HEJu/vdwYbMVT7fUXuv88Av4LhlnFyCzMujM3VqYXC5CKAHgUx8u2Eo
	 i5xzu1JPqMCa/8iP5EwUxNcVviYV8jP1FhjoKOE6okytOXlUA9IGNwQP1KgeoumC5wub5
	 uiko7MXH3Se4yQhfN4UgIPggcMTE/W5S8GxO8GTvnE5IVd0hUItGz912Oi6HEvtkF+Gjd
	 JE5sP2Dw7AnrpL6Mfgzr4CiMBqQ/NdyTb0h9i5dUQHVW5gQfh5FrIPXnCcMq78wbKPg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790817029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=i+37YPrt8+4b0uDxIQJMMHaKjsimSyfXMR5eKpu/HV0=;
	b=iFpTKcEpjfwiUrV3d2MGsOVDzKkO153cdn8NiYmaN68sOKL474l3s86Pf6HY9J0FLFmZ
	 82sLoi2UOFiugjrF9AuDzgl5yOQ8Uw73mxV71eu2cc590Gz++W86cytn1GpfNJeo2Y6wh
	 cPfp+GstiOPAKhU66752kYAGFfQpE4qb/EsB+ssEzy8ZdIJAm7I2sAcgvs6P8ueN7F+aM
	 DPw3KHLFKkJXRUOhjhSzOoYbEpMFjfK1okjJbBAIRoHFo4b9jBNFiY7/1N99IZ7mZi/sz
	 6dP810s7LfXYqsN0GZWI2/HQ8mrAkSQMGFVgnhNg4biJ/CMG0oZvZw8XuIrE5CyLeMg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790817029;
	bh=i+37YPrt8+4b0uDxIQJMMHaKjsimSyfXMR5eKpu/HV0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=psSnXGwAk65U9U22hH5jKIcy5n2V/EHXaJAnlr/2YvmStQhkn4AcnUYirVjy4dGQ6
	 xVT5o6ZdcBHa9zyHoGeal1G6bBkOK3x1RJ7BeenxD6RnywBeuZt/YO1qQt8PK4nhNZ
	 Sjj8RWQuC0f3VPLqXoKVyvpcWxNLynBFJk9szTZ2lKgAqjKbdQeusa/nRkNobT2J97
	 Q0jELgIjo6T9Q/ZnT07boKxIeV7OnCfFeQRR0xV3UjPhDp+X2EO6nmXUPKIpoaTJaP
	 Om2oNut+Sh3CanlF5kqSiCbZhHbvx5yIWZ5/MBzUyy7hUcGL7EGQn59owE5vZ6RMoD
	 iG0JsE1cFyOqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C02D381214;
	Thu,  1 Oct 2026 01:10:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC24A116C
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:10:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 896664025F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id coOcl1jyKZjn for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:10:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C13DB400D0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790817025;
 b=Gb7BetzOpMov4LUgFrL/0ElDDGb4QKK6u/LdKjhs/GCww7uEI1ultfw678aGdEGZGQmC
 f20piluJjV/9lttEU+ceg9fGpih92Id51KijbF5ec9+4PIExyTOHjXQFp6gI/RiIeC4vA
 zJKHFZf85ueoppmCIafMrYAXzCYnLPaCF2IdHXTwOM++uu3sKTY6CjKpWYdwORgR63gkZ
 oxoS6zEt6jymTTwZv6348GFI/5NKlXtyCsT5YGp7KhenF/Lwi35OiUrZ7c8KN+vuMpcT7
 KO+siDDMYriM14tvRpbB3lcJ2mehTpd+fQtBELYWLvIrqA0m0N1jqn8xJiL+HUI2FCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790817025;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=i+37YPrt8+4b0uDxIQJMMHaKjsimSyfXMR5eKpu/HV0=;
 b=ZqKxQ74kQPiFje9+GMA3//hIDmoWaKatmS7dcnNch7Ob4IYISj0xyaus7M5rtU4seJk/
 uCZRgn0/Rkrqhx+ZpJUdfVyEHAuOtdiVaPzxeJi95KPgmoG22fdyHfZ7w510EkeTav1EH
 WeqWCaUXEAk/g0A8KZxzZTZEhEVr4eTL0x3tElKGFvG16oZGJXEOxRtWOJtzM9Kcl+0gf
 uVsowUYzhrn16EzKCRfPUibIq1X1RPRQKHy4cpSTNxK5ADRQCyc25r862bJzrNTyyW0UW
 Taa1AM72GdtaKiNRhy9WUovPnDPVYGMxB5hrEbSFYzi8kpRk3y8uksV0LjqhRbgh+pQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iRFgweZQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iRFgweZQ
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C13DB400D0
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:10:25 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2caced6038eso1435065ad.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790817025; cv=none;
 d=google.com; s=arc-20260327;
 b=HHOAHH1OHpUUMC7oRaE6LsjlJWwyGO6GPPxK3QigdnZh6jhJFwokkl6cG6G/DSe531
 iaPN5mTQDU4YC9ziibfRYWbfUz4mwA9+wR54uGaSHjSF1HB8MMsVAmuahcnHzqHFIRX0
 k/rSWsvL5BJsBLRZES/6NuPSQSTu9EVeqacU7Skj8rlj+Fwme8Be7eRKqZpEMdXtQMZy
 kqyZ4tvCzu7UKPzatn343MR2J+qFVuOFCaOMGcdaaZh1gpGfGp7A/RbceQ/25emyjOzU
 PI7/YWPv8vsun+ef6f3NUEfN8/8ZJsrXt3YcFchLIA5WzMSGzyva3hbRt+bAWqkn0duy
 rv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=i+37YPrt8+4b0uDxIQJMMHaKjsimSyfXMR5eKpu/HV0=;
 fh=t1yYVnAwSUCI7XDMMoOfn1vh2ZSLieBmy7TTW1AbBu4=;
 b=C+O6gRBGwufIoa6nslvbeSj/ttriiw0OgXUTNLL9NNWviQ8gT3Y2y+DfY8RbaZOztq
 rsP+n4hd+Z8/hiTotELMMNulo2hGJC68tuKLIFJ51J72zv/eeWG3DIoXXJZbAY11b15p
 0PBruzs0FafhVbkiBRV2fpUeInH44J3dSn/NTi3CRLbCW0bYrU+zpZpyIysLccHW1PSI
 lp+L2lmBAL7FkwedJU4Nzh1Yoy84wR7dirGv+OcsayoyJYCCudlS5bildMJchFZ9W05d
 PUOujhguJeILr7SV2aXYjtuRwQ4quD1kcMPbniy0e789S+7yxoUBgWfg571u9XopvzKd
 yxAA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790817025; x=1791421825;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i+37YPrt8+4b0uDxIQJMMHaKjsimSyfXMR5eKpu/HV0=;
 b=iRFgweZQRUBlrY5xCRZmim8zxVHYawgQdvSCcNkkr0C2lF78wdIKkdrUqTne0CV91H
 y6voIBY6u9fWuo6x6WlIcmJeaigMvpiXzINOYOAyzrmLaw1/pCSfWAEYuuec7JjKRBXu
 GhLX9azjB9P6keGjFwIuodXst5KG/jNaoMBLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790817025; x=1791421825;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i+37YPrt8+4b0uDxIQJMMHaKjsimSyfXMR5eKpu/HV0=;
 b=Ex5p09VQCG+2HxtLdI+eNhYkFxg+vM5Wk3ubr2jD2cQgAdyPZMfnsb+sWPC60UZkWc
 Yn5dFZgftcVwy2S43iDeNJ0EbXWsYoi1ZLYDcsdIeo2f6BAVBLF+SFzQ0eZrxzs3NTIv
 CKcRqRhmxcCqCHRQuQlalal4z75rtvstFZOM4rinq9Q/WFNRrShQ/XfzM6wFkmUjFcfP
 L2qkuNf1LthkXr16QKvMdtIzDeH9FVSj2d25+Sej+5b1OB6elSg4OaXvwl6IWo2ZeAba
 ilr+eF6hBt4KSffATS4ftl9lCnCrxAYWZL9NVuelcF+VYEAenGmxh771PhTELDmOsDGs
 s+Mw==
X-Forwarded-Encrypted: i=1;
 AKwUvByZOmRv+ofvEd5m9jSI5DlzCR+oM6Hun66vvRKooA8lfERE32XULmhMieqOezS26Q/aoGjG+Gg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIl73nGDlvt/twzkzhjrU6kH/3DXbhibPE+z+uCqUiMTIfV12RY
 Y1eiDxtEQ+3NZHbZ350OwDzRExsPlBHos/RIHnfSF/PamHkyYo37/Db96pomUhS1btovZAXixKw
 pxzcetzqs4dAuzi5wrGZ4VjH0pNSV5TB6h8ZSZpVi
X-Gm-Gg: AYBFou0JYgsgNA9Cb4qZHVW3J83PG9zQSGOpACSVZK6hDLUraIPdYMNjmyG3f0mOv2j
 zsVhqJAzfEeoa/YEQkkgiYlDBmQG8T3XvS89bk37Z3By595j1Agv9RrYzg4GO0+oAyx/j1CHeWR
 ZEacz7Z/8Z819nHj6kyo7U3800DekRGk014h8T/z9K4WtbR2gJaE5xXP8+WBW27WPnQmyF7bk7e
 SGMBUourL2XXFZTxUeHdmpno0W818q/KjePfkjsTU1MmWDzZEsp/bf6lVvbjqBdEnExkGJv+Ihs
 rSB785KrAsssvJ6aKJhhTFi1OEhZ8QVUOZtxZ/GSZpsJ3gVzhXoo1fdZAPX55jomLM+J
X-Received: by 2002:a17:903:3c43:b0:2e2:e0f8:e58c with SMTP id
 d9443c01a7336-2e30014eea5mr6278365ad.21.1790817024712; Wed, 30 Sep 2026
 18:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com>
 <20260930-imx93-secureboot-v4-9-f968a1b14dc5@bootlin.com>
In-Reply-To: <20260930-imx93-secureboot-v4-9-f968a1b14dc5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:10:09 +0100
X-Gm-Features: AclHuK_9ULVVqfxOWCi-9s2hpCnET8qnZ1SkODJkMQwNQUI06d5rK4uVTXanhYE
Message-ID: <CAFLszTg5vRcgCx50w2nmjZnDFWJHF7=3JF7J8jeQyto5_tosqQ@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] binman: test: add code coverage for nxp_imx93cst
 etype
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
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Lei Xu <lei.xu@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Vincent Jardin <vjardin@free.fr>
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

On 2026-09-30T13:42:33, J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric)
<jeremie.dautheribes@bootlin.com> wrote:
> binman: test: add code coverage for nxp_imx93cst etype
>
> Add test methods to cover all code paths of the nxp_imx93cst etype,
> reusing the pattern of the nxp_imx8mcst as done in commit 0cab35362d77
> ("binman: test: Fix code coverage for iMX8 and cst bintool") by Simon
> Glass.
>
> This brings nxp_imx93cst to 100% coverage.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> tools/binman/ftest.py                              | 78 +++++++++++++++++=
+++++
>  tools/binman/test/vendor/nxp_imx93_csf.dts         | 18 +++++
>  .../binman/test/vendor/nxp_imx93_csf_imagename.dts | 24 +++++++
>  3 files changed, 120 insertions(+)

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -8158,6 +8159,83 @@ fdt         fdtmap                Extract the devi=
cetree blob from the fdtmap
> +    def testNxpImx93ImageSizeNone(self):
> +        """Test SetImagePos() early return when an entry has no size"""
> +        # The imagename entry is in GetEntries() but not packed, so has
> +        # size=3DNone, which triggers the early-return guard in SetImage=
Pos()
> +        self._DoTestFile('vendor/nxp_imx93_csf_imagename.dts')

SetImagePos() is now in the nxp_imxcst base class and
testNxpImx8ImageSizeNone() already covers it. Running the other four
new tests with testNxpImx8mCSTSigned and testNxpImx8ImageSizeNone
under coverage gives 100% for nxp_imxcst.py - the only line missed in
nxp_imx93cst.py is the 'too short' guard in BuildSectionData():

    if len(data) < flags_offset + 4:
        return data

This test only hits that line by accident, since the u-boot entry
content is U_BOOT_DATA, which is just 4 bytes. So the docstring and
comment don't describe what the test actually covers. Please can you
replace it with an explicit short-input test, e.g. write a short
imx93-container.bin with the existing nxp_imx93_csf.dts and check that
the data passes through unchanged? Then nxp_imx93_csf_imagename.dts
can be dropped.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -8158,6 +8159,83 @@ fdt         fdtmap                Extract the devi=
cetree blob from the fdtmap
> +        ele_data =3D bytearray(0x410)
> +        ele_data[3] =3D nxp_imx93cst.CONTAINER_HDR_TAG
> +        ele_data[40:44] =3D struct.pack('<I', 0x866)
> +        ele_data[0x400 + 3] =3D nxp_imx93cst.CONTAINER_HDR_TAG
> +        ele_data[0x400 + 12:0x400 + 14] =3D struct.pack('<H', 0x90)

Minor: the signature block is at 0x490, past the end of this
0x410-byte buffer. It doesn't matter while cst is missing, but sizing
the buffer to cover it (e.g. 0x500) would make the fake image
self-consistent. Also, nxp_imx93cst.SPL_CONTAINER_OFFSET would be
clearer than a bare 0x400.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -8158,6 +8159,83 @@ fdt         fdtmap                Extract the devi=
cetree blob from the fdtmap
> +    def testNxpImx93cstSigned(self):
> +        """Test CST-signing-success path with mocked cst invocation"""
> +        spl_data =3D bytearray(64)
> +        spl_data[3] =3D nxp_imx93cst.CONTAINER_HDR_TAG
> +        spl_data[12:14] =3D struct.pack('<H', 0x90)
> +        spl_data[40:44] =3D struct.pack('<I', 0x123)

This duplicates the setup in testNxpImx93cstNormal(). Please can you
move it into a small helper, e.g. _MakeImx93SplContainer(), which the
ELE test could also use with an offset?

Regards,
Simon
