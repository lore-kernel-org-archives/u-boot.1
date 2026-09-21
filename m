Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AEEC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 20:38:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CAE880AF3;
	Mon, 21 Sep 2026 20:38:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rGRKwxkW80fe; Mon, 21 Sep 2026 20:38:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B9C8D809B1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790023101;
	b=rNd4pln1FvKq9NW9KRjbroOYfpRplPn/QWN46r8HqivtRRZ6dI4i+JdVAZQfKuiBWDIo
	 6aSprm40+ZC4KBrB6DY7zCUfkPdVdZLAJdvikIacEdAJ4NKQ9jGOjT3j5O3WZuCisiiCP
	 02fB6xlXqHIgizvYcSSKBGzpKsBgbJHPmw3I13L1ux/v17Cutr6HvR9/tDVEWD0vQzXj8
	 hV9YgK3qwin8gSI/Ga3eTe1xIHcYBf3D19QTi/Xrkzc/mQqoHq+nYrs2bO9lxuHtlGWJ3
	 +95N1ie4XNrlGw09KG9ZzR7GS9y7knBU+7XI4E/Gr88yZrZCOkrWeqtBh7+pH5V2qQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790023101;
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
	bh=9AbrtK24JOh5NQgTo6sEUHcGeL9uD05Wi/3mbgFZlV0=;
	b=PPJPp3sFCqQM+KaU2XiS5/qTAhtivS6o3XnyMG6YmS4w92tHPXiT6zeifev1WGPf/WOw
	 Eya28opaiia7raSWhlsEvZVPfSwq2ze/nBrk+t9eafelGEssTMRfCtYBkm7W5xLrHEGQm
	 kNoQ+w3sj7GvyVGO1okhrZ5sY0R5pfIjj5QNuG7j0Xl+PNukRybvRl7tsDC73OVQEkNBc
	 Zd3qpjzMrnhd4ZvZ9LZP8l3jtsKzqKAZ8zf5lezxjeLTHyyvCIMp3I3FxX3xxVj7j6gYt
	 Ql6mFppjsb2ZzUx35yUsHp1RvlVp2Hi4MnuYUOKVi8nrjmxRXVb2WOocbfkfAQKuudA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790023101;
	bh=9AbrtK24JOh5NQgTo6sEUHcGeL9uD05Wi/3mbgFZlV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k8LEGw5dRiRRIb3AqSWd22em/lfbYFTPVVjyYvHVbxBjlBAXrWZ6z8JrldLjwext5
	 mm1lXSdfIyWfcXW9sdemE3C7vV17zvaH2cUTBIP03yBw6Sktoys9mRrl1i82zjFZIx
	 GaOp3Hi7G+a4GnZUoBl/Ch4w6HEjv96N0x0DlaASk4uKviF1np+jF3kAwFU54Pbvh9
	 vX3XDLULU4H0mlC1EpTLdUfaBY0GnwgwTwKSD3KDRrf+sffEduEwwTTuWadgt7qQW8
	 yAwtXSo9eBLgtCxc6eOpVPmeBq3bGTbSM6CL0Jbw0dHmxmD0WfytgNJq0JNxkBg4l4
	 6832tSAignfIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9C8D809B1;
	Mon, 21 Sep 2026 20:38:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 444149CA
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 423406064F
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:38:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U1shvBg5Buz3 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 20:38:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9039760618
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790023100;
 b=Ued6FSF+dmVP+Kgj/v0/z3ArOfmCNxPUDn4u3F8BuTRgzt6/NQ6fM6cBGHp4A5uMoHeU
 a/oastbWKY7ZpWVBL57J1uoLCc52dAAQE4vuRCvyV90X6VD4ob/tlH+R5a4qnw7WqWhBe
 HS9z0+RkB0tWmlMvy1PY3IuCulL3mjzzFaOfJsccx6mYyCZXCTYR9oo+KXD3rBsInqXir
 SWgG4KkIW2kAe1tvORGLheX2Qy6zS5zs1zfhqDVge1rnshVr/EUgQNyK0hD9qxvnPWp9F
 Q8SPrDwM4KkDfgOj9yWstU2HzneXU/gKKVeqPREKIbcUKVH51KI/3eEDHuNQoINFC6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790023100;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=9AbrtK24JOh5NQgTo6sEUHcGeL9uD05Wi/3mbgFZlV0=;
 b=jDeKfDGJuFDtfONPf5Zqn5niBf0kziCKWs0bcAbkAMlfxvH9aI4heBUaObFE/M1CmNgx
 TOYVcfxBJkjhqAOAe1ztV2kwvlnhYsm+AXMai6fqEujMMqtZhpxxJO2bLq1sNgXNkPVDU
 TDWRlheUW4Fini+MbKZdvlvv0VCM3ZnXZXpZWVm8/csBIVK9HY8C5m/pXjYA9sj4fH/7E
 UY/l24dcm32R8julEQKEpeZDkepsabsw4sCfwrJJ6Or9zjFip7YWWku3DXsDWgi9815W5
 wIuP9yFk/t2mivEvJgQO8G1+qbtAlw0o4Tyv1U5lXHdlJvmZ30oFo4G5ZdA0QqvWZww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=i1bUP0nX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=i1bUP0nX
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9039760618
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:38:19 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-801a8bf8112so1323321a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790023099; x=1790627899;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9AbrtK24JOh5NQgTo6sEUHcGeL9uD05Wi/3mbgFZlV0=;
 b=i1bUP0nXsTit84GhCiwp5C1ggdFi3hb9cRCg7kHYVpu0yNMY62YJA5M+Yo7t2HRN/6
 jXWBPPa2nYAv6nt7/m+LJbytKlUAjZnsJeV/aKSnWYj6WSrLGlV0n46BOUFChMny5U3V
 9iIzr8aYx/tyPCw9scYuIYzbuXVnaWQH4atuvBNUshiVz2fCJFFqmzjIRXhLhp07dtwE
 tfIxH6bN2t3I6663jzkl8cLv9VWAPJKzkD3vGQbgGkd8ylGT13KBcLnd90ZGbbugS9Nb
 dSfMrPqDnFwg4Wy2OzscOZE9/zhM4pb1NZjihrlfCeTBHqhJP0UCfvQs+JqDVO5/x3cm
 wOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790023099; x=1790627899;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9AbrtK24JOh5NQgTo6sEUHcGeL9uD05Wi/3mbgFZlV0=;
 b=GJVn35AC5xX18XQYyXbO0QVWFsFIBDPALQ5ByJJ36PKA4yDgiGaHiTUT9Zp5HEsArQ
 ROg+FQeZSSw6BD6p8cXsdQ96zq/haaTJ+s6XUuEGnWRabnSXsdKGXYuKhV8ixPuySpqn
 7DY2JT0JsxkMEHkhzYnW1jRrkkqtDwEQ2JieyeEayHmVKwYrFEobA0XM4h3oqC7boaA4
 CdoRs/vv13uQaQtnI64UX7cL+aK6na2JlSYFx347q5JKklUAwXTwwr+iT+o9+tIUr+GR
 eG3MjVRn/SbQUvfvCcgaOjYMQMU4Oa/Aqo/r3Xuj8akdpxlRJzPZ4xB2uzIzqVIg0v4y
 gR1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwebBZrz7D475EfMp2ljk+bFxRgvoXibf6OUYW5J20OLdSIXpn07+Ynix69v1A1AZXHzNGEGpA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nzbDl7cWZ3sPCesmMEFv3HPt0FMEFgk0ojDAwl4rwAGBn/OkGC
 dwGC2mjKXM+mf/udeBCqa2UNq4dgcA6+A08aFsPz6mVCQN4j+QRF/w+53P9GQ+4L34U=
