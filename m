Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AAC60A2623
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U/13jBfR;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FworG4mb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C2F681185;
	Fri, 30 Oct 2026 21:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0PLJTlTGhZqD; Fri, 30 Oct 2026 21:16:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3950381135
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793395007;
	b=EGcTRtTeoKAiaZ8cWeefGaMjQJMPBp6uumnSzIn0EefWzIgIKqR3SDW5AK0j5zrm11SW
	 Neawiie/Z+Z14irnAyg07n8+tIT2lUpZDwuEHiFcV6wBOAXUMWY21G9Na5QYDKZhP1dNl
	 a+0hNncybYBINMVsYlNRaB/SsORTmdCDRolKl2g8DzGZqIt19WiNevSFPVMNP5dbyJnd9
	 W+ONoJ0jkLxSVY6typ2ttufKjdx6HkmvdV3Pjouqi7ObmhV7R3rLJmdQW8BVTgHwAkEzo
	 fygW957Ah+U4aVUwJ0CKDUY4QaLcj9IeTbNv9X73VdhEWdlfVgc9+Lm33xlsNHThhXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793395007;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GSlDtXnm9wAR+DY9gcWb2saKTc1UxLbkJQd99odKasY=;
	b=XsK86esC1e56pCzerc7i1+1Ubqj44zEWfmuwV5iIhtkpaVg1XwwJdIK4kkBWQwz7N4BO
	 vz2jBSIy9NnTzF1R3GQoAcJl8Nf4aGlN/oybmhKwDofIWGDqxSmY7j3fEoB8h9PfJ2yJM
	 LHhDvNLtuAqoirRMMLd29jLluilihv9DO96NdrxOi3NJ1ChRNWO3U16SV1ogGtXdYoMt5
	 KaqnvE9XqqXlb8RoIHYg2K+0Tu9nl55Q/DumZxgNEQnvYC1rcXyubP4P51NafdhLYQ7Qs
	 u32sZ8/Elqz0hKraHpW0ne0JIa/EDAv4SJPfaDTr1QHZBF8b6Bmqt/m9yDcN3J7ArSg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FworG4mb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793395007;
	bh=GSlDtXnm9wAR+DY9gcWb2saKTc1UxLbkJQd99odKasY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U/13jBfRgQFJCdym/V+aVfQv34vz7Xf5iFJQ05acrZllSR7JgRYxsOPswVHdeWXQU
	 m/Pteu+IdzrtCj4+d2bIryU8R6CpmWdByzmdaTa4Lab/EiJraIo+deS/p+2vluCv36
	 pdQ+U6IiRqzvKMaR99gghprMlIwIxCjLLTYhv6Uj07CH+yTh+L4Sgh1qp/4DPXSlfs
	 q3soJ3F7Zi0T40Abi9H3AJQkZ488LEoetNJCYlLVRwtCh0ITnzyvELTOePbPuXpmYR
	 rig6e5feGaE7HYgQIPN4GH92B2rCfAu3E6jTT+hbjAM6iTdw8LJ+ZIy2kMGaM5/AYL
	 fT3LSTHg5un/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3950381135;
	Fri, 30 Oct 2026 21:16:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DB13362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5427D81359
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:25:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3hNN-agw2ANe for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 15:25:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1BEE4812AF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793373955;
 b=VCAUnzzHtjiqrKk3FE86T6nEyslepk/y/4Vk8WUp3l1Z6Dnhe0C4wCgpRTUi3ihz8XgH
 51m7DVJntujzLfeAvpBlGA6Yl7zEH5qykLxnAQYcqXpPLnRIEq8HrwYILwk8kAaL853TQ
 nx1StIWxvJHm1dL5PKQ8Fvy6hZc61lNKPJYckaUA8G2x/BX432yELKdBrwBot9+y9/aN1
 gFkuRZ6x0Irhywgp3/YWe7iug4U4shd4rIbDAD6YrisgjDInfo7CljkG0RlZz5tMb/R2+
 k7Ffg9a9/VbU/UcfSczLKSl09PjVUbrEuoCNUPr1IPKIjL3pRozy8b+jeGrA7OzMW9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793373955;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=GSlDtXnm9wAR+DY9gcWb2saKTc1UxLbkJQd99odKasY=;
 b=dNI83LyEAKL8h47nzCOWJ3JbYeQbJIKcJhtq/Lm4cJLAkP93gMk4S6ne6F18FYjiG/Pq
 UEnVcUKsjW7L3do0vAQAcba7QkDAPIBnC1/F6ucDgj4DjKsI4B2ikrgFuOkHSwBU+Ivtx
 1ufU3BPjXtr15l/hi8FAYgVjqLwoUO3VQCRQrBOza8icXXMpFJR8qrq2HSXWwi64rS52i
 LRnS34ia0UetqkRatDlFlZWVd07HaofidZo2CdcPQpXtFG88aKKgscpvETRtSTgjX0cf7
 sNA6xYTxSlOoIWPR4AHvW1sdjFD611d6m5VJfwtqUBRF2Oj10Tkttcpp3k86oGYKw0Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FworG4mb; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=ddrake@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FworG4mb
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BEE4812AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 15:25:54 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso411996f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793373952; x=1793978752;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GSlDtXnm9wAR+DY9gcWb2saKTc1UxLbkJQd99odKasY=;
 b=FworG4mb/9uMxjsvnhjImJxb4hPeRM7EP+LeCbJBzgcsm1SpQRecEl+GzAEcTe+ys2
 W5kXPMkF1kPMAZoLHWikAUi5cFE0Bza90yDT6tRIo1eVj4jjyLfrQSAEoY2cSItcIImW
 5mFbSho2MwyHG1i3iRbFmCIcCsEB6crTBkrK2eTgICCi94Z/qOA9udPh30jXymW9/kd+
 dz4htEIN9FwaEpm0ANcwoigNfRidt68z/FLtvKz278mw/a3nmUDJ0f8OFmkQkTyVd4mn
 fPzx+KYe6pk3rCt+tIi7AZ7njJRD6MIGGjxZTxy6g/2fFqcFmy7cdLxADNiUDacJveqV
 65Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373952; x=1793978752;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GSlDtXnm9wAR+DY9gcWb2saKTc1UxLbkJQd99odKasY=;
 b=DUiEBbSWYR+07qy9vHAb/96hRKX6ts0x6u8F7kBDsamKL60MwtEmhLr+eA7Yl3yySo
 OF0ao0MnyayNccEb1pMaOCzXIGwRJczbKBnz58GLK2ks3RNCfV9VgdUlmZGjO5AcReT1
 wf858K4LYBYo7iFgKmldLVdFJhTOwsNZwqw6waKZ9tURC56Vzps4i70tRNWlLvgxDDUS
 t2oLxFIgoEAAObSCkYmGji1Xar1wjPF4RmY6nkG4SkSLTuyGCyzXpErqtIWDzyFbZOMA
 e25v9/z+QiavLoYFaqDUcfyieh1uyB3a0+bVP6HhCQZqNbi2CBlwJjE2nlmZs9z5Oetm
 aBwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhAAqem3hg9OGS3XNVbWH4PhXhnTU1a7jj51Oc4uIQHoP9bX4qytZGGTD88BLGXw29pA17hp4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI3GqOW34zoqpEN3c0xM8GNtcLIw8e2Ot4+FJzVtzA+u7+d8tS1
 YRd+KHEEpZpojF5Ch62ea74KWMf6ajlN9fG4g56+ETAouSQaRS7zMfqNnRazry/NwIc=
