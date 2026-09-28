Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0FACA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7334D605ED;
	Mon, 28 Sep 2026 22:32:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dUuY62Xwm2SY; Mon, 28 Sep 2026 22:32:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BAA2460613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634729;
	b=ZzwQBifIC50Beh8FPF53jUlH574gLZJgrlGZ76jjiJ8P1kTMuv5a3EL+6+mhv3/0oe/E
	 c3x/psWAU3FgBbcgZDNTMFfSzRUXmARrZ7zM7yGCtG7JvvN/C1HQ8pPuH17fsyT6sUwq2
	 lAWHi40hCfjzGKUM2jNQ3wAQ8lJLhhPU/fvyE4QrNQthihkIj/QhFHReQwQQ0U3fPItsU
	 xyIF+4kMqEc4QCZk5mFf/Vwrx5zxCpBVB9+86wT6I0BkrErVcgz61zvAyegnYMPOhT65X
	 7BGk/PEm0MvrWHOqm+gkVY+gl1FvIGMwSGQIYKSzysf2mkBCANXNOnWm7vhE2a4N/jQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790634729;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O+EGkiFWQ134jOhw/KhdNzkP5HOPPyGiJEQ9w6u/tS0=;
	b=hYxt8moiPXSpnXUODRU0Yxa4HPktYxp2fklgoScPvmk8qGbldNRrQLO+byYZbasSWymF
	 jql5yxeAOSSWXOqKbwu4ZtR0N6R88f4H9zGHleGv0RbO58xAA3EFUSVELKGBLyUlr3YDv
	 LTSg9A1mS+UzNRr9nk9qSVk0iNJ/q39GAIO5hq9HmYugA3Cv6Pxqnw0ULQcAyfngOx2Nf
	 meIVLn7vWBNX8Lvvn2BUOAoIDLKuZJQT/3iYAYd5OWAdt0cfy2g9s257qX3J7JOVPjR31
	 T1raxX05osCDDwuVb6LgVw8xwkJGNh6xz59X73rCu3oM2RgCgWK8OeaKCffSVbAVE+g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790634729;
	bh=O+EGkiFWQ134jOhw/KhdNzkP5HOPPyGiJEQ9w6u/tS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0nL4tzrxG0ceIUflhdyxD4MpdHWA7dtIOoAN95y7RQiPnG6W1iEhon8krUVVwOA8V
	 vq8D5h5xEu3j7thkW7oFTbs3m/vCCcuqoB73FOe/emZvXizRF6gENFbw8vmXDB3uLc
	 24O/StFlTEHyeFItt9knJ/JbIHhe7NqQcMNn4AAo6W2d1UCkXu7onovjFr7AHti6pI
	 HxRSUhLUaglBVm20g5F79kWP5IoW+3eBPQ1rfjOpZA/BC3yccnD0d9g3PI4DmeVd0U
	 2qKa+HkgGUfBBEzdODYVZg4bTypdDVtl2lrQnpG3hRdSci0IPjktU4m6guzVkiegnJ
	 ih74SZChFmz9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAA2460613;
	Mon, 28 Sep 2026 22:32:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E8F2335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FE6B80BC0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:32:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FR0XuVXMvSPz for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:32:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EFE3080BBD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634727;
 b=g5RYKRggJsXv5nxGE/OEmZGVxCxG01IWL7Xz9mMWgh8GkPlnAUpaxXfPGX286MxFtqB8
 VLERIdPu3JrD68S1jcsJYBXiPWcfBRrnjCDkmNADTxaKblP59xYxiqrtVL8C9n53JKWNg
 oiR5lqy5Zpu8M804Gfn9Nlj3z03yUv6ywloSZMiTDoEmnH7FCw0PvVeIvV+hDsOXanetk
 1r2y3TcDzvbuv9xblpjF9TjY0qeQxzBTeMq/vMIVy93pOCcYfTvqCV7pikC4nuijMOBGY
 OF58CxnWLglL6N7ObeSWTvoMpqpa8Al0epyGAHFuxPL7Cv0DVrpY+9JYg+3kT5ka0Tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790634727;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=O+EGkiFWQ134jOhw/KhdNzkP5HOPPyGiJEQ9w6u/tS0=;
 b=oa1xxtIf/u0flqUhX8fi+Nc2bGlY/ZX6YTcKzeKDGvVQNZvK0Uks71lZqC99GTsPBqjA
 FGybO+9LcycjtJduPWK9GTzUchDqcA+8N2WkwLb2SUcBoRO8PMpvGe5buIBl5MqN9Vv2s
 UZkyVW2mqI/wLvdf9jvHBbgqlbiWcU/zWy6wyBqGB9fh/B06PIbx9/dN6Byf1NZOE5C4r
 sFlHbBhbbAYHDoToENdX+qhVgu9E7bDn3j23zwCTGP++zr8WQuOP+GwatfuAbM9GWLsHy
 w4aX2jwWSk5+cLpHP4WqIFq35dCRbEOThzfkQtKS6hWhsQEA1wxX97JsiCGNLqzI0Hg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KGviKK+e; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KGviKK+e
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFE3080BBD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:32:06 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac62c88c7cso3708043a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790634724; cv=none;
 d=google.com; s=arc-20260327;
 b=dtptwr2vyXcq/9FRFYken8DOfN2t883/VtMZOY8JjxV/WOCFmse6ZYY/f2aZw3DObQ
 iNcSviBzKrnFioFBayPTPzKa1z3BAvvHomDXUFrUX4ZUkileGPATyuiSZM1SXJuS3YtL
 u5xGbF7ndGxmbBtyiWGuX6HbJ/zEAycMZIVTJyMg+riXewUCRjCyeTqKqCW2Hc+eGyhZ
 vPWH1WKcgZ4jhUyggbr8AtqbqkFIjuS9nX1RNFBwkslZ73Y7wq/vGunrezVfhzGXlo6y
 3k9HMVwXY44z2KLp9ARHVorpCBWexQOHDxWEUNA0N3C+Vu+Pjz0FSGumN3tVtSVjeXjE
 v5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O+EGkiFWQ134jOhw/KhdNzkP5HOPPyGiJEQ9w6u/tS0=;
 fh=n+sjz04X0Y7rphu2f3lsvu1U0cMn8ivi/DknDONi33E=;
 b=iSA1paUvlsqybT+KjAnv2a7N8M7+OMXiC8ZYpBRQZZPvLs8sfPIRbkgeh8CC+jrdmM
 bwUIIzGlpMqW3wkUa9X62pDfPxRUbV+E7KUsA/zUWaGkfHt+h2U1QqxDr7zmm3Qfn90U
 YHmCktAOHT3ZYJMaUpSkwcG6s1+YkDaDo58FyxMbFZCDp68qT6jxu1t0iPUPGbnDKike
 xkmXz8WDxGZgQmmiy1DnwQUi0FbNxgZkfmdWMgSB+skmHTYqcOvR+2r5UbIRdUHSQezA
 tUIe7s0ZZ3K9VWLDAd3kFlBkF/f/aSllL4P0ci3TEGBChIxC/TzW79QnKrj2QadMXuKp
 w4fA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790634724; x=1791239524;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O+EGkiFWQ134jOhw/KhdNzkP5HOPPyGiJEQ9w6u/tS0=;
 b=KGviKK+e5VBPKF8E+rr17AEouBFzLYyap3XrOj9CZFoY8HcPJlMiNf1iFDIeSGfw9S
 lE87ULVrgdWzs1hvW0vWBImq80RiiMM3Yo8hfGfTXy+Gr06FzhNGnoy3zV6HADz+Lexm
 ez8fY8TszDgk5Lw6xu2SIMh6atvQBl2key+1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790634724; x=1791239524;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O+EGkiFWQ134jOhw/KhdNzkP5HOPPyGiJEQ9w6u/tS0=;
 b=dwWhqKYK/6jpm7bD6+m0wHO042qDiGQxzxwyvJDxEF4eM/3Nfky6Et3onJ7BMB7q0c
 fH9pSE76BRhP2sPygSg5AR04U7dUVxNy9pb+CU/nfEnA+ibgbDyR7MSp/T6YOsY9/FJQ
 FVCDHrqgj/4TAsDUMh4kbZWT0tg+h2mT99xC5mRWEIkNOx1v4G1Md8Hb5vy6j8cd99eJ
 cJWpQSF2QHvvkISQ4H5G0yBwTx8W52nvCqa3vbNuMCoaO17XvpUx8yV8EEBZgfytOpHy
 rElDOXCxtcuH+/6dnq47/N36J0uJeR0gBPSlD0oTDrEM5QUNoE2OWwAS5EbxHhWM0o6a
 sROg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLZ7bwlKYdoV/rzbWeZ/79XQQkpep28Or/H7S/+W0EfuRc+C+kMPdRv64BedT7vJSFfSVyI/4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLL0Jn5p5iNOFnLFERhjdwtbrIWHGdg2JyNi9SoNZ9k/NoBPJRP
 spATrvTrdAEZyAMlfn7O0tH6bmGJUc3ZAW174sXShoKV4j4lAwl1sggd6b44qPq+ODRzzzE9e0j
 zon5XthHbov53KSk7xFyrzDGzhGz5UaKatLllOFbH
