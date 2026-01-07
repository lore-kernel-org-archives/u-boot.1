Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AACCFD624
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 13:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D4483AAC;
	Wed,  7 Jan 2026 14:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YiaA66UE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70A4283B86; Wed,  7 Jan 2026 14:00:18 +0100 (CET)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD80E839D7
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 14:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-11f42e971d6so2340795c88.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 05:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767790813; x=1768395613; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lOvy51uoIF1sJkEXpyINcAqk5YtOj9RA7WqvkIAuUOk=;
 b=YiaA66UEH65WTDtp5OJCw2OTi1/o9i5ULNwtiV3ijeNlMW49g84HhS5kxbuKdDVPdA
 HL08sFyXrphTh+DQPUKAr1KV08KCyT8G8tXn3OCJ9pZ75t+CMaPmCYd6E9AUY3a+eDLq
 9vmEatI56S4RSJwdMA13GLi4uQET41uB1eUvY9PfdVZ+MaSscHueEG4vPr5t5QJgkMUj
 D92BGA77pNd2o0bnOCgeGe6AKFR5fdTsCJqUvm3bVL2oRrQem1Mdb46kRhRVKj51Nyua
 6Puuv9egYV2DlTdIBEAs+Y0bujpH6DBO/jcCGXe8T2GkcCQITzLGI2SOW4pBMAxjXS3E
 gfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767790813; x=1768395613;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lOvy51uoIF1sJkEXpyINcAqk5YtOj9RA7WqvkIAuUOk=;
 b=SXk5fwLiGLx5m1t4G9ZU7cFu1jbviMMfBdqjXqorH2enh35A0gUvyhhhsXxZxKBQ3j
 jjYoPGtfcG6qa716U02Q0CFtZWhRDzB6DqmfvlXtb5iDyFBhliYChRrjdwijwaaFN5tN
 K59euG534YP7UUoZyHP7Vf0iJRpWeKQduXJcbcz6Ucc4rRHYYj8Nwi3l1RAWvO6XiDwb
 p4T+1owdbvyc36VLwVlqQrbDIt0w+iulGIAeexvphSb+T+7Qguvxb25ht0NlGsY/cFEF
 D1Qn+34XjsrGz9t09HlmZljZNZfV12JVh02eM+rrNQpZlHItamlxAPwQ+qN66yZPtc1/
 MzEg==
X-Gm-Message-State: AOJu0YzflP6x3ZrxWG5gKooAgdMELIr7r67sLtIspcrRlqS8uPIwDbUP
 q4WBxtQ/7SozVc32OcPQZ2iNH1kygI6NSAOvYYHj0KQRHUvda0BzDr/nFch3ykzCv8KXPhY5DF0
 YRz7kiN+OCWy+PR830gGDf09yvLgc89MH0jlK1io=
X-Gm-Gg: AY/fxX67IlePIoPzT/Yioytuy5NngolIPFc89BmrwAczcxteXKpvCpr0I/vWDWYruzr
 n/C7zxxW/xwI0JuGMb8Pgqebo6h+WAW/Erpm9GC8nn8D5CZr+5nEcyuQjCeGlZ3JJZ0+/tI3Qgg
 EbWyzmGQ2S+MotnxZfoNPzDIZF6UNCRDNpo32czvbVOThigsXTQASPtDBQQvg4eV++rBcpqh9ai
 B7ja/0Lcu0LaCqYpcQHkYByXnfK1Uv69iCnSnw8NUyQhSycu++gTmnaqY7lk1pvxAtE
X-Google-Smtp-Source: AGHT+IEmT57DF9NkNC44OpKGzm3yNZ0McxAVtUqGCyNmEtolWFRIQaoE0+Nq5xjVyLzJ4Nm5p+wEdfUUyaHzGa58Snk=
X-Received: by 2002:a05:7022:a84:b0:11b:c2ea:daed with SMTP id
 a92af1059eb24-121f8b40da3mr2290137c88.32.1767790811739; Wed, 07 Jan 2026
 05:00:11 -0800 (PST)
MIME-Version: 1.0
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Wed, 7 Jan 2026 16:00:00 +0300
X-Gm-Features: AQt7F2qTjg6XDpewQE56MhlDceSwFufzhK2oCaXvMOWGMdB31NVFez9S_YrKMFw
Message-ID: <CAJs94EbyBnv=q6Gxp0WAhTRakxKm9xXgnriCVXQiycSem5qpCQ@mail.gmail.com>
Subject: FDT overlay: lost in the documentation
To: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hello

I have a board with SPI where U-Boot image is located along with
environment settings. The image is supplied with correct FDT, so no
additional dtb files are required to boot Linux from MMC. I.e. fdtcontrol
variable is set up by U-Boot. Then EFI is used to execute Grub2 which
handles the rest.

I've read
https://docs.u-boot.org/en/latest/usage/fdt_overlays.html#manually-loading-and-applying-overlays
but it describes mostly how to do the overlay loading manually. What I want
to achieve is to automatically apply FDT overlay from a specific dtbo file
located on MMC at each boot. What is the recommended way to do that? Will
rewriting the bootcmd env with pretended commands work for me?



With best regards,
Matwey V. Kornilov
