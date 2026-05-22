Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CDACD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 23:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE4284878;
	Sat, 23 May 2026 01:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hTXk3fjY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dr4VWUqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B09A848B6; Sat, 23 May 2026 01:54:07 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C1D84659
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ricardo.salveti@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MIERbj3344505
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 23:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BnZRFS7bkXs6F6tNHoRlJfrlv1ovaFj5YrAq36fB+k0=; b=hTXk3fjYelbXFNFy
 +Z7QI4ltfl9x6tXp6zxLnqA/VFqJhgv/d0tBRlxYQ69Zjgr8bv0OuPg0Z1mqNgsr
 wPL9DGc2SMAdyCfnagGHAOPttR+pjR8f0i1B7WhshM2sJ8BU4K2UF2ajp3Q77lzh
 5MKECcFJa+huJ3R8zvEHQbGwVXK0PmZpPpPEVXH0NRA3qPTqb7b6B0tbK0khzXXJ
 i1tb7yEzLog2wtHq1QNVtcwqFX0oDEZFeMZYvIYAqi0hUrKSPgBKmSxNJHQ/9pX+
 XeYzg8u5+Uup670I2U5V1g47wok5tdNRQWcyI1I62g4/5ljQ7OqRTitfuzaowRhU
 2Ph9pw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eav87rvy9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 23:54:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b99eb06178so182614195ad.2
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 16:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779494041; cv=none;
 d=google.com; s=arc-20240605;
 b=b//pDiyNUxJlf7X91ly41hjRQL2yoRiWO2lhVHHgWB8AtAtNGADoXC6+VFazM7UwG4
 LlZQzLT5/oDXInHNSHqOa0WCcjtlDYNHCO6xOkUOK+l57yjr7oNGkw3sZqD92BtNFIjk
 kW/aSw0FIzF7o7VyE7lw754YgYfy6XsCNiqb2rGK5FpfvD2INpJ6nnBRMbi8JcqoM8dH
 lNCFkbcFyuQ69iT6aWUC3nVUjfqj+tf/XLna0XO1CiVhyM1fQptvMZE4/Zu/ZCUzpDdf
 QGyv6SJngfyYcKnPHf0iV2GQV0PoQ5MTI9ToTWf/aijajwHe47gEFatINqOfbjGCtO2V
 Iq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BnZRFS7bkXs6F6tNHoRlJfrlv1ovaFj5YrAq36fB+k0=;
 fh=3iNYg88dhW19GjVaCIU4619aPJN79/mDd+Kso3tHAOM=;
 b=B4/VHdT4hxQZgVG0VagOic0yBfIqizhVPeb+NfTc7fFi/ZoP1QKYPS+yD8dqR0Ac+u
 ONRhxE6/7xyf26u1vR8WSkXEuR3g7uddf06ul8bliRuyi/RFujqV3Chi4cAlQgUrUNjO
 /cuTelX7KVw0bMDOE8OhOn4CuiLT9yaSRqtoiHJXl6s7jdp8KC6shoI7RLG1CPUbxTct
 koKOYQzvsHvaMniBmzyEaOdff4AoYVaTPCRKQh3tpxxihEtTiFb7DGGwfDvFFx6sMkgc
 jIfZdDrZyUW2WmVE4VrtpApz+HOtqQYrX4hdo/cSZ/V7XRJsuixghuSRnF6mlD2L8ELp
 hcEA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779494041; x=1780098841; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BnZRFS7bkXs6F6tNHoRlJfrlv1ovaFj5YrAq36fB+k0=;
 b=dr4VWUqa1v8S+WTK370urc0qu+tEtABw1q63sOnhBHvi4LgEqSeZ4CJrevGiwnHt46
 CtZ9LHn90LwzolwBYpHP09V11ShYdHyj8I4fTvyYRbczD12+2/2DcTgMiPIada6OEAcj
 40is1kPqDMnnDNHr4Psix+aa/Kk5QHjMw83uPBKyvDTKQ7nWtf0dsmHJ5ksNKDit3hmS
 8R+nMBF2QZTA0ins5rB92Z189TQDaCnGN3AxfZpmosj2ogcV92njmyWZjqB0yy7/vzMz
 E7N9A8j8YA22OCX7TSNfgCm3PZDRyGrQXef4jUAwr4WxBtljBUNze8CRDHLZpCWv/LgR
 RPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779494041; x=1780098841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BnZRFS7bkXs6F6tNHoRlJfrlv1ovaFj5YrAq36fB+k0=;
 b=bdnfnXN1xD5AVb6vzFRYUugRY+qjFSsxhbDKx+mDghYC7Z8UHKU8RGn/GaBWJ9Qcbs
 f7v6PREI5NJ2HaASjgExDAivFED3XM07m3+dZoW+ZQ+j5WIGN4Y0jPFzXBk1+d9PdS+s
 QSxBwk4Sjd8xvI1Df5MKyPZJLd72OQPp4Tq4A56egAywj/Z+Qh5iTqAk+QQiIGZP8r+g
 IphXmn3LUX/aCDUbW1Rsxox0J/SX00fA+yvRx+fPZNYiBRM2Qk+sRqS07Zah/WNQnddp
 jFLqNdDnIFdoNGUVmEAd8d8VRxOnneNi264Y9A07onqP7UYYaTp6NoT3qAgY5cXERiFC
 ud1Q==
