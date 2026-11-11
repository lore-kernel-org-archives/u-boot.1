Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297C4606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JmsabJpS;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AecvlzCS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E75DF40A4E;
	Wed, 11 Nov 2026 10:50:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ai7Pdi-FQ7wG; Wed, 11 Nov 2026 10:50:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1C8B840A6A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794394211;
	b=DSUMgiFWwya+hD8yQuuglKbOnRSgf9lerzC63kY5W21nWBu/sUefuuHvjXHDY3oG+d5E
	 MYnB+gyCGBOfuQlZwyT1kBykzhydkbFni7FYrZrG5aG77NQRnK57RHrqEXFgpUhDSBG2B
	 XvYfKu693fOG20a+n738qvcdesUwGCU7Q3ff+EXbwsAE58/OUCQJ08csd8S3dadHaQ+n8
	 CXh8YhmQj9lHcMrV0NJ34OCldBKV7KCb1TeeTsbulhjgeFJjz6FPXEHK5NiMShaj4lJF6
	 6ARCIFpU2Kk5RXAmu9h3uj4ADVWS/jHIO4vKK1NgYkizg6bxzksOU4Am5vpqRmiAjww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794394211;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wvcPw4DrhrMm/Eww3Y6O2QM6FgOn5nKBZJd/dchTDbs=;
	b=m3fa7U6cgcZ+RbS3JaVOPS7/TDksJpGxEa+mzAyeXXuCaL2vtvHPrsOzeatdCg/SRb3Q
	 /y3mXO2nclIDKs6S939HuzAJ4mfesoHTl4lAbQMNMDBn/dXltC/hUxBEj3jR9wXk8z4DE
	 HcpWhXsgYBReoZm5SPVsmrkDe7o1nPi+6ogcTHIX0tbKUz3qJO4r4TThAAARH6ZgSBSdi
	 QSaDLvvy29EzTWmWT3QmzhveI2SrkbDI9qj/YH3ouZzQfcqI7VHC2Bc9oWxGsSqVqdydM
	 WadMoxpmf0V/bEAm6mqBs2hbwVomN9Ja2s5CE5T4dUZO6BgkV23Ysq/e5DwDTOe+8lw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794394211;
	bh=wvcPw4DrhrMm/Eww3Y6O2QM6FgOn5nKBZJd/dchTDbs=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JmsabJpSuFCgG/wpDEKzCs08jQ5yrhyn2uO4xaKG7mbbsYqwbPvKt2KKV1yQgKeKF
	 8VYusw9yI0eb9oKMZss0SIRnwPURFno/BDAVYypxTgM1tS57a2atvxw0ZCnT9Ildpk
	 zrdULARkVrWmPbeww5BdM4kzCUZXqmcgQ4LQASN85J7xONrHMa1zHGRTpkA6Mx5sCA
	 Y/VjfWbZiqKlzKud2Bhc54r03NDoMmKB8GEBhsMxVjQHeN1qxbVAOMDZl+1VOpvAYG
	 nPqCEJWce2Rp8PVvVACL6HfoAFJ85eQx5peHdNS4EbTA4DPUz+fyD0NR3EPrhaMF7Z
	 EexaPpBBN6xiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C8B840A6A;
	Wed, 11 Nov 2026 10:50:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A6D917CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:50:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E3E28606ED
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:50:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7C3Oy5cf8Nmm for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:50:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EC45B606E0
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AecvlzCS
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC45B606E0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:50:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C1814136F;
 Wed, 11 Nov 2026 10:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA99D1F00A05;
 Wed, 11 Nov 2026 10:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794394207;
 bh=wvcPw4DrhrMm/Eww3Y6O2QM6FgOn5nKBZJd/dchTDbs=;
 h=From:Date:Subject:To:Cc;
 b=AecvlzCSJ27wKbNxpAZCJk9acHQvz1S06qq48Cyh8sXgJPiBHNUtqFfwOmq8wLMoq
 TM19UVJT0N1c5p8OXKxpBlmAPm22Snn9RRlzASPKAvl51zdOi27jjTtSdoPpGe+xsR
 Ya20hDGKfbfGCHefNF9s6gzgCc4Czhfr/lNmymZ5xrptG9xZ/P4k0ss9ZPpp3f1Q+Y
 gJG/vRyqWJI0H1e2VA85viwp3qjySoedMsvv4nNf2/i4apOGcbF0ul9gQWA1M6tokd
 SQ19zBjkIeJn2SYGIcTg+ZHe3pg26U6wBiGXbfizSiSrSRh0PD/JMsoBGHmTZdudH5
 qKTKpEx6MTckw==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 11 Nov 2026 10:49:55 +0000
Subject: [PATCH] spacemit: k1: fix SD Card Detection for MusePi Pro
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-02-k1-sdcard-fix-cd-v1-1-08f89230a13c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDQAxFryJZG3CysOhVxMV0Etso2DKxIoh3N
 9a/e3ze28Ekqxi0xQ5ZVjX9zA6hLCC94/wSVHYGqqgOPqwIp4DGKWbGQTdMjBTrgQM9KDYNuPn
 N4s+/2vU32+85SlquFBzHCfGnUt13AAAA
