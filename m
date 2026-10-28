Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FEF606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f4DgBQbX;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EhLjffRq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3A0081463;
	Wed, 28 Oct 2026 14:48:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QiWZHl2TTyEs; Wed, 28 Oct 2026 14:48:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E5A0D810BF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198854;
	b=H8YKkdHLSkVKKAj7rpldxRgjfL5FotaByIiyMzu6yEfadyGqCPsh1bw4o2J5koOeehuI
	 UJwpfYHX2UJcE3AjlvubSXyYyqXvsZBRBMDZ0nlATcIQ/IxHJBVp+0VgVPY7o/TOWeueY
	 VYBmFX3x74zUHyN51vIkPBQj1iObKaeGuq+OvEHcpohYQV0K7fIw8jWqwOBPON9AvrmF3
	 kFGCoUNkgXEbuJW5XNxbbWqd+PIZrgUutBM2X9rUMUXhWO3gv5SJvT4R6A1q0+YDHeb4m
	 xGOwZCF61ATHrdHN1mzGg1lLa0VVHoIvwRELxfqCxb/kCuyx+wMOGAxG7mfvuiG29eA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198854;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cjkSY9ckpShkZnLNCnJjpYPklai5ywPag4x7OSWM6tY=;
	b=gb20zNHMKEOh9B9m8drQro1Ny223J1243n0v3fNv1JDnq+D/UAHce3u4iOIfBPwF0zS1
	 TilBjXh71bUYWVuNfnWIPYp70eg0E9nRoQPOkbzfoKzS6JAuI4xrISv+6TGDERDRujU+3
	 d2BW4J0JhUNtSabo9RH+sCvN2xf34gF4uRPXllSCpGYJonXeJSeTAkW0RbFO8g7cE/V17
	 MZdEWQ8xsMC3Ry4wzsWy7u4YtiD7eWVl1Qm8LMU54Fq41JVpUeQ+2NY5/TIB2AQSNTTzp
	 eoiywO4Z6aiBf1doFuEXPMKs8e8eUXXX4myKAv6/AMB8YtFIaNi5xrMYhU3dHHvki3g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198854;
	bh=cjkSY9ckpShkZnLNCnJjpYPklai5ywPag4x7OSWM6tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f4DgBQbXYXzEGkMwSIRgWvzNcThcMU/qpTC1Ugcr6xgl89C7x2RZOrAd4HRsJ91AK
	 RDe+qNlttpCcpBdnX/rY/UrtQL1EBGp1zQUlPIpGuyuKRjxFPSBAx/H66wCwpcmsYS
	 YEeyBn6VdpvEqQ42ytWFSeygRCKAEUJrO19FgcEZrD7CTY3xvEEusCoG6gNeBerj2X
	 7Ju80xKzOyCS7a9Yalef35ss9i/nGrj32aINwt4q2SlUeBTSgOcI/5ptlXc+jwSrUU
	 sBbVbnnskRrukFbqWeBsNQonqpbHpfd2YNWffolaPShVyKdmv8mmcM0PKeBdFygXKJ
	 4rbNks0QJ+26A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5A0D810BF;
	Wed, 28 Oct 2026 14:47:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 50F24972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35C226060A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QW5VOATBRu22 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:14:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7E934605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196847;
 b=Ph1P5yz8qXbpu2xbjnEgglqwPFio4Dt+SlLN/vYHnYWb2KMR3mHsmcmFd4brKl2xjxGe
 4XwpVdLvugfM5PAy1L8dNciU7hjScJnenh2fOivudPxyVGaU3Jaon1V9iSTw42pPkFYwQ
 qA2xVNfvJf0uBjX903BVNY4IOQeBmD+mY693w/F6u42drK6D5mVBvvMtwS6qBCQcj8g8Y
 iIfb9sQSQGTizCWpd1MaXxF2Uh3/0irgSW0PQ6EIWt58KNMiA2XfvbgM+ZCMopHEoXEdp
 mOz/56hGEry25qM69vaUkhU1HygJnsYUvNGDA1vUvC4MOb08MATVV/1lJKMszDClVhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196847;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=cjkSY9ckpShkZnLNCnJjpYPklai5ywPag4x7OSWM6tY=;
 b=QmyQHadUS2bvTjCWrqfDWUQwBHbt/wySVM8V5XFrKkQGNnpwDSU8eRUdnr8adtxyIo7u
 6kuy1bBJkn/8HQxeytbzHe8YWvjTYffl+nyXyQO4Sa5d8432Z+UlP5qabbzolu6/3/5PG
 ebSMqUY0jzb1g8PipAnDTSPMNWJMzpjRI2+MJ5LNFN21i2uLFRbJwNbP54ZjFX6OHcGs+
 hXoKZRzayUJkvkELBfGQwQuCFuqIXslIBJeNePLcZeKXOV3rf26Cv7JGFp7421dlHdTIQ
 YwTI2C23ZbmmxNeHqVZPZ2WRlG77L8wAbpoyJUBVpdRi5g+ZgUsSzTYIHbae2Uq+EvQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EhLjffRq; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=EhLjffRq
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E934605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:06 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c40aa03a96fso11237166b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196844; x=1793801644;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cjkSY9ckpShkZnLNCnJjpYPklai5ywPag4x7OSWM6tY=;
 b=EhLjffRqI1D6Z0QQya2MyJjxxHJ7tCm8OeYHfcAXqu6sop0yaxnA/fMdQxcg+qWLPv
 bmGLUX0i+obdq9Tsza05wppa7LJ9fQqeOfy4C9z6N+9FpQM3hmENNIJdxYLap/c7sGbM
 51eUXyANaq3NEJwWHChDMiD6vD5lf3Dj61VGH3zF++KxpGMRdPAC5wTIxCcIy9kzKQ0E
 5n8J8lRTeDe/tbV+XA/a8L83LqmPI94Ckm2+KAlPm+EsXtEUwTcaozneRNXm4nkfYeL3
 lUSxzWGMBNbRArMMr494sSTIB6B4W3oLg8Tj+aoHRMjvOYZ/3hmivMM19fFnYgSu7Wz5
 p5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196844; x=1793801644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cjkSY9ckpShkZnLNCnJjpYPklai5ywPag4x7OSWM6tY=;
 b=wpNZUgDnaIGC3Axht5XJ3zFUz1l5cAw2ZQoAnlC7kHsndgCV4ODEAIbsYDI2tz9An+
 0CEZrpKh6JQdiptHPq2JVxkl8J7KVdRL356UsvlQWB0CYb5yR/n7YyEbXXIMPoO0XsA+
 NH/6QKlRisObxCRPH1uNvqdy9NewxN7wM0JjSmH6CMvBV3l/0kvlXIiR7v7Bjm9V73uZ
 0lSeeHc1NTUTZrxWFKAmpcmX1WnHeMiAICDIsIlrlQf2a3Cqw7ISSwkSn7rQza7QVocS
 FumdC+6IEAQdabE0pO8OGGCUWzxPTXC/7K4f8HlQ8jlFh+gzEi4+/+pUCosMQ73r+VD3
 mu9w==
