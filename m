Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0C606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wJSa7El8;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=njjbgNVU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 966514075C;
	Wed, 28 Oct 2026 14:47:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LcFQG4mQpRA4; Wed, 28 Oct 2026 14:47:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 69A1140834
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198861;
	b=lmKdtG0UkX1+Ey5NzbK0ItxSmoA5Q6RaFFFpJa7DRf2U2JLxmkOxSbqOyRTCLkZN88Vb
	 y81BXdBt++RaXSl8dVmiTFaNHDguyMHpGi1a6IKxHGULPXT+NuOo/lMLv1YB9GRYlgF+v
	 40dge7VI8s7avD5FmGjQEkhgWecT67BCrKLcoV/2wVQRdrCBHkBA4ln35H6i+V1WzyQ+D
	 lXu1cOquvitcsJdkF66Dul3yV6ySAp4CfehCvP8TN4uPs26PYpwj53eKeu56S+n2bIy/R
	 z5qIQ0gHGFd3iyPDYHLQg+HuutJvqmyZQzBTSNk9pQEfWStfEQPAUUmhXeCE0K/A7oA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=btR6xMHcc0KGn42Pec4OtlseLtYuwOuZ4H6V7/rtq9k=;
	b=XO2L8fOYr9xWk5THYUhqp8E8pGVyqt5sLtW8IIzdgvrW6u70tkouW8231slexItIoXCe
	 g2ZxbxGVm0ug+FPibPY9t3BoUyx9c1GsurHObmq3KKf50EjbPcJMyvJqF7yCyzHjbAGNt
	 Bj+dAcR2b7HxTpP5PnvdbBfpu3gcSp7FN1jtcZoS6axjPqT/hWleUlWBfMaxhgibkyDpP
	 t4E5ePKD4rOmlxOodCYTccZ1Vck6MLKTKA6pFVygOisDZNHKsNNvPn5cI03vS9wbWV+8n
	 cIFlVZe5cItO8miYP3gm7HY46QWfoyggS4PDTxn1qaccuy7YkqDlQnguzq5XcTYiSbQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198861;
	bh=btR6xMHcc0KGn42Pec4OtlseLtYuwOuZ4H6V7/rtq9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wJSa7El8/zwS5yqBgJ0kS0z7jpN2YxvRp/jFeX0etODf99QiZEiRO2/BmFvFrxZtz
	 ihpIeqxoiHj46owZUkZloToShpm765vVs6XoA6poQwQ+t8BAOJ9X8gAHP5IU7xbh4M
	 EEw+mmO6s5Gj3w7bkwwesA4iaMaQcXbFWDv3R7qiFwffhMK/+LuzJvt3i8oamsgcqT
	 mchiwxe2lon5rAJEQRiE+f7Geo38eOYgfZzdabK3HjSOKSjdw2F5QJ7S4VZJwf+Ck7
	 AdSBapxm/MAnZrLKBU/TshdO3LnrA0whqoYNL0/MnOu5NiJCM/bj4k1fRbM5vJEa10
	 AQ1B/B1HQGw5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69A1140834;
	Wed, 28 Oct 2026 14:47:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BED3D356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0992400D6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9JP7xqhCKseM for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 039F04008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196851;
 b=eLSpCqhIed2B8cgwg0pxO+Vl47pOiD8FFwVKWnZv9z2q2UemlOGeZ6/z4YyYGE50MD+K
 TbzHaDHW0mzFRSmfhcJhMQOt2ATeDUe5Q89I91l5nUb+yrIDWZUDgnn/iIckB5dwF9tq9
 NkQMRyalsnSaarsl1NpOV7Zqt+8a7lgBOFfuUZYzMWdbhZKWJu+CrW+mWfs/LYvnfhmlZ
 a762H7CkMokG1xj8q7l5cJF8sHAEr/neJVB1GuXU4SDQLMEYKSjqoKple4XeFb2eLMYpL
 yT3M3Vm8rsq58YvdcEYFQarooss0ki8+qmnARoml0w9GsTa8tD3IP0SDdXvebKxtY8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196851;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=btR6xMHcc0KGn42Pec4OtlseLtYuwOuZ4H6V7/rtq9k=;
 b=U9UXxcMLztcBIWtj4ZNLQ9VvuoFZJrbtb6H3bOiUY1jaMRH+2AYi4aLn6I+g5dY5RI3D
 l18sz10I8Jp7Oob/8jb3u2pla+1Dv5yGxuhXTrVCFG0e0cCPcDSQ5pWeoMIb6hsQuX2Ak
 DaQTZQJvHFxbDzZuOtxFmvDPDdVGzGyc0nY4RP2KvMnn3J4wft0TIGf9YtO/ljnPpb+5R
 PAxGPe4Qiq3UraB/uA8xDPSnkL0zGKNtm/B+gwsEtCfPiX5pBUOCDqj8DonHSRfcy9Y0m
 jpXp0Qiqdrwglx0WR+DBfiFsefz9O1kUq3/k08x2nFVMsmxodJdvSjA6IdOntDs6VJg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=njjbgNVU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=njjbgNVU
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 039F04008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:10 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6acbe0e4090so195514a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196849; x=1793801649;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=btR6xMHcc0KGn42Pec4OtlseLtYuwOuZ4H6V7/rtq9k=;
 b=njjbgNVUmrSnj/OS+QNZiGxGzPOxin34bONjOc4nAlFUIdmR2TBhCq7LA40RFOFMtT
 SWBazMt2k30lRFUbcUPzEgyPGQAmy73QfpOYDiogGbZ5j/MKphWZegihdqnSwt4obUUN
 H8WcYiWbxcol++AoGGbNIn/ABwddha/WsHES9va/Gprin6ZEdGncKFfEN1skHvQCg4db
 Pr6dcnnE1NNGAN1zcpkwT0uhl7BokNCO0ZteOj25EeOiOfI3GKcAXD7seorNa8Ip8Ztx
 3zsBu6bHIe1CH0DxNWbJ3zXPe3wOyevgiCaB9dQ97Yl5ts3FkgKH1GpX0Mf8+4sm0xlt
 Crlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196849; x=1793801649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=btR6xMHcc0KGn42Pec4OtlseLtYuwOuZ4H6V7/rtq9k=;
 b=2CR6/kFUl3EyqFO9EZmIaumFePL2ajf4a3Bv95HEP7OuBk6Voe7nQ9eB3pE8+47fRE
 rfvnsEaM7rUmdcbRSaX2jt6v4hK8Ej3/smohjLx/GVn81HUZyyybc+9Ai4VvwDyvlN1G
 bP2jJTSgZ4K/bnoTZkstPU4yJ9bg7HjiMaRWnZ5Xm+x1H1VepfsTdZ7zGIiYdqnK66ts
 Mz061XXVZNeTcbnXnXJxXU36XZbNnUGGTlTM7VHBoA2xvnTNU5E8POgyg/HLDcZHc38z
 4w3mNWCDrXJ9yFTTVJgtpeka3b8ws4Y3CXg0cr5sB88haATH0YvYfUVVXFCFfxZFFrkk
 5DVA==
