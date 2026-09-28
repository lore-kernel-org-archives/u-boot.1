Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0A8CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 815C160632;
	Mon, 28 Sep 2026 22:32:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cse9788iqtFM; Mon, 28 Sep 2026 22:32:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B60AB60613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634720;
	b=Jet0j0jPj7s5iHWCRfgfXPtwnPaTTtXo/6d9/PUBEXnbu/JMgpa4lSIZqHgUGIQJ38sX
	 O2IGGLA7u9gWN6AJNvifM/GwykWE10T+ZSw2EgnUgUFMtLX9k60ny2cDW//Uw8P64lf2b
	 a+JuJrWxPqwotaCUWSGmr5Vee/B31HPHHdjVnQiSSDBVFZBtBMi10MeBVYN6pYYOoDu9t
	 Tg9uiuvJR+4z693hQd67J8h3pIdopgRhK1jAXMaElbQpeW8wj8dW4crlIKWHA+g6no98i
	 T9aqPCuOCFG0yv7+3/prVplgTjdAbmsHsTC7DIM1De+oHJDpCZPwJEShHdHhirCyiMg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790634720;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IRvbxycdLxA/2r613LvcuyKCTIENLau8RwqnpM7QdeM=;
	b=qqdpjiCZcgMS2yZhmrVHD1i/KdM8yAaZUpLj0pZXWxZajmVBGtU/e00wOzV1Trpse8U/
	 CCCpa33wxF/8KOIPgjb1j1KxuPCxDD1ytVSOiiPxEv3c/yMxASLiycbv5ESNABmCnycvZ
	 4s3BjJCMxtP5L9jlc7zuDhaBFECL+JqAevWwZdwRILiJbArkDkGRuGT490B99iPPdfOd9
	 mEDziRas7PrPClc22K4n2/+BzrkCtLIiSPKPvJEK30srAi3O95Z2tNQerHikR3nRaf4h3
	 WW70QowTaQv/yapA60tZ/NaEEMWaI9v6jC/nEu6lmfDozC/U8/L0HEQHT8VzL03YumQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="EbwlI/2i";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790634720;
	bh=IRvbxycdLxA/2r613LvcuyKCTIENLau8RwqnpM7QdeM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PVGi7+/CwOgXa2iw7uQN1lAU/OiEZQ6OR4IoWO3AJX9MJwPJhOkcmQXxV8ZippSGk
	 +IPq4THVb7pbTh/SSUGlBqxS/DPV//IWMEeD5/EIG4xW9VuTkLAggnmr0nWhhdpUeI
	 f9t8Re+Ff90JnuMxgeef75meR5KrsbqjvLy4BkugmC4i1c1k/CMTGTvEN+nrrzTTpf
	 f+Edea0JVt9+zvp0ChaCQTGLio9JVTg3tB08yrXuT2hRPwrKmnLEPUG9gwrVQW/pXA
	 lIY/MK2zt0d0wdTMUefJGamEbopjQHV8dEcr1ia7+c3k0N+X+DWmfnercYvp0ALpt7
	 hm7tol4KrOxuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B60AB60613;
	Mon, 28 Sep 2026 22:32:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A3994CD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F85D60613
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:31:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 012FoL_Ti-rY for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:31:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 636A2605ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634718;
 b=MMI0um9mxZklUqkQWzu7yuLcDWgMgSBOFiRUfTrmX8PB+G+IISzZXX9z0A93hWP5Udx/
 2rzHeVCPqWerbSDdU3DvCU0KvYAf6nl7oJIvYChHJZjkCmkmm/pwo++j9ceYAq1MFjYwt
 Qw2Hqr2o3i+1V0c9aIvmYxaUcqBVGbE/5j7O4OdWsmkawbmeakRQSOu3itznrUyBdsGUM
 qNP/algo2PJfaRyw2xkt7rks3ycOynQP159vZCTEjckSXxmDsj+TdlNtHfZq8kiD/rPPL
 w1RQ6h8Z0aycb4aa3bBO2Obf0IqkSs+QvrCM2QFdrYYAL8pp6tRgjfOyu3BuPOv0L3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790634718;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=IRvbxycdLxA/2r613LvcuyKCTIENLau8RwqnpM7QdeM=;
 b=KI/AetqwjPEmBbakncNsns8vBRImvAz7Y62+k/rIL5bvsWpUUhSg/yLbYOqZiXd92p93
 F7F43JKg5Gc4e1liN1B/9lzHpmaagK8RGQff/7G2pGCJsAv6N5FDuf4MtCOdhLVvxGl6b
 e6pI8X30ym52TzAjQ8UgAWkjqG+aLl/vUEoxSqT1vnw+H5cOiiGFgWV8n1/ZalF+LuAWB
 RtXONsv6zkg4B09eCYfBap4MatUwRk1wXDduvf6jxhxgLJj1o8p8jjXe1FAr/dtD0KJfv
 Sw1hL00clZr3cyd0XILkleIIf6EPvbReftkV5msHB5dEZKbWxHf45EetaSSxXeMCXaA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="EbwlI/2i"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=EbwlI/2i
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 636A2605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:31:57 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aae7b7fe22so6151743a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790634716; cv=none;
 d=google.com; s=arc-20260327;
 b=RH5QTLHPYnnIHfMBBx2XIouFkuty3LzqFx9TSSW+gTHjggD60jNIbpUq0gVLVwSlK2
 MhH/BV51JOclgEsONEGxK9atUn2N0mSxjY9Z6JER7yE5Ylb8GLxAq+LalPPy+fJvwOo5
 G0qdBeAM+Ccst+t0YIYJolAHtp1/AG5ympCU31/WHIi1ZXTvvLcKT0FUt2aF0rEBkq8W
 cbY1Myj1dYTZvtXXblsZO6aqTQab989D7Lg+PbrwmfwYY2NdOdsVQ61mDKtj7bgVzU7i
 r2a1JiNE99sgFbPszyGwo4oLAoD/sDTSmWXp8AEu1NB1n4QHXnbGGaUGP+7oeOjRCvHx
 Dm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IRvbxycdLxA/2r613LvcuyKCTIENLau8RwqnpM7QdeM=;
 fh=hPyWfVO6cslxsp7ivkNK66/EmaNwO0pM3/ZlhGdvrK4=;
 b=den9hCzv3pQ4Ol1ikGqtaKq3k+GVoF9ccpf7SEJ3eeSTkAz5dvmQ76Q6opTcf48R0n
 V04OH9y+SFIsfqKAjT8AfVYzWcsvZqQfY88QJdEpMKtgj8Y5xVNA+2LApEEQemhBqVA7
 jvYD8yWzqnxNdJMyQceHir9UKpWHXKc01YyKd/xS1f9HiI1B/I6MchySqDZglP/+dbar
 J45IKKzD/q5jss2STHUH+UfBnhSPdfNi4/9bOMeVIeG53P91rpYeW3zJYo49Qjb4mYI4
 7L1Prb+nUvK1oAFWWZ65cqRRL+15wJIIRy0Q6cuXP6m9TGpP5YAxQCeqkvMaRf4K0+GB
 opMg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790634716; x=1791239516;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IRvbxycdLxA/2r613LvcuyKCTIENLau8RwqnpM7QdeM=;
 b=EbwlI/2iUD7aTXitqv0/EdqSTn/oRgvHa4xJDO7/bk7WC5PEkZ4xMYJY59p359WsFV
 h5feNDf6+c6Jl7x5aiSuIWRnijzRNmrPF6JkaPzpTdI2PWFOJyc7n4dP4MqPXLwFqVfw
 SU29bZPC3FCgfmcxJeIsYSXbY9BA8kL1l0/dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790634716; x=1791239516;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IRvbxycdLxA/2r613LvcuyKCTIENLau8RwqnpM7QdeM=;
 b=luu+8Fd77Frk+cww+4uCmkRXv3ySXAE24nO783MTrDJ3Lw9k5OESnMEutb+3XvRxe0
 X3X2TQreFCTWwsswQE94zc2CI1VjMz9oMCwANZkEQA1hyu5K5r74brEN/eLzyY8uw3Bu
 8f4Ry57QPoNva1fGgYy3VRcKsH08thw+vuj7N7UnTo3XbTe7kjRLUfRKvs4FekJWIDm/
 VtZMS+fh+2l2uKxN90+ipEGBvTuDsAp027IeJ5kWEb4D/Xh0F2ZBOmP/8GSQ7kkURwXT
 6WQMkv6hxCaARzVQMcIwvJoVb6vTpzuJBGp6DGLL7KKYIgazMxi7MNTm2jQXGrfJmPwp
 5wXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJ+c/ZXJJkZ36qsanmmImn1qD2bIAboMh2E1/zFisO9GivdrSiO2kxOph365gEJ1rbZi3fkqQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKTuMU7NUoGkfzS+PQ0JMdNpa5nH3lsfvyBlWU/IIoZFHeo+Yb4
 X+C05kNLbPZ3oVBYFbPEQqiv/hplHosQptGysIezKfjt/NyaU7w/ZcpG2lZMmah8r1X82Bn7qwA
 9avbRxJFrRGv+fB+hRKmtG9LYAOYOYVM4/FmQky4Q
