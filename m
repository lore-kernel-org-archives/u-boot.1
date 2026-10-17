Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7740CCF2C7
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F64E814C7;
	Sat, 17 Oct 2026 13:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BEYpYSJufVg0; Sat, 17 Oct 2026 13:01:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2540381491
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242098;
	b=YRSuRvUzaWWTvDFMWwsvnmxp+qvt57Tbvw3cZ1lF1w+s+usQIRrioxcBvtEVrSNU2Brx
	 n+1cWPA1nMKMhLfdz1tsF8x8YiLfGR76ts5zBsQGv8azA0K1nfvgZ7rOmbJSvzObez6E3
	 xyxJVCf0av84cMbKnfq1n7y2H3OloLCg4qrdhEFl9pJ1okIQqEBp8SFRYBsQONTEn+sqk
	 q7T4Ya27be9SmmT8GK2N2hfMrb6xJ+X1z7TAS/z7CoFOLUUceMAVpYvAP7KXs+Fa3YYR+
	 pPpmvn+8y0loIyNfW9Mikdd4fbciG9TvZMpVul+9yW4B4wujXabUW5uC39jUlaUK0Nw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242098;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ZsZsxH8LjovsFTM/BwuiiYZhbogS3/J3xH2/4EaeBBM=;
	b=tXtksxJdTQFmG+tYbKSBFCT618jKjUps1JriSgPzW6peAJBPt24qjZwVKKERi/54lEg4
	 y+oHOEbbu76MmUT9xD38Y8DnW3zzRYtD/VRbFOmDPdl60iQTk10yH1iCkOsLILM7g2H8F
	 +FkOlZWtrjWEHQdV/1paTUFTycm2sf+wwLJJ/nHUlCqkZzRcJ54cXLVcJd7nP0xdAYyiX
	 DpI+4ZpKWk6aNuNZFoBfPu/ECLThRELbRSHBdsOBqjW8EI08nXo9FRPat8QFcf2jxvfrZ
	 MiiF3d2RNmm2NaWpFtYCXSr9HZm8un3IuAas8npv5usXzWFnSvZBsBlZ5GpBQvA+Shw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Vuk+w9UQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242098;
	bh=ZsZsxH8LjovsFTM/BwuiiYZhbogS3/J3xH2/4EaeBBM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=lsclxtJkWO5LqDkJKTTVBMEyhH5yHWskcintJGArOlpaa6yMV+mfSzSsbCxuDbdMh
	 x6lSg4CTrinSeCQTtUzuqCKpgV+dn/RZLQPEYWEkJGn3IPdwHkqEsSL9pZdAc6TQx+
	 4rXzJZ5Ev31tTJEdG+sqd3AdhJlb1AF8URb0RwEDkF8bnzjsZo7wIlBcCae4Yp+dU+
	 8auBzYgAJVECkkhCt4f4rJMOx2NTmb/OPWn0xlO4RbjkUmJY8FCe2R3v5PLGlaEe5H
	 0kTac6NJlPEZ0H5YRFNNorPkUFro8hH2rG/LnC/LGsZEX7JZjSalVFcHslro7MJwy8
	 qFZiC1tJYuNcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2540381491;
	Sat, 17 Oct 2026 13:01:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 849077AD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76C8B812DB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 19IFP_1mqKwz for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 68192812DF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792222780;
 b=iXEiHijnLZZP5GLrMp6WrSe27EZdbe0CvIvT8UGqYcxlx7q2nNp8c5pa9abWQWorOvYw
 ZAtfen0pCY7OBgThMUYMNC+AQY8sqsul0qKjxq3RxF1CqGiDDL5TGeC3qd7e9n1XwJqJm
 FCuwVVDRXAXQV4Lxxq1bPeeDCBMj1EgP48IJEljqMY6F2gPxGzLZqeRMcKWmj2K1N2+EP
 MQfNQqXsb783XP5GKtDutMofUcTDFFBJGsoRt8wc9vwmCn9UgN3EAAL+//GuAYp1x+GGP
 56LrlSOyYebjv+XtbXwEu/vOsX08uG11UqWLIafWKZ4GOjCYbDr8h5XPqnCRs96vuKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792222780;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=ZsZsxH8LjovsFTM/BwuiiYZhbogS3/J3xH2/4EaeBBM=;
 b=Jx0GkIQKJPmiAb1OUJPCSEG8sAMXGr4CT+PLtb+ymqW78FhT6VlEIZ0Yn0iobZEpr9E1
 LYI1t+YdyTOaHw/p+8PJk20mI+flrk4iUMWwxRw1TKxAunBRfx33IJf9JjWvF1L01c1gh
 Qi9fEgZA1IxIxx6qiXrVnILUnEOYwUm0hIksqB91QiCpJxsSO9CEMaYUKZo/QH7VJWudy
 xlsVS+IW85kPU+ii+RSdhUWdjPWjvU0ztkMDOYcntcDquoMMphThy4i81oPpPNmqC76Zx
 sAyNSo1enihgRYBdKcQK1zVhScfaq2LI9+QLc8prQsL8vu5HhayOr1QHkbdHPodSUSw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Vuk+w9UQ; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Vuk+w9UQ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68192812DF
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 49F1860A9D;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F25CFC2BCF5;
 Sat, 17 Oct 2026 07:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792222778;
 bh=FF3S2yi58tQ3DFXXoJWH0P5qSrgVFpf7CVY3P6mPwkc=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=Vuk+w9UQU3li5kTwbaWAG5wIXlgV9hIrqZLKLLMxFanks7RapgRZyR2bIFm4lQpzN
 TD4qNeSuqqnA7qKWIS0Bd2eKz3awzVNI7kgKlhqovAy7M6HUtmHeJA2ZJ7lHlksaoA
 0+uiJmVptvbQNx6F0+tSDPUJZyNTxXZ3jiItZWTBU4272rqMcSgRvNFHL63LmLlzhp
 3lCghH6c830mLHAx3p7ncqXgSConjA0aM5DOOHODGkrUHoGeHVeFC5WslePepP8Ffa
 dxerFOUMQxr6sQpCwGapFKFJKP0K/fSt+3X9OdpqSyKZSURlwV2A8D8qBv4KNeGKbr
 cdZ0Qe8wfmwJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CC54ACCA462;
 Sat, 17 Oct 2026 07:39:37 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH v2 0/6] binman: fit: Compress generated fdt images and use
 it on Rockchip
