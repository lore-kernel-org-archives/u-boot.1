Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CBCC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25CA08771E;
	Wed, 20 Dec 2023 13:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wv004Q65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58F7386FF4; Wed, 20 Dec 2023 03:03:28 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5536386E82
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 03:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=preventivaclinica@gmail.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7b7fe0ae57bso25269139f.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703037805; x=1703642605; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=26Y9UfdE66AMb7IWsI5kS4Eh4/F/WYf8e0Y8vQzj1DE=;
 b=Wv004Q65zeWDYpthGoYdLmdE5Gr8h+ySmYlpz8F5AbCLIyx+Qpf8944N+Io/aJE58Q
 TX95yKf9eJKNaIHgPIJeXxIgIfb3Oogwf1sKb5SZjAsZfAtpZ8VaWXjb8YwUdUBHUnuZ
 wZLJ1s2BfMBCwfoWExSlWE/O5OAQpk/3I1PIZ1R6E0F+/ox8nK5A+ba5QJvIm0k90z6B
 V6+81Fve/krKE1pAl0VrDQ+nk0W+lJZTx7EoNfDVK/0I0t2Vqxa3YN+zaDoClM7V+OFd
 NFrOzG0SV3iXgyjSoa9xDF1JM93WsnD+cUiVPePdNULDnXwothWZi2Mv6ZMEVeg4VRbL
 ilvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703037805; x=1703642605;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=26Y9UfdE66AMb7IWsI5kS4Eh4/F/WYf8e0Y8vQzj1DE=;
 b=qOUc6MA+cD3KsawPmb8+NXQbX7LoR2QioGcSQDp12mcaWV57+EZHn6K9XIpIPEoqB1
 99hZfpv7Ct0BRQaJemMEVkCjrZelphgI0c6kkkylZFavLz639a5U1krwxq0ZzWWLwMnX
 G3AiHao3ZYJTdlx6uUtTz87l2xB5WdS1lilJzGme5UoqyGNqiJ1b9X54zukCZH/TZFQT
 5z8U1Y/eOPgbJFUOwK7eg3f8rVDE1M5xy716zZlas0yp3H8r8kfS8937U+0Nv6NRBexn
 QI/X13NCdH4LAll2MDZkjqz4EoXCwpUmzAdba+bUiz50JwlMLBeipJCUNwoSsA8fsfZa
 H64A==
X-Gm-Message-State: AOJu0YzKMd7hJyyIMrgr28xNn/d2+fB9H9P37MNMOie5LeamfvW+s/qH
 b1Tpmg4XKF88QDf2fCMbjXh+2VFG3xGAkO7V6ZrjlD5gAGD4Bg==
X-Google-Smtp-Source: AGHT+IFs6eCelHRik6TkSP5Bl1DmRLHyLeSO/O3MNb4TmFMVjdtC0+HEwMmJG4YLMC04Qtg1BQZSSr6WwP7He4/oUsU=
X-Received: by 2002:a6b:e915:0:b0:7b7:d6f3:8f66 with SMTP id
 u21-20020a6be915000000b007b7d6f38f66mr4651130iof.30.1703037804695; Tue, 19
 Dec 2023 18:03:24 -0800 (PST)
MIME-Version: 1.0
From: Kledson Silva <preventivaclinica@gmail.com>
Date: Tue, 19 Dec 2023 23:03:12 -0300
Message-ID: <CAJik2ecgeu+zhzJK_bjJGi8_q2A81LpszO-ZJVDxvq5cynSGHQ@mail.gmail.com>
Subject: Problem with CROSS_COMPILE
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 20 Dec 2023 13:13:44 +0100
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

Hi,
I need help, if possible with for compile and install VxWorks in my
Raspbery 4

I follow the steps in page of WindRiver, but this step
(CROSS_COMPILE=aarch64-linux-gnu-
make), i have the problem below:


include/image.h:1397:12: fatal error: openssl/evp.h: No such file or
directory
 1397 | #  include <openssl/evp.h>
      |            ^~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.host:112: tools/aisimage.o] Error 1
make: *** [Makefile:1858: tools] Error 2

Please, any idea? its for a my project of university

Thank you very much!
Best regards
