Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D693E606A329
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qmb9JC/x;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=F663nYpY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD0366089E;
	Wed,  4 Nov 2026 10:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LB7xN9aZqEa0; Wed,  4 Nov 2026 10:59:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 883626089D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793789976;
	b=pwcvWhRwmmeT2CMn+0HBwaOoQ0jKVREG8PtgLkXbGeLEQIK6imOjJRHhQEoc/PD5+HXR
	 sSglbEz0P+QCy3G3LtesFM7hLwrw1MMCOKWkDxRKtCWg9RfrMBWy0UjWe2k3Vy8IU1UFS
	 kCjMgFzqOwa8GSr0X2kma3pxvvy+DkilVOzC8r88VkmlOsA/NjWQEZ1fJdqhAdWvrqpvy
	 y0pc1YpXuXOuS1bDdTB2lP1uUW03fmdT+9DO0JBTOBwiMb21iwsqwIbfCuC2s1YD5y9O5
	 P6P0r8r56pp64Rgo8mPlEsNDk+6dF3eeOM60YQN2bh1IAaO4SX4O/0LITPg7h0Iw7Zg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793789976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/1jPmnDMXscBv6ypWcZwkeRcDyw4kTeAUyQ9eH4R+ZA=;
	b=HBqfYyNqO9/S5fNYyi/RtRGoMKf0/s9wEZEtlP19XPGobJxptVGv4kWd0InteXbvpwgW
	 8xyZxb5fQcowv2a1fFG9+wKka7vlQ/8LTqYxVtRrQKAPzTX4UzlQfWpmrGBRj9Dos0ql0
	 Ftd2vmJ30VuApYGlaK5dr5JG/1AZ6l13db3EarbK36OgHnkjsrfXUtLz4HWQk0qvb/KKo
	 8M/+ZsAc9t8StwaFWcj1Uuv3Kpz6GBAUOpQGHKPBVsFPbRCKnabqY+HYVsx4C3DTa3cyS
	 fq5DEqd2g3w2jmgqxIj6uOF4mtH/U1TdNaAesaFobC7fir3dlVY6CBml9eqdS6bu6RA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793789976;
	bh=/1jPmnDMXscBv6ypWcZwkeRcDyw4kTeAUyQ9eH4R+ZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qmb9JC/xFSl609hhlNYPmZcfNTdsj2OWg5OlwBprdvS50jD9jkOItVOH09g/6/INh
	 +9dFURTr1/hf6o5UemOWmY3dVg3i3k6ztXaPYDnznF5V6eI/iDLQepXbrH/IlVbcCT
	 paTiO+IKz6NsRz5vUXAaqodzYDZVtgNiF6YHFE6KC5c6GBChecSBQXEv9EmCusi/WH
	 HuSK6uqEL3Rp4MVdhxVYDnaGbmj1UmsGZSgzFJ0MH/sZys6NgUeh9YUdPLONyJk8la
	 fQhzG0f0292eqyqmhzCre7xJ/YoySf3YHSgj/nz0RsWg1Koz9TywACDePA8/UjSUhU
	 2oPMSfZ6dh2Rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 883626089D;
	Wed,  4 Nov 2026 10:59:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C8432B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1AB2A4074E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SKB8eUnyvkQe for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:59:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AABD34043F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793789966;
 b=RWlzpwrpMyvIeh9xc5cAGgH/5u20t6aocSNMxhEkt8gSv8JT94nD5HW5sikdYh/PRuuW
 Yn1K0fOhJEe+xD0SeSA5ILt5fLh1sRkXGk+RpdR+WHI/0Mm+YYg+rWtY50Y4uZo/92tn2
 +z9N9ZsGBuY6Jgm3DIZSW8TDhjrU28X8MJxjJUL66Dy+K9kBxG1/Bx1H6MtLBFUK4cuKp
 SbVTI+AAF7VypVPAqG2ipO0fYmp41bNF5QxsgHazI96imYrAK6fqmcMWCX4ZoRo46IjFf
 4lPl+7vU15ZTeEZ+zy/xg6fKrSP6Isb6Ba1rSKm6DxOk5xfSLTC+zbtg1DsNH60geoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793789966;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=/1jPmnDMXscBv6ypWcZwkeRcDyw4kTeAUyQ9eH4R+ZA=;
 b=taCHLufEb+8sQ3un6ozlEeyR7hZS6bzIsM7/vcAMA4q4OA8zcUDlfuPbLu+3kpBOT217
 CqRz3kmOUqDk3++R2cIYYVX1YJS9UAtGSRSj/EVb9kuZYZYU3SzELb0sXU68dwyCbW072
 iFA4A2EpWeY0YrLfR2Ds76M1At/q2wkEeuVS8bIk8MRnch6E3qz9acXzznqiNbLZnUbGQ
 mYNzoiEg+ext7ZL4MrQGJlkXeVghSWXIB5Ena/jJwrw5QKEqY7J4YNJBrfKjI7lLOK0hr
 QkP66SeYQaEH0Iu9dc+w1/AmCoc11Gr5UbdIPMiLOiJGHFM40NFXeEaV8Pil70MQqrw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=F663nYpY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=F663nYpY
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AABD34043F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:59:25 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so3171775e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 02:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793789963; x=1794394763;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/1jPmnDMXscBv6ypWcZwkeRcDyw4kTeAUyQ9eH4R+ZA=;
 b=F663nYpYnb2WP5Zri+EztXaADATgb1p7nkoENAoFAFy2av4x+LQsffLBF+YfvJQsam
 wWIQkTCWhbal890FITolqMXuw6HUaW/pYWg2TfObdmM74fmAjSXFWUJx+snqIdIoUaq6
 T7qt7HeaCAASoy+qx5FjkITjd5HWymu0c8KuC5DhJMLg3vs4K/m6/ns7H/JLJGCwSn6O
 sdk7g07rGARh3dcHlisRXSMnBvR1ACMosjmzYBMr/oBLGZ9wBrmBjlx0MmG72PFW/bHH
 cwR5zZbKoYtuG2V3FKZONJplTM5PgmTlXQBlPKMpB+0kRHDfpAK9pnM6985NHu7p/Y16
 llnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793789963; x=1794394763;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/1jPmnDMXscBv6ypWcZwkeRcDyw4kTeAUyQ9eH4R+ZA=;
 b=SIrSAMhclFOG0fW3lmskzS+4pho62oZB4+DPT2U+MCL9rxQxIA/bKhC6BvEv3+UCDB
 mlhC9cFNtf7H9kM2w9sFwbWj+45xKruvmQVrSchU1dE0jRvug6yx/j7ntl9RirlF+wSt
 PjbMbbqi3VTjDQ6q+ACNyQQYOVj5pQhyy6etKgmwxUH+Gwip5VS82HcTIWxdunlnlyQ4
 Z5QkoCdSEjvwOsVpFMVjNFpCj4m7d2cKe1EbO30lGImNrZDUgCYQq916/MUUjgkRw/f2
 GUYXuZTZd+BQVpeOVU3tnBX2cR1fxoQ/XhhUKu5ylizWue8ag8Y0K7tMlsfP61iC27wx
 McxA==
