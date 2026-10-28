Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E8606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NaVinrg4;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E49gHOgI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA9F880BB8;
	Wed, 28 Oct 2026 14:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IkozyLA5Rzjs; Wed, 28 Oct 2026 14:48:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 267CB81190
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198842;
	b=UttyYX5+Nn12YUCgTJ3yDUPSsPrAPsdQ8qmDt8FS62Y+lfTLnLxO8kyB/WXy+Nqg9MBM
	 D2Mggo9cVLbVs7JcD1D+V2Q+eZz4lzSQ80KHdzSWnsy4dOM2YlAu9SGBMidU4B54Leq/Z
	 1hoHyCi5RGIFh96W6QDdndFXef5UJnd3vRBetsJhrh2cHaOTsndgj6ALx2UDJx8TBoSb9
	 HetOYC5PXXvWVZP2PHAs84ElHNgnhfBkrvmkspGLlV11pLgcGhOf1mTWKuP42AqbIGl68
	 uz7BHJRcbZ1xTlf0voWu6NBCxETxCLK1DozPsBHJ58eeNcySoOWGoTSUkETBGDVlq4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198842;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hjGzZRwk+e9uDFzOezj/yY7UxS9EKdSnzJZD2q+3gZ4=;
	b=BE+fo8IIzTxkm3ezohHV9gSdj8xvmuvoZbIx/apxYMCJmLUO7AKCRbOif4xl4Z79p3Ix
	 2GZksHbsHv0k4rIZuNeAtPzHb2AMeaJLkQBVYbhpBSOGcvLmjHw43shcGy18wFCfDTZ3g
	 2r6KdtxfoNKh+3OQ7tMLICEfgNREXGCplJhAsYBtPxsr3GkdYzVqZReSGFe7Ijg946iae
	 D/Ve4rYsGd6UzAdjMifA9FwFcgJsoFftSUSJWzdzY1GAx5dEydn/Y8lKN8Zz1gzUxqEks
	 4POl6cCkr8BupcYyzAoM2CU/L9bLDhp1WpxiySKECDRZ+V4jH6NX1FW+1VPyJ5EqkyA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198842;
	bh=hjGzZRwk+e9uDFzOezj/yY7UxS9EKdSnzJZD2q+3gZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NaVinrg4ZMfaSuX+xDcdTf9Aasy+ibudnyLOwq2+cs/nApr4pAKUCeepFMAJcnYE0
	 lfIPj2aNGQOqRxifMumRY0hpiftqn2B7mko8nQ18QAMLiz3Pez8l66zgfUHq4PkHNR
	 2nBgMChv/T2KKmWcegHSLGan8uiOrsV14udKtALuSoIpkgOMWHLofoiB7u0+ChH0if
	 0rqHkgrjj7RXAU1W6pRmdATTSAwp0m7e1kbDe+fO9USQO+GdWTeGTvnHiipwAqHhph
	 nSq9fNOeTlMvtEVVT0S6dEQg9b8SZ/a5ECCICArQqTTebmZujbXs9V/7L+Jgh8u7ZS
	 tOnDnL0SuVi2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 267CB81190;
	Wed, 28 Oct 2026 14:47:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DF6F4D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EAA9605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EaeOm_pHPS0B for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:13:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 979E1605F1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196800;
 b=MqYC+09xdaFqjtpR409McuT1lY1ng+XZmX1OeH/HMSgBtkYVBo1d9eTyIasHJJbGAQFf
 AtSA+ZSlOSVgiQ4TKemRffbAquiK7G/g5RFNB41q6Q+kYJUgwQtyKZZtCfCaaR9BiIpIk
 +2ttGR+1BuC5vOmSxick3gwPrMUXBtJCixWuCjKYs0p+iPga4ClF1/h4z+hMxB/pBmF5H
 BYCqujQQCLXmBZSjkqDBjc1IS1brTHVAejnciktaR5fhl5nhv8gCFjEgqpiUoVZv0363l
 Fx9oAmYNcFTrLCHcjy5aUa8qVCwYsunyfHJypsHbBOgLzdKZe7C3PAeX+zgdwT/arfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196800;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=hjGzZRwk+e9uDFzOezj/yY7UxS9EKdSnzJZD2q+3gZ4=;
 b=hwAuQ1wqdMugWJofWJcKRoVoiAmRV2u3RLn2T1KMxPEYZNgaUwC4uRpe20BAV3LHiEYY
 PqgP+AaHUuzBwbX6hsZQ4O9qm1+WVSrhKXwhmRwgXbOPhIS2UW2CTHRmLuj5wMEymCc3S
 i0DoXDlyKfbHhlGIfqXUA391kdof1Ek54eTAEqUoq34wkR3eVilQTsKx7HX3yw7injaaT
 CivfAbqcQneqm9KGGVTjIuzmmSS35sk4fcHGM5+UaWDLzVnnP2Hv9z7kJCkcTK6G24V41
 YvGZc/TrMA+Gameqde1GfMrZ7xdW4yzXBu3wGLwTBqLfkwEhCKfCru58Upv6eilntMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=E49gHOgI; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=E49gHOgI
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 979E1605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:18 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6acbaec0d70so183636a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196797; x=1793801597;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hjGzZRwk+e9uDFzOezj/yY7UxS9EKdSnzJZD2q+3gZ4=;
 b=E49gHOgIZFd69jsHeBNFXWyiRyK7mKCPBUlg9tuRkg0wQVvGtdj5xcPs5yri/N1OzP
 egr6qCw5Ld++f0J/Kisy2SAYSMZGnLlSA6y7fPRqnff0YUEZgIaW8gYSnW7f8GwI5QWv
 MVD+60BwPITBV+GKNKvNFti1XbHXDBiQ2q7AfQbUVVSFz6/1tgdQSVyeRk7JdY7UHWmH
 N3LJsJ5RjDAA+1aQda4fdGi7EUtjqQ7IdmghaDxwQwx2zWFK08bGvx8z8P1pAg9dbrOD
 FFhx/N86ZLA+ml/jpWld0QTckDiwrXKmbWz09hcJx6gm7/y6q1hG9SU4RiCpPMHk6JLk
 g6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196797; x=1793801597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hjGzZRwk+e9uDFzOezj/yY7UxS9EKdSnzJZD2q+3gZ4=;
 b=gatjP5fVEYmYWeHAXbd+TdujpDDxuUt2R5xi4rXpYwVr4uNsja21l1ob66M9+3ndeg
 NzMp0vb3Dwj+G+1xpqAY3mMSE63NPr0uvHmCPUivS5RZfL+47weyxCXDtOZ6huVTf1MJ
 lFR2qMUM4AU12r6Atfep+diuEOuVE4bMaUgSZ68GFYB1zXmfUaKrd8Y0ZipScvTIgtHN
 BAbL/N2C1BZLjnYkRwbb5clIcUm9H+aWDivglI1DLioamQtRahSjf+Z8DgTePoUAUL1Z
 WWlauzQtGRaJBd/Wb3Qj5g44fvrcc9KWxAcnSXY6NoIPIMvxLYM+FOlAOlj8RpaWQpI/
 bSnw==
