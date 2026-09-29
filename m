Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7063ECA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 17:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A1B880A95;
	Tue, 29 Sep 2026 17:32:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yr5Caqril6F1; Tue, 29 Sep 2026 17:32:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 94616809AD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790703174;
	b=ZmrLbQm42n1Haj5uRBMAVcLvYSkRH5dh3ijMOEnzJfokir1MIRkf8ViqjaWJzmGPDguk
	 lTilJXfHA6cEHJa/fIDy+2K68AMYKyFDOqCptUk+phwOsZraGQI7sIP9OD/s4sXODCoOl
	 EOk2eqHFV8BGYSlI2Yak4WCOtVVyC90S6Zucm6UwvJvSKlf33plxKU1K362vr4QugPjP5
	 b24Loxi8FT6Gk4z57sn95bKppwd0IYQtoQmX/2Qg1G/c1ZQ+UjhrOPgJWQ1kOQVYBj6+m
	 2430x0FRJPAkAaBEJI6mRrXd2mh47ft8Cex6dBV184oCp94TTQvUASwBfzt2DGTwzrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790703174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/n/6Dmt4KwYiYgWTZxlortWuq67s8yZnDlPQlKjpmL0=;
	b=jf1s/Dk2gLVMhzDZGMf+ese54MN7Xaj71E3ULVYsIc4HsGRFo7UhLjMTYYA2MHyTdov/
	 5x52+/8QCC9kKoQ5wa6xaaVVIH1b4oym+G4C+PpMIdQ3lsvmuMt0/Ulc7lZoHEUxwBchp
	 f3sPsL3KvTi2ovf6LvqS5upPPS56S04gZsf2u9XsPS8zhhE69qFraF2lJP8ZIz9bXTptX
	 HFSzofMKasIBBfPwfTlw8UieH6eGj6TJywgZheCJRN4oMf+JaD85f+8b0LoXrhl6yAR7+
	 TUM6pQeJ0Ij6R9G1MhsV3zqhT6hwPbqXtV344tIKBtHpz5TPZonniotz8X4ida7HtuA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790703174;
	bh=/n/6Dmt4KwYiYgWTZxlortWuq67s8yZnDlPQlKjpmL0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hvLnBBpQ2TTME3Q+Bpd+yFGWpFbhjYXx+9Y4F3dYNi3K2S8PWa0K3qTyxLyttGCKL
	 qGs/1vv5zELJw4ryijR9qS9mhZ0pK/bGMaLnFes22td0CdUNK1Uz9KmhQBHqfZRM58
	 8hDtrrWV5Xrv6wwzxz9+9pY8Y8IHYVyNb2RvPkyUeN8nOS0TE4vwgKlfo4Y73Q6K/f
	 YvNgzQksy0qxmhJvEZ3lyWkI0LWUVSHd2Lra1jT5u1/eKxkHKiTP7YBGlk70q1WQvC
	 Cc6S8aE72k2tQ7w69t1HD6BOqXADl7QScwthMUAz67IySG6ZkXH2GaQVM0crNUQ0BB
	 /sh1q3eqYkNng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94616809AD;
	Tue, 29 Sep 2026 17:32:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC5CA32A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:32:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E401607B6
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:32:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9rQf-FATmyK for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 17:32:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B871E6071B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790703172;
 b=RhdO5BAVMdm95bZ2K8KrAgHn3hU6FUMDqOSl7i6fRSaafrXGy8XQhXQH0wBdVoiN+t+2
 WsJE1IlanOzhr6lVZBl0+rdC2Ab6/S3u+18wCRSgtOwSMxnBW0Ovb6yIciHbh5n6XIvpo
 i2gkOWrPH63yNdQ6HH9hSHLRpc1SoZlxvonHtt6Z1LNXEfNWEzo0y44Zc4ZYx59Mm7JTk
 Lq/RVXX7r8f4HWYEqI6cI9Vpa22VGgXs5JUhIhdIBGyyyTOaxURIyXMhtFK08eVnbdVH8
 DAKaKoCGrSGdxtFcQgXZWLz6iHBw3vnIxsNHSjmP8rmMeysgget7vEGKAN8JSaMy9Jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790703172;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:
 X-MBO-RS-META;
 bh=/n/6Dmt4KwYiYgWTZxlortWuq67s8yZnDlPQlKjpmL0=;
 b=J//zYA/HcTPApvdPkiA4aAvZA6bWDH6n58PtLkwNWu2Ptkmw7ypgsYlupJfOGaCuKV6X
 o96lNpteRSSaux/ytuD5Gp0DDYIl1SsQxCWL/dQDaFNMocJPULzBYW/LVFaBY8fYJMSCx
 sRKuT4FL67wF4GqkOu/5ULs5J4bpa4aN0YcJHi9VOAEv/CPHLgTwpXQqVd/ia7qwdvI5R
 +8k0UwBW/6Tca2xakFD7+NWQuSdpEwKFU3VOgdASNTYx/E3LIquZav7+9qSu6h68ZXWOE
 D3zsIcrUCVFHLcDnPUNaRhKMay7R6IUX2G1mI7rv2uZbilgg8XQWImT5xXcO8YXIMUQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=nChVEvN9; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=nChVEvN9
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B871E6071B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:32:50 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hvQHL3dYXzMllW;
 Tue, 29 Sep 2026 19:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790703166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/n/6Dmt4KwYiYgWTZxlortWuq67s8yZnDlPQlKjpmL0=;
 b=nChVEvN91UqQi39QYTGQF+bnEbcbSssgqZuIaKMihBKRQlhjK7dppXWLRov2HjYhikd2nc
 OaXSoP3oIzNnPvjwySunGjQkuWGMcGSq/He21J+k3eQV51tHgVE11+R0gbuggQPijB0qR6
 rDBK0xElIwe87TqIOMwZsBD73d2EzidgtCFyIIVmsyn9uvPcfgYUNbNmYyJ8JCqJ7skd/q
 m35MVrr1Owj/TnqBOjtrrYy9VDXtXtWrp3rJW4WCUPqgxSIQyvf059Oh5wQuDWTlnKgWpm
 Pw4+e3XiNFi/sUYgWH7WPcRC/Scftv2Crcd8FoI8AlWyApOPNh1cUDB2/tKt/w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: config: Add additional embedded text option
