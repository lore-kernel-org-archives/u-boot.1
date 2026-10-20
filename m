Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592B606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Psj3TgmP;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hJFZmUuL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C14280DF6;
	Tue, 20 Oct 2026 21:44:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30xgQtbaI5J8; Tue, 20 Oct 2026 21:44:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 64EFD80F24
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792532664;
	b=DjVM7XHa4ITpmHqUqm2WaP18q3+MbcCNviULL4DkYofZwXKA5zz7i4Inu3KVZxKUKgio
	 +CpGSWA0atVD93N/+1z4gQ30lLGIUkL9yTlp7Vv+wzoLVAISyMlWtGagiF9cB14O1SAqJ
	 MjhNcEEYCZYl4Y0RAknQQLg0vrbXkWmjjwo1soVf2TjslAscmWzg2+JgBXXBXpA9Glwe5
	 oMkwEdpHc4wlLz42nXAwu9iz69dckw9vp1Ez5UMte4tFr+wr0SZe+JRy7LvtBkTILKxHO
	 RfqVRHPERv2Pi7hHwE5LQO6k5PpeAbNXgjJfTEplIaYeKgNI5lsTEGopo2a1Jcv4riQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792532664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=A97A+J3pr25QsdZwkurCJcORKXd/H3XSVL7fkYOJSyQ=;
	b=IPPqrJC0QN61UQOX77FFhTED1+R2FzLzrbeYDQ/r3XwrYBWi+Nw4jJa/0icf4kfev3e/
	 8ZVZyOs5hRZYK7Uw0FnU676R0QRebhXLg+OfaIhRH1hONyBFW9JboSmF1qivc+tBaEUZ3
	 7CRztgelTxigz1dj7kGwDALSgAwQgQdveHf4PinQMwnB9zq+XhXsiJa21I7H3UTS4S4/W
	 7PiEOCnaLcR0egwDMPnepG9IXB149WfO0xe0tqT0KDqjLKhn0tqKPkChWnpfxsZEazsS8
	 CHbEhEWHR3pHlfzv9PpW4HiEIrZy+gKkaIMbMQq5a8QPORaD+jy7gAm00QpxZG0BeKw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792532664;
	bh=A97A+J3pr25QsdZwkurCJcORKXd/H3XSVL7fkYOJSyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Psj3TgmPDcinpw2rmHeRXxBx+KejLi+kwHBcnGALMZAmud86Q9kww6MNi1dWqfMn0
	 zZNuA5q7W8GUaOp2WMTo3icWqkh89sgwLUNGWYryOP16FrKLJpn8t6QKEEw+Egj6aS
	 3Z6cFbjkepGKSp3C/Jk8mFHc+x4aNv3xEdnRWaOfOb+SX9eAekQuJr2Y0nFtibxDQz
	 eHLcJ4ifWJAyjGQtYKfjlRINiAhR41w9oQUlhehJBFOJ57N8T3it2vn+3cI1i4gXVC
	 DxPUN9zo1b85a4UJERpKG14h0edowkaW0lBSCpdgT/D3i4Si3FGNj0nlWlU8Usr8yi
	 wwPDrjA1u4VSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64EFD80F24;
	Tue, 20 Oct 2026 21:44:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 770833A4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 21:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68B8B605D8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 21:44:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Z4UAquV_kjo for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 21:44:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 35FCD605E7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792532661;
 b=Osi9KwwyeEdXlHzHTZof4wKxaKWGgjumZ3CcSbaJaJ4F+5pdqXV8oZeKDsuLqzVp0B8U
 YZHSDxnNQQKBSREZBYJq9d2jL7PabVMy1cNbesJm92XcgfG/VAsAwWamAbKMYR2HAjeH8
 S9VQL3g9JFX1GHdAKtDt8/eYfUuOII/p2eYkisrHJ31NxdePUC7HtzTyhvV4yT9T8rzuJ
 PBoFGCNqq68tlfOyftjz4BuD5CoKxM4Ory+PVaeaePIo97XFQqCruFPArxyUUoNLWBDnq
 6xz4vp7bJDs16tO5RIgy8Nq944kbrZM+5CjJmDpo2pe79UGvGvkF8t29y66aycPNYmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792532661;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=A97A+J3pr25QsdZwkurCJcORKXd/H3XSVL7fkYOJSyQ=;
 b=nlp06RoEaxj+/pM4uFzx3pkEDAB0/Ux1VDPO2TgrwQTUllsGYeplVyCrMi4JC6yAwubN
 mhyNleHMjBfRuv1TszeqP2b0DV1COCAeCdzNZJGEFLkJQo3WNTIF7Cc+5Xyuk9BMZpTVQ
 XIkuVgk5mqYPxT1sS1ocEbgVEM4bLYJIQdY3ZoGow2eE2KN8t+RMUj5rXB4xHWriZb9VX
 2zEaZdhxCW0877GzwlQxEZqfm5ieZdty5BNPk9BaGFwJVJ5iJ7EOv9FWmzgR707rTyBz0
 pq+zHFfMvLeGpsBOWvnFcnXRisgRnPAhPfIzS2j2vKlpR+GnsIMSTWCMp7RvXzwHRtg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hJFZmUuL; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hJFZmUuL
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 35FCD605E7
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 21:44:20 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-43bf9548df4so148605fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792532659; x=1793137459;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A97A+J3pr25QsdZwkurCJcORKXd/H3XSVL7fkYOJSyQ=;
 b=hJFZmUuLx2So88g5XXqRPIVbIT7xIbT1XKfdMR9LFCkXsVkRS0+wXFNlyemNFWEQz5
 FFtvSZ+2DASSTgiRBWC+D71K+7Iv5+FGtc8jeL2a0wJIU7MmZy8nxgCjiaztOjVf81Nw
 eDEXVUfUk169CXnnQseTvC4nOLdDBaXc7VuKSaTi29ptb7LYB9GGkZaMmKid1a69tRu1
 9wvvu31zzEx/V1gGwpmKzvUpV9jrU6mfKO+j3bti4cpy60OmuFie4z5YdUJa/EtOXlzn
 CEaW8TiZyY4s7aXSzUIovzQrPo2YTpjCMGMp3j6z6r0mjxQcEVzxyKmFEYDJ5y/KvE4z
 zHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792532659; x=1793137459;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A97A+J3pr25QsdZwkurCJcORKXd/H3XSVL7fkYOJSyQ=;
 b=dOIQB5xbPnM6I+No1Sxt8eXyHocjBl9/jyGoIoW3u/OsxuBrlPx33Tdozian/d+jVp
 MmB3+tuBPq9E2ZYEycCruIJPFJROwT6NMsMY2X2zzXVKU8VbTJo5sc0Ftn4dM9rmVSDs
 kAI91r0DZall6xIJqiEaFiyAsYZf5swSHfVvzrGvWpwVGCIXwjBs9DuU+j9vvZnc+N7F
 q+cjwyVDUXSeU1n5+ytFS+blkq+/9DT0jfawLh8k0vPg7ksu8f/LpyI7ZT7srofDxHnH
 9egYMdf5MpNfpTeBUsVWsbPJi1UdfDn/PlOnNV7YkF8qwmUubrTaO5NBSuTGWHZod2rT
 YBiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw71UfLxCUKbJfz1nJ3js9+sN9OfN9HIssMvVjmZA3wQ2+QcAIfrAR73JV42ehHcuiHFhCK3nE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKm3A2+VpUuXLoF4MGDkIa7e8YQRKww/YaE7Y9AXVszv+v3gtcL
 ZlH+9eOGS3rGo2z/fzaRs8I/phWdLC6xjnAI4NGPYqhON7PEmyx7/X+4Jdhe54Adx1w=
