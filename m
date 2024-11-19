Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31159D6C2AF
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 23:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727BC895E8;
	Wed, 20 Nov 2024 00:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GBxlSJ34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E05C895E6; Wed, 20 Nov 2024 00:18:23 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA2889588
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 00:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fb587d0436so35554261fa.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 15:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732058300; x=1732663100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LSBy2v3QngHcufqPClEa+pLTJv9/2KO1P82nQkj+U+Q=;
 b=GBxlSJ34g6yRqIwGcP4sA+yVsDx4pupRmy04aI7FbXZUmJMf4wTeDbkXLqg/zhlXi/
 6R5VTPev8mMxI/6GptrcEik7OgVfAqocucpjB1y4ZK4Df/eSMK+sRcuxWAEVueQUnJ6X
 u9h5I+FFw/Nm88aC4Efh8J6aryb+KJBhnozV/T7mKpbWYS0qYeTd/EH7YgHS9RFe8aI3
 ZqNzRhxpHIMR5iiIZkv85R3dsh5NMdpkvtNGbcDAiBJHa3tmpsM+FxFtHSm6kt0A44I/
 1xxpn5QsllJFlYTpYNMY9nI4NaJ5W8qWBBt+SPL200L0Y1mgVT9dGzGkji4d33K5Ec8p
 urKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732058300; x=1732663100;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LSBy2v3QngHcufqPClEa+pLTJv9/2KO1P82nQkj+U+Q=;
 b=Ozl1RDdltUkuWO1w4isDs5J5gQ40mFk5f9p5DLefPwOBNZ8USC6iJjIlCy0taZvIUp
 KoTZOh2MLl+aE+G7Sx0nUAo3At49mBRG3x1Ard2K7cBI/h97ad5c7gkgsggKCmLhwX7q
 ttqeG6FUVyJC84vjSLY4O2OG53HIjMutrUriH0+Cf5SalViIQKyEUXQfQqGA+i3Lu2gJ
 AiwguTR1+LawGiKuUC5g9ZW5kqm/VItiKVSttCQG1xgth1ba+Pi11E6W0Y32RozMTuFF
 2EgVQ4wmvHY+hc9lfl3hOmhvkGbgxWQObCrQH9Rs3NLWqKrqyFwA0/BjsfqC/YqugO2i
 YkMg==
X-Gm-Message-State: AOJu0YwzBlV5SBuCVnhV6FLoz1Yk5b+Ifx2dIlVGKv3uBf8Fkzl6TRk6
 ADwUCCsDtTa3CnMUhN3k7P1abDlgFmrqLTNPySIzXKpBuoVX6D4tqOmAX5mHvUfWayGZLOjovbw
 ReP+zC0gZQye3aMUe/CXcSfa5BiNiRY+z
X-Google-Smtp-Source: AGHT+IFHT2VFhn/kWDdwAC8aM9k/ykyGBaYGIU0ZPVMweDRQBcYEG6NOYKqnupZZm+acdY/5O/AaKSR3hfU211EnVrA=
X-Received: by 2002:a05:651c:158f:b0:2ff:5897:2709 with SMTP id
 38308e7fff4ca-2ff8dd44525mr3506901fa.38.1732058300005; Tue, 19 Nov 2024
 15:18:20 -0800 (PST)
MIME-Version: 1.0
From: E Shattow <lucent@gmail.com>
Date: Tue, 19 Nov 2024 15:18:09 -0800
Message-ID: <CANV2PTN5AbNpCu4TGhZ87q_Eyeemxxwu5m=QjwKVS967x8hbnQ@mail.gmail.com>
Subject: [BUG regression in HEAD] efi: memory: use the lmb API's for
 allocating and freeing memory
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

Hello,

On HEAD some commits after v2024.10 I encounter a regression for
`bootefi bootmgr` fail with error "Not a PE-COFF file";  The fall-thru
case of global EFI boot is successful.

Having run a git bisect I discover the first bad commit 22f2c9ed:

$ git checkout -b master origin/master
branch 'master' set up to track 'origin/master'.
Switched to a new branch 'master'
$ git bisect start
status: waiting for both good and bad commits
$ git bisect bad HEAD
status: waiting for good commit(s), bad commit known
$ git bisect good v2024.10
Bisecting: 850 revisions left to test after this (roughly 10 steps)
[82686e678e1587ddbd9570f82c58cdc3aecf2dbe] Merge branch 'staging' of
https://source.denx.de/u-boot/custodians/u-boot-tegra
$ git bisect good
Bisecting: 422 revisions left to test after this (roughly 9 steps)
[8963d433eb5d4a9f3a9def84e9c61a45c13e72bc] Merge tag
'u-boot-rockchip-20241026' of
https://gitlab.denx.de/u-boot/custodians/u-boot-rockchip
$ git bisect bad
Bisecting: 214 revisions left to test after this (roughly 8 steps)
[0a504585d1cefeaf35ae8f860a5e5aa44dfffed5] arm: dts: k3-j722s-binman:
Add support for HS-SE
$ git bisect bad
Bisecting: 106 revisions left to test after this (roughly 7 steps)
[88057dab2cde8710ccc95d12fb312184e0b023ca] mtd: spi-nor: Allow flashes
to specify MTD writesize
$ git bisect good
Bisecting: 53 revisions left to test after this (roughly 6 steps)
[625d40ab120dbc6f45dbd975857f8f87e422bd0f] test: boot: fix
bootflow_cmd_label for when DSA_SANDBOX is disabled
$ git bisect bad
Bisecting: 26 revisions left to test after this (roughly 5 steps)
[5b9261fb0b1ed087387f2036d279fd3f4bb20a61] Makefile: Drop
SPL_FIT_GENERATOR support
$ git bisect good
Bisecting: 13 revisions left to test after this (roughly 4 steps)
[e1b6822d6522d94d579d53092342b542d368a04b] efi_memory: do not add RAM
memory to the memory map
$ git bisect bad
Bisecting: 6 revisions left to test after this (roughly 3 steps)
[2f6191526a1325b6ddb59795a093eca69dbf8976] lmb: notify of any changes
to the LMB memory map
$ git bisect bad
Bisecting: 2 revisions left to test after this (roughly 2 steps)
[3c6896ad2fb876b0a23202f62a83c0d44380c9ea] lmb: add a flag to allow
suppressing memory map change notification
$ git bisect good
Bisecting: 0 revisions left to test after this (roughly 1 step)
[22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1] efi: memory: use the lmb
API's for allocating and freeing memory
$ git bisect bad
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[eb052cbb896fee6f947765b44b0d80a54b19ce1a] lmb: add and reserve memory
above ram_top
$ git bisect good
22f2c9ed9f533a56bed09bd4e0e37852b6b9f3b1 is the first bad commit

A commit is good if Star64 boots and absent the error about "Not a
PE-COFF file" (duly confirmed by eficonfig to adjust boot order
allowing removable media of an OS installer image on SD Card to be the
priority, verifying that the installer runs as expected).  A commit is
bad if U-Boot crashes and/or has the error "Not a PE-COFF file".

For context, the Star64 eMMC contains here an installed Debian Linux
OS in the usual way with Grub2 EFI on the EFI System Partition there,
and that image boots fine from U-Boot v2024.10 also when loaded into
memory and using 'bootefi' directly on that memory address.

Best regards,

-E Shattow
