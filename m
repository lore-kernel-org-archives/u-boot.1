Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853B7CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 520C180848;
	Mon, 28 Sep 2026 22:32:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HsQhuWVQg3CJ; Mon, 28 Sep 2026 22:32:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4D54880A82
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634751;
	b=mPXy825AJ/A+J6v66JFQmcdBaT/con4ADdABm7LizUBNr4PYZmOER13erDJtZ6xYVNLu
	 SuJsO0Futn5L4wyO+Pe7NN29tJbT8fMkRb1kO7xtSIcCMyAo9XyMJz/AdYo+GGM4S+H4e
	 4aDwKY9zbc/ASaBBB84fXbC3BeHjyA+zqPRIUPqTyrrZNbu5aHrWFdnrJcXI53wT+s3F4
	 ySZiOgZnVjGx6yQ0MGWJQIvltswc8t0H+k8d3y7/s4u+STvQi0/5uPdSHiWqdlJc99Hqa
	 5STMFWIYwI6d1oIL+KFxPCLljvfcw+nPDuoi8PejoaAIFZsTzoC4AGjx+nPJFzcFntw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790634751;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TeZhNoKcRbPIxDGxNg0dLpD1DT5Z82ytSkgAfzadhxE=;
	b=aOHdo8BQKGQ+W0vuryMCVuaFoGrO1HURwCDlW6bNyiCzxxnEkwiTBORYTurO2gKLP0y0
	 WKWQMplPE3oaq4teSjtKta/5teTCx55Q6ku+spFupebS4OREWkBbMJh9QcBiiKv/n6lzI
	 hLODbDWyReoxk+WrWSNNWcRAFfKy9HRfzD6h5fSXhEsNtQCKR/uXHn88v3B27OD9iOMDf
	 QjYgNsRDH0dg2rgPphslsXlTjAmLpUatcfSY/T27JwSVqVj6c8WbmkKs67lvNDvAXDtJZ
	 RbwqAMjVfmu47m3OlgO/QeWww4rGXcuHKuqIvtjhPZ9OgEMIY1OrTXpn0rJbkBOr1fg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790634751;
	bh=TeZhNoKcRbPIxDGxNg0dLpD1DT5Z82ytSkgAfzadhxE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nIuf0gcA4h3qS79ic2Q3Y9rvxX8IDNlB11IInDH1YW0lGE4Ga3y0Rv50ZpZK+KYQm
	 JFltrOnc9d7770vXuutcpfQpQ0To2TtR87XB/L5e56yWnoiNHEqtOMNNGIOsYiet+t
	 W2u8NYdwF6f8b4ovKb7Iz4vXifwS+j5U7bLgBwbUqL7w0HXMl6DvMWFaRgPkGefCsr
	 kpw/Kr6SQa6+L7rD+aE1q9SNoDmQSWyIoW5X5P+iYbktUPLFs/bbcOYBC+0zjdhlyO
	 +y2ZJfW5HX2D1n1yGe66JgSGJ3q1ugDJzPpNsaH+bl85luQYS9EwXs+X2O1F6vYUe2
	 L8LdRBJZ/gB2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D54880A82;
	Mon, 28 Sep 2026 22:32:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CBB272
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EB9C4027B
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P6Vd-2sMaxXN for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:32:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1668C40216
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::27"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790634749;
 b=MDoT9UFMgiKo2lNnPsDJhXMd11KFOelL6WVWQSF3B7iKr0sB2X7FjLJSxDZpIHDed2LB
 Zm5GZKOGzGzRimn4gFvcB+kyWLmGU5ASYOvWRRWJgnH2JpI3dtOh2BPfa5t3Uu6EtlHlk
 x1RLuxHuxbYVQCQU0f2r/YDiaVndWsg3Qv8B64o9r1PK9tIgM10qZC/0pOM/2WaHlq+3H
 38Z8SkQzLKoHh3O5pcdzYT9DvQRWKJbARJj3TkGaoscE6JMgTlZDlhmBMN3xA9V9f58/4
 Ke7Xn8fzgqDP5j1R3xAAijCybATxeDaOZWmu3cLa6P8L4kziIWJAuiAThQ8x51HuRFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790634749;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=TeZhNoKcRbPIxDGxNg0dLpD1DT5Z82ytSkgAfzadhxE=;
 b=H1bn3qQGyQgi9/lw6/BmbPn8P/I1/2I0rOivk99qGjvjpp1JukJ8qtEKLTADNK0npzEk
 bR7w/SmTQQM5AVaGW6RgrShWmj7z77Ri1Q+WwZ2oNhWPqIG4f4zhT6h7wZrtkxmd4uh8K
 ksv9QsAHXVf33lAOeLhbAT4oerN5Zyfzq35ITME/qTrOUyr6aWTFlDr1CNx3sn/seoUsL
 NmfGdmOaB+QrP6Wu71ar/JnTGOf/X030oyulSAHEcfmg37hldm7YWQ4Z5Q0tTk1HFU/jt
 SeAvpmdv6kXJmCs41HwMjEozd3GKL5A7+uOkoh7rZk0hiEgKitFVsBcTP9eEnSiStaQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="icGRuD//"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::27"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::27; helo=mail-ed2-x27.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=icGRuD//