X-Gm-Message-State: AFq9FYJiIe+pHkOCONEWEmFHz+Gtu+BQf0MW71WqhZg5zzuQeFo8bgR5
 5eSkTzoH0UwYbpw0vH9Iv8aD+8dS7+7gPYDdI41e4vTryKCRGz5s4kLcQTNb/K32/aMNf36LyhU
 QhtJD
X-Gm-Gg: AYBFou1E+iLjc+J0hKxwB3cYTY8QIYRl2L4F908ShvMLj4eYzNpChXrW2hNTobhbQj7
 ZgJ1mQGoiOPzOO3WmAcAjddSeqI9qe5JjsfB2tSMlm16elGTFSPtNgwc81vzfxEh3M7gQnN8aJp
 Rhsr1oeBSU7hgK+qdFoH9xo4E8J4guCAJ0+qvU9k/qH+RkNGPU7uPw8xnCmB3EO3FnGGybED0Yv
 GJ+Wdvy6Bc6Wm9BGJdpA3+cwMKUWsvxYX4Hmds1IUwxODV7/ZT7B7Oyrz6ESS/E0VpQSGnIqUcA
 +yWNp1K1h7Hw7jX9TkNz0O5UhficHQQcCmEKjP+LdqI7xrJg/DBOPnQwQ6FiogduUC3EiVQBy/O
 We9yNXMlV2xkUVlmG75h7p+MB2g/MfH4A2AWKEWt3ohC0nBaxoac0oX5T6jzxz3J4aLhOp9EtIc
 ks19u5JhH4qs3J4hLR/AGbF/1dea2+d9l51KpqvcQsJpuh14tCxCJdYifU2yB6VGCxgk1dDTP/S
 jwx3op0H9Ng5rg+R/Hmn9mxIBh4DLEgSJPialS/hdzl+BIWURITyZ42Oa1PYk3/toNBDa/8Bk/c
 p4PIvL17Cehr21csvZVGQiLLX7Ycl6jiUhPhZrPQyuC5dl5Xi4F0rxkzfT3K0K2+oOUwrPBD8ZH
 s80X0qCOBu51af9h5ePhGrQCFu92Kbig=