X-Gm-Gg: AYBFou1spkO/ZsayYCQezJPgKEzb7+IITGWoBxBeToQYX1eU+EgJVDa17pq+C4y/cdj
 eJNhtcg+yn/SpOwexPXKlALebqVO+zwAIRvahk84Gsbsu7e9pOGSNZ91wng+AkYWPsIK7PZdHcM
 0a44DPXztqKe79VC7U4TeIxeuhIUQOmcS3KbqLUMPc6/8+wFgRZCENjjgfVTwrR+eqqQpdSuI36
 nADuTg8CEYj0cJmdSAWnSv9hNiHnLlNycJFYul36fJ/UBYZYBpo2fsWsBA+Tgn2X6bv6mMn3xwC
 TsHj2lbfOCXng3+VaWrS6Wf7fzC/ElTnFSwTam6XZ2EE+Ihl2XV4PseMoLmh2YR/+nzlqtmQ0FV
 yRG1JWh5kmS56pUqGjUBuMaygN1/gaaq9kcHv4l6SrQ/64YkKskc/Gl0dLkNqi6HUWj1vTIrwsy
 4jW/+vMiVIpXe/RboWch2nTJkkY3WlmnMK15eBCPPdKeGvmjLiEwPiJLfCPbPhkR916trJKLnin
 38YzWDqxGC/jmqG91ohQXkIzn5/2XE8qCE07Vgsy/XvX67QcNiHTDKKI0XN
