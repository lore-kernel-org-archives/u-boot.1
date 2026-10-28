Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0414606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xvbK43Xq;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fD/FIvb4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A5A18100F;
	Wed, 28 Oct 2026 12:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OulwVqxQbVUJ; Wed, 28 Oct 2026 12:13:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C77CB80FF7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793189610;
	b=eOEMsXEOvCEoxfwEUfeZ11XrC3A0NO2UAAjGtKXUDURAoAWkSlSZ1IcC2z9ANAJzzYWf
	 OthdgTKsB/11nELEoR1YN7qmiWjfsKyumxhLLaBS04+DpJWFn0vCmefYPhRbqPaB9hRaq
	 ZRKL6wFAnQMkVqvaqZSApnQ0KV9fHovaF7IB0HOC/V5M9rYa8DliOSvkVRP94TTslBZPj
	 y3ZfnGKC696eEjiXBCeRIoSYFsXRpiRDOzJHabtSvsSL/NUSzrQm0MX8MguQ+U2GWVdbb
	 XQUIlKZD5FXEVCMYHsvW2/U38gWntSPFX/dsNExF09k7ClTbRSo92ZSgBmsIAMUgz0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793189610;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ugtdkk339eiV6YRiC5SeeBrpN/McxW+kIAEXY3+e52k=;
	b=hH0vLqKs/AzJ4HKOZpahKOkhw1muXBLdbEwAZIPPtPbfGc2C+jmoX5KASKI2rWWN0VZ1
	 LXdjWX8W8GexkyY4Te9QBj2g8dqher59TWzLgTSEE5cYKGyZV0DgkYGNgGK/10E7as2+z
	 0vrNHljA0Lwj1o7MHD1d3IMR/9FryDDvuY9BYYZQXwl+yT4P9HFOtED2ZEPIV7ZBNHPr4
	 84bgQhngO5SC1w3plF7uOl1V6doJ7tGxAU27ZxGBsXvPfVGWG6r0MpRFBFCCA5B7ynO7S
	 JZ6uACL/0w+2//RJaUjhvJ4jfMi195qNmdu6i1YNyOywOOQq9dF+szXVZFmtxDumsug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793189609;
	bh=Ugtdkk339eiV6YRiC5SeeBrpN/McxW+kIAEXY3+e52k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xvbK43XqYUrnJ50UCBgt1fbmTPfyWAh7ZDJI2IkI9X1aFCT12aXjXvgsafMQrwqNP
	 7gh0MOVBGIteoDGcsWdYScxCNNykMj8OSSfUzZJhtdw9l5DgtHYMgVaiiv/XTuBdi3
	 tRYrvJ43b18t0eDTSFWid5zU+sel4LZy4KoeqBxfAE0v3yQMBY8b39bNkDqEi8dosA
	 k6N27Dn4swZLN7O4GUPGeM2ITKb/BSA4Ua5zo/HqdY8oyL5fz8l3Bvlh6Q1ZsgZ1lg
	 P50O9CzJpZBRYaAYXiW0Ahc7Qoqa1hH2szUGv5/2mBQOW9D7qpJOAAIdkMy0ZBNwhe
	 PoTff0WiQbX6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C77CB80FF7;
	Wed, 28 Oct 2026 12:13:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3ED6C356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24A0860773
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 61-0QOzwGuG9 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 12:13:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2BC3B60770
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793189601;
 b=orcAxCSWRVXaJDuXV4cSGH/8MFS93sFHy2g7XpU6cYKFNp2KIC9HQZeWM8aF7W9qetB9
 rnwaa8U1IsPHLj4StsK4YHrE3/jukPXkoOKKXsI1YVwoe/h0cvgbgKRJikpC2hnzVl3EF
 Wx2RCg5UcRkoapSpMQHQUSdYZYC+Kr29lvmnRCUCQytZ1dEei/yyY/V6mJddBA5JKVsFB
 mM5KMOr4Dw9KeAlyRl19AHZjc4y4L9QmwK4hmTiF8NbOfp90HoOH2Nmg5uNfx8rZPj33M
 b8I5bMuGiwhtpvxBcaQaRctNtbeIH96OPpM2FpraSikwhaAYkQx/lSqF0z/qvujlLJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793189601;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=Ugtdkk339eiV6YRiC5SeeBrpN/McxW+kIAEXY3+e52k=;
 b=OtApQshAYCBzzNhhHAg/TewlDHzO88u2+oIT0hEjZM2ovPb489kN0ljnf0aVnj+7kG25
 Ey7oj8EeC3rOdrO24Iw5p+5XgRmIdim/SIYD3d5cyO/2XEYcC34upakIxJwaJt5uKxQ6S
 FzAm+GchCfrlKsmpOJV+22ytUZeiRY1ShtykYJKt1G9G3B3mpFaght3NLC6gUr7X8r+SY
 O8SW6/54L+6zd6dChMqZM1nF5wGnxFR7PYmYG4kcZlJIcpi8Mdfe056GNm3qkWDhL8Cy8
 GaaH4LY6eFSJCUU9fLpYm32bsjKp4pyqUTRxsAFEjMoUjphK3WQevtoIAs0hZG9iORg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="fD/FIvb4"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=fD/FIvb4
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2BC3B60770
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 12:13:20 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48dfb76b304so133417f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793189599; x=1793794399;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ugtdkk339eiV6YRiC5SeeBrpN/McxW+kIAEXY3+e52k=;
 b=fD/FIvb4U8rc8XhACBAVxcMIvj2mZDmePsRWQ29vbDQpsVGqQmGEe+toZUovxFO3E9
 BdGtAsDuxV+uuyTXjRUV5Qb3Et6xPPeaflJO0JNovU4PwLH55gkhrx8pVTFnNbChjs9n
 iUrSLeNF40/iXRQ0Z2zL+yHM/1oDpDyxyB+JpGcXuI791jc06q0C7W2eM2+32REf2jEU
 Dz8ahJURh1U/NiKUdylPsHV5j149CMYEMDtLwquRCGvaIjUsQZ6MWwx3a2kl9ixmnz0l
 WeE6qoe2O4b30dDVFzSaxneXBgJZtvF8VSVorcyxt/66L0IlqO+cjpglbgip57z4Yq26
 gKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793189599; x=1793794399;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ugtdkk339eiV6YRiC5SeeBrpN/McxW+kIAEXY3+e52k=;
 b=rXpiIUzC4UjFOmPNoROmwAbvsaj1TPpT+lIbLbm9FLTCACtFnaVpfGhyg1/MmsbMKF
 UxWooImxr1aWayktJMZG8vk5zp5GGWlKYDKwaxaRgCPnB53+ZTYtbuSKe9NMNU+Iv8vp
 yFjHru2yp/6CKyJgCgu3oYk0ize3TuWs8gFS8Q9QR7gRACuIH91YZM1m+6C+FWP3eIIC
 Hf2v06N7rGOyLJARtSP/NqF/IxmqkbkNxpGj7xV7h4LbYl4PcMOi1Htlm57vGEAq+LDP
 oEfLatQKLp6HL/DVRpA+NTf5JRI85ryBTsjJp+iKMHIPcjyPUjn6DsyapAasYdLge20b
 NZqA==
