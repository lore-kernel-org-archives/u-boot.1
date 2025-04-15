Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53134C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 12:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAFDE82AF6;
	Tue, 15 Apr 2025 14:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lUkcFGZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9529E8209C; Tue, 15 Apr 2025 10:30:24 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9911E8056A
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 10:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brunosampaioleite@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3104ddb8051so31907671fa.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744705822; x=1745310622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yA8U4jcHBU1qLoRd/hi4ojBgCldiyI08upRnsxT8iN0=;
 b=lUkcFGZtjkGu/fRQH9lVzXieHfx/bCHCksS0s4GW6zTJ3OZBd+RVmaSyX4I6Y8DMjg
 sck+PvT01tNCPLgi3OPr/r0u3kdFDRE4SNirSnG4uZQLOKf8VSBnGIu/daE7nIY2MDu/
 RBuYasyY+z8AlroOz/O2I55uJxgqPKRTbQUW2NTT3lt+p/cGxrW5zzfLN051TrQLtr1d
 4wEiXkQF6WBS6CmBY7UTZx5oAZ+cc0/Fr23QVw9XJxSHF7VwixTGgB4rjgz9B7Y0yHJ7
 cGO+4XbqHJqwJl12a5IdFqg5KL+/2nVkbzWhmAji/Kd8X+iDTkxlFZuFl3+Pu9Loo28I
 jjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744705822; x=1745310622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yA8U4jcHBU1qLoRd/hi4ojBgCldiyI08upRnsxT8iN0=;
 b=p1ufip2fQ41VzOb1oiQqG1qcIFz4Bu+uv1A2DpfDBqrY+3+yF6kb/qYINfEw5UCnv0
 /cec2nAI8n2GLblIWk9dDKwK8beNC1/hwVn7poqu9MhoMDvVeaZv9OUvJR9WEpu+MMW/
 SXunhIdOWOjKZuCVVqqfzNaLCo+mB+J3it6/4j8B/maVCryqQGxfGagn8tSJS7Hi1jMO
 jBBL4uws/WpONFgqidXqXQ/nYpTNqmRhO30hDUVcw4vQbSk8frSK9jMYtKfgOxVZTbb9
 C1B+/Sk+B1ejmv1vx8N64IEC1xbpmNe8/dMfzRfGhPu8xn2cZ/TYrAo0MChkiVC4l/Tm
 cVMg==
X-Gm-Message-State: AOJu0YxsfJDuKLQkwcEQEU5dJfmNNWHDZIkTauvf+7O9xdh+YFV14cMd
 IPHb0DDClpzr3d07zWIoisNn2xECe5R7E6S2ZnNxyMVFL6xroz4H/kgxtBYp
X-Gm-Gg: ASbGncsxgxMzHQHN3trLrBwgz8oa3QqSYY/mbh3lLbwMVqSnx9hOKwAPcBS70oTVKBX
 Y9jotxLzo8739PnrpKqU5YDKoaubktwzTx50cXUTLnulmykxacEDCFq//FkSY6A7nHdiCk0qCTD
 yOlTL9PbrnemddTYDwDI13HAqdN+GRBaZQN86+JwpmzZw3HTP0O0okwLv2Pnt+eyGHoVebCO+cV
 GBFIugz8J1gLJbdVt3kJ9Gyi26YACEgX3PMLpAJamdmekA6ZsaTZZwhNr0m6WvCxS5h8nGwYMN5
 Tiay1M5MRai2JIEQfZiyor5n4obKbhbou6KfGD/4rjDBpN03KDh+8t3mdKyrxAsZeCU2CINdwg=
 =
X-Google-Smtp-Source: AGHT+IF1E5Iqij9wcx9h/iWPP4PEQGjGirLDWB4HMug7+VeW2gM5p2ioAG1u0po1YgUhHBm0erFNFA==
X-Received: by 2002:a2e:a5c9:0:b0:30d:e104:cd57 with SMTP id
 38308e7fff4ca-31049aba5b9mr46742341fa.40.1744705821325; 
 Tue, 15 Apr 2025 01:30:21 -0700 (PDT)
Received: from brule-Precision-3590.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30f464cc0a2sm19679971fa.31.2025.04.15.01.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:30:20 -0700 (PDT)
From: Bruno Leite <brunosampaioleite@gmail.com>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, Matthias Brugger <mbrugger@suse.com>,
 clast@prevas.dk, ravi@prevas.dk, Bruno Leite <brule@prevas.dk>,
 Fiona Klute <fiona.klute@gmx.de>, Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martin Stolpe <martinstolpe@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/1] Fix RPI5 uart clock when loading kernel with non-boot DT
Date: Tue, 15 Apr 2025 10:30:13 +0200
Message-ID: <20250415083017.3523317-1-brunosampaioleite@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Apr 2025 14:50:26 +0200
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

From: Bruno Leite <brule@prevas.dk>


When loading the kernel with a DT that was not used to boot
the rpi (e.g. when using a FIT image), the uart-clk property
that should have been patched by the firmware will be passed
as is to the driver and thus cause the divisor to be set
incorrectly, hence the uart will not work properly. Fix that
by copying the correct uart-clk set by the firmware to the new
DT loaded to be passed to the kernel.


Bruno Leite (1):
  rpi: copy over uart clock-frequency in DT

 board/raspberrypi/rpi/rpi.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.45.2

