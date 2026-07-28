Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B570AC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F128608B3;
	Tue, 28 Jul 2026 13:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l2ImnPafSjqP; Tue, 28 Jul 2026 13:37:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10EBB6089B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785245847;
	bh=eZzSSkEkX5y7OcpU/nf4dK4xK1M4xpRme9yp88XThIw=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ELofKBH04EXXWeXmNXkS1LXIsL4aVah2LR8zWq89T+QMtF0+3/MUps+h3BFKGDx1f
	 7+xgcY4MsKpHx1wjlNqXt3Im9kXXMiNHfIBOyqm7wJ2rQT3xkab1qCa9Dq+fu4GaXu
	 kmwVHrG4WfSus4PilYNITkgokDt1RTAcr8za6yNH9V/AJMIWw3MXw6Je4w5j6RkuIP
	 Z5lA6ulRIiYHJn/L2eXGyPr7PzphOzcHWvNc9rqAx53h5T/0DnQSTeHmkfS4NcbDjM
	 3mCDB3JfF6yaZV3UtYjgxe0uE1rIzzq6MOmaKHJC8D7XqrjOmT56d1gcAhxzUrn1vk
	 sVeAjLZ3FR7cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10EBB6089B;
	Tue, 28 Jul 2026 13:37:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BAC19194
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0F18812C9
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:34:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rBYgSoVlXdBZ for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 13:34:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 366BB812BB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 366BB812BB
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 366BB812BB
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:34:08 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h8bz13rJKzMlGX;
 Tue, 28 Jul 2026 15:34:05 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Daniel Golle <daniel@makrotopia.org>, Dillon Min <dillon.minfei@gmail.com>,
 E Shattow <e@freeshell.de>, Fabio Estevam <festevam@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Kamil Lulko <kamil.lulko@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Michal Simek <michal.simek@amd.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@ew.tq-group.com, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 2/2] doc: Switch from printenv to env print
Date: Tue, 28 Jul 2026 15:33:18 +0200
Message-ID: <20260728133337.15916-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260728133337.15916-1-marek.vasut+renesas@mailbox.org>
References: <20260728133337.15916-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 83krrgotnmaoduygwhneyyy1pmcrcxhp
X-MBO-RS-ID: 5bb659c8da57468c2e4
X-Rspamd-Queue-Id: 4h8bz13rJKzMlGX
X-Mailman-Approved-At: Tue, 28 Jul 2026 13:37:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785245645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZzSSkEkX5y7OcpU/nf4dK4xK1M4xpRme9yp88XThIw=;
 b=nLFDj4kRGdyYO8NXKB7mkPSugJ6rEk9Y+3dQm0mwq47od9t0bEYDl7ylJHdtjcHgp+1d5p
 lKRPJGvEugcS3gN6oDbErmbJiJtYdhr8APCMGXbXDumcz3LRzSXPmYadnOe3lqWx++veez
 poGAOX9DUIUQwy8bGpHoiKgaqyvZGDj9WKPfvyO/m+qj67PVINuwDQ5i1y2kYoJSrflHJ7
 zXvJDagDh1qjw0fjPrH7sSFtjCmjfykyNTK8r07B7h52Sz+8ki4SBZF6SVphoKatOAY4Cs
 YXTtotZ08iPOQ5JSFnBm7NgSBBURrgPm9EjcW7K+2uVKxbjK6XmG5JbXz1d05A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785245643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZzSSkEkX5y7OcpU/nf4dK4xK1M4xpRme9yp88XThIw=;
 b=T4Nv/47TbmxNeLAYEQ++EAnO4mEAnJq8lBV3eHOCRdINzmGJpELKfB51kpGRSQcRcqQscw
 UmgZ5zMcHuVbaFhshRqGrdjG/H4S+PLIVHjsRnCpzBy4UxGjnokqy6DUCBiThotFYAP1Zw
 H9b/4jXtV9vBLQKLr69feoqDFiRueuAr+TAXxfBw72h64moFzofZIXpEF973Mz/llx1sh+
 k+Ur+OkhrNHPaFBBF8+QvG55jPXiQOefBj1rQVG/BPHDKqCQkw9355hA+DkZBq6LoK/yVs
 EyAUXO4kgCeRgFA5C1A5w7sv9GGUBBUAxB+E5qvL8L3VaJhfxy9+PxMvTwYLzg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=nLFDj4kR; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=T4Nv/47T
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="T4Nv/47T";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The "env" command is the recommended environment management command,
its "print" subcommand is the equivalent replacement for legacy "printenv"
command. Update the documentation to use the contemporary "env print"
command instead of legacy "printenv" command.

Note that the "printenv" command is unlikely to be removed from U-Boot
in the near future due to it being integral part of the command line
ABI.

