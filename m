Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C79606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HeAH+Jq6;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=CxcWMEvR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32C066061C;
	Sat, 14 Nov 2026 15:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1_NlQ8gkR7lu; Sat, 14 Nov 2026 15:00:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F2096064C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794668407;
	b=QHSksqg9YwhUtNqP/HaEQlrPP8WrcZ2y51GYCYg3Zuua+cI63TIme9bLGzbwMw+6LGn1
	 /ZyRt2kLNhKeeCfnXMoGHy4ODIotJD0KU5kkWik200oOWgDXAnJ7XKTg5ppQdCaHsl/Ir
	 nocXN0tQQEaaNW/A5IxonPfo4bK7HUFYjuQ0RIJuPmPJoTbqWindKCkTzElfVaEMmyUHD
	 Bn+6z+cxaAEH9MU8wlQZtx9Nx8p4pWMYhPykGxNnCOpgxlYYhNu9mH8IylK5DKCvFybBT
	 ZJyHpVnBW5/RZO5L++7sqRiKnz1WY/1k9tdZOl/xJNu6qFpfnQNUZEqcBKfV1DBSJOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794668407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4pNcqYceAC3B670dc6BK85ka0T1TFq0Yz1xafJy8/TY=;
	b=GzHk+jBJFlmsKRyxQ+QYjt4WEaT61icHx5lLXX8w1aOb9/yRxTOajBgiT4mCcipEZRRQ
	 wltclaGocOqXitwIrFlX3rGpC75Fin/IC3IxJ+jOM1Cw2Uwx6kPQvVUmuln68hAccoxCz
	 yzMgiFRrarzdiKndZ8GGNCGWvnfJAhS6k34YUzGtY7W9Lh/+qXQwy4bDcoBolsty5/8o8
	 cmKr7B59GqL1GT07qi/whq6N6H3PeB38Y7/RPEMXSltn7HMG4UqiWvjsdreMP4aqt/RW8
	 1hFlN70kpqFwmkvsgvmfELPDQhbmvygO2LTFvumKpBgiwQILWeImnWGpbtnfYCuOUFg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=CxcWMEvR;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794668407;
	bh=4pNcqYceAC3B670dc6BK85ka0T1TFq0Yz1xafJy8/TY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HeAH+Jq68VEksE1uYzuUnKZ3ZHhCFZdi6HbVGNH5Qo/ap7kvuKKMHKkVMwuHYk5Ul
	 pYXOKHj24cAH4fu5685kQFsmL8hhLsLNFh0Su9tteG3QtQXdv1y6EE3lu7M1bIOz2d
	 mg75nKNHpjk2Si15G2VJHbsra1xv9IK4dkkHiy4pJyUFmKhJw6XKEw9s4iJdAwbnAX
	 MavqGaRjzpd/6eZIX9oJfc8nG9R/TwY6ybkcQrrJeIABxaHyFT+IkrybXWVDmoTt5W
	 2C75h+0NZhXxevF+cUkAGLjsKujFa8P/MG+b+oEwbmoPNOCzdi96Jai39srGdLGlLV
	 Htybdy+8Iv1tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F2096064C;
	Sat, 14 Nov 2026 15:00:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8327772D
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 15:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 69A316064C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 15:00:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6V79NO_XOHhl for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 15:00:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6C2FD6061C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=CxcWMEvR
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C2FD6061C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 15:00:02 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-491d1f66968so453663f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794668400; x=1795273200;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4pNcqYceAC3B670dc6BK85ka0T1TFq0Yz1xafJy8/TY=;
 b=CxcWMEvRNlRqJDywxCXz2Jeg4yU3buHlKEg04qc8OQs+GoWoKUnCv+pTSEWCV/ihgu
 y6dy5foQXhv11p1eEgFRTC/49tZr2mrhZd5C93iyObdnpN5hxqD8gAp3CpSCtBtxkslz
 1/AHtSSzZ1+og/EIdiNfArpg7ID4WSj6dVr2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794668400; x=1795273200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4pNcqYceAC3B670dc6BK85ka0T1TFq0Yz1xafJy8/TY=;
 b=LiYzQN0/WQqdiJi+xl81HVayYrWs4hNE/fwig090542JFFD0Jgt8U9Qe1rkip6sRsd
 tqBNHoFzdcM9lJ3qUmYl017rBz7+xcPcDFrp5UPzVo/ie5cgilCRYdUrQQXjC/4PaegN
 o9IvO2xhSyVSymr4cCD4/4fShvIonnJ85NUFdjuUiZPwf5MPXKrqIyahnxSd+6+W2jtT
 o2FxUjpOJ+jZpoLk+aKPaIBmru06KOLD+f8OXsNKX+cNxtiPrXanqNUHC2wNqYaCArIc
 VAdUNyW6NLX5h1vTYIWug4W2ZI+E1QFsfZn7W/NGMShHde3d2BzUdz4yZt519itp/z2z
 mFoA==