X-Gm-Message-State: AFq9FYICDQG5E3jrWX0w3ZM7QMbKXqr944cRATSSp0ooEQIy7jkrB9+5
 SDVCz6j/L2GsObWOMUJR1ocIEpDE7gPYpf/sptkt6Tmp2KUDnvtCpjynTfbecb8n4F1kGulSc8V
 5jYJJ
X-Gm-Gg: AYBFou1X8P2AFiFMWpJ9BzroKKvPVwsD8cHiH67vtWunSJFXNNDCz3Dxjx6jyd183qJ
 Jed0R1rJqLRl57gqxuuGHFOY0eSqLvjq5qhWs1ILMRzKOaqmJoV4no3ODhXbBJ0tBIupOSPnse3
 hTupBzeZ2+TuDvXiOjg2omDAwHkTfkZO+2LDDlHdhaD4YpKNdyah1eXNVe80cyf3vYMx6iWwpjU
 Q5PzBDapzVAn8wHBBSk0uO2a4l/RXCaV8Y29ILXN0wyu9Urgi942+X8vJAv8xN5ihqo/RcXyrrp
 n7i+YG0mDWqks5VC/wlyuvIwW4jpvMH8lGmIGp4MkZLGqxzsYpCEYCi8YD60W5euFC0BY2w3yHD
 nmSPEWV3HOWSkLdRjJTnBAoHyI0Kt6tNHjAurCv6b+MzwYyq5fhJ7IcMv81KKmdZOLmemNra5cD
 d4+1OSNj5x/n4r2pNqsfjGoqjb2T74vd+P3eyOQ4b+I2CW6nQdY+WoOou3h6MaWWmoLXO15Eguj
 6gsHCqwd4dhVO8YX7bgDqtjXdoJnxkR74LBMJLpE1j9dN7rV7eYZEOXd5mm6B+ayJwDk8JX2w2h
 cK3gtEuUySWWkRAMtf0nX8N/qb2LWaiZD01JpMR0uhV9bhqaordMvvfPIf4gj0iel+iSf97gtHy
 tXyvAURrsjQ==
