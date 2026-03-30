Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD28AFF492D
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 01:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14DE78394E;
	Mon, 30 Mar 2026 03:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L9jLpZfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239BF83B48; Mon, 30 Mar 2026 03:49:47 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA3B8063E
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 03:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6618bc129acso5697445a12.2
 for <u-boot@lists.denx.de>; Sun, 29 Mar 2026 18:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774835384; cv=none;
 d=google.com; s=arc-20240605;
 b=bPF5eKe47/bqT7JppTHfNkCDgG00txopXc9wWqvlU+xmii8oJ6Gat3BEDSJF7zb14Q
 Vm6QzV5yDvrZdf5A3Z+xlo4Pm2Qxx/I91a8VoZxq/hreFdhTbTz+iChuC4YTzSidh4GB
 gl+KhKl04cpJ0MHb8xSrh0x0pixhwCg9aYxDeQ5DkidHy+kUZQxg+J22BF4H/EDkxoTh
 kRHmvPJ7G6FP0yME6uWtUXDzrNvh2Zux4Qojnz26XzdEXU/F8LmVBidyMfLB8HOP/lQq
 nV46+FnoL+aRHXe3mSuzUTZ0TxEdt4tDnhBqiypaG2CMALc9hEUCIRz6jQXkBw2b2JGQ
 mSuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LLYiRAlZWMjxqzi4vM+XpTyG1mQL14t3PdCu7F/LNsc=;
 fh=7FqrHHZ0L629h0TDQAGFOFxUMZzvTpP3UnKIBZgj4Go=;
 b=VEHXktDnjwxp9mS6Qjj3SF/62jVFkkjEY+UgRftYacRIWc0shWFA9J/TtmPWHpbacP
 vgL+SqRipIk6W0oB8fza1ajJ3LzxWcRS09KKcgOJqaOzwjEGK3FGBQXjTpf71Qo9ROmJ
 lnrC46J4JUB3hEgUlQnO/g1by19TcOFFm8cfefSkqfKGbIjRBOCk6kbrqm0r0dIH0VMX
 zHYFln4dRqYzLbLVQ1tPbjXf2azHbyuwkNIcoww+ATGGNVnA6XzKJCMj8OqP/WN/LNr3
 PbCpYsVkndQSOjLx8N+tv4PyJ1BV7VR63E4ZLJaUStlzcTW8+qyR+um/hq5U7JBFELb+
 Y6Bw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774835384; x=1775440184; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LLYiRAlZWMjxqzi4vM+XpTyG1mQL14t3PdCu7F/LNsc=;
 b=L9jLpZfnufJv+mZ/2fNMkVa+A0jlx3Jtg+9q/2Mp5G3VuRALImIvfq6HfRGfpi/vgU
 BgBPyyfC5dMQxG4XLlFJci75VLotrq2WCGHe76P3o07TNfWRbG8A0KZ3i5vNBulb5Ccj
 9znI9jeaSFidDdBgyRrlWtBrpueSZbvMF99tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774835384; x=1775440184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLYiRAlZWMjxqzi4vM+XpTyG1mQL14t3PdCu7F/LNsc=;
 b=qhxAlV0VFGXR8uMj0Haq1YUfeOhZOra7JndCPO3vvPn8kxMxE4ZTwBuRdMJVb1zLOB
 NAO2LU/HrA2rO2S5Jez9eAzc9H4HNpzNjXbc6KLlykRBQCUZ1N0ROxCCgALOQ+wFKIeY
 VPyEm6+szEopyqpe68w3+ywCvIlOwjJHZdxEOv9UzPh6/ttjJBiJYX1NMUKcuA6gZ57Y
 BQlZFdSN5BWYd6Ur8XR7Fy25SZCDB53sbvWIayvnH1Erqe0SCn3iEurQEZ00HCPvaG4q
 Lfz+S1U4K179gBu5zcarNaiY/8UwkUdPMYuCET5M/Gvqn3s8MSEf1UihoViornPdSihd
 A5tw==
X-Gm-Message-State: AOJu0Yyu/ei/6QI/NDLY/kmgG7D15ca8zg2XkJqKTNU7ir4/KpXCTk9y
 2sLam0uD7jx8NImusagt2vkJsngSDVJmtopWTa5NPSbMBlkQkHCxOKIUxsBgEehowvU15C/NzKH
 3qatnQQk+5p4MnlVWbSc7yjkXX09T/ifczU7W9DE1
