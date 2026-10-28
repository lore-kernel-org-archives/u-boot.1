Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6961606A31E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VBfm+ojO;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CTVQ1Ro8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6898D8119C;
	Wed, 28 Oct 2026 14:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O3-pNlPI8jXf; Wed, 28 Oct 2026 14:48:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E4F5281197
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198844;
	b=IxCVeCI0o84O6OhNYS2UhoPDIy2CDTOa6oHyP5qMYKL2JO5/HLvWbfKtIteARekloUTY
	 7+TnxjMf4v+o8D8NGCmpHvbqlGWwiM9ABqKGgjQC7d9fD1eE6qeNXQQ/k+WkHwuk9AH6V
	 5YTQEHu/TF7ML/Z/w8yMt5j36wIuSaV262Yheju9BZi3IDqOcR5ziI0fYKDOuqlo0kXsq
	 7ABnjAlO1Q/weeril/wjZ2uFpC+DQcoYw4Zivecx96JCpiX4II2SVaL7mb5yKKAgtB55t
	 e4BQznTNKiEnWR4BPVe39p4mgLy/y4CE3DdefAbjYGMmcSd1RiFCjUF/AyDG/A2I9jw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198844;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BMWPxhJU07SszhgENdrVD2oVr1+bL4jhDtZONMpI6XE=;
	b=rGjfgpYukbLH2ywaIEVLiyYCxT4EFV/XSYT7/ZykXnpcdVjTSmwFyQ7K/+YMtQFrl2fY
	 EQC1iQDHVGSQgARgtc5ECgjPZfgVWDCD5LIF93yCQUvawKuDV9/6Q32OjohosxdfbQBix
	 WX5TJ2crZ8TE7sm76pGcuaLxqXxd9TFZkRF/sRWB7qPEpJiv7WlvBsGQ6Cu3AX1SU2dOm
	 gBORLhqDoJ3A10mNPzggR4hnRCBED93ZrST2/S7/RDqD0zjIuDhDZmLDL5zTIuKRIyuDZ
	 jqUvyOdOHxeovzgLQj9op9/ECWo8k9mr3htf2IJjSwWIv7qdVVB5U/foq3msUDW/4mQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198844;
	bh=BMWPxhJU07SszhgENdrVD2oVr1+bL4jhDtZONMpI6XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VBfm+ojOG8RcT/ea2Q/803y94VboggaZotrsTenCCp8iFBiKvNrGCfcZ49aBD/a8I
	 qiPWLn/Gpmz7W7Pp0NL8lYTDWd1jpPES7k0PIk5a70/XQEa6fTBrseOT0wTw+K/N5R
	 V+ns7iwj9iiSBIDerdLUDijueewS4Fu1e7EaZQQV0G6XlNoIW7h8+xg1MoRBcfubM4
	 zmM6U+S419aIU+RD+rlH15kC7Lut4dklpABCks7kkTTSV9VL85XLMzNvIczI8k8G1y
	 vFvuGfGM9D72UB/6pEGuawzlJjVoAXTHJlxLV73cex+tXGcShQgV9b6IFLt6ZocsXM
	 5pV3AQi003t5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4F5281197;
	Wed, 28 Oct 2026 14:47:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BB47D356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACF80605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pCKbmH-9U9HY for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:13:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AFDED605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196802;
 b=W4ziDcOmyk2aopNCzD892DPXc8t/HLFBfu+o8Dq4vqlrofiyT3o2na5/KV5fVTLl1M/z
 0OH+I0qnFnpLAL77wri10WzQu6THnTgOlvGQVSNxl14/jkISvthKwVvnlIvjeFeQEhxdB
 Vj6pAxxSXsQc/qTMmHd6Bfg4KHFYghpropXjtVfxhphkgTqC7NGxi4aB4EqhKnZVgrYLB
 NUGcKDq7doK3ivEvvifKHhMh61yM0du61PHCWbI7BGVQRcnni9EDAG+kGQeFWsTBlnFvR
 XcEXzlJ+dkZvizO09a4QmqvalZbW97L+P85z9lYejKK9KS5K3yIsVGe0EHYy8D/RBeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196802;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=BMWPxhJU07SszhgENdrVD2oVr1+bL4jhDtZONMpI6XE=;
 b=rgp/fNPYFGEySTjfr3JM2PeDwrUOTEkBYNjx17UOr+19tEa8SS1wzwVxj3iQL+51BKJO
 PFvWU66fPWPtP6jyBqM+7ywdF3uto6SeZ1lu0NkrCQXZF73nf8ZG6uJTcUXx0zaZRluzB
 Z2s7GLTZPRJuK+SI86lIJYfNvnvCddSQajUD/AdOgAQROgk1WnBkCFx39vMMactkjXNBF
 zsF6qbDoULVVilCVMI4OpLkdQ43voMFqLE85p8rSahBCW3Po34tMcqO5tQRoolOO515oN
 dzEgqCwqMpB0VCExoQH5shoMBUMpr9hfnJgQOOxO0DG/BI+Knx1GBa15HY7eG0Pz7+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=CTVQ1Ro8; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=CTVQ1Ro8
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFDED605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:21 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c33700b6435so16192866b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196799; x=1793801599;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BMWPxhJU07SszhgENdrVD2oVr1+bL4jhDtZONMpI6XE=;
 b=CTVQ1Ro8ooP4XuV5W78M7aTqy8FUrRXwcZqZPCdrOsdy07l2hgMO6MzNSxl7/bLVfx
 clkqqi9zCqqWeyxiQCioTeVnJVnoi65uudHhBfYwPX//rqvXV0Wfsq6hCL3mbieInFBn
 667QPxdCczi9+ts2L9qGhemWvhn0HbTSRmzDLuqJX4X6N4i5e7Dt6aCHE8TbqEELDV0Y
 4snSJPBH/5/aLXf06dgQeQF1trO15/pfyH5bxVHAN6yR3B6Xl8kn8ysDMcun5fzcGMS8
 GjfMld0mRRXYWv2qpCFJHkih3QT9TrwolppgIRWeeBgdm2K7yh7wZkmTrwRFTkTDhGqP
 Tovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196799; x=1793801599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BMWPxhJU07SszhgENdrVD2oVr1+bL4jhDtZONMpI6XE=;
 b=yA+yD99+qzmnUjmcJsKdnJyrNIEFIg1I96VSiiXCdUFT5ly3slx/+AQdvfDle8uRUw
 33dB5aheBMmsnHkzneBst3TFBvaNEU5Akgz97agi0+gOm94PeGqkpXiQdmCPZsp1s/9t
 +rf3XielQTdWFXwH6ouDt4f+A4xPXPQVVtUuuNDqYC7sdKGX3UIaM0fVP2SvwMrynUve
 AJ4cYslkFIT1t8GZ11BRNSk4WOBFVsozMs5CLdt14S8QYnbEDv3ZvTpOprM/ESc+us/Z
 Ptxi7hsXRt3gT5U/h+QjoSUl/gfDxk3bnAPkxjgSVQOVlZJOt+nF/1q1zKlIxQLjIvuI
 Aseg==
