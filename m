Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE3606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Or3WtxhV;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=BScfiBod
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CB816075F;
	Tue, 20 Oct 2026 17:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 88Ef_sTyHZ0G; Tue, 20 Oct 2026 17:26:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0006760853
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517198;
	b=bv8HdPD7+l6rqp1BcoS7nCLgjvB0UNgzj3O9R3NNWN9HdBNNKTQxhEBHMgoYmPOlONGi
	 zg44Ai+KdjG9bZZRRViAvne1Rrm9olBMlO8PCY+s8YW1SmNtQjoz6DTNpWUn85wxwnbQf
	 r+sv4YeOJpkx3JsqRrTZ/rLVU1kRkqIneJCY1E+sqA4fhG7S8RlT8OLicrLYfYQVcT8/M
	 7XuLoZI9T+gXQZnIifutVPlVcmBCgB2jJogZuk7T5vBQAciBamWerrb7ahsz9yli/iOvK
	 DQgC84WcNznwivyJ3WyDyZGiP+q/zXlK64DNH6CgNAzYyJUTJWWehp3IPnVON0Slukw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517198;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ls23kXy2MFVXND5kFeTtqMhE3aypflDinKBMKkqMHgY=;
	b=LDr6deYmGS8n24MqbGOs3AWvjZkkIniiT2wmfh0VhbjWYpV6ZYq6lYj9S0881GVRqxG6
	 BZAm5k7xlbRaYrFzyr3K/GCq0eFEv026wiub8VJt9Wen3VZ9gY2lfxOMFs3oZV/yY3xDZ
	 Y3dPN4AL0ylXthRHZ3qbvWQU4YOEtlIU22dgfhkgIjM69vdeahWynxEXC6DujQ+Z/LLRF
	 uimXREwCALBV5aI1ucpSK65ruCCD6aWx1V3+5fyUqf5ITgCGGgLAk1trld/4XS0QrAfxO
	 Cyx++BzYQXiqQrvXO2AwK2Xl7X2XUNb4Jke7MkTMVy4l2Fa/sM0r1yTyHFo8bNk9K7g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517198;
	bh=ls23kXy2MFVXND5kFeTtqMhE3aypflDinKBMKkqMHgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Or3WtxhVjZ9B18SMEEcnu24qa7uIjJ9+qOo48tGHCAEQBj3R1KC8e8kbh2DpDKBOC
	 NU2JEQIxJBE2ov9fWBEMMhV8juSSd8tdKUdRXUHtVAnvZZ+v0TgVziYfhpI5V19945
	 BapW4+/hRfC2+zeaRDJVyf8O6Y2YtVN3reDFdqJg3PrHq3wyp5tpcyBkLt6lK5BcuN
	 mh+IgY1MStQUQfej+UHv8s+rOkINSt3dK2syo3RHEUO02aITQnALuh2jnw9SuYjluj
	 rTiMEgGFKjXqZIzYQ/Y+BfdGhzjJPmO5rmHKvIUdvzKuIaLbyp73n/v03fGY1RB7qT
	 +1ICRF0uZEMJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0006760853;
	Tue, 20 Oct 2026 17:26:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A6051E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 506F6400CD
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0UqkFLyYIQUl for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 63FEB40060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514611;
 b=P9z/oJTMLrVw2Fg6VYQ1cmLnRikOVPrbylvp+2LGCd7N249lmbNiv9PK/+vTudtqakeN
 qmcN1Wb89pTaC3Q+927xTi++AmBca3a05veBl+e0DKq7KZJpGZJMwMDevz0vESMuqAz9b
 Qo7qzJvrGjhIwO9abaYhPV3E3NIbrD4+RrqBP0+NAlz2kkD6X8rCu3/Tq22JtyBIuXDnw
 /m/MB6xPf5RB4IVqdJRZfCnNV6iJOgn8dJBc9e+X27Fqb7mL2MPPY3Fnmha0CxmrAen80
 ttUKX+1xs9znZOy7afQ2XqSocCsU0OCgcA4O2iOh4yWgrhQ7ePqoFjxa5uVs4yzC93w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514611;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ls23kXy2MFVXND5kFeTtqMhE3aypflDinKBMKkqMHgY=;
 b=AbBFPkXQTJ3wbMyN5OKvOdkFX3TgeJ5i9SDrOGGesk4Iv1uRXjjpNEvnzNtT8r6+IAKv
 zDrO2QPqxs0RblczA7WTDPRojmG2qUuNmah6zpqDAwR9K7T2WLambVVmLppgmRmF2wrBJ
 uGAXK0kdstrLCmgpt+iexa8IMghblfN1JHqZK5jll8AdDaz0Er2FqGo/FKBhg7isE9Fwm
 gnKefxjFyofhcbOcyNdgQjaXKxYT0dK377DYBSNgAZ6gXcWeXjMwIumVyOaixGrUs1rs0
 0L+AnMmnRYk3keZHvpJca7rkM6tlZxKwJtNzE0Cg1A/vHpO1T3rSLT84LwxqyzviiZg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=BScfiBod; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=BScfiBod
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63FEB40060
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:30 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso28005855e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514609; x=1793119409;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ls23kXy2MFVXND5kFeTtqMhE3aypflDinKBMKkqMHgY=;
 b=BScfiBodk6B0VIDMq6aN3Bs6HdfVIlxGMUMkw4n3zi+XBzKVj4t6e0GTM2uQ5ZJONI
 Bwbl69GCFJGXghnxmFU+EMOq8+84XGJo8E0tSm0o9FcYEJ0AHWOOG5UBcM/hNx/V9hG2
 bEw6cj0EbVVu+tO6geNX/NaWqDsKOd7xg8Htw2HOt0OSoeywTtaD1XjMVDwJwwrHjGJZ
 P84waunheCAQx26+YhpoKx7U4VB+pabyq88D7QMR3HBVWzACpoH/+MvTX72MAUm5MRLE
 tEU6JZzsyNU0VKHUYNLp4RkyWglUK3GJ39NTkVGuDziD6DjhVRXylntLWpiY2KDAH4HF
 eS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514609; x=1793119409;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ls23kXy2MFVXND5kFeTtqMhE3aypflDinKBMKkqMHgY=;
 b=h/4lzwqCIRgT4OrxjDOjEvIA1BwJCO0+4RFTBZrVCxVfNZ6ABSqXM9FPzTFUvLDI7D
 /AZ5YCMK4p7sSWCugGuZI4XAx5w4+VXnXM9MtPXkhmlil0yp2CV++R4cTUGA0C2/S7CL
 X9T5fQY8YHXcz+2M5/O74wUlcz1wgy4IvxwNRAw9wtAnfZ7gRS9k84Cc5Oln15fUXPR/
 e0GhvLUGpYgIxdqOSdHM3Ub5BlyOoqtypaF3KUBJfBgZ0s6ZDxLukwJuI2emo21zzRyC
 L/aBSTVfUMUn7L7Y4pxvh0pArkpz/83bY0ecs+wezxATXla5tMPo/rUafP108OEO+okk
 wEIA==
