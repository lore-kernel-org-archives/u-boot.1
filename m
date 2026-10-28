Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3F606A31E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h9cOka8x;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qIYN7OSR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C0B6407F3;
	Wed, 28 Oct 2026 14:47:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s-flf2uz6q77; Wed, 28 Oct 2026 14:47:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 96264407FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198834;
	b=XeK9Mo8o84BTxcbKjF0LqX8pdloveR3pkd7Hjr/7uUNcMfYbc5W76eRjJ0l4wzRnWbGA
	 /naG2eiI0upFPMm2Cv5a1Ti/11eXuZsFwjG/UZW/bFmtbibMH3Z7fFMJYO2qeKZ9jq82e
	 x3GZ1KWuBbhnrvLOMuSkD8LO/fZX/gqLQbkAn28WAxDTHA1Jry69iS26FaTdZgfqlFLQP
	 hGn3K0+I1DbeVT3R/0QGNicfv1bqN9qdcO/ZhFl+Vz2eugIFEXnCGlKPs99XXJItZ7Sbo
	 pbnRm3Ncw1rtRInRFL8h9AV2CdrGs6CJ9kOLw+IGZ2ib18LjP3+TEVDwuRz+7aChNXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198834;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sbUTYT3keKOcLBeYxkoEpMllA6TuxlYG77e3jqkghTE=;
	b=K31LBtnHE5h+e0/timgzI/Fzm6w/nd5QbgQakc23Xw0IaNe6+BNxseXE13zaW2fy/pCX
	 RC3KbQHE9yjR/BQuoQdOZlx9wTOdjQc3s9ILSACUve8o1Ilabi2/2fWAM/L28sJ0XIauC
	 s50hagWlEcvOAobqsw8xuKwFx4S9HNZ8pfsuZtuKmXSQ5qZYE38kkpgcJaWXH12KAOmjI
	 5ixPDevO12XVYsuzkdDr7e7+ARBUO82TOHcQnVq016mcVzNaHFJMC9Gxk7IDD9F+r8mm3
	 1pwWV9yFhASMecUDdp6CFUUpaTtO3c4qcANfGcqpBhtOl3GG2WpJYIuZfCmtxYTobyQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qIYN7OSR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198834;
	bh=sbUTYT3keKOcLBeYxkoEpMllA6TuxlYG77e3jqkghTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9cOka8xOP8hUPtqtJouHa0PGAGCc6C0iw+z1Rkmri0ks1dAB8avx7JTb49IH5LnY
	 LmGURWsuDEHR19PtDwenjdYafy/zO8znBbKqt+GYnwjrQ23HRRSs4lVtnQ+6c13U14
	 4fd/FYvthOmy3bYSkN+B0c6dhh+Ri8HXO+5Y1fYH38XzFcnCBCydPXbZv403gpfqsI
	 rhC9W4LBoiEDA94zfZz+vuy3O8wH3KswXXiTkSZk/e1r0475gRn2ZmGtlE4ZD+9AeI
	 4uY7Y1gUWcmIAY8hB2ppV0M5yHquU8b/iH9jdl8qkNwmGyIaukjTwK6mayPqbDyETt
	 QoUTDdZ20vrZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96264407FB;
	Wed, 28 Oct 2026 14:47:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F6FA529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7587540562
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QALVb4He70Cn for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:13:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A5D44404DE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196797;
 b=BxTQxtGH4wLudK4zL2rTI7HYhB1GMh9CLN6iFp2BdM0ie4pFwAGh4SdXfOsfoJ82tR6M
 GV+HsZc3hOAbignZl1WoNF9mZhoK5uqsyS1gNCimrWgyoalsXFMHZlOBqjmgWWa0PgJjI
 YcFJauh/cT7nB4P/9NZUyXYDCKMvMluHxCIYpEewduECQtfsVfmybyP6O+okA8qBE3rYI
 M+it8895O2kPDDLVk7nU1JEsbUeNgf/PBuyOG/DUyGcfDfeB3v2jSwTfbFCgDnSBdlT91
 7s4xQkfu9utgW5yP9RR8d0yceaMEKSknmEQoLLOUIvqR9dOWZnYx4sqWjHZ+9+eWuzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196797;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=sbUTYT3keKOcLBeYxkoEpMllA6TuxlYG77e3jqkghTE=;
 b=sAPlWBkbSOZ45UJW15Q7OX0N1Xht1G8yyzls+44p6d/99RKakoqo4916FT5BITjrTelk
 kP0tlaye0BGV9DJyJlffl1MR41OUkQxDmqMmUchYa4YSiwokBVtDyNa0cMUohZNF1dIrk
 K1yPP8VcQjrTN6u+3UYXE1hfSC/4Ow6KfFprJDWC77ADJPwUjgUtclc5BDsoI0fIxQicg
 QuMU+t2PCnCRHwplriyHghf2P1w+PZxVfMZPHhwN0NsMZgfWuxKs/h60f9B3IoFcowTzV
 IP+l6Y+YBMQ6Tfq3UwvMokvoCKEihctGke+2cnsYfrU2kmGBllE/a7X6JKKsgUFTCxw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=qIYN7OSR; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=qIYN7OSR
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A5D44404DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:16 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c499b5be0f1so11808166b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196794; x=1793801594;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sbUTYT3keKOcLBeYxkoEpMllA6TuxlYG77e3jqkghTE=;
 b=qIYN7OSRbQN5mxkjCzlRd/RJHgsthiIOUFXBHhx84Zqtj8F0mtEsc+mHgV8wzzl1FE
 7XB6bf7pKWtsRpYOMpNhGwCfKEfqsnl6dIQC91IXpX7pfjBXnJvKB65x4dGK0fgN+yv5
 gWvgRjTvJdjBXRXdluGY4UtFP5/b0NHysSp/bXsjVSIF/Qhr9ZlJG0b1SPCEq5dDSIg+
 eXnM0BqBadCpQzFlyTtcF2V1E2fuwq9K9WFcEKDsQZGcFvoBGTitSsI+3LpezYIGdwvh
 mLw3OJZ+XGTUqpEXhR9kkemUfPLb8Spb/EmAj/gpmux0jETjpgM38OX5xBar1M8jkUOk
 WppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196794; x=1793801594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sbUTYT3keKOcLBeYxkoEpMllA6TuxlYG77e3jqkghTE=;
 b=z+cNfE26SUCzVdUwP4ioPocCFUjLrl5cmf+BshP50c96UBEAN6H4S3Bp6Bzp1Sovd4
 a1NMfYcFrl2Ik3S73k49t43uXc0snMqvY7c6/TlGjn62dRhEZ4o1Ne92A0YY+dWJoJA/
 Meg94LjrZnL0d2kZkqOB8nSIAeJWXqNWSbV9n2SjuwRfpFjEZHWbtfUjz9Z+WGOgEYNK
 XvOd8fzzlAY5ui2O9OlkMO7nTt7GlGZ8gr1OzBlTpK3EnBQpoqoysNbMvROggqV3jMWR
 /b15f8GElTLqa46LpI2lZEkDl26kjRn93rk185M3QnKY/D+XgLmu50ZWq0kPte2dttp6
 IBPA==
