Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317A606A329
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JBL5nDlH;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=m+BGp3db
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71FD440669;
	Wed,  4 Nov 2026 10:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YsmaYnubI4c2; Wed,  4 Nov 2026 10:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76C114077C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793789972;
	b=HZiNPBGcxyfh2laULhDelcyfmTIjz5OHwItYUZ9Ir3eCJ4iEYb53qm/l1ZD3X1COY/Lg
	 2ggXIid9a99Rjusha01J0uTwMWxHLhHpeGc9BN+GHHBRF+uvkegv1zmVm6lnxvk1kkGlI
	 t+8jV38Ou4gErMb+XqI3lNz4NPzm1UKvd2iAvIg1Q087X69CyOF4x7W3yFGgE9kW3QGbG
	 3cHxkKtQ9FoquVcueYovX+f+IzeHBwyGRk8yVNXZq8c9hwno9hvEKFGNIKV/0afMekeT/
	 Kdu16yRkAL4lV6utusDtgDCDln+VfWySgQsG0/zDWAFKdHqpsIHVyqBhnN6VFHmRUVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793789972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L6YtsmIPE+gWELar1r1bFYm9NcycQwvjZcQ+xugB7aI=;
	b=WJQ2jNLNItaclOEj89uEsIEWI+dwhCRFIUX/ScqLiPFdZxRnkpaftilwuAO7YH8eDUfn
	 u21RLIzgar7ZZdrcrT+TD1hUfnZhK6TNMoEx6H4SF+tl5VsIObG3FZCpUI9E8h7uD1Gmc
	 sof2Dkpu+bYDhbUgIFqbMbwooU/8WTBVHVDDBDqgK9d/824IOQg5rVcAKCs9CRVOSjzQL
	 zsXktdI7llcVUwuvXtnImHBOcLDXVyRp8oi1sw40x3KG32gyGjGyKIuuPHsgFNrIP2LBQ
	 oe3lJHNVdxb4TXVVRc3B26h/xDfJOOS3y01wmAjiz4kQd+PjjG/YFzcds8QMeg/DrHQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=m+BGp3db;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793789972;
	bh=L6YtsmIPE+gWELar1r1bFYm9NcycQwvjZcQ+xugB7aI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JBL5nDlHC/I4bLs2Atx968nsoQ8ImEtMWRZ7tL6+a4QTfvWT9Gl7dQYRdzQRWkQWo
	 nm69S1BmsJW4IVRKIIv56MwZ0XQjaNiFXnnK/uPCM+HQtu8bvoQRKxXmsMCYpKMwfr
	 i/ymDO3vOqtypKT/d/CieR4X2wq12tNjHb7o6YNKw5qQUbzduEQwJcOgPzgB+1K/vZ
	 w20yjlXuJ4i6Iajt8+YeD+OZf+CUaAMsYSZo5BfH6AkUSm7uoGedIsPPNtJT1j3Sf9
	 ubnL3TTSpygpUKhmCGWj0B8SjWV4LBIoq7bdnFLKkNRwjV3tX+PblUurk8/62nEAew
	 obIt4jOaaJWtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76C114077C;
	Wed,  4 Nov 2026 10:59:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CEAE92B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B416A4046C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MHeO6k71R0AN for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:59:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 95E904043F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793789964;
 b=ghO64xIusr4HGAQiFSvxNrC3r5WoFxQrRzg0Nv+2BSWTRY6P/g4v7L/LmuO7nf4A4iR3
 M29+T1Eff4jrwxETyokxLIaTKAZHVafN4k8nX4ob6OHASi516ojXRv0MyKm6/0SLjhIMr
 TEh5ZnvNLGEmY4zPUUQZelcD4Wcxh2goBKqcnE/3imeta8nnSQWRK3WRwb5dhJhE2TI9S
 mWB3KNGpf9fViKs7DyV40q405XTyfaRyDdrzbMp+gzzEX8OVu/dk7zjHWfpYFiVNuPyCn
 5odjUr/CYJyOAVV55QOP2y4z+fXq4riZpU0Q6iAG239preweOMB5w83EKFNc8OuFYWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793789964;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=L6YtsmIPE+gWELar1r1bFYm9NcycQwvjZcQ+xugB7aI=;
 b=Uypxi2A+ecYst9EnPScsGg/GxiFTyRY0yYqhJsYnK+nuZpq5Fvt650HCWmrIbN6Sz3Sm
 mHGBCMe7UKLfBe4GcuFSpf/Ban+0SbL8/nKVO1RvsCIRJZBS0aWbcL2DNHvFdES4nc99+
 mHrpQnAj93h8R9ibBOhcV4U0/0jkqtnYBEKV6AKUMdIgSXvwm8ztWoOju7e4e/zZ/qbCy
 Ps3fZ2urWtV3mo0F62U9/90edt+mCBw5AMNibYIAnaLS+TyyhDKKJYLHIFtpvA0UiSNp9
 aJASQpweWQTe4IDgnktGYYEDjPVY3uIU1aZLrRXDwOmwPwbTSRzl2nlqO1XgemGhq3w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=m+BGp3db; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=m+BGp3db
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 95E904043F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:23 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so6190795e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 02:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793789961; x=1794394761;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L6YtsmIPE+gWELar1r1bFYm9NcycQwvjZcQ+xugB7aI=;
 b=m+BGp3dbXS4W2NMhIAlgUp94qrk2PaEnwlK3SaKRDyDkOCtKN0AT9Lktis4CPfJ0pS
 KbGvf8b+bUVOjsiY2NdcVa9XHbZg2wD9zunY1SahFxM2GpWx9HJfncl69I3ilUyXfa99
 by3PCM9/YTEu2eU/E0V7O3QcJt+uhFSgVMLvpE3bVgbEQUF4NnPcjAfi/VT7jDHKchB9
 RId6Tov3Y02XrDHOOCCfs2mUscaGT7UJtOG6I15TQ9+Icx7HQKOVD5CxwIIwiXywgRY3
 huouUjobIxYvLQBgbOXblonGM7CUGY3DlJ8/45YIzWw8OajUdStJYFii4b/4SL0+HhSP
 YFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793789961; x=1794394761;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L6YtsmIPE+gWELar1r1bFYm9NcycQwvjZcQ+xugB7aI=;
 b=B1H3/dCSsO4Xn9Ha7TP8yGJXrqFvP30cQKTF3r9AyJFTpmU4X9araqvOBdPiKueOPr
 aHhSt6TzLu+2kZN94BOby0v13n/v7y/4DSaPWCiPeC6TeADzAgaPWbQsg25ygmKVxDAA
 Ad7I7KuoeDUAaORBwGie/Ca26I33s/NmF0LJIECr3Gv5Mp9yABN+yLggeQp+ULezHNWk
 mEacM6FkqlN3siaZhwoWfvZPb5WT+7lxGOldc3UWR2GR+Lz2bemomt6gysol8H2LruDc
 6jObJ0R2Jz0r5YE+zhXQu5oY0SGDsAXPapOfjiqrPwVZDkReac+MELYSGgiNvBrVLo9M
 Pfjw==
