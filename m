Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A3FC624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF36C605EA;
	Sat,  5 Sep 2026 09:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MxaPb4UcDemi; Sat,  5 Sep 2026 09:13:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 56CC060602
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599625;
	b=e7hZzGq1TQCw9s4L8w93U6dx8COZHjpJVeN0JsY1c97IuByP/vTYlpOb+fsXWE5guD9C
	 TEt73t+YjXPgbMmNLRcIIVNk9X2Uw2YfIy5aduCyMbsNPToiAcOzW2zhFr1D8j0p0VkW4
	 maIgPBUyC8szQ69eXwKTY1RyJtJeL/vy35vN99d9oox8+9V8iB+Ltqofmwq2fKBBQgHkY
	 On5Jc0XL98NUwSNchc1bj1CGoVXMpVXs1g2y/O8caW33rcp3gFcQM9uJu7DcDj/jA2j7c
	 jL+r5C2es4UuhCW/T7NvKD1iE1PMldPZzUOzi8GN5ipecotwuf3WDfp/ZWkyYkBJTZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599625;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XaPnTjMSiqdqTrTwv+jqZtCwfTlnQPdTRFFtlkigZAc=;
	b=QDL8LS+8D55EEON90YaQOwLnp+0IApBbyVx3wR8+LzcP5+I97MAVExiGLvMZbK27YGme
	 AEqf01r0Kgb+OneatvSYyN7opM6I1yxh3W5hM6Dt573sLDY28+SXxFleeXu70GaZXKamv
	 w7jWSrQOhPlwGz2Ef8OV85mdn7ir/8ZKZQhgvQfzKzN857Je/SPM8IQHTlIUjI2WvkjIx
	 3POgU38RZODouPnLtNm5ZmjmXvfKeZTr34VkA9+41p8Cm9zv6NObEONq2eYM+L5QyvzR/
	 Q+KXmr95SSl9HIS0LLXCx3ChcWKq4w2IMEbzYcKI6cTlty9YaWmavqD079WzIIpyokA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599625;
	bh=XaPnTjMSiqdqTrTwv+jqZtCwfTlnQPdTRFFtlkigZAc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jSa+Dg59CYoZRf1OEUV+QYrOTVRvT2JfijOqDs2bKjWljwXqxJdlDQxoX95XGHdPz
	 GYC01kuqgOyfIfE0b0Edv0ui+HSmWRp+78EqxEBF2qWwuUP9Hu6Q/JFtLLUjdfqhyb
	 wqWeXo0y3UX5IoysFBANck9uT5Y54lnegt/K0WyU9o3sgKTL6N7x11TwlaD+J2lgCE
	 cGyXILGVxJ5SZPqXA9p1lFhAOnMF6zGVGRgiArgLVOEsHmSMlIDCfOo0/pYzNMSaWf
	 T57PfMzo7Olt0Nrgrl2mPFb0s8R9mfD9axtOzqhUCWHvcE48anVPmNlenZaw4YIW6v
	 eSIyIwPc3n+hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56CC060602;
	Sat,  5 Sep 2026 09:13:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 220DA105
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F82940B9E
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zqz6QHYZvdAl for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:13:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0358240B9B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599621;
 b=Kbfys5xTK2GIIlR9IEUUmBvxKpQTZz5/OT8Ry+tiDmypkWC6o5cRYwskx+VTJHg5CUmn
 dZGcw4OhcoZEqSO36QPVQvO69n80AqUSfq563/xsAam7KX+HVX9D2K4XaU4RB4SMyZx+n
 TYuyr2UpcBHUdJttUCVFhX7aXxGgav+7BdyFyFf7eaIZJ3V+K9mBon/P/NFV8Xlt7BcP8
 UTJfX0ytXH1wc15OMnHhdJ2sn2/5+t0WTdK3ADW6j7sz3S/zE61oAhpJtfWJ0Qy/hlzbA
 08rlXVPB2UF5rENXS4K/4ajV+vOTLY+vjhyVMVC76icO7YsWXzNusa9eEOhut3ndMLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599621;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=XaPnTjMSiqdqTrTwv+jqZtCwfTlnQPdTRFFtlkigZAc=;
 b=Vk8WSyciBTtjpHPSXeMVfVJmwjh2uxQ8mxknPt+TojZSjHIGD8iAaIaA1QYsjKpX9jPF
 GqUxVmQZ9kjUQ9eFZ9Z0rkKoA3+053yud/nbQMsfgSHGXDZrWQsEzt7g1rRIhnB3a8RZM
 MzlgHyj+i10fWE8TnaIVnOmDP3o9fcH/4D/u1RE+wlP/PokGSBlbVCa12YnRx8EM7ndN5
 pKZsP7MoP/lLF1hpoG1+NU9zpkXJqsUjf6ZdsK52cMGtyIqYYmVWaSR0lTly9xVNVLYf6
 FV26TCD1P+dVwk4F8Xdakk1E08NUZJDfODpj7cZeTO4Q9G6BcKwP/eAQxs4qJ5HpzHw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=AHPjMO0v; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=AHPjMO0v
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0358240B9B
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:13:40 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2d91ded8174so14620425ad.1
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599620; x=1789204420;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XaPnTjMSiqdqTrTwv+jqZtCwfTlnQPdTRFFtlkigZAc=;
 b=AHPjMO0vVIY4DCSULzEAAiaJYN1dqjkqIMnG7sRSKh8LxAxAELELsJfpCVodMxZHPq
 jSh4NjBHYxIBc5EyeDIxbLxF+gtNN4pI2v901E9W+FTzxghAdj4h7j3D3zNc9/Ime5Db
 zL7OWmTAGhmBMMOTVG7qQFjnlQzWbqLctKUnSNOxKJRJRI8OwkkAeSVtgRNZCdoE4s38
 mkRvjw4PmjiP4NVHEwov3sBk6IdR6uY2iTyA2YjeGQ6/xWdbS/64hDqjCz9E3gMxEV5V
 7/wxM2N7whuUcGVLULfP8SLJNA2C1xgnVgOuWE7rlfobMhdvy7lNltDJqIl+Acbp3UZp
 wDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599620; x=1789204420;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XaPnTjMSiqdqTrTwv+jqZtCwfTlnQPdTRFFtlkigZAc=;
 b=jcN2fLv6rBjkX4QIbW28ZovH0lmKLBiYXaHlhioYLw9R5/m/JijJA3wAtyDtNJUyOy
 vqdws+5mjhXpY3lBdcUcMq8sWAtVokjp5FK9vgW8lV1lpnbMrT9/BVIJrRaPImtzppZ4
 ui35cDoXCCgRYBdpHGwyFumsM8n72DswP2TeObPIKwAA83hef0+3640NBlX71g3PZkJ4
 RXe+lh/Keka/zvxQKS46fJ7L227I8zrXP4NkZ+XUU80WrqAWnxeyL9LvyDawlJSS7dAB
 JhrhG+rtu87PiReZNxFCaogRw93GoIeU+14D62CkaI+UQvDb8LvyxF4Ifn5q/VQEHFwp
 m0zA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpEkBv8VuUNIOCv5jcssaiaLfyseBo85DIiI2e5NzCuIKnGhq1CbcYIQr3gVBnIZZ5y0RXf5c=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l/GadoMewnOdRQT8NXZDF9g04r6BAYOV/FWzLtxORnZuRiNN0S
 hf0pXQ3VOFVX5iC2tJGbiAPVXO16SJM1fJkSzdBy92j9tqvfyI3TPc42JOHsWdnXyIo=
