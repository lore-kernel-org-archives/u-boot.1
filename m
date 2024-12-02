Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD976D4978E
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 00:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E7B88D4A;
	Mon,  2 Dec 2024 01:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Oe+9fUsk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73B94890E4; Mon,  2 Dec 2024 01:24:33 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4571688D3A
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 01:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733099070; x=1733703870; i=xypron.glpk@gmx.de;
 bh=ZrlMfW7wGX0PDgRRaLsssi13aHCZIQbL7R+KnHHJG60=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Oe+9fUsk8c/dI4AqFgnSqV0tFpIAk1i6pWV9Qz7GRUCSr8LgI12mgguLkgRSE6mY
 6IIvLU+Dlo+9uIhtxWgNDFFoAihvMEJlmzWzH1qnJfWAEtvov17VfFhwjgD3KUtLD
 d0k/8wGvKmx44iGFjcMUcuCBwLS2aqcaxyis+Qij8Zkn/tGU8/MBSFIuZEgcYyrue
 gN1xtpsqkGg947BUDtIkEdRCsmMnFZ4A7aDdYasdtr2ZflbdnuXg5JMntIg1ukTHC
 a44U/Zc7gpK+yxH82FMHUzH9UCAtHNiNXHi+aDDtVnQreenN4P3ygUeaO+envkTiV
 xbMbnPK4BqSuTy5rUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv31W-1tZIdB20O0-014cu9; Mon, 02
 Dec 2024 01:24:29 +0100
Date: Mon, 02 Dec 2024 01:24:27 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 0/7] efi_loader: Add support for logging to a buffer
User-Agent: Thunderbird for Android
In-Reply-To: <20241202001243.1283274-1-sjg@chromium.org>
References: <20241202001243.1283274-1-sjg@chromium.org>
Message-ID: <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7LIPB2u+Yi/vEEFsv4zbC22MLjS721JDmUsiv0pKyGgHXs+cKWI
 sFGTP0idmCWDLrN/gjNELT0oWH+Puau5lo8bMjSB00dbHzwA2QKA7JsqxBHMcm8vjDdtL6f
 0JsFNalYE49HPl3ox+v0tbnd827LjETrQfGXTKX2SWT5TZMI828vumDhYISg6mJFEfN2ony
 87vIGVljk2IK0PHxwk8iw==
UI-OutboundReport: notjunk:1;M01:P0:ltoFZUVtiKg=;dc8nP4X5So2IWUse4c4LVZivttX
 PjbngveKl2q3GO3scUmqw2oyjhIPuv23VpDb1Tm+AwtjWoLS5iuj0qqa1po3+7X677wUEyvvO
 phTE4bVIYxpcCqPPCu3mbtDUhnfxKQcsgE/Y52ML4tpkqtJUxUuEN7O8g7Snif/Z5d99eOxho
 8mTtPiOGX2qE4k90wSEqxcElO4vWU6gsctoKKEdtbPruc3V3VZS5tdjt8MKPAr3m0M6ihtj+3
 4UXCqR8GvLVrVGfsXpIWaVH7eikya+oyTdpbrcYWeiqQuAXPfXiIdP2guPPXTJ3Kz34amUxeB
 6kszp4bD6PZ9ulYIkhEOOM1e2zr4pwGarDDNYp10QYoGOhaI/qLjGoKKcHjxj6oLVp/9gpH/+
 YHDKBK2DlhGK9crlKhJ7nT+HLmiZofqorYrdvI5I5CxLwufsrDgMbYU6hj32592yjVsK+NbpJ
 fH0Xm4B++VaO0l1L9Ybmp8afOjssBDZszXIbnSp4mGfpdm7HzMkPZwC+Ngh84iaf+ALPSEsyd
 We0mELZ19y9CECwELKPt55ThtEffDQs0ZkeOEluHF1FlpS8tOkCEOLePUXrJEwcqhG77kZPwY
 0TDaPT84eI+sb9afTSup/p4WuL6vm+ZMhFK9J3VoK1jej3vSjOoJDy2B2hlR3obsczujtq+kd
 0C6SBl08aOjb8l62dpQWdHzfWtYWDTjGwr+8C0OkH3/xZwrfIaIsZvuT61fG4e+IWlNLYwEwY
 b9uWt2CSyDJAlRxWNRO4SOQ70ALuYZOrpeziWpdnLnfRF098LFxc8PsYQhuCZXStfpFtRqIj+
 U+SoBO/ix32MSqGjjQBBL+MaXREqVaeJ2bggSVyYXu9gvDp+Mdg4MvT1AFFFfH92I9TRvthEX
 +3K/QFEHob9/RjUgzcObNtbiVPZH6DWVXswdqfpsqVe8xAudMBrZ8RZoK+9+TRoSg1l+uSRMh
 GGY9NsYQfPbnLvKJpZVfUTDqQkXM4S6o9ugSMRkbMxf4pUTbn42rSdHSCb02VC0v81DNwvIZl
 F7UuJn7d48Gst+mFgXXB2MVkBOebT8ouQay0rPLnseXjVZl5OgCmCzsUazIpGF42V/woJk50n
 XELJ+0PCQ=
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

