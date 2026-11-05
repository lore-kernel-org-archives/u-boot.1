Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04520606A329
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lRzTjTvc;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=RuR/tERA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B59E681169;
	Thu,  5 Nov 2026 17:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Af4hRvyIdefB; Thu,  5 Nov 2026 17:54:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB40281135
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793901274;
	b=h9bO6KivFKYwguVQUh3YJhHkY+jMejifNuGvF/SeNNMYA9ijMPub11djIgZ9ff/0bqG/
	 VU8dxR2kvy+JM/COFc9I5hy5l9TNemt5wjNpfX/UcNmavC/r7CXsOH1q7edZAAUyy/eWt
	 A8LCVkOKe3JuwYbRFLzRPNeY9EF1G8gopf7lUcXA/MOCx3r/Om6GcvDg1uGPtKQGUW94c
	 B0ZKPubIdwbVAPgY3V01ycM8VqtKOt0I1zJly0JL1/4iMhAk/cyC4J1QD1Wb+0f0a65NE
	 8WoyjLuxoh3DGZBBQCwUnfx1hRku8lqx3RTMdyjrp5TPmGxEKbMr4+iDAZqT5JLXsJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793901274;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EeqLkxPJbtc/ZPTyad+PQKOyrz2X43T1JIYNjpgU/es=;
	b=Y5L+vAHvP1Bes0Mz65F7GEieUwdnTR6j9db4r4UGpKYDdzEL4/QSD8ePP10g8S7r2XeL
	 +QzD3qGUnCyBEkwfjjnhj/cYIy6NFCqmfhU2WADMEZFE57Jx1GIgiYSwe8wdcqqmwiEfE
	 UINUOobvBUMFidqJcPZxTVsdlbvwlc0OwcWW9EFdrrTaOy4sCWvV/92Q42mPUK5VWCeFp
	 /ERJ/sV2x4pEIzyHC/bGCLlfQTbJ/9rBAS5TGZYLEzPGeegRYcllzv1ioIU0jG14OFYfT
	 RovkALMAR8ZJoJY35wR7Pf2ka1HDFZjpiou1WiLe7qC5s9dSvP/Tao3SkHMoVd1MsMA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="RuR/tERA";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793901274;
	bh=EeqLkxPJbtc/ZPTyad+PQKOyrz2X43T1JIYNjpgU/es=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lRzTjTvckOzG3DTVzAjPc6ImHFr2Pvz18UhFSgXWZnEtJFwPxHzMIXl9cHDR79cjK
	 Q/9eFlE3XD5hVvVkG6Sz655+hbR3FyPlJjtZujHALulx1ohIEd0kfjbMzsLc1FXZaC
	 XClLrPNtIO9wxliwQm7yu+O12nwpGQVnBweEu0YGQw6KQBbdSHAyjRIdNHsktjWSGi
	 3nDfgZ+ZOXGbP7vILNLl1a7nw+Q13kygYGyc/VExbCjsA1N7lOdQrTuFDPxJ4+pryp
	 E2IMxw3j2dmdPZbPcGiZ4DJ6XMK4lN/dl8JdPXDR1GWrW8bLWnviIDP1ADbBCi8wve
	 Wf3FCvFAztu3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB40281135;
	Thu,  5 Nov 2026 17:54:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE9A231F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFEB181135
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xls4giUToXWY for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:54:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 842E28112C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RuR/tERA
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 842E28112C
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:30 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so2350994a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793901270; x=1794506070;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EeqLkxPJbtc/ZPTyad+PQKOyrz2X43T1JIYNjpgU/es=;
 b=RuR/tERA1YmlfM0qkgWQKQ25vWigqCoLMTN0wAtPC/Se0M2CiMc5Whmz4sDjKPTqQM
 asgz6j4FT2PaqqV15OQb3rSFBrPyf++1x0U52D7OyRdhpShVkBvy3dl6hLTCClxS7V7U
 j8hVELEsUON6zXs2h3JZTdE3N0C/bjlJfJSc7dYbCXzQSxn01yv4qYOVD9XGDdtWUSJc
 pu2QkcVYqxGV8bj0jUqfBTlqi+jHlW2bl4xL9VGp1duMgE7j9VbQTWOGMKoMinq0baqT
 c4Veztg2Lxoy+/UNuJBR0pHPeq3aTlQUiGeyPGKyWexUqZ0c9qlGCZKGSiZCCBXmnMPu
 pdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793901270; x=1794506070;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EeqLkxPJbtc/ZPTyad+PQKOyrz2X43T1JIYNjpgU/es=;
 b=xI9UXSKFZ1QsrKGhL6C4AeG8jdjkLg2a0AFnx/QHNt+A3Yu7ikv9056bcBBsfirrk1
 ouYiQ74y2EQtNrfUaA8jC8RRqMWFILc5487xThtW/j3Ml7iCwZIVw8JpAwreH3ixom1X
 3cewzY8b8RbFVGukMHfEthLOx26eRoyHasNpC7ODQSC80Bxl5Wl7rXp/kU/XknYOIoqZ
 YMNCOtpYU0wOhbiQmQOOYGNtK0IJ4JjTfNaIR4qBO0LKAPJFnVfP++l+j0vo129XF1Dv
 7HmUpEHaEH9C8tMkEeoIbf4mohyhcbdBLxSQakosNB42eX8QEYt1B56R3cl9LptDoMrl
 7Dyw==
