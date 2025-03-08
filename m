Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDBBC282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 12:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9029F8043C;
	Sat,  8 Mar 2025 13:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JqnGo1pB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338C68058A; Sat,  8 Mar 2025 11:07:34 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FFD980017
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 11:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alitariq4589@gmail.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7c3d9cdb0ccso523393185a.3
 for <u-boot@lists.denx.de>; Sat, 08 Mar 2025 02:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741428451; x=1742033251; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4Makyw8Mgxbv1vvmnQLWUfkzQqYyvJHa8hEq39cNtU0=;
 b=JqnGo1pB+TTp5eraeeFkI8fsqvtFtLT8HrkUB7gHViZ5l9MkPVMsMrehWk7inbs7/J
 /pzI5gCUC+NIYl4jJTIro/7u+YSBm2z2SymCuh9oofgCuM50c2LSGeWwUVhXklHiRJek
 wgRnDLI3Vf3NNQ8Qw8b7WSB+03vM1YL3iWw8p3WyZMKIRgBZs0G7gnx6R4zu/QndyPS+
 Ko3V38sA2bnJmF2zPwMsRBZfilrMQ3S2udapXhhnFgRcg/Dxh0Pri1cbLqsAZcpqlZiV
 Hm1vp1GjW90rOsePseuBFB+vY8wyRIf46MDsGvVPjYmcCyP/5gS5BeO95Vb42tnpNXUt
 HIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741428451; x=1742033251;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Makyw8Mgxbv1vvmnQLWUfkzQqYyvJHa8hEq39cNtU0=;
 b=m1WEKjqME4ay5yXMYB5BVTdDbKzvQeG59pEQD7rckFR+nUUBxKn9Ui68P/bcvqlEF7
 JvHUL5xnd8vvMNFXMtrM3+7ZVxH0+elTh3xN+j5V71dvdkOEPCzhaf+L08C6o3r8KDYU
 LJUT7xP6APwKUqnrapBhg3hPMQfAW8BOZ9Q0ibDhCAsFchBchmqQ7kllMpm1dmhVJSFb
 0lZkZoU2Dsm1UHUcw85Z/dm9EWFpPseE6kskbGXh2x/9OrgaCGe4QyWlDcyyP/YA9PLU
 WPDk/L0+Yl9XrN6ohcyg6v29IRUGEN2B32w7cTrODTYK/8YlX0u35PfCcbS5Zpk/UQl2
 G4EQ==
X-Gm-Message-State: AOJu0YwFYXrdZV/hash5Uj9Vnkv0J4mf7EafR5lxj2UPhPYvIxMW8aiz
 SRfT1KeGdzbkuPVOdn+gn8w3s6F4QU5QxlyMK7IjriE/yr7BtFDroWaZdtRgTgLiStQDKXHKKgm
 JnovJhFL97qB0uRt1tZ18BW57OOWfqZgizGQ=
X-Gm-Gg: ASbGnctcdze5bCef5ile4+Ouc40jew201yH5KgcUVifgwXRzk/sKVIQPH/qDY92FESU
 eHaOOFdUP2wM1RjmOoI5ZgNGxinXlHs7EriPNIMJWg23dUKo/1l8H4ZFMXnDHoVCq9+UUoBg6nT
 /O6qGP4q0lP2Ef4aby01dnA+v2
X-Google-Smtp-Source: AGHT+IHfn4HKFTEM6T+nBkdqmAKSlMRDEtW4uyHPKat0v0VExMXi9aK276yI2vwpE+1IuehF08cmVlX/a49LUYLPE5o=
X-Received: by 2002:a05:620a:63c4:b0:7c3:d79c:9c3b with SMTP id
 af79cd13be357-7c4e167798dmr1114624285a.5.1741428450869; Sat, 08 Mar 2025
 02:07:30 -0800 (PST)
MIME-Version: 1.0
From: Ali Tariq <alitariq4589@gmail.com>
Date: Sat, 8 Mar 2025 15:07:19 +0500
X-Gm-Features: AQ5f1Jonn1kNEBGHNHZ95yuHh60fs-VUqXnTdTZLoGDaWtnOGvTjD6hNF3JzAO8
Message-ID: <CALDOrMFBp0WVRPtXvT5mtjdw06QMZTQw9rEo38NB0o=LkT1prA@mail.gmail.com>
Subject: Building separate SPL with U-boot
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sat, 08 Mar 2025 13:54:57 +0100
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

Hello everyone,

I am trying to build a separate SPL for u-boot (which would produce a file
named FSBL.bin - first stage boot loader after the build) for testing
purposes. I am using bananapi-f3_defconfig as the config file. But I want
to know how to produce a separate SPL for any SoC or board.

Is there a specific reason why the separate SPL is not built?

Regards,
Ali