X-Gm-Message-State: AFq9FYKRVWMKLI+Le0j4Cum5UMr8J6w1kubTpeXYDuEjbV1mL4m4duIV
 O+8Z+18h7NyUSCB7/NsOTrpXB21DNzU/hoQIuiTjCXEFXNFK2BM1LPD/eSFeRNFmJzoo57+EvCp
 cl9kY
X-Gm-Gg: AYBFou3Cvma+JUkH8+U9JbfpsJmmyjTwwX0zO1Zhi7HpTVdspb4lbCCksUxQ+2/gDGX
 MQ3HwLwbMjDNThkGNyDZz+2PzMeExZVsgNrkUt1tD8KYiStPtSdukYzkPG9c6FU24RMbt9iqToR
 vv5ojO+AtMLY6muI7fYzrFqxLsmWaxMgFpszu8c22s64erskAkfDhu5ZMpKyuo10wZmCV5uYq8C
 isLbbgoMe3Qktg62+09UIcK1tPN/wrgli1j6cYjwc3w9DahZOTHodIIZwmQNyx4TjHV7wMTqHmO
 bbiICPeT3FJpFXG06LSs5Lldc+kmGNgxucqyCSF60TpNt9oGOhoq0wxRdYr7m10pKcaKf3VPQ0W
 Hl7bZCvgy7Ggecj8Gfr/WaBqa147PsJ1u629JlBBpFsVhUZQPJJFrY99NKn3V/rKBpDu5b5g/uA
 xSNx1yhavTs/iV8N50stwvHE+6WWQdsN0VYAnOKPsTtwn12KmhYpn722rqvWf90NUMfWVnWMmFm
 LTbuLd4Wl7WHdGGE0QPNrGR/w+1cuuT9YeVRKqOCcGH6D0OIk3T7dhhRSA+P0PjHoTbxBuoY4yH
 vNMZ6Mf13WTm4CsG+zhJFOE42Zh1Ibe6x9TdSNhvTOef8tG/eGdPBxhr9PMDHZhk21WdKoNpoXl
 4ks0i/CZQCoI=
