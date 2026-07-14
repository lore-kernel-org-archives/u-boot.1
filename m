Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40B6C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 12:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C68E84D1A;
	Tue, 14 Jul 2026 14:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nHpL9Ehc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBCA084CE5; Tue, 14 Jul 2026 11:49:42 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC4884CE1
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 11:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 44C433F28F
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 09:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784022579;
 bh=pGsk66JZn1h/3M38flh1fnWe1C8ACxpKIAppWy/wXVE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=nHpL9Ehcy7ir8MqfC4RawgUpocdwWsKZ2GrayKkr+89fc6+p8lSOaKTGY15qEI4ff
 hIFlU6/26ktQEiOzWgv2tQvcAMh7b+ZX5If5myTj/gJ1ZUAI6jGfgcdbJE89Tcg/Ik
 mIOuPTFE4r82YEAZhe8hqoy0lUFmPhke4s8feHRtrpY5Aohs88SgrIYW1HQJbDZtID
 Uo6hn9AIHQK5QD3nQCXxkvxGC/wk/z0JwP/pp/V25bFlNV2c9MUAfi9dLJzcoEIeXd
 g7icgW1ioYRk+pREIjgaD/zM5fymqN7IWUfQ1OGVYcaNykVLlsdlXyw95hiGOl89c5
 AAxHHZ6ZI/9SMzdUUDJKYtrla+asa00VXxLw/4Sk63syb3r3phZwB4JiSxWVUgkjPY
 pV0ua6zxZEjrgNQ51iGEvg5cV0Z9rhYlFGVlJQkQARqCf+rDydWUV5WKqLFCii6QXR
 kNjtVahXf3I7KFkloDsmRtfYMaHjKvFDYQLvEbfK/uL/jrE5SO9Bvr7+hg7CH2+HBh
 t84yBspBmGv6tjU01ZfkftMcy1DBiVq85fU6uS+7yhiSa6TmuKRLDuIbwXR1SofOTz
 GpPt0h8cv++ftSnySxjnSYo7ryGjhER30AyNYA0gyWtvGo+bCP6z9zeanQutLXou/N
 PUtsmbxpcX/zyHciIigw+W/s=
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-caf5fa127d4so1283212a12.0
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 02:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022578; x=1784627378;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pGsk66JZn1h/3M38flh1fnWe1C8ACxpKIAppWy/wXVE=;
 b=p9gKbg6DX92N9SIoHkctNDrbXv21QGj5nRp6ZOMInQLTq5N+UxIpbQNcVtvKYyqpAJ
 QqbKSmJ7cEWmWPAurQoeifIizbi4F07xY35ZjgSRk0BQLx5G4MCIOeSfLDsWs6b78aFb
 hT6NjRSlAw//ylr393geuvgwePNIPvCWaoioOYU/eqKt5zqmLLWb16sakWJOArJ6o5GV
 LckKk+3/MtUb6ONAC1TRUNI3Hk9wwPRg1esc2EnEZnytYDhtrm+a8DUxnsOgxxj6SUnz
 LJr6GCh4Ox1q+k1a2mzLqNJmImPA2ejaHrK1/6D2WCJVR7yJDhAhfJJWtUPVzEbYe/pN
 CUbg==
X-Gm-Message-State: AOJu0YzHgHJ0P9TUOm+vf/ZNVkLs5w8mjPgJHbTi1cunJv8OwQgfgzYW
 ewWcpunziW6HY9KO/auVEhdVdKEvLlnZ27Ofp2HU4OuNPR8jWS9//x5zrQRqk4fgAYw/FZwWJZQ
 Q8j3ga9lj0F/WWGoPHdgpkksHYkgJ2VMcRgW97g2rgEcI4A6i7tpECPfKlXBaKO3z5Dgk32mDBc
 zAYS4=
X-Gm-Gg: AfdE7cn0OkbxH/vnIj/0bQFHdGuE8IlSi5lMRhHIg5tlsJdjlXliLiyxYyafHShLhQ0
 GC4hL+/2Z+lu+84iQ7odD4vl1Xg27Pv71vF7weWZpMrMHSlAX1t/Phj3RJBzNP3yMj/xE5mSEy5
 fCwsynmRI2ocmNodNvWd75Q2h7KvwtMG1qSFbrDs8YPOjVTu9qQEHcB7NCI83PMofGhW69pDArL
 Sb8epplyW66ARhzSaLOVq30KoivT/0eXHF/afX8sHwzg06WDm+BcnXD87maTnQSnJ8UlsyErhYy
 IByNUdf53XfQX7S5topAIKZnGqnj2gqIvIWcPc4B9Kz15YvyxpsRT9RnEB/gHUQyUS39tSFIn4R
 +aOg7/+JaKRCGcdh0U2nwOOL5H0jUOe0hvzLjOlwgs24tKw4OWC4ibES7IEuLmPtdiPWoRKQJJn
 e+nO5V
X-Received: by 2002:a05:6a20:2d22:b0:3bf:6c08:2849 with SMTP id
 adf61e73a8af0-3c1108c1afcmr13237113637.56.1784022577834; 
 Tue, 14 Jul 2026 02:49:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d22:b0:3bf:6c08:2849 with SMTP id
 adf61e73a8af0-3c1108c1afcmr13237091637.56.1784022577471; 
 Tue, 14 Jul 2026 02:49:37 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3c1f77fsm9687752a12.32.2026.07.14.02.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 02:49:36 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/2] cmd: nvedit_efi: fix default GUID selection for
 signature databases
Date: Tue, 14 Jul 2026 09:48:58 +0000
Message-ID: <20260714094902.438079-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Jul 2026 14:51:05 +0200
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
security database GUID and not under the global variable GUID. This is
the first coverage of dbt and dbr under test/. The enrollment happens
in setup mode because once secure boot is enabled,
efi_variable_authenticate() only accepts writes to PK, KEK, db and
dbx. The new test fails at the dbr step without patch 1.

Aristo Chen (2):
  cmd: nvedit_efi: use efi_auth_var_get_guid() for the default GUID
  test: check default GUID selection of signature database variables

 cmd/nvedit_efi.c                              | 22 +++++---------
 test/py/tests/test_efi_secboot/conftest.py    |  8 +++++
 .../py/tests/test_efi_secboot/test_authvar.py | 30 +++++++++++++++++++
 3 files changed, 46 insertions(+), 14 deletions(-)

-- 
2.43.0

