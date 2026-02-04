Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C348E8B397
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 18:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE7B283A5A;
	Wed,  4 Feb 2026 19:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VeeCdGrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBBC0838FA; Wed,  4 Feb 2026 19:18:59 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C30C6838FA
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 19:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so990595e9.0
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 10:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770229137; x=1770833937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOVk6x2B3J8FxoxN3eBkSu3aduFqEZ894eiIH7eoI5M=;
 b=VeeCdGrYK15CUrm+B3rdWiHpgBgdVSoNFXf+V75mNYzv2L2nFHyoPwhbdJhZNJYvFB
 I5eZNJ1Nn3arg+Yu9B6JITg26jQtGXqE6uE2FQJ94E8BGnvzYKFjCpXD2K7c4INZW4hk
 zeGDN3FUGXZhRZKPIXujgT2LMzjnSM5uWs8N+aLdi0pjyZT1H4YHxK4nb+eftmQnah+3
 iw8dnxB18fDQhdFOSKDbiB4XINwCUmHPVcuD/qu3LJhgkTwZevh329DPqLA0YEO+LfKn
 z9BWmxHjmV1KDZB+S/1sjNKnWQWnmio60I286oDLQ6HfdMBjvKRJ+yqzzW5QuOBiiH+e
 dIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770229137; x=1770833937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eOVk6x2B3J8FxoxN3eBkSu3aduFqEZ894eiIH7eoI5M=;
 b=URSo6tIT4/QS9JIX56lhdirdeB+xFVdc/j6wePvr5V16KTKwte25jcSqKIS1dwH6VO
 zhNu1RQUyT/OkNdsZlnYM1PgxWK2G8tvxg3NoJCn3LzqiPLbljlPrhl+7vFKmcs6SfQb
 0nAGY+06on4XF3UfSssJ8AlykDlaw1k1xBMpLaiOzPVccqdRjNeQhiMm9wtuhVXIRv8I
 7OwgsOazw6AR49VlwRnV7nY6l+2a2boR97ymq2whg0sRBjnHS/teetJ5G06/u4DW+9Hi
 NtY1y89LuP+v9iModycY0evXPDiTTATAClNlj+D23cmKIjJfFTqfgXSTtTRGKdPwc5x+
 nOLg==
X-Gm-Message-State: AOJu0YwPu09mDrgrjkTGrV5FGFmLGBq/lOTayCxSDWL0+2h6E/snA50a
 MPeJtRbGLExlaTfTtRLDqEXT1ZoY96yFujsvPjGgToJb47YPXei6SwPYLBiwph3o
X-Gm-Gg: AZuq6aJb3GDycRxRysA+MAroGi2X+wdzspft9czyFDcyZEpgYIUUrL07KJR0mZjGRLF
 fCXsj9t6HUAWzcV92L4vjBcbP6RrW7xPIeE66+f+6m8kO/4QKQjKeYJJFEx6o81RH5wdVGsmoaJ
 hjHnAkFC0q88bqsyvhVv7Q2+LnMjDfm0dmHTHjGiMxNcFMcQumHDz/2rQsxnmF2yMn2teO6++6C
 eoqBgpaPoRDO3QfGPA32IZQeRaaXxF9CIyuqRMvVPvIHBzrZPPA7vZAyu2Ux9RL/E3S70gBP2A/
 oKpxDRdNsf5F11s1oR3Jbdc5DcbEiTu8osnvUqzrcOXFlocn+pypg6HjEUdA8BGkRvr3J3X3eQA
 eQUbqSNMqb5tqSqeKVT2Qt550i7CCXAlsZKRXnEgTvsgEGBSkwsdaVvmJxWOE14/CQgo3Tc6Wtk
 ExRwmlUa3MSEnmCV/diDzEcxhXZtaEE0oiroV98zRTcSo32oBdi3Kf2qotyVDBZObILEL/S6wOD
 1VWFw==
X-Received: by 2002:a05:600c:a03:b0:47d:885d:d2ff with SMTP id
 5b1f17b1804b1-4830e991bf6mr48942665e9.29.1770229137095; 
 Wed, 04 Feb 2026 10:18:57 -0800 (PST)
Received: from jernej-laptop.localnet (178-79-79-213.dynamic.telemach.net.
 [178.79.79.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830ec53159sm25682115e9.4.2026.02.04.10.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 10:18:56 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Paul Kocialkowski <contact@paulk.fr>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <paulk@sys-base.io>
Subject: Re: [PATCH v2 2/3] sunxi: a133: dram: Fix PHY dx delays offsets and
 add dmb
Date: Wed, 04 Feb 2026 18:35:32 +0100
Message-ID: <5073851.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20260128235727.1322861-2-contact@paulk.fr>
References: <20260128235727.1322861-1-contact@paulk.fr>
 <20260128235727.1322861-2-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne =C4=8Detrtek, 29. januar 2026 ob 00:57:16 Srednjeevropski standardni =
=C4=8Das je Paul Kocialkowski napisal(a):
> From: Paul Kocialkowski <paulk@sys-base.io>
>=20
> Some of the offsets for the DRAM PHY dx delays are wrong (as compared
> to the H616 code and the reference binary) since the
> mctl_phy_dx_delay0_inner function does not perform the correct
> calculation for some of them.
>=20
> Introduce a mctl_phy_dx_delay0_inner0 to fix the incorrect offsets and
> rename the existing function to mctl_phy_dx_delay0_inner1 for the
> offsets it correctly handles.
>=20
> Also add memory barriers that are also present in the H616 code while
> at it.
>=20
> This fixes detection of 4 GiB DRAM on some boards using LPDDR4.
>=20
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> Sponsored-by: MEC Electronics GmbH <https://www.mec.at/>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


