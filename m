Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24458606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XvO8WY8o;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u8v1yeiB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2581811BE;
	Wed, 28 Oct 2026 14:47:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iVtq9__BC6f4; Wed, 28 Oct 2026 14:47:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8067D810B0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198808;
	b=evBaFP3215zyKbGzNXvgdzhNYlw6P9A02A+k11GHZ53PBohx9HcY+/DNCQpMGMLwSCJw
	 SpUUugVLeikTEQwexYdo4aBZIVdWzDyrmg1Kr3GQOGctCWirJwvPvHi34BrySM8ThDmV6
	 TOcgHRC8NUlGM+Z/I+6bgnarxrj/BRQc4aFTvwL8SvhzW9fo/0nLsYhQUSmQkBRNCRx04
	 hHumkXNOtu40H0ektI059K5y1g9j3/cxYiiIt4wKHzK0K9YIKhgCuUkyWXnEdPTSgC3Ir
	 TUMIeUmMXw5F6F8Ubky/kmploBuYbvpbtCtdoaKgPk8U30nGWMDAccVwnb43w9gbLJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198808;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Hy7fIVFAaUbLSquXCa2GdLE41Vlred20cKXgitQHXp0=;
	b=GgeKgMEFWt40l/l9/s2le+8vYSJ0FRSLnupb4NdmXTDftO+6OcvGGbubOruaxwIgMruk
	 sY9iJu2+PT78zwc2gN4fXGD93j22v1lsb6Rny0qwDGDAQkAcaBImA5BDj0YBjmqhlhzlo
	 TjXkZSaLs+foJZV6x82uzoYN3dws6kU+692T/Dz72b3tJ0+39rrg3H7cyoDnLRblxovyF
	 Q8VAIkLOQatidL8iI0cyUOfKQvuewhIj/HbRDD8YKtwtn9Z0a5mqFJQqi7Q+K++Kigt/Q
	 oucjA81BDpgsGt+f6vNFqX/S2lRlQdaU9XMdLdfbVXr3OVU1xIUnmUjQ5aJM/iS35aA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198808;
	bh=Hy7fIVFAaUbLSquXCa2GdLE41Vlred20cKXgitQHXp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XvO8WY8ofoNYL00tujZlu4EwLTRgBLX7ZpCQfMuvrPtSFosVlXEy/mb3u1atbg5G2
	 9qZEdSe5DQHfo+ztyGk4tUGih2asl+HyWJcffgVVVvRakNhtO9LzlUuvH9PbgFt91t
	 bCXE2Kd1p3ZuYC9wxmBKtkTM9X7Sk5mMGrVaRQs2IuM9cSwuipHegD5Dz77xaRaM3S
	 NpkXhwf6vQAJrqW7lTVFVXw8fIwngsYRFZ4zCvwcRmTJWOzaCBjcIFDT2d9jj8VgLh
	 saf1+qgoeeV1685HjaCLyrG7C9wtLbRl1z24oWXjKs6jSmnqZbZI0RsFeyjvUmEIRB
	 ejGtgUjoVuTMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8067D810B0;
	Wed, 28 Oct 2026 14:46:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9ADA2235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 816D140523
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4PZjYhSyrmFz for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:11:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA95A404DE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196710;
 b=e2bd5jnaW/tlqnMa+e0m84+Xtw3ygsd+en9ZarAZUk0bN2MAxXvMRBtC24YLr2K439i4
 IPGMJfbkp180t5Q9Xg8ifl5bOPWjQt59C0fWWs3OfmLzSQ/uvBj2BccR1BSYu1/98zmR1
 V5pg2rEXIE/+69Y4UmNJ2ENxkOKvVWwp2BDmtUKjs1ZndxS4yI0nITOUjOQnOWnWYiQqo
 1pfXCgKF2tRx4iw5LKTXTW2AA6aaYhbOOMtX8d8Hy6sXbD0Q9fDg8KVgxFFF+RfFH9rTn
 IyK4iXXRzfDb7YLlUv9l6x3lAnfQAYDShWHQGoS7hFmA/crPwfMWOcFpH3VYC4oNyig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196710;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Hy7fIVFAaUbLSquXCa2GdLE41Vlred20cKXgitQHXp0=;
 b=hCdF81h/ETeqVjmIY2c/vJYn9zwXRinvGl+9BmyhQrRFvyn/R5JrZGDFKjWEoi51MZGO
 AB/m5LHKvQPVSZsfyIROfc+NL2xWARArNyQXzz2xbCyGXnGq8SIbKVPKLbmivMAql/hay
 GaZgasQXwuwIpnvguijBg53joFDgwbCaBLBggt3qviD7h34L7HyoG5WfsgFtP+xs4Ykhw
 q7AxlFJBJ9n1ldogZKVUm9OwvCLdoxB7mtYfh78via98ckc8mQDOr83MHrZqQfML2oum2
 UHxanJVHyit64qT6dXGZsm8oEHLi8ybt0Zf5ymhY5tjnG8q2MvwJ9tjA7ZOXzt1Bgbw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=u8v1yeiB; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=u8v1yeiB
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA95A404DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:11:49 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c4015fb0b42so10390766b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196707; x=1793801507;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hy7fIVFAaUbLSquXCa2GdLE41Vlred20cKXgitQHXp0=;
 b=u8v1yeiBuS2mQbIZszhGQdZniqdr91njCdAk1G4U62keQ7m/b+gxD2sGfoPdwaVNoi
 rF8BiH0ZLVFrbw0msgP0sS2/x+UqUoWqxwXEh/9u9FyJ2fUDzdReUKW6mtAc4KS9GWKd
 /iPajsxoPXMD8J2kbRrwm30WqNheTSgz5ortibADApy4/Iwl20xwkyy+G1ScuRieI2fc
 8uc74IlbpazfBLuga/FclBJ19mqyQ3QI6DwVE8MeKiMiQV+4JMRGaz1JVABBcxY3Hl79
 0AlQPnmsnszxEAu+m4msvQ96PEilwyApDB4f+0z8oxGG4FBCrXePJPtG20K4LVSWtzKX
 eGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196707; x=1793801507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hy7fIVFAaUbLSquXCa2GdLE41Vlred20cKXgitQHXp0=;
 b=WQKx24LC4aXr8U+IuE39ASuEsSxLoBgkDSSmaA9C4+D4B8ge2w2GD6yliS7TUVxe47
 1ht9q+ADHo2+wHECYJdG0EHN3KDAMdOWyDksgWzB44x7bB5dwl/kQ0h0PzfkVbnx7v5z
 6iQB3gFTyTpNO5f4vvGvKxyJKnx4jLzOkUM3GmK3hFbJr4Y06zQLUsI+b+33Es6A8Gmb
 iZ9pSqiZdKSfIZNsWM0k6KZLYM9QTF4SfT9MwPl04MXHJ/kmu1/wMF0QM2HCwh2Pfgba
 qLU7iT3voCt1v0/xgPpo4ujlAm+KW4+X6M+44GTbO6jIl2i8Z76lBM99Jfq6y2rSue5y
 +HQQ==
