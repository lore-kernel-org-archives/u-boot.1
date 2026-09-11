Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB944C88E45
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 01:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B56674080A;
	Sat, 12 Sep 2026 01:07:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2LQLgrwB95ec; Sat, 12 Sep 2026 01:07:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C5CFF407F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789175256;
	b=faa8DUemIVdOUIk3DFwK3eg5A6uEYwpr52+ds3Z9vlfrOKxyQoJjyRP8xg+Ybe8sHe3N
	 89lqhDZwQs+hgsJfPvT1GH1FqdfluZiySHKwdhB7g5KdS+FMucbqoL5QORn5dxrtSqwyz
	 Z4H0Bkx8hUNoLHjBXEEIm2o04fRxO6msMkGQb/qRVYVCwGxGKlvC8xg5OZk1Z0RMe7+HE
	 DFxI3V6GSp6RX0vOJ84/ZARbA+Gn+KWSaXwomrywIi8peU5Lqjc76rj2EWPDJa7lb+4Gv
	 wVr9hlXS2GH01efbr9/1Rko8TpCJy53E+m0AT65m0+ZauG5seRba0dkvi0cUFNZ8Zmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789175256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=FO7OGW/+YltbVDqMA8zRlcxsAVGZodgoOGNpNUTVLKQ=;
	b=I1C6o45o837D1HdVc46AJiZUrMHfRleKh8+4ooJMooV3P7b2l+6GFvlf+ZtQuQE9CsE5
	 hWWYltAosRyi9E2EwKLgLEVZbr+3O3ZvYDB4tOnCC3dhjNWuzZ8PFxu2b3ARo86nUkWat
	 QRqmBvjgvFZXBQ0y1JpqwhDp8fyboTQQ0f0h5GBpzjJZ2dkH+n7MkjRaxTnA9LWqdOdCr
	 Xahvdq4XmvPlBanPE+3Q9DPTRnwejxj4xTO3i+qtFgsp76wAbx+AHi3Zc5HUoLpUMtOIh
	 68XmzQ8EPAkiX/lxux2xJfsYLyT5NgDqKxdYc7/7Iwkq4SmISbGWEt6d2SjeyAPHlog==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789175256;
	bh=FO7OGW/+YltbVDqMA8zRlcxsAVGZodgoOGNpNUTVLKQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Uj5Oi6drBCRXPjvV/v8fm+sLbxCpqYsDHtJstWRPCFuRS5cyv4JdNggzWVS7lJ7qf
	 tZnjzkP3PPfeMsgLRRWbs9WpcGrSkzZ9t2VzDrz1N9MnUvO02wIZ+FQOV1BPJeFxLM
	 z5wJNKxET+1R/yavi5wXFTIDEAgsJcmiY5rlWIpgQX+nXARlDM+tyJ4oWMXeE5TU4L
	 X1s7CX0KkFqiRgWxTd7ZhFvy/z3gKrbuLk7raTFySwSH0OJcs4OSmTtAZ6VKgOpYiX
	 qS+g/yQCYdL7XyJLfshqTGtPDw276I2NZe5OvP3DVRidWqr6a6nqx1bQTIFyWQnIDr
	 AzSuuw15MhNKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5CFF407F4;
	Sat, 12 Sep 2026 01:07:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1157F2E3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F321580EF4
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:25:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ll-zMviU0IwU for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 18:25:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3F15980EC8
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789151120;
 b=GJ9cor5FM/4fDXgD+0XbyGi7220pXHgFR7m6lTQfBpNSqqAOqjnPRR2meqWq19e0BMX/
 GLC8FP59F2yA+peDyxVN9OJNiC014lUenR66myjWNbOEGNqBDg1MrYeHU4sq7ty6d3rc6
 XFzczXGzHF0eZg+RcMpKLF7pOkql/hgkJgLvhaMrY8ByymldZ6uQ7xFQNHwPDp8Gk4wY0
 92bYqTkhLsDmUKv+lSknxoPjjGQ3mUiNrOxZcGxivAfaY4Z3N7IpenfvFEZyMcrOzXnS6
 2SldKQrLzt7QmxF0Vy+OJHOnS406qUrBCS1FnD6H3O7/GSNmGKv/jeGrhX076JL7tFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789151120;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=FO7OGW/+YltbVDqMA8zRlcxsAVGZodgoOGNpNUTVLKQ=;
 b=MzQ3hSZ7PqaVKoD/8f2z8NCgAJS04p+xQwv9VqhdBfuOlXuuO+MR1FGggvjS2nh06jQS
 Chx+EMAGjzrMeq+DKyoUn7GnycyJFScHqQ8sn/bAz8tMNk8YgqMdrm7W8TCfpwmbBgcFV
 UtuHIObDV54qM0jNV13b9T+x8pn5AnQ+frUgjtt09mFcyL2nGo+hdiCenzpiNaF0QgOeD
 jb40iLF+EQb7PB7oZCqSzM48ypQOsQxUAWLgby+6lRC/+FfUnYYLRJPJIRr7qonANFG22
 lPfX5P3uwmxORfNcGIAdmORfDsIYI/WOvcQjRnzNcdn1JOUzCjRlEuL77uTWGrBYcEw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b="V9/4t3T3"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=V9/4t3T3
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F15980EC8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:25:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CC5F060008;
 Fri, 11 Sep 2026 18:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83029C2BCF4;
 Fri, 11 Sep 2026 18:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789151118;
 bh=yr4RpxFK0MfMd0wrVuxfMWoV2a6Qx0RLtTf3y4cEM0w=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=V9/4t3T3keTFJLx6Co9lXYXYWDw25QMTmSR0Byr5MfmTbGWawzdebNWwWyx6m709s
 UWncXBjJHZbUKZaruNhu9rySo+z/goUPHdhQJuwrkuEe7oTcq089A7gbfDAc9ezHVl
 JHsn1/ich15trUuqCcH/0x6LCEzhpUtY+M6r8J22dyWOEPE3YvJbNe6q2f4HUPc8gl
 EPrDLsyk4/20RnJ1NE+5ribHwZeSGnWeQn322msGzCGjwdtHJwgvuMeMrkW+m12PR2
 u/B/xzsedpgc2eRlQvuvHOrfWbIcMfZKqI61goNUs/TyGD/1CmQTOHwb7qEeGE7RR5
 QgzEox/xcW36g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2CEC88E45;
 Fri, 11 Sep 2026 18:25:18 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH u-boot v2 0/3] lib: qrcodegen: import Nayuki QR Code generator
