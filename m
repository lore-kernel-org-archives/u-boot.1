Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF69DCA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 19:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 798046071B;
	Sat, 10 Oct 2026 19:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VH-EpCguyRL0; Sat, 10 Oct 2026 19:10:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9768D60718
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791659401;
	b=ONVtM91RHBp/ti6uMKI82r0iUR/iGMMFsbNygTEhqCvJROUlJXI/WAj2ASwFu7ll2k2m
	 V/4uzDm6Hzvf+HAhkER08z/JcaTIq56YC+ehZ7ChxAeyYFvgIAnBIUhchlloCKZnFL5hJ
	 j80LPvxsfkvmbu+nT+X5aN5cbJLR2XO2aPwBlT8VLUaBwR9+nOsd3FIiDBE/d+yfg1AM0
	 LZD8xt2t7lJ0gFE7B2YI3N1u87QU1IAi1LoAIwIKIWTHuHPCKIxuSYDm+xv1rBG4JXqr7
	 JHOEkx/e+5lgHy61R3J1Kay3B6nFO7HoLmbmcVi8oCDGP67NbEZ7XpJxNpvluwqAZ6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791659401;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=rPg9ECB7daxzgrpbF8lp9BkwiJWNwBTMeQYg2kCzeDI=;
	b=ewCO3nXtaBgFfsJHFAS/GsIC3MUyHETwfSuYCh619e4C9xYsNxfATSlPHFqAN2t0kG01
	 YX+xUa/ilRQbqlY4G+zeugYVZ+lRpY9pPvYbk31KGYt9ycyjPmltFuHSw0obCTrxGvB/W
	 TwtXGGsgEQTvD0cTF7IwNjIyo5oUNX6XUxrZt+wmw1N20rohsreA+a3fJnQy0E8yapXCs
	 yDA7waMF6eyKrtDDsR8UE9cQnupnw1Dixvi4eA9+RFpCAM/j50wA/aSPeT3SPD0B09L/o
	 XxWSLQOZsx0TToFHNqwXXtEn3XxCM1Hgblf9LmY7Fqw83vti/JPx6i4APDQpZ/v/WLQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791659401;
	bh=rPg9ECB7daxzgrpbF8lp9BkwiJWNwBTMeQYg2kCzeDI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=oM8uvr0fs9FPHreFYghdxS1VpVRP8I+NXVRwp3RSa4iDUxW9TDPkWZPQpLM6R1gva
	 9n1JsGN2qGTON0SxMZJDBL46okeejhrA06nbYjB08FlL3BQt6PT3oXjQbmt5nTVETx
	 GCUKfR0YASysl0TLUMK3xpLTaa3ci9RhIj5n+XloFpXHhDTfXCDtDdxyPciwQuUV9d
	 ld5b/XfNnRuvMLBb7w6fne2Gs3WgNRF/zJGVDNwpbGwOgcfTsPoKTMgeDCKI5FYrKh
	 PxBmRQ1Ds5bOJmmmijDkdjT/UC7q8m4EFyc6yfQR0KlOtJdh6Kczg+0Fk0QeXZePG8
	 F8IpoAR8NZuZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9768D60718;
	Sat, 10 Oct 2026 19:10:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CDF5317
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EF9381209
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id voqoSfhCOetj for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 14:24:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DFEEC81208
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791642295;
 b=mccNhQVBJNOfcBYe1SKHTz6sMrco6raxN3tw8IxnFygUZTCrD5ZX/b3xtupAhioc73XD
 Lu+cWR67uCrnfeCAC1Jc9f7G2Cf4sMsnMI9XOlVVx/TYjMlY70GRGIiPXGMi+udIUY7kv
 HyH6YNfLyM8oC0O7Av/63fVfzc5JQH9QkdMxf2gcjJkB7G1YEcI3lFE9yHa2tU4vPG6z+
 ty+XTwDA9YlzFIOMGQznn/EA4ytn0N6bu5dclodGGToJPxQ50AowdybMTf4giB76sDGse
 8f7Panclk9XwtgbjPzjKWWiD6wzq+eMYtpgK789WUjxJjDnsh2eMBnXJ4rZkvGo6EDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791642295;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=rPg9ECB7daxzgrpbF8lp9BkwiJWNwBTMeQYg2kCzeDI=;
 b=pWp/qMyH49PDYX2b9UVirftjGmQmDv42q3Jq8usudPDnqpPqBr7eylrNUI1iOde4Ffuk
 fCUvL0kH8ZwSNehsAH1P3V9jzo/9u6F8M2CYIinfKkT3JhHAkteJdGeafM/1DBHuDslbK
 XAQvt1cHqIjjwwTeHe690J/qDY2+5ln2zScf9yHoadvY0maJKHih2U0OGudSAhZ9OghSP
 +0GeHJZuJy1gILKeXnb9S0OhkkYuTeGZAOLkw24Xj85L32w47+VL7AYeCK2mhthLPh+hq
 c4Z42d60CEVFZrL5Bd6sAfgj7deTuy8RlthHiCkYNp/O/6a35EtDgRQaD1q1xeq14tQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WnCWU7Q6; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=WnCWU7Q6
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFEEC81208
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D7680600D4;
 Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A4F9C2BCB9;
 Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791642292;
 bh=qJWDiDovEmfT81HjKbVzJn0ktLPTALKy8ZNdma0jFio=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=WnCWU7Q6H3FjHDyrOPdlXrUjhpy4iMoBPu9IX/Af0mZzuFfjEDyWofNhXXTt2KMfJ
 +53yMhPUv6Ac/l6aRd3hp/5ZEjsTWZeqR0mdLWVhl+1g0Ph0lt3kxSkK2uiiLa8Rfg
 4TUB/mrE+iv6B/NsVYy4aGXR0VNDV0cDB5SsX1Ayag4Upih92xnuQ5rZ/OX+IsWhjJ
 0oKyNxs6aJFGX0pTV1FYG5ZqIIYefPqjBha4tSYBET7oJ+NX+NB1SWKegyAHUTgdmU
 YlcViY7RfN99n7rt76qWk9ybxOufSy2K0gcUTKBVwRZdXe1mDtI4a61fiyNhekvRMx
 h+6y8pY/pZn/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 65115CA9EC1;
 Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH 0/4] binman: fit: compress generated fdt images and use it
 on Rockchip