X-Received: by 2002:a17:906:584:b0:c41:8e21:4d62 with SMTP id
 a640c23a62f3a-c49bdd71afdmr213795766b.1.1793196796866; 
 Wed, 28 Oct 2026 07:13:16 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd350c61sm612006966b.11.2026.10.28.07.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:13:16 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 46/63] usb: dwc3: import from kernel v6.1
Date: Wed, 28 Oct 2026 15:09:12 +0100
Message-ID: <20261028140930.3025368-47-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.0 to v6.1.

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

List of commits: git log --oneline v6.0..v6.1
Commits imported:
f90f5afd5083 usb: dwc3: gadget: Clear ep descriptor last
3aa07f72894d usb: dwc3: gadget: Disable GUSB2PHYCFG.SUSPHY for End Transfer
d68cc25b7c7f usb: dwc3: Do not get extcon device when usb-role-switch is used
ffb9da4a04c6 usb: dwc3: gadget: Return -ESHUTDOWN on ep disable
308c316d16cb usb: dwc3: gadget: Don't set IMI for no_interrupt
f78961f8380b usb: dwc3: gadget: Stop processing more requests on IMI
4db0fbb60136 usb: dwc3: gadget: Don't delay End Transfer on delayed_status
d182c2e1bc92 usb: dwc3: Don't switch OTG -> peripheral if extcon is present
7a84e7353e23 Revert "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"
2adc960ce79d Revert "USB: fixup for merge issue with "usb: dwc3: Don't switch OTG -> peripheral if extcon is present""
2a735e4b5580 usb: dwc3: core: fix some leaks in probe
63d7f9810a38 usb: dwc3: core: Enable GUCTL1 bit 10 for fixing termination error after resume bug
a6fc2f1b0927 usb: dwc3: core: add gfladj_refclk_lpm_sel quirk
76bff31c7fba usb: dwc3: gadget: Do not clear ep delayed stop flag during ep disable
af870d93c706 usb: dwc3: Fix typos in gadget.c
8422b769fa46 usb: dwc3: gadget: Submit endxfer command if delayed during disconnect
b353eb6dc285 usb: dwc3: gadget: Skip waiting for CMDACT cleared during endxfer
461ee467507c usb: dwc3: Increase DWC3 controller halt timeout
5265397f9442 usb: dwc3: Remove DWC3 locking during gadget suspend/resume
2b2da6574e77 usb: dwc3: Avoid unmapping USB requests if endxfer is not complete
dff981842a0b usb: dwc3: gadget: Continue handling EP0 xfercomplete events
9711c67de748 usb: dwc3: gadget: Synchronize IRQ between soft connect/disconnect
e1ee843488d5 usb: dwc3: gadget: Force sending delayed status during soft disconnect
359d5a85a758 usb: dwc3: Do not service EP0 and conndone events if soft disconnected
37a136aac3fe usb: dwc3: debug: show events parameters in hex
b44c0e7fef51 usb: dwc3: gadget: conditionally remove requests

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 100 +++++++++++++++++++++++++++-----------
 drivers/usb/dwc3/core.h   |   7 +++
 drivers/usb/dwc3/debug.h  |   4 +-
 drivers/usb/dwc3/ep0.c    |  11 +++--
 drivers/usb/dwc3/gadget.c | 100 ++++++++++++++++++++++++++++++--------
 5 files changed, 167 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d0237b30c9be..1f348bc867c2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -408,6 +408,10 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
 	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
 	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
+
+	if (dwc->gfladj_refclk_lpm_sel)
+		reg |=  DWC3_GFLADJ_REFCLK_LPM_SEL;
+
 	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
 }
 
@@ -789,7 +793,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	else
 		reg |= DWC3_GUSB2PHYCFG_ENBLSLPM;
 
-	if (dwc->dis_u2_freeclk_exists_quirk)
+	if (dwc->dis_u2_freeclk_exists_quirk || dwc->gfladj_refclk_lpm_sel)
 		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
 
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
@@ -1180,6 +1184,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
 	}
 
