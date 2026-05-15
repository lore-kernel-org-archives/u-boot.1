Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374BBCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 07:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78F06838BB;
	Fri, 15 May 2026 09:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fx1poNrr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6611F839D9; Fri, 15 May 2026 09:55:23 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB292836AC
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 09:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65c6a2158d3so8062929d50.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 00:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778831719; cv=none;
 d=google.com; s=arc-20240605;
 b=Rx62cr5XYqnE+QHHVigT8LYK75CH0dsyf+D2s/3g0PPWKzK0sDcxr9oVfrom49J+D+
 8MCHggGNzFTqfbD4QCBb8jU3Gs2HYgssJd+6l29zANihMNjZTgs7vB9kcJLewUvEGfJs
 Wa8UtEIlHfJEWtN0b5c3GGI+r1bslBhHi8jR7H63ENAj0V20ibMisEGM7zgWOi1oc3lp
 Tq04r55Ki1LyS0Hduu16eB2ebiq07HHiQc9h2RMPlbOTArOzqaY/uV0c1QvaFgVxaymv
 HJkJn+k+QNG5WBrGXGEQYSRCQ4gyeaIJzo9bcZcY/y1fC9vOQnVnrhnkzz84OXcD0rTs
 ovMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5pmLU8idu5+hp5gpHca73YcXZxm6GsKm6nwfrZumJ1Q=;
 fh=uiOctrBsTSP6GdwtsEeyjhqVSvjAhNsx7ssKaqTmgiE=;
 b=GuONNlQNeGmexF3aVIptMyyyMiXHjEDnzoz5eO58egQQ2tmbaA367fq+lIEcFAVeON
 6Nwr6RIO0nhBuNZxfFuSHUOm/wuyUk6ee5rbdJyNIG6K/CqaIveo13mCix2qJ7hga0ko
 kk+TpcTbm2tQbl6UEBNht8e22i4VeiJLDqgmFtpZmNyosb+YMqfibzzi222MxgV4LNxG
 xwJqH0fyDn63teh09WAfk8dYFWwcc1wm/g/AUcZ+Zd5IqES2+7nWI+TEnukF7RyDB8XR
 dHtGQc34jLiO3uxGUmb13cuWt41e+XQpy64tQTsgswQEpin7wYTC1YZ9D5qMyLCAyrWX
 /n/A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778831719; x=1779436519; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pmLU8idu5+hp5gpHca73YcXZxm6GsKm6nwfrZumJ1Q=;
 b=Fx1poNrrq1Hqi6qhznfw8+t7XzZ6x9QhNIr2h503vAfdql6kLCunDbPo9lbLdlKXVf
 WHVosNeIDZEDhKf/SVMQzW26pEN1MPv9Lmkd2aE8RSdPNzN9V+pshO0KeyAYwhyQnqku
 NWAhvKmMJE9pbozc59JRJNRKoFB4v76kv+/ypVWH+ttmVUIiPXz4blpkZ2WQj7+z3gJN
 ZFdSWyx4AtIA77suo35jUdK+x6YdYQqJkp5RP7qfms46bk17goT6qiQrCO/OTVf6l7bk
 YIqIRy495DSvV7vv9FECsywxamLah22B0XPE4Spi4iaVEH+Pmtw/OUxlDvKe30TWrnGo
 luZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778831719; x=1779436519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5pmLU8idu5+hp5gpHca73YcXZxm6GsKm6nwfrZumJ1Q=;
 b=qgma6MuzwtSNsX0umfZD/ybDPMRJYZnZB2NEa99OPFi0xKxgWGe3Kkc7JFdDZ4iLt2
 IYM/IkJvVilR/sH06tIjpsgLIgWXOubOOb+nr1vPvnLNLpShzbwJsJ12Z38W2f3+2vBm
 ysc1MvTq03hsFG2jq3aEQNOl3sjK9vBmeOAPcnfsPNkvr3q8rlNIoILjRrgQa/hVEvSP
 yM6yWo2Nekd7Fc0EMBp84pwvoJcT4PnouEN7FLPWwXu0J4hJRjxJ1r6LmskDEClfTM5W
 a3TD95lo3Nt8VpGzyhRnfgzXXm1wLbDT134CZWWyo0s1TJI6131nONpu0u8KFcBbA/7p
 amEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ949WrUOmHk2y0+btXHRM3cx25kiMtgkYq2eiktzOy6MSvVwPVH4N+vE7VItPeJ4lZemxne9jc=@lists.denx.de
X-Gm-Message-State: AOJu0YwoOMWTlWQJMWBTj1Q21wl1rpLrOJddNedBjzGFTfC5Yned8/Yq
 02T2JJTBf1U+u44lLL1lOrNsyjfPIeycQ+GCbIH/l+zXZFNb4Ck6wuo/asMVYUdwrtSDtxy5nXY
 3IbhOuMZrk4mdpsrRZCziZd5VWQR5mZnHyuD/zvhAD+FF6/hByGHd
