Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C56606A337
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xm9M4h66;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bImxsuf7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FDBE81298;
	Wed, 18 Nov 2026 23:20:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OJoJ0Cdc_V8m; Wed, 18 Nov 2026 23:20:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D55A78128C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795044022;
	b=d65flRtoVTH9DbiF8vmPfHu/COAC5cwl3Jc2/31c0ywuysljTykfufrvqPd1FnLF92iY
	 mW1Wn7wiBkD0QMlWpJFH15910GZEbjjkFmW3xiWoqT8U+M0wgY1E+cU2Wjby/5FGH2dMw
	 UF1SQtgValo+pWI2j9ZjeuqxxHPdIpYjhyD+lVJ1LdwMwialXaiVRrbhjSfTyWSodlW1/
	 YT3R4BdgkM4anI0XW1V2K/tPaw1EXlmIkSueEkxvwPNtrUCBXoHE2CKQk74DSnbZNgW6k
	 2xwX5r/aJ3KBiiMmIvSxQLEbDIEmWZLCna+v3CVbHFaLh991/uIvAi286b7UBbjL9xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795044022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jNyvpx9izxl8aUbCNJvV/gTkCKJ3UpVc1BzWyJzyyDw=;
	b=c4qLAvtjA//B3RUfgyvCwYEZ6GAeYtM1FVVHVjAiIp7XH9AmXdFcmGcmjewNqt18DbiA
	 Mu3ZWMRgw+UaU3KSyqGd7uN7yDyiqBnl+tT9ljjU0E/P3dFSJATG7IQEr2RI2/vVNu5iT
	 em9l7yf2S/pzZ/8/BRSq/xjI+ieY9UAKXECL8uS4mrJAKBg4JSVjrut1BUdfEn9TlCt/1
	 TCv8OaC4UfAHyqVV+fUJYjqUEFnBnhPwi5LVyS1vE5NjC/6/5ax8sGy3ztU5r76lZB0F/
	 CjhCD+80rPNkO1QZe670QaVIW7kYCRtA5Y3hedEVRInIGliS3/I2av32g+rxHSMBfoA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795044022;
	bh=jNyvpx9izxl8aUbCNJvV/gTkCKJ3UpVc1BzWyJzyyDw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xm9M4h66yUY5oKtjrcN9rqYCQB4PX4PjKzwTTGAcbKXO2o4g7woBJbRK/zZwHC2ym
	 P5QkoLA753cOZZhWD3K11wx3pCQnsB4BsGnW/1S8SW0/ODQ0HfsoZNN9Cfvq8FH2c3
	 X6f8X75aoe7c8jwOD6MxW4FQCFK5a77dhY46r8ALqBTk80J9P/MAqVaMaMzIjZMXx/
	 Hw22oeMrGa5QVMatgsWWM7AGF/bbP1ObuxBPFhXS3iXgpW5nYv/RJXMcKonKbJ+u/F
	 DV/k+VFKoqT1IKS4pGsAhKcjT7VKwb79We/fSOxgWglW3Bs1dyIt/86WJZAaT0A3SD
	 uxfKNW5971ufQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D55A78128C;
	Wed, 18 Nov 2026 23:20:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DCAF722B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C28D3400C8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TXl0y7t69j4q for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 23:20:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3849F40086
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bImxsuf7
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3849F40086
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:18 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-85c1135c286so1192848a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795044017; x=1795648817;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jNyvpx9izxl8aUbCNJvV/gTkCKJ3UpVc1BzWyJzyyDw=;
 b=bImxsuf7l+32XDGoZm+JI4UVlRH/UXs170jD02PySXzpWv+KRJkRvGnwoRuIW0eQUm
 wAMBEyVk9BsvwpdXQkHA7TdGpEDXoT289ndv9kwO7iHEN3YywAvU01q56HZ+ULiODtWg
 tSxYwAhi83mbFqCrIJZTjDl+rJBJkzA8+1le+dKXy49ZkRLUTZOjAi52QLknDyQ6XoNk
 nVMbp91xDrcKI5GJSO5/ta6j0YBCjeuBZIPtJQWIw1K3us5evHCUXdfcpU87brH9HI9N
 Q6QbPV/70UGD2KX1hc9JYt9p3TdoDzHl52/TtGq0eqQKls0NOMZzL6pWsL3tq267excC
 oGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795044017; x=1795648817;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jNyvpx9izxl8aUbCNJvV/gTkCKJ3UpVc1BzWyJzyyDw=;
 b=bq1NtjTQsPL1/Mj13f7LXw8GpI1amEOsJUwgNc7N9pvmPY2wiwt+pIi60RRFb5dlcL
 bwwv3CcJICwEMAlUCc47WxeWxOlgL/ZKCv3tGb4P5Du3sPUVgNx9XkXJ2845dKKj+f+A
 ALwP//4h/5FLgRfTUKDHsueRPgOC8URqEeLemVjBqxvl1S0NkWZCqQ2BG/FBIBj0PC2C
 cp5PkQ3ZOJjmVS2+XKGR49H480Z5R2Sgdkje14CluII9xLjknnDI/+hm2IplNAo+Z0S3
 8g6kC2BajrC2owviiUo0kggWeW6XKv6VJIZFoh934poE0XM+Yb6I1OaPpEBeAMVmtwRH
 QNYA==
