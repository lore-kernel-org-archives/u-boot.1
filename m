Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCFBE8B386
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 00:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 168B983DFF;
	Wed,  4 Feb 2026 01:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kkEBcvQR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7CC283EBA; Wed,  4 Feb 2026 01:23:29 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0096A83BC8
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b884ad1026cso1028141566b.2
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 16:23:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164607; cv=none;
 d=google.com; s=arc-20240605;
 b=k2eSV+9AwX9p9T5T5p6VwfrxBxOfNGkCdQsSKY7gQMxR18+Nl4oaXq5e0ZIBwrER9b
 +Pof0DocEZOaVbBATJlMwYVhF5iZ+ICWqp6pT+uuHONMmcTBHSoxaca5MKZSHn+l3KL2
 a4njV9yF2hW4pRMlOYHJlDuuEYSbXafO11amybzYfb6s79T4Y+N8f73oBQCKeyAnWiJt
 r22D7oA0GLfV6GBvIaxGWAxNmnsSDM1APRYgi0i+OguN0nM4+sNwQ2eUb7EjCzVLUCYY
 YqOBqARbAMPSKjBvROZoPE7D8UUT0gBWE8AZhv81Man4lFg3fhPtzQV0mBaH7ypLsHuo
 S0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Txxkp2ihPca6MT0tvA9fDhVmZtYG4UdisLxgM1hXA2Q=;
 fh=tOA4I8VzWChWXH0nSG1Twu26sWxlRgSpSXSZEBDkEfc=;
 b=RvuPP63pcuwy83cTV3QrtiKhVyHftNaFJ6tBUKgHtOKzsvsBcrp9qR4LpyTz2XxDeY
 g8fvlDwx+xpS9YaF+4CIBetlaFYOu/U8X5uxpE3HADYHPpk5xzf/fohMBvMUzeKE/WE/
 pVo+WfjBqpRGpuTg/hvpc74NxU30OeY1wljtEBf0+PDGfxHezEEfNCWTBFhZaHdqsYFo
 9gP0RxUzHyB+8AzhN03xUQLj65+0zYbhMH19KggFXILCg5n+jKIqsUvipBACE72gub8X
 /OX0/Oo09UcLcGZmrNfD9CPRgldPJPAVFh0dRdNfkmIYAwkCWVGvda19g2oKeihO7Bz8
 6ZUw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770164607; x=1770769407; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Txxkp2ihPca6MT0tvA9fDhVmZtYG4UdisLxgM1hXA2Q=;
 b=kkEBcvQRUgW0POWItv67TZk9kGzSHOQShm86msRyLv71bG5NJPbQ5HMIABsODdAvsq
 Rn2wBjD1ULmZDeIRp+Fn8M7HlvDDdcr3rxLchqe3UheXIVxa/P0nTX9KyiBvWtpTpmM0
 enHMFE+Jle5/DBoaI+egwbB39f24Dzr7llnYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770164607; x=1770769407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Txxkp2ihPca6MT0tvA9fDhVmZtYG4UdisLxgM1hXA2Q=;
 b=usNGPLBFf0bOPAdVmi3MZUYFYk/7lc+mLLuc14Q4XaMwbKPUFd1inLXN/dE6HgIkV7
 yNuEnRBWlSsc5UlL1tQqdjlMnB8XCgfzCmOmKpV465Edoyu6crbhvczHXD74W9kPDqWH
 AGzJo2KMpciNJHs1LDcMCS8e/e2LiQ7t5OIFMatS7kQrumKxD8aPxDrDAKImpiA8en0j
 V7+yGolFZbCtKuzILts66D6thrlNuJR0lUKA7I0cDeWwX3+Z28hVuWygo1inMV5i9MbJ
 QeyeL6TE/GtmxQTq69imuxuEVS2j3AEqAY6SAWYQP1TCl3G/VJ9STlWz23Dy1AoA4PCy
 CiHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPvGVSbESaJpN23WqLsadeyk+Pc+qMD7Ep/OdYXoQbL3ehWkS/U280Z2UnYItEBSCPRdRfMj0=@lists.denx.de
X-Gm-Message-State: AOJu0YwdP4nNbEbmZ4tusDLo3DzP2thjpyZB/eGzwW9hb0eZy8AMu9tQ
 VEDZku6HfvYwaDPqITn53gMH9hRF3ANPNOQusz0NG607ivk2WOviTo8kbJvUy3WtXo5A0f4XfVi
 OmgOnN0viP1NWZq9Z73rvY6GBpqngcH77jmKk+1/0
X-Gm-Gg: AZuq6aIANTBixw3JrpE+APbzRr1XrnEslm2mjhupvIP3PJoXBUwhfSu14N9UbZOFb/Z
 OQ2OeBRU7UWgjdq9dgtJRLcTZzxQicinKiPEFc/MLnI0uY+cl9X+E/kG5onyTVoncxMtZChH+3H
 bhMNVVnVY46rPWl6Md8L8+T6LZ+Zx1dOGlKHyw73GMOHTjwEO3Ri06eFgmUx/7d8q7TGb9lcrA+
 ns2f4GaoOyx6OyEh0UTKeSudu6J00/IqNec5Bec48H1nTuMrPVFNYQ8WbjA6u7C0ryAX9iy
X-Received: by 2002:a17:907:2d20:b0:b87:d1d8:5c26 with SMTP id
 a640c23a62f3a-b8e9ef25794mr88516466b.3.1770164607414; Tue, 03 Feb 2026
 16:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
 <20260120-clk-reparent-v3-1-0d43d4b362ac@outlook.com>
In-Reply-To: <20260120-clk-reparent-v3-1-0d43d4b362ac@outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 13:23:12 +1300
X-Gm-Features: AZwV_Qh3H9sq1lsuWxKrjGGaWt3wH2Lst_GgV-czQ7_UQ7zlU7csu5wdNHFI_D4
Message-ID: <CAFLszTgpp-EZJUNudPW1mOMerx6syQmReL4V0wUgZhwfg-z7cw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] drivers: core: device: set new parent when old
 parent is NULL
To: forbidden405@outlook.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

On Tue, 20 Jan 2026 at 08:07, Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
>
> From: Yang Xiwen <forbidden405@outlook.com>
>
> The current logic does not update the new parent in device_reparent() if
> old parent is NULL. The behavior is not desired. Fix it by setting the
> parent in this case.
>
> Fixes: cfecbaf4e768 ("dm: core: add support for device re-parenting")
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/core/device.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Simon Glass <simon.glass@canonical.com>

Separately from this series, I would like to see a function to set the
parent for a device, since this is a fairly unusual thing to do.

Regards,
Simon