X-Gm-Gg: AYBFou1SMy7sZjnDfEc2dT503dA/bLZDHmOiwulL13626GMRiL9NVnGblKCFH80usPz
 ZM/lKuAMuNmlj8Zk/6LvoeiZ5+Vt3hTDvO1z9DOivVQmDFFMctLOJTbgnKh0FsVzG10eyrGKe+Z
 HlNi58d/whgMlJnd28mhyC9sYCsWqW85FR94NBNFaUlMlKj1X9fUb+ip+AYnoXvjDtPO+Cpsuta
 eEC/qV6cd+nrvrerEn+SvaQdMo1Tai9jUuz5JjXW2yqSAqLUuAd0d1j4oypV6NftGZaljmA9aBV
 bVfqtCxskok4U5rbg+EGvCxud3M/QLEhjmOBoU5KgpSlBTUV5tuaYNlqPodJHyGYvoOlzeRnOtE
 me2JpUGRC/2wRx6oKdKUx+xQCsAILloS0jS3B2waYE6C3/6LL7NPL0xErQhrsxPcoK8V3mmTgSb
 Uvgr9FlVlNPoC+6ry4weTaIKU0XymnVUoZxTO4OgLAac2pCi6mA5IECJdssXQ8iqg/nJ2rcrsHx
 89u3ho61DWHSadTHQRgWMHIk57CXhrCDqzvSoaIt5U2IWdYOMf77IHyXnkQ+8AOy04GHykmvuse
 iiKznH5YSX+dxJMxQnHueMVH6g==
