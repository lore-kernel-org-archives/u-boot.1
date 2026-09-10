Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816ADC79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D958C40A1B;
	Thu, 10 Sep 2026 06:26:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eL8830Mz9DK0; Thu, 10 Sep 2026 06:26:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0C78C40A06
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789021581;
	b=jG4j3rdCT+3mXFxI5BDchRzo0qGAh5T/qH5eQ2DqdNuGhW3roE4Vl8R+8FRYvA3PPPqC
	 sZnjN72GEN7ycu7Y14zDtZWIuSGPzfbh9DLKmvEfLkWt7GmqEOrYgD+/p+Rwb8pNfsNGM
	 CiXXLjYT8McGHEGxsCi7nTlaqg1aYAom203PRKNeMBmwaFS5lHwiLiZqpRGExjWl/BkIF
	 WfqdW5E9vpRGd+DHv59tyUWZJ0qZ/hnFgGzoKtNnpnFK4JaQWxQxZsZMDoRQR+qXn3L1x
	 IKXw9sqjrjysmsL5ofAB1kZairFj2iz31YBFmMPQpGeYYPvdAAh/bN6ECmPsIDrAy3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789021581;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dT8blZdLNkngRBwWBfl04p1bmJUkL7klz1dklyUHpCI=;
	b=pPUP6Saj3fNql2c1i5skQ7r4TN0d1mzQAe0yeUt9BtsAfy2rJJ8lpCbqwBQVuf+SAbKs
	 zP6nc3jBear6rX+YWOC/pQpUvmr+kQ43GR1gw7k8v41rWrGL/tsIMzVoZUP3zoSNMN69h
	 G7KLnnp/HhlZyPLDPiL7CP2GFhjkCWrhoMSsC9vfuj7DCKhLgxfDtGQu9OQy0abUgxv62
	 zKZLPM3sYQNKwQNL4NjoQtSZzKB9ZulrbtA2QbMIn9linWCjpg72oNatMydhGwd9FKVrv
	 iKz+blnnIezTty9FsZZXgiEITB3j9VQ15QiRVv8sMbBTm/kW4PGLwtcjcjgL4qILcSw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789021581;
	bh=dT8blZdLNkngRBwWBfl04p1bmJUkL7klz1dklyUHpCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MvcdlfpMcHB87F1BPIBIueITs+iR5UOkXxkL1Wsma9beDK/I8k6oNxJqHLENwKrFR
	 CG6YWnyaewm2zjB0fi+TuXuk6DfYUyhGc5IkBJMUk6RTWCnviQ4Gd5lSEqThYZpEsu
	 khx+kZsppOZu4lmtlMb/nR1BE1TRj8XnZ79ll1hRDeXNZQMvbRpRTLDcdmW91bg9jq
	 unz/E8jRkY+wElKnMdLP6MrHB/ZQbklY6z+2By6SLpoqGjWBOTfjM8qepl3GfHtB7l
	 ultZ6sr6W2CRXAaVOoEq7IU4HgYf/D+py9vK84BbFBuN69VEN7nILKwyZKmslEvBlG
	 g5u6v/dMKp9CQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C78C40A06;
	Thu, 10 Sep 2026 06:26:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9258E43F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 842FF80EEE
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L3Mnye1E_0G9 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:26:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9053880F0B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789021576;
 b=HoMLVfqNJddXg3FvzX6ni3zssH5Sup3g8lI6TxJ6nt26swmFnpZhmJexhlaTnx3o6Z7Y
 0Cdd7cRfOiyACXQinrcBMM2f7sLBe1ua7lwE+I+179/qp0gXQ1yvmAXJe+AJQGNv7C3zT
 s0zy55IOQpFc8o9xdcnxsY2piHrKmZAMnlCRpm/VQeF2npZfJLxcSblQZSBm9RMSoq6Hb
 kCn6lObW3gs8M+sMMhjCMcGNcjd8HPfQhMB+g8TGQUycULD7cGfPJnk6G8olQk3+CgFS2
 R0l7elnjtgf3axQ0R7UPSH4y/inwFn1MUQPS5Vy4Uof2vaeEEXR+nL6Db9XllLaWE5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789021576;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=dT8blZdLNkngRBwWBfl04p1bmJUkL7klz1dklyUHpCI=;
 b=s9TOkaQkOaytK5ohJtgps9XVtVKLKktan/585W/4kqqjKQ3lsL7ibpg1njudW45CGge3
 wEaDbzf4mn0ZfZ+zYTF2+kcsj07a4kNwDKneJ2PMrtAN6zUR7oEb3Ho5Ct34rG9NxdCw2
 TVsqGepBmWP/SrJWOFECCcAOOaRgAaJKJMmpXJVSZvoJid3ftVmg6JazhNFvugSgAEgF0
 i7qu6DaZv4Dn0f9v8GLRQ2jnA3M0iQXxjIvTL0sfCrtr0xpqLb4F1KpzUKBVEtkYv5CQ5
 GZJvma7OFk70AfHDwaf9/G8PI5THpx25GwlYcD2dTVKfGg8XbVAYIN4BrXfzK5sIqYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=g2Vneo1v; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=g2Vneo1v
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9053880F0B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:26:14 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b94fce6e8so7969225e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 23:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789021573; x=1789626373;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dT8blZdLNkngRBwWBfl04p1bmJUkL7klz1dklyUHpCI=;
 b=g2Vneo1vK993JhaJVJOrA25luHSTClcFwgT1RKtA+XIo/MamHaFB+crYvYuqmLCOS3
 6tM2Rge7USPl7sr0fzAWk4m5hlbWeHRaPlmQLuGqdfZAGMQJcDjisbsahz/KSRvoNli8
 ArHKGQzVc0aGz68LNXa0FjQnwxbVS4bAKw7dlaiHgUUnJTMx5A19I9ds00+BSnlEKiSq
 7IgTYrPhYrPWzjRGOsGxenP5hmsMJ9HTHMfKeBzW5s3n1G7ryPWjvuKxeb80O3WN9jQV
 a/GLI0fAxLt+YIAxqwSwgEnQnTSCPp7nrluocbB9GEALjaW1ZbhwRQQww16AXoFbfDn4
 t5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789021573; x=1789626373;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dT8blZdLNkngRBwWBfl04p1bmJUkL7klz1dklyUHpCI=;
 b=QFjad3WOocWQUt1QldSkCVGoouxpqw/X8REiBVD8InSb3WzQRtMWPkBpA2Un+O6cfY
 eWFDYXKtvvwssZCZXgg7RM8h7fUMsy5oIoMX52hR2y48orHedYW4jeArPji9np/KmhpY
 oVBT8zyj7Lcz5ScxxLD8wl3kmVRp5ZARp90bpvDlOmSuuJ9e5cgwkVXbenRBj619L1Bk
 e4M/W84X7ZasW9NIrFgq2R0V6gggIYTjrw5GNy0R50aeh3BauMqe93D+qGijXUXSZkQl
 iI2CSFfdl10WdIhBLnOTVpZElzeXCCUvUAc4Ixz8+2L6ZrtSeY9aiS/NiEPTdjeDUrHt
 YSQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxexSQTWIenCatYvYVFjJ+ihJoN2Qwev6BidBNd2bVIR8ONQ4jsaP2aMNnpM77PBAOu9AV1DQo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kjK2k3RqnY136+U7ghiLrVPT6cDW/8eP8nZUxVWpJDhBX71dMa
 NZ0C3mhmwQmyZ7+5Sj08bdkEFjF5cZyH8rtMy0mV0yfAEaakOFkPAII56xvh+FS7BFI=
