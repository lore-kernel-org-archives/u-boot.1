Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82FAC624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 19:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09D2E40839;
	Wed,  2 Sep 2026 19:43:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QG0A2yyx5W7p; Wed,  2 Sep 2026 19:43:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D8537407FD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788378181;
	b=SfC6IBF6IWtsR2fuEtGnikgrrYrlsgnFVRcwxJ2dP9zdP4XFIOm95gNbYovM7UBZrmbn
	 a/6mUzXE4NVfU98X/wHJGhF5PUHfTGHJwhjn7ov7CHQZBt9o8P7AbdNzJRPe4cKOBbdCs
	 OwG8NYDV0qpxJi46kk6sF3EY74hW6oAjFYfit6XJOUOqxrUyw3FW3goxchKDBUbuzT4Bf
	 ed3YJh6oCAt+Kv5B7B6ZKkPsfDug/3J+YKisLy0XGvha5GHuKLii41BxQevpAzRhyuZPs
	 KAeq19Wz8rsYgu0FpGuv9lHpBkXPak+nGGeUJ0pIqP8Bhw1V8TntmVAPIZ+9FXJZDaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788378181;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=APhjzA4INKePIHe9FQlRsHUtT5LhXJrFxbESsvlmhwg=;
	b=snXOJ1KOSM5c/gCF301XD+tVPJ1UGOqNkLW7r0W5N12tg/KqNGeAlDZH2Vrh7+v4YAFa
	 Xb/rGbL3CCUWap3gQPgdUUs+G/ClDhx8rTneftgRSCCSF/WYh5VEoXC0nNUm4sGiZvTq0
	 nT5gJbN2zqqN9n6Cq+pTI4eBi4Poxk/Ly5BLlg6WHQZGkl0mItX1AIX/IiYsQFVSk5X9/
	 mczFrYbcrfIE0gJoi5oEYW5GMYiFq1P1v3ZUYKlpZU9CIuc8Q1rUxz3exa9JomB4ZpUAm
	 mSWsW/gCjK90/4tTUYSb/ECswMVENekMegCZlganIeUwRojWzXU9WuS8KcXxhGsCZRw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hdTd+A+3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788378181;
	bh=APhjzA4INKePIHe9FQlRsHUtT5LhXJrFxbESsvlmhwg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h6RSBjLwhXf23AG7asCGahORw1m9Z2rRp+7QGI7Mc3NHQZcz7I185cyLJyTTs4bDE
	 qhiP74Ybl5nMH9y+a+bxHDmzDw635POK6Eqc/tY3bIt8QE6QKvOZupeRqm4P2qiTXn
	 MkJelkpyYYwvhDJqOXtEzWUSndADKs39IrP+k2jZs1ekJ/CAkOrDFyCCPEXaBrvWMP
	 ItQwfamh+I4LZ9to3DBtr2/JZgEt5EyjJqBz6QdRl1GxrJ0l0p8Z3tshOqRYoYAVta
	 /8UZhrWpYyUOZ4SyFB3+lqncGAgYeIRui5ke0G6cCADT3ZYgUl/l33owY8dW2JlhAt
	 ajv271wdxCg6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8537407FD;
	Wed,  2 Sep 2026 19:43:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DD892B2
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 19:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FCBA407FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 19:42:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WOr-_tubSfkq for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 19:42:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BB7BE407EE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788378178;
 b=o9poKHs9x5hBEL2IT9vo79MVxQlzj1bc4rnIt6sTl9sMwQ5ShsyypQPYzegxaJWkyDPB
 0Un0JkoKxAsyNeIEIUR9sRXAoslSJji9ZMaJGdzezGkn4vx0b1GboiwEa2uCDiBi1ZRn2
 SPY43NqgBq2HuRpegJqkTp6TdTmm9I7IaBTyBwholTI7yfWFQhjTrlvU95PCwQ1mq6d3A
 A9p1rbhGUpJW8GzWtXzmTivC7nDXZSHsY5/ip/pxFQhNZBMLlc05QrBX5nl/kLspXEfqO
 I3a9Zd91LEg3K6CSo3kedsNQnsCObob2J+z9cr5kGR60q+1AeghDvASoEwETHSZNwCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788378178;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=APhjzA4INKePIHe9FQlRsHUtT5LhXJrFxbESsvlmhwg=;
 b=kH7wdAlewFoygI8djx6MpruUTrcrpw6uYkOXcOCbmg3gdPWgr0RhpoWCuwkCBXA25Y67
 K798P1fML6xCpuFlG4S2Eeh2CgQwZ+441PRvcM5yUc+bT/qnTlCneNXxhU25A9cxiFJZ8
 P3AsBaLFIWb/jyAKPEflNMbkzvHJNrF7iJea8O7LizPWV/NDEMNdjcXOTtVPICdeeDoHA
 8w9j2Ro5nJBv9HyTu4UCMNbCHw3rBJ6U9wRLNjiu1W1YMpjJd6B2SJ/CRvLyXI8o1oNr8
 alELjq6R/l2uBTGn5zlYLPqTgv7aQPsmZJqBK88sehjXAtHsIwm205AsTuo/a5VGw7w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hdTd+A+3; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hdTd+A+3
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB7BE407EE
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 19:42:56 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-45eb2e6402aso1060658fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788378176; x=1788982976;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=APhjzA4INKePIHe9FQlRsHUtT5LhXJrFxbESsvlmhwg=;
 b=hdTd+A+3WzS2iLA/CVnpILmR/PYOq/bwm8bvCXNvhfYKVYJerFrcufPtw9MhmPY2zo
 QJmxh5OuL68g1FKiuzIpk8c6xshwJBMTeTjyiWKYzwO7TB3DE1/4HIRX7Usx9TSmIByQ
 GirGa0KaxD+alVf+5N3arxpyU2dxTkWozIC+wl7s0bUFyExQQ6SxuARpNpuD0RmJswzq
 PcK0zmkMqUgHVCB6X/pl2g4CLnsykFw/WEkdE8TvnhFEae3YtYBBd+497GM9EnAfN7Bp
 VePoxFyVRYxle3+xH/emxQjQAOS1YAbpU+59tmehNHhIPXFj042+bchZTAnIhErbyGd8
 HDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788378176; x=1788982976;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=APhjzA4INKePIHe9FQlRsHUtT5LhXJrFxbESsvlmhwg=;
 b=g5yoimRzcvwFyf5RO043BKyeaqe3zTchNmqbIPjmRy+gug946j1cKH+54SilNoN5b5
 xtEKUVceB7e+l0UKb/STjuu7axvf6j7znwVoC59rcsSV1t9XveJJTtuD4O2nXmDsYOeU
 oGmv0M3UbMf6dg52bmmbZvTAmb4LhNiyTg4ZQVilnV+VLN7tEgv0jw1SthY164CZlcPx
 cqpsLJ0W/1L2AVLKDPu5FTBNOt2DW3rnYXY3f1XAe2tFYR2Mj2cD5XWs0ZQcQevNoCKo
 9tStpZGdwO1+ACUoFzaxC+GeX4WvouN6wYGGuaP09hp+cNijkD+52CdkfgCuBifN/WuC
 ECsg==