Date: Sat, 17 Oct 2026 09:38:59 +0200
Message-Id: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ7CIBAAv9Ls2TVQCzae/IfpoVBq11hoABtNw
 9+F+gGPk52d3Q2C8WQCXKoNvFkpkLMZ6kMFeurt3SANmaFmteSMM1QNKrJzb3GkiOMQUbt58Sa
 UTTxxKZVWAxdKQG7kwUjvvX/rfhxe6mF0LNFiTBSi85/9gZUX799bK0eGTSOFEO1ZtFpfF++iy
 z49j1mELqX0BencgBjhAAAA
X-Change-ID: 20261010-b4-binman-fit-fdt-compression-3166bcbd15b5
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792222776; l=3027;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=FF3S2yi58tQ3DFXXoJWH0P5qSrgVFpf7CVY3P6mPwkc=;
 b=P/m+f1TD9T/sggLrKpIRvGHMPiW/05wqVTC2zGLKpTTl+y09Ih17Kd1Xnj3whHJzdE0Eqz1m4
 LsAoJUxicQ7BUnJaUPlhKNiO1UiTqFJDWnrBKCUQNw584ypmysPYo3X
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

Entry_fit's @fdt-SEQ generator always embeds the raw .dtb. Add a
'fit,compress' property so binman can compress it with any algorithm FIT
defines (xz is rejected) and set 'compression' to match.

Add a generic SPL_FIT_FDT_COMP choice (none, LZMA, gzip: what the SPL FIT
loader can currently decompress) and use it on Rockchip.

The default is none so no in-tree board changes.

---
Changes in v2:
- Use a binman-level 'fit,compress' property instead of acting on 'compression'
- Support all algorithms binman knows via a shared bintool-name helper
- Register the bintool in AddBintools() and handle a missing tool, reject 'xz'
- Split the test device trees and tests into their own patches
- Document the property in the Entry_fit docstring
- Expand the Rockchip commit message
- Add a generic SPL_FIT_FDT_COMP choice in boot/Kconfig used by Rockchip
- Link to v1: https://patch.msgid.link/20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com

To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Marek Vasut <marex@nabladev.com>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Petr Pavlata <petr@acrux.cz>
Cc: David Heidelberg <david@ixit.cz>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Philippe Reynes <philippe.reynes@softathome.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Quentin Schulz <u-boot@0leil.net>
Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>

---
Petr Hodina (6):
      binman: Factor out the compression bintool lookup
      binman: fit: Add fit,compress for generated fdt images
      binman: test: Add fit,compress device trees
      binman: test: Add tests for fit,compress
      boot: Add a choice for the compression of the FDT in the FIT
      rockchip: Allow compression of the FDT in the FIT

 arch/arm/dts/rockchip-u-boot.dtsi          | 15 ++++++-
 boot/Kconfig                               | 32 ++++++++++++++
 tools/binman/entry.py                      | 27 +++++++++---
 tools/binman/etype/fit.py                  | 67 ++++++++++++++++++++++++++++++
 tools/binman/ftest.py                      | 44 ++++++++++++++++++++
 tools/binman/test/fit/fdt_compress.dts     | 24 +++++++++++
 tools/binman/test/fit/fdt_compress_bad.dts | 24 +++++++++++
 tools/binman/test/fit/fdt_compress_xz.dts  | 24 +++++++++++
 8 files changed, 250 insertions(+), 7 deletions(-)
---
base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
change-id: 20261010-b4-binman-fit-fdt-compression-3166bcbd15b5

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


