Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97994606A32D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a7Zvdxmx;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QtbwHk6X
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EBF180DC3;
	Mon, 26 Oct 2026 14:44:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jyhvy-eoMRpF; Mon, 26 Oct 2026 14:44:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 94E8180E87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793025891;
	b=T4APh0sIBoozaTC0Src/KlFqj8eQ4MqOy5qK/rIZ+NShAJ95Xjl9PK/SVs2UaWTEKa0i
	 SeLeBmNiZxBVckaKIvRIQud/c2YBjVMCREH3LIQUi8uQn9M38AVfBKhfdZMJR1OXVJzkc
	 1IJb9bmo6It/9NMBvhf0lGLx4hETjukQC1oFvJo8C3bQlsNmsIKE1vw+zvziffBsAFzQ+
	 lNHawLeUasEF6Zl2uZSc0fLN0VnTkxo53G4mjwVdkl10rCxkCDedh3FpK5Wp+cwb9qwMt
	 gDjBcFyJmjOwyLv4nGUO1XVlkWuIIyM5Eq8vigxenSrLf2KeCxiqSlMofFYoZS7O6vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793025891;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cNIHjtRklqMAU8nxFnKd4pp0wslbrbusW9OFMeOaDr8=;
	b=USwlTTWiLBjgtU4YNqRY7ZaCVZWQs8eaFICM2zrsEEeqAlxIg38v7aqN8kGGK7m9thwt
	 sruajVBsvboGUZN1DJtMrIpqNMnnD6DlAngPGtHFF9QsKXkBYENCzpwYHzCaBXcJYZ2Rp
	 t0GqHLP6ZrwloKTB5E5BUTOVexrKF27dRNhc87ZueD8P48RYJw01R5dgl/Hva7qIWwx2Y
	 +0DKqcJ5mT76bnHakrCgOf/c/ArpC800Dk8K5CgpcQLDINcxNA8tyr8lmMoLbwdMzEtwg
	 63dw/X8uoCNyKkJhwssaMrtzmOZAIYRM/o8S/a0OlwGeVqwk2bmkhI/97oYjqDI788w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793025890;
	bh=cNIHjtRklqMAU8nxFnKd4pp0wslbrbusW9OFMeOaDr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a7Zvdxmx1wwVKLg0rmnmBS6EtL0eHBxIjyF0XC1O22Ef5bLgZ7LVkJKXR3mEfanRS
	 T0nAhFZEkVS1yhAMHYGDCm4IkgHwBl+NaoAqsnbybNHwPnOgnw7zu9GfZkMBePDaxu
	 C+5AkXNsh+tuPf7HD8US3mc1k5lb3FO+LTa7bsydJBrSSatZKXhmDwZ7L6E6IecNGa
	 Jgw3qnjZHMDFbVieG3Q+zbpaDSFNLXeFiv0OeRa1sqR7qDhRWBeOiUjCNXzKuKoLiL
	 x6h63x3W46RJQOgMataSWa+K2zxFvokqfNLEKrWXSV/ebOVcXisQaNlHx7zsER5/3q
	 MnJ8SwRPFsSmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94E8180E87;
	Mon, 26 Oct 2026 14:44:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 85766D33
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76F5B40093
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:41:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KL22FsmW0mXg for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:41:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 88F1A400F6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793025671;
 b=eMkAXBVTaKMrqHCSUkOzh9dtepyN9Mx8ZZGrY2L/R4hsooGuMe5pWxB7fBmJctSW2FBu
 /+OIG9OM3q6jMtHn7tWNGq5HfgDZkYtQrgVZwcV+/5iFUVhQJ3NV2pn8+SOWCq4AIMry+
 zYl4ALv+ZuskhFhqqeoh4WUAVgHdb3v71PGVDtdSNuuRBTD1FwTHwoEKtIscqLcxBcYFQ
 NjLZVaZq/eQ+PxcNDptg8wCUbmNYivh/nh6qKUijTJxOpKK5cL12PH+LQVc57s4vODZ1j
 TnDMA1jWzZwRQsuoZPLFszHgRoCJfsLEQYNf3XPT+yj/qw0WQW79HPSfuYrUAS4TX5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793025671;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=cNIHjtRklqMAU8nxFnKd4pp0wslbrbusW9OFMeOaDr8=;
 b=J/IW5OFdNPih/t/VGj6bXxEBhQJDEwd6ye+fKhUjD6ruTYrJ/qoe7h2zlwBuDMUVtkDF
 mtF4zs/3Eycl9t5nHDBGwaf8ZZRb/5VLnBfqvpvk0wbgUFDaXJKM7XRN8Ow3AIeEk4glC
 ST9XkAMuIJRkV8AAC3GXQgZGLUr2B2gNNlWXPGkIdoK9CzhVA8wTMzkSa8OascrpeEYJk
 WAUXGKl2ijYWpSXF+XlaaqNk/4gUFdOSr5HXXm7KRzlJpGq3kv3VrOjAJhxQ8diUtFXEk
 RPKbi+9IzUVtHbsE+pisGH8xxKi1Hf1tqje+WWi6cJn0MroydMI/yMdB7lODDkRTxGw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QtbwHk6X; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QtbwHk6X
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88F1A400F6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:41:09 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so10485325e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793025668; x=1793630468;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cNIHjtRklqMAU8nxFnKd4pp0wslbrbusW9OFMeOaDr8=;
 b=QtbwHk6XvegrNHkl00UgsCGblGRbeT/lagzko3RSS9UEkK8/I64lfHtXnEpr8mGC4f
 xLibesG9VyDaTILtA7dZ1RdotlxsmR4r5ik1lu/MBu4pSwU1XZyv/6R3fgxS7VTNDyta
 AvMi3rQpYhpA//IMErMBPsNyKeTJYs6Y+K6mBELsiYGnrfmlDstjefYeJDxEsryRL9MP
 m+4ImmOu88TPb2N1wpvP/xRd0jK5GfGP23w/7uLPaGZ9bwaRmXv9hjsZX8srbVXAgSm0
 bXanqEN9yykKSIsooJW6C8ovft1lltsGr78UnhkCMECmfsEZ066mc7I+zhLunApE5/sf
 qzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793025668; x=1793630468;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cNIHjtRklqMAU8nxFnKd4pp0wslbrbusW9OFMeOaDr8=;
 b=gmF1mRxB160zkNs197r27TBCpk37PbKkljJ3YoWofVmWNCzOGLCKtS9XpxSrTJoBdg
 w60ZsGGJyPHcu31bQ3yVadKscSN+bm7BMVau30QTBlCr/0JeEpM9LzmuAMm5pqZY2aox
 RMWYbwenlqb0vfVp+x4jhLaecY2DpWOCwYu63lf3ujDk3VNRo7vqWwZDI2GYu+yWxyWL
 5b6xC8F+V040jAGeBVLcgyx31cqQ4ISdwOB1MiZ9zscWio4IQ7MnhvY8Hs9UIbRF6Lki
 mipaPWDCHKp7xTFN+HeYBXDMVPD9I7rDU0iBRKxm32iScAwF0mTz2RkWYHIP8sP2nVBm
 TR5Q==
