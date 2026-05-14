Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C388ECD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 23:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38FAD8464D;
	Fri, 15 May 2026 01:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rIptkBIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6CB1846A4; Thu, 14 May 2026 20:20:44 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA3684687
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 20:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso51809025e9.3
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778782841; x=1779387641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgmfv3WxPsswfn3OpFM+x1W6RSzPAjdGt228EsTxFz0=;
 b=rIptkBIjjeXY4GsVR9ltAO841DXD04OBoYqblSnxQfQQDibvvrmNzOqsY54Uw6j2pt
 kTPKeqCEYNG4w17sBCVeM7Nq/ALfjn5JD5feU2+wSu1FAgquoZYc0RIcXcs5Kc7iyO6n
 XaK8Sbx9Kji4OQtWYxRfH8KABFgQ6aJ0Hh7qzhDBkl89Clqo9bXrx5PvpRHZ4DLZ5cWS
 vdvfxDSPsve8j+aECGXKw+QKSJ1e77bFiETziuMxJLbPQL0bIUeqYfr9ZKst4GH373VN
 b7VpWkIRE8+/ITmVlXeB7izAVz3Mf6binKjAzpVCzbIAM9ktTdXISWwEE6t/cgwSuw7p
 RPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778782841; x=1779387641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zgmfv3WxPsswfn3OpFM+x1W6RSzPAjdGt228EsTxFz0=;
 b=GqRer7hcN8shA5tnfojprzS9OYJ0NXN8ZXhf1xVJZLeDGfLm5yj5SOzqUnQeCJQKMx
 U3SO9FtvMXrcZIVtUTCwg6o69zj01F3mtn5Kp0KuGDGpZxHHgrlfXPo8ygd/8giKNsQp
 EyF5bJEvqsbXlZJNO5MIdYmrPVA8HA4lmSrND74BlUuISnQOBk4+L36eACzLuw/4UTuQ
 OPZNA7cidu50IohL5VZGJLOgX5N1cqrfewvADXq7HmkhTItexaAAoWbs4R37ghknMtJU
 /NUS487NaMBTcj9guDelIZT4mpWqK8n21Q8YLad8WlWfbgIDR/8CI/IK9GxVfkBn3oAQ
 CMDw==
X-Gm-Message-State: AOJu0YyOF27XxF6oyzfJTIcWH3/Dp3hlXM7oCVSLgcXjTuryAtshUC5a
 rt+QHVEl85HFDCSdJLDNmCSJbLjBZpg3w2Vk6BgFXcZJp+zesbDAQ+5aoWdYywfCDLM=
X-Gm-Gg: Acq92OFC7ukKsEqZUaKdmoVHzY3Toz0k6LqMmEwrl7XIGDjrwdgl0lHxy8m81RTLMtG
 ZL7CpEvJLihyMjiUrKuTKOFBUXKEuSTsBaKsTpMaAsNw1ZBWJNXS4kvnwQYhsG3R5EY0zYTuV1C
 Ez2mNEX5Wc0uy2kgormsDkRyP+C2W3lLjJRjMIpsgLY4AIhk9pawzhYFGIACwEqNVzQTSvAw2u4
 LwIO0PY8tMnSO52TEc9oIXTX+LPPu+Ck5DfhHUqc8OfxEiLA4kxYEJT7R4eiiykKNFHajIEymwL
 hZKXY7FmgJrzFKRqOidxAZONQcI3VqpCVME/0ik9tqVXpnm5fUpfWu1ColPr6S++hb4nkrVik9Y
 +nYaxk7OnV8afOVZ7Afz4wLQt/Z7mzo+fjiDv22GH2qwAFxpnGtZHu2r0+qr92qmoY4rJ3BYkby
 nU6ff50+n7XkgSLYnNRb9CEPtGp6/3db+brgHSTzniSaFgAy28hCVsyhwhzOJepWd0s9zmCx1za
 FlBxE/eOo27zcXcg17+AWsLWR8Yw8XUo58Y8Uwr5VQm3KMiTqloXsA5f61GIn3oGFpqDHufH2ce
 RW0h
X-Received: by 2002:a05:600c:858d:b0:48f:e230:80a3 with SMTP id
 5b1f17b1804b1-48fe6514c31mr5473445e9.33.1778782841232; 
 Thu, 14 May 2026 11:20:41 -0700 (PDT)
Received: from thinkpad-t15g-g2 ([2a01:e0a:905:5c10:111d:8a59:d7b9:c8a9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53ab773sm7973575e9.3.2026.05.14.11.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 11:20:40 -0700 (PDT)
From: Allan ELKAIM <allan.elkaim@gmail.com>
To: u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Allan ELKAIM <allan.elkaim@gmail.com>
Subject: [PATCH v1 0/2] fs/squashfs: fix symlink load failure on large images
Date: Thu, 14 May 2026 20:18:50 +0200
Message-ID: <20260514181854.399679-3-allan.elkaim@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <"CACgNL-F2=KJtZ+gThpx_BuWsn6puqFxK0uLOmnABSS9=rRQmeQ@mail.gmail.com">
References: <"CACgNL-F2=KJtZ+gThpx_BuWsn6puqFxK0uLOmnABSS9=rRQmeQ@mail.gmail.com">
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 May 2026 01:39:52 +0200
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


sqfsload fails to load a file through a symlink when the squashfs
image contains a large number of inodes (e.g. a rootfs that includes
the tzdata timezone database).

Root cause: sqfs_read_nest() resolves the symlink by calling itself
recursively without first freeing the parent directory's inode and
directory table buffers. This causes a temporary double allocation
that can exhaust the U-Boot heap. When malloc() subsequently fails
inside sqfs_read_directory_table(), the error goes undetected and
sqfs_search_dir() is called with a NULL pos_list pointer, leading to:

  Error: invalid inode reference to directory table.
  Failed to load '/boot/Image'

Patch 1 fixes the structural problem (temporary double allocation)
and plugs the silent NULL pointer path in sqfs_read_directory_table().
Patch 2 adds the missing return-value checks on sqfs_dir_offset() that
turn any residual lookup failure into a clean error propagation.

Both patches are independent and can be reviewed separately.

The bug was first observed on U-Boot v2024.01 and is still present
on v2026.04. The patches have been tested on a Raspberry Pi CM4
running U-Boot v2026.04 (Yocto Scarthgap 5.0.17) with a 325 MB
squashfs rootfs containing 22 517 inodes. The symlink
/boot/Image -> Image-6.6.63-v8 now resolves successfully.

This series addresses the bug reported at:
https://lists.denx.de/pipermail/u-boot/2026-May/618533.html


Allan ELKAIM (2):
  fs/squashfs: fix heap exhaustion during symlink resolution
  fs/squashfs: add sqfs_dir_offset() error checks

 fs/squashfs/sqfs.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

-- 
2.53.0

base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
