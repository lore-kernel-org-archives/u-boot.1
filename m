Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901D606A31E
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bId0KxK8;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ec5RT0kl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB25F40A3B;
	Fri, 23 Oct 2026 14:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bu1_QXyVTze0; Fri, 23 Oct 2026 14:55:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F6DA409EA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792767335;
	b=T4QKIcEJhfHV36+vNdP/+veHS2jzlaDUA0lVOkN+JGS7Vu9P+kSTDpVkfUlScKyAegHK
	 56lIY8pyshoRCuYkqPtJ1df5c2MwcAoRiwhf8HCZVzdGPLr1xGOEE+TEnCUO0wPJj3ELw
	 1AUS1AgJNqr8pyXhjBw+SO5mNs9ZL0qpg0n/MCQMtqKgE4cYcpWp3mz5Gv3XDbRDvYXE/
	 Qx/Ygn42neQcrjEyl5ag09Aer+1PDpNCF0HxOsWz14HqWK5op5RlJRxI02kFMzR8dTfWb
	 rTiiulbGTZEbIyUrrkjdHV/aHL6JKwQV5H2MlIQfabEaUYSOm8ab8/jnA8Uj1ZSqEOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792767335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zbvLi6J+J45aztiqIkEjCYybtWY5nxvv4LQze3T3N9E=;
	b=mriYasO4z25Xz0pRLRE+cnNnK/8687WyMCh0kaB9KZ75BxrhPUAioDDOoSfV5Nm3JePO
	 2zPSzW9fThKSSdYfAGiwH/TbH83PSrURKrMeMlKuXbCNC0PDVanUAQuM1V2gBXVKLu+of
	 fuaeimX1jr2NEtoJ67mSLzIIsDV1WILdS6+nUM/oi7qBHsi741upXIcRS83rQQqvpCrK1
	 RPa8bFSh7w672JMrPu/w/gUJMDjILrYv3Z8x0Zio+1qlokT8TF9bMe1L1IDxuceLRlRHs
	 vSTCyGTj/TF20gsFsmtxiew44A7r90AWqnPY4lTSqLgon8+v8LSkO+I+maVLU9guG5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792767335;
	bh=zbvLi6J+J45aztiqIkEjCYybtWY5nxvv4LQze3T3N9E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bId0KxK8ykz/z1xbTTregao4UoeMjktMNd9xFR+ENRWxeKETEch5JtZgA2QBWPbHo
	 qlljw1DwUtsDwXF4A5uFJdxWyLkyUt5d2OnAt0jotx0JkxRZktMmAOlhq3wuMPUXkd
	 rjwq9VRBTbtudP2KW1O9p947Jc+ydhTUYVIQJZHsuLKpKcWmOwuqsP7MaZbmvTdCld
	 X/xljPAm2Py5QC3d/qiyNNYGUVkm5WlwYlb/6R81JnE1ArQusW5oShNdT/rMs1aZpI
	 DuxreF0FyAJNE78skMCcSWoa/cD05wlCSZEFhg4f8C4HjKfOYROVUUmjHJTu0AbxpG
	 6YDW1zti2RZwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F6DA409EA;
	Fri, 23 Oct 2026 14:55:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 14058371
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE6D460709
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:22:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKxkfI8SHw6f for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:22:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 197BF60668
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792761761;
 b=LSCf9MIaDKicycs0SCIKEZDGe+9Jjv/1j/jeBj66NRUX3L6EzaoRDUZtas+jOj9lxjvU
 W8E6pbxqvi0Ztior9oSo7iRdcdI7mMIgZO7vvbPBj5IyDRZf9Xt1N/EmRcE7obf+m7/JE
 2kZ/xvSIYDOmYBeVVhus+wH7w9YLbEQkbyfqj2BqKecbu9eoaaLx56ZcEzDx28ugWGw9N
 X5vDIJbuZf44zMPRxBh0qBZUo1+k2u9YoYgfw6P/1FE7iebuA8n3LbZpnZdqNL6bI6Nc7
 cW/ydXke5s7/VhMDyhk3BG+NCmZsqPGheYmphOzcfJu07cNXOBbWGyURPxaD522pfmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792761761;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=zbvLi6J+J45aztiqIkEjCYybtWY5nxvv4LQze3T3N9E=;
 b=O5eZQ4FkZ4RuQq/EiSqD4AijPTDfjTqKP1b//zZAUTqkixR4mtm+URmpLZtP835P6EXN
 jZPbqlTUM5ZXGnpyZkJ9xiCM5lsjfo9ViwMqymRhSlLuRj7vBYXxGBFDQ4/sLQ/wAfJ+G
 oXfhLlKe7r+q0/jSvjodvC4SIXjm+VtCGynOxyXPqk7AmdqSo+SpocdzCv0J7uvxicAHF
 e2yatJ0xZ5vRxSP9z1W2XNA5lZRp9fD+qstOwOH09JbYTfZiku6/rPLz0De5kn/04nTnt
 RgNZ/stfwHqzDqvFrxAczLggYpZFEwh71B96n4zqBBqDeFUNz+LeAKlktQ8ll4XLbng==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ec5RT0kl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2c; helo=mail-vk1-xa2c.google.com;
 envelope-from=rnunez@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ec5RT0kl
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 197BF60668
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:22:40 +0000 (UTC)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5eac925bac3so173946e0c.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792761759; x=1793366559;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zbvLi6J+J45aztiqIkEjCYybtWY5nxvv4LQze3T3N9E=;
 b=ec5RT0kl1cnkhXgqnh+X3v9njdG2K7w0dz4QRjb2Mwfz1Nskp/aqDmrSYTgu7urgt/
 WPvXFWW1SsL4LcDV9urFJDbbuCa8LozBVDgF/9isZ2yPFLhKYCR8mTO4NPWPn3ZOyYo2
 JbF08rlgXCV+Fzxb8zxSebXLAWCuUHySIXUqJ7Bfivc/YEXXBs/uEqmCjMfroZRjzEUU
 HNWMss4bpXXf1AWKeULTo7lbJbLy/2fQBpO9Jbp2WK96W9v6sE5t/ErGo7Xqmx9wJ0G2
 oz5/iX0xRawmrGcWWJT6utRz7X9CG3mqQFFy0kIik1PDYY/4kgzbJJtQIhGr1z5nxRZn
 SK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792761759; x=1793366559;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zbvLi6J+J45aztiqIkEjCYybtWY5nxvv4LQze3T3N9E=;
 b=jVWEMdTohZYjSpi++4MPsPLAHH1wgqkoqNvgYqMHYPJQ7M/qmPziw9VwPq6iaLbI1E
 3gmHJs8MjI2dgdOZUOBOFci836owgihDHVDBBK0Xt/UWrn6yuK8CK9qPMOxcmoLJd81l
 SkoN/O9sdEYa7lXwBRKUZpfI6rJJ2HOqehdIVu3fb61tgNoIomo7RNslbxJgwFJF0WtC
 dAysRq2cVw0JgOJj0i0/jcJcUDH0FAbzJvxFn5LMMyMal4gMXIBu8ESkWCZrvsOKj7MC
 xwMkcX4fK9eJbCVdZmRtgR+mzKm4SBf8/GyPNHSsA6thpAnOw+SeBy6ijQYklI7jGbAb
 ICdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBywQmRkbm5XGyowTnmpncU1YAQhalBLd+xwdvnkRdfdVEeNtpy7+ZIrpmV91V3EsV2qjPmIBEc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJrNJIudAQtQ92TFlN8CnGv3iYbxh/yH80PuKqnXihXe3MWeksi
 tEL+yHggr/SQ+hyHDWlhAtGl8peXBxZhsFmTfByrnAHT+MGE0lecBHTHx1XZVfcZG7I=