X-Gm-Message-State: AFq9FYLkt99ASrq8gTYOsAzFqY3Ub986tPBSylFOEOYF60GL2fu3//ab
 jhAucRQwOBlaLqN5cfAr8pZj9lnlfpORWBo4DbqZ5ptvLz2RO0GPRUMOBQuX8JHOm7E=
X-Gm-Gg: AYBFou2aIAa6O2Z2K/Y1nY/G1Zz98NfNY7pp3R7gTfzvlXKA6a9rGYD3f1wdlXom0Q0
 1ZHaQMhMYKbMYkP28pgF2pOF5qVHHyKOrA8oH9XJfbAy1ltF9iBlGctFBAq6Uh4dwA6eYDWeTWj
 8EeMNcw5Cxkiw0NU5WwxknYKALFsKLZCYcD5AoucQOBB3yCUy29NOMf2nNggey07Td8c0l1tv0a
 by50Ci8gEuhYf/hDX1u9daZWChbrnEifXySwjDC0UwiDylTXkuUqFw1Vgu16P9TW/+KyRqUarpR
 BGcpC8DeZzMcqvH1KfRR+loV3wVTItna2yfHJBvnVGsTlQmuCP3ugBYsiOgbwEPhDvw2qLDnsVH
 ro3mNSL7q6BKB/TK8L7Gbo2/si6lAqgp6xiOV/lIb9tSEFKNssJq9HhjWSvMIAHYI/lXXtTdX9i
 hOL9VoPkShfBMoha+xEOcGLWJVUBhz3sTUbeTqeNzd+JLOhTsUx9NlLi4bfMpRu18PS+FHgSbKw
 f2OAecbPwEXzxVR5ieVrgtiqLtVi+v3DRPLGeLbP2ZdTpHhPr3aXQ==
