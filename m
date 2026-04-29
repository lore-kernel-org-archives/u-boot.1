Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148C6FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 23:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89586848D7;
	Thu, 30 Apr 2026 01:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XWX35YIX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCBE4848DF; Thu, 30 Apr 2026 01:48:52 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FCF6846D1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-676d8582a13so642765a12.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777506530; cv=none;
 d=google.com; s=arc-20240605;
 b=b8ZbmSaDgD8Ss4ggO0MB8qS9+XcqJoYLC/WgZbo3WB4/wQUHdPeb19Czy+MTR/PqTT
 RVK1gA1vfXymn08yqg3XogR+zM3SDH3MSZ4WjskV1ZRIGDAwk/LEjJqVg2jBoV4weDFL
 Bfj43M82BPHhhcZipirU/Ck26EGJBcLXXsR9LNmsjDnlKD2sjfziDZSAFJ6ZkqqFKcrq
 XF8fzAYEhcatevm1RtzUWNi90J3aVRgbbKAz0bg1vThbIzSgyKQly9McGJxQOGTV13Hr
 kQ2se5VPEIrJxYMLb/7dl7Q/aIGS4pl23KhpViI/5aNZ6Ec6+p3/zcEALVhTaAVsT9mQ
 51tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SPJrd5nHkJTyPY+Q/v0HA+4/XK4jYWmieicodQaMFyk=;
 fh=Clskkn3t75Xn889eo4hBDsalDkg+BDcjXqBknQ8WB5Y=;
 b=GpSWRGTHD5y1M1IE53Lzf+DvWtHWKddMnwiFU9yDdB4xlJM0iUG9RtCmpdFBbPMo4r
 kfHpO+eEn/N3RXYDX8qzgqapqPsgNTmG8EcOfNWQwcA0AOi6Btn/uT9Gr8zAXozNVd38
 cE6/OND/AmE0ZlPg3N6rVB9dpVrDeic4owiHDChTUD5nKrapBeRQ+82iw+nf+AWdAoW9
 5hfJRtY3T/n1n0HbY3QYYhCrrX9bEeoi6jtfZutoIKwCP4u2EDnIrOXvZWtlxaPgeveY
 flpkCs2dDh1vpP4zO8dPm6fNClYMI8zHadvoTb0CMuxxvD1312+KEw+X3RZhif3nbaS4
 48Yw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777506530; x=1778111330; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SPJrd5nHkJTyPY+Q/v0HA+4/XK4jYWmieicodQaMFyk=;
 b=XWX35YIX7l7Og8BzNgJkOj+2oUQx8Ro01BGYAWamq6P9HV3Nv/6w+4G9NoN6+QJdxd
 A/6iAekQQxV5xih65g2hNn7HWJh5po1wiNKcPxEDNz+3bnCyl7+EJIVELVBweTW7T+9o
 hLY6Jw6/53Sc0dLQBAxkckSmgsMJrtcmsMFAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777506530; x=1778111330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPJrd5nHkJTyPY+Q/v0HA+4/XK4jYWmieicodQaMFyk=;
 b=oE80CgTaaloEqJHHb1i8o4jUjlqtRL2+nlQ1Ng9scLDN1Uyeye20NtS7g5gT0/NTrl
 ySNp+ftZA1nN2j9bvLDhlVXhlzQca7oBnm6Vq+m40gVQENZHdaafXC7BlwxSC+DWxFSw
 WfR8Vxuwcv/GpT8xZjezJXPpiHYUfVORYOTm/JDENWCpJsxKTIJlyI8Nf35yTQyRtNqQ
 yvbMZlfscPlJHbWeU57jQ+6AeZBDihr9/hYwQWDh1eddG166BPWm8Y82HUHey19+q0lW
 1DNDUfmU0Tp8fbQGu+ZE18fozWB5tw3DBHWAkvIyYuU4+fA8lklKxZuyB+kYWUa+YFLY
 HzGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9h7Qfwwz9gazJ02SPRGqod6rBC6vvnB22gb6h+U87uLTkC/pZLleyHParutfKMiKTAw1ywkfc=@lists.denx.de
X-Gm-Message-State: AOJu0YwN+88MDLFNJZqranXM9QO9LICLKZS+Pmmzodwo7NeM6a35Vx46
 tkhRB8waRIq0QMNwINIXSmi9WiMwgP4HcibiFs6MyHja8HH3lfaYuPKYGPxiIryj1s3N4OYAk3m
 ZMxo4q936HBzFBC//fvXGRb03srRCRnfl6hPYBqiT
X-Gm-Gg: AeBDievMCaKOL1xzxZajsz+Eq0mYmOaCEJIZ15mPyHKfe9javAOWJUlvRvX2Om0FlkC
 sf1ks4Z/SiQcbuXpiLOCqHecgnnEw9v8FGGBy9/AXfuYcfaktpn0AObbDoRw5e25r9QFHw0JAEI
 LRFuIfI6q1UBTfk30Ke4uUqzTjJBpBbZ3RNGD3MLGmQzTL+rOS9outu10oOx5qMtyFLFvWSWVSQ
 G/PJlseFfsK0k/qs5bCJIrmjPfctoS09sidRNbq9+g5qHvz7cs+A0kzYgy4WamvWqQYh85/bQVz
 0mOmRjnB5Kjsjoe3
X-Received: by 2002:a17:907:980d:b0:ba9:aeaa:fd01 with SMTP id
 a640c23a62f3a-bbac7c91880mr44327166b.43.1777506529803; Wed, 29 Apr 2026
 16:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-3-b-padhi@ti.com>
In-Reply-To: <20260425033742.1519298-3-b-padhi@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 17:48:38 -0600
X-Gm-Features: AVHnY4LCLCSt_eArP-bnwBGUQLKOsBt18UtMEvwKaIFNP1bmFCZnkLTjKmeKGag
Message-ID: <CAFLszThnX7E6evH-hJVgWGq5mEOdDAiFFHTa92VbhwNoLcMwKg@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] arm: mach-k3: Use FIT image data addr as
 fallback if 'load' prop is missing
To: b-padhi@ti.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
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

Hi Beleswar,

On 2026-04-25T03:37:39, Padhi, Beleswar <b-padhi@ti.com> wrote:
> arm: mach-k3: Use FIT image data addr as fallback if 'load' prop is missing
>
> It is possible for FIT Images to skip mentioning the pre-defined 'load'
> address property. In those cases, SPL uses the actual address of the FIT
> Image data as the fallback load address. Use this FIT data address for
> referencing the image when the 'load' property is missing.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>
> arch/arm/mach-k3/r5/common.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)

> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> @@ -342,6 +345,22 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
> +                     if (load_addr == -1) {
> +                             ret = fit_image_get_data(fit, node,
> +                                                      &fit_image_loadaddr,
> +                                                      &fit_image_size);
> +                             if (ret < 0)
> +                                     panic("Error accessing node os = %s in FIT (%d)\n",
> +                                           os, ret);
> +                             fit_image_info[i].load = (ulong)fit_image_loadaddr;

We might need a spec change to deal with the 'load' address being omitted.

By the time board_fit_image_post_process() runs, *p_image already
points at the in-memory FIT data (it's the 'src' that patch 1 reads
via fit_image_get_data() and feeds in here). Re-resolving it with a
second fit_image_get_data() (and adding a panic() path for the
failure!) does the same work that has just succeeded one frame up. How
about just using (ulong)*p_image here and then drop the local
fit_image_loadaddr/fit_image_size/ret ?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
