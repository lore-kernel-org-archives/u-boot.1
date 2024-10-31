Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46520E6748F
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 23:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8796C88E5C;
	Fri,  1 Nov 2024 00:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZJZdrDkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A0888E61; Thu, 31 Oct 2024 18:26:03 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FED488D54
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 18:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=surajsonawane0215@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c984352742so1443789a12.1
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730395560; x=1731000360; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bm53QEbFLaieW0PqrxcBefuXiWiUc2YKnRL0gzTbXIU=;
 b=ZJZdrDkWK6UNOqQ6KokP5Wh5GBPnMq/4QcaeN0auhvtE25jjJi1qzS45jZhrUMry2o
 wlZ4wQ7LUCJ6wks1CdDBUfyo5a6XS1bIuvG0760gcFoR55/yUPLaXaQ0e7e5CH2djjyA
 pdWCcZR6MH7jVLN8Zlvb5cuwwzleFUWj7zOL9G5v8z5yHPkF9dIppppKQH87Ci0pxV/N
 AjCME6HyKidirGrgIglydqXNNbldNsS+LcNj626lJlnVXpUt0TaBatbHCw1eZRKScFcp
 Qggoq7lSrNvhfb9QGfTwWTmxEgUf/PzlnkVagxHGB7R0fyyf46izClhXx0DQRIJvD4R/
 GxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730395560; x=1731000360;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bm53QEbFLaieW0PqrxcBefuXiWiUc2YKnRL0gzTbXIU=;
 b=GJFGhcdsxDTcCAxGf6r8rm4h+DRVispXhZqAWgcC8mebUd1FOQ6lx8puH7Z1yLITaU
 7O/klc1dyZN1U0e5+5/RnWZhz7CnL/bxx25o+VobgcpNjnRgAjeb8anx03g4zPBdp4q/
 TEfl0xn0lJ/0FHQgyXnxPev85twYhpn1z80qUYs0jYxvLJRw9xy90FmjjRR6+aQLThn4
 Tfe3/WDvw62iuqUXIyVVXOFle6WabLnU5L2OX1bqlmBZPUPphFWCYJBFL0WnWs5yi0Hr
 Syz7T0d3MIvi3k1bhk0U9Y8ROWCnWqFU+uIp3lPsjHHoUbsqHon+2CNOEdoaFCLfMCCB
 Gpaw==
X-Gm-Message-State: AOJu0Yz8QeEICqz7b8hafsHaPcaIR49xv/Hi4UwLSg6nJyM72wXj8NmR
 d1ZSRN1nG2AF1LUZNHbK++wsfYmnJqcVD0sPCR2alFanNCK9XrY2HuVQegi5Ao3Tgr0R+VHilxK
 +9xOZYmoLAvhGI2aTA7CRYanon6YzeHmLyjc=
X-Google-Smtp-Source: AGHT+IE1RfphvkEjHeq08Bb4Z1Hr++18Kut0+JjATfxe3Ouabq65WrlxP9Hprp0R06APVDxcr6Dq+ItBLVIROfNG5NA=
X-Received: by 2002:a17:907:7215:b0:a9a:8028:45d8 with SMTP id
 a640c23a62f3a-a9de5d6f953mr2061318166b.7.1730395560410; Thu, 31 Oct 2024
 10:26:00 -0700 (PDT)
MIME-Version: 1.0
From: Suraj Sonawane <surajsonawane0215@gmail.com>
Date: Thu, 31 Oct 2024 22:55:24 +0530
Message-ID: <CAHiZj8jq3JC0=o9LasZ5Xz2AvhvaSyLbpZED+fawcfFn5GdVrw@mail.gmail.com>
Subject: Suggestions for Custom U-Boot Project
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 01 Nov 2024 00:20:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi everyone!

I'm planning to work on a U-Boot project for learning and would love some
input. My idea is to create a customized U-Boot bootloader with features
like dual boot, A/B System Updates, secure boot, and OTA updates. If anyone
has suggestions to enhance this project or ideas for other interesting
U-Boot features to explore, I=E2=80=99d really appreciate it!

Thanks in advance for any guidance!
Best Regards,
Suraj Sonawane
