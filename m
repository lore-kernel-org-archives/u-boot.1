Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CC7CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 10:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AC7D8341A;
	Fri, 15 May 2026 12:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CCFDgwFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1EAD83AA9; Fri, 15 May 2026 12:33:29 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C0580086
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 12:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-65c364b893aso11111006d50.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 03:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778841206; cv=none;
 d=google.com; s=arc-20240605;
 b=lgrWIq3FIAv+lFLYODjUzm7U0W5uyVtkXMJ2l3xmsYvfT79E79PiYQDPgFmibvLVMV
 A4wpVNTflplboMTplJijirfG9xUlq8zF01qDrX+iYhQn80iTjZx3WyCkWVuWJliimhRg
 tnqXxilDhadTBASC60In41KfH0uTnkkGvSqjIjEwQ2zJee1aTrfw7inPZ2fXMlmseNY6
 wYDUSHYSDWu9039p+gzlY0lnsfiyU7+vTwjtomFu5z6ra79gpj3/7Sj3cmDKCMgkgYWy
 QjeHnR430/7kKcKf3C6Pmq0wxkBg2nS/q+BBec9o87OV4yvX5Koiv6JE9p1ZjsiEnSlz
 6+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qOK43D2L64QXntlHo4TTpZlSNRyQFo+mR/M2sRMJ08U=;
 fh=VzTu9ko1hWQ6udTzVa+1zW0DFUGxBaAFN6kIh887dp0=;
 b=elO+0HSIso+Um1i38X2uUfuVDDIOYzUAKi19aGS7OPfyRsZ1t81Fd0HEWO8qov6HLz
 2Rfj7ur75ltvy8ho4nRiQadN1C59sOilCeCwlBSnXG6g2zYDhBPdD7Oews5DXYuDgxk3
 XZy3RBmSB1ipOMOpUNAeQeDr9FKMgyHvritYdb1k0r4f59X4GR8Cxy5OQQ0YYv8+fIcV
 VGtbdmHchs+S7nahhenITQXwaxJOV75a3FK678TLGp4Z0KQhSeL4Om4HFWrn608UQVQc
 745PjM6bODps8o8gOtxbuexT5A66epiHAFov/A7wsYa6NmK/ifJsLknALz7r6HP0EmjM
 meyQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778841206; x=1779446006; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qOK43D2L64QXntlHo4TTpZlSNRyQFo+mR/M2sRMJ08U=;
 b=CCFDgwFRJEuUI0JXoVv725MT2dEQWoapjbUQ2NggjXy5BQfoyuwVxK8c95rIA5Fouh
 DHTa28f6JtPBOwnebV2o//M6L5qSe4nQy7xsKLXE3zjuERwq0nai+rov2HfQgu4De21t
 IY2uqBt2JGZTgNVGZajP+qjnT1qWA5FpdqVRqwJpj+BTX2xWexZHvc7fWIYvXavGivtu
 +S69Y3CpZ9RAvbq0VTipMYkFQFPhUyWCb9I7lv8TB/YeljOvcehpTM55Vi1lsnHU9Van
 nTncLCiwCzy0PcP+msPnAio+c/RRDoZrcA8o8T92D34V3CJsAg3vbgEJu8uHE3O7ErgZ
 Qtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778841206; x=1779446006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOK43D2L64QXntlHo4TTpZlSNRyQFo+mR/M2sRMJ08U=;
 b=V6+QLVVvP37R5qMWFHQHMD8AX5n1w4EHiHmbx2qkuJvonF2wpMMYJA1et8jr4yTQie
 B83gEXc5xB1FZzm/IqA+sO3YayCyFSKNhompoN55mv60/VIXhSt1/NlfFAuX/i301Ksv
 PY8og9iUkgJ9vZNsamRQfxm54y1aiJo5qAoPEPycBj4yV6Wg1UpiJl7RjLgKe1CgMyk9
 HNNySByDvveXQgo6Oxdoo9WTNYjzh2y19RzoX6k7L8aHQQMfp6tsWP2QhSECMJCzGZmf
 f4p1IsUMZupXG+ZtEDHbtUkwDIOdV0XbRx03XajDwADorUCVZZWOgGo0EvoZuqDnoKVk
 tvcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Y0R6CsYr3ZeBjaGfSm49ntKJHYJZZPeaNFtS0aRsp3T6EdxG9fYq7/wcykOQO3SCITVfo2pk=@lists.denx.de
X-Gm-Message-State: AOJu0YwCem9tWM958bQQsZz1hfsNJw97YmvmNGEBWm3Q36/3ymCFoj9l
 wd6GkeyUepP2d+RrPODsfv0aV4lUK9Elo7/wtn0egSmfrKwRpDy1/ZcmlEyDuzPFS1Issc5XvOx
 rY5UWjJYJ44c1vO8NEsPevT+lwzGp2Kbe+6zOgwKHnw==
X-Gm-Gg: Acq92OGAGslW0JG4/KS5fzL+c75kM2sKkGhK4WVo6EDqdkjPuaKaVY2NiRg2hIRq7vV
 HON+l1376t2s/C/jEQnv/RCt8bg2BvL/L+v2RJkKdquCl36Pmya0LIQLnEc74MJjzhr6Wf1fRWq
 GSHZgFvbXLOYe/MLF5f6LBIWhgGWEyOc6TY4lgYcJaZQI9P+wTKTEd9OSxWY6FhSaSO/0dwwhwH
 zUpj6tSDsr9ZG3ydLYMeqNbo7jUm0hOaYWOe8Hke7nbS0FscVkDOEIQwozx8sIzTvdgDWECuIWH
 Kdp4ZDHPFlKN6Npce9HVi7b9D1U/9hjDHj3Q4vnaALtH2VOLw97VMvG3ONWOxXjdP5MC/hLnK39
 Iz6mMnA8a7jxBP4MgM9NNVRKl8hNADPV/+O1/Jvge+gbW4hOq1kSlD3SXCIqjOpz1o54tgGeLFY
 aj+iG5fevjhysHspk5kN+PyiJvpPkpC4XrmxHE/aAi3WhqcKj00EL9lDGp+raTPvvF3aKP1Qadh
 aAtbR50ReLSvPBXhvNfTmL+jWVOP3Wfx8bT3q5ZxaGXF/2BQtG1laUaAOBkIyME416+hz1FVaOF
 Q8trDt8tY41GxK7mOlnyI+GsmtDxW/HJlU06Oa/8f53Refb+7f3UQtEbpCg6IIlQweFNsU8my//
 6Qda0xw==
