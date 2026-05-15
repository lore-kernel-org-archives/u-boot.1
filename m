Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BA4CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E422084099;
	Fri, 15 May 2026 14:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n4bn80S2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04AE884683; Fri, 15 May 2026 14:49:43 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B7484099
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso1818427a12.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 05:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778849378; cv=none;
 d=google.com; s=arc-20240605;
 b=go2bO0YhgUER919DPdkwUUnbErhnQCNbleTSauS6pmtN6/gRKjHiwNl8NhYZhw/lKZ
 x1WIEvW6g/0EB1tYQUMwhPJo7C2MiZOVHsKTTC364LCmkkyS0UHdLIJ+2n/CzWDy3nVg
 zUdMJ9cex7kit3y4Nfi/Yg+hSdLqH2ERxGRbAB5y18HFevqGYd/FWi5djtQuFSp3iGL2
 RrnnGX+P90dR/9OFKUm2TvXd8KAYG+WEKOoY/s7Z5JsnNf/ZwrionfWjzjaSPFrbdV4g
 4oNWlZtmfvnguf/ojMv9wcnE1z/NsqCQUxjdfcQPwQXXSrR97COC/Pl8kCG3Erwj8NoT
 NQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=91VbVHHMfZJ9MZ4rUXbiz2r7oAONk82jdgQlZpKrgf0=;
 fh=bnupiERZn2PI+MmEvXIHvRvb/x9C+g9PVm9rW1kLi8I=;
 b=QI6P8mG9ig0r9KaQ7qbTY1VZjYvrSAHXQ+Lb6F4Mk/mR6q2+B4Y+tRR1hXfApjR2w2
 JF6LCyLGC21tel4k/DTK4YVX94mfmWNeArAftSpueII3jDMPNJadAJhRvgm767tr7PSp
 J4C/9xHGfSlqLItqIDBKRm4/IH32W10Cf0KUHfETSogbIdickzoeova95VfO7lc96Zhm
 S8SMCxRTTdEMfxlrywX+9ybOUNFpbDX3DihyZlRCpbhuARAlzjDQ3zbmERp88lcjHmfl
 93GmrLqvc7IzlIm5zh0oOkNEt2j5YjS6/C4Dh4NxsqmBXmM3ul3AERciXp5Gy7n7lAWL
 XmUQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778849378; x=1779454178; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91VbVHHMfZJ9MZ4rUXbiz2r7oAONk82jdgQlZpKrgf0=;
 b=n4bn80S2QMxyjDBR8h8xIMTtgrC4wOZQPnhjhJaXextgdts3S0qp0FhZu4ynMc+iJz
 4IJnoJnHW2TBo2mWAWnzSaFjOUBMFJSMaStYy95CKcek98s8xB6ysjpvejeGhfacJmXE
 rFCGI1HBmzv9mqSCYnG8XX0OZLq6DdTNH4aMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778849378; x=1779454178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=91VbVHHMfZJ9MZ4rUXbiz2r7oAONk82jdgQlZpKrgf0=;
 b=MrCMdnydoC7pG5z59pfkboC9xZirfT5IjSH2EzbkTjs3a+kphGDXgY3+C2k+LM0KIo
 KSZ+DAMw6ugNGV1j0W6EZ15WejbCx2CJQ3F524ZrKNX+13JaLBi0bi0vswaCMxV0+Kr0
 arDkpkAkZkY9z0tlrU+KQIKLRinh+oyEBmbR64SRwBO45wW9eLEGQspBpDk2BUkBck3U
 nBc/sTGc8+e9BV3vKPytHa/2Hl6dN3vPIj4H2GEa1rnXCHiAw1VrzYFBE77U0PwtqIOI
 JvV2GPPmdwxFEUIEHVO5UPACy0DnE9M5VQzfuaSVNSCEJPYFmY/nsiK9OpV+91iezODD
 JqGg==
