Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C5BC5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 11:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C52860909;
	Fri,  7 Aug 2026 11:15:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s2DXDVcTeYUr; Fri,  7 Aug 2026 11:15:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71A1660A3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786101306;
	bh=yiDpAdEdnclEqOnXVaiptQWK1AX9lFuacFtJnLsGRC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ITkHRUkw7Sp/OaF+HhXVHG2+rb+CNCh+mtzWSSsM00Au22qTanZQwKbiMwesWGPfg
	 avL6rbhKuPloKlpc/YBf3eaCzI+nmqpoxtl/g2nEePsb9eAXxtjFiletZnMVR5SH2z
	 zDhuLTfkDXXt+2wiIGYO+kbEA7b225xd5Q5biUxOQU1CoX1ENranOAOP9iKHaGwSW+
	 NE6LB3Y8qBWNG9PXkPYA/89yELo2EFfcjMZM8IWC62u79cEZqoPxWVf6G/cRxSmcn5
	 jUK9lfN+Wa7EkF6JaHua2wQDDVokQjJxCOzhdV64pHNDHRVUiVef7VZDK7TAmFNXlU
	 7y4Ksfs/NuGfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71A1660A3C;
	Fri,  7 Aug 2026 11:15:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 311D810E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1720060A3C
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:15:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dwMDkl7lE9a7 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 11:15:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2D80760909
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D80760909
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D80760909
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:15:04 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a1d11bda7fso1187038a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 04:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786101302; cv=none;
 d=google.com; s=arc-20260327;
 b=hA0f92CbxGyGK0ke9RKFoB9VaS2iXt1WqgHWyLOYz4scxSgE5F2YdkDy5KXH+OXHLe
 9nxT6O9jNEFVhno8tMlVwQlb5HdQ0bOsajfkMldcWm3MghPEa2P5Lnhl0euH2FIiPyOb
 oaZEZ8SxCzzWW+G3HbPFRk88a4LLY7tAjo6o4pibc1DIYvn9GgKJTTiARVvdqPq91fkJ
 0rJGRnQRlbDa5jfvyhc1UtkCnQMMRGpZy8a88JgUWUUjgqG33BFMuyGFApClTv9IUflq
 mklNnOsWMzOwgfwbo+ExzahHyEvbPjecNIiTlOjx/jcFnfvrSty4U5PPRsDD05vX+Ne/
 KL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yiDpAdEdnclEqOnXVaiptQWK1AX9lFuacFtJnLsGRC4=;
 fh=JATHIa1xEglVtBY1zkb/Za0M2ge3OEJqlDigme2D4m4=;
 b=We2NP3feA1WEVIXRsnwgX97WUEM32Mi2fPNAy+y/Ap01wpU69tq8yHh1AOeMei+VYW
 VWcxCkOY7u5Nc8XLQUUKz3ZRA/0XcM+Zzr6YnahockznJ1hXgQtD3yufO0fUcPQbwCIh
 cSRJ5b1txaBYOTf8L+0AtLpUcziO/FLEtws3ORbVCE/FS/0eR8Kxfk0Z4MolQNsVNaYp
 HdIg8VXxGytQR271hED7nWPVyYGATkIuZBLEYBMvM4bsBhO8naE2EQ12pfhU5XMT6SWA
 01xf/C7jfD5POTpc/VvS5lkj47XPx0j7hHDCuYxUlfKGcGwOPGJFAEnAKw0UQRKBaKjC
 mU2w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786101302; x=1786706102;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yiDpAdEdnclEqOnXVaiptQWK1AX9lFuacFtJnLsGRC4=;
 b=XamiGWtXImzOuvbrJ+mDfWzMFeNf9zvAVbIX3I4z1V+4ytgoO1sXO6OBuAF8uGdAnM
 PbaQGsxM7uAexbR6U2jfsix8DezOdjyupkTHi5m3a94IA+Gg8OdMmv+W/FDmH4CK/JQD
 81KG9ygcx4HSAz5qTHlKYi73pvaE36+tM16lZazUxf6gf3Es7GEdAgxeKX/9tfD13MGD
 R+ApSe4XH0BO8kTaz9kvbZYVoAHnyIOXmRa62SQxmXOqF+Gt5YMsS1zeYbpLZpT4Bp70
 IuoGK0/D8lsl6IiL04b9vPhud6FoqXCAV7thEgNo1EYeJK3lOCw4vMfpvq92QFmlKw1O
 UxPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFcZ2JJrCX9hLPmZsYGsK8K/L3o3azxi8go1VNNQSvmkQTcggQ8JxDFW1SpZBpWocdLNxqlH8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yypo1xnKGaY0JHJ8og2SozA0iCyMfodfg+Scod0iUD4+HMLMwxu
 cClG9IEFjxf+9mHM3LzFXTZlNdRRb1jCR8DN2Moy0BPNpmC9awBrY5MNSogmDSLAvB1yFRo80Ue
 6wx60ABWMbN+0EUVSeaTEqPmOrIWp/G68fzzRKx5Hcg==
