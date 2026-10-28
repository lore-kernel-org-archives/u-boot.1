Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3E606A320
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0FOSFdX0;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YVweYEb2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE4F680F3E;
	Wed, 28 Oct 2026 14:48:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cd906BS9YAsP; Wed, 28 Oct 2026 14:48:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F08180FFF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198852;
	b=K3fQoeyatwBp5REOZBxdIUwGAmUNQFMll6D/gb4ldOH1rF5Gy0elOX9kf3Lxn8cbsvng
	 hfF4CqIj3eqK1yO6qtwlnhhy3/p+crBNunHsgH9odkG/r8/eG6g8eSB7tOL5mxzPdrCW/
	 bQzhEp6uxIwpQzeCqRMUZPz4T8y4CKnF38lVyLGl7LYXjnzM8lli+WnIBewvA++aPuVqC
	 ByTh6tCAqLb+nsqaIS9xmXj+ZfuDr0GoRzB6f0ys8xn9da6ZlMCnABA04MTXcmhAPzlqo
	 xbpMkNCHs01Z30u4/YzVSa+5bufrJoR3puFUqyeM+AWQzVEHNqnOYdOhsvfxnlYtmVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198852;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SQqA36nH5/VdjNwJpzesc14G2aQhgw3Y4ijKTAamWgo=;
	b=nNmKjOFtdEkKrTtSh+YFxdCwtubeexXEVtGt2mD40DBCwg6EOg52xU5mjpUIOXYFwieo
	 roRCsDfCl3dcgtoN7T1mTRYSDKh0aSpOKhrB+5GqqCjYJnqLes/00LkZsftsARgJZa+Os
	 Mbkcpv19rt2mx6xVY1zz2GYhkEp5jIVuWgWLaMxudp+Ju8+HxiADC3cta5N4ZrfsldDJ+
	 yYFVhD/Tj4Avwf8P4XHqH4GrHcnI+zhqwmuKjpjiIvHxPYZHVYqqJg2JHOG9OtT8vHc1x
	 /+dILWnGc5cu0Pk1t97myJZmNsWsl9C0IjGkVoCajilBvPS+klxQybv78/C1YvEea1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YVweYEb2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198852;
	bh=SQqA36nH5/VdjNwJpzesc14G2aQhgw3Y4ijKTAamWgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0FOSFdX0DIqXAfEmxzGnuCFvo1HgM8e1YxNz9TH2IvwoY57kzMZq/AXgwdo2JEkgI
	 7+bKoX1nuUMweKU73kHmUri8b+8dp3egXSIjaHcs6yd9naTC8oGOe7qVrdtjYY9krs
	 0YeCNxbPi3JrgPN3/e6qSlGJzU4vzAGc2naXamwGmAlUZMyjvk5zTDKWPk3YS4aKi+
	 xYaL5VHOXDJrseEl5SE6ywdQ0hdfs+y8XEJQRKnG5lDN6ERMNDPfmSHAstXHsx9mPj
	 8tFRFpfQTKXvu0IVg650Dsr2PJ0txNN07A14+/PdDBOOxec/n4LE+beHtpgIVBqg/B
	 g9KAl1R7h5FHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F08180FFF;
	Wed, 28 Oct 2026 14:47:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B25D5529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9774280AE3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jZ5rOG7xcJiE for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6B0C780ADE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196845;
 b=idibzTJ6w+D5WnLW7riXZvOATlLY66ky4cCKfY/GPyt+GIyXHa+tVMyTVKxOvWkupzsa
 zeICmOS30d+6RHnHKRZpUj3l8POUKne7D15CmZzqn0nFddJ/B9xwHnkQydxTsRoWkp0vK
 6DoP9r/D31dRGynrk0ZyKUwGmikupUNKuxWEPeKldxalhi3HrYv/xu3yoV58PVZY58iaK
 xMga1AH57AwGAtCRVbX/TMuYWkUkyjDU+uWfu35XVUML2TFFgiCyy4nRROl16Vnr4PPH3
 kUS0Fnzh8F8B1PYEj54N1j3Bcni+fJ0smG0ylZG8LadvqFCt9RuakK9JMBKKAsoWRGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196845;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=SQqA36nH5/VdjNwJpzesc14G2aQhgw3Y4ijKTAamWgo=;
 b=NM8O6zncnY+Cq/ybbFpABt6w/6Xxar2Re2DLbnqfswtHeeR7L7iVyDRJM1CQJjg6tdLq
 8LbSbWLKs0UwK+ZuNR3Xk3eaqB4lpyD7z5+uVIQpkUwadV1vNQYuyVHWl7Wr75L2qCOk2
 bm69kMVCv1BzltqbtaVX7z4yR7KuEZAh8ztrIs4pnco59N/+oRRzBEmw8jB+ddIHeawfk
 ZrP4vTPz1pH2rYSFtRFdXZqv8l3T5OY3ZN6RXdjIaAxn7ii06lvtfAl/QduKTjiyBRR+7
 H286x12UoCkwVZT+jyXGlRf7ZcG0tt6RW/mny0X8HwLwAafd0AybcdE5YRwxYzahiGQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YVweYEb2; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YVweYEb2
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B0C780ADE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:05 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c4015fb0b42so10425366b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196843; x=1793801643;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SQqA36nH5/VdjNwJpzesc14G2aQhgw3Y4ijKTAamWgo=;
 b=YVweYEb2Z++B3a05GMRZopv2/e6KGLpkgs3n+2lJxqbwnPPDHNQBne+4ucVhfC0H4Y
 iAuX3FvABdidVNKNHSkeR9JmqcpJY0cS+Tg0I88KuxiFvKYznFgaW4ddjJ/nHH0r0eKK
 ir1xBCtmS58dwnmkzlz/q94XTL93+5nGOs3P57elpN1GjD+XZ09Fu2x2uVQRwYDm908/
 EumMOhzQsPmiZpbZ/S+95McCz0Sxw4NEvGKHlB+cekjqyNQeyLEbLfXIqCzynh6JpbJv
 Owa5iBIWJhGNRx3xLZEdZx0ZYqVip4SnRG3i8R2wJnUpF5uCRoKckonpa6z6brYtRpWr
 n+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196843; x=1793801643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SQqA36nH5/VdjNwJpzesc14G2aQhgw3Y4ijKTAamWgo=;
 b=FqKS0iNmSlQaU0ZLEzglvRYE/IcnDiSfJE/rsIAKQgyUkPMaerbROhIL5Db4KtM10a
 2/FkSMSALzKeSz6B2rxgUCL+o5f7qMATz4JZhTpW6KmcDNly4sdCOgeDgJlF1iQekrgt
 1TFXPXEWUCNXHRefaePPzwxlAXNmdglUYC3tO49+Fzi1nqcWWZJChZJvyNNMX52IPZC9
 wyNyOfv1IkzIbDSQNpWfMSpQbv9nEakq+o3mkTSjEUMnevTp3dRnqLee49LmYONvRq6s
 FIycandSzH/wPyIUWJBMxJ2OvsrI1DWQtIdTFmYcqu5qczfZPWfDDblE9VyF5Q/TGjZz
 YWjg==