X-Gm-Gg: AYBFou1yMNr5kKewH3lp7B3Q69Kgz6LnVgTao6mx9tNExxlD+xLk+P50LHSCmJpLtGb
 LlJPNrGcD/4TnGdW4ezZL3shC0/f59dXxRmut+3+FrPfMgHqTV3dBevzu/49vsLLWJPxbPQaibH
 JoGmp+5G7iXPD09yhALKpqBmV605piUfSRvx6I+FfceOznSS22FHlOEQLWcq7bMkJ+kEJX3AIMe
 2IBW2HmPMZMsax+nCgU/V+UbPL7Y/PvYq202AW3S2lZiJidVEfobPTE/W1QLVb3PYirxiGefxF8
 kVOvUAxEkx1weG0lo6X2J7ittEWkXdMYcXZLxGB/wbc2VciqLkZ7KVwjJQ==
X-Received: by 2002:a05:6402:3806:b0:6a9:df42:8cba with SMTP id
 4fb4d7f45d1cf-6aae8f3906amr8528935a12.32.1790634715663; Mon, 28 Sep 2026
 15:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
 <20260911-imx93-secureboot-v3-2-542a99793af0@bootlin.com>
In-Reply-To: <20260911-imx93-secureboot-v3-2-542a99793af0@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:31:38 -0600
X-Gm-Features: AclHuK9f01vI3yCziY3Iia6vFoBN9oUCSsuN2-28D2ZuADUfp1cRbV1jNCWGr1w
Message-ID: <CAFLszTh-gDxOXr3qpdrctvm+YYcuJiyQ4n7okJbnXK9OJw=wzQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] binman: nxp_imx8mcst: use the nxp_imxcst base etype
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
> binman: nxp_imx8mcst: use the nxp_imxcst base etype
>
> Use the freshly introduced new nxp_imxcst base etype and remove
> dupplicated code.

Typo: 'duplicated'. Also 'freshly introduced new' is redundant; 'Use
the new nxp_imxcst base etype' is enough.

The refactor looks good: the dropped imports (Entry, elf, OrderedDict)
are all unused, and SetImagePos(), AddBintools() and the CST
invocation move across unchanged. The existing testNxpImx8mCST* tests
all still pass.

> This should not have any functional impact.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> tools/binman/etype/nxp_imx8mcst.py | 60 +++++++--------------------------=
-----
>  1 file changed, 10 insertions(+), 50 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
