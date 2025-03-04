Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D113DC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 18:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B71180FB9;
	Tue,  4 Mar 2025 19:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bens.haus header.i=@bens.haus header.b="BvJMv14X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63459805C3; Tue,  4 Mar 2025 18:47:15 +0100 (CET)
Received: from mail-4018.protonmail.ch (mail-4018.protonmail.ch [185.70.40.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F5278006D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 18:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ben@bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
 s=protonmail; t=1741110432; x=1741369632;
 bh=Q5iFaJbvpFRzz6i/THvhJaz69avAFbrlOnU5P0tYDfU=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=BvJMv14XkdYvbwImuj2KGSJNbUMqyR8FnRKEIUuucu7sw1LqXj58m9SkkaOlP4zxz
 WNvFrCIrqYN9EUMBmSAkJxF3JG2dkSqkJXGBm2bgpjURzrGmyfSGWP3bwhBwrafFWm
 tJZNw+WTZsvj3jq1T8PSj+AKbf/gSnRAONUd3uIRi7ZUvyYBMfuEPO3FqLx0JYqOih
 IuLDZlOwUC0rvkWR7aSiMHRX/vn1LABQZGMe83XFkNzOQ3d7JLKzJEMQjU7X7HHiv6
 sHEh0l67iqC4ZVvWcyoX56+Yo6e60AFmAvYRNK9VvI21rICJ4FE7hC/Isqy64EUV4q
 V0+DUk9bNsQVg==
Date: Tue, 04 Mar 2025 17:47:07 +0000
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Ben Schneider <ben@bens.haus>
Subject: boottime->efi_allocate_pages() returning EFI_NOT_FOUND
Message-ID: <CdUirikQxEto6yzkO-G-y6mmWa-ek5NZPN9K7EYvyeUAmnxuge6UmHxfp0tb580qFmfHacX5aWFLqrXjXAFs87nP14AZ72vkClzp3U3WBw4=@bens.haus>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: 5c23c2a34c71fc43ec006b3fba3eb7b0d18b1d42
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Mar 2025 19:04:43 +0100
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

Hi, I'm trying to boot a compressed (via zboot)=C2=A0Linux kernel image
for aarch64 and running into an error I didn't expect.

To decompress itself, the kernel will run=C2=A0efi_zboot_entry() (found
in=C2=A0drivers/firmware/efi/libstub/zboot.c) which wants additional
memory so it asks for it via a call to the UEFI AllocatePages()
service.

U-Boot receives that request and runs=C2=A0efi_allocate_pages() (found
in=C2=A0lib/efi_loader/efi_memory.c). In its call, Linux is setting
type =3D=C2=A0EFI_ALLOCATE_ADDRESS, and memory_type =3D=C2=A0EFI_LOADER_COD=
E.

Based on some testing, it seems that the call to lmb_alloc_addr()
is not returning an address so efi_allocate_pages() returns
along this path:

addr =3D map_to_sysmem((void *)(uintptr_t)*memory);
addr =3D (u64)lmb_alloc_addr(addr, len, flags);
if (!addr)
        return EFI_NOT_FOUND;

It's not clear to me why I'm getting this error. I am using U-Boot
2025.04-rc3 configured with mvebu_espressobin_ultra-
8f3720_defconfig. I use Standard Boot (bootflow scan -b) to find
and load a systemd-boot EFI application which then tries to boot
the compressed Linux kernel. I am encountering this issue on a
real device with 1GB of memory. I would appreciate any guidance.

Thank you!

Ben
