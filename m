Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0109DC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 12:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB15807D9;
	Tue, 11 Mar 2025 13:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OWjFRZs5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38E4A8083E; Tue, 11 Mar 2025 13:31:34 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EC7801BE
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 13:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso18336935e9.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 05:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741696291; x=1742301091; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=91YDrttUK+cMyESFf/N4o+bTAUxrDceaCEOkS3G1KLA=;
 b=OWjFRZs50rIkU/hHJCxHXpST0eBLhhPFnvEPUiY2c6s5EFPdCLGgHZBgYseZ/ajaXU
 r2EUjfnh7KrJUcQNQDlFSM+RKvcE+ruKwpWsl8iDBtgU9AJtPQL+jjQ0Gpcv3Xg0B9Es
 8nxkukFOf/IfPxF7GxOYR2GNoZ1AGa12N7jJj2RIiPO8w1fG0JR4p+QxIz67IU6U+V7Z
 /Z6Q2zX0TBe1E3CCzCK24X3Z/bVt4LyH0PaS5cZGE3l7ZJHy2PcQjpRUmqFwvqo3LeCN
 /H+C3volPy7jzvkpt9zeZtQLI/Qc2OWdP0NQ5IhW2UhaC+LwVpyLJKh2jaf8GwoelW8P
 6FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741696291; x=1742301091;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=91YDrttUK+cMyESFf/N4o+bTAUxrDceaCEOkS3G1KLA=;
 b=CLFNMXsuuK2Jeuju8BVTHxkAvQtlANuY2HTiZZsGmqoXcpHVixGrHcciLdqh5k5QUx
 UUqKJWv/r0BEcsW5S4eZul+D/Cw+6H4fUwBDtl3AA6C2XfzpDGZSp1ZVlVFRitQPnIb9
 53Y75wfyz4MZoMIg9t00QpID6/heJwNJwQwY1m3zDyN+aMyCDkBcgC/wAfm1BJsVsM68
 msdz0DOKmSiDOvERfWRrSASJ7cB1NZR1DyBcB8dszW/9XQuaMAmIFl5ESywRUfxUZwmq
 OluirQ7vxmir/CZwNUWLh2A+D3K455xXHkkMI//bCZTvZcOgnoUapc9WKpyeJHX90N1r
 6mhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRPTe5hirFD4EtsO7XE4w2uAB9jnwbWQW/TvAHSx2CRtGuTnEhiiolPMs9MZ6fyoNBKtx2tE4=@lists.denx.de
X-Gm-Message-State: AOJu0YxdWV7hyRuH7PZt96JLg3vV28HpDi+PNX3jZSeF07RgLjCeO7Ev
 L6/aaGi70MEH+d5rdOZ4n3VH201IJWZHZQ4v04fYTYLNljWnEurNTqmcaWLVFOw=
X-Gm-Gg: ASbGncuX+ySI6HvyX50N0SoJ2eO/ugZifPD3YfgK1S1GWPPo4M19i1lGdVCUCF57xwA
 yfcpaZCRaj8XAGhrhF3+TL83m+XUggx7lrDgNeymdjkfUt9z3sSw0ku1uVbgpOCZPUlrA/hS7Gk
 dy7Ou5MJAD7AQQD+UFRL+rKChwa6mgpmKuk4KXhglbpRINsweQiqyfBlhTVruW6SLefiub7I4oI
 u/Crechwl7jKPMiWeBRTi1VpCw782xKASyBA30hyLCLiPVlVUvsFOOn4nQmpz6k3osL570Vpzm8
 5DyxK539DHZ1kGbCGtXK+WVa6YII8dNYzJCIiVxw94nfvxp2eIGwotKnm+NUI/CN9tYL9T4B
X-Google-Smtp-Source: AGHT+IFnLuo8nYW+7TX/Wxq+b+yu5FH1tqoLoSy99L5OwT6th8iM8gzotL0AqhgmUM447n8CDpkspA==
X-Received: by 2002:a05:6000:4182:b0:391:30b9:556c with SMTP id
 ffacd0b85a97d-392642b52b9mr4251459f8f.21.1741696291029; 
 Tue, 11 Mar 2025 05:31:31 -0700 (PDT)
