Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92400CD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 15:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 293138470E;
	Fri, 15 May 2026 17:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I0NnTfvl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A28384717; Fri, 15 May 2026 17:06:16 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529C2846BE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 17:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-67c3cb1433cso16387470a12.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 08:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778857574; cv=none;
 d=google.com; s=arc-20240605;
 b=k/1q7GHUUtl8zQxJMc/7MpsPAFu65YzKvHAFvaM7jkId2uW9EWK7tSGZOUrBjqYAaq
 o6ktDpV5Tlexvch7CBmsyqfmdenOEQftxaKLsM/nHroIFJ65e9OfY4hN56UGgho+92hp
 fGAWkVxZSd6nc0tniWBaXqfxpGeWgfYpY9xJlHKEmBLqfR3QkdES8JzrAVMCjaAAObeT
 BhrZ+j8cHOGpKxfY3mk+UvHidH7jc7Jfk4ZrjMIRRa+8/Yz+CcXPhyFiL4cY3xcPa19h
 BQoVDMmM+XzvnukS7aidhTgmKX74Iy1ItDbE8R1dWY1f3srlwwX8CL0f8liuaIIsOBte
 vHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D99K8/VB50dNrRLylPaySnlQ1CSa1/tcoX5DC8CqNqw=;
 fh=JlFVM2sn2lnVLryXzRVaaorDVfAi0D7VflZ01UvkRsk=;
 b=Bs5hhqV4ullTfH+s597oW+SNBxqL7iy3N+bCmen9Ed/1j0EzfU+lvnA6OENWBwdhSf
 Tu9lybvjtVSZEwJWMcmJPI1sAtPlYywIVaJe5tqLG6RD4DiDDPKjqKhk3mjNgJzJYJEH
 8LS0eMHSoHdzJLQOynsSJt6oNHyQo3ZRH2C/CZyQEMycB5uERPBD3hv1MuX5srovvtDu
 XLN2DDtb+JtbWN4uJ8bebvuAmlwLZiBiv9Njp9MddUKv2qAmHoGET/HqzLM4MXiMDOWI
 dsjDj0Ob7NQDRuRgf34utvWcY94jeUDsAuS8A+D3QfMErRikJq45UQcZsg96ylyKhhfH
 hoiw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778857574; x=1779462374; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D99K8/VB50dNrRLylPaySnlQ1CSa1/tcoX5DC8CqNqw=;
 b=I0NnTfvlDSd9Cf4Gm976hEVuh5Yd4tn2m0XbWtH6Gg872Mr7tMk4z1y7mu4zxrJN2m
 XS1OoQD5mAGfj6Vr8PNdq58snqoDXmhWqrv9JXHrHDiuMM5l8Hp82Q7fqCI8Hz3YmwAP
 oW7oulHzm7Bz4kUWWI/iNVlvVFo6HRw0ViAE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778857574; x=1779462374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D99K8/VB50dNrRLylPaySnlQ1CSa1/tcoX5DC8CqNqw=;
 b=ZdTqgOWxZ1p3ivkWWXS7NE/DpEfgJ8q2fKAx0Rv7niwLsK+ROI9bEAN9VbKnhixtHQ
 rULJNNFx5xJS4JVLN0Urvxs0z1kiTcE3MiaZoRAFVuDu8cOyNwiDvQeCtnRath9YYvon
 e1diNd4baGZFedPERHc69PGmxb7ZHecsHUnKkfxAKvYyFGoJ8Wvi3rYqShyRpPeFvg1W
 uJOLLjPE5nBbCOVVIjFGlIZ2jjF/1jMxOy8Ql66PZL+igUkywWZfVAcdkLILCXqCWOTv
 QZxSyOXmnZcgj2gphktMVkWax2SCPSXlawkDIZS7AvBJ/AgeZCtZgStCeCxkCikaW3fs
 k95w==
X-Gm-Message-State: AOJu0YxXaMdyD+eDy99AfwccdkDVmPBZhDy6zDezfve2gCLxW2/jGBs/
 yS3GucyoJ5WxnYq1eECqSmNXhl2CYcED/VpnjpHoOg0SinxSthr1PWvhayzYgH/JFK1c7ymscGU
 QZvwZeXP43FWUqR8QV3dhdYHYFFD4P/pqpik/I2di
