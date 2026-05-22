Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D52CD5BAC
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 08:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF5E8460E;
	Fri, 22 May 2026 10:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yKHYf9f1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDD1B8460E; Fri, 22 May 2026 10:43:54 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CAFF8432A
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 10:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65c2cd216c9so6021339d50.3
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779439429; cv=none;
 d=google.com; s=arc-20240605;
 b=HU7loWuaHXQP7t+HpNM14CVxlA3brJgVw3g4GFmGJnybf7jlUvdM/Qlv/0l1la0kMA
 zjZPTFRZw27F2gubB4/PF/scaW12pC/9Gfy27sAxAj0rlMVo8i5SgPG6e230n23FoqWD
 5qVuSluBsfBSh8XERQ6PeaNLGBvqtkUpUfH9p61d4lp0I/s6lNgIuhuDq4XdkR9GTbWc
 jyryYaNnDSliMAp8Deag16L6T1zoMIowQ0HplmZ1+PNo3jdyMvo8V25fvP7wRmBVYMbd
 7WFxJWx3b1aNtpsMCLIslzTcD7l9KhZZsObCFvXRoFTbFcS7MrNajgD3Flwnkqpwiq1G
 8PRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n9du/sVHVaU+Aj+AlHiX+abiM8q19qThzhnADtn0x9Q=;
 fh=YYpQR412u2LpDLmxgxwUVn7lU3iubIFghgTWPl9UIxM=;
 b=UtoK4dib7F7CcifwuH/N2BvuaSoHh60XLEgw4Y/niUN1wTwkgE3r8UNf7TjjV23giS
 VbmFRIKmRHmORGScZ3Qm3q+WqoXOWFsgjGgTpd2EtF4BSk31qLEsLrLLY9vlUpA16cJ+
 llkwTWl0lHICTC+yCxl+9gPZJpCwBfSQ492sdxZNxWuZn6M6ux/TL84w3dJ60i9kT9YL
 kwdVCB8OGPecXYFMeAO5VLARYwun82EJrl9Vtb9OEQ7PsltT1/xaMzzI2Ovb9f2LaJMC
 t2FvlTCPB0WrLhDwtyDVyQgYMDattvFYAXs5oG2Lo6sY1KxjOpp8TuRzpOyhio6BKQNc
 nFYQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779439429; x=1780044229; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n9du/sVHVaU+Aj+AlHiX+abiM8q19qThzhnADtn0x9Q=;
 b=yKHYf9f1Fka1UAIWK1TSRTLKM5nTmcrB7Qb6aFFyqVBm3tFqJQJ7L9td41CSQTyHvU
 ru/MkSTA6GxKbNSss5wkjAe9/qlCTvNnKDJ8Hd/TqpH5rW5YAwigRTwYCBptHe99clew
 k+xhbvosVu7OWlsi1zJq/kiGRK54JURdmwzZDCWe0GdcAWiaose4q3d1kXGIyav2fXA0
 GIAevIetEDcACYaTd+zNFoh/SWk9nlSK2K4JpGSHEo7uYlWXQSbQIbM6afCMYaUDa/qI
 5G931cJVpwrqWocp9ibF0QdvRvMJbxPiKC+IeBuT9lysefdm4lNeewduJS0D7nriXgsw
 eXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779439429; x=1780044229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9du/sVHVaU+Aj+AlHiX+abiM8q19qThzhnADtn0x9Q=;
 b=KXP5+co2LZZs475jU2vDmf1VJ9ST213mHG1G0PLyaaseOKSDsD4uVCt8z82R99hXGD
 lh0pMK92rB8QrQ8Azho0/JuxwEkAuZJtRRt811DLb+XE/TxAr9UFfCq9bCVUQpYS59NE
 G65xPW4eEQ4GBcIn9CnfwAgxJzUUui5afmxppm+qsKT5iD+s8QYoQtSA6DFa7y/F3PUI
 NWVsKruMjfTy3naIH3IiR5lwroH90PU2JShFrrKIEqtTxzHXrYreqYD/80qvOw3PqDF2
 pkKXegYKJNL8jMB/qX29ka42BCznj8ozpY+NPwr16Nw0vbvBzhW4WTH240e/Z8YpuyR3
 OV4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iCbOiM8so6GqPNUlRKCHcafdpQRifxwDRZgREOtpEO4ZSss9JqYsimcT1Aa2trqEsyN4n9BA=@lists.denx.de
