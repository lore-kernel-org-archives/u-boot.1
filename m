Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C35606A320
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uK1dTC8l;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uRlQ6fHU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D485D811A4;
	Wed, 28 Oct 2026 14:48:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iAwzvPOlYsds; Wed, 28 Oct 2026 14:48:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 00C45811A0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198849;
	b=PEkHs6wxLCuOMzffo2PTg4eqg2fMGZf7CTUFXez1nVlQblxKIYAx22gjtYKo8pjVwJsZ
	 6ThAlyT24AYqu8hJnYKfXMgWIzyjzYhmgRzC/yfH1RXXkodXeR7U6ePyHLvwQnbnvYhGj
	 ++gUwbHQwqNE2oJVL9FmYFNMs6fyfWqDLMdaJ+qh4MjVPQFt9c+VWmf/oYlibVVW/w+wN
	 YF1OJvtIHI+Z5qXwsyJlrX5ySrqam5jnUe9NHFRbFpvmu2ODGksfpkVovERbV9DkcwKHz
	 /nMdI1QSQxmCAa3F+2oCQazCZN4RRZaGNu0lYzEVy10FUlkhDj93E8myTDkRkm+2mfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198849;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7eayOV4Qjmalhx5WjZQS6102iFUKhdrpzSiuN/cLuFk=;
	b=iV3yZGuDK6GHIKTHDlJ5oIExMVzpYf50F+1K5syvxlFL9E1vyO0lrySoBEUdnPVpHhsw
	 4w28Ber7RjXquhksIcktzjPC8qFS2sAlIHpfVi8NvMvXfCOP9eE39J23CGECXFNDzVgHF
	 0hauZ1iGNBlUu5l9ZejEWg9p/+pIg/8wcJp4AaA5Ap3ZkOt4pxmsoP2cP2NGOVhFYj55+
	 bgfb0KS+oDvwlrmRcd02dJZ2+8O5o5U6yvjLexxZQhYZu9kUBcu9l5BF1txLtlYdf1eI2
	 tX4J3dQh53qW9dW0/T9PGKP8HmmJmmyKQmkfhh3/t+jSU7uiK0OXBlLx23kSWvyUePg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198849;
	bh=7eayOV4Qjmalhx5WjZQS6102iFUKhdrpzSiuN/cLuFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uK1dTC8lS/Y2TH3arhXM3AIT1uYgAhJfy/oMN0nPLbdJUO+FQMJIjxqHQ01i0rVd+
	 2A2ssX6WFp1xvPLx4Vhv/UZrmD0rpGl/dKYC+THmmD62Rm1kY3aY40EONzyUNv5WqD
	 utz0Q6yDz8+Q79YGI1GWvygefiNbGIP8S45dKqb5BPqcwK2e8KxmXrPNVpwlnHCFvr
	 8u9c7IWZfKaaJviUHYdEYsNx+E92NjqeDwKyZOJW2ZFFa068z61aEDN2ArSNaXELOQ
	 YuN92KAELcMtLVAuN4VUHY26c2rXqf6iHfhMVVJoc3NiFHbirScGfz1hwa4+eb492X
	 g/L+D6NRx2Y1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00C45811A0;
	Wed, 28 Oct 2026 14:47:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A886380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 106EB605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8x19yx8NiNht for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:14:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E0952605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196844;
 b=sRQbTVNOePEjwgI+MZZGKa0+0OOsedF1RYdCSJitx54jc43dPU90LMtCosNcmQy65hgP
 uuRZKDHSnnOnvc37gL7doB19dWoORXcgmBcBbeUJKzmWl78Mls/LOcZODiBPvdDM/+A9Z
 NIZElPhaQrXTVUzKWAWgLHuD2SPqHhlXlg9374r5jt2J71P+H4DufocKAdEwpYtDNaPYJ
 ttgn0MtQQinKSHEpW2aoOY0GNmIwF+qTnOXitBM7cUS103lfEbVgJvKt+fv1RTRZlDymk
 IgE11UCg+qlbIOQ/kkC373gp3krbmP5G+2m78QdZSP13Ar95cz9Peb6/iERmyHKCYjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196844;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=7eayOV4Qjmalhx5WjZQS6102iFUKhdrpzSiuN/cLuFk=;
 b=WAwkgkL7fOYA4lSArgftVn3+vRalz9pKPV97j4FLFdK2RojcdhI8RHbAjb1fYc6jFtKn
 sQDDRBBmnUB5mKDNnFVwId/Vr5yuW+pELzafcql7++709nXROtsXDnP8U3faAbHJwt0Qs
 Xrun2/NmUFvkSDkUwbIQDE6U5nMOcAoaRZL9KriqKLaDubDdBQFzt+nf8vuTfCz5rO3ao
 XwQuGV/iFN2WiATx8H8KnNgcdoidG4Fc5zmBFDjPJwmjdgzUhvmtxSGKonV7QIryTIPZ0
 SVUOKUUJeUvZTXUhNGWt6py11SVgBoB+yf5aefM3DMhI6GpfBkQfBr8RqrQ0N/yqEFQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=uRlQ6fHU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=uRlQ6fHU
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0952605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:01 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b4584287adso184898a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196840; x=1793801640;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7eayOV4Qjmalhx5WjZQS6102iFUKhdrpzSiuN/cLuFk=;
 b=uRlQ6fHUx3VZOKmmjsknu5nF3gv3OatNj45HR6yP/fE6PbZ6ZMOHa/KYclf6gb90TO
 Lu6sKHu6Lqa4zG9sCW3uEdpKJh94kr3+O5bYOndCeRcvonxWnocBwGAwDsbYRMTkyxD9
 BT8bNSLANAyGlGEWoFdNiRpngLfFBvljmYq+T+D5hbbHyip7sI4+MH/dtvAgUnnSyUxW
 TE0F6ldv3B5D/zVQ/2MGmVE0SeNK4B2KdKcXPnYjOgjpJS+Y/jwoNg2aY3YRo/qDFpok
 i0XjdnS+zgY7ETsXwYW4eTcvVT3+AOTUfQ+hyQuWzXQgX0HZ6MSssee2pBJpr9YnQVZN
 WKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196840; x=1793801640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7eayOV4Qjmalhx5WjZQS6102iFUKhdrpzSiuN/cLuFk=;
 b=TxwmdiQmjGZ+B7+IMLmDwB4y6Y/Y4TRGQC/RvL29pL36Q8c+jgluXNyWroPre4MJgI
 PsBO08RWCJFSB8KtaWX+BNb/YAa5vR9ShhwlIA3RKIginS47dthmeZH8UibmytupXxwN
 tw/ojYfR9nyPcGrBznuZF5xI8AuNV9n5kqXqBcI7abIAL/uwGoswfFA43g+iVM3Ws//F
 O0Ok1BJ3IY4Pjg2+1yN8X/+rcA3OZMhehmBI+dCuUNOdCn3qdDwMaAz0iVqOw8vNYMls
 OCuZXVNTFZrLYcZoy2Rj1E4/+Nrz03o+hh4mzzBeZShwerDOoULS9Elyz9Hy4w5kq1z2
 b9vw==
