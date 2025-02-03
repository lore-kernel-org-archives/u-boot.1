Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83D4C02197
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 16:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A0F5800B3;
	Mon,  3 Feb 2025 17:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="Xg4s1SeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F7A0800CF; Mon,  3 Feb 2025 17:42:29 +0100 (CET)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1773F80079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 17:42:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1738600945; x=1738860145;
 bh=z8oFcevXI+EzXxS/qxMWVoO+gep99cSmi2JDjmCKht8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=Xg4s1SeBdrrUhgbD7FopmnX1wvLoRYOuMdBhcQNumQ2rZM0Ypfuludi9Lk7Ec94ZS
 WP3jDHtPtCDWTp4HVkQZZW+TVhldKnJwZjiHI9XqzpMr5myqJeuv2FVAru0pE8KcJ5
 L/jP20n0b7zfquXS5tpm9tO94S2GwIlr+pkGdliU1qaq0lPMtDwVedwzsZWqhKIlrn
 ykrSA8uZqZs4mNj0c9vTIkZmah1T2G60QAZfI6ouEUE2IS9PlNvBQ7SHicHKGcsa1R
 p4+E0a/7U4dguOpjodkpy3LDbRVcUaVlK2GMXe+PEIW/G15aQ9IwNU/hBkq9uSlHdR
 zLKZgJ0pmBuGQ==
Date: Mon, 03 Feb 2025 16:42:20 +0000
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH] cmd: ufetch: use 3-bit colour ANSI codes
Message-ID: <20250203-ufetch-vidconsole-colours-v1-1-a9e543ef4cde@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: a884d3a3ef201d777c1f8727576cc8d89d658bdb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Currently, the 8-bit escapes are being used, which aren't supported by
vidconsole_escape_char. Since the current usage maps directly to the
3-bit equivalents anyway, let's use those instead.

With this change, the fetch output looks as fetching in the vidconsole
as it does over serial!

Signed-off-by: Sam Day <me@samcday.com>
---
 cmd/ufetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/ufetch.c b/cmd/ufetch.c
index ed5a856c7abbe08949b81e0b2f634edd8b390be5..46bd16824e613104a0c7f5b53ef=
274ffb8209c17 100644
--- a/cmd/ufetch.c
+++ b/cmd/ufetch.c
@@ -24,8 +24,8 @@
 DECLARE_GLOBAL_DATA_PTR;
=20
 #define LINE_WIDTH 40
-#define BLUE "\033[38;5;4m"
-#define YELLOW "\033[38;5;11m"
+#define BLUE "\033[34m"
+#define YELLOW "\033[33m"
 #define BOLD "\033[1m"
 #define RESET "\033[0m"
 static const char * const logo_lines[] =3D {

---
base-commit: 2b1c8d3b2da46ce0f7108f279f04bc66f1d8d09a
change-id: 20250203-ufetch-vidconsole-colours-0e6a9ebe2475

Best regards,
--=20
Sam Day <me@samcday.com>