Date: Tue, 29 Sep 2026 19:31:59 +0200
Message-ID: <20260929173244.369402-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3a679fbd37fa5a3438f
X-MBO-RS-META: ffss8ombrrw9fucgjthrpc5ypae1mcuo
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

Add empty string Kconfig option, which depends on CMD_CONFIG and lets
user embed a short piece of text into the U-Boot config, which is then
printed by the "config" command as part of the embedded .config.

This can be used for example to embed OE /etc/os-release into the U-Boot
binary, which can then be used to identify the exact OE build from which
the U-Boot build was built from:

Insert content of buildinfo:
"
$ sed 's@$@\\n@' /etc/buildinfo | tr -d "\n" | \
  sed 's@.*@CONFIG_CMD_CONFIG_EXTRA_TEXT="&"\n@' >> .config
"

Print the configuration option:
"
=> config CONFIG_CMD_CONFIG_EXTRA_TEXT=
"

The output is a one-liner print of the embedded string, it is possible
to interpret the result and the embedded control characters using e.g.
echo:

"
$ echo -e "-----------------------\nBuild Configuration:  |\n...\n"
-----------------------
Build Configuration:  |
...
"

Please note that this does increase the U-Boot binary size, and
therefore use with caution.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 cmd/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ff90a87024c..0d8b152f12c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -170,6 +170,17 @@ config CMD_CONFIG
 	  command.  This provides information of which options are enabled on
 	  the running U-Boot.
 
+config CMD_CONFIG_EXTRA_TEXT
+	string "Additional text embedded in .config variable"
+	depends on CMD_CONFIG
+	default ""
+	help
+	  This option can include additional text embedded in U-Boot .config,
+	  which is printed as part of the .config by the "config" command.
+	  This is useful for example for embedding build information into
+	  the U-Boot binary, e.g. content of OE /etc/buildinfo, but please
+	  do keep in mind that this does also increase the U-Boot binary size.
+
 config CMD_CONSOLE
 	bool "coninfo"
 	default y
-- 
2.53.0

