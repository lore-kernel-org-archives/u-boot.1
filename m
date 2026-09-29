Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC732CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 14:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E53C640735;
	Tue, 29 Sep 2026 14:17:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ipKhEPq-HhgR; Tue, 29 Sep 2026 14:17:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0747A405D1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790691421;
	b=MMwHWfEeWQbvq3dBoe/L+SBVMcMTAtX1LtkVKrqJsPyTBlnmbUxAxJX/HZVJFMYsSqgj
	 xUB19P7AajMxsbNGvP6a6cpoln1CR65rVzepUBi4MN8V/LWdo5H2s8sozZZBtGpsJ+HEO
	 YCC/THIgGjvrwwRXXxwED8QeVFeSKtJWUwIAymW4npyJDkqnv/B+78bkr8dUMrjjsDM2z
	 LLfd6xujDoeVUNh61JJ0T6xLso50AFXb6M9LdugqatvxXOcWPdzuR7l6HuL2tjGbxHkzA
	 /Wz1xymfRLdiuJLK+JZXLv+6szGs/zgodAajw18nB2K36PGlsNBHDiVEarErjpX/Gvw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790691421;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nMWr9mXSEcWuU+gxalfA2Zgu/hgBPgEjNoFQEQz9Vzs=;
	b=fBTcrwrQ9tLuiob21Gt24CNkCFoQeRYpWYUB3BjTwczCW/DAi/xJXmPnl6singj9iWZq
	 DJ1F23fiNwOXO72apQF/Q4/ZVJOOhBQVfwixL2tqZdY1QzIFuqj+GMEwFXD29q48mTW49
	 5Vh7I+wvXGRFIqncgsDl23vncUqxZkJQ+a6S/KFpf3uiU7wji+iOjXUD/mbmJFSJckHcG
	 CoIMtY7PQw0VsqWwqFNwgs+Tz0+2Ja9eRKqMIG5/U+L7AIqh1EQslXNjgl1AOlud5j3cL
	 pGG/LmlQJZ+jsQwhqUo+qGQM/Kx79z1j4XzZg1+EfnF95BU7ZT95KYLPBwEM6c3uE3A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=samwSZVv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790691421;
	bh=nMWr9mXSEcWuU+gxalfA2Zgu/hgBPgEjNoFQEQz9Vzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QmZoORx8cI8emEIKKhcbCks+yHyXyKmb+9L4/2XrV99uC3rXJKkhavcjCwqCHfj4F
	 7wYP/nZBnjLRLPEI4FnoB4ts5RgbPKRjX/BDCPvOSp+bYevpq1zrSMqtz3UfL79nLq
	 jNq6/NNax50keRO2DzJs3icvIyCb1peoGke0l5t+n3rcZQDokmY+jIM5LqsFVPkALY
	 gsp476rnpzvf4uxEeqrsYpXWjn6d3nK+VY93XSWRyD5xmsnG+7ToSMYUyaWH04Ht4A
	 LmWsgWWZjE1T8Hqf+qtz/nT7owRt9a6CV9VUfEYU6014zDPmn1LuzVvk+X3M14nTV1
	 OYpNmLyHuuWXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0747A405D1;
	Tue, 29 Sep 2026 14:17:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DA31432F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 14:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB9D9405D1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 14:16:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PBNbg1hwGnQW for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 14:16:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A1DE94052F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::2a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790691418;
 b=UBTSUzG7B1rdgYMDNna6j6d75BnKksoFCZaO+MWeJQB4TlT3Pi45mGD7r15AZI0z8jJf
 YqqG9nsO81Nw6P1zmXetBEYE5SiwN3VaJXhDsGx3Dg/qAA6ZJRkHeluo+rk287ZWvuJI0
 8A4Lho1fjtc4GUf86o6zYt6+yghTDRgKqmAOL2kvJ1vny7OVNoPc+mzut/rcn/TUGceNb
 QOGAeJgXub9sAKFdz5PCkxKe/qOww0coSjxMQ0pTJTq7H1+CwixzgPlBs0CNSX+8saLQp
 /SgDYOhw2943OXrTV3pYOyuniLobfRl2yAi1+WhPzly55dj44XG6XiDZPmXFxD6qs7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790691418;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=nMWr9mXSEcWuU+gxalfA2Zgu/hgBPgEjNoFQEQz9Vzs=;
 b=TWVTUYXyjgmx+EcYPBqchCbfacOQ5S86F6C8Q8M/cJ13C0jdKAAKkSF5dg/e1BML+A1p
 1t0rz51k3eOvi23oY388P4iQbuuSyuEjovG8VscooNr1XrOAFewIGDclzCCmNFy4GM48g
 VlGWSqW7J+fV0OxfQSuNyjNuRv4lePoZh34Ht7ukDrPXybbp6cY0FLiXQL3xdUA6WNEJb
 Zka+xoudderP19o6w7m1JIZ6WlUvC+42NT6YoqTz8PDaL0KOWTfN8w/WF5NOOVyHdwXRQ
 PZc+X0bkCUadWZc2IBO5u5jsyhBNMzGGaiS/TFA2hUCKoY5z9yvg9tJm4Fbz+ZN+Pow==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=samwSZVv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::2a; helo=mail-yx2-x2a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=samwSZVv