X-Gm-Message-State: AFq9FYJQrF1PhH7dBsGWmZkLZEjiYgUeCbajrLj4vddlrYJaxQvpesum
 SseB4/TtVmflB+Q61QPQQ/PcX/54TtOfT2NFlSrZqT4BDnVRS6TNNF+ao767o5f5M35H5J45+Dp
 Ao/0d
X-Gm-Gg: AYBFou1/cB85qaCoa6is2FPac5ebShYgg2hLALcCk6I3dL50xtwD6FHsBvDHMFRkWhq
 DCqU8gFTV1oEE1qO0YkEhIpdLOhEYCLIAJCYZZsf2FbhVvxd8++oM2ANaljWTeimgfJxX63EUXQ
 6BVhjJwwQVLJWg9P/IIyvalFDp4GA4Yuw/1+6/EN5jFF6skzhAdl/tdQ0KPl9qywQiVCVe9SNO4
 6LxASOazLMlWSqKdWU9P00rkyT5S0VOdIHLU/nGdPLg+jmwC5557LDjQ62RGawx9+4CwiPlTm9F
 9CDGsrHUWeErTpTu2VfLP/7V0xjOwiN36OF6cecM4OJ15+CFdIZUFbB0glPYorT1213C3kwEXpH
 vtx97hWr6urDMI3AVz/jov8mBLp4VTYOk2sk0u1NYKEPUbt7dSdx6atJc92KG1i0D/Zgwuct9sn
 cVmfxWCiovxT95kTXpjnnbgfALuxbb2egfdn7PR5oxbmbCmayhxFss0ztkxOeoEWy9o/y+M43/8
 rrnH1pQBsEpK7Ir9RJmSW+mNvF+lCgqk08ZU4lXDNp/HHdJkcq9gOWelIkO1tY2kuCWYbxoZWWh
 UB6d97pgZNE3OHXFf64HXyALH01vjjqiDuB2qgU2pL7OIh4nlbezZtFobdGoAejATFdnbA9v2Xl
 rDrS75kSVVQ==
