Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5603606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D1hO+iG8;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FuOLtxVm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C135081377;
	Wed, 11 Nov 2026 10:22:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D2-A6p_KxXat; Wed, 11 Nov 2026 10:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1AC00813F5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392521;
	b=fZsMBxT+RvyGPJ1I8ciVPfGL9iHNUJnyKxilaMRbWwUHgRcZhkNeGUjBmNLYNDQr1OCH
	 Im6iw5IADLG3qhF/RlLJOohRXuI4U/RgKHbutRNDfTzjcOeeSSJBzD2UbPJq+B8ifWdsv
	 zi88o8rsRvgvgBQBZzK/kceu5DWTR+DOmpEPkUbVSnaIvpxY3Tkbj3NkSGx2SK1b/2yw4
	 4vw/covm23y7JYQqm82ZvkwEP0YuiLK4lF7ncEneK/QNW8X4HJExsM/TMYMXAWo7fnD0u
	 CCKjYG0zWX08aLygjMOJV+24iP0qQ8xAV4aJqJ3zKFFcdtmFkiBr1qK8uMJK+MM4ZBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392521;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=brd1oaO9ncOUChAQKoaK8Asi5TCBoXsc8Mx1nWwyOIY=;
	b=LhtHX7rLI8nY28Y3xuGzahQv2X7jPQM+40HQ/QSl+2ZhjKPgPgoQymhSfJ6AB0P9AzqM
	 z3R25gHPgAhmykui65zCdICkk2Va3NbNr15jgcYadgtq4TId4NReyyiYLZbW4vUPwGnYX
	 pyWAQJRCShqvWfh1TlXwvr6/wehjr3m0kq/vXIdkbRXAZW+iqibZwC6WjYI5P6EShH+us
	 wkYt1fpGGV1XsVMt3Xq8rpvVwJEN0TAdt2efuvivls4ab06vrPohUDjExl0uu03jaq37V
	 tv2NH3PCjCVC88qENBY7RbfZG0+Hk6dRmQJxY3ACllWMeA7XVNAvD0A2vP2d/usDWcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392521;
	bh=brd1oaO9ncOUChAQKoaK8Asi5TCBoXsc8Mx1nWwyOIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D1hO+iG8m7vT+qKUsgS+F9VjuCDngY1vEz4nkwY4KBsglOVzMV4eDg8wHMcNKeNyu
	 /vti3a5Mg1nZeQ6DJy3iHDFrHM1bCcfOIKklTankKmN9kZ93gElyibdWpuJK4lYrSM
	 H9woN7jL32sfbY5V1ExbPkFqacpBVhdg3e+eDwTqFleEDpDzny6dHGVYmFXKsXShkD
	 fSazQGlC9yElYTevr+YCFfLKPsbIdF0Igzfg1ERLPNPKhXZEv5I8kMFeXZ0tM0TiGm
	 YsoKM4f6XwBFoOzZcQ0DhbKR/Cou52vtFBJqQfZ32uYPbPO9/kudtJgG7wuGUrXHX1
	 gb0TeOGqieA4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AC00813F5;
	Wed, 11 Nov 2026 10:22:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 411341A6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 32F3940217
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HbvDaQ9NcFHu for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:21:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D08FE40070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FuOLtxVm
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D08FE40070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:52 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so1614215f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794392510; x=1794997310;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=brd1oaO9ncOUChAQKoaK8Asi5TCBoXsc8Mx1nWwyOIY=;
 b=FuOLtxVmbju1sdfv5JUSd6dJ7tGj3ge4NhhhD+j5mIaLC+dqzs0vDuhz/oUOFpittA
 +u9AnrWBvl0S9HCdRn+iZJxdIvHpCth8tVRVM3OGESpTlyvDQuo5B79oqP5LIwJPQZHl
 LWWDRPmzSCqyKlw/xvN5fZGgrNETcD3dUNsMJpaeBD15Ucbyayy4Y0Tjz5ljRYIEty4K
 ZKDqUUmJbgctYpMBIqoSIrysaPCal079q9a/eNYq6YW48nO311lanGrDgjvCTWSk99jP
 9VWAVYn6zA2jHA96T/8CgcMaGHwclJk3hPkBOGzdPxjo6E5+f2jN4KIWeeC3cEu8P2F9
 DEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794392510; x=1794997310;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=brd1oaO9ncOUChAQKoaK8Asi5TCBoXsc8Mx1nWwyOIY=;
 b=AjCCwH2gKkxwATi+gEnhHniYJ0ONy1HJ4zYBVdwGFkBnnXrUeUa5FjQXQHc1LztoVb
 u4iY17QMWeQdLv+VMWAMOkjk1KyC30dvNnBPcQ0Rpj5lovkuG36nv1OjGFotj34F/quO
 Td7BERPIR3vmzvIrHsDJoCswgdS/3jq+IxNLgpt+yoGgv9iOh6ifYKvqYnWcdYLFHWDx
 k4YDZkRb1x2CtgyOXzug1yLQ4gsMjuzujgpJXuuPuV6v58Y1AeRNk/ENFUDThdXXvP/c
 vRcMbBT/+90Kli3NARqin8btQZScPmmCbmL3+ZUY5L+49KiXRGqmaWAOjjfYKYdjRPim
 L9bQ==