X-Gm-Message-State: AFq9FYL87BjjwLj1LoIZW8Da5fJoEH2n4Wj7dupWo7cdtPOtHszUh1sc
 7jF+Z6RUuVfKdjvxymLgitSjoamrZyr5nFOINOFifUITDftl0fg+ro76YT9MYnudOUtAs4HXC8U
 Xpkqj
X-Gm-Gg: AYBFou3muAOdpS7Oc45l6LuUBr3Yxtl/xcxeN0ITTlC4ZqkHU0+jte0NRS/bdZD8Z66
 jZGZBgPUASJTW8hv9lM1WvHAmGJUZfXiqvbMVhagV4bOK+OpHFuuocm6yxdEcAYN7HCE5Hq6E9s
 VaCn0Fgc1htaYKH0HogZhlW8RYAWd7wIfyuERn4QekNwD3nlJNZ5Jypn8pGc5l5KWhrg34Ookye
 RCgR11ws7wNOrNYRgbSZaJgIEIYTu/TiwIbOM7irdcAf0llmu1WXKryZp6fdopVIQBa3bXazEJJ
 LmmKRMfBFIP4/p2jfW6LC0vDnT5U15emX4Sks4TZbllxOvIS28qmQONEkIEp55duIO+4A68iS0e
 5GsoPwuxjdURB5Q6055Z4oQWbjJ6cgc+rsgRxjkNyWajox10+MQ4dZfIvfqj5B2ZFlyCn0QxCDq
 /akXNOzL9BSJqM81W5QK/sd6+p6aRRowio4xKYrM6scfW2+7vMddj0tJ1yky4f+9FZ7oITkIDmA
 twPnh5rxtsTpcxzuroq6thnLlxB0JroNwgaTAqC2yUhrJrz8iHS6/x4S9dzFK5i3kodZSpgZevw
 +HwQN/SAPTeGi1e0d+6AHNLMhBf9oUjWA7cGrvjyYvMINxykklbXe85LgTnhL49XT1F+bmiamvx
 ttwjVePkgwrM=