X-Received: by 2002:a17:906:fd0:b0:c40:b180:db3b with SMTP id
 a640c23a62f3a-c49bdf8d67fmr246174066b.3.1793196848438; 
 Wed, 28 Oct 2026 07:14:08 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524271sm628414666b.35.2026.10.28.07.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:14:08 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 58/63] usb: dwc3: import from kernel v6.13
Date: Wed, 28 Oct 2026 15:09:24 +0100
Message-ID: <20261028140930.3025368-59-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.12 to v6.13.

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

List of commits: git log --oneline v6.12..v6.13
Commits imported:
625e70ccb7bb usb: dwc3-am62: Disable autosuspend during remove
01ea6bf5cb58 usb: dwc3: gadget: fix writing NYET threshold
f5313c8b418c usb: dwc3: gadget: Remove dwc3_request->needs_extra_trb
61440628a4ff usb: dwc3: gadget: Cleanup SG handling
b7fc65f5141c usb: dwc3: gadget: Fix looping of queued SG entries
02a6982b0ccf usb: dwc3: gadget: Fix checking for number of TRBs left
5d2fb074dea2 usb: dwc3: ep0: Don't clear ep0 DWC3_EP_TRANSFER_STARTED
ce25e2a8d82d usb: dwc3: core: Set force_gen1 bit for all applicable SuperSpeed ports
61eb055cd304 usb: dwc3: gadget: Add missing check for single port RAM in TxFIFO resizing logic
6ff78df5b3d0 usb: Use (of|device)_property_present() for non-boolean properties
fad16c823e66 usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
9a0749d61a9a usb: Switch back to struct platform_driver::remove()
57d7a6b93822 usb: dwc3: Correct some typos in comments

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c      |  16 ++--
 drivers/usb/dwc3/core.h      |  15 ++--
 drivers/usb/dwc3/dwc3-am62.c |   3 +-
 drivers/usb/dwc3/ep0.c       |   4 +-
 drivers/usb/dwc3/gadget.c    | 156 +++++++++++++++++++++--------------
 5 files changed, 114 insertions(+), 80 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 98114c2827c0..f219c82e9619 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1409,7 +1409,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	/*
 	 * When configured in HOST mode, after issuing U3/L2 exit controller
-	 * fails to send proper CRC checksum in CRC5 feild. Because of this
+	 * fails to send proper CRC checksum in CRC5 field. Because of this
 	 * behaviour Transaction Error is generated, resulting in reset and
 	 * re-enumeration of usb device attached. All the termsel, xcvrsel,
 	 * opmode becomes 0 during end of resume. Enabling bit 10 of GUCTL1
@@ -1470,9 +1470,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (hw_mode != DWC3_GHWPARAMS0_MODE_GADGET &&
 	    (DWC3_IP_IS(DWC31)) &&
 	    dwc->maximum_speed == USB_SPEED_SUPER) {
-		reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
-		reg |= DWC3_LLUCTL_FORCE_GEN1;
-		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
+		int i;
+
+		for (i = 0; i < dwc->num_usb3_ports; i++) {
+			reg = dwc3_readl(dwc->regs, DWC3_LLUCTL(i));
+			reg |= DWC3_LLUCTL_FORCE_GEN1;
+			dwc3_writel(dwc->regs, DWC3_LLUCTL(i), reg);
+		}
 	}
 
 	return 0;
@@ -1941,7 +1945,7 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	struct extcon_dev *edev = NULL;
 	const char *name;
 
-	if (device_property_read_bool(dev, "extcon"))
+	if (device_property_present(dev, "extcon"))
 		return extcon_get_edev_by_phandle(dev, 0);
 
 	/*
@@ -2651,7 +2655,7 @@ MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
 
 static struct platform_driver dwc3_driver = {
 	.probe		= dwc3_probe,
-	.remove_new	= dwc3_remove,
+	.remove		= dwc3_remove,
 	.driver		= {
 		.name	= "dwc3",
 		.of_match_table	= of_match_ptr(of_dwc3_match),
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index eab81dfdcc35..f11570c8ffd0 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -81,7 +81,7 @@
 #define DWC3_GSNPSREV_MASK	0xffff
 #define DWC3_GSNPS_ID(p)	(((p) & DWC3_GSNPSID_MASK) >> 16)
 
-/* DWC3 registers memory space boundries */
+/* DWC3 registers memory space boundaries */
 #define DWC3_XHCI_REGS_START		0x0
 #define DWC3_XHCI_REGS_END		0x7fff
 #define DWC3_GLOBALS_REGS_START		0xc100
