Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B65606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mHGA+rFX;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C3CVuWHP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 322DF811EF;
	Wed, 28 Oct 2026 14:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2GEsHtPpVPKi; Wed, 28 Oct 2026 14:47:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 27EA8810E7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198810;
	b=InjioIsmJ1IgTUgJGMNF+FxfEnd8o51Q4yaCv7NsxKqsRI31sFxCaniJPVu0hjxhI9y/
	 WM8EO0JLzCbs3OIdX7jj2REfAka1GJInN/T5BLevxZiGos1cXxYeVV0n8+L4++1v09Xm1
	 /Fa3adlOIga5cT3uiqP2521AXl1lTx76kQSK2xdzpbsZc6QEOWyND6CWpdJM7D4KKT09K
	 LihS7wFmIkRZIB0UnUODBW3+J2heRWVIWezVWT831DIiI2pL5G4q2uyQ57rh7Rzp/Grp1
	 l+nlSHMzZmUxhglsaj9pLhuugfGW2FRZyYwglDaEL9tIpCFEn8/vF6tVVu/x1KKqp9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7v2eYIl3JLTa/G6t0MgsUSqfAoDRndrznilmwjCJOJo=;
	b=ifVhY29hsBW1um893YoXFbcPfHH8gr7lPT+JB7LusETT8wAro+rewjJr8TkgYxmeytZv
	 g8IBk5NRIcpAlxEn+mblihvgGxWK/hWwpVJoDlx25oR2piPyl7eJgZGrumUMBz45hMx04
	 1rG5X9A0f3evRaP8WtguYHA66Zfzdwov5hogB1VdVfaoFynkqMZFiUKjAP5DUpm2OJQOz
	 petIDjkzU7PfsCe8Mp9CrX1u0Bt+sMoOwzdz4R89q6DIisWGRXypyKTXeF2QZEM8q3OhB
	 JVd3j3a6pwuXBO7UxBwiFGyby6LQ19/zkH/qKaPqrL6HjynbVCiVAMtgPn47WEiwlfQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198810;
	bh=7v2eYIl3JLTa/G6t0MgsUSqfAoDRndrznilmwjCJOJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mHGA+rFXgjdWgVQtYW3HGebbksPbADKUUxJJCN0cMsCJLGMc8og5aXiQMbk9Zf/XP
	 kzvMjdLNVd/OmD0DvZf5aqqzDYzV38bHIdzrBW8OwdJThDy8WPrq139uFKPQlDQb9N
	 uZV/S/E7fKCZkL19YAhRPKgKYCZp5sKvkxEwgb7oMldDLFeCwFbaA16T+08gBePxwM
	 D6ll+NXEpSh60zj1LSsu2aujCgPmelzzK9slUZ1OnQoNfYFPU6xaGZeAvVsTvNfCO1
	 iLxrzEfNFo5SRKKA0MWM5HcLkMAvfgEHLxqxFn0Rfx1yFHNq8gCflZQLKhHDFg5nkq
	 DStmbA0yCs+mQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27EA8810E7;
	Wed, 28 Oct 2026 14:46:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D42E972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EFDD40523
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WoT1kJTlaHR6 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:12:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 590BF404DE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196745;
 b=J+EwjarWjkJA0jJwxUlPEHGdzNqT+5tG+R+F3/1KINR3Zy8L+rVV0CkEykBGlyPKqzVZ
 JC97H8tZt4OPuk0hClkCFQwMCeajT9hzzKT+b1mXKfSTZoSFoQSb6tCo5wcgmXEgU4R18
 CWoIbCfC3g1/rc3PFn2F/Nsg5JkHLiXpdsiVt2RH44tMj4OGDHwYJHEoBWc35r7TH+LrM
 Bh5isuCiaSe+uRBwdGVW0So+zaPtOC++M4BFfzEvrrmsukoY4+tC1wUUW32WCdwMcY+Ch
 X56RlzRWdJ/Len6/YmDIPMVNXTXu4Q9wrIU1W+5/0UUqsd1Sn11E904ru+mIKY8LuWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196745;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=7v2eYIl3JLTa/G6t0MgsUSqfAoDRndrznilmwjCJOJo=;
 b=DbwkbTj/3XRYbP3BN9es0rJfMnFd98Yj4UXJh2GqfRt4mH7+3ASLJIRUNykoB1vbaVTM
 sIYvCK2I6jpiPqqts7tT2vg46prNwsL2/MNUYbO/+NLGrs2olV8gc4uFuWfzCQIWT7ByL
 4qE/bxAzWR8QSJQiYUJkKrmj7YZtZLw0gY6qwItC5r7EFFpsGGuKu4n76dQPWeXklfZJA
 NI3r16GYbTw7plutX/12inW7fikUuDaKaKbd/DqcFRToAgPN0WvkImCQwyVKIiLV6j3Eh
 FEAQSV3JTueFtgmRQaoD/5SFDBkug7LW27nm97LZ/BwICiskqdUQQxw+tXOwt/BjXNw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=C3CVuWHP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=C3CVuWHP
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 590BF404DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:24 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6ae15688f36so194576a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196743; x=1793801543;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7v2eYIl3JLTa/G6t0MgsUSqfAoDRndrznilmwjCJOJo=;
 b=C3CVuWHP4vNmymBnH/FM63Rjp0LJjzjYhKn5VrMLWqvrJXBkQNtlhwyUqzHknYglYW
 gK39+hXuaFQJ7Se49x3shq4Aj5aH1A59RArATin6+39Jx+2CPncV7pBAvBKFLjCagBO0
 hae5Con1Z+rKf4wCI/FWb8Pc0gKTlCgebgnfxVySC8rsWRibFmkEMYsQplrbyts8UEKb
 r25MsSwB1cqy3l6YpMqZnkGcHpFuHkl3RjS04bvrtd2Hq3RKogLhrdxI6GqRxInBaCJG
 T6KOfo6cPN/loDCZ3Ps6HW6RIXiP6NZLnp3Ud4GQgRqakq0q3LLeMO/kcHbrUJg4dvaj
 ep6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196743; x=1793801543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7v2eYIl3JLTa/G6t0MgsUSqfAoDRndrznilmwjCJOJo=;
 b=Brmx5cFgxBknod03NSULdDi2twRVrZdoS0gwOo7wqEN1NXHiV2Hfo+UXIvcORoHYLm
 /ZMfWNcClsBhIj1wucq5vlkQ9eBzsqo5gzrh6I/9WPtyN1hqD4ihU3/yl01A7A1BYPJN
 d76NlNNcxgDSE6CzIBqTtqm3j30AWrlUbhZResKgn/pX3hvLAWskxbWM397z5rsZtwWF
 ToBCR5mDZfpbX24f9B2QknpTmygWv9iz5a38fFO32NU8js9/I8KnKkdFx7vdIXiYSHYd
 G0Heima9QZEYkczXX1AdhjawkSanjAldpDy9BfZ8gFlsXWy3UGSq7d7/J6x4QTP8TPYE
 bpuQ==