X-Gm-Gg: AYBFou3orPIr6MyxX/KRTtwfCITuecgip9zXs4td447E4eNftaf96QP+zNZDopaL0VZ
 uqas/1F5EZwCZ+2nl5Ox+qjAsLdOWvLRgrwx8tBQ3MEdU288S18/U1bpjp7YW61mRye2sZgdkCS
 F8LVkdRyG9EzJimFoPPd0rhHyAD0KTQY85xixFBqQFIXKuDxy/3D+kh6HjSlVxUbib8MGPclLWU
 kY0eDuFf+3ZyL3haymVIfxElbwQSGv+347wHM/paTjqjQM3EVM84q6v1RpQxFXeblktHqGJl5XN
 pwaPkDcveiMxhQJLAu6nfembwy3b9zagb4Vj/gcuCSTPNMAeT6dWODsKji50i+KxTfNj8ePnKcd
 29Mu6NGR4wLcb0lEDV+mJns6r0uYQAwP58WU9j1uef9Oi+TyI9xqG4IM8rzPFfxQdadVgo7vTu7
 P1SlcSv6gyHaS1EdujjJeGcB2Q5YgDYGmk4VtJwh5x5QYPyCjnp8PZMPyplBffUIrec+Xl17Wvv
 WjSjNreITaHNA==
