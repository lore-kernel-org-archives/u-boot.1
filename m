Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE44CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 08:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B681A83FEE;
	Mon, 18 May 2026 10:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iSc/TbJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3812784119; Mon, 18 May 2026 10:38:05 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308FA83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65c305f381eso2181435d50.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 01:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779093481; cv=none;
 d=google.com; s=arc-20240605;
 b=RmI0pHPMjep04q26DQ7rGNDAN9vwZuvS7a6e4LhRZCh77JMfXNRiS06Vg01Wmf+q3I
 E5fVCJ+H27Ad55tpVXt+fmlJrl0KN48dUiMrgwgbZClsb8T58SHMZT3nkz8cV76mH+Ws
 uAM6T7jH9Iz3FNJ8EP8Tnp8RfSr3fxFXN5LLTMOfNlBYHioXGmx6qKg+o8mMnO0CUyYe
 B7y+VGgw4YTR3vZZH5Xr8P1ATDLO/R87FrTV750xZhFx5x/wZnMhiGsfZOpDyaNvtdHq
 dKdus4OXWzg+M1KDM7eB0X7dUFDkGyVEtU7iOyJghVcOAsc7SWsBFp+1hLmjNEFqt/2U
 5/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qdoBw3dfO0KtPTWV5luhCroibnihCPiKIK1/U8VYsIQ=;
 fh=YhiLL9+MCwBvFhw3risrDRR5sbhxpUj9yV1eCBhDh50=;
 b=YZ1k83wu6XfiKZEPpoCuU5636hZs4So+t/YFNWhWfZ6rtHg2UI79g3odnNqOXH2Nt/
 uQDC8MwQ2s2B5lsodkKZVKG1QP9xwOpreYPsXQiAW9oivPIyl9I5NArYu6Qbz9AypXQb
 sRNZtYo3yc0/uY7jit0PncIEX02O8/nOUZaZ9S1o0NFgYMirz9X7mmhz1f6j5plpaHdN
 qKCNb3XaKI0afCfRRSXvCQJ3ryj0HCkOdTabUMLtEvhEXlu7q3ru9xM2b37rM6cdD15V
 NUnpiPpFQxsOEjZtMbJSvVGk7YLwZcpZrLPOQ55GiysdJGdxVE7RzwUI4/4qPFZtMwMk
 IEKw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779093481; x=1779698281; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qdoBw3dfO0KtPTWV5luhCroibnihCPiKIK1/U8VYsIQ=;
 b=iSc/TbJeBjv3PBj7uhZN5OO0gPRcdb+kQ3GYr0kdqlOgSI7H5T92dYhglSEDXIhfwt
 ZxTH1mTADTWRn/5phrI6PRyi0/Y2fdNbBKWwGEo5F7bUKtYEZPv4y1TqK/C4VIhaN6tG
 vu/l9h0qvxpZ4m9h7RTqpNqgwlOro53CAu6kW8+LDbgil3neXVBRaL7x9Hhx6Jsz9fK7
 asbHs2Y+AmZCee14iPqNGFFblRkjQ3cOw2sXGPoY6jXdWFjJZbvVeP5Iy5QnhtMB8zHZ
 mdcS5DU6pJBKxo6VzooA2vlPWpeiX4QtfjK7bnoBtPzAROuMYbIg241xWgGA+Z9CbSdy
 /qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779093481; x=1779698281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdoBw3dfO0KtPTWV5luhCroibnihCPiKIK1/U8VYsIQ=;
 b=U/u/CCmbjOAkn5uKakiFNiC/aHyb5DVBe9Zy05k8F+mQbK4JaF3rbr9iUcMqeH7Gjc
 qxxJU5/eloVhbc7DirXI7HlC3S0U0BBz4/xOAUGTM5AkGLXG4PxLbrhaMZOL1e2djX3b
 2KI+QSoMwSwqTHbqm83g7itXc11KFt4JUrrs7MdBvipXxMNp7z/TAEm/O77QluK1FYbL
 DUup8NSCic++FHIlwtzDF8SqrJIPPksg6Ms9clTVVyuNTuqXqK1odnC25WDqcrLE8vVf
 899HkpIR4vVEsg4aLZvaA1xNMq27PkldsFHAsgsQVIcGV0wumGOvQzYfNfL/On2ScIlo
 lEdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hG1aY/eQBo4gAIQXbmPgHiPx4C3Bm2/+tSFddZazqozdn4a+eI7JcBYa9L+3Yz66Ct8fSd6Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxVHtjKaBbbmj7tImJmWmi9P03rHRpGVeIOpWt7UKRYncwPNYXM
 u3JXqIGcjWqNnW/NorS1u+k7d4h5R0ywguchsYD14nzFGNstyGp71pg8U27HsFhN6DP7f30xitx
 lvCZvqNTEsLIy4n4fbPjMAYg+DBVFitgGHZ/2MLv+Pw==