X-Gm-Message-State: APuU4Z82mGYh7rR2U1TXk0lAiZ2xPlNXMcb12rUsS1snfWUk/0bIdZhC
 MMKq4ArmzlyDzxvin/FqVjEih8ZkgfUc5uUgwydUbNwTUxn3mwo1F3TruH28ykUN7Zw=
X-Gm-Gg: AYBFou1luBQAtZRfRJB2jonBg0XYDmUNQm5NEPjezL6bqkp07pgrkJmvnbc4eCP4Tu5
 URZxAqdPh5PNAZTDoz2hAxQMs+luIu1IJ/CH+dCN3wkCkEH8L51eV+LRHTA/iri2hZmO57ZO9o7
 c+SWFbDabg5/nksYPXL5IgE9PnN60Pu+TJ9Gf4+wAl34kS8+E3ppQvqWmTRysD6J4jbKoni4nYF
 2zi5c/+d9N/aJK0WfKs9gHVjwaX3/8s+cPw/iotfmr9J8qSfQUBIDf7wOl/rSjlzeeqq81ZjcR8
 9V0oyWs+Rpz0h1FSINwsmSpNo8fZ05o8c0Q1o/fcz31BfYwTNHyQn2jJyyXgaedz+ZHzbF9KR1N
 Pn177kouk6Tt6OsY8l/4xQmSR5LWiaZoDgL6/41oH+uXGqpsqwPsqOJUJ2SDk3C0hZDXG2JiwIf
 fMj1K/7OYRrx38FrPgYwHcos/hynp8wf4qcDrHPKIq9oHlnbqSA+VJ+nWDblAqjF79WOkciGktq
 rsIuMxD51eub2IG3ev4z0K5Q48I8WuS0MOAqls8aYHrGaf+GnixlmqNM735zTsD0fOxnbG3Jm0L
 VoGjXP2iHF2BHgNgKlo0BTgwZsBwperL
X-Received: by 2002:a05:6830:640d:b0:817:bb8:cb7d with SMTP id
 46e09a7af769-862f0924acamr4888926a34.18.1795044016962; 
 Wed, 18 Nov 2026 15:20:16 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9834:2835:378c:43f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862f01d4764sm3025878a34.5.2026.11.18.15.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 15:20:15 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/7] mediatek: genio: one defconfig per SoC
Date: Wed, 18 Nov 2026 17:18:59 -0600
Message-Id: <20261118-mtk-genio-one-defconfig-per-soc-v1-0-1505d27fdfcb@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Qy07DMBBFfyXymkG2k46TCCH+A3Xhx7iY1k6w0
 whU9d9J20h0gRDLK825Z2ZOrFAOVFhfnVimOZQwpCWIh4rZN512BMEtmUkuUQjRQpz2sKMUBhg
 SgSNvh+TDDkbKUAYLrbXOS2WU1IItLWMmHz6vhtftLZejeSc7XWrXiUwfx0U93cZ+zH119XJR3
 3mV5FDGAwiUvBFoUcqmnyW7X/lP8OgLNNqi9qp1pHg/i99gwfEONiFFncBNBiw3hJ3oqLNuZSO
 Volf4af0V3siL9WLMYzQQQwpRH2CWwMFgQ8v/vOEeX4z+OgST6dEO8fn/t6QhQ2dROZRU16jWf
 YwuBEtTDFNftYI7JWpp0fO6qfmmbb1vNk5bv1Aofd1x3HQt257P3/H0S0MRAgAA
