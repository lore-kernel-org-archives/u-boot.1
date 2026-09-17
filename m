Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E49DC982D7
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 16:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB41280B80;
	Thu, 17 Sep 2026 16:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DyRoby7UYJlP; Thu, 17 Sep 2026 16:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C58DC80972
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789660971;
	b=R6f0VPfMhhH1IDIhaqcB/VmFwWusic/w78DGG6Tqbvt93LI61UVIAocmfgVgqdts3Wey
	 Ko3hXt3s7UKcF3+QRC4lxGAw6h3EYrwEJY0U68zZYIyBsGogHiwnyHh16D230Sk4c8fOk
	 4rNtfiUSp5RsNHWY/2ip+zSXv0EtUPrwsWavgJzMonYu6YF6esUOLdE3G1j6htYDqXKy7
	 SbLtKv7LSwAFCIsEGKd1/C6xmik3JLmueGXbqykmIL8hJdckJV0AKGEmfvrxqbduG3c5r
	 wvapaQQQzjShUH3h/okkrjRr1FWiWH/am1UsozM26zWUGI7R08aevrlTsvfeoCS8TRQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789660971;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T62Ky0MRQBXi6Z87wJ145hKG0r8CDuk8fCaoij0uXGo=;
	b=PESfOQMS4I0BjSAaBFHJ6g775CPEf3XHfOqD83Caqctvb4NDrn96FNKp0yd5C4Nc/uFY
	 nJvnxON7Vrh0aDrUa2y1J9btz1kAgSoFBkPJl2tn+QDyPCVY7ZEBCyZBevMUR2QMvKUPW
	 eu5mrpE5O3amV28grY6fufZAU/0Q0BwPs8rNqGgLFuBIVDN5ofRufBUVOMUKFIzIXQlW4
	 WY7Sv7Dc+P19YNISUxvPSjXwcFA6a1MI6EBnvJXY+V1e9+6pe27cibQVBA1OwEsDkhgjV
	 Ac4R+GWWotaTfyDoBAF5SspW+cTuL/bEVKZGvgeACgHHAFXU9xTcGhZlXjqz3CxH/Pw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789660970;
	bh=T62Ky0MRQBXi6Z87wJ145hKG0r8CDuk8fCaoij0uXGo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fCL81jMZKiBSFIFeQRALhcCwC7NWJfHXcubrLJNb0Us60WJzqR0MPmQRxhF3rd5MC
	 WZY9iZFXSCkT83LG8LhnyJ4U64a9Wg2EFdmaCpGlYhakiHurKRAzSPBYD/Pz9hry05
	 8oM3vpVn3QUBf0gyQNnQ9J/Cs26pgGWTtBYTsW/praSk96zx5n5xN+/ECW3JitpLvb
	 Gh5syVgPqVLSuWIgVVnHoDeIOFjmLWeye1o9J0xsAEiLpd0tNfPoxoKkEraWWkxdo8
	 /A8USnN2+P58wSzmhoONrCvWAFbVhQwgF7rvhoJLjlpY5p01/M6sfOeLWuKgiA0zIw
	 hCSholVjH9i3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C58DC80972;
	Thu, 17 Sep 2026 16:02:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F2AD422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70BFA608A8
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:02:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cpyp-vzwTF-L for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 16:02:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4702E6085C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789660968;
 b=PXMHUz2Yc+GtuI1W+DgCAg/BEtsSESPTYg+Q2OG8/Cv+rV4zbNnC3Y7U1EWd5EgVwSBj
 tsJ57UtFKUWWCuHe4XgB45keXUrCAUeDdFWVirE5LiD3DC9O96nTghL63uzCCUOaMFBEP
 HccOyztsE9OVZO0zA+3ovp5qg+mwiIGR9egKpQKtxAZvyMHfYiJgDZpa3eUVoLpjbEPcE
 kmZ34sdxZfE3ERO3eY4pz9WjhHt4KTDDiR9MfeSXDYgDCYMrvukImArYzM2SfNAJ7XYQH
 aAHrJXufsl6ajkptDBKfTRFQKjg8lxpPJORyiEY8D+wLubnK5eV1BsVA3o6YbqORI4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789660968;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=T62Ky0MRQBXi6Z87wJ145hKG0r8CDuk8fCaoij0uXGo=;
 b=UikBqFopK4+gkIX+fGJC8mEr76J7zentHPDs50/BHzJdpKCH9+Yx1MFL9LjbCqDFGCBr
 XitzMRA/ERb2vrGHIf4I+Ut1oK1RVDDRhoUKATa8Pfk75gBTZUzOJcBmLZvQDWry8z9iS
 YR5/WN6S+p/gSTp8TYDjIiZU9Ae9yoihPsfzD1YfdhjwGXEaJnuyJ3J3g+hMkire+YCmu
 mujV5DQGr0X3MX1MDxAibWu5tFKk2Mr9LjeGbnGrGnH7cZOLCWgelUpig695ndtDFqwI9
 9Qfp7llWRl2Lvq2JtpA2B7cEOPD8JShHud59WlHZzsGGWxoRroCBL+E6hTHGJfD7oyw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=DUgnW9tA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=DUgnW9tA
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4702E6085C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:02:47 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4ab201ecso912007d50.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789660966; cv=none;
 d=google.com; s=arc-20260327;
 b=fBUfDjBVUZn4eDEy4+EwKYfv2n8EfthRcZ7sSyc/Qv0wJkpiZeW35DBKXfUCsJtqj1
 f+HjXF+MeinHhlYKVnFcG1ty+UUqSAOkt1XFIKfKG2Pp2xgaNCxtv/JNY2twTNf/u6uN
 Ker8kFrLDuWdc56llgaSS1qYvvISWWjt+37Y/pRfVf07biaTkbzj6clagdi8fKC5uLKw
 gv1b8umr9VzcwkCkSki1zxoQ9Bxgg+mXScGlyGsigLGVLwXVxo1JDMkC1GiuhYpzSXcF
 dblzfhJSOjtkiSwjWneyiD7gSqstisAKyZavf3NN7P8E/iR3lhEpD5oP9BJiUU1S8YaH
 tVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T62Ky0MRQBXi6Z87wJ145hKG0r8CDuk8fCaoij0uXGo=;
 fh=nuBf3wKo1f6h1jUIZsacuBBNlSv8DnOg+7qF0rK2IQQ=;
 b=QQi2hvBuLFG4eepmcoR/onujcIS2WzjtTsVFsTZw6MmqrYRvfXIkHcN6nNi5ktU8Zo
 DuWsW+MTFTl2BT8JM3tAK+3dfh+pbJsW4FxXrg8P5+MBQnPErofe6SF0VRUE/rU7GMXx
 nAzQqEzdln1KWU+yo43wai5msQd350jOiUBs6yPvEsV9tNXhLd47Oeum5FDa8zYy87yc
 FNrttJyhrlu/AvdDs6hFmsoJL/ltkYd9ZF/cY1gyeELpn9vfb5pm5Njmp9sEfWihIISQ
 +2K6Ohj5jRNNDdV20JZkNfp4W+GN0X3ElW+bScszrkjGeTj77ybhsNfFfHQsabDUcHK0
 KwWQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789660966; x=1790265766;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T62Ky0MRQBXi6Z87wJ145hKG0r8CDuk8fCaoij0uXGo=;
 b=DUgnW9tAjJzO7oRvXJHXbYZUYq0I1k1euuDlyVyBenVGw121XlYRVNKQK8Ygx4N3Eu
 57B84Pc46olvJCazWP8z5jdBWuKDkKVSY8x3EagcR+8PUVqbB4IQFkd+4h1iGrvcCK/M
 dwbrxUF5Q3P/hLbMaEh/Ix7zmTbyYZipitFN+q1JktzTfU8mVrcOd9KxdLgGNHNcJSV2
 7pTOTqGA5+JuyWsyP1fB2R+UcDu7Tiy9lIKU7OPU0UX9yPjvJndmKXX9ZnwoWSnazc5u
 zQZAuSwbEwfm9vpd07093lwLxtGdcAbEkwOx+G+qoi1S1HHC7S92HustfB6ZU5b47XDU
 OnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789660966; x=1790265766;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T62Ky0MRQBXi6Z87wJ145hKG0r8CDuk8fCaoij0uXGo=;
 b=GyBRDEuXter6VsUV4MAMLADy/PfKlJrQz6oIzZNz80lAu2gviQ3n18/0lCOSlqxr5C
 LTce2dk9qgmGliLayMux7KpplT+3sciJ7zwT97rJBG9e+AhCN7+DjMS+D4yGwSnCjn/t
 T3ZSTNbtYT8v+UiOTzlNO3bIiH19DlmQHmSWznh+e2FmnE6IYN5QSgn66Bp9Zwm/OXbe
 fM10CNhEWacdBJIWLGR6ZdYLjU5c6webF9X+qK0TiBkyzD1oHx64bR+a9TCJSJeJaIB0
 uzCNad1uUBPFqMFdlFpKqY80H/Teht/vs/dTGPHg553TaKd/UCcOYRmULJfWkDl+JDUB
 2r/Q==
