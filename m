Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631E7C982DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 11:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 193D240B83;
	Fri, 18 Sep 2026 11:49:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nMQqW0YNQnPb; Fri, 18 Sep 2026 11:49:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D85EE40B78
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789732186;
	b=mG7YJrU7yOfQXldRzR8MaxJb5AnxuNwzdmUtGK+Kv5QSkeeo59mtTyC1/j9eyKL25emR
	 ipFttOeX5t4rjJw24JVlWj/v/EZ8LEP1UB49a7hBDdFnM6Gu/kqu12GTAZy++AOGri4xD
	 d7KeevwUDROWiV9GmALK+ice1w0TahaZVRhgupGUrKya3TxJQkib0MsaxK+XRxqaJV9Ba
	 fWXE89OyKnnhbFgoRWn4uOFw8qF2NPk8ImJuvu99v+YpLUdtn199rR6XxLyCetD3gbl0s
	 3a6jHlUtDNvOpP3MatdZFOGTLRMEnpquPmcajHcl9aX0GWQDDA61iQrIFdnETnanTig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789732186;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8VsjLvffqoTckr5q8EUN8W4h+BnEIIo/bVStqJUBAPo=;
	b=fRWoHd/zHeAN9QmIt7ccoTanTT+FR5FK7wHEyqgeAdjeqhkntO8O+jbhNtK+eNSt7PjX
	 W05GOOuUOWaxUgvK8DwjXYBVRdRyrO47FT5yKgpE/F48LQBPjJe4foubrWfpEr4l2t5K8
	 LXikyE3DyGi9IIi/VHSmWXQVBTyZca0hKnWlC+Mxdz6ztdxz3ZC8wq39IMzjv0H2rZqTw
	 yLDUFmGF1Ii135JPnvKvwmNNOfUYkCCpeihAkj5OiG1r9Y0Nv77p9/TQ3PZ22x18XGmHK
	 ZGLiSBw5fJT11NREyR7EritcOdWrCwFF3oGOBDaBNHpzxLuCMkLmhWng4MpPiHTxoCA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789732186;
	bh=8VsjLvffqoTckr5q8EUN8W4h+BnEIIo/bVStqJUBAPo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bApou2nucb92gD3JJkRFp5S21VdPw6egupzT4WjbUg5/1nxBjghHnVVFKiMOsHYnE
	 qZu562m+X8eb3seZKLOkI+Cld6HSp7qYGzdukPNtmylLmOULkBRF1rQXKTdvjR7+KB
	 JCNHvdZkHN0RgIe0baGzq/O1P1Q5WSTyWZ3CFXY01GxNpPcM7eunSPm/tVjdg9yIDv
	 7TZrSRfa8tp8JoY6kf9jF0GMex6T340GDDaOWuB1j0Jt52mOTCmP+DoDARZYbkQVrA
	 U6LCkDuw4jWWW2rVKVcExzhX/V0u5UggQ+1iTLiYp9OTvWWLxnbEJLL7H3Vyp+wwdz
	 qbcVqkcGKTVfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D85EE40B78;
	Fri, 18 Sep 2026 11:49:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5168413D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3433860D65
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:49:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bKlXBZ4gXjlo for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 11:49:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8D01560C1E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789732183;
 b=G0fmGxQcaVzoYYjSABmbb6BUWYpjcEF++2q4cmvnsjiJiWNxWRAsrblyDAlL9JRolj7M
 Vap/t4JFzBB43PoyH0nLfCxjd24jQtp+uCn75AKmDNDe+8agMc2NjNsfXcgrNO5WeH8XI
 ktKBwSar5tQ7atwqtAMNA1SS1+VerQnq7rC1baaPyObMCszC4Ba8PASFE84VsQeK51Y1u
 4e1d+dWZb0qOCvDfK9QcXpwLwXpnyPX3uF341pjRp1To3Biud/Z1Iih/ChzY5xNYyejIc
 tTNyC0Y7YcyEPExGdxs6/14mOqEY5forGRad7pEvFDN5xcYDI4/c4z7UGyudg+tyC3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789732183;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=8VsjLvffqoTckr5q8EUN8W4h+BnEIIo/bVStqJUBAPo=;
 b=VNKFV+mLH+2j7xuLKyMcKMjcso+2uak2KuF4IAhadrnp6Wu7C+6TJ++FcfpBMtVfKrb6
 H04lDA0s/ibNYK/6M3BB51YQcsD3C8Ohj45U+JsE/kzd794vVNHEoJ+5MOQr71NfBrc2/
 WksHVCh37PT1dPSw3zjI4BTxD737RbMxZSwM7HiI3F/+fOrLAZv+PHms137A5KoVXM90X
 ov2mPJLptMOIadYJ30DLvllzr5TJXonmFvlGpIYFRRO9qNf2NqMcwWg1anDJPuNfxLwuF
 KcFDzcit2JwRZBC6Rbxhc0mguecUDT1izVoatHaq7w2vEjjwEaEhO8gBvD164H7o6pA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=oYPLrIAu; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=oYPLrIAu
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D01560C1E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:49:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E974168F;
 Fri, 18 Sep 2026 04:49:37 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.129.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F10F63F882;
 Fri, 18 Sep 2026 04:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789732181; bh=oL5TYrqExf8WviMkSX6I8xK4LZ5owuF10E2BD5t0nRg=;
 h=From:Date:Subject:To:Cc:From;
 b=oYPLrIAujR1DDJf0VpklqpLACQD6VQagdQqnTk93BhlH3r/qnZPe9tV/5Cvar6b1k
 BCTKp47JwDjuLJZT9g/khZxKre3JC42GoLIJm7pMjcsJXeHjcISE26mGexkYMQ9kg0
 tzIuaPUO20s6me0IbYlYcugxp7KXYinFx7GFJRog=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Fri, 18 Sep 2026 13:49:38 +0200