Date: Fri, 11 Sep 2026 20:25:14 +0200
Message-Id: <20260911-b4-lib-qrcode-v2-0-c5291fb7c646@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NwQ6CMBBEf4Xs2TUt2gY8+R+GA21XqQEWWyAaw
 r8L9ebxTWbmLRApeIpwyRYINPvoud8gP2Rgm7p/EHq3MeQi10JLieaMrTf4CpYdYa0sFSXp4l4
 o2DZDoLt/p78bTGiYR6h+eZzMk+y4n+3NxseRwyeJZ5n6yVFK8eeYJQp0J+2MFkrZUl2HwCP3X
 e3bo+UOqnVdv9YxPDjJAAAA
X-Change-ID: 20260611-b4-lib-qrcode-a5ce89e68f85
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789151116; l=1960;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=yr4RpxFK0MfMd0wrVuxfMWoV2a6Qx0RLtTf3y4cEM0w=;
 b=3OvYD6ozwpEcp11dvjtWCv+x15YW5hwFtWAfayoy15pbBk8Gntv7RqEIcYf4MjnfEdFtgihMy
 gIVZOb0zPFGDwQObRO5xnc+/CK9n74x/1MXJT9B9PgjBpei6sXhzZ5B
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 12 Sep 2026 01:07:23 +0000
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

Add a small QR code generator library so U-Boot boards can encode
arbitrary text or binary into a QR symbol. Main use cases include
displaying URLs, pairing tokens, serial numbers or
self-diagnostic state from the bootloader (e.g. during porting to a
new mobile device with no serial console or usb peripheral working).

Optionally apply gzip compression for the QR code payload.

Three patches:

1. Verbatim import of Nayuki's public-domain / MIT-licensed C QR Code
   generator (qrcodegen.{h,c}) under CONFIG_LIB_QRCODE. No code
   changes and the only adjustments are SPDX header, swapping <assert.h>
   for U-Boot's <log.h>.

2. CONFIG_LIB_QRCODE_MAX_VERSION (int, 1..40, default 40) so callers
   can cap the maximum QR version. The version trades payload capacity for
   smaller static scratch buffers.

3. CONFIG_LIB_QRCODE_GZIP (bool, depends on GZIP_COMPRESSED) and a
   helper qrcodegen_encodeBinaryCompressed(). Perpends four-byte "QRGZ"
   magic header so the scanner side can detect and decompress.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Changes in v2:
- No code or commit changes; correct the cover letter's To: address.
  v1 was mistakenly sent to the old lists.denx.de address instead of
  the current u-boot@lists.u-boot-project.org.

---
Petr Hodina (3):
      lib: qrcodegen: Import Nayuki QR Code generator library
      lib: qrcodegen: configurable maximum QR code version
      lib: qrcodegen: optional gzip pre-compression of payloads

 include/qrcodegen.h  |  407 ++++++++++++++++++++
 lib/Kconfig          |   44 +++
 lib/Makefile         |    2 +
 lib/qrcodegen.c      | 1034 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/qrcodegen_gzip.c |   45 +++
 5 files changed, 1532 insertions(+)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260611-b4-lib-qrcode-a5ce89e68f85

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


