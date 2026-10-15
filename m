Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1627ECC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7871E60AA6;
	Thu, 15 Oct 2026 13:14:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XLgQDUkFMZ-7; Thu, 15 Oct 2026 13:14:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 93B3960AA1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792070098;
	b=mhSW9FERZU/WZpZtfwzWAexmOFo1A2aflJQBP5cu57GpZrjKmHGzz29iWCRBp4U5V1TG
	 wA3MWEUAe3/Iap5rAEDoLsccGqdQjIrcGDGDA0bpy4VoSB7urDW8+yODDY1K9bWHM5Npv
	 QtZeak0EsybMmFOghONhU91qRVOCCk2BrGYLCAe5ig5/TFqixTjL0wxUtJqB33dhWvpyr
	 kodotePR1+ppm8vNio9x0CUYdCSdkYmcBj/zsgNr8XMjAWP0Bkd/X4+jTrvLDIAE5u5Cc
	 TzLOWRXGSh3q+I3a7JskqzQtkAOeM8ZKSqRUaLcqGx/Wy3O9VRFV0HCFVt3BXmBqGdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792070098;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q/pcc/b+wm/PaykDudglD0wfWmUccNkfY6fzIXQkGHM=;
	b=AaZGfBDDzoWQHDW6qfxKf0ydLdXbprNehpcnOeqObKDGnOcBoxLcUvP5BF5Zhsw8syvT
	 pk4JG+kSGIDNuqaNk0eSqwP1H0IzaNXkEVAJhn3OL7sniuOvVhR7ycyoMY22kCFFlWw0w
	 lgxvLwfpVKkET4T43gF6MkOH1wEm1yU3zGaW5KY9NpEScxjcaBqhmDb0c/8ZSbdjDDG2Y
	 K85cHBlq3HZY8ujB9k1HBXqmLxGB8ddFm6Y1RUq9OQzAOcvyj0kf5fl+aJyRiRh6CTdVC
	 A2yt2llRbh5eTQgAE2em5JfkKXyP+eeKF6Tkm+7k3O9g5xDeR2W7IU80UG09PKmhMDg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=disruptive-technologies.com;
	dkim=pass header.d=disruptive-technologies.com header.i=@disruptive-technologies.com header.a=rsa-sha256 header.s=google header.b=d8t0ro9z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792070098;
	bh=q/pcc/b+wm/PaykDudglD0wfWmUccNkfY6fzIXQkGHM=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LqKM9XNdHfhK4TqJkIt9xWr/zifBfrF7H41NCBsxYCvJuivU4EltBufWFWOJnAhMq
	 QT8h653f6d4dyO8xU2zcZtKc1oa5odQpMmoxVZz31eh1N9jlqOx6aQ4yDNKgLhvHe6
	 AvXJiOW3sr4kZusAGFdXE9n7t77B14IDDzZgenD8R71kETysCS242gCqBANiw3NXA2
	 bwTv/79qD4YQpS54mP7W1TTUdy5ufJYxxEbR+XmJAVwF5ZKhr+Ye37WeflXa6sjxRl
	 xpneCl4IzJm+vZYzafTav52NRFp5GFmUKyvmCQz9TdsGKKm6tWVGzPzTqiWZIXNKSg
	 wTgRTLu51SStA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93B3960AA1;
	Thu, 15 Oct 2026 13:14:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 51335A58
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 09:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3720960767
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 09:49:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LuYnbmTkyjJf for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 09:49:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 22224606C2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792057798;
 b=X7h/AbSgaWBtqulQUhnbmEfgAtpOZ63BtgYwzeyY0A1BQ9xWw4tP7CT4Xamwm49z3ChO
 8sfNOkJBrT2/TcPnR5JFNadr0iCjvmP/h5eKFJ3PZi21tpcVKsgFEWinRd3IRKFxCS/c1
 OaaUahUXLhcAy4bBJ8WxfavJEJaN6K+XpPa3RITOe+S/texb+b5sYwyzCrQebJMjwuTHw
 abni8WzEbMsXb/DhyU3pbRcgvQ17Z/v3MelV1dfqW2I8B0x5+wXaUO/vOcI5y/Hw/uRjo
 Ti+30Ehz0AKAsVNu5Ey4aCF+6fbuvp/JQXwWUePeJoZ/qaCOmMCILQzRyLk/X9os8pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792057798;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=q/pcc/b+wm/PaykDudglD0wfWmUccNkfY6fzIXQkGHM=;
 b=FNsbh9bgM/JULMlBsOWtIW5gfvyJxmo2uvz4NTFRf/Nhis/m+7uZrbLhseQYsaiR7CKF
 la075zqjUhPEEP13c4Kt1sZPAM1NDRYia3k8gLs1EH2YaWwRu15e7HASQPMV98Xj8hDvK
 rmR9xDgi3zpJvOFC1B7Nrem7Vu/p8ERcXRsrs3Oo13Ruix4eIFTBapuyDzTCkLCvt3dxS
 DaB82wngixkIncCzSoYPpgCcjnyEvP8JzAV7gmc56J8XvCY/xupkmQZ4I+Hjn0cxBBEX4
 ljaQ0PNLpAJozhqQVm/UxE1poLcxeS0IiWLW1rzmkmwcUpiYmSEDT9n8IO4YEw/GKiw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=disruptive-technologies.com;
 dkim=pass header.d=disruptive-technologies.com
 header.i=@disruptive-technologies.com header.a=rsa-sha256 header.s=google
 header.b=d8t0ro9z; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=aksel.aase@disruptive-technologies.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=disruptive-technologies.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=disruptive-technologies.com
 header.i=@disruptive-technologies.com header.a=rsa-sha256 header.s=google
 header.b=d8t0ro9z
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22224606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 09:49:57 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6acbdbc1725so2685587a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=disruptive-technologies.com; s=google; t=1792057795; x=1792662595;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q/pcc/b+wm/PaykDudglD0wfWmUccNkfY6fzIXQkGHM=;
 b=d8t0ro9z3/07+9Fo9K1J6Q4nE9PtAI0zglwiYYl3NnqIVj3KKjgGSQyckhi5YShrZ7
 /RoL6Nz39OexRoiGT/8ZdKNAwgPcrs1FYxaG4L+/I3StSeGHs6+RnvXFg1bnwtUw/sP8
 V7gUjud4x8UbSwP0UgnavpxEaNVKBRSlW19htEOt+w13P61u0bbclIge4Udh4HW3FAo5
 UgS4bLXreJUD1NghTgBd1f1CiXM+rW9n54+U+5O8gf3/YEctowAQ9rGJgR4J0q8CE4uh
 5Q2xqXhykk7nHm3X3x0HJlxWEoL27RUOfgsx4NHsJR/if2ZFVKXu0GbQDT4a5UW93xyH
 CKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792057795; x=1792662595;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=q/pcc/b+wm/PaykDudglD0wfWmUccNkfY6fzIXQkGHM=;
 b=qevAxSf6qUSK5VLJoiQlz9c/9P3se72dw1npwmTvEeBIQdwSnGd3QgON9u8T4rrWPG
 Goxbi4cy/UBKwo02x5Ap1gHXBFSmHyICcuxpOj43WZNZgewBZjutpc1kH15C+g0doLDb
 njABgdFdLePsuSvU3Q1STJBVEgoVFESnuVIMb7y5t7z80M+pDvWVYLnPS9mIFm0HK94J
 EQJr7ojMC8vEfk5Bq901RXnxN0U6eUIcnR15BoGHoC25dKqqbZKqOtpL0r5GBJaYc51/
 XX/hd4/tSCEVl4hppITbciZlzbzoFVW6wNd7KXqlmOy5TeVrwW5sFGNRR0iZgd45eiTs
 Jtgg==