X-Received: by 2002:a17:906:5192:10b0:c40:5ee3:8694 with SMTP id
 a640c23a62f3a-c49bdee7e16mr262284366b.4.1793196844259; 
 Wed, 28 Oct 2026 07:14:04 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524271sm628414666b.35.2026.10.28.07.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:14:03 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 54/63] usb: dwc3: import from kernel v6.9
Date: Wed, 28 Oct 2026 15:09:20 +0100
Message-ID: <20261028140930.3025368-55-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.8 to v6.9.

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

List of commits: git log --oneline v6.8..v6.9
Commits imported:
6d735722063a usb: dwc3: core: Prevent phy suspend during init
f2e0eee47038 usb: dwc3: ep0: Don't reset resource alloc flag
f9aa41130ac6 usb: dwc3: Properly set system wakeup
1e43c86d84fb usb: dwc3: core: Add DWC31 version 2.00a controller
f0b9c578408e usb: dwc3-am62: add workaround for Errata i2409
d78ff37567c9 usb: dwc3-am62: Fix PHY core voltage selection
4ead695e6b3c usb: dwc3-am62: Disable wakeup at remove
6661befe4100 usb: dwc3-am62: fix module unload/reload behavior
a6ba1e453174 usb: dwc3: apply snps,host-vbus-glitches workaround unconditionally
50c72a46eb41 usb: dwc3: gadget: Remove redundant assignment to pointer trb
b311048c174d usb: dwc3: gadget: Rewrite endpoint allocation flow
2d2a3349521d usb: dwc3: Add workaround for host mode VBUS glitch when boot

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c      |  92 ++++++++++++++-----------------
 drivers/usb/dwc3/core.h      |   5 ++
 drivers/usb/dwc3/dwc3-am62.c |  42 ++++++++++----
 drivers/usb/dwc3/ep0.c       |   4 +-
 drivers/usb/dwc3/gadget.c    | 103 +++++++++++++++++------------------
 drivers/usb/dwc3/gadget.h    |   1 +
 6 files changed, 130 insertions(+), 117 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3e55838c0001..100041320e8d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -104,6 +104,27 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 	return 0;
 }
 
