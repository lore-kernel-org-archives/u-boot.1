Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBAC606A339
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ajAi4PuD;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=HJ/k045h
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA2918195D;
	Sat,  7 Nov 2026 14:34:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TgE765echlo1; Sat,  7 Nov 2026 14:34:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 12612819C8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062045;
	b=mJQ/eF6HwmVCTEUg3Mlp8YBz/ST+4Z8SLxqO0wJw80E+dHkLR4vbGXd/Ga7gof+CzDKG
	 rWVrdDH2g1hCFmDxvvpfO1SOJH3mg5ucMScMOyTPASWcvh2cDeCcva/cHQEkp+Q5ByDNw
	 2XkzZkYBX+o8FNWDCCtbF61397a0HkolV12j7+0btLbNf5Pqif8aOaSuRSQkmLJViMUA6
	 cKSI0ke6m0SYbnnbiPhBzt6fG8wn1Bl1wc87lv/xm9eboLMsJbkJ4IYexYkhgNdfJr7MU
	 Vz3JTl1pwibBydBmFZOs6rjk6qY+fvEhVupX7hSuHw3OezN1zuZFYP4cWg6y3VzvWmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Is8YiIAkPRvCdo9EIVYRvpHHVxIIDYQGu3g9U2pOqrw=;
	b=tFwnUxypegr24jWDO55uOW7aKwm+nv9ASNsLTx8nu39DNyuv4AGCWSqTxo5touZgVDMU
	 dSqrFAMowkA3GapKu+76qvYV2zwVThyOf+HAIqqEmacm+XrKyzZyrKOwfFm4EJpbD85Vq
	 +A5TdorPhKGmp7T2BW5gyi70Vry+BTHUNMUOMwYTyeL90TiycKO5AnZzkJWlTgg1mK5i9
	 8KLpg2lRwSVGL3vrlhJQ8xx3rMFcTGOfsmEeZsdCwuapJzt02VUsgMc3c6n/7GUV3H85/
	 8WMIbSfJMmUH+ug2NzoYHvNZLRavHPnG8dR6VHHv8b+dUSXyPQvHNOmSo2rJngxWHQA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b="HJ/k045h";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062045;
	bh=Is8YiIAkPRvCdo9EIVYRvpHHVxIIDYQGu3g9U2pOqrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ajAi4PuD/rJxQmGghzmDOypIRmvRXIYmpIbMbBD0Nm/+FDPEd2ZmXrpKQU935yXl0
	 WCMsBDH6VAt/XRFX2mGFjK3qXlLcF+j/6P4uCilvWfaVHlB4NdpJp/RpLON9WeGeVX
	 rT/BVmv24epNSsTzmv958SElLsVAmAwGfqWzRn/+DfFp7miBQKVK/jreO1Cj1oUjll
	 fQVIiTwqKJ4WUKfVyw+bRxd9jo/+XAeNdWjjNPnQ/FM/iQDLkDZ7syC2zV/lOFO9NV
	 DArIhtWjWi7pb58LXneLxBaps5Jt05gCMBGPN1lWxYmhbdaET6Yyi4Lz28SYdhTFSJ
	 KIfIGdQ5ObjbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12612819C8;
	Sat,  7 Nov 2026 14:34:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CB04C4B8
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE508816EF
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ggnG9FAwWK15 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BFBAE816E0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=HJ/k045h
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFBAE816E0
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:39 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so952983f8f.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062017; x=1794666817;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Is8YiIAkPRvCdo9EIVYRvpHHVxIIDYQGu3g9U2pOqrw=;
 b=HJ/k045hLv8yF9j1gO6C1qmEKRPn6MDoEm6WxRGk8cwJ2jctnONVjBhPiz7CmWPzoZ
 SRUgwL4AApfh9GMQNrOUJlXNnydlzxBwd+Zlug5rlh3zLDlOXlBSNT8DHfmQrobe0Qu0
 DApwg1RQ5N+ximrltLrK5+smDdVemLELR+HGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062017; x=1794666817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Is8YiIAkPRvCdo9EIVYRvpHHVxIIDYQGu3g9U2pOqrw=;
 b=FzgtcUvsbuVbD68KDQfRGOmY2YTVXdnzkREJ5BI4S3VvnzTfkmEiUqP5wmRL3ynRER
 RAqL+S97hgeXBk8EvnN6V6bLecUY5clAOnfcqKLBKnlIuucCpLloO6AAbMdX008/NkDp
 veJEAeIkb8dlVwGsMglf71T+2pRpNSeAzq4f4Gw1Jq3kIZXqC5834s7K05TjpewPkQcM
 cI2VOGed1GHJg1stWy8NoFDAq6e+QOeRUYsGC7nPGF9e+JNCyEMbISfRKyGEg5/Kxf5F
 /EzcxVWyjUiSlin06fZyZt6U5C+84dIizVz67G1hxicdpQKE6v4AIrDQXlVyYcNRUu0M
 cHVw==
