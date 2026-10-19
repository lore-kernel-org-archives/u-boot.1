Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43349CCF2D3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 11:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 036EF4061F;
	Mon, 19 Oct 2026 11:20:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gQivOzcAo96F; Mon, 19 Oct 2026 11:20:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D7EB40629
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792408858;
	b=FsQDC450qKIx8nzBByEtUp8TeMvAKuLlOCmFl4S/tyblYgybZUcAz2jJNlyEknRa+t+L
	 6h2L++RRcexjaGm/2ewq5q239pL9/P8NXB1+6YUGQ2mHUFVP+Orf503MeHEdvJhdaWYGe
	 65yuTAV0fMHy+RUJ0upo0N2UGj2tN6IR/D+PSfTiZle3C67MV9dTCeb0XHDtJywdF8Q01
	 72OKuYy3KVNsnuGlGjfoqti6ZcytGKBlfxywxemch1oh3KPAk66yIC6FdjASWRkYfyUWG
	 r1v6st5NI64/HsURZOwt/uaKHfd77MlwmIDhPG9XbKlrlTEk9uMGvDfAvEAN83EKbRQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792408858;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3x6RdJhQY1gGI81SWKJ6I3yWXjMrJVmNEX3ffFY+VnU=;
	b=YkbcoiBLuLYBrcvuJsOPnpI1Sfc1uI5RBPjAcn51SPqrumS273YUt4JsYsQEuro0xrtO
	 02esCdvczOZoJ44pEPA1PFMUuUoR0ZWDDwkoURRGGqeDgrpBwQgPupf7/D29puBoDSy3B
	 OgOGFYoJcYTmdmmIa1FzFtuUSntWnSNx7+ZvE+IG1UFJyi2khUNSzKTCU5pl6NzBHBPUi
	 cXo/BS33R+rHNwZc4dEG+15CDQJxFpODAskpqotO4qqWz2MKoELbdiN3EecIvxtuJitU2
	 dXtrDS4//IwPMbY7P2CSTPi+BNMFm/Ml/iSmTObTw+0jxI3kiLVU3JXJWxUMaCZoy6Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792408858;
	bh=3x6RdJhQY1gGI81SWKJ6I3yWXjMrJVmNEX3ffFY+VnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F5PR4mbUkKdk+bGWPR6x+5DJB2DHRbPjUx1OOgHaDUY1Xb2wxrzGzmivoVqsGgPzk
	 9k830ISzldTC/d/36RkmPEn/7CR0YLFqNGJ6rqYh1VLmm98pi3VINwxeVradPuwr9w
	 Oi2awNx3ruCyMS4MwroSi9VjoQRZYRm4elNNclc5c8cJFfdlnGH+wFbLVw/SzlJlMU
	 RLutD60uYuJcAvqUay0aX5I+RvWXwH06L3A8luLfPbr+Fohu6fhnC7o2h4ra34Sqwb
	 8CCGMJVvyTFP/ubl7hMKd54vrREkDT39RMHwiTmcwizBcUFnA+evOM/LWWqXFUNRww
	 DCsD24A6mDMag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D7EB40629;
	Mon, 19 Oct 2026 11:20:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DCCB11DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C299360603
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oVYMpMypCkXV for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 11:20:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C4C1C60600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792408856;
 b=ebfPy/dIQ/g1ofaFAnkrl595Cm5h8p7TG4Y3JxVtVxPkJFLxOeDbN68JNRr17Ftyp+Gw
 LcChbOB0vLbKxAba9NRrsOSka39RCulfSgNIvMW8A7Phthi/emrdQmoLQkFTSXsXoIOpm
 fi94wDDZ7uZ3INz9J0+n1yaTpUh6Sqspo9D4syCEcIO79xz42n87QccEdjWAQaMlpKw8p
 iBFu7GM+Y2FmUevVX/CU6Q2XeioWRW1HEag4giaiTZrID4kjcjFsVx4rUNXDhpqY+KkRz
 8FkdHR1os8NlQX2oPv4e+LXrSKCZOrNbwgM/4gcMO1kg+5p3YzgaqRNClj3qwlsKGog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792408856;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=3x6RdJhQY1gGI81SWKJ6I3yWXjMrJVmNEX3ffFY+VnU=;
 b=pHv4hfBKYQRgWXOIQ9oGezwlLkPrhxMNXXApKxJrENb4z751P2qUCTvInjlv0xEZmFkc
 Yrq2BUKdq5t4X4kT/9Xje/vqvO1fmCh/BZlF+ygmJguj6qGupTmdBzNvpZYU3vNfqsGUJ
 O+cI3NXOpDjzCERNEn1UpoXxaUPhokKgCmQYW+WQ7i1qkG+kwTgTcs1oxmlisTVYplUq9
 jJgXJOZoziwNuGQ7meQnMdj6f3ZZZ2Hjhv/uJ0t2Ls5SbrsKR0jH9zsXnYw55gQgmdtsd
 XeFiTCpr5455emzRc8cncfWgny6MukB7rvhgACd4ay2kR3Ajc5Qkh9m+G9RwuN+ayoQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="NI59QCY/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NI59QCY/
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4C1C60600
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:20:54 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so2937741a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 04:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792408853; cv=none;
 d=google.com; s=arc-20260327;
 b=cvosJ9u0O8fJgEaFkyqSEwrZjKSPtucK81KustJqv2EMVRvMiA+yi1+WObIn1syZpM
 Ips37L7WHWH5oA6GXTN34oy5hB7+WtBEQ72Wj8mqkhEAcD6WlW00qNFzJvPPxKOHbEqg
 /TrX0x2ca3QHfnNT3AD5rK+lrABA2muMQVRVnMcynqvNCNAV44oZ3rfxwQ4zxZ3LrFUv
 JdbHM4Wqba6nb+wnjwGdiwunupi3O21BZlrzDeOrZcYjhoEJG5Cao18Z8lZAABUkGqL1
 EsxH8nzE79QPzWJEYWPQYh1rnaxu1gkVp2FIQB2cIhdfrv17c/vfXZ8E10VpSsW/VI0T
 n3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3x6RdJhQY1gGI81SWKJ6I3yWXjMrJVmNEX3ffFY+VnU=;
 fh=kcTwKzLIqR/+Se2R+6jxC+vUBOe/RTTnwqJw2bt0OAk=;
 b=D3oTZMolEDt48TyqblJsxyD5dBDwtqkk1n+jEPBP24faZVsFNq+T6RuIwRi/7WuhYG
 MvVPuzyDm+9dz6QFC4cvbEUZ66qfNHsqxlIRfdmC5apqpwPAAwtniC0pTbx/4SQ1XXBG
 VPTnxPpVqw6E1u+UXAj6yiA8FGUFGHKAlYD1Tl4tBrk7bvjKETZ4GE2rczh41nVNWZ9/
 rm1WedPRl/g+a/+lyZWLhJqBxRnhD+ZBkdmRLX3TOsm1TX1Ou4/RKl2AybNlAzhmbTpw
 Y8gsDp90jaHHF1JEoXIZkd6KUzrAzyBQFWAar9yHBrVftdbCMi9HhA9mzqnY3YIaAw1k
 5RbA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792408853; x=1793013653;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3x6RdJhQY1gGI81SWKJ6I3yWXjMrJVmNEX3ffFY+VnU=;
 b=NI59QCY/OGO8ShjJ71synMy0hV9pXbGA0qCVXv3J24DqvBdKH89s5551B7NcZSPZUO
 hcPoDD12CnRwvgTRHko2FwRiCkN78Ld34aIU/7REML8Kt6D+0nxfR7MvjaO8TVbU1oVp
 7h/5opMa9+iiB6Ylu/GjQOGPPIijW7wigiqxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792408853; x=1793013653;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3x6RdJhQY1gGI81SWKJ6I3yWXjMrJVmNEX3ffFY+VnU=;
 b=rogxlWD3LN+se+d89XjnY6OYWX2vzEXxCkf9y3qEEGPkYfGxeNQxiR9jOzpX+OEJxN
 mY5znhOxOy3OgQkwZVyZbZm8PiiAc58x/fwJT9g1REL1VBuXPZ2QzYieixhVBLnnZlEo
 IYwRbmzDqlXBMMmG65SxseVQ2tAPkUOqu/YJK2p7OWs+goeCFulPqRSXTxTR9P8NPSY5
 hAyRP7a/GBw6P93Y6qAATqNhzHj1LewZe2jxzAA7WkkKovhkd2pVRDrfnSbGj15dJRUs
 zM8LkgsWndcKM3HZkwioo/Y0pD1S3zHj2atOkStfLpkAJ6VzWotC6plUR4tNIzjDvKFm
 pD5A==