X-Received: by 2002:a17:906:5a73:b0:c29:4634:5c8f with SMTP id
 a640c23a62f3a-c49bda28beemr269265666b.0.1793196707255; 
 Wed, 28 Oct 2026 07:11:47 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64a02csm611738166b.44.2026.10.28.07.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:11:46 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 29/63] usb: dwc3: import from kernel v5.4
Date: Wed, 28 Oct 2026 15:08:55 +0100
Message-ID: <20261028140930.3025368-30-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v5.3 to v5.4.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v5.3..v5.4
Commits imported:
d8eca64eec71 usb: dwc3: gadget: fix race when disabling ep with cancelled xfers
a7d9874c6f3f usb: dwc3: remove the call trace of USBx_GFLADJ
d819f6584c20 usb: dwc3: Remove dev_err() on platform_get_irq() failure
f146b40ba1f0 usb: dwc3: Switch to platform_get_irq_byname_optional()
a0a465569b45 usb: dwc3: remove generic PHY calibrate() calls
17b63704ec7c usb: dwc3: gadget: Workaround Mirosoft's BESL check
91f255a26bce usb: common: Separated decoding functions from dwc3 driver.
54fb5ba647f8 usb: dwc3: gadget: Set BESL config parameter
16fe4f304015 usb: dwc3: Separate field holding multiple properties
c09b73cfac2a usb: dwc3: don't set gadget->is_otg flag
240b65dc1e89 usb: dwc3: Use clk_bulk_prepare_enable()
03bf32bbb607 usb: dwc3: Use devres to get clocks
4749e0e61241 usb: dwc3: Update soft-reset wait polling rate
a6e5e6794a53 usb: dwc3: Switch to use device_property_count_u32()
41b57327b270 usb: dwc3: Switch to use device_property_count_u32()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  64 +++++-----
 drivers/usb/dwc3/core.h   |   2 +
 drivers/usb/dwc3/debug.h  | 252 --------------------------------------
 drivers/usb/dwc3/gadget.c |  37 ++++--
 4 files changed, 60 insertions(+), 295 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c9bb93a2c81e..97d6ae3c4df2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -168,7 +168,6 @@ static void __dwc3_set_mode(struct work_struct *work)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
 			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
 			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
-			phy_calibrate(dwc->usb2_generic_phy);
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -252,12 +251,25 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	reg |= DWC3_DCTL_CSFTRST;
 	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
+	/*
+	 * For DWC_usb31 controller 1.90a and later, the DCTL.CSFRST bit
+	 * is cleared only after all the clocks are synchronized. This can
+	 * take a little more than 50ms. Set the polling rate at 20ms
+	 * for 10 times instead.
+	 */
+	if (dwc3_is_usb31(dwc) && dwc->revision >= DWC3_USB31_REVISION_190A)
+		retries = 10;
+
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		if (!(reg & DWC3_DCTL_CSFTRST))
 			goto done;
 
-		udelay(1);
+		if (dwc3_is_usb31(dwc) &&
+		    dwc->revision >= DWC3_USB31_REVISION_190A)
+			msleep(20);
+		else
+			udelay(1);
 	} while (--retries);
 
 	phy_exit(dwc->usb3_generic_phy);
@@ -267,11 +279,11 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 
 done:
 	/*
-	 * For DWC_usb31 controller, once DWC3_DCTL_CSFTRST bit is cleared,
-	 * we must wait at least 50ms before accessing the PHY domain
-	 * (synchronization delay). DWC_usb31 programming guide section 1.3.2.
+	 * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST bit
+	 * is cleared, we must wait at least 50ms before accessing the PHY
+	 * domain (synchronization delay).
 	 */
-	if (dwc3_is_usb31(dwc))
+	if (dwc3_is_usb31(dwc) && dwc->revision <= DWC3_USB31_REVISION_180A)
 		msleep(50);
 
 	return 0;
