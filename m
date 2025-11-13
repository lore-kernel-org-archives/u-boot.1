Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9CECD98F5
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 22:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEB028406D;
	Thu, 13 Nov 2025 23:10:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RXTDxpO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 095568407B; Thu, 13 Nov 2025 23:10:01 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E327384064
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 23:09:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c707e11e01so1379836a34.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 14:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763071797; x=1763676597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qoaOsPe+HhSGnkjavoGm17+q0dy+W9CS9lcJtQD8OD0=;
 b=RXTDxpO1Zr7SLb2eoS6mS5wkAfLmHKWxLkcwPozrK6DagEQ8mMpwzI1cBmGvcHJzxo
 kXSCYHnnr73EyCJPrfElujqJnHIBRdKOMjTl+8WgfW8iNs9mVo2e7YIP0ZA1n4Ldmfmt
 ZsuqSGH7OvMufLG4TviMW3lcsg4bBPGjD913c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763071797; x=1763676597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoaOsPe+HhSGnkjavoGm17+q0dy+W9CS9lcJtQD8OD0=;
 b=q4QsVyyFf8FFwAgRp67q0gGR6S7P0QrJAXV0oQ9AIS40izpCcDLH8VM41WApSpDulK
 6B4QIcdxPSpuSfjhMljMEl1h0bf6NGe8McAbG2kdB1fbDgqPiZZLQb1Bn0HmDgiNM92S
 wNB929ASXPAh97Rw/2+l6+PuoYnpuuOorMuJKs3IsNEAOM+OXoAuQnbFR3pBR9hrMzIq
 klVL4/TOYAfXe0C62EZ2i0KCqf/+xvC+U9opI80+MHcKQb6e5tlayh3Sa2HHoBZ1Yn78
 dEZC0MuN2EenbTOUfB/hFoVwj1Uuf8F/7MVk7BQok8Qp2Q/CeYrtlJFTHI4Vlbj2GnSa
 VdHQ==
X-Gm-Message-State: AOJu0YxDNpdQKYVQFuT6yjRo54c/78EpKzqC1mi+tNx7z0/aiTzXo/DO
 qt1VZ4fVUyS/eTgOYyEVEwkrOpWNMDZWfPKZ4SvogDx3WD5nwst1ytqWAF1EHFevY9qp5l7Pcjl
 ll2DYwyDEgg==
X-Gm-Gg: ASbGncuLXzDekI/Cqr3mTlRXZsjNoKqPMM+1ze1UFVbyB9XtyCKl04KmWK4BntAjc3/
 HHhtalzYNaNqvuTYWpzUsHGy05BUEJ0w7qaNryom1QTXJyDgYg1z2nSJcRX2H/Ab+Dfj15BLBmI
 SGPkHMoQpVUx4vqUf3bBtFw8cNpd0REEhRyEorhmHPGwQw0GLFpJPVknjqkVu/5EPYuWnpoCAgQ
 QN6oH13aKsKqmhKrzN5h9s2H7ngEGbWmAUGDu3TYTMKypSosfoDTwHIHBWlhOKmZUdqtW7VKWtw
 qFYCY9JCJ4hYnZO0dZZUayxNXZIVIKAAudFHW8NUcx34IsuMElR3hv8uB6rIIIznBTkbTcJMEHv
 9n8K1NytdS9B3FbdihWrXHuCfZGWYrFEJlPH35f5ViYCpxhCfsRnTHRrnJB42PG5pC4Z9kT53EW
 hIdubUaTitl1DnV+ME0mB1fdzcwhoCTtfVYE1sNPCXFcpfxfIVWszl
X-Google-Smtp-Source: AGHT+IFTZ+mo6xU6wWVAY9PnAELKYVX3IvoMvJFyrZnwz5TZCAy2ZTCm/O2SjnmgRhXRocA3X6yruA==
X-Received: by 2002:a05:6830:348f:b0:79d:eccc:96eb with SMTP id
 46e09a7af769-7c7445d6dd3mr850314a34.26.1763071797752; 
 Thu, 13 Nov 2025 14:09:57 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a29cdd8sm1881275a34.11.2025.11.13.14.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 14:09:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCHv2] Dockerfile: Include python3-tk for FATtools
Date: Thu, 13 Nov 2025 16:09:56 -0600
Message-ID: <20251113220956.1833225-1-trini@konsulko.com>
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

In some cases our tests for exFAT don't run because we fail to be able
to create the underlying image. This is in turn because while creation
of the image succeeds, it seems that some way of how we invoke FATtools
wants to import tkinter, that fails and so the test stops there. Having
tkinter available (and then presumably a fallback to non-GUI because
it's not available) leads to the tests running as expected.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Alphabetize, per Marek

Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 tools/docker/Dockerfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index d2384219c06a..91edd22918b4 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -126,6 +126,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	python3-pip \
 	python3-pyelftools \
 	python3-sphinx \
+	python3-tk \
 	python3-tomli \
 	python3-venv \
 	rpm2cpio \
-- 
2.43.0

