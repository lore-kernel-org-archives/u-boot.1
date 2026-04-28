Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1E4FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D34588426E;
	Tue, 28 Apr 2026 16:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="iqTYm7SN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD0C4842A2; Tue, 28 Apr 2026 16:28:56 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEB7984255
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 41DCA3F861
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 14:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777386534;
 bh=Qit23yoT/JLBtdiKkJqUQVtxZxvk5uZWi+AI+UC0yf4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=iqTYm7SNsok9L0DPnDTjgxw1D+Of5qaR3QctCJWCQoh+KKbUKY/J37XsjBoV9J7Y7
 gKvU1qazI0zazhAXav1vCuJv2SETikJkJNdwqEhMZA3M+0F9fAkWSvHSswks6w5izr
 HpTdv2VD6XTrOYNrdEkuVBQh3nxFOhgH41VchJQ/Fg7CxYoCMA0xEk5eLd7qzl8G5n
 m4nqUmbx7HKzCWd/pf6OeuJYLkVHXiRPVIyAYr8xmDj+w7f3OfzdFoNj+IOjhTBVsF
 nXyu+IX6MuZprvSBCY5VBIGR6DAn/WjXBRbVJ8OHQ4LcvPs10EPzr/jQNkFCqixVSa
 qkQwzNs+5MW3tVodcOyNkYo2H0wBAGGOACGWWUFcmQYPl3ven6dVp43XbGUyv0XIaE
 r7NUn/b1m7drXDGmRrfZAsxD892jCN92kCOLhULXCMQQ7X3B3BkleVutY5K+iV2SRn
 slE+VZkWuI2pnx7lbJqpMRGMsbdS6mXUrgLf4yZVzyk4pZRSqfzoy9L4BIwsJ70qm0
 GXH9ZHpqOOl42BA4f6CuujQg+Knu7TxlN3ENLYkKRxkHVILT81leSZnYfdAuzs40ik
 JJf2RVCD4DyQz0y6d3YnIyHgqFPMqXS98ARyMP0NQ1wf3Ss7ddYOV68t6rrbO7lBP0
 RoD4ufnZ2vV3hS9/kpsoU2dI=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488c0120047so68000455e9.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777386534; x=1777991334;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qit23yoT/JLBtdiKkJqUQVtxZxvk5uZWi+AI+UC0yf4=;
 b=aEhZy5Hy3F1u9khwLtSLaLzRbpPQozswD81ijEnkr+s3NF0Hd4YxZPM3GZ19qtcheH
 XWZWiHntLWGrgmGgsd1CZgggmo/QdS0rKblIlX02EL+MhDYH8oyFe53ZL3QpC9/NDR+N
 mtopl5+1Wg5tRW31uIEGDPIM46kixT5otrLyHXEc2hpsGR2Y7hup3UJaWjWwuWerPxrW
 ApMAJdh+B2JERvn3QPlq6NziA8MqAXzsLmh0Cm1/QvXusEAhW1zf/5Tp5gnINWc94poJ
 nHvdXII59jt35egpC6W1aW+cXYVzC/ZNYvlB+GXm7h3MtCUDxJPvjTB2n4BRvZga3XoT
 sjbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eKqsDO0E1ZM6LTo/fHXJQObK3OXWVJR9VdLIbabYayALH3Bem5rDlShxglL6h5kVa6pkYp0Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyH/0kSOcVQxxJ9qlSo+XAVUEPcc+qA5yTPI5QwibncD1l3spaO
 sJori5D22Z0ffLWHWIEwhcp7P+gZDtT1t6XCmhyigcvG7GeoblXy4wOfSIf3cPzZlrg3Lpbo5lg
 BIMzcO1YGmL0wgcjKa0+/2X6k7IYjWNjt5N5oOAl+JXSGRypNcYc4Q6IOWbc8dQdk7MHStd8=
X-Gm-Gg: AeBDietuQoib7/DZ2SCc5aUW8725BZPqr1L1z9sBarDzwfpylFB+jAowYGt7wlOKVty
 bygBkmrvAf3PDcRxVveRjG62YvlN++sJloAmDmilOYyP6UVhZSzaIAx9BnmvgIB5HkcT/SJFEjU
 VqPlMzSXfIDbZI+E7NPm1Bv9FpFsGBi4W84I8cz3np32PvKi3saP6lj4BYwppVJQxSZ+kJ1LOFO
 PNOaafpsL+ynBEk3ARgMA/dB1FQMM8Bf/AXzM+BFpdGRcqhLefNFWk6gyKv2NjqKlU+bxKT6n3b
 F3d7O2L8CV0F78T4w8PJYBO4qotctnYUfB1ewAPiNfxfF6C818Yz2UQynuBxCXOY1ZaPQcD1UcE
 ZbRJ8XE7TRORDaFOvyFDIgLPwEDZ3Q1r2GvgbbfmzmD62BkRkIJEm9eA0u7H+y4K2MEqGvwpYOd
 +hPXdwtftKPkvWseH8/isypuPUwGJQXPFon1X9FzQXKRT7TxALWs6e2hQ2rk5y
