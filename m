Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E09606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tWsWlgdj;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cUc9cB2v
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BDD440AFD;
	Fri, 30 Oct 2026 12:28:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZHr2eRKhzcy; Fri, 30 Oct 2026 12:28:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC8AF40AF8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793363328;
	b=lfeguVg/L4B8UMpXKyA0YxdhII4Hqr5/VEtxbrX+1dX3AfAPTiJeKdrT4Mq1fFJDMBOE
	 AKFf5wkSrj1CBunAIrDbbLsOpI80z/yGzg8Kk+pcX8xf5wmlBlurAqJ5BCWrVDJjv2y3+
	 0FE5GtVjQKLNHiHd07tZqfdbjckVBg4rFL1AkT8A9bxzVQzc1ARuUXkLLxTlzpY2NWy1w
	 vD+OgG/Mftw9QukA1BxzFKHiEJ/eQFeLBKS3xar3UKIj+3DATLoJ1ZfniDiG0I5mpOhjn
	 GNxpw4HlYyComWNIgLDA3IYqBVnVlWSJoJPqXomNNwRKMceMwGkgTaxVlhaNQiGeEQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793363328;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s4FuXs23NmPn923O4EyVDxRGOn7TvfZG6MD2wIMNVqI=;
	b=s/Nwfin++zUf6Isk9IU0BVAzLx71CrxOEKF5U/SCjCT2dlWQHndIebeOIAcY+gg+ewL0
	 49uS7Szo7GinZsuckfu1KgS50peVQQ9h74dDqUU2VtDfGJvB0N16xQijGju/Ehryc1me9
	 qGz4ur5tvlcBh9hTHcJhhqcpGXNKc3lpEayfvnh+QnHz99PQLQ3buKsIboouhATnmSx3z
	 C9cPmjfOrUmX2CfqCCoKY1M7mxAxwykviJ+HUvDFQsU0HONdq6QMX7XAab0mfaro74HC8
	 p39Dy21CqbnRkJxOOIrYNdXt8Yvi0Y2IOmBKL1B4bTfanr1KXJo4//WRWS5FRpeL6tA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793363328;
	bh=s4FuXs23NmPn923O4EyVDxRGOn7TvfZG6MD2wIMNVqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tWsWlgdjms+HTtvD9xHxv/HJTQMmf7GaJdapGqmTJx7SgWAp7bFdx7Yykrc2smgJL
	 FyeGCq1rVxCcUmdoBTn2E09XQOUmKNIXo3VopVk8DaWIoWuv103QRoMyisCas7yh1L
	 D7+4HqWW3cQKoPRqcqKxo4CV81ROGfCV80qR8zG3AYy7FdvQTK/4anB24xBWi7Qk/D
	 c9jRHgqaqsL2uN+IQXvmS0l09+C2dCkMHTFjZoP76WXgBXqcmMjMOYmhH+51OolkuG
	 p3aHR+cTpn9TiVRsytrqMVfKhgmnJ4EGJU7veC6UwwtRxGFVUgYaKZgx50WD6hFef9
	 huscfYy+a3RWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC8AF40AF8;
	Fri, 30 Oct 2026 12:28:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 81BC34BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 734A84052D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S6wINjdTAXKm for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:28:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5F40040243
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793363320;
 b=K64qes53hgddkyuNY78cZVGqD3sNCNI4uA9rSg10vwZfiDjnbUkrigdqLAV2LVwIxtoj
 j4TUimYa4prAw4U7xR2lg6VxtrKAW/Vh8GJNaY+XhRK7/96EPpEVH+jqTGo3FxcdTJyNZ
 7xk572aZyrr2fn40eoTOpoa6xljHMbeeBvZvT8vfh6oOzSGPXS3YQpfteQr8t6v+JhBVB
 XNkO7YjPnG3BRp8jtk1cHRfkVWgOHULwCJ4oVYg4od4U3UuvzkmjWUNXiennNreG/0SOE
 4+ZL4nzMGbJ2VNd7a/kJ+ucGsHQonoknsuFdaUs9ybuZwQc7St6/G/f4cv/GznZCZZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793363320;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=s4FuXs23NmPn923O4EyVDxRGOn7TvfZG6MD2wIMNVqI=;
 b=IpVTz1hsiyHHuaEGALZGzVWZGXyretBNl+WILwArslC+ZkL7zM5awjYQVXNxa1wrVyfL
 vEvCttA21DQtsP1fdnePyXflAp1mQbSdpCxRUGBIDgvV35whsue1Hugc0hiwEIw3QzUsM
 71++66nnI+qEfhPetbzz81AQwSc3+DTew2Ic6pZoehlJGm14pzgE9zjHQvvkoBgffJFNp
 DywZlBbRGjuggcVV6GquOoKtQHRYczP35fiMmFkMeaNjOxUmmN+EQx2vMe2KPV9OZapo0
 8cC77WfEag67wvU/Yrk+eIOB4fr7n5TeZ+A1AMO5i4TJ8jLjbOLsPxQJUxi9Mx5tdsA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=cUc9cB2v; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cUc9cB2v
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F40040243
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:39 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso5587805e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793363318; x=1793968118;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s4FuXs23NmPn923O4EyVDxRGOn7TvfZG6MD2wIMNVqI=;
 b=cUc9cB2v3uWscoK2L1cwfx4iR9irCf+Y7IR8EqALvypjkeEokB+c1S7YjnVMxpMdzj
 lgX9qc06RBE5V1RUhsJYeyD9+l0xTa4QBCEIiCiQ9xn+dHOtaC9M1jsPzwmo/jId9vUj
 MLakQUtj2Nk+E2BtDNWRGnDpQ+jIQ4BU6m2SkI75SmytzRwuTPmcqoEeiP4ce8Dy1SI6
 pByz5uo24lDJHtfVUc1RqLN5Nu/8z8aymuEgRGQFBTW5sA5s+YD5J30XDodCDIejypZ7
 LkNppz9DBcTQn+FJKB9/iCgTEBpVwxmKsKhtfQKDjz88/8K17L6feg0gsA6WEBTYbOcY
 07MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793363318; x=1793968118;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s4FuXs23NmPn923O4EyVDxRGOn7TvfZG6MD2wIMNVqI=;
 b=zBadSmTfjQem1xSY7nA8Te1EoP9kEQhxU+ONyqU9fCrgEdfO+5A/ZCqdBGdu158V76
 p7/SmW3kA7Js+qlYKNYnPFSRazaLsNI1QfKIUo0XkwaHbCZCr3wBOO1qW9rofsBJz3Bb
 vLMZ3/6BankH4Htt3dTiNBbGGg+KSJJWHLOiYoHxf4ncYDYoq1emFjysOrWz1tRyeEM0
 YZxMJr4yvnNNe29ZB9lq/ciDnET1W8faG3XbzU3rX7eV4x7BdAtN713xkgl6b2/OQIbt
 FtaciH6vzVVXJKGO7XGVu1IreVpnnoXNSAs+YZlmyCpCteoF/Tto9pMEv4B4amGdF1X/
 ZSDQ==