X-Gm-Message-State: AFq9FYIK5YgyFn61sTQLnzONjBvceD9+4zrb777B2iE27oeCLWsBdbDR
 WIymE6qxpRdQVYrtllnaRtikH+wG3YYkZlfdSjkmYXVduMd5M6DqkKAtoP5YRluRSJNZ2dCmMIo
 9CUYL
X-Gm-Gg: AYBFou3rzkArvNvqbUHvDaKw5IuqW2VLeNJRezYi+FxivN0ZbDPPbbMuG0VakMdPHAV
 6pBUUytUZmjELJeL7ljIJs8fT+i+tGedOabb2ISD20mXhSvEJ9vpPn10L1kwISykujTUgbOVdBY
 wRw7e2ggkJlfT0z6VHo2h8VFniQFd1sc6X3z4528xn3QVWxKq2sqYEhBeoK5xl2QH3mPVb0gX+T
 AEVAdbZCUB+WKjJTBw5XexU9OhXpXeEVCkq+Jkg65mK0VWqj9ZsB8s8+AIoZPSTVlkFtc72uphE
 p+2I+i5OP5nEIyD9fFbCz3nDQBKU8gBdPGVPSGoPHSu0PRed0xSl8CmU4pl6n4rUBnau5A6OM7N
 Dd1ZzVRAfAKCZ8/AhN+Zs+VthX54eiWR3dRLnWPT2wTGcT/J+Qt1YwYHrJa0aPL4v5Cn38X//xr
 GfJ02MsB1vOiI8UgyUc97v6pc719P1fXpWtD71iZz1uRcyiIobNusAF5+xdaUGpOG8ffwb+tjJ/
 DEbSJys0y3465Df612fNLONwa5Tz6wgzkFUv2CKIRQ6C1IB+Z+4wZ+RHM/HdmaAE0kttHIQAgnM
 rBUV1a2rmWdcI7Th269vWPWsrJwmiHhawlSVGxMkKWuXw/KPzYqScud4iexNSYXXpZzeECTWES+
 QkqnPEFUMzg==
X-Received: by 2002:a17:907:da10:b0:c25:3ec4:9e43 with SMTP id
 a640c23a62f3a-c49bda96afamr288678066b.0.1793196742699; 
 Wed, 28 Oct 2026 07:12:22 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4ea351sm606060666b.28.2026.10.28.07.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:12:22 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 30/63] usb: dwc3: import from kernel v5.5
Date: Wed, 28 Oct 2026 15:08:56 +0100
Message-ID: <20261028140930.3025368-31-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.4 to v5.5.

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