X-Received: by 2002:a05:600c:3b91:b0:4a1:dfd4:9430 with SMTP id
 5b1f17b1804b1-4a1dfd4955fmr235763585e9.28.1792514608908; 
 Tue, 20 Oct 2026 09:43:28 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:43:28 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:41:08 +0400
Subject: [PATCH v3 21/23] rockchip: Choose FIT payload compression via Kconfig
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-21-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
In-Reply-To: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
To: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>, 
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2686; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ZAfPR4XOBwkZYfb3B8VywoxOdBzFotPJLO60FxcD/tk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7laZoPiksqFqlZTjtbcv/+hzmX+f9aTW1qfaiW92
 dpxyfhodsdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTXcbHyLDGbKFRtLDn6fmzpQS2S85qbOi752Jx4fcXE7a1+5unZnQz/I+av4N
 lckGumWpO9dbM7dPCHu0LWhIsklfGUl1Tm//kFDMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 20 Oct 2026 17:26:00 +0000
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

The dtsi infers how to compress U-Boot proper from whichever SPL
decompressor happens to be enabled, so there is no way to ask for one in
particular, turning a decompressor on for something else silently
changes the image, and the conditional has to be updated with every new
algorithm.

Take the selection from the generic choice instead, which covers every
algorithm SPL can unpack and carries a compression level. Declare the
capability under the same condition the dtsi already uses to decide
whether it emits a FIT at all.

This defaults to no compression rather than following whichever
decompressor is enabled, which is a deliberate change: the setting is now
asked for rather than inferred. No in-tree Rockchip defconfig enables
SPL_GZIP or SPL_LZMA, so no board changes behaviour.

The level is not offered for lzma, whose tool has no such knob and is
steered by its dictionary and context-bit settings instead.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/Kconfig                  |  1 +
 arch/arm/dts/rockchip-u-boot.dtsi | 16 ++++++----------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3e9f3b51031b..c689c88e0bb1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2128,6 +2128,7 @@ config ARCH_ROCKCHIP
 	select DM
 	select DM_USB_GADGET if USB_DWC3_GADGET
 	select ENABLE_ARM_SOC_BOOT0_HOOK
+	select HAVE_SPL_FIT_COMPRESSION if ARM64 || SPL_OPTEE_IMAGE
 	select OF_CONTROL
 	select SPL_DM if SPL
 	select SYS_MALLOC_F
diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 4ba6a87e78ab..a934729df3ad 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -11,14 +11,6 @@
 #define FIT_ARCH		"arm"
 #endif
 
-#if defined(CONFIG_SPL_GZIP)
-#define FIT_UBOOT_COMP		"gzip"
-#elif defined(CONFIG_SPL_LZMA)
-#define FIT_UBOOT_COMP		"lzma"
-#else
-#define FIT_UBOOT_COMP		"none"
-#endif
-
 /*
  * SHA256 should be enabled in SPL when signature validation is involved,
  * CRC32 should only be used for basic checksum validation of FIT images.
@@ -61,11 +53,15 @@
 				type = "standalone";
 				os = "u-boot";
 				arch = FIT_ARCH;
-				compression = FIT_UBOOT_COMP;
+				compression = CONFIG_SPL_FIT_UBOOT_COMP;
 				load = <CONFIG_TEXT_BASE>;
 				entry = <CONFIG_TEXT_BASE>;
 				u-boot-nodtb {
-					compress = FIT_UBOOT_COMP;
+					compress = CONFIG_SPL_FIT_UBOOT_COMP;
+#if CONFIG_SPL_FIT_UBOOT_COMP_LEVEL != 0
+					compress-level =
+						<CONFIG_SPL_FIT_UBOOT_COMP_LEVEL>;
+#endif
 				};
 #ifdef FIT_HASH_ALGO
 				hash {

-- 
2.55.0