@@ -179,7 +179,7 @@
 #define DWC3_OEVTEN		0xcc0C
 #define DWC3_OSTS		0xcc10
 
-#define DWC3_LLUCTL		0xd024
+#define DWC3_LLUCTL(n)		(0xd024 + ((n) * 0x80))
 
 /* Bit fields */
 
@@ -464,6 +464,7 @@
 #define DWC3_DCTL_TRGTULST_SS_INACT	(DWC3_DCTL_TRGTULST(6))
 
 /* These apply for core versions 1.94a and later */
+#define DWC3_DCTL_NYET_THRES_MASK	(0xf << 20)
 #define DWC3_DCTL_NYET_THRES(n)		(((n) & 0xf) << 20)
 
 #define DWC3_DCTL_KEEP_CONNECT		BIT(19)
@@ -915,6 +916,7 @@ struct dwc3_hwparams {
 #define DWC3_MODE(n)		((n) & 0x7)
 
 /* HWPARAMS1 */
+#define DWC3_SPRAM_TYPE(n)	(((n) >> 23) & 1)
 #define DWC3_NUM_INT(n)		(((n) & (0x3f << 15)) >> 15)
 
 /* HWPARAMS3 */
@@ -925,6 +927,9 @@ struct dwc3_hwparams {
 #define DWC3_NUM_IN_EPS(p)	(((p)->hwparams3 &		\
 			(DWC3_NUM_IN_EPS_MASK)) >> 18)
 
+/* HWPARAMS6 */
+#define DWC3_RAM0_DEPTH(n)	(((n) & (0xffff0000)) >> 16)
+
 /* HWPARAMS7 */
 #define DWC3_RAM1_DEPTH(n)	((n) & 0xffff)
 
