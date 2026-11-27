Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1A1606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VQmHgFFd;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fEJFFov5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C51EC40ADD;
	Fri, 27 Nov 2026 18:29:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MGKy9SZ1Shtt; Fri, 27 Nov 2026 18:29:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 89E4640D44
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795804165;
	b=a9H9JSGIcoq/qFkmYHmxFVWRLOjWo/2FCUK8Qn7i0oPPSGVnh/AxTtqBjifgYpHrHSAX
	 ByM72c9H+0QeShFylWdSC4d0EDOzyjnBCrlw1fag9aAvJo9a+LKoX0VxH+Xr/QnW+8rny
	 xvugWnUH89v7DD0ztk0gUKZZNO+NEHWfvlgGA2h85iU+kSP+ejh5iNe9fv9a515JiVJB3
	 xbzso5pOJ8pIgsPD7JWTMpcsm/T/3V5VjNB4SfXGL5FGdZRDsk9/RL8MVYDejjfYLU4ZD
	 C8SaGQWd/Ssxk0F3FNgPDBF5tGC11eFOG7d11CtQ6cHnsZihhFkGzifiD1CE//N2lWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795804165;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=u7VwQhLiuwEZiLfM5oOFX+H9fF/SLq7G43SVisd2v1I=;
	b=LKjUttgu9M0JfWjAN9vN9JMNzXjsPk49jy9vIX5ngGhzBq5JUiHjutTI8D0CnXsyTCOg
	 jG2BL4AwJYaUFbAV4QXkA01NPQi/7O9OHZ+Z1+s4ZLpSkeBMiYc3Xmga2lbtUc7/+zrjT
	 tS0AlEjrcrPLlOeZt3P4KKMcDDK4/XqrfAxcue/JbbUNrwHh+5/dY6SRb6w5+I8BPji/3
	 D+GQXYDUDBaZg6Jw6Zh9LcS1qffxY7H0+CH8XtsBEBZA1k8yoNo321ofsvhxQfPxFLgnI
	 nLc5fPuq8o0LWnAYIYANrZaem+zqEG7q7jkjHN2ynonOKWjnBHYjaCwuNlnE4p7zrKw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795804165;
	bh=u7VwQhLiuwEZiLfM5oOFX+H9fF/SLq7G43SVisd2v1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VQmHgFFduMGljqI8nnkjtpXuRZ1TZQl3xffPrRWZNKGQFHFJSFJB3JqVVqTZSUlvp
	 Vcb6XfpLXD89/uM9nMzu3gf4AtKNTlYp1dHwk9rFlgIns6BnG2fCPcgk4BYtiFZY5h
	 yDyFc1xteVaUpq7pU/MA9ScVM2rqGnPJTxX1yOfk6SerLoPNisyNcZp8EzVGlZEhmf
	 NwmvZShvoS6lJt7O5GpFwii6oRl5+G+yNRpZI0FSBFkzSa5sxKf/4H5eXRbZMa4u6Z
	 67E+4PqbyzLtes1/DDRXq+b1rhLoBce+vEorDMnEGwYzLg7wqD82thwx4IHQoH7mM4
	 P0LbI3IA9JXXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89E4640D44;
	Fri, 27 Nov 2026 18:29:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 725A4373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64BE8409D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F4DqmWBvgi32 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:29:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 64D89400BC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=fEJFFov5
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64D89400BC
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:15 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so5825554f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795804153; x=1796408953;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u7VwQhLiuwEZiLfM5oOFX+H9fF/SLq7G43SVisd2v1I=;
 b=fEJFFov5tjMjksGdo1CIHz2oR1RESp2CBgfFQ8f8pWMz1c9AFE1Lon2KZzg1AemcQz
 PcDvDgiKfKXuS++9tyRotGTslp36kB3hxIAPxM97/FDDlKrHnEub7uyfFA2WEjkv/8/p
 sv0ayl91e1p8yJbT3QEUCgMocXzRp4Sp3CUEhi5TETIPPVpiF/K7hiIHlN9WappHK7dm
 dc5lgZR2FDc2MSLPSfFFzYfzeYa1pvOpne/UklYXqLRt1vkqvWkhAanjxq3Yttd95XZT
 mUTfe9lauJ8t1RDCugs0cOn9oh4++9c/8KKqvmSv//s6OqBYgsly/iMSHIcNnGJoYp/f
 ez4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795804153; x=1796408953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u7VwQhLiuwEZiLfM5oOFX+H9fF/SLq7G43SVisd2v1I=;
 b=DH4VSLTPdl8DywEBfmPRupYgT0EUSzJRe6N0f8Bf7QQ8gp7nvJRynaTbpbkSB3fK/e
 6oo5q7ppGC/mMxLMlzzklKO+pK0xKr8dWZnbAcv6Le7eMapge68gzyBDcIBBgIqnj1P6
 lCnVetwYgL2lLuRUd2EUStwuCRJVlKdD0/GQxKNYUJokOrVpWO4kMcUGABhMCh/Vvv/U
 wuYCrtFZ4eVxFo/4lAwCW5u1T6UQwS8JizfGZG4mCz6MmowxSRn0vpUuTdmCRN4rZtoG
 Wm07le/9p7NgVoO5dik8S+SOAD/ScYmF8FSX3rzdHZz/4MCUtt3RBBanJHjssm7z8Qv6
 YbDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErElEHChIUGK1xguxuDW+tEXu3r8flwuxCDfD0aQnnbvLAdAoScRpzwkNBSMDA97NUWV44ZcMBQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8rsoJff5pgvMViS7ttJ5Fss56AjRV+H/LuBb9904MVrKhNxYB/
 Qe4seaR+23Wqc+vCd5PDUOVOGnD4cPmtDOzbdQxPw7fuNoP79NhhSC6U