X-Gm-Message-State: AFuF++klXjpzW22wpQe9ucjFNpLDtEn9KxFtAZqtdBc5ZENfcHwrSfsm
 Jc8vSgj0aYCFMl1UwTyvhkC7YKuoBWiW/V/h9+4S8KLbGmTXId+sla38QEr4rPfoVtg=
X-Gm-Gg: AYBFou2AbDG6uEagwPuDzsbk4hXvKOA1mfRv7nC7ffODvvXuvtn64bNjkxR2SkyFaaL
 H4WX6+l2AilxTj4AvqENxrRSvFfphaE8NQZAbzhEMrm76mumNYaSS0LgBjZiaYSrV5yM+Cc6DDF
 3WE1gjdTEhiF+LLVvE01gS97fbuTHptynvK6B3kHl/V6TdTUFjTn4VLGYz8pJXmFTLfKZJmFVF+
 VExOd3D9DzW/3JbzS9X8E5g/cDotAKkfOOCGw7dxOeMElebdXmNxaxLFDAIoCHBzXTXWIOO239K
 XgGbG4pwaKYX4RUN4r0AD4JPCSOrORtNW6eQzXqfrhw2V3FDTe1L571vZj8r+pTb/hnB4sudqF4
 rs7WreAcuW64blGcxH0WMpOxg+69wJmj61MK55eRhCtYXNj9NKKxWJwFs3ENllHZduM8EKpjxkM
 W52yfs7Pb/7GJAsyJvhWX1Kuok+3KNjXz3fCFE0DG10eTJpbvj4XEzXvkXMDUTQArcdA==