X-Forwarded-Encrypted: i=1;
 AL+hErGU9nTffh5p4YgrrkGBE90FxKR+c1d7cAZxBMqYfKZQOJyN+JGx8X8jURH57wJh41ytVLW4piU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+1bFOEq1xVlDGqmOFp/rCrRFH6sC9Yqdew3a4m4YnfwR1VnOXe
 hkxFT31xnBANmKg473cUohPlZEJ5R03hi9iC+h1gxPCIoAPCJoWqLW2DcWUOaf0XNbyCkyerjVq
 hReLy
X-Gm-Gg: AYBFou2sTgpUUMLk58p6g1o6t5sp7ipH9C9LSHkfq+scJAbg3BBHjB+Zlf1F/0rNBZy
 qGFCL//HhLRwlSsLs56pCnsancValF8Go0ibgbebgH9BQz6axP51XqoQqWJGpds80q4RYTEo7gs
 PzgfJ02ITGgykM40xbH5o2G5xvvDH6L2QG3Jh7QNgYlncQMd6Z2W5uYNDFXHF8dNeya822mNfl7
 v5rXqae4mvRKrDCjbLSaL9x9+mrOVnzMzwU0Sipi95kNy8FVMBa/IXdzJcwExS3wzNcDEfxlwM4
 uI07MbSE1pgG6Le07jif605DaWcGE8GLKUqIrvVCAgGvpFGDckKz+d4MHIG9jg0ThWK8vbhprJ6
 ybvygmb9USgkqoAjTmV/gsztK78E21jfyTmCZwi9Fz0kTEot7uL0u/bxEIsWkpFI6hyHmnvXeTG
 VYj30mrvZuWzzvOsgcatV1QkGOefbFlEk7akUo6nvbKaenqpfIjcijFbYe7hAfvgTpTAiskeROr
 UG7BWB51ey4LOBiy7lCKxnXQ9NO7XTM0ig6jmS+0LHiC5TdtBNS06bQK4M4QNy+edsE1Y0HkPFj
 WHpWeVkMu4kpBhCCZgg/wB2aVN6VXM+vGVBPLmBWYxo1yG+Idj7i53K0IkWMbl+aLWE1mwn0g41
 JONT6VAYSuM55RXfUa1M9RwNMTWs3CTOuRKJxrl44nE6ZmjGjdaNsy2YEN5BrfJ+DfIaSx+BtAq
 G1R8re8gUfTvpH+DIqvaBE1CXMfg==
X-Received: by 2002:adf:e013:0:20b0:49b:b93d:9631 with SMTP id
 ffacd0b85a97d-49c71970581mr8655354f8f.48.1794668400276; 
 Sat, 14 Nov 2026 07:00:00 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f782396sm11728413f8f.24.2026.11.14.06.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 06:59:59 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 0/2] Enable the display of the STM32MP257F-EV1
Date: Sat, 14 Nov 2026 15:59:42 +0100
Message-ID: <20261114145957.2197295-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series enables the LVDS panel of the STM32MP257F-EV1 and shows
the STMicroelectronics logo as splash screen on the STM32MP25 boards,
as already done on the STM32MP15 ones.

Tested on the STM32MP257F-EV1.

Changes in v2:
- Drop the redundant MAINTAINERS entry

Dario Binacchi (2):
  configs: stm32mp25: enable the LVDS panel of the STM32MP257F-EV1
  board: stm32mp25: add splash screen with stmicroelectronics logo

 configs/stm32mp25_defconfig           |  10 ++++++++++
 include/configs/stm32mp25_st_common.h |   4 +++-
 tools/logos/stm32mp2.bmp              | Bin 0 -> 7802 bytes
 3 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 tools/logos/stm32mp2.bmp

---
base-commit: ff8a9bc41e4e5bdd3406932af5abb4c18064e539
branch: stm32mp2-splash-screen

-- 
2.43.0

