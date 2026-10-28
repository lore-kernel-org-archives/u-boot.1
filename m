Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBCB606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TiushjU/;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Mmd39KIm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55CC8407EC;
	Wed, 28 Oct 2026 14:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NP8Vo2cGEo8t; Wed, 28 Oct 2026 14:47:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6FA7C40709
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198828;
	b=raIoQ3VGFu6qG3G/FlgqNwiPGeOjUw3n5KdUgyvqxG8R35eObnx7v9oJXchLLO8eqYmd
	 l4lSyNfhyrLVXD/IG/q5jkpEGx2fOJVXyw268B30MCjYlomSxI2i/hb/fG9+PLvv+tMtv
	 +6v/8fmv9CXv1luNcLD7Yl867hnScf8gEZCOhqyZZbLfadMXA0Xxv+5Ti34K+oFiWZa6c
	 ePgTIFGKLUgdEYgl/ctciCpWO6Cb2iw3PCuQrw10B8tRqFp1k0H+efOcVrnoGZbgU7cQh
	 uOqtzDcEv3eFVjQnEIL8LMZmMlfm8Z7kECQpQznsuiFbBeaPvpf7MAmEC2Y5j4DHmfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198828;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=C7WIkum7RWmhPXAKAxXcsYIEQOf9CJ+zvc9G/QdwC5g=;
	b=iO8riTe2QDJQNZC+fHeQh8DHRbLsUC+Nfw56E8MRUB4oKuEOD+I9WTatiP8iKj38jXOT
	 +mp1ac0eCdIxSunVY+fhSzf5IFHmt1CbvVMNsuV9LfNuekpbCt6u/dnVlvwvoeB0kvXxp
	 5DUQnhcpEPjJjRXWpQfcPPrR6n4nacT/iicvMQxLAnQ1hHnUvSHys7gZyp4sxkimBfTQ/
	 zkPwmIpmliKjD6cNnluZ8sPCNkUhG/i8GRaD8zuD6B+P1s/LPyBXAEM4Ch27B60qhzdpv
	 BZyY4ER1cXPlvTroKQCp0sq4MLNekIIkRFgXE701BktozruE57aQXCyDUUsj0wXPN/w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198828;
	bh=C7WIkum7RWmhPXAKAxXcsYIEQOf9CJ+zvc9G/QdwC5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TiushjU/+oELAo2jITWQc5CXP+sZQuojsJdcCp70K+QDGu/TgHkcodydQJ6HFBk7R
	 lhMRRkKuCbxru5B3cSsZe1lANJm/73XbU7Ew02wNiwp2ob3k6tXRVNTd5ZObv8o5PH
	 p7Ml9vPSWtPn8KfoepuUJ0dK2Y+GEQxJWwpbPfzLyMMfSmYJQVcx4BiKTkJhVfYmXs
	 92Tq59jNjTTPa+JCrF97tGtCOY6yYfUN7Je1citBj4LPzNfX093loCDglb6J4mwcxl
	 bQTYO7/quQFuo+XTlgBDO37A+jbo7kkP80CYjKSp+RpD8yKQga1yNzyfRWde5xY8FX
	 lFPPoLNDRiaQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FA7C40709;
	Wed, 28 Oct 2026 14:47:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 55FE44D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 47684605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cpbAROoDMNhX for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:13:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B4FC2605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196794;
 b=YE7b4u12OV/qbJ8j7AstQ31bQ8HGBwlbzFNZ6e3xPnTh4sohow8jBdMcPZRxH6brqbXt
 d1dr6qtILnVssPzVjYpV7PJeG5+iWD+DI4PLyKV12RJRS6BLuLqLSfnH2OQrW906MvCrc
 brsuN7n+urCQoQl0MNA31OIqhw+131aWl7/sfYEg7NCzkoSNR9Qk9wjvmHxp/9TIcri4t
 JkHjBYHrIZu7CmC+aPv1lK5S3WX7N5StL1h/0TaFaLKlDLiWJ7tdQzCzyuyjsUUhfD7kC
 FkFTBrg6me0LlUQ/I5ND6bJFft+c8V19t9TtMYNuNv0ijSKmuwRA+ZBe9ovg28iWWgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196794;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=C7WIkum7RWmhPXAKAxXcsYIEQOf9CJ+zvc9G/QdwC5g=;
 b=KToGc4vDm829NwCanxcBDhLrd4CtWZPHr6MEcfMNrETl6yftCXT8w23VZKRlv8NWrzSc
 LnAdMZ8BIStAkewLX07f/K7a90kpkQJ+z57vF0/hfjyIuP03h7nBoStrqjXxwealw4seV
 hbl4tE6T1lKC2pUnVn8x0YAxI8V+1Vc97Yra9Z6k+mPgx/4MOyP8BiF2ldiU1OInKhEGA
 GOozPBRVUo9IlIMVjT6MAdCjYTjXgGAH9na+NNo3pI7OXnHLiAqSWpbcAKPYmD4jWjMYF
 pgrKD5dxk75Fyu6NYKtu4eSmHUTnMsjh91KvNUbp8HVWVWNWl+iJunqrW8/yRPcc1lw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Mmd39KIm; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Mmd39KIm
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B4FC2605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:13 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c499b5be0f1so11807266b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196791; x=1793801591;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C7WIkum7RWmhPXAKAxXcsYIEQOf9CJ+zvc9G/QdwC5g=;
 b=Mmd39KIm4nwUGl4Dohl4uAfqHugedanit6E5uE1mqbLK+3v3Y5f+IjiN5Ii/Q9TF/H
 ARK/ORbAN6+RxFj1Iuc9AivJjtblHkCsYlEF0k8zN2p7ijBJgGW/8nw0Z3PvTM65q55E
 Y9GGwkWtQFyLuAISehz8cSDLfNEAfYMzkCNaFnPlI6xH4+Q6quU0CtcYukO5lv1fddZQ
 vIktxs8Q4syY+XWP0xHtq+0WLzlEH/bK7U20ilMkmQNLpr58qS3buKFmz6s7F1YToaKV
 gf1c1q/FHABRxxXMOP9x/ceel0MBGzw7WL85sIUmGiM0048olxgNnJyjQue2o4ncotLZ
 gw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196791; x=1793801591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C7WIkum7RWmhPXAKAxXcsYIEQOf9CJ+zvc9G/QdwC5g=;
 b=pzE2ioX1aJXf46/sSm50sbIPhjpKDR2KFueovpVRpLd53nyvz/rhYmOGZ6fxcIFjsG
 EivzMlAicBGO2d2Aswxa0T8fH5iMPyERruE23vuTptNh4nRlr3kSOx6nx+G8L0+9zTkJ
 0SQtxl7qqcZ7ByXDDKTwkcUZXn+FIA0HIhkyQ5bbHvjTuZOVQ+pFkL4brN6x4mhrGw4O
 amW3ThHVwcreVONAvMape/slcZo5sQvGwFQDTLHHjU5bCWnql6z2VVNIl8jc4f1d0+9a
 TAMKTaApD7CYyjWS8EnfvjMV1dAEHA0+8ruxarRcocozaBoTXml5oXwRhWZmNgyiLGUe
 k2eA==
