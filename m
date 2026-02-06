Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A310EE6B49
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 18:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B861D83A64;
	Fri,  6 Feb 2026 19:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="n4QM1sx1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D6183AA7; Fri,  6 Feb 2026 19:32:50 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD62836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 19:32:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1770402765; x=1771007565; i=xypron.glpk@gmx.de;
 bh=cK9DIOpV0EWXtVBUBRjeluo2akm3eQX9GNtVLs9rsgw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=n4QM1sx12wwqumg4Skyk+d2YlnMswXIz06Y31hHUNBbjoq8dC54H/j9GiUKSTU/J
 lstCSRO+Hpc2wQNTKpBHl9itaOfwzLJdiluH3I4IalOEvQwWkRqz0qv9fjHwn6+rc
 0nlG8TdkMM4Sf1dsMJR1cU/BxwXXgADs+oEVo7Lcog48B2Za+xnmhMEQtYSx6OHGg
 50zBb1su5o7flLY6je1RWvJOKzaVHVU7l33zm6lAvBj8xGWc88IVOpEnw8osxzYlg
 YkIl8fuvYm971ydXHaa3iHh/AJUHSBf2F+HDuxYCvaL96fPDRdBltfCiOVqcmXUQI
 rjrHkoK7TSdkLzY0Eg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbRm-1w28Yd2MSk-00596e; Fri, 06
 Feb 2026 19:32:45 +0100
Message-ID: <32ebd3f3-6ce8-4be2-ada8-9edb25f42bcb@gmx.de>
Date: Fri, 6 Feb 2026 19:32:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Pranav Tilak <pranav.vinaytilak@amd.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-04-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:634sKD4Xg3qzc5QPy57ChKJKBRCBG32aomaXyAa8reHD5x9R2mX
 7rMFkZi5/WaElq59OhYX7NZDbgBIVDwrsKv0LrcWiMRNxr4zlpJUVd38cw6HNzrn2VKmBAx
 i4ui5cKLCBn9IjAy7XTySZJOj2VkY/5MdrnpGYr1DkDLJdWBaMRAAXsx6HZiy+shI8KPE0J
 h9sGXQrxERwOEsQoTLPVg==
UI-OutboundReport: notjunk:1;M01:P0:e3n+dcrGFTY=;PBza2/31R8x41ZGmWhs54FNNA3G
 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
 Likn55yBC5QPfL/+nde/G0d6VdvglGEDoMT18Q
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

Dear Tom,

The following changes since commit b5213bbfdcb1812be510427857827ee8becb9f8=
f:

   video: menu "TrueType Fonts" depends on TrueType enabled (2026-02-04=20
10:41:48 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-04-rc2

for you to fetch changes up to 36e321b487a9ac73c2dfb9cbaadb0244f70f66fb:

   efi_net: add missing EFI_CALL in efi_net (2026-02-06 10:04:30 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/29203

=2D---------------------------------------------------------------
Pull request efi-2026-04-rc2

Documentation:

* Remove pip from requirements.txt
* develop/process: Clarify name usage in the Signed-off-by line

UEFI:

* Improve EFI variable load message
* Fix use after free in efi_exit() with tcg2
* Fix efi_debug_image_info_normal allocation
* Add missing EFI_CALL in efi_net

=2D---------------------------------------------------------------
Pranav Tilak (1):
       efi_loader: Improve EFI variable load message

Tom Rini (2):
       doc: Remove pip from requirements.txt
       doc: develop/process: Clarify name usage in the Signed-off-by line

Vincent Stehl=C3=A9 (3):
       efi_loader: fix use after free in efi_exit() with tcg2
       efi_loader: fix efi_debug_image_info_normal allocation
       efi_net: add missing EFI_CALL in efi_net

  doc/develop/process.rst            |  3 +--
  doc/sphinx/requirements.txt        |  1 -
  lib/efi_loader/efi_boottime.c      | 13 +++++++------
  lib/efi_loader/efi_debug_support.c |  2 +-
  lib/efi_loader/efi_net.c           |  6 ++++--
  lib/efi_loader/efi_var_file.c      |  2 +-
  6 files changed, 14 insertions(+), 13 deletions(-)
