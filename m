Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27401C83F21
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 02:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD2F836D1;
	Fri, 11 Jul 2025 04:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LOq1lUud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC6C836E7; Fri, 11 Jul 2025 04:21:17 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB82F835B6
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 04:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5561ab55c4dso1659264e87.2
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 19:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752200474; x=1752805274; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3MzbR089BJ6tmfI74YKhOwBgozYrz2765j3XYZXLSM=;
 b=LOq1lUud71mUaMTGBcwHEYevRasKLysuWHSjrumohEA+D5E9Oa3yjDKjwuQ0MI4kON
 5P1dm03MTqPRYBg3h8CgGv6sEElKEBXn7Xf9rzo3uLb+L8tikW6eJBz/ilMkYVWrPb/O
 Bc/LBJfKhkpUsFGf0D58UvFm39mp7s7832FLEyhK47M2du3vAWlRhYuS00CNnTSzjl0N
 UqduCStd3Mlf0QIy8Mw0nDmG534MateZOOgLX1deVYDv6CB5SKayerQI+OvrvDZqerja
 nnql6/DXggiVmWgnyXbiFrkHES5p8m7fVm/NoPyYEPma80yOvQNFv8mLgYhrM6fs6Ag5
 zkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752200474; x=1752805274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3MzbR089BJ6tmfI74YKhOwBgozYrz2765j3XYZXLSM=;
 b=L3a1bwDxECPD8Yt8n+EJlbd8FJJM3sJNYmtr/AedgShMXG/mOHTA2wKWxKfkjnMaB9
 iyTyS7FPqk0orXSg+nZxImyY75rw/3ZfhF8/fz1QZpqFf5V/341hb+8uZBV/tB08fGCa
 Ni5kLzRi/l5XEiRjJNssC2ilE8jVSnWbJIc1xuqoDsUkWS6BuPufHU5LuVZKnUYkF2E6
 TC96S1bc1JALGlPjC1PJtDK/ByuBW8d7h0bmdmS1ipiXIQhKcJAFPyHhgNdKQ+qSpQpd
 Jc+MkwyURIWKnUvQMtWWZxaZ4XDmvdfRozx/q2oo/F31121lZdokQ27PkjJzSFPo5afs
 YYTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCf6wUV94QguXsOayKfobR/jVjkS2aPgdxvIaXT2qkUd+tHmi0//opq41EUruz7xv6T1OCqOI=@lists.denx.de
X-Gm-Message-State: AOJu0YwCv6XYYtT7WIBuZGc5YPHRoo0fVbBTcAOXr9YQWkmTFqnpGCtm
 concwyMM2HF2V4UQZiS+vmV3OICImaRML/qWjLnAye21NuM6oGnBn8tZ1L3pGkNOFQPXgzlfrzw
 wvE5XafV700mD3ehKZHmVwhXD2VTNst4=
X-Gm-Gg: ASbGncsIf1ZdXHkhRvkSiBTXbEBxMAt2l8X4hZCG61sdN4kobnMWARam1endZcFb397
 bfsvYvDNXOyXKv5pL4tR0RtCKwPmrcf8zaXloBybFckzq5bZMHrRh3dvauVA5EWW/ztQ++J8dST
 4io0LmoKqGpQUzWUd6z308tT5MXpSn5k1s+XGfg31str9X4ZNsjdNtHzg9Ll4V8PiLomj4zINF7
 zenPDxjNfG7UcK2YIFhA29mviikAqKYGMQcSmQ=
X-Google-Smtp-Source: AGHT+IHnc61NIi6RIDasz9vPkDfKKUAVQ3ftc181fh7AIg7CzmWkRB/iEd7HQNbHfDRwutzEZKbQPfxQOLbdECpwmtM=
X-Received: by 2002:a05:6512:3b12:b0:553:37da:2bad with SMTP id
 2adb3069b0e04-55a046475ccmr319691e87.38.1752200473795; Thu, 10 Jul 2025
 19:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250708084127.659728-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20250708084127.659728-1-alexander.stein@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 10 Jul 2025 23:21:02 -0300
X-Gm-Features: Ac12FXzoVWcFKsCw8pRPQZ0ypVdwsLh-_PRvNjId4yXExEqZectN6ICOsGzAUV8
Message-ID: <CAOMZO5Aain_S1+AWwe7SMHAQot8Pw7+h0C1WA8A5nr=LQ0_2gg@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm: imx: imx8m: soc: Fix i.MX8M Nano GPU paths
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Tue, Jul 8, 2025 at 5:41=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> The SoC node is called 'soc@0', even on NXP branch 6.6-fslc. This fixes
> the boot on i.MX8M Nano DualLite, as there is no GPU.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks.
