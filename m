Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4D8606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X1ki9K3f;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=E7tw3HKh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE5B360862;
	Tue, 17 Nov 2026 09:19:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xl93XeY6KARZ; Tue, 17 Nov 2026 09:19:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D31E3608B5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794907199;
	b=qfpMlFbHzg7bCksdI3mmOQImOKDJqpslnzmQAOo97xeG/tVnr0Yk92KIiwPodH/ivGc7
	 nM696EPgbhiJptqbwFO2dj4oxbkMgks2J8/Ps26szZqCRWAp7mWgBD9eqPlzdR99txduh
	 aq57dY/I8knAIayLiGTC/jWY6z8pUBWgBFRxCnalX0C7kRxtYXH4GddDhyrcc3XQpNccQ
	 tKLAjz1RCafn2EfHjeYCpEDQTWLYnWCRpyjlgapj8WjkQu4zQ8fOVduBjzXBJiA2LV8n2
	 9KOc+KtQun9dP5k+6oYZFw+aagVyLzJwM5YaE6/0DIpBXTqeMIAuMrm6fqMa3vVYRNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794907199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EJQw5lwnOBp+PVLmtQn9IhzooqS32sqcBzYmhCGbSW8=;
	b=OQayjmtvnozwnJnfbawdw10Sd9Dazy2byTNy+l2ZnIndiOjQVPCNQczKYb4xQ5z0/IbT
	 6zKSoQkeL8ahX4ukt+x8noNBLh17LIDxQczLnjT+U3x4yDT1japU9Ssw1uu6W2wsZPePV
	 wM/KTausQOZK7RD16VcSXtKtxmI81ukUltw2HATvXShDYXyh5aKpTzTAOSr26aeL+cHXR
	 E8DkjEuSIIxDEkKyhdmhQvsp6UHzgfzZjKXb75fBPQ7BF9g+UEqPSTl8RHCSIUc/UGiEy
	 k6HsR2H6wXZ+Cojbyf4mqhOQumlvW4JHkEa1qHD7CzfMGdSI/fneXbG0iHCoT6Cshxg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=E7tw3HKh;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794907199;
	bh=EJQw5lwnOBp+PVLmtQn9IhzooqS32sqcBzYmhCGbSW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X1ki9K3fwjj6RrabVCNZEtFYdja3TX22DMqZ70ZSpsMzHpuyf/UyPZMaxgr6RPdzW
	 Y/9HsboYe1H97SB5XsMpucJyC6N4uAEyiLC1C9wWBi11y+37MPvuOKD4XQdsQzxTlq
	 opAab0cSeJBafa6+IMEO4XrJUvz/Rievf0foxpe4/fXTnPCocmzinh1S4NyzcqHWxQ
	 0fQEaDBSLUofpnaVlemfm8axxssouJghNdnawJYXZuZhd6iXji06CGAmy/VNsiakND
	 I6FM1JVXO4EbsTn1CmmeIVF3CkGv529KeH3y4/Nf8SXS9uEGVhbn54+U4xmHsdguNY
	 5S0ykT58qeXGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D31E3608B5;
	Tue, 17 Nov 2026 09:19:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AF611E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1CE836081F
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kl3LhBObPrmS for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:19:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C044E60858
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=45.157.188.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.9;
 helo=smtp-bc09.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=E7tw3HKh
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C044E60858
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:46 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTK1r2pytzQCn;
 Tue, 17 Nov 2026 10:19:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794907183;
 bh=EJQw5lwnOBp+PVLmtQn9IhzooqS32sqcBzYmhCGbSW8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=E7tw3HKh9i/2YalHsct0GHMd9DFbhg1y2hDRzGoI5HgKBWqzgsmYTISVvjwb4mPEx
 va1BxZ/9pyMCAWrKGiUYAckhu8zuQEC/XwsN7VZCRLD9q5jQKVcKTA7Z8doVakrDb1
 SVgHIBQpWLX92hH5o2rcIIz8VOtv/VmMSZ6nHKCIMB6FN1nC3Vjsb5TRAUgfANsEwk
 g8da6VhQFvK1vebrSyEaSUUBtOXfZJdKyq+l0YNIojf3yLMlQbie9NDgB8630EkOu8
 lgPHwW2x6SY+ysd1/eN8OSA0uhVAvuHBfqWKObezpSzOZGnmo1tDeh1HKfKUlZsb1E
 RbmpYa6v37oHQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTK1q07xczhkY; Tue, 17 Nov 2026 10:19:42 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 10:19:11 +0100
Subject: [PATCH next 09/10] rockchip: correct [ST]PL_ROCKCHIP_BACK_TO_BROM
 help text
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-doc-follow-up-v1-9-2cc0910f9455@cherry.de>
References: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
In-Reply-To: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Eddie Cai <eddie.cai.linux@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, Johan Jonker <jbx6244@gmail.com>, 
 Shuqiao Zhang <stevenjoezhang@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

User code can actually return multiple times to BootROM (on some SoCs,
up to 4 times) so saying it'll load "a second loader binary" is
potentially incorrect and misleading. Instead, just say that user code
can return to BootROM and have that load and execute the next binary in
an image. For TPL, provide the typical scenario, which is to return to
BootROM for it to load and execute the SPL next.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/Kconfig | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index fef5932844e6..f8cc51d9b4b6 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -606,9 +606,10 @@ config SPL_ROCKCHIP_BACK_TO_BROM
 	select SPL_BOOTROM_SUPPORT
 	depends on SPL
 	help
-	  Rockchip SoCs have the ability to load a second loader binary
-	  after the SPL phase. If enabled, SPL will return to the BootROM,
-	  which will then load and execute the U-Boot binary.
+	  On Rockchip platforms, user code can return control to BootROM which
+	  will load and execute the next binary in an image.
+	  If enabled, SPL will return to the BootROM after it's finished
+	  executing.
 
 config TPL_ROCKCHIP_BACK_TO_BROM
 	bool "TPL returns to BootROM"
@@ -617,9 +618,11 @@ config TPL_ROCKCHIP_BACK_TO_BROM
 	select TPL_BOOTROM_SUPPORT
 	depends on TPL
 	help
-	  Rockchip SoCs have the ability to load a second loader binary
-	  after the TPL phase. If enabled, TPL will return to the BootROM,
-	  which will then load and execute a SPL binary.
+	  On Rockchip platforms, user code can return control to BootROM which
+	  will load and execute the next binary in an image.
+	  If enabled, TPL will return to the BootROM after it's finished
+	  executing. The typical bootflow is for the BootROM to then load and
+	  execute SPL next.
 
 config ROCKCHIP_COMMON_BOARD
 	bool "Rockchip common board file"

-- 
2.56.1