X-Gm-Gg: AYBFou27yQSQqYlRPHD/XqkNGuuDkSAurOdecrnfx3C2bSsedmTZK3nXAMsHZ6vDsiE
 1DMh54flvodO7yzny2Qe6QX3oDho6KI9vL83w4XmtbkqxP06iqhpDbSIBGfgqXwHn+vlwSic6mu
 qfEHCU4H54Qfz43UIxOuK2+Z7TEnCoQyGX+3kvCkMwz+28PRuekafCSbhCp5oh+Cubhk8AyeikV
 bn5ACyRU9/Wdcn9EU/OZEw+OLcZFlkyjUO+Q/UIJuzliiQRuQBCuYNuLXe6T+wH0iRzVXv3HeiC
 7oYrsAVuhEKXsZ9PIMEe3VEO0tM6vKCXYUkulycJJRLcnuvVRsci1h+/CBBfjEyewi0Y
X-Received: by 2002:a05:6402:360b:b0:6a7:ee55:dccd with SMTP id
 4fb4d7f45d1cf-6aae8eb5635mr8947093a12.28.1790634724585; Mon, 28 Sep 2026
 15:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
 <20260911-imx93-secureboot-v3-3-542a99793af0@bootlin.com>
In-Reply-To: <20260911-imx93-secureboot-v3-3-542a99793af0@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:31:44 -0600
X-Gm-Features: AclHuK95SCILNTuP-uKZhgzEN2-BkupFGHn3TCwphxtVmDNL_or9DEXTdkqE6uw
Message-ID: <CAFLszTj_+qMh+A7=1R4TT-Wb2WN3OaZSfCDjyRfgxsQJST2JBg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] binman: add nxp_imx93cst etype for i.MX93
 flash.bin signing
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
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

On 2026-09-11T16:35:05, J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric)
<jeremie.dautheribes@bootlin.com> wrote:
> binman: add nxp_imx93cst etype for i.MX93 flash.bin signing
>
> Add a binman etype which allows signing the SPL and U-Boot proper
> sections of the i.MX93 flash.bin using CST and AHAB. The implementation
> reuses the shared functionality from the nxp_imxcst base etype.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> .gitignore                         |   2 +
>  tools/binman/etype/nxp_imx93cst.py | 112 +++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 114 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
