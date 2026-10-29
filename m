Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557B606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q85KXyeU;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Qzd9EhRv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81FF540737;
	Thu, 29 Oct 2026 15:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BCLDf9HqHN5d; Thu, 29 Oct 2026 15:07:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CDC4040729
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793286433;
	b=N/H5mO2+uol8GQfIXfqK4QT4JP9S/dum9EndCnAWVcyvT6FPU9gOacQm+oU//eMeeSqz
	 4+9tX70CqYbKYrfvTMbVYMGkGi0nGyRPfbz1NNc6AOZg7G5j1JS1n86vqPWtd254R760K
	 WP9WJmFs7UN0H/ZkRK1HgKssgWc04Tkenn4cOsvUKpzts4FVpHSBhvIh6QspKkk6aD3S0
	 EogGoOyoDOQHKGXMcxiPmHU9kxICxkBNdnGct0WUsrWXfTW7H6EKseif2ILOABlKLR4fh
	 eaRnWt1vLpOSRYC7RAK2lGK0EBZXDxm9JOhMN19UNmHibMZCe4wkk6O+gnVF7kCg/5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793286433;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3dE36wa0ookJvDWy1f36iKdzG2jhdnHv9wEGw/lnUHs=;
	b=tLruDAU2LM1r/yIf9XYhBwQWkKZqM1EMTuxw7a+EG0H504+ekJqOaa/LLqCRpE75Hm2m
	 gz4Z7w1mQiJDaeq91N8LaBF1GS0hNhOiomtE64qoXc+ObCy1mKYqnYed0n/87chLTAIj8
	 7yBbW8KlD+IkQFrpCqCFPGrFYqNTo5RUREIW4MdKkHEE+R8f5Mzbm1sFmNQvPXcwAHtXG
	 6rN8HKns2k6ELwKuSCcDltvVx5rwX//xQfbXWAi+q/OtGEVxeq+tMimRV9dpJ7X/LxOGj
	 VTeySfasl4XzCW9HCjE4SzDbciSci6qQoi4Z8Si3fn5jp//viG4UuXjL3XAstBvLOvg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793286432;
	bh=3dE36wa0ookJvDWy1f36iKdzG2jhdnHv9wEGw/lnUHs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q85KXyeU4aHNIYFWFXlYtntrO9EyLo7wm1CkDX9tyZ2l9t/hw6ooCtsX2fTHIaRF+
	 X3oT8324OcvT1eGX7QkvDm2nR3UNS30wWeeUJgQGJXh2WWOppfXytjjM2w6+aKfzp0
	 +SXRjJyYDs5bQ2/SSLD1MSkoET4lU90E4/Rv4bvHsHVt6n4uni3Hup+mj8rkGjdMLE
	 u6HtqYMusE7rAO1sJPI3cklEsCJe7WJkGayvIzICgWzw1EH6zI18V2oXioCWqlx0oq
	 QIjQUvdgZ9o2JiVAvwVdeNCU7NLJv98s21BK+AHP4lHN+lOEjtN2KEOZCC+Piwr+h3
	 BEgTpC2/1uPvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDC4040729;
	Thu, 29 Oct 2026 15:07:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 60622D22
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 462EA400D5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:07:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KNdOnyFd7rCt for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 15:07:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3B43E40024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793286430;
 b=gpjjItJgUcLknr3u5QcBYfZh352mTbvjRPKGqu+yJRU3Bxtont8zwlekAf3AyxHvIW0h
 K1uMqSG5oJpWVGcdCIRaoLl8SLVFad27SxGkdTHCkkhSgS25qqkt2ReY9K09WPOE/9PDz
 lVpatirPZQSr9jfVzTrVhVqsS2XqpxLbVL9whaa2pTaaVaydFerNAhre3xr0hesTha3h3
 nB2RvRGFPeXawVHmpvu4rubZT9W4iz4OrVnIB1SVqOClNm92quNtehTfpwaIYJrUX6agP
 jI0icgVAU5ZoA3caCF9tXXXlObUBf08wkDqaiwyA0AiPadcziLuP5pupnc+fKcDHtJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793286430;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=3dE36wa0ookJvDWy1f36iKdzG2jhdnHv9wEGw/lnUHs=;
 b=HCs+ugq6sXp5FhYaZ+RGXJRpYjEoX4s/asCL4XhB57Zna3PX/3ehkbgG3A0KVUugrl/X
 DWmm0H4pL4Imgep1gDNTU6pemmeQUlVgYyZvDjMyB4iD5Q7NfF3lOlPOUp7f9dWD/zo2D
 RGTbsCFl0LbJmy9eI1/pjxBAQH+i5TGbmoepcDtXZuSPJs/WKFJsG+scs6vvseF1FQgKI
 z8qD0AD0VIEpBYvsvo+zVvJTfEXevauRPvP6/ladIhFQaEBplSRNbbgRi5aG4Yq/id6yQ
 NvpeuMZ+l99FR1dQoHqzzjbu9Y+T0AOAfTh5TtPflP4lhtV9TLVV+aPZ5QsTpiFMxXw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=Qzd9EhRv; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=Qzd9EhRv
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B43E40024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:07:09 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso495143f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793286428; x=1793891228;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3dE36wa0ookJvDWy1f36iKdzG2jhdnHv9wEGw/lnUHs=;
 b=Qzd9EhRvkChcF/qIDyjUXRxB98P3A/Y/6RvKHHhhMeIKwLTnanLUc1X5f42N9pA/Ql
 c+63okunHS0ogTQLzsPEVt5fwjidX4Q4CxhZuxb9Kzesvsb7hTfr19fK3VZ0A5ojQHsH
 DFE0G0GE39zC8lC2xraU3RVIc6EoJsibqdtQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286428; x=1793891228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3dE36wa0ookJvDWy1f36iKdzG2jhdnHv9wEGw/lnUHs=;
 b=0HbSgGY9wSjKGgAqQU2LQeNIvfe2F3l6vC6ZYYuADc45mOgjOn7IlXe7ik6PtVeXQ7
 Eq9nHCBWVCbtBc4vhVg11RgMlTRbJ38eVnYKoFuAgZDqkipQ+5FuXuFjxalezHRLCWmn
 z3V+DO7apblnzjWjM84fYiWvqOcXefkt0iBY70oQzo36/A4xh45UnKylCG2ztogySNu9
 uvm7HUQmX9+6N4AxeaUQUyc8stqAeFev7AK8vuZGOpmKpEUHeRLg2p5xniWOZZfixnW5
 9yJp2Kz1LPrK2RIe45lPTa90o7QDkumUaiPSK6wQg8Uz/Wdedn0SesNJqpgd6bHZOrvI
 n7dA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtnEsq+OV7xN5bTE9RDB/Snrd0hSQ0Qz5SX0+ohzW8yxzpuS2R3KRcv8EP8mKn5sH8VQCt+Gk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIPcf46bQEV0boOvX+68iAmEpLKGX10EB3C8J7zSFpFXsiMm644
 amUpYNRfuxsbpvEFqbNkXrHHVtzam9TOMel5dd4jL/cI+jIFQKCbG5Emw6PYoY/E2q+VoXnXIjo
 x76+5
