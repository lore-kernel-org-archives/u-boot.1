Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E48CC6B1A
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 17:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A78454031B;
	Tue, 13 Oct 2026 17:53:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9IDla05qhsnI; Tue, 13 Oct 2026 17:53:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02AB4403A7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791914020;
	b=BYlyV4A3aDZfl0oav1vVcCKpFBqkBs3qAtMN/FMF7OzqE58JaWegf7K8tQb/tsmo9wwk
	 xP7oJBh/i2Xa9r5/sZvI+t+qQ7HIqgXpr2JoVq856onS/WM+MOEofRpWKg0E3j0P1InTp
	 sf+HUxwZP4YaZjx1EQGMylLG4Qim9fcWcG9Gwbi0BSOGdNbQ23BtjifGGJhCsEqQ1XtLK
	 XKpRqRTD8zfwqJEifkCJvqzCdblfOqvVCX6NdRam4/JLS7inA8z17NG69+Ez9qlzg5P9k
	 tqhg1JnOtQYdrcUEP4w33XHH3SUhxniMCv1cOmehYvVuUCm3m352lFuK+D1So7OAHVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791914020;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:Errors-To;
	bh=m+/O51oTcd4bxx3wFfiWXT1NZat5nTKbeMrLi4KFCec=;
	b=M336KWUQQ8pY1Ul9FMyVh8LMJKqwb7HQX1Fbmp47YUkGIH12entVIbI2jNqewwqard2r
	 Pyp2Fn3RSe56fAawUxyLOwwwSQamozNRZ8o1mDkdlc+6R/UuTkD3VkLZpXvAZVO6yF5DE
	 PXucmKIz+c0bYKg7eU4efXBZ35Y8p2bCAvA4YqAWT2Os6pTUonilD4f8U2MF4DpW8HrDF
	 0gnUxCzQTo0kcf0Zsq0D93VVKhzzf/VsM+3uz68PoXZj4eQJOkd6noRgtgjt2JruY4Ogm
	 W6f+trMdHbZ1wIa2oKr1Euo68wVlACKOBBx4BX8nrFzzb5Ig97scfl0ywDxlEmodbcQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lGeZyYtt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791914020;
	bh=m+/O51oTcd4bxx3wFfiWXT1NZat5nTKbeMrLi4KFCec=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=J9xsvgRhhhHc8ntehN+IqYAE6/Zcy2WwsL/vjxiaHZJymflUMvZLgg+OLfXqrXeBX
	 JpPeXv0FCM4RhcHq7PJwG0rcsoqhHcpfclgvKM0R7bKp2cLGC+UK4+3TcuFKYXqQSr
	 54aXv59oSinK5R61FaUUyu90BSQ/wGYW6xqfVWCzhORN/mqCzqkPqYKcy3cmeFqDx2
	 g/1vxpgYpvrFhqbfCXpMcrmOrKqtEpPOcnfzpN/wTRG+Aozcu8UASznnH+X2XwKlLV
	 h3xmYHNDsd1wReakjJ+OcirAKI5RlM2uyoUAfJC98ZL173BwWBY6u2vHY/jUBE7ZSa
	 spSDJLak7atlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02AB4403A7;
	Tue, 13 Oct 2026 17:53:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 780B075
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69C26403A7
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:53:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JWr-M6sIDhpi for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 17:53:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C97F94031B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791914017;
 b=PKGKSbaFlVc7ZWzwD+VZbg2QPp3HlVXn9WKgOB2biN1QxSKPoXx6rhHAZ/yB72vgqtFa
 skqmtcDhNL5xDfGjDXcusKGEqJ8/GOEw/33pRmYC8IJYiaL4ySIRQ7uppycqMKcl3OQ3z
 RxZiiE5u/sn3plRpXuLUiX5L+nTOfjnCruDnCfKNOtKi186whwMCYWibYOQEQc47yon3J
 A1zrnwV7gLIoQjhpqlCyADPXDMAyUHpLZrEKbYxlXNE6H/p9Sm976ZLqQHKOUtx//SlMF
 tMEfdx2kvjyKmora93AN0OsXPTpVbxiLQ3rVxGpfJA0DkkYqjDxVc6MIvm6jUYOLh7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791914017;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=m+/O51oTcd4bxx3wFfiWXT1NZat5nTKbeMrLi4KFCec=;
 b=mObXjDmAtC3+cKC8ichL+gs7jc9GR6DKizsUFJIoGcra4V4bIqrdp2tynfCgCtUlqi7D
 jGLmfrApb3GWOGNEAynTOk2aCXyudRPmUl8jSLvvnjQKDs1emho9+/12p1FgKmd7vDG4u
 2HXrXS0pQHclIyGid1oa+9hJ7Wd+oFC4c6AchLeuCVC++ahOgwoZ6f2xdwopRO4MQ8k1h
 RdoEL0VrcNi8ppayzy9cG4DRdVwHSzvd6wXyzRph93oT2VuApOYcpkS7IomA0NKbRHEWV
 WfAkKiaGgnhJWBrPuXHe7LbwyW5XH4p+seBEK0jJO8LX3WdeGtem3iKC1OBP1R6nPbA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lGeZyYtt; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=devnull+iav.iav.lv@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=lGeZyYtt
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C97F94031B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:53:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 76B2640C52;
 Tue, 13 Oct 2026 17:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58B41C2BCFA;
 Tue, 13 Oct 2026 17:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791914016;
 bh=GjuW0xVjuChdhF8eXw8FxorM4tcTp3XzAHW7nNVgc2s=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=lGeZyYtt5pOCqGF2sFfA4neKLLdrjeXZ9Q/aL7dOR41vN2zl1vghbSqFZZX/OLtAD
 fOHof8oYzh18Bifqhofx8xAW5i6f7v0556ew/UHA0tyrBcjJ0FxmACNnKt0Bu/jX1y
 rb8SQHxRhxW51DkwUjD8W2XGdECJ0XJ3UX9OHyQbGiFjHziUyzN/eM9ziXI3eHhjZX
 a2U1/p7o7A7R96S3v2kA0FCQeFfX3F7RlBASv6A9UMJvw8ZfYFriFm7PXN36g35E8B
 ZTdlejOKqXpaJ5Og3XF0TCnKPDftTe6Ek2G1nw2duNajpmSp64V/RN4JjX3Rbg5MNL
 pMIkCGKrfDbEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 44386CC6B12;
 Tue, 13 Oct 2026 17:53:36 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Tue, 13 Oct 2026 20:53:34 +0300