X-Gm-Gg: ATEYQzxnWkmNvS/85ZIXvKktzR1M0E2gVvhv7/86eiVadgIpXjU/ZnO19cf0s8PiV8S
 duHwQ2LNrNLCNxprWuTbvMz4AslZ8BSmnIkfdmHJ6RG9KdQ9clCRWI0HLPUvNlydEWeUbnu5if7
 ci421Rv+15djLzxsKp/bXOA6ASUmrkRAxxO31FkjwofbLFmz5zTOxVbSd8+arAndqbT8ILUrQh8
 mVzplNKXEySAXRO7QY0Iw4NK8h4iJSkpUlgy0Qx2kSeqi/rnj4x4kEyeRnL43F5o00OFyi9ePHf
 SHLnswfD5N7Ewv7CIJd3fLyWXvluSs/J2t08mbm/V4YsLIIjJz8=
X-Received: by 2002:a17:907:a807:b0:b88:6309:c300 with SMTP id
 a640c23a62f3a-b9b5090a9d9mr595726566b.39.1774835384009; Sun, 29 Mar 2026
 18:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260321195238.174658-1-marex@nabladev.com>
 <CAFLszTjdv78kSfFwBXxGq=wxP7y-bc4O_8jDeVTtQFtLct4L4Q@mail.gmail.com>
 <9f5c1c47-410c-419c-b272-2a44a0e4a4d9@nabladev.com>
In-Reply-To: <9f5c1c47-410c-419c-b272-2a44a0e4a4d9@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 29 Mar 2026 21:49:32 -0400
X-Gm-Features: AQROBzAP2sY5CUnc7AxscnmGPsYLZkGXN_SBsxvmAOwIETq6FKvWg-T1l_vHZQA
Message-ID: <CAFLszThUT+YbHJLoXNBN73mZz_37jbOZ608xpnOmJNSVG5m-8Q@mail.gmail.com>
Subject: Re: [PATCH v3] binman: add CST backend selection for i.MX8M signing
To: Marek Vasut <marex@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Marek,

On Sun, 29 Mar 2026 at 08:25, Marek Vasut <marex@nabladev.com> wrote:
>
> On 3/29/26 2:09 PM, Simon Glass wrote:
> > Hi Marek,
> >
> > On Sat, 21 Mar 2026 at 13:52, Marek Vasut <marex@nabladev.com> wrote:
> >>
> >> Add support for setting the CST backend, both via DT property and
> >> CST_BACKEND environment variable. The CST currently supports two
> >> backends, 'ssl' and 'pkcs11', with 'ssl' being the default when
> >> CST tool is invoked without any -b parameter. Keep 'ssl' backend
> >> as the default, but explicitly pass it via the '-b' parameter,
> >> unless the user selects 'pkcs11' via either method.
> >>
> >> Signed-off-by: Marek Vasut <marex@nabladev.com>
> >> ---
> >> Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: u-boot@lists.denx.de
> >> ---
> >> V2: Fill in documentation for all used DT properties
> >> V3: Fill third copy of documentation into nxp_imx8mcst.py
> >> ---
> >>   doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 30
++++++++++++-------
> >>   tools/binman/entries.rst                      |  7 +++++
> >>   tools/binman/etype/nxp_imx8mcst.py            | 19 +++++++++++-
> >>   3 files changed, 44 insertions(+), 12 deletions(-)
> >>
> >
> > This is missing coverage for line 177 of nxp_imx8mcst.py:
> >
> >     cst_backend = "pkcs11"
> >
> > Please can you use (or mock) this feature in a test.
> I already invested a lot of effort into binman tests before in [PATCH]
> binman: Fill in most of the imx8mimage and imx8mcst tests and it went
> nowhere.
>
> Can you provide (an example of) such a test ?

Yes you created quite a few tests. Then I invested a lot of time to finish
it off[1] so that we are finnaly back up to 100%

Since you are adding a new feature your may need a test file with a
'nxp,cst-backend' set to 'pkcs11'

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=494765&state=*
