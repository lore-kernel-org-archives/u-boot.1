Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A69CCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02E71409A8;
	Sat, 17 Oct 2026 13:01:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E5SHO9OVnfGx; Sat, 17 Oct 2026 13:01:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 38174409A6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242090;
	b=dsUAqWA+5YqD2nXGVF3jfxycgE+ctZR5kii4tXXFzoexlpjEOysZD4PQQ264Q7NkKGKj
	 HViLWM2S+EWocu8OljbuIk7U3pDZKun8FC0mA9K/Cc/Cp15G9Lu/7rGUfzW/59AKCaqgR
	 JQgCGMz/cNlJ03NvKBwb6Y2VZYJKuvqJAGBcFHNyvEqwpIHMCqB5G3f28+oJA7zOTRmSc
	 N8A+mBHt0+4HHcgjV2O1a2yks2SJUuq16Ru0VtclK0EuNm1FPNfkbLWYtIegfyqnpwgdX
	 XRvDzhF6OTTIy6T/N2Tn6Aj0pbJWAA0ibKIVeILGgEihp57cTIyWojNGRtPVHxLxC+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242090;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=7J/naRGq2PGNQQzgDDaUQlm88DsVdA22AOiKHrCdGHA=;
	b=Jc2PqIQ6DqMYDEppm8uIVoapg6BCtMPtBaqq+fQd096trRAcoWpEXhdB8GM6bmMjSwLm
	 lRGoHd0K0j4mvgsIkvo7tgwG7x2ME/7Abhe0jL7bimmCPiHjqKakbcmAz1/FWkKxOz1/T
	 HkMALetVWS2XROYLpn5e1YLERagxwVUXbjXmr8tMeId098OFBoKTZtFjo964Mfl3DoYA4
	 xfvO8ygfapFrmRDwNo2EhHgjHYBibnGXRZb8UXX6g4Bqzr++bvDPlZ5gWXjkZT4fsB1Qd
	 GDLLXYGvU7AK3WOHpXuUDnv8Rj3PGFiy4QN8dwPv09a3UkC8ksWwo5h+aY1x3hbyHSg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242090;
	bh=7J/naRGq2PGNQQzgDDaUQlm88DsVdA22AOiKHrCdGHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=LsUwqNF2CyrIsFSf2d8/Kb6kDXBLf0u4agxmCfu1WtbTwzaw4faKhfhlI02vlXMG7
	 OPP4gXDSEmFwUNfC1Lok6kaB0Dfb91dpqv2a4Fa86lhoewhUQGRBBCILWsFodzqBf8
	 YcaDBngFyffXZInmicztbC3dnHfE61v5o5V3jz9Ew+kkLfmGdvK/yicksnoiF1rkk/
	 2ZrYyKsAZEAwqhOtITa+DUxTHruDYQRSg5dxMGPXEMxCc3VUcMwlOjqF0U3W9T661X
	 4g9DaXAp4GslrkIuRpWwjWl6EMr/dvi5YrYncQGZb+34cBcH2kB0VHpV+8zxPQanNg
	 zEb1Sx6fAS9FA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38174409A6;
	Sat, 17 Oct 2026 13:01:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B3458DCF
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 99A1F608E2
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4PEvcm-kAiMS for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA9AD6087E
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792222780;
 b=Slnm/K9pLs3FWorVqxk6PwOYPGYprpxObwSFJ3diVabSUwZMFiHCxfWjM/RNHXaIgR/F
 VKWnDRXRloVgpSNYkkDulYF/RhR2rRrbbjF3ERkBf3Dz2ydBzndDFY64NfuAmzoBkGs7y
 3tWROvmBw0XAwrAbCJwVMmSgvNLF722XszaPkUbXZE8bOnQpR0ayQf3b9BNC4lCIOHCmy
 H/0/6sH86Ry8Jrtqgr5PEo8FbXE8ulh59m1hQybSWvRxCBevcxxVycZrOPJnAXKvUwyht
 EN0q5e1CoWRm8RzBCtG58OYJamL60vkTk59t/UlTuXDc6pgd8XkHHSpH3msJsiEV2EQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792222780;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=7J/naRGq2PGNQQzgDDaUQlm88DsVdA22AOiKHrCdGHA=;
 b=sR9Fh9nkx3xjGlUVbSNEDmJ2LvFAP5f7j5MW0Pe3fZh0k8A2Sb9A61M9NhOfEIOSUxlX
 9hAauQhCf0JS0UGft1dTuqXJxkmeZxTb1bbPKZelBQ35fvpwAGs5E1IwgoHeBAdnTDX8j
 PFg2sSrGzAWE1+YQnmRCcVbQKgJq+oC7bL/kE2Ca5daC7l093d98FWccG5NK5U96nUwJR
 jUNYugdqlY1czGsJkjNm+WDYAT/7zsl/VJe9TYOGxqvwCnw+xHnaFmsymzD7xzJZGusUJ
 KAs2n6vE2EUbSx1khksDxY7q4wh6yGROCOPqkfawwsqlt5ubNUnMPTI4ZRtahdrdzAQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=a6YP38lo; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=a6YP38lo
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA9AD6087E
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 602EF43A7A;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44C2CC2BCFF;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792222778;
 bh=120kuQQWhNb14k/ld3+q6/UtgGEBh5pZVS6tqpoHueI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=a6YP38lobrYovgaTohtFu8vIBUQZW+xqPVfxaSR1n+i0p8uKFZOchS/rpD6XvbCId
 ATJeFumnOSDFoTBx+prS/jEOLusLVtadKPUx6Lt2LIL2NRz71TCTmroNu6wcLj6psV
 U+OKxfHyrvyWwLKnnMyI3H37l1onn1VxqajnWdac3s+/TznR+1tw8UAJd6xRRWnEXb
 4ojkBdUImFdMb7eCcesT2IKBkTwmg9fbcfOiLiodQfXUy0P70gNiJGzCuzustrAiLc
 fRk+KZSGI/np4jHCKzGEjNmCgyetKgupwyzYO1ehl5HXQTdMhesx2XgpSRjeIb0EQF
 TttURsS02DA8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 31F3BCC6B2A;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 09:39:04 +0200
