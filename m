Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C899606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NucAayDz;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FZyJ70+F
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C360660600;
	Mon,  2 Nov 2026 19:35:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rqnqj7XH92lg; Mon,  2 Nov 2026 19:35:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DFC38605E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793648147;
	b=GU4vnWjX0x4Wo72srwLK81R88ND5RnwUWGKuN/1tLfncIKLt9SCRFtQ9FvsW/BFGWpQ3
	 hBGJNKIye69dHPQ+R0VysbUuPpFJ/eNST9hjhjeShxWk14g65PfHfhm4pESYovI6CdkV7
	 vSqSCQrapySkQcRZhtxCqePqmWw7nAFJByeZcP3L936rXtziiohsO6l3siEkRf/3KeaE2
	 RRHHw2jFMRiwAVG6eao3h3Y8KHiqO5yQaIW23gWNiIlwNtba5QTXwrZdGBI/W8oJpt41Q
	 XqKihVuajbPngTXU3lZabEMhSnNtGQ90w63w+0P/vy0tHcMQ8WTvLSVEFWBKiyqr+Ig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793648147;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bko1zj09v1GMNn1Mhcl9kkkfsB6TRaMRVmgAgGvXYYk=;
	b=akmuDZhSefxzeJEcqsi+1bYQooKC+O6VJ7pmshVybEskhnL9xvbvzXyGp9egpkR6xi7s
	 T/YIDfmEdCXOv9UuBcy9kk6yg5E+X6Xer7xU7bcWhHhaR1k2SU2OWCK2cqUudzuOtLUo4
	 4yguixkaLBT6oAUZVALJ5mkV42ICGdfS8YpwHwpttyJtrsJkuGNhK+fFhshJbU09OpmrJ
	 adi2iMTGfRb46jy+6oVFxlpvhUtrip1kk644BrG8lkrkUwHXGmVE9qg7grs3w6pjMq4Da
	 tILZ7L6k3NC1VLWEyg1/aGjhhL8i28G9/wgeX8yaWTocBKih89bXX2Jda0q+Yyjz9GQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793648147;
	bh=bko1zj09v1GMNn1Mhcl9kkkfsB6TRaMRVmgAgGvXYYk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NucAayDzkO1ZaxFuu1ERNKOZJybsUAycugzkDw26xnvZYJnJsIE75qZNAzJeTM1kl
	 H0+NPjX2BCUMVZoMrmp1FZNHVDxtV4cp0vGs6Lwu83jqK0XQhTr1kebZ5TBwRZ4siB
	 SPLXbHncjK3yI8waAJY7BAQZU8uEPqyKL0RtZX5Zd2KrOYP6NrZ9oyYyFe9stqFe7L
	 +DLKdbu/yfLgd8EAI3kBmqtLiXrYeVejOrnaAIHYu3Z369VYaVNlIFmrayG3sMRTUA
	 4mHSmC95kP4BEbfWPhf9JRY7Rj8T2UV9B6v1xltPAHfRyyvxSlkOhVfPKntEuWOo1T
	 7bR4KPy3GRlYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFC38605E8;
	Mon,  2 Nov 2026 19:35:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0629F120
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:35:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB93440575
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:35:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MwmyUgo2mqnS for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 19:35:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D0AB40381
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793648144;
 b=J1gUz+zviiUzwCVJt9OIDRNJ7C9cHoxJD3YViUKMMemL4E3xTiJxaGyZbmxY2zPUmSVY
 UimwVMF9btK0JTLVJRcGaATKb3dX+GBZ5COiNu94Ej65FUguvdXh79nf1heURRuy7lZQJ
 0kAkGV34ENrzQpIbduP0QFAPO0Tv+lRH6rgEWHzN1Ua6xUXHUU6aYke8s0Gz8FxSsPQPT
 Q7NmoHCMf6xR253nfQgapGuuMEcqjuzeI3jaiOdiJGfOF9/KTHJpaQx2TJ4un2Mr0jDWj
 UzWPfSdmqCFoDFok0aARW8GmZFThP5wQBY8ltWeB4KEABH1RlFkLBCJz4nBxGQjIamQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793648144;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=bko1zj09v1GMNn1Mhcl9kkkfsB6TRaMRVmgAgGvXYYk=;
 b=VZXTXvcZ+irzt6WAONDrFfH1z2Ec84Iddj5sueOLljoP8bQjTb1Y/hok8Hw64MVfYQTi
 k0lQfvPFDJScXQZcdmqqGlRPVmJ4jRVmDFo2l9MQri6apS9aH3Wegsx1Etk6m87B/pOVx
 IzIz0PfIXAb1yJKPv6mno4539c956iJEWurRFGNQgtis+0iKvEk1hz6u79yqgCkmI+I86
 ypMcScDLpZz3PlkLyLjP5DpsJ3W6LKDcdQgOgc1Va/YLcJCpUTaRLQtvatx7YzP365ftF
 Eqv5XdEM+o73U7k8is+SNijgYiRry9PIyDiL4QwjhTdUmxfmKuD69wEEsV8p9Ai/BOg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FZyJ70+F; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=ddrake@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FZyJ70+F
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D0AB40381
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:35:42 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48b042c0728so801935f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 11:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793648140; x=1794252940;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bko1zj09v1GMNn1Mhcl9kkkfsB6TRaMRVmgAgGvXYYk=;
 b=FZyJ70+FjbhwcXpfMa7Arn1Qyzawt163mNR6AdE4XomDctSVnOLyjO/Rsn3jYDlnog
 rqgtarjA5Qs1Fohjkw7w2PvAeOPBSbWUFWl7lvAo+QepsZfWHWwWbd+jJMF4snpE0pDR
 Sy15k7i7HyTxlD53a/QY5xlBPosomRaYzvPR9b0m7rU1kMzrrb1zl3NgH+ph8UdrY+Z0
 4mIbXzzCzJKod/9B7oIposznQUT+nzidJ+fZd61mGkZ6NDwlfTkGSwPDpbmnjq4iTaIU
 lCxhjgMdWpEP3tCBKFJMMmg+Wm6W0CrRVu38HM9uGvO1gulaqrO99vE4sz9V1XgnSknC
 IWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648140; x=1794252940;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bko1zj09v1GMNn1Mhcl9kkkfsB6TRaMRVmgAgGvXYYk=;
 b=npKnfXBVftOvGm76bGaGB+1EBCMMixFD/xUwqDj/TYKyLmLMbX03+GoW78z8aS9O7i
 Yeuk/YH0A/piF1iptpN536lmM5wCkS0qsE7pknI8HDoHrfTEbKcsoboEh353KwPdEjVD
 x6PPlZIUVCUDPjSyd/GQiRbh47g1/dsyffZcU9ZOl1cKRubSnUKKqalZV5bToTg98H+/
 /KRCuQciM2bZLe9J/9P1/YcH1VuZknzT2gRPb4XxqQ7g2d/V+D/gw+nQ/v1mXRUsblqY
 nrEQkdpT94vnAt5g4WeQ6esCMQcHH1sx9v7RuRTBqJ6Y5dYppa84o1hd+qUuQvXlgwOa
 NBCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrg3mSbUXQaMQWh00M88fgcT0JoVGWj4z6u9XWYmZVAVC+ehmqQ3x2Gzf8Y7TsoSkmQd5JH2Q=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z88EQtelaKj8GBAPkwFXnX2CBu3HOh8WFneEhIX5bzyiH4r04G6
 8tdmOz12MIi/2+Vhe/mlP53JAHLFRWTw/tiLxmc2m2iyXpm4Te5lbE4rGqQsfW8qdks=