X-Gm-Message-State: AFq9FYLHFiRBoKF/FyduWEAizFdtXBjaK7UU88luUNAf8S4BygRn6CR6
 syUF9hHtQagU30q9G2sS9o19WZQEPRJpMPkc/78e7smvFhlqvAdFugdqxswWEMPjeywq1QuyZyf
 rZBGT
X-Gm-Gg: AYBFou3sOIvX4lxp9pc39jB3dktVzVQ1nWTQ4y6ul5Y6GVsv/E8ngohReLlnFQtET5A
 qUJlT6KyfyO9nF5jWwIaKPPEECXrTm85hS6fD7lE9L0p9ET+6SPxpWprxKlan/1t4Y4W7S8jMAq
 ZbeOiHkIMbWAdjhhWnismaZ5/fr0Brpti4at4QKutK5MvYQIgdE4ffPaxrk5/oHYPW45MKiTM5w
 mWyex5rzs/89Nyl73VIPcFDOQ7+BMIpGMIgnUX3WApV3CxfyaiNRDKRy1Af8vr4j4gV5OPXOEdl
 l8Wkct08uPkXMqf9zt3SNv1HdfQLZnItRuMDG1zydb4Z4kxKv4U3Fc5Y4kczzQRpzW9o5yxanep
 5SY4UtoEALf/05/Ta8/32AHnYNSEAsE3ZXhSmPza3dehDa4uHa0r7FZJvk9bxQtv+y7YuwELPC2
 S9ACQT7iBE5Yl2t+3MmXy6Kh+tanCD4Zt0HiS4rWg0C0tPCQ7DoqPfSYaRNLAGBB7swH3FtaHoY
 ykoS2/S2nIoGfY2QYzVamQmRrgMKQyRV4JLMigEV6MiHLu0or3YD2ITA96rg/9NYZyAGhDLppkA
 VJGHLUxYmjNfzfaIZzVlM4rDX0OpfSeJ1J+/YId9+RsWwhrGDA01oeCiijIcMTIwCGYHIEQGmHm
 K0H5abFW7SjYTf9NdbpwJX7xAdEyGUYQ=