X-Gm-Message-State: AFq9FYJE9WgmgjgXCfHNnMIGb8/bPbe/NxPJL3bQNoF4k71DK/zfR9i5
 nP/R1UCCo/l8z3ubL054nWA/IiFgR8+pGg/ls23Xh4KqIAYhaaJ9kdBX+d1SmNtJSXz0MqQRaHT
 nHFV1
X-Gm-Gg: AYBFou3QLwGC9jzzei3ZWnfgPxp+ez8ynJfbODCPETDTtHBpA9RZ8BjPvc8LoU8ZThR
 z1IZDpS7KleKXKfHL4Ac+liU73sPuMBm5A282oOdxb8zcux41oF1KBxCEluvm7IKQmjQjQJT57m
 t+XFBqlyETqCLA8bmZiJ3Quo/+0bIDaJfgChIgNaoMi1V14Qkr/3sUQYjz1/Lc6ZU29E8UMNW6k
 OkouDe13okAIstgyVXmex2pJAGcxKrcZYemJ9uusp8JmiANnmAerNq5cx+rFNzXTrmfG7u7Lcgr
 zr0sL4NoqiO62axfZMfU/HeTSpaB8zErHdNj7xueWsSqEqD5esZcXfjsLvesQmVgnp2AdDSkaS0
 XvypbYjnMJN2aQBDxadWJnMxyOehqLWssjHOyrcCZTpurmPhMUcjl2sYCAO7IaoWEJVMY+vxFkj
 zhBfzd4ohiNW/ZG1jno8b1q/SSe6ENUtGFhAI/JPD4/o9QOmJST6skbzh46n08uWQqhNPFwele8
 LXvFwaiv7giKVueGoYVjMJaqXMXX/bbi4dNUzZghkKVBe6QtPrGNgessEWsZHcq7Kiur+ENcM4x
 0Ped2FZJ4N+OaNOwN/JaSJRUxCsOWUCYM9tIEdZF+5+vH+biRwnjZuVlvzzOvx1ZCyNsjw3lz+L
 sA6VOo1XRDA==
