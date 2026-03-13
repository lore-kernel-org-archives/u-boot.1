Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85F5105F7B4
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D63784319;
	Fri, 13 Mar 2026 16:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2oBvQW9f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1FC28433B; Fri, 13 Mar 2026 16:11:32 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A8A18430F
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-899fac9caabso30372306d6.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:11:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773414689; cv=none;
 d=google.com; s=arc-20240605;
 b=T8D2+st5n24COhJZV3QDdTOV5bDh4Sruk2rlLQS1knQBg6MhexpPqq7fBtdoRuQuJ6
 pnBUBaUXWJLUb2MUJPXugE4pyiQUL4u0MZN0dsm7KPNJ+AnTrKTf05ZysLtQvd6SKnCM
 u53cJbX6CY1++VMggNIm6iRLWdeYT9DdVF3pQC9sF39OrNpLJjfTL+0/MRBkC1ZOZ0mK
 XsvV5E1B2wUuPfn+gHSWNporq/gGMiGcw8gqmMXsrzEP0dFJAKpx13jghN5YFktWC4SQ
 sCySWhLjkdqGdy8fxR6bItlv+aAY+bZU8wTHdi+cBh5PA04hXvAxDrdpZDEg+g9clmiM
 YVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rbFf67dgkM2lLXZqW9edRmQGSalGmrssbl3E/ct/RHo=;
 fh=OOkJ9mKVxdpVXS9jELpcN0rS8JiGzdGe+HPCQru3D1w=;
 b=PYSDwSH121rY0wmzHNhXEU7/xsjTydfGGt7/mnDyds09YdjiNcgPxuFZjgh4bhbeQk
 +x5fjoBKuPKZ5QvJNY2eHN+RIrnnUJ4MTRYURdWFhM6QiXx3cRwJ3PfKmsHMemDGfJZ6
 6RU5wO96WM5cv0GT1V8Mta+7yCi1Z5pKibSr7su+p2wFmka/FYcd2F6a+3PEmA7y96Nx
 Vtj7usb/WUtfRJ8RJZYaQ4bESAxFmpTf5/E+K5sqqdJ5BEZ52MSEAe6rLvmmTG0HAZ8S
 YiWYn88O89adRjVuLSaj8nduf3+CVqEtQO67oJ1D9UcNPlBZA9Mg5kGwyr7KkWmF6BPS
 MuuA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773414689; x=1774019489;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbFf67dgkM2lLXZqW9edRmQGSalGmrssbl3E/ct/RHo=;
 b=2oBvQW9fvxdOY3hosmaYW6yVKjaXh8qiAVaM2sDC+pv41a22fluDfWCbue7xNYHr2o
 TKWiF3VjDcs7f7nC+6HEZuZ2JroVVyl6tXw7LNccZG9MkNWQvpTBe9iKchdo4CUGvdWJ
 +9ZqAm3lkOQaFyYnKMbbsRFWOL1TV/TykLAFbFIDL2FjY01TWp+ENToDDeNn7eRVV2MD
 5zZWmYEuT+V16G0ooaLtOijOKUlolrB9C3FVCT9uYvfOYz8XjtwRrbCABjzMTBcn4x8u
 se7WuYyBCBF6zF8RKnPcO/YgjyT0J1pviOe6BS349C3KFInPkXAU9aHbU/W+GLAl+AAX
 7WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773414689; x=1774019489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rbFf67dgkM2lLXZqW9edRmQGSalGmrssbl3E/ct/RHo=;
 b=FxH4BfT16W2y0WAMsSesdhl+NR2uJJyGbpE/cDn9aSSmtK4EvgaGTTcVEoLPO6mQla
 +Q3ns72am8oLpyEPN+YTrnqn3vS14q9Xz5Ospcm5CxHn0iqlLW/1WRqwGA9xgObJlNE6
 Swf8T0lYe7uPeJuZbJeJUoE8G4q2Fzkka079Ca+6Ee4ko1lW6zSKUBygEpmrY40hEKBT
 lriQircOoDPBxGYhNDGZDB1exXrJEqwwyQhLrI2ZkSRahzNJmBCitAhH23GLDX2HO/Hx
 obJhDOojp/JMeqJ53iK2yQvWBGOaLMRLVJwVWLeb5hOjGLyUu2RHgcuceEDXgHxYtZlt
 vj7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXgO1nEmOMvgcYAmQ+L2xlvrbH4YScvibdGETfmsoPZlRZwpAKXRm0By37prURawi7DAWRISY=@lists.denx.de
X-Gm-Message-State: AOJu0YxFhvUdgNfAzvSDhw0kdCDyulygyGxeBuXI3wcmyWGCVYxddI39
 pouJzMUR9gs31Wa4Mda6Gfa1sFreZUxvqpuwSOXWM2gPf8ZLeqwSF5+HJXqtJEkGaezCLbTN+Sp
 VTBmBMCwbfjBbRpr68NAVPrsQzmaqQ01GmSn8ew4sXQ==
X-Gm-Gg: ATEYQzwto05+MzFnh5cV0nHEmAFV9zH4oWmC4AGFcSxGS2YADShpjQ8fPynZGxTqiSk
 q37ll20NY4qN8M1SIgWCZ9+R1N81CRgHafZzsfEtyhcS2COI6TYbCsWKOEnTq6CeunISrWrgyjl
 yCbUwHqIXzVP+2AJTnom1zp96zV7i4i8O+CmPe7QrpucjwlTNekZsvzc5EOfBfclCORNiTFx61C
 5JX4IEgCIBw1/mY3eglx9laE6xQU2YDkspjLgIM5hZJKhauWHMtVoGhaXsDbAddEIocEJYikAJ4
 a6sWp/60jKYS29zmJNEaqKKuJ4+jpLU8XuvouXSVqo0igpsJY0ZM9zPLpE2VBxB9eUp+yJvAPvJ
 V4o/tI6X1X8yxkAxaYx4g479X3w==