Am 2=2E Dezember 2024 01:12:36 MEZ schrieb Simon Glass <sjg@chromium=2Eorg>=
:
>It is a bit of a pain to log EFI boot-services calls at present=2E The
>output goes to the console so cannot easily be inspected later=2E Also it
>would be useful to be able to store the log and review it later, perhaps
>after something has gone wrong=2E
>
>This series makes a start on implementing a log-to-buffer feature=2E It
>provides a simple 'efidebug log' command to inspect the buffer=2E For now=
,
>only memory allocations are logged=2E

In my previous review I suggested to move your work to the level of the lo=
gging library lib/log=2Ec=2E

Why are you reiterating your series without exposing why an EFI specific s=
olution=2E should be desireable?

Best regards

Heinrich


>
>This feature makes it possible to add tests to check which EFI calls are
>made by U-Boot itself=2E It may also make it easier to figure out what is
>needed for booting Windows=2E
>
>Some patches to help with debugging sandbox memory-mapping are included,
>but for now EFI's use of mapping is not adjusted=2E
>
>Changes in v2:
>- Rebase on efil series (memory address/pointers)
>
>Simon Glass (7):
>  efi_loader: Fix free in =2E=2E=2E_media_device_boot_option()
>  efi_loader: Add support for logging EFI calls
>  efi_loader: Create the log on startup
>  efi_loader: Add a command to show the EFI log
>  test: efi_loader: Add a simple test for the EFI log
>  efi_loader: Use the log with memory-related functions
>  efi_loader: Add documentation for the EFI log
>
> MAINTAINERS                  |   7 +
> cmd/efidebug=2Ec               |  53 ++++-
> configs/sandbox_defconfig    |   3 +
> doc/develop/uefi/uefi=2Erst    |  22 ++
> doc/usage/cmd/efidebug=2Erst   | 109 +++++++++
> doc/usage/index=2Erst          |   1 +
> include/bloblist=2Eh           |   1 +
> include/efi=2Eh                |   1 +
> include/efi_log=2Eh            | 316 +++++++++++++++++++++++++
> lib/efi_loader/Kconfig       |  19 ++
> lib/efi_loader/Makefile      |   1 +
> lib/efi_loader/efi_bootmgr=2Ec |   3 +-
> lib/efi_loader/efi_log=2Ec     | 444 +++++++++++++++++++++++++++++++++++
> lib/efi_loader/efi_memory=2Ec  |  66 +++++-
> lib/efi_loader/efi_setup=2Ec   |   7 +
> test/lib/Makefile            |   1 +
> test/lib/efi_log=2Ec           |  93 ++++++++
> 17 files changed, 1131 insertions(+), 16 deletions(-)
> create mode 100644 doc/usage/cmd/efidebug=2Erst
> create mode 100644 include/efi_log=2Eh
> create mode 100644 lib/efi_loader/efi_log=2Ec
> create mode 100644 test/lib/efi_log=2Ec
>