X-Gm-Message-State: AOJu0YwpnW2uL+tlE9IyhPWSuLxoXRd9Wnx2mWZxAdjJyXK68oNZsOvq
 e17eoVM9OZ8BaSk9HsiDg1iSiy4D7tLM0pPeERDaSHIxEYrB55xACjFBPQ4vsB+ytZRZLE/F4AQ
 EXHZu4jz0nashsu/eAb33XwKPgdhvmk7lTMApJ85XOg==
X-Gm-Gg: Acq92OE7sHdzJ2jWR+h7E17KxU8hbIePwWVW4jVZ8CQLry9Qmh+yWKGUNC+suZxVjV7
 USJv6A0nLMA9cwWW4//LHJv17gYFhuX/4Ze89NtL/GscAMCiYNRZVCTu7Qz4VjyyfBdiROIM5IC
 xToH2UcuhKa3BIB4Z/g/7in1pMqrqWwQ6DTFAxfYVkQl7RwOekIkChkxuV+mP/mfu6tkg7i3WUW
 vyMXV8x9cgstRlPpGkFzlfhDT++BykIKPuIzU95UdQiaFbx/SFu4p9j/hdhKPqY9YpTvmXkrd1x
 fg+O+a+wef3MWVRkGkoDm0RV0vA38UIq7UY4O/IAzOaZl2YqAThWQJVL7pj3O3aZwOu6IuaXOSK
 oKH0bWZIYytUYBCE/he4SNPlaAFoBzquC40oGqoC1/u3Ar96SUu9UH+xs9gd0357GTxfmIdXiFb
 /ZOIf9ORFeuo4cd+6Wkbbuudgn/6DO/Bp3ZZ1ROc5U4/c57nJtB6iuypMLSIVKqqSjqIxYAePUI
 sLToOVUujl2ypS5ojKXTBxALk8s5wHzsbLlQohYjTLBCwRflPyb+iiabTcp55+6kVDIQsRMJzqq
 88KUJpZMp9QeSIsWH07qntNIgz8sImcCBvXl39t/GP9CTCfdoq2MeGFu0CuvJxsEWTJ0xdMrC1a
 LfJeV7w==
X-Received: by 2002:a05:690e:4287:20b0:651:bd70:1622 with SMTP id
 956f58d0204a3-65ec961ce6bmr2140403d50.10.1779439429476; Fri, 22 May 2026
 01:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260514171649.3708107-1-aswin.murugan@oss.qualcomm.com>
 <CAC_iWj+bgFhPbxNH-BqU1fFD0j3wzBE_9FT_kfhZ-r48Ztb7pQ@mail.gmail.com>
 <da733868-79d2-4425-acd1-f1a9ce83feba@oss.qualcomm.com>
 <CAC_iWjK+VL=OCeN+4ZufQMyKv7su+JQ-gic7YMSnt-Ci6xZh-A@mail.gmail.com>
 <932df312-3f26-4966-a313-fd8ac932167f@oss.qualcomm.com>
In-Reply-To: <932df312-3f26-4966-a313-fd8ac932167f@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 May 2026 11:43:13 +0300
X-Gm-Features: AVHnY4IFVHa8o1YSI9qLBOTJwxl57ApNJXgCw5WFTe6c8Xl81Va7c01ukhA_tJo
Message-ID: <CAC_iWjLXF6F1wOsMJgLiQxC4PXLb0PNhoQfAd1DrgUdtuRFtcw@mail.gmail.com>
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