X-Gm-Message-State: AFq9FYK4jm32yu5j/9i/gOnwlSMiv2Oin/guFrkt/5JFQXUn8jZpjF1b
 wkfdcCGakNYjqjJdGcDBPDD3o/4oQVoN7TMa68MI1JjTudx/PNhi1SbootFNYASewb/eISgba1j
 vclrg8xFnBw==
X-Gm-Gg: AYBFou2GlAESIJlw2VZoFDY44PUQ4N45W3rt9Ijxzsf/AbMkAP7bngkdu6z8P8dczMi
 1Zan9kakI88C1E1sPQmiciDHzoCeHTJlNIiZg//I39PHv6mufaAO7Ob7dnk3isViDyvF8V00+fp
 oZ8V7DgYhyS6zPLys0tuYd3uRkpW5chDFEU3kTu0EfV9ks3KeOrR2hFC+Rt0EwQMlWS9aWOahr2
 WHkDSFWLPPUngihjNBANci/5LFrmVeeyapyEXN4xw4B24cESAzmJ+P5/tPy5x0Ywg8NSTiSfRWf
 PJ6Vj2rIU3Ai5Bkxa/xmVNZsLJAs88MqQ3nLpRJFKFQa3cx6VFHMFqPCxylJXgKGP6gva0E0fTQ
 oFzKyXTJJ0oTqSiHML9FjEyMBNVAORh6pxDNuig37y7bsxt2rgxIW6QL4xJxdoxze6wb+lzK+kM
 Fs1ehf+RE72SzO23fw33FnWdxTKWZMLeaiLIADiSpNv7pt5Zzgj3EVn7byWANjweiaO18RPh7t8
 6tFsTpRN8LU79RzNJY=