X-Gm-Message-State: AFq9FYJCFE9eYOaxvOtnHQonXF83xbgbP6i/xin5EpLTeU+kwFWED4AN
 hQhzehxY8M0emfbAuC7NOSZYaKRShofVIwKUHG/1LoVpAYu5fxFChs5RqkfYtDyeFvvS1dVq7fd
 5pzn7
X-Gm-Gg: AYBFou0tolbh+JKvDyJuTq4M1s8/EiCnkmRm7SdVpvAaysOOtcEfUAYYDjAFwCWxY05
 9lWt8fmLKllQ8r8i2PDN2SBX686iNY/MGIYgs/fBEf2Z69RpngRXb0fsS3NE069JJtK+tddsi3g
 THhcQ7ldMKyhv7u4PgPNousUb9OXYxVn7/m0MecIL1iUWSidPA9InJB+EJO4Yf7aJh1F9iBgVld
 hsviIlVP1e1n3xUS1lYvr0+hQ2kOijwTzLzi09cq6cm64T1L3MEdgADPw/XZ1/wpVAChcRmux+A
 D9G0fm5PdiN+pVyNLVNlZVC2oyTkm9eCRyhpzPsJe7+NvvtOYmP2MYOHJKXQ3A33cYE2aQk7Iak
 MWUP9mqV0lAbC4nx21kV9QQUtvUw8bGTyFEEJoUMqK3BMqHSWys15Ojm1Zq5QiZ52IxP7v/a82X
 lOisP6mDWiqpMAC/Pv6a+Qwzj63hzZaW1hGxNo4oHPKA8tm0os5o3wParI7HYF0XyR+cVORmpxl
 HGNlpcnRz6iRsWKx6GzGZXmdkusagkYu+Z4u055rUkSz+phmRTYVvZ1Jq9OAPJ6DbDXmq4hRHOt
 kmmYL3ou9m8aYpYRHk08hVtJt4eody9vqIkjK690WVelIdhvrTSDxCKIWYAMcM88fcvQd9ZwCjU
 o4KpYxB0YNw==
