Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F2606A323
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ezb6ittU;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tFFX99rA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 565C68137D;
	Wed, 28 Oct 2026 14:48:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UhD8BBINPqNV; Wed, 28 Oct 2026 14:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7CB0B80F39
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198847;
	b=RVzXyhTTdJCIdAlDr6eK4mvxSUFYmYSko38hz0bcIZ4xQ2qjdRvCk5X1bgPZdzMbplLN
	 YrDt3dXCou1ocvoYW8lN3gYB7tFcf7g/90brJjvqpM7k/gaT3A1p1ph1PaF9YuEVRQ/3N
	 Mnx+Y1U+1VPQAc8JSbw4m2ziLpr1ODHMNPr+FV9QdIsq2g6b/ulUqBVi4Yns4iTm/l+p8
	 Ax1HAYHKyaH02pZ0hH87BYpRPcCC6jLrmTI+tBYYQDZRSNjCjMJAJH0iTW3kIMSOUZ6Uz
	 /JBZF/u6/KM6SBgVFxRAqkjJ49l81DTQuUDD3DE+g+lzDzagg2h8DaqdSsCrZxza2lA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198847;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8hKOHLjQYw6SSk3eHqSe8KLczL5iiwsi1dTbjAbKap8=;
	b=lp1WiN5BbGQaiiYxrbaAnXvPTD+twYbyVDxSXi35wWRSihXcHvhE1YwCgGHDfk99wzJh
	 2NaykQvlstF8zD9ggtN2Hm/Al/NWMEF2oyq/NqNPRElscc2ynCbf1mXbiWu33SE5z9aGS
	 RYV9mygmft1xxmNIeNiCiaFgp6qNd4eodEe8bafw9x5OUjnYhEoDJu5TsaottDkScPhsf
	 gVUl+l8EISHQzWgiffvqU0W3nNTpeOr91S23DcpZaWvcb7D/5wmpQPdShaaqhlfEj3dFc
	 jWG9rDT1YhP6ejE3/f/bqMJRxnjhbQ5oEMRZsbPcsI6MIdOv9hfWvAKBbEjBdY0+Mqw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198847;
	bh=8hKOHLjQYw6SSk3eHqSe8KLczL5iiwsi1dTbjAbKap8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ezb6ittUVM/aS3CH1hQnAKiQltKimPgthkETUKok0jncTKVeIZ0ve95+t98g9kZwN
	 SYFfw+NCr6BUtLWErAwID7fe1vwlawwxaszZeOCpOdOGOp8qwvy5FMc6Hp/wbBZe3w
	 fg/RJql2WVaT1nw9hOZP6pJeNmq+JeVQ+O4uNJ8G9+qO93u8ZUvaeGUdaeL3aIHmtF
	 TV7MBaJmYSmLaL8gYbUP8uSEtgBhU+XdxtWIGY4f8V11/41eENURSxGvEiiBlPNjeo
	 jBGlB7y6+Dkqyjdmr/lTnc8+Qj9ZjieddrRjq+Fkp3notstloTZtChWIEZRPANX+Ca
	 GE65/wfBW2IRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CB0B80F39;
	Wed, 28 Oct 2026 14:47:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BE94D4D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD182605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6jTMevsfZGgr for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:14:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A125605EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196843;
 b=MyM9gZlNx8yuMFEu4/vfYt3Sq+1HLc+hx1GQjroH7vHFKQQGpeo2FSDthNU7SNxwMYT4
 Y44rP8/VXIVBlGw68zYrZRAJ0tddOIu3swaj+U8EH/T6p7pcTuoFBd2npuS0HE/mE0SaC
 lA2Qgg3VB4mkmCxfaH/js0VnbrwquEsrIdfMijYp5PjP7W5ZQpU9lPDlQR36Fu5evtKlr
 0+R6uFF/+Y2o0UYUlo9fc1IFDofzQ3seHwMn9pD4WJ/zImYCZI3W+1vSvRJ9Exl00uTtf
 +2HgkZ+LIzdQV8jp4XzTcJq+XriYCxB7Jq5eO+mzb8JGFTvuA8Xd91bYX2NzVkJFQcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196843;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=8hKOHLjQYw6SSk3eHqSe8KLczL5iiwsi1dTbjAbKap8=;
 b=NEMOo7tKj5pMhFlSjHszJluS5g7VRybNweaX0I7LkAvD/GrIquCZ+9GD1LY3Aa9iNXpi
 I3li9ahoNt2NdcF7hPTFxqBTjBLYGAhAS62GICjSrCjboGYasqjhZGVcLBrLwfgO+fOm7
 CXrW6nCRf4/BPPIhuQwr/JcAjq0D0gPCoaKPZXEB+3pZlp5Y0wR7RLoTzY5vhYZRfD1qS
 Y32jpBpktplikv1B5eenY5LaB4laGWFNTvyHN/Av2yq1YdI7KQSLH46ixjutpbH/4wENq
 1ukfe7/7PNPBHA/LiE6nclYpP5TBZFxeG+WSeAaQBCpP/ITBK9C2YC/Kczg3i/LwZLQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tFFX99rA; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tFFX99rA
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A125605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:02 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b3f7d5b112so171500a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196841; x=1793801641;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8hKOHLjQYw6SSk3eHqSe8KLczL5iiwsi1dTbjAbKap8=;
 b=tFFX99rARNfpbhG3R7Wql7Euow5M3Z6iwdO443ViOyE6RPIs6g8Cy40wyEXkhoWqoq
 5aj1Qb6W2g+54ff9LwlFpuLTQrhgtJ2K45aXULP9WucWBGboTEexY7gGp3b7TARn8WmG
 nXIROL0atYlYn4YWsoxyIe1UGrMT7A5q9TaKpMIEQ9/ACJbG32LgnPwHy/aa0I8RODPm
 Tyb2CRXc9+HqU6XyS7SBuHiDs6AmOLOHX7KlSk28ZSvxhusp9l6HhIExACfIsT5t0jft
 fT/rq5Y6tRpBo9b5bPMZX0fY6/MXjfod7YU/XIQZiUHpZNmiy4GyJF86J31WkHd8F0q/
 EoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196841; x=1793801641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8hKOHLjQYw6SSk3eHqSe8KLczL5iiwsi1dTbjAbKap8=;
 b=r5cG+YICSOEVP/v/ax6jfjXe5jodmKeYgWxmDTLl6PWneL48pKXlKSxrr8j0DkTkU8
 awrUVHMwI4dIqrOtyJN9L1o/JVPRaBmPbtzgXBeOFHG/c2IJnMoJW2wpShJ+AVUkiPgM
 Cs6MWPf/1NMEkRfTtBZju0cekC15vxyJtDHFd1XqG67sliHA7WBYd4bbIHjr2S3HcYyy
 4ExIgMFkY10q4vKYkPuiOFsPtKvqP/K4HUUjzdMaBYjCndArPj2CaNd1jXOXmwA8hM/E
 oRamLqMDVzbTPklIpen4qx7Zm21H2ROtzmHHfclQtwJskfK1y5q96A/i7HYeqDDZYh3q
 Ww3g==
