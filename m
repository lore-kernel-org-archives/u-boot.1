Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6568CFA466
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 02:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 036C6802C1;
	Fri, 21 Nov 2025 03:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="HMV3STQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CC5D801CF; Fri, 21 Nov 2025 03:58:55 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C61AB802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 03:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7E45825FFD;
 Fri, 21 Nov 2025 03:58:52 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ix_4leUIVrat; Fri, 21 Nov 2025 03:58:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1763693931; bh=D38e4U99YsBwjIV+iN8x47tDdFq8hf7d74KWJvqGvGg=;
 h=Date:From:To:Subject:References:In-Reply-To;
 b=HMV3STQtaC4MMs4Yz72S/gPVrehtLPSsIOwbn82wvohfi2CBdPIW8jjywNCphkDr1
 6gtoYYj3UDLWzziEtQdu4g1YCy6Y6IGOzMFT8/XnsM9Xf23fPZuknJ6xhuDo6CWvMn
 kTWHg80gETLkFiSXe8i4xhW8AQ0xiaMmvQrp4xM169d7xvwlZebriamHunEFH21xuH
 64i7hZOimoaAvkz1iZVu/MMJVFnnaBTJv8nQ9ldbnXxMvpBwArKjckfScDz7Mou7kM
 B3win9pn2T1LSEqUfW21qBz5jLlFmiler+nUxTqNU5tiWAfbcohG3WEasPS6cY5pWq
 CdSWcBhjeR5vQ==
Date: Fri, 21 Nov 2025 02:58:40 +0000
From: Yao Zi <ziyao@disroot.org>
To: Ivan Velickovic <i.velickovic@unsw.edu.au>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Query on RISC-V booting ABI
Message-ID: <aR_VYKIhx-ZWYfGT@pie>
References: <000D2537-636F-493E-8E6E-2BC18916A6BD@ad.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000D2537-636F-493E-8E6E-2BC18916A6BD@ad.unsw.edu.au>
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

On Fri, Nov 21, 2025 at 02:00:46AM +0000, Ivan Velickovic wrote:
> Hello everyone,
> 
> My understanding of the general RISC-V bootflow ABI is that each boot stage provides the hart ID and DTB
> in a0 and a1 respectively. From [1] I can see that U-Boot also adheres to that.

I think the ABI is only defined for Linux. OpenSBI follows a similar
convention, but provides a raw binary with no image header, and requires
an extra fw_dynamic_info parameter if dynamic image is used.

> For my use-case, I am typically booting my OS/application with U-Boot via the `go` or `bootelf` commands.
> I believe that currently these methods do not adhere to this ABI, and I’m wondering if someone could clarify
> whether that is a mistake or intentional?

There's some previous discussion about passing hart ID/DTB, too with
bootelf[3], but I think the patch is stalled. Here's the v2[4] but I've
never seen v3.

Personally speaking, I think it's a better idea to pack your customized
kernel into a Linux-style image, in which way existing facilities could
be re-used, and ABI stability is guaranteed, too.

> I can see that for `bootm` for Linux images for example, the ABI is preserved [2].

Yes, and similar convention also preserved in common/spl/spl_opensbi.c
which loads OpenSBI. But for "go" and "bootelf", you couldn't tell what
ABI the image really follows, so preserving the de-facto ABI may benefit
in some situation, but I personally won't consider the current
implementation buggy.

> Thank you,
> Ivan
> 
> [1]: https://docs.u-boot.org/en/latest/arch/riscv.html
> [2]: https://github.com/u-boot/u-boot/blob/2bc0715b558fa1ac5c88b11e250740b16a905837/arch/riscv/lib/bootm.c#L100.

Regards,
Yao Zi

> This email and any files transmitted with it may contain confidential information. If you believe you have received this email or any of its contents in error, please notify me immediately by return email and destroy this email. Do not use, disseminate, forward, print or copy any contents of an email received in error.
> 

[3]: https://lore.kernel.org/u-boot/ME0P300MB13096732AF44AC5409B9D0D49F96A@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM/
[4]: https://lore.kernel.org/u-boot/SY7P282MB5675687EA430C83D458678F89F77A@SY7P282MB5675.AUSP282.PROD.OUTLOOK.COM/