List of commits: git log --oneline v5.4..v5.5
Commits imported:
ea0d762775e2 usb: dwc3: gadget: Fix request complete check
2d7b78f59e02 usb: dwc3: ep0: Clear started flag on completion
d3abda5a98a1 usb: dwc3: gadget: Clear started flag for non-IOC
8c7d4b7b3d43 usb: dwc3: gadget: Fix logical condition
038761ce68c2 usb: dwc3: debug: Remove newline printout
9ba3aca8fe82 usb: dwc3: Disable phy suspend after power-on reset

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 37 +++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/debug.h  |  4 ++--
 drivers/usb/dwc3/ep0.c    |  8 ++++++++
 drivers/usb/dwc3/gadget.c | 12 +++++++++++-
 4 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 97d6ae3c4df2..f561c6c9e8a9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -566,8 +566,11 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
  */
 static int dwc3_phy_setup(struct dwc3 *dwc)
 {
+	unsigned int hw_mode;
 	u32 reg;
 
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
 	/*
@@ -585,6 +588,14 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->revision > DWC3_REVISION_194A)
 		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
 
+	/*
+	 * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be cleared after
+	 * power-on reset, and it can be set after core initialization, which is
+	 * after device soft-reset during initialization.
+	 */
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
+		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
+
 	if (dwc->u2ss_inp3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
 
@@ -668,6 +679,14 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->revision > DWC3_REVISION_194A)
 		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
 
+	/*
+	 * For DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared after
+	 * power-on reset, and it can be set after core initialization, which is
+	 * after device soft-reset during initialization.
+	 */
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
+		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+
 	if (dwc->dis_u2_susphy_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
@@ -902,9 +921,12 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
  */
 static int dwc3_core_init(struct dwc3 *dwc)
 {
+	unsigned int		hw_mode;
 	u32			reg;
 	int			ret;
 
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+
 	/*
 	 * Write Linux Version Code to our GUID register so it's easy to figure
 	 * out which kernel version a bug was found.
@@ -940,6 +962,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err0a;
 
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
+	    dwc->revision > DWC3_REVISION_194A) {
+		if (!dwc->dis_u3_susphy_quirk) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+		}
+
+		if (!dwc->dis_u2_susphy_quirk) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		}
+	}
+
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
 
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 9baabed87d61..e56beb9d1e36 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -112,7 +112,7 @@ dwc3_gadget_link_string(enum dwc3_link_state link_state)
 	case DWC3_LINK_STATE_RESUME:
 		return "Resume";
 	default:
-		return "UNKNOWN link state\n";
+		return "UNKNOWN link state";
 	}
 }
 
@@ -141,7 +141,7 @@ dwc3_gadget_hs_link_string(enum dwc3_link_state link_state)
 	case DWC3_LINK_STATE_RESUME:
 		return "Resume";
 	default:
-		return "UNKNOWN link state\n";
+		return "UNKNOWN link state";
 	}
 }
 
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 3996b9c4ff8d..fd1b100d2927 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1117,6 +1117,9 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 void dwc3_ep0_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
+	struct dwc3_ep	*dep = dwc->eps[event->endpoint_number];
+	u8		cmd;
+
 	switch (event->endpoint_event) {
 	case DWC3_DEPEVT_XFERCOMPLETE:
 		dwc3_ep0_xfer_complete(dwc, event);
@@ -1129,7 +1132,12 @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
 	case DWC3_DEPEVT_XFERINPROGRESS:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 	case DWC3_DEPEVT_STREAMEVT:
+		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
+		cmd = DEPEVT_PARAMETER_CMD(event->parameters);
+
+		if (cmd == DWC3_DEPCMD_ENDTRANSFER)
+			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 		break;
 	}
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a9aba716bf80..154f3f3e8cff 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2467,6 +2467,13 @@ static int dwc3_gadget_ep_reclaim_trb_linear(struct dwc3_ep *dep,
 
 static bool dwc3_gadget_ep_request_completed(struct dwc3_request *req)
 {
+	/*
+	 * For OUT direction, host may send less than the setup
+	 * length. Return true for all OUT requests.
+	 */
+	if (!req->direction)
+		return true;
+
 	return req->request.actual == req->request.length;
 }
 
@@ -2491,7 +2498,7 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 
 	req->request.actual = req->request.length - req->remaining;
 
-	if (!dwc3_gadget_ep_request_completed(req) &&
+	if (!dwc3_gadget_ep_request_completed(req) ||
 			req->num_pending_sgs) {
 		__dwc3_gadget_kick_transfer(dep);
 		goto out;
@@ -2719,6 +2726,9 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
+	if (!interrupt)
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+
 	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A)
 		udelay(100);
 }
-- 
2.53.0

