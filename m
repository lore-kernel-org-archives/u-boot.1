Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8F8CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E533184862;
	Mon, 25 May 2026 17:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WYnOf302";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46843848A9; Mon, 25 May 2026 17:13:53 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F698482E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd3d7c29b4dso1388340066b.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722031; cv=none;
 d=google.com; s=arc-20240605;
 b=bmb7Oi+HnGxhGIjMBNIoweU8JXBh/tKIEV4cHZ37IDdKRWm9Lye1COwgiBXXQxnguo
 WU/2IYaekIqtKratmTcoHe5xbBc+O2QF8SW3+fhw9JaCXVT9yh3ujiYreJdEguDYCKwj
 85bwKPRn7fRDps5nXXEsF22CDcRoFeRa0/C2EQXjqabvg1JXSiKCuczEE8JQmnt2NwO2
 6uNubWru1QN3oFbmY7QPfXAUPFC02K3PNvthgcKMaGs24xa/kzBHFWewcfDnWhi/MILl
 j+GvbJnx1RVogUiOtjYZYrD9YMzLboHU+epe93fUIH5D6Y7zxzYejIM/uqpGqeTnIAGf
 9/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3f3wcR/5K1xVl199++dvPdTHn+IZlePR3Dd5MWRg5Sk=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=VmnyeEuKNUMBtb5yXZDQDe6FC+oDORnRZSf3fJL/Ob0aktRjrxc2jGxA4t4GxcYGOP
 y28AMCIvFz1fIB2ZYEGK7cy6apiiVdYSKu4zoifXVCZOUKsE+0MmYNCb6suby2gqVOiq
 0y/ypSZLwWHH0UYexfwT1EaTihSPOknB7IssFUBAH1kQI1KNSMwzG3k29FDF4Ap0ofU2
 CaWJ5mJm427/9/NhVpK7SM1OCyV3PNyKVnjut7laAEMIvpSa0I1RdvZTfjcknJdioUP5
 hDLwYO7fHVupHm1jhx4CbuqqTRMtoLUvsRSQdiXXztB+/wFDz9b8KJKwD+e5wa/iy5qt
 o3EA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722031; x=1780326831; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3f3wcR/5K1xVl199++dvPdTHn+IZlePR3Dd5MWRg5Sk=;
 b=WYnOf302PD+ncRj2yN5kbHIhIrxyqy2GdCWBnxXzOToaWvuHN/mUFSWrtKk9czEWUm
 wc+4Z51EbcVBaTsiV4oax6415LJ0FgXE9ppmYq1W/LsQO/Fgam4zQj+m05/qOvk9w3kb
 FwxJ6D5G8rqD3mnQa9FIs56TKUSRe7hi+req4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722031; x=1780326831;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3f3wcR/5K1xVl199++dvPdTHn+IZlePR3Dd5MWRg5Sk=;
 b=FnQnVb50FcSLMBz7lmDvc/3SFqyIPvUvIw+hHLM1KC19dC098qMXqUDr7bZaiB4ewV
 0OH5iwG+tlfHt0FNYtg2Ry1QmK/fxFj5oh+aqfCk50idcNM/wIamBWWgD2oqSxqxy4HE
 fkQVpZ0+ZsrfBu3UXyJXkepHhMVps9v3ybA4rKcHqmJYBtx7Q7LAQI280pl9PP2gnclM
 MK/eu81LkLagaYx6whclTpMc69gf/vMoyfCf5roJRMIXkSiSGExMtK38UTBIBFoHTesC
 5P+qmsohjZ6PSRfTxeFwNivCnT2/9/q5Psq4+iGw+WxRMOw0dNoXP0nLUQYoESZRUls5
 udrQ==
X-Gm-Message-State: AOJu0Ywj3oPeQd8gXz4AEGTL3zXiMRy2x+UK0Oz+GaxI7zkhBzIdFIG2
 D2yNAECZ6rm4H42nhDr/lsXRMDwWxY/zDLJoMwt03KRJLfFm9+6ZoQZtNxOWjEPscDvNwq+0ArT
 1Mu5yMaSbcB9nSxyikRczZ6J4TzcjqXNGF5txAf90nXSHICkSVuI=
X-Gm-Gg: Acq92OFUyGVgqdAajGzh3TQVr84CyOoiTQkYZP67ugUbIB0E4wGITQQ9efwdDEi16IH
 euKKx1XxDoHMuzyVHGdNb9SPmuWGinU3EqAfQE7pRe+YSOZR1znkf9XPLZ9Ymn/EGplV90k8tTf
 ZoSHVoi9UpT+alsUurkMrOKVzpUEDdsO9XE6qAG9tdh7hpNoxbWp28wQGFwd9nOg3xQds0jpiXX
 Ipoi0AD0bEDtb/Y4syZsC1KBuFHr6qykIASRWW3GbUuWw2xEQb77MFfqYKY2ouI8R3hGtb0j7aP
 0WlHGA==
X-Received: by 2002:a17:906:fe02:b0:bb8:fd89:4a30 with SMTP id
 a640c23a62f3a-bdd25ce1807mr837302366b.31.1779722030798; Mon, 25 May 2026
 08:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260522024227.2950976-1-dmukhin@ford.com>
In-Reply-To: <20260522024227.2950976-1-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:13:37 -0600
X-Gm-Features: AVHnY4LUxK-QbmWcc4yFOxhsImiJoPg9Ehezf3yG53fsXtUyjgCa_Nln7RFu4Zo
Message-ID: <CAFLszTjpCKUj5pSAKn+0V2mmK67gtJ_9z5VwVC7ur_KWD-dYgw@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: exclude logo generated file
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-05-22T02:42:27, None <dmukhin@ford.com> wrote:
> .gitignore: exclude logo generated file
>
> Correct the rule in .gitignore to skip generated u_boot_logo.bmp.S
> artifact in sandbox_defconfig environment.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> .gitignore | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/.gitignore b/.gitignore
> @@ -80,7 +80,7 @@ fit-dtb.blob*
>  /*imx8mimage*
>  /*imx8mcst*
>  /*rcar4-sa0*
> -/drivers/video/u_boot_logo.S
> +/drivers/video/u_boot_logo.*S

There is only one file, so you could spell it out:

    /drivers/video/u_boot_logo.bmp.S

While you are here, the top-level Makefile still lists the stale name
in CLEAN_FILES:

    drivers/video/u_boot_logo.S

The commit message says "in sandbox_defconfig environment", but the
file is generated by any board with CONFIG_VIDEO_LOGO enabled, not
just sandbox.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