X-Received: by 2002:a05:6870:d204:b0:456:b6b3:5b64 with SMTP id
 586e51a60fabf-46f8526d2d8mr6235215fac.1.1788378175838; 
 Wed, 02 Sep 2026 12:42:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:518a:9db8:615b:293f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f336c72fdsm4241804fac.17.2026.09.02.12.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 12:42:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 0/4] arm: mediatek: Genio 360 EVK bringup
Date: Wed, 02 Sep 2026 14:42:14 -0500
Message-Id: <20260902-mtk-genio-360-bringup-v4-0-2d38f522c72b@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQTQ7CIBAF4KsY1mJwsAVceQ/josBYx59WoW00p
 neXWhfG2OVLhu8N82QRA2Fk69mTBewoUl2lsJrPmDsUVYmcfMoMBORCgeGX5sRLrKjmMhfcBqr
 K9so9SoveATqzYuntNeCe7m93uxtzbO0RXTNgw8SBYlOHx7u4Ww5zY4cWcqKjW3LBc5Ejpk2yz
 GYbWzzOZAMuXH1hQ00H35CagiBBykktBRjljfoDyS8IsilIJkijMmik1lD4H6gffx7w1qbDNp9
 z9P0L3l76JHYBAAA=
X-Change-ID: 20260729-mtk-genio-360-bringup-de3bedc2ec94
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4197; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=TGhPICc82bS0jYJjLqqM4f8rAbYBpp1XoS2SXVwR8tg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmHwYcYpQXrIa7D0cNAUBvpwccsbYfyLyFW/L5
 imtRb22x4SJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaph8GBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AInQH/1MfPY8cGCA4/C1WR0VKumjK9BAsEv24BvW7UBx
 jcbBvgZNZpq0UjmwdNEAp3/jNMLkUyCxczbM0VTa/KbT3DzEV0Ej1rMT16Mep6z5IqK/kmLqs6T
 ev+Rz46WGbDbiAKBeBSd0EYpLPTEs/lYgAhr25txugOqi3Ftio0oPvTmzmOQshWMCElqkFibmKS
 ipSN+Ovyodxanj8U5Q2Pur3+yq0E+/2MUjrNuq+g13vLXHztZcTgufIk98uArqrHwSI6f/9WhWV
 dXakRgcpwcan4relJL1/vTS4C9Ztt0xwrYRBjmVdulTS9TJSht/jhDH1MrwtTzhJt+SyQXY9dD6
 jzHk=
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

This series is doing a basic bringup of the MediaTek Genio 360
Evaluation Kit board. This contains a new application processor
(MT8366) that hasn't been seen in U-Boot yet, so basic support for
that is added as well. Clock, pinctrl, net, phy, spi, power drivers
to add support for any missing compatibles were sent as standalone
patches.

There isn't an upstream devicetree at this point, so most of this is
picking up the downstream devicetree along with a little init code
and a defconfig.