X-Gm-Gg: AR+sD13qecGbMsylf44E3KR55+k6EV7Or1h/VOQFf6YJej4KdtFMAD0UlALTzrtg+Cs
 nf38CNolCU29QnxyBjRlHtoKjlgy8W+N06PgNlHUXyqzLEOSceqyx01nXUx9seoIvSyKoQmQGhe
 YXYNEAppU2QTG8FAYjLH7vvRxMM48Wlqnkq6ShLgzq9PzxkaRaxnESO525wIc3Tm7mkBdE4RUtl
 oDdkvvfF40048RwHOc/bLvopvaeID2UgN1Yfi8vL0yHFxfVPMobgv/HrjX2Rl/OPODfyOUcjg56
 eFO54tMqTntpsaGO994XJMrd0vmwJFj9wmOmO4eW3o7UR0/+DZZwYytVtx+vONiJPiuS69mBvvx
 uVD3/HaQqKnVhxhY7KWQbZySUgm2vDsuDPgVJCQ7g7pD2RLEg3eRqrTSj3pgShXs=
X-Received: by 2002:a17:907:9816:b0:c15:c1fb:e8ca with SMTP id
 a640c23a62f3a-c2039b2a843mr1141966766b.12.1786101301998; Fri, 07 Aug 2026
 04:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-mtk-mach-phase-aware-reset-v1-0-90b918aa52f5@baylibre.com>
In-Reply-To: <20260731-mtk-mach-phase-aware-reset-v1-0-90b918aa52f5@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 13:14:50 +0200
X-Gm-Features: AUfX_mxjhCIiYdEYbZgKN5WV1EKVCmWbAEVOafytgSX3Xemqh_fP6gJuZk0rKnk
Message-ID: <CAEHHSvYCrwxJJgM4iJKx8_OEHzC-NWNs-FQfnQbLE9-q4bLdCQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm: mediatek: use phase-aware PSCI reset
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786101302; x=1786706102;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yiDpAdEdnclEqOnXVaiptQWK1AX9lFuacFtJnLsGRC4=;
 b=VRFnM4CScrXCqdcGNQwTPiiBc2k89A3roHqy5gBSS8UYRcSr2k0ucwTcg/AlXzoxdU
 BpeA40ojt7wYkQT6vlGSVl7OOxO1913buq/VXOKsp52NJ+bD6THME/y/oXg8wY7NtZ3x
 is8LUr/ai6KsxELOMz2jG/2mP5dilNsd83OL+wpdyTjBAH23I0SijVT3iJHo0ODgJgB6
 mHPOCLGHDXpp5MKEpA4OINLRXjUj19aSr8lD4NEhH2XubKDfbO6/iyx4YHfV3meTQHF8
 qDrpBkgMB1NUpabmCZQYxAGDALXEK2lMR3LvnU3UzEfxcOUg9aL8M0Pid063KXfE/6A7
 gJWQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VRFnM4CS
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Le ven. 31 juil. 2026 =C3=A0 22:31, David Lechner <dlechner@baylibre.com> a=
 =C3=A9crit :
>
> Similar to [1], a couple of other targets need to be fixed before we
> can enable SPL support.
>
> [1]: https://patchwork.ozlabs.org/project/uboot/patch/20260724-ccaione-up=
stream-mt8188-spl-reset-v1-1-08da6554ecd8@baylibre.com/
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (2):
>       arm: mediatek: use phase-aware PSCI reset on MT8365
>       arm: mediatek: use phase-aware PSCI reset on MT8195
>
>  arch/arm/mach-mediatek/mt8195/init.c | 2 +-
>  arch/arm/mach-mediatek/mt8365/init.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> ---
> base-commit: 0d8724e128d17c106074d4789e1a8de60e4280ab
> change-id: 20260731-mtk-mach-phase-aware-reset-1a737ebecf5e
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
