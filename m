Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3179CC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 19:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6239D875EF;
	Tue,  7 Nov 2023 20:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KLSJElrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F4718712E; Tue,  7 Nov 2023 19:57:25 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F0E7875A9
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 19:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rathore4u@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9e28724ac88so149230766b.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 10:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699383442; x=1699988242; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5yzEWM4B6OuBweUz+jIcxS+UspEEQ8771VAvy/JOfR8=;
 b=KLSJElrGmo1ThXGkBq4jF9QK2tW2Q7q+k99r544katooEbW3ezl0bDWq0Ec2wQTVUM
 FP1WFvso5asSrb6k65knEN3UORbWuU6wrny1t1fROw1hW5/eJMLNR3CmnKVypE9t5ftk
 jwpHGo89pjs6kkjpkehQUyqIfq283XCUXuXlC7qgE5waZ3M+am+MiHfNRZdN7mdvYL2C
 hwB97mYUMXfQ+7pBtKBsiYFAeEc8emYdDzO2atXvhKotmJKlnAQegiRQJw6FJ8S1TesO
 q3oW7SRwV/Qe2Omvizvlb3hckD/CXBPYB5V643dPB6vlStcLlVCYOO/lNszahke2OrjQ
 JdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383442; x=1699988242;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5yzEWM4B6OuBweUz+jIcxS+UspEEQ8771VAvy/JOfR8=;
 b=UbRXfX/tv9Uh3rD7N3Bz/uclxZfbFjOCNoWFN4ZZBdlAbWOUoPNAEudN/EVBzHtFNB
 VnUhzoYonkGA1HQLnFl7B+t+G/fbuYtZvvaLdsBoHPvx0Vu2mtAb2Wjur0j+eJSWouIv
 HixHZ+TNR5d+x+MN1S2tiI7htk8Ub+pgXrTFLnrQn9FyMWDcIP0jXJ8tuU/SDjyayHGZ
 Xno7TOclJdG7wk/qX2PE1T2r7ZJ+VTTfyHt26Kko7AM3pHqUBerB/6DzezH3ebouMIwG
 kj684eQXITXkUBUiJ3LMxHJm8/bmUBSQ3Q2TPhBkilckK0xRJ4HdspNh66C2JGmvZv1b
 VMjQ==
X-Gm-Message-State: AOJu0YwmE0owRu4h508BIxCqSAdXIDCABC+yNviejFBwc/8z/FwiNLYP
 4ETZ6XiqqQcJusO1wyvMlR/V9gLRpzXdzx18fUJyYws6MJU=
X-Google-Smtp-Source: AGHT+IHYAgGlE0XKh88Wk7LmWiomok8y7zzs/FwKy6r82ZqDoBSRXdFfUrYgNiteVt+J5+aHFS2SPn0U6ZmlRDPQCjo=
X-Received: by 2002:a17:906:7309:b0:9d2:414c:b92 with SMTP id
 di9-20020a170906730900b009d2414c0b92mr17963654ejc.68.1699383442302; Tue, 07
 Nov 2023 10:57:22 -0800 (PST)
MIME-Version: 1.0
From: Shantur Rathore <shantur.rathore@gmail.com>
Date: Tue, 7 Nov 2023 18:57:11 +0000
Message-ID: <CAHc5_t2RP2LB=4GAdKWdckzXwiWUpAGY4T1UCu=YuJQgFWo4Qg@mail.gmail.com>
Subject: rockpro64 rk3399 dwc3 issue
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 07 Nov 2023 20:56:12 +0100
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

Hi all,

I am trying to boot OS via USB3.0 ports on RK3399 base RockPro64.
U-boot is failing to detect the drive in the USB3.0 port.

If I boot linux through other mediums the drive is detected and works fine.
Can anyone please help me figure out the issue?

Kind regards,
Shantur