Subject: [PATCH] arm: dts: meson-sm1-odroid-hc4: power-cycle the SD card at
 init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-hc4-sd-power-cycle-v1-1-cde760a256a5@iav.lv>
X-B4-Tracking: v=1; b=H4sIAB1wzmoC/x3MTQqAIBBA4avErBtIM6GuEi1SxxyICoV+kO6et
 PwW72VIFJkSDFWGSCcn3rcCUVdgw7wthOyKQTZSi0a0aBQGqzA5PPaLItrHroTeSKV170zbd1D
 aI5Ln+/+O0/t+ToIaRWcAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=tR/RFYgAqbY87MOye/X3GfkLr/MIhX3x0TK79SL/+gg=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFnnCuTebzBRkLR1C+N5XVVhc/bU4ePe07ObuXzd3DYfD
 hEXkFvTUcrCIMbFICumyDLhkMatjCVX//p7mD+AmcPKBDKEgYtTACbyfB0jw96599raVr42938l
 /P38ued23S8717Ov2G1X7tM7XyKnaCPDP7WE9T/32Rj0sXgUvgkozkn1C6q3y+M9t+zDFY02/6v
 7mAE=
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
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
Reply-To: iav@iav.lv
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Igor Velkov <iav@iav.lv>

mmc_get_op_cond() power-cycles the card, but both SD supplies,
TFLASH_VDD and TF_IO, are regulator-always-on in the Linux device tree,
so regulator_set_enable_if_allowed() leaves them on. After a watchdog
reset a UHS card is still at 1.8 V signalling and U-Boot fails with
"No partition table - mmc 0".

Drop regulator-always-on from both supplies for U-Boot, and keep
TFLASH_VDD off for 100 ms before it is turned back on. Linux has to
keep regulator-always-on: the boot ROM does not turn the supply back on,
see Linux commit dc7f2cb218b5 ("arm64: dts: amlogic: odroid-n2: keep SD
card regulator always on") for the same supply on ODROID-N2. TF_IO
keeps regulator-boot-on: after a reset a pull-up on the board enables
it at 3.3 V before U-Boot runs.

Tested on ODROID-HC4 with a UHS-I SDXC card and U-Boot in SPI flash:
after a watchdog reset 3/3 boots from SD (v2026.07 without this change:
0/3); cold boot, reboot and suspend to RAM unaffected.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
The card holds a btrfs root, so the main build under test also had
FS_BTRFS, CMD_BTRFS and ZSTD enabled; odroid-hc4_defconfig has none of
them.
---
 arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi b/arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi
index 963bf96b256..5f09ecc8f60 100644
--- a/arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi
+++ b/arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi
@@ -18,6 +18,16 @@
 	vref-supply = <&vddao_1v8>;
 };
 
+/*
+ * Let the MMC core power-cycle the SD card: after a watchdog reset a UHS card
+ * is still powered and at 1.8 V signalling, and U-Boot cannot read it.
+ */
 &tflash_vdd {
 	gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
+	/delete-property/ regulator-always-on;
+	u-boot,off-on-delay-us = <100000>;
+};
+
+&tf_io {
+	/delete-property/ regulator-always-on;
 };

---
base-commit: b871f72273c183ab557e29f9bc52d9065e0aacf3
change-id: 20261013-b4-hc4-sd-power-cycle-fb24669db395

Best regards,
-- 
Igor Velkov <iav@iav.lv>