Implemented using:
$ sed -i 's@\<printenv\>@env print@g' $(git grep -li '\<printenv\>' doc/) README

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atishp@atishpatra.org>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Dillon Min <dillon.minfei@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>
Cc: Hal Feng <hal.feng@starfivetech.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Kamil Lulko <kamil.lulko@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Minda Chen <minda.chen@starfivetech.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@ew.tq-group.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
V2: Fix up "env set" and "env print" in README
---
 README                    | 8 ++++----
 doc/README.odroid         | 4 ++--
 doc/android/ab.rst        | 2 +-
 doc/usage/cmd/askenv.rst  | 6 +++---
 doc/usage/cmd/memsize.rst | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/README b/README
index 0e3c278e29d..f740188a4bb 100644
--- a/README
+++ b/README
@@ -754,7 +754,7 @@ The following options need to be configured:
 		directly type `$name' at the command prompt.
 
 		Global environment variables are those you use "env set"
-		or printenv to work with. To run a command stored
+		or "env print" to work with. To run a command stored
 		in such a variable, you need to use the run command,
 		and you must not use the '$' sign to access them.
 
@@ -1655,15 +1655,15 @@ The "bootm" command is used to boot an application that is stored in
 memory (RAM or Flash). In case of a Linux kernel image, the contents
 of the "bootargs" environment variable is passed to the kernel as
 parameters. You can check and modify this variable using the
-"printenv" and "env set" commands:
+"env print" and "env set" commands:
 
 
-	=> printenv bootargs
+	=> env print bootargs
 	bootargs=root=/dev/ram
 
 	=> env set bootargs root=/dev/nfs rw nfsroot=10.0.0.2:/LinuxPPC nfsaddrs=10.0.0.99:10.0.0.2
 
-	=> printenv bootargs
+	=> env print bootargs
 	bootargs=root=/dev/nfs rw nfsroot=10.0.0.2:/LinuxPPC nfsaddrs=10.0.0.99:10.0.0.2
 
 	=> bootm 40020000
diff --git a/doc/README.odroid b/doc/README.odroid
index f0592dd57fc..8fe226cf4cf 100644
--- a/doc/README.odroid
+++ b/doc/README.odroid
@@ -200,7 +200,7 @@ Odroid #
 Note that this automatically sets the many IP address related variables in
 U-Boot that is obtained from the DHCP server.
 
-Odroid # printenv ipaddr netmask gatewayip dnsip
+Odroid # env print ipaddr netmask gatewayip dnsip
 ipaddr=192.168.1.10
 netmask=255.255.255.0
 gatewayip=192.168.1.1
@@ -256,7 +256,7 @@ Loading: ####
 	 40 KiB/s
 done
 Bytes transferred = 46935 (b757 hex)
-Odroid # printenv bootargs
+Odroid # env print bootargs
 bootargs=Please use defined boot
 Odroid # env set bootargs console=ttySAC1,115200n8 root=/dev/mmcblk0p2 rootwait
 Odroid # bootz 40080000 - 42000000
diff --git a/doc/android/ab.rst b/doc/android/ab.rst
index 7fd4aeb6a72..b0123db28e4 100644
--- a/doc/android/ab.rst
+++ b/doc/android/ab.rst
@@ -54,7 +54,7 @@ or::
 
 Result::
 
-    => printenv slot_name
+    => env print slot_name
     slot_name=a
 
 Based on this slot information, the current boot partition should be defined,
diff --git a/doc/usage/cmd/askenv.rst b/doc/usage/cmd/askenv.rst
index a8867ce4d26..0aebc70214f 100644
--- a/doc/usage/cmd/askenv.rst
+++ b/doc/usage/cmd/askenv.rst
@@ -44,7 +44,7 @@ Value of a environment variable env1 without message and size parameters:
 
     => askenv env1
     Please enter 'env1': val1
-    => printenv env1
+    => env print env1
     env1=val1
 
 Value of a environment variable env2 with message and size parameters:
@@ -53,7 +53,7 @@ Value of a environment variable env2 with message and size parameters:
 
     => askenv env2 Please type-in a value for env2: 10
     Please type-in a value for env2: 1234567890123
-    => printenv env2
+    => env print env2
     env2=1234567890
 
 Value of a environment variable env3 with size parameter only:
@@ -62,7 +62,7 @@ Value of a environment variable env3 with size parameter only:
 
     => askenv env3 10
     Please enter 'env3': val3
-    => printenv env3
+    => env print env3
     env3=val3
 
 Configuration
diff --git a/doc/usage/cmd/memsize.rst b/doc/usage/cmd/memsize.rst
index 6e99d7c1d33..9ebeefc58fa 100644
--- a/doc/usage/cmd/memsize.rst
+++ b/doc/usage/cmd/memsize.rst
@@ -34,7 +34,7 @@ This second example shows assign ram size to environment variable:
 ::
 
   => memsize memsz
-  => printenv memsz
+  => env print memsz
   memsz=8192
 
 Return value
-- 
2.53.0