X-Received: by 2002:a05:6402:4341:b0:6ac:8761:17a1 with SMTP id
 4fb4d7f45d1cf-6b17c27a7famr14063134a12.36.1792057795617; 
 Thu, 15 Oct 2026 02:49:55 -0700 (PDT)
Received: from localhost ([81.191.31.98]) by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-6b2038aa1aesm2174024a12.32.2026.10.15.02.49.54
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 02:49:54 -0700 (PDT)
Received: from localhost ([81.191.31.98]) by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-6b20386327csm2121127a12.18.2026.10.15.01.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 01:47:17 -0700 (PDT)
From: Aksel Lunde Aase <aksel.aase@disruptive-technologies.com>
Date: Thu, 15 Oct 2026 10:47:05 +0200
Subject: [PATCH] cmd: eeprom: Zero-initialize eeprom_dev_spec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261015-eeprom-zero-init-v1-1-81003ce77c1f@disruptive-technologies.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0MT3dTUgqL8XN2q1KJ83cy8zBLd5KQ045Q00xRTo+RUJaC2gqLUtMw
 KsJHRsbW1ADy5xj5iAAAA
X-Change-ID: 20261014-eeprom-zero-init-cbf3df5d52ce
To: u-boot@lists.u-boot-project.org
Cc: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Aksel Lunde Aase <aksel.aase@disruptive-technologies.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Thu, 15 Oct 2026 13:14:48 +0000
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

With CONFIG_I2C_EEPROM enabled, passing both bus and address to the
eeprom command causes a data abort:

    eeprom write 0 52 ${loadaddr} 0 1000

This is due to the eeprom_dev_spec in do_eeprom() being partially
uninitialized. When given a bus and address, parse_eeprom_dev_spec()
sets i2c_bus and i2c_addr but never assigns dev->dev.
eeprom_dev_spec_write() then sees a non-NULL dev->dev and calls
i2c_eeprom_write() with a garbage udevice pointer. Reads are affected
the same way.

Zero-initialize the struct so that dev->dev is NULL unless a driver
model device was actually found.

Fixes: 57a9e8d86fde ("cmd: eeprom: Extend to EEPROMs probed via driver model")
Cc: Marek Behún <kabel@kernel.org>
Signed-off-by: Aksel Lunde Aase <aksel.aase@disruptive-technologies.com>
---
 cmd/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/eeprom.c b/cmd/eeprom.c
index cf89cfce3e4..7998a7c05c8 100644
--- a/cmd/eeprom.c
+++ b/cmd/eeprom.c
@@ -449,7 +449,7 @@ static int eeprom_action_expected_argc(enum eeprom_action action)
 int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	enum eeprom_action action = EEPROM_ACTION_INVALID;
-	struct eeprom_dev_spec dev;
+	struct eeprom_dev_spec dev = {};
 	ulong addr = 0, cnt = 0, off = 0;
 	int ret, index = 0;
 #ifdef CONFIG_CMD_EEPROM_LAYOUT

---
base-commit: 32ebe922e574a733d01c3f106fa77d9176bfecad
change-id: 20261014-eeprom-zero-init-cbf3df5d52ce

Best regards,
-- 
Aksel Lunde Aase <aksel.aase@disruptive-technologies.com>

