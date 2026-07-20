Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F2DC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 12:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E93EF838D7;
	Mon, 20 Jul 2026 14:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gxpojjTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F9183E76; Mon, 20 Jul 2026 10:29:41 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F2E80517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B40B3F601
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784536178;
 bh=aDrzEEc0y92aXQdzR+riV10FA6KYhAvTq/bnHcxiks0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gxpojjTSNIG1cCmbaCWgnq2X2lk4D0xZ+1LijaQ8DfcRrTnP8mLMpLjrof79Lg/jV
 NIDsn8ypVtMZhFjj+6ZBKr0xZ+7Y+QgmzY1Ibvyd5tAU1TXJWkOV6p6Bt7phqlfgaN
 5jCxz3p5GX0wS6NWjI/YfQT7W3Y5Gw6sbCUcB2kHiUxV5PFcnW5vRF8Kne7XojHh64
 +yQ1p1Eqq/3EtYEukztM1tWnwm8SIlGt8dZflOr9kjX1KIBHcITbmpDZBZtXimXwFq
 YEM0JPV/Y44HpLtCIkp1JScG9X8piJ0kCYzZJfcz3fgC/B1mKvKV2yxxmXBE865fF0
 6O5XjS2je9Sl0X4QjXJmi/wOOGizHBFVsIzj61y0LEJTtwvb/oJcE8x8jmoRGhaHZh
 GKHHXPWYUQS1Ccf+zZTo1y4w6qMZCX6qzIWMdqrMUX6eUf/W1urh8ZAzgNYrrWxxWk
 FztKyim4EMNMPpyFLi2WTVmQn1FwjPX1/3Fcg/dR9PGcyYt4dflAI5B1NstpF1Ld9v
 n88LDgVtCDsEs4emytoLxkgyVbZJZPzKRpAjYnAahPFTu0pfpwWRLQ/IGaeV1Xc2Ed
 LDhDLWxX3RKWzKROL78TdcPjdKK02LVlNaH5dlFV0crKxs9lbXQ5je+n1YEUS0DCWg
 EwnBRXMxLJDkftJGQWzKg0yg=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cf27789c79so46932465ad.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536177; x=1785140977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aDrzEEc0y92aXQdzR+riV10FA6KYhAvTq/bnHcxiks0=;
 b=UApCJWSaDJIndahC/MiSwpItwDBgmQlVP8MUvVpSAT88ZkIpuVwrWm48OOos2IzZeg
 ZWHFRDMaMPfindSXtvlNMHlJFXI7oKAnmM1N5iOOS1ZnrLqz2QdcVIJuEBUy4GHWluJx
 EDi/I5yYik3NDGTUyBtRv8vOQpPk1PbOy9GLj3T+P5FbRJMpIgzFpaU6tXm7XgetMsa3
 YopB2NQMqfC674QkHtTvCJBEnP7tivB1jGUsERrIkBpKsgOby6L5TVJWhDho+Op6KiS0
 KxuJ8XTAEYvJXhrQnF5UWqj6uQb1eTctxrsi7oHIILkwmc3jVwxeJbzVrgNga63x+mUQ
 fKUQ==
X-Gm-Message-State: AOJu0YxNbz9X45w+wR0nP7j5ynHJKbxKa49sVSyxXtZQsfQwzonFf+zY
 BH7iBgpzaJTZe0H1aGFFkAa3WTtFfPvIk3Xl72Ie60SplpzSl8wDrVrwFz7wrQzXISySQxYAPeM
 1GU8GLNek8TkYVka4Wtl5P3gFH4+MEZa5OngaDgqHfSMr4L7s1GF3+C13owc5qtYKZHIE/bqm7D
 mgPZk=