X-Gm-Message-State: AFq9FYJJMZoSaW5mlyBKyvcTXHTLA0T8TvWIp4QBxl/gx9pXumuT8TwF
 80FANKqdKqmFk9iFJhOi47Bb0jajdLKSudnC5k42qnt1kPnR6IyRimGonesssoh8J9yE0usZBd+
 RfnIn
X-Gm-Gg: AYBFou2wMHtRJC8LwehNCqK6RF7cs7k85v0LbX7wh8Wc5soQ5b+KXUwGE6l29KrS2ky
 RhPsuwkY5uVhgH9pHlGGdhtnlaiUvrEzq18dei3hOe5uOAyxMCKNjErIzmBX6po5DjT1vPs4LWw
 Eb/ZGKDzkJCa5ffJGM1RZNy3EskmLRT/jxzYnZlzKZW/JlcBvI4ojEIS8RwaXGbQAOkxfEpG0Xo
 AXrSFSRBnpDMmr4t8HkA0JwmY4fg5+EOaXEbM1r8KDlCRfFHUAPi1L/3ripOT12BSD0hWkaC2Hb
 ER/77RF8nxWE8B9FAnIMOGWbqkXIwmEs1X+Vs40HPL1A4b/V7K3v5YFldeLSzBfkYO+H+/AlYNC
 ZZpg20hvD7FIowQXjpu+jNccnFYUmYbCg37twQeQwV+Zfv8XX1zGeSUzRlpwYiwjSCY5Rsp4q/F
 nnmizk75dmHKpemgd2N5p4L/YFEYtYL9rhhIQJHSV8tBotDsrl02QBzUM6PbRjrVi9ZyM0FfDn7
 uelezEHYrTKeWP1xTw1QFwyEhTpEE/TbMug/fQOFIEAB2WHWLiHICmx0JrtNKUti47URTvEzuqF
 zFQ8GojDu7IZOTGrGzo7xwJTsQ8b3ZN3iu/biFLAmXw=
X-Received: by 2002:a05:6000:4809:b0:488:7787:469d with SMTP id
 ffacd0b85a97d-48e3eb8ea2emr13155934f8f.25.1793025667944; 
 Mon, 26 Oct 2026 07:41:07 -0700 (PDT)
Received: from localhost (2a02-842a-9b20-0d01-a06b-e180-2ea9-f6eb.rev.sfr.net.
 [2a02:842a:9b20:d01:a06b:e180:2ea9:f6eb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdd5b3sm16737269f8f.53.2026.10.26.07.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:41:07 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Mon, 26 Oct 2026 15:41:03 +0100
Subject: [PATCH 2/3] configs: rcar-gen5: Enable env erase on the Ironhide
 RSIP-M
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261026-clegoffic-env-flash-erase-v1-2-18777abd1bde@baylibre.com>
References: <20261026-clegoffic-env-flash-erase-v1-0-18777abd1bde@baylibre.com>
In-Reply-To: <20261026-clegoffic-env-flash-erase-v1-0-18777abd1bde@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Aristo Chen <aristo.chen@canonical.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Mon, 26 Oct 2026 14:44:43 +0000
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

Enable CONFIG_CMD_ERASEENV so that env erase drops the environment saved
in HyperFlash, both redundant copies.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 configs/r8a78000_ironhide_cm33_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/r8a78000_ironhide_cm33_defconfig b/configs/r8a78000_ironhide_cm33_defconfig
index 3f09a7c25568..73e626f0e254 100644
--- a/configs/r8a78000_ironhide_cm33_defconfig
+++ b/configs/r8a78000_ironhide_cm33_defconfig
@@ -22,6 +22,7 @@ CONFIG_BOOTCOMMAND="run rsip_ipl_boot_ca0"
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_CFI_FLASH=y
 CONFIG_CFI_FLASH_USE_WEAK_ACCESSORS=y
+CONFIG_CMD_ERASEENV=y
 CONFIG_CMD_IMI=y
 CONFIG_CMD_PSTORE=y
 CONFIG_CMD_PSTORE_MEM_ADDR=0x80000000

-- 
2.56.0