X-Received: by 2002:a05:6830:6ad3:b0:7fb:eade:d302 with SMTP id
 46e09a7af769-80de159c159mr12481040a34.10.1790023099029; 
 Mon, 21 Sep 2026 13:38:19 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:48dc:2ff3:bb18:4337])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-814d136b655sm7348a34.14.2026.09.21.13.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 13:38:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
References: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
Subject: Re: [PATCH v7 0/6] Add Genio 510 and Genio 700 SPL boot support
Message-Id: <179002308803.18666.1055903617175722056.b4-ty@b4>
Date: Mon, 21 Sep 2026 15:38:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=2Nb1Uiinj9iuKCU91+981pZSRJLBv/kduDEx6BM4PBE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqsZWxeEu9E45R91ROo+QVI2gKk2Aw/XFLmkuXv
 bd/oeT3ZlaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarGVsRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AgNMIAJTIFT8DM9LsmnBPMKFRvh2qI0dfIY7OKsrUyje
 uPiqE0Ok6QcfFb8yEadY1YgrflIC1bz9KkW7WE5IOV3o6XRMtNDek93etNc6CuKWiGjCYSutRRB
 +BXwB0waxTQDx+OeGsLZdZFad0w2iU/lauxX1iPSRJ1ZkjOiUryUQdAIdf3gkdQaUG4ITMJHj+G
 CS6AvEYcu3YoFmVZYNn9yr6VCvE9g7Y4ss1ZfkF05bMyTXaBRhMAPK6vdlmlfUlRwqNVA9Y5sIw
 /jUc1wO2EjPOIV3TVK2jeT9cjGErVGsrmRnTCx4fHPQFLtek4aCousKm9oPpG8+ircoKNAuyPUB
 XRCI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Thu, 10 Sep 2026 08:25:49 +0200, Carlo Caione wrote:
> Add Genio 510 and Genio 700 SPL boot support
> 
> The Genio 510 and Genio 700 boot chains use a platform DDR loader built
> separately from U-Boot to initialize DRAM before entering U-Boot SPL. Add
> the shared SPL devicetree and configuration needed to initialize the debug
> UART, watchdog, pinctrl and eMMC, then load a conventional FIT from the
> bootloaders GPT partition.
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/6] arm: dts: mediatek: prepare Genio 510 and 700 devices for SPL
      commit: 8b3cf38413bb87961bf8d22a1fdfd3bccdfe7827
[2/6] configs: mt8188: enable eMMC FIT boot from SPL
      commit: 124dd672b8213005ce20f45386f10dd0d41d9e56
[3/6] arm: mediatek: build Genio 510 and 700 boot images with binman
      commit: 906823e147129b7fcb4d09ce2d39d2eae2289f26
[4/6] arm: dts: mediatek: support signed Genio 510 and 700 bootloader FIT
      commit: db6afce2c7ccf0140eb429127c8244195609e5a3
[5/6] arm: dts: mediatek: emit the Genio 510 and 700 BootROM payload
      commit: d08ebdc88db4cf9e6752b938c87dc6ec6bca7706
[6/6] doc: board: mediatek: document Genio 510 and 700 SPL boot
      commit: ca1c29c01bbd03f89cd86159b2959b4e72d41aa9

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