X-Change-ID: 20261111-02-k1-sdcard-fix-cd-2a6fd1272a99
To: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io
Cc: Yao Zi <me@ziyao.cc>, Eric Chung <eric.chung@riscstar.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Zixian Zeng <sycamoremoon376@gmail.com>, Yixun Lan <dlan@kernel.org>, 
 gpio 80 gpio 80 <"pin 80 already claimed by 'mmc"@d4280000.cd-gpios'>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2571; i=dlan@kernel.org;
 h=from:subject:message-id; bh=sVkenF7CKW1KUqMfuqchXWm2I9nHcbe5GCPfO6dnsyI=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq9EhZchiuQEEeGylG1LdjnYtds9P78iQdK99pH
 or6qrTFdBmJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCavRIWRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3B6w/9GLhqiXOxkinAdFPBGND7xunpYmvGTlBmjIWO8Wy0KR+uzKJT91jMz
 VR9GD/J14ceFBBXZCkgUUKkXQwgIYVTDC1ZChwzAZ0GZg5cka1FeE85kC5bWVgDNbxUbrpOTDGx
 LdBJoJlmw5nkCfQ1A4veq6L+fm1XCeC2/QHWPOh4dCzs6VJWu6/3xfaAGnOs8b1xCDENVCTYUoL
 J1nu4F8yySPEYw6cPZZjo2clF5T0rxh0Hxn6s4he7cHQYEOZal+N5ewF2225/Yly1j530e89biV
 0Pmh9KZdY/meX8g6xdhEeWp+m716Cbz6/mz/3D3ie3t+MI+kGF9Fwb/2T0RFW/AAJXPy4vhRoIj
 RIHzop514K2Vea3frJTkCeiPotw8QPlH5AyVqxn2XkGgoNU3NAdZzEboQttoJWJ6D2TwlL5EEVY
 5GAGkrnLrBmGV6fBYVDDqt8a8/5EXzrkWdBtR4hzSzaqQ5jyK0f7JKEfsYKO+4HdlIs7yH3GOlo
 MeD7U5FFbi3K5GN6EuKKW3oF3xvI9FkCHBnMEKq6as6FFpWz3eaIShXPIu91ahfZUGpc3JRiGt8
 alJT9bkRtnXI3BmpaO7Glz8ZC6gk/7nOoIDbQiJlYtYCmrsg213j0D2WYdySIAO0MELm/38CeQx
 a/m8aZX/eZPvtzZPqNQUzlsDyWNXGY=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Previously, on the MusePi Pro board, reading the value from the
SD Card Dectect pin always returned 0, and cd-gpio is overrided
in dts as active low, causing the system to always treat the SD
Card exist regardless of whether it was actually inserted or not.

With GPIO bias patch[1], the GPIO_PULL_UP flag can be passed down
at the Card Dectect pin request through "cd-gpios" property. So with
correct pull up settings, the SD card CD pin is just work fine, no
need to override the DT property, so use the default from dts upstream.

Link: https://lore.kernel.org/all/20261104-02-k3-gpio-pull-flag-v1-0-de9f0a9b7669@kernel.org/ [1]
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
This patch try to fix SD Card Dectect pin for MusePi Pro board,
Please note the GPIO bias patch[1] is needed along with this one.

Previously, without the fix, SD Card Dectect pin is configured as active
low, so it assume SD card always exist no matter being inserted or not.
And it will abort at later command phase when no card.

Here are U-Boot logs for cases without or with patches applied

Case A) Before, the patches are not applied

=> gpio input 80
gpio: pin 80 (gpio 80) already claimed by 'mmc@d4280000.cd-gpios'
gpio: pin 80 (gpio 80) value is 0
=> mmc dev 1
switch to partitions #0, OK
mmc1 is current device

=> gpio input 80
gpio: pin 80 (gpio 80) already claimed by 'mmc@d4280000.cd-gpios'
gpio: pin 80 (gpio 80) value is 0
=> mmc dev 1
Card did not respond to voltage select! : -110

Case B) After this patch and GPIO bias patch applied:

=> gpio input 80
gpio: pin 80 (gpio 80) already claimed by 'mmc@d4280000.cd-gpios'
gpio: pin 80 (gpio 80) value is 1
=> mmc dev 1
switch to partitions #0, OK
mmc1 is current device

=> gpio input 80
gpio: pin 80 (gpio 80) already claimed by 'mmc@d4280000.cd-gpios'
gpio: pin 80 (gpio 80) value is 0
=> mmc dev 1
MMC: no card present
---
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
index 200836cc204..f2688a1868f 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -131,7 +131,6 @@
 
 &sdhci0 {
 	bootph-pre-ram;
-	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
 	max-frequency = <204800000>;
 };
 

---
base-commit: 26a75ef02a879b08f1140508aaf9f0051f73d5d5
change-id: 20261111-02-k1-sdcard-fix-cd-2a6fd1272a99

Best regards,
--  
Yixun Lan <dlan@kernel.org>