X-Gm-Gg: AYBFou2yk/xfWsBF/MsEO+PScIxig1gbr+DcyzDv29i9JgWQ6odBqhvCLCCuQSiO7+G
 24IIG5ol/ZGon6e6MYPWIsgyo7+bQyROUuro/+EpMblJvRCdEtqja8MSLDa3l7t/dquTXz9NjnL
 7irbORYKIFhyEOcIFcZZzy5pcEvh2rwaC9HIlDdl3jjhYYa6Sa8qyoq4nRwQH8r5vXLkm2XpHOl
 rp9P16+RJJw3fGYqGT27YQz1IeLwFFEGFCA9JgaWN1Nf0RmVL/3KZIb/uKAoocH0p6Da6KW6m7Q
 IZVvXMvNaVlNjF8iQG9RC25m840hs99exhMIotIKPvDVKDrAMZoBcSHGGDRrezuNwgwPNqH1DvE
 VG67b5d1pDGWNRAsP5yORNe/AT7WrFhCaC37pIn7UbSmeE9aAE3+ydMoKNrwaAnLg0eGC6gS4f5
 4R2e8VC5f7S+JgFJvf5QhOPdtTdZDwxn7A8w7hyI+bQ4FLleDxpH5ytzhVDHr809uJHi3jk3ByP
 7RR6iaWb9d4vVN3HLlwt4/wOhfy9tK1/DR/n+2FRTQVvZoUj8Jcy0Z7czK4VTbwxBz4dYBlwEb3
 y7jrWQ5tGaOlAbpeU/cXURA/E8W2Z8IDuX4L6g==