X-Received: by 2002:a17:902:f092:b0:2d8:df44:a5c2 with SMTP id
 d9443c01a7336-2db126afe54mr123347175ad.20.1788599619681; 
 Sat, 05 Sep 2026 02:13:39 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:13:39 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v11 00/17] spacemit mmc driver
Date: Sat, 05 Sep 2026 17:13:13 +0800
Message-Id: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACndm2oC/23RzW7DIAwH8FepOC8TJpjATnuPaQc+zMqkNhNk0
 aYq7z5IDs3UHI38s9HfN1YoJyrs5XRjmeZU0nitBcDTifmzvX5Ql0J9YIILxZUw3UV2RhMHhSZ
 SdKw2fmWK6Wed8va+1eXbfZKfmmwd51SmMf+ua2Zoff8GztDxzgJEHaRRpMRrTsWXyeZnP15Ym
 zmLRyWq8s4b8MrpPugD1d/VwHFVfVVojfNDFBg9Hii5V8OqZFXBBQ6gMRqAA4U7JcSqsP1QgjU
 IhIDDgVJ7te1SVYmIGpUKUnt7oMxdadjSMFXV7FQ9TW+EMwcK+I4JuUXPWx7EbfAOKDy4ZVn+A
 JH69YcmAgAA
X-Change-ID: 20260629-m4-98e01659fefb
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@gentoo.org>, 
 Anand Moon <linux.amoon@gmail.com>, Vincent Legoll <legoll@online.fr>, 
 Troy Mitchell <troy.mitchell@linux.dev>, 
 Margherita Milani <margherita.milani@amarulasolutions.com>, 
 Aurelien Jarno <aurelien@aurel32.net>
X-Mailer: b4 0.15.2
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

This series adds MMC support for the SpacemiT K1: an SDHCI platform
driver, the SD card device-tree overlay, defconfig options, and SPL
boot-device selection from the SoC strap/config registers. The SDHCI
driver is usable in both SPL and U-Boot proper.

A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
write images to eMMC.

---
Changes in v11:
- spl: Fix the read_boot_mode() that returns both boot mode and boot device.
- Link to v10: https://patch.msgid.link/20260824-m4-v10-0-5e0adcb1edb9@riscstar.com

Changes in v10:
- pinctrl: Move all pinctrl patches into a new patch set.
- Link to v9: https://patch.msgid.link/20260819-m4-v9-0-6e66016392b9@riscstar.com

Changes in v9:
- spl: Enhance detection on booting from SD.
- dts: Synched upstream DTS files for K1.
- doc: Create SD card image from scratch.
- mmc: Avoid to use CMD18 on SD card in SPL.
- pinctrl: Drop "fix drive strength configuration".
- Link to v8: https://patch.msgid.link/20260802-m4-v8-4-e916643205f3@riscstar.com

Changes in v8:
- doc: Remove SD card.
- Link to v7: https://patch.msgid.link/20260729-m4-v7-8-2cb04b4fe389@riscstar.com

Changes in v7:
- env: Drop env support on the mmc series.
- dts: Sync upstream DTS files for spacemit.
- pinctrl: Simply clrsetbits_le32() on pull-up/pull-down configuration.
- spl: Fix DTB matching.
- Link to v6: https://patch.msgid.link/20260727-m4-v6-0-2f58566d48ca@riscstar.com

Changes in v6:
- pinctrl: Fix drive strength configuration.
- pinctrl: Fix pull-up/pull-down configuration.
- pinctrl: Use dev_read_phandle_with_args() to fetch "spacemit,syscon" instead.
- spacemit: rebase on latest upstream branch.
- Link to v5: https://patch.msgid.link/20260722-m4-v5-0-c41a951e5157@riscstar.com

Changes in v5:
- mmc: Split CMD23 support out.
- mmc: Use read_poll_timeout().
- mmc: Set pinctrl state based on selected timing mode.
- mmc: Remove the condition based on quirks.
- pinctrl: Fix power source argument.
- dts: Add missing power source on mmc pins.
- Link to v4: https://patch.msgid.link/20260707-m4-v4-0-dbd01185f911@riscstar.com