@@ -300,8 +312,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
 	dft = reg & DWC3_GFLADJ_30MHZ_MASK;
-	if (!dev_WARN_ONCE(dwc->dev, dft == dwc->fladj,
-	    "request value same as default, ignoring\n")) {
+	if (dft != dwc->fladj) {
 		reg &= ~DWC3_GFLADJ_30MHZ_MASK;
 		reg |= DWC3_GFLADJ_30MHZ_SDBND_SEL | dwc->fladj;
 		dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
@@ -686,8 +697,7 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	phy_power_off(dwc->usb2_generic_phy);
 	phy_power_off(dwc->usb3_generic_phy);
-	clk_bulk_disable(dwc->num_clks, dwc->clks);
-	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
 	reset_control_assert(dwc->reset);
 }
 
@@ -813,8 +823,7 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 	 * result = 1, means INCRx burst mode supported.
 	 * result > 1, means undefined length burst mode supported.
 	 */
-	ntype = device_property_read_u32_array(dev,
-			"snps,incr-burst-type-adjustment", NULL, 0);
+	ntype = device_property_count_u32(dev, "snps,incr-burst-type-adjustment");
 	if (ntype <= 0)
 		return;
 
@@ -1166,7 +1175,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 				dev_err(dev, "failed to initialize host\n");
 			return ret;
 		}
-		phy_calibrate(dwc->usb2_generic_phy);
 		break;
 	case USB_DR_MODE_OTG:
 		INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
@@ -1310,8 +1318,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
-	dwc->hird_threshold = hird_threshold
-		| (dwc->is_utmi_l1_suspend << 4);
+	dwc->hird_threshold = hird_threshold;
 
 	dwc->rx_thr_num_pkt_prd = rx_thr_num_pkt_prd;
 	dwc->rx_max_burst_prd = rx_max_burst_prd;
