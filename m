Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1560AC982F0
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 12:54:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C97C380D23;
	Mon, 21 Sep 2026 12:54:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGb8AgTbKzFv; Mon, 21 Sep 2026 12:54:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 94F2C80D39
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789995267;
	b=Q/dGuAq6TB3CHplD9g8jab7bU832Nq8W02bRkWDIxIMBpcEy/w6UJCP/czgsE9IQYBxe
	 zHotsgvO6r+cauudjvLldIhj1aFT9Sq05TQv7/BTfTuU8/9TsC/Bd/HmM8BoCLD93SMEZ
	 gurWZ27z2Qlf7euUxL8US4kXedgSZMlEXlzGvjKmxnICdzphImvayS83s1CUF1HyAnjmg
	 9drsNk19NdY4S+FKlgKOmlkR3Z3PjC6ohO6O64rncCuq0sjdBAxaM97eTvN60NfgrwqK8
	 Pq6liupJvtzaegJNM5x+o1sKxDsZ4jkwnUFb734k7G7EFmrtsFc2cHzqEQIFUtjVxMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789995267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xB4aBJpcskQOiiY7fTul/GrPVwspp1cf/9p1MaJE4to=;
	b=LbME7Lz/loY/dqu5Xy1VmaSN6BmX67mX01FoDqEJgKh5Z8J8tcKdN0VFQs4L7Qn1AU25
	 VANx2vgG0xZntH9KXU0Prd7wbwqn7tMyEMzZqi8O+VDgunUxOpzXKlvYPH6Nt2pP3cw/7
	 2wZF6lnaGN4mn0jodhUvweffUbRlpsaV2qtf2GshSqh/xFgLWzYPqClZ8O117r0ghAvgZ
	 eRRtT2K0EPR++pnxMaLdwDwhC0FZxZVWwTVn2nZsVOSTiLP51iC4JxVZjL18dkCgP48Tb
	 hwfIL+0EzGOWIaj0aRPAyGIXv+2rX4sw2xSuMyRf9Iv6jqlV8pvlOgIMOjisEEoMK8g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789995267;
	bh=xB4aBJpcskQOiiY7fTul/GrPVwspp1cf/9p1MaJE4to=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ldz5dzKFVhhUhrS/n+OpY6jaR+kqG6lMQj1Jb29zDFOVMuxniow1KW5P4YdLMzFuh
	 oBGEfojSbAdRKFOEqPCGyWgbZNzbCqDq2ivmRyzQOJ4SUivrTM181UyfykP1x/R4Ik
	 /D7G/ALg1RGcconXsHcR/CqRFrboadNCOeqEsJUM5whOQI9bOHUq61Y24+chtbFoxc
	 fZTR4nPkmKfNZTke6YGfukqsYJGoHIq5FMaCI18KBnbZWLNQ5qVzO3xKpC06v0pYDp
	 WdkV65nV/KyAbhwEI4ZOm7ZY5b2f8xxk+93qFUOCkat3J+xkkAqQr8sy4J1V0o2M1l
	 Ed4Zro8QABcHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94F2C80D39;
	Mon, 21 Sep 2026 12:54:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 68E74FEA
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 05:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5AC4140CA4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 05:45:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4OQfLLPOJGuy for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 05:45:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 666C640C8F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789969519;
 b=RXGO+JZnwkinYc7WyBzfcFffXBkO2ov4ukdBFFfsmdYtlQ9R4eQham7ouHeCcc+mmhjN
 RQxCjOZOfR9jCOSwbBSE0XLeE9Sa9U7WAnbJoBSUFeev5+nO+HLJE2vpcYRxLfnojts6j
 RBFSLM7hex34Hh/A4AtXNQ62Jfot/f8rN5g7QU1h4TudmvlcJcHSn6KU9ymNYTaR4v9Ux
 QYBEnsv8PLgpkVO8vS8bf7E33UjfPYtQoVGJRXEKg8yrI6s06fll6oMBudJolXGNBxIZx
 Kiu3jYRYuPnFbzN6n/0jgHSWuC8id/oxnonmBoYRkHedSZCFFMRFeBxqOZlBPCQpmIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789969519;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=xB4aBJpcskQOiiY7fTul/GrPVwspp1cf/9p1MaJE4to=;
 b=FB7lAHOCeIaCKg44qb0tWsNQDrkSQKzAmz+7GcmUnVuZRbxol4of1mMfRpblAZfAi1B9
 FQBSzzHo8kk2meEeSIGuDLTOCIL7Xv7Mv5xzbqOLLf06OvR5szUEJUGWNJgbCJFqfJ9Sn
 Uv2C0niI/fZRsYtJHAHmFHb3Kh5iyWkbI7m91K/t49ndU+TxcEAB3rMFG7ZMB0Q5U2Zzp
 /msa0AnGz3INvRXYGU1pGbb5v3mxofSouBgU3W8wJJ6RJWwjD6/xHIxLkYCm3AmYJfYmO
 fnnKrciQBkZaE7YWLBvPQDFlsJ3adJ6sqiDXRAL1wy1SLgijMHcXJeq9keXMtfBy/eQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=B9Yn73Qq; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::e;
 helo=mail-pj2-x0e.google.com; envelope-from=hungen3108@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=B9Yn73Qq
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com
 [IPv6:2607:f8b0:4864:39::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 666C640C8F
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 05:45:18 +0000 (UTC)
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-39b350c69b4so2251223a91.2
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 22:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789969518; x=1790574318;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xB4aBJpcskQOiiY7fTul/GrPVwspp1cf/9p1MaJE4to=;
 b=B9Yn73QqbyB98TefEU2KoUwhRFIHzRe0C5eyaNQ2MOqyNRY0URyrbvdGf2n5oqaGEp
 XUeyoPfUZ1GsDytP+v2AnDpm1mop8v2hl3gfyEbvRYm3Vhu7BuB9ZhtuU+U+W6lUSIj0
 iYp94Gtjnz+jWra2D2oVOYIT4epoqipUd/C5F9irLL2RP/Ja9Ta6gElfJ6lybzkLrnHg
 +wS/Q12iLISTyOMk0wWSyQ7g54pDgYkBK1B5dRIKIp0ZrVamkthwOr/zH5PmuhUadhCq
 r7ODqHrQLqPhWettFs5mqhX1gB/ndptKHG4BJJ4/FF5+yEm9n+IRB2FKDO0mlAHo9hn9
 cMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789969518; x=1790574318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xB4aBJpcskQOiiY7fTul/GrPVwspp1cf/9p1MaJE4to=;
 b=dHhSJIar9dzGTFzU1zGap0NeYxFBPMhCeuYDBJ5zBAvw3xmyEdb69kc38zm/YByO8J
 iSHgOOQnP18VVJNh4KsWDOf7An2IgQIWLcB9qqKCyPX6VrW0xw5DV9EaZTNH00IhYngr
 SqRCu4zbwI5/u1evUb+ZtHN4KgwsDU6yIp0WH6B8jBv2bEvNDaVrg+uPcDthvNGUZV6X
 4xUREOR7LyJQiBrDNipX4AsUNso47TvvLDzQj1OOghtkCjWI+MYAN4DwFh8dShjiYROv
 44qUMQ9FQZn1BKHV/SxZqq+fzFv0YxHYcCEHscZp0z99G7WwxLgA9PxOZS7Jq0/gt5cc
 TSTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYkXJglMZUJYhi+GmSIaNEecuLj+kwN/KQ0A6WIOdHw4qOZXWniQq2IWGVQ27YIogvXOi1VHo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k+ucKa+qmL7i5Vas14tXiuj0S/CYjQ+T46oAja6v03MQMKftnF
 gaiPIRhsBaW2+c//UmY65PM5kfXqrokFhzskjpNH669O6FpZUxrFj2B35cvzjbOzdj0=
X-Gm-Gg: AYBFou2vXZPzEVyqzDxv5ZF5NHRMIdfHUzoRwTab49eFS4a18c+xKIB33nGaKHSvu0N
 GsVpkYO5UQtfKcaMshf8tZ+p64VOpMVkkflJ081SZfl/kilFBfzKaM+CBbMsXRezlla6mYS6uWL
 GjvACOSboe8Lzfsgm3cKrTQSrD3US/3rAXil964elSBXXew5kLB010O2kQc8gG3V9RkZUInpIFg
 18jsLSIZ7ff//oS0aRvn6V1ZJHkiv9Olxw6BU66teVmeTUR3zgjHoM7oPGi8PSJ0loDfERffzU8
 yTIodevbB9+s09LJ2+ZPB7fzC2dDSyqF2bDQPT7zTS0usBZrKQNPcISPihREcOBMxp4unNYqa5T
 O7fFi9R+8erXrci3ZxfsuO+xIZ6cZn7E25OjbhdEqZCMDPKRwB7V86KRTc04TspaamVCYhZTVl2
 BmKDjr/cSE6q/1Yvjl6n5Oz5js5p79Wm7R+bbNnUoJfyIad2Xs4GPrTQ0xGQ6aDXM3eRjihWRXl
 /iJPfLuF+vn7bC/pkKi5koBIMIuMLjfp9FoiYEyFBaY8tnFHBCHRXgtySOjEovTFglg+QLVi9aP
 LbIPdBMd
X-Received: by 2002:a17:90b:2d4e:b0:39e:4c80:44bd with SMTP id
 98e67ed59e1d1-39e54df9105mr15924692a91.32.1789969517831; 
 Sun, 20 Sep 2026 22:45:17 -0700 (PDT)
Received: from pc130107.ADVANTECH.CORP (118-163-147-185.hinet-ip.hinet.net.
 [118.163.147.185]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a031d63ca9sm7629853a91.14.2026.09.20.22.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 22:45:17 -0700 (PDT)
From: Tom Hsieh <hungen3108@gmail.com>
To: sbabic@nabladev.com,
	festevam@gmail.com
Cc: festevam@nabladev.com, uboot-imx@nxp.com, marek.vasut+usb@mailbox.org,
 trini@konsulko.com, tharvey@gateworks.com, stefan.eichenberger@toradex.com,
 u-boot@lists.u-boot-project.org, Tom Hsieh <Tom.Hsieh@advantech.com>
Subject: [PATCH] phy: phy-imx8mq-usb: add USB PHY tuning support
Date: Mon, 21 Sep 2026 13:45:05 +0800
Message-ID: <20260921054505.2978948-1-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 12:54:14 +0000
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

From: Tom Hsieh <Tom.Hsieh@advantech.com>

The driver defines PHY_CTRL3_TXVREF_TUNE_MASK,
PHY_CTRL3_TXRISE_TUNE_MASK, PHY_CTRL3_TXPREEMP_TUNE_MASK,
PHY_CTRL3_COMPDISTUNE_MASK, PHY_CTRL3_TX_VBOOST_LEVEL_MASK,
PHY_CTRL4_PCS_TX_DEEMPH_3P5DB_MASK and
PHY_CTRL5_PCS_TX_SWING_FULL_MASK, but uses none of them and reads
none of the fsl,phy-* properties that feed them. The PHY is brought
out of reset and left at its power-on defaults.

Several device trees in dts/upstream already carry those properties:
imx95-19x19-evk.dts, imx95-15x15-evk.dts, imx95-15x15-frdm.dts and
imx943-evk.dts each set five of them. Linux applies them on the same
hardware; U-Boot silently ignores them.

Port the tuning from Linux, keeping its structure so the two stay
comparable. The code is taken from
drivers/phy/freescale/phy-fsl-imx8mq-usb.c:

 - imx8m_phy_tune(), the property parsing and the generic converters
   from commit 63c85ad0cd81 ("phy: fsl-imx8mp-usb: add support for
   phy tuning")

 - the three i.MX95 converters from commit e75d564f6466
   ("phy: fsl-imx8mq-usb: add i.MX95 tuning support")

The i.MX95 field encodings differ from the i.MX8MQ/8MP ones rather
than being a coarser version of them, so they need their own
converters. For fsl,phy-tx-vref-tune-percent = 100:

  generic (i.MX8MQ/8MP): clamp 94..124, (100 - 94) / 2 = 3
  i.MX95:                clamp 90..108, piecewise, 100 - 92 = 8

One deliberate difference from Linux: the i.MX95 comp-dis converter
uses clamp(percent, 94U, 104U) where Linux has clamp(percent, 94, 104).
U-Boot's clamp() in include/linux/kernel.h is the older type-checking
form, and the unsuffixed literals make it warn about comparison of
distinct pointer types. The other three converters already use U
suffixes in Linux.

As in Linux, the tuning is applied from imx8mp_usb_phy_init() only.
A board that sets none of the properties keeps the current
behaviour: every field stays at PHY_TUNE_DEFAULT and
imx8m_phy_tune() returns without writing anything.

This fills a gap against Linux. It is not a fix for any failure
observed in U-Boot.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Tom Hsieh <Tom.Hsieh@advantech.com>
---
This is a new feature rather than a fix, so it targets the next merge
window (v2027.01) rather than v2026.10. It applies cleanly on both
master and u-boot/next; neither file it touches has been modified in
next.

Verified on i.MX95 (Advantech AOM-2521), which sets the same five
properties as imx95-19x19-evk.dts. Reading the PHY registers after
`usb start`, with the patch applied:

  PHY_CTRL3 0x4c1f004c = 0xaa14e6eb
  PHY_CTRL4 0x4c1f0050 = 0x04289e09
  PHY_CTRL5 0x4c1f0054 = 0x0000007f

  TX_VBOOST_LEVEL     [31:29] = 5     (1156 uV)
  TXVREF_TUNE         [25:22] = 8     (100 %)
  TXPREEMP_TUNE       [16:15] = 1     (600 uA)
  PCS_TX_DEEMPH_3P5DB [20:15] = 17    (17 dB)
  PCS_TX_SWING_FULL     [6:0] = 127   (100 %)

Each matches what the converters produce for the properties in the
device tree. TXRISE_TUNE and COMPDISTUNE are not set there and keep
their reset values, as intended.

TXVREF_TUNE is the field that shows the i.MX95 conversion is the one
being applied: for fsl,phy-tx-vref-tune-percent = 100 the generic
i.MX8MQ/8MP converter yields 3, the i.MX95 one yields 8.

Test base: the tree also carried a local fix for the DWC3 reference
clock lookup, without which `usb start` does not get far enough on
i.MX95 to be useful. That fix is on the list separately from Stefan
Eichenberger as "usb: dwc3-generic: fix ref clock lookup indexing
wrong clk_bulk array". This patch does not depend on it to build or
to apply.

Tested on i.MX95 only. The i.MX8MQ and i.MX8MP paths are unchanged in
behaviour for a device tree that sets none of these properties, but
were not tested on hardware.

Build-tested with imx8mp_evk_defconfig and aquila-imx95_defconfig.
Thirteen defconfigs enable both CONFIG_PHY_IMX8MQ_USB and
CONFIG_USB_DWC3_GENERIC.
 drivers/phy/phy-imx8mq-usb.c | 283 +++++++++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/drivers/phy/phy-imx8mq-usb.c b/drivers/phy/phy-imx8mq-usb.c
index 387db843c50..3308a3a8b58 100644
--- a/drivers/phy/phy-imx8mq-usb.c
+++ b/drivers/phy/phy-imx8mq-usb.c
@@ -118,6 +118,9 @@
 
 #define TCA_INFO			0xfc
 
+/* Tuning fields left at this value are not programmed. */
+#define PHY_TUNE_DEFAULT		0xffffffff
+
 enum imx8mpq_phy_type {
 	IMX8MQ_PHY,
 	IMX8MP_PHY,
@@ -130,6 +133,13 @@ struct imx8mq_usb_phy {
 	enum imx8mpq_phy_type type;
 	struct udevice *vbus_supply;
 	void __iomem *tca_base;
+	u32 pcs_tx_swing_full;
+	u32 pcs_tx_deemph_3p5db;
+	u32 tx_vref_tune;
+	u32 tx_rise_tune;
+	u32 tx_preemp_amp_tune;
+	u32 tx_vboost_level;
+	u32 comp_dis_tune;
 };
 
 static const struct udevice_id imx8mq_usb_phy_of_match[] = {
@@ -201,6 +211,275 @@ static int imx8mq_usb_phy_init(struct phy *usb_phy)
 	return 0;
 }
 
+/*
+ * Tuning helpers, ported from the Linux driver
+ * (drivers/phy/freescale/phy-fsl-imx8mq-usb.c). Without them the PHY keeps
+ * its reset defaults and the fsl,phy-* properties in the device tree have no
+ * effect.
+ *
+ * i.MX95 encodes three of these fields differently from i.MX8MQ/8MP, so it
+ * needs its own converters -- feeding the generic ones a percentage would
+ * program a different register value, not merely a less precise one.
+ */
+static u32 phy_tx_vref_tune_from_property(u32 percent)
+{
+	percent = clamp(percent, 94U, 124U);
+
+	return DIV_ROUND_CLOSEST(percent - 94U, 2);
+}
+
+static u32 imx95_phy_tx_vref_tune_from_property(u32 percent)
+{
+	percent = clamp(percent, 90U, 108U);
+
+	switch (percent) {
+	case 90 ... 91:
+		percent = 0;
+		break;
+	case 92 ... 96:
+		percent -= 91;
+		break;
+	case 97 ... 104:
+		percent -= 92;
+		break;
+	case 105 ... 108:
+		percent -= 93;
+		break;
+	}
+
+	return percent;
+}
+
+static u32 phy_tx_rise_tune_from_property(u32 percent)
+{
+	switch (percent) {
+	case 0 ... 98:
+		return 3;
+	case 99:
+		return 2;
+	case 100 ... 101:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static u32 imx95_phy_tx_rise_tune_from_property(u32 percent)
+{
+	percent = clamp(percent, 90U, 120U);
+
+	switch (percent) {
+	case 90 ... 99:
+		return 3;
+	case 101 ... 115:
+		return 1;
+	case 116 ... 120:
+		return 0;
+	default:
+		return 2;
+	}
+}
+
+static u32 phy_tx_preemp_amp_tune_from_property(u32 microamp)
+{
+	microamp = min(microamp, 1800U);
+
+	return microamp / 600;
+}
+
+static u32 phy_tx_vboost_level_from_property(u32 microvolt)
+{
+	switch (microvolt) {
+	case 1156:
+		return 5;
+	case 844:
+		return 3;
+	default:
+		return 4;
+	}
+}
+
+static u32 phy_comp_dis_tune_from_property(u32 percent)
+{
+	switch (percent) {
+	case 0 ... 92:
+		return 0;
+	case 93 ... 95:
+		return 1;
+	case 96 ... 97:
+		return 2;
+	case 98 ... 102:
+		return 3;
+	case 103 ... 105:
+		return 4;
+	case 106 ... 109:
+		return 5;
+	case 110 ... 113:
+		return 6;
+	default:
+		return 7;
+	}
+}
+
+static u32 imx95_phy_comp_dis_tune_from_property(u32 percent)
+{
+	percent = clamp(percent, 94U, 104U);
+
+	switch (percent) {
+	case 94 ... 95:
+		percent = 0;
+		break;
+	case 96 ... 98:
+		percent -= 95;
+		break;
+	case 99 ... 102:
+		percent -= 96;
+		break;
+	case 103 ... 104:
+		percent -= 97;
+		break;
+	}
+
+	return percent;
+}
+
+static u32 phy_pcs_tx_deemph_3p5db_from_property(u32 decibel)
+{
+	return min(decibel, 36U);
+}
+
+static u32 phy_pcs_tx_swing_full_from_property(u32 percent)
+{
+	percent = min(percent, 100U);
+
+	return (percent * 127) / 100;
+}
+
+static void imx8m_get_phy_tuning_data(struct udevice *dev)
+{
+	struct imx8mq_usb_phy *imx_phy = dev_get_priv(dev);
+	bool is_imx95 = imx_phy->type == IMX95_PHY;
+
+	if (dev_read_u32(dev, "fsl,phy-tx-vref-tune-percent",
+			 &imx_phy->tx_vref_tune))
+		imx_phy->tx_vref_tune = PHY_TUNE_DEFAULT;
+	else if (is_imx95)
+		imx_phy->tx_vref_tune =
+			imx95_phy_tx_vref_tune_from_property(imx_phy->tx_vref_tune);
+	else
+		imx_phy->tx_vref_tune =
+			phy_tx_vref_tune_from_property(imx_phy->tx_vref_tune);
+
+	if (dev_read_u32(dev, "fsl,phy-tx-rise-tune-percent",
+			 &imx_phy->tx_rise_tune))
+		imx_phy->tx_rise_tune = PHY_TUNE_DEFAULT;
+	else if (is_imx95)
+		imx_phy->tx_rise_tune =
+			imx95_phy_tx_rise_tune_from_property(imx_phy->tx_rise_tune);
+	else
+		imx_phy->tx_rise_tune =
+			phy_tx_rise_tune_from_property(imx_phy->tx_rise_tune);
+
+	if (dev_read_u32(dev, "fsl,phy-tx-preemp-amp-tune-microamp",
+			 &imx_phy->tx_preemp_amp_tune))
+		imx_phy->tx_preemp_amp_tune = PHY_TUNE_DEFAULT;
+	else
+		imx_phy->tx_preemp_amp_tune =
+			phy_tx_preemp_amp_tune_from_property(imx_phy->tx_preemp_amp_tune);
+
+	if (dev_read_u32(dev, "fsl,phy-tx-vboost-level-microvolt",
+			 &imx_phy->tx_vboost_level))
+		imx_phy->tx_vboost_level = PHY_TUNE_DEFAULT;
+	else
+		imx_phy->tx_vboost_level =
+			phy_tx_vboost_level_from_property(imx_phy->tx_vboost_level);
+
+	if (dev_read_u32(dev, "fsl,phy-comp-dis-tune-percent",
+			 &imx_phy->comp_dis_tune))
+		imx_phy->comp_dis_tune = PHY_TUNE_DEFAULT;
+	else if (is_imx95)
+		imx_phy->comp_dis_tune =
+			imx95_phy_comp_dis_tune_from_property(imx_phy->comp_dis_tune);
+	else
+		imx_phy->comp_dis_tune =
+			phy_comp_dis_tune_from_property(imx_phy->comp_dis_tune);
+
+	if (dev_read_u32(dev, "fsl,phy-pcs-tx-deemph-3p5db-attenuation-db",
+			 &imx_phy->pcs_tx_deemph_3p5db))
+		imx_phy->pcs_tx_deemph_3p5db = PHY_TUNE_DEFAULT;
+	else
+		imx_phy->pcs_tx_deemph_3p5db =
+			phy_pcs_tx_deemph_3p5db_from_property(imx_phy->pcs_tx_deemph_3p5db);
+
+	if (dev_read_u32(dev, "fsl,phy-pcs-tx-swing-full-percent",
+			 &imx_phy->pcs_tx_swing_full))
+		imx_phy->pcs_tx_swing_full = PHY_TUNE_DEFAULT;
+	else
+		imx_phy->pcs_tx_swing_full =
+			phy_pcs_tx_swing_full_from_property(imx_phy->pcs_tx_swing_full);
+}
+
+static void imx8m_phy_tune(struct imx8mq_usb_phy *imx_phy)
+{
+	u32 value;
+
+	if (imx_phy->pcs_tx_deemph_3p5db != PHY_TUNE_DEFAULT) {
+		value = readl(imx_phy->base + PHY_CTRL4);
+		value &= ~PHY_CTRL4_PCS_TX_DEEMPH_3P5DB_MASK;
+		value |= FIELD_PREP(PHY_CTRL4_PCS_TX_DEEMPH_3P5DB_MASK,
+				    imx_phy->pcs_tx_deemph_3p5db);
+		writel(value, imx_phy->base + PHY_CTRL4);
+	}
+
+	if (imx_phy->pcs_tx_swing_full != PHY_TUNE_DEFAULT) {
+		value = readl(imx_phy->base + PHY_CTRL5);
+		value &= ~PHY_CTRL5_PCS_TX_SWING_FULL_MASK;
+		value |= FIELD_PREP(PHY_CTRL5_PCS_TX_SWING_FULL_MASK,
+				    imx_phy->pcs_tx_swing_full);
+		writel(value, imx_phy->base + PHY_CTRL5);
+	}
+
+	if ((imx_phy->tx_vref_tune & imx_phy->tx_rise_tune &
+	     imx_phy->tx_preemp_amp_tune & imx_phy->comp_dis_tune &
+	     imx_phy->tx_vboost_level) == PHY_TUNE_DEFAULT)
+		/* If all are the default values, no need update. */
+		return;
+
+	value = readl(imx_phy->base + PHY_CTRL3);
+
+	if (imx_phy->tx_vref_tune != PHY_TUNE_DEFAULT) {
+		value &= ~PHY_CTRL3_TXVREF_TUNE_MASK;
+		value |= FIELD_PREP(PHY_CTRL3_TXVREF_TUNE_MASK,
+				    imx_phy->tx_vref_tune);
+	}
+
+	if (imx_phy->tx_rise_tune != PHY_TUNE_DEFAULT) {
+		value &= ~PHY_CTRL3_TXRISE_TUNE_MASK;
+		value |= FIELD_PREP(PHY_CTRL3_TXRISE_TUNE_MASK,
+				    imx_phy->tx_rise_tune);
+	}
+
+	if (imx_phy->tx_preemp_amp_tune != PHY_TUNE_DEFAULT) {
+		value &= ~PHY_CTRL3_TXPREEMP_TUNE_MASK;
+		value |= FIELD_PREP(PHY_CTRL3_TXPREEMP_TUNE_MASK,
+				    imx_phy->tx_preemp_amp_tune);
+	}
+
+	if (imx_phy->comp_dis_tune != PHY_TUNE_DEFAULT) {
+		value &= ~PHY_CTRL3_COMPDISTUNE_MASK;
+		value |= FIELD_PREP(PHY_CTRL3_COMPDISTUNE_MASK,
+				    imx_phy->comp_dis_tune);
+	}
+
+	if (imx_phy->tx_vboost_level != PHY_TUNE_DEFAULT) {
+		value &= ~PHY_CTRL3_TX_VBOOST_LEVEL_MASK;
+		value |= FIELD_PREP(PHY_CTRL3_TX_VBOOST_LEVEL_MASK,
+				    imx_phy->tx_vboost_level);
+	}
+
+	writel(value, imx_phy->base + PHY_CTRL3);
+}
+
 static int imx8mp_usb_phy_init(struct phy *usb_phy)
 {
 	struct udevice *dev = usb_phy->dev;
@@ -237,6 +516,8 @@ static int imx8mp_usb_phy_init(struct phy *usb_phy)
 	value &= ~(PHY_CTRL1_RESET | PHY_CTRL1_ATERESET);
 	writel(value, imx_phy->base + PHY_CTRL1);
 
+	imx8m_phy_tune(imx_phy);
+
 	if (imx_phy->tca_base)
 		tca_blk_init(usb_phy);
 
@@ -353,6 +634,8 @@ int imx8mq_usb_phy_probe(struct udevice *dev)
 	if (priv->type == IMX95_PHY)
 		priv->tca_base = dev_read_addr_index_ptr(dev, 1);
 
+	imx8m_get_phy_tuning_data(dev);
+
 	return 0;
 }
 
-- 
2.43.0