X-Gm-Gg: Acq92OGMuIjot4AP7+HbVgnkZNzEUqFkWqWfYctRNdORrVwqKR5OJ0y0my5qqqs+Hus
 T1iFh3rzImOZO6iEJrUYyK+j7568QPhMwxCs3Tl4TreiqcDQdBcm1CEcq/8rQ90SS9nuLroVXid
 FmDkmQxjWsrrPj9k9YaxUzIUHMbK9jNS9x7gjoOidEBCfcKt4YBMnduqANlYBVouijkIaqSUMBy
 0uHvdlr48ng31Nrc7vhivhjXY0autjaXAw0Uf2gyGgrYrNhn0U/56PXSm7swHh+cc9QFPJGEcaM
 iZuSVA==
X-Received: by 2002:a17:907:7b9a:b0:bd4:e58e:ee93 with SMTP id
 a640c23a62f3a-bd51777b99dmr254768266b.4.1778857573559; Fri, 15 May 2026
 08:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260515145942.133279-1-trini@konsulko.com>
In-Reply-To: <20260515145942.133279-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 09:06:01 -0600
X-Gm-Features: AVHnY4JRnzkWG_1KABbSZXwk7ZbonS7Uh-sqSSjzSxvAS2Muh6VGMcjw9VcWEfQ
Message-ID: <CAFLszThwpS8ULztWURncyZa1hCGbam9Fw02FSxQDgqMVZKkeuA@mail.gmail.com>
Subject: Re: [PATCH] Azure CI: Drop Windows host tools builds
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Eddie Kovsky <ekovsky@redhat.com>
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

Hi Tom,

On Fri, 15 May 2026 at 08:59, Tom Rini <trini@konsulko.com> wrote:
>
> In preparation for being able to support more recent OpenSSL versions,
> we need to add support for the OpenSSL Provider API. This in turn isn't
> something that MSYS has all of the required packages to support. Given a
> lack of user feedback that these tools are still used in this manner,
> remove Windows host tool builds from CI.
>
> Link: https://lore.kernel.org/u-boot/20260429180247.83091-1-ekovsky@redha=
t.com/
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> This is intended for the next branch, and to allow for a more visible
> part of the removal to be made now. This means v2026.07 will be the last
> version to support MSYS for host tool builds.
> ---
>  .azure-pipelines.yml | 28 ----------------------------
>  1 file changed, 28 deletions(-)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 4417ef4e5a50..b2a59bafa83d 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -1,5 +1,4 @@
>  variables:
> -  windows_vm: windows-2022
>    ubuntu_vm: ubuntu-24.04
>    macos_vm: macOS-14
>    ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan202=
6
> @@ -44,33 +43,6 @@ variables:
>  stages:
>  - stage: testsuites
>    jobs:
> -  - job: tools_only_windows
> -    displayName: 'Ensure host tools build for Windows'
> -    pool:
> -      vmImage: $(windows_vm)
> -    steps:
> -      - powershell: |
> -          (New-Object Net.WebClient).DownloadFile("https://github.com/ms=
ys2/msys2-installer/releases/download/2021-06-04/msys2-base-x86_64-20210604=
.sfx.exe", "sfx.exe")
> -        displayName: 'Install MSYS2'
> -      - script: |
> -          sfx.exe -y -o%CD:~0,2%\
> -          %CD:~0,2%\msys64\usr\bin\bash -lc " "
> -          %CD:~0,2%\msys64\usr\bin\bash -lc "pacman --noconfirm -Syuu"
> -          %CD:~0,2%\msys64\usr\bin\bash -lc "pacman --noconfirm -Syuu"
> -        displayName: 'Update MSYS2'
> -      - script: |
> -          %CD:~0,2%\msys64\usr\bin\bash -lc "pacman --noconfirm --needed=
 -Sy make gcc bison flex diffutils openssl-devel libgnutls-devel libutil-li=
nux-devel"
> -        displayName: 'Install Toolchain'
> -      - script: |
> -          echo make tools-only_defconfig tools-only > build-tools.sh
> -          %CD:~0,2%\msys64\usr\bin\bash -lc "bash build-tools.sh"
> -        displayName: 'Build Host Tools'
> -        env:
> -          # Tell MSYS2 we need a POSIX emulation layer
> -          MSYSTEM: MSYS
> -          # Tell MSYS2 not to =E2=80=98cd=E2=80=99 our startup directory=
 to HOME
> -          CHERE_INVOKING: yes
> -
>    - job: tools_only_macOS
>      displayName: 'Ensure host tools build for macOS X'
>      pool:
> --
> 2.43.0
>

Reviewed-by: Simon Glass <sjg@chromium.org>

How should we document this use of WSL to run the tools on Windows?

Regards,
Simon