X-Gm-Message-State: APuU4Z+zQyHWzIWiQbt5S2HSEsJlW7M6I3QkcLScxOdrtNXmFEebLR7B
 fnkG0NV52aAiV8GSxC0EtjG7QW6RWSBLbghNUOiuDhTUxn4QmiGiEMn5fPMZ7xFgLUE=
X-Gm-Gg: AYBFou0TDZPsLyoGTO7tIzr1m1ow3IXOtBlV0rSiMk0kCtxJ6ueKZ5Xb5kBM7wOI0rR
 uHLAqJOYolaBg2aaH0p/2OSYyF9vSKIsBEkgpSCWUzEGglVRNeEfQZW9stW1emV+ftYaRFtBZWd
 ZhwXMtax9rWLXBua5/r8eMaDmjHUHZ5ce0djfZh21ccPz3iJlXSzK9HSbAXRwmKxAK/+Tq/eOu5
 8RFkNTiJRDpViOnj0iv5SRDDcwilUYWg5F5SCyy+RJdCZZVpYkrmY5OlY52Z2ZHE1V+8JVnfYPp
 5oNQznIphRMYLdCKCB8HTQwNIwCd+cQqrmaem2pZa+UP9SSxlyRXMSjah1FvrcVyBej+3RdUpf6
 K6NStc4ZgUaK0/2Yld1xaeY3ZQk/GB4/D1wHPbVTzRwie7rmGcx32bg1jQAwJcHdjDD7a5Tkt3k
 IBvW6GmgmFhY/uWVTshicaV9yUT9OrrbHHwOn+Ue7GcqyMW+fi2KUViG+U+2yCMoX977T7oKH95
 6erocPiG32DVBa4efXRrnH+9iXppB4znhECRS+YLcG+THpCwkx6P/but8RwQA+aIqBvRXZRF44r
 9FZWKKljPSrt9QcEpA0nIRDWgdvTld6/Kg==