X-Received: by 2002:a05:600c:8109:b0:488:c530:48a0 with SMTP id
 5b1f17b1804b1-48a77b24190mr60865655e9.24.1777386533722; 
 Tue, 28 Apr 2026 07:28:53 -0700 (PDT)
X-Received: by 2002:a05:600c:8109:b0:488:c530:48a0 with SMTP id
 5b1f17b1804b1-48a77b24190mr60865095e9.24.1777386533242; 
 Tue, 28 Apr 2026 07:28:53 -0700 (PDT)
Received: from workstation5 (ip-176-199-115-125.um44.pools.vodafone-ip.de.
 [176.199.115.125]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a774c3ddfsm46391335e9.2.2026.04.28.07.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:28:52 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Javier Tia <floss@jetm.me>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] .clang-format: add U-Boot specific for each macros
Date: Tue, 28 Apr 2026 16:28:48 +0200
Message-ID: <20260428142848.48156-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Formatting via clang-format is controlled by .clang-format.
For each statements should be formatted with a brace at the line end:

    for_each() {
    }

This requires clang-format to know that the symbol is not a function
but a for each macro. We use some for each macros which don't exist in
Linux. Add these to file .clang-format.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	search all directories (not only /include) for definitions
	sort alphabetically
---
 .clang-format | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/.clang-format b/.clang-format
index 48405c54ef2..e86a17da147 100644
--- a/.clang-format
+++ b/.clang-format
@@ -748,6 +748,57 @@ ForEachMacros:
   - 'ynl_attr_for_each_nested'
   - 'ynl_attr_for_each_payload'
   - 'zorro_for_each_dev'
+  # U-Boot specific
+  - '__for_each_child_of_node'
+  - '__usbhs_for_each_pipe'
+  - '__usbhsg_for_each_uep'
+  - '_for_each_zynqmp_part'
+  - 'alist_for_each'
+  - 'alist_for_each_filter'
+  - 'cvmx_coremask_for_each_core'
+  - 'cvmx_coremask_for_each_node'
+  - 'dev_for_each_property'
+  - 'dev_for_each_subnode'
+  - 'expr_list_for_each_sym'
+  - 'fdt_for_each_node_by_compatible'
+  - 'fdt_for_each_property_offset'
+  - 'fdt_for_each_subnode'
+  - 'for_each_bin_hdr_v0'
+  - 'for_each_bl_params_node'
+  - 'for_each_child_withdel'
+  - 'for_each_console_dev'
+  - 'for_each_ext_hdr_v0'
+  - 'for_each_label'
+  - 'for_each_label_withdel'
+  - 'for_each_marker'
+  - 'for_each_marker_of_type'
+  - 'for_each_memory_map_entry_reversed'
+  - 'for_each_mmc_mode_by_pref'
+  - 'for_each_opt_hdr_v1'
+  - 'for_each_property_withdel'
+  - 'for_each_sd_mode_by_pref'
+  - 'for_each_supported_width'
+  - 'for_each_tpm_device'
+  - 'for_each_w1_device'
+  - 'for_each_zynqmp_image'
+  - 'for_each_zynqmp_part'
+  - 'for_each_zynqmp_part_in_image'
+  - 'mtd_for_each_device'
+  - 'ofnode_for_each_compatible_node'
+  - 'ofnode_for_each_prop'
+  - 'ofnode_for_each_subnode'
+  - 'pko_for_each_port'
+  - 'sfi_for_each_mentry'
+  - 'ubi_for_each_free_peb'
+  - 'ubi_for_each_protected_peb'
+  - 'ubi_for_each_scrub_peb'
+  - 'ubi_for_each_used_peb'
+  - 'ubi_rb_for_each_entry'
+  - 'usbhs_for_each_dfifo'
+  - 'usbhs_for_each_pipe'
+  - 'usbhs_for_each_pipe_with_dcp'
+  - 'usbhsg_for_each_uep'
+  - 'usbhsg_for_each_uep_with_dcp'
 
 IncludeBlocks: Preserve
 IncludeCategories:
-- 
2.53.0