X-Received: by 2002:a17:907:9543:b0:c2e:8801:9139 with SMTP id
 a640c23a62f3a-c49bdd5a5a5mr216691166b.1.1793196794044; 
 Wed, 28 Oct 2026 07:13:14 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd350c61sm612006966b.11.2026.10.28.07.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:13:13 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 43/63] usb: dwc3: import from kernel v5.18
Date: Wed, 28 Oct 2026 15:09:09 +0100
Message-ID: <20261028140930.3025368-44-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.17 to v5.18.

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

List of commits: git log --oneline v5.17..v5.18
Commits imported:
c7428dbddcf4 usb: dwc3: gadget: Return proper request status
f4fd84ae0765 usb: dwc3: core: Only handle soft-reset in DCTL
f28ad9069363 usb: dwc3: core: Fix tx/rx threshold settings
4e64cd7763ca usb: dwc3: fix backwards compat with rockchip devices
0066472de157 usb: dwc3: Issue core soft reset before enabling run/stop
e4cf6580ac74 usb: dwc3: gadget: Wait for ep0 xfers to complete during dequeue
e192cc7b5239 usb: dwc3: gadget: move cmd_endtransfer to extra function
26d27a1080a7 usb: dwc3: gadget: ep_queue simplify isoc start condition
aa6812be1feb usb: dwc3: gadget: Give some time to schedule isoc
62b20e6e0dde usb: dwc3: core: do not use 3.0 clock when operating in 2.0 mode
596c87856e08 usb: dwc3: Program GFLADJ
5114c3ee2487 usb: dwc3: Calculate REFCLKPER based on reference clock
33fb697ec7e5 usb: dwc3: Get clocks individually

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 158 ++++++++++++++++++++++++++++++++------
 drivers/usb/dwc3/core.h   |  17 +++-
 drivers/usb/dwc3/ep0.c    |  14 ++++
 drivers/usb/dwc3/gadget.c | 149 ++++++++++++++++++++++++-----------
 drivers/usb/dwc3/gadget.h |   1 +
 5 files changed, 267 insertions(+), 72 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f4c09951b517..d28cd1a6709b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -115,8 +115,6 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	dwc->current_dr_role = mode;
 }
 