Received: from mail-ed2-x27.google.com (mail-ed2-x27.google.com
 [IPv6:2a00:1450:4864:33::27])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1668C40216
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:32:28 +0000 (UTC)
Received: by mail-ed2-x27.google.com with SMTP id
 4fb4d7f45d1cf-6aa135d6e97so5617522a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790634747; cv=none;
 d=google.com; s=arc-20260327;
 b=N1BUpo9AYwOeNjEqU4UZeA6tk/IfciVBobWVw8NqmC8SNd7oFg/8UoaTOCydqWwoJd
 mbq/sJqLqxhzgJwS/YsmNekF3LSV7veib/J/alNDHIOq3q9LeYQXL1fq6PzfCuO4tpIS
 ZP5yXluVXTXjKzlmPRubLzgf7C+veDWdVP+xieWFL6i0EKv+IPi+zQJteON70gNYfIGN
 gIPFjC34RJRFppysaGlkAJNqWKBsEeO3Z+trGuZ1bHhMFlyhRNBKax0zyxqzQIBecUJo
 z89qoiI3aTNhXSl8Dx7CiGIzqYIjfxDapSzKb5LOEEwjTWmCHJD6teKuibTQtEzFPi4+
 itBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TeZhNoKcRbPIxDGxNg0dLpD1DT5Z82ytSkgAfzadhxE=;
 fh=8V1Yh2X1GL7nlXTgHazgTXtUO3A+qNj9epPLeM9oi1c=;
 b=MMD014SjLrEJ5+ltCkqh5HzQ1X5Tq0UMUzhz3x+x9XChAY/2vVfHcPrCWHwgtztR+T
 frdJ6MvB/JH2b5eS2GGHmXGCi4sQmpxBiQClB6PytLeOHziqBEhj+cITVAyrzUVsE912
 FqyCuc8hL8+rNGs7HSIb6dRvzV+++Q0FIRWyBx8mK3bavOPxvl8NwuV7ilJoWOqiekHT
 +1JCKv5iiU/exuF1d3ltPnGaUnZMchK8uN3GfXLAqCs/oDp6MwufXfNeH6GJi8QvFVge
 5nU5PdeeUoHZ9Ovc8BCAA/7q6rDlWSpXc2WpRct9pg4ylKuaEokM1ESw5H0vFXyvFFWu
 vOgg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790634747; x=1791239547;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TeZhNoKcRbPIxDGxNg0dLpD1DT5Z82ytSkgAfzadhxE=;
 b=icGRuD//dHGu6aK2LMwOUjo34OXS5PhG6q1Az9EH8i1OKxRPTzrDoOzTuJ+mq4epE8
 jfucsrm25Ga+9/93JKgNdb9nLR2WM3KhY45+OObnFZ+3vYab66L5NNLUyrOG3vGCUemS
 TJPg/2bn98JLEgd0Uz5cYtTIgrQiOPtMU3Fok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790634747; x=1791239547;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TeZhNoKcRbPIxDGxNg0dLpD1DT5Z82ytSkgAfzadhxE=;
 b=vc7oD3hmePfJsYWN3Ajw1w14j6SFzth0fkAco2+Hg2rROS3fEZv97EQ7qEFzi5o+5Y
 jaeLSG7y/FQoJepCpM1Ht40mYcWwQrIA2m9MXeb8OQ/IkOyfcStgDtzDKinrfKMm1MsG
 M1i2tX+02oc02g1+oycjTwuYnJEgpyERdBGdHROHzlzO83YM98OpEjkmGe8wK5JSGxI9
 8QVG/Nfw9u3RRVBJtqZyEyusFEKjUgRi08EGCnDprjGOodY7uATPcgzaNIoG0HrKmKKP
 DtZUclL23qBTjp54IgCQ7guArkblwe4FWWj8//6RoLpgvM5qcZ29/hdAXYiQtzvhs+/P
 +FlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwePR7cVRBdvuVDGA1bEje2HtI7fHpm7sKuvRxPZwFlrIR9ka7+cyLs+wchB5pQP/q5hQr6Mks=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJKJSAjkTnS3x5ffffVFGOZDPMdh85+PWPugZLs9/Mm08RESz+T
 5mV+64gysENBDzmbYU+BIJAhHsxSIIPcJkBcLUpYrPL4OQtjEDaWQFNKlUyv3uktmjQWqm9IPZh
 ZQ42Y9HCxcAJQjBDutKNID7A/TCMN/aWhHOBV3WhN
X-Gm-Gg: AYBFou3n0lThe16/Kz6ZTDFc4xdRn1OqRGuuY6Hnf+pgpym8zfV98uRU5gG/TGPtItC
 fkOoipHPxF99PxTTRW9dQa677ykUl4DNXHT67VUQcW+afST6ffqhaCfPxAuPWnto6Bwh6Pgl4c5
 yLZbAbmgQMliJ1GcoVtS+nimc8kbpv9LJfpNhNp32/ZnC+qG3xCemrIjv6mgVLlhKYYejHFudDk
 mR+MZinxAjFuEtNWkKeCY8drrIxFiVQzWoFjx2h/7h0m6LIDi7G8RHKd3rQmlMPiGqLGTWr75o3
 jqcRdVAgglZ/jBXKfxXKQMeB25gJH0vCjNlT/tGOxOteu8qL8ki7y3Q1VQ==
