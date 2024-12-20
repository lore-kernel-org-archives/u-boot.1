Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10771E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 20:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 951A980429;
	Fri, 20 Dec 2024 21:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pHdQoXsl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E47AB80435; Fri, 20 Dec 2024 21:41:54 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 444FD803F0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 21:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7ea9739647bso1569900a12.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 12:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734727311; x=1735332111; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tLIFCAEbGLCVv11ySUyO/7xC/xsXs0/M4eUzTuLqC7I=;
 b=pHdQoXslg5oheYSGukPz1BLqJznjKAk9zfQF0sD8cRvIVLen7FdyKRMj185vOlSyna
 WV5m/hdjvutXTS9UU1GBoXkDFEytXLSRMGFf+dlOHEYbKCwK0H01ydPUpApiXUFWoaJb
 LiPHqqmZt9BXvKEg0EXgyFwR4IQjlOFYSCacJlJvcMb6zbGYOScVe6Tkd6bzoUz6fHMH
 HTj3s3qm+uVhp+dFz2OR+HTVx20Ev7PX/rmy19GUCCn2I9Ef9SeqCH8ISgDs6BvZjBD9
 EORp1J3AOdBgkCmMNLbYfAAICDgeMlLjXIoIB8HlMpw9h0OOtG5ZBkAyUJL1sL0pOCDp
 EvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734727311; x=1735332111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tLIFCAEbGLCVv11ySUyO/7xC/xsXs0/M4eUzTuLqC7I=;
 b=mTlvVTMtlB2tWgv6ZOPzOFdMdUOnAx4IZ8M6qtHDIo8e+C9HHHNf6hUm1oSclrqKiR
 2ST+4fm2J1ap83D6CHjqmytUgQ+0XO9vBsvtiM+KDDbYKoT4v0hxlUsO6YQOYgfv0gw4
 Uq4IgIB5wCg7Oq9AeifuMGvET6+U+wE1iHf00VEdWunB8Jri11nj5w0edKSWXypY3L82
 sqe/iASKa+LLdMm10kUOYIVcoOjNB92K0VYaLPOGcttAc0qTtXKZ8CrPbst1e51aQ8QR
 g/f4G2KSrvOd+GgYaTealqUzS1ZPxIByUSJtDIyjz11PHNmJlYtZrkYfskBnaTUM+Kcx
 G9Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU46NTpXfHrVQnv1vB41BL3MfmP6VdU8DpZ9UHoCO5Px7mlqp7MuxqNDeGDmCxlCTTgjaVPOlU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6hkOMzvOpo0MoMtvKqlCd7h7sapbnRUN467c71bmTj2NRSrDw
 i3SmKsNQbm3YwiYFhFwlxDvV5nmk7ilYjZNMd+pY4wd9fQ2HiZxPIncCqFSb3FGvsPPFflMpbuM
 vrfCcu/CBkKTUD6sc1bzp/Cn5DK6E1iti/7QuUg==
X-Gm-Gg: ASbGnct3n9UVX793JKNKrN9XRAlQWRoA8VTzBWG0Qq2FxMpcvuJryVhyrRlZCJ26ZyL
 7KJYZnxl9ZjI/X1u026ykKD7vaUS//+EReEaeCYN6krC1h+T2ejoRi8TkmS9vuO245Sz70Nk=
X-Google-Smtp-Source: AGHT+IHH0CPeMp+8DT5rU5Cn7XvlqGd4Uu0kt3V4VS+ZnK8FStZAXBVq+ewuu6XgdF5gNCTldDAR5rErYpQTic6Zsf4=
X-Received: by 2002:a17:90b:3a43:b0:2ee:45fe:63b5 with SMTP id
 98e67ed59e1d1-2f452debbd9mr5873682a91.3.1734727310782; Fri, 20 Dec 2024
 12:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20241206225438.13866-1-raymond.mao@linaro.org>
 <20241206225438.13866-11-raymond.mao@linaro.org>
 <468bd401-f85d-4b76-b513-f775a51ee5ab@gmx.de>
In-Reply-To: <468bd401-f85d-4b76-b513-f775a51ee5ab@gmx.de>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 20 Dec 2024 15:41:39 -0500
Message-ID: <CAEfUkUKD_m1n3v9m+zcDOhdBx6=AnjF9Tm9L=i-Of4z2qwHbQQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] configs: Enable sysinfo for QEMU Arm64
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Stefan Roese <sr@denx.de>, Alexander Gendin <agendin@matrox.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Michal Simek <michal.simek@amd.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Thu, 19 Dec 2024 at 11:00, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 06.12.24 23:54, Raymond Mao wrote:
> > Enable sysinfo smbios by default for arm64.
> > When SYSINFO_SMBIOS is enabled, disable QFW_SMBIOS.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> > Changes in v2
> > - None.
> > Changes in v3
> > - add CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE
> >
> >   configs/qemu_arm64_defconfig | 3 +++
> >   drivers/misc/Kconfig         | 2 +-
> >   2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> > index 8dffb91e93b..31656699d82 100644
> > --- a/configs/qemu_arm64_defconfig
> > +++ b/configs/qemu_arm64_defconfig
>
> Doesn't this work on qemu_arm_defconfig?
> We should test on 32bit too.
>
> It has been tested on qemu_arm_defconfig manually, I can add the kconfig
for it if you want.

[snip]

Regards,
Raymond