X-Gm-Gg: AYBFou0xjdYP1+Z9UDHmcH+lsS6IOblF+NQXHMivXbjs0obxlj0T3N7wXRD6HF+HBFJ
 mgTvxmGsRXowOpFUzp8czP//NUY/Ro+Z+0Usdp0boX8yDmi1P5kLrLsAU4mRA7LcOfCELDqoTaF
 GRDoCwmCkMpA7WFlQiPjMlFpC0hbj4FIcJfr58Tdu0rz+6ceLn3FihGtdANtssN0gd6CeiWhlNm
 ZIw4qmKIOFdr1e+L4cXAzYpohRWHqG4EiGYr/b8YGHaT/s6bYMuDrrllf5vIFSr3F5Jq3iMjnVc
 tCMGdNpcjvhC4vD2Pcg1LphMxeWfQiE0cjNQ/+oViSInlFiZk3iLSxLHf/ZkVRGVPkVRx8HAW2p
 eiFODZ7oZsVwThNRjdMlmrobowWhXo2zuZY0giL4rZzL4PXzoll+q6q4X+xgCW9i4eeBaoGvVsN
 WNnzya1owMhsEUT2q0U/5FXpr/JAx4BojxY5wR1LuxkB7x2P9DqEq/zFSD+TMqWno4IPSZJ8Y0h
 wrCCLayV7/GbO9RN5oDGbGhO9qSFVYB4FSzrGQu0RZoHl9Hn82g