X-Gm-Gg: AYBFou2lUvXSuv9saXpeIaIaqa8c6R/zEYXZ2ERvCYighiq3GKDSz3O/dZ3R3wqraAO
 cgnq4kiaICLsAATBql8sleh7ZebyOLe4DsO4enmlFq5qXdp97arJDc7QhjUHB/VinEloCzcxKhD
 0sv4s5N2Sx9LiEpnaplg00y5E5NBmh2RYaMMzwBrqg6A/dcEr487GG9w8MNUk0L/V1MN7UEo9NF
 CGL5mmmcKfP75xGbUcBO2rjazXBLjr94TKp/rqL14KBekaxJ3qwwtWmy8MK1mHupHokd7y0GKkU
 r3reWf0Usu7+o5h4diKwkapqETU+qr1Ukb/8l5X/BFanOWfXd/eKD/sGeO7NRLF7AKPfgrjIG+o
 b/L6NSImM2JDHfUEkZldmigQCnBwz6TgH9nLLB/LhA7b8Mq46UNS0m2p1hpBFS0VXeN5syAjN3d
 J365/DBhhUSzodRjyreqlKS6ymAiiQE/v3YTfC8mhLoiaFRp3HtffB3rUjRG4ijnQyLBJAzYoyj
 +0Xyyumd9jsbUzmJNAGsA/2IiOocueWxh9LAg3lTaAxB0hsqxlxVIQWV9KaH+Dw+wWvxaqcTnR4
 M6EC4zRY+guc6Pd1+P/dLCBhbZsV/5nPRGP/+9lfVp//zYcCwYLTJA==