X-Received: by 2002:a05:600c:1c0f:b0:4a2:150f:1601 with SMTP id
 5b1f17b1804b1-4ac1709a7bdmr369612545e9.12.1793789961490; 
 Wed, 04 Nov 2026 02:59:21 -0800 (PST)
Received: from hermes.fritz.box ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20567sm3503492f8f.51.2026.11.04.02.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:59:21 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 04 Nov 2026 11:58:22 +0100
Subject: [PATCH v4 4/7] arm: mach-k3: am625: Wait for TIFS initialization
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-4-e211cba9f3ea@baylibre.com>
References: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
In-Reply-To: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Jacob Parker <jparker@basepowercompany.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2637; i=msp@baylibre.com;
 h=from:subject:message-id; bh=iEHxOrUkc7tloY6uwzR21m6RzTCnTR/7QF0QDllvKPc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqzX/B/jNcTSspdbxU8Qz7PqOnh8+7foswfz7/7btGDn7
 Xl/U92udExkYRDjYrAUU2TpTAxN+y+/81jyomWbYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDx4iBi1MAptpzJiPDvYAZq5avf3px7oeu8076H4+8/FLRWMrVs1eI+XzgvM0ezxh+s094HJ/
 FpbpUXCt+365VJy6YHivarTN93Y7QSWxuk0waGQE=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
the firewall on the registers at the end of initialization. On HS-SE the
U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
leading to a race condition. This leads to a broken watchdog since the
signal configuration doesn't succeed because the write doesn't take
effect.

Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
ctrl_mmr_unlock(). As spl_early_init() may already probe some drivers, I
am attaching to the EVT_DM_POST_INIT_F event to wait for TIFS and call
ctrl_mmr_unlock() before anything got probed.

Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/Kconfig            |  1 +
 arch/arm/mach-k3/am62x/am625_init.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683f..b1f290c1d765 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -6,6 +6,7 @@ choice
 
 config SOC_K3_AM625
 	bool "TI's K3 based AM625 SoC Family Support"
+	select SPL_DM_EVENT if SPL
 
 config SOC_K3_AM62A7
 	bool "TI's K3 based AM62A7 SoC Family Support"
diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index decb50bf853d..c7e976fe5ca9 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -12,6 +12,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
+#include <event.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -100,6 +101,20 @@ static void ctrl_mmr_unlock(void)
 	mmr_unlock(PADCFG_MMR1_BASE, 1);
 }
 
+/*
+ * Called by spl_early_init() after all devices are bound, but before any of
+ * them are probed. TIFS has to finish its initialization before CTRL_MMR can
+ * be unlocked, and any device probe may already need the unlocked CTRL_MMR.
+ */
+static int k3_spl_dm_post_init_f(void)
+{
+	k3_sysfw_wait_ready();
+	ctrl_mmr_unlock();
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, k3_spl_dm_post_init_f);
+
 static __maybe_unused void enable_mcu_esm_reset(void)
 {
 	/* Set CTRLMMR_MCU_RST_CTRL:MCU_ESM_ERROR_RST_EN_Z  to '0' (low active) */
@@ -158,8 +173,6 @@ void board_init_f(ulong dummy)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	spl_early_init();
 

-- 
2.56.0