X-Received: by 2002:a05:6000:4203:b0:48e:64cb:1673 with SMTP id
 ffacd0b85a97d-48e6e308b16mr22100190f8f.45.1793648140339; 
 Mon, 02 Nov 2026 11:35:40 -0800 (PST)
Received: from [192.168.1.123] ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a4csm21316417f8f.23.2026.11.02.11.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:35:39 -0800 (PST)
From: Daniel Drake <ddrake@baylibre.com>
Date: Mon, 02 Nov 2026 19:35:28 +0000
Subject: [PATCH v2] imx93_frdm: make room for distro kernels and initrd
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-imx93-frdm-distro-boot-env-v2-1-d173dc546803@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBBGr2Jm7Zi2/CiuvIdh0dJBJhFqpqSBE
 O5u5QQu38uX920QSZgi3E8bCCWOHKYM5nyCbrDTi5B9ZjDK1FoVCnlcmgJ78SN6jrMEdCHMSFP
 Cri7VjbylqjCQAx+hnpcj/mwzD3kfZD2+kv7Zv7JJo8bK2cZeTa8aVT6cXd/shC5dGKHd9/0Lg
 DHvGscAAAA=
X-Change-ID: 20261030-imx93-frdm-distro-boot-env-c6408edae532
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Drake <ddrake@baylibre.com>
X-Mailer: b4 0.14.3
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

Move the DTB and boot script addresses up to leave 128 MiB between
kernel_addr_r and the DTB, and add ramdisk_addr_r after them for
standard boot with an initrd.

Signed-off-by: Daniel Drake <ddrake@baylibre.com>
---
Changes in v2:
- Leave 128 MiB between kernel_addr_r and the DTB instead of 92 MiB
  (Tom Rini)
- Link to v1: https://lore.kernel.org/r/20261030-imx93-frdm-distro-boot-env-v1-1-5ba9a72f0904@baylibre.com
---
 board/nxp/imx93_frdm/imx93_frdm.env | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/board/nxp/imx93_frdm/imx93_frdm.env b/board/nxp/imx93_frdm/imx93_frdm.env
index 96096bc51a0..b3a19a4720e 100644
--- a/board/nxp/imx93_frdm/imx93_frdm.env
+++ b/board/nxp/imx93_frdm/imx93_frdm.env
@@ -6,8 +6,8 @@ bootm_size=0x10000000
 cntr_addr=0x98000000
 cntr_file=os_cntr_signed.bin
 console=ttyLP0,115200
-fdt_addr_r=0x83000000
-fdt_addr=0x83000000
+fdt_addr_r=0x88400000
+fdt_addr=0x88400000
 fdtfile=DEFAULT_FDT_FILE
 image=Image
 ip_dyn=yes
@@ -39,4 +39,5 @@ bsp_bootcmd=
 	run loadfdt;
 	run boot_os;
 
-scriptaddr=0x83500000
+scriptaddr=0x88700000
+ramdisk_addr_r=0x88800000

---
base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
change-id: 20261030-imx93-frdm-distro-boot-env-c6408edae532

Best regards,
-- 
Daniel Drake <ddrake@baylibre.com>