X-Received: by 2002:a17:906:b30c:b0:c3f:98d4:dfda with SMTP id
 a640c23a62f3a-c49bde860a4mr226696066b.3.1793196843196; 
 Wed, 28 Oct 2026 07:14:03 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524271sm628414666b.35.2026.10.28.07.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:14:02 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 53/63] usb: dwc3: import from kernel v6.8
Date: Wed, 28 Oct 2026 15:09:19 +0100
Message-ID: <20261028140930.3025368-54-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.7 to v6.8.

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

List of commits: git log --oneline v6.7..v6.8
Commits imported:
b191a18cb5c4 usb: dwc3: gadget: Don't disconnect if not started
7d708c145b26 Revert "usb: dwc3: Support EBC feature of DWC_usb31"
61a348857e86 usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend
3c7af52c7616 usb: dwc3: gadget: Queue PM runtime idle on disconnect event
68c26fe58182 usb: dwc3: set pm runtime active before resume common
398aa9a7e77c usb: dwc3: Support EBC feature of DWC_usb31
91736d0619eb usb: dwc3: core: set force_gen1 bit in USB31 devices if max speed is SS
e9d40b215e38 usb: dwc: ep0: Update request status in dwc3_ep0_stall_restart
730e12fbec53 usb: dwc3: gadget: Handle EP0 request dequeuing properly
afe28cd686ae Revert "usb: dwc3: don't reset device side if dwc3 was configured as host-only"
7059fbebcb00 Revert "usb: dwc3: Soft reset phy on probe for host"

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 60 +++++++++++++--------------------------
 drivers/usb/dwc3/core.h   |  5 ++++
 drivers/usb/dwc3/ep0.c    |  5 +++-
 drivers/usb/dwc3/gadget.c | 30 ++++++++++++++++----
 4 files changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b101dbf8c5dc..3e55838c0001 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -277,48 +277,11 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
 	 * XHCI driver will reset the host block. If dwc3 was configured for
-	 * host-only mode or current role is host, then we can return early.
+	 * host-only mode, then we can return early.
 	 */
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
-	/*
-	 * If the dr_mode is host and the dwc->current_dr_role is not the
-	 * corresponding DWC3_GCTL_PRTCAP_HOST, then the dwc3_core_init_mode
-	 * isn't executed yet. Ensure the phy is ready before the controller
-	 * updates the GCTL.PRTCAPDIR or other settings by soft-resetting
-	 * the phy.
-	 *
-	 * Note: GUSB3PIPECTL[n] and GUSB2PHYCFG[n] are port settings where n
-	 * is port index. If this is a multiport host, then we need to reset
-	 * all active ports.
-	 */
-	if (dwc->dr_mode == USB_DR_MODE_HOST) {
-		u32 usb3_port;
-		u32 usb2_port;
-
-		usb3_port = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-		usb3_port |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
-		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
-
-		usb2_port = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-		usb2_port |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
-
-		/* Small delay for phy reset assertion */
-		usleep_range(1000, 2000);
-
-		usb3_port &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
-		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
-
-		usb2_port &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
-
-		/* Wait for clock synchronization */
-		msleep(50);
-		return 0;
-	}
-
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg |= DWC3_DCTL_CSFTRST;
 	reg &= ~DWC3_DCTL_RUN_STOP;