-static int dwc3_core_soft_reset(struct dwc3 *dwc);
-
 static void __dwc3_set_mode(struct work_struct *work)
 {
 	struct dwc3 *dwc = work_to_dwc(work);
@@ -261,7 +259,7 @@ u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
  * dwc3_core_soft_reset - Issues core soft reset and PHY reset
  * @dwc: pointer to our context structure
  */
-static int dwc3_core_soft_reset(struct dwc3 *dwc)
+int dwc3_core_soft_reset(struct dwc3 *dwc)
 {
 	u32		reg;
 	int		retries = 1000;
@@ -276,7 +274,8 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg |= DWC3_DCTL_CSFTRST;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	reg &= ~DWC3_DCTL_RUN_STOP;
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	/*
 	 * For DWC_usb31 controller 1.90a and later, the DCTL.CSFRST bit
@@ -347,17 +346,64 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
  */
 static void dwc3_ref_clk_period(struct dwc3 *dwc)
 {
+	unsigned long period;
+	unsigned long fladj;
+	unsigned long decr;
+	unsigned long rate;
 	u32 reg;
 
-	if (dwc->ref_clk_per == 0)
+	if (dwc->ref_clk) {
+		rate = clk_get_rate(dwc->ref_clk);
+		if (!rate)
+			return;
+		period = NSEC_PER_SEC / rate;
+	} else if (dwc->ref_clk_per) {
+		period = dwc->ref_clk_per;
+		rate = NSEC_PER_SEC / period;
+	} else {
 		return;
+	}
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
 	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
-	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, dwc->ref_clk_per);
+	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, period);
 	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
-}
 
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
+		return;
+
+	/*
+	 * The calculation below is
+	 *
+	 * 125000 * (NSEC_PER_SEC / (rate * period) - 1)
+	 *
+	 * but rearranged for fixed-point arithmetic. The division must be
+	 * 64-bit because 125000 * NSEC_PER_SEC doesn't fit in 32 bits (and
+	 * neither does rate * period).
+	 *
+	 * Note that rate * period ~= NSEC_PER_SECOND, minus the number of
+	 * nanoseconds of error caused by the truncation which happened during
+	 * the division when calculating rate or period (whichever one was
+	 * derived from the other). We first calculate the relative error, then
+	 * scale it to units of 8 ppm.
+	 */
+	fladj = div64_u64(125000ULL * NSEC_PER_SEC, (u64)rate * period);
+	fladj -= 125000;
+
+	/*
+	 * The documented 240MHz constant is scaled by 2 to get PLS1 as well.
+	 */
+	decr = 480000000 / rate;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
+	reg &= ~DWC3_GFLADJ_REFCLK_FLADJ_MASK
+	    &  ~DWC3_GFLADJ_240MHZDECR
+	    &  ~DWC3_GFLADJ_240MHZDECR_PLS1;
+	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
+	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
+	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
+	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
+}
 
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
@@ -745,6 +791,38 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	return 0;
 }
 
+static int dwc3_clk_enable(struct dwc3 *dwc)
+{
+	int ret;
+
+	ret = clk_prepare_enable(dwc->bus_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(dwc->ref_clk);
+	if (ret)
+		goto disable_bus_clk;
+
+	ret = clk_prepare_enable(dwc->susp_clk);
+	if (ret)
+		goto disable_ref_clk;
+
+	return 0;
+
+disable_ref_clk:
+	clk_disable_unprepare(dwc->ref_clk);
+disable_bus_clk:
+	clk_disable_unprepare(dwc->bus_clk);
+	return ret;
+}
+
+static void dwc3_clk_disable(struct dwc3 *dwc)
+{
+	clk_disable_unprepare(dwc->susp_clk);
+	clk_disable_unprepare(dwc->ref_clk);
+	clk_disable_unprepare(dwc->bus_clk);
+}
+
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
 	dwc3_event_buffers_cleanup(dwc);
@@ -758,7 +836,7 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	phy_power_off(dwc->usb2_generic_phy);
 	phy_power_off(dwc->usb3_generic_phy);
-	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
+	dwc3_clk_disable(dwc);
 	reset_control_assert(dwc->reset);
 }
 
@@ -1088,6 +1166,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (dwc->parkmode_disable_ss_quirk)
 			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
 
+		if (DWC3_VER_IS_WITHIN(DWC3, 290A, ANY) &&
+		    (dwc->maximum_speed == USB_SPEED_HIGH ||
+		     dwc->maximum_speed == USB_SPEED_FULL))
+			reg |= DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK;
+
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
@@ -1295,10 +1378,10 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			lpm_nyet_threshold;
 	u8			tx_de_emphasis;
 	u8			hird_threshold;
-	u8			rx_thr_num_pkt_prd;
-	u8			rx_max_burst_prd;
-	u8			tx_thr_num_pkt_prd;
-	u8			tx_max_burst_prd;
+	u8			rx_thr_num_pkt_prd = 0;
+	u8			rx_max_burst_prd = 0;
+	u8			tx_thr_num_pkt_prd = 0;
+	u8			tx_max_burst_prd = 0;
 	u8			tx_fifo_resize_max_num;
 	const char		*usb_psy_name;
 	int			ret;