X-Gm-Gg: Acq92OFaG4oTqTD6rU2Ya0fPzrdcLXS4x5f6YEY1mMQTAf4ThwHHuYBO1x5IDdfHrJW
 Mpftgydzqb1R+3OWbsZ393OJPUfdeWAZp91WxyD+xX5H12i5UhWd2pyb9v49IDo07mssW9Scmxj
 9GpKUc4+iH2MMVWFHdIarz4PshGZ3oyOA9oQkTCKpMdie3KSxC2RfCaypbdxYXVsRxq5ik0n3/Q
 ZErqm7VBtbfqkhniorknjObIgyhEb50ITYz8/nbL5XFYJgPCyZbJWMgSyfaR7GS1p+NYKA0DyMW
 uCNKy1+SSRxTPsPjVfiaD0VHX3jktr75cf3PdgeLbuTQNpmxdd7xs2I+/WNbjYlRg3JcvjtfdZ8
 QWpo4h8NGgn07PSFTXtT/LA8mh2/3Hqo5X6mv0tY+7m+8DZ+1k9G/AtDIyZ/tZB3zS1Mlk5I+St
 Sbm9SMZf1Jaj0qS9XdL7po598v9El1nt1JYp8SxvNRXQ/LTnQ2Yfv/6HqYm/U7wmtHWYz1Z4B4v
 QVLNA3PWhcRYVU33uwL5QBG7iHYpvNZ2m34hHoN70W0GXDiW+524HkCL0XezhOmEa4HLZBuhTTc
 oK17fvCx1e3dyvoV9Gt/gx0X+sGUUzio/Y1K8Q4APY5vUZhFKXetcpX8g0X3xNZ38RyF/kmIcWJ
 rGbmlxQ==
X-Received: by 2002:a05:690e:4812:b0:651:b604:6b66 with SMTP id
 956f58d0204a3-65e228fad1dmr2138313d50.65.1778831719523; Fri, 15 May 2026
 00:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260512194205.1905069-1-aswin.murugan@oss.qualcomm.com>
 <CAC_iWj+tD8eOKxem3m94BWX42GTLuCD7tqEW0GUdtsPLpLcYqw@mail.gmail.com>
 <12a09e02-3093-47a6-850b-3be4e63b1ccb@oss.qualcomm.com>
In-Reply-To: <12a09e02-3093-47a6-850b-3be4e63b1ccb@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 May 2026 10:54:41 +0300
X-Gm-Features: AVHnY4LltX_0XnmH9-wFufZ57izmZ5TrRa0uML6piChuehMmJvgcsw2CEscfWDI
Message-ID: <CAC_iWjLCfS73BFpKv_qRTHOGa=vNN22b8cotEu+8H5qbWPLT=g@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: Remove authentication header in
 GetVariable()
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, michal.simek@amd.com, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ashwin

On Thu, 14 May 2026 at 14:01, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> Hi Ilias,
>
> We are attempting to pre-seed ubootefi.var created using the *efivar.py*
> tool for authenticated EFI variables.
> Currently, efivar.py writes variables including the full authentication
> descriptor (timestamp + WIN_CERTIFICATE + payload) into ubootefi.var.
>
> As per the CI tests shared, it stores the authenticated EFI variables
> using setenv
> When authenticated variables are set via U=E2=80=91Boot using setenv -e -=
at, the
> flow goes through SetVariable(), where the firmware:
>
>   * parses and validates the authentication descriptor
>   * removes the authentication header
>   * stores only the variable payload
>
>
> Due to this mismatch, variables created with efivar.py differ from those
> created via U=E2=80=91Boot:
>
> GetVariable() returns descriptor + payload instead of payload-only, this
> leads to inconsistent and non=E2=80=91compliant variable behavior
>
> Fix Proposed:
>
> Strip the authentication descriptor within efivar.py during variable
> write, so that only the payload is stored in ubootefi.var, matching
> U=E2=80=91Boot SetVariable() behavior. Please confirm if there are any co=
ncerns
> with this approach.

Yes, that's what I was trying to figure out on your setup