X-Gm-Message-State: AOJu0YwOoG3n1It9oUKYkW7UD3x4U9zxzaHGmsvNxCu+CHdTqasPO31I
 8ISARvDcvJjbdRHQuW+CdzX760QAp4oHw8qX/FegIHDb00G+uQkyXFv2IgJzHddFK/csIiJYDOs
 ZNF5eHF1U7F4WTbjQVAyEUyqCtFFJexvsJzj0Mvpw
X-Gm-Gg: Acq92OEV3jCMMJXtNN0kAPPVKsAlukiMSccknVZqF5ToYKI7xHljQHW82bDc3KG2ZNQ
 iVYwraMBIo2gFQvfy6Q6py4vTIuiNs/3NysjfcvQ6jtt+qF0/smqdzr6IdquVJLVSoagZAirjlu
 eLPLm27ycv7SloqCRjTYsZdMUBRb60fWVt2JYEtFd2G1TlEUpwxeNT2axJF39Rfu83xoiIQoRZP
 AGzVZB5Kp/jT3A4JcKBP2gO2XpZcaZEvQfu7UxoLevU9MeDZVYiRBDO19ayp/SKmA8Fv056DxXQ
 2RpiFki8Ntkzy9yD
X-Received: by 2002:a17:907:e105:b0:bd0:6293:bd0d with SMTP id
 a640c23a62f3a-bd51538f0bcmr126700266b.7.1778849377787; Fri, 15 May 2026
 05:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260511220555.GM1858239@bill-the-cat>
In-Reply-To: <20260511220555.GM1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 06:49:25 -0600
X-Gm-Features: AVHnY4Jo166GnKOEjNxHP_SG9poTlIxRhU4FTvcu5rH8Og-3Bl__bYsBMlxWH0g
Message-ID: <CAFLszThULFjq_R4A1nWYjQcQ4Odw3aZ200RPmQ56Ecf3gO4UYA@mail.gmail.com>
Subject: Re: [ANN] U-Boot v2026.07-rc2 released
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de, 
 u-boot-board-maintainers@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

On Mon, 11 May 2026 at 16:06, Tom Rini <trini@konsulko.com> wrote:
>
> Hey all,
>
> So it's release day and I have tagged and pushed things out.
>
> As I mentioned earlier today[1], I would like to again thank DENX (and
> the Denk family) for supporting the project for so long, and we're
> starting the process of moving our infrastructure to the OSU OSL lab and
> the u-boot-project.org domain.
>
> The delta between -rc1 and -rc2 looks OK to me, and I do still think
> there's a few outstanding PRs to come in and a few things I should pick
> up as well. But, the next branch is now open and so bigger changes
> should target that and I will be applying a few things there shortly.
>
> To repeat what I said in rc2 (and will keep repeatint) is that it might
> really be time to retire support for running our tools on Windows under
> MSYS, rather than something like WSL. The move to support more modern
> OpenSSL versions has hit a lack of support problem in MSYS[2].

I'm not really the right person to answer this, since I'm not a
Windows user. But as I understand it, this would mean not building
Windows executables anymore. Is that right?

Should we perhaps just build without the pkcs11-provider feature?

>
> We're continuing with a community meeting following the release and the
> calendar link is
> https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMHYz=
YzQ1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWM=
wNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=
=3D89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group=
.calendar.google.com&scp=3DALL
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/yyx-dsaj-iwr
> May 12th, 2025. 9am (GMT -06:00)
>
> To join by phone:
> https://meet.google.com/tel/yyx-dsaj-iwr?pin=3D7760044274127&hs=3D1
>
> In terms of a rough changelog:
> - Platform fixes for Atmel, MediaTek, STM32, m68k, Renesas,
>   QorIQ/Layerscape, MIPS and TI K3
> - Fixes in our USB, UEFI, Documentation, and networking subsystems.
> - Updates to our binman tooling
>
> I continue to plan to do an rc release every two weeks and the final
> release will be 06 July 2026.
>
> Thanks all!
>
> [1]: https://lore.kernel.org/u-boot/20260511174116.GJ1858239@bill-the-cat=
/
> [2]: https://lore.kernel.org/u-boot/ae_KfGqNrsWZ1rfQ@daedalus/
>

Regards,
Simon
