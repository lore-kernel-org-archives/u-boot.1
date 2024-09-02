Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7BACA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 11:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ABDD887B9;
	Mon,  2 Sep 2024 13:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="sC09PpJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 969208880F; Mon,  2 Sep 2024 13:42:09 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97BCA88785
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 13:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1725277325; x=1725882125; i=xypron.glpk@gmx.de;
 bh=kYtkuvoqpZvKMIfn8WwGXsw5Hea5KhHA+YN3JzJv2zY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sC09PpJrwy1MlV3pko4UrbrvjoMWxwXJczhGjNYvp07DXrM1p8qS4WtC2knprrOp
 2+x/wNk0wFdV6Cd3Z5t73BRbjkiUklfmpYrua0ti0d2NKxU42pVNNtizKRJvqWYJ1
 9ynp7YMI5rB64GthsPmYStAHJUQZD/Xn9dtY7iFeRwtUYJlIibzcj9vGwcmOF4tp2
 BUfpMO+ummQAaM8e+VG6v97sKoT7BugsRMjyxPw4e3aZ/bYKQ7GNXH/WxZWfch34C
 MTxldDpmAS/ufB1NG1RtZ1FXaCxmyLs9RSqQE1TWD0ji9ciajyT3snFY6eREuST8C
 blZTWVLNtVXay7It/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([176.1.2.125]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1sRw2A3Zes-00PKCZ; Mon, 02
 Sep 2024 13:42:05 +0200
Date: Mon, 02 Sep 2024 13:42:03 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: Re: [PATCH v3 3/3] efi: Show the location of the bounce buffer
User-Agent: K-9 Mail for Android
In-Reply-To: <20240901222259.456932-4-sjg@chromium.org>
References: <20240901222259.456932-1-sjg@chromium.org>
 <20240901222259.456932-4-sjg@chromium.org>
Message-ID: <B266038B-370F-491F-A047-52F6A0B2882F@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zRBY8EsvYA8e4aSIV3s5iCi+zkIee0X3Ins79VtfV6TfjdemRBG
 kG1mMP6INFsM+VAvnqDJOhON/CODKC1tblhiUq82s1fz6OHu9WQLQKv8xIeXWhenvQeDxdj
 O0N/ZRIFNNf2ooBOS0v0Nf5Xioz30BWShnklV3AL3gkFm4KhfUYfzbBK/PEZ50/HpzA+RDB
 UlAi0d+IzB37GYPiZo8ug==
UI-OutboundReport: notjunk:1;M01:P0:QcuInkxfI00=;5s8CG6Yu+DIRo4YgQWSCqjSSZUC
 aoCNI72fN1nu/eC+Zc/QCmzNCvFHLPS0ipKNEMB65Gvb7KJtMmZW3S/wdTu8iBftqQv+kGsQJ
 NmEgIggj0nS5m2APKjHy+0M9Ls6n9ASC9lh+y97vGYt7GJiHDOffFUOY/HSmIBVJKPUDw6Fd5
 6gjw4LgVrzlvcDzUU3e/041AIsNoNZpEHZdF7U5X+NQAPjdZxL73PBmktTDgPRDwJKnNqh7th
 Ih8NuAQEfiOYQpXHIxYKjPqQUEYi2QkpSHdVHhjt64aFJf6htpt3T5dq61eLQT38JE06i83De
 AAF6ldY/e7JV+gBTrR9LFrCz1PWiDHIZJYn5x+uXDpp5nJ1XJ/IUApEtRoS6lxNVirBNt0hw0
 rSXuSIEZaBqJv8XxJ0VS6qT3DxuXW67mjS+S5X3HV2No20KeZB4GbfeEBR+Xjj3URJa8GuKp9
 5sgUSxosVnYik7/horVR1K2YT/Ifrq98SDbxeXkydfmzwP5rTiEfbuRbzVXI3QdbhYijSVVd6
 F3RVnEFVl0Ibwxq8eIa4WChPCTVhpfo9UNiYa5MvgD+HOAlyG4ShN52RmJDBoJOhS5omHKTSU
 D8F4zL9YyeQW70vJGiREM7A7kbQu+Nph5rfo4u/heYzHmIrh7SabqqCpAjuJCDwJt8hpDS7zd
 1oMv98RukHHQpZmy2C+N9zG9HPOmlqLCw2Q3AMI9f44+0YeaLE+PObmq17DUj0F+QL1gKjEyw
 ikyiGB/5RhQjNDPnlzzyYHigK3H+aOwFR82JIy9tIQK29wTZLik3Xq+hMCsd8A0HdLKNYxn9b
 Dz8M1IBIBkdyP6aEJxI+t0uw==
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



Am 2=2E September 2024 00:22:59 MESZ schrieb Simon Glass <sjg@chromium=2Eo=
rg>:
>The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago=2E It is no=
t
>clear whether it is still needed, but 24 boards (lx2160ardb_tfa_stmm,
>lx2162aqds_tfa_SECURE_BOOT and the like) use it=2E
>
>This feature uses EFI page allocation to create a 64MB buffer 'in space'
>without any knowledge of where boards intend to load their images=2E This
>may result in image corruption or other problems=2E
>
>For example, if the feature is enabled on qemu_arm64 it puts the EFI
>bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
>1088MB=2E The kernel is probably smaller than 27MB but the buffer does
>overlap the ramdisk=2E
>
>The solution is probably to use BOUNCE_BUFFER instead, with the EFI
>version being dropped=2E For now, show the address of the EFI bounce
>buffer so people have a better chance to detect the problem=2E
>
>Note: I avoided converting this #ifdef to use IS_ENABLED() since I hope
>that the feature may be removed=2E

The functionality is still needed=2E A warning is of little use: what shou=
ld the user do about it? The region should be reserved in LMB=2E

Best regards

Heinrich


>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>(no changes since v2)
>
>Changes in v2:
>- Drop patch 'Show more information in efi index'
>- Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
>- Add the word 'warning', use log_warning() and show the end address
>
> lib/efi_loader/efi_bootbin=2Ec | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/lib/efi_loader/efi_bootbin=2Ec b/lib/efi_loader/efi_bootbin=
=2Ec
>index 5bb0fdcf75d=2E=2E9779dc09b5e 100644
>--- a/lib/efi_loader/efi_bootbin=2Ec
>+++ b/lib/efi_loader/efi_bootbin=2Ec
>@@ -211,6 +211,15 @@ efi_status_t efi_binary_run(void *image, size_t size=
, void *fdt)
> 		return -1;
> 	}
>=20
>+#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
>+	/*
>+	 * Add a warning about this buffer, since it may conflict with other
>+	 * things
>+	 */
>+	log_warning("Warning: EFI bounce buffer %p-%p\n", efi_bounce_buffer,
>+		    efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
>+#endif
>+
> 	ret =3D efi_install_fdt(fdt);
> 	if (ret !=3D EFI_SUCCESS)
> 		return ret;