X-Gm-Message-State: AFuF++nyJzEvUlp54Zaqx2CwsslEaMQqYDvMJzevt2tXQn4FqI/iFBdj
 fbph6ripikkPUabKZzb655DFX7Z268vNsw0SqA/0alRJNgCYv17oTU4Eq6m3CMe2odGl2rC16VN
 EXgXYZ0I/wrb4gUbYwhhbXOgs2gWqdqLP6s/yp8/AIw==
X-Gm-Gg: AYBFou0vnhmnLRKUAPvtRZ2v/RnFg5NBYHGBoIRG81cXyWjrKoJOq0xfsAx0Sg9BZJM
 Lm8G8OVqeGSbCIowcNlYAX3/shDKNrr6zp05b64JA7+g/TgPXjvITx5APdfPGHT2mh3u07coGpM
 qoOqR4+5y6jqVdEJtyoaRDLYwYkEb1fi0iIWBDP4WiIBlU3gU4N8eNvb4ZM1rcl0XpxxpquVGJk
 KfFe/z9pleU483dq7+/fdCcUcucQhRAhEgFyOUOKBz99a0geolOKK2KyOPYyk4GrcKpkTtoexmR
 0j8RM6rAhke6L21Z1l2pG5VrmbK2U0V70pKO0H3VRsNoDrVszJDy6AJ++LXqWfxhnGrv/Hc/t2f
 Kvo2gPNhOIDtkjOJ32+byFFWDPjrfS6OhvpqfvURSNvqmBV7H/b9ZV7oQmxpiypw//+Fz7dbqmK
 wczToZftsy5VnH2m+tDKw/uTvOX6E1Xe5JK8SWph9SV+2AmndGQ5kB3JiwkVj2IJpckQhHAa0xT
 OQnuxNa+RuJjrlKnbcHiimetFBW+XrLxZ7fGrZlqMpdo5cbNUCeDoAbyHzN8Yei+yECBbEplJv6
 QUPBusZDsqij++o4TMy0zARRqx1ECCHg397P4ZwZUpjq+T1V0RQGtvQH+4bKbIQ4yOn/KXxZowt
 uyrr9Pi+C9s8BQ6iy+3UYquW7utE2t4u7zT24s+9HosFbZsNghfeZ3emc
