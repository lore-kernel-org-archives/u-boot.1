Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAA9C27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 16:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62148875B9;
	Sat, 28 Oct 2023 18:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cu2qzQNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91DC8875CB; Sat, 28 Oct 2023 18:58:32 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 747E887561
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 18:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7789923612dso232237485a.0
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698512309; x=1699117109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BQv2bBwIY6cRG62LYeaMcmAo2KJKmvcx7twaVJexniw=;
 b=Cu2qzQNszrk8D79AtCudi9cbSP+/S/i3fVGbFA2wLzwuFVCL+N0UnHVGbdiPrcRWaD
 tllNw1SluRb/8Zy+HvbRIdS9Ee/dYqrePzb9kUe6CYKu/gNyfxY4IbSQYb94yaxdT0rX
 CndY8BPYS72CYzqvvoXlryHSfT2xUlQ+88Fqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698512309; x=1699117109;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BQv2bBwIY6cRG62LYeaMcmAo2KJKmvcx7twaVJexniw=;
 b=WFdF/oWGb8jYuRC7/qCFM/H/besT0DcchFyI8+LvMGZ0abj0n30XMZO5LwBANSNy0E
 VH2EA5XgF5miBMMVX6FOBzadenOinai2QTD1ba5gGQsUjRZHzdRW/DYcHTkExuXJ7pIR
 PYRkWusmSQffv8TpBVNySVoLaHsJ4YMniiTrwSQpBx8Al8EyfOh3YQgW212NjkXbZ4q7
 buPWTgvZqUSHzqL7bPMOJYGUjE9j0tIgYQ7nqC91ikVx+nHWmKvC9+m98oDtmbtE8GI5
 QMBbpnr1uOZTg0ZohrT6tn8JQ6yBIej36v8Iiqp1T5g2D7Ht1ebC4en/ULw5VIda+qCb
 msFQ==
X-Gm-Message-State: AOJu0YyT7J8eanMAHPWbCpV6zUMp11diy33rFNu86tEPuA5m7Te33b8L
 epWYICNgmJGKfpdsEEJf3uvON+ORw2sikZh/UCY39A==
X-Google-Smtp-Source: AGHT+IHXpl++5rfLxu+HjocB1VbWjPTneUQGX0C+qw/9271GsCIAumE6bilNm0O+wYsX1TuAo+fsZw==
X-Received: by 2002:a05:620a:4116:b0:775:9040:cc69 with SMTP id
 j22-20020a05620a411600b007759040cc69mr6173523qko.60.1698512309051; 
 Sat, 28 Oct 2023 09:58:29 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a05620a28d500b007743446efd1sm1698704qkp.35.2023.10.28.09.58.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 09:58:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] get_maintainer.pl: update from Linux kernel v6.5
Date: Sat, 28 Oct 2023 12:58:27 -0400
Message-Id: <20231028165827.3305310-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Update U-Boot's version of scripts/get_maintainer.pl to sync it up with
the latest changes to the Linux kernel's version of the same script.

The last sync was with Linux kernel version v5.13-rc6. The commits to
the kernel's get_maintainer.pl since then (starting with the most
recent) are:
        11fb48961e52 get_maintainer: Honor mailmap for in file emails
        26d98e9f78da get_maintainer: don't remind about no git repo when --nogit is used

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Note that I used v6.5 here as a reference point for future syncs,
v5.18-rc4 or thereabouts is the last time a change was made itself.
---
 scripts/get_maintainer.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 81116e215e51..6c58578e9885 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -981,6 +981,7 @@ sub get_maintainers {
 	}
 
 	foreach my $email (@file_emails) {
+	    $email = mailmap_email($email);
 	    my ($name, $address) = parse_email($email);
 
 	    my $tmp_email = format_email($name, $address, $email_usename);
@@ -1718,7 +1719,7 @@ sub vcs_exists {
     %VCS_cmds = %VCS_cmds_hg;
     return 2 if eval $VCS_cmds{"available"};
     %VCS_cmds = ();
-    if (!$printed_novcs) {
+    if (!$printed_novcs && $email_git) {
 	warn("$P: No supported VCS found.  Add --nogit to options?\n");
 	warn("Using a git repository produces better results.\n");
 	warn("Try Linus Torvalds' latest git repository using:\n");
-- 
2.34.1

