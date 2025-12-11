Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE55D41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9CAA83C9F;
	Thu, 11 Dec 2025 11:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="un8TvGR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06CD283CAA; Thu, 11 Dec 2025 11:27:42 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B4983642
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 11:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B8D254440B;
 Thu, 11 Dec 2025 10:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBFFC4CEF7;
 Thu, 11 Dec 2025 10:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765448847;
 bh=0CBZJut2BNH0CMm3qVZm0YmXq2VDfvpcN3mkdS5V2yM=;
 h=From:To:Cc:Subject:Date:From;
 b=un8TvGR69zyIkaDGL26fZgsE7VBjnvcAHjwELUINLaCBpG7VxmSp8nInMQGy0DDVZ
 zgqR3ULsRJ3Xb/HZWPPofFearVax+LOdjzHhfFxuuohjDwbjXF6aLipo7A255FK+tt
 XP8SqzDV8QwKRkc3ArZJczSQaBTjwdTwVge5T0NcptuVD/WAzL/klwiSpq7MxEsVlq
 a90IoqcIXk0waLqS3weaFoRXLrzbsJ3U1vrxn1r4iWuG9gdzkqX/lyN8ba3riET9QJ
 gzPsmtpX78yZs013IiaV8ENNkkLjim0IN6ypM3kEAAozrExBQ1HnTf9LNazX6wiKun
 U1kmobVBOG+ww==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20251211 into next
Date: Thu, 11 Dec 2025 11:27:24 +0100
Message-ID: <875xad5n5f.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Here is a PR for next

Android:
* Fix 8-byte alignment for newer versions of libfdt

CI:
* https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/28724

Regards,
Mattijs

The following changes since commit 59f9fcc1f514762674ac07c13c2a85f7aace7250:

  vexpress_aemv8: Stop disabling device tree relocation (2025-12-04 15:11:26 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20251211

for you to fetch changes up to 42ee514ed049d5e689e39bb4a8b6b5fb519aa3be:

  test/py: android: Point fdt command to aligned addresses (2025-12-05 17:21:47 +0100)

----------------------------------------------------------------
u-boot-dfu-next-20251211

Android:
* Fix 8-byte alignment for newer versions of libfdt

----------------------------------------------------------------
Marek Vasut (2):
      boot: android: Always use 8-byte aligned DT with libfdt
      test/py: android: Point fdt command to aligned addresses

 boot/image-android.c                        | 42 +++++++++++++++++++++--------
 test/py/tests/test_android/test_abootimg.py | 28 ++++++++++++++-----
 2 files changed, 53 insertions(+), 17 deletions(-)
