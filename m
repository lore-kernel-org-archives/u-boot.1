Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2885606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 04:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EUjrSW6H;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BJcW1niK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC291406D0;
	Sun, 25 Oct 2026 04:47:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dr7Fdk8EjMDJ; Sun, 25 Oct 2026 04:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 997B94069B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792903651;
	b=RnrUOiDy+euqEbeaWvn1WlrRfbAhx3jSmH83h3v/qao2Dk5DIT2zDaB9/cSMyMuhtDSZ
	 G0xcxj7ZV1mqYGCNPiLZVc63fATRecIL0kxINqTUamxpoMl/cfli/HuuGxq+gZXULJkQv
	 gusREwfTUxmxHK4VoLIMeOMGrr6z1mcU4RpJSqnhCTLD+vmsJnHtMGIP+/qo8OKN8K2ug
	 b1FnJKu8nhMKpFvp7giZfc0Z7/9fTBjdV0Rghn/Vk2gjekUBCQ8EBRaCPp+8etJAh/hbc
	 YguRgy9vKa11YkxdZ2b61PK3Rj8O31kDVwYoEwUsfy6ViqjdmKbCaxlxs7LmWY3kGTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792903651;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ANO+1zoYcV9ERUASRWzj2FrZEJIs+88YfJqiRf4SMdo=;
	b=el7MAjBCKZ5DN6VDXlEmxO5lmD19QmOsUvGU4IWpbbQeRAm7T7qPlj3TKln0A1xjS1Rg
	 bZS3aEZwrcsr1Fh0R7YZFBTAQXfmCE8XqHDj6D5uqFOto5LxjIFusy2ZhXVV+x77stC2z
	 LmvoNJAsZG/EoO/IVPRfOBiQ7ttbMpy14V9HAs+8nAyW7UP6/mrm7clxTuwGSYU7N6Bae
	 muyI6L6osB74RT+1Le0RQaNsZHjmIZ6uxwh1zl/lU7cz+B2sf9Ft2oY12ybA+vvIf1thj
	 Rpwcla28KlxoLf1mGsgCrMcX9jByX4XWeCLE1CtaKHRYkK0ixNMJ7gy2hO7YYyUcsHA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792903651;
	bh=ANO+1zoYcV9ERUASRWzj2FrZEJIs+88YfJqiRf4SMdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EUjrSW6HBIie7FOw0s9xQmvOkJCFc7nXNiXEXwJgFPYS0QQa2kDzESb4tDJ7DK42v
	 JfJpwh1+sH3u092W/BSaPKqGPJAxGlo4tZDCPBMPJIRqXoE3cN+vJ1FUZWN4qaERhu
	 Bf6QeLrgeMgHjtrDodcRD9m3to1gTBfiQnYbyHNlirbh6bc7yvn5fZmkzFIDpWSXKV
	 KmYB7JjUX95hyBgoJvIR5ZH19mvEATk/ikGCs1CbGLG7V9WZVnP9QBMzgf2/1hoJau
	 bzsQvb6zgJZoJWWZyYJuSFe0g2egWTR7/ry8LgR4rOOXcDLw0c5gSqbDIczbB+vknc
	 IGeCiB64pRk0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 997B94069B;
	Sun, 25 Oct 2026 04:47:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CC423380
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE89480E2B
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0y7kgSAfWgvy for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 02:00:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F220180DB3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792893635;
 b=Sn/avbJLoCrEiNzZu3U5Nqv3p/VPsgdvVZAN7hnIAvEStAFaFLFEa0jwBaPxRDW+M2C1
 ESeAb6XV1UPQ/uo6IXaT3wEz9iuwVqesu6j1F6K0cL30r9q/oUH5Ju+WNMNhIhJ35onoa
 6DoNlFcX7jVlbKLQPw2c5wGrcC/7bqzE0idn4+tFyxkdvcc0BUAtq9i0azAFXLuOIlnjb
 v6Fd5Sd9BF4mY4R+7iWejwpmS5rphn/NsJjrfEQBZMhjZW0Xw0G+nZk/hsELp6uznVhv8
 mY/CYUhEh8MCetuAwNXw9nuOxzWfwfvWg5wp1DjzWR2crkyTLiFok84SvQo1jDCS57A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792893635;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ANO+1zoYcV9ERUASRWzj2FrZEJIs+88YfJqiRf4SMdo=;
 b=lX0dVggWwbBJlhQtbq0jGzDJjXoJQ7YP9d9rvXc+7LWFe0bsVOvptbyT5ccSMKQ4pCg/
 Y3ZyWt1IcWzSsZeW2HnqB2HdFRpeQhHSYV7QVcQ2wxVcLWhqPIDLirZtJyqKej7courI2
 k6EbdyZnH9Yq3p4G4LiS2x6rPXcP4B/xkGVglxxhCe20IKxQ6Ra/Ro4lTthuoGIswKfjv
 17ICx2Th8CeoPhjbM9Fq2HPb8XnViYWJYXq+vmbtaHgokODWqMcQ4ZLt3FObP7e8qUrwx
 Len4pP8Q2JlhtMTlaA3jORSgzqu6HMB9VFwKSKxnoX+BI2DWKmGohRktN1Ras3ZHdGQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BJcW1niK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a32; helo=mail-vk1-xa32.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BJcW1niK
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F220180DB3
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:34 +0000 (UTC)
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5eac6c5f927so814069e0c.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 19:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792893633; x=1793498433;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ANO+1zoYcV9ERUASRWzj2FrZEJIs+88YfJqiRf4SMdo=;
 b=BJcW1niKaSsaohEQSQReOR+Hv5SkRlcLuwoHYsLdLInz6Bo1DUb3BFx0Z+ItSrx8hd
 DrrQfr/vmWpnZRVO4uPnoIjLb6etgltK50tq5LaBXmQg8DyA716A3he+4imYq9z3xied
 0kTj1SGvRSuPvgAFpJrDLzO3z6H/fHga4jxzjZA/XeXwn0FeJxIA4yV6zbi55KF5x6pf
 O+LmFLHao/nkvhFaICffeXzULOxSpbUkAkPA8bcBYbpdXVobQzE0/rxRfpa7WEHqKs34
 L7ZrcqSMvnziXN9PLMtMk23V7qqdDmJkFv8ihyuXbSvEUtreXdRqY7kaephIGVMwlziY
 wSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792893633; x=1793498433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ANO+1zoYcV9ERUASRWzj2FrZEJIs+88YfJqiRf4SMdo=;
 b=D4B93ylgKvVM6EgRVK5HJKW7xOtAoM4bLR0gkwIe4GjkBW8Rj8dEYApKOHGoElb5Fl
 Mt3N16fCpezfDwr5kHmNyFuOGhAc2FOyhuQe8JsukcGky4DNJvP7Yft9zjq4lT7WZ0LA
 1OKs2vfOdF2fOYSqUnN9QY5wyrCuYSB9fzx0PSddeu+9IG7ycsJncxVDW9CNd1XItfll
 HrdkiXCBclb0HqDQ9OseZVSh8V4ZQxb93bdGr8WRnwJ+wUgLzHT/fUsv96tNBIAst9OT
 yqMZ8+q+olNKEih02eBFTyGKXFsjPN7WMI+H25EahwVgWpEMADjfsMWdhsjENWIVxF/7
 an5w==