+void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	if (enable && !dwc->dis_u3_susphy_quirk)
+		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+	else
+		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
+
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	if (enable && !dwc->dis_u2_susphy_quirk)
+		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+	else
+		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+}
+
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
@@ -585,11 +606,8 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
  */
 static int dwc3_phy_setup(struct dwc3 *dwc)
 {
-	unsigned int hw_mode;
 	u32 reg;
 
-	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
-
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
 	/*
@@ -599,21 +617,16 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	reg &= ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
 
 	/*
-	 * Above 1.94a, it is recommended to set DWC3_GUSB3PIPECTL_SUSPHY
-	 * to '0' during coreConsultant configuration. So default value
-	 * will be '0' when the core is reset. Application needs to set it
-	 * to '1' after the core initialization is completed.
-	 */
-	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
-		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
-
-	/*
-	 * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be cleared after
-	 * power-on reset, and it can be set after core initialization, which is
-	 * after device soft-reset during initialization.
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB3PIPECTL_SUSPHY to '0' during coreConsultant configuration.
+	 * So default value will be '0' when the core is reset. Application
+	 * needs to set it to '1' after the core initialization is completed.
+	 *
+	 * Similarly for DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be
+	 * cleared after power-on reset, and it can be set after core
+	 * initialization.
 	 */
-	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
-		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
+	reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
 	if (dwc->u2ss_inp3_quirk)
 		reg |= DWC3_GUSB3PIPECTL_U2SSINP3OK;
@@ -639,9 +652,6 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->tx_de_emphasis_quirk)
 		reg |= DWC3_GUSB3PIPECTL_TX_DEEPH(dwc->tx_de_emphasis);
 
-	if (dwc->dis_u3_susphy_quirk)
-		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
-
 	if (dwc->dis_del_phy_power_chg_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
 
@@ -689,24 +699,15 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	}
 
 	/*
-	 * Above 1.94a, it is recommended to set DWC3_GUSB2PHYCFG_SUSPHY to
-	 * '0' during coreConsultant configuration. So default value will
-	 * be '0' when the core is reset. Application needs to set it to
-	 * '1' after the core initialization is completed.
-	 */
-	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
-		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
-
-	/*
-	 * For DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared after
-	 * power-on reset, and it can be set after core initialization, which is
-	 * after device soft-reset during initialization.
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB2PHYCFG_SUSPHY to '0' during coreConsultant configuration.
+	 * So default value will be '0' when the core is reset. Application
+	 * needs to set it to '1' after the core initialization is completed.
+	 *
+	 * Similarly for DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared
+	 * after power-on reset, and it can be set after core initialization.
 	 */
-	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
-
-	if (dwc->dis_u2_susphy_quirk)
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
 	if (dwc->dis_enblslpm_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
@@ -1227,21 +1228,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err_exit_phy;
 
-	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
-	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
-		if (!dwc->dis_u3_susphy_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
-		}
-
-		if (!dwc->dis_u2_susphy_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-		}
-	}
-
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
 
@@ -1519,6 +1505,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	else
 		dwc->sysdev = dwc->dev;
 