X-Received: by 2002:a5d:538d:0:b0:487:197a:5c1f with SMTP id
 ffacd0b85a97d-48e6e4f8ebcmr4881197f8f.49.1793373952468; 
 Fri, 30 Oct 2026 08:25:52 -0700 (PDT)
Received: from [10.42.0.1] ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b723cdsm3801590f8f.12.2026.10.30.08.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:25:51 -0700 (PDT)
From: Daniel Drake <ddrake@baylibre.com>
Date: Fri, 30 Oct 2026 15:25:49 +0000
Subject: [PATCH] imx93_frdm: make room for distro kernels and initrd
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx93-frdm-distro-boot-env-v1-1-5ba9a72f0904@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ5AMBAAwK/Inm1SLYKviAPtlj1oZSsiEX/XO
 M5lHkgkTAmG4gGhixPHkFGVBdhtDishu2zQSreVMgp5v3uDXtyOjtMpEZcYT6RwoW1r1ZGbqTE
 acnAIeb7/fJze9wNqzdJtbAAAAA==
X-Change-ID: 20261030-imx93-frdm-distro-boot-env-c6408edae532
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Daniel Drake <ddrake@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Fri, 30 Oct 2026 21:16:44 +0000
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

The DTB is loaded 44 MiB after kernel_addr_r, which is too small for a
generic distro arm64 Image (Debian's is 48 MiB), and ramdisk_addr_r is
not set, so extlinux boot with an initrd fails.

Move the DTB and boot script addresses up to leave 92 MiB for the kernel
and add ramdisk_addr_r for standard boot with an initrd.

Signed-off-by: Daniel Drake <ddrake@baylibre.com>
---
 board/nxp/imx93_frdm/imx93_frdm.env | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/board/nxp/imx93_frdm/imx93_frdm.env b/board/nxp/imx93_frdm/imx93_frdm.env
index 96096bc51a0..443fedb6dc1 100644
--- a/board/nxp/imx93_frdm/imx93_frdm.env
+++ b/board/nxp/imx93_frdm/imx93_frdm.env
@@ -6,8 +6,8 @@ bootm_size=0x10000000
 cntr_addr=0x98000000
 cntr_file=os_cntr_signed.bin
 console=ttyLP0,115200
-fdt_addr_r=0x83000000
-fdt_addr=0x83000000
+fdt_addr_r=0x86000000
+fdt_addr=0x86000000
 fdtfile=DEFAULT_FDT_FILE
 image=Image
 ip_dyn=yes
@@ -39,4 +39,5 @@ bsp_bootcmd=
 	run loadfdt;
 	run boot_os;
 
-scriptaddr=0x83500000
+scriptaddr=0x86300000
+ramdisk_addr_r=0x86400000

---
base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
change-id: 20261030-imx93-frdm-distro-boot-env-c6408edae532

Best regards,
-- 
Daniel Drake <ddrake@baylibre.com>

