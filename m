Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B13C5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85744405F6;
	Mon, 24 Aug 2026 19:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ww-MH4_NFPV; Mon, 24 Aug 2026 19:04:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787598242;
	bh=oY2HrivNwGG6Hxoa5i+pfODqA8CnQoCzZf7+qmC1iC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jgV6+d0wR7DSPG3sR3fkDewSs5xvIJjYJe82KqerubA9L/Zn7kTiDiPq8OOahvsr9
	 2GZ+Ttk1kM4pJ+8BWpb5l0rGUq2YluEmNLmHHTwadSiRuniIvvhy0akWdcbtC89zA3
	 HBHV+m6hn9SmLdCvw1X3hau53PtBwNUMNCKoze3wRqKrpp+6FEppqEYOOjsmgCFR/l
	 imMNYJ9V6I6/WQJPuAJvoj/RFleF4/ouXee5zCV6YFRlQKF4jJOB76n1gDNZGvhNnG
	 cSd0lFKgqGGOQIYPI6K1K+U6zHpZHl7i2g4rtaHAO0r6LggmiCqYTTruhvYxdzAZV2
	 oy40L2SxsHJEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1EF64040B;
	Mon, 24 Aug 2026 19:04:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D00634E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73C4E405AE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AyY9rzAXWBSP for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 18:31:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Tk7W3JRF
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E4F3405A4
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:03 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c15d3cd51b2so582006966b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787596262; x=1788201062;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oY2HrivNwGG6Hxoa5i+pfODqA8CnQoCzZf7+qmC1iC4=;
 b=Tk7W3JRFW+pbbqooE2jMKAVxkfv5W8PbprQJtbbaITE7AJOjc4GjrsmHZUuAFvUJE9
 iWZUgPhskkmDdeLMCzfeeRQk/bdSxBa8cS4BTi4fxDg6EFd3LsSg08KaQMNQUzI0ijuD
 DQwia3gZiQDeJSL36CA/Gbio9uIbLulHJWeVCcv3cehAiviyfdt8BLYJoWCid9JVCdp6
 tgG/Nt1gCgE2WEgWEwDGmC9eElIDoMY+bib2GrOnH3H6fLQw7FQnx+U2bDnRudOu3ukr
 96eIrMxFGVxbAw8Os8j+3utnU9HU5gzrO5DasuUG8myrrMpsZhWE4oZw1/WiQ8hss9MM
 jSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787596262; x=1788201062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oY2HrivNwGG6Hxoa5i+pfODqA8CnQoCzZf7+qmC1iC4=;
 b=pa2TUATkVvhvgnARWnvViRCVSUTBcuZBeq/HnvYHUUPGnLyWoG7HdRJaN87Q25RCgD
 na9tVT8j7vu3wWlTYrSMnLsWe+rPVWZUS7Mk5kGN99VcCmtuzFxz0hvp5ON0oBVwiIvQ
 Bh5C75qP4DAawUzrkEjLAZcuebaYk7BGnt8veangH2lu97Rbjild4XaY2rSrW8neVgWz
 l/Zg89FOIhWmB4nSvnNPJjSspHzipBtIgT6FAIQObS3gVKRWaVj0tYHXEYcxcjF7n8or
 h6adLzivVzmh00JiZ4mVb3Lyya0E2mvB5KvmING2gQFsFNtJwA4SoXQxtjHtdk6GDS6c
 eorw==
X-Gm-Message-State: AFuF++nq/y5isyVDz3IVOODTBoThXDCAehVVt3NKo/Lk6ApPt942pJWO
 8wh2Go2NM2U5xrinkju+bEqSG37K+RzH1zVrkZ2TvEXf3Xo0qO5K8jTH
X-Gm-Gg: AR+sD12jMyq5euQWDRCQDJtINazAfSMjonR3K5WLSoUnAdhHTXGIIARxI6ueiENAfW6
 UX2SNmOt+uptUxWqzS/iHzFdBYyh2UVuv5xG0BxgDUQEnsvVeABCt681QKCFM+pIBhIKdHrHFeM
 Zo6Dpq2/uOprXJ/sb/528C4MdzPLJyAbA4yUZ8cicelAJQegA84K6zRzqKxom7uLbDM3FkuoBp3
 4WU63A9vmFIllcE6r0VicJ0U1bmT0weJaqzEp1i6LyAMd4Hii9UVQdxQz2krICRkQDe47Zmh2oB
 k+Y0wVeQyZch3Z0/h2COJH1DcZRQiddMSI1VwRKXjXsagTr752TBRPo4+/ji5A4Fc3AmM+n8pmz
 NgDnK/kwDLIyF/fKLcpJC7k3F7Akk8Uirsu4j+2xv53RU4mbRPOyoJlH52VIV7ociWLIAyyfH5N
 cGPNN3pcFJHs3pzHcjmDk0wCtkDnZKPyuT2+bRUUKBDIo=
X-Received: by 2002:a17:907:8908:b0:c21:35d0:f435 with SMTP id
 a640c23a62f3a-c24924db408mr2350558166b.10.1787596262058; 
 Mon, 24 Aug 2026 11:31:02 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a8edsm1355044366b.6.2026.08.24.11.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 11:31:01 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, alice.guo@nxp.com,
 antoine.gouby@toradex.com, stefan.eichenberger@toradex.com,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev, sjg@chromium.org,
 ernest.vanhoecke@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 5/6] toradex: verdin-imx95: enable DWC3 USB controller
 support
Date: Mon, 24 Aug 2026 20:29:13 +0200
Message-ID: <20260824183048.419198-6-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824183048.419198-1-eichest@gmail.com>
References: <20260824183048.419198-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 19:03:53 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Enable the DWC3 USB host controller on the Verdin iMX95. Enable the DWC3
driver support by enabling the wrapper driver CONFIG_USB_DWC3_GENERIC
and ensure the device tree nodes are kept enabled for U-Boot.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi | 8 --------
 configs/verdin-imx95_defconfig                 | 1 +
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
index 8ab70cf7399..ab6e1054a9f 100644
--- a/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
@@ -90,14 +90,6 @@
 	/delete-property/power-domains;
 };
 
-&usb3 {
-	status = "disabled";
-};
-
-&usb3_dwc3 {
-	status = "disabled";
-};
-
 &usb_recov_ctrl {
 	bootph-pre-ram;
 };
diff --git a/configs/verdin-imx95_defconfig b/configs/verdin-imx95_defconfig
index 2635d899be0..4da705a91a0 100644
--- a/configs/verdin-imx95_defconfig
+++ b/configs/verdin-imx95_defconfig
@@ -172,6 +172,7 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
-- 
2.55.0