+	dwc->sys_wakeup = device_may_wakeup(dwc->sysdev);
+
 	ret = device_property_read_string(dev, "usb-psy-name", &usb_psy_name);
 	if (ret >= 0) {
 		dwc->usb_psy = power_supply_get_by_name(usb_psy_name);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e120611a5174..180dd8d29287 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -755,6 +755,7 @@ struct dwc3_ep {
 #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
 #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
 #define DWC3_EP_DELAY_STOP             BIT(13)
+#define DWC3_EP_RESOURCE_ALLOCATED	BIT(14)
 
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN			BIT(31)
@@ -1132,6 +1133,7 @@ struct dwc3_scratchpad_array {
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
  * @dis_split_quirk: set to disable split boundary.
+ * @sys_wakeup: set if the device may do system wakeup.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
  * @imod_interval: set the interrupt moderation interval in 250ns
@@ -1257,6 +1259,7 @@ struct dwc3 {
 #define DWC31_REVISION_170A	0x3137302a
 #define DWC31_REVISION_180A	0x3138302a
 #define DWC31_REVISION_190A	0x3139302a
+#define DWC31_REVISION_200A	0x3230302a
 
 #define DWC32_REVISION_ANY	0x0
 #define DWC32_REVISION_100A	0x3130302a
@@ -1355,6 +1358,7 @@ struct dwc3 {
 
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
+	unsigned		sys_wakeup:1;
 	unsigned		wakeup_configured:1;
 	unsigned		suspended:1;
 
@@ -1576,6 +1580,7 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc);
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
 
 int dwc3_core_soft_reset(struct dwc3 *dwc);
+void dwc3_enable_susphy(struct dwc3 *dwc, bool enable);
 
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 90a587bc29b7..fad151e78fd6 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -97,9 +97,15 @@
 #define USBSS_VBUS_STAT_SESSVALID	BIT(2)
 #define USBSS_VBUS_STAT_VBUSVALID	BIT(0)
 
-/* Mask for PHY PLL REFCLK */
+/* USB_PHY_CTRL register bits in CTRL_MMR */
+#define PHY_CORE_VOLTAGE_MASK	BIT(31)
 #define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
 
+/* USB PHY2 register offsets */
+#define	USB_PHY_PLL_REG12		0x130
+#define	USB_PHY_PLL_LDO_REF_EN		BIT(5)
+#define	USB_PHY_PLL_LDO_REF_EN_EN	BIT(4)
+
 #define DWC3_AM62_AUTOSUSPEND_DELAY	100
 
 struct dwc3_am62 {
@@ -162,6 +168,13 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 
 	am62->offset = args.args[0];
 
+	/* Core voltage. PHY_CORE_VOLTAGE bit Recommended to be 0 always */
+	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_CORE_VOLTAGE_MASK, 0);
+	if (ret) {
+		dev_err(dev, "failed to set phy core voltage\n");
+		return ret;
+	}
+
 	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_PLL_REFCLK_MASK, am62->rate_code);
 	if (ret) {
 		dev_err(dev, "failed to set phy pll reference clock rate\n");
@@ -176,8 +189,9 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
 	struct dwc3_am62 *am62;
-	int i, ret;
 	unsigned long rate;
+	void __iomem *phy;
+	int i, ret;
 	u32 reg;
 
 	am62 = devm_kzalloc(dev, sizeof(*am62), GFP_KERNEL);
@@ -219,6 +233,17 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Workaround Errata i2409 */
+	phy = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
+		phy = NULL;
+	} else {
+		reg = readl(phy + USB_PHY_PLL_REG12);
+		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
+		writel(reg, phy + USB_PHY_PLL_REG12);
+	}
+
 	/* VBUS divider select */
 	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
 	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);
@@ -267,21 +292,15 @@ err_pm_disable:
 	return ret;
 }
 
-static int dwc3_ti_remove_core(struct device *dev, void *c)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	platform_device_unregister(pdev);
-	return 0;
-}
-
 static void dwc3_ti_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
 	u32 reg;
 
-	device_for_each_child(dev, NULL, dwc3_ti_remove_core);
+	pm_runtime_get_sync(dev);
+	device_init_wakeup(dev, false);
+	of_platform_depopulate(dev);
 
 	/* Clear mode valid bit */
 	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
@@ -289,7 +308,6 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
 
 	pm_runtime_put_sync(dev);
-	clk_disable_unprepare(am62->usb2_refclk);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 }
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 6ae8a36f21cf..d96ffbe52039 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -226,7 +226,8 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 
 	/* reinitialize physical ep1 */
 	dep = dwc->eps[1];
-	dep->flags = DWC3_EP_ENABLED;
+	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags |= DWC3_EP_ENABLED;
 
 	/* stall is always issued on EP0 */
 	dep = dwc->eps[0];