X-Received: by 2002:a17:906:fd0:b0:c40:b180:db3b with SMTP id
 a640c23a62f3a-c49bdf8d67fmr245778066b.3.1793196791288; 
 Wed, 28 Oct 2026 07:13:11 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd350c61sm612006966b.11.2026.10.28.07.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:13:10 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 40/63] usb: dwc3: import from kernel v5.15
Date: Wed, 28 Oct 2026 15:09:06 +0100
Message-ID: <20261028140930.3025368-41-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v5.14 to v5.15.

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

List of commits: git log --oneline v5.14..v5.15
Commits imported:
268bbde716e3 usb: dwc3: gadget: Revert "set gadgets parent to the right controller"
8cfac9a6744f usb: dwc3: core: balance phy init and exit
843714bb37d9 usb: dwc3: Decouple USB 2.0 L1 & L2 events
c6e23b89a95d usb: dwc3: gadget: set gadgets parent to the right controller
9f607a309fbe usb: dwc3: Resize TX FIFOs to meet EP bursting requirements

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  54 ++++++---
 drivers/usb/dwc3/core.h   |  21 +++-
 drivers/usb/dwc3/ep0.c    |   2 +
 drivers/usb/dwc3/gadget.c | 232 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ba74ad7f6995..0104a80b185e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -264,19 +264,6 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 {
 	u32		reg;
 	int		retries = 1000;
-	int		ret;
-
-	usb_phy_init(dwc->usb2_phy);
-	usb_phy_init(dwc->usb3_phy);
-	ret = phy_init(dwc->usb2_generic_phy);
-	if (ret < 0)
-		return ret;
-
-	ret = phy_init(dwc->usb3_generic_phy);
-	if (ret < 0) {
-		phy_exit(dwc->usb2_generic_phy);
-		return ret;
-	}
 
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
@@ -310,9 +297,6 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 			udelay(1);
 	} while (--retries);
 
-	phy_exit(dwc->usb3_generic_phy);
-	phy_exit(dwc->usb2_generic_phy);
-
 	return -ETIMEDOUT;
 
 done:
@@ -982,9 +966,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc->phys_ready = true;
 	}
 