X-Change-ID: 20261118-mtk-genio-one-defconfig-per-soc-8ccdf27b72a1
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=19426;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=v52YEpf40xCjUVu0mXLc9qur0XCiDuqDHo3Ij97TbFY=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/jJ5Gh/E+f5BdVIHliLMvfwXPhxj6Im90GqAp
 oF8t4g9Ph6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav4yeRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AYuwH/RevZ7OC58N+CBmUeG7PYpAxHA7qNbLY68OmsXu
 6r3uhbkGPO/J2nf+qeLq98FT/lzfXoq38DOue9pL0C7XlGoO5mayi35/QZpfQcpLAgQJMu1yp4h
 eRaQ1FhbHvQjaoddTCs2A7q96qRf/y9MpEbQpT3ypZzRKy5rccgqHEt8IX0ssjsEadhuC1gPMdp
 4NbuKUkphpSqKXNJGwY3GzisRn2bjah6I706SZjERZmTiO3euFcZrsQgtxBZPQi/hP2lIu2DLi+
 nuxIqa/zArLOYlHyGgqkpDA0SMoshbIPZjX2DG2C7GRSPacnj4Vl0jAhr+IWdkon8QTsaAB1+LH
 5Jbk=
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I have started working on download agent support for the Genio 520/720
EVKs. While doing that, I realized that if we continue to follow the
pattern of multiple defconfigs for very similar boards continues, it is
going to get unwieldy.

As maintainer I build all of the defconfigs a lot, both locally and on
CI, so reducing the number is saving time for me too.

So I am proposing that we have one defconfig for each nearly identical
board (e.g., Genio 510/700, Genio 520/720). And we can use the
DEVICE_TREE= make option to select the appropriate (nearly identical)
devicetree at build time rather than having separate defconfigs for
just a different devicetree.

And for small modifications to the config, like the download agent
builds, we can use configuration fragments instead of creating separate
defconfigs. (I still need to figure out a good way to build this on top
of the defconfig to make sure we are getting proper compile testing,
but that is for another time).

There was one other difference besides the devicetree in the defconfig
for some of these boards, which was the RAM size. However, it turns out
that even the same board can have different RAM sizes, so we need to
read that at runtime anyway. So the first patch here addresses that.
Then the rest of the patches are weeding out the defconfigs and updating
the docs accordingly.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (7):
      arm: mediatek: map DRAM from the DRAM banks on Genio SoCs
      configs: mediatek: drop MTK_MEM_MAP_DDR_SIZE from Genio configs
      configs: mediatek: drop DEFAULT_FDT_FILE from Genio defconfigs
      configs: mediatek: build the Genio 510 EVK devicetree for Genio 700
      configs: mediatek: list the Genio 520 EVK devicetree for Genio 720
      board: mediatek: turn the Genio 510/700 download agents into fragments
      configs: mediatek: drop the Genio 510 and 520 EVK defconfigs

 arch/arm/mach-mediatek/Kconfig                     | 18 +++++-
 arch/arm/mach-mediatek/armv8-mem-map.c             | 44 +++++++++++---
 board/mediatek/MAINTAINERS                         |  3 +-
 .../mediatek/mt8188-genio-da-spl.config            | 16 +++--
 board/mediatek/mt8188-genio-da-uboot.config        | 71 ++++++++++++++++++++++
 configs/mt8189.config                              |  1 -
 configs/mt8365_evk_defconfig                       |  1 -
 configs/mt8366_genio_360_evk_defconfig             |  1 -
 configs/mt8370-genio-da-uboot-fastboot.config      | 29 ---------
 configs/mt8370-genio-da.config                     | 12 ----
 configs/mt8370_genio_510_evk_da_spl_defconfig      |  2 -
 configs/mt8370_genio_510_evk_da_uboot_defconfig    |  2 -
 configs/mt8370_genio_510_evk_defconfig             |  4 --
 configs/mt8371_genio_520_evk_defconfig             |  4 --
 configs/mt8390_genio_700_evk_da_spl_defconfig      |  2 -
 configs/mt8390_genio_700_evk_da_uboot_defconfig    |  2 -
 configs/mt8390_genio_700_evk_defconfig             |  1 +
 configs/mt8391_genio_720_evk_defconfig             |  2 +-
 doc/board/mediatek/mt8188-genio-evk.rst            | 37 ++++++-----
 doc/board/mediatek/mt8189-genio-evk.rst            | 25 ++++----
 20 files changed, 171 insertions(+), 106 deletions(-)