X-Gm-Gg: AYBFou242sqcYMbAU+lSgArjB7YPkDjaC+L1/LMC5+YEZ+y7YsU7FskJqc8J0g2im/S
 atzKzt+By++daT4FyC7uXdpSyM2zdXEpmFtJIn7/piso9zIqTQncV8jDLyN8gMYxxgctTZNBOE3
 idezYt+YyaFtc9AEc/quEzcgUjjcyB+gHvwReQB7CWD2AK2GtBrO+GKVnxiLg/G1S+a6tG5q8tD
 ao+0VfVDjL4rpfoVld9EY+mWq1lrN2Qbah/uaJ+ItAMqcx3+rHfjRRw9agwgpn9SRSWSGJHxFRd
 si+/72yyb/LvZWuXrdgdOtw3c1NuMlsm/plrHL/s0/ugv5rY4lt2LFyynrnDNjJJJoqcCXEmKPC
 46chByADrESDCa+7seh8MOdlUFd+nGMGPILIOznZF8qzi3wQIElmc0RoklrYQskfP0+J8txn47P
 QKSeGXnvbTgxc5/21ayj3Hp+r0IxZe1zT4IITXkvXMmWw+jQD3RxwrngVCSPv04juU4YosKy7PC
 r8rNEfOnDQfDC3Gp3TNBhDucHtdz7XZg7bNmOEtnrsY8rIQXlR3XTvcdGKmlyXctRgW7YcoHyz7
 SLP7rMls21j8OhwG3yLfUxoFU5OiLszt3P8c6lQXJoMR18EqwpNgLCxUd+IrF8UoVHXFetnu0se
 Gdxowwfz9jqqjAefDn310MefprzUcJ26fVh9h6NwyyUYkVdMqqtRSaFO/PJ4/3hycJYYRShUIcN
 MbOt2oo/xlKWgrMy5VpnoeiqOQWg==
X-Received: by 2002:a05:600c:e558:20b0:4a3:5da2:38ae with SMTP id
 5b1f17b1804b1-4aa87d702f4mr46971075e9.14.1793286427857; 
 Thu, 29 Oct 2026 08:07:07 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee57589sm81122745e9.2.2026.10.29.08.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:07:07 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] board: engicam: imx8mp: adjust the fdt_addr_r and initrd_addr
 location
Date: Thu, 29 Oct 2026 16:06:53 +0100
Message-ID: <20261029150701.625466-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Booting a large kernel Image with the current fdt_addr_r address may
overwrite the device tree and make the boot fail:

  Moving Image from 0x40480000 to 0x40600000, end=0x430a0000
  ERROR: Did not find a cmdline Flattened Device Tree

Apply the same layout used for msc_sm2s_imx8mp in commit 3a6a7a8dda69
("msc_sm2s_imx8mp: Adjust the initrd_addr location"):

fdt_addr_r = moved loadaddr + 128 MiB = 0x48600000
initrd_addr = fdt_addr_r + 512 KiB = 0x48680000

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 include/configs/imx8mp_icore_mx8mp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/imx8mp_icore_mx8mp.h b/include/configs/imx8mp_icore_mx8mp.h
index 0a861a107b26..2cb916afc8c0 100644
--- a/include/configs/imx8mp_icore_mx8mp.h
+++ b/include/configs/imx8mp_icore_mx8mp.h
@@ -33,10 +33,10 @@
 	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
 	"image=Image\0" \
 	"console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200\0" \
-	"fdt_addr_r=0x43000000\0"			\
+	"fdt_addr_r=0x48600000\0"			\
 	"boot_fdt=try\0" \
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"initrd_addr=0x43800000\0"		\
+	"initrd_addr=0x48680000\0"		\
 	"bootm_size=0x10000000\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
---
base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
branch: imx8mp-icore-fdt-addr-upstream

-- 
2.43.0

