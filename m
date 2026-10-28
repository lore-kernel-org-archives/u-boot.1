Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA64606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V1Q3Ahvh;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n271AIQa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E0B260773;
	Wed, 28 Oct 2026 12:13:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ghym1NIsBwup; Wed, 28 Oct 2026 12:13:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 375926066D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793189605;
	b=bzu6dnJn4deRahA1QrfIZgdxOzaRlbLLWr21ZdcZTe4zMy/Tbs00s77sY8/MErK/3AA/
	 ZHvH3oJ6tnRW5OMC8xo4DTMilwHEu9cEHDuFWovyBesF7OTYFeFfH/vWvmQrTW7leMelE
	 aXTdTesSosFtt6dT+AJLaTvROlFWonF7ys5zSr+hr4E8Rc9kCVy0oLvnr5+BQs6H/24/a
	 xh093OhCahyPIytkasU7zRQyds1KywDBbS7NywKJoseMd4Xvo0EXihPt8HIs8FQvnETAF
	 /kEzUeGXQpBMlXwdMMjaqj4/1e0U0r0JgmcUaNzGZTomP0tFgLqHy6v1XA95izCT05Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793189605;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4zr1EdvKH16vLOy4lBQyUT15AfH4kfVFziCfj4/qIBQ=;
	b=QoNu+PVRGoAKmsy3hWl2QXMRq2MC5Dfb/OwtR1/t3BeWkrmj8hEDRQ0lMP5N0goHddKI
	 UghuYwhNtIN+ClaBA5U7GF8Vo7Ut7llqIG94UpWXxke997lNQshcOGIrU7dE9cSjS/PNC
	 pp7kKmoEjmXSyALxNyAk4xqrz5mGYg6R+P1RPcC8yhqTRokdx0eDE4VFJ5GcJROspVg2b
	 /+ALhnpG5GNMw4UzYiWWWW47sZI5T5sHSh7NrnZCExBh6OHkTtwQF6NO2m7hnPQS2tozA
	 WvZH0fHIAPpN+ZOI4NYSyFi476LR077SDQUEuys48VP521OVXOZNxY0XxSccukLN+yg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n271AIQa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793189605;
	bh=4zr1EdvKH16vLOy4lBQyUT15AfH4kfVFziCfj4/qIBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V1Q3AhvhIljC5ckpudTVxuIrQOfqke49qdHp+ifRlwx1XpS7tYDMLDNquqCe3RGWi
	 l/v/T36/h+gmiu6lWjTvj+HsjZeBndNuhhYTsRrx5JPjZQPXtBMR9uIr6Z8l8A6Zxy
	 zlL5rK2krXlMme7sk9ocvF8tb4lxJ8w4J6twIsiJNN9KWZmamMnsq0UVQP3FdGziP0
	 JPu5c3BYxAKiGZ5Aw12oU2WcStaWgTWMtUkdNKABAkxJyrtKLn3/E6ThoSA/YFwMEe
	 07+LWvKoOrj7lTtWJLRHdYRF0DtPrOFj0YEZDVbOTqf/R1LCQdLWLFLZwogASq41dB
	 fY1YYbkkExEKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 375926066D;
	Wed, 28 Oct 2026 12:13:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F1B4E2AC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF11D60774
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OSzARycsXgJV for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 12:13:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1C4E60770
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793189600;
 b=Zi4r1g726Ofd3A0M109ZwOchNOn4X34TTc7Hz/dmcEIqCfIytsuamSF2od2TvwaidPco
 3F/Q8TV3HtzYKdjPxuhb6ROoEF+iov/r+m8ZuyC3MBKgWT55kwRtIj2ix5vrMpsMVH1XP
 bwEn6ITxbkwrm/bFaoElhPeRBNz9+gWt73CjAZe+4PLkEj7ifGo0Pm7BxpHtbTLx8/yKm
 78CyIvPmJtmZJmWUc8YEQ2NJt9JG8BPcBr6RVDorPuOo3dZVp//jgBtRv13TWcrMnSrj3
 8ci1aDuZnCpQejjwcKpt1L5tCsT8oGyCOyeoiz1mqE5XQnfSyxxWbHVTQIkfAY0PQQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793189600;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=4zr1EdvKH16vLOy4lBQyUT15AfH4kfVFziCfj4/qIBQ=;
 b=bTDzL9LSnYtB1hYMxdrSV8pURDxxEztp9FpIpPXjzObtYANVaLRJ3WVukBtK9GXLa+7D
 AwjyUJd0YubCeyEicPzDxvBYDRhwtdSB/KSM7MUYaWpNuje0vylH6UxKFykMHbN4HMQjK
 SmnHkzCcOoS5YNFAlIWjCQfFHmS+SJWSc0yQBqJ1SyzTXtX6SgtYiuOYRTETmhQ66nYaN
 /N4F1LpioY9KrA2Ug3YZuefcidWWTGqoDVyaF2YxmD3kpckURnjwqpzbQY6BvPqX6UV2s
 rxkMdMGzL3I1RZ9myk+9NZHjzhopAaPdPo1GaZuctp06PqAV+8G/7rRSE/7Rtrz7i1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=n271AIQa; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=n271AIQa
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C1C4E60770
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:19 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so9590335e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793189597; x=1793794397;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4zr1EdvKH16vLOy4lBQyUT15AfH4kfVFziCfj4/qIBQ=;
 b=n271AIQazX+TiZeV6DGPWuwd8dn97DSBGmBtuLTmmYAbPlCH0mMfZTPxdoc0ZhALS0
 joauekgqlBDR9sVFe0wPj6QRBzrKYR9zAmD95wgUsLz+vM+jTw339lLufJ4YD1lu0Oo9
 75OOiqTnLPAiSk7ReGjIwCNhyr/D8XsHrR5F69QAZesDptl+x1bH4CRmJkQbg4vBkUN6
 NDwj/LUoQiG7N82wTjVWRYDA6J0ORw6yGR6v9TSPvuOoj0FpSh+tp89nmvKj42WCLHxs
 zhZz1pZgPfknSyRKOJbXx7R1eP42ydwHhajHSeA+2KpxNPuvVzJj2OWelnD+SHxJM1KO
 BLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793189597; x=1793794397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4zr1EdvKH16vLOy4lBQyUT15AfH4kfVFziCfj4/qIBQ=;
 b=en6flfOVfZwdaQpLrMTdb8pgHszmjWTy503t1j56YUREVMx1N4BfBXb9pntWKzYLD4
 DIy3Ok3wqvOEa6WM+729g/cisePb/aVtsQd/T5gUsk67ekW4JjnDnmFZS3z0vrJc9TEQ
 gHmqiJzg7sq9iQFl8++lS+SMx5V+ZrxxC/M1n5PJuZ6dHEfF+pXDilXEE/ywPw619mEI
 VYoT2dxtWu5Td88O1vG8AtfoW/jRzRCEBy+dBFVlNiy/PLbcg7zqMlqmiGgNd1pMEsuu
 AMtC4VVeZIR/75L9LfS2Mu0MoS4xyWtPbZ1TvkqtGkph/t2M7xqeEOpXb38tUh1Yk3ns
 +Pqg==
