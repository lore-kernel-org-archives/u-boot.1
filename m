Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1D8C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 17:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0526E82E76;
	Sat, 24 May 2025 19:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NjMCJosE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9634582CD2; Sat, 24 May 2025 19:07:30 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F1183600
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 19:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3dc82baf4eeso3342445ab.3
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748106446; x=1748711246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpKKwisZFraaydWNT8vci62BEuqeaxnIo5Y5PilqLeI=;
 b=NjMCJosE9Avn81dppepM2aI4xG0CPEEe5CNdaLFQY7Qo26hAzRxKm09ih0MDzkv94J
 1GFJLclWqEjyOHrclWk/iPvimlvF+qkaX8+ngA6wnHU7OJHi727Im1SItoer8+QWaIZh
 UVhp4G8VvG1XVUBUzPH/CLEy+uoOwzIgSWZzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748106446; x=1748711246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpKKwisZFraaydWNT8vci62BEuqeaxnIo5Y5PilqLeI=;
 b=v1h9dH3iQKl7vnLyt/u/H5g/ubUY8J3olNOkXx+0IVewmSZSo7WN+sVPKZV+sFTZE4
 K75YlOGEq3mN5UGUeatpm2DdOyoNPY9GjQaz8/xWAFCVLX6pWRSqs2MwbDTI1o3kltvz
 /mH4ynmuxpMjk8Z+WKYqFAmvRu9g3lU68dP1kiHihOJH7GKYUD9WzOWvpPtyGjutY5iA
 7Eyzc3giACAFYKFjDdVhfOiLa39AJ2umYl5HShQtUlrS04ZgVH5u9IzBOWZWlKtmNDwT
 Y5IkL9fnq0WaoH3WB0aB+87J02psU3h4ObcG+FNVzWY6sUhdzGCcqr7QvjtHCl9DhGHl
 kEdg==
X-Gm-Message-State: AOJu0Yzi8f23iXAB7FkAI5t4Bqinu6UuWuAbk3zt9MTkmX7LEEk1s9OT
 e6ZnI5VHBZbdJ0z8CX83AtQCao9hX2x0y3ivYheao2O+XLkBMu2Rv1y3q3eJl5DwquZ45OVcNZ3
 AlNAKpgol
X-Gm-Gg: ASbGnctREJUIk501av1lO5Ke5qo5BHwHoLwVZ4p/0NqQ+W2/LGLwW/EjUpltAiPI5MT
 QY4bFE/8MAJ+ObCbOcpjpiy7HZ9tJYoI20lMEVEWN3xZfC2K5Z0DKVK8lCfNasFFblRwwUmgh99
 BaMVCPJQci2MvCSi9NS/+ggeyEqpK7T1KAKz6bewdCLEXJz2AHx/ruhFh5rIg85FWDob7VrbI+s
 nhqfY36nE5ytB0cupuWQuRXsRf4VPxesrxsSZ79CmLi6wOUEjjGS3tsrCxnLbi/10sUmsk2vMgq
 waZscKrCoS+ANnelApyf2+uDHGJmlQ6ranOxjJB+6ssO45k38QpTbwNX2ML9a3aYoVPo/g6NwHA
 DXNzk09N8SK5b
X-Google-Smtp-Source: AGHT+IHZiXT1//gh9H7GyatyUkUp8kcFmuJXxZ4jcqXCFK4XtwUlW3h9ME/fGlIdAG6KiGtfcYmU4Q==
X-Received: by 2002:a05:6e02:2193:b0:3dc:8667:3425 with SMTP id
 e9e14a558f8ab-3dc9b70f000mr25831635ab.11.1748106446710; 
 Sat, 24 May 2025 10:07:26 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc9e7d18c9sm3940355ab.53.2025.05.24.10.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 10:07:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/7] patman: Support autolink when some series are archived
Date: Sat, 24 May 2025 11:06:55 -0600
Message-ID: <20250524170701.1238642-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524170701.1238642-1-sjg@chromium.org>
References: <20250524170701.1238642-1-sjg@chromium.org>
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

Archived series currently cause an error when autolink is attempted. Add
a check to avoid this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cser_helper.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/patman/cser_helper.py b/tools/patman/cser_helper.py
index dd2cfc5cbf0..ec44357c252 100644
--- a/tools/patman/cser_helper.py
+++ b/tools/patman/cser_helper.py
@@ -495,6 +495,10 @@ class CseriesHelper:
             # Get a list of links to fetch
             for svid, ser_id, version in max_vers:
                 svinfo = svdict[svid]
+
+                # Handle archived series
+                if ser_id not in sdict:
+                    continue
                 ser = sdict[ser_id]
 
                 pwc = self.get_pcommit_dict(svid)
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: pate