X-Gm-Message-State: AFq9FYKD2wzEycBzLGpqVGsONynghIMxOU1Q1OFS5vUfFBw6RS7Ek74n
 xOixQGxhz4z60W3A0qwLf8zONAUdU/wRiIuJ1ljp8lbpHqceSWzm3fGi/ehKithpQ2ke9w5/m3m
 3t0J1
X-Gm-Gg: AYBFou1+y+8nAhML2XQm1GEYKU+N02TkJSSVLZCOj8oAHL7weZarvD6XcHwyhCQL1sr
 eZSbB03NUGL5tUgFkhlviVSdmB1qGn7O+Tp9bP8LTUDOiZF+my23s0WrNwcKd/ud4TLC8sAKFo2
 exqo496QYrAn3VoheJNASP5DxqGLnTGQaTM95drhOlhWPZV8Y23peXHWaFx4yrqtsA1F+cewXzp
 yBy0MMHX5VPP7HDuOPqnrK1MNpm2G96SPdpkPPjc8g24ztBI4s2YUjhnQN58Pj/GpyRR74fuyyR
 +vlbOsngpjtJ44XJWcYMJ6TMWD3n9qmkTRVLPKbnOzXsm8l/ScZmmQmrapQCiJOIdiLggYozh1o
 IdTHK6jZxFbKhXeg4MawyKynl0pxeW3yzYKR/Zi/esGLRMuvGiSvubFwWwqg5XBNCgFCywR0uP1
 QbnLmV2rYf90PnYfRVl98r4grO5O4mNLVQzQv8dONHiXQXbl4aNWxklp/pdDwk+Rwb2vrrxMFI8
 CQcNdm2S44JDabtI+05iid7zpBeAeJbPK4bDg8phdnzsFXdMVq8qrOVoukye08FbSHxbS+KqHOv
 ffNAsSAKR2DUL3j1hKwN/MM2v91nmmSlA68+Y+M5iWC1Fpf7gDMTC3azl1+yEuLZUh1C1H5VXUT
 lUHpuIt+YHg==