X-Gm-Message-State: AFq9FYKvY4e7hSgnetlhZM6pBQq1K4brjfExr9v59nL00fcDfIvuMpWs
 m284Q+XkOSmn63ponH8KW4ImnPITRIJOfwM6ySQtiEUBCz/wwWXIxe3hPfshxAi+TurexTnSLf8
 YlVGX9mDK2/p2JXIVWOSWgU/Ic+Lw6p3Uet9kOHlL
X-Gm-Gg: AYBFou2nMCzyysUW1lJn9OTEbcUSQ1C1WcrgPSKzZojHSfXvcdKl0KI1qaMudU2M9jK
 na8S1Doais5w79oDFrxUczejMZDg+0Z3BnL5AUOvlSpC+0ap7psgcDLMnST0I82bShjP8RVeD6D
 LUJlDyXBS+4tq0d0rhEQcm1Qp1RGwuRL+0KfENA1hbKc2ZSIXZhHmCSdjpFiSahVKiLXpSAl1Xm
 QQgMvthI13vE1Qn+V+bDEA24lXRM0GXi/XHNj9vwJ4WBJxsDionQ3h7CT3TGBRn4ERQtGHCQm5W
 bYHY2NZhOTWR+e88rbq0nkCoaBju9wEZVYgdD+iEx7PI8e4fiAXwcOM=
