Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600B4606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VT8M91WQ;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=HLpz4Uro
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3802F60846;
	Tue, 17 Nov 2026 09:26:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jVDzvwQDuWtX; Tue, 17 Nov 2026 09:26:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 758886083A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794907576;
	b=nACtcPwIK9OtBCtb3DWNXWMnfNrW9gYjLuIB9/FQIznCh93MpkHAl5ZnaggqWzNQwNxC
	 pxHwIXhBxRUHTiJTF6SpXwdXpQvKt/g/wwMlsj1SdSe9Z77kLBWVXK8qGDzeD/61XGqSX
	 h5Df1CnGi3IVLLRmaMBCLKHTM3oOh+RHiv7mzAU8EMc+c058ABMg+/7qrIbnCMUCtUM2N
	 BFnXSsVmpi1vjNzh9JHXX+AapAr/TJJlptWpjmsHi+99jKs750/LxZ2N4VwrtmlAPlHjm
	 nECsBYBQCxkqEY45eu8jmX/XDju/e222Z0zCXFdSRxf2JGHKN6cykXlDGGvJJljd5Lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794907576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sRs9qL+rA9WRx6evlk3ByBqV5wkIDZa3hr+nwG90grU=;
	b=okSxPDNSooktFnecWIirQKLAqOBBgUunj6b27ORB8laqbQohmDBPMPOOEkXBwLt37S/k
	 sBCKBM27TPS8oTX8lHK218kjMk7SIupjQN3fd0mxj4eD5KM8zsAIKBYh0UFYhrGuSwqiG
	 daf/yJKzAER6VxHoxWYSTTlxzEt8m0QPISLDBB76eYcLg693hnZK1ml8/KQbqzclF3SRk
	 JyLfLdZPe2DCbVcgA0uzblAYMFs/1luVRg51/aMiNlCSUDjgo4+3w+DRzYB4biQRJRF3o
	 9kHCfT1yB4PIs7rqyEgClpooxveLYmyKMSac3Ip+8yFUPEqXD+imhejVVtLMbY9rP0g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794907576;
	bh=sRs9qL+rA9WRx6evlk3ByBqV5wkIDZa3hr+nwG90grU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VT8M91WQ4i1UZzVreeVWmiNCCKDuNXMHiXNUpr+bRWONvpugcrEtqcEh9fVga0teh
	 uczbngq9KpTh5YYyAXIWLPXuPrR7EV/9fm0EKBRrC5KwWxWdHOxK7OnqlkFNLoQwA2
	 7HUDw7rjSTP7DpaXyL0p/x51fWNmaBZBd529v8gBh5kj+6TwgH8ECdE1xHKGMiP1qo
	 xKz0ibWSvhRLFRUbDJlbq7CIWQ5+WOT8SYxUxQGvtoaoT/poCJrjF+qgH54IcZtL9b
	 FJvJthglZ/Z+KGT+2SA2oZhONe3JN6t/wBm4sqZ76i1A0/7sMakpDIn3unsKuvXDvz
	 DMD32eHd8w46Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 758886083A;
	Tue, 17 Nov 2026 09:26:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CF5548F1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C102280FA9
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ord6EbcPTDBl for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:26:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F1B9380FA7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=84.16.66.170
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.170;
 helo=smtp-42aa.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=HLpz4Uro
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1B9380FA7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:26:14 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTK1k4Q7Wzsm;
 Tue, 17 Nov 2026 10:19:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794907178;
 bh=sRs9qL+rA9WRx6evlk3ByBqV5wkIDZa3hr+nwG90grU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HLpz4Urolk/R48M5qSeQEZAwt6PuReMRsxOpFCkGuGA7QSjI90p/Z7hbZKDgOREGL
 3YRE8ZMa2myTquxUuln9bFYN8EK6MgUewlO/BqGcxZfnbLNNuZ44eZyC4WnwkW9yjt
 dZpvD99HrMXjzWJYOpigvH/+r7M65CnQUTG5nFsBJ7mRQnARS8meHyegTJjtRJwZvu
 1xa1XBKquWJd1oM32cp3lMu0IT1lsapZjrA8SYZRhbW59/9X0/wPUiWclOnFAR+mK2
 6pbQZGUfJguVt9T3AsTrNjnvTytFySisDmupohvudKG6nVDrNLnAk1L5nT+a4KHP9Q
 ox9B7YUkF39Fw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTK1h3pJQzj6Z; Tue, 17 Nov 2026 10:19:36 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 10:19:06 +0100
Subject: [PATCH next 04/10] doc: qnap: reword instructions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-doc-follow-up-v1-4-2cc0910f9455@cherry.de>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

The ddrbin_tool is only run on the DDR init blob so mentioning the
"maskrom-downloader" is incorrect and misleading.

"maskrom downloader" is incorrect as MaskROM is the mode in which
BootROM puts the SoC when no storage media is found to be bootable.
Technically, it should be "loader mode", but let's simplify by simply
stating "bootloader".

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/qnap/ts433.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/board/qnap/ts433.rst b/doc/board/qnap/ts433.rst
index 446c8ec8f2a8..d9f8e049d491 100644
--- a/doc/board/qnap/ts433.rst
+++ b/doc/board/qnap/ts433.rst
@@ -9,8 +9,8 @@ Preparing the serial
 --------------------
 
 Qnap devices run their serial console with a 115200 baudrate. As the
-binary DDR-init and maskrom-downloader expect a 1500000 rate, it is
-necessary to adapt the binaries if their output is needed.
+binary DDR-init configures the serial to 1500000 bauds by default, it is
+necessary to adapt the binary if its output is needed.
 
 This can be done with a binary provided in the rkbin repository.
 First the ddrbin_param.txt in the rkbin repo needs to be modified:
@@ -31,8 +31,8 @@ First the ddrbin_param.txt in the rkbin repo needs to be modified:
      sr_idle=
      pd_idle=
 
-And after that the ddrbin_tool binary can be used to modify apply this
-modification and also a new maskrom downloader can be build:
+And after that the ddrbin_tool binary can be used to apply this
+modification and also a new bootloader to upload in MaskROM mode can be built:
 
 .. code-block:: bash
 

-- 
2.56.1