@@ -1436,7 +1443,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (dev->of_node) {
 		dwc->num_clks = ARRAY_SIZE(dwc3_core_clks);
 
-		ret = clk_bulk_get(dev, dwc->num_clks, dwc->clks);
+		ret = devm_clk_bulk_get(dev, dwc->num_clks, dwc->clks);
 		if (ret == -EPROBE_DEFER)
 			return ret;
 		/*
@@ -1449,16 +1456,12 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
-		goto put_clks;
+		return ret;
 
-	ret = clk_bulk_prepare(dwc->num_clks, dwc->clks);
+	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
 	if (ret)
 		goto assert_reset;
 
-	ret = clk_bulk_enable(dwc->num_clks, dwc->clks);
-	if (ret)
-		goto unprepare_clks;
-
 	if (!dwc3_core_is_valid(dwc)) {
 		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
 		ret = -ENODEV;
@@ -1531,13 +1534,9 @@ err1:
 	pm_runtime_disable(&pdev->dev);
 
 disable_clks:
-	clk_bulk_disable(dwc->num_clks, dwc->clks);
-unprepare_clks:
-	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
 assert_reset:
 	reset_control_assert(dwc->reset);
-put_clks:
-	clk_bulk_put(dwc->num_clks, dwc->clks);
 
 	return ret;
 }
@@ -1560,7 +1559,6 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	dwc3_free_event_buffers(dwc);
 	dwc3_free_scratch_buffers(dwc);
-	clk_bulk_put(dwc->num_clks, dwc->clks);
 
 	return 0;
 }
@@ -1574,14 +1572,10 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare(dwc->num_clks, dwc->clks);
+	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
 	if (ret)
 		goto assert_reset;
 
-	ret = clk_bulk_enable(dwc->num_clks, dwc->clks);
-	if (ret)
-		goto unprepare_clks;
-
 	ret = dwc3_core_init(dwc);
 	if (ret)
 		goto disable_clks;
@@ -1589,9 +1583,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	return 0;
 
 disable_clks:
-	clk_bulk_disable(dwc->num_clks, dwc->clks);
-unprepare_clks:
-	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
 assert_reset:
 	reset_control_assert(dwc->reset);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3dd783b889cb..1c8b349379af 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1137,6 +1137,8 @@ struct dwc3 {
 #define DWC3_USB31_REVISION_120A	(0x3132302a | DWC3_REVISION_IS_DWC31)
 #define DWC3_USB31_REVISION_160A	(0x3136302a | DWC3_REVISION_IS_DWC31)
 #define DWC3_USB31_REVISION_170A	(0x3137302a | DWC3_REVISION_IS_DWC31)
+#define DWC3_USB31_REVISION_180A	(0x3138302a | DWC3_REVISION_IS_DWC31)
+#define DWC3_USB31_REVISION_190A	(0x3139302a | DWC3_REVISION_IS_DWC31)
 
 	u32			version_type;
 
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 068259fdfb0c..9baabed87d61 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -246,258 +246,6 @@ static inline const char *dwc3_gadget_event_string(char *str, size_t size,
 	return str;
 }
 
-static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char *str,
-		size_t size)
-{
-	switch (t & USB_RECIP_MASK) {
-	case USB_RECIP_DEVICE:
-		snprintf(str, size, "Get Device Status(Length = %d)", l);
-		break;
-	case USB_RECIP_INTERFACE:
-		snprintf(str, size, "Get Interface Status(Intf = %d, Length = %d)",
-				i, l);
-		break;
-	case USB_RECIP_ENDPOINT:
-		snprintf(str, size, "Get Endpoint Status(ep%d%s)",
-			i & ~USB_DIR_IN,
-			i & USB_DIR_IN ? "in" : "out");
-		break;
-	}
-}
-
-static inline void dwc3_decode_set_clear_feature(__u8 t, __u8 b, __u16 v,
-		__u16 i, char *str, size_t size)
-{
-	switch (t & USB_RECIP_MASK) {
-	case USB_RECIP_DEVICE:
-		snprintf(str, size, "%s Device Feature(%s%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			({char *s;
-				switch (v) {
-				case USB_DEVICE_SELF_POWERED:
-					s = "Self Powered";
-					break;
-				case USB_DEVICE_REMOTE_WAKEUP:
-					s = "Remote Wakeup";
-					break;
-				case USB_DEVICE_TEST_MODE:
-					s = "Test Mode";
-					break;
-				case USB_DEVICE_U1_ENABLE:
-					s = "U1 Enable";
-					break;
-				case USB_DEVICE_U2_ENABLE:
-					s = "U2 Enable";
-					break;
-				case USB_DEVICE_LTM_ENABLE:
-					s = "LTM Enable";
-					break;
-				default:
-					s = "UNKNOWN";
-				} s; }),
-			v == USB_DEVICE_TEST_MODE ?
-			({ char *s;
-				switch (i) {
-				case TEST_J:
-					s = ": TEST_J";
-					break;
-				case TEST_K:
-					s = ": TEST_K";
-					break;
-				case TEST_SE0_NAK:
-					s = ": TEST_SE0_NAK";
-					break;
-				case TEST_PACKET:
-					s = ": TEST_PACKET";
-					break;
-				case TEST_FORCE_EN:
-					s = ": TEST_FORCE_EN";
-					break;
-				default:
-					s = ": UNKNOWN";
-				} s; }) : "");
-		break;
-	case USB_RECIP_INTERFACE:
-		snprintf(str, size, "%s Interface Feature(%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			v == USB_INTRF_FUNC_SUSPEND ?
-			"Function Suspend" : "UNKNOWN");
-		break;
-	case USB_RECIP_ENDPOINT:
-		snprintf(str, size, "%s Endpoint Feature(%s ep%d%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			v == USB_ENDPOINT_HALT ? "Halt" : "UNKNOWN",
-			i & ~USB_DIR_IN,
-			i & USB_DIR_IN ? "in" : "out");
-		break;
-	}
-}
-
-static inline void dwc3_decode_set_address(__u16 v, char *str, size_t size)
-{
-	snprintf(str, size, "Set Address(Addr = %02x)", v);
-}
-
-static inline void dwc3_decode_get_set_descriptor(__u8 t, __u8 b, __u16 v,
-		__u16 i, __u16 l, char *str, size_t size)
-{
-	snprintf(str, size, "%s %s Descriptor(Index = %d, Length = %d)",
-		b == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
-		({ char *s;
-			switch (v >> 8) {
-			case USB_DT_DEVICE:
-				s = "Device";
-				break;
-			case USB_DT_CONFIG:
-				s = "Configuration";
-				break;
-			case USB_DT_STRING:
-				s = "String";
-				break;
-			case USB_DT_INTERFACE:
-				s = "Interface";
-				break;
-			case USB_DT_ENDPOINT:
-				s = "Endpoint";
-				break;
-			case USB_DT_DEVICE_QUALIFIER:
-				s = "Device Qualifier";
-				break;
-			case USB_DT_OTHER_SPEED_CONFIG:
-				s = "Other Speed Config";
-				break;
-			case USB_DT_INTERFACE_POWER:
-				s = "Interface Power";
-				break;
-			case USB_DT_OTG:
-				s = "OTG";
-				break;
-			case USB_DT_DEBUG:
-				s = "Debug";
-				break;
-			case USB_DT_INTERFACE_ASSOCIATION:
-				s = "Interface Association";
-				break;
-			case USB_DT_BOS:
-				s = "BOS";
-				break;
-			case USB_DT_DEVICE_CAPABILITY:
-				s = "Device Capability";
-				break;
-			case USB_DT_PIPE_USAGE:
-				s = "Pipe Usage";
-				break;
-			case USB_DT_SS_ENDPOINT_COMP:
-				s = "SS Endpoint Companion";
-				break;
-			case USB_DT_SSP_ISOC_ENDPOINT_COMP:
-				s = "SSP Isochronous Endpoint Companion";
-				break;
-			default:
-				s = "UNKNOWN";
-				break;
-			} s; }), v & 0xff, l);
-}
-
-
-static inline void dwc3_decode_get_configuration(__u16 l, char *str,
-		size_t size)
-{
-	snprintf(str, size, "Get Configuration(Length = %d)", l);
-}
-
-static inline void dwc3_decode_set_configuration(__u8 v, char *str, size_t size)
-{
-	snprintf(str, size, "Set Configuration(Config = %d)", v);
-}
-
-static inline void dwc3_decode_get_intf(__u16 i, __u16 l, char *str,
-		size_t size)
-{
-	snprintf(str, size, "Get Interface(Intf = %d, Length = %d)", i, l);
-}
-
-static inline void dwc3_decode_set_intf(__u8 v, __u16 i, char *str, size_t size)
-{
-	snprintf(str, size, "Set Interface(Intf = %d, Alt.Setting = %d)", i, v);
-}
-
-static inline void dwc3_decode_synch_frame(__u16 i, __u16 l, char *str,
-		size_t size)
-{
-	snprintf(str, size, "Synch Frame(Endpoint = %d, Length = %d)", i, l);
-}
-
-static inline void dwc3_decode_set_sel(__u16 l, char *str, size_t size)
-{
-	snprintf(str, size, "Set SEL(Length = %d)", l);
-}
-
-static inline void dwc3_decode_set_isoch_delay(__u8 v, char *str, size_t size)
-{
-	snprintf(str, size, "Set Isochronous Delay(Delay = %d ns)", v);
-}
-
-/**
- * dwc3_decode_ctrl - returns a string represetion of ctrl request
- */
-static inline const char *dwc3_decode_ctrl(char *str, size_t size,
-		__u8 bRequestType, __u8 bRequest, __u16 wValue, __u16 wIndex,
-		__u16 wLength)
-{
-	switch (bRequest) {
-	case USB_REQ_GET_STATUS:
-		dwc3_decode_get_status(bRequestType, wIndex, wLength, str,
-				size);
-		break;
-	case USB_REQ_CLEAR_FEATURE:
-	case USB_REQ_SET_FEATURE:
-		dwc3_decode_set_clear_feature(bRequestType, bRequest, wValue,
-				wIndex, str, size);
-		break;
-	case USB_REQ_SET_ADDRESS:
-		dwc3_decode_set_address(wValue, str, size);
-		break;
-	case USB_REQ_GET_DESCRIPTOR:
-	case USB_REQ_SET_DESCRIPTOR:
-		dwc3_decode_get_set_descriptor(bRequestType, bRequest, wValue,
-				wIndex, wLength, str, size);
-		break;
-	case USB_REQ_GET_CONFIGURATION:
-		dwc3_decode_get_configuration(wLength, str, size);
-		break;
-	case USB_REQ_SET_CONFIGURATION:
-		dwc3_decode_set_configuration(wValue, str, size);
-		break;
-	case USB_REQ_GET_INTERFACE:
-		dwc3_decode_get_intf(wIndex, wLength, str, size);
-		break;
-	case USB_REQ_SET_INTERFACE:
-		dwc3_decode_set_intf(wValue, wIndex, str, size);
-		break;
-	case USB_REQ_SYNCH_FRAME:
-		dwc3_decode_synch_frame(wIndex, wLength, str, size);
-		break;
-	case USB_REQ_SET_SEL:
-		dwc3_decode_set_sel(wLength, str, size);
-		break;
-	case USB_REQ_SET_ISOCH_DELAY:
-		dwc3_decode_set_isoch_delay(wValue, str, size);
-		break;
-	default:
-		snprintf(str, size, "%02x %02x %02x %02x %02x %02x %02x %02x",
-			bRequestType, bRequest,
-			cpu_to_le16(wValue) & 0xff,
-			cpu_to_le16(wValue) >> 8,
-			cpu_to_le16(wIndex) & 0xff,
-			cpu_to_le16(wIndex) >> 8,
-			cpu_to_le16(wLength) & 0xff,
-			cpu_to_le16(wLength) >> 8);
-	}
-
-	return str;
-}
-
 /**
  * dwc3_ep_event_string - returns event name
  * @event: then event code
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 173f5329d3d9..a9aba716bf80 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -707,6 +707,12 @@ static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
 
 		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
 	}
+
+	while (!list_empty(&dep->cancelled_list)) {
+		req = next_request(&dep->cancelled_list);
+
+		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+	}
 }
 
 /**
@@ -2078,6 +2084,26 @@ static void dwc3_gadget_config_params(struct usb_gadget *g,
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
 
+	params->besl_baseline = USB_DEFAULT_BESL_UNSPECIFIED;
+	params->besl_deep = USB_DEFAULT_BESL_UNSPECIFIED;
+
+	/* Recommended BESL */
+	if (!dwc->dis_enblslpm_quirk) {
+		/*
+		 * If the recommended BESL baseline is 0 or if the BESL deep is
+		 * less than 2, Microsoft's Windows 10 host usb stack will issue
+		 * a usb reset immediately after it receives the extended BOS
+		 * descriptor and the enumeration will fail. To maintain
+		 * compatibility with the Windows' usb stack, let's set the
+		 * recommended BESL baseline to 1 and clamp the BESL deep to be
+		 * within 2 to 15.
+		 */
+		params->besl_baseline = 1;
+		if (dwc->is_utmi_l1_suspend)
+			params->besl_deep =
+				clamp_t(u8, dwc->hird_threshold, 2, 15);
+	}
+
 	/* U1 Device exit Latency */
 	if (dwc->dis_u1_entry_quirk)
 		params->bU1devExitLat = 0;
@@ -2868,7 +2894,8 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		reg &= ~(DWC3_DCTL_HIRD_THRES_MASK | DWC3_DCTL_L1_HIBER_EN);
 
-		reg |= DWC3_DCTL_HIRD_THRES(dwc->hird_threshold);
+		reg |= DWC3_DCTL_HIRD_THRES(dwc->hird_threshold |
+					    (dwc->is_utmi_l1_suspend << 4));
 
 		/*
 		 * When dwc3 revisions >= 2.40a, LPM Erratum is enabled and
@@ -3243,14 +3270,14 @@ static int dwc3_gadget_get_irq(struct dwc3 *dwc)
 	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
 	int irq;
 
-	irq = platform_get_irq_byname(dwc3_pdev, "peripheral");
+	irq = platform_get_irq_byname_optional(dwc3_pdev, "peripheral");
 	if (irq > 0)
 		goto out;
 
 	if (irq == -EPROBE_DEFER)
 		goto out;
 
-	irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+	irq = platform_get_irq_byname_optional(dwc3_pdev, "dwc_usb3");
 	if (irq > 0)
 		goto out;
 
@@ -3261,9 +3288,6 @@ static int dwc3_gadget_get_irq(struct dwc3 *dwc)
 	if (irq > 0)
 		goto out;
 
-	if (irq != -EPROBE_DEFER)
-		dev_err(dwc->dev, "missing peripheral IRQ\n");
-
 	if (!irq)
 		irq = -EINVAL;
 
@@ -3318,7 +3342,6 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dwc->gadget.speed		= USB_SPEED_UNKNOWN;
 	dwc->gadget.sg_supported	= true;
 	dwc->gadget.name		= "dwc3-gadget";
-	dwc->gadget.is_otg		= dwc->dr_mode == USB_DR_MODE_OTG;
 	dwc->gadget.lpm_capable		= true;
 
 	/*
-- 
2.53.0