X-Received: by 2002:a05:6870:8316:b0:49d:cac9:28ca with SMTP id
 586e51a60fabf-4a7dbf67178mr24381fac.2.1792532659493; 
 Tue, 20 Oct 2026 14:44:19 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a238:1d98:cbad:952a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d8ec2584sm248943fac.9.2026.10.20.14.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 14:44:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
References: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
Subject: Re: (subset) [PATCH v4 0/5] Add Genio 510 and 700 BootROM download
 agents
Message-Id: <179253248848.3711947.3606137530180818744.b4-ty@b4>
Date: Tue, 20 Oct 2026 16:41:28 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=666; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=usMEASwA3BWkKGm+ZxtPs9PBQlEhftlzM38HxHC5210=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq1+A7VSFrK/aGNK/k78PSZmZvKWshINRuyaqQP
 7mufI2hDAmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatfgOxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A1R4H/0NteKdaVoUyojDNs+LDb4AsWhuWoEqlJZk10qy
 xTAJ2K4FgdIOOq8l3+pUBZHqQV2tLx3eLysv2Mqr85WprkpFI7S/glajZJXmsj+ANnjhKTmKv4e
 31wx6snYSJj+G24gqRnSmmaO/8Ap/ijdQCEN+6U6M5/JPeAXEq55P4Y9hIaVQQmFxtAzM2CHm2D
 oM2S0WSAsQQ8T6Re0N6cywBxAdDmjZl+0jImKuKk02ts0QScng/19G5CIAd7jPU0RE22FaLZ79Y
 ALS5PNFY/Py6nnxpI9Ob3QMXKT4kfN5vuccQMmhvnnmcFSu4XiNjOv8IRrwu3iLYOPnh6VM5bFM
 RCiE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 06 Oct 2026 17:01:44 +0200, Carlo Caione wrote:
> Add Genio 510 and 700 BootROM download agents
> 
> Genio 510 and 700 need a way to provision blank eMMC and recover boards
> with unusable boot firmware. Add RAM-based fastboot download agents that
> can be loaded through the MediaTek BootROM download protocol without
> relying on the installed bootloader.
> 
> [...]

I'm picking up the first patch since it stands on it's own.

Applied to mediatek-for-main, thanks!

[1/5] arm: mediatek: simplify SPL boot-device selection
      commit: 5b24feeca50041bbae032ca1286bedf5badd759c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