X-Received: by 2002:a17:906:8f14:b0:c46:ae89:cd3c with SMTP id
 a640c23a62f3a-c49bddd28ddmr279038766b.1.1793196799249; 
 Wed, 28 Oct 2026 07:13:19 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd350c61sm612006966b.11.2026.10.28.07.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:13:18 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 48/63] usb: dwc3: import from kernel v6.3
Date: Wed, 28 Oct 2026 15:09:14 +0100
Message-ID: <20261028140930.3025368-49-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.2 to v6.3.

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

List of commits: git log --oneline v6.2..v6.3
Commits imported:
d8a2bb4eb758 usb: dwc3: gadget: Add 1ms delay after end transfer command without IOC
02c1820345e7 usb: dwc3: Fix a typo in field name
be308d68785b USB: dwc3: fix memory leak with using debugfs_lookup()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.h   |  4 +++-
 drivers/usb/dwc3/debug.h  |  3 +++
 drivers/usb/dwc3/gadget.c | 18 ++++++++++++------
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8f9959ba9fd4..4743e918dcaf 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1098,7 +1098,7 @@ struct dwc3_scratchpad_array {
  *			change quirk.
  * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
  *			check during HS transmit.
- * @resume-hs-terminations: Set if we enable quirk for fixing improper crc
+ * @resume_hs_terminations: Set if we enable quirk for fixing improper crc
  *			generation after resume from suspend.
  * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
  *			instances in park mode.
@@ -1117,6 +1117,7 @@ struct dwc3_scratchpad_array {
  *		     address.
  * @num_ep_resized: carries the current number endpoints which have had its tx
  *		    fifo resized.
+ * @debug_root: root debugfs directory for this device to put its files in.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1332,6 +1333,7 @@ struct dwc3 {
 	int			max_cfg_eps;
 	int			last_fifo_depth;
 	int			num_ep_resized;
+	struct dentry		*debug_root;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 48b44b88dc25..8bb2c9e3b9ac 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -414,11 +414,14 @@ static inline const char *dwc3_gadget_generic_cmd_status_string(int status)
 
 #ifdef CONFIG_DEBUG_FS
 extern void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep);
+extern void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep);
 extern void dwc3_debugfs_init(struct dwc3 *d);
 extern void dwc3_debugfs_exit(struct dwc3 *d);
 #else
 static inline void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
 {  }
+static inline void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep)
+{  }
 static inline void dwc3_debugfs_init(struct dwc3 *d)
 {  }
 static inline void dwc3_debugfs_exit(struct dwc3 *d)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89dcfac01235..cf5b4f49c3ed 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1699,6 +1699,7 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
  */
 static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
 {
+	struct dwc3 *dwc = dep->dwc;
 	struct dwc3_gadget_ep_cmd_params params;
 	u32 cmd;
 	int ret;
@@ -1722,10 +1723,13 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
-	if (!interrupt)
+	if (!interrupt) {
+		if (!DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC3, 310A))
+			mdelay(1);
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	else if (!ret)
+	} else if (!ret) {
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+	}
 
 	dep->flags &= ~DWC3_EP_DELAY_STOP;
 	return ret;
@@ -3194,9 +3198,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 			list_del(&dep->endpoint.ep_list);
 		}
 
-		debugfs_remove_recursive(debugfs_lookup(dep->name,
-				debugfs_lookup(dev_name(dep->dwc->dev),
-					       usb_debug_root)));
+		dwc3_debugfs_remove_endpoint_dir(dep);
 		kfree(dep);
 	}
 }
@@ -3776,7 +3778,11 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	 * enabled, the EndTransfer command will have completed upon
 	 * returning from this function.
 	 *
-	 * This mode is NOT available on the DWC_usb31 IP.
+	 * This mode is NOT available on the DWC_usb31 IP.  In this
+	 * case, if the IOC bit is not set, then delay by 1ms
+	 * after issuing the EndTransfer command.  This allows for the
+	 * controller to handle the command completely before DWC3
+	 * remove requests attempts to unmap USB request buffers.
 	 */
 
 	__dwc3_stop_active_transfer(dep, force, interrupt);
-- 
2.53.0