@@ -1605,25 +1688,54 @@ static int dwc3_probe(struct platform_device *pdev)
 		return PTR_ERR(dwc->reset);
 
 	if (dev->of_node) {
-		ret = devm_clk_bulk_get_all(dev, &dwc->clks);
-		if (ret == -EPROBE_DEFER)
-			return ret;
 		/*
 		 * Clocks are optional, but new DT platforms should support all
 		 * clocks as required by the DT-binding.
+		 * Some devices have different clock names in legacy device trees,
+		 * check for them to retain backwards compatibility.
 		 */
-		if (ret < 0)
-			dwc->num_clks = 0;
-		else
-			dwc->num_clks = ret;
+		dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
+		if (IS_ERR(dwc->bus_clk))
+			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+					     "could not get bus clock\n");
+
+		if (dwc->bus_clk == NULL) {
+			dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
+			if (IS_ERR(dwc->bus_clk))
+				return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+						     "could not get bus clock\n");
+		}
 
+		dwc->ref_clk = devm_clk_get_optional(dev, "ref");
+		if (IS_ERR(dwc->ref_clk))
+			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+					     "could not get ref clock\n");
+
+		if (dwc->ref_clk == NULL) {
+			dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
+			if (IS_ERR(dwc->ref_clk))
+				return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+						     "could not get ref clock\n");
+		}
+
+		dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
+		if (IS_ERR(dwc->susp_clk))
+			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+					     "could not get suspend clock\n");
+
+		if (dwc->susp_clk == NULL) {
+			dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
+			if (IS_ERR(dwc->susp_clk))
+				return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+						     "could not get suspend clock\n");
+		}
 	}
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
+	ret = dwc3_clk_enable(dwc);
 	if (ret)
 		goto assert_reset;
 
@@ -1711,7 +1823,7 @@ err1:
 	pm_runtime_disable(&pdev->dev);
 
 disable_clks:
-	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
+	dwc3_clk_disable(dwc);
 assert_reset:
 	reset_control_assert(dwc->reset);
 
@@ -1755,7 +1867,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
+	ret = dwc3_clk_enable(dwc);
 	if (ret)
 		goto assert_reset;
 
@@ -1766,7 +1878,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	return 0;
 
 disable_clks:
-	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
+	dwc3_clk_disable(dwc);
 assert_reset:
 	reset_control_assert(dwc->reset);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e1cc3f7398fb..5c9d467195a6 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -259,6 +259,7 @@
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
+#define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK	BIT(26)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
 
@@ -388,6 +389,9 @@
 /* Global Frame Length Adjustment Register */
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
+#define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
+#define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
+#define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
 
 /* Global User Control Register*/
 #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
@@ -733,6 +737,7 @@ struct dwc3_ep {
 #define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
 #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
+#define DWC3_EP_DELAY_STOP             BIT(13)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN			BIT(31)
@@ -978,8 +983,9 @@ struct dwc3_scratchpad_array {
  * @eps: endpoint array
  * @gadget: device side representation of the peripheral controller
  * @gadget_driver: pointer to the gadget driver
- * @clks: array of clocks
- * @num_clks: number of clocks
+ * @bus_clk: clock for accessing the registers
+ * @ref_clk: reference clock
+ * @susp_clk: clock used when the SS phy is in low power (S3) state
  * @reset: reset control
  * @regs: base address for our registers
  * @regs_size: address space size
@@ -1134,8 +1140,9 @@ struct dwc3 {
 	struct usb_gadget	*gadget;
 	struct usb_gadget_driver *gadget_driver;
 
-	struct clk_bulk_data	*clks;
-	int			num_clks;
+	struct clk		*bus_clk;
+	struct clk		*ref_clk;
+	struct clk		*susp_clk;
 
 	struct reset_control	*reset;
 
@@ -1525,6 +1532,8 @@ bool dwc3_has_imod(struct dwc3 *dwc);
 int dwc3_event_buffers_setup(struct dwc3 *dwc);
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
 
+int dwc3_core_soft_reset(struct dwc3 *dwc);
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 658739410992..1064be5518f6 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -271,6 +271,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 {
 	struct dwc3_ep			*dep;
 	int				ret;
+	int                             i;
 
 	complete(&dwc->ep0_in_setup);
 
@@ -279,6 +280,19 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 			DWC3_TRBCTL_CONTROL_SETUP, false);
 	ret = dwc3_ep0_start_trans(dep);
 	WARN_ON(ret < 0);
+	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
+		struct dwc3_ep *dwc3_ep;
+
+		dwc3_ep = dwc->eps[i];
+		if (!dwc3_ep)
+			continue;
+
+		if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
+			continue;
+
+		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
+		dwc3_stop_active_transfer(dwc3_ep, true, true);
+	}
 }
 
 static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIndex_le)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a0c883f19a41..0b9c2493844a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -654,9 +654,6 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