Received: from mail-yx2-x2a.google.com (mail-yx2-x2a.google.com
 [IPv6:2607:f8b0:4864:41::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1DE94052F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 14:16:57 +0000 (UTC)
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ab3fa8a788so9288727b3.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 07:16:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790691416; cv=none;
 d=google.com; s=arc-20260327;
 b=H+8x0XeBdfF3M86duPGdr01IdNxx/dbioPrqRJHxVPfiV5CoPWyGdL3ct0CxqCSCV4
 ybiOUtEDdjvE6zDJQh1JWOEuClssURJRBaXxqhn4EBIzm7pcwMt3D4Al/WM/FSQTEUp+
 lvKgfhA7bcuwotQKWXFz41a/UEpeRi/kSwZ3IbbATyaMOyoPhGdW8hIJW5SFLndDxX52
 YHSzOX/lEUthBdmCyr46tvmb9AmrR5FAqC8a/q/LYFN3eBYSrf8xo2NPa6Yu8USGTX6s
 e7QVd+5X72FWgcM5OXCjSIVYTF/UlPQSTiOQLAJSChyLQhtLl6hii052Ilb25DQXrHJX
 bA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nMWr9mXSEcWuU+gxalfA2Zgu/hgBPgEjNoFQEQz9Vzs=;
 fh=2iRdfu1MfbZEyLcJ6OJLQV3z1tHNmux/5Q/ZTPFM8Zc=;
 b=IJAG6FXM9g6H5pPFQSV+4S2GIEvr/suFMOpIhBhnQ13nLYwWWd1G5nxLpKR+dR6Nhk
 kKqV9xSDO1aINWhRmW0spqrQkl+llp06pOCKgtDU4604W5I2ocxwYlx7rFDy0efWpSha
 eUo57ulWKDWq/JrCDWoDk48DivbYh/Aj0Ovugzfuao786Rc8GGpyW/+Yb1xHr9g13XFH
 ZUsSVA65jdkBsUvSWHymDtYBjhbm4MAj4FcNgRPdALKsbVVB8Pd2lRdm4r3pHE5AoXP/
 eFNsuRaZrO/I5xi+l7rJQN4xgc5g6HCR1/fWKP+SmodFWGMCEErjF0IdvbO+f6wgS/nl
 p4vA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790691416; x=1791296216;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nMWr9mXSEcWuU+gxalfA2Zgu/hgBPgEjNoFQEQz9Vzs=;
 b=samwSZVvRmrXChaxpWS/gOXmUGAhHU47uri+bOKEOA6/3ej+NL1E1uOoEf3+Z6x/kW
 Udvj8ENBe7MWlifnO84B/lM+EGHGLNYuuL+z37YzGcoT+D8eFm6oWFpa0u+yhhBXO6Ma
 VLHO44PlPpjHfo84ZgsgulW7IDchcam+NGKjmve1dE0AFgU39baM9SSZzncGEwGVNo/t
 BR8HAnBIqibVK2LLaZK69W5RazBig+gk5lTC4P8b0frq9VIDCgv6ulXXlEqiJxrts3mU
 /9dFRfEKhdHjf4UwexwqcJ7S7sDXnkJ+BUvcN/MHGm6dPug5IUs1TfDNbiPQ5WitjlFl
 AO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790691416; x=1791296216;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nMWr9mXSEcWuU+gxalfA2Zgu/hgBPgEjNoFQEQz9Vzs=;
 b=FrE+fWjssxfRvhTR1wlswEaifXqKivG4KB5UdDlHKPMr2gDxY2k+razgJqs9Yu3UuY
 RhHmKhDsQR+y7YuoEAML/IUa/9mzzNk43ymjW/W6gukm6lOjQqnusNkMjNQwiuov1XDP
 UKTvsC/Wa3CEOyULppQjID1apX8FbVo5W9+4CYUF4JxBrrZYuLi+vKPpO87hgMr4XZ1e
 32qqv5pVT03MK8JVmgI3EdhH2ktmKuTJQxdbOoiH1VhnEfgZOr8YF8abfBp3Gx3iJEnS
 vuKIVpFARs3YYOl4I3HOiXw8nfu8GOJlgWSUOFpYc8QdPcw4XhWptPSXY+qjIaLnkWGP
 1UbQ==
X-Gm-Message-State: AFq9FYJ8GCXs9PkHW2Agt2rUzJjT3PiKyiP721AbT0RR9qrtzgiiKQWj
 PanfMcyJMOIxEq1kJwgaNtbWscKB/bI7UcyUNM7D7d6gwGiTH54XUPQ3FKGgqjn3Ca3MWF7WlGs
 CV0m/VNW4QMYQdHAmuuuGvAuD0UmOysPGDNXtflCj1w==
X-Gm-Gg: AYBFou3CRYAwTeiYPEO5SCxOhdRv4uRgtXHXzmjqUgSRfAgMSLlHTuiazF1iMJwRsVu
 gzq4oubwI1010eycIni4J1aDShxHgZSypoMin/AOKP+mjw6MNlY/3FKFBKQh+DNxo63Acc0bGDD
 TfyvT785dVtW3xu11FDJLen/HtrcqPcxEsVrGGYaTnkEqFyqIKaKi4WZDDwVEoNX1YYtfy0fG27
 a8d06CjAbgK/C3G8xto1Ty1Dxu0+cmLUb0LSbk8uHihyV6nECiaZuI98p8VaIg/su+S+L6qBQ1g
 BXVZplD78TEk7iA9v56wbma58qdfG6R7uGc+bdgPeW5xNcvn5ZiChKKZqY1POp9fv57OzDYgBVZ
 UkcYJU5xPfoWrkUXlmi4j3EN6zr2I/2VE3U3LaRcsXCEYG1dRxHO3IsV5LnC1kwDoBokDty4YIq
 m0DNT1au6ooB2aOMaTLKRRmuhw98dDksdWy70CgTNy2GG7EBBYPe506LSockNoq7mtdvD1grtiE
 BON5T+fBgC9KfmvKyw0WCBUT3iY6cEj74JRlFbwKb9QsFqNcs2YTzlh1wgEq71dlUOk+CGrz9s3
 uNIbl/3Cw2r/2Q0q3VMae49Cld5tEPF7FA7idhIlwSPENa63GXM2bnFsQ2tFEaxcomeuis+m3Wb
 Ox6WB9NmVNIoKdgBszJsB2tFOnXBEbV5Dkcs7d+BRzmNBvc5U8cK4HVQ=
X-Received: by 2002:a05:690c:e3e1:b0:873:17c9:afca with SMTP id
 00721157ae682-8a64bc4f8b5mr68927967b3.29.1790691415561; Tue, 29 Sep 2026
 07:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260813-tpm-trunc-resp-v5-0-153b492a3256@byteray.co.uk>
 <71222064-d97a-41d2-b811-38c0944bf769@byteray.co.uk>
In-Reply-To: <71222064-d97a-41d2-b811-38c0944bf769@byteray.co.uk>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Sep 2026 17:16:19 +0300
X-Gm-Features: AclHuK8jY8C_7bf2lC1etDttLAhvA1SMOCPZF2p5SCBCz1rEDM4uye3FHvU5LoQ
Message-ID: <CAC_iWjLHUR69y8n8t-Wy7vLUXpi7RwXaJ0O2E=-UGfdw3C2Vrw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] tpm: bounds-check device-reported response lengths
To: shj <shahriyar@byteray.co.uk>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Reinhard Pfau <pfau@gdsys.de>,
 Tom Rini <trini@konsulko.com>, Argus <argus@byteray.co.uk>
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

Hi Shahriyar

On Tue, 29 Sept 2026 at 16:03, shj <shahriyar@byteray.co.uk> wrote:
>
> Hi,
>
> Could you please review the TPM response parsing patch I sent on 13
> August 2026?
>
> Please let me know if any changes or a resend are needed.

Apologies, I somehow missed V5 and thought we were still on v4.

I'll have a look,

Cheers
/Ilias
>
> Thanks,
> Shah
>
> On 13.08.26 17:58, Shahriyar Jalayeri wrote:
> > A TPM reply's length is taken from the device and only upper-capped, then
> > several callers use it unchecked: the TPM1 OIAP helpers and the TPM2
> > GetCapability parser subtract a fixed header length from it, so a reply too
> > short underflows the subtraction into a huge memcpy; the GetCapability
> > parser then copies that many bytes into the caller's buffer, so a reply
> > longer than the buffer overruns it. Because a TPM sits on a physically
> > accessible bus, a cheap bus interposer (the kind used to sniff
> > disk-encryption keys) can inject such a reply, and on the TPM2 path this
> > parsing runs during measured boot, which is exactly the physical attacker
> > that measured boot is meant to resist.
> >
> > Patch 1 checks the reported length once in tpm_sendrecv_command(), so every
> > command that reads a reply rejects a too-short response, and passes the
> > caller's buffer size to tpm2_get_capability() so its copy cannot overrun for
> > any capability. Patch 2 adds regression tests driving the GetCapability
> > parser and the TPM1 OIAP helpers with truncated and over-long replies
> > through the sandbox emulator.
> >
> > Based on v2026.07 (fdfe2ec48d5c). A reproducer is available on request.
> >
> > Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> > ---
> > Changes in v5:
> > - Count the TPM1 LoadKey2 minimum reply length from the header, like the
> >    other commands, so it is 55 rather than 41. (Ilias Apalodimas)
> > - Move the TPM2_PT_SANDBOX_* test-hook properties out of the common
> >    tpm-v2.h into the sandbox TPM header drivers/tpm/sandbox_common.h.
> >    (Ilias Apalodimas)
> >
> > Changes in v4:
> > - tpm2_get_capability(): bound the copy by the caller's buffer size, passed
> >    in as a new buf_size argument, instead of a prop_count-derived guess; this
> >    covers every capability, not just the properties query. Document @buf_size
> >    and @prop_count. (Simon Glass)
> > - Add regression tests for the TPM1 OIAP tpm1_load_key2_oiap() and
> >    tpm1_get_pub_key_oiap() length checks; enable CONFIG_TPM_AUTH_SESSIONS in
> >    the sandbox config so they build. (Simon Glass)
> >
> > Changes in v3:
> > - Rework per review: check the response length once in
> >    tpm_sendrecv_command() instead of at each call site, so every command
> >    that reads a reply is guarded. Drop the per-site lower-bound checks; keep
> >    the GetCapability buffer bound.
> > - Drop Miquel's Acked-by, as the fix changed substantially.
> >
> > Changes in v2:
> > - Use my real name in the From and Signed-off-by (Miquel Raynal)
> >
> > ---
> > Shahriyar Jalayeri (2):
> >        tpm: bounds-check the device-reported response length
> >        test: tpm: check malformed capability and OIAP responses are rejected
> >
> >   cmd/tpm-v2.c                   |  4 +-
> >   configs/sandbox_defconfig      |  1 +
> >   drivers/tpm/sandbox_common.h   | 10 +++++
> >   drivers/tpm/tpm2_tis_sandbox.c | 28 +++++++++++++
> >   drivers/tpm/tpm_tis_sandbox.c  |  9 +++++
> >   include/tpm-v2.h               |  5 ++-
> >   lib/efi_loader/efi_tcg2.c      |  9 +++--
> >   lib/tpm-common.c               | 16 ++++++--
> >   lib/tpm-utils.h                |  6 ++-
> >   lib/tpm-v1.c                   | 62 +++++++++++++++++------------
> >   lib/tpm-v2.c                   | 60 ++++++++++++++++------------
> >   lib/tpm_api.c                  |  4 +-
> >   test/dm/tpm.c                  | 89 ++++++++++++++++++++++++++++++++++++++++++
> >   13 files changed, 244 insertions(+), 59 deletions(-)
> > ---
> > base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
> > change-id: 20260723-tpm-trunc-resp-664a3babf1cf
> >
> > Best regards,
> > --
> > Shahriyar Jalayeri <shahriyar@byteray.co.uk>