X-Gm-Message-State: AFq9FYLfbw9VEGwtyI0c2Puj+r5YLjcz2blQPAyCK965tiFsZV4+sgB/
 Az3MxOVjyv5O51tE3BVD915hTyfEHNzDtC6KGQUAJ0GSNgtzd/XmIHRS9uzNmgs1
X-Gm-Gg: AYBFou34JiVgZ3m/Do3fVMPGpzRySIRCVtrnryRZxXUc+uub+Ym6X9PoMitWM3A0cP8
 WFfiKDIGd8D5xco56d9t3xibnA30x4f6JO+5WldcjesjA9lS8ct84mXbQPVIk5H2KT4Ix9WoDO4
 oQp13tBjdZkBT9yJO4wlUDZIPWJh1Zzi8f09bQ7Maie4cXvLadCripvigmVsknSgLPSboW/OB37
 83r3g4w2DtLMjK+1rQ9nmYBtOzPnUR1BSRoiEUNLXOHmfLzXGcieriBMrdvN4+5gl7zgC7NAi/Q
 JjgkcNj1SPGIKSLBmFe2Ad6WZyoKF+zY0kgGOva7dfnhZD5mL6wcvilr+dI1CoG5XgLsX9l4oia
 EY9p2BQINoTXc4QXhImMlWl98p2FBE2rfthkZPgn8EDl6V0S5jRSWy63OhmIgqpzgkkdji1jpX+
 +nRpxTNQcggOgpCTXTjW/sRwKcRuK+W7wGbiHVIgV6VV+Vpfz+DTGqqvJFItO9XpCvNDm1YYHcQ
 IvKPqcD+Y8rW+OyMOzQLdEJeCCFElAFIqpO8mQfYEtZYT9A81wQOyeN0fWCjeTziVtZhRoqpiO9
 0bCk/28SP2vd9imJ0l3cmfvziuHKq95caehnzsaCVQdO16xHofAiDOLVE1hwGv6ptU2jf0+Jrs2
 gtKY5Q8bG+9VtpBgFfxcr4LEHAqGQ5r6iGhr5ykqfkjulSTYH0WrpjMMSegHAhVreazc1yBxRGl
 FR1H9FD5bt+09hbUCeE2eKXG4dXlqJ3h6WnVWGcQr2YtEZNhSYHaVt