X-Received: by 2002:a05:690e:d01:b0:66f:c1bc:87dd with SMTP id
 956f58d0204a3-671632bd5bbmr2260577d50.54.1789660964011; Thu, 17 Sep 2026
 09:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-conform-v1-0-475b2947631a@arm.com>
 <20260904-conform-v1-5-475b2947631a@arm.com>
In-Reply-To: <20260904-conform-v1-5-475b2947631a@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Sep 2026 18:02:06 +0200
X-Gm-Features: AcwNN1Vp1amvh3r1VpKHWVldR77rxA4OsKRIkPgDKl4hWDYjyUhToDh6w-WNx0g
Message-ID: <CAC_iWj+8hZHnzsg8p_4NaHCOyOvO3edb+sm5RsqWY1aWxZVtAg@mail.gmail.com>
Subject: Re: [PATCH 5/5] doc: uefi: EBBR conformance profiles
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Fri, 4 Sept 2026 at 17:02, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> U-Boot can support multiple EBBR conformance profiles, and it can adverti=
se
> them in the ECPT; therefore, remove the EBBR fixed version 2.1 mention fr=
om
> the documentation and add a word about the ECPT profiles.
>
> While at it, fix one typo.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  doc/develop/uefi/uefi.rst | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 94ddf690440..9dc34495f66 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -14,14 +14,23 @@ Development target
>  ------------------
>
>  The implementation of UEFI in U-Boot strives to reach the requirements d=
escribed
> -in the "Embedded Base Boot Requirements (EBBR) Specification - Release v=
2.1.0"
> -[2]. The "Server Base Boot Requirements System Software on ARM Platforms=
" [3]
> +in the "Embedded Base Boot Requirements (EBBR) Specification" [2].
> +The "Server Base Boot Requirements System Software on ARM Platforms" [3]
>  describes a superset of the EBBR specification and may be used as furthe=
r
>  reference.
>
>  A full blown UEFI implementation would contradict the U-Boot design prin=
ciple
>  "keep it small".
>
> +Conformance profiles
> +~~~~~~~~~~~~~~~~~~~~
> +
> +The EBBR conformance profiles supported by U-Boot are inferred optimisti=
cally
> +from its configuration and the corresponding GUIDs are advertised in the=
 EFI
> +Conformance Profiles Table (ECPT) automatically by default.
> +System integrators should review the advertised profiles and override ma=
nually
> +if necessary.
> +
>  Building U-Boot for UEFI
>  ------------------------
>
> @@ -323,7 +332,7 @@ Capsule with firmware version
>
>  The UEFI specification does not define the firmware versioning mechanism=
.
>  EDK II reference implementation inserts the FMP Payload Header right bef=
ore
> -the payload. It coutains the fw_version and lowest supported version,
> +the payload. It contains the fw_version and lowest supported version,
>  EDK II reference implementation uses these information to implement the
>  firmware versioning and anti-rollback protection, the firmware version a=
nd
>  lowest supported version is stored into EFI non-volatile variable.
> @@ -1019,8 +1028,7 @@ Links
>  -----
>
>  * [1] http://uefi.org/specifications - UEFI specifications
> -* [2] https://github.com/ARM-software/ebbr/releases/download/v2.1.0/ebbr=
-v2.1.0.pdf -
> -  Embedded Base Boot Requirements (EBBR) Specification - Release v2.1.0
> +* [2] https://github.com/ARM-software/ebbr - Embedded Base Boot Requirem=
ents (EBBR) Specification
>  * [3] https://developer.arm.com/docs/den0044/latest/server-base-boot-req=
uirements-system-software-on-arm-platforms-version-11 -
>    Server Base Boot Requirements System Software on ARM Platforms - Versi=
on 1.1
>  * [4] :doc:`iscsi`
>
> --
> 2.53.0
>
