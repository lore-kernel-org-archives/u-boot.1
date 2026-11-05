Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F701606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gnkBWGkN;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ZRWWELdq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66E5E81138;
	Thu,  5 Nov 2026 17:54:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pl9QmbI2vS0m; Thu,  5 Nov 2026 17:54:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4FA838116A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793901284;
	b=P9+8ocZf5byzRyUPwesEJZKaJpMXuVuaZxPMCMjfPrS3CbI4aGYqbZnltHmKhA9UpBzr
	 UJGgD4LLlpVTE9qMZzlLQZdYSnz/PGs22E+QzidV422an+WriE7oq8e0l5A4eVzMEh58v
	 akphkhWtVA8V/Rdzk5Lm6fuUKb+vlmV1/8sqbHCb6b+3LrWplHoEJlaeFRpu5KFtmWkYy
	 CnTO7bdnNGPQ7/SJzOS96l5ZD6Mp/OcwJg5OknrQ8n5ybyTOhgv/YgcLgzoTqIhWQt1Rb
	 ROou2B+OqXObRmF6tXZL03WickpJZ2gVtOyk68JHzrB6JA6WNOjDtF8wWI7i7MbowKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793901284;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CSi28tPh/bWHngTxENSJVcQI8F4p8ex6Q1SUSDMTArU=;
	b=A/OBlwvJvPbCwa7ZBQttR1rV0LslBibc6rtvKrU8Ib8K19QkHtT7w/Q7mL1vd56DfpSS
	 T+WyGzA/G6tZrHCzTvXHRuxk2UJVFj0Ef9VQjHokC2dUeCJ3opEme3xdEDZhFnjIeW1ss
	 wYxM1nFhLfPvOJ3VpXlqQDbAVfgeDQakhapMpzlGqSWh8rBD62ioYz2xC2l45Cntz8OgQ
	 bQCtS4v1Zz4sVIb98U48JP4brQHQLah4WlBEPKkoLXrQpNHEEe+NU01e4r2Iy0lWihFaL
	 RWTqWEXRM3MmLWqWTlO0P7SnuZfNsTvaKon/9dJnc182KtnVUWzFUzcU/69ICi8SbDg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793901284;
	bh=CSi28tPh/bWHngTxENSJVcQI8F4p8ex6Q1SUSDMTArU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gnkBWGkNvQddSuzgb1zWmxNLF+EBc9b0r/D642x9kKpu0a4sCfntyfM1WcJiXR5ih
	 DLCBlYGwbCI7MbNQjXKSm9BLXAM4KfpfyBanTpLZhtJpqgyi4uiVYg17uz9f/HK0zz
	 L3hexBB6m0k9ihf42RUxYbe82WPB2ntYVxmVc34nVyOdr0U3S450P0pgi74IAU3JI+
	 RBLKPAW9/khmXPJcd2Pb0wEMGviEb70YfR7UjnGERJifCSQ+QGsK5J8rp0CwEYpLMo
	 ai7R0feTfNMnIDTwQ/2db39fdcbzf69DTQk7zSGqECSx7cJMpiUZpMdcdWu888aARd
	 2JqwrOs0KVDlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FA838116A;
	Thu,  5 Nov 2026 17:54:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 59C5E1779
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FEE760820
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8o21irLlSjr2 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:54:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7EFD660697
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ZRWWELdq
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7EFD660697
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:35 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-705cb6ceebaso1449920eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 09:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793901275; x=1794506075;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CSi28tPh/bWHngTxENSJVcQI8F4p8ex6Q1SUSDMTArU=;
 b=ZRWWELdqH3kAAP8aR7T5FNeZh8sD4/Rd3kdV5xQFmm91acHgicqqTBPszzpgXhjTYz
 NqmzwXkj0lW1J9QYB5g4UjQJfhuxL/SfXwuOZTDXrBFEBHbqjuEUchU9egtdmNp2E1VX
 f9+ulkeyMvh5TitUC2els7jO4hfq/3gzGU8GxIbHKokRtfccqmxfpUpUVUQMQ/DFIq+S
 EuCluCPt9D9pKNIqxUJy66K+MpQ7q3tqZ6Fhq/HH2YZpSHQC4eIkXh70ovVPtGrw6Wf8
 oiU//7VSqhivMukajjP5NdnAbwNXHddjgyJih+n859tTXGWt7sXn2ITpGDoqjp0zAb1r
 WEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793901275; x=1794506075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CSi28tPh/bWHngTxENSJVcQI8F4p8ex6Q1SUSDMTArU=;
 b=bCs9cfvi0U7I/1pSgFazF3sHkukwig7XFJhA1lCcYfGSNhBct9llsm6NrZVJTGu4DQ
 bNQ/SuZVMPVaJxcyCrqdAYdR4XFmKJaIch8JbFGe6QPw8l4+XyE/2zdUt+nT9X/at4/m
 DkuZvkmLsTJGkElkME/6jLPIJEK97v6cd3CT1UypWKFKqAxv0CuOMwpwZrRgRWHqQYxB
 L2D141aHbVZNzI+DihOuCCZAkVhErNGdH50AB4W3RDqE4tPJXq2B1yV3T9N3XhmRCS9u
 dnN/6iP/oUXU5ZuqgQJMmJYrRfNhesHxnAVuqMWlNPP/jSqw7UvBS/kIs8Y0RZz91Z0c
 Q30Q==
