Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7384BC021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7D7180FD8;
	Sun, 16 Feb 2025 21:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bmySZiVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3A2810E8; Sun, 16 Feb 2025 21:45:53 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FDB580FDD
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d04932a36cso34859875ab.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738749; x=1740343549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NQ+rAKHDgxXQcOrx96hJkYcuMHTN+d1m+l8YTSOAL0=;
 b=bmySZiVTA831UHr4gAkOJuMsWRyflB1d+6SufnWrSihzmgIuhF4HmX28LgQiOEY+KQ
 MGKySF0TomV6UxRZC7vBbAmGYqVOYBS5RBKugzTGk9+HbSbnW2oj5AhiMUdo/YFAk2Bu
 /9dc6uhfKy2cUW/hqAlAZm381Pg5PqmyqwxUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738749; x=1740343549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NQ+rAKHDgxXQcOrx96hJkYcuMHTN+d1m+l8YTSOAL0=;
 b=LDY59nggkf/UEF3xLf6ilk4zqoPbvnv9TkHtKPCqTypXVINcLLUlPJmdvLCaTRAW7e
 ZJIEFDDym5xHuXZkWGGz7M//T3UfCDD3kz/vZJoqgzPstJ8ATXMSrNBFxAKQhw7QrBoy
 aq6aUZCFucqcVsrJBAm4ywyJmzoP10nxR4tzJL8heqkKWSOgWnrKEsGnRrZuvC1pwOlj
 cx2N/BoM8HZG3SZJIZHOGR9P0V/65CD0swLuRlFodZw3LYEDvgN0VfAt7UwDbFmMG69G
 inGgftPTsjJCvnW6ksG8INuvoG9d+UykbbMKobwwVarHZSPulwd0RB1WSDlngI4XMO66
 Z5xA==
X-Gm-Message-State: AOJu0YwbPs8YFWhSLh/z7DW/AI4+JWHwj+2nPu8HPSRHfozsLp2LikKQ
 HwmwoOEHVz1L/8KPzr8KNT5TqBemnkKxdpcUvX1ZGXg3s+MzwcT0vEFtst0TNAkjIUaL3Px3gNY
 =
X-Gm-Gg: ASbGncuyHDXwyFknThPj+wL545VYPB+zq2YPUkW0TTKgH4h2PGJEtruXLu34vKhfzBG
 y/ubs8unznAz6kK7cqWOlVgaqL/oHa7+04AHpMaEkjsG6yWo+ZQ43Crd2ChalCNxT+m7Ajie4ga
 QpftuNfUFrQNrQWIZhgcdOe7OP2KSb/m94BR0ArQUa9pEtg9agWCKReXLJ9ZzKzbyg+FcSY99k2
 NY8Aw6UUUSCrZB0wWVmaebC7YjfDAx9l14VUr1eI+eQ4WWgRLjfwAH8mUFxZI91H4+gfWmHE6cV
 v+Yb12QmkRSEuXZSc3m7aW0riJ227P5eJdQVO4TQ9AOp/sGC74SE
X-Google-Smtp-Source: AGHT+IEmH8h+ud2ceK8dae4gkCd45L3EdHNManp62S/OFPX+iK7DigJ76NDVr7llw2RcI+L5otCaDA==
X-Received: by 2002:a05:6e02:5:b0:3d0:47e3:40bb with SMTP id
 e9e14a558f8ab-3d28076c3d7mr68708035ab.4.1739738748724; 
 Sun, 16 Feb 2025 12:45:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 24/28] scripts: Expand a few options
Date: Sun, 16 Feb 2025 13:44:09 -0700
Message-ID: <20250216204421.3560012-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

This gets the script to where it can boot with kvm:

- Use -cpu host with kvm so that the host CPU is used
- Show the full QEMU arguments

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 scripts/build-qemu.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
index f9ee0072573..03f06105246 100755
--- a/scripts/build-qemu.sh
+++ b/scripts/build-qemu.sh
@@ -93,7 +93,7 @@ while getopts "a:Beko:rR:sS:w" opt; do
 		extra+=" -netdev user,id=net0"
 		;;
 	k)
-		kvm="-enable-kvm"
+		kvm="-enable-kvm -cpu host"
 		;;
 	o)
 		os=$OPTARG
@@ -150,7 +150,7 @@ run_qemu() {
 	else
 		extra+=" -serial mon:stdio"
 	fi
-	echo "Running ${qemu} ${extra}"
+	echo "Running ${qemu} -bios "$DIR/${BIOS}" ${kvm} ${extra}"
 	"${qemu}" -bios "$DIR/${BIOS}" \
 		-m 512 \
 		-nic none \
-- 
2.43.0