X-Forwarded-Encrypted: i=1;
 AL+hErFeogMq4rikKfJYv4nN8+zXqAxr0aihOZRfdNaGfbW0cglkMgDvwxiWv5BcfdpiNRzAXjBKu3Y=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+q9JbsjCYCZXWlqXfeWHh0nhCijrAT56eEhcgmXUJQu69zc3E6
 9NEbjdrjNEqknYHcGGK4GTuG3SE63UH0WY62ZLqY/LV4phGUTWAX42VtZq2FtUnRhBQ=
X-Gm-Gg: AYBFou20avbKivgV9snLND/i80unntFUWkPPPsH5nCwVUpntBzFZf5xmstgubGMhn8E
 /yUu9c8gD8PNJjffXPjqY5YTjpwHTVvm8rkpYq8DQgAutSqxYIUawTPS4nE/Y28BWmYTqc74hNW
 ZYqsx+kDF4tfyA5DQLdL+oDyNJ0w4pfT0AzUqLKrDVZaIsz56mhl5pxHI5d/ZctS3PKwmI+Xvew
 lRhJVKmK+1xTzXqkJE7Aah+oZpTHW3aeEsbNX6SXihiZWaf+s1O9BFQ8edUwTBWaEtw58Z/OMJh
 oxN8vYTPJmLbOtgInpnkXoD1lmriWvQ8kfha7NTdiRz+7CpGv+omALO/O7Dvyhbt37t4zFsB3o+
 W1egdugmMd2IvgfCCCk9xTMVD20rFMekfdxJUYclNquwp+mKR1FOJeR/bu5BclorA5wVZKWReL2
 JDwwWgGhD7vsVx8rVW/bvI/d1eIxvzpvui3zrZkD2aTYB4gJqhdlwId7HSRqx7c/n05ZWPTIgxu
 +efT4eSZ7syfITVPyymCR38r7BaD+ZbCBb5tjuuR9KqiuCH2jhXgbroX9sEr73u+zKfFEQ9i64d
 EoaWzsrvQvtPVXf9pTrV2lxYXUVQdjyXirIHuU+oKgLywghQte88vG/xZe3idEHJfmmRX5SDMFu
 +Oo9gHx1qoVWrf5K/JFEzk9PULkr+0WD/ohFfN8f75vUHbOLu+prCYRFuh1nr1a48odQTI0tAUg
 cfHPHHlRjyNDgNW547FJBV0BxM/jlWoBDCUshTf1Tz3Xt3GHU=
X-Received: by 2002:a5d:5e86:0:b0:48f:ead0:631a with SMTP id
 ffacd0b85a97d-49277e91eb9mr10361564f8f.47.1794062017580; 
 Sat, 07 Nov 2026 06:33:37 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:37 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 26/35] arm: stm32mp: move FWU multi-bank support to SoC code
Date: Sat,  7 Nov 2026 15:32:16 +0100
Message-ID: <20261107143241.2236511-27-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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

The FWU multi-bank support, i.e. the boot index read from the TAMP
backup register and the selection of the partitions of the booted bank,
only depends on the SoC and the TF-A, so it is not specific to the
STMicroelectronics boards.

Move it from board/st/common to the SoC code, renaming it to fwu.c as
the stm32mp_ prefix is redundant there, so that other vendor boards can
use it too.

No functional change intended.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/mach-stm32mp/Makefile                               | 1 +
 board/st/common/stm32mp_fwu.c => arch/arm/mach-stm32mp/fwu.c | 0
 board/st/common/Makefile                                     | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename board/st/common/stm32mp_fwu.c => arch/arm/mach-stm32mp/fwu.c (100%)

diff --git a/arch/arm/mach-stm32mp/Makefile b/arch/arm/mach-stm32mp/Makefile
index 853469f3c503..e22207465658 100644
--- a/arch/arm/mach-stm32mp/Makefile
+++ b/arch/arm/mach-stm32mp/Makefile
@@ -22,4 +22,5 @@ ifndef CONFIG_XPL_BUILD
 obj-y += cmd_stm32prog/
 obj-$(CONFIG_CMD_STM32KEY) += cmd_stm32key.o
 obj-$(CONFIG_TFABOOT) += boot_params.o
+obj-$(CONFIG_FWU_MULTI_BANK_UPDATE) += fwu.o
 endif
diff --git a/board/st/common/stm32mp_fwu.c b/arch/arm/mach-stm32mp/fwu.c
similarity index 100%
rename from board/st/common/stm32mp_fwu.c
rename to arch/arm/mach-stm32mp/fwu.c
diff --git a/board/st/common/Makefile b/board/st/common/Makefile
index 36dfaddfa0eb..122b13c3aa8d 100644
--- a/board/st/common/Makefile
+++ b/board/st/common/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
 ifeq ($(CONFIG_ARCH_STM32MP),y)
 obj-$(CONFIG_SET_DFU_ALT_INFO) += stm32mp_dfu.o
 obj-$(CONFIG_$(PHASE_)DFU_VIRT) += stm32mp_dfu_virt.o
-obj-$(CONFIG_FWU_MULTI_BANK_UPDATE) += stm32mp_fwu.o
 endif
 
 obj-$(CONFIG_TYPEC_STUSB160X) += stusb160x.o
-- 
2.43.0