X-Gm-Message-State: AFq9FYINtw7RhAwNqCgbpivIbbSGa0kHvKNycp+1G5TG3aUSXlR6Fq1G
 z9iDcSw8rGJi1EHdGau0Kh31aD/k+f8BW0OUjpUn99k8PGM6mEDThFVGOLM5nwzD
X-Gm-Gg: AYBFou0YhrHuPsZXdPFYHx8xxti5IWv8n8EvJaEyOu2EU0YiSq3NORikqVeiIjlK6VL
 fJ4xKDlnP1daVhUyWdVBGISI9MXVg/kOCxC9eheaz0hlXU+MsyaLuw/GNZ5g+x4KdI+JQuJ9PWI
 5ADr2y5ObV9esVNs6EAcbjG2N4T6e1RLTn+wojLHNQIHV7t85Iu8rJtf2s946Ij54UdJuPG+RxS
 VMhzcKTPf5nvNM7SvZYgok60PESbjvHQWeVr4ukehZk3jF1W+I/zJWP5PS0ycJSI9Pn8cv5cOmd
 CT2TijEdoPbGjQ5olYB111C5ocR4GpWa08X/xSZBF2Sns1+IyDEFYxJEMczyfmX4kIIUxmPdIj+
 Xrxl4gY7522zV11kClk1LT9VJCGBZjNjwP2c3EqDRNBBSPa99OXgVbTvzGg0MO/WrD1P4YNyPcO
 W1fgOSLh80wJ1gRMSHSFJGKAHKcPlb8EO7EXB0NEJP/3FKeERxnbbjtAccEo+R0lkUek+pt/vP8
 +A9J4GOZB0oJYrd8lcjDHhvd3K3cUBLIPgw2a9n55e37O0v3D8yTgFNp1ogWbAtItuLqX2J27iy
 0Mja/PfbTfqmhQnfxBpnjru4g+QC52I6U1zWz2oLKale6UDpT/Bd0OqjkEe/eRKGpjYQFrwAfTq
 pgVy+b5AGtLJrv1jDTMJDTZRIxAGszxRKj0mPVJwcRHuanTgiJtFl0SLIffwxqoZRYH4hLyVTxH
 Z1kWgKkzqH1Wv8abzlzz0eBHMnMI2J19mQP/AVVIgS4MHZ9DJpRh5/
