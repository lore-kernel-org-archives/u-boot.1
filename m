Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586EA606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BtZ1GzL5;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=J39doPUt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3459B60651;
	Sat, 28 Nov 2026 13:12:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Lv26JKsE9ci; Sat, 28 Nov 2026 13:12:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6EC0D606E8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871543;
	b=NoEP2IHuTuK0XE7/bVHvv+jmnX/9GUo01E51OJ6MQi65b7oytNhGMozK7f8lwVpgkOuR
	 RagLbWaSGYCXad3HOQC9PXsod91hADRb8QjlBtvbU8pUOKFZpE9GLvpmPoZ9hGNbV4oa0
	 RMkFrtkrKley5+sbWvPaqATo7QvntQF0P9w9W7DzJNl3m0vIaA0WZUkcg7gMKI/Qh+VfD
	 WR2OvNlICXk/jPmHzWnwF00TEvWcUrtmgCL+k4mP21k6oWeGO8J5xtKr02sSnJvZ1OCkY
	 oOyEVfwMJk5H/772Aue+6ELggfmz66sXSeh9+QxTrAeUPp8WWd82eRm/2ZomJhYMW9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871543;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Tiq1DvDEJ0KYcLTyMcNLPRIBwD+aW9qKWfb96spWBOc=;
	b=rOSuYv3Fw1SrZQIwQugslI8bUsMG91nEcdaj1c/503zdO0V9D4TkxvHEPkpKRh9+S9Fm
	 PHXRc6WTGVztyI73mSyytbyrHB3JSYEB3aE4VWECCTU3XxaZ/detqWH96oq+Mz3nw7Rxt
	 VIMVPKxKOc9QA03wqEGsb91ozMUJbeLW2saJ02hXC7r5CuBx8Vo73EwoX6qBRH/s5Vxqf
	 jgwErq0KvRwXhGdxRjqVklrGYO7MYyyoVGIQSS9WlvBWS55oPAlt5SYZc4/80wdUNtsNO
	 MJum2r5QaMaR/MZIEpwBVg8seiTOA62n2aroy7KS96VBjU7nQJ2hWRh22VZ9aVH97QA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871543;
	bh=Tiq1DvDEJ0KYcLTyMcNLPRIBwD+aW9qKWfb96spWBOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BtZ1GzL54Bo+RPpJZlHUG52NhBYd9aUzWNeVNYLfCZE5IfiZwuTfJnELez0xkcY3P
	 /8q5v5FB30aShkM80LyDorMZpWwDooEucenoK8d86RPoWiBwX8aoLR9hRZJ/Rel7sM
	 L6sXWojB/vE6S6WkSie/Lf+Ifn8gKRqlb5K6SOJJbpPuLCKta9IQAdD0lGAiLZ9GKV
	 dHFTyEsOKXd29yneDw1NN2+wf6Sdg12c5cyy16/2wMZ4x1ghCBrGC2fjOnsZrdvQL+
	 VIOnCwyHh7pycrvQ+QHpqzEP8GoR2n8c+iQmJ1D783xQ6cqSpHZRrcOTcVK58LzO1D
	 ceANmpZN+/N+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EC0D606E8;
	Sat, 28 Nov 2026 13:12:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8808FBF4
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76F9081101
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cgr-GyCr48l5 for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:12:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 83A1E810EC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=J39doPUt
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 83A1E810EC
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:04 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so94423455e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871522; x=1796476322;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tiq1DvDEJ0KYcLTyMcNLPRIBwD+aW9qKWfb96spWBOc=;
 b=J39doPUtfzFwraqsH/50IUEy15ISRXbhTmjBS99j7KuZHgwov8yxS+IR5fxHQy5Q6A
 v/bsviFk1jFOIzWK0Udyv6lcRi9EIYbabwooG/S1ez6yV0g9KJpZ7CQ6xI7HBgT/S3lr
 khG9ZLzv1F6fPqhLM/+5EUDYI4g9e5/1StWVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871522; x=1796476322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tiq1DvDEJ0KYcLTyMcNLPRIBwD+aW9qKWfb96spWBOc=;
 b=Nv+H/nMU7bOJsnFN9jzXNb1moYUWnsyJCk7H7jwaKy+vACxCgCrXs3WnqCECce0NA1
 OmdSqmXRpURnP5QL+l0OFjduXv0LcL54fcBYmZbj0lJUsQIRFVl2Jfv4MousGBIYQQD/
 u4XBnB2Scvth9DNJMTQhoI97xdfr7NufSJ2f7NTyw1ntsGsbpjX2EL1sS2qpv3OdzJYf
 fyfwoLpDRE5e2NsRZFfDWZ9bwubGwbd53+LbZGtHh5+T7QpSz05+alXuFFPKHhMaHJfx
 0a56Q0utTTewiBv1MNqUR1b8i0Vpz3SU29e5DRolTGWWEWH+iQ77J+GsMQIYu4JsVUCS
 YA9w==
