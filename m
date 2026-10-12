Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506F5CA9ECF
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 02:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12E9140641;
	Mon, 12 Oct 2026 02:01:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dZCDQW2IzJ8U; Mon, 12 Oct 2026 02:01:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D60AB40637
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791770510;
	b=pbGN5d/+6RE8PLFsgZliG6KNUmFqcof5XJrYdDvd+Lks3SmPvZIu8tK29+c7BYJkuvl5
	 GtVKSepVHciK+vrfOPLuiOUCEdK3VlcRr/FVxLL5U6j0Y4mYN8UuCeqfoBy9a+0i5E6f3
	 OZd75yk1mkrNBnGUU8B96dXRoticQ+rMRnJMV5tyif9vx0ThpuSHs8uYM7ttdXSc7RfOn
	 L/L6RQQi4dyaVqa5TGSLeL9V2t8/8SKqgRivl69puB8z2DqBJtZ/x9FEIjSjVg1QRHWRk
	 WfNVb9m4TiPmcK1ir/xcXFi6nOJ8E0iIV99Ijy4Z6YUG+QvR9rpBzyUasmILJGLb5Lg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791770510;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:X-Relaying-Domain:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lviH6JJfYVz298L3jUcHvKFOdksCjpP+18YSfvkXl9c=;
	b=Rc/nlBYmrfu6fofy4BumXETbbo1oaxuYoB5plGuOUHslpohfWa4sfe3omNI4SP1mxtzp
	 T85OVKHRrFIM9BFtMVW35ORtJXAmUkk8KcZhgCzWn4T5HrzWQuglUZ4bMvQuslbaXvJTO
	 CMI3U23TzmbNc7eF0fG0b47AWAOmGE6b45UDNotnnNHAy8qFARVqTT0Ws/sDN9nz8y7dC
	 JGzac9jQB9llaNNrenPe7EWR1FjZ61a2rt/KZghKqz0rJrsCC6CJsCZ6VrCQF3dhcPWnd
	 6rLZ0SmYLhQsmWefu3cqdFdzDmTZuWlLARPl/ii3k4rpVU3zfJrCo62LptT3E2I+lDg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791770510;
	bh=lviH6JJfYVz298L3jUcHvKFOdksCjpP+18YSfvkXl9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VbD6Bv305Y4la8zS9iCAi4OHll2n/+bffS7ipCB3ko2hylDD7H1JVAzc95xgtL++K
	 XdyAvstNx+cE+nz4CMH1vPMIgQuiBKbtyaxbCOiVhHAPVPNH5WFaCgMz6JhL8Gbop7
	 DNWozuw4qzrFHbhgp33FnnyzNHYB7RKdDaBSk1DacJ5TEoylG5gLY5S+Hs59gm2mPc
	 sg/1XovNzE0MpY6gqDnVxLZZiA+KGI8nenQ/ZTZYPiZXGp2kByUjpZx4lNx0JTB5py
	 Wt/4HmxqN+PPhbNqxSXIVGmqeo9PsFuWUFFTyCH2ZzZ5+20FGApYDOYd2R79Mc8Mgf
	 1dYVim8+9SCIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D60AB40637;
	Mon, 12 Oct 2026 02:01:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 722EA1A6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 402A580CEA
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eD2hIo917oiu for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 02:01:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 384AD80C41
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::662"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791770505;
 b=OmsxxO2tImiSqv+IGAGuzivKqoznhD4dv+oSYQzJ6ZwnUrHDwhOHQhJmXwrynx/fsv+B
 9p0X6wtNQsTSgRYb/nNA2dbpgiYVqHQz3LFxK3lkyYSwIVQLB/Jr9bh+W25eKrvNbSuGt
 JCrA83HxW9zoTFWfTJwIDB8FwW6ykdbMADUk+hO6oWmEp2aCxznEGhiGTJUI8DcFdNiPp
 a1+M20x7kZ6pujKNcOnEyqsc4vJIzKbqRwx77JOH8SXNGta4deAZ/yOYs1DpogfLuje4Z
 +9xKaOUBq+3dlowKyVgHB6v1T27opIHCsI1fbOxP9/V+ql9G8N10oxTSeIqDmCHbSEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791770505;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=lviH6JJfYVz298L3jUcHvKFOdksCjpP+18YSfvkXl9c=;
 b=OgPrA83xNYGha2VhumEHqOli+Y+UVFy2iDwkPoTbXoJc4+l681e87Lytya1sNvp7CFG1
 nEv1HFsMC+L/QF9Y53Aa07SiCqkDcvRY/hSF4dJ32xrp2XReR8/654eNEOtXWqQJI1dWV
 ETe0coZRMAg0X2lJtnqxQVF/Dg0Y3554YR0foL9Wv/bGCLCnRHKwT6QbMuN5/LNxZH5fd
 gwCn3jcGQAd0zUVZtY87WlzL+CrMOhmEEAPbp8pklBuUSbD/TdYeEiekoqGAAHhWb27ho
 ApKgtRPc+Wdw95v1ceq600FvWoCWoSwGUqWAZah7zHfrvTDkduvSsK/eYs9tc4JP59w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=ausil.us;
 dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b="hzyA/ZSi"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::662"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::662; helo=mail-pl1-x662.google.com;
 envelope-from=dennis@ausil.us; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=ausil.us
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ausil.us header.i=@ausil.us
 header.a=rsa-sha256 header.s=google header.b=hzyA/ZSi