Subject: [PATCH v2 5/6] boot: Add a choice for the compression of the FDT
 in the FIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-binman-fit-fdt-compression-v2-5-d7e290847543@protonmail.com>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Alexey Charkov <alchark@flipper.net>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792222776; l=1762;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=4zYaQ6H7gvea7wuTACDytrlHDVzm52hqn+UVZvLezIA=;
 b=6Z4bW1d5h1MvhOicY7WOFFB1h5sjSdERn/Q4t3unKTQAh5itQ/0zSz1w2l1c6bjXF3sTCjM76
 lbe3GEyKXGACPIwrHZ3ACRWTUs2+tcymEj8NH6yhtPUnMRxcIacWQoO
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:25 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Add SPL_FIT_FDT_COMP so a board can select how binman compresses the
devicetrees in its FIT (none, LZMA or gzip). LZMA and gzip are the only
algorithms the SPL FIT loader can decompress. The default is none.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 boot/Kconfig | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8fcdc36c931..b84a75062b4 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -236,6 +236,38 @@ config SPL_FIT_FULL_CHECK
 	  advantage of bugs or omissions in the code. This includes a bad
 	  structure, multiple root nodes and the like.
 
+choice
+	prompt "Compression of the FDT in the FIT"
+	depends on SPL_FIT
+	default SPL_FIT_FDT_COMP_NONE
+	help
+	  Select how binman compresses the devicetrees in the FIT. This is
+	  independent of the compression of U-Boot itself. SPL must be able to
+	  decompress the chosen algorithm. Only boards whose binman description
+	  uses the fit,compress property are affected.
+
+config SPL_FIT_FDT_COMP_NONE
+	bool "None"
+	help
+	  Do not compress the devicetrees. This needs no decompression support
+	  in SPL but makes the FIT larger.
+
+config SPL_FIT_FDT_COMP_LZMA
+	bool "LZMA"
+	depends on SPL_LZMA
+	help
+	  Compress the devicetrees with LZMA. This gives the smallest FIT but
+	  needs the most time and memory to decompress in SPL.
+
+config SPL_FIT_FDT_COMP_GZIP
+	bool "gzip"
+	depends on SPL_GZIP
+	help
+	  Compress the devicetrees with gzip. This decompresses faster than
+	  LZMA in SPL but the FIT is larger.
+
+endchoice
+
 config SPL_FIT_SIGNATURE
 	bool "Enable signature verification of FIT firmware within SPL"
 	depends on SPL_DM

-- 
2.55.0