X-Received: by 2002:a05:6402:4551:b0:6b1:b0f5:40e6 with SMTP id
 4fb4d7f45d1cf-6b3a818e3ecmr3274127a12.36.1792408853010; Mon, 19 Oct 2026
 04:20:53 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 13:20:49 +0200
MIME-Version: 1.0
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
 <20261017-b4-binman-fit-fdt-compression-v2-4-d7e290847543@protonmail.com>
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-4-d7e290847543@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 13:20:49 +0200
X-Gm-Features: AclHuK8UUGKCiDHhUIG-Wd0hLfvxG9AcUeP2SuPYOpFzyoCRaEhIpp3JrldMhnc
Message-ID: <CAFLszThE5f5mXaTNQsZcuVG-vM4JcO_Dqm7jbFsaKq7MmuK74Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] binman: test: Add tests for fit,compress
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>, Alexey Charkov <alchark@flipper.net>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>
Content-Type: text/plain; charset="UTF-8"
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

Hi Petr,

On 2026-10-17T07:38:59, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> binman: test: Add tests for fit,compress
>
> Check that generated fdt images are compressed and that 'compression'
> is set from 'fit,compress', that an unknown algorithm is rejected and
> that a missing compression tool is reported.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> tools/binman/ftest.py | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

> +    def testFitFdtCompress(self):
> +        """Test that fit,compress compresses generated fdt images"""
> +        bintool = self.comp_bintools['lzma_alone']
> +        self._CheckBintool(bintool)
> +        data = self._FitFdtCompress('fit/fdt_compress.dts')
> +        dtb = fdt.Fdt.FromData(data)
> +        dtb.Scan()
> +        for seq, expected in ((1, TEST_FDT1_DATA), (2, TEST_FDT2_DATA)):
> +            fnode = dtb.GetNode('/images/fdt-%d' % seq)
> +            self.assertEqual('lzma', fnode.props['compression'].value)
> +            self.assertNotIn('fit,compress', fnode.props)
> +            comp = fnode.props['data'].bytes
> +            self.assertNotEqual(expected, comp)
> +            self.assertEqual(expected, bintool.decompress(comp))

Only lzma is exercised on the happy path. It would be worth adding a
second dts (say gzip) and a parallel test, so the shared bintool
lookup from patch 1 is covered against regressions where a specific
algorithm name is not handled. What do you think?

Regards,
Simon
