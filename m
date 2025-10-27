Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB09CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 06:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A07982A9E;
	Mon, 27 Oct 2025 07:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vTq3MU/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 212F4836D1; Mon, 27 Oct 2025 07:14:59 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 923DC832AD
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 07:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c281c649ccso3020001a34.2
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 23:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761545694; x=1762150494; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnJzmaBzffVAA7HRW7dYtCCdyhA+rArqBmFiPILp16E=;
 b=vTq3MU/R+/jKmH2AirR5NHWDj4fqKxWnxXCIq3sO6VEUTMVmzfdJ//Tflk5joOqN6H
 T4SePd2sJMiFHc5SjOjDOFGE+sTWBFhCr7dGniqGGbwSSRYSqnT08Fgukx2D79BumkeV
 +4hZSqfxBM4420pJS6Q+PCelVxEzSkBAuXBiFqmcpudI7qO4d/EnHwHFeNOtSSa2+lH6
 P53sMGIatsfgi7W4q6GPWG/aE5w2+My+wYE4uFfx6V3BSjFPtLYsHMiD6oe9ZnNNonPP
 nLaEfDVdyn582Lt9id1dNXUGA2xD2t50RDnTan6Q5HMhaNv5a58P8dKZfv8nuYJwQ2GN
 64XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761545694; x=1762150494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JnJzmaBzffVAA7HRW7dYtCCdyhA+rArqBmFiPILp16E=;
 b=EgBCuH2ncgyIqg6nwKZLcKJjpgYlnaIuue0xQemIn+uNpnwKWfj8UL0AMPkoOFjq6t
 m8Mv+oOQ11BDEkOqwizZVdblJrmZIUyk9zk3eTt/lO60po4YKyey5uJNXClZrlG/z76i
 zBcQmEuMxL3hIwOJE4bI6txVZhs96nrxWFwuNS3en+6PwuIv5hd9XFVexvEvJkcx4LaD
 B9nJ2VLqZg6L1uAGUbEmjkikSQtvBY2flJVvME99lPxYTxeNJWoCEv3fE7XdSwtdEz+c
 dp2zFWxuu1k4tODHrW2fiPOv3qjXtY3mNF/lAjzukVg+45sIFjARSPZliITK9liOqhZk
 f2zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt4zE91L7lCLXJHBNZzdVx9s6yxRUzwpLboqV4BvpKLwFSemmu5u9i2OqEBQ2ah8gM/ZLAhXQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6lIqAfTNRmGmq2lMAkXitprEF0hfixQlv4HR29gg+yX6KnfYf
 0Zo2yAQo6jjY6kuo/hw1WyhrDPJBsC2HhMPzqNd4L/ieZ9q9CLUlDmN9juPyfVrinio=
X-Gm-Gg: ASbGncuEMsTNL5bmmDHU+W00BC2HRAzobrA5Cklrh/RNTi42iVf7Txi3C8uv2TxxxMc
 ay8IV739VYYOAluf+buvDeUIm7jWr9+E2vpZP4TOzrPnE6G2atCm9CVQDd03ZMv/XqMhjxdR9fn
 qlbEBcPUfsuS3LvkT7F7z4S3dazZHiiUu5dz3DaQH0sonL+15myKmiP9bcagWLMH5ttWGT6GnPd
 rUXZRDt9pH4j+7tw0uOdB0eWkqsp9oU7yIK5v8y5048bfuwI68hjq1wuhZhyhLZwWC3ERcnfvTF
 hK3IIiPgFtGJx5VZtH+gs+W80XM4XO2ufEABBhswVbbUkEVtyjFbny+ILtdc8jTFKsRFuohd1b1
 qw721Qv3FZKBLRTmFiASLSCvkTRqWimfdU8YPk3HYVqzCGSUgUW1UEFAEr3HwfF0TMhTmkHkm9f
 dsDDen9ikeMA==
X-Google-Smtp-Source: AGHT+IECxBuP8VlSIFpqUThj8sINhvTqAAL3lEFsvfVlvyDZduDrWVvntXnmO2hw3WTQYn8fE7xsKQ==
X-Received: by 2002:a05:6830:6013:b0:7ad:d568:6e60 with SMTP id
 46e09a7af769-7c27cab380cmr22011016a34.9.1761545694327; 
 Sun, 26 Oct 2025 23:14:54 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c530136068sm1981013a34.13.2025.10.26.23.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 23:14:53 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/5] board: samsung: e850-96: Keep public functions together
Date: Mon, 27 Oct 2025 01:14:48 -0500
Message-Id: <20251027061452.21165-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027061452.21165-1-semen.protsenko@linaro.org>
References: <20251027061452.21165-1-semen.protsenko@linaro.org>
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

Move DRAM init functions close to other public functions, to make things
visually distinct and improve the readability.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none)

 board/samsung/e850-96/e850-96.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index 3df241edde2a..34e01914032c 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -77,16 +77,6 @@ static struct acpm acpm = {
 	.ipc_ch		= EXYNOS850_IPC_AP_I3C,
 };
 
-int dram_init(void)
-{
-	return fdtdec_setup_mem_size_base();
-}
-
-int dram_init_banksize(void)
-{
-	return fdtdec_setup_memory_banksize();
-}
-
 /* Read the unique SoC ID from OTP registers */
 static u64 get_chip_id(void)
 {
@@ -166,6 +156,16 @@ void load_firmware(void)
 		printf("ERROR: LDFW loading failed (%d)\n", err);
 }
 
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
 int board_late_init(void)
 {
 	setup_serial();
-- 
2.39.5

