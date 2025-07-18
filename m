Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35263C83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 14:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5920D836AB;
	Fri, 18 Jul 2025 16:17:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tHUykX8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72AC9835B0; Fri, 18 Jul 2025 16:17:06 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61B13836D1
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 16:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4ab92d06ddeso29813871cf.3
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 07:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752848223; x=1753453023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3a41LTw8Z4/DKgAapyekLwNqa14G1EiEsYycnj4caw=;
 b=tHUykX8JAXj4ug/LmsSDNsmizQDQNTUVNOTwhBI/Xxie8oE0ZyNqX7Ok0++Vo/hiCb
 oExb4R4tg+1RhBEak4PgylEQC3/RPOlYUQUo/swS8xTrTwf7+cblQZblfuUpcLrTyE0T
 nW+2d+UvmPm2zJupV5hnEi52Soop19mH4VVLqAxaigUXmXBQTbf/k09jbc30IzCP6jus
 q97eg/9TqFgX77jovr419ga4zOzmge9Gf+OaizCxeC8VkL5yto+nMfWdKGYTH1ZB4Ohg
 RWDSS6YoNsByAokbzrJUYlBgdNE6w5BpLKUFTNsOGEAjNv9Rwc3rW+7ao8WSBE2niwKC
 uxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752848223; x=1753453023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3a41LTw8Z4/DKgAapyekLwNqa14G1EiEsYycnj4caw=;
 b=Lt37B/2mtQ6TCcO+hQqWAo2NB002L8WOomhKS+5V8TMd/GVoKDCG+zzxl75lNvTyVI
 rtGwKoqN5d6/ioq5xWdprotq8j4EsRW+sVosad1gpzp/V7fMb0WR0v7V9A9M+nuns5Zn
 S5P6wQav4q1cgOTwTipcYugbk64cuhMUMIKi8SzYG5aJ/VZ2dsB021ZSMKnen+e3u/uN
 mdm1Lx/Uo6IgeJgqvvxQWV3BTrq/vJHCK3zmemx5Lh4/FCqZ12B0SVwIJtfthS7/qL0f
 9T/fLZHq8UC4S34v2dB9VOgmKfDGQQ1pqZ5mI8CnkhFeXxotuL4K8BICtsraAZNVLA4X
 b3Kg==
X-Gm-Message-State: AOJu0YzPhsMowxdtAxkCHcXCBe0s6gkQa5jG3BB5LNo/P0u+VpER2wpD
 AtalSlq3kaQEh7fepmybrO7J4ITm5AfyfxqiaP8+NXt6ZAbUzjdwbK+a1TRQYLR+dWk4/xBVdJ8
 nMpwU
X-Gm-Gg: ASbGncsWiMFBxHSkHlbPFVL0a5wEdRR/CwVLS0FFf/QmQTUZhAPcKdZ+S7tJS3e803F
 hZTsaxagWm3JSxbidd00n5e/yqQ0slvy2YSWlbaHawrZzOyg3h8OrDcuqPmCUx55ywyX4tfeDwt
 0m7wzCQhSkjOGkJfb6V9xCsoX3Gk3PujtcIFySUsGBcOBQDWHGODtIkU927Xk7CM9gulmh1MzHm
 pHfEiD6OaLHAOrCrHRLd+2bc0au8cyXmeLCXV0zDzCVZu5x/7TqhkffyPW6YkP73aRa0rFtXg0A
 TobX93DOvRZtjIKxITu/Gyy10fHyTFOyZL2zLr7iySQhLN6YWzh1K0Whvfdtty8LNQ7abIZRldr
 Ov0dHFB7oT6qXsP/R8aB7PnpB5hEJbMkY6Aihdvymy38RzS7N17gZYdwYwucVUW1PUjjTBewCn/
 cbkOLuh4k=
X-Google-Smtp-Source: AGHT+IE3qCzIvdkuYuQhElWCyqHaj+z+DlKkkxsWzP2KhMgEXY4lR7m3KVt+ApZpq14yKSVKhrSVrA==
X-Received: by 2002:ac8:5d07:0:b0:4a6:f518:6b11 with SMTP id
 d75a77b69052e-4ab93d8dee7mr158926291cf.28.1752848222566; 
 Fri, 18 Jul 2025 07:17:02 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb499e91csm7558341cf.19.2025.07.18.07.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 07:17:01 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 6/6] configs: Select OF_LIBFDT_OVERLAY to hand over DTO via
 bloblist
Date: Fri, 18 Jul 2025 07:16:19 -0700
Message-Id: <20250718141621.3147633-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250718141621.3147633-1-raymond.mao@linaro.org>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
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

Select OF_LIBFDT_OVERLAY for qemu_arm64 and vexpress_fvp_bloblist
to hand over DTO via bloblist.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3:
- Initial patch.

 configs/qemu_arm64_defconfig            | 1 +
 configs/vexpress_fvp_bloblist_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 39afb837e41..a63cef0c1ea 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -7,6 +7,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DEFAULT_DEVICE_TREE="qemu-arm64"
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x40200000
 CONFIG_DEBUG_UART_BASE=0x9000000
 CONFIG_DEBUG_UART_CLOCK=0
diff --git a/configs/vexpress_fvp_bloblist_defconfig b/configs/vexpress_fvp_bloblist_defconfig
index 4d52b96202b..6cd0365ec68 100644
--- a/configs/vexpress_fvp_bloblist_defconfig
+++ b/configs/vexpress_fvp_bloblist_defconfig
@@ -1,5 +1,6 @@
 #include <configs/vexpress_fvp_defconfig>
 
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_PASSAGE_MANDATORY=y
 CONFIG_BLOBLIST_SIZE_RELOC=0x10000
-- 
2.25.1