X-Gm-Message-State: AFq9FYKJkna/6BFTlDJK8TA9R6Ko/4zq/BS6iVSpwhmj6v78AS50Uivu
 vW4/ut9Ri7fjjhmJcnatYBeQ5Qnu8hLEzx/fVMNCaNBCoIm51AZcD9Mcwfw/qRy9hJGLJ/XIY1A
 +HhgP
X-Gm-Gg: AYBFou1k2G9yiqpVklk0OHrTqj0Fcb5g6dAKd3k2X3GYJ8PASu+oQey+eYh/cbNCpJE
 Pqo34Y/Ln0H3nPJOt4NbIz3vZkgvypPXX4DqqLjlkMZyMT2G4zlIXz+r06Dj7GZCtsFWhzIhN3+
 Q0mmivOU83GWcNpceDrAYWSoxJeWgRITJb+94zyIH3Q7tVvpXJv0SVBzaRJPYeUdDWOTtpynffj
 R4jkWJu5ANn9loBxKHpRbt/uuOKAwSEgjqcv/B8/qjpWlFv/xal7KG8FCyYhK0JkkOLOU9q3heS
 ohMuEXRVA0W7P0RtcMDUCupyw1rL9aSm1qOjGHtBMd+n3IX4PjUOXuBpjaN1mmA1/KQuSCnI5aA
 rYlTBxUAygGS9WICd5HO7LKAO5Avi8yJ5jCRCgsKRgVjeDxHEww5/4fOSo6sFFOSVv13srjkwEs
 oYFcp/Qi1neprUPsen6z3W+LbCkI832YM6PsI0F7edsg8HXPuOOMcKCFvPe32eQfelDPWqQNv82
 ke1ilIM25NDzmAi7Fgwj9jdfHomZi8W5y/ejBKGtDvQE1+MOSmL2NT8hLM6Ft1jxCKTqZw4S+PU
 MzySXnuRzzhFJwPNAdNX5IjKfzEbu8LbCM8RM8bzoxL6XY9FbBuKJe1dc57oU9LOkuEHJx/wZYl
 LhqH7ixuaKw==