Cheers
/Ilias
>
> Regards,
> Aswin
>
> On 5/13/2026 11:54 AM, Ilias Apalodimas wrote:
> > Hi Aswin,
> >
> > On Tue, 12 May 2026 at 22:42, Aswin Murugan
> > <aswin.murugan@oss.qualcomm.com> wrote:
> >> Currently, efi_get_variable_mem() returns the raw stored format for
> >> authenticated variables, which includes the EFI_VARIABLE_AUTHENTICATIO=
N_2
> >> descriptor . This causes image authentication failures when reading
> >> secure boot variables as callers receive wrong data containing
> >> authentication headers instead of the actual variable payload.
> > What are 'the callers'? The EFI security related variables are usually
> > read and consumed by the firmware itself during secure boot. I don't
> > remember the code on top of my head, but i think we end up storing the
> > auth info because it also contains timestamps etc.
> >
> >> The UEFI Specification Section 8.2.6(EFI_VARIABLE_AUTHENTICATION_2 des=
criptor)
> >> explicitly states:
> >> "The authentication descriptor is not part of the variable data and is
> >> not returned by subsequent calls to GetVariable()."
> > We can strip the headers during GetVariable, but you need more changes
> > apart from the one here. The EFI secure boot tests fail with the
> > change above [1].
> >
> >> This patch implements spec-compliant behavior by detecting variables w=
ith
> >> the EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS attribute and
> >> stripping the authentication descriptor before returning data to calle=
rs.
> > [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/300=
86
> >
> > Regards
> > /Ilias
> >> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> >> ---
> >> Changes in v2:
> >> - Enhanced commit message with explicit UEFI spec reference
> >> Link to v1: https://lore.kernel.org/u-boot/20250725123653.513252-1-asw=
in.murugan@oss.qualcomm.com/
> >> ---
> >>   lib/efi_loader/efi_var_mem.c | 44 +++++++++++++++++++++++++++++-----=
--
> >>   1 file changed, 36 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem=
.c
> >> index 8d5f99f4870..edf4522e51f 100644
> >> --- a/lib/efi_loader/efi_var_mem.c
> >> +++ b/lib/efi_loader/efi_var_mem.c
> >> @@ -336,9 +336,10 @@ efi_get_variable_mem(const u16 *variable_name, co=
nst efi_guid_t *vendor,
> >>                       u32 *attributes, efi_uintn_t *data_size, void *d=
ata,
> >>                       u64 *timep, u32 mask)
> >>   {
> >> -       efi_uintn_t old_size;
> >> +       efi_uintn_t old_size, var_data_size;
> >>          struct efi_var_entry *var;
> >>          u16 *pdata;
> >> +       void *var_data;
> >>
> >>          if (!variable_name || !vendor || !data_size)
> >>                  return EFI_INVALID_PARAMETER;
> >> @@ -362,19 +363,46 @@ efi_get_variable_mem(const u16 *variable_name, c=
onst efi_guid_t *vendor,
> >>          if (!u16_strcmp(variable_name, vtf))
> >>                  return efi_var_collect_mem(data, data_size, EFI_VARIA=
BLE_NON_VOLATILE);
> >>
> >> +       for (pdata =3D var->name; *pdata; ++pdata)
> >> +               ;
> >> +       ++pdata;
> >> +
> >> +       var_data =3D (void *)pdata;
> >> +       var_data_size =3D var->length;
> >> +
> >> +       /* Handle EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS *=
/
> >> +       if (var->attr & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_AC=
CESS) {
> >> +               if (var_data_size > sizeof(struct efi_time)) {
> >> +                       struct efi_time *timestamp;
> >> +                       struct win_certificate_uefi_guid *cert;
> >> +                       efi_uintn_t auth_size;
> >> +
> >> +                       timestamp =3D (struct efi_time *)var_data;
> >> +                       cert =3D (struct win_certificate_uefi_guid *)(=
timestamp + 1);
> >> +                       auth_size =3D sizeof(struct efi_time) + cert->=
hdr.dwLength;
> >> +                       if (var_data_size > auth_size) {
> >> +                               var_data =3D (u8 *)var_data + auth_siz=
e;
> >> +                               var_data_size -=3D auth_size;
> >> +                       }
> >> +               }
> >> +       }
> >> +       /*
> >> +        * EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS type is old & not
> >> +        * expected for auth variables
> >> +        */
> >> +       else if (var->attr & EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS)
> >> +               return EFI_INVALID_PARAMETER;
> >> +
> >>          old_size =3D *data_size;
> >> -       *data_size =3D var->length;
> >> -       if (old_size < var->length)
> >> +       *data_size =3D var_data_size;
> >> +
> >> +       if (old_size < var_data_size)
> >>                  return EFI_BUFFER_TOO_SMALL;
> >>
> >>          if (!data)
> >>                  return EFI_INVALID_PARAMETER;
> >>
> >> -       for (pdata =3D var->name; *pdata; ++pdata)
> >> -               ;
> >> -       ++pdata;
> >> -
> >> -       efi_memcpy_runtime(data, pdata, var->length);
> >> +       efi_memcpy_runtime(data, var_data, var_data_size);
> >>
> >>          return EFI_SUCCESS;
> >>   }
> >> --
> >> 2.34.1
> >>