Received: from mail-pl1-x662.google.com (mail-pl1-x662.google.com
 [IPv6:2607:f8b0:4864:20::662])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 384AD80C41
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:44 +0000 (UTC)
Received: by mail-pl1-x662.google.com with SMTP id
 d9443c01a7336-2e623eda81cso7870285ad.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1791770504; x=1792375304; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lviH6JJfYVz298L3jUcHvKFOdksCjpP+18YSfvkXl9c=;
 b=hzyA/ZSieGV7rBgeyJMU/jiRQF7sMuS69NVrRqusRRAi5PftJg/SgnDYzJyX/0Vi7/
 ItfVGcMpIKEsEKm5x0/5Q74YWwcjuwLrE6PQkuaKHEdfFLCvWI9aUO3N7Xcm4cFrtBmw
 qZqLxwCqqoDich1JvXUiYnZmIDK6AQ+1dbFzqIH9Ro4xnbjnwSDBXw2upS0W6Ziba7hf
 hDwqiSRUGPehxllP/EWlu33ZCIQq65jt4iXs5KOSR7wK2vZ1L4y91XwTMTntZlzXxr1j
 Kgxtn20O6zNfz4VhLaIcK1VN57niWUrBsLdSLmA6ayy0VSry4fJNlFWqxzrdEWsrhIxG
 hZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791770504; x=1792375304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lviH6JJfYVz298L3jUcHvKFOdksCjpP+18YSfvkXl9c=;
 b=PTGrIkK1yUOzGtjz1EasApXSgbSCH8EWQacek4+ejnSqIU54XS+ZEpIZUEVbOb0snK
 iVIQWTjQwauf9LZc1OQKWGUaMXVTJbpbEvvXvNnA1/3o9w7lGywrTEQqwwelxcvqHIwL
 gNLKd+qiTF+Fl0SRNIgV5n3XnQY357qfe+rM2s6IaS8x+qc+2a9RAzYnkp2in9Excj9p
 zqn4votVhCpzlCdX6WZ6XmNTYnDqtBbq9zTLTwkZdwQ1DpW+PgHtHz+mGhSHSK7z0XHr
 KDH/vh+hkK3MgvjxXgukD4SqvYZXfVYeVU1filDdTMg9vOBYQNO3K1KIvB9jy7zk9p1a
 ZLOg==
X-Gm-Message-State: AFq9FYLHy9ZumYPRQ/0PlFQBl65Ss/TlFpUDeOUUw+mYGrY2g71yUc/O
 5yF/MhyFECQOxf7KbdwBDq2Dh0/7IkLiIMeBrkur5nzJjR8W0tW+kU+qJG6a95WBNBnvOs/cbK0
 YzIHLYiK+pQNcvy+MTjNAdTBsZCUuY6+DHqcqEWX16FP8
X-Gm-Gg: AYBFou25TtD7q6c32qnfz3janMH5RWQJZxYS9G6eCDMWGQyOcglx6/U18JFtotY0Zy8
 jy45sZJjU1fl1Q64Mrj9J6OwmCwbp+upOsFKJSM7OV3C5Eq2uZLo4JWwaT1pQVakJHsQPMoOvUQ
 vf3AqbcCkKhoFJLRVMyaV3R3FDk9uLOMq/h+6aeGAu4WhNb+bx2Cww13A7ZZp21Ola0dj7TIxI6
 cIBOKWt9mxBhAjaYSq6+Z32RQ0lDFiRLRWhjXyLUqVQr88SJDuMMq6SrW71Ca9imE8l6Dl+Boik
 A9/k8DIzQkG/bOhgU0IPlrbFGnoSTKey5iaM/0bkAK/+QXO9x9jC+n99qnrefGgvM5nIYimPAnN
 18hcgRXgZaQxM++goMS1TqCqV
X-Received: by 2002:a17:903:1745:b0:2e6:2843:6e86 with SMTP id
 d9443c01a7336-2e842ab6a3emr60212275ad.12.1791770504289; 
 Sun, 11 Oct 2026 19:01:44 -0700 (PDT)
Received: from tomin.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2e84131a272sm3254325ad.0.2026.10.11.19.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 19:01:44 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/5] board: rockchip: Add Xunlong Orange Pi 5 Pro
Date: Sun, 11 Oct 2026 21:01:34 -0500
Message-ID: <20261012020134.621305-6-dennis@ausil.us>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261012020134.621305-1-dennis@ausil.us>
References: <20261012020134.621305-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Xunlong Orange Pi 5 Pro is a single-board computer based on the
Rockchip RK3588S SoC. The board provides many interfaces, including
two HDMI output ports, a PCIe-attached Motorcomm YT6801 1GbE port,
an M.2 M-Key slot, one USB 3.0 and four USB 2.0 ports.