Received: from toyger.rex.connolly.tech
 ([2a0a:ef40:1d11:ab01:f578:9a7d:3957:bef9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f44sm17788586f8f.76.2025.03.11.05.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:31:30 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/4] Better smartphone support (Qualcomm)
Date: Tue, 11 Mar 2025 12:31:15 +0000
Message-Id: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABMt0GcC/23MQQ7CIBCF4as0sxYDlLboynuYLhoYyyTKVDBE0
 /TuYtcu/5e8b4WMiTDDuVkhYaFMHGvoQwMuTHFGQb42aKmNtK0ST8cPsQSOmIUb7Mkr47HvBqi
 PJeGN3rt2HWsHyi9Onx0v6rf+d4oSUkjbK4PeW2y7y53ilPjIaYZx27YvNM2v7acAAAA=
X-Change-ID: 20240831-qcom-phones-c789d14de657
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=uC8NxjPoARpRf/DomQYNWvJXdqWgN6r/p6e4auWUb1A=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn0C0h+5BvgmAzyYSX6SRys9UUT4GK+HcB4NIan
 8ReOSjvTseJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9AtIQAKCRAFgzErGV9k
 tn2YD/46yLtSfORVS5dgJVPj9vn9cauDTMfryFGSbcgHnxrzUTLNr4dBCHYJATMO5ElDZCBW1mr
 FIdRpe3Ed0lFlD4MAiBV3ocDhY/p3zE5p4sHG1CLPtvPY9IN89W2OLTxnXxb2dS2V0UnJVq/ykA
 bpbmCF5FgSTMbDUOJhZJ4pj4tnZD8/7ii5EoCz+Cj8XJCOcb+ZkY9cZKFHtz1pCpDYGBJnEKfeN
 4X2LIB1Ew+pqe3z/sja7+o1NogksJFEBvpno4F5J/Clf9RftBEO+PMRDNzH1vi6Ukf545ULL6RQ
 YlC1bLMyXvmOjocYsfsUmGvCYJw/M2MoKjObpGWBMp7qhICvhtDAtBLPUgRCvTY8xtMMiZineFk
 GY4smxch81PjnCQHOTbXqDj5IK0sm7r6x3XTaBfsYcQF4ndQMKJaimQshCpe7DEuj27a9VdenAa
 VCds/wmQu1WIm9cigqPH5IKkRci3QT4Y3EZdOUu+mAXvjDFkWFmdqlRB8b2OKVLLmBM4wzdUTFE
 xKNc7VbVJmiMJpxYQhfj5Ig9eC70wWmm4eaNkd7n0++YwxFV8NEkTMjL8LaCFNhryprn7/ii+++
 GVeF33J+L3Z/DH7fbqtVxIsv76VYLZrrpt79NiLkdKuy6FlPUypGltfqAoWkWlsQ7AM/As+9+k8
 270KDFSK3NCBHXw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Improve support for running U-Boot on [Qualcomm] smartphones, with:

* A boot menu which can be entered by holding power during boot
* Hang on panic (so errors can be read on the display)
* Serial gadget which can be enabled by holding volume down or via
  boot menu

In its current form, U-Boot's boot menu is perfectly adequate, however
once an option is picked U-Boot will never return to the menu, always to
the CLI.

On a phone (with no keyboard), dropping to the CLI effectively makes the
device unusable until manually rebooted, since there is no way to run
any commands...

To rectify this, let's revive CONFIG_BOOT_RETRY for the hush parser and
add an option CONFIG_RETRY_BOOTCMD to run the contents of "bootcmd".
This provides for a flexible menu system which we can enter and exit.
See qcom-phone.env in patch 1 for more details.

Finally, provide some rough-ish documentation to describe how Qualcomm
phone support works and outline some debugging steps for when UART and
the framebuffer are unavailable.

---
Changes in v3:
- Minor wording/clarification improvements in docs
- Introduce CONFIG_RETRY_BOOTCMD rather than changing the default
  behaviour.
- Enable some more gadgets in the phone config fragment.
- Link to v2: https://lore.kernel.org/u-boot/20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org

Changes in v2:
- Fix CONFIG_BUTTON_REMAP_PHONE_KEYS name in qcom-phone.config
- Add Tom and Simon to CC
- Link to v1: https://lore.kernel.org/r/20240831-qcom-phones-v1-0-08614edd8e35@linaro.org

---
Caleb Connolly (4):
      board/qualcomm: introduce phone config
      cli_hush: support running bootcmd on boot retry
      bootretry: check for bootretry variable changes
      doc: board/qualcomm: describe phone support and bringup

 board/qualcomm/qcom-phone.config |  17 ++++++
 board/qualcomm/qcom-phone.env    |  49 ++++++++++++++++
 boot/Kconfig                     |   7 +++
 boot/bootretry.c                 |   2 +
 common/cli_hush.c                |   6 +-
 common/cli_hush_upstream.c       |   6 +-
 doc/board/qualcomm/board.rst     |   5 ++
 doc/board/qualcomm/index.rst     |   1 +
 doc/board/qualcomm/phones.rst    | 122 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 211 insertions(+), 4 deletions(-)
---
base-commit: 78f8c8c58f7d3f7c3a26af4afbd08aba21c14c90

Caleb Connolly <caleb.connolly@linaro.org>

