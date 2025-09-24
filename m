Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE84CAC5A7
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 09:09:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A1880B9B;
	Wed, 24 Sep 2025 11:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="ELJz2cw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D814C833E9; Wed, 24 Sep 2025 11:09:35 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D401C80107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 11:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-36a6a39752bso34322281fa.0
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 02:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1758704970; x=1759309770; darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=m1TyA5zYcSjMjLYAvbSEd0p6kyG5NibiIUQWtTcKTfw=;
 b=ELJz2cw8cj7cygs3GVNhC9WC5MER3WAMjLaTd4GF51qxBTry0gzhtL6pmIs/uPf2an
 08m5PxSGnsgKI0iAG8i9YXpP1b/6SSB4hazLQqVJe+I3Wdb2mqQEq/jKDdOI+L1vF85/
 HkcDCHRCGbek53N2xNNJTmM0V8MUoXOtK1xjtNJyYxSqdnw9k6SIuY/5dLmsUWKo1W1A
 uSnEPFVbBd0qPtkMamjSo9pibtJyh75/tNhiJvV85/I7rc4ulSa7eGhA0hssNo6tdM6I
 U6muzvpes6OqueVG5HustvzYNETEAFQZomSXEVJX7o/6aT0JcJ7N2fnYbxi++yj0cyIG
 vR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758704970; x=1759309770;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m1TyA5zYcSjMjLYAvbSEd0p6kyG5NibiIUQWtTcKTfw=;
 b=iX/gLdCV3YlTCyLnTJtHoaaUxaRRRHde7Zqqy9rVQ6IHTEcjqegVYdfimdW4EdAKgD
 lmLtk/DcrP68sf5SO2JuMNByP8QPZr0ZGEqNVygJEZ5C3pf2OiTG4gegooN3DHCg0ywD
 49rzf30FfFa4oFiagSm7OHrKcDLdgqqiN/VthEryf/1ShHD8uYyXIqyhlLqgF2+JwFGW
 Mll0A6Sg/gwzW54WKFDalQS5bRe7vo0CwAA9M7/9jnvhMJzNgaAmDRsNmbfglay5LMsd
 X41HBHzx68ZQJS3g9HKRmuxqOkVgsbXsOzNgKrPX4UFJFGzXcU17Teb0OsuVv1sDNaJV
 LoCA==
X-Gm-Message-State: AOJu0Yxm4Li9gLlTHaDbAtSFHl0AJHY1eEMNEYAo+SbYCew0GBsl9zqS
 8O+MEVrFMien5cL5CvMhSCYgxXVnbe8hggV9Q9ASWqQ8srsJO+BcMDqF78otOlh6KS52pBpAVnI
 6NxlDogf/xtxDAAGCrO4WUuSRublDyCzd7EkO
X-Gm-Gg: ASbGncu4a5ilb/F2W+o1/asdTrCzPK5VmDpMD/zzBY49J2mIxHvrwakXar3W2Sl/aw8
 9/usnC0XAtoETzL9JwGlCMFHEBTP8ICfBslkiFV37R5juFcX3W/UagqnwVdBz1R8K2Az6ridqa7
 ZdA4fzyyf7WpvKeXGwu2CfP1iLKASKHfM/MHGTr61CRoonUP7fbIi2DSaSOeRBet+AJ9f9oNAv7
 QGlrPF3
X-Google-Smtp-Source: AGHT+IGHYbm+UYwSJyulmXsNV2ad7wNg6q355F80ToV6/+9ldYmp5UWv4sDCN3i0KHBIz7I8DqAn/M11YzdbY9kHG6s=
X-Received: by 2002:a05:651c:1991:b0:36d:5c6d:fd57 with SMTP id
 38308e7fff4ca-36d5c6e0176mr17604531fa.32.1758704970073; Wed, 24 Sep 2025
 02:09:30 -0700 (PDT)
MIME-Version: 1.0
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Wed, 24 Sep 2025 11:09:16 +0200
X-Gm-Features: AS18NWBMjvOV8Q56uY9-_2d27rICA2_r2Eo5b-GAw5obdihw47i1zdjVDxJKO5c
Message-ID: <CAGm1_ktPcqpCzy=B=_n1fZS5dZVCB208qt8CTgBJak=V0xfgEQ@mail.gmail.com>
Subject: am335x: NAND boot problem using the legacy u-boot.img
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: seanga2@gmail.com, Tom Rini <trini@konsulko.com>,
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

HI all,

trying to boot using the latest master, I get the following error:

U-Boot SPL 2025.10-rc4 (Sep 23 2025 - 16:45:07 +0200)
Trying to boot from NAND
Error: -5
SPL: failed to boot from all boot devices (err=-5)
### ERROR ### Please RESET the board ###

It turns out that bl_len will be set to 0 in spl_nand_read():

spl_set_bl_len(load, nand_page_size());

This sets the aligned image size to 0 in _spl_load():

size = ALIGN(spl_image->size + overhead, spl_get_bl_len(info));

Looks like FIT images with full FIT support will be also affected:

                       read = info->read(info, offset,
                                           ALIGN(size, spl_get_bl_len(info)),
                                            buf);

If I manually set bl_len to 1, I can boot without an issue. What am I missing?

Best regards,
Yegor