X-Gm-Message-State: APuU4Z9UKOc27yCqv9b6VRDjFStgzgPlwYyLFT6VGbyoFteH2oFxX1dp
 ZfpEsGe7UOHDI0WDWDMTNSPMRuhsV8Piyo9KgU27GOR2OIWYBehl7yyWAl/uLhyhyA4=
X-Gm-Gg: AYBFou1ngbP0F1uGfC3iuooDwyk2Rn/Vhn8mbVcXSGvz6TlCwwPoE+/wf/cp4CmndLP
 7tF9VnBFznN4ycDa649/tRaZfqHxml18vqzPTplxnPICTdjrai0pFjDOQ8Es82ZTYFVWR4er00o
 JFl+SOcE5uxmaEVDe5yc4xdk+mrJVp1gJDbB2ymid3caxa2OtQSxu6keIulaG7WO7kZ1Z5DunWr
 910S0YiDbgPv7r1rz8cj6XpDTJKxJpEBJO2AKHsqyx9bL4IJV6bZr1vx0eAFJ0SRTdf8nQTt7sX
 jqCi5CLsGcmz/p+Jaafa0ADWuQa6TR1m0o7BQls126ipiYPgZ9zsCqk3ZCxdzbsHlM2Xdd8fKy4
 73AmZOSh3rj42vsKjSsdWGk29r9kAocy4aqy5qmbct62R7JOBwUXvKxxm+6sPP+WPKVMA+VPcZu
 WVxwle5HpYaufyI/9JJ3GzDB5INYyDC4Iz0lAnLG5pqlo/YRDgqrzJKA3PKO1NbuL54GODrtMq2
 3s/G8VNhhL89Nx+u4sni935KijcD5FGbJS+Va8Bv3T2pbUXhzxnC2/ILqzuAGnshcMyTYQ4ol/K
 ZEYhpw1ncABWZI+tRnwED4wg9EcC0SrG+A==
X-Received: by 2002:a05:6820:1343:b0:70e:177b:eb6a with SMTP id
 006d021491bc7-716e78ae8femr246350eaf.17.1793901269776; 
 Thu, 05 Nov 2026 09:54:29 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c12eb1b9sm4659682eaf.10.2026.11.05.09.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:54:29 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/6] mediatek: mt8189: add U-Boot SPL boot for Genio 520
 and 720