-		bool interrupt);
-
 /**
  * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
  * @dwc: pointer to the DWC3 context
@@ -1673,6 +1670,40 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
 	return DWC3_DSTS_SOFFN(reg);
 }
 
+/**
+ * __dwc3_stop_active_transfer - stop the current active transfer
+ * @dep: isoc endpoint
+ * @force: set forcerm bit in the command
+ * @interrupt: command complete interrupt after End Transfer command
+ *
+ * When setting force, the ForceRM bit will be set. In that case
+ * the controller won't update the TRB progress on command
+ * completion. It also won't clear the HWO bit in the TRB.
+ * The command will also not complete immediately in that case.
+ */
+static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+	u32 cmd;
+	int ret;
+
+	cmd = DWC3_DEPCMD_ENDTRANSFER;
+	cmd |= force ? DWC3_DEPCMD_HIPRI_FORCERM : 0;
+	cmd |= interrupt ? DWC3_DEPCMD_CMDIOC : 0;
+	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
+	memset(&params, 0, sizeof(params));
+	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	WARN_ON_ONCE(ret);
+	dep->resource_index = 0;
+
+	if (!interrupt)
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+	else if (!ret)
+		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+
+	return ret;
+}
+
 /**
  * dwc3_gadget_start_isoc_quirk - workaround invalid frame number
  * @dep: isoc endpoint
@@ -1830,7 +1861,13 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 	}
 
 	for (i = 0; i < DWC3_ISOC_MAX_RETRIES; i++) {
-		dep->frame_number = DWC3_ALIGN_FRAME(dep, i + 1);
+		int future_interval = i + 1;
+
+		/* Give the controller at least 500us to schedule transfers */
+		if (desc->bInterval < 3)
+			future_interval += 3 - desc->bInterval;
+
+		dep->frame_number = DWC3_ALIGN_FRAME(dep, future_interval);
 
 		ret = __dwc3_gadget_kick_transfer(dep);
 		if (ret != -EAGAIN)
@@ -1842,21 +1879,8 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 	 * status, issue END_TRANSFER command and retry on the next XferNotReady
 	 * event.
 	 */
-	if (ret == -EAGAIN) {
-		struct dwc3_gadget_ep_cmd_params params;
-		u32 cmd;
-
-		cmd = DWC3_DEPCMD_ENDTRANSFER |
-			DWC3_DEPCMD_CMDIOC |
-			DWC3_DEPCMD_PARAM(dep->resource_index);
-
-		dep->resource_index = 0;
-		memset(&params, 0, sizeof(params));
-
-		ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
-		if (!ret)
-			dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
-	}
+	if (ret == -EAGAIN)
+		ret = __dwc3_stop_active_transfer(dep, false, true);
 
 	return ret;
 }
@@ -1899,6 +1923,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	 */
 	if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
 	    (dep->flags & DWC3_EP_WEDGE) ||