On Thu, 21 May 2026 at 21:31, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> Hi Ilias
>
> On 5/18/2026 2:07 PM, Ilias Apalodimas wrote:
> > On Fri, 15 May 2026 at 16:17, Aswin Murugan
> > <aswin.murugan@oss.qualcomm.com> wrote:
> >> Hi Ilias,
> >>
> >> This change has been verified locally with our setups on qcs615 &
> >> QCS9100 SOCs
> > Ok I am getting the same error here. How did you produce the final binary?
> >
> > The only test I am doing here is enable secure boot and variable
> > preseed. The generate the preseed with
> >
> > ./tools/efivar.py set -i ubootefi.var -n pk  -d PK.esl  -t file
> > ./tools/efivar.py set -i ubootefi.var -n kek -d KEK.esl -t file
> > ./tools/efivar.py set -i ubootefi.var -n db  -d db.esl  -t file
> > ./tools/efivar.py set -i ubootefi.var -n dbx -d dbx.esl -t file
>
> Similar steps are followed but instead of .esl we pass .auth file to
> efivar tool and sign the kernel using sbsign

What's in the auth file? A certificate?
You are not supposed to pass the .auth file iirc. We expect to have an
ESL in there. The documentation is unfortunately missing but there's a
pointer in commit 73253d7765c

In any case, we should look into why using the auth file works, but it
doesn't sound correct

