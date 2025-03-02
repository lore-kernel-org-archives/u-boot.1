Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC1EC282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 04:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CCFF811B3;
	Mon,  3 Mar 2025 05:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JPfMAvJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8651780842; Sun,  2 Mar 2025 22:33:15 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D49CB807B1
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 22:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=estesjn2020@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2234bec7192so45324025ad.2
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 13:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740951190; x=1741555990; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=43r40FPLcdN4ZJa/4H7kccq3l1qSbki0NTnIi2KlCW0=;
 b=JPfMAvJZnkrsvGQrbxHN3R63PGd/U1vGknqLcHirGMnJ4Sriw6D9hrKhieC343+6Tu
 44TNIWLyP85gBCRo1RJ6V6u2F45lagHuITY2LfCPlUh13LYk+eqjh4myBW2tI/LhbOjW
 5UP6uPs41rKjGfDhE5Cb3WXwT0qhV8tnPmAfwXx0PeCno0DhO8W+HgL2uj7EpLSO1cCI
 Gfrgz1kc7v1eGMQokF03Ggwif5Y81AldkDwu3f0jX/a/mh3b/Y++NNizGq1G46aWF8hX
 Tf9IVGFxlzBedXAZgAq3byQX4kRRkONBzCI6aaqcCQzLO4SMJ0etPH+4eyDMhdsb/i6E
 GYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740951190; x=1741555990;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=43r40FPLcdN4ZJa/4H7kccq3l1qSbki0NTnIi2KlCW0=;
 b=d+7sKlZmArpu6f1BeafLaN7NdUCeqDgwlLjeYf7lLWV5jF+Y42lctzKsD1SlOCrUro
 f0zpEILVXu+rcvh0uLo90Z5VmujBkZsGJPOX0CchDF67+qEICLEPcCEZVCDJFVzfiHfg
 5v8CArw8afIUDGCcLoClGxaeA7jPVeTLjVX8qNhavTkbt2MeWH8baOhim8NHpqIGK2a7
 qmzOBf2vbAe2wDJxKd/jN0br62iakYFSUr0mtQqKkiqsoJJ2uw0rF2AznZqSkBzV3Em0
 ZYZRdeidrY+Q50WTgH4fCe7Pi2GMzO1zwpS5BiyvjfDg8JJL/IlwMi+TDpBaobrfVuBQ
 oeIQ==
X-Gm-Message-State: AOJu0YxfIzBtuG9QodAPLeGRUWESC/sgTZQ1cVFR1Jn/JFuTHkp+6CC6
 /r3K8FBhmfTNCKWXLqSjyTX9sRa1IXizv6MAeN3TFNSxffdihjeIYdeoU+1TCJ3GsgE8KNco6UV
 pVc8kr6OvLoem65Pl80lw6YsC6x/jThEzGQ==
X-Gm-Gg: ASbGnctECFXWG1TXml/2I5BnCIVgrCd/fPNjari4Q0Z8N0JScVOXiGKZ3eBQj0EhNcK
 p/mgHdHd5lfPFii6r66QdfX0jDk4QQT5vbp4nWrfJXbDP+edk+qqrPLJ7g1ia09/bh/dW+ev2Qz
 1y2uRq8dOYXiH95EqdqoujCbfPdApsdyBPc2eqETW9A9HgvWcjdgYxMpjmdw==
X-Google-Smtp-Source: AGHT+IGEbGs9UpIaK+B5A4ucEK46GzWmhQ+n4yNkwS5wQnAN0/+5holy7gDFXZJPhGQnU9LtZCtt6a/HcazYbGRAvYU=
X-Received: by 2002:a17:903:f86:b0:223:536d:f67b with SMTP id
 d9443c01a7336-2236920780dmr184887905ad.38.1740951189772; Sun, 02 Mar 2025
 13:33:09 -0800 (PST)
MIME-Version: 1.0
From: Joshua Estes <estesjn2020@gmail.com>
Date: Sun, 2 Mar 2025 16:33:00 -0500
X-Gm-Features: AQ5f1JrS0D8psbrVbVKI58Sat1GEIE1KxvvswDTyaxdMnDRCFKgzqUCh930di98
Message-ID: <CAHUV=EbJhrGXQ26xT-OM8HAsWsB7=VMkg=XKyX4w_jfKS6a9FA@mail.gmail.com>
Subject: examples: I2C Driver Model in Standalone Applications
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 03 Mar 2025 05:42:45 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hey all,

I am currently trying to build a standalone application using the driver
model functions to interface with the Designware I2C Controller on my SoC.
I believe I have correctly used the driver model functions such that I can
read and write to an I2C device, but when I try to compile the code with
the following configuration options added to socfpga_de10_nano_defconfig I
get a few errors from the linker about undefined references to
"uclass_get_device_by_seq", "dm_i2c_probe", and "dm_i2c_read".

CONFIG_DM=y
CONNFIG_CMD_I2C=y
CONFIG_API=y
CONFIG_EXAMPLES=y
CONFIG_STANDALONE_LOAD_ADDR=0x0c100000
CONFIG_SYS_MMC_MAX_DEVICE=1

My code is located at:
https://github.com/jestes15/DE10-Nano_u-boot-socfpga/blob/socfpga_v2024.07/examples/standalone/i2c_test.c

What do I need to do that would allow me to compile my standalone
application? Is there documentation I can read that explains more of this,
I have looked through this "https://docs.u-boot.org/en/latest/" and
didn't see anything.

Very respectfully,
Joshua Estes
