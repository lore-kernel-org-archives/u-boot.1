Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79823C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 23:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 371A180759;
	Tue, 21 Jan 2025 00:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="HCjW7d0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F582805C5; Mon, 20 Jan 2025 20:43:17 +0100 (CET)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3918800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 20:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737402193; x=1737661393;
 bh=yFrvn4uUcAhTPGnhvnCsSg278RcSgRDkFaEsPTteqSQ=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=HCjW7d0hwPEts7E2SDXGWIWj6ALRKT28eIONoPdj5VMkJTQuhHtfprePftk8BQbl1
 6GIOwJZL5O4nUA9yDZc331+LMyCIppxae0J8/HvnX7oB5QrBHXp6TeFlM0AWQ9j0Gn
 rSwqtlvo55zD5SCmqIHr3xoivpVRXfHJG7suBuQB15vHS8KRFDBBEbeoglJaBvRIf8
 C65cF0+mSaZhIzyHXPLEsIaS3zh2Uo1RjXxEu38TQEZCF0kLTXHKSJENM20H8bTLsE
 yfR+dRhvJVIHJAXsyBTM+D1K4x/K9/V7yXDFoqezFvpihHngwu38wglh9fwdSF1Ad/
 juqmkn3eGj+3A==
Date: Mon, 20 Jan 2025 19:43:07 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH 0/2] mach-snapdragon: Fix and improve /memory parsing
Message-ID: <20250120-qcom-parse-memory-updates-v1-0-54a7f0550cff@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 79986b1cd9ad2b522e911619dd6c812552a2c28f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 21 Jan 2025 00:25:40 +0100
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

The first commit in this series is a fix for qcom_parse_memory, which is
currently broken on master (since fc37a73e6679). It's an alternative to
the patch Caleb proposed a couple of days ago
(20250117102734.3725009-2-caleb.connolly@linaro.org). This approach
results in a smaller diff, and also makes it possible to do the thing
introduced in the second commit.

The second commit introduces the ability to boot with an internal DT
that lacks a fully specified /memory node, instead obtaining that
information from the FDT supplied by the previous bootloader.

The first commit should ideally land even if the second one needs more
rounds before it's ready. I opted to submit both commits together as one
series because, as noted earlier, the way the fix is done introduces
functionality that the second commit relies on (specifically: passing
the pointer of the specific FDT to parse for its /memory node).

I've tested both these commits together on an msm8916 device and an
sdm845 device. The msm8916 device booted with an internal DT that relies
on /memory in the external FDT to properly function. The sdm845 device
booted with an entirely external FDT. So I reckon I hit all the various
code paths in both qcom_parse_memory and board_fdt_blob_setup.

Signed-off-by: Sam Day <me@samcday.com>
---
Sam Day (2):
      mach-snapdragon: pass fdt to qcom_parse_memory
      mach-snapdragon: support parsing memory info from external FDT

 arch/arm/mach-snapdragon/Kconfig | 13 ++++++++
 arch/arm/mach-snapdragon/board.c | 68 ++++++++++++++++++++++++++----------=
----
 2 files changed, 58 insertions(+), 23 deletions(-)
---
base-commit: 639cd409987acf173eaffebe7876968b42fd7c32
change-id: 20250120-qcom-parse-memory-updates-96ffe248cdf1

Best regards,
--=20
Sam Day <me@samcday.com>


