Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75830ECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 14:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E92DC88DF5;
	Mon,  9 Sep 2024 16:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jPWPHTWM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 167D388D3F; Mon,  9 Sep 2024 09:10:11 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E849F88C7C
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 09:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aiedbebar2@gmail.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6daf46ee332so38883807b3.0
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 00:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725865808; x=1726470608; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tbmXv3qBT8urI7Z4KM5QHmvUOHS36ySBRsxSiYZLpfw=;
 b=jPWPHTWM8seTKVNoVZYAquEo3HZdJrh39zaAJEdVxFblhbe/8OSCPf0nhivPHBLTOM
 qA0WDe6MUOVykD9WF1AE2KStAgmrxrQk/W38WUT6A2qmDjUkJzalLFZTuxF1cxcsjXHK
 OJ33HmEYZIzTsU0M8ZqA3JxMlXSMvtzRZLPC7UxLGV8+3fDXzLDL0DF/vYpa3ABC6EcN
 fyEwTO/DfElvcTcQdWChYWVua8aQr0B/bV1DlYNG/r84T4514CKB2PlsBVPA4OVoTc4y
 EYkfk6kKnltKtr/PnC0h326BwmRPA53Qsg8LvDi/l9UKsC+Scq8CnrmRe2hljHrIHVRy
 qLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725865808; x=1726470608;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tbmXv3qBT8urI7Z4KM5QHmvUOHS36ySBRsxSiYZLpfw=;
 b=j6hCvvHIsiNVvRJmbObqHRQ2hNB1FqPyqF/7soY6+rhnn2cUFdWcAKj4ZE3GVBhzhM
 Q9sq8vvVu5DR0Ieiq3mJiHJJhWVnJE0Vm8fYWUMwJr9gllk7iCoVFsXtL3Rg10cAKmbU
 JQP5biekBSo9vTlp+NVcQnHvXJqG3o3LZFRxXlbATtHXMGvBmT2mqxQklgufMlRKT2IY
 zOkWkvwX0Lx+mIqPAIS2prcGlp7Zh59PV8ypducSM82hyY4WASWAxcfaPoVWnh0ijwCM
 fZG+EE8vUmSFnt5MoiCpITHlXJFqCOxl7vVC9AGJG77bCBX25+hQxRuD0qmx2y3YQB96
 Tqkg==
X-Gm-Message-State: AOJu0YypSlHk5ziQH4PKEA0kpKWmAuwfps0mfWR92DMShh2oCWsIkW/h
 Hxix/T4VIWMQkT++4S4Rf9qbLhh0w5gPy+XKd+exCvqCfSASSzrcb25zQ6nB+SvDpbsc644osAy
 2tIuxB5+gDiSIe1dZxqOnSMvBwqag31EE
X-Google-Smtp-Source: AGHT+IErLeME2zm3bfqq+7a8UOT+rmT31oBKZeTT09YOJswfdK2r1P87dJ+HJkZbiM78a+r0GG0FOMs7sWyZp5bAOmo=
X-Received: by 2002:a05:690c:60c2:b0:62f:aaaa:187a with SMTP id
 00721157ae682-6db44dc6066mr136299937b3.14.1725865807645; Mon, 09 Sep 2024
 00:10:07 -0700 (PDT)
MIME-Version: 1.0
From: aied bebar <aiedbebar2@gmail.com>
Date: Mon, 9 Sep 2024 10:09:04 +0300
Message-ID: <CAA411mfoFoZSAre8HefwrgW-Nn5Ya4O+YWeHvcPUnK=3HHKHiA@mail.gmail.com>
Subject: DE1-SOC LKM MAKEFILE ON U-Boot SPL 2013.01.01
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 09 Sep 2024 16:25:45 +0200
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

HII , I AM USING A DE1-SOC BOARD THAT IS BASED ON U-Boot SPL 2013.01.01

THE BOARD IS :Altera SOCFPGA Cyclone V Board

i downloaded the console version of linux os from terasic and its working
fine on the board

I am trying to load a simple lkm that prints "hello world" on the kernel ,
and in the makefile we need to specify the source directory location. I
tried all the options and examples of makefiles that I could lay my hands
on , and nothing seems to work .

in some cases it worked but when i try to load the module on the board
using insmod command i get "invalid file format  "

i tried to get some help in roketboard forum and in intel community forums
without any success , so i thought maybe i can get help from you cause from
what i understand the console ver is based on U-Boot SPL 2013.01.01

i need to know the path where are the source files located in U-Boot SPL
2013.01.01

and if you have a make file that is tested on the de1-soc maybe for
compiling linux kernel modules (device drivers) i be glad for any help
,thanks in advance