X-Received: by 2002:a05:600c:3b24:b0:4a1:e250:b191 with SMTP id
 5b1f17b1804b1-4a96677323fmr42479785e9.17.1793189598822; 
 Wed, 28 Oct 2026 05:13:18 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-301f-0e2e-7b95-b045.ipv6.o2.cz.
 [2a00:1028:8388:a84e:301f:e2e:7b95:b045])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97a093e86sm41139085e9.1.2026.10.28.05.13.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 05:13:18 -0700 (PDT)
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
Subject: [PATCH v2 3/5] arm: Keep the section flags with LTO and
 SKIP_RELOCATE_CODE
Date: Wed, 28 Oct 2026 13:13:11 +0100
Message-ID: <20261028121313.814-4-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028121313.814-1-pepe.schlehofer@gmail.com>
References: <20261028121313.814-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

With SKIP_RELOCATE_CODE, relocate.S relocates a literal only when its
value lies between __data_start and __data_end. Without -fdata-sections,
GCC can reach .data objects through a section anchor that lies past the
end of their block. If that block is the last one in .data, the anchor
lies above __data_end, so a literal that holds it keeps its link
address, and stores through it go to the read-only alias of the data.
The .data of r8a78000_ironhide_cm33, the only board with
SKIP_RELOCATE_CODE, does not trigger this today.

Keep -ffunction-sections -fdata-sections with LTO when
SKIP_RELOCATE_CODE is set. This changes no image on main.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Marek Behún <kabel@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/config.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index e9606e7c78a..7e99e61ca82 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -17,7 +17,7 @@ ifneq ($(LTO_ENABLE)$(CONFIG_USE_PRIVATE_LIBGCC),yy)
 LDFLAGS_FINAL += --gc-sections
 endif
 
-ifneq ($(LTO_ENABLE).$(CONFIG_ARM64),y.)
+ifneq ($(LTO_ENABLE).$(CONFIG_ARM64)$(CONFIG_SKIP_RELOCATE_CODE),y.)
 PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
 endif
 
-- 
2.54.0 (Apple Git-157)