Date: Sat, 10 Oct 2026 16:24:44 +0200
Message-Id: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBCF4auUWTuQqW0WXkVcdJKJjtBUMlGE0
 rs31eXP430rmBQVg0u3QpGPmi65BZ06CI8p3wU1tobe9Z4cOeQBWfM8ZUxaMcWKYZlfRex44pm
 858CRRh6hGW1I+v3519u/7c1PCfVAYdt23Ar8ZIEAAAA=
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
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791642291; l=1548;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=qJWDiDovEmfT81HjKbVzJn0ktLPTALKy8ZNdma0jFio=;
 b=B50cU6mk0REWRoQr3ppNbOZpaXEVWMyRDOyzng6LXmnNkWictjRzwgRlE210zOSOykXKZJltb
 Knsglz7zczfA9Kxm9iyxpn18IYgAkXZC9SHLGdrJ4hi22AkMPgipYI7
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:09:53 +0000
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

Entry_fit's @fdt-SEQ generator copies the node's "compression" property
into the FIT. However, it embeds the raw .dtb. A FIT can therefore claim
"compression = lzma" while holding uncompressed data and SPL will fail
to decompress it during boot.

The patchset fixes the following:
 - Patch 1 makes the generator act on the property (lzma onl)
 - Patch 2 adds the test device trees
 - Patch 3 adds the tests covering both the lzma round trip
   and the unsupported-algorithm error.
 - Patch 4 uses it on Rockchip where the shared @fdt-SEQ template gets
   FIT_FDT_COMP, "lzma" when SPL_LZMA is enabled and "none" otherwise

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Petr Hodina (4):
      binman: fit: Actually compress generated fdt images
      binman: test: Add fit fdt compression device trees
      binman: test: Check compression of generated fit fdt images
      rockchip: LZMA-compress the FDT image in the FIT based on FIT_FDT_COMP

 arch/arm/dts/rockchip-u-boot.dtsi      |  8 +++-
 tools/binman/etype/fit.py              | 12 ++++++
 tools/binman/ftest.py                  | 29 ++++++++++++++
 tools/binman/test/fit/fdt_bad_comp.dts | 72 ++++++++++++++++++++++++++++++++++
 tools/binman/test/fit/fdt_lzma.dts     | 72 ++++++++++++++++++++++++++++++++++
 5 files changed, 192 insertions(+), 1 deletion(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261010-b4-binman-fit-fdt-compression-3166bcbd15b5

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