X-Gm-Gg: AfdE7cmxPdXHZP4+u6qcg71CCq0wqalAug+bfBcqwc+FCKmbjzij9OKNZ3QNMg+9553
 BtnzH4/1qxygpdhSz66HvVam/arLN0/tlX9nOwIcd1Q8K8Sh3AMe1dMhkv0r0FzFcqyvtHPaN07
 V+8eGEd/D/wFw25sMcOg8Fpqs+kgmnoEO4yIE6XmirqkdiyeyiDOAu23fxcC+KVUkn9j3M4Q5Ez
 HuTL1g64EhOYkTRRZs4byPPfcl1Rx8SHxDfR0X6SbPejs8BHeV21zUt4li/PQtfCcY0JWr2HvAm
 7H5YlHDSyAk3Li86A3Cj4vpJsaQ0SqJbq59bKL6LHzfamINagvRJrFF9nTXZFX2QmL/JCMY7Dit
 O7Ej9ohbM29lgxYg0z6Ctvd6FuFuH0qr+dTXsuQl3BGjn3psFTSjNwqZqM16Wyn1mh88=
X-Received: by 2002:a17:902:c412:b0:2cc:86a9:ebfb with SMTP id
 d9443c01a7336-2cf349b839amr150766535ad.33.1784536176950; 
 Mon, 20 Jul 2026 01:29:36 -0700 (PDT)
X-Received: by 2002:a17:902:c412:b0:2cc:86a9:ebfb with SMTP id
 d9443c01a7336-2cf349b839amr150766305ad.33.1784536176490; 
 Mon, 20 Jul 2026 01:29:36 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf34713fe1sm52975265ad.55.2026.07.20.01.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:29:35 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/2] cmd: nvedit_efi: fix default GUID selection for
 signature databases
Date: Mon, 20 Jul 2026 08:29:12 +0000
Message-ID: <20260720082917.2162-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714094902.438079-1-aristo.chen@canonical.com>
References: <20260714094902.438079-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 14:28:29 +0200
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

"env set -e" selects a default vendor GUID when no -guid option is
given, using a hand rolled name check in do_env_set_efi(). That check
has drifted from the canonical name_type[] table in
lib/efi_loader/efi_var_common.c: it knows db, dbx and dbt but not dbr,
so "env set -e dbr" silently operates on a variable under
EFI_GLOBAL_VARIABLE_GUID instead of the image security database GUID,
creating a variable that no consumer will ever look up. The command
also unmapped the -i value buffer twice, which triggers a spurious
"Address not mapped" warning on sandbox for addresses that get a
tagged mapping.

Patch 1 replaces the hand rolled check with a call to
efi_auth_var_get_guid() so that the shell command and the variable
service share a single table, and consolidates the value and name
cleanup on the common exit path. Behaviour is unchanged for db, dbx,
dbt and for non-authenticated variable names.

Patch 2 adds a test case to the sandbox secure boot suite that enrolls
each of db, dbx, dbt and dbr in setup mode without an explicit -guid
option and checks that every variable is created under the image
security database GUID and not under the global variable GUID, then
enrolls PK and KEK the same way and checks that both land under the
global variable GUID. This is the first coverage of dbt and dbr under
test/. The signature database enrollment happens in setup mode because
once secure boot is enabled, efi_variable_authenticate() only accepts
writes to PK, KEK, db and dbx. The new test fails at the dbr step
without patch 1.

Changes in v2:
- also check that PK and KEK are created under the global variable
  GUID and not under the image security database GUID (suggested by
  Heinrich Schuchardt)
- patch 1: collect Reviewed-by tag, no code changes

Aristo Chen (2):
  cmd: nvedit_efi: use efi_auth_var_get_guid() for the default GUID
  test: check default GUID selection of signature database variables

 cmd/nvedit_efi.c                              | 22 ++++-----
 test/py/tests/test_efi_secboot/conftest.py    |  8 ++++
 .../py/tests/test_efi_secboot/test_authvar.py | 47 +++++++++++++++++++
 3 files changed, 63 insertions(+), 14 deletions(-)

-- 
2.43.0