@@ -646,6 +647,7 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 		return -EINVAL;
 
 	case USB_STATE_ADDRESS:
+		dwc3_gadget_start_config(dwc, 2);
 		dwc3_gadget_clear_tx_fifos(dwc);
 
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 28f49400f3e8..f94f68f1e7d2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -519,77 +519,56 @@ static void dwc3_free_trb_pool(struct dwc3_ep *dep)
 static int dwc3_gadget_set_xfer_resource(struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
+	int ret;
+
+	if (dep->flags & DWC3_EP_RESOURCE_ALLOCATED)
+		return 0;
 
 	memset(&params, 0x00, sizeof(params));
 
 	params.param0 = DWC3_DEPXFERCFG_NUM_XFER_RES(1);
 
-	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETTRANSFRESOURCE,
+	ret = dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETTRANSFRESOURCE,
 			&params);
+	if (ret)
+		return ret;
+
+	dep->flags |= DWC3_EP_RESOURCE_ALLOCATED;
+	return 0;
 }
 
 /**
- * dwc3_gadget_start_config - configure ep resources
- * @dep: endpoint that is being enabled
- *
- * Issue a %DWC3_DEPCMD_DEPSTARTCFG command to @dep. After the command's
- * completion, it will set Transfer Resource for all available endpoints.
- *
- * The assignment of transfer resources cannot perfectly follow the data book
- * due to the fact that the controller driver does not have all knowledge of the
- * configuration in advance. It is given this information piecemeal by the
- * composite gadget framework after every SET_CONFIGURATION and
- * SET_INTERFACE. Trying to follow the databook programming model in this
- * scenario can cause errors. For two reasons:
- *
- * 1) The databook says to do %DWC3_DEPCMD_DEPSTARTCFG for every
- * %USB_REQ_SET_CONFIGURATION and %USB_REQ_SET_INTERFACE (8.1.5). This is
- * incorrect in the scenario of multiple interfaces.
- *
- * 2) The databook does not mention doing more %DWC3_DEPCMD_DEPXFERCFG for new
- * endpoint on alt setting (8.1.6).
- *
- * The following simplified method is used instead:
+ * dwc3_gadget_start_config - reset endpoint resources
+ * @dwc: pointer to the DWC3 context
+ * @resource_index: DEPSTARTCFG.XferRscIdx value (must be 0 or 2)
  *
- * All hardware endpoints can be assigned a transfer resource and this setting
- * will stay persistent until either a core reset or hibernation. So whenever we
- * do a %DWC3_DEPCMD_DEPSTARTCFG(0) we can go ahead and do
- * %DWC3_DEPCMD_DEPXFERCFG for every hardware endpoint as well. We are
- * guaranteed that there are as many transfer resources as endpoints.
+ * Set resource_index=0 to reset all endpoints' resources allocation. Do this as
+ * part of the power-on/soft-reset initialization.
  *
- * This function is called for each endpoint when it is being enabled but is
- * triggered only when called for EP0-out, which always happens first, and which
- * should only happen in one of the above conditions.
+ * Set resource_index=2 to reset only non-control endpoints' resources. Do this
+ * on receiving the SET_CONFIGURATION request or hibernation resume.
  */
-static int dwc3_gadget_start_config(struct dwc3_ep *dep)
+int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
 {
 	struct dwc3_gadget_ep_cmd_params params;
-	struct dwc3		*dwc;
 	u32			cmd;
 	int			i;
 	int			ret;
 
-	if (dep->number)
-		return 0;
+	if (resource_index != 0 && resource_index != 2)
+		return -EINVAL;
 
 	memset(&params, 0x00, sizeof(params));
 	cmd = DWC3_DEPCMD_DEPSTARTCFG;
-	dwc = dep->dwc;
+	cmd |= DWC3_DEPCMD_PARAM(resource_index);
 
-	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	ret = dwc3_send_gadget_ep_cmd(dwc->eps[0], cmd, &params);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
-		struct dwc3_ep *dep = dwc->eps[i];
-
-		if (!dep)
-			continue;
-
-		ret = dwc3_gadget_set_xfer_resource(dep);
-		if (ret)
-			return ret;
-	}
+	/* Reset resource allocation flags */
+	for (i = resource_index; i < dwc->num_eps && dwc->eps[i]; i++)
+		dwc->eps[i]->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
 
 	return 0;
 }