X-Received: by 2002:a17:907:7754:b0:c2d:bbae:703b with SMTP id
 a640c23a62f3a-c49bde4d5bcmr217019466b.2.1793196840900; 
 Wed, 28 Oct 2026 07:14:00 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524271sm628414666b.35.2026.10.28.07.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:14:00 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 51/63] usb: dwc3: import from kernel v6.6
Date: Wed, 28 Oct 2026 15:09:17 +0100
Message-ID: <20261028140930.3025368-52-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.5 to v6.6.

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

List of commits: git log --oneline v6.5..v6.6
Commits imported:
8bea147dfdf8 usb: dwc3: Soft reset phy on probe for host
8d1de0ebce71 usb: dwc3: remove unnecessary platform_set_drvdata()
3609699c32aa usb: dwc3-am62: Rename private data

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c      | 39 ++++++++++++++-
 drivers/usb/dwc3/dwc3-am62.c | 96 ++++++++++++++++++------------------
 2 files changed, 85 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9c6bf054f15d..343d2570189f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -279,9 +279,46 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	 * XHCI driver will reset the host block. If dwc3 was configured for
 	 * host-only mode or current role is host, then we can return early.
 	 */
-	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
+	/*
+	 * If the dr_mode is host and the dwc->current_dr_role is not the
+	 * corresponding DWC3_GCTL_PRTCAP_HOST, then the dwc3_core_init_mode
+	 * isn't executed yet. Ensure the phy is ready before the controller
+	 * updates the GCTL.PRTCAPDIR or other settings by soft-resetting
+	 * the phy.
+	 *
+	 * Note: GUSB3PIPECTL[n] and GUSB2PHYCFG[n] are port settings where n
+	 * is port index. If this is a multiport host, then we need to reset
+	 * all active ports.
+	 */
+	if (dwc->dr_mode == USB_DR_MODE_HOST) {
+		u32 usb3_port;
+		u32 usb2_port;
+
+		usb3_port = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+		usb3_port |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
+
+		usb2_port = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		usb2_port |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
+
+		/* Small delay for phy reset assertion */
+		usleep_range(1000, 2000);
+
+		usb3_port &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
+
+		usb2_port &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
+
+		/* Wait for clock synchronization */
+		msleep(50);
+		return 0;
+	}
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg |= DWC3_DCTL_CSFTRST;
 	reg &= ~DWC3_DCTL_RUN_STOP;
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 1755f2f848c5..90a587bc29b7 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -102,7 +102,7 @@
 
 #define DWC3_AM62_AUTOSUSPEND_DELAY	100
 
