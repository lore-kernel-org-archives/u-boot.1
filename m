Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E6ACAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 19:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199B183855;
	Fri,  3 Oct 2025 21:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ijSsLhbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D49138386F; Fri,  3 Oct 2025 21:19:51 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B859883855
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 21:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-91f6ccdbfc8so138021739f.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759519188; x=1760123988; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDmED1920y5Z6Ple6Ml/5KorGZto/2xjS2qKP78q+B4=;
 b=ijSsLhbqAEMvN1zMCWB5Oxjm4QX8GYx6MVaZLfwofqSWuR1N1xRAx+Bd2POz88ghnC
 hRJ/Dsg7DG+75RCNIgE16huQpV75zEr2lLtaDYgwHdpWyacebOoQtlTHd9ZdORLWiTwI
 QyLfzHX9YKkHcwrIPrEX9XLyp9XnLs3Thho3GOtSN8vNmoGk1mCi3NWLvasnArw5BjIk
 HDVoj+tC3fIs34K0la5qkYZRSdV9rJMklrSxci4vTZE0zBEdvRypw4wU8tS0FPFtgc/f
 5a+5VrFIgHOPEcEjI7saLXcvki7qmH2iW3kEtS91sypq8PDq9898zGbZj8AH0UzpmlIv
 78Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759519188; x=1760123988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDmED1920y5Z6Ple6Ml/5KorGZto/2xjS2qKP78q+B4=;
 b=tX/wKTRKw394n9vK0JEWbDIU6U1PX5+ZCaK0DNQLJhmU8zfiQYZFmEiDPeTvmgNt3c
 xKDl/dX+Y7ewvTVqm+f8FJ0pQuoubTCU7XQsOT0mcbo0UdxmGKInwGeTZ7C8AXiMtGmr
 obu9ukzlHT57WuuGccrJGsZMvAwMYL0gd8XFcitIfRYCkxbPijr/+UgLhOXLmGrKCd5G
 pbwOhZO8U3Mrj28W1hW/4T2/ehC//W5djmkezAtsDP34gZEaudsFX+2LPpgMH6UxzEEU
 yAVR1WB5wM4tziTJKzy4h7LkH+kbMQjP2F6MFpjYqvLTPFiyeNf98WogEgXm6kcVBxGD
 WWOg==
X-Gm-Message-State: AOJu0YxtIfHP9ky9ktJg7omnKqjm+67RuQzSBIcneOzMZtbeZKtmpHYX
 jx6lkQ10Pe3JK+oLvx+59rt/LN3ZjDpOVf/5KdVx2yiNXFf7MQPwuFfDLrF2+ccgswv1nZSCWme
 JfWor
X-Gm-Gg: ASbGncshXPdpjyTBiav2O6GpfyicRI/uESbM+fIB2sQUE8nFq1xKun3rXODgdaG1PlU
 Vx9a5Cjw3ibqJHuJMUOIc9Eos5HyXjmykGfVe/3SuEtxqi/1ODUoKEhTrXxUECmP4oQTALs0MoX
 jghjn/AtUzlX5zeHeYHISZ8Nw+Nj/JbgokDFS20lOm1uMUGMBXy0YaL1mSTWqmWdmJB0uLQjQIe
 uWokwU6atvirjShKP241iPzWSpU+WZrmfCH33LhpTfKX5AIm6U0etSSXwIyxppcFCAyT4XmoMWF
 5sATMw7SzvF56QuMvTVL0Y8hwf4Xv88tU4518oV8REV3u1kXyZBJl8g59dITCLvtXIUIprFvY8i
 y4cO7sfZofCWe6JlB9bUSzAF8e+BmFFjuz5u2lyCcSRqR7Nx5kKT50SLl5WHqfBKPhu/XWpJfje
 NgJ7hAOItW
X-Google-Smtp-Source: AGHT+IEB61uid8dbbBy+afZu/9uKBLWGK+fBUh41gDQqpBP/IyGvO4s/0CrZ5UnvLeoT+MHy5wE0dQ==
X-Received: by 2002:a05:6602:158b:b0:8f3:bc41:1ab with SMTP id
 ca18e2360f4ac-93b96a6c116mr537547439f.12.1759519188094; 
 Fri, 03 Oct 2025 12:19:48 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a8912bfd9sm213794139f.25.2025.10.03.12.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 12:19:47 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH u-boot-test-hooks 2/4] bin: Run the conf without board_ident
 as default
Date: Fri,  3 Oct 2025 12:19:11 -0700
Message-Id: <20251003191918.767698-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251003191918.767698-1-raymond.mao@linaro.org>
References: <20251003191918.767698-1-raymond.mao@linaro.org>
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

Set conf.${board_type} as the default config when no board_ident is
specified. This helps to reuse a single config for multiple board
identities.
Hense, rename the conf.qemu_arm64_na to conf.qemu_arm64 so that it
can be shared by all qemu_arm64 boards.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 bin/travis-ci/{conf.qemu_arm64_na => conf.qemu_arm64} | 0
 bin/u-boot-test-common                                | 6 +++++-
 2 files changed, 5 insertions(+), 1 deletion(-)
 rename bin/travis-ci/{conf.qemu_arm64_na => conf.qemu_arm64} (100%)

diff --git a/bin/travis-ci/conf.qemu_arm64_na b/bin/travis-ci/conf.qemu_arm64
similarity index 100%
rename from bin/travis-ci/conf.qemu_arm64_na
rename to bin/travis-ci/conf.qemu_arm64
diff --git a/bin/u-boot-test-common b/bin/u-boot-test-common
index 2c3b476..0e443d7 100755
--- a/bin/u-boot-test-common
+++ b/bin/u-boot-test-common
@@ -32,5 +32,9 @@ hostname="`hostname`"
 if [ -n "${USE_LABGRID_SJG}" ]; then
 	. "${bin_dir}/${hostname}/conf.all"
 else
-	. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+	if [ -f "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}" ]; then
+		. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+	else
+		. "${bin_dir}/${hostname}/conf.${board_type}"
+	fi
 fi
-- 
2.25.1