X-Gm-Message-State: AOJu0YyUS0SKmyonQUjSDGitBnQwTH3N6NMw4uq2w3fwjC0dB06WbKd8
 zEmOMcV4F4TDn5lt6qxTFZQhT+1MGHGAc2wa3RYAA9c9jNPBLuV/Mk4nbg8atmR1ZtOFONoogWA
 PlBCccWv8GX3V1mYTJikCoeSopuSDO2U26smKmPQpMmDEqY6B4NTNRvNdXRssLMFfeuQJLXEuLH
 wQsmZl9TWiBdgChv9nT8hojdneElH0MY8=
X-Gm-Gg: Acq92OEjSdv0pHne5o7079nTKWHRdK3t2kkGYM1E1mlxj0NmjvdiqyJipI4C1sPKFyh
 7q0ncY1hm5fDtIJhh62WWbeypCwktIQVWUGu4SzoNd7+f1+wPHyiOcyQW11JRipD9Ro8nYFyHvC
 9XXKHtvzLTMlyNi+/1Z/NUHMke0TS6+pILbV0R0X7KcrezFKp4bZ+vzEc1YiUpKFAVlAaZigooq
 1bW
X-Received: by 2002:a17:903:2284:b0:2bd:412:21fb with SMTP id
 d9443c01a7336-2beb033eeeamr64024895ad.8.1779494040496; 
 Fri, 22 May 2026 16:54:00 -0700 (PDT)
X-Received: by 2002:a17:903:2284:b0:2bd:412:21fb with SMTP id
 d9443c01a7336-2beb033eeeamr64024575ad.8.1779494039921; Fri, 22 May 2026
 16:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
 <ae4eec1e-1c5b-42d3-a26f-3911b1a2839d@linaro.org>
 <CAA_5yov+8_G2FUQ-QrKBtykt_vwZPdU-KGEzzmguYBJsUveqeQ@mail.gmail.com>
 <e13fe55d-1f43-4c07-a92a-045b0db9cf38@linaro.org>
 <CAA_5yosVpB6L6yN8gBAnMmxV7uSNjvyKtxeBV7ELGF+z18aibw@mail.gmail.com>
 <7b61004a-6166-4566-869b-7157e5563ff3@linaro.org>
 <CAA_5yova4YXN5GssCtZ-dYd94K9Ms6yqkA7zZepbtK0OxsW-3A@mail.gmail.com>
 <504b47b9-c43d-408c-aaa9-4979e3b1b7b1@linaro.org>
