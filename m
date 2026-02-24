Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811B8EF5862
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD62383DEA;
	Tue, 24 Feb 2026 17:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="NItaI1Kk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16DDF83E13; Tue, 24 Feb 2026 17:47:59 +0100 (CET)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::1909])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E951483642
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fL3Ym3vD0zq48;
 Tue, 24 Feb 2026 17:47:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1771951676;
 bh=c5uK+MTrXuMJLgPfk6GtdAKd7s1Hkc8XnXXs4y0peSI=;
 h=From:Date:Subject:To:Cc:From;
 b=NItaI1KkMnAzokXt3TXMBvlM2oVBzfDKT1QHIEKsEHjv5at0JBE1zatpJkXciRxbp
 1SRuf0pVddm7rXqUyAmQQ6ktuAW1FS7t+2Iae9R5o1XZTRfdFXuZwg5N8s5MHAIB3E
 aqu4gilwqJphb/qw/u6YAmDvUHEWX/218ZRmcKFwVkn1eowmPNcRIBRIzeYwEjdxei
 1xepf5iqgqs3Gfz8y8mTn8LQ4Ei8DMwr7xDLKfxVoqrM1+RdrHDeYoi9JKvm8FyUrN
 zuhzxwrnzu52m2+IlLbDORtg4A3/lOtEeHeXwen4SC2iALPrrBqTVFl6E15eK7jHBb
 gyhQy3LAYR+8Q==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4fL3Yk61QBzd6f; Tue, 24 Feb 2026 17:47:54 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 24 Feb 2026 17:47:43 +0100
Subject: [PATCH] kbuild: Ignore phandle property when diffing base and
 U-Boot augmented DTs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-device-tree-debug-no-phandle-v1-1-10bd3f3a3498@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMzQqDMBAGX0X23AWblBb6KqWH/HyxKxIlURHEd
 3fb3mZgmJ0qiqDSs9mpYJUqY1a5XhoKH5c7sER1Mq25t8bcOGoUwHMBlP3ScR550jQO4OCStd7
 6lNyDdDEVJNl++9f773XxPcL8fdJxnHOkC2GAAAAA
X-Change-ID: 20260224-device-tree-debug-no-phandle-caf33b3bffa7
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Edwards <cfsworks@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The phandle property is a unique numerical identifier for a given node
such that it can be referenced by other nodes (Device Tree Specification
2.3.3 phandle).

Considering that when we generate the base and U-Boot augmented DTSes
for diffing, we actually resolve the phandle with dtc such that the
symbol is used instead of the phandle value. This means the phandle
value is now unused and unnecessary.

The issue with the phandle property is that it is not necessarily the
same between the base and U-Boot augmented DTs. For example, any new
Device Tree node with a label inserted in the U-Boot augmented DT before
the last (after sorting!) shared (with base DT) labeled Device Tree
node, will increment the phandle identifier by one for all nodes after
itself, meaning we now have a diff churn between base and U-Boot
augmented DTs only for the phandle property. This is typically the case
for binman-supporting architectures like Rockchip where the binman node
has a label for easy overriding from SoC/board DTSes and since /binman
appears pretty early in the DT when sorted, this means many phandle
properties are different.

This gets rid of all phandle = <0x>; properties before passing it to the
diff tool such that they aren't even taken into account.

Note the double dollar sign in the regex, this is due to Make special
meaning for $ which needs to be escaped such that it's passed to the
shell as a dollar sign.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
The BRE (Basic Regular Expression) is quite awkward, but I think we
could simply ignore most [[:space:]]* if the output of dtc is guaranteed
stable.

Something like

'^[[:space:]]*phandle = <0x[[:xdigit:]]\+>;$$'

probably would be enough I guess?
---
 scripts/Makefile.lib | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 377a4700b94..9f60965f816 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -437,7 +437,9 @@ cmd_dtc_diff = \
 	$(DTC) -s -O dts -o $@.full.dts -b 0 \
 		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) $(dtc-tmp) || \
 		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false); \
-	(diff -Naru $@.clean.dts $@.full.dts > $@.diff || true)
+	grep --invert-match '^[[:space:]]*phandle[[:space:]]*=[[:space:]]<[[:space:]]*0x[[:xdigit:]]\+[[:space:]]*>[[:space:]]*;[[:space:]]*$$' $@.clean.dts > $@.clean-nophandle.dts; \
+	grep --invert-match '^[[:space:]]*phandle[[:space:]]*=[[:space:]]<[[:space:]]*0x[[:xdigit:]]\+[[:space:]]*>[[:space:]]*;[[:space:]]*$$' $@.full.dts > $@.full-nophandle.dts; \
+	(diff -Naru $@.clean-nophandle.dts $@.full-nophandle.dts > $@.diff || true)
 
 dtn-tmp = $(subst $(comma),_,$(dot-target).dtn.tmp)
 else

---
base-commit: cc5550e494693ee56e36ffd119523eeed427dfc2
change-id: 20260224-device-tree-debug-no-phandle-caf33b3bffa7

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