X-Received: by 2002:a17:907:9543:b0:c2e:8801:9139 with SMTP id
 a640c23a62f3a-c49bdd5a5a5mr217059766b.1.1793196839800; 
 Wed, 28 Oct 2026 07:13:59 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524271sm628414666b.35.2026.10.28.07.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:13:59 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 50/63] usb: dwc3: import from kernel v6.5
Date: Wed, 28 Oct 2026 15:09:16 +0100
Message-ID: <20261028140930.3025368-51-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.4 to v6.5.

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

List of commits: git log --oneline v6.4..v6.5
Commits imported:
3ddaa6a27457 usb: dwc3: Properly handle processing of pending events
734ae15ab95a Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"
e835c0a4e23c usb: dwc3: don't reset device side if dwc3 was configured as host-only
c0aabed9cabe usb: dwc3: gadget: Propagate core init errors to UDC during pullup
b4a4be847184 USB: fix up merge of 6.4-rc4 into usb-next
890258e22117 usb: dwc3-am62: Convert to platform remove callback returning void
0176568702a5 usb: core: Convert to platform remove callback returning void
813f44d57e19 usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens
2f28c3c9c347 usb: dwc3: Add error logs for unknown endpoint events
ec5eb43813a4 usb: dwc3: core: add support for realtek SoCs custom's global register start address

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c      | 37 +++++++++++++++---------------------
 drivers/usb/dwc3/core.h      |  5 ++---
 drivers/usb/dwc3/dwc3-am62.c |  5 ++---
 drivers/usb/dwc3/ep0.c       |  3 +++
 drivers/usb/dwc3/gadget.c    | 22 ++++++++++++++++++---
 5 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d68958e151a7..9c6bf054f15d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -277,9 +277,9 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
 	 * XHCI driver will reset the host block. If dwc3 was configured for
-	 * host-only mode, then we can return early.
+	 * host-only mode or current role is host, then we can return early.
 	 */
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -1209,22 +1209,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
-	if (dwc->dr_mode == USB_DR_MODE_HOST ||
-	    dwc->dr_mode == USB_DR_MODE_OTG) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
-
-		/*
-		 * Enable Auto retry Feature to make the controller operating in
-		 * Host mode on seeing transaction errors(CRC errors or internal
-		 * overrun scenerios) on IN transfers to reply to the device
-		 * with a non-terminating retry ACK (i.e, an ACK transcation
-		 * packet with Retry=1 & Nump != 0)
-		 */
-		reg |= DWC3_GUCTL_HSTINAUTORETRY;
-
-		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
-	}
-
 	/*
 	 * Must config both number of packets and max burst settings to enable
 	 * RX and/or TX threshold.
@@ -1800,6 +1784,17 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc_res = *res;
 	dwc_res.start += DWC3_GLOBALS_REGS_START;
 
+	if (dev->of_node) {
+		struct device_node *parent = of_get_parent(dev->of_node);
+
+		if (of_device_is_compatible(parent, "realtek,rtd-dwc3")) {
+			dwc_res.start -= DWC3_GLOBALS_REGS_START;
+			dwc_res.start += DWC3_RTK_RTD_GLOBALS_REGS_START;
+		}
+
+		of_node_put(parent);
+	}
+
 	regs = devm_ioremap_resource(dev, &dwc_res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
@@ -1913,7 +1908,7 @@ err_put_psy:
 	return ret;
 }
 
-static int dwc3_remove(struct platform_device *pdev)
+static void dwc3_remove(struct platform_device *pdev)
 {
 	struct dwc3	*dwc = platform_get_drvdata(pdev);
 
@@ -1940,8 +1935,6 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	if (dwc->usb_psy)
 		power_supply_put(dwc->usb_psy);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -2252,7 +2245,7 @@ MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
 
 static struct platform_driver dwc3_driver = {
 	.probe		= dwc3_probe,
-	.remove		= dwc3_remove,
+	.remove_new	= dwc3_remove,
 	.driver		= {
 		.name	= "dwc3",
 		.of_match_table	= of_match_ptr(of_dwc3_match),
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1f043c31a096..a69ac67d89fe 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -84,6 +84,8 @@
 #define DWC3_OTG_REGS_START		0xcc00
 #define DWC3_OTG_REGS_END		0xccff
 
+#define DWC3_RTK_RTD_GLOBALS_REGS_START	0x8100
+
 /* Global Registers */
 #define DWC3_GSBUSCFG0		0xc100
 #define DWC3_GSBUSCFG1		0xc104
