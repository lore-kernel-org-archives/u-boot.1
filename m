Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D44C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 11:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3645487C10;
	Tue,  6 Feb 2024 12:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Hn50o0kT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57B9387C68; Tue,  6 Feb 2024 12:00:09 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66CED87C10
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 12:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707217206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5o749myclnPNn7FAdtTsVOsfxD7mJTPfAIF2xDbgT9o=;
 b=Hn50o0kT0lOR8L18A4QkSAuYbzelfajrcDRDdw4VCMZZqAnBYHqoYnIpym0CWe60nXv7wc
 t1JX3kqxLZhuEJgkQDSYi9jpRIRO4zPSqx1sTWzdXgkHoWlCCP3wy8j2VWp/R5ihT5lpVe
 1yLuUV3h3YPz1fh6AhXMJCyPiH28GYXewt8ofPbK0H4l1i8HKXgcHVYc89qry6L/k2japH
 azD6YbE6WEl/4METz0+cp9Tn0YNPx7cE5fMX0j6hUzKi4iqhqwzcYXW8P5rmSbv02GwMRF
 7NmBVAOgKPsC4wk0btamGIxs+WP30QK3RkhD2sHwqhxAjjH7QsCoIvkt9jSpHw==
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, martin@geanix.com,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v2] scripts: dtc-version: Don't show error messages
Date: Tue,  6 Feb 2024 12:00:04 +0100
Message-Id: <5ece6e37de9321ad1c2e089659cbd80355181c4a.1707217112.git.dsimic@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Prevent the error messages produced by which(1), such as the one quoted
below, from being visible in the build outputs.

    which: no dtc in (./scripts/dtc)

This makes the build outputs look a tiny bit cleaner.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---

Notes:
    Version 2 incorporates the suggestion from Quentin to use a more compact
    version of the redirection, which is already used in multiple places.
    The original motivation to use the more verbose version was to prevent
    possible issues with some shells, or with some older shell versions, which
    may not recognize the compact version.

 scripts/dtc-version.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc-version.sh b/scripts/dtc-version.sh
index 53ff868bcdce..18c59ac1e255 100755
--- a/scripts/dtc-version.sh
+++ b/scripts/dtc-version.sh
@@ -15,7 +15,7 @@ if [ ${#dtc} -eq 0 ]; then
 	exit 1
 fi
 
-if ! which $dtc >/dev/null ; then
+if ! which $dtc > /dev/null 2>&1 ; then
 	echo "Error: Cannot find dtc: $dtc"
 	exit 1
 fi