X-Gm-Message-State: AFq9FYJr09z5UawVr+Kybk9QzGsKUOC3mDGI7q9yFaZ/gnfT+PFDFseR
 vrByWT97IumtFxxQgEXC8cPFQduYNn6hJzuxbCir9J9+w9jjlwdhRcb/iRvTPud2YYA=
X-Gm-Gg: AYBFou30H5W11qJEDJwakyB46abOb+RyvBKX/81kxj7byHysUzrAQQmlclMuPfYAUKk
 P+zPcDIcylr3fOgNoRIfmDQkbSH8xAJ+JO9syyNz0IdY5Bng1tQHH6TK+M32zjYXWo4zxE+ITyo
 45XMwlFT21AriI7rqDZNXppAMMGY11A11uWzoTK2hypUsNqCONq3HohD0COksYly+Y3AseiKVZ5
 ERpzNyFxRdHN73863ObDU8VoUfQx0JUa2J2sMjo8VYbjOX2aygTImUzUaM2AcEO2Tqq/qAH5Tzc
 iWcP+KgxUPQKqsNlBNdijaPUx7/pklm+w5HjKPdvxw7DaDTOBVoFr5AU8oE0WQvTm0TxlMXJRpq
 C/fjlugmaPHoXjLCJBowinLbwCBzPIFbADii4uSfitRoYlJVoeRmOhUzXikyAWhiwJ2wAeJ4Wdw
 vwJ/fUBHER0sBPZpWKT3YA9VYDhHBFXi54mYKxh2X6ek+6zpNIizS+Ob2Fni3sGKX/ecrPP4KJv
 QnEsoebf9aaV6gNIt7rCUvBhVgs+iB5i0Rd7vbKej7/4dYuq991sVOPjWAJClW1SdwhtM9BukhT
 bGwUIrDMkW3sfn2TwqcrlDKTiUpcNApUplE2CjOCSa4jrg==
X-Received: by 2002:a05:600c:19d2:b0:4a4:4d57:8487 with SMTP id
 5b1f17b1804b1-4ac1737c51dmr46889885e9.5.1793363317681; 
 Fri, 30 Oct 2026 05:28:37 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm40777045e9.3.2026.10.30.05.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 05:28:37 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 30 Oct 2026 13:27:43 +0100
Subject: [PATCH v3 4/6] arm: mach-k3: am62a7: Wait for TIFS initialization
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-4-2a67384ed0ef@baylibre.com>
References: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
In-Reply-To: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2666; i=msp@baylibre.com;
 h=from:subject:message-id; bh=TpMR8AuDiS9QMT2ISzqDy+UojR9qInqTqV93Kugrdqw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwnvYktp6UWvj5geraZ3dw6T6ZyFeeieacXVZ1f/tVn5
 akX746KdkxkYRDjYrAUU2TpTAxN+y+/81jyomWbYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDx4iBi1MApvrGPkaGlXqSrinTOrzLbt5d8n1C38+c0kUybFITPaac7j/rktAQwsiwxK1Etf9
 H885ORuaDEwuOH3SqnNrJNvmY1cQldf83prgzAQA=
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
 arch/arm/mach-k3/am62ax/am62a7_init.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index b1f290c1d765..405c5d4fad94 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -10,6 +10,7 @@ config SOC_K3_AM625
 
 config SOC_K3_AM62A7
 	bool "TI's K3 based AM62A7 SoC Family Support"
+	select SPL_DM_EVENT if SPL
 
 config SOC_K3_AM62P5
 	bool "TI's K3 based AM62P5 SoC Family Support"
diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 0d86d52ef267..ddfe84217ab4 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
+#include <event.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -110,6 +111,20 @@ static void ctrl_mmr_unlock(void)
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
@@ -134,8 +149,6 @@ void board_init_f(ulong dummy)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	spl_early_init();
 

-- 
2.56.0