+	usb_phy_init(dwc->usb2_phy);
+	usb_phy_init(dwc->usb3_phy);
+	ret = phy_init(dwc->usb2_generic_phy);
+	if (ret < 0)
+		goto err0a;
+
+	ret = phy_init(dwc->usb3_generic_phy);
+	if (ret < 0) {
+		phy_exit(dwc->usb2_generic_phy);
+		goto err0a;
+	}
+
 	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
-		goto err0a;
+		goto err1;
 
 	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
 	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
@@ -1050,6 +1046,15 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (!DWC3_VER_IS_PRIOR(DWC3, 290A))
 			reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
 
+		/*
+		 * Decouple USB 2.0 L1 & L2 events which will allow for
+		 * gadget driver to only receive U3/L2 suspend & wakeup
+		 * events and prevent the more frequent L1 LPM transitions
+		 * from interrupting the driver.
+		 */
+		if (!DWC3_VER_IS_PRIOR(DWC3, 300A))
+			reg |= DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT;
+
 		if (dwc->dis_tx_ipgap_linecheck_quirk)
 			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
 
@@ -1267,6 +1272,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			rx_max_burst_prd;
 	u8			tx_thr_num_pkt_prd;
 	u8			tx_max_burst_prd;
+	u8			tx_fifo_resize_max_num;
 	const char		*usb_psy_name;
 	int			ret;
 
@@ -1282,6 +1288,13 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	 */
 	hird_threshold = 12;
 
+	/*
+	 * default to a TXFIFO size large enough to fit 6 max packets.  This
+	 * allows for systems with larger bus latencies to have some headroom
+	 * for endpoints that have a large bMaxBurst value.
+	 */
+	tx_fifo_resize_max_num = 6;
+
 	dwc->maximum_speed = usb_get_maximum_speed(dev);
 	dwc->max_ssp_rate = usb_get_maximum_ssp_rate(dev);
 	dwc->dr_mode = usb_get_dr_mode(dev);
@@ -1325,6 +1338,11 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				&tx_thr_num_pkt_prd);
 	device_property_read_u8(dev, "snps,tx-max-burst-prd",
 				&tx_max_burst_prd);
+	dwc->do_fifo_resize = device_property_read_bool(dev,
+							"tx-fifo-resize");
+	if (dwc->do_fifo_resize)
+		device_property_read_u8(dev, "tx-fifo-max-num",
+					&tx_fifo_resize_max_num);
 
 	dwc->disable_scramble_quirk = device_property_read_bool(dev,
 				"snps,disable_scramble_quirk");
@@ -1390,6 +1408,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->tx_max_burst_prd = tx_max_burst_prd;
 
 	dwc->imod_interval = 0;
+
+	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
 }
 
 /* check whether the core supports IMOD */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5991766239ba..5612bfdf37da 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -256,9 +256,10 @@
 #define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
 
 /* Global User Control 1 Register */
-#define DWC3_GUCTL1_PARKMODE_DISABLE_SS	BIT(17)
+#define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
-#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
+#define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
+#define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
 
 /* Global Status Register */
 #define DWC3_GSTS_OTG_IP	BIT(10)
