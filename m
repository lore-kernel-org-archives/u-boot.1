Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133E6C83F26
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 08:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 632248392E;
	Fri, 25 Jul 2025 10:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KUeDmiYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0BD583930; Fri, 25 Jul 2025 10:32:37 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE69283927
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 10:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pbiel7@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-315f6b20cf9so2125870a91.2
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753432354; x=1754037154; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=x9tNN6OXrGFcO/mMIF+tDxC41jlX/mrabBhT3qrzL9I=;
 b=KUeDmiYHdDTwAOMaOVuYibaAG6N98adixXntvDJg4xLyvCRTV2eD5je8CciA+yMDAn
 46KE+KRulBa4eIUZNfIpmQ6RPjQk0Sc8Hpkti8ioOH6Tl8HJrT4fVRE1PwMjH5rOfDA4
 RZKS6uUoM8Jjh7q1ZHf46ka2D7EQEkvWdCxDx8i+uc+jsehpzza4mh85uGFwdAlaByht
 NtAobvtr5Z8NiQZwJ/UC1JA9fLlMH9IrY7FsZd8Zqpi2fjoq3ZoeD4CrNFlwXuwzcwu6
 7wKTy3HN4wyHKKyuggCCtuL75Re8DlqCcqTE24jfP+iyiOGn5wnhnxI+7bZCgM4zldPo
 mqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753432354; x=1754037154;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x9tNN6OXrGFcO/mMIF+tDxC41jlX/mrabBhT3qrzL9I=;
 b=JyWaAwAlKU+aUvkN1PI2eN49SNKNoQYDfm6oeZ/6soR/u1o9SNeXobmWJyd2IeF1ab
 rVBGliIWWqk+dKAQKHr94tr0aAiiYgmHuxfoi4pMF1Mvdp/o3DoJuv1ZOA9sdbt9WYB3
 8Uf8FMpI2NeXuvI/ZCePd8uq2LAiQAINnwdz+gMNYgX1AdB9j63fqEpqLQ2NXYaqDE4Y
 bKIJQSMLPG8ecd2D59C8vLNA+psD3WWb9kAmOa+RUrAaThcPDuVvqxvVMvaFTo4KEZiy
 FNJahVlgpmoTmo6RO/d7bsGboLtaPen5d50SsSBOCDKT+nMNKC6jkEhsk7vn3SQO/DcP
 +hQA==
X-Gm-Message-State: AOJu0Yyj+bQbL6gLVM1NqjoaNIcVPGAEGG3pj7aepMIZOnxpD4BliNHA
 t0rIO6GebN4xriz32QniHE8T7O7G/YPp8hCBrAPOpNNA2WTQpX0qGVcK0LJH3oCRGAzNrnfm48d
 9tMdR9SmtIjQcOFhQ4rowlXNqjIARBf2ICgOrBX8=
X-Gm-Gg: ASbGncs7/xMWx2v//7+T2p2nDcRMKvoUamMXD9rWEpa/DtcGSNJy1cm+l5PGytfl0DY
 uchrU47st1TseqVYUXrLO16DhVfftmEMMLFpb3Qcqj98Ki0380yCCrgBmD6e7EXAu4pFypCKlzj
 /uBXrB7gFch/awN0SIEvm+oZPrc93+Y+NgzpKBQERNArb0aVgz+HkEnOYkP6B0WXGajodCBnUUa
 ztBAA==
X-Google-Smtp-Source: AGHT+IF/AwbqAwe7XzvpM+WqpO+pVjUWnH27N8k8o6aYzH6J3jumqicwZC5nquhUfvY4A08NCkyWCT20yED6RYuW1jc=
X-Received: by 2002:a17:90b:5245:b0:313:62ee:45a with SMTP id
 98e67ed59e1d1-31e77a2f7cemr1374968a91.13.1753432353953; Fri, 25 Jul 2025
 01:32:33 -0700 (PDT)
MIME-Version: 1.0
From: Patryk <pbiel7@gmail.com>
Date: Fri, 25 Jul 2025 10:32:23 +0200
X-Gm-Features: Ac12FXzV6fXvau48_UMOZFqhtjtmvJFrdlePVhBvA0zZGLMM3TLh9MIsZLr1Oc0
Message-ID: <CA+DkFDYBjKgNOgXKQ_K9w5=vPymj+q9scbrqVSS20KEJevR9OQ@mail.gmail.com>
Subject: Migrating custom board to "Standard Boot"
To: u-boot@lists.denx.de
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

Hi
I've been working on a custom board based on NXP LS1028A and
considering migrating the boot flow to "Standard Boot".
The motivation to migrate to "Standard Boot" is that the current boot
setup provided by NXP feels a bit messy. Looking at the e.g. LS1028A
boards they support distro_boot mixed with runtime bootcmd override
based on TF-A boot source detection.
For example, if the platform booted from eMMC then u-boot overrides
bootcmd to call emmc_boot.
Maybe it will be easier if I describe what I want to achieve:
For non production I would like to be able to:
- boot from either SD or eMMC (depending on boot dev detected by TF-A)
- boot from pxe / pxe network
- boot using boot script
- support A/B slots for kernel and rootfs
For production I would like to:
- restrict boot device only to eMMC
- support A/B slots for kernel and rootfs
- boot via signed and validated boot script (validated through
escb_validate command that's used to validate signed kernel, signed
scripts and so on).

That's being said, and given the following statement from U-BOOT's
docs: "If you are using custom boot scripts for your board, consider
creating your own bootmeth to hold the logic" I'm thinking about
creating my own boot method that would:
- check boot dev
- check if there is a boot script (and optionally validate it if
secure boot is enabled)
- select A/B slots for boot
- boot the system using boot script and FIT image
But I'm not sure if this makes sense and whether or not it's the right
/ modern way to boot OS on today's u-boot.
The other thing I'm wondering is - taking all the above requirements -
 how to integrate bootcounter and bootlimit in the overall solution?
Should I use altbootcmd or handle bootcounter liimit and A/B selection
in the boot script, or perhaps integrate everything in my custom
bootmethod?

I would be grateful if someone could point me in the right direction
regarding modern U-Boot practices for this type of setup.

Best regards
// Patryk