In-Reply-To: <504b47b9-c43d-408c-aaa9-4979e3b1b7b1@linaro.org>
From: "Ricardo de Araujo (Salveti)" <ricardo.salveti@oss.qualcomm.com>
Date: Fri, 22 May 2026 20:53:22 -0300
X-Gm-Features: AVHnY4IZC7wkgH7MJWgbrhFqRwGdJhkBsSBp8yfLAAbnNYJ2rtOzJma3O9EPknU
Message-ID: <CAA_5yosvLR7Dm90_xGVHeSiPQ4=uMpMpg2uoJrJJf9MO6C-vZg@mail.gmail.com>
Subject: Re: [PATCH] board/qualcomm: use bootflow for default boot
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, sumit.garg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzOSBTYWx0ZWRfX2kKLAgh907B5
 Jl72/KA4OB4Mn3Yr/gXS0paT+XM6u3u0rXI4h4vVuqQSxHphDNsSvfOLU1NgD5OHTTBiXq280ii
 3i/f6RNTCDZmLb9PUSamFOJ5BXnDyLVq1sD1YiGsS8TeMipodfwHLLZEeP7M5rzqIxRnbV4HSLl
 2tdikKLCZR/rKZ0agvXPhsc3WpITGq61pT2p1dkSB18XqogSV8foJb1porUSrjmbW7PT3Sb+dXH
 WQQbugD7wwODTg3CuOpd3xMbDinOCpYmJnEJqNHHCS8rOW/Y0vMxd6QQ9W1YyUfLb4iPeDd8dZ6
 OiJZd92ZfFIIaANPIBkh7tl//n9tfeLzNbJWQpeunmWweaVQNpeFaJ4iPqjUyltNm+xyD0PcZ6w
 KTMm7IBw1grFj+RnjPDbLKGz55ukla4yORJJRLKphuJSyHQrtScF1ldvMyFkDzIJ6zyEQqqmd2G
 gt1noqVBdAjYQan+L8Q==
X-Authority-Analysis: v=2.4 cv=dbiwG3Xe c=1 sm=1 tr=0 ts=6a10ec99 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8 a=54owO1CYifvxDnEu4pwA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: DeLtll7_CreUcBNqmUX9UzAwH81XX27l
X-Proofpoint-ORIG-GUID: DeLtll7_CreUcBNqmUX9UzAwH81XX27l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220239
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

On Fri, May 22, 2026 at 10:10=E2=80=AFAM Casey Connolly
<casey.connolly@linaro.org> wrote:
> On 21/05/2026 19:07, Ricardo de Araujo (Salveti) wrote:
> > On Thu, May 21, 2026 at 12:32=E2=80=AFPM Casey Connolly
> > <casey.connolly@linaro.org> wrote:
> >> I'd also strongly recommend against bootflow, you can just chain
> >> commands together "bootefi bootmgr; bootm ..." to implement fallbacks.
> >
> > Would it be fine to change the patch to add bootflow after "bootefi
> > bootmgr" then?
>
> If anything I'd rather disable bootflow entirely by default. How do you
> actually load the FIT image to boot? Is it combined with extlinux?

You can load with extlinux or via a boot script (often the preferred
option as you can add boot specific logic to it to support a/b
selection and so on).

> >>> I agree that EFI is more suitable for generic distributions, but we
> >>> expect that some embedded products will leverage FIT directly, and
> >>> disable EFI entirely (e.g. faster boot, reduced complexity, etc).
> >>
> >> I'd expect those products to fork U-Boot already and/or send specific
> >> support for their board configuration upstream.
> >
> > They will probably all reuse qcom_defconfig, which uses
> > board/qualcomm/default.env, and that is why I wanted to have bootflow
> > available there by default.
>
> Do you have a list of boards? I don't think any of the Dragonwing boards
> use qcom_defconfig currently, maybe they #include it?

Yeah, it is included directly at the moment:

configs/qcm6490_defconfig:#include "qcom_defconfig"
configs/qcom_qcs8300_defconfig:#include "qcom_defconfig"
configs/qcom_qcs615_defconfig:#include "qcom_defconfig"
configs/qcom_qcs9100_defconfig:#include "qcom_defconfig"

> they also will
> need CONFIG_QCOM_GENERATE_MBN once the MBN support is merged, so even if
> we can get it down to a single config for all of them (which would be
> awesome!) I don't think it should be qcom_defconfig. The need for
> supporting non-EFI boot methods is additional justification for that.

The board level config can contain whatever that is specific for them
at that point (e.g. mbn header version), now the boot mechanics would
probably be more generic.

