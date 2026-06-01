Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A123CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 21:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CAEB848DF;
	Mon,  1 Jun 2026 23:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pft0LJ7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD75848E3; Mon,  1 Jun 2026 23:12:20 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5ED84894
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 23:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-68d23430690so3373044a12.3
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 14:12:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780348338; cv=none;
 d=google.com; s=arc-20240605;
 b=fwKySDcD1Z1rfMS+gE/Hj9+juos+l5PV4vDpfStHfn1lNHJAU0p/ek+iwY7SQvBv9L
 BQa8IlRSTFbrc7JfMeN/wuUgeCHszjtjUjqHvOT4gXixpeG+IJwblpzwECQpwGGmSUot
 Y+fVKYg+y0yqFw0QcmDSJdrBYv4F+Seu3nCEtuqc7B31RzzqnYavNcE7PpmcuZ1P89JP
 3BV0qA/w2iY8Kn7+nIBxJEPb88Yn+lZ59MnpjWiKhO9odhFznyMFmwuJZnkxuyrAvWU4
 9ZAY663crGMf2/27IArUX/NrWMWC9t4+9iNZn1dwC1gi9arG4kQSvPkNTEPn4FL41eYq
 Y2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8IhcP4nTyzqG5CQR7PkVaN7r2/nOq9uJPTLJEakiugA=;
 fh=5Uny70soa0I2dokMvsCUphj9pGfm4ZaZVCjhucDZoXk=;
 b=lGHJ2LvN3k6E5IaAVMlxeYSGOJQJGsPSx0mSDXzJ1HFD4sIjDkmZteI4r4KNKYRe6V
 sRPip3dA601aIQPSCleWZ4QHBB4kkOfp/TRI490oPb+DNkbjg3d4OcNI4YhgSziOLaYY
 KmjGEQkeRNr6VYUHwGrjoBRRVAnc0bkksHDnD8MigX8Y//dSCoTRbsOUNjLtgvDQQhS0
 Ptcr/UWGXC1LO4FHY+NAkPHf4ujTMO5PbFWc58oC3+UOY/NONHb+3+O3NUbHkx46yhEc
 S7b3XZuT1iFv2YD16wvkYC5Ny0ft/QLy+nXEd1sQyBNBd+Y47fSSezjaoa8fORsGnsMv
 YItQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780348338; x=1780953138; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8IhcP4nTyzqG5CQR7PkVaN7r2/nOq9uJPTLJEakiugA=;
 b=Pft0LJ7ce56jRyxtv0OIavymdsvVG0WF9fa3PJJxST2fxaO28ZSamn5qHVhyPoHFyY
 +HTRvbTMHfjFkhV46pooWZCgItCjqoC3l5jqFRtrGhPSsX8E/DfwP0Q6klw/1FtmqFfs
 /V+Fsc/KGEZh6+9h2Wd0jBchPi0hAvpEtHjgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780348338; x=1780953138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IhcP4nTyzqG5CQR7PkVaN7r2/nOq9uJPTLJEakiugA=;
 b=qpoUjtfAMMCMt+2snEKDvNH/3FJAH2UOCo13PZZL29+2fuXqJ3tE92wtsKmTaUgc4H
 vJX9BzAhjB8fDDX8QT9MiaR0UaFYiYHhLCR1TGdr/bBW2TT4fdf8MVhYoUUcvLeo+PMQ
 6L32cSQhGzx8W5WqBe6+FgQWhLf1iV/tWfciXHjLgV3JodiADxw/82vTMi7Yz2vS1p6k
 OoTTlKZtkCXVqS946u6d40YKgGfz89WPVMCWEoutReRmkQhKHv65Y+7EdW32dZt0zzk0
 TCOJZ7By1buF6q9k2scohBTHzRKHx1bO0SiQ6ACxO2MzRuwtRPoxOQoaEcXBumBSUgUJ
 UQhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+L9HLv5NkspKA2htjENSE54JJBJ/9FhCspc7R5w8/9alIgh6Z42R2yFwxD9bWceedFlNDgujc=@lists.denx.de
X-Gm-Message-State: AOJu0YzuxD3kKSWkCB/w0mR8seYzHDMOSGXnzt1O4sql3e40WX3tWZ9U
 rJJG/6of1WBZY4YM0JMDoyLe4PDFeBlvtGeGN16YFGuLSryFgPVDQ5cVRQofwlmRrl4370TKiIX
 V4NC9oU6fqDkKzXdSHCtx5h+KWPEkX+LKY9hM6vZQ
X-Gm-Gg: Acq92OGXQ6n0AuBwsDqdpKzn/s8220vSu1LzVTjQQBul29UVZPA5MciOsh9/Fgtv+cM
 bWOrx8U/+ppRqiHDdEJcKh0UtqdhOKk9FNcBLO/SNOs0yiqWaxx5WWxYBugOuoPPNayGMX+yMuC
 mtDmmxTzRoP7KuAOYVczfpt9GALijgmjaaPVFEKaddYXnpFjZu9cPTC3eoh98R9PHrwI28X9vc8
 VwRPLDkYTo0fLGMrDyf09Y2RIZAQP9e+ov9HekAORNHbBN0eTii/UTVT+im6yqC0ujzDRdWef/V
 +yBNVBlIerMm6CKTlJYoDofHp4c=
X-Received: by 2002:a17:907:1b14:b0:be5:2bc0:5370 with SMTP id
 a640c23a62f3a-beab542b91fmr679606966b.36.1780348338025; Mon, 01 Jun 2026
 14:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
 <20260527095123.50797-2-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260527095123.50797-2-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 15:12:05 -0600
X-Gm-Features: AVHnY4KKHUqYF6CRb_xuwvxgyKbWG-0ZiBM38DxXzKa-cHFMh55--l3mffg5m4A
Message-ID: <CAFLszTjDaJnTQoV_++_gNGTZ=MYr=1MYbaE7VX4WAm5pNFsUqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] sysinfo: uclass: use sysinfo_priv size for
 per_device_auto
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
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

On 2026-05-27T09:51:17, Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:
> sysinfo: uclass: use sysinfo_priv size for per_device_auto
>
> Reference the struct itself for the size as it is more robust,
> even if it contains just a bool at the moment.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> drivers/sysinfo/sysinfo-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
