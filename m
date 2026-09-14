Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6645EC88E77
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28635606F5;
	Mon, 14 Sep 2026 14:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LcluC8lZX37a; Mon, 14 Sep 2026 14:17:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6F75E606FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395461;
	b=pC9R490UXp8H8xVt8kUpOqrMnQWXgjpL0ShXQxvknaZBTl/pm6+ChSjSph9dtCOPkE88
	 /DRAxhmQNKmsjoFPmSDVeMFZpaQi+SfXUTe+SrZIIWLSyuhsQ+jJtqAfxoTKNo1GsKXW/
	 ml9bah91eey0eZTEvfPtnnF9vJWxp8ALoNZPEWTFpv01QUcv9ovqna6xHgNLEBy0u5rW0
	 PBiP3ThBmmWgsC8/ecd6TGvVKUTTI7B74k9b7zVydG/5P4MSj0zc54UCiweROzmOmK9dN
	 HgBQkp2CnakZVGzfrAue3h0G5DIeXN6E1mHCZOcO1GEoQvWuRbCEot4ECqhHaIjF4qw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UZpA+OZSHuMwQN0nTcxvaMn+SvjplDHx4/gQX8SzPTM=;
	b=WJtPyabdMHFuyRAy6YN921tOMxCLy0WtE+JJ9l5AagqFzrD2cwqI7Pz065NGzlYtmX1V
	 60H+nPOGswDLImjs5ZYg4bwx3kueaDy8FKDPNdA1XXpNAasebrJxd2DJB6tpmX6dN3CAd
	 NUanpXTiJkUiH8S0uQGKgB2VB+Dp5bXxhIGGpZI7FHXYKChof7fvZqWlBQAnEfKamOy+t
	 Q0sY1SpgwW04N7ea9sbj2ziem/X5rdEDmvqVGM5WbLqo7+eHc+FWe0f/RETpYfyiIfs4s
	 X5R9LaM5/bsthWjWRjiNIc98MMZFK0kbbl1VVu4uSN9mcB1tWytXJBzBGyysfLXY+Qw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395461;
	bh=UZpA+OZSHuMwQN0nTcxvaMn+SvjplDHx4/gQX8SzPTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=meFz04hWyCaoqnglPSCibxU5B8AheAiE3oln1TYC2hQk1nf5D4fHtoqjqwc9BcP2g
	 DG3ndSZereWkoMoOMytIGdBEDFyJxuyVKUOBwwueSAIsngQXOqQ38f3Q56291xdS1w
	 igFyh2LAzEIBCy3RRll0NN8T5N96+JSB1ZOH0fBKzXUFPZcbZ2LifaRi/IF+guKx4/
	 CZb80NqBUo1W/kKhYhdljY6vJXM2Lgd+0OHYa8ndDYz9gwpXNsC/vTekNxlOQ1uvhs
	 P5pMtu9S8Pp+R8cpQUyeSPh+BoV5prG5B3iQUd0EqoOnnd4Dx6wxuvgEQCIAcikoFp
	 rinvNvO2M0ESw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F75E606FF;
	Mon, 14 Sep 2026 14:17:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 07DC82D0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E289240631
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nx1USFzq8bFf for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 398F340635
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=C9ZMuvSXGsKPZrG9GTWskA2Ehr4sWlWzbvSK1DjA+Ol4f0r5Q5yYnWD5Aer8V+J333/B
 Ka3YmSBv5poOw5yTPKUvRl5/U9q6YGeA+w8llchih8rROBULaU8leDEAyBeCymz0UYT+G
 hBzYZYVjHy2DViXn2v2B+6WXRkXMJ5WBVGxUSEMMxrc3GUEo2niUrDiq0IIxrRyA98RdO
 126sntCRifShN8qbNsKKZSG902WJdkel5ldF0tBTT5HV7X4DyPRgnCafr5s2k4j42O48D
 fy1qJ6g3hbld1J6gPrknp2M5+ukIZe0d4fZg1dosfb3UzNRHXOZrjvBq2Zgf7WtqE+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=UZpA+OZSHuMwQN0nTcxvaMn+SvjplDHx4/gQX8SzPTM=;
 b=LFZMC6JoQ7veQCiWVDGcrE67DO+W2LEIf8MNm9T3Imz+Bg09VEJ2rvMrd5LuUQPuMx4O
 LcHPiCItD4ti1mZkKY/WOFykrjgs3CYquaSUkX9RKE77JeKX7zwGr/HFGK+ctqLeewFkT
 0+DX7jfp7JD0dd1cy0/ETIwlDCThDDOzjzghyLR79gQa1NJP4tK7LqexvG8YNFdD8PNae
 H5lbqiG8j6GI8wM5SGSo8PaxjNW6R6GF9uMTf7f6qTIyCVDXXLHK7Kf1alP9z2tmi4Rfs
 qdOXzXSeCpXvpQLb+aFlfilRoVj6p556BGoH+7n4gcc+YYBJGWOIlUvIMGZ5cospHrw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=ZqRmCRC8; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=ZqRmCRC8
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 398F340635
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5706F2EDF;
 Mon, 14 Sep 2026 04:02:04 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80B963F86F;
 Mon, 14 Sep 2026 04:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383728; bh=D5V/iOFLyaptZfV74pMFzj55BwhzEnWW0vfLvpxdvd4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZqRmCRC8WKUYudCHSgN9egQ3I6oWYS9gDypEuMrKFtjB+au9BXEwxzGai3Bl9OFoT
 Qbea1/t6UwJlCcmwhoeHJRZV6U+vP4SCakE6hldPh9c5OBQzpR3GFxtbXHpp8LTxU5
 oKImzqVaIRr/Ee7lXImtJesAHy/OquU0CI1OYZXY=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 22/22] doc: bootefi: note two-phase runtime variables
 selftest
