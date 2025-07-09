Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB2DC83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 14:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BFD78352B;
	Wed,  9 Jul 2025 16:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l05dh4rs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D32858344C; Wed,  9 Jul 2025 16:22:01 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B661683466
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 16:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-61208b86da2so1346694eaf.2
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752070918; x=1752675718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrnLWYyjypAqWeTasIyqKCeROx+O3YjH3pwHl2Ziu78=;
 b=l05dh4rsM03vAtZgrFZ6VF9o0UdyLqWgr24r9tWhIc2/6GunVBj3BTlZMqixXbM+B4
 XCRnCR4ZqLOOIpxb5+Jm2XBknETeRG7MPErT6SlP8qifKkKBBdph294fJwbxHQUa9wHn
 vz+jHndsj/A4qXPeWw892LvtTBOgUYj42CuuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752070918; x=1752675718;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrnLWYyjypAqWeTasIyqKCeROx+O3YjH3pwHl2Ziu78=;
 b=EaCnLp0QAQV2GBRq6K+CkK3gyM70cZhgQdfPQq+9hO/phvk0Ac8Yj5RBuLLO1GwNPi
 ELLC/xg727ciT/SRfp8neeFjTKxPOzwYYs8e1wCFOrQtx8D/hkU6rtQEESA4yUm0gvQF
 S+ywQsHlYBOei1JVOFU8BRDc405v4/H51z6GInbw9697xoDLu62JX/hSaxMty3IJmQdD
 nSTW3a+PTajJd7YDzXQOaRsBzk+S3RtpQ/4OUlacQlkpasOpPwM3giFg1McVRNCg83wU
 1KpN3FzLmBhhefG9YxprZy/NK0StxGllkS65sxBKeEy+R432z1vs6wyqJGxg1v7A0XYh
 hApw==
X-Gm-Message-State: AOJu0Yxhu2Dk1WccbzRNBgbwbyHx535GxNpiai/rR5PomPM1zLYhuLsz
 fH/uIBXNKtH8B1MGG428qcVq3CzALUYjBt6YKojCUcApxAdd20OMVqnu9MN2kChRO0mj9pOzNGC
 XIJXW4e8=
X-Gm-Gg: ASbGncsamN1y1mO5am+zPNX7XT7VboEd276zveZdX58+yGg4AilXGVNxw5bXlUuO/Iy
 jd6pORdxyjlGjQlnAj0u79NpVMV+MRCJjKahMjnWzyUmhGf+W9L5SblDBs5PYCb2+6Q+dbBy/2Y
 8o/tSQ6e206zHlrdeahxzs96kuTgApG+Lk9lj1NNKtFgxec/3Lha5tdIUaOIKMqRKbrSyKZq40x
 FqhUIj+UVfHKh2ycCEmfi0CFzNTdUJOXrZWvPDN/Id1ypOMeSBqr9SJeEJ0UAogzZASU+T8D5KA
 7/ZpZS3x08QdfCr1jkKNJxLdpprqgppuiG8ThOB97tMEPE0ex5XHG2lpf1yOsGATaPcYEsy/Yrn
 NDuNDForibksL3nq8RGA=
X-Google-Smtp-Source: AGHT+IHjnRJvzdeVpnIliPQKs/7lv6M3HcDMjHlKLRXqfUen4GT1LWmB1LlCeBP+y774hBB4p+jTRQ==
X-Received: by 2002:a05:6820:4b89:b0:610:fc12:cbb4 with SMTP id
 006d021491bc7-613ccd3a332mr1688432eaf.1.1752070918442; 
 Wed, 09 Jul 2025 07:21:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac83esm1919975eaf.27.2025.07.09.07.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 07:21:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tobias Olausson <tobias@eub.se>
Cc: Loic Poulain <loic.poulain@linaro.org>
In-Reply-To: <20250626065428.1471599-1-tobias@eub.se>
References: <20250626065428.1471599-1-tobias@eub.se>
Subject: Re: [PATCH v1] lib/rsa: allow matching pkcs11 path by object id
Message-Id: <175207091752.1813324.3411631326532267411.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 08:21:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 26 Jun 2025 08:54:20 +0200, Tobias Olausson wrote:

> The object= part matches against the label that the pkcs11 token uses
> for that object, but in some cases, specifically with a Yubikey using
> ykcs11, where the keys have been imported, the labels differ between the
> private and public keys [1], making the object= matching useless. These
> keys will have the same id however, so matching against that works for
> both the private and public part.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] lib/rsa: allow matching pkcs11 path by object id
      commit: 0707f73a8ba26f5aeaeada6f5942d003bf67ce06
-- 
Tom


