Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCBDC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 23:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FDC584AC5;
	Tue, 30 Jun 2026 01:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="U0xWQGv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B912984ABC; Tue, 30 Jun 2026 01:35:26 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D43BA84AA0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 65D193F29B
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 23:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782776124;
 bh=lL0/ZZQ6VfwU83yvvNwx4t9+YjELQ2wfDocDmBy9MTU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=U0xWQGv3p3DW9nl6hurgx3cP8zh+9+LiK6tQmqDPYWa0ILcIB+0ibLCSzPIZA+cYu
 jQBqJG7I3YYO2wzbGtapM10o71hNIYFZm+y6Lh/C5r+KO6OjK7DN+dJ0FuBLrY/AZA
 sZ0tEa6V7yk45bBifLu4dsG1NpHnVqjC/uFzU6Hd0BdkMaZYXYjoBesyRMmtQhd0AG
 H07blpZO6xWx5qKFXsu9IPYTuCmoqASuK8/PZvCvDyWbxBDnk+5ZTBWmDkIu/YxS8W
 IC+qT1C5mqoOKK0/j5HO3r6DbrTBkNMniiBDKJ4UUtwJ115wD2s5EjuQLOblUUPM1t
 jKhb2UYQ3Q9pC/EXZ7dhyOqoEVzBP94qedC+Qvfsabh3Er/Oj+psf+maL3fIG7W0xA
 MyKcrZyZ3VWjfgCqeS7Bg+QwjyWOejRoknFBQWcn7uMUlCQAeaWx5bTXYJpFkSRLG0
 sNv2+xqxIC5JwDU1l51okjlYVote3QhlbnV4vei99sWIBIowDqfIA+wOtDPlMJ0L3J
 fc8UOc11gVaEwWQbJmoEX8nLvqbWHpn6GQdrk7PCUXXi1UiArg3qXgxHLpIk4Twzsg
 sMjAIU04+3zcQwi+++vIgVxX2h9wE9nzboI9595rXeuNGRj72Pw/zBEDx4OZIaB7o2
 EOadM4CL71KMnDk+13T0X6M0=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47132f8a98aso2142060f8f.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 16:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782776124; x=1783380924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lL0/ZZQ6VfwU83yvvNwx4t9+YjELQ2wfDocDmBy9MTU=;
 b=Dgp/KsB5aJFbcWVsHuqdby2Cv8pgB9fA7Njq2NuNziKoT/xR8o7An5sv9NYPcPpgzn
 ffFEM5JbGC3Nr3p9restULDLSuQ4heqOve1tnOV7bB5C3wdkhqMShj2Adcs9l979Hx7s
 Jlmaz9dlzO0uxO1no0edlOWpaxMWMHX4/dAQ77Wf0r1/GX2WJxYXOZY6Q1sOwbSjyz1j
 PWy68oAyQY6cTeSnV0QE6DZKeivTQuCMSsmNc2+qWhJIHBaC65oxFsxFM7VP0jGcbOmu
 lR/9LtsxV5lmc/bPTe7I8UBKP5vV+FnkDrzh0Am2d3z1w1dRAq6yxRNYN32Qo1sfyVgn
 rMJA==
X-Gm-Message-State: AOJu0YwbSB76oLU/JMjxjXIroH/1IGVn11xtX1reuoxW6rWQ8vsioZpr
 P5yM7O14ookpi8DVVXQ927OJ3CoYisYzP76k2im7W3Bj0NB64Bg70rVn8HogELgWwH3Xl10Dzc5
 ArR9RaqNSbz1MqHMMSPnCP0DHR6CDrJbP0nLj9p1AQfmyyuap1cbADF7s6HB+JkRslyPe5/Q=
X-Gm-Gg: AfdE7clHMpVBh95TVGOAjYnSf6eFMAyrhl3WvI/vvl0/w8Je3HBd7DnIXB42uY16MiQ
 Aw2Wzye6LQgTAxWd3w/mAzi5ZbRSPkYlVeM29YYTJ8nU3ppTDmilTUjbcTjDnsKFHpBo8QKrTI4
 h7iHx0yQHECZqZdnpBroeaH/fMQUZfp5tp5x1K7WSccYrv1+gCTr4s18pgZViMCWQRCYGZqzCI0
 aFBj0V7DzQOlmQ6JjtjsclNBuDigY6U4fzDI+PYP2Fi8Sp1pqg0hcp2UV2Omq4K304XwH7rf5f2
 rdZJshiavkonZzlmPBvQcu4vmEDC4DzH4cVNTwNaIAsGk/bx+xwJfiJppGc3wLW+UWDj5H2DZ9r
 KA1q0yn13Gk/Khr6vCAuQkjdThr0ISn4P8ImR2fG2vrj1DaFkqd8IlouCaxS7IlIjFQ==
X-Received: by 2002:adf:fb11:0:b0:460:3233:beef with SMTP id
 ffacd0b85a97d-47553ca1fd1mr1219776f8f.43.1782776124023; 
 Mon, 29 Jun 2026 16:35:24 -0700 (PDT)
X-Received: by 2002:adf:fb11:0:b0:460:3233:beef with SMTP id
 ffacd0b85a97d-47553ca1fd1mr1219752f8f.43.1782776123700; 
 Mon, 29 Jun 2026 16:35:23 -0700 (PDT)
Received: from workstation5 ([2a02:3035:626:ba8f:5998:4d02:a4c4:fa47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47566fe448dsm1968537f8f.27.2026.06.29.16.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 16:35:23 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] efi_loader: fix buffer overrun in
 efi_sigstore_parse_siglist
Date: Tue, 30 Jun 2026 01:35:13 +0200
Message-ID: <20260629233514.211746-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629233514.211746-1-heinrich.schuchardt@canonical.com>
References: <20260629233514.211746-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

In efi_sigstore_parse_siglist() sigdata is allocated. But instead of an
allocation matching the size of sigdata, tainted external data was used
to calculate the allocation size. This may lead to buffer overflows.

* Correct the allocation size.
* Follow the man-page. Use the structure size as second argument for
  calloc.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 lib/efi_loader/efi_signature.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
index 93a4f257016..6aff5c14a89 100644
--- a/lib/efi_loader/efi_signature.c
+++ b/lib/efi_loader/efi_signature.c
@@ -703,8 +703,7 @@ efi_sigstore_parse_siglist(struct efi_signature_list *esl)
 			goto err;
 		}
 
-		sig_data = calloc(esl->signature_size
-					- sizeof(esd->signature_owner), 1);
+		sig_data = calloc(1, sizeof(*sig_data));
 		if (!sig_data) {
 			EFI_PRINT("Out of memory\n");
 			goto err;
-- 
2.53.0