X-Gm-Message-State: APuU4Z9tgca2ksuFh7zMmT8hZx6b2c7HREISVsv5J6pW8/YxE3W+32ha
 zGwnk9qPD10ZurDKDTk0c/1W9+oJt3g22cYuvhCiblSN/AEHtzZ5OFLDstClco5dpDQ=
X-Gm-Gg: AYBFou0sSEsvnkOd0BuwPEK3ueLBndadVCCyuDy6eeSNf335lzMyFUs3UhwF2rj4Yb1
 bpKqpC1ya68zVnz8+fZEB/gOn2LTFwAYSZlANHxIqEgXfXYzgrjSDL6A+bri/pigTWmM1JewGEk
 bP7aTHZr6fFF0Q5+3AseGi8YWh43ENyTvCCMB4QxowjTpBe2ILSXT6qD+hGHTcggERjEmHsZwTF
 gaAmQ4E5CtO0+TFL+IBTs3gr7Yh7RaMm2SglSPqGFEJrqlpXG6pDTh4wQyIgGlk4XsEHxdGU5gX
 tspXKcELU89cAsH/Ue4dlk2olk0L30hZ/kGVSJHFZTQ3S/LZZp+yocQqRnCYcL1wWAFt/OVqrSO
 IExw390UbxDTItUdJGGNiB0Md0HaTWv4MWrz0CTM26xbdv8lRW5E415fY/ZCx8xEvbBn7sXlOqJ
 v+74wc9Fik0AGtyqGADCic5OURItZUz0sTPSaRQXdYKT5Oyx5V+brSaCPcf6qdB65Gwvu9c8qc7
 8qn6Qj9nWieH6vkrY7Kt1ylEPBEruyGNUBUN6oT0og7djv6cTb5lfmbYVCbr3w4lFwhs3jwIwoD
 t5OhLRWjThUtratW99LIfSXmu5zUBWjCs65Tnz84jXaO6eUadqkETAe8ZTChzD7/xONE13k1JFH
 r3XTa3OIjaLusA+ipvA9TMIUqnueyzyCj75eyLpS/G0Y+C7ndwNGdM5W1CTWMPEvL/wk=
X-Received: by 2002:a05:6000:4917:b0:492:7969:b4d2 with SMTP id
 ffacd0b85a97d-499c6e96a06mr2972529f8f.40.1794392510079; 
 Wed, 11 Nov 2026 02:21:50 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835858f26sm10550001f8f.18.2026.11.11.02.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:21:49 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 11 Nov 2026 11:21:38 +0100
Subject: [PATCH 5/7] cmd: allow the OP-TEE RPMB command with UFS storage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-genio720-ufs-rpmb-minimal-v1-5-701a62dfa034@baylibre.com>
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
In-Reply-To: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.16.0
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

From: Macpaul Lin <macpaul.lin@mediatek.com>

CMD_OPTEE_RPMB is restricted to the eMMC transport even though the OP-
TEE persistent-object interface is independent of the storage medium.
Allow it with the UFS RPMB subsystem transport as well, preserving the
existing sandbox path and default.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 cmd/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ace0b2e9c80..6f07eccf16b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1554,12 +1554,12 @@ config CMD_CLONE
 
 config CMD_OPTEE_RPMB
 	bool "Enable read/write support on RPMB via OPTEE"
-	depends on (SUPPORT_EMMC_RPMB && OPTEE) || SANDBOX_TEE
+	depends on ((SUPPORT_EMMC_RPMB || SUPPORT_UFS_RPMB) && OPTEE) || SANDBOX_TEE
 	default y if SANDBOX_TEE
 	select OPTEE_TA_AVB if SANDBOX_TEE
 	help
 	  Enable the commands for reading, writing persistent named values
-	  in the Replay Protection Memory Block partition in eMMC by
+	  in the Replay Protection Memory Block partition in eMMC or UFS by
 	  using Persistent Objects in OPTEE
 
 config CMD_OPTEE

-- 
2.56.0