X-Gm-Gg: Acq92OG/LMStyYmh/i50hi6J53tMuxueRXjPVslGw1vY7TIgDMsseeds8YtTODK6ZIU
 aYX/QOawITFyPxUbpdMfUsj7YAhV1H84NG7WhHv6sc9lAOablCEgZVK1zYNjKdguz1pC4dNxx+F
 GjzCefvTR0FsN32GNO/Cu5boiIuvnG4MN5QAhoAU8+sNrpTbvWLpHdnPAWCzFbY46xDX8xHmphy
 y12wlCXppbfH0hPXwihDIlVsopdrypllrYVrdLQkb0eQNQ0aWNzNvUQxAIxiQv+gG5PjstjUgVT
 YI/cMG2Rb6+TEuC8q9kMT1q0a2nzyleHwOKetTUGKrIxMul+Z4tntQBI2qPNnqjMgFKGvy6nf3s
 RRqEDXLJiyPX3ski76FvsMOi+ztgwviGuKPEaEb/3rfa/EXKiou97xbEsXfru0EUEgIY2sPwPbO
 OhhkBDO2Enn55G0hAqr0OMN6u6aVh6kIbN9fgQ104s545pDVv1lGpAW8TiAIKWbS9bR7JEDrNnD
 Kia8HEIMxOlneUaKRNLtFnvpnB/iDTm9+0gB2TRzCCGdzdSbe6vnLvgg7WpfYMam9jbSgikK5Wy
 LmNZOYSh+JDxO+jSA5YHILcyA6RCDyN5fqWCpMwafB6mh/OwTkfmJdr4ya6Z9+kQC7jp/jPc/mr
 71yALOg==
X-Received: by 2002:a05:690e:14c4:b0:65c:5e34:7343 with SMTP id
 956f58d0204a3-65e2283524fmr13877220d50.44.1779093480727; Mon, 18 May 2026
 01:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260514171649.3708107-1-aswin.murugan@oss.qualcomm.com>
 <CAC_iWj+bgFhPbxNH-BqU1fFD0j3wzBE_9FT_kfhZ-r48Ztb7pQ@mail.gmail.com>
 <da733868-79d2-4425-acd1-f1a9ce83feba@oss.qualcomm.com>
In-Reply-To: <da733868-79d2-4425-acd1-f1a9ce83feba@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 18 May 2026 11:37:24 +0300
X-Gm-Features: AVHnY4Ik4m3PhhPOcoDP7iGlhIUay6eCQhUO37Fqz2rcjyTHZPgstfw1txg05QY
Message-ID: <CAC_iWjK+VL=OCeN+4ZufQMyKv7su+JQ-gic7YMSnt-Ci6xZh-A@mail.gmail.com>
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

On Fri, 15 May 2026 at 16:17, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> Hi Ilias,
>
> This change has been verified locally with our setups on qcs615 &
> QCS9100 SOCs

Ok I am getting the same error here. How did you produce the final binary?

The only test I am doing here is enable secure boot and variable
preseed. The generate the preseed with

./tools/efivar.py set -i ubootefi.var -n pk  -d PK.esl  -t file
./tools/efivar.py set -i ubootefi.var -n kek -d KEK.esl -t file
./tools/efivar.py set -i ubootefi.var -n db  -d db.esl  -t file
./tools/efivar.py set -i ubootefi.var -n dbx -d dbx.esl -t file