X-Gm-Message-State: APuU4Z9r1ChJlSwLqb1HDMwh2QSz0DFtAfxtA46eg9UvgP3PkwMlPmNa
 OuGBCEQ35/58+aoDHmtpMENFXSr3FoMxCyu07gc4dN5kbtzz7c5bATc/d2rn2uviNkY=
X-Gm-Gg: AYBFou0oUCWtDsrzYzvcA/BA2bVCJlFLYJL/2FHXFsWN3mO1quzAuWxo072+mZWYGNj
 1Uj7Jo1sRqPQvy7C9Mum0TEN5SyLe+Cu6fKZItfrhP8OEYH8tgCrrALVudAd2lR1/hd4wkclUCR
 WEKcXEF4PCcdKruUlSEo2gwVYmtIsDWjZr5N9oB9llmOFFwuj1g0DGNfzkvYzTenZzL/JAqYKHc
 n+abjK+lC4f+peposdQnG1HZAZFLT4+Yt+xk/L0lSDRoF6a1vtxzNcYnN9tcSCqoWKo92HWLjJV
 PpIjlADuAWCxGewMJsi+9t+Z2EwVTh9MoqC4tiLgP8R0VUodUuP/DZbXj0UtMHlsADYdTVn4IFR
 5aYNM8RzdpUKLzh3avxK54yW38k+cjOIzxq5KERcckDRUaxykVtBaRfCGoBwSfdBytuUlQS99J9
 cT34g4xtFkaq36XPY+vPa7ci91jmOiiJp8BYtGRY8uAij9e5yRDFIJWfAdiKIeNK16/I21vH/kx
 2db56lPVbzFOQ2hrtbeSqljOVZz4Kmkdlweo/o1z2U1Nkp4+B2VlVNnheXvgtNGTQM8SgzYL1jp
 toPpM9Uw1eh9m3n5sfrKK/kCWneihvrb1A==
X-Received: by 2002:a05:600c:a00d:b0:4a5:e6fd:65e5 with SMTP id
 5b1f17b1804b1-4ac19705d57mr352073385e9.31.1793789963354; 
 Wed, 04 Nov 2026 02:59:23 -0800 (PST)
Received: from hermes.fritz.box ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20567sm3503492f8f.51.2026.11.04.02.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:59:23 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 04 Nov 2026 11:58:24 +0100
Subject: [PATCH v4 6/7] arm: mach-k3: am62p5: Wait for TIFS initialization
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-6-e211cba9f3ea@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2678; i=msp@baylibre.com;
 h=from:subject:message-id; bh=DFUd4bwuuQfTfSWzwLP2HDWtANZ0VPrKxYzwm+RPHh4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqzX/H8muMxXSJLcovkq5RxT8NwLvxqfL3+z9EuuWFHI1
 u2fo+NSOiayMIhxMViKKbJ0Joam/ZffeSx50bLNMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChY8TAxSkAUz1rJyPDfMFfxRHlG+wPrmp/e1X8jpikcI6mca757O7l3leWTpyfy/A/JdD9W6S
 fsNvNNcFG8/ubOF2Sxd1mnZi2JHxR3I+Mg3k8AA==
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
 arch/arm/mach-k3/Kconfig              |  1 +
 arch/arm/mach-k3/am62px/am62p5_init.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 405c5d4fad94..3c567f50b223 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -14,6 +14,7 @@ config SOC_K3_AM62A7
 
 config SOC_K3_AM62P5
 	bool "TI's K3 based AM62P5 SoC Family Support"
+	select SPL_DM_EVENT if SPL
 
 config SOC_K3_AM642
 	bool "TI's K3 based AM642 SoC Family Support"
diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 599ea7cf2dd8..014f494c8e6c 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
+#include <event.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -93,6 +94,20 @@ static void ctrl_mmr_unlock(void)
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
@@ -116,8 +131,6 @@ void board_init_f(ulong dummy)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	ret = spl_early_init();
 	if (ret)

-- 
2.56.0