Date: Mon, 14 Sep 2026 12:01:06 +0100
Message-Id: <20260914110106.1974894-23-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The bootefi documentation did not describe how to run the
runtime-variable selftest, so users had no guidance on its reboot
requirements or on which flow applies to their configuration.

Document the runtime-variable selftest flow in bootefi.rst. Describe
the non-volatile path, note the single-run
CONFIG_EFI_RT_VOLATILE_STORE=y case, and show how to select the
runtime-variable selftest with efi_selftest.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v3:

Simon:

- Clarify the volatile-store runtime-variable test flow
- Note that the split-phase tests only run when selected through
  efi_selftest

v2:

Simon:

- Update the doc to match the v2 new efi selftest flow
- Document single-run behavior for volatile-store builds
---
 doc/usage/cmd/bootefi.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
index 7c5448586b7..0a7800b93ce 100644
--- a/doc/usage/cmd/bootefi.rst
+++ b/doc/usage/cmd/bootefi.rst
@@ -160,6 +160,37 @@ environment variable to match one of the listed identifiers
 Some of the tests execute the ExitBootServices() UEFI boot service and will not
 return to the command line but require a board reset.
 
+When CONFIG_EFI_RT_VOLATILE_STORE is enabled, the test
+*variables at runtime* completes within one *bootefi selftest* run, so
+it does not depend on preserving state across multiple runs. It still
+executes ExitBootServices(), so a board reset is required afterwards
+before returning to the command line.
+
+::
+
+    => setenv efi_selftest 'variables at runtime'
+    => bootefi selftest
+
+When CONFIG_EFI_RT_VOLATILE_STORE is not enabled, the runtime-variable
+flow is split into *variables at runtime setup* and
+*variables at runtime verify*. Run the setup test once to create the
+runtime-accessible variable in non-volatile storage, reboot, then run
+the verify test to validate, append, and delete that variable.
+Both phases are on-request tests, so they only run when selected by
+``efi_selftest``.
+
+::
+
+    => setenv efi_selftest 'variables at runtime setup'
+    => bootefi selftest
+
+After reboot:
+
+::
+
+    => setenv efi_selftest 'variables at runtime verify'
+    => bootefi selftest
+
 Configuration
 -------------
 
-- 
2.34.1

