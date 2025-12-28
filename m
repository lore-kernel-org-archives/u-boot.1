Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2621D3B7E5
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 15:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533A483AA0;
	Sun, 28 Dec 2025 16:18:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Qw2WDlXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E74A83A94; Sun, 28 Dec 2025 16:18:32 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D8C8392C
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 16:18:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64b7318f1b0so9872245a12.2
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 07:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1766935109; x=1767539909;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kN/0yKIETiWdMocNf6ulhAovEy5FxJcRqo5j91lvYd8=;
 b=Qw2WDlXI7aXU7VKFeNPFmKVaL9yjvK+ibqmLQ+SveRtyPs9m4tiCwZgdSObdblk5bb
 iGxWyYNhyPt8401siPfGCc+AQ4e2mZpjvnrVc/5UTNIh5iQeAuNDLf6UYhaoHrMZNnRt
 mMHwxpzGPSYUKs2503MYwgNPPCoCSBbsE1emI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766935109; x=1767539909;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kN/0yKIETiWdMocNf6ulhAovEy5FxJcRqo5j91lvYd8=;
 b=sxhNLgZ3shy9T6xgRwfkuKTWvkgGX0T1fi29mPAgGfS+a5dP0LGFK8Mdj/5aUmthus
 gfZQxSLxRemkF+SwVFlNgGTIO9DnbIQHlaUG73i6++iY5A/3B5ZeSJoBle9eyv6/2aqp
 gbHTCf6h9tMndnzHk5GwRdVI7fvjs4dgseVl+CAN5wlptqbvQbbtyFvVRebJ8EYYgcl8
 3JX6D9myTm8KHWlkj6VokLhD7vfMGMPAptqszgYyUKVvxQ1AQizOY62dtamlZA0DBfie
 bC/cU5njS9CRULR+RAN1AbmBKG0axFocChxHy+8FOMpPYpFd95RPutzfjzonA9jDnOoK
 ucAw==
X-Gm-Message-State: AOJu0YyIa2BE3iXzq6qsar0z/Cu9nyNYegXsC8nJqNMHfkyFsPPlJxDP
 tXkXjbTmoGPhmVrragWX1QAoFrVgJ+XZUeIuX3pJmXxFx9NIzQaQjsOFTlJRx8yIke46+AeUIqB
 hlcF2
X-Gm-Gg: AY/fxX5MdgAVT/sqcgitmTMw/NCQ7WOoe9vJ3e3SoOXNC/q4Qst0Mfqto0W7e1Wct/W
 EZwcgA+eMrqzPyIYX1ZWV3WxLofS7yWZ3oWtNQPF1IXm01REFzZ4TP6Bh7zjuunuAqKjiiGFdBg
 ihf/Gxj8iF1eh6ponxg2f0THS++ELS0JXm39hp3W/sVwNn5AsxPuHQDGRY3hbopKjQyupvTojFj
 gGhxyspiYyc1lb95C3Z/Jp0hdhnrehPpXGOydpg9KyC+Ya2M45296wGMDVP/+sAy2YgWH2TaBZH
 nrcfgKJOJWiRCSr/js/eL2E5QmmWGX1SXS62PguOZ9HkO+3foNl+SGLz04JgfWcE+MuhkAsyEbr
 49b4K5f4PEb4QxDi7NNLlrEoxdsS7BE2883SaS7ZwWG2Ttdw8aS/0f8zr+DnCbVQhr/NyYugDPu
 XjAmjW8304+Um7SqruclvfvYsAWSzMY3Q7in20f+AobJ5cPiUDE++ZP4ljbfJh2HdWVaO7kjO/W
 eLqlVOeYlalEckgsbT0tQ7Cs5Zm8A3Y6bPc+TdIjMLqxYnhhE6UD8b8Tw7zqZk1uFXtQ19hiHVB
 cIjyLvW/I/s=
X-Google-Smtp-Source: AGHT+IFXaJbM4rd9xwVhVUeBGwCfW3a2Dk8U809NlWgevFrMAkBwhmM69FjmQQKYLyuTM1fld1b+mQ==
X-Received: by 2002:a17:907:6d22:b0:b76:5b73:75fb with SMTP id
 a640c23a62f3a-b8036ecdbfcmr2723198366b.9.1766935109080; 
 Sun, 28 Dec 2025 07:18:29 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494cd7sm28502224a12.16.2025.12.28.07.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 07:18:27 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Daniel Golle <daniel@makrotopia.org>, E Shattow <e@freeshell.de>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/5] Add dumpfwumdata tool for FWU metadata image
Date: Sun, 28 Dec 2025 16:17:50 +0100
Message-ID: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

This series originates from the implementation of the A/B update
scheme on a custom board based on the STM32MP2 platform.
The addition of the dumpfwumdata tool required changes to its
counterpart mkfwumdata in order to ensure code consistency and
readability.
Finally, I considered it useful to enable both tools in the tools-only
configuration.


Dario Binacchi (5):
  tools: build mkfwumdata with tools-only_defconfig
  fwu: centralize bank state macros in fwu_mdata.h
  fwu: use FWU_MAX_STATE_BANKS for bank_state array
  tools: Add dumpfwumdata tool for FWU metadata image
  tools: build dumpfwumdata with tools-only_defconfig

 configs/tools-only_defconfig |   2 +
 include/fwu.h                |   4 --
 include/fwu_mdata.h          |   9 ++-
 tools/Kconfig                |   7 ++
 tools/Makefile               |   4 ++
 tools/dumpfwumdata.c         | 128 +++++++++++++++++++++++++++++++++++
 tools/mkfwumdata.c           |  10 +--
 7 files changed, 151 insertions(+), 13 deletions(-)
 create mode 100644 tools/dumpfwumdata.c

-- 
2.43.0

base-commit: 56cac250b0839ddbad1311d3ca4231f532b5aadf
branch: fwumdata