This has been tested on Genio 360 EVK booting to eMMC, microSD card,
and USB storage and booting from eMMC and SPI NOR flash as well as
testing that networking is working.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v4:
- Rebased on mediatek-for-next.
- mt8366.dtsi: sorted the children of soc { } by unit address.
- mt8366.dtsi: renamed the remaining pure clock providers to
  clock-controller@ for consistency.
- mt8366.dtsi: dropped the duplicated "ss-img1" clock from the ISP_IMG1
  power domain.
- mt8366.dtsi: added the gce-timer clock to the GCE mailbox.
- mt8366.dtsi: restored power-domains on ethernet@11019000 and
  usb@11210000.
- mt8366-gce.h: normalized the indentation to tabs.
- Kconfig: dropped UFS from the MT8366 help text.
- Board DT: added mmc0, mmc1 and ethernet0 aliases.
- Board DT: fixed the microSD card-detect pinmux (GPIO2 -> GPIO94) and
  dropped the duplicate pins-insert group from mmc1_pins_uhs.
- Board DT: restored the explicit MSDC drive-strength and R1R0 bias
  values.
- Board DT: added the Ethernet PHY reset GPIO.
- Board DT: renamed the SPI NOR pins0 group to pins-ck-io.
- Board DT: added a comment explaining the "rgmii-rxid" phy-mode.
- defconfig: dropped CONFIG_PHY_MTK_XSPHY, which nothing in the DT uses.
- MAINTAINERS: added include/dt-bindings/gce/mt8366-gce.h.
- Link to v3: https://patch.msgid.link/20260825-mtk-genio-360-bringup-v3-0-8e79e93882ad@baylibre.com

Changes in v3:
- Dropped unused/unverified nodes: cpus, i2c and spi.
- Aligned bindings with upstream where possible.
- Added power domain, display and PWM nodes.
- Enabled power domains and FAT in defconfig.
- Link to v2: https://patch.msgid.link/20260807-mtk-genio-360-bringup-v2-0-7c3830297d97@baylibre.com

Changes in v2:
- Updated devicetrees to align better with know similar upstream bindings.
- Added nodes for mm1, pmic/pwrap, snor.
- Added more options in defconfig to enable gpios, regulators, phy, net,
  snor, usb.
- Dropped clock dt-binding header patch (will merge the one from v1 with
  the clock driver patch if we don't need a v2 of the clock driver patch).
- Dropped the pinctrl dt-binding header patch (will send with pinctrl
  driver patch v2 instead).
- Link to v1: https://patch.msgid.link/20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com

---
Chris Chen (1):
      arm: mediatek: add MT8366 application processor

Macpaul Lin (3):
      arm: dts: add MT8366 application processor
      arm: dts: mediatek: add Genio 360 EVK
      board: mediatek: add Genio 360 EVK defconfig

 arch/arm/dts/Makefile                              |   1 +
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi      | 521 +++++++++++++
 arch/arm/dts/mt8366-genio-360-evk.dts              |  14 +
 arch/arm/dts/mt8366.dtsi                           | 787 +++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                     |  12 +-
 arch/arm/mach-mediatek/Makefile                    |   1 +
 arch/arm/mach-mediatek/cpu.c                       |   3 +-
 arch/arm/mach-mediatek/mt8366/Makefile             |   3 +
 arch/arm/mach-mediatek/mt8366/init.c               |  58 ++
 board/mediatek/MAINTAINERS                         |   9 +
 configs/mt8366_genio_360_evk_defconfig             |  62 ++
 include/dt-bindings/gce/mt8366-gce.h               | 858 +++++++++++++++++++++
 .../memory/mediatek,mt8366-memory-port.h           | 263 +++++++
 13 files changed, 2590 insertions(+), 2 deletions(-)
---
base-commit: 938e2774f01674a3a38cc6df5d20401cf09b1401
change-id: 20260729-mtk-genio-360-bringup-de3bedc2ec94

Best regards,
--  
David Lechner <dlechner@baylibre.com>

