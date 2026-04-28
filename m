Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25005FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD406846A8;
	Tue, 28 Apr 2026 20:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K8DDELDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1242E846A8; Tue, 28 Apr 2026 20:23:58 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C7C8468E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b941762394aso1617202266b.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777400635; cv=none;
 d=google.com; s=arc-20240605;
 b=Vf19QilNp1As479jEUjH7intom9NWXUSG5F0tChsFYKzKRWJmN0uJ45j5ZAr7dP5fc
 iC7eA4f9dhv+JjQqQLQNm28FRTNDvVVnV2jOZ4W3eP8VN8mebjO8cQNYhIFtMReVvHc8
 vksJHXsXmQAD4wWRZmFErRtfHxy3nYwlYGhvdIHbV5+vBjk5pRJYnjhkBlRQp+GxD4/M
 NryF+Y2HExp1mIvZq+7IgWM8LldteH92rt6J9jKRzgDkGLIQcu3q1r42maDWTNh/8CUh
 xLBi7d8roydT8Mr4nxe07bwppToSy34ETIUbPwbKfn5oZ5aVoEuBLvzEnuXKefgCuMBp
 wI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HZzA+tWF6Ts8EB1Qb7SPrPqPbTNy9tt3OjjkPDJKUu0=;
 fh=roScgQRs/1XQwKZoJDPK2CRWP0QTsH47L7/m3Rpzqtw=;
 b=T1ijfSAm5+kCeYI09/cYMLzn0xhNRr9Q7nSf6g/iFgEhuPXHJqS+2ek42iK0Z+2vsx
 C63vHPhf8X1+HSa4fEFMEeoPg4+3MgsLsk3JcLMvDmoukiPtPoZ5QR9WNHXvY8MbYBHn
 PBiOvP6K8MHwpMfq3JqmNLjmDkSrWPR2gdeDZ/T6gRiLdMvIdMFjS5c/Zb/nxr+awulX
 Myw1IRN2Zzo6VsObuCrq07p8ruyt72KR2SxLMLBeCDpUpXwWdKHFgljqgVvzqcobLrab
 Vs52Pg/j0sP8KveVJaAyKHjZjQW7/m9noEkcJijUH91DJrU8hRiPu9y4DpiSSmhM0PZ9
 Ep3w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777400635; x=1778005435; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZzA+tWF6Ts8EB1Qb7SPrPqPbTNy9tt3OjjkPDJKUu0=;
 b=K8DDELDT7ZLmv5CcPQVsVUsHQn/aU9S2zCEc2eu6EQEzEUz9MACycGOLl7hfxcDbkp
 lb14nQuFhetP9/DaGpuvOk4yKqkgk6Ip4xOr92fJ7G0tRL1qfJ2mjEGHXuREbjA6ZZzl
 1vkFdCRtT0db7mXKH4jiW9OgVu+3Dx5PkrFcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400635; x=1778005435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZzA+tWF6Ts8EB1Qb7SPrPqPbTNy9tt3OjjkPDJKUu0=;
 b=F9LIGuVnQoReI462brrzCrGEEFToW62kKD0FbFYueqYZKRDoiYM2f5F5TKl78AHX57
 RCpoKqZCUDsBJdKHNFJsyb2Q5s+rE8LQS/StqdV6gPwKAWvNE8vDldQ1W4YisCmQ/1Z9
 EpCIkprwVf+UNj3LpJhzBAATFTwGi9ykExWLkDPObx9+b9J6I5YVHw7DaUOncLDD0KyK
 NqXfp0idAxMwjeKmEdfR+SyRLfa+LYxmm3DxFXK4VVzxPJfZriQfx8j51dEA3x14q413
 asjJEjj1YfKtmSxY5/DEz06VLVJztIXeybECZkgM/VdLGlfNfQo+qyR/f8/MAmhN5deu
 P37g==
X-Gm-Message-State: AOJu0Yyd77aYt4vT/CifJiu6pmf2wF2wi/nqWJb2y+oT0Bb0I0N4InuX
 LdVDK356Tu0RPHDUqAnsSICy+BAN055+yEXt2eycVzyjYtIh5BgUqFgFJnyTJrTTVNlc7o2EIz3
 n4lfPIETlPnyueEMqJVeHyEA8L6RlkklQQcsXXp2I
X-Gm-Gg: AeBDietjUoMUCb0k+Sy1ameWN1quLbkomfV+P76as8X8o+G+8WLqIYqFJHY8QMF6gY7
 LFBeqOOMP/7gBRNy9JCIp2GsHn+9XaSegkoyh+4SELfkstsuUfBqCgHua5HQ8/osNXSr4bTf4UK
 uvsD2c8xTCnHnCzcgLrQD3bQfhitR+u33rIKKWb3h+YMYpIz1rjmLUhgg1fA2JRTXALBm5Z0q7C
 XmVGDxR/4E8uAfGzqiBX6f/9D7Rcp3jndpjW2mrAOxzYNKhIJvssOiDaDghlAXnYKAYFPUuMJCy
 v9S5vHpoTrNCJkmq
X-Received: by 2002:a17:907:c48d:b0:baa:2e75:8cd5 with SMTP id
 a640c23a62f3a-bb8023b8ad7mr277480466b.15.1777400634784; Tue, 28 Apr 2026
 11:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
In-Reply-To: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:23:42 -0600
X-Gm-Features: AVHnY4Lm39jODnpjePwsIgAuApsvgKOAkcD_e8bRkJqIrM8QC04qOIhIbyY5kN0
Message-ID: <CAFLszTi4jAGOHa6qUXNq3qu3ViVteFT4gW6nMb=yn2OKDNiGnQ@mail.gmail.com>
Subject: Re: [v2,0/4] fastboot: block: Add GPT/MBR and device selection
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.denx.de
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

Hi Balaji,

On 2026-04-27T12:06:41, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:

> Patch 2 adds fastboot_flash_gpt_partition_table() and
> fastboot_flash_mbr_partition_table() helper functions that handle
> flashing of GPT and MBR partition tables to block devices.

Patch 2 also refactors fb_mmc.c to use the new helpers =E2=80=94 please
mention the MMC conversion here in v3.

> Patch 1 implements device selection syntax allowing users to specify the
> target block device using 'N:partition' format

Since you are adding a new feature (the N:partition parser, plus
GPT/MBR flashing on the block backend), please add test coverage. See
test/dm/fastboot.c which already exercises
fastboot_mmc_get_part_info() - you can add cases there for the block
path: a successful '0:foo' parse, the bare 'foo' fallback to the
default device, and rejection of a leading-colon name like ':gpt'.
Otherwise the parser and is_partition_table_name() interaction are
easy to break in future refactors.

BTW the v2 changelog has 'Seperate' (twice) and 'fot' - please tidy this up=
.

Regards,
Simon