Changes in v4:
- mmc: Add CMD23 for write.
- mmc: Fix CMD23 only for CMD18.
- mmc: Update bulk release operations on reset and clocks for spacemit
  platform driver.
- MAINTAINER: update the maintainer of Spacemit K1.
- Link to v3: https://patch.msgid.link/20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com

Changes in v3:
- pinctrl: Fix "fast" by "uhs".
- pinctrl: Add syscon dependency.
- mmc: Fix quick by capability.
- doc: Add SD boot support.
- Link to v2: https://lore.kernel.org/u-boot/20260630-m1-v1-0-83f13347b3ba@riscstar.com/T/#m2aba875a2696a7bb9b704618d22ae2fd7f7f5acc

Changes in v2:
- cmd: drop patches on eminfo & tlv_eeprom.
- configs: Enable ADMA and SYSCON support.
- dts: Use vmmc-supply as vqmmc-supply on the SD card node.
- mmc: k1: Enable ADMA mode support, use CMD23 for multi-block
  read/write, correct pinctrl state from "fast" to "uhs".
- mmc: sdhci: Add new quirk patch to enable CMD23 for multi-block
  transfers.
- pinctrl: k1: Add new IO power domain configuration support for
  dual-voltage GPIO banks.
- spacemit: k1: Use FIELD_GET() to parse boot strap mode.
- Link to v1: https://lore.kernel.org/u-boot/20260521-k1-spl-mmc-sdcard-v1-0-1bd14b8c4f9f@riscstar.com/

To: u-boot-spacemit@groups.io
To: u-boot@lists.u-boot-project.org
To: Yao Zi <me@ziyao.cc>
Cc: Huan Zhou <pericycle.cc@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Guodong Xu <guodong@riscstar.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Yixun Lan <dlan@kernel.org>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Alex Elder <elder@riscstar.com>
Cc: Andre Heider <a.heider@gmail.com>
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Tim Ouyang <tim609@andestech.com>
Cc: Leo Liang <leo.liang@sifive.com>
Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
Alex Elder (1):
      riscv: dts: spacemit: define a SPI controller node

Andre Heider (6):
      riscv: dts: spacemit: k1-musepi-pro: add PMIC and power infrastructure
      riscv: dts: spacemit: k1-musepi-pro: add 24c02 eeprom
      riscv: dts: spacemit: k1-musepi-pro: enable QSPI and add SPI NOR
      riscv: dts: spacemit: k1-musepi-pro: enable USB 3 ports
      riscv: dts: spacemit: k1-musepi-pro: enable PCIe ports
      riscv: dts: spacemit: k1-musepi-pro: set default console baud rate

Eric Chung (7):
      spacemit: k1: select boot device via config registers
      mmc: k1: add sdhci platform driver
      dts: k1: enable mmc devices in SPL
      configs: k1: enable SD and eMMC support
      MAINTAINER: update Spacemit K1 entry
      doc: spacemit: flash on K1 SoC based boards
      spacemit: k1: fix product name detection and DTB matching in SPL

Iker Pedrosa (2):
      riscv: dts: spacemit: k1: add SD card controller and pinctrl support
      riscv: dts: spacemit: k1-bananapi-f3: add SD card support with UHS modes

Trevor Gamblin (1):
      riscv: dts: spacemit: k1-musepi-pro: add SD card support with UHS modes

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi          |  12 +-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi           | 136 +---
 board/spacemit/k1/MAINTAINERS                      |   5 +-
 board/spacemit/k1/spl.c                            | 148 ++++-
 configs/spacemit_k1_defconfig                      |  22 +
 doc/board/spacemit/index.rst                       |   1 +
 doc/board/spacemit/k1-mmc.rst                      | 271 ++++++++
 drivers/mmc/Kconfig                                |   7 +
 drivers/mmc/Makefile                               |   1 +
 drivers/mmc/spacemit_sdhci.c                       | 684 +++++++++++++++++++++
 dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts |  31 +-
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts  | 329 +++++++++-
 dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi    |  60 ++
 dts/upstream/src/riscv/spacemit/k1.dtsi            |  28 +
 14 files changed, 1584 insertions(+), 151 deletions(-)
---
base-commit: c46bd5b2136158d3380d626d79c96827818226c5
change-id: 20260629-m4-98e01659fefb

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