X-Received: by 2002:a05:6402:4381:b0:6ac:94cf:9f4c with SMTP id
 4fb4d7f45d1cf-6ac94cfab0bmr1735505a12.45.1790634746669; Mon, 28 Sep 2026
 15:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
 <20260911-imx93-secureboot-v3-6-542a99793af0@bootlin.com>
In-Reply-To: <20260911-imx93-secureboot-v3-6-542a99793af0@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:32:13 -0600
X-Gm-Features: AclHuK_hUhvHUkICafebwdwtOWf0PkJIhg7BCqBPt_ESYSziksgZIBlzMDDN5Bo
Message-ID: <CAFLszTj5JN_3Uw9iwMDYYmWh-LohRmnastDEBB9vS4QYON30dg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] doc: imx: ahab: add i.MX93 secure boot guide
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
> doc: imx: ahab: add i.MX93 secure boot guide
>
> Add a step-by-step guide describing how to securely boot an i.MX93
> image using AHAB.
>
> This guide is largely based on the following documents:
>   - doc/imx/ahab/guides/mx8ulp_9x_secure_boot.txt, from uboot-imx
>   (lf_v2026.04), originally written by Utkarsh Gupta
>   - doc/imx/habv4/guides/mx8m_spl_secure_boot.txt, from this tree,
>   originally written by Marek Vasut
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> doc/imx/ahab/guides/mx93_secure_boot.rst | 294 ++++++++++++++++++++++++++=
+++++
>  doc/imx/ahab/introduction_ahab.rst       |   3 +-
>  doc/imx/index.rst                        |   1 +
>  3 files changed, 297 insertions(+), 1 deletion(-)

> diff --git a/doc/imx/ahab/guides/mx93_secure_boot.rst b/doc/imx/ahab/guid=
es/mx93_secure_boot.rst
> @@ -0,0 +1,294 @@
> +The paths to the SRK table and the certificate can be modified via
> +changes to the nxp-imx93cst device tree node(s) or via the environment
> +variables.
> +
> +The nxp-imx93cst etype is configurable using either DT properties or
> +environment variables. The following DT properties and environment
> +variables are supported. Note that environment variables override DT
> +properties.

These two paragraphs say the same thing. Please can you drop the first
one, or fold it into the second?

> diff --git a/doc/imx/ahab/guides/mx93_secure_boot.rst b/doc/imx/ahab/guid=
es/mx93_secure_boot.rst
> @@ -0,0 +1,294 @@
> +The SRK private key (``SRK1_sha384_secp384r1_v3_usr_key.pem``) must be l=
ocated
> +next to the certificate so that can find it.

Missing word: 'so that CST can find it'.

Also, 'next to the certificate' does not look right. The list above
tells the reader to copy crts/... and keys/... into the build
directory, and the environment-variable example below points SRK_KEY
at $CST_DIR/crts/, where the key lives in the sibling keys/ directory
rather than next to the certificate. My understanding is that CST
derives the key path from the certificate path (crts -> keys, _crt ->
_key), so both layouts work, but the text contradicts the example. The
mx8m guide says the other files 'are required by the CST tools as
well, and will be searched for in relation to them'; something similar
here would avoid the confusion. It is also worth mentioning
key_pass.txt in that sentence, since it is listed above but never
explained.

> diff --git a/doc/imx/ahab/guides/mx93_secure_boot.rst b/doc/imx/ahab/guid=
es/mx93_secure_boot.rst
> @@ -0,0 +1,294 @@
> +   $ export SRK_TABLE=3D$CST_DIR/crts/SRK_1_2_3_4_table.bin
> +   $ export SRK_KEY=3D$CST_DIR/crts/SRK1_sha384_secp384r1_v3_usr_crt.pem
> +   $ make flash.bin

Just to check, is CST_DIR the CST installation directory or the
PKI-tree directory? The introduction generates the tree under the CST
directory, so it works, but it would be clearer to define the variable
(or use <work> as in section 1) before using it.

> diff --git a/doc/imx/ahab/guides/mx93_secure_boot.rst b/doc/imx/ahab/guid=
es/mx93_secure_boot.rst
> @@ -0,0 +1,294 @@
> +The existing file structure is automatically collected by the nxp-imx93c=
st
> +etype and submitted as a single signing operation: the container header
> +and the signature block offsets are read from the i.MX container header,
> +so the offsets in the CST configuration file are always correct, whether
> +the ELE FW is bundled in the image or not.

'The existing file structure' is unclear; I suspect you mean the SPL
and U-Boot containers produced by nxp-imx9image. Also, from patch 4
each container is wrapped in its own nxp-imx93cst node, so this is two
signing operations (one per container), not a single one. Please can
you reword this to match what the etype actually does?

Regards,
Simon
