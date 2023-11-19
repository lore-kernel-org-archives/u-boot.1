Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D142EC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 16:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE298715C;
	Sun, 19 Nov 2023 17:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="cIG97sq5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5D386F1A; Sun, 19 Nov 2023 17:56:18 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3800086E95
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 17:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40839652b97so8602795e9.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700412972; x=1701017772;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EnYlzV8ctq5nJ9RqIAl8kRF+frXsxJk8HiE3UHDcT7A=;
 b=cIG97sq5YufNxqan3KBUeSNCJ/kX8Tu+C5ZIkLfFhSG9N/z5oBDSJSWpT2xgJSMcPj
 g3AC7gUadcrr70sITL0ELDhHKGnPOsDdAVq4cq0zu06Pb3bRh/+WsQzd+ykqp8k29Yyd
 +ecfNdheeS12s+RzY1V5vVvQsjLICbQwvnBacBuDJId7OOSyBESNZ0/6E6Z0Ob0UYTqX
 XM13Bm73FSO+50Y732L3oRqVva2t6+XXTuIqR3v8qIjaDFQdmHajclIpMP+hvOlkBESe
 72scJ7heAjlB3AWSaIvhZL3WVE0OYDsgQZz3rI1S4/lyAk2+9sNYMx9b/pDiOtqxvZOF
 SdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700412972; x=1701017772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EnYlzV8ctq5nJ9RqIAl8kRF+frXsxJk8HiE3UHDcT7A=;
 b=uJmLmkzUcPUS0hjvJXx46SNoaCgODuWXxKAFmJ1ipqkkEvDxtB89QtKNjfZTVk0Gk8
 UFMdY0hAnPeaV12lWw+SJ3hJnhvJ3XRkN2lyqHhZYfYncdpn4iCmsyTS5/5q1d+eZngj
 inyFIOh616HTe9KcgcQkp2d6iNVlKYgpCAU7BR1V81KXG9fs4Y32ebfUSH1ueE+uUPZ1
 XD9y0AERkzDh5TadKAhNy1gFZ3fH9x7ko/yCttnOIvjhsfbXi//z1CTAPE6CbzJVUyrF
 QybwMcfNS2inZKsBEE5vVOihcuvWFMbSRbmJwC3OSiizFN7SXpSVDWoVjz63/mP4RthD
 HJfg==
X-Gm-Message-State: AOJu0Yy2MrjKISdiOGPysjm8qR1emO3PCR9v+fJB9uN6wDOP8Nf7b6bI
 mGRVmhLYYvNSTwJMpfSKWyzmQ9i4sWUiruf0L0MuTaSa
X-Google-Smtp-Source: AGHT+IHshJoo9zyx5GfBeinTT495sG5oE7GdYDMzqaVaYTjU4Z8HtxXxShUetfDfZ2hS7OCqm5icBw==
X-Received: by 2002:a05:600c:4510:b0:409:6f6e:d257 with SMTP id
 t16-20020a05600c451000b004096f6ed257mr4939638wmo.17.1700412972053; 
 Sun, 19 Nov 2023 08:56:12 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 x7-20020a1c7c07000000b0040684abb623sm14483754wmc.24.2023.11.19.08.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 08:56:11 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Shantur Rathore <i@shantur.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 0/4] bootflow: bootmeth_efi: Fix network efi boot.
Date: Sun, 19 Nov 2023 16:54:57 +0000
Message-Id: <20231119165501.1305136-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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


Currently bootmeth_efi crashes while doing a network (dhcp) boot.
This patch series fixes issues and both network and disk boot works.

Shantur Rathore (4):
  bootflow: bootmeth_efi: Set bootp_arch as hex
  bootflow: bootmeth_efi: set bflow->fname from bootfile name
  bootflow: bootmeth_efi: Handle fdt not available.
  bootflow: bootmeth_efi: don't free buffer

 boot/bootmeth_efi.c | 36 +++++++++++++++++++++++++++---------
 include/bootflow.h  |  2 ++
 2 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.40.1

