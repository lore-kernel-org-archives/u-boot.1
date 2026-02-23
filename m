Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100B3EC1136
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 20:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EBD483D8A;
	Mon, 23 Feb 2026 21:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="laGOfcEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C15483D2E; Mon, 23 Feb 2026 21:40:28 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 378F083935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 21:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-67997ce9e1cso2765631eaf.2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 12:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771879225; x=1772484025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MBZpNyHScrfa1m5j9o2GDn0Tc/2kkq9/ka7DXMdFoM0=;
 b=laGOfcEFLZKou7OT58oiRkBCkltWdLxME6iOtF4i9Yvt8TiYBcocAeh4ZdO+5wCLo9
 m7RILn2iF9kWmDrm1VGLlVzwwndS2HO65A15tg0xavFNXAV/ry9rXKsjECvvMW7nGOa0
 tGN/tmWjOG4Ts97sqMm8i9m0z2z39710TFp0Agqxu1Yd/1VdnuQgxzfoJ96yrMwArQ5f
 i8C8wSGulRtUqytFx2Dxvmg0f1LAdRdnhWl1CpVSRSNmJnxlIZCuVRGxTJsG/epEg7IB
 nKnq6i1/wQsA72jkyjJL53moFqAaN8gg5knCweuP/+8PgdP3t+DugMNHMX4Ai+NYq/V0
 zMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771879225; x=1772484025;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBZpNyHScrfa1m5j9o2GDn0Tc/2kkq9/ka7DXMdFoM0=;
 b=vgG3uddv8ejBR9FxQ284FYqaErZu3A9tVBn7/Viza3VVIAdudH0hzigxN1vOtb+AtE
 KvKtliDIJI1ETonWLfiDyhCJiXo5dDwycPl0ByYv/N7TUypmr8cISAv3gn3Wq6011olR
 gd2RnuJ6F6tGhABqbwLOm9dCfnggJA4eIUOxA1Hsc0fZvP9K8I96pJpDIagOnScOQV5d
 WUKinsyH7XHBYKHz2PDkDdqzmQPxq3SQIblP1ngelJgD8IjGaH3EF45Gadwx4syiDp21
 mfovj1AcCv3EJl4kUmowqJ6IVww4DgmHGfABvPIyjcUuIOut5MeqKt0TnCqjnDtQKsPx
 ePaw==
X-Gm-Message-State: AOJu0Yz8K2k23MlIn/CFlxoqXfeYB2LkaMKNoiTRSyVRTdUmyKD+6x5O
 bZqixYBu9geLbtRhc4O/FNaW8vYNX2KWLdzvOe0OD7aXFcapM076W0A4jly+JQ==
X-Gm-Gg: AZuq6aKIbP5t7n9dZ0w21we5DbRu064D78RjOY9JyMacAm+2ytHimThplnJdd3SFSYI
 x3sKb1/Y7ouU7stIc5SRGSAavG2PcXdwDLxnwPd/DwXIZyH/QDgXk7d6HjM9Mt65u8oLHcb3r8r
 gGxQ/dVWrDQz9bG62II9yopfw5XvD0z5KM/tGnlujUNLAOYpOEVmDfCP8w0P/gIagjz6/jZ2EFp
 /gktw+1z6+UAPzS0P+FB7N/nSG9aJ0lnDMqnpTcKkv2vOGYh+PWAPB/kCZaWdst7OQEh0+eE8kF
 n0MShgR4VvD1NVNqV6NkD15CfUdSt5wjBjiXpV0YCyxABOuO3dCL4TyRr4rkZ6PHQVHxZpzQ6Qn
 PHmKPKvOgnoCbXXLCwwTvg1PXQe7XuGcRyH9AEZ3XbK1PUzGkR+kJqO3XvukRldZaHjPTsObLb2
 AHddYSQvBjHXCJLMDjSAGCPOCOb/ddwh4cr2xkRKNcEChxOOGCtFBY38kMMS+KsKuMuUjzP2xmX
 R+UM5cWilwpdmnw8KGgukjr6aj2NjsBun5+wamUrOabnNZvq7bGH6JpkCo5
X-Received: by 2002:a05:6820:4dc6:b0:662:f2ea:8f9b with SMTP id
 006d021491bc7-679c428264bmr5489961eaf.20.1771879224599; 
 Mon, 23 Feb 2026 12:40:24 -0800 (PST)
Received: from james-x399.localdomain (71-33-158-51.hlrn.qwest.net.
 [71.33.158.51]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c56dbdc4sm6791726eaf.10.2026.02.23.12.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:40:24 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Lechner <dlechner@baylibre.com>,
 Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH 1/1] boot: fit: validate FDT/DTO payload before fdt_open_into()
Date: Mon, 23 Feb 2026 13:40:04 -0700
Message-ID: <20260223204005.2705968-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Feb 2026 21:44:12 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

boot_get_fdt_fit_into_buffer() calls fdt_open_into() for both the
base FDT and overlay DTO blobs loaded from a FIT image.

Those blobs come from FIT payload data. In the overlay path,
fit_image_load() is called with FIT_LOAD_IGNORED, so the IH_TYPE_FLATDT
header check in fit_image_load() is skipped. This leaves fdt_open_into()
to consume header-derived offsets/sizes from unvalidated input.

Validate the full blob against the payload length first with
fdt_check_full(fdtsrcbuf, srclen), then proceed with fdt_totalsize() and
fdt_open_into(). This fixes Coverity CID 644638 (TAINTED_SCALAR).

Fixes: 5ebf0c55a23 ("image: fit: Apply overlays using aligned writable FDT copies")
Link: https://lore.kernel.org/all/20260223195109.GG3233182@bill-the-cat/
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 boot/image-fit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index ddc64debb14..e7c7212195f 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2390,6 +2390,14 @@ static int boot_get_fdt_fit_into_buffer(const void *src, ulong srclen,
 		fdtsrcbuf = tmp;
 	}
 
+	/*
+	 * Source data comes from FIT payload. Validate the blob against
+	 * payload length before fdt_open_into() trusts header offsets/sizes.
+	 */
+	err = fdt_check_full(fdtsrcbuf, srclen);
+	if (err < 0)
+		goto out;
+
 	newdstlen = ALIGN(fdt_totalsize(fdtsrcbuf) + extra, SZ_4K);
 	min_dstlen = ALIGN(min_dstlen, SZ_4K);
 	if (newdstlen < min_dstlen)
-- 
2.43.0