Features tested on an Orange Pi 5 Pro 16GB:
- SD-card boot
- eMMC boot
- PCIe/NVMe

The devicetree is taken from Linux v7.3 via the preceding dts/upstream
picks.

The upstream devicetree muxes the PERST# pin of pcie2x1l1 and
pcie2x1l2 to the controller's dedicated function while also using it
as reset-gpios. Linux switches the pin to GPIO when it is requested,
U-Boot does not, and probing pcie2x1l2 then hangs. Override the
pinctrl in the -u-boot.dtsi to use GPIO function for the reset pins,
like rk3568-rock-3a-u-boot.dtsi does, until the Linux devicetree is
fixed.

Link: https://lore.kernel.org/linux-rockchip/20261002025746.3284691-1-dennis@ausil.us/
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---

Changes in v2:
- Add Link to the Linux devicetree PERST# fix (Quentin)
- Move MAINTAINERS entry into alphabetical order (Quentin)
- Add Jonas as reviewer in MAINTAINERS (Jonas)
- Drop USE_PREBOOT/PREBOOT (Quentin, Jonas)
- Drop DISPLAY_BOARDINFO_LATE, Model and SoC were printed twice (Jonas)
- Drop OF_SPL_REMOVE_PROPS, use the default (Quentin)
- Drop VIDEO, DISPLAY, VIDEO_ROCKCHIP and DISPLAY_ROCKCHIP_HDMI, not
  supported on RK3588 (Quentin, Jonas)
- Enable LED and LED_PWM for the PWM LEDs, CMD_LED is enabled by
  default (Quentin)
- Drop EFI_SECURE_BOOT and CMD_NVEDIT_EFI
- Add Reviewed-by from Jonas

 .../dts/rk3588s-orangepi-5-pro-u-boot.dtsi    | 25 +++++++
 board/rockchip/evb_rk3588/MAINTAINERS         |  7 ++
 configs/orangepi-5-pro-rk3588s_defconfig      | 74 +++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 4 files changed, 107 insertions(+)
 create mode 100644 arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
 create mode 100644 configs/orangepi-5-pro-rk3588s_defconfig

diff --git a/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi b/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
new file mode 100644
index 00000000000..142db4a0fcf
--- /dev/null
+++ b/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588s-u-boot.dtsi"
+
+&pcie2x1l1 {
+	pinctrl-0 = <&pcie2x1l1_reset_h>, <&pcie30x1m1_1_clkreqn>,
+		    <&pcie30x1m1_1_waken>;
+};
+
+&pcie2x1l2 {
+	pinctrl-0 = <&pcie2x1l2_reset_h>, <&pcie20x1m0_clkreqn>,
+		    <&pcie20x1m0_waken>;
+};
+
+&pinctrl {
+	pcie {
+		pcie2x1l1_reset_h: pcie2x1l1-reset-h {
+			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie2x1l2_reset_h: pcie2x1l2-reset-h {
+			rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
index b64dd4947ee..8dde58bd3ef 100644
--- a/board/rockchip/evb_rk3588/MAINTAINERS
+++ b/board/rockchip/evb_rk3588/MAINTAINERS
@@ -47,6 +47,13 @@ S:	Maintained
 F:	configs/orangepi-5-plus-rk3588_defconfig
 F:	arch/arm/dts/rk3588-orangepi-5-plus*
 
+ORANGEPI-5-PRO-RK3588S
+M:	Dennis Gilmore <dennis@ausil.us>
+R:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	configs/orangepi-5-pro-rk3588s_defconfig
+F:	arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
+
 ORANGEPI-5-RK3588-ULTRA
 M:	Niu Zhihong <zhihong@nzhnb.com>
 S:	Maintained
diff --git a/configs/orangepi-5-pro-rk3588s_defconfig b/configs/orangepi-5-pro-rk3588s_defconfig
new file mode 100644
index 00000000000..b560cb32401
--- /dev/null
+++ b/configs/orangepi-5-pro-rk3588s_defconfig
@@ -0,0 +1,74 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-orangepi-5-pro"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_EVB_RK3588=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-orangepi-5-pro.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_PWM=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de2df3046e2..dfaceb40f46 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -179,6 +179,7 @@ List of mainline supported Rockchip boards:
      - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
      - Xunlong Orange Pi 5 Max (orangepi-5-max-rk3588)
      - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
+     - Xunlong Orange Pi 5 Pro (orangepi-5-pro-rk3588s)
      - Xunlong Orange Pi 5 Ultra (orangepi-5-ultra-rk3588)
      - Yanyi Tech CoolPi 4 Model B (coolpi-4b-rk3588s)
      - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)
-- 
2.56.0