Date: Thu, 05 Nov 2026 11:53:35 -0600
Message-Id: <20261105-mtk-genio-720-spl-v2-0-4994535a3848@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0K6dsx0JDW68h6GBZQBRoGSFomEc
 HcLunT5kvffX1RgLxzUNVmU50mCuD4CHRJlm7yvGaSMrAjJaNQn6MYn1NyLgzMhhKEFbQhTbaw
 hSlXcDZ4ree/Ne/bl8CoebMcttBmNhNH5eT+d9Ob9+vSvP2lAqMgiM17SqsRbkc+tFJ6P1nUqW
 9f1A9ZOMojHAAAA
X-Change-ID: 20261013-mtk-genio-720-spl-1620416c6224
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=YR1MoZl4eyH2KkYw6BerEzHIcyHQFZXH34TXx3PCcdo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7MKjKWNLNw10aRilnkhvk2iOq9U3eJqQtANgV
 fur2IkwF46JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauzCoxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AiP4H/Rvk/jmdHKDXZEp7ldBqjqA7aTHIGppOXNQNqLe
 qPuFvNuxNKlpZsTH4rBBGWlAsC8gcMDNnJki0vU2mBOpbC4emRbz6uyzOZk41JqVH2vRbvdb6rB
 6EretsZlii7WdO4WGwmA7Ma53r1mHWht8YflVRlKEWydqAvvVl4MoTmaRyY36krJHX9cUD2yQoS
 im88obfJE7ugqlZWVPtV7SxKB8jsrb4M863QPHIfeD2t+imDRgvbuz3mndVNGoXx/vFZ74rjkWy
 Yr4On0K0/IvGOiOemAPn2V2X0821KiUi3k0UCB14ac6dq4zLX/TB/ExgypeciQXBDffqyKOyFRj
 OMcA=
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an optional boot chain for the Genio 520 and 720 EVKs in which
U-Boot SPL replaces the platform BL2. An external DDR loader initializes
DRAM and starts SPL, which loads BL31, OP-TEE and U-Boot proper from a
FIT on eMMC.

U-Boot proper takes the DRAM size from its devicetree for now. Passing
the DRAM description from the DDR loader through SPL to U-Boot proper
will follow in a separate series.

Tested on a Genio 520 EVK booting from eMMC.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Drop "spl: atf: optionally pass the bloblist to BL33". Passing the
  bloblist from SPL is now done in the series "spl: pass the bloblist to
  the next phase in registers".
- Drop the bloblist options from the config and the transfer list parts
  from the docs. The DRAM description will follow in a separate series.
- Rebase on main instead of "mediatek: mt8189: apply the DRAM description
  from the bloblist".
- Link to v1: https://patch.msgid.link/20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com

---
David Lechner (6):
      arm: mediatek: mt8189: fix the reset_cpu() prototype
      arm: mediatek: mt8189: use phase-aware PSCI reset
      arm: dts: mediatek: prepare Genio 520 and 720 devices for SPL
      configs: mt8189: enable eMMC FIT boot from SPL
      arm: mediatek: build Genio 520 and 720 boot images with binman
      doc: board: mediatek: document Genio 520 and 720 boot

 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi |   9 +
 arch/arm/dts/mt8371-genio-common-u-boot.dtsi  |  81 +++++++++
 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi |   9 +
 arch/arm/mach-mediatek/Kconfig                |  10 +-
 arch/arm/mach-mediatek/mt8189/init.c          |  14 +-
 board/mediatek/MAINTAINERS                    |   3 +
 configs/mt8189.config                         |  34 ++++
 doc/board/mediatek/index.rst                  |   1 +
 doc/board/mediatek/mt8189-genio-evk.rst       | 238 ++++++++++++++++++++++++++
 9 files changed, 393 insertions(+), 6 deletions(-)
---
base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
change-id: 20261013-mtk-genio-720-spl-1620416c6224

Best regards,
--  
David Lechner <dlechner@baylibre.com>

