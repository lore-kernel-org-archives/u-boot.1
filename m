Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9AAC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47D6F8653C;
	Thu, 24 Aug 2023 15:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GepzrabS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B1786553; Thu, 24 Aug 2023 15:31:46 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 785AB8653B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so8758880a12.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692883903; x=1693488703;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QxQaBeaB/1HZuu7y1vofRYzKvCp6JOf41c/Q4K7SEUw=;
 b=GepzrabSsN8krwHb8zCpBT8yy+3We/lQllbR8MEesXkCGnkMdHWEeGjlDeTVGO3YKr
 2z5R6I7HFtrsMDMTOU0lAHI4RvqGYIJh68ptXlAKjxQxLcOvlF2w+teYRSecX96LAFUw
 X2GNSlmiOo6TchE49dZl+nI55dB5Xp9ekkYYRI7e4iJP5qrTtef5QuJgi1glnt9jTPWm
 OVBCDSReCEqvRTr52+C+a/2ZFx5BA+J+clyoBRXN5TWq8Hw/ifMkWN90pNZ401RTyil9
 2Mop8BZ/WEgm3rb8BSfuzrF0DTJ950JN8r2RSi5OijWQA9GLHeCNovXz/5Y7WofaTATt
 0NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692883903; x=1693488703;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QxQaBeaB/1HZuu7y1vofRYzKvCp6JOf41c/Q4K7SEUw=;
 b=KEzBsOkIzOAdQcJiogeIFvqYCxa1ddBbLFMPK9BSpgfY+9fq9uC5Xov+ClSNm3hq42
 TaicftTRqXZTl+S4yu7Qc17A36H6moE1ZEhbpeIfyiWG+UZXOEC7Go44sl1zdqCXGFQP
 VjGIeyjTpVTKws3FlOpQdihR07HeHf8xzb90ITpAG6HwnVJ3I+j1yl6vLN/GYeygkCib
 qtq4MTA/EdEfH4/KBqJV1QEJXIJpdrtKjaFD4BwE3X6tzNH3cgV/vtzC1frfc6QZvO7L
 eweoFjBemzekKi+MM+hXp84z4Nif7q9ru/98VqBZUAjgK7rdmVeZC02kyfNFOac0cBGI
 lwYw==
X-Gm-Message-State: AOJu0YzgH6L8f2O5KNbF/fM2duZw5EITtxeRW2TtKJFTeuSN4Ju9FkvX
 +cRnvUDfei6q/BpuY0mhAlIk3zqp1Xz/uQ==
X-Google-Smtp-Source: AGHT+IEZ9Yy8TVn7a9ErkpcYLgkIWc2PopixCPPEnOOZVuLESgb3mPaAR+M5wtdyPfHy69vklHBY3w==
X-Received: by 2002:a17:906:32d3:b0:9a1:8a54:145f with SMTP id
 k19-20020a17090632d300b009a18a54145fmr8915802ejk.40.1692883902658; 
 Thu, 24 Aug 2023 06:31:42 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.238.14]) by smtp.gmail.com with ESMTPSA id
 m14-20020a1709066d0e00b0099b7276235esm11023322ejr.93.2023.08.24.06.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 06:31:41 -0700 (PDT)
Date: Thu, 24 Aug 2023 16:31:40 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] tegra_mmc: get tap and trim from dts
User-Agent: K-9 Mail for Android
In-Reply-To: <ZOdat7QlHuhU5TVZ@orome>
References: <20230819153501.77245-1-clamor95@gmail.com>
 <ZOXlJmZicgBUINlb@orome> <10578B16-04A2-4CE3-83B8-2BF7FBDB7711@gmail.com>
 <ZOdat7QlHuhU5TVZ@orome>
Message-ID: <8C157F37-0AE0-40C3-B9E4-C72E93351A7E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



24 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 16:27:19 GMT+03:00,=
 Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Wed, Aug 23, 2023 at 02:30:48PM +0300, Svyatoslav Ryhel wrote:
>>=20
>>=20
>> 23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 13:53:26 GMT+03:=
00, Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>> >On Sat, Aug 19, 2023 at 06:35:00PM +0300, Svyatoslav Ryhel wrote:
>> >> Default-tap and default-trim values are used for eMMC setup
>> >> mostly on T114+ devices=2E As for now, those values are hardcoded
>> >> for T210 and ignored for all other Tegra generations=2E Fix this
>> >> by passing tap and trim values from dts=2E
>> >>=20
>> >> This commit will cause regression on T210 (emmc may not work),
>> >> fix is applied in tegra210=2Edtsi and will be sent next week=2E
>> >
>> >Heh=2E=2E=2E I don't think so=2E If you already know that this will ca=
use a
>> >regression on Tegra210 you need to rework this=2E Adding regressions
>> >accidentally is already bad enough, but doing so knowingly is a big
>> >no-no=2E
>>=20
>> DTS change for t210 was sent in "General tegra and board improvements"
>> patchset=2E This is why this pathset contains only 1 (one) patch and a
>> warning=2E It has a dependency=2E
>
>For U-Boot this may not matter as much because the control DTB is always
>linked into the binary, but for Linux for example we need to make sure
>that the kernel always remains backwards compatible with older device
>trees=2E I think that's good to follow in general, so making sure there
>are sensible defaults to fall back to if the DTB is missing some
>properties is good practice=2E
>
>Anyway, the way you posted these there was a future dependency, so if
>someone had applied the driver change without the DTB change having been
>applied first this would've caused a regression, which is always bad if
>it happens at random points because it makes things like bisections very
>painful=2E
>
>So unless the patch is fixed to fall back to defaults for Tegra210 we
>need to carefully coordinate in which order these patches go in=2E The DT
>change needs to go in first, followed by the driver change that relies
>on the DTB update=2E
>

You are right, it was my miss that I did not include tegra210 fix here=2E =
I will add it in v2=2E Thanks=2E

>Thierry
