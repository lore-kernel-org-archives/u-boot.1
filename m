Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAFCC5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B96C340542;
	Fri, 21 Aug 2026 13:12:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tcDsVROLJjKu; Fri, 21 Aug 2026 13:12:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317949;
	bh=gyLlILxsvnFTB4zt1VU+LTXv6vaPhV1WFQyTvTY+tkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E0KSSNK8uXAv4g2bVCU8WiqT/81FyfPWbZak5FrwHUspUm3Ew93JdCFaLzq4TAtSI
	 jrQOjd4YRKcYJ3/r8s5vQer0WXlLiJ3mDlDx68VUMTNV9PMJJhfcybjSfwWQu5ePrc
	 frk0d0Bc63JIXXk1Jv80khUjPOSHYYJxb8RtxQuVjLL6ytqIf2WbP2ojfgitX2HPAp
	 SQLh5OHUNzo2wFhDkBaHPIsFbdDugkQ5qjJECWuEAYvvsqnsKNrtre+WCHxW3AolOz
	 wDALTYolNbupdfASxbtYZxwSL8MSNZU/zkY8HT5nmOs7IhUQECp95hbzsjSyBGHt1I
	 8nn61iVcEM4HQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B83840A04;
	Fri, 21 Aug 2026 13:12:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7186476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD42240947
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kHPQTUL2hfrj for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:51:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=B0nkQouq
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB28640930
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:16 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a1541ea780so146399a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302275; x=1787907075;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gyLlILxsvnFTB4zt1VU+LTXv6vaPhV1WFQyTvTY+tkM=;
 b=B0nkQouqF7hA0V9zd5zuR6Fq+FVymCL25C6+DNeR6R9ZzkPx6oeRvhBm581AgQxTEg
 VcqW7wk74uZ1It2Qoc4wcemOx3JNaiFU+2kKwLt77BUmBxwGYENlLD75OlSZ4GiftGKz
 vN4fQMb1qNFlY/FvEnkDR/Cq9bjzKRTX5/KuBoAj4flPBKlEokxrgii1zpXWiHDfXGma
 BRVpYHvPoSoJGjg0gN01Epy/nPiaa2UoVbEP4i5fenzXiPHen8lflIpuILIXfF5k3Qg6
 KLIB2AOf8HWuzy3wjoT4iUKcP4+DwDj5+B6FTFU5hGdV0ttFIruSZwgHFzFP6fuN/b8D
 H22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302275; x=1787907075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gyLlILxsvnFTB4zt1VU+LTXv6vaPhV1WFQyTvTY+tkM=;
 b=OC9en/WZA5+n0juFdmywQtcyY1GDqh5ZjJsXRcNiVUefACCxkHqKsGxcE6daMIq00t
 1A3wacVapYuVeMUe/AWPsNqYkLzjsIwYSju1/kXuG0mZQkL5VhzspcinPqbsKddOX7PE
 AC9Nd5ynXUtMzO+qI9GADQbrmIPmW8+e0n2YMtUUtpPkfMC7rCHYEq1FMgPZ7n3gjnVi
 JqpbN4T/jB8t03Y4x1QmwL8AoMKbs7TptPboNTp0gCrQxpdZ73lzPldf8SQRRtFCX4Iv
 JM2Nbtaw4d+ZTVCRCIJDAupPSlRqMNWCzxHhEK80fzPGF0q3kqFswX1G/V+gufw7qRa5
 51Qg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqB/h749D3iXBEr+LJMTbnCzDJaanQtbdFz9+pNxu6K4o0xrEd3WHwDMVg8IZ7uhPRP55Wyd0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mNuB+sMKmXW/B2f4i4WelrqYeve80vDpGT98fE8xEV5UTPlCai
 rDSJqPDPW9G2diQ/fg28FjKqB2dftvCet3AKOYKycoKUmVTZxB25Mgz1ymdBkSArK7k=
X-Gm-Gg: AR+sD10DPRDWVBxsPJJPoFgrruQG1z6CiHLdnZhVlYkqqlI93UKGp96ikEYSSTiHFLV
 HnOIsI3I7YAt03FMIKuiNQj25PEEH3z9uosnd4CS1E4mzFWXu3ihyCBq+umEi/Co9jiD6BGcJKc
 23uUCou5wXMfe3tRxm/IabOjajn5I9AiMhXikfUPU5z7oD8ZrdFvpIVCzU+Ss6CFv3hHJ3BTjGm
 rM0AmfsYJCCzXEUEbNSBndZqroo9QoaKAsA6i7m8yIT42AbBmgAceWCI5zKEyAkZjUqIjgTjx/q
 /U2Koz9fqEm7yppiKZPDvLLh2QfJu6i032Hmxqee9JY6JLgkCAz0rk/3q1+fUtOMRuhyvzTaD4D
 DB7bYbmbeEuuy1bKWR/czo5kYqDcuM6hWPHhljK34OiA8AZgdwZegqnNG8iTXbshywi1jqo+Ijg
 ahcNaaH0fT2SLMyHnhrQ1AUSRMCpvpuf8q9Qlf54Td+ZE1fGcD1CsJ78CZayw4sb2di6JOm/eYW
 K8pOs0wri/p9xTiXXEvCvQr
X-Received: by 2002:a05:6402:5186:b0:6a3:eb13:e74c with SMTP id
 4fb4d7f45d1cf-6a42f1a8bfdmr2909409a12.1.1787302274458; 
 Fri, 21 Aug 2026 01:51:14 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff16c546sm5260656a12.21.2026.08.21.01.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:51:13 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 18/87] usb: dwc3: import from kernel v4.14
Date: Fri, 21 Aug 2026 10:46:54 +0200
Message-ID: <20260821084829.2070426-19-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
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

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v4.13 to v4.14.

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

List of commits: git log --oneline v4.13..v4.14
Commits imported:
551684708356 usb: dwc3: ep0: fix DMA starvation by assigning req->trb on ep0

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/ep0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 827e376bfa97..75e6cb044eb2 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -990,6 +990,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 					 DWC3_TRBCTL_CONTROL_DATA,
 					 true);
 
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
+
 		/* Now prepare one extra TRB to align transfer size */
 		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
 					 maxpacket - rem,
@@ -1015,6 +1017,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 					 DWC3_TRBCTL_CONTROL_DATA,
 					 true);
 
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
+
 		/* Now prepare one extra TRB to align transfer size */
 		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
 					 0, DWC3_TRBCTL_CONTROL_DATA,
@@ -1029,6 +1033,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
 				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
 				false);
+
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue];
+
 		ret = dwc3_ep0_start_trans(dep);
 	}
 
-- 
2.53.0