+	/*
+	 * When configured in HOST mode, after issuing U3/L2 exit controller
+	 * fails to send proper CRC checksum in CRC5 feild. Because of this
+	 * behaviour Transaction Error is generated, resulting in reset and
+	 * re-enumeration of usb device attached. All the termsel, xcvrsel,
+	 * opmode becomes 0 during end of resume. Enabling bit 10 of GUCTL1
+	 * will correct this problem. This option is to support certain
+	 * legacy ULPI PHYs.
+	 */
+	if (dwc->resume_hs_terminations) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
+		reg |= DWC3_GUCTL1_RESUME_OPMODE_HS_HOST;
+		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
+	}
+
 	if (!DWC3_VER_IS_PRIOR(DWC3, 250A)) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
 
@@ -1523,8 +1542,12 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis-del-phy-power-chg-quirk");
 	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
 				"snps,dis-tx-ipgap-linecheck-quirk");
+	dwc->resume_hs_terminations = device_property_read_bool(dev,
+				"snps,resume-hs-terminations");
 	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
 				"snps,parkmode-disable-ss-quirk");
+	dwc->gfladj_refclk_lpm_sel = device_property_read_bool(dev,
+				"snps,gfladj-refclk-lpm-sel-quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
@@ -1687,6 +1710,16 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
 		return extcon_get_extcon_dev(name);
 
+	/*
+	 * Check explicitly if "usb-role-switch" is used since
+	 * extcon_find_edev_by_node() can not be used to check the absence of
+	 * an extcon device. In the absence of an device it will always return
+	 * EPROBE_DEFER.
+	 */
+	if (IS_ENABLED(CONFIG_USB_ROLE_SWITCH) &&
+	    device_property_read_bool(dev, "usb-role-switch"))
+		return NULL;
+
 	/*
 	 * Try to get an extcon device from the USB PHY controller's "port"
 	 * node. Check if it has the "port" node first, to avoid printing the
@@ -1753,8 +1786,10 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc3_get_properties(dwc);
 
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
-	if (IS_ERR(dwc->reset))
-		return PTR_ERR(dwc->reset);
+	if (IS_ERR(dwc->reset)) {
+		ret = PTR_ERR(dwc->reset);
+		goto put_usb_psy;
+	}
 
 	if (dev->of_node) {
 		/*
@@ -1764,45 +1799,57 @@ static int dwc3_probe(struct platform_device *pdev)
 		 * check for them to retain backwards compatibility.
 		 */
 		dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
-		if (IS_ERR(dwc->bus_clk))
-			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-					     "could not get bus clock\n");
+		if (IS_ERR(dwc->bus_clk)) {
+			ret = dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+					    "could not get bus clock\n");
+			goto put_usb_psy;
+		}
 
 		if (dwc->bus_clk == NULL) {
 			dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
-			if (IS_ERR(dwc->bus_clk))
-				return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-						     "could not get bus clock\n");
+			if (IS_ERR(dwc->bus_clk)) {
+				ret = dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+						    "could not get bus clock\n");
+				goto put_usb_psy;
+			}
 		}
 
 		dwc->ref_clk = devm_clk_get_optional(dev, "ref");
-		if (IS_ERR(dwc->ref_clk))
-			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-					     "could not get ref clock\n");
+		if (IS_ERR(dwc->ref_clk)) {
+			ret = dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+					    "could not get ref clock\n");
+			goto put_usb_psy;
+		}
 
 		if (dwc->ref_clk == NULL) {
 			dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
-			if (IS_ERR(dwc->ref_clk))
-				return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-						     "could not get ref clock\n");
+			if (IS_ERR(dwc->ref_clk)) {
+				ret = dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+						    "could not get ref clock\n");
+				goto put_usb_psy;
+			}
 		}
 
 		dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
-		if (IS_ERR(dwc->susp_clk))
-			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-					     "could not get suspend clock\n");
+		if (IS_ERR(dwc->susp_clk)) {
+			ret = dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+					    "could not get suspend clock\n");
+			goto put_usb_psy;
+		}
 
 		if (dwc->susp_clk == NULL) {
 			dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
-			if (IS_ERR(dwc->susp_clk))
-				return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-						     "could not get suspend clock\n");
+			if (IS_ERR(dwc->susp_clk)) {
+				ret = dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+						    "could not get suspend clock\n");
+				goto put_usb_psy;
+			}
 		}
 	}
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
-		return ret;
+		goto put_usb_psy;
 
 	ret = dwc3_clk_enable(dwc);
 	if (ret)