@@ -1023,6 +1024,7 @@ struct dwc3_scratchpad_array {
  * @rx_max_burst_prd: max periodic ESS receive burst size
  * @tx_thr_num_pkt_prd: periodic ESS transmit packet count
  * @tx_max_burst_prd: max periodic ESS transmit burst size
+ * @tx_fifo_resize_max_num: max number of fifos allocated during txfifo resize
  * @hsphy_interface: "utmi" or "ulpi"
  * @connected: true when we're connected to a host, false otherwise
  * @delayed_status: true when gadget driver asks for delayed status
@@ -1037,6 +1039,7 @@ struct dwc3_scratchpad_array {
  *	1	- utmi_l1_suspend_n
  * @is_fpga: true when we are using the FPGA board
  * @pending_events: true when we have pending IRQs to be handled
+ * @do_fifo_resize: true when txfifo resizing is enabled for dwc3 endpoints
  * @pullups_connected: true when Run/Stop bit is set
  * @setup_packet_pending: true when there's a Setup Packet in FIFO. Workaround
  * @three_stage_setup: set if we perform a three phase setup
@@ -1079,6 +1082,11 @@ struct dwc3_scratchpad_array {
  * @dis_split_quirk: set to disable split boundary.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
+ * @max_cfg_eps: current max number of IN eps used across all USB configs.
+ * @last_fifo_depth: last fifo depth used to determine next fifo ram start
+ *		     address.
+ * @num_ep_resized: carries the current number endpoints which have had its tx
+ *		    fifo resized.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1233,6 +1241,7 @@ struct dwc3 {
 	u8			rx_max_burst_prd;
 	u8			tx_thr_num_pkt_prd;
 	u8			tx_max_burst_prd;
+	u8			tx_fifo_resize_max_num;
 
 	const char		*hsphy_interface;
 
@@ -1246,6 +1255,7 @@ struct dwc3 {
 	unsigned		is_utmi_l1_suspend:1;
 	unsigned		is_fpga:1;
 	unsigned		pending_events:1;
+	unsigned		do_fifo_resize:1;
 	unsigned		pullups_connected:1;
 	unsigned		setup_packet_pending:1;
 	unsigned		three_stage_setup:1;
@@ -1282,6 +1292,10 @@ struct dwc3 {
 	unsigned		async_callbacks:1;
 
 	u16			imod_interval;
+
+	int			max_cfg_eps;
+	int			last_fifo_depth;
+	int			num_ep_resized;
 };
 
 #define INCRX_BURST_MODE 0
@@ -1513,6 +1527,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		struct dwc3_gadget_ep_cmd_params *params);
 int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 		u32 param);
+void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
@@ -1532,6 +1547,8 @@ static inline int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
 		int cmd, u32 param)
 { return 0; }
+static inline void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
+{ }
 #endif
 
 #if IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 2f9e45eed228..658739410992 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -621,6 +621,8 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 		return -EINVAL;
 
 	case USB_STATE_ADDRESS:
+		dwc3_gadget_clear_tx_fifos(dwc);
+
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
 		/* if the cfg matches and the cfg is non zero */
 		if (cfg && (!ret || (ret == USB_GADGET_DELAYED_STATUS))) {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ccb68fe6202e..4519d06c9ca2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -631,6 +631,187 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 		bool interrupt);
 
+/**
+ * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
+ * @dwc: pointer to the DWC3 context
+ * @nfifos: number of fifos to calculate for
+ *
+ * Calculates the size value based on the equation below:
+ *
+ * DWC3 revision 280A and prior:
+ * fifo_size = mult * (max_packet / mdwidth) + 1;
+ *
+ * DWC3 revision 290A and onwards:
+ * fifo_size = mult * ((max_packet + mdwidth)/mdwidth + 1) + 1
+ *
+ * The max packet size is set to 1024, as the txfifo requirements mainly apply
+ * to super speed USB use cases.  However, it is safe to overestimate the fifo
+ * allocations for other scenarios, i.e. high speed USB.
+ */
+static int dwc3_gadget_calc_tx_fifo_size(struct dwc3 *dwc, int mult)
+{
+	int max_packet = 1024;
+	int fifo_size;
+	int mdwidth;
+
+	mdwidth = dwc3_mdwidth(dwc);
+
+	/* MDWIDTH is represented in bits, we need it in bytes */
+	mdwidth >>= 3;
+
+	if (DWC3_VER_IS_PRIOR(DWC3, 290A))
+		fifo_size = mult * (max_packet / mdwidth) + 1;
+	else
+		fifo_size = mult * ((max_packet + mdwidth) / mdwidth) + 1;
+	return fifo_size;
+}
+
+/**
+ * dwc3_gadget_clear_tx_fifo_size - Clears txfifo allocation
+ * @dwc: pointer to the DWC3 context
+ *
+ * Iterates through all the endpoint registers and clears the previous txfifo
+ * allocations.
+ */
+void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
+{
+	struct dwc3_ep *dep;
+	int fifo_depth;
+	int size;
+	int num;
+
+	if (!dwc->do_fifo_resize)
+		return;
+
+	/* Read ep0IN related TXFIFO size */
+	dep = dwc->eps[1];
+	size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
+	if (DWC3_IP_IS(DWC3))
+		fifo_depth = DWC3_GTXFIFOSIZ_TXFDEP(size);
+	else
+		fifo_depth = DWC31_GTXFIFOSIZ_TXFDEP(size);
+
+	dwc->last_fifo_depth = fifo_depth;
+	/* Clear existing TXFIFO for all IN eps except ep0 */
+	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM);
+	     num += 2) {
+		dep = dwc->eps[num];
+		/* Don't change TXFRAMNUM on usb31 version */
+		size = DWC3_IP_IS(DWC3) ? 0 :
+			dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1)) &
+				   DWC31_GTXFIFOSIZ_TXFRAMNUM;
+
+		dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1), size);
+	}
+	dwc->num_ep_resized = 0;
+}
+
+/*
+ * dwc3_gadget_resize_tx_fifos - reallocate fifo spaces for current use-case
+ * @dwc: pointer to our context structure
+ *
+ * This function will a best effort FIFO allocation in order
+ * to improve FIFO usage and throughput, while still allowing
+ * us to enable as many endpoints as possible.
+ *
+ * Keep in mind that this operation will be highly dependent
+ * on the configured size for RAM1 - which contains TxFifo -,
+ * the amount of endpoints enabled on coreConsultant tool, and
+ * the width of the Master Bus.
+ *
+ * In general, FIFO depths are represented with the following equation:
+ *
+ * fifo_size = mult * ((max_packet + mdwidth)/mdwidth + 1) + 1
+ *
+ * In conjunction with dwc3_gadget_check_config(), this resizing logic will
+ * ensure that all endpoints will have enough internal memory for one max
+ * packet per endpoint.
+ */
+static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
+{
+	struct dwc3 *dwc = dep->dwc;
+	int fifo_0_start;
+	int ram1_depth;
+	int fifo_size;
+	int min_depth;
+	int num_in_ep;
+	int remaining;
+	int num_fifos = 1;
+	int fifo;
+	int tmp;
+
+	if (!dwc->do_fifo_resize)
+		return 0;
+
+	/* resize IN endpoints except ep0 */
+	if (!usb_endpoint_dir_in(dep->endpoint.desc) || dep->number <= 1)
+		return 0;
+
+	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+
+	if ((dep->endpoint.maxburst > 1 &&
+	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
+	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		num_fifos = 3;
+
+	if (dep->endpoint.maxburst > 6 &&
+	    usb_endpoint_xfer_bulk(dep->endpoint.desc) && DWC3_IP_IS(DWC31))
+		num_fifos = dwc->tx_fifo_resize_max_num;
+
+	/* FIFO size for a single buffer */
+	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
+
+	/* Calculate the number of remaining EPs w/o any FIFO */
+	num_in_ep = dwc->max_cfg_eps;
+	num_in_ep -= dwc->num_ep_resized;
+
+	/* Reserve at least one FIFO for the number of IN EPs */
+	min_depth = num_in_ep * (fifo + 1);
+	remaining = ram1_depth - min_depth - dwc->last_fifo_depth;
+	remaining = max_t(int, 0, remaining);
+	/*
+	 * We've already reserved 1 FIFO per EP, so check what we can fit in
+	 * addition to it.  If there is not enough remaining space, allocate
+	 * all the remaining space to the EP.
+	 */
+	fifo_size = (num_fifos - 1) * fifo;
+	if (remaining < fifo_size)
+		fifo_size = remaining;
+
+	fifo_size += fifo;
+	/* Last increment according to the TX FIFO size equation */
+	fifo_size++;
+
+	/* Check if TXFIFOs start at non-zero addr */
+	tmp = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
+	fifo_0_start = DWC3_GTXFIFOSIZ_TXFSTADDR(tmp);
+
+	fifo_size |= (fifo_0_start + (dwc->last_fifo_depth << 16));
+	if (DWC3_IP_IS(DWC3))
+		dwc->last_fifo_depth += DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
+	else
+		dwc->last_fifo_depth += DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
+
+	/* Check fifo size allocation doesn't exceed available RAM size. */
+	if (dwc->last_fifo_depth >= ram1_depth) {
+		dev_err(dwc->dev, "Fifosize(%d) > RAM size(%d) %s depth:%d\n",
+			dwc->last_fifo_depth, ram1_depth,
+			dep->endpoint.name, fifo_size);
+		if (DWC3_IP_IS(DWC3))
+			fifo_size = DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
+		else
+			fifo_size = DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
+
+		dwc->last_fifo_depth -= fifo_size;
+		return -ENOMEM;
+	}
+
+	dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(dep->number >> 1), fifo_size);
+	dwc->num_ep_resized++;
+
+	return 0;
+}
+
 /**
  * __dwc3_gadget_ep_enable - initializes a hw endpoint
  * @dep: endpoint to be initialized
@@ -648,6 +829,10 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	int			ret;
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
+		ret = dwc3_gadget_resize_tx_fifos(dep);
+		if (ret)
+			return ret;
+
 		ret = dwc3_gadget_start_config(dep);
 		if (ret)
 			return ret;
@@ -2508,6 +2693,7 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= NULL;
+	dwc->max_cfg_eps = 0;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	free_irq(dwc->irq_gadget, dwc->ev_buf);
@@ -2595,6 +2781,51 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 	return ret;
 }
 
+/**
+ * dwc3_gadget_check_config - ensure dwc3 can support the USB configuration
+ * @g: pointer to the USB gadget
+ *
+ * Used to record the maximum number of endpoints being used in a USB composite
+ * device. (across all configurations)  This is to be used in the calculation
+ * of the TXFIFO sizes when resizing internal memory for individual endpoints.
+ * It will help ensured that the resizing logic reserves enough space for at
+ * least one max packet.
+ */
+static int dwc3_gadget_check_config(struct usb_gadget *g)
+{
+	struct dwc3 *dwc = gadget_to_dwc(g);
+	struct usb_ep *ep;
+	int fifo_size = 0;
+	int ram1_depth;
+	int ep_num = 0;
+
+	if (!dwc->do_fifo_resize)
+		return 0;
+
+	list_for_each_entry(ep, &g->ep_list, ep_list) {
+		/* Only interested in the IN endpoints */
+		if (ep->claimed && (ep->address & USB_DIR_IN))
+			ep_num++;
+	}
+
+	if (ep_num <= dwc->max_cfg_eps)
+		return 0;
+
+	/* Update the max number of eps in the composition */
+	dwc->max_cfg_eps = ep_num;
+
+	fifo_size = dwc3_gadget_calc_tx_fifo_size(dwc, dwc->max_cfg_eps);
+	/* Based on the equation, increment by one for every ep */
+	fifo_size += dwc->max_cfg_eps;
+
+	/* Check if we can fit a single fifo per endpoint */
+	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+	if (fifo_size > ram1_depth)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
@@ -2616,6 +2847,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.udc_set_ssp_rate	= dwc3_gadget_set_ssp_rate,
 	.get_config_params	= dwc3_gadget_config_params,
 	.vbus_draw		= dwc3_gadget_vbus_draw,
+	.check_config		= dwc3_gadget_check_config,
 	.udc_async_callbacks	= dwc3_gadget_async_callbacks,
 };
 
-- 
2.53.0

