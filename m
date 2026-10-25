Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC81606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iAtC03Pb;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=btg9fqjU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E55580972;
	Sun, 25 Oct 2026 20:19:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iE344T0xh2FS; Sun, 25 Oct 2026 20:19:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 336FE80845
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792959540;
	b=WsaPI1NnDsmBCNCXc9ll0Z/LVJR4BPINEmlsFaSl/b2nk3bEiDmsWgATMp+bbKhlWQWK
	 YiTpc0xZRzXWReqgg/42l47dz44eOjBtmmEW4+q8DsYau5yNouOtyugX0tJ+k4O5iN1H3
	 OcIFQ/r2rqe2WGF8XBArve4Qu4rbQ+wkdYELWhF8a2NHKU52b6JpLHbarcTBVSWvd2xqa
	 MssKJwQbAOZ2mMOyQqHDriaQS1O1NutEc1ipBypEzWWo40ny7hkQxN6nek4BgJp9pf9tJ
	 SINCYMaz6su1iwLhX3surFQTj8qvdlmi8xbkn7hZFLd1+XGBpuHJ44CDI2DmkCdqEtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792959540;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l24/RcxlBtxxcZchauKAdJRx5WJg5Wf51basxKsy45A=;
	b=VEzJS1TDd0x7b7KDKFl+GRU9afjq79heskrqm6qDm7MknF8grrHSUs74ny3Tz56QKzJN
	 JZTHV9Vf28QGEe8kvp30owRTlNeMft/7bJolloQhA+5aYVitx9jS/byrNkW7SsdD0QDwS
	 B/c+2rlrdMwFMTsJ2vHEqjlDfQp5Lg752TsXZ5zWpgcUmx2V6dTlPhWThCPlNSghWNbgP
	 fVj0R39pkwZXqXCYYOsQPwb8WqYLJx3Zf9gXdUYhNFSSjmt/CRRSErR6nJ5Yoq+JLy0/f
	 YkYwtTN1UBW9Fe+EyI18dFkcYPlN7vbvmo0sjumICM6YCzGpog6F5LBpKOdHDiWc53A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792959540;
	bh=l24/RcxlBtxxcZchauKAdJRx5WJg5Wf51basxKsy45A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iAtC03Pb8G65wQ/2xYZae45bYptJKDOgriqtaxTJ1RvF1gX2zw9atsUygh95X00tG
	 7OK2t9tw/F6BZ52xeaosI7G5fgOWdX98D8gp/4m1nNKtHTrJBBGojI8DGC7Zt5qMOt
	 NRQWa4m7EPiKvkYlPWugD41kADYFRH6CtrwhxQEnLq4tTiR6Us7j0V6UI6nv4UM5te
	 iMYgX41JLYOGU1hB25TaRBXUYDC1RLeHJgSuNBAYKvpRlitiyrW9bp7oksSFrpxo6b
	 ONwwJypUqeSUUF4p1XUjnv6+enDgD9d7/hR9TUEmf7QSRjUOrlYFbnaPDyqRwId9pj
	 AAAGO5Sy7MEag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 336FE80845;
	Sun, 25 Oct 2026 20:19:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 46270235
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 20:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C12840593
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 20:18:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iOXsiwKlZZI4 for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 20:18:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C66B440591
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792959538;
 b=a+GukxtAu2O38BZWY5E6oktTWATYzvDAKgBy1FjEVIKNkrpLnoOJ9EFY01p8Ng68dlni
 geD/AlT+g2YIYC6XEfDlyU1M2OYnoXDimeB/ZG2xvGwSrnUr67y7er670+ZZb4hbkKIlq
 e4plGXwldVw091GVrVn3eWhOGsO4Wa+59AuSXU7Mf3jz6Hqp/copy0YLA7JdFkJvdmTCt
 SEgo3pTlA0tP4zq3PRucnfYC0tWM1ttqjuARLbunaH8num6revV5D/qSxytDBhWK/A8IS
 2gK4f9eXlSR69KqR/nG8GeRsaTQ8dHV1QaFb8OsYfbTgx+i3z3Xx/EtMg2vBDGWH2CQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792959538;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=l24/RcxlBtxxcZchauKAdJRx5WJg5Wf51basxKsy45A=;
 b=Ryi5lskjwPykJIfvhcnnAyIaZWgOkZtkMWe7bFefe9nPuhCRIuGYhP+FjgHe4sMQRoEh
 BiVWhe6l/uEXk56fNxjLG+4/AmlsadXvjgw4dUrm525+TMPcoJgnEtesYkDF3S+XxMs3o
 DvvpMQ7sxvnqLWNrNT0sDbZqPBZL9Vuh3voOx0Tw80IRXmTsyAkNUJelN1Imn52iyfft/
 r0YdW+e+6t7/9H/4hSKuIizzcFJ58cr24MIRlwniAZxkJ8LThgV3cd3JC3RadKQ28g6OL
 u088vixyXxPRkIAR50TW5ymUga1rH2Dtj9idq1keJRwQTZVfxQ+hBtwPjranZopCYSw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=btg9fqjU; 
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=btg9fqjU
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C66B440591
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 20:18:56 +0000 (UTC)
Received: from LT03 (host-209-35-187-178.broadbandcancun.mx [209.35.187.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5BA9541633; 
 Sun, 25 Oct 2026 20:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792959534;
 bh=l24/RcxlBtxxcZchauKAdJRx5WJg5Wf51basxKsy45A=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=btg9fqjUrZO8mMzmDr3UGG8Rhm2J2LEHaiLCLZd3WeF671bQM+CzMsKbEZ8lJ//IL
 Obi4/JvzC+cL2/sPXyASfreAeQIm06wFQy7YM86mYCYueON4qZR2KlBbuBPKqGDfJT
 0zta/Zi007PybIwLJz0WghdtO0tcAGQRO20sUEt9O0tffxuxszD4nDgogA57Ez1YvJ
 xi0TRdKCq1iJYr4Fi4O/SOafdmf+7eap5+EkoZispZINIxZqwZsvcVVOcVy6np+kMb
 6vbJ3Y1iEl+ZMeg6q6ARXlB6KzfL0vQuXJiPwZi0maImsfUTQLvbP3zkCKUssNi9gi
 fk+47utsFTf7fsusbiyihFRh3AutEtFWFfJMwc4u7fOE3iE0lnAKreURgdIX2SUBFs
 sJBOWPmV+dWpAKuVbaJjLlL8Di/0TPb5IqYe13VZj/9cxVcNZtx8m4bf14Y3rZDHVs
 c60t1twRLW5bkrtCSqJvyC45ueyWHk4jgWj+v0IN8JS12boEHQYFWH1jF7bBFgFNZ9
 A4ZsqzPU4ixafAnfdWIYUoNIxTrwugzkOEUQi1Z3AX2dyELYgwBHnxXhubLrD04Mu2
 ulBI2626O+Kqx+8pcPZO7rFZxSxVLAhqGWKz6sfh48ytIMUJPkbYEdYoiT/SiOlwI5
 Q85HQfaXQCkPsf2sI64DTlB8=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Tom Rini <trini@konsulko.com>, Randolph Sapp <rs@ti.com>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] efi_loader: implement EFI_DT_FIXUP_PROTOCOL v0.06
Date: Sun, 25 Oct 2026 21:18:42 +0100
Message-ID: <20261025201845.328650-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As result of the discussion with Tianocore EDK II developers in  version
v0.06 of the EFI_DT_FIXUP_PROTOCOL specification support for carving out
device-tree reserved memory ranges was removed. A new GUID was provided
for the reduced protocol.

Implement the new version of the protocol as a wrapper around the old
implementation. This keeps full backwards compatibility for existing
users.

As we want to be able to treat efi_selftest as standalone binary in
future we are not using fdtlib. Factor out device-tree access functions
for efi_selftest_fdt.c into new module efi_selftest_fdtlib.c.

Create an new test for the EFI_DT_FIXUP protocol that checks fixup
is applied with either of the old and the new protocol version.

Heinrich Schuchardt (3):
  efi_loader: implement EFI_DT_FIXUP_PROTOCOL v0.06
  efi_selftest: factor out a module with fdt helper functions
  efi_selftest: test for EFI_DT_FIXUP_PROTOCOL

 include/efi_api.h                        |   4 +
 include/efi_dt_fixup.h                   |  21 +++
 include/efi_selftest.h                   |  50 ++++++
 lib/efi_loader/efi_dt_fixup.c            | 102 ++++++++---
 lib/efi_loader/efi_root_node.c           |   2 +
 lib/efi_selftest/Makefile                |   3 +-
 lib/efi_selftest/efi_selftest_dt_fixup.c | 201 +++++++++++++++++++++
 lib/efi_selftest/efi_selftest_fdt.c      | 138 ++-------------
 lib/efi_selftest/efi_selftest_fdtlib.c   | 214 +++++++++++++++++++++++
 9 files changed, 588 insertions(+), 147 deletions(-)
 create mode 100644 lib/efi_selftest/efi_selftest_dt_fixup.c
 create mode 100644 lib/efi_selftest/efi_selftest_fdtlib.c

-- 
2.53.0