@@ -1846,8 +1893,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc->edev = dwc3_get_extcon(dwc);
 	if (IS_ERR(dwc->edev)) {
-		ret = PTR_ERR(dwc->edev);
-		dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
+		ret = dev_err_probe(dwc->dev, PTR_ERR(dwc->edev), "failed to get extcon\n");
 		goto err3;
 	}
 
@@ -1909,7 +1955,7 @@ disable_clks:
 	dwc3_clk_disable(dwc);
 assert_reset:
 	reset_control_assert(dwc->reset);
-
+put_usb_psy:
 	if (dwc->usb_psy)
 		power_supply_put(dwc->usb_psy);
 
@@ -1977,9 +2023,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
 			break;
-		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
 		synchronize_irq(dwc->irq_gadget);
 		dwc3_core_exit(dwc);
 		break;
@@ -2040,9 +2084,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			return ret;
 
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
-		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_resume(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
 		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4fe4287dc934..8f9959ba9fd4 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -263,6 +263,7 @@
 #define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK	BIT(26)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
+#define DWC3_GUCTL1_RESUME_OPMODE_HS_HOST	BIT(10)
 
 /* Global Status Register */
 #define DWC3_GSTS_OTG_IP	BIT(10)
@@ -391,6 +392,7 @@
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
 #define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
+#define DWC3_GFLADJ_REFCLK_LPM_SEL		BIT(23)
 #define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
 #define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
 
@@ -1096,6 +1098,8 @@ struct dwc3_scratchpad_array {
  *			change quirk.
  * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
  *			check during HS transmit.
+ * @resume-hs-terminations: Set if we enable quirk for fixing improper crc
+ *			generation after resume from suspend.
  * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
  *			instances in park mode.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
@@ -1311,7 +1315,9 @@ struct dwc3 {
 	unsigned		dis_u2_freeclk_exists_quirk:1;
 	unsigned		dis_del_phy_power_chg_quirk:1;
 	unsigned		dis_tx_ipgap_linecheck_quirk:1;
+	unsigned		resume_hs_terminations:1;
 	unsigned		parkmode_disable_ss_quirk:1;
+	unsigned		gfladj_refclk_lpm_sel:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
@@ -1560,6 +1566,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 		u32 param);
 void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index d223c54115f4..48b44b88dc25 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -278,7 +278,7 @@ static inline const char *dwc3_ep_event_string(char *str, size_t size,
 		break;
 	case DWC3_DEPEVT_XFERINPROGRESS:
 		scnprintf(str + len, size - len,
-				"Transfer In Progress [%d] (%c%c%c)",
+				"Transfer In Progress [%08x] (%c%c%c)",
 				event->parameters,
 				status & DEPEVT_STATUS_SHORT ? 'S' : 's',
 				status & DEPEVT_STATUS_IOC ? 'I' : 'i',
@@ -286,7 +286,7 @@ static inline const char *dwc3_ep_event_string(char *str, size_t size,
 		break;
 	case DWC3_DEPEVT_XFERNOTREADY:
 		len += scnprintf(str + len, size - len,
-				"Transfer Not Ready [%d]%s",
+				"Transfer Not Ready [%08x]%s",
 				event->parameters,
 				status & DEPEVT_STATUS_TRANSFER_ACTIVE ?
 				" (Active)" : " (Not Active)");
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 197af63f8d05..61de693461da 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -197,7 +197,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	if (!dep->endpoint.desc || !dwc->pullups_connected) {
+	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		ret = -ESHUTDOWN;
@@ -293,7 +293,10 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 			continue;
 
 		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
-		dwc3_stop_active_transfer(dwc3_ep, true, true);
+		if (dwc->connected)
+			dwc3_stop_active_transfer(dwc3_ep, true, true);
+		else
+			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
 	}
 }
 
@@ -815,7 +818,7 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	int ret = -EINVAL;
 	u32 len;
 
-	if (!dwc->gadget_driver || !dwc->connected)
+	if (!dwc->gadget_driver || !dwc->softconnect || !dwc->connected)
 		goto out;
 
 	trace_dwc3_ctrl_req(ctrl);
@@ -1118,6 +1121,8 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 {
 	switch (event->status) {
 	case DEPEVT_STATUS_CONTROL_DATA:
+		if (!dwc->softconnect || !dwc->connected)
+			return;
 		/*
 		 * We already have a DATA transfer in the controller's cache,
 		 * if we receive a XferNotReady(DATA) we will ignore it, unless
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index eca945feeec3..6d524fa76443 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -291,7 +291,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 	 *
 	 * DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
 	 */
-	if (dwc->gadget->speed <= USB_SPEED_HIGH) {
+	if (dwc->gadget->speed <= USB_SPEED_HIGH ||
+	    DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
 			saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
@@ -366,7 +367,9 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 
 	dwc3_writel(dep->regs, DWC3_DEPCMD, cmd);
 
-	if (!(cmd & DWC3_DEPCMD_CMDACT)) {
+	if (!(cmd & DWC3_DEPCMD_CMDACT) ||
+		(DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER &&
+		!(cmd & DWC3_DEPCMD_CMDIOC))) {
 		ret = 0;
 		goto skip_status;
 	}
@@ -965,29 +968,33 @@ out:
 	return 0;
 }
 
-static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
 {
 	struct dwc3_request		*req;
 
 	dwc3_stop_active_transfer(dep, true, false);
 
+	/* If endxfer is delayed, avoid unmapping requests */
+	if (dep->flags & DWC3_EP_DELAY_STOP)
+		return;
+
 	/* - giveback all requests to gadget driver */
 	while (!list_empty(&dep->started_list)) {
 		req = next_request(&dep->started_list);
 
-		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+		dwc3_gadget_giveback(dep, req, status);
 	}
 
 	while (!list_empty(&dep->pending_list)) {
 		req = next_request(&dep->pending_list);
 
-		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+		dwc3_gadget_giveback(dep, req, status);
 	}
 
 	while (!list_empty(&dep->cancelled_list)) {
 		req = next_request(&dep->cancelled_list);
 
-		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+		dwc3_gadget_giveback(dep, req, status);
 	}
 }
 
@@ -1005,6 +1012,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 {
 	struct dwc3		*dwc = dep->dwc;
 	u32			reg;
+	u32			mask;
 
 	trace_dwc3_gadget_ep_disable(dep);
 
@@ -1016,18 +1024,26 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	reg &= ~DWC3_DALEPENA_EP(dep->number);
 	dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
+	dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
+
+	dep->stream_capable = false;
+	dep->type = 0;
+	mask = DWC3_EP_TXFIFO_RESIZED;
+	/*
+	 * dwc3_remove_requests() can exit early if DWC3 EP delayed stop is
+	 * set.  Do not clear DEP flags, so that the end transfer command will
+	 * be reattempted during the next SETUP stage.
+	 */
+	if (dep->flags & DWC3_EP_DELAY_STOP)
+		mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
+	dep->flags &= mask;
+
 	/* Clear out the ep descriptors for non-ep0 */
 	if (dep->number > 1) {
 		dep->endpoint.comp_desc = NULL;
 		dep->endpoint.desc = NULL;
 	}
 
-	dwc3_remove_requests(dwc, dep);
-
-	dep->stream_capable = false;
-	dep->type = 0;
-	dep->flags &= DWC3_EP_TXFIFO_RESIZED;
-
 	return 0;
 }
 
@@ -1277,8 +1293,8 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 			trb->ctrl = DWC3_TRBCTL_ISOCHRONOUS;
 		}
 
-		/* always enable Interrupt on Missed ISOC */
-		trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
+		if (!no_interrupt && !chain)
+			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
 		break;
 
 	case USB_ENDPOINT_XFER_BULK:
@@ -1683,6 +1699,16 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
 	memset(&params, 0, sizeof(params));
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	/*
+	 * If the End Transfer command was timed out while the device is
+	 * not in SETUP phase, it's possible that an incoming Setup packet
+	 * may prevent the command's completion. Let's retry when the
+	 * ep0state returns to EP0_SETUP_PHASE.
+	 */
+	if (ret == -ETIMEDOUT && dep->dwc->ep0state != EP0_SETUP_PHASE) {
+		dep->flags |= DWC3_EP_DELAY_STOP;
+		return 0;
+	}
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
@@ -2340,7 +2366,7 @@ static void dwc3_stop_active_transfers(struct dwc3 *dwc)
 		if (!dep)
 			continue;
 
-		dwc3_remove_requests(dwc, dep);
+		dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
 	}
 }
 
@@ -2440,7 +2466,7 @@ static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
 static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 {
 	u32			reg;
-	u32			timeout = 500;
+	u32			timeout = 2000;
 
 	if (pm_runtime_suspended(dwc->dev))
 		return 0;
@@ -2473,6 +2499,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	do {
+		usleep_range(1000, 2000);
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 		reg &= DWC3_DSTS_DEVCTRLHLT;
 	} while (--timeout && !(!is_on ^ !reg));
@@ -2501,6 +2528,9 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	if (dwc->ep0state != EP0_SETUP_PHASE) {
 		int ret;
 
+		if (dwc->delayed_status)
+			dwc3_ep0_send_delayed_status(dwc);
+
 		reinit_completion(&dwc->ep0_in_setup);
 
 		spin_unlock_irqrestore(&dwc->lock, flags);
@@ -2568,6 +2598,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		return 0;
 	}
 
+	synchronize_irq(dwc->irq_gadget);
+
 	if (!is_on) {
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	} else {
@@ -2718,6 +2750,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
 	dep = dwc->eps[0];
+	dep->flags = 0;
 	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
@@ -2725,6 +2758,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	}
 
 	dep = dwc->eps[1];
+	dep->flags = 0;
 	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
@@ -3215,6 +3249,10 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
+	if ((trb->ctrl & DWC3_TRB_CTRL_ISP_IMI) &&
+	    DWC3_TRB_SIZE_TRBSTS(trb->size) == DWC3_TRBSTS_MISSED_ISOC)
+		return 1;
+
 	if ((trb->ctrl & DWC3_TRB_CTRL_IOC) ||
 	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
@@ -3568,7 +3606,7 @@ static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 		 * streams are updated, and the device controller will not be
 		 * triggered to generate ERDY to move the next stream data. To
 		 * workaround this and maintain compatibility with various
-		 * hosts, force to reinitate the stream until the host is ready
+		 * hosts, force to reinitiate the stream until the host is ready
 		 * instead of waiting for the host to prime the endpoint.
 		 */
 		if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
@@ -3596,11 +3634,12 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	dep = dwc->eps[epnum];
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
-		if (!(dep->flags & DWC3_EP_TRANSFER_STARTED))
+		if ((epnum > 1) && !(dep->flags & DWC3_EP_TRANSFER_STARTED))
 			return;
 
 		/* Handle only EPCMDCMPLT when EP disabled */
-		if (event->endpoint_event != DWC3_DEPEVT_EPCMDCMPLT)
+		if ((event->endpoint_event != DWC3_DEPEVT_EPCMDCMPLT) &&
+			!(epnum <= 1 && event->endpoint_event == DWC3_DEPEVT_XFERCOMPLETE))
 			return;
 	}
 
@@ -3763,13 +3802,24 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 	reg &= ~DWC3_DCTL_INITU2ENA;
 	dwc3_gadget_dctl_write_safe(dwc, reg);
 
+	dwc->connected = false;
+
 	dwc3_disconnect_gadget(dwc);
 
 	dwc->gadget->speed = USB_SPEED_UNKNOWN;
 	dwc->setup_packet_pending = false;
 	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
 
-	dwc->connected = false;
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
+		unsigned int    dir;
+
+		dir = !!dwc->ep0_expect_in;
+		if (dwc->ep0state == EP0_DATA_PHASE)
+			dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
+		else
+			dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
+		dwc3_ep0_stall_and_restart(dwc);
+	}
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
@@ -3867,6 +3917,9 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	u8			lanes = 1;
 	u8			speed;
 
+	if (!dwc->softconnect)
+		return;
+
 	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 	speed = reg & DWC3_DSTS_CONNECTSPD;
 	dwc->speed = speed;
@@ -4129,7 +4182,7 @@ static void dwc3_gadget_hibernation_interrupt(struct dwc3 *dwc,
 	unsigned int is_ss = evtinfo & BIT(4);
 
 	/*
-	 * WORKAROUND: DWC3 revison 2.20a with hibernation support
+	 * WORKAROUND: DWC3 revision 2.20a with hibernation support
 	 * have a known issue which can cause USB CV TD.9.23 to fail
 	 * randomly.
 	 *
@@ -4507,12 +4560,17 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
+	unsigned long flags;
+
 	if (!dwc->gadget_driver)
 		return 0;
 
 	dwc3_gadget_run_stop(dwc, false, false);
+
+	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
 }
-- 
2.53.0