@@ -1367,6 +1330,18 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_config_threshold(dwc);
 
+	/*
+	 * Modify this for all supported Super Speed ports when
+	 * multiport support is added.
+	 */
+	if (hw_mode != DWC3_GHWPARAMS0_MODE_GADGET &&
+	    (DWC3_IP_IS(DWC31)) &&
+	    dwc->maximum_speed == USB_SPEED_SUPER) {
+		reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
+		reg |= DWC3_LLUCTL_FORCE_GEN1;
+		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
+	}
+
 	return 0;
 
 err_power_off_phy:
@@ -2340,12 +2315,15 @@ static int dwc3_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+
 	ret = dwc3_resume_common(dwc, PMSG_RESUME);
-	if (ret)
+	if (ret) {
+		pm_runtime_set_suspended(dev);
 		return ret;
+	}
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
 	return 0;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index efe6caf4d0e8..e120611a5174 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -172,6 +172,8 @@
 #define DWC3_OEVTEN		0xcc0C
 #define DWC3_OSTS		0xcc10
 
+#define DWC3_LLUCTL		0xd024
+
 /* Bit fields */
 
 /* Global SoC Bus Configuration INCRx Register 0 */
@@ -657,6 +659,9 @@
 #define DWC3_OSTS_VBUSVLD		BIT(1)
 #define DWC3_OSTS_CONIDSTS		BIT(0)
 
+/* Force Gen1 speed on Gen2 link */
+#define DWC3_LLUCTL_FORCE_GEN1		BIT(10)
+
 /* Structures */
 
 struct dwc3_trb;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index b94243237293..6ae8a36f21cf 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -238,7 +238,10 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 		struct dwc3_request	*req;
 
 		req = next_request(&dep->pending_list);
-		dwc3_gadget_giveback(dep, req, -ECONNRESET);
+		if (!dwc->connected)
+			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+		else
+			dwc3_gadget_giveback(dep, req, -ECONNRESET);
 	}
 
 	dwc->eps[0]->trb_enqueue = 0;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 858fe4c299b7..28f49400f3e8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2103,7 +2103,17 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 	list_for_each_entry(r, &dep->pending_list, list) {
 		if (r == req) {
-			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			/*
+			 * Explicitly check for EP0/1 as dequeue for those
+			 * EPs need to be handled differently.  Control EP
+			 * only deals with one USB req, and giveback will
+			 * occur during dwc3_ep0_stall_and_restart().  EP0
+			 * requests are never added to started_list.
+			 */
+			if (dep->number > 1)
+				dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			else
+				dwc3_ep0_reset_state(dwc);
 			goto out;
 		}
 	}
@@ -2640,6 +2650,11 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	int ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (!dwc->pullups_connected) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return 0;
+	}
+
 	dwc->connected = false;
 
 	/*
@@ -3973,6 +3988,13 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
 
 	dwc3_ep0_reset_state(dwc);
+
+	/*
+	 * Request PM idle to address condition where usage count is
+	 * already decremented to zero, but waiting for the disconnect
+	 * interrupt to set dwc->connected to FALSE.
+	 */
+	pm_request_idle(dwc->dev);
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
@@ -4686,15 +4708,13 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	unsigned long flags;
 	int ret;
 
-	if (!dwc->gadget_driver)
-		return 0;
-
 	ret = dwc3_gadget_soft_disconnect(dwc);
 	if (ret)
 		goto err;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc3_disconnect_gadget(dwc);
+	if (dwc->gadget_driver)
+		dwc3_disconnect_gadget(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
-- 
2.53.0

