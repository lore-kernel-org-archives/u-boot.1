Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00540606A32E
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sfLglTgO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=A1Nj5N3m
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA081608C7;
	Thu, 12 Nov 2026 16:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6dUPyBiOWgrw; Thu, 12 Nov 2026 16:55:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D36CF607E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794502543;
	b=sELP0Bmny9noaid2xxl9MSsLbzl4XIGWu8CT984Jv+jHqcawuwM9zOkqeLtUYAJtC62Q
	 NLHU8iJG07PVdxWeAtalm8xs2f6ca+RdnpxDs5HHxD8EQjHFglZRsXSeraHnZHolGXTrM
	 mdTRIxCSXHazoPWvRs6kPYKk/9/9i1h3whPxyxlGFlZFAF52c+AD3wKT5gYjk1dIIhXxJ
	 JtSZka2b7C+N4mwlce5U3l6O2xpgHw3qhlqhYqQ8maO0jmzKO8UF5SsrAKeuL/pnhJvKH
	 NPqwBWD+2Y0cSHFgVRvgqAVuAqtnahKn6Wf6PURQEEjjfHAA0phGea1+PbnJE6TgmxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794502543;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vvaXM43psOV9DPsQUdc8kLsRbjWeFPvGrv4QGAKVCgE=;
	b=YbAlyOSrsoDrv7iJPB079CA54+9nQ6CoFvakfl7Mh2v4WrNOnqFF7R1RQ8Tuh3THKq/o
	 aBBswLrlali0Ul20dLa9kw8v+hlFYI3hhxpgAOrJV2ya25d/eRUzUTlIzI9KbmwKcP/B1
	 ZDENdkwuJtjmSLQTTZ9hWMpd41ha8z7rYdPn5lk+ZI7eQ9hFBZNfFqCsje2A9Eq/C20XY
	 lAmsKgIYR0hf5IYu6rrQ67qWLBxrVXSKlZjbhgFRBP13TDT7+6TGK16nwb1wPKBXNpN/v
	 SKkoQvVrk4MtQybIX6LlQ684xa5zOy08RHquiaNPLKnh9pmxf4AFmgex5UpoQo+GXnQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794502543;
	bh=vvaXM43psOV9DPsQUdc8kLsRbjWeFPvGrv4QGAKVCgE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sfLglTgOU9Jqn6dQ9F942m5dwGBT8FlMC8MnKCJNOf1rNbgG+k00YqD7vaDgBeu5U
	 cgBAmL7FePveyvgxYo9L6HVTILKB53/kuWKl9wiad8JP8argPh2f3jj6egPq6EuF2M
	 wb4RyVVVqJC/ZRn2a5J1FT67vEZml68Pn0Ahb3F+8mqBxTbxP3clPOPKgmWPDqHsV3
	 fFO26DreqlCm8A1Y8x7U6trTvdBlItL5jNWqllkx00fMf8d4Y7P3JEE6EXSE9qFoYR
	 EMQP9ojXkblnjO8ipRSFaLMDhAFz3qsGWW8ORq9bj6HtnXKw2J090iAttC8VGeIigo
	 ZXRGmUI0X9cRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D36CF607E7;
	Thu, 12 Nov 2026 16:55:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F0697E09
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D5B8481463
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U8w0mLJASQ2Z for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 16:55:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 689588145D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=A1Nj5N3m
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 689588145D
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:55:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C32F1516;
 Thu, 12 Nov 2026 08:55:35 -0800 (PST)
Received: from [127.0.1.1] (unknown [10.57.16.216])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33EEB3F673;
 Thu, 12 Nov 2026 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794502538; bh=3Dd2BMePUgA6R3OtiWPwJG9s4IOV14PjIj31x50CjSA=;
 h=From:Subject:Date:To:Cc:From;
 b=A1Nj5N3mP727Wo4g88Ztpm1IJthiLzgvHbUFggoPwAXCPvTWbpNi76FKoICAEPzzZ
 1WNp1JXUKhQNcB1JnhdvyCY3Li+3CDYlsvpO0BuKBgT7hmMPHMsqmlYH8VFL8VN0EO
 aOUoHWm+UoOI5yepX8G+r8mkQ2eVurvOxoNraZiQ=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 0/2] efi: fix and test getinfo() returned buffer size
Date: Thu, 12 Nov 2026 17:55:32 +0100
Message-Id: <20261112-getinfo-v1-0-b7eb8c837985@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDUxjQquIhZaU8aipEUkjbsrl
 l/yvxchkGcK0GYRPJ0ceHUJmGdg5sFNJHhMBlnIChGlmGhnZ1ehjCKFpdamqSHVmyfL1/fU9b/
 DoRcy+zuH+34AQgfiZWsAAAA=
X-Change-ID: 20261112-getinfo-5c5e514bbc98
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=vincent.stehle@arm.com; 
 h=from:subject:message-id;
 bh=3Dd2BMePUgA6R3OtiWPwJG9s4IOV14PjIj31x50CjSA=; 
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBq9e+I9Ks07Ts71l4AugULssM5xzOI6JkzgxKCY
 OmTHjYd/UyJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCavXviAAKCRDLSfhWdqMG
 lMWNB/sE1Pu0pefVqho1i/o2G8QcQIdmS6AZDh/O/TY71kHwNv6ONVgyBn6orUqJ8GOgS+1jtst
 nw11bRIIH2B+mMXtQ9TnvVg1Oq2iNvYp/VBYbSynmw78RB3N1HBYtbzTORtD0YRE0oFCEgg1AH+
 6KFtivnD2/3nSR41Py0g2s61h+b69ljh+JRcBCg+OaDgGTdQw7YlW61bBUu9c1TXt3xTysH/+/E
 gyybsKVmYBqkbTVRvZ1vV9FEPu4hKDm4ndcMH/Xkj2mtDwweybwOqnGJCnLMjlmIloWkVvvm7Zi
 p6PS1fqG/5rbT1ts54jXLl5fkgldPs90xX6qO0D0WhNkMqi3
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This couple of patches does the following:
- Fix the buffer size returned by EFI_FILE_PROTOCOL.GetInfo().
- Enhance the existing block device selftest to verify it.

The existing selftest exercises only one path of GetInfo() out of three,
but as the fix is common to all paths this is a good start already.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
---
Vincent Stehlé (2):
      efi_loader: fix getinfo() returned buffer size
      efi_selftest: verify getinfo() returned buffer size

 lib/efi_loader/efi_file.c                    | 11 +++++------
 lib/efi_selftest/efi_selftest_block_device.c |  6 ++++++
 2 files changed, 11 insertions(+), 6 deletions(-)
---
base-commit: 3cb2cbbc75aa7fe2391f662607d6b2f46c1292a7
change-id: 20261112-getinfo-5c5e514bbc98

Best regards,
--  
Vincent.