---
base-commit: 810d7132c6f03430588ff45dacf62e62f3906598
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git mediatek-staging
change-id: 20261118-mtk-genio-one-defconfig-per-soc-8ccdf27b72a1
prerequisite-change-id: 20261013-mtk-genio-720-spl-1620416c6224:v2
prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175
prerequisite-change-id: 20261013-mtk-genio-720-spl-ufs-4ac6af78de70:v1
prerequisite-patch-id: 79df99b8a797eed3bedbfcbafb7cda7e019f0445
prerequisite-patch-id: bc8ebcd6928771bcb436408a6c10ac4f00b2c265
prerequisite-patch-id: 0f5ccd0db365686315ced7255063d0404cdf5250
prerequisite-patch-id: a435fbd4cca84219d404138e2d8ee1a96d669366
prerequisite-patch-id: 4407c23f51001d4996a8e790270825fd8281d7f5
prerequisite-patch-id: 14bb13c537f635ee2589d626e0031e9a80c348d5
prerequisite-patch-id: 0b59a9f24e103a77700ca1cc99052ba318017b9d
prerequisite-patch-id: fc1dc7d141126db709479fb8477fe11536e6811c
prerequisite-patch-id: 2b22eb0b87c0c9e5c35e0b2719eedb3228503dbf
prerequisite-patch-id: 90108657775725ee881493b1af8e2ae51c8debc9
prerequisite-patch-id: ba3b4599b6ce497f7bf5bcafd2c93c89a0c7f5d4
prerequisite-patch-id: b47cebc4433bc3a0e5c3932a8cd64afea88d32a9
prerequisite-patch-id: a8a6f8e478b4888ff1c6affbcf14f1bb801f6cb9
prerequisite-patch-id: 537ec57f093f5cc68529116aabb6fec1296e9ed5
prerequisite-patch-id: bcd4644665e032714d68c49ad9afb36b25b9f418
prerequisite-patch-id: 1eda3254e8ba4f67886c788467d5cb3e706e51f7
prerequisite-patch-id: 0396e7309b235e7a577aa54549f260d6561d6cc5
prerequisite-patch-id: 3ff8b871bc763b373ac93eb095a0ac362f4fb4f9
prerequisite-patch-id: f3288ee3e395bff11655165a34c9617be55cc52a
prerequisite-patch-id: 893c19a121729050c2095888af67d5cee32c67d1
prerequisite-patch-id: 8c900b341eac7dd1b2f69a434b2fa808ac79e914
prerequisite-patch-id: 180113519aa422aef5b1d6384c8e65a943482cf5
prerequisite-patch-id: a5493d2e60617de14414c25c63d9f77f3fbc7ca9
prerequisite-patch-id: 3b798f71b18533fa36c3864daaf3b60099201097
prerequisite-patch-id: 731b2a85b293eb24b8a9ad5cbd4b2052591ec9d7
prerequisite-patch-id: f44798150ea9c5cf44a43ba0ee5561ed6d522063
prerequisite-patch-id: 01bd0fde93d212bbce964da6cc85f5aace84bddf
prerequisite-patch-id: c5662096f7f5cc7abfd5b178e145fe006737152d
prerequisite-patch-id: 74e53343d8fb0f2e7baee9848b7d81320910ed4a
prerequisite-patch-id: f018d9e03bd324a7853ab106eaaeb770f20bfb1a
prerequisite-patch-id: 95e0ae837a7ba3ca39b2a4b8421ac105234d677a
prerequisite-patch-id: 88e610436d6e9630fac7212c08251727fbe27fc3
prerequisite-patch-id: 0949dcf268f48d1fb7ee912fc57188b73fd4ae58
prerequisite-patch-id: 1474c68c12a790dc0abe513ffa5f71c5d72934eb
prerequisite-patch-id: fdc92399e83ba67d6f157e7e9fec546624226db6
prerequisite-patch-id: bb0f680620dd60fe1f55507198c1daba04d51ca0
prerequisite-patch-id: b60ed43a099f02bf9743f90a7cf474ca844d71d2
prerequisite-patch-id: f18d63e4e8c0ca8f08573f2395dd58b698e1da27
prerequisite-patch-id: ce11ab44a0332ef9682d3f6cb34a5f8648a1c619
prerequisite-patch-id: 3c5e447deebe943a6b8a98c2d017d1c0eab5da25
prerequisite-patch-id: dc6c98cdbffe9b3f19b8a0fc303f9b2902defa07
prerequisite-patch-id: 558d3536869699311008e4d6cce6a2a18a727eca
prerequisite-patch-id: 805a0898b88d8e1291e8262044d1d6bed1d45be2
prerequisite-patch-id: 8d7155ea7c0941b756129b6a490f9413b51b05ef
prerequisite-patch-id: 974eaa9cb6adf9749f6225fe1e67dd9433318625
prerequisite-patch-id: cdb2934ed5393e539f856e6f4de36140cd8ad697
prerequisite-patch-id: ab91736213909c77894d8e47594f548592f96bb4
prerequisite-patch-id: 15e30b35b9a32d98cea92287c95973bb55655b8d
prerequisite-patch-id: 74b01d9723a9eebb7a438ae6f3aa84fecbd86a2f
prerequisite-patch-id: 84ffa226fd432b97e30508988d556056f19488d8
prerequisite-patch-id: b6ef8f19bc0e45642fadc98a2a70a8a77e16cc31
prerequisite-patch-id: 6d301cbbd2d389bb156e2f9565f02c7d1eb9fed1
prerequisite-patch-id: 21aae4cff1307c55e73d737cd68552b6ea1b73f2
prerequisite-patch-id: 110fc69a696fa4dd74fb7e14a50c97e3b7238a9a
prerequisite-patch-id: 2ec906b416c75e44362332459fcd498872a22124
prerequisite-patch-id: aceec0866b3329401896512d235b7e01dc1746b1
prerequisite-patch-id: 41d8b9c212ca0950fb1ccbea92d8f62a3c42676a
prerequisite-patch-id: 94bec74d37c3b2d2b22ffc303d8f2ac567db22c4
prerequisite-patch-id: 4391fbbb5b04123f46d3eb3ec7b183be7152d338
prerequisite-patch-id: 08e009e1d4f6ef7fffaddeb82f9e35692bd593e4
prerequisite-patch-id: 14b40c9224527e76382332cf547d070f1d3a40ed
prerequisite-patch-id: eca0139a7cedf72a4e8a99324a846dea15392e4b
prerequisite-patch-id: cde323ef8d773b7dad5a278faaca89bb71405ab1
prerequisite-patch-id: 6abe9e3824531990933ada4bd58ff483637f3794
prerequisite-patch-id: 4344564d375dc6002077d382335ce759523ffa29
prerequisite-patch-id: 316b1610fc2e3953677ec152eee8cd5035723f82
prerequisite-patch-id: 55680c05d9c25c1a5fbd05e2b9f91a5bb1e4c350
prerequisite-patch-id: 2aa06c6d07b125147e3a6bcdc620e19f9c5885df
prerequisite-patch-id: eb93f71f16b3641ae6a369b1b3113656656f65e3
prerequisite-patch-id: 575d26f405980ef8a1be726c9ca0df679eb77d84
prerequisite-patch-id: 6b9e9c6e1f9cbc0ef3b716cd8615430680354877
prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175
prerequisite-patch-id: ef70f6dcf4e6aea68256028734614efc067c954d
prerequisite-patch-id: 75640c82cbccc2f173feb4bc6c912c9a321a68c9
prerequisite-patch-id: 569f315372b1b8f55a5a94f1385175252dc33b9f
prerequisite-patch-id: b43d50f060dc034ad413c28153ea641e697e5655
prerequisite-patch-id: f5f6fabf8e9a55c44413a76791d3713fe6415a33
prerequisite-patch-id: f031399df28961dad8315ffa6ad1ee0ff77116ec
prerequisite-patch-id: 8064ba5bd7cf2db6d127f981b3731001c71d58f2
prerequisite-patch-id: 6c889af47fd9df264bf4dc2758c18418c175dd3b
prerequisite-patch-id: 6c44e76abdeb8319ce17dab256fb99ea6a5e77ea
prerequisite-patch-id: 4680066fad4dcbccf016541a4847c7ace62e2e06
prerequisite-patch-id: d7159d0635ba309d374f519b37fc39dfdd15d0eb
prerequisite-patch-id: 070be0db29756ccd90ee239cb9ae5c3b6748cf93
prerequisite-patch-id: 93318a4ddebf24432063549989b91d9ff998bdec
prerequisite-patch-id: 55ead548e0a7c82c4296cc9b9fa047f110c1e306
prerequisite-patch-id: 34bbdb130ae694420b954f41a536b8eb8df77791
prerequisite-patch-id: 5a62f8304a1790b31accf47af84815bffaa92b89
prerequisite-patch-id: d2e87bf5a992d19bde372fb230f4589242f12d40
prerequisite-patch-id: 0429aaac18b3a3d564662f2b93aa3af755c880db
prerequisite-patch-id: a577a9e2266f5b16dd0bf1b8b4312952f736380d
prerequisite-patch-id: 3223b00fa7e9c330054e19f256b4e601008160f2
prerequisite-patch-id: f1cf16250799f803bde22d6dae704cc5338ec76c
prerequisite-patch-id: 781986f407c7f833f3a157bcaa9b6384f964fe11
prerequisite-patch-id: bb9dcec311319f2dbac1c3795ec19fc44dc5bd20
prerequisite-patch-id: d56476ab6a3a7b32a29eea6c811e110a127dfc65
prerequisite-patch-id: 0d9bf4d3f321845f908bc96dcf0b844c14701218
prerequisite-patch-id: 24910c0e34355ac74ac3e0701e24d09e18450b90
prerequisite-patch-id: 640fa47c52c8d79ae409b7077e030cfe8d336287
prerequisite-patch-id: de19c1094bc466beef1d7d648974f925f7cbfb91
prerequisite-patch-id: d98337a0fb6f5db044fc303476f609e4d0a5bc0f
prerequisite-change-id: 20261106-mtk-genio-binman-dtb-c0be6919e9cd:v1
prerequisite-patch-id: 79df99b8a797eed3bedbfcbafb7cda7e019f0445
prerequisite-patch-id: bc8ebcd6928771bcb436408a6c10ac4f00b2c265
prerequisite-patch-id: 0f5ccd0db365686315ced7255063d0404cdf5250
prerequisite-patch-id: a435fbd4cca84219d404138e2d8ee1a96d669366
prerequisite-patch-id: 4407c23f51001d4996a8e790270825fd8281d7f5
prerequisite-patch-id: 14bb13c537f635ee2589d626e0031e9a80c348d5
prerequisite-patch-id: 0b59a9f24e103a77700ca1cc99052ba318017b9d
prerequisite-patch-id: fc1dc7d141126db709479fb8477fe11536e6811c
prerequisite-patch-id: 2b22eb0b87c0c9e5c35e0b2719eedb3228503dbf
prerequisite-patch-id: 90108657775725ee881493b1af8e2ae51c8debc9
prerequisite-patch-id: ba3b4599b6ce497f7bf5bcafd2c93c89a0c7f5d4
prerequisite-patch-id: b47cebc4433bc3a0e5c3932a8cd64afea88d32a9
prerequisite-patch-id: a8a6f8e478b4888ff1c6affbcf14f1bb801f6cb9
prerequisite-patch-id: 537ec57f093f5cc68529116aabb6fec1296e9ed5
prerequisite-patch-id: bcd4644665e032714d68c49ad9afb36b25b9f418
prerequisite-patch-id: 1eda3254e8ba4f67886c788467d5cb3e706e51f7
prerequisite-patch-id: 0396e7309b235e7a577aa54549f260d6561d6cc5
prerequisite-patch-id: 3ff8b871bc763b373ac93eb095a0ac362f4fb4f9
prerequisite-patch-id: f3288ee3e395bff11655165a34c9617be55cc52a
prerequisite-patch-id: 893c19a121729050c2095888af67d5cee32c67d1
prerequisite-patch-id: 8c900b341eac7dd1b2f69a434b2fa808ac79e914
prerequisite-patch-id: 180113519aa422aef5b1d6384c8e65a943482cf5
prerequisite-patch-id: a5493d2e60617de14414c25c63d9f77f3fbc7ca9
prerequisite-patch-id: 3b798f71b18533fa36c3864daaf3b60099201097
prerequisite-patch-id: 731b2a85b293eb24b8a9ad5cbd4b2052591ec9d7
prerequisite-patch-id: f44798150ea9c5cf44a43ba0ee5561ed6d522063
prerequisite-patch-id: 01bd0fde93d212bbce964da6cc85f5aace84bddf
prerequisite-patch-id: c5662096f7f5cc7abfd5b178e145fe006737152d
prerequisite-patch-id: 74e53343d8fb0f2e7baee9848b7d81320910ed4a
prerequisite-patch-id: f018d9e03bd324a7853ab106eaaeb770f20bfb1a
prerequisite-patch-id: 95e0ae837a7ba3ca39b2a4b8421ac105234d677a
prerequisite-patch-id: 88e610436d6e9630fac7212c08251727fbe27fc3
prerequisite-patch-id: 0949dcf268f48d1fb7ee912fc57188b73fd4ae58
prerequisite-patch-id: 1474c68c12a790dc0abe513ffa5f71c5d72934eb
prerequisite-patch-id: fdc92399e83ba67d6f157e7e9fec546624226db6
prerequisite-patch-id: bb0f680620dd60fe1f55507198c1daba04d51ca0
prerequisite-patch-id: b60ed43a099f02bf9743f90a7cf474ca844d71d2
prerequisite-patch-id: f18d63e4e8c0ca8f08573f2395dd58b698e1da27
prerequisite-patch-id: ce11ab44a0332ef9682d3f6cb34a5f8648a1c619
prerequisite-patch-id: 3c5e447deebe943a6b8a98c2d017d1c0eab5da25
prerequisite-patch-id: dc6c98cdbffe9b3f19b8a0fc303f9b2902defa07
prerequisite-patch-id: 558d3536869699311008e4d6cce6a2a18a727eca
prerequisite-patch-id: 805a0898b88d8e1291e8262044d1d6bed1d45be2
prerequisite-patch-id: 8d7155ea7c0941b756129b6a490f9413b51b05ef
prerequisite-patch-id: 974eaa9cb6adf9749f6225fe1e67dd9433318625
prerequisite-patch-id: cdb2934ed5393e539f856e6f4de36140cd8ad697
prerequisite-patch-id: ab91736213909c77894d8e47594f548592f96bb4
prerequisite-patch-id: 15e30b35b9a32d98cea92287c95973bb55655b8d
prerequisite-patch-id: 74b01d9723a9eebb7a438ae6f3aa84fecbd86a2f
prerequisite-patch-id: 84ffa226fd432b97e30508988d556056f19488d8
prerequisite-patch-id: b6ef8f19bc0e45642fadc98a2a70a8a77e16cc31
prerequisite-patch-id: 6d301cbbd2d389bb156e2f9565f02c7d1eb9fed1
prerequisite-patch-id: 21aae4cff1307c55e73d737cd68552b6ea1b73f2
prerequisite-patch-id: 110fc69a696fa4dd74fb7e14a50c97e3b7238a9a
prerequisite-patch-id: 2ec906b416c75e44362332459fcd498872a22124
prerequisite-patch-id: aceec0866b3329401896512d235b7e01dc1746b1
prerequisite-patch-id: 41d8b9c212ca0950fb1ccbea92d8f62a3c42676a
prerequisite-patch-id: 94bec74d37c3b2d2b22ffc303d8f2ac567db22c4
prerequisite-patch-id: 4391fbbb5b04123f46d3eb3ec7b183be7152d338
prerequisite-patch-id: 08e009e1d4f6ef7fffaddeb82f9e35692bd593e4
prerequisite-patch-id: 14b40c9224527e76382332cf547d070f1d3a40ed
prerequisite-patch-id: eca0139a7cedf72a4e8a99324a846dea15392e4b
prerequisite-patch-id: cde323ef8d773b7dad5a278faaca89bb71405ab1
prerequisite-patch-id: 6abe9e3824531990933ada4bd58ff483637f3794
prerequisite-patch-id: 4344564d375dc6002077d382335ce759523ffa29
prerequisite-patch-id: 316b1610fc2e3953677ec152eee8cd5035723f82
prerequisite-patch-id: 55680c05d9c25c1a5fbd05e2b9f91a5bb1e4c350
prerequisite-patch-id: 2aa06c6d07b125147e3a6bcdc620e19f9c5885df
prerequisite-patch-id: eb93f71f16b3641ae6a369b1b3113656656f65e3
prerequisite-patch-id: 575d26f405980ef8a1be726c9ca0df679eb77d84
prerequisite-patch-id: 6b9e9c6e1f9cbc0ef3b716cd8615430680354877
prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175
prerequisite-patch-id: ef70f6dcf4e6aea68256028734614efc067c954d
prerequisite-patch-id: 75640c82cbccc2f173feb4bc6c912c9a321a68c9
prerequisite-patch-id: 569f315372b1b8f55a5a94f1385175252dc33b9f
prerequisite-patch-id: b43d50f060dc034ad413c28153ea641e697e5655
prerequisite-patch-id: f5f6fabf8e9a55c44413a76791d3713fe6415a33
prerequisite-patch-id: f031399df28961dad8315ffa6ad1ee0ff77116ec
prerequisite-patch-id: 8064ba5bd7cf2db6d127f981b3731001c71d58f2
prerequisite-patch-id: 6c889af47fd9df264bf4dc2758c18418c175dd3b
prerequisite-patch-id: 6c44e76abdeb8319ce17dab256fb99ea6a5e77ea
prerequisite-patch-id: 4680066fad4dcbccf016541a4847c7ace62e2e06
prerequisite-patch-id: d7159d0635ba309d374f519b37fc39dfdd15d0eb
prerequisite-patch-id: 070be0db29756ccd90ee239cb9ae5c3b6748cf93
prerequisite-patch-id: 93318a4ddebf24432063549989b91d9ff998bdec
prerequisite-patch-id: 55ead548e0a7c82c4296cc9b9fa047f110c1e306
prerequisite-patch-id: 34bbdb130ae694420b954f41a536b8eb8df77791
prerequisite-patch-id: 5a62f8304a1790b31accf47af84815bffaa92b89
prerequisite-patch-id: d2e87bf5a992d19bde372fb230f4589242f12d40
prerequisite-patch-id: 0429aaac18b3a3d564662f2b93aa3af755c880db
prerequisite-patch-id: a577a9e2266f5b16dd0bf1b8b4312952f736380d
prerequisite-patch-id: 3223b00fa7e9c330054e19f256b4e601008160f2
prerequisite-patch-id: f1cf16250799f803bde22d6dae704cc5338ec76c
prerequisite-patch-id: 781986f407c7f833f3a157bcaa9b6384f964fe11
prerequisite-patch-id: bb9dcec311319f2dbac1c3795ec19fc44dc5bd20
prerequisite-patch-id: d56476ab6a3a7b32a29eea6c811e110a127dfc65
prerequisite-patch-id: 0d9bf4d3f321845f908bc96dcf0b844c14701218
prerequisite-patch-id: 24910c0e34355ac74ac3e0701e24d09e18450b90
prerequisite-patch-id: 640fa47c52c8d79ae409b7077e030cfe8d336287
prerequisite-patch-id: de19c1094bc466beef1d7d648974f925f7cbfb91
prerequisite-patch-id: d98337a0fb6f5db044fc303476f609e4d0a5bc0f
prerequisite-patch-id: 0fa9a46cc96dce9417643522415ebe3759dde68b
prerequisite-patch-id: 5c18df7c1a8a34ffc79b1d26adf7945a3ee452bf
prerequisite-patch-id: 33762234ab4e809a0e8e6b6b65c32718c8cf99f9
prerequisite-patch-id: daca212d2666231fe948b6603ff07107cae1f192
prerequisite-patch-id: 13da74cb022388cfec32e21ba03c9411f625faa2
prerequisite-patch-id: d431066ca661245ea5ea74fa9217d5c84b33a143
prerequisite-patch-id: c5e72d376397445bd4e2d5aa670b0dcb62a15a62
prerequisite-patch-id: 92e0d24903c0128556135adede898d00557c1af7
prerequisite-patch-id: 51ed6ffa77b8e8eaf8cc6d3292bd9f4632ea39ca
prerequisite-patch-id: 1d5fbb162c8f6ffa8ae9055f0b22a6008a5bd8de
prerequisite-message-id: <20261116-genio720-ufs-rpmb-minimal-v2-0-b64eefcfb0f6@baylibre.com>
prerequisite-patch-id: eed84c9dced35c4e763777cf48fb123572b85f07
prerequisite-patch-id: 2dbd9c71fed90e03e446765fcf56fa19cc7c8b55
prerequisite-patch-id: a5850ed72820050fd734cc104a78f5d658503068
prerequisite-patch-id: f7321ec882a79846135af7055c41684f6f28d157
prerequisite-patch-id: 73c1aff1673136645b5a1bb14bc142adb4651a17
prerequisite-patch-id: 010fbec3b3ca5f259c4418bc7161c4a900bd51a6
prerequisite-patch-id: 9394ddd46665d4b78ddfcf361118006d4ca15623
prerequisite-change-id: 20261013-mtk-genio-720-spl-nor-9c67d62e3367:v1
prerequisite-patch-id: 6d06730fdf0b704dfff32c9a64d51f19cc118e2a
prerequisite-patch-id: ccdb869e04eff620964fb28d179f91a0fb275cb1
prerequisite-patch-id: 1ef319e6a957cd1375164ad8a85b59755aff92cd

Best regards,
--  
David Lechner <dlechner@baylibre.com>