-struct dwc3_data {
+struct dwc3_am62 {
 	struct device *dev;
 	void __iomem *usbss;
 	struct clk *usb2_refclk;
@@ -129,19 +129,19 @@ static const int dwc3_ti_rate_table[] = {	/* in KHZ */
 	52000,
 };
 
-static inline u32 dwc3_ti_readl(struct dwc3_data *data, u32 offset)
+static inline u32 dwc3_ti_readl(struct dwc3_am62 *am62, u32 offset)
 {
-	return readl((data->usbss) + offset);
+	return readl((am62->usbss) + offset);
 }
 
-static inline void dwc3_ti_writel(struct dwc3_data *data, u32 offset, u32 value)
+static inline void dwc3_ti_writel(struct dwc3_am62 *am62, u32 offset, u32 value)
 {
-	writel(value, (data->usbss) + offset);
+	writel(value, (am62->usbss) + offset);
 }
 
-static int phy_syscon_pll_refclk(struct dwc3_data *data)
+static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 {
-	struct device *dev = data->dev;
+	struct device *dev = am62->dev;
 	struct device_node *node = dev->of_node;
 	struct of_phandle_args args;
 	struct regmap *syscon;
@@ -153,16 +153,16 @@ static int phy_syscon_pll_refclk(struct dwc3_data *data)
 		return PTR_ERR(syscon);
 	}
 
-	data->syscon = syscon;
+	am62->syscon = syscon;
 
 	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-phy-pll-refclk", 1,
 					       0, &args);
 	if (ret)
 		return ret;
 
-	data->offset = args.args[0];
+	am62->offset = args.args[0];
 
-	ret = regmap_update_bits(data->syscon, data->offset, PHY_PLL_REFCLK_MASK, data->rate_code);
+	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_PLL_REFCLK_MASK, am62->rate_code);
 	if (ret) {
 		dev_err(dev, "failed to set phy pll reference clock rate\n");
 		return ret;
@@ -175,32 +175,32 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
-	struct dwc3_data *data;
+	struct dwc3_am62 *am62;
 	int i, ret;
 	unsigned long rate;
 	u32 reg;
 
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
+	am62 = devm_kzalloc(dev, sizeof(*am62), GFP_KERNEL);
+	if (!am62)
 		return -ENOMEM;
 
-	data->dev = dev;
-	platform_set_drvdata(pdev, data);
+	am62->dev = dev;
+	platform_set_drvdata(pdev, am62);
 
-	data->usbss = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(data->usbss)) {
+	am62->usbss = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(am62->usbss)) {
 		dev_err(dev, "can't map IOMEM resource\n");
-		return PTR_ERR(data->usbss);
+		return PTR_ERR(am62->usbss);
 	}
 
-	data->usb2_refclk = devm_clk_get(dev, "ref");
-	if (IS_ERR(data->usb2_refclk)) {
+	am62->usb2_refclk = devm_clk_get(dev, "ref");
+	if (IS_ERR(am62->usb2_refclk)) {
 		dev_err(dev, "can't get usb2_refclk\n");
-		return PTR_ERR(data->usb2_refclk);
+		return PTR_ERR(am62->usb2_refclk);
 	}
 
 	/* Calculate the rate code */
-	rate = clk_get_rate(data->usb2_refclk);
+	rate = clk_get_rate(am62->usb2_refclk);
 	rate /= 1000;	// To KHz
 	for (i = 0; i < ARRAY_SIZE(dwc3_ti_rate_table); i++) {
 		if (dwc3_ti_rate_table[i] == rate)
@@ -212,20 +212,20 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	data->rate_code = i;
+	am62->rate_code = i;
 
 	/* Read the syscon property and set the rate code */
-	ret = phy_syscon_pll_refclk(data);
+	ret = phy_syscon_pll_refclk(am62);
 	if (ret)
 		return ret;
 
 	/* VBUS divider select */
-	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
-	reg = dwc3_ti_readl(data, USBSS_PHY_CONFIG);
-	if (data->vbus_divider)
+	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
+	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);
+	if (am62->vbus_divider)
 		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
 
-	dwc3_ti_writel(data, USBSS_PHY_CONFIG, reg);
+	dwc3_ti_writel(am62, USBSS_PHY_CONFIG, reg);
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -233,7 +233,7 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	 * Don't ignore its dependencies with its children
 	 */
 	pm_suspend_ignore_children(dev, false);
-	clk_prepare_enable(data->usb2_refclk);
+	clk_prepare_enable(am62->usb2_refclk);
 	pm_runtime_get_noresume(dev);
 
 	ret = of_platform_populate(node, NULL, NULL, dev);
@@ -243,9 +243,9 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	}
 
 	/* Set mode valid bit to indicate role is valid */
