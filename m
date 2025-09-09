Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663DFCA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 18:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49F883290;
	Tue,  9 Sep 2025 20:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IFq/e5q+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 949728319C; Tue,  9 Sep 2025 20:31:45 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8990F83257
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 20:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-88432ccd787so435302939f.0
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757442700; x=1758047500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wf8uAmX6vos6pyDZDAAIvx/lViakGCvlOxCcP+J3rpA=;
 b=IFq/e5q+L6Bx8wX9W3HQE4j32X4w5ir9JFCVEG7ewz3EVEAm3nkW7C8dLuZgM+/FFA
 c3sFVfyR0Y8b12zG5xjdPh3fGAhHW/55YACTP/MZxGgOUbvrr4OWEo+mypYXEiTuj1Mj
 z0AFk3AFW7dikT07JgQO5O0ztd4QHb9Y33y90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757442700; x=1758047500;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wf8uAmX6vos6pyDZDAAIvx/lViakGCvlOxCcP+J3rpA=;
 b=O+fEdvlvrsAI07Aa/BsEU5YpNKnRFdM9dHU9IxCoOq9lKKGexdWi++YFxdYeRJlzFO
 uVwMiGrUk0DiQRPLwCy1o0Z5bSkx7rYYE0tQO5vIGWZwTN+CWm8BY11VLNdV8YQAhU16
 d5KAByf5u/n2UA68CuVY32rjzG3UU0bkFz3fdeyxAnpobRwNCzH3Z5Z8h1jC7cFrym6G
 +M5agn0j4xkVXGgd51BW54f6Vn06zxW00x3nXpzvEJahYrysRSV/AmSou1O0AxHV81O8
 t8AbDzKdPZpKgGz5d2ToRmSyC/rXteb9b9i3coCgMAABnTXiMf8ZGxgM/4Gu7eneqF3t
 RHLg==
X-Gm-Message-State: AOJu0Yw54dvGVtspTf0c2V+1FjarGsYBlkCM2RiOvnSkFSBZF9xVLwh5
 GboOKTMG6h0PckpyJjZOWn+tALV5Z1aexApEfoMQ95YaPQ/OP+r96rKC720RABA3yNs=
X-Gm-Gg: ASbGncuocepp8hT/evo7VQb1VY0NE0WlCPRCsXKbLdFChRCBonFq8sVzdmUpRFEAN6w
 up8U1LRrvS9DVU9kvpCwzgTnFemYp2z1es+e5vxeHKufW5M/9jhElGI4CbvHntt3XYVte4NtdiH
 M8JyZNzNsfvexSWwbql8tOzUOBz6N05DXX9aYWM1mN5JdgzE/jIPT4oelqUoZtldHK3Y3FiHpNe
 QrC/3EmSQb1D6gUTUnJfkfKVq2BcaL6Fgfr+P4LxFquStHA5qTlcDkl2PsAi6a6vNwrAO9gOnFH
 v0j76jYcQdBQp1aaSCp0QdBjBVuZX0IlKVe9VG4QhQyYoMLZxsGOodqfdG330u0GjgUPRMT1b1o
 +lwNrz4N/N2IZlkdEGWpMjXQnDCY3uN3lTPdcuXm7rn54rBZGlY4DdNpRZSBIcUyMtQ==
X-Google-Smtp-Source: AGHT+IGQGpBT8p/fR7sLXbf5SZWN1tumrp5PIxK/7T0eOMdW/ZFmQgh9J2AiSBE1whREpxX0nAum9A==
X-Received: by 2002:a05:6e02:148e:b0:408:3b68:3902 with SMTP id
 e9e14a558f8ab-4083b683adcmr105523485ab.8.1757442700248; 
 Tue, 09 Sep 2025 11:31:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-403c8eb8884sm32715295ab.33.2025.09.09.11.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 11:31:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <ae9c0d66-01ee-4d58-adc4-66ea36e62cc3@siemens.com>
References: <ae9c0d66-01ee-4d58-adc4-66ea36e62cc3@siemens.com>
Subject: Re: [PATCH] tools: Drop meaningless comment from Makefile
Message-Id: <175744269935.1809471.9685766944217102588.b4-ty@konsulko.com>
Date: Tue, 09 Sep 2025 12:31:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 23 Aug 2025 13:29:49 +0200, Jan Kiszka wrote:

> Introduced by 245b1029e1af, probably a debug left-over.
> 
> 

Applied to u-boot/next, thanks!

[1/1] tools: Drop meaningless comment from Makefile
      commit: ae84ef8c625f6454747b5d13192e1a16649761b2
-- 
Tom