X-Received: by 2002:a05:600c:1991:b0:4a2:c2b:a91b with SMTP id
 5b1f17b1804b1-4a965dd3290mr46968005e9.10.1793189597082; 
 Wed, 28 Oct 2026 05:13:17 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-301f-0e2e-7b95-b045.ipv6.o2.cz.
 [2a00:1028:8388:a84e:301f:e2e:7b95:b045])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97a093e86sm41139085e9.1.2026.10.28.05.13.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 05:13:16 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anshul Dalal <anshuld@ti.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Sam Day <me@samcday.com>
Subject: [PATCH v2 1/5] arm: cache-cp15: Do not reference the MMU helper
 without an MMU
Date: Wed, 28 Oct 2026 13:13:09 +0100
Message-ID: <20261028121313.814-2-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028121313.814-1-pepe.schlehofer@gmail.com>
References: <20261028121313.814-1-pepe.schlehofer@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit ee0fbf4ef766 ("arch: cache: cp15: Add
mmu_set_region_dcache_behaviour() when SYS_DCACHE_OFF is enable"),
mmu_set_region_dcache_behaviour() sits outside the CONFIG_SYS_ARM_MMU
block and calls mmu_set_region_dcache_behaviour_phys(), which only
exists inside it. On cores with an MPU, such as the Cortex-R5 of the K3
SoCs, the call is a dangling reference. It only links because
-ffunction-sections puts the unused function in a section of its own,
which --gc-sections drops. cache-cp15.o is built without LTO, so LTO
cannot drop it instead.

Without -ffunction-sections, as the LTO conditions in arch/arm/config.mk
intend, the K3 R5 builds fail to link:

  arch/arm/lib/cache-cp15.c:331: undefined reference to
  `mmu_set_region_dcache_behaviour_phys'

Define the function for the D-cache on only when CONFIG_SYS_ARM_MMU is
set, as before that commit. A caller on an MPU core then still fails to
link. An IS_ENABLED() check would instead make the function silently
ignore a request for an uncached region there.

Fixes: ee0fbf4ef766 ("arch: cache: cp15: Add mmu_set_region_dcache_behaviour() when SYS_DCACHE_OFF is enable")
Reported-by: Tom Rini <trini@konsulko.com>
Closes: https://lore.kernel.org/u-boot/20261020212819.GK720525@bill-the-cat/
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
 arch/arm/lib/cache-cp15.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/lib/cache-cp15.c b/arch/arm/lib/cache-cp15.c
index 28bb6fd36c8..e0922320217 100644
--- a/arch/arm/lib/cache-cp15.c
+++ b/arch/arm/lib/cache-cp15.c
@@ -325,9 +325,11 @@ int dcache_status(void)
 	return (get_cr() & CR_C) != 0;
 }
 
+#ifdef CONFIG_SYS_ARM_MMU
 void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
 				     enum dcache_option option)
 {
 	mmu_set_region_dcache_behaviour_phys(start, start, size, option);
 }
+#endif /* CONFIG_SYS_ARM_MMU */
 #endif
-- 
2.54.0 (Apple Git-157)