X-Gm-Gg: AYBFou0BSP/M0icBhpocuUbaXg3mIifKNZQ8BAMjVYfEg1soxCav/CXd6RbhbN7METC
 aVFs4o6/W+3lAl+81LLJAKpBwxw2ebqhw/Q/juaGvqO9emQwGmRd7tu0K6dhoe0cIB6yIbsu1s4
 l0lnA/15jFHacvPwT878wZSs535jRDlFgCiMc8rQISH+SVVj6oqpnjq5D2D/N15Q7qKhT/67brD
 Bt+5hBkD0XHTBGfeMuYehG7BXap5i5OqQv4ZtMEjpmpWkVnYleILHnJwUD0JaxMEDusHZHVwMQ3
 dxLTMhbw7XXxBDypWoQfyxVi/duyxKCQqaPlwrDTcdAtyZ6QUxevL0dsiFXmlRO4dsxqeRpW5Ep
 w6FAWCuWtDv7RY2ITrB9Nf1Pl1uzL4SZ4pN6QKaEUuJ9apCNGfjcYM/QQhhxFheofQrE6vNBpvN
 Pms2eqG03QDmaGkqCrzdXjrgpjxAAr6Fn8NYtPzxa0xCmg/ZMKVtyx90k7/Wq9Mqw+epbz6j/ng
 fgMyNPFz1pLzHm9iBqbXXebmEyy9NRHDJPlEwtmdrSukqqSbyzpN61RYReRCKEeoKlv+rKTAS5B
 SIvO58Qo1EzI1pk=
X-Received: by 2002:a05:600c:4fc1:b0:49c:fa21:e73e with SMTP id
 5b1f17b1804b1-49d2590a952mr44335865e9.20.1789021572850; 
 Wed, 09 Sep 2026 23:26:12 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c38e3asm52279585e9.9.2026.09.09.23.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 23:26:12 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 10 Sep 2026 08:25:51 +0200
Subject: [PATCH v7 2/6] configs: mt8188: enable eMMC FIT boot from SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-ccaione-upstream-mt8390-spl-v7-2-0a5cf09c5761@baylibre.com>
References: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
In-Reply-To: <20260910-ccaione-upstream-mt8390-spl-v7-0-0a5cf09c5761@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable the shared Genio 510/700 SPL path entered by the external DDR
loader. Keep BSS after the downstream SPL reservation, leaving a 0xc800
guard after the copy window and space for the initial stack and early
allocations. Use an 8 MiB heap for loading the firmware FIT.

Load BL31, OP-TEE and U-Boot from eMMC partition 1 using generic SPL
support. The MediaTek BL31 stalls when given a runtime devicetree as its
platform parameter, so pass NULL there while retaining the standard
firmware entry-point parameters.

Keep full printf enabled because the MediaTek pinctrl driver uses
scnprintf(), which tiny printf does not provide.

Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/mt8188.config | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index 29e2b3db878..a7a59940646 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -28,3 +28,36 @@ CONFIG_MTK_SERIAL=y
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y
 # CONFIG_RANDOM_UUID is not set
+CONFIG_SPL=y
+# Fixed destination and copy window of the external DDR loader.
+CONFIG_SPL_TEXT_BASE=0x40000000
+CONFIG_SPL_MAX_SIZE=0xaf000
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+# Preserve the downstream reservation, with a 0xc800-byte guard after SPL.
+CONFIG_SPL_BSS_START_ADDR=0x400bb800
+CONFIG_SPL_BSS_LIMIT=y
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+# Leave 448 KiB above the BSS limit for the stack, global data and early heap.
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+# Keep the heap separate from the loaded firmware and its reserved memory.
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x5c000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_SERIAL=y
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCONF=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_EFI_PARTITION=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=1
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y

-- 
2.55.0