@@ -937,18 +942,14 @@ struct dwc3_hwparams {
  * @request: struct usb_request to be transferred
  * @list: a list_head used for request queueing
  * @dep: struct dwc3_ep owning this request
- * @sg: pointer to first incomplete sg
  * @start_sg: pointer to the sg which should be queued next
  * @num_pending_sgs: counter to pending sgs
- * @num_queued_sgs: counter to the number of sgs which already got queued
  * @remaining: amount of data remaining
  * @status: internal dwc3 request status tracking
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
  * @trb_dma: DMA address of @trb
  * @num_trbs: number of TRBs used by this request
- * @needs_extra_trb: true when request needs one extra TRB (either due to ZLP
- *	or unaligned OUT)
  * @direction: IN or OUT direction flag
  * @mapped: true when request has been dma-mapped
  */
@@ -960,7 +961,6 @@ struct dwc3_request {
 	struct scatterlist	*start_sg;
 
 	unsigned int		num_pending_sgs;
-	unsigned int		num_queued_sgs;
 	unsigned int		remaining;
 
 	unsigned int		status;
@@ -978,7 +978,6 @@ struct dwc3_request {
 
 	unsigned int		num_trbs;
 
-	unsigned int		needs_extra_trb:1;
 	unsigned int		direction:1;
 	unsigned int		mapped:1;
 };
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index fad151e78fd6..7d43da5f2897 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -309,6 +309,7 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_set_suspended(dev);
 }
 
@@ -377,7 +378,7 @@ MODULE_DEVICE_TABLE(of, dwc3_ti_of_match);
 
 static struct platform_driver dwc3_ti_driver = {
 	.probe		= dwc3_ti_probe,
-	.remove_new	= dwc3_ti_remove,
+	.remove		= dwc3_ti_remove,
 	.driver		= {
 		.name	= "dwc3-am62",
 		.pm	= DEV_PM_OPS,
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index c9533a99e47c..666ac432f52d 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -145,7 +145,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	 * Unfortunately we have uncovered a limitation wrt the Data Phase.
 	 *
 	 * Section 9.4 says we can wait for the XferNotReady(DATA) event to
-	 * come before issueing Start Transfer command, but if we do, we will
+	 * come before issuing Start Transfer command, but if we do, we will
 	 * miss situations where the host starts another SETUP phase instead of
 	 * the DATA phase.  Such cases happen at least on TD.7.6 of the Link
 	 * Layer Compliance Suite.
@@ -232,7 +232,7 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 	/* stall is always issued on EP0 */
 	dep = dwc->eps[0];
 	__dwc3_gadget_ep_set_halt(dep, 1, false);
-	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED | DWC3_EP_TRANSFER_STARTED;
 	dep->flags |= DWC3_EP_ENABLED;
 	dwc->delayed_status = false;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4959c26d3b71..31a654c6f15b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -197,7 +197,6 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 
 	list_del(&req->list);
 	req->remaining = 0;
-	req->needs_extra_trb = false;
 	req->num_trbs = 0;
 
 	if (req->request.status == -EINPROGRESS)
@@ -687,6 +686,44 @@ static int dwc3_gadget_calc_tx_fifo_size(struct dwc3 *dwc, int mult)
 	return fifo_size;
 }
 
+/**
+ * dwc3_gadget_calc_ram_depth - calculates the ram depth for txfifo
+ * @dwc: pointer to the DWC3 context
+ */
+static int dwc3_gadget_calc_ram_depth(struct dwc3 *dwc)
+{
+	int ram_depth;
+	int fifo_0_start;
+	bool is_single_port_ram;
+
+	/* Check supporting RAM type by HW */
+	is_single_port_ram = DWC3_SPRAM_TYPE(dwc->hwparams.hwparams1);
+
+	/*
+	 * If a single port RAM is utilized, then allocate TxFIFOs from
+	 * RAM0. otherwise, allocate them from RAM1.
+	 */
+	ram_depth = is_single_port_ram ? DWC3_RAM0_DEPTH(dwc->hwparams.hwparams6) :
+			DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+
+	/*
+	 * In a single port RAM configuration, the available RAM is shared
+	 * between the RX and TX FIFOs. This means that the txfifo can begin
+	 * at a non-zero address.
+	 */
+	if (is_single_port_ram) {
+		u32 reg;
+
+		/* Check if TXFIFOs start at non-zero addr */
+		reg = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
+		fifo_0_start = DWC3_GTXFIFOSIZ_TXFSTADDR(reg);
+
+		ram_depth -= (fifo_0_start >> 16);
+	}
+
+	return ram_depth;
+}
+
 /**
  * dwc3_gadget_clear_tx_fifos - Clears txfifo allocation
  * @dwc: pointer to the DWC3 context
@@ -753,7 +790,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
 	int fifo_0_start;
-	int ram1_depth;
+	int ram_depth;
 	int fifo_size;
 	int min_depth;
 	int num_in_ep;
@@ -773,17 +810,32 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 	if (dep->flags & DWC3_EP_TXFIFO_RESIZED)
 		return 0;
 
-	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
 
-	if ((dep->endpoint.maxburst > 1 &&
-	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
-	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		num_fifos = 3;
-
-	if (dep->endpoint.maxburst > 6 &&
-	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
-	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
-		num_fifos = dwc->tx_fifo_resize_max_num;
+	switch (dwc->gadget->speed) {
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:
+		if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
+		    usb_endpoint_xfer_isoc(dep->endpoint.desc))
+			num_fifos = min_t(unsigned int,
+					  dep->endpoint.maxburst,
+					  dwc->tx_fifo_resize_max_num);
+		break;
+	case USB_SPEED_HIGH:
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+			num_fifos = min_t(unsigned int,
+					  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
+					  dwc->tx_fifo_resize_max_num);
+			break;
+		}
+		fallthrough;
+	case USB_SPEED_FULL:
+		if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
+			num_fifos = 2;
+		break;
+	default:
+		break;
+	}
 
 	/* FIFO size for a single buffer */
 	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
@@ -794,7 +846,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 
 	/* Reserve at least one FIFO for the number of IN EPs */
 	min_depth = num_in_ep * (fifo + 1);
-	remaining = ram1_depth - min_depth - dwc->last_fifo_depth;
+	remaining = ram_depth - min_depth - dwc->last_fifo_depth;
 	remaining = max_t(int, 0, remaining);
 	/*
 	 * We've already reserved 1 FIFO per EP, so check what we can fit in
@@ -820,9 +872,9 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 		dwc->last_fifo_depth += DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
 
 	/* Check fifo size allocation doesn't exceed available RAM size. */
-	if (dwc->last_fifo_depth >= ram1_depth) {
+	if (dwc->last_fifo_depth >= ram_depth) {
 		dev_err(dwc->dev, "Fifosize(%d) > RAM size(%d) %s depth:%d\n",
-			dwc->last_fifo_depth, ram1_depth,
+			dwc->last_fifo_depth, ram_depth,
 			dep->endpoint.name, fifo_size);
 		if (DWC3_IP_IS(DWC3))
 			fifo_size = DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
@@ -1177,11 +1229,14 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 	 * pending to be processed by the driver.
 	 */
 	if (dep->trb_enqueue == dep->trb_dequeue) {
+		struct dwc3_request *req;
+
 		/*
-		 * If there is any request remained in the started_list at
-		 * this point, that means there is no TRB available.
+		 * If there is any request remained in the started_list with
+		 * active TRBs at this point, then there is no TRB available.
 		 */
-		if (!list_empty(&dep->started_list))
+		req = next_request(&dep->started_list);
+		if (req && req->num_trbs)
 			return 0;
 
 		return DWC3_TRB_NUM - 1;
@@ -1384,6 +1439,7 @@ static int dwc3_prepare_last_sg(struct dwc3_ep *dep,
 	unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
 	unsigned int rem = req->request.length % maxp;
 	unsigned int num_trbs = 1;
+	bool needs_extra_trb;
 
 	if (dwc3_needs_extra_trb(dep, req))
 		num_trbs++;
@@ -1391,15 +1447,15 @@ static int dwc3_prepare_last_sg(struct dwc3_ep *dep,
 	if (dwc3_calc_trbs_left(dep) < num_trbs)
 		return 0;
 
-	req->needs_extra_trb = num_trbs > 1;
+	needs_extra_trb = num_trbs > 1;
 
 	/* Prepare a normal TRB */
 	if (req->direction || req->request.length)
 		dwc3_prepare_one_trb(dep, req, entry_length,
-				req->needs_extra_trb, node, false, false);
+				needs_extra_trb, node, false, false);
 
 	/* Prepare extra TRBs for ZLP and MPS OUT transfer alignment */
-	if ((!req->direction && !req->request.length) || req->needs_extra_trb)
+	if ((!req->direction && !req->request.length) || needs_extra_trb)
 		dwc3_prepare_one_trb(dep, req,
 				req->direction ? 0 : maxp - rem,
 				false, 1, true, false);
@@ -1414,8 +1470,8 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 	struct scatterlist *s;
 	int		i;
 	unsigned int length = req->request.length;
-	unsigned int remaining = req->request.num_mapped_sgs
-		- req->num_queued_sgs;
+	unsigned int remaining = req->num_pending_sgs;
+	unsigned int num_queued_sgs = req->request.num_mapped_sgs - remaining;
 	unsigned int num_trbs = req->num_trbs;
 	bool needs_extra_trb = dwc3_needs_extra_trb(dep, req);
 
@@ -1423,7 +1479,7 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 	 * If we resume preparing the request, then get the remaining length of
 	 * the request and resume where we left off.
 	 */
-	for_each_sg(req->request.sg, s, req->num_queued_sgs, i)
+	for_each_sg(req->request.sg, s, num_queued_sgs, i)
 		length -= sg_dma_len(s);
 
 	for_each_sg(sg, s, remaining, i) {
@@ -1488,7 +1544,6 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 		if (!last_sg)
 			req->start_sg = sg_next(s);
 
-		req->num_queued_sgs++;
 		req->num_pending_sgs--;
 
 		/*
@@ -1569,9 +1624,7 @@ static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 		if (ret)
 			return ret;
 
-		req->sg			= req->request.sg;
-		req->start_sg		= req->sg;
-		req->num_queued_sgs	= 0;
+		req->start_sg		= req->request.sg;
 		req->num_pending_sgs	= req->request.num_mapped_sgs;
 
 		if (req->num_pending_sgs > 0) {
@@ -3075,7 +3128,7 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
 	struct dwc3 *dwc = gadget_to_dwc(g);
 	struct usb_ep *ep;
 	int fifo_size = 0;
-	int ram1_depth;
+	int ram_depth;
 	int ep_num = 0;
 
 	if (!dwc->do_fifo_resize)
@@ -3098,8 +3151,8 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
 	fifo_size += dwc->max_cfg_eps;
 
 	/* Check if we can fit a single fifo per endpoint */
-	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
-	if (fifo_size > ram1_depth)
+	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
+	if (fifo_size > ram_depth)
 		return -ENOMEM;
 
 	return 0;
@@ -3416,20 +3469,16 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 		int status)
 {
 	struct dwc3_trb *trb;
-	struct scatterlist *sg = req->sg;
-	struct scatterlist *s;
-	unsigned int num_queued = req->num_queued_sgs;
+	unsigned int num_completed_trbs = req->num_trbs;
 	unsigned int i;
 	int ret = 0;
 
-	for_each_sg(sg, s, num_queued, i) {
+	for (i = 0; i < num_completed_trbs; i++) {
 		trb = &dep->trb_pool[dep->trb_dequeue];
 
-		req->sg = sg_next(s);
-		req->num_queued_sgs--;
-
 		ret = dwc3_gadget_ep_reclaim_completed_trb(dep, req,
-				trb, event, status, true);
+				trb, event, status,
+				!!(trb->ctrl & DWC3_TRB_CTRL_CHN));
 		if (ret)
 			break;
 	}
@@ -3437,19 +3486,9 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 	return ret;
 }
 
-static int dwc3_gadget_ep_reclaim_trb_linear(struct dwc3_ep *dep,
-		struct dwc3_request *req, const struct dwc3_event_depevt *event,
-		int status)
-{
-	struct dwc3_trb *trb = &dep->trb_pool[dep->trb_dequeue];
-
-	return dwc3_gadget_ep_reclaim_completed_trb(dep, req, trb,
-			event, status, false);
-}
-
 static bool dwc3_gadget_ep_request_completed(struct dwc3_request *req)
 {
-	return req->num_pending_sgs == 0 && req->num_queued_sgs == 0;
+	return req->num_pending_sgs == 0 && req->num_trbs == 0;
 }
 
 static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
@@ -3459,24 +3498,13 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 	int request_status;
 	int ret;
 
-	if (req->request.num_mapped_sgs)
-		ret = dwc3_gadget_ep_reclaim_trb_sg(dep, req, event,
-				status);
-	else
-		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
-				status);
+	ret = dwc3_gadget_ep_reclaim_trb_sg(dep, req, event, status);
 
 	req->request.actual = req->request.length - req->remaining;
 
 	if (!dwc3_gadget_ep_request_completed(req))
 		goto out;
 
-	if (req->needs_extra_trb) {
-		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
-				status);
-		req->needs_extra_trb = false;
-	}
-
 	/*
 	 * The event status only reflects the status of the TRB with IOC set.
 	 * For the requests that don't set interrupt on completion, the driver
@@ -4167,8 +4195,10 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		WARN_ONCE(DWC3_VER_IS_PRIOR(DWC3, 240A) && dwc->has_lpm_erratum,
 				"LPM Erratum not available on dwc3 revisions < 2.40a\n");
 
-		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A))
+		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A)) {
+			reg &= ~DWC3_DCTL_NYET_THRES_MASK;
 			reg |= DWC3_DCTL_NYET_THRES(dwc->lpm_nyet_threshold);
+		}
 
 		dwc3_gadget_dctl_write_safe(dwc, reg);
 	} else {
-- 
2.53.0