Thanks
/Ilias
>
> tools/efivar.py set --infile ubootefi.var --name PK --attrs nv,bs,rt,at
> --type file --data PK.auth
>
> tools/efivar.py set --infile ubootefi.var --name KEK --attrs nv,bs,rt,at
> --type file --data KEK.auth
>
> tools/efivar.py set --infile ubootefi.var --name db --attrs nv,bs,rt,at
> --type file --data db.auth
>
> tools/efivar.py set --infile ubootefi.var --name dbx --attrs nv,bs,rt,at
> --type file --data dbx.auth
>
> *sign the images to be verified *
>
> sbsign --key db.key --cert db.crt bootaa64.efi --output bootaa64.efi
>
> sbsign --key db.key --cert db.crt linux-iq-9075-evk.efi --output
> linux-iq-9075-evk.efi
>
> Regards,
> Aswin M
>
> >
> > Thanks
> > /Ilias
> >> Regards,
> >> Aswin
> >>
> >> On 5/15/2026 4:02 PM, Ilias Apalodimas wrote:
> >>> Hi Ashwin,
> >>>
> >>> On Thu, 14 May 2026 at 20:17, Aswin Murugan
> >>> <aswin.murugan@oss.qualcomm.com> wrote:
> >>>> efivar.py currently stores authenticated variables including the
> >>>> EFI_VARIABLE_AUTHENTICATION_2 descriptor (timestamp + WIN_CERTIFICATE)
> >>>> along with the payload.
> >>>>
> >>>> When variables are set via U-Boot, SetVariable() validates and strips
> >>>> this authentication descriptor before persisting the variable data,
> >>>> resulting in only the payload being stored and returned by GetVariable().
> >>>>
> >>>> This mismatch causes efivar.py-generated stores to differ from U-Boot
> >>>> runtime behavior and leads to incorrect GetVariable() results.
> >>>>
> >>>> Update efivar.py to strip the authentication descriptor and store only
> >>>> the payload for authenticated variables, ensuring consistency with
> >>>> U-Boot behavior and compliance with UEFI expectations.
> >>> The approach is fine, but when I use the tool now to create signatures
> >>> and enable secure boot I am getting
> >>> => bootefi bootmgr
> >>> Getting signature database(db) failed"
> >>>
> >>> Have you tried a built that worked locally?
> >>>
> >>> Thanks
> >>> /Ilias
> >>>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> >>>> ---
> >>>> Changes in v3:
> >>>> - Previously stripped the authentication descriptor at GetVariable(),
> >>>>     now moved to strip it in efivar.py during variable pre-seeding/set.
> >>>> Link to v2: https://lore.kernel.org/u-boot/20260512194205.1905069-1-aswin.murugan@oss.qualcomm.com/
> >>>>
> >>>> Changes in v2:
> >>>> - Enhanced commit message with explicit UEFI spec reference
> >>>> Link to v1: https://lore.kernel.org/u-boot/20250725123653.513252-1-aswin.murugan@oss.qualcomm.com/
> >>>> ---
> >>>>    tools/efivar.py | 50 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >>>>    1 file changed, 49 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/tools/efivar.py b/tools/efivar.py
> >>>> index 67729fa8505..d248cd868ba 100755
> >>>> --- a/tools/efivar.py
> >>>> +++ b/tools/efivar.py
> >>>> @@ -79,6 +79,50 @@ class EfiVariable:
> >>>>    def calc_crc32(buf):
> >>>>        return zlib.crc32(buf) & 0xffffffff
> >>>>
> >>>> +def strip_auth_descriptor(data, attrs):
> >>>> +    """
> >>>> +    Strip the EFI auth descriptor from authenticated variable data.
> >>>> +
> >>>> +    This is used during efivar.py-based pre-seeding of ubootefi.var to
> >>>> +    match U-Boot SetVariable() behavior, where the authentication header
> >>>> +    is consumed during validation and only the payload is stored.
> >>>> +
> >>>> +    For variables with EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS:
> >>>> +    - Input format: [EFI_VARIABLE_AUTHENTICATION_2 | payload]
> >>>> +    - Stored format: [payload only]
> >>>> +
> >>>> +    Auth header size calculation (aligned with U-Boot efi_variable_authenticate()):
> >>>> +        auth_size = sizeof(EFI_TIME) + WIN_CERTIFICATE.dwLength
> >>>> +
> >>>> +    Only the payload portion is retained after stripping the header.
> >>>> +    """
> >>>> +    if not (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS):
> >>>> +        return data
> >>>> +    if not data:
> >>>> +        return data
> >>>> +
> >>>> +    efi = EfiStruct()
> >>>> +    if len(data) < efi.var_time_size:
> >>>> +        return data
> >>>> +
> >>>> +    offset = efi.var_time_size
> >>>> +    if len(data) < offset + efi.var_win_cert_size:
> >>>> +        return data
> >>>> +
> >>>> +    try:
> >>>> +        cert_hdr = struct.unpack_from(efi.var_win_cert_fmt, data, offset)
> >>>> +        dwLength = cert_hdr[0]
> >>>> +    except struct.error:
> >>>> +        return data
> >>>> +
> >>>> +    auth_size = efi.var_time_size + dwLength
> >>>> +    if auth_size <= 0 or auth_size > len(data):
> >>>> +        return data
> >>>> +
> >>>> +    if len(data) <= auth_size:
> >>>> +        return b''
> >>>> +    return data[auth_size:]
> >>>> +
> >>>>    class EfiVariableStore:
> >>>>        def __init__(self, infile):
> >>>>            self.infile = infile
> >>>> @@ -172,8 +216,12 @@ class EfiVariableStore:
> >>>>                    break
> >>>>                offs = loffs
> >>>>
> >>>> +        if data and (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS):
> >>>> +            data = strip_auth_descriptor(data, attrs)
> >>>> +            size = len(data) if data else 0
> >>>> +
> >>>>            tsec = int(time.time()) if attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS else 0
> >>>> -        nd = name.encode('utf_16_le') + b"\x00\x00" + data
> >>>> +        nd = name.encode('utf_16_le') + b"\x00\x00" + (data if data else b'')
> >>>>            # U-Boot variable format requires the name + data blob to be 8-byte aligned
> >>>>            pad = ((len(nd) + 7) & ~7) - len(nd)
> >>>>            nd += bytes([0] * pad)
> >>>> --
> >>>> 2.34.1
> >>>>