-	reg = dwc3_ti_readl(data, USBSS_MODE_CONTROL);
+	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
 	reg |= USBSS_MODE_VALID;
-	dwc3_ti_writel(data, USBSS_MODE_CONTROL, reg);
+	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
 
 	/* Device has capability to wakeup system from sleep */
 	device_set_wakeup_capable(dev, true);
@@ -261,7 +261,7 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	return 0;
 
 err_pm_disable:
-	clk_disable_unprepare(data->usb2_refclk);
+	clk_disable_unprepare(am62->usb2_refclk);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 	return ret;
@@ -278,36 +278,34 @@ static int dwc3_ti_remove_core(struct device *dev, void *c)
 static void dwc3_ti_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct dwc3_data *data = platform_get_drvdata(pdev);
+	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
 	u32 reg;
 
 	device_for_each_child(dev, NULL, dwc3_ti_remove_core);
 
 	/* Clear mode valid bit */
-	reg = dwc3_ti_readl(data, USBSS_MODE_CONTROL);
+	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
 	reg &= ~USBSS_MODE_VALID;
-	dwc3_ti_writel(data, USBSS_MODE_CONTROL, reg);
+	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
 
 	pm_runtime_put_sync(dev);
-	clk_disable_unprepare(data->usb2_refclk);
+	clk_disable_unprepare(am62->usb2_refclk);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-
-	platform_set_drvdata(pdev, NULL);
 }
 
 #ifdef CONFIG_PM
 static int dwc3_ti_suspend_common(struct device *dev)
 {
-	struct dwc3_data *data = dev_get_drvdata(dev);
+	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
 	u32 reg, current_prtcap_dir;
 
 	if (device_may_wakeup(dev)) {
-		reg = dwc3_ti_readl(data, USBSS_CORE_STAT);
+		reg = dwc3_ti_readl(am62, USBSS_CORE_STAT);
 		current_prtcap_dir = (reg & USBSS_CORE_OPERATIONAL_MODE_MASK)
 				     >> USBSS_CORE_OPERATIONAL_MODE_SHIFT;
 		/* Set wakeup config enable bits */
-		reg = dwc3_ti_readl(data, USBSS_WAKEUP_CONFIG);
+		reg = dwc3_ti_readl(am62, USBSS_WAKEUP_CONFIG);
 		if (current_prtcap_dir == DWC3_GCTL_PRTCAP_HOST) {
 			reg = USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
 		} else {
@@ -317,30 +315,30 @@ static int dwc3_ti_suspend_common(struct device *dev)
 			 * and in U2/L3 state else it causes spurious wake-up.
 			 */
 		}
-		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, reg);
+		dwc3_ti_writel(am62, USBSS_WAKEUP_CONFIG, reg);
 		/* clear wakeup status so we know what caused the wake up */
-		dwc3_ti_writel(data, USBSS_WAKEUP_STAT, USBSS_WAKEUP_STAT_CLR);
+		dwc3_ti_writel(am62, USBSS_WAKEUP_STAT, USBSS_WAKEUP_STAT_CLR);
 	}
 
-	clk_disable_unprepare(data->usb2_refclk);
+	clk_disable_unprepare(am62->usb2_refclk);
 
 	return 0;
 }
 
 static int dwc3_ti_resume_common(struct device *dev)
 {
-	struct dwc3_data *data = dev_get_drvdata(dev);
+	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
 	u32 reg;
 
-	clk_prepare_enable(data->usb2_refclk);
+	clk_prepare_enable(am62->usb2_refclk);
 
 	if (device_may_wakeup(dev)) {
 		/* Clear wakeup config enable bits */
-		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, USBSS_WAKEUP_CFG_NONE);
+		dwc3_ti_writel(am62, USBSS_WAKEUP_CONFIG, USBSS_WAKEUP_CFG_NONE);
 	}
 
-	reg = dwc3_ti_readl(data, USBSS_WAKEUP_STAT);
-	data->wakeup_stat = reg;
+	reg = dwc3_ti_readl(am62, USBSS_WAKEUP_STAT);
+	am62->wakeup_stat = reg;
 
 	return 0;
 }
-- 
2.53.0