@@ -884,16 +863,18 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 		ret = dwc3_gadget_resize_tx_fifos(dep);
 		if (ret)
 			return ret;
-
-		ret = dwc3_gadget_start_config(dep);
-		if (ret)
-			return ret;
 	}
 
 	ret = dwc3_gadget_set_ep_config(dep, action);
 	if (ret)
 		return ret;
 
+	if (!(dep->flags & DWC3_EP_RESOURCE_ALLOCATED)) {
+		ret = dwc3_gadget_set_xfer_resource(dep);
+		if (ret)
+			return ret;
+	}
+
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
 		struct dwc3_trb	*trb_st_hw;
 		struct dwc3_trb	*trb_link;
@@ -1047,7 +1028,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	dep->stream_capable = false;
 	dep->type = 0;
-	mask = DWC3_EP_TXFIFO_RESIZED;
+	mask = DWC3_EP_TXFIFO_RESIZED | DWC3_EP_RESOURCE_ALLOCATED;
 	/*
 	 * dwc3_remove_requests() can exit early if DWC3 EP delayed stop is
 	 * set.  Do not clear DEP flags, so that the end transfer command will
@@ -2913,6 +2894,12 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
+	ret = dwc3_gadget_start_config(dwc, 0);
+	if (ret) {
+		dev_err(dwc->dev, "failed to config endpoints\n");
+		return ret;
+	}
+
 	dep = dwc->eps[0];
 	dep->flags = 0;
 	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
@@ -2937,6 +2924,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	dwc3_ep0_out_start(dwc);
 
 	dwc3_gadget_enable_irq(dwc);
+	dwc3_enable_susphy(dwc, true);
 
 	return 0;
 
@@ -2968,6 +2956,9 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	dwc->gadget_driver	= driver;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
+	if (dwc->sys_wakeup)
+		device_wakeup_enable(dwc->sysdev);
+
 	return 0;
 }
 
@@ -2983,6 +2974,9 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	struct dwc3		*dwc = gadget_to_dwc(g);
 	unsigned long		flags;
 
+	if (dwc->sys_wakeup)
+		device_wakeup_disable(dwc->sysdev);
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->gadget_driver	= NULL;
 	dwc->max_cfg_eps = 0;
@@ -3428,7 +3422,7 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 		struct dwc3_request *req, const struct dwc3_event_depevt *event,
 		int status)
 {
-	struct dwc3_trb *trb = &dep->trb_pool[dep->trb_dequeue];
+	struct dwc3_trb *trb;
 	struct scatterlist *sg = req->sg;
 	struct scatterlist *s;
 	unsigned int num_queued = req->num_queued_sgs;
@@ -4664,6 +4658,10 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	else
 		dwc3_gadget_set_speed(dwc->gadget, dwc->maximum_speed);
 
+	/* No system wakeup if no gadget driver bound */
+	if (dwc->sys_wakeup)
+		device_wakeup_disable(dwc->sysdev);
+
 	return 0;
 
 err5:
@@ -4693,6 +4691,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
 
+	dwc3_enable_susphy(dwc, false);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
 	usb_put_gadget(dwc->gadget);
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 55a56cf67d73..d73e735e4081 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -119,6 +119,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
 void dwc3_ep0_send_delayed_status(struct dwc3 *dwc);
 void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt);
+int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index);
 
 /**
  * dwc3_gadget_ep_get_transfer_index - Gets transfer index from HW
-- 
2.53.0

