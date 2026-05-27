Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919F0CD5BD2
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1068484869;
	Wed, 27 May 2026 03:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WJlLU7ke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 491A684886; Wed, 27 May 2026 03:16:21 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E270846A5
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bdce61897ebso559816166b.2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779844578; cv=none;
 d=google.com; s=arc-20240605;
 b=c65WZ4PwaZz1o6YEL6rLLCMys0Xlk4W1uCHTQcCC68SUZaq72CaQCjCVudwbzn2+96
 lfkmrhqYACdiWgZE799YMog+fpOIoNZ1D7QDEuCBgu76pugZiXV8IW2wq3zy342D8TyY
 PySLmjGLfQL9WlpISdHCxV8fBXgmC0c+BtWxtDWQYfl2H6M79jjzQEk1pbR1f0OxmESd
 xBtUl9PR7kdbtv6fLpia+1YEXq/SIuuQ6HnqVHG59PWla3bm4M8XJj5BObUWBdc+x53k
 D6turEP4t50WATb1jO0UFIhs3WT6+Poessz8xx3a8r0DZ2thSxN5S/IjWkb+dut3s05S
 /vog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nrRit4WFnZkzjEB1yseDvkvnVILYQmexXhH6R8zmmfs=;
 fh=POnMNVtdGOey9KFgI9PkeeVD2TOAkKe+/DLSF3JeClA=;
 b=ebaFcjoA8KLqqXCp6rLh/W/QZm0DqPmMw5UGz6+xjMO1GPu8pnITznIVnH4OyFik5u
 PSAyhp3qFNQK47aBrGuh8SCGoiBcgtYisRR4subNMVYDtCTjPnY7ToP90JtkrueGoKGY
 n4QSGo89iWfLlfsFZXk2/gPmBsXI1jw4AfJ+aJKDjVFbpRdqNpAB6zLr05agritbczgB
 rgjicO8dCB+TADfUUCJ1ojMUPk3TpHBBw/ZN/ddgJZZmyrbuiq5cfPUppsrgGBsIIIP7
 3YpJKeu78rFDNdLWdkMbzxeDYOfAiKhHElN0BSc5NMFY441xe5YPFe1kh+C5m3aCsMoR
 O5LQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779844578; x=1780449378; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nrRit4WFnZkzjEB1yseDvkvnVILYQmexXhH6R8zmmfs=;
 b=WJlLU7ke4T2PupCf9qt/bJYIxkkckJPN15B08jB3qdK3UwhOBdrqrKS7RyUqbzdeCX
 wtYlwLv+fKnSMkMn6c3xAlH3Onvg3Gxj9w3Zh7wVS9bWX/4Dec23a5M3NtCbW0QA68ZD
 ZBgwTmJO102sanG0WoRNlp3XyXePGVTY8EVIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779844578; x=1780449378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrRit4WFnZkzjEB1yseDvkvnVILYQmexXhH6R8zmmfs=;
 b=n5NvvAgg+BPtuow4rSpjDTkUGBMqmdmhnO228Ugik7IF7Sm7KeTaIEx0FWV0yrY93L
 IGyuvzgpBdIBGUskp0LIXoV6ch0h+fBqyQn4g9nx8lPzFh5xpwo2tVolMjTQZukAVAHM
 8cuO3kyeiSvfgBz2i2Dwf7SVe44Dt28s6Iar8FCu8zpYDJq6oE5b49abb7LrcJN+2JaL
 9HfXLJj4QzEN/o6sBClLnx3UVI8pvKL+DVnBOQsYjL/Gy0gWDCmyBLPhqQZsX3UmYbwo
 i4aA1SoY06gYu74d8RM5SbAGavUiGXjtj8xEU+3I6BufND+hZTxpz6jVM5ZKyLPJ2+pS
 wCAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ89Y+xlOGRsny+zZ4YpD37EeqnligYR3i3wT7kNtG+KOxPVj9ClZEGleH9CfCPw9uPm+kSNLQI=@lists.denx.de
X-Gm-Message-State: AOJu0YxCSqcmrICIXxGT9WOItG1LvOzhJ4Q6B9Ba8ZrBxRCjhsc6ckV5
 0daLrQxDsIT4V/ui8K8o+wcToeGqie2TWXLM6KKF9sWqmzFUe724i5p90oR8osmX54KRfUs1rWK
 zobnoZj0bWSQHj0RivEFnr12NhCb6GJ8zbCKOG8Lr
X-Gm-Gg: Acq92OF5atXDpNBW+es1pNIY93QVmMhpnkj7hv+6M+UHwSBRO8zkADPV3JoaJ+2SZRV
 hzmL/uTzcTTHBZbYPmGLdWJwv5ASFwBP9hguBfeEWxEJ/AO1fqAddgzWSgRPa3FkVrIaObvK+G9
 HGeipQlICEZBBxlITymExNoWu5FZiqkZXrbgNs2EcDuQdz1dolIiPcPcMzluEhkmUExNbx37ryP
 M5O1kxM1RNlMznLlYDejnVwPNHlRVKYFWWG/RWGleoEqwzBEQywWphoeg5wTMJwQJtrLFRzq3lE
 ZUkZV71cZGx77Iwu
X-Received: by 2002:a17:907:a789:b0:baf:19a8:b44b with SMTP id
 a640c23a62f3a-bdd276ccf77mr1285818966b.25.1779844578589; Tue, 26 May 2026
 18:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260526124044.354578-1-Alexander.Feilke@ew.tq-group.com>
 <20260526124044.354578-3-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260526124044.354578-3-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 20:16:05 -0500
X-Gm-Features: AVHnY4IraI5tIxrCXy9Oks7Ew1OxCgaxHz5ZL7dZbsWVKAMKyy4EtjK8yUoHZao
Message-ID: <CAFLszTg=DeuUsH+qGh8U+7eq5NRL6Nv6bs05t=VyaJabHDHi-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] sysinfo: add sysinfo_get_and_detect() helper
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

Hi Nora,

On 2026-05-26T12:40:39, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:
> sysinfo: add sysinfo_get_and_detect() helper
>
> sysinfo_detect() is commonly called after sysinfo_get(). Make the API a
> bit more convenient to use by introducing a helper.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> include/sysinfo.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/include/sysinfo.h b/include/sysinfo.h
> @@ -373,6 +373,26 @@ int sysinfo_get_data_by_index(struct udevice *dev, int id, int index,
> +/**
> + * sysinfo_get_and_detect() - Get the sysinfo device and runs its detect
> + * operation.

Please use 'Get the sysinfo device and run its detect operation' to
keep it imperative.

Regards,
Simon