> >>> Since FIT is already widely known and used in u-boot, I think it is
> >>> good to also support it by default here.
> >>
> >> Appeals to popularity go directly against the point from my last email=
,
> >> booting without EFI might be justified for your product but that doesn=
't
> >> mean the /reference/ Qualcomm env in upstream U-Boot should support it=
.
> >>
> >> The reference env upstream is there primarily for testing.
> >
> > I would say this is more a personal preference, my thinking was having
> > both enabled and available by default to facilitate the life of every
> > developer/user.
>
> The community devs over in the #u-boot-qcom IRC channel are also focused
> on EFI as far as I'm aware. To a large degree yes it's personal
> preference, when there are no technical reasons justifying a change then
> that's typically what it boils down to.
>
> I'm strongly in favour of having Qualcomms dev boards be well supported
> upstream to the point where there's no need to have a fork and users can
> just run upstream, I'm very glad that ya'll are working towards that
> goal. I'm also glad that there has been communication and discussion
> about how to architecture some parts of this so that it can land
> upstream and you don't have to make breaking changes later.
>
> I think part of what we're running up against here is that
> qcom_defconfig and the default environment don't really have a defined
> scope with regards to what platforms and configurations are supported.
> I'll share my thoughts here and maybe we can build on that?
>
> To me it should be a maximally compatible baseline *horizontally* that
> runs on as many platforms as possible with as many universal features as
> possible (e.g. capsule updates, fastboot, usb, networking...) while
> being minimally *deep*.
>
> So the image it creates requires different post-processing for every
> different platform/board (be that building an Android boot image or
> baking it into an MBN). The image can boot with EFI and gets you to a
> working system but it won't handle PXE boot or expose a UI that can be
> navigated with volume keys on a phone. It doesn't support every
> filesystem or have secureboot, and so on.
>
> If you want additional features to support a specific board or usecase
> more deeply (like emitting .mbn files directly, booting in a
> non-standard way, storing the u-boot env on a partition) then you have
> to make some changes to the build configuration.
>
> Attempting to enable/use bootflow in the most generic qcom_defconfig
> might improve things for the platforms/configurations you care about but
> it's also a level of vertical integration that does have an impact on
> other platforms that use the same configuration.
>
> To pick an arbitrary example, bootflow has an "Android" boot method,
> it's quite possible that on some dev boards or phones U-Boot might then
> attempt to boot Android from one of the boot partitions, this could
> result in the device booting to a broken state, infinitely booting
> U-Boot (if it's chainloaded), crashing, crashlooping, maybe U-Boot tries
> to update the slot status and touches something on the misc partition
> that makes ABL crashloop and potentially hard bricks a phone (since many
> vendors don't provide signed firehose or even a way to access EDL) so
> someones perfectly fine device becomes landfill.

While that is possible, it depends on the boot methods that are
enabled by default in the config, and from my perspective it is ok to
assume that it should try all the boot methods which are enabled.
Currently we do have several methods enabled (by default), but they
are not leveraged by the default boot command and environment.

The methods I have with standard qcm6490_defconfig:

  - CONFIG_BOOTMETH_EXTLINUX=3Dy
  - CONFIG_BOOTMETH_SCRIPT=3Dy
  - CONFIG_BOOTMETH_EFILOADER=3Dy
  - CONFIG_BOOTMETH_EFI_BOOTMGR=3Dy
  - CONFIG_BOOTMETH_EXTLINUX_PXE=3Dy

So if we enable bootflow by default (could as well be the second
option after trying efi boot), the behavior will depend on the methods
that are enabled, and we can disable options that are not necessarily
known to work.

> I don't know how likely any of those outcomes are, but given how
> crash-heavy all of the non-EFI boot paths are I'd really rather not
> tempt fate.
>
> Hence, I'd feel much more comfortable if we all worked to minimise
> unnecessary scope, having board/usecase specific configurations is
> absolutely the best way to do that and as a bonus make it much easier to
> justify a lot of quality of life improvements that only make sense in
> specific cases.
>
> That's why I would much rather see a dragonwing defconfig and default
> environment where we don't have to worry about some change breaking
> someone else with a completely different setup.

Having a dedicated default configuration for dragonwind should be
perfectly fine (and included by the dragonwing targets by default), as
we can probably assume that u-boot would be supported natively instead
of chainloaded.

If you are OK with that I can send another set to create a specific
dragonwind configuration file that could support a wider range of use
cases by default.

Thanks,

Ricardo