+	    (dep->flags & DWC3_EP_DELAY_STOP) ||
 	    (dep->flags & DWC3_EP_STALL)) {
 		dep->flags |= DWC3_EP_DELAY_START;
 		return 0;
@@ -1913,13 +1938,11 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	 * errors which will force us issue EndTransfer command.
 	 */
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-		if (!(dep->flags & DWC3_EP_PENDING_REQUEST) &&
-				!(dep->flags & DWC3_EP_TRANSFER_STARTED))
-			return 0;
-
-		if ((dep->flags & DWC3_EP_PENDING_REQUEST)) {
-			if (!(dep->flags & DWC3_EP_TRANSFER_STARTED))
+		if (!(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
+			if ((dep->flags & DWC3_EP_PENDING_REQUEST))
 				return __dwc3_gadget_start_isoc(dep);
+
+			return 0;
 		}
 	}
 
@@ -2033,6 +2056,16 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		if (r == req) {
 			struct dwc3_request *t;
 
+			/*
+			 * If a Setup packet is received but yet to DMA out, the controller will
+			 * not process the End Transfer command of any endpoint. Polling of its
+			 * DEPCMD.CmdAct may block setting up TRB for Setup packet, causing a
+			 * timeout. Delay issuing the End Transfer command until the Setup TRB is
+			 * prepared.
+			 */
+			if (dwc->ep0state != EP0_SETUP_PHASE && !dwc->delayed_status)
+				dep->flags |= DWC3_EP_DELAY_STOP;
+
 			/* wait until it is processed */
 			dwc3_stop_active_transfer(dep, true, true);
 
@@ -2116,7 +2149,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
 
-		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
+		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING ||
+		    (dep->flags & DWC3_EP_DELAY_STOP)) {
 			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
 			return 0;
 		}
@@ -2544,6 +2578,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 						dwc->ev_buf->length;
 		}
 	} else {
+		/*
+		 * In the Synopsys DWC_usb31 1.90a programming guide section
+		 * 4.1.9, it specifies that for a reconnect after a
+		 * device-initiated disconnect requires a core soft reset
+		 * (DCTL.CSftRst) before enabling the run/stop bit.
+		 */
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		dwc3_core_soft_reset(dwc);
+		spin_lock_irqsave(&dwc->lock, flags);
+
+		dwc3_event_buffers_setup(dwc);
 		__dwc3_gadget_start(dwc);
 	}
 
@@ -3229,6 +3274,7 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event,
 		struct dwc3_request *req, int status)
 {
+	int request_status;
 	int ret;
 
 	if (req->request.num_mapped_sgs)
@@ -3249,7 +3295,35 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 		req->needs_extra_trb = false;
 	}
 
-	dwc3_gadget_giveback(dep, req, status);
+	/*
+	 * The event status only reflects the status of the TRB with IOC set.
+	 * For the requests that don't set interrupt on completion, the driver
+	 * needs to check and return the status of the completed TRBs associated
+	 * with the request. Use the status of the last TRB of the request.
+	 */
+	if (req->request.no_interrupt) {
+		struct dwc3_trb *trb;
+
+		trb = dwc3_ep_prev_trb(dep, dep->trb_dequeue);
+		switch (DWC3_TRB_SIZE_TRBSTS(trb->size)) {
+		case DWC3_TRBSTS_MISSED_ISOC:
+			/* Isoc endpoint only */
+			request_status = -EXDEV;
+			break;
+		case DWC3_TRB_STS_XFER_IN_PROG:
+			/* Applicable when End Transfer with ForceRM=0 */
+		case DWC3_TRBSTS_SETUP_PENDING:
+			/* Control endpoint only */
+		case DWC3_TRBSTS_OK:
+		default:
+			request_status = 0;
+			break;
+		}
+	} else {
+		request_status = status;
+	}
+
+	dwc3_gadget_giveback(dep, req, request_status);
 
 out:
 	return ret;
@@ -3596,14 +3670,11 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
 	}
 }
 
-static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
+void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	bool interrupt)
 {
-	struct dwc3_gadget_ep_cmd_params params;
-	u32 cmd;
-	int ret;
-
 	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
+	    (dep->flags & DWC3_EP_DELAY_STOP) ||
 	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
 		return;
 
@@ -3634,19 +3705,7 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	 * This mode is NOT available on the DWC_usb31 IP.
 	 */
 
-	cmd = DWC3_DEPCMD_ENDTRANSFER;
-	cmd |= force ? DWC3_DEPCMD_HIPRI_FORCERM : 0;
-	cmd |= interrupt ? DWC3_DEPCMD_CMDIOC : 0;
-	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
-	memset(&params, 0, sizeof(params));
-	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
-	WARN_ON_ONCE(ret);
-	dep->resource_index = 0;
-
-	if (!interrupt)
-		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	else
-		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+	__dwc3_stop_active_transfer(dep, force, interrupt);
 }
 
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 77df4b6d6c13..f763380e672e 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -116,6 +116,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 		gfp_t gfp_flags);
 int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
 void dwc3_ep0_send_delayed_status(struct dwc3 *dwc);
+void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt);
 
 /**
  * dwc3_gadget_ep_get_transfer_index - Gets transfer index from HW
-- 
2.53.0

