Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602F5CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:32:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADB15846AE;
	Fri, 15 May 2026 15:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BsiDUKfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50A62846B0; Fri, 15 May 2026 15:32:18 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 693D984676
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-651c5d525f6so12746861d50.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778851934; cv=none;
 d=google.com; s=arc-20240605;
 b=Ysv0Pm4cRl4dQnCuV/46bbYcSLE908UNE2bI5a9ks0lEdeZ9PFg2OYVYZ0kbu4qzJA
 YKDEXERtt4yl1lRwU7AaX35h+RY195akZm5Cf5W72isBLi/biqGtXcuD1yxCGhSXzDnP
 59HzfLjjR6aPeejdItmUv7+Bjseawm3gTeBEzfhzta/C8NuaTVRzvbpmd4JO4jj6ZMJe
 b0837z09G1KXwjcgPDV8ubCnHWIqyn4e6DOA+IAQ4jp9kvt4HdmHCRCQ20TF17j7KhD1
 Z3Y7ipFcylfnnQ7MR+nLwXrksEdMCQsWH8cskOLJZ6bRBDum6fhXE5mSPDL+7cnr8p68
 /4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QgmdGFUwT0GJwd0R/OZ14miwVx1kFzvHBXp4F+TcSIk=;
 fh=XQcPXIBq6g+2Cu6+r92qJcj6hBQjbhebzW8WfmtfBgE=;
 b=hC2dgIOEZBcH2wf8Q3PlxPcCRzetyUu/0ouocRmCnrRSlHVtm3U9vtNHp9LnaduBAo
 w3rqc0xtKpOYVAhbQPkTAdOgkaCnZ8QgIaiwbUN+WMeJnh39cYea5SFgYoCg1csAA9wj
 H/JdRZH1sREsqhLJj+NKlSQFOcQFdjgu/BmitiZRurfvzsUSlkN7oQolJWmBnQhZOthW
 jEecrdJf9lA3rs2DCQn7Gn8WuCpo8OrHQhjOJx07Ga6B5eEP/GV8gaEkBQLXDvB+ewWI
 PTcJ7w8VyP2NuiDKhajJmi8OpM/UK8tfWwJk6pQn2+S7oUL0I4tBRhJ0YUfGFP1bdFOq
 zKrw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778851934; x=1779456734; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QgmdGFUwT0GJwd0R/OZ14miwVx1kFzvHBXp4F+TcSIk=;
 b=BsiDUKfk1WDlXZQ0Amz3SVjbLd10nyYV6djx1+VPjG5zlmkqkJiy69VCq2D6TRULpK
 GtjRKfXDu/KxzAo4tpQHIGK+FPIKZCMUdfUz5Fjx9d7SIyPIZoYVM82R4Kawb2Upp4ms
 RonJw1sU1twFRrXQE22HleAj5K8njhxEJ6inX9WcF1K5OM9of6cATp1dAB04KymNthX7
 uT05qwApstFjBXYYZTWcD63AOppC760ohMc6U83t3z17oV3741Mi9CZT/Wt9fBIca5b1
 G34/MX/+WqMcyy/t1/Ur9H95XvALJIwRtJjFL1QAgPTB3EiLimKtKcyzxE/AH2M/ZMfH
 uguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778851934; x=1779456734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgmdGFUwT0GJwd0R/OZ14miwVx1kFzvHBXp4F+TcSIk=;
 b=F7qm+A+Jl5DQktCHWWWJaXpwUbeSzg8tk4eWSxINd1SPtK/LVCSYvC3kFXrZUqCrtP
 6WNYNvEj6uoh/ZYmDkie/1qbOvYYnDQYPviA8NDfdo8SbpnVgdA/fcl8TBU3nvlyz4jT
 zZBNGmwjK0Jhv6FDstXeOqeK+ltFOBp3r+fD1M2kOlv7h1lcEpL8pVqbsJxVu7owzptN
 U9nkQN4Fgz1uyyI2JIJQ7h89YPGvTf7U5S/Ejk78nCx2IqfwIfOvWfRaTzph927peuUj
 0ENTVo4yXns5qIoq7vENUTX0GGr+ASbWQoKgPcku7d2m6cYGojGQHUSDihAxTBGAxHLN
 JhqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tzbNgQXG9Xw7GBK2P9ExvX9Kd0gOpm2Q00leQPpawzVoLXDwOd/T3v0Yd5R7Zkg6mMIHewLI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+pAzEfqxLavNDdu7LN1w0pvmj+j4g6Y39SNBUaqVVn3Bw6zKr
 xvGvolmun37kvFfO1/4y9YajP6MZyo8qiKVz8UiklTvNIrdwFFblx4EPULlJQomAQk5l3cPSnZc
 gAc2mSs/cEWWR7VLTrGgZS8lOxGL9umKGjBwNv1hzq/IkYpIoS4/TokI=
X-Gm-Gg: Acq92OFOiTvuj7Irs0yBP2fgBJG/yfNoCmbPJ4jVDcwdS7KNdfB6xhXu74r/Sri3IH8
 6rNk7aKacm0u07/KK/IQgqAjyL+cYMCrR8qslXTfxqqdBn9Hgvn2WegIeDTFc7ysq19vkOTuJlX
 c9C1eNWfeqm3GuwYuqDsrY7XZEljORulP2frXNeW6zYBi93eLVkGTws/SbA7yHyrf15L1IkVDm+
 J3wx1LiWdsheQh7FCSr6W//VCheq9dlQ9ptl7yIxxNqaLWAFzr8EeTVeqRKqHnMRPjv+YscCXfJ
 day6IgkQmdEMUyN8VkKgM3lovFBGVTJ+2L/cG9ifqn1IoW+3F0l7l0fwjwLbQmQaUiGqno0wzjb
 yO9xXSz99wKWWn02yXhswIdiZ5weoPlFyC3FR2vezIjUyXdGqObq4yOH2q7QWtVf/qBmW2VrcLA
 tKsucbemwhU65m9o4RAcYzm5qGZMDqHRWNXnkD2/l1Luj2VUKw7rtKdnny46O3yD6bkoKxU8Dlt
 L4nYZC9243njO81Ftn0Idz1cnCqoiobynZZ+WcHNi6W7In0rkL6RitC2dlBBoLFn5IZh011zbv1
 1G6IWRFn+zo2Q15oy4kNMTDY2xRFIih3YO20KkPBEE35m2kYec3iLpGxx0XMf8ARTRBpceAkgPQ
 MHGNR
X-Received: by 2002:a53:ec12:0:b0:65c:6220:5fcf with SMTP id
 956f58d0204a3-65e228b53f5mr3240172d50.62.1778851933987; Fri, 15 May 2026
 06:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260514171649.3708107-1-aswin.murugan@oss.qualcomm.com>
 <CAC_iWj+bgFhPbxNH-BqU1fFD0j3wzBE_9FT_kfhZ-r48Ztb7pQ@mail.gmail.com>
 <da733868-79d2-4425-acd1-f1a9ce83feba@oss.qualcomm.com>
In-Reply-To: <da733868-79d2-4425-acd1-f1a9ce83feba@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 May 2026 16:31:37 +0300
X-Gm-Features: AVHnY4LZSGAaYMd9opQWuaN0e7SnZDv-vZlgrdbGzc829gTW9VJFedTp17mxQ44
Message-ID: <CAC_iWjJg=fGVUk2hVPH2=eo4JGYeRsOPhr0p94YxzmffKCMvRg@mail.gmail.com>
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

Alright, I'll have another look in case I missed something.

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