X-Gm-Gg: AZFdTZdGPn/TYA52tBlyzqUueSdxDpj7ja0+UVMFbYtl2/vjUbQGXAzAk31ba2XhFyN
 qwI1ekcOgR5St/Gl+GvXmArHqPgE+qYXWkAKtSZ8Rki94biSCv/6SfHoShs/ep84rQ2IhkO4Ylb
 /8/soJaxup+z8HU5teBsHXtwG/r4mQfplUdaPwZtH0z27Fs5QqBO0R9lZKPQKdkVMbIW8E4RPFe
 AljCbD7+mwE3ot7exzGb17iNc45YU73BVxrNGCvEMBFlSzsOvq7bxxRjdQNr3B23NZAq3CJUiYr
 QuOJXQgtlDSPFWxeeDPB83VcBP1gdTNBWz4Fj3Z3nclObAghShLRrL8oyiOlUkCHk6kn3TobDOV
 TMUGEbI3OZcPPpZCOUmorCan5N17fWP1em4iwOBJ8N2IaWcK7StNjSIeKxCQeCkWA01IebJb5lK
 Tm0VUBvRFeRDwepoKvtpAI1z3ExTVn5KQEEYGwmZm13kyqe+xqCcHRGSlcZ3bTG84w2mXkKVG97
 fcZ9tT1sA6vOLU1J/qqo/T6ix0T86QbD4a9vK/Y5aJrdVejPeiPhpLnVr066gvX8PTFRTkp4LW0
 OKbVntb5wBslIPgeNmxY0mAXFQGZGGroUtg=
X-Received: by 2002:a05:6000:240c:b0:4bf:2fa1:3c44 with SMTP id
 ffacd0b85a97d-4bf2fa13dd8mr6398154f8f.14.1795804153041; 
 Fri, 27 Nov 2026 10:29:13 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm50584856f8f.8.2026.11.27.10.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:29:12 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: [PATCH 6/8] usb: ehci-vf: drop the port number
Date: Fri, 27 Nov 2026 19:29:03 +0100
Message-ID: <20261127182905.2836449-7-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127182905.2836449-1-mehmet.fide@gmail.com>
References: <20261127182905.2836449-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The port number is left only to pass to board_ehci_hcd_init(), which no
Vybrid board implements. Drop both, along with the switch that took the
number from the clock of the PHY.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/usb/host/ehci-vf.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index fa36e3e2af4..1848690d3c8 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -18,7 +18,6 @@
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/regs-usbphy.h>
 #include <dm/device_compat.h>
-#include <dt-bindings/clock/vf610-clock.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/usb/otg.h>
@@ -45,7 +44,6 @@ struct ehci_vf_priv_data {
 	struct udevice *dev;
 	struct udevice *vbus_supply;
 	struct clk phy_clk;
-	u32 portnr;
 };
 
 static void usb_internal_phy_clock_gate(struct ehci_vf_priv_data *priv)
@@ -93,20 +91,10 @@ static void usb_oc_config(struct ehci_vf_priv_data *priv)
 	setbits_le32(priv->misc_addr, UCTRL_OVER_CUR_DIS);
 }
 
-int __weak board_ehci_hcd_init(int port)
-{
-	return 0;
-}
-
 static int ehci_vf_common_init(struct ehci_vf_priv_data *priv)
 {
 	int ret;
 
-	/* Do board specific initialisation */
-	ret = board_ehci_hcd_init(priv->portnr);
-	if (ret)
-		return ret;
-
 	ret = clk_enable(&priv->phy_clk);
 	if (ret)
 		return ret;
@@ -138,17 +126,6 @@ static int vf_parse_dt_addrs(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	switch (priv->phy_clk.id) {
-	case VF610_CLK_USBPHY0:
-		priv->portnr = 0;
-		break;
-	case VF610_CLK_USBPHY1:
-		priv->portnr = 1;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	addr = ofnode_get_addr(phy.node);
 	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
-- 
2.56.0