X-Gm-Message-State: APuU4Z+4keehaPc6OHo6uimPjPVvnb3pqVjVeviBNda22vUEuuzZM/z0
 3zxPEFKZ6eagggOnnNEapTvNMpcA9I6aGcdsZtLz+56c/2iVvfGdm/v2krlIrkJP22Q=
X-Gm-Gg: AYBFou3m085Is9C9GrkSVpJkE3fugMMc8QheoAdxhsaGOrUShNGSuDYsDRhuzg3Qfn+
 W7V80tZ2HlCuxYWz6qrGJ8/HrGd40Jder+79JPEMdo3vxmfaHuPS1DzW67dmuWIPIcHSzzweqSD
 Udch7cNNNFhMCHGOc6p0UvzMBpIMEYXdK7062sQRsY2ciIXAvm/u4aNdLKT8516CZPblHWl1dpA
 Vqw82fXIHPNovX2Twb1+2ezVA5do5g7plPwIzqElhCwcmRLMG2EJxIzwXfyYm5BN7SFzMqdGDZ4
 j6PrzGOlHJNpXnqIWxelKTFxjWjZWBfNn9BWv7W0Zq50hrnpq6BQPqHqmrfNc1IjChKw6KYTspb
 mJbUvDd9822FIN9xHI+3Y3jVLeDcsp7RHujFiFiaBBLWbWSuSoVoN6OWAxAof9G4y45JrK2MArv
 5UG2XrH8jF+21bD9U1nLtzx5+rYfenEN0KAVNzTnje58Gw9ByPMzaPDV9rGfFrYDL9xZiVke2qm
 6Nd4C1nKUQpGsP9xd6la3BmlFLfeoHt7wNslFzFWSC/DrnVEaMovRuJvKvW6kHbyVj3hYrxQxE+
 jZEkYyL1SK/rkEMitx53G7Urtu8r3RQw8g==
X-Received: by 2002:a05:6820:a513:10b0:6c0:dbd:309b with SMTP id
 006d021491bc7-716e794cf0emr176441eaf.59.1793901274957; 
 Thu, 05 Nov 2026 09:54:34 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c12eb1b9sm4659682eaf.10.2026.11.05.09.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:54:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 11:53:39 -0600
Subject: [PATCH v2 4/6] configs: mt8189: enable eMMC FIT boot from SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-genio-720-spl-v2-4-4994535a3848@baylibre.com>
References: <20261105-mtk-genio-720-spl-v2-0-4994535a3848@baylibre.com>
In-Reply-To: <20261105-mtk-genio-720-spl-v2-0-4994535a3848@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=FXGgs3Zgj6qjepXFrLzHGgyJEiWI/eGWcf4i1PRNaLU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7MK/meBVqTQquwZ/6YvkxpP82n3nw13ZCHxp1
 Pb6z8tiekuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauzCvxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A3XkIAJsD55sLMxs2MD6uCUB3J+yzbEL++J1fu5r3br/
 LIjoaoJOKj1xvBT5s8IosLiTgJXl6HzL89PaKfvr9ld7SoPial1RvBCAqmbCBCOz3kB6MJIiUbh
 oVXURNuGepunfNllb7e2EV/2lGwGxKdeP0e02rkS7ANPmHbqv+saJrRUWGuy4jfmikyhgIIsUdY
 Llzda9PD3ezLPqIyXa6Oq09triPNc7og0rU9w+a05KQSQ6xodjKNB1bSXzE4M+h9sdggfaWCJgr
 sJt+/8+GCiz22x4JBF7XgT+dUdqROYrpt9sr+oKMQq8UuhRpEabAYaajpb/Hb/uL3Zt/pVYFI32
 nNU8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Enable SPL on the Genio 520 and 720 EVKs, entered by an external DDR
loader, to load BL31, OP-TEE and U-Boot from a FIT in eMMC partition 1.

Reserve 256 KiB for SPL: the MT8189 BootROM loads at most about 930 KiB
from eMMC, and the DDR loader needs more than 600 KiB of it. Place the
BSS right after the SPL region with the stack above it, and the heap
away from the firmware that SPL loads and the memory reserved for it.

Reviewed-by: Carlo Caione <ccaione@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8189.config | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index a60f67bd7cb..7d526041ebf 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -62,3 +62,37 @@ CONFIG_VIDEO_MEDIATEK_DSI=y
 CONFIG_VIDEO_MEDIATEK_EDP=y
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y
+CONFIG_SPL=y
+# Fixed destination and copy window of the external DDR loader. The
+# BootROM loads at most about 930 KiB from eMMC, so the DDR-loader region
+# and SPL together must stay below that.
+CONFIG_SPL_TEXT_BASE=0x40000000
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+# Place the BSS right after the SPL region.
+CONFIG_SPL_BSS_START_ADDR=0x40040000
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
2.53.0