X-Received: by 2002:a05:6122:c8b:b0:5ea:d03c:f0e9 with SMTP id
 71dfb90a1353d-5ec14ab917amr706473e0c.12.1792761759412; 
 Fri, 23 Oct 2026 06:22:39 -0700 (PDT)
Received: from [127.0.0.1] ([2804:7f0:7541:cdb4:5471:ddc9:4fc9:2])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ec1fd11d42sm90891e0c.2.2026.10.23.06.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:22:39 -0700 (PDT)
From: Ronaldo Nunez <rnunez@baylibre.com>
Date: Fri, 23 Oct 2026 10:21:58 -0300
Subject: [PATCH 2/2] imx: bootaux: clarify comment on firmware support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-imx6sx-elf-support-v1-2-73e378c6d5e9@baylibre.com>
References: <20261023-imx6sx-elf-support-v1-0-73e378c6d5e9@baylibre.com>
In-Reply-To: <20261023-imx6sx-elf-support-v1-0-73e378c6d5e9@baylibre.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ronaldo Nunez <rnunez@baylibre.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Fri, 23 Oct 2026 14:55:32 +0000
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

The original comment was introduced by commit 6f6058bfd8ae ("imx:
imx-common: introduce boot auxiliary core") when only raw binary
firmware loading was supported by i.MX6SoloX and i.MX7D platforms.

The support to ELF firmware for i.MX7D was introduced by the commit
c0f037f6a2ae ("mach-imx: bootaux: elf firmware support") and for
i.MX6SoloX by the preceding commit ("mx6: implement memory translation
table"), but the current text doesn't mention ELF support.

Make explicit that the original requirements related to i.MX6SoloX
and i.MX7D are applicable to raw binary images and add a new paragraph
documenting the support for ELF loading on those platforms.

Signed-off-by: Ronaldo Nunez <rnunez@baylibre.com>
---
 arch/arm/mach-imx/imx_bootaux.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx_bootaux.c b/arch/arm/mach-imx/imx_bootaux.c
index 26374fdc33eca986c2cf7a661a1225ef0bf06f30..9c97504b16ff19f08d822c8ae2d7f5d53846ef7a 100644
--- a/arch/arm/mach-imx/imx_bootaux.c
+++ b/arch/arm/mach-imx/imx_bootaux.c
@@ -164,17 +164,22 @@ int arch_auxiliary_core_check_up(u32 core_id)
 }
 #endif
 /*
- * To i.MX6SX and i.MX7D, the image supported by bootaux needs
- * the reset vector at the head for the image, with SP and PC
- * as the first two words.
+ * bootaux supports two image formats: ELF and raw binary.
  *
  * Per the cortex-M reference manual, the reset vector of M4/M7 needs
- * to exist at 0x0 (TCMUL/IDTCM). The PC and SP are the first two addresses
+ * to exist at 0x0 (TCMUL/IDTCM). The SP and PC are the first two addresses
  * of that vector.  So to boot M4/M7, the A core must build the M4/M7's reset
- * vector with getting the PC and SP from image and filling them to
+ * vector with getting the SP and PC from image and filling them to
  * TCMUL/IDTCM. When M4/M7 is kicked, it will load the PC and SP by itself.
  * The TCMUL/IDTCM is mapped to (MCU_BOOTROM_BASE_ADDR) at A core side for
- * accessing the M4/M7 TCMUL/IDTCM.
+ * accessing the M4/M7 TCMUL/IDTCM. For raw binary images targeting i.MX6SX
+ * and i.MX7D, this means the reset vector must be at the head of the image,
+ * with SP and PC as the first two words.
+ *
+ * For 32-bit ELF images, PC is retrieved from the e_entry field of the ELF
+ * header. SP is set to zero on non-ARM64 hosts (e.g. i.MX6SX and i.MX7D),
+ * and taken from the first non-empty loadable segment on ARM64 hosts
+ * (e.g. i.MX8M).
  */
 static int do_bootaux(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])

-- 
2.53.0

