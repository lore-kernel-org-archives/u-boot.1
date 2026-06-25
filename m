Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36C7CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 12:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F50684949;
	Thu, 25 Jun 2026 14:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cVSAcnHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A62B7847C8; Thu, 25 Jun 2026 09:15:14 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F66080398
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 09:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjm2473@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-8dfd7b11e1eso16060846d6.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 00:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782371711; cv=none;
 d=google.com; s=arc-20260327;
 b=MtlPWLKSOT/BcNLN/mnnND/StsCCeaE84q6lfttwv7Bz3SKJcczE0IAkI3boroXBAg
 NdeIAL1MIZQrYpLUvP8LK983ZcgsEopP6ciHkWcXJNCScVKNCp9SYKpESky9pCBj+H2Q
 ZcbeyBKqSuM1HQc5KtH8sDRNcDuOOpNDwE7iGW83OqjOoYSSDu+IpVFYxMiTHExqKRZZ
 a806USmlzI/Bvr+Iv+Oe9gcMWbdZl0y+HRXfTh+y4Z7QMJq1qtiPkGMu+j1T6H9GWNq2
 X/eErib/F7+oALFBRCIxTJeTl4x5jKvOghDgULystszRYE339NcFsLLNBG1EzRhXExuS
 Mi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VP5VOUtQ5mGcxIyT3R30YnLtLzT5lWtTVn087XmEBNY=;
 fh=x73HISMD02Ddlm4UL9P4qFt+bKnpXc6gYNbl/Hv7Q+Q=;
 b=HXWTL25S7QGggCLFa24leYnPu2v86EQLbUMZEvwg5hMYRd+TQZYpexFTf7IQsaJ91K
 +2bQa1AGz5RYI5ecCXk80J4uz7amsV1+vYVBMruPDwUCOMmKOICJhLEaLrcR+Ft19qCF
 u2zA7mi68PIAknmdf0Cxux76Qk7AaU+avENw3vfeQWZy72qciOTDxWcwrVfLD27QEQVS
 eW9j9cRnuavFy80hRf4Y/DFqWN3/ODDetAgKwxXKdQxtNvTlrU7uXq6zV7zM5EFutxIy
 E1cp8oCIOCsFQyLAT9o8NBJEEjTx/b4P9KRFrFeu41pqPWgpcjzu9up2sVLvuKzc2ciS
 ugHA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782371711; x=1782976511; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VP5VOUtQ5mGcxIyT3R30YnLtLzT5lWtTVn087XmEBNY=;
 b=cVSAcnHAQ8pAnxRl8J1rlndSk3tfCUf03zh9GP2Pd3UyZi4Y6bHwoLLP7+2dhT4Nyf
 hKb8zLf97IlH9WA5G2Q+bEpi5YyWGhA2l7q2XYeBib7gsIz5szLSe/YKDvIGvCfp1XyA
 tWw8ACf9iVZyj0x7w7xD8J6a9662AMiyOu0ODH4pKIzmAp/YYZ88hwn5xeXzC0PziNkq
 YceIOq3NbHBeZhA7UgdTIUEyMoqrWtOxkUZcjJswT7xXOvt2h+/O2WSerj0XyTnTBqE5
 xf2vr/5xloP34JBKEY5QylL6L3Ml53K4InIYjfon5NeMnZpJeAAH70Ap1pmSY0+TySLK
 d/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782371711; x=1782976511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VP5VOUtQ5mGcxIyT3R30YnLtLzT5lWtTVn087XmEBNY=;
 b=MQZZt0YkDqacvwWk2wUkxtEoMnWwCA5kH3Hat5no5c62EPXPt2/QRy0korJvfW8pDU
 ieFavAYR0xd9dEqKGm0UYIuKNbvuqp5rSnqs/k2E4trNq3oNPYmhQOlk2GVm2G5pZHe6
 RhOAsBxk22wspklF1BRSqMK32yoQwV8Tc+Le02SAaw6p4tRTL+VRq84xeh9N26b0ylSU
 P/2N29yuRTVJ9/OL/zph0D55qKxkb1BVHnlP0Bqg8AKbcR/HEhjZ/7afZWi7HH2Tr9Mr
 r81t7kZamrX0FXCq2R3XrgK12iBlcxlTGZSi0rgMHXbr8HLtFSAYHoNMrYvdni87PilQ
 g1GQ==
X-Gm-Message-State: AOJu0YzAeT8lO2J/5YBrpEfA1JTKerZiXz6lWF52I4RzEXYC8EIY/xhx
 bc45MRaUjpAT0BHda9ijJHRS7g+0tga3HypGQPQLtN5O+vr7o7VSQV55792NUbfdgEjozzIlido
 AMuo/FJuxjz1SFUmvWA7nwtd7AgyJdoo=
X-Gm-Gg: AfdE7cnaJ+7wzxCgsDHbuYrAZTtcFnbeHqHEjvF0Jpp2nGibOJPTT4lfPPyfo72Iwbd
 4DDkC1fyRsnqHv1nz2VsPpreyJ+921LmrRRQVA7CWdjNheOSMmREsjBAtvYhHT3zYgzLnuo4FvV
 5vf2+H3Q1TRI1+F3CSpUewCflT2ejuDe8w9HU1L/aa/VYrOmcsjYUYgE/4SNCS+q5Pj3QHzKeNf
 O8lBHSW6tev7it76cROudisORUthnyymIdmmOPij/AzvIkGg7VHddpDsc3Fr3kunthRj9OrDUMV
 y/+1+Q==
X-Received: by 2002:a05:6214:ac4:b0:8cf:5c36:eb6f with SMTP id
 6a1803df08f44-8e6d687856cmr26193246d6.13.1782371710821; Thu, 25 Jun 2026
 00:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260512091532.97256-1-jjm2473@gmail.com>
 <20260512091532.97256-2-jjm2473@gmail.com>
 <b2b25f9e-336e-419f-b2a0-e5942df246af@cherry.de>
In-Reply-To: <b2b25f9e-336e-419f-b2a0-e5942df246af@cherry.de>
From: Liangbin Lian <jjm2473@gmail.com>
Date: Thu, 25 Jun 2026 15:14:58 +0800
X-Gm-Features: AVVi8CcjwEgAi03qD93PhnymbAdbGsSghL9HRLeSYB4Kd8tt2j7OXvnIcQq0C3U
Message-ID: <CAP_9mL545u7VqnzCBk8SMo-LLJ9LmYMdrdRWJEeO6+YrOsggVQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] rockchip: rk3568: Add support for LinkEase EasePi R1
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

Hi Quentin,

> > [1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html
> >
>
> Note that this link times out on my side.

It's possible that Chinese ISPs are blocking access this link
from overseas (accessing this link from China is normal).

This link introduces the EasePi R1 hardware configuration and
link to schematic of the EasePi R1.

The EasePi R1's DTS has actually been merged into Linux 6.19
and has been tested in OpenWRT, so this link is probably not that important.

Schematic of EasePi R1:
https://assets.koolcenter.com/easepi/Easepi-R1-SCH.pdf


> Do you really need to remove clock-names from the xPL DTB? I know most
> Rockchip configs do it but I think it's mostly because everybody's
> copying everybody :)

You are right, this code was actually copied from nanopi r5c :)
I will check that can be removed.


I will also check and fix other issues. If there are no problems after the
fixes, I will submit a new version.

Thanks!

Cheers,
Liangbin
