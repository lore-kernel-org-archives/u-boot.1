Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AEDCCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 16:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F326A83678;
	Fri, 24 Oct 2025 18:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UtNOrBks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1705083678; Fri, 24 Oct 2025 18:06:09 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A120836EE
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 18:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c3e26d534fso1584284a34.1
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761321963; x=1761926763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LUXp/oDdNK8aJUSAhFkdlpq4fGvZ/vVEWePcuhl7m8=;
 b=UtNOrBks41+O7/NFV3NDC+n+iP0Vd0ZfnMB6yz7EbxLeZVCL3JhdVTd0jbo/2eAr3Y
 0vq2RDlTmvBnh3NSfwcO6R+YDYiFl51AwY2p6h5tR6q1B8UxSbGSK1m8RL07/cEzQUIX
 gtOTiB6ZMched19xAZmma9V9DuEoh02STLOME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761321963; x=1761926763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LUXp/oDdNK8aJUSAhFkdlpq4fGvZ/vVEWePcuhl7m8=;
 b=UwerCK6h48bDQWNJV6t/IsolyQXyHZMZzce3A6gQMT8dCtg3A5FVcTzhXdNueZQbXI
 J0dE+yl35Ja5v6AxCKBuGIeJbhZJzk6X4VvyejeBPtjQAZEStWYaunqVwMUwTYQJaQmh
 daDM1lAXH8bppMGLPBDkVlDPrJFSWLkS0ucBW+5K92XeQyg/8Orkj4Q7sYe6+phn87AJ
 zQ0+DoU54B0WwneOih6WvEly/By0zgliOicF5toGycm0kr0vNzXFhwVIe3VxeM9nx6o6
 nq+GTP5PY5ZItqdqGk83pLcMEQPTu87IYygg1Au7HlFZz8h2jvWMg/goFK4xpdXq+/rQ
 wJsw==
X-Gm-Message-State: AOJu0YxNbdVhi792Ott9LUIo1F1Zwjatg8Y3/SyfM5Zlka2b17mZ8ngk
 xnTIC5i/76CszknuBigr1f+AWmuT885RS6/lYsYVyZsRVVXJVfcPi0ez3mipzcNnM5KKkaZAi/u
 dBWRQH3UO/w==
X-Gm-Gg: ASbGnctN/eOdeSP5rElz8rBeIBhfXQ9PDgmXPT+A7+BMD+07MIqPDd5IGpXv/Rj46OQ
 157qi3nKXC0RijSrw8IsXMJJK2QKeLGZYD6LrRqDR9+Cox2G0yXQAQqVKW299bWM2excUf2buFX
 b19rQoCs0XpHu3MXJQfVDIZjfUTe6v9AuJWdPip5Ykl8EyzSHmSoxoKa2B6zWH6bwo2SiglkkGr
 K2MncjfHlJtJkGPRoEuflIshQ4MRpnKyOeKtiyE3MOx5iDGmZfOMxttxDmQwJVS3o0QWOVCcrCh
 CeOCyL+52FkXgxSmBex3BwKBQ4PhF5e+8hiAMsEYTJz+xBJ8Vre4791BYJctBeFCu5Bk5Hns2RT
 4nikHZUvkYyjex3Dw7rsOTMbalFmY3hOiC9aW6M0e53+hHoX+IBdSHDDdt1la7ChXIVA8Rp5Njc
 6aV6G96uU3wMYROoA53wE2YkxPQL4OoqullIVYfQCa1g==
X-Google-Smtp-Source: AGHT+IEA6F2QSqQ0x62VdPMTJKVoSFj2gNNGV4q0LzxiiO0hB7F+dQmmREpFCy3zACQbqhrX9/+Dww==
X-Received: by 2002:a05:6808:1a04:b0:43f:78ff:65ec with SMTP id
 5614622812f47-443a2f17ca6mr11792998b6e.19.1761321963196; 
 Fri, 24 Oct 2025 09:06:03 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654d7fb99d1sm1250225eaf.9.2025.10.24.09.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 09:06:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 3/3] doc: seama: Reword return value section
Date: Fri, 24 Oct 2025 10:02:59 -0600
Message-ID: <20251024160557.2317081-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251024160557.2317081-1-trini@konsulko.com>
References: <20251024160557.2317081-1-trini@konsulko.com>
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

With the addition of general text about how the return value is handled,
reference that while retaining the additional information about setting
$seama_image_size

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/usage/cmd/seama.rst | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/doc/usage/cmd/seama.rst b/doc/usage/cmd/seama.rst
index 17fd559f4856..a6b00f32902e 100644
--- a/doc/usage/cmd/seama.rst
+++ b/doc/usage/cmd/seama.rst
@@ -56,8 +56,5 @@ The command is available if CONFIG_CMD_SEAMA=y.
 Return value
 ------------
 
-The return value $? is set 0 (true) if the loading is succefull, and
-is set to 1 (false) in case of error.
-
-The environment variable $seama_image_size is set to the size of the
-loaded SEAMA image.
+Along with the general rules for setting $?, the environment variable
+$seama_image_size is set to the size of the loaded SEAMA image.
-- 
2.43.0