X-Forwarded-Encrypted: i=1;
 AL+hErF2AULD+SY19GJ3f0AFbS+6JbIXlOPBtJwGJ7qZyrXzSjqNWpqb35Ps4ejNvUJLly/InxOEgEs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+4gY3q1y3cMvzyY9Rx+Tg2mQD5Jp8lPzzRLLnmX3XDAn94PeHu
 HFQFop4A7x2K1JWTzgofwguIkuMW4bzP5qUzTLs+utS+z5D4zKmv1Qb1r3q5sXDnSrQ=
X-Gm-Gg: AZFdTZcbrE9t72iYfNxw55RFSKUY+OvxsZ6VOcb2Qj54JQx43mVQrHFz0Vv7sPkgqK4
 kKdoOC75ERiJswv89LElnjNRBKlD+0FNHs3zoiARb0sMoUhbQoCLgwUHWsrbM0d6P8YMsXjZILy
 uSxk7Kg/v+DspOQi1JhHBxtvbOLiYYsfPe5I8oxoSHdDBwK/MRNoN+COsJ6TPVmXHIQQSq55ckm
 MMaxGlU1IOjBGfusX05C46331ur89QAb11Se6Zaortg1z81V42gz1rmHn7RSoEPP+ZQml24Bdx4
 Y5GTn+8kO4TljVP86NjYrPvl/f4bN4AlxbBX6201rXsx7bdBt1k0FLnINC1d/kC+No5VsfszbAa
 wjPuW3iUv2z5fnPO9Psvs1vanFSElxAwDdaxMk46yf4nvhW2nn9R0F+PqUjWQd9igfYjyDu703y
 DL6l24iWRg27ZU1mEaHfL4EbCk2ZSw8eVv+PNvrAeQ6y30ka9bFOJFDN2dm8lT5guJuWg6YAApR
 lfgP454mjvhTDtmj0lxEVJxkCA+VnwV+fWlzMouwtrzeDexa2NvUcUQ0W6+oHo8O5RZOioVLQBI
 Dq3nFPF0h96+giUizjDh6WpXQP/jggpwJ0+DoR7b3Q6Z+1bJW/FSDHW61/uCpvSnSRFNfBTT5ir
 csP8IIHkSZwGa4i0blnreaTyuqF3pChj+qWUVTLksf7712QV6W8QOeDqYIM9mywnhk4qP2oM10k
 tQZA83jSszesEsL+XDcA0k5mOP+Ao8w3FWZcI05TiMOoh4mrw=
X-Received: by 2002:a05:600c:530f:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4bb8892a21amr514991495e9.34.1795871522391; 
 Sat, 28 Nov 2026 05:12:02 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:12:01 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH v3 20/29] arm: stm32mp: move FWU multi-bank support to SoC code
Date: Sat, 28 Nov 2026 14:10:37 +0100
Message-ID: <20261128131125.2141352-21-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v3:
- Add Reviewed-by tag

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