X-Gm-Message-State: AFq9FYIqUkSpZrinLKztQ5mE/6lc225cawbI5MdH3dLFXixkk+XJAiE6
 2LZ+Yzec+pDTT4Ek6VfTwit+xu43puU2kEpGCz7ofZhhwSzuPxcrPyXuXxwmN12A
X-Gm-Gg: AYBFou1JwG3TINXu0YFioCMv9DZUaRXfXarRaxk0pBR2T89lYCVZOVgskm2ZB2lt+cO
 FAUTnN7g6LlDVyaJiugrlz6ycADor/BwFbwNIskmHEf4yyVr/NSwIXe8XWyZzE9KOtU3iVaRuSu
 OAcURqTu3lY3G+jQlce2mJAekN3yt5JAY4r7eYD6L3t1vL8wHlpDU1HOSZQ2pF8Bik0rhNmJu3N
 UEZ+nEqZTX5kLprxI52lqZqMFvRVUmT8Z2liLkUr34Q2PA03tCkQo/KJqSMc163eF3witXJej/5
 3BKKcSj7Fx6hbCfWg3QGp0G6Yi/UytO2bjoBdbZnOL2IIsJFugnercS5vdbexBgxZ1Sj80q/MbG
 cd/QNy2BDOO/C9Ihqk8w1xRVXLMT/DAodsna+vf2SopNmrVZhyWYr4yFBMUItkI018qE1ZKq7Du
 pLiq+pB2E+ZK52DPjUIknBplt1Y7ohKL0uxXFI1W8REznwS5OLFNeCYAaeam7BZ8YqW6ihxAPF/
 NjckKmb8yF/uAL0LHHsW+K3nS3GNkltjQTykhpDOmixLwrECJW7Nlkr2Xb6f58cTc/PPAfWDBor
 aYmcv06qoTBPcwwwa1MLuRfdDeQ=
X-Received: by 2002:a67:e7cb:0:b0:7cb:bc5e:7dab with SMTP id
 ada2fe7eead31-7ce5cd5c735mr778479137.24.1792893633431; 
 Sat, 24 Oct 2026 19:00:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:1eb0:a0:15ff:76c:632f:8ae8:6a5c])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7ce5e2baf56sm3485070137.11.2026.10.24.19.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 19:00:32 -0700 (PDT)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alison Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 5/6] configs: ls1021aiot: Allow 64 MiB decompressed OS images
Date: Sat, 24 Oct 2026 23:00:11 -0300
Message-ID: <6689372b6a85605e7df063c7a4fa26a05b4263c3.1792893601.git.mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
References: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 25 Oct 2026 04:47:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit cc7b8b9abb1d ("armv7: ls102xa: Increase the supported kernel size")
raised the maximum size of a decompressed OS image to 64 MiB for the
LS1021A boards, but the LS1021A-IoT board was added later, in commit
20c700f8daee ("armv7: Add support of ls1021a-iot board"), and kept the
8 MiB default. Its kernels outgrow it: an OpenWrt initramfs FIT image
holds a 16 MiB kernel, and bootm stops with "Error: inflate() returned
-5".

Set CONFIG_SYS_BOOTM_LEN to 64 MiB, as on the other LS1021A boards, for
both the SD card and QSPI configurations.

Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Alison Wang <alison.wang@nxp.com>
---
 configs/ls1021aiot_qspi_defconfig   | 1 +
 configs/ls1021aiot_sdcard_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/ls1021aiot_qspi_defconfig b/configs/ls1021aiot_qspi_defconfig
index 00346509706..8f01b649ea7 100644
--- a/configs/ls1021aiot_qspi_defconfig
+++ b/configs/ls1021aiot_qspi_defconfig
@@ -12,6 +12,7 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="ls1021a-iot-duart"
+CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x82000000
 CONFIG_PCI=y
 # CONFIG_DEEP_SLEEP is not set
diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index 2dbcc7ce609..d130cf8d34d 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -21,6 +21,7 @@ CONFIG_SPL_TEXT_BASE=0x10000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x82000000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
-- 
2.43.0

