Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2978C982EE
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1958399B;
	Fri, 16 Jan 2026 19:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q9IdHnpF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A3278367F; Fri, 16 Jan 2026 19:23:45 +0100 (CET)
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com
 [IPv6:2001:4860:4864:20::43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D681A8367F
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-3f9ebb269c3so1309914fac.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768587821; x=1769192621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nt9wS3KStcnq+7Vl7NdPU6lP0DthLpbaeVYte7k6zf0=;
 b=Q9IdHnpFlfxSIo3XV4WPGR/UraHDEUoVCRy6G34JBsEEGb/J5MLgNjYMdlWgJeR+6h
 v5n2rsnVW+ATEXGyvdNTdr3XOJuzGRIHGuzLPYjrmppJYxf+FFrkZmBjCxaxR95Mtbx0
 xg5fF/tpaaYFfPbNpi50pPiPHcprcxGKkAS0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768587821; x=1769192621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nt9wS3KStcnq+7Vl7NdPU6lP0DthLpbaeVYte7k6zf0=;
 b=Xx4N5bolrg9zQeLCNeNmkGIhOfFPb/hC57bMEy1aliuc3vaEZEV8GHN8FYIEC4e4SA
 azT+mn3Mz6IehV/YiVTAkmzVOcdQxSGhBl2ZH1lZoQ8hTpuEpRmWwPJdxZWDYM2xh/ph
 DL+Cuz7jVEAO9K9y4UTsljTB9Ikm18BkO7eOreRPMGKzIW4seSCrA/CShiG4qIGPJiks
 ae7KvbxyE7MjxZidb+Mz2CHy5v9e9M+0zHN5oLj8xycSPvYsJYVEvsfhC/ZuD1DNk+Ra
 3TIDYbK8OdKpRFmpsoD/KP+wzp48LlZULGV/yKxFMX4nXMBYMGnPCsT7UmMIfjKT42tN
 fPjQ==
X-Gm-Message-State: AOJu0Yw3AIDvW59s8GqwPsTy8HjrmJs99OGiqc8H5Cvy2Ltl3TtKz/PM
 /K6QDDB/G01O5utLvrtEWCmN6nEfWwCFgU9CJvcwGgzA7CDvPpx/DrT7EpiATaONJFZbJagjGHt
 roPHuwU4UMg==
X-Gm-Gg: AY/fxX7cC0wfn6iSOWdnzSceDmAUBa7qg14lRtzlehaIvc0E7uVgYYlZ6Ria8Z5RqOm
 Zqe4pY3nZyiWAJ23XniFK5HQ8vh0+e7NRs4zkuovRHv+lC31HmlXft3F2pv4UvmAPx6/tUVvQkM
 L1b9kk5P7vczw+qIjdn5mF/89PK6pae3uoKzVPH2nMJ5gx1mBou1hNiaGrCdGYfdy5o4wjD9jw/
 pZMGGkJyJrA4tBGl6HbKDn19QT5xETPFQpDhsYpM70zIiT+osqlDRik/nQ9oRmq/EToreRrpSnq
 Ym2NlCtAivmJeow1t8yLfyCLxMgLzMJY2YstkRv3Zk40bs8kJLNB7qITlynqsXZUCgeh4xTV5EQ
 HwIYAZqcuB2nsAM4/Vkmn9s9CkAXP1/soCKY/LBu54rGrGKgKHO/WvI87QehHbstrPj8btfOjPJ
 +IuPMaifhXr65xXE0OWDaAIvW7BzPmyNasr81yHFWR5Plzdykk48EWyYh06Fy1iewnishYz/hUJ
 YYJDMG6UtZwNhUABGQpx8BPL1N3B4gH+wo4LX0ILlEoZMiBwHSz
X-Received: by 2002:a05:6830:6d2f:b0:7cf:dc2d:8508 with SMTP id
 46e09a7af769-7cfded3d668mr1920115a34.1.1768587821652; 
 Fri, 16 Jan 2026 10:23:41 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf28ef44sm2152994a34.18.2026.01.16.10.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:23:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 3/3] doc: develop: process: Explain when/how Custodians may
 edit patches
Date: Fri, 16 Jan 2026 12:16:50 -0600
Message-ID: <20260116182335.4081828-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116182335.4081828-1-trini@konsulko.com>
References: <20260116182335.4081828-1-trini@konsulko.com>
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

As seen with commit d503633a3676 ("Revert "doc: board: starfive: update
jh7110 common description""), it has not always been clear what is and
isn't allowed by custodians, and what the expectations are. To prevent
further unintentional conflicts, document the limited cases where
custodians are allowed to modify patches directly, and how to do that.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- New patch.
---
 doc/develop/process.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 6f5bdd3db957..775a855fd7a0 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -144,6 +144,12 @@ feedback to the submitter of a patch about what is going on:
     feels it has been too long since posting their patch and not
     received any feedback, it is OK to follow-up and ask.
 
+    * A custodian may make spelling corrections, spacing fixes and other
+      obviously correct trivial changes. They must also in turn amend
+      the commit message noting their change inside of ``[]`` and add
+      their own ``Signed-off-by`` tag. All other changes must be handled
+      by another iteration of the patch, or follow-up patch.
+
   * If the patch itself can still be applied to the tree. The custodian
     is expected to put in a "best effort" if a patch does not apply
     cleanly, but can be made to apply still. It is up to the custodian
-- 
2.43.0