X-Received: by 2002:a05:690e:4290:10b0:65e:11d1:5c1b with SMTP id
 956f58d0204a3-65e227d405fmr2694620d50.33.1778841205788; Fri, 15 May 2026
 03:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260514171649.3708107-1-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260514171649.3708107-1-aswin.murugan@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 May 2026 13:32:49 +0300
X-Gm-Features: AVHnY4J_FPAaa9tQjQuku3JG5QKd2RG986qY5-_VI5-bn1YVS57DB5ecEisamVE
Message-ID: <CAC_iWj+bgFhPbxNH-BqU1fFD0j3wzBE_9FT_kfhZ-r48Ztb7pQ@mail.gmail.com>
Subject: Re: [PATCH v3] tools: efivar: strip auth descriptor for authenticated
 variables
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Ashwin,

On Thu, 14 May 2026 at 20:17, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> efivar.py currently stores authenticated variables including the
> EFI_VARIABLE_AUTHENTICATION_2 descriptor (timestamp + WIN_CERTIFICATE)
> along with the payload.
>
> When variables are set via U-Boot, SetVariable() validates and strips
> this authentication descriptor before persisting the variable data,
> resulting in only the payload being stored and returned by GetVariable().
>
> This mismatch causes efivar.py-generated stores to differ from U-Boot
> runtime behavior and leads to incorrect GetVariable() results.
>
> Update efivar.py to strip the authentication descriptor and store only
> the payload for authenticated variables, ensuring consistency with
> U-Boot behavior and compliance with UEFI expectations.

The approach is fine, but when I use the tool now to create signatures
and enable secure boot I am getting
=> bootefi bootmgr
Getting signature database(db) failed"

Have you tried a built that worked locally?

Thanks
/Ilias
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Previously stripped the authentication descriptor at GetVariable(),
>   now moved to strip it in efivar.py during variable pre-seeding/set.
> Link to v2: https://lore.kernel.org/u-boot/20260512194205.1905069-1-aswin.murugan@oss.qualcomm.com/
>
> Changes in v2:
> - Enhanced commit message with explicit UEFI spec reference
> Link to v1: https://lore.kernel.org/u-boot/20250725123653.513252-1-aswin.murugan@oss.qualcomm.com/
> ---
>  tools/efivar.py | 50 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/tools/efivar.py b/tools/efivar.py
> index 67729fa8505..d248cd868ba 100755
> --- a/tools/efivar.py
> +++ b/tools/efivar.py
> @@ -79,6 +79,50 @@ class EfiVariable:
>  def calc_crc32(buf):
>      return zlib.crc32(buf) & 0xffffffff
>
> +def strip_auth_descriptor(data, attrs):
> +    """
> +    Strip the EFI auth descriptor from authenticated variable data.
> +
> +    This is used during efivar.py-based pre-seeding of ubootefi.var to
> +    match U-Boot SetVariable() behavior, where the authentication header
> +    is consumed during validation and only the payload is stored.
> +
> +    For variables with EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS:
> +    - Input format: [EFI_VARIABLE_AUTHENTICATION_2 | payload]
> +    - Stored format: [payload only]
> +
> +    Auth header size calculation (aligned with U-Boot efi_variable_authenticate()):
> +        auth_size = sizeof(EFI_TIME) + WIN_CERTIFICATE.dwLength
> +
> +    Only the payload portion is retained after stripping the header.
> +    """
> +    if not (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS):
> +        return data
> +    if not data:
> +        return data
> +
> +    efi = EfiStruct()
> +    if len(data) < efi.var_time_size:
> +        return data
> +
> +    offset = efi.var_time_size
> +    if len(data) < offset + efi.var_win_cert_size:
> +        return data
> +
> +    try:
> +        cert_hdr = struct.unpack_from(efi.var_win_cert_fmt, data, offset)
> +        dwLength = cert_hdr[0]
> +    except struct.error:
> +        return data
> +
> +    auth_size = efi.var_time_size + dwLength
> +    if auth_size <= 0 or auth_size > len(data):
> +        return data
> +
> +    if len(data) <= auth_size:
> +        return b''
> +    return data[auth_size:]
> +
>  class EfiVariableStore:
>      def __init__(self, infile):
>          self.infile = infile
> @@ -172,8 +216,12 @@ class EfiVariableStore:
>                  break
>              offs = loffs
>
> +        if data and (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS):
> +            data = strip_auth_descriptor(data, attrs)
> +            size = len(data) if data else 0
> +
>          tsec = int(time.time()) if attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS else 0
> -        nd = name.encode('utf_16_le') + b"\x00\x00" + data
> +        nd = name.encode('utf_16_le') + b"\x00\x00" + (data if data else b'')
>          # U-Boot variable format requires the name + data blob to be 8-byte aligned
>          pad = ((len(nd) + 7) & ~7) - len(nd)
>          nd += bytes([0] * pad)
> --
> 2.34.1
>