Subject: [PATCH] boot: mention sbox in efi loader boot method doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260918-sbox-v1-1-792acae4a3a7@arm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0ML3eKk/ApdwzQjA0PL1ESLlBQjJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAFI9sLtoAAAA
X-Change-ID: 20260918-sbox-1f2019ea8dd2
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=oL5TYrqExf8WviMkSX6I8xK4LZ5owuF10E2BD5t0nRg=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqrSVTaxinEEosSOk54ikkJZHJ9kf7T3VFYaIQl
 Q/dsZA89HCJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaq0lUwAKCRDLSfhWdqMG
 lI9QB/9qW+PlHFUb9wzqfR0+j1YRYFvq35gGnO9z7LFjdQaoGK0ZIJQF5XIhzBxB85EIvaiX77z
 8PiqT2EMxJf/FJ04vw7f4A9ADGbEo/HK+J1aUMp6GuQTp+BW8Vde1shIubrKMD9hZkW3ih2ku+J
 H/+tHpBtBMSLlpZ6nOyyyOj/uLxJAwMrXkT5ZL+DYhDrqf1yn0e+0oJSP3ZW3d6P/Dq7fh8ugnM
 hzicAvf2qZT+H1bUkW2IOgrBDaAKShvsHwqxYxQ7k0b1JLi5wC11LSmAD3jBZPRB2ASyUV6uicz
 rYINpqy96UGyZo+5JZc+4zb0Mn5f4HDoORkkyAfuzOq7o5Qt
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

U-Boot EFI Loader boot method looks for an architecture-dependant
boot<arch>.efi executable, where <arch> comes from the list defined by
the UEFI specification. [1]

When booting with the sandbox in non-native mode (the default without
--native) the <arch> that is considered in that case is "sbox".
As this case is not listed in the UEFI specification, it can be
surprising.

Mention it in the BOOTMETH_EFILOADER configuration documentation.

Link: https://uefi.org/specs/UEFI/2.11/03_Boot_Manager.html#uefi-image-types [1]
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index c67dc0ba493..3c750e4923b 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -670,6 +670,7 @@ config BOOTMETH_EFILOADER
 	     x64       - x86 64-bit
 	     riscv32   - RISC-V 32-bit
 	     riscv64   - RISC-V 64-bit
+	     sbox      - U-Boot sandbox (without --native)
 
 	  This provides a way to try out standard boot on an existing boot flow.
 

---
base-commit: 211de43d0f954a00a490220c1aac9db298287c40
change-id: 20260918-sbox-1f2019ea8dd2

Best regards,
--  
Vincent.