X-Received: by 2002:a05:6214:dcd:b0:89a:126a:5b7d with SMTP id
 6a1803df08f44-89a81d3293cmr59001706d6.2.1773414688463; Fri, 13 Mar 2026
 08:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260309-clk-mtk-mt8188-drop-extra-top-clocks-v1-0-6ee4743a8465@baylibre.com>
In-Reply-To: <20260309-clk-mtk-mt8188-drop-extra-top-clocks-v1-0-6ee4743a8465@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 13 Mar 2026 16:11:19 +0100
X-Gm-Features: AaiRm53un7xcCaqIBnI7wu8fxAja3vb_PVJJ99DKh5qBCsDsHIQuDglx8YWdLmY
Message-ID: <CAEHHSvYO2LBZQ91HfNfW8YVmT3+v=mLoXvL-SgboucGgYiQ_Kg@mail.gmail.com>
Subject: Re: [PATCH 0/2] clk: mediatek: avoid more "extra" topckgen clocks
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
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

Le lun. 9 mars 2026 =C3=A0 23:51, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> This is similar to [1] in the goal to not add extra #defines for
> topckgen clocks that aren't in the dt-bindings, but in these cases,
> we are not able to fully stop using the ID map.
>
> [1]: https://lore.kernel.org/all/20260303-mtk-clk-8365-drop-map-v1-1-17f8=
1c375290@baylibre.com/
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (2):
>       clk: mediatek: mt8188: use ext_clock_rates
>       clk: mediatek: mt8195: use ext_clock_rates
>
>  drivers/clk/mediatek/clk-mt8188.c | 741 ++++++++++++++++++--------------=
--
>  drivers/clk/mediatek/clk-mt8195.c | 820 +++++++++++++++++++-------------=
------
>  2 files changed, 811 insertions(+), 750 deletions(-)
> ---
> base-commit: 36add050eea439f0b2a15e4ea0d3a8e21216f159
> change-id: 20260303-clk-mtk-mt8188-drop-extra-top-clocks-5bb5a693a1cd
> prerequisite-message-id: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@ba=
ylibre.com>
> prerequisite-patch-id: 81f2dd4fd7c1632736c08180d6b9f6aef5fe1e7f
> prerequisite-patch-id: 60f0509a5f36c2828316fa3e27dfd8f4d218eb27
> prerequisite-patch-id: 237c548edf19f9cf734b1ac3b9252a4f06d8cf29
> prerequisite-patch-id: 22de64f70e8d1ba5e17f8b31f461118b35e54f30
> prerequisite-patch-id: 3d5661f9e55292a30f57617848a7b10e67844402
> prerequisite-patch-id: ccbc73b2bc1dc41beb295604088d63773cea15ef
> prerequisite-patch-id: aa76b6b028374f20551955eafe56a1e0c1daa75d
> prerequisite-message-id: <20260305-clk-mtk-fix-mt8188-rates-v2-1-0ce2b521=
2775@baylibre.com>
> prerequisite-patch-id: 88e5a61d8ad8543f0fdf11f35bb6dba637d49550
> prerequisite-message-id: <20260306-clk-mtk-remove-clk-bypass-xtal-flag-v2=
-0-b253b49f17b2@baylibre.com>
> prerequisite-patch-id: 15ac11765ddddcf378e0e227a9fb5876636aa8e6
> prerequisite-patch-id: 90b4781a99ea5eb40eb6c943dee86dd8a9fabe06
> prerequisite-patch-id: 150153a03fa40f8f9d790526512f7341a7d95eba
> prerequisite-patch-id: bdc28e831956d0a487c62e11d1442a51b9548c25
> prerequisite-patch-id: 08b3b97b5870fa4c5eb435f5b19762481a94c058
> prerequisite-patch-id: 291f87bf8033440b0c79a03055cec7e1317216e2
> prerequisite-patch-id: d3ff487de22ca508a65613bebf8cbe0e61005a31
> prerequisite-patch-id: f0e2edcbe17f6bea4bd4e6ceea49cbf73b7568d7
> prerequisite-patch-id: 0700411359ab89ebd24c4c3d17a5864e41289547
> prerequisite-message-id: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea7=
4b99d@baylibre.com>
> prerequisite-patch-id: 8789067dee5193eac9889bdb35cbe53fd8ba3db7
> prerequisite-patch-id: edb2b9a5644e0deb0b846cb6365957e8cdd9e9d8
> prerequisite-patch-id: 14723a8815ed459c3995ba2682344f8c6813da74
> prerequisite-patch-id: 5c528aa9c92e9d79fe406bca97192624f0267db9
> prerequisite-patch-id: c5a12abe7b61f253d13966fc6b257995f085c7b0
> prerequisite-patch-id: b4f5a8dafda57305a07cfc3783d7154558f515a6
> prerequisite-patch-id: 9a33fdfe476f6dc0e9e314755073d308c6a61a1e
> prerequisite-patch-id: 2daeb61c75b459c5c790266c329439a0fec5f50c
> prerequisite-patch-id: 29f06542d7c519b8995bcebd04b800508cf32d1d
> prerequisite-patch-id: 2d8a751c3012596e64b93e5361c7a50c8ac0a303
> prerequisite-patch-id: 85f6c9b692293d482d04bb3661fb51dfb5533ef0
> prerequisite-patch-id: 688b2021a1585ae037c15081cf43e62d95e7c286
> prerequisite-patch-id: 10f08bad47e8a2e6953c59540264dfa9ba433c1f
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Hi David,

LGTM, tested on genio-510-evk and clk dump looks correct on the platform.

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