@@ -254,9 +256,6 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
-/* Global User Control Register */
-#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
-
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index cda9458c809b..1755f2f848c5 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -275,7 +275,7 @@ static int dwc3_ti_remove_core(struct device *dev, void *c)
 	return 0;
 }
 
-static int dwc3_ti_remove(struct platform_device *pdev)
+static void dwc3_ti_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dwc3_data *data = platform_get_drvdata(pdev);
@@ -294,7 +294,6 @@ static int dwc3_ti_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 
 	platform_set_drvdata(pdev, NULL);
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -362,7 +361,7 @@ MODULE_DEVICE_TABLE(of, dwc3_ti_of_match);
 
 static struct platform_driver dwc3_ti_driver = {
 	.probe		= dwc3_ti_probe,
-	.remove		= dwc3_ti_remove,
+	.remove_new	= dwc3_ti_remove,
 	.driver		= {
 		.name	= "dwc3-am62",
 		.pm	= DEV_PM_OPS,
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 953b752a5052..b94243237293 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1207,5 +1207,8 @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
 			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 		}
 		break;
+	default:
+		dev_err(dwc->dev, "unknown endpoint event %d\n", event->endpoint_event);
+		break;
 	}
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b78599dd705c..858fe4c299b7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2703,13 +2703,17 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 
 static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
 {
+	int ret;
+
 	/*
 	 * In the Synopsys DWC_usb31 1.90a programming guide section
 	 * 4.1.9, it specifies that for a reconnect after a
 	 * device-initiated disconnect requires a core soft reset
 	 * (DCTL.CSftRst) before enabling the run/stop bit.
 	 */
-	dwc3_core_soft_reset(dwc);
+	ret = dwc3_core_soft_reset(dwc);
+	if (ret)
+		return ret;
 
 	dwc3_event_buffers_setup(dwc);
 	__dwc3_gadget_start(dwc);
@@ -2744,7 +2748,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	ret = pm_runtime_get_sync(dwc->dev);
 	if (!ret || ret < 0) {
 		pm_runtime_put(dwc->dev);
-		return 0;
+		if (ret < 0)
+			pm_runtime_set_suspended(dwc->dev);
+		return ret;
 	}
 
 	if (dwc->pullups_connected == is_on) {
@@ -3809,6 +3815,9 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
+	default:
+		dev_err(dwc->dev, "unknown endpoint event %d\n", event->endpoint_event);
+		break;
 	}
 }
 
@@ -4446,9 +4455,14 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	u32 count;
 
 	if (pm_runtime_suspended(dwc->dev)) {
+		dwc->pending_events = true;
+		/*
+		 * Trigger runtime resume. The get() function will be balanced
+		 * after processing the pending events in dwc3_process_pending
+		 * events().
+		 */
 		pm_runtime_get(dwc->dev);
 		disable_irq_nosync(dwc->irq_gadget);
-		dwc->pending_events = true;
 		return IRQ_HANDLED;
 	}
 
@@ -4709,6 +4723,8 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
 {
 	if (dwc->pending_events) {
 		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
+		pm_runtime_put(dwc->dev);
 		dwc->pending_events = false;
 		enable_irq(dwc->irq_gadget);
 	}
-- 
2.53.0