Thanks
/Ilias
>
> Regards,
> Aswin
>
> On 5/15/2026 4:02 PM, Ilias Apalodimas wrote:
> > Hi Ashwin,
> >
> > On Thu, 14 May 2026 at 20:17, Aswin Murugan
> > <aswin.murugan@oss.qualcomm.com> wrote:
> >> efivar.py currently stores authenticated variables including the
> >> EFI_VARIABLE_AUTHENTICATION_2 descriptor (timestamp + WIN_CERTIFICATE)
> >> along with the payload.
> >>
> >> When variables are set via U-Boot, SetVariable() validates and strips
> >> this authentication descriptor before persisting the variable data,
> >> resulting in only the payload being stored and returned by GetVariable().
> >>
> >> This mismatch causes efivar.py-generated stores to differ from U-Boot
> >> runtime behavior and leads to incorrect GetVariable() results.
> >>
> >> Update efivar.py to strip the authentication descriptor and store only
> >> the payload for authenticated variables, ensuring consistency with
> >> U-Boot behavior and compliance with UEFI expectations.
> > The approach is fine, but when I use the tool now to create signatures
> > and enable secure boot I am getting
> > => bootefi bootmgr
> > Getting signature database(db) failed"
> >
> > Have you tried a built that worked locally?
> >
> > Thanks
> > /Ilias
> >> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> >> ---
> >> Changes in v3:
> >> - Previously stripped the authentication descriptor at GetVariable(),
> >>    now moved to strip it in efivar.py during variable pre-seeding/set.
> >> Link to v2: https://lore.kernel.org/u-boot/20260512194205.1905069-1-aswin.murugan@oss.qualcomm.com/
> >>
> >> Changes in v2:
> >> - Enhanced commit message with explicit UEFI spec reference
> >> Link to v1: https://lore.kernel.org/u-boot/20250725123653.513252-1-aswin.murugan@oss.qualcomm.com/
> >> ---
> >>   tools/efivar.py | 50 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 49 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/efivar.py b/tools/efivar.py
> >> index 67729fa8505..d248cd868ba 100755
> >> --- a/tools/efivar.py
> >> +++ b/tools/efivar.py
> >> @@ -79,6 +79,50 @@ class EfiVariable:
> >>   def calc_crc32(buf):
> >>       return zlib.crc32(buf) & 0xffffffff
> >>
> >> +def strip_auth_descriptor(data, attrs):
> >> +    """
> >> +    Strip the EFI auth descriptor from authenticated variable data.
> >> +
> >> +    This is used during efivar.py-based pre-seeding of ubootefi.var to
> >> +    match U-Boot SetVariable() behavior, where the authentication header
> >> +    is consumed during validation and only the payload is stored.
> >> +
> >> +    For variables with EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS:
> >> +    - Input format: [EFI_VARIABLE_AUTHENTICATION_2 | payload]
> >> +    - Stored format: [payload only]
> >> +
> >> +    Auth header size calculation (aligned with U-Boot efi_variable_authenticate()):
> >> +        auth_size = sizeof(EFI_TIME) + WIN_CERTIFICATE.dwLength
> >> +
> >> +    Only the payload portion is retained after stripping the header.
> >> +    """
> >> +    if not (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS):
> >> +        return data
> >> +    if not data:
> >> +        return data
> >> +
> >> +    efi = EfiStruct()
> >> +    if len(data) < efi.var_time_size:
> >> +        return data
> >> +
> >> +    offset = efi.var_time_size
> >> +    if len(data) < offset + efi.var_win_cert_size:
> >> +        return data
> >> +
> >> +    try:
> >> +        cert_hdr = struct.unpack_from(efi.var_win_cert_fmt, data, offset)
> >> +        dwLength = cert_hdr[0]
> >> +    except struct.error:
> >> +        return data
> >> +
> >> +    auth_size = efi.var_time_size + dwLength
> >> +    if auth_size <= 0 or auth_size > len(data):
> >> +        return data
> >> +
> >> +    if len(data) <= auth_size:
> >> +        return b''
> >> +    return data[auth_size:]
> >> +
> >>   class EfiVariableStore:
> >>       def __init__(self, infile):
> >>           self.infile = infile
> >> @@ -172,8 +216,12 @@ class EfiVariableStore:
> >>                   break
> >>               offs = loffs
> >>
> >> +        if data and (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS):
> >> +            data = strip_auth_descriptor(data, attrs)
> >> +            size = len(data) if data else 0
> >> +
> >>           tsec = int(time.time()) if attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS else 0
> >> -        nd = name.encode('utf_16_le') + b"\x00\x00" + data
> >> +        nd = name.encode('utf_16_le') + b"\x00\x00" + (data if data else b'')
> >>           # U-Boot variable format requires the name + data blob to be 8-byte aligned
> >>           pad = ((len(nd) + 7) & ~7) - len(nd)
> >>           nd += bytes([0] * pad)
> >> --
> >> 2.34.1
> >>
