Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CA9C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 09:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0496482B0E;
	Sun, 25 May 2025 11:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bCplnlLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94FFF82BAF; Sun, 25 May 2025 11:08:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C291981D6A
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 11:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748164116; x=1748768916; i=xypron.glpk@gmx.de;
 bh=dcZ7apKaN1NGBC6tMI1tGgpBb69USh8BBUF+Lu6ip2Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bCplnlLgI4O1kJats6z1MRswYbTMEjvG0vDlls0Mc68OGTIEJHhQhKeRI4VhZ4Sc
 r8Eb07kjkS9faPiP9UxFJ8tz9sijpgsjbeFXJMvmalgWz3QX7f4+Od6OhAqnDV5VZ
 s1pvcU6wTv8TCCJ6KUitzWOhAjxery+kb5SVt84LoKQ21EN6J6COaIAdQKYajuqy3
 KF1vFrBGQtBEk50Ebe5I99TTOaSCjeFWtJiQPwVzcdxHJobu4HQvdQpoc6r1JcjbY
 ygAOSjR0lZtcEg3/cjZn0W7C/wErgpyrV0mPsx2tWywZx6C834FpfCSSq1gLtfiBV
 awPuNMHaQ8+etZBMbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.142]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9g4-1u9Dr60Dvw-00ACOV; Sun, 25
 May 2025 11:08:36 +0200
Message-ID: <16877848-0f1c-4f0e-8b2e-7004cb0d6ba3@gmx.de>
Date: Sun, 25 May 2025 11:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] efi_loader: Separate device path into its own header
To: Simon Glass <sjg@chromium.org>
Cc: Adriano Cordova <adrianox@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?Q?Christian_Kohlschu=CC=88tter?= <christian@kohlschutter.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Moritz Fischer <moritzf@google.com>, Pawel Kochanowski
 <pkochanowski@sii.pl>, Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Yao Zi <ziyao@disroot.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250524172827.1243975-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250524172827.1243975-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qDizSkrAkYDUnpFkyiySZ8LwDOW86ZVUUkI4adlSPSKPEIaJ/xw
 WdfYo497+xXudSaG/htpId+uhiJmP56dR6dbZFP9LpNjdMFovM93Y56TvvdbFRSMz7c+tdq
 Cl2Ba9N6hPYqGtAa5DvXG96t2BhNz7v9V2Tac2jB9Sc5SasPnPCnP42Dqz1ordp7115PyMo
 nAEAVzB7Dc97wrIBtH1SQ==
UI-OutboundReport: notjunk:1;M01:P0:OM90Akcw97o=;jRTE5jJNVN2f88MDxy2TZq/X3EA
 Mc29Zp6dgtxOo7P4RWE+BmpSl+oZ12lgekgKwiFdESiILYL3b+GNrlczu9mO03sfexPy1wVUV
 W1XW3PQnNVHhOEwJUkiYjHZtfApjA3srDik6Abs+SMytlQR6Hkd2KQ9kKBxfXULfsjhgD+UaF
 +o0L0fZC/f21nud0QKyVhbjYtP9QZYdngpiOLaQW4d/Dr5vzZieZ+oz0mgpTo74/U1e9z/uaF
 rAREXM+wyO8O0mzEYX5yf8TFBE8q8HMDfFydNEh8OxDybITi8CPe8A1KW8o6EVTX2V+5x0fiY
 1FZngZQKuEr5bO+vN6Zve6Xw8gXbVfKeFDZWGbZsg4qIObQK5OLzud//bsa1gWwA//kxeZDpa
 msnn6FXVMOs4VB+h1hzkMFGFOP3feGsYDOGbL1Ofajn7b54vs+aTAjWjHK9CM1S9mizjA/wQ+
 WOQGPfnvW6964TNXBgYpeIjHmmfy6xF8FR/0M8sT5hdoopb9g71xNoo3K42sXPBGrqVX9TWDM
 GsciuOcin3nGb/0D13KfvSb/3zR4aGOocE8T7kayIMPA40JTL6va1qSpU9sBNe7H7rACSnXJa
 0B7v7Q1GBbYJiT6JF6UsPYwgoudXWgvUyO1pak5SC1kf2YXjQHBnvyUhHjeSFM8TzX0WWIpV2
 99pD9eU1Ac985coipSsrJGgPJOEMYZ2iEN08ISg83RkCrBUcT+kJg/vbQaUT6ZjJNnKKU+gNJ
 jhnJPJu5w6L2wokY443OoisWz2sscXoDK8twzT85AaUKp1mZl4+ZGilPMlO+BhiipXGHADuRK
 3L3eNr5JUgEBcyytKpNNVs7mjylN5bdfICYqAXUufvFGxGeDKwDLxIpKMD6rPFvGttJlM+6LP
 RtfLOSXbNqcj1LYxgc27AM4x8XNGod03t5gBSAfmq0sWySMkxiE7rg7hg0vRyK30q/cK/DW4+
 D8FYCmH6W3A86ziwKuHaR5r9oKPscaGdnXxtDdQ9wjqTU5jhABjxyhxJeVxxjvLbeNamK+qY7
 c7dBycQKwG99yLVg/R8iQewseL7YqhNbf+NLVhz5QLZH4Mu57HFwMBTvyXS0FBQoxUYyzGhkS
 FpEAS0mGtu1wT/OqyHXGquOc+wVkS2gWND85I3BnvJSJ6MO5Hppg6aaV0998YZ5PUK6kM1fz3
 eS3OuaObfzGEVFbzIO5HmE1Qbz+0GX9zN/IzTaThy3KCsUxfOLT2UZJRNoZwNKWuRolgZGfeD
 rXchLw+cL/vuWHIbYqXklfBeDDJ8vceA8nMIvRMhu/ej09X4DfDTyoZWRgnvccx1ANO1Vj3sx
 43Zu/UKzhYP0b25G1BO8kabk3NATlWwaWwOVxXoX9U2W9uLeipkop8UITc6RQyMt3MiLgQo03
 6mIPiJqd99YNXXzhKZe13kFLdaYd5tPllvECT87UKr1G4uFABw1rsrDeEqQJ2z86gqUubIsLF
 36Xb7UB09hV+9T0R0YlGk+NTSzJcWL977t6EH/sMvzUFqEKOsmL8HcMRwNMeJJLq8J51dK/UN
 +2Wv8C9Pgsx+Xh27VJt7ecHfxbl/uiM5NsMT29Bbd6ML+VyLA4Cvr2k2vibmV/ZYi/KLgq++J
 EfFSC7UVtuqYTJg5GVucfzorvquf8tTkbZCgpFqLQHlxbV44lvA9hu8fJ+JTN0sJMqbAtB5zo
 v792eaQKTE8Yqqvi+e4/3JlIPnKfe6ZnnKm46JAbF9OKgr0ZULSZdmjJVQfaHYjvpQqeiD8Bu
 ygPGo7Z23BghrpNN0yMwG63CbDhNsYGdPAKxos/LC5U0lSZ4wT6qlnjAVm5n75PxS/HaSMuCm
 WK/fUZh6kw/LKFSjkfinBpCO/dtsIKi2+ETK0Y9xhcEgsfsObLio4gWNwaidetTevnqxOMwsx
 iVgKlLtD8h0v/TSuUAQJCcUPKqBwchXhx+By0wozgZyVMAoSv9vHndPcHNZJoDi6V+018/0Ru
 dWzizM7d1dmlai7Y9anVpEH/9c2Tnv0L6zUDCSNr0s8zpmeAbifJXLH2EKH4GnkgSUQ2KE7tD
 6nf6wVEVFLjf+MGKoxf3EOF1leTiC4bJNKhA5ob5vB4PzE1LLmUbdxRLckVQDh5kz+bZ92ZI2
 2h7hkBmxIRzt+P5JXgTzxVcFsvMzjKcTiJhLvBa0HXPDPWPr0S7mBsGrCKeV+q7kBExYgX8CP
 8W+QvkLVu4NNZE/kL8E/SRGNdfgbwQew2vplzQ71nobpKoo9CUJHhRLzD+lrhbo61Kd7uBqsK
 cDYX3OKgLA9kiI4j+ODezW/bp6oN2G5EZcOBxMJpY8fz+DlUmg2LwIoTj8Uhlm7aAwFuhYZxa
 ifCL2JiT//eiOaBHp1cvrKh/dtuOFJhsUI1F90AmifMalVdlZahp+959iiTBsjElw87bDf7QB
 3wQYH0QSJQb/Pj7sn9VuU6kbnt06OYvb/4zNbPKTXt3gJfI/qTWEqO4dHKWvgDQIWX7d1X5Gs
 UxoSvwarmFCxGoTwFt9t5o4xmiBLJNJa3wirswDVUWXZlNTy4VmtFYZszbw4QJvi2wFYTE+1y
 y8WBvOq0KESlP8t5oLzI6RKG/gMp20YcFP25XucGyQOcmlgfPh2DlQveTp+KTI0Ayglnn0fex
 ApVctt0NJRMObHOYBoT060Gj87J1mvfjPBwIirJ5Tk3ID5GvsJEvMhW/lHO9zfV1PNCK3UC4i
 NATU50RiAaY3YMMQAzr9FAB4/08QRoi+o/ZNj7ktdeQrY/cDKaYfq9/dvHucr+Rpv6TBOXI4u
 DR0w4oUXNzzNr5I3WeyQUUHcsnhg8Pr3oDEc4178zT5yctozZGZ0V0Qo98KBWs+i16G3H33/U
 4EbcptNT8TrPH+G5TKGQOPyea1CFv6q+qh/umDQgi1s48Gdl7g89VKf2Jkn9q9fixSh6wRXkM
 sYeBWEa2dqVkrpEblRVJOjcfy40XKxXP0InlqtVQJcsoZQVi60HCCdNNfwogbeed7Wi+kfjvz
 P5t2GNKKzXvuf4BLBsIYj6Or2PFFDaoskURt2IJewOQDsZ25XPsGunsgWr/uvPIXp2StPhlgY
 nUu0sYU1ER+c3ls1ZJ7VCnCvzdoh0CiLuUgJ4BLGbq1coqxRiSpLI5m7O8fs2D5fJ4v0XKbdb
 ePIkzl0ReRzvQz8VESfbJS5PiYFsNYvwaJT/+FMVTB3JKdV7gLJKsdkd8O++9JcLCTF/rkRfj
 P2+I=
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

On 5/24/25 19:28, Simon Glass wrote:
> These functions are useful for the EFI app. As a first step towards
> making these available outside lib/efi_loader, create a separate header
> file and include it where needed. Add proper comments to the functions,
> since many are missing at present.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Add a forward declaration for struct udevice
>=20
>   cmd/bootefi.c                              |   1 +
>   cmd/eficonfig.c                            |   1 +
>   cmd/efidebug.c                             |   1 +
>   include/efi_device_path.h                  | 420 +++++++++++++++++++++
>   include/efi_loader.h                       |  57 +--
>   lib/efi_driver/efi_uclass.c                |   1 +
>   lib/efi_loader/efi_bootbin.c               |   1 +
>   lib/efi_loader/efi_bootmgr.c               |   3 +-
>   lib/efi_loader/efi_boottime.c              |   1 +
>   lib/efi_loader/efi_capsule.c               |   1 +
>   lib/efi_loader/efi_console.c               |   1 +
>   lib/efi_loader/efi_device_path.c           |  89 +----
>   lib/efi_loader/efi_device_path_utilities.c |   1 +
>   lib/efi_loader/efi_disk.c                  |   1 +
>   lib/efi_loader/efi_fdt.c                   |   1 +
>   lib/efi_loader/efi_helper.c                |   1 +
>   lib/efi_loader/efi_net.c                   |   1 +
>   lib/efi_loader/efi_tcg2.c                  |   1 +
>   test/lib/efi_device_path.c                 |   1 +
>   19 files changed, 439 insertions(+), 145 deletions(-)
>   create mode 100644 include/efi_device_path.h
>=20
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index cea6d356ee6..8e8752127ed 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -9,6 +9,7 @@
>  =20
>   #include <command.h>
>   #include <efi.h>
> +#include <efi_device_path.h>
>   #include <efi_loader.h>
>   #include <exports.h>
>   #include <log.h>
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index 629bf1b82c7..de1647b943c 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -8,6 +8,7 @@
>   #include <ansi.h>
>   #include <cli.h>
>   #include <charset.h>
> +#include <efi_device_path.h>
>   #include <efi_loader.h>
>   #include <efi_load_initrd.h>
>   #include <efi_config.h>
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 2461425e291..01e58031573 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -8,6 +8,7 @@
>   #include <charset.h>
>   #include <command.h>
>   #include <dm/device.h>
> +#include <efi_device_path.h>
>   #include <efi_dt_fixup.h>
>   #include <efi_load_initrd.h>
>   #include <efi_loader.h>
> diff --git a/include/efi_device_path.h b/include/efi_device_path.h
> new file mode 100644
> index 00000000000..67474d6d0c1
> --- /dev/null
> +++ b/include/efi_device_path.h
> @@ -0,0 +1,420 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */


Thank you for the patch. Just a few nits:

GPL-2.0-or-later
see https://spdx.org/licenses/GPL-2.0-or-later.html

> +/*
> + * EFI device path from U-Boot device-model mapping

This text does not match the content.

How about

"EFI device path related functions" ?

> + *
> + * (C) Copyright 2017 Rob Clark
> + */
> +
> +#ifndef EFI_DP_UTILS_H
> +#define EFI_DP_UTILS_H

The name of the macro should match the file name to avoid future collision=
s:

EFI_DEVICE_PATH_H

> +
> +#include <efi.h>
> +
> +struct blk_desc;
> +struct efi_load_option;
> +struct udevice;
> +
> +/**

Better already use '/*' here so you don't have to change it in patch 3/3=
=20
to avoid a warning
./include/efi_device_path.h:23: warning: cannot understand function=20
prototype: 'const struct efi_device_path EFI_DP_END; '

Otherwise looks good to me.

Best regards

Heinrich

> + * END - Template end node for EFI device paths.
> + *
> + * Represents the terminating node of an EFI device path.
> + * It has a type of DEVICE_PATH_TYPE_END and sub_type DEVICE_PATH_SUB_T=
YPE_END
> + */
> +extern const struct efi_device_path END;
> +
> +/**
> + * efi_dp_next() - Iterate to next block in device-path
> + *
> + * Advance to the next node in an EFI device path.
> + *
> + * @dp: Pointer to the current device path node.
> + * Return: Pointer to the next device path node, or NULL if at the end
> + * or if input is NULL.
> + */
> +struct efi_device_path *efi_dp_next(const struct efi_device_path *dp);
> +
> +/**
> + * efi_dp_match() - Compare two device-paths
> + *
> + * Compare two device paths node by node. The comparison stops when an =
End
> + * node is reached in the shorter of the two paths. This is useful, for=
 example,
> + * to compare a device-path representing a device with one representing=
 a file
> + * on that device, or a device with a parent device.
> + *
> + * @a: Pointer to the first device path.
> + * @b: Pointer to the second device path.
> + * Return: An integer less than, equal to, or greater than zero if the =
first
> + * differing node in 'a' is found, respectively, to be less than,
> + * to match, or be greater than the corresponding node in 'b'. Returns =
0
> + * if they match up to the end of the shorter path. Compares length fir=
st,
> + * then content.
> + */
> +int efi_dp_match(const struct efi_device_path *a,
> +		 const struct efi_device_path *b);
> +
> +/**
> + * efi_dp_shorten() - shorten device-path
> + *
> + * When creating a short-boot option we want to use a device-path that =
is
> + * independent of the location where the block device is plugged in.
> + *
> + * UsbWwi() nodes contain a serial number, hard drive paths a partition
> + * UUID. Both should be unique.
> + *
> + * See UEFI spec, section 3.1.2 for "short-form device path".
> + *
> + * @dp:     original device-path
> + * Return:  shortened device-path or NULL
> + */
> +struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp);
> +
> +/**
> + * efi_dp_find_obj() - find handle by device path
> + *
> + * If @rem is provided, the handle with the longest partial match is re=
turned.
> + *
> + * @dp:     device path to search
> + * @guid:   GUID of protocol that must be installed on path or NULL
> + * @rem:    pointer to receive remaining device path
> + * Return:  matching handle
> + */
> +efi_handle_t efi_dp_find_obj(struct efi_device_path *dp, const efi_guid=
_t *guid,
> +			     struct efi_device_path **rem);
> +
> +/**
> + * efi_dp_last_node() - Determine the last device path node before the =
end node
> + *
> + * Iterate through the device path to find the very last node before
> + * the terminating END node.
> + *
> + * @dp: Pointer to the device path.
> + * Return: Pointer to the last actual data node before the end node if =
it exists
> + * otherwise NULL (e.g., if dp is NULL or only an END node).
> + */
> +const struct efi_device_path *efi_dp_last_node(const struct efi_device_=
path *dp);
> +
> +/**
> + * efi_dp_instance_size() - Get size of the first device path instance
> + *
> + * Calculate the total length of all nodes in the first instance of a
> + * (potentially multi-instance) device path. The size of the instance-s=
pecific
> + * end node (if any) or the final device path. The end node is not incl=
uded.
> + *
> + * @dp: Pointer to the device path.
> + * Return: Size in bytes of the first instance, or 0 if dp is NULL or a=
n END
> + * node
> + */
> +efi_uintn_t efi_dp_instance_size(const struct efi_device_path *dp);
> +
> +/**
> + * efi_dp_size() - Get size of multi-instance device path excluding end=
 node
> + *
> + * Calculate the total size of the entire device path structure, traver=
sing
> + * through all instances, up to but not including the final
> + * END_ENTIRE_DEVICE_PATH node.
> + *
> + * @dp: Pointer to the device path.
> + * Return: Total size in bytes of all nodes in the device path (excludi=
ng the
> + * final END node), or 0 if dp is NULL.
> + */
> +efi_uintn_t efi_dp_size(const struct efi_device_path *dp);
> +
> +/**
> + * efi_dp_dup() - Copy multi-instance device path
> + *
> + * Duplicate the given device path, including its end node(s).
> + * The caller is responsible for freeing the allocated memory (e.g.,
> + * using efi_free()).
> + *
> + * @dp: Pointer to the device path to duplicate.
> + * Return: Pointer to the newly allocated and copied device path, or NU=
LL on
> + * allocation failure or if dp is NULL.
> + */
> +struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp);
> +
> +/**
> + * efi_dp_concat() - Concatenate two device paths and terminate the res=
ult
> + *
> + * @dp1:        First device path
> + * @dp2:        Second device path
> + * @split_end_node:
> + * - 0 to concatenate (dp1 is assumed not to have an end node or it's i=
gnored,
> + *   dp2 is appended, then one END node)
> + * - 1 to concatenate with end node added as separator (dp1, END_THIS_I=
NSTANCE,
> + *   dp2, END_ENTIRE)
> + *
> + * Size of dp1 excluding last end node to concatenate with end node as
> + * separator in case dp1 contains an end node (dp1 (partial), END_THIS_=
INSTANCE,
> + * dp2, END_ENTIRE)
> + *
> + * Return:
> + * concatenated device path or NULL. Caller must free the returned valu=
e.
> + */
> +struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1=
,
> +				      const struct efi_device_path *dp2,
> +				      size_t split_end_node);
> +
> +/**
> + * efi_dp_append_node() - Append a single node to a device path
> + *
> + * Create a new device path by appending a given node to an existing
> + * device path.
> + * If the original device path @dp is NULL, a new path is created
> + * with the given @node followed by an END node.
> + * If the @node is NULL and @dp is not NULL, the original path @dp is
> + * duplicated.
> + * If both @dp and @node are NULL, a path with only an END node is retu=
rned.
> + * The caller must free the returned path (e.g., using efi_free()).
> + *
> + * @dp:   Original device path (can be NULL).
> + * @node: Node to append (can be NULL).
> + * Return: New device path with the node appended, or NULL on allocatio=
n
> + * failure.
> + */
> +struct efi_device_path *efi_dp_append_node(const struct efi_device_path=
 *dp,
> +					   const struct efi_device_path *node);
> +
> +/**
> + * efi_dp_create_device_node() - Create a new device path node
> + *
> + * Allocate and initialise the header of a new EFI device path node wit=
h the
> + * given type, sub-type, and length. The content of the node beyond the=
 basic
> + * efi_device_path header is zeroed by efi_alloc.
> + *
> + * @type:     Device path type.
> + * @sub_type: Device path sub-type.
> + * @length:   Length of the node (must be >=3D sizeof(struct efi_device=
_path)).
> + * Return: Pointer to the new device path node, or NULL on allocation f=
ailure
> + * or if length is invalid.
> + */
> +struct efi_device_path *efi_dp_create_device_node(const u8 type,
> +						  const u8 sub_type,
> +						  const u16 length);
> +
> +/**
> + * efi_dp_append_instance() - Append a device path instance to another
> + *
> + * Concatenate two device paths, treating the second path (@dpi) as a n=
ew
> + * instance appended to the first path (@dp). An END_THIS_INSTANCE node=
 is
> + * inserted between @dp and @dpi if @dp is not NULL.
> + * If @dp is NULL, @dpi is duplicated (and terminated appropriately).
> + * @dpi must not be NULL.
> + * The caller is responsible for freeing the returned path (e.g., using
> + * efi_free()).
> + *
> + * @dp:  The base device path. If NULL, @dpi is duplicated.
> + * @dpi: The device path instance to append. Must not be NULL.
> + * Return: A new device path with @dpi appended as a new instance, or N=
ULL on
> + * error  (e.g. allocation failure, @dpi is NULL).
> + */
> +struct efi_device_path *
> +efi_dp_append_instance(const struct efi_device_path *dp,
> +		       const struct efi_device_path *dpi);
> +
> +/**
> + * efi_dp_get_next_instance() - Extract the next dp instance
> + *
> + * Given a pointer to a pointer to a device path (@dp), this function e=
xtracts
> + * the first instance from the path. It allocates a new path for this e=
xtracted
> + * instance (including its instance-specific END node). The input point=
er
> + * (*@dp) is then updated to point to the start of the next instance in=
 the
> + * original path, or set to NULL if no more instances remain.
> + * The caller is responsible for freeing the returned instance path (e.=
g.,
> + * using efi_free()).
> + *
> + * @dp:  On input, a pointer to a pointer to the multi-instance device =
path.
> + * On output, *@dp is updated to point to the start of the next instanc=
e,
> + * or NULL if no more instances.
> + * @size: Optional pointer to an efi_uintn_t variable that will receive=
 the size
> + * of the extracted instance path (including its END node).
> + * Return: Pointer to a newly allocated device path for the extracted i=
nstance,
> + * or NULL if no instance could be extracted or an error occurred (e.g.=
,
> + * allocation failure).
> + */
> +struct efi_device_path *efi_dp_get_next_instance(struct efi_device_path=
 **dp,
> +						 efi_uintn_t *size);
> +
> +/**
> + * efi_dp_is_multi_instance() - Check if a device path is multi-instanc=
e
> + *
> + * Traverse the device path to its end. It is considered multi-instance=
 if an
> + * END_THIS_INSTANCE_DEVICE_PATH node (type DEVICE_PATH_TYPE_END, sub-t=
ype
> + * DEVICE_PATH_SUB_TYPE_INSTANCE_END) is encountered before the final
> + * END_ENTIRE_DEVICE_PATH node.
> + *
> + * @dp: The device path to check.
> + * Return: True if the device path contains multiple instances, false o=
therwise
> + * (including if @dp is NULL).
> + */
> +bool efi_dp_is_multi_instance(const struct efi_device_path *dp);
> +
> +/**
> + * efi_dp_from_part() - Construct a dp from a partition on a block devi=
ce
> + *
> + * Create a full device path for a specified partition on a given block=
 device.
> + * If the partition number @part is 0, the path is for the block device=
 itself.
> + * The caller is responsible for freeing the allocated memory (e.g., us=
ing
> + * efi_free()).
> + *
> + * @desc: Pointer to the block device descriptor.
> + * @part: Partition number (0 for the whole device, >0 for a specific
> + * partition).
> + * Return: Pointer to the newly created device path, or NULL on allocat=
ion
> + * failure or if the device/partition is not found or invalid.
> + */
> +struct efi_device_path *efi_dp_from_part(struct blk_desc *desc, int par=
t);
> +
> +/**
> + * efi_dp_part_node() - Create a device node for a block device partiti=
on
> + *
> + * Creates a single device path node representing a specific partition
> + * (e.g., HardDrivePath or CDROMPath, depending on desc->part_type).
> + * It does not create the full path from the root, only the partition-s=
pecific
> + * node. The caller is responsible for freeing the allocated memory (e.=
g.,
> + * using efi_free()).
> + *
> + * @desc: Pointer to the block device descriptor.
> + * @part: Partition number (must be > 0 and correspond to a valid parti=
tion on
> + * the device).
> + * Return: Pointer to the new device path node for the partition, or NU=
LL on
> + * allocation * failure or error in getting partition information.
> + */
> +struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int par=
t);
> +
> +/**
> + * efi_dp_from_file() - append file path node to device path.
> + *
> + * @dp:     device path or NULL
> + * @path:   file path or NULL
> + * Return:  device path or NULL in case of an error
> + */
> +struct efi_device_path *efi_dp_from_file(const struct efi_device_path *=
dp,
> +					 const char *path);
> +
> +/**
> + * efi_dp_from_uart() - Create a device path for a UART device.
> + *
> + * Construct a device path representing the system's default UART,
> + * typically based on the U-Boot device model root and a UART messaging=
 node.
> + * The caller is responsible for freeing the allocated memory (e.g., us=
ing
> + * efi_free()).
> + *
> + * Return: Pointer to the new UART device path, or NULL on allocation f=
ailure.
> + */
> +struct efi_device_path *efi_dp_from_uart(void);
> +
> +/**
> + * efi_dp_from_eth() - Create a device path for an Ethernet device
> + *
> + * Construct a device path representing the given device. The caller is
> + * responsible for freeing the allocated memory (e.g. using efi_free())
> + *
> + * @dev: UCLASS_ETH device to process
> + *
> + * Return: Pointer to the new Ethernet device path, or NULL on allocati=
on
> + * failure
> + */
> +struct efi_device_path *efi_dp_from_eth(struct udevice *dev);
> +
> +/**
> + * efi_dp_from_mem() - Construct a device-path for a memory-mapped regi=
on
> + *
> + * Create an EFI device path representing a specific memory region, def=
ined
> + * by its type, start address, and size.
> + * The caller is responsible for freeing the allocated memory (e.g.,
> + * using efi_free()).
> + *
> + * @memory_type: EFI memory type (e.g., EFI_RESERVED_MEMORY_TYPE).
> + * @start_address: Starting address of the memory region.
> + * @size: Size of the memory region in bytes.
> + * Return: Pointer to the new memory device path, or NULL on allocation=
 failure
> + */
> +struct efi_device_path *efi_dp_from_mem(u32 memory_type, u64 start_addr=
ess,
> +					size_t size);
> +
> +/**
> + * efi_dp_split_file_path() - split of relative file path from device p=
ath
> + *
> + * Given a device path indicating a file on a device, separate the devi=
ce
> + * path in two: the device path of the actual device and the file path
> + * relative to this device.
> + *
> + * @full_path:      device path including device and file path
> + * @device_path:    path of the device
> + * @file_path:      relative path of the file or NULL if there is none
> + * Return:      status code
> + */
> +efi_status_t efi_dp_split_file_path(struct efi_device_path *full_path,
> +				    struct efi_device_path **device_path,
> +				    struct efi_device_path **file_path);
> +
> +/**
> + * efi_dp_from_name() - convert U-Boot device and file path to device p=
ath
> + *
> + * @dev:    U-Boot device, e.g. 'mmc'
> + * @devnr:  U-Boot device number, e.g. 1 for 'mmc:1'
> + * @path:   file path relative to U-Boot device, may be NULL
> + * @device: pointer to receive device path of the device
> + * @file:   pointer to receive device path for the file
> + * Return:  status code
> + */
> +efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
> +			      const char *path, struct efi_device_path **device,
> +			      struct efi_device_path **file);
> +
> +/**
> + * efi_dp_check_length() - check length of a device path
> + *
> + * @dp:     pointer to device path
> + * @maxlen: maximum length of the device path
> + * Return:
> + * * length of the device path if it is less or equal @maxlen
> + * * -1 if the device path is longer then @maxlen
> + * * -1 if a device path node has a length of less than 4
> + * * -EINVAL if maxlen exceeds SSIZE_MAX
> + */
> +ssize_t efi_dp_check_length(const struct efi_device_path *dp,
> +			    const size_t maxlen);
> +
> +/**
> + * efi_dp_from_lo() - get device-path from load option
> + *
> + * The load options in U-Boot may contain multiple concatenated device-=
paths.
> + * The first device-path indicates the EFI binary to execute. Subsequen=
t
> + * device-paths start with a VenMedia node where the GUID identifies th=
e
> + * function (initrd or fdt).
> + *
> + * @lo:     EFI load option containing a valid device path
> + * @guid:   GUID identifying device-path or NULL for the EFI binary
> + *
> + * Return:
> + * device path excluding the matched VenMedia node or NULL.
> + * Caller must free the returned value.
> + */
> +struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
> +				       const efi_guid_t *guid);
> +
> +/**
> + * search_gpt_dp_node() - search gpt device path node
> + *
> + * @device_path:    device path
> + *
> + * Return:  pointer to the gpt device path node
> + */
> +struct efi_device_path *search_gpt_dp_node(struct efi_device_path *devi=
ce_path);
> +
> +/**
> + * efi_dp_from_http() - set device path from http
> + *
> + * Set the device path to an IPv4 path as provided by efi_dp_from_ipv4
> + * concatenated with a device path of subtype DEVICE_PATH_SUB_TYPE_MSG_=
URI,
> + * and an END node.
> + *
> + * @server:	URI of remote server
> + * @dev:	net udevice
> + * Return:	pointer to HTTP device path, NULL on error
> + */
> +struct efi_device_path *efi_dp_from_http(const char *server,
> +					 struct udevice *dev);
> +
> +#endif /* EFI_DP_UTILS_H */
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 84e8cfe320e..57050308a9c 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -9,6 +9,7 @@
>   #define _EFI_LOADER_H 1
>  =20
>   #include <blk.h>
> +#include <efi_device_path.h>
>   #include <event.h>
>   #include <log.h>
>   #include <part_efi.h>
> @@ -916,66 +917,10 @@ extern void *efi_bounce_buffer;
>   #define EFI_LOADER_BOUNCE_BUFFER_SIZE (64 * 1024 * 1024)
>   #endif
>  =20
> -/* shorten device path */
> -struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp);
> -struct efi_device_path *efi_dp_next(const struct efi_device_path *dp);
> -int efi_dp_match(const struct efi_device_path *a,
> -		 const struct efi_device_path *b);
> -efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
> -			     const efi_guid_t *guid,
> -			     struct efi_device_path **rem);
> -/* get size of the first device path instance excluding end node */
> -efi_uintn_t efi_dp_instance_size(const struct efi_device_path *dp);
> -/* size of multi-instance device path excluding end node */
> -efi_uintn_t efi_dp_size(const struct efi_device_path *dp);
> -struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp);
> -struct efi_device_path *efi_dp_append_node(const struct efi_device_path=
 *dp,
> -					   const struct efi_device_path *node);
> -/* Create a device path node of given type, sub-type, length */
> -struct efi_device_path *efi_dp_create_device_node(const u8 type,
> -						  const u8 sub_type,
> -						  const u16 length);
> -/* Append device path instance */
> -struct efi_device_path *efi_dp_append_instance(
> -		const struct efi_device_path *dp,
> -		const struct efi_device_path *dpi);
> -/* Get next device path instance */
> -struct efi_device_path *efi_dp_get_next_instance(struct efi_device_path=
 **dp,
> -						 efi_uintn_t *size);
> -/* Check if a device path contains muliple instances */
> -bool efi_dp_is_multi_instance(const struct efi_device_path *dp);
> -
> -struct efi_device_path *efi_dp_from_part(struct blk_desc *desc, int par=
t);
> -/* Create a device node for a block device partition. */
> -struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int par=
t);
> -struct efi_device_path *efi_dp_from_file(const struct efi_device_path *=
dp,
> -					 const char *path);
> -struct efi_device_path *efi_dp_from_eth(struct udevice *dev);
> -struct efi_device_path *efi_dp_from_http(const char *server, struct ude=
vice *dev);
> -struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
> -					uint64_t start_address,
> -					size_t size);
> -/* Determine the last device path node that is not the end node. */
> -const struct efi_device_path *efi_dp_last_node(
> -			const struct efi_device_path *dp);
> -efi_status_t efi_dp_split_file_path(struct efi_device_path *full_path,
> -				    struct efi_device_path **device_path,
> -				    struct efi_device_path **file_path);
> -struct efi_device_path *efi_dp_from_uart(void);
> -efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
> -			      const char *path,
> -			      struct efi_device_path **device,
> -			      struct efi_device_path **file);
> -ssize_t efi_dp_check_length(const struct efi_device_path *dp,
> -			    const size_t maxlen);
> -
>   #define EFI_DP_TYPE(_dp, _type, _subtype) \
>   	(((_dp)->type =3D=3D DEVICE_PATH_TYPE_##_type) && \
>   	 ((_dp)->sub_type =3D=3D DEVICE_PATH_SUB_TYPE_##_subtype))
>  =20
> -/* template END node: */
> -extern const struct efi_device_path END;
> -
>   /* Indicate supported runtime services */
>   efi_status_t efi_init_runtime_supported(void);
>  =20
> diff --git a/lib/efi_driver/efi_uclass.c b/lib/efi_driver/efi_uclass.c
> index 495be53cb77..7392c60f0f9 100644
> --- a/lib/efi_driver/efi_uclass.c
> +++ b/lib/efi_driver/efi_uclass.c
> @@ -20,6 +20,7 @@
>   #define LOG_CATEGORY LOGC_EFI
>  =20
>   #include <dm.h>
> +#include <efi_device_path.h>
>   #include <efi_driver.h>
>   #include <log.h>
>   #include <malloc.h>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 94ba7c5589b..b394f0d60ce 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -10,6 +10,7 @@
>   #include <charset.h>
>   #include <dm.h>
>   #include <efi.h>
> +#include <efi_device_path.h>
>   #include <efi_loader.h>
>   #include <env.h>
>   #include <image.h>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index c0df5cb9acd..a2ab90030b4 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -12,6 +12,7 @@
>   #include <charset.h>
>   #include <dm.h>
>   #include <efi.h>
> +#include <efi_device_path.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <net.h>
> @@ -527,7 +528,7 @@ static efi_status_t try_load_from_uri_path(struct ef=
i_device_path_uri *uridp,
>   		 * will be freed in return_to_efibootmgr event callback.
>   		 */
>   		loaded_dp =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> -					    (uintptr_t)image_addr, image_size);
> +					    image_addr, image_size);
>   		ret =3D efi_install_multiple_protocol_interfaces(
>   			&mem_handle, &efi_guid_device_path, loaded_dp, NULL);
>   		if (ret !=3D EFI_SUCCESS)
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index dbebb37dc04..24b0e52a2a2 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -11,6 +11,7 @@
>   #include <div64.h>
>   #include <dm/device.h>
>   #include <dm/root.h>
> +#include <efi_device_path.h>
>   #include <efi_loader.h>
>   #include <irq_func.h>
>   #include <log.h>
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index 1aa52ac7bb6..f19e78ae9d1 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -8,6 +8,7 @@
>  =20
>   #define LOG_CATEGORY LOGC_EFI
>  =20
> +#include <efi_device_path.h>
>   #include <efi_loader.h>
>   #include <efi_variable.h>
>   #include <env.h>
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index 9d9f786a6db..ade44cb6e36 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -9,6 +9,7 @@
>  =20
>   #include <ansi.h>
>   #include <charset.h>
> +#include <efi_device_path.h>
>   #include <malloc.h>
>   #include <time.h>
>   #include <dm/device.h>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index c9bf2726fe2..818f993f7cc 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -10,6 +10,7 @@
>   #include <blk.h>
>   #include <dm.h>
>   #include <dm/root.h>
> +#include <efi_device_path.h>
>   #include <log.h>
>   #include <net.h>
>   #include <usb.h>
> @@ -46,10 +47,6 @@ static bool is_sd(struct blk_desc *desc)
>   }
>   #endif
>  =20
> -/*
> - * Iterate to next block in device-path, terminating (returning NULL)
> - * at /End* node.
> - */
>   struct efi_device_path *efi_dp_next(const struct efi_device_path *dp)
>   {
>   	if (dp =3D=3D NULL)
> @@ -62,12 +59,6 @@ struct efi_device_path *efi_dp_next(const struct efi_=
device_path *dp)
>   	return (struct efi_device_path *)dp;
>   }
>  =20
> -/*
> - * Compare two device-paths, stopping when the shorter of the two hits
> - * an End* node. This is useful to, for example, compare a device-path
> - * representing a device with one representing a file on the device, or
> - * a device with a parent device.
> - */
>   int efi_dp_match(const struct efi_device_path *a,
>   		 const struct efi_device_path *b)
>   {
> @@ -90,20 +81,6 @@ int efi_dp_match(const struct efi_device_path *a,
>   	}
>   }
>  =20
> -/**
> - * efi_dp_shorten() - shorten device-path
> - *
> - * When creating a short boot option we want to use a device-path that =
is
> - * independent of the location where the block device is plugged in.
> - *
> - * UsbWwi() nodes contain a serial number, hard drive paths a partition
> - * UUID. Both should be unique.
> - *
> - * See UEFI spec, section 3.1.2 for "short-form device path".
> - *
> - * @dp:		original device-path
> - * Return:	shortened device-path or NULL
> - */
>   struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
>   {
>   	while (dp) {
> @@ -180,16 +157,6 @@ static efi_handle_t find_handle(struct efi_device_p=
ath *dp,
>   	return best_handle;
>   }
>  =20
> -/**
> - * efi_dp_find_obj() - find handle by device path
> - *
> - * If @rem is provided, the handle with the longest partial match is re=
turned.
> - *
> - * @dp:		device path to search
> - * @guid:	GUID of protocol that must be installed on path or NULL
> - * @rem:	pointer to receive remaining device path
> - * Return:	matching handle
> - */
>   efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
>   			     const efi_guid_t *guid,
>   			     struct efi_device_path **rem)
> @@ -204,13 +171,6 @@ efi_handle_t efi_dp_find_obj(struct efi_device_path=
 *dp,
>   	return handle;
>   }
>  =20
> -/*
> - * Determine the last device path node that is not the end node.
> - *
> - * @dp		device path
> - * Return:	last node before the end node if it exists
> - *		otherwise NULL
> - */
>   const struct efi_device_path *efi_dp_last_node(const struct efi_device=
_path *dp)
>   {
>   	struct efi_device_path *ret;
> @@ -224,7 +184,6 @@ const struct efi_device_path *efi_dp_last_node(const=
 struct efi_device_path *dp)
>   	return ret;
>   }
>  =20
> -/* get size of the first device path instance excluding end node */
>   efi_uintn_t efi_dp_instance_size(const struct efi_device_path *dp)
>   {
>   	efi_uintn_t sz =3D 0;
> @@ -239,7 +198,6 @@ efi_uintn_t efi_dp_instance_size(const struct efi_de=
vice_path *dp)
>   	return sz;
>   }
>  =20
> -/* get size of multi-instance device path excluding end node */
>   efi_uintn_t efi_dp_size(const struct efi_device_path *dp)
>   {
>   	const struct efi_device_path *p =3D dp;
> @@ -253,7 +211,6 @@ efi_uintn_t efi_dp_size(const struct efi_device_path=
 *dp)
>   	return (void *)p - (void *)dp;
>   }
>  =20
> -/* copy multi-instance device path */
>   struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
>   {
>   	struct efi_device_path *ndp;
> @@ -270,21 +227,6 @@ struct efi_device_path *efi_dp_dup(const struct efi=
_device_path *dp)
>   	return ndp;
>   }
>  =20
> -/**
> - * efi_dp_concat() - Concatenate two device paths and add and terminate=
 them
> - *                   with an end node.
> - *
> - * @dp1:	    First device path
> - * @dp2:	    Second device path
> - * @split_end_node:
> - * * 0 to concatenate
> - * * 1 to concatenate with end node added as separator
> - * * size of dp1 excluding last end node to concatenate with end node a=
s
> - *   separator in case dp1 contains an end node
> - *
> - * Return:
> - * concatenated device path or NULL. Caller must free the returned valu=
e
> - */
>   struct
>   efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
>   			       const struct efi_device_path *dp2,
> @@ -449,9 +391,6 @@ bool efi_dp_is_multi_instance(const struct efi_devic=
e_path *dp)
>   	return p->sub_type =3D=3D DEVICE_PATH_SUB_TYPE_INSTANCE_END;
>   }
>  =20
> -/* size of device-path not including END node for device and all parent=
s
> - * up to the root device.
> - */
>   __maybe_unused static unsigned int dp_size(struct udevice *dev)
>   {
>   	if (!dev || !dev->driver)
> @@ -820,7 +759,6 @@ static void *dp_part_fill(void *buf, struct blk_desc=
 *desc, int part)
>   	return dp_part_node(buf, desc, part);
>   }
>  =20
> -/* Construct a device-path from a partition on a block device: */
>   struct efi_device_path *efi_dp_from_part(struct blk_desc *desc, int pa=
rt)
>   {
>   	void *buf, *start;
> @@ -836,13 +774,6 @@ struct efi_device_path *efi_dp_from_part(struct blk=
_desc *desc, int part)
>   	return start;
>   }
>  =20
> -/*
> - * Create a device node for a block device partition.
> - *
> - * @buf		buffer to which the device path is written
> - * @desc	block device descriptor
> - * @part	partition number, 0 identifies a block device
> - */
>   struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int pa=
rt)
>   {
>   	efi_uintn_t dpsize;
> @@ -892,13 +823,6 @@ static void path_to_uefi(void *uefi, const char *sr=
c)
>   	*pos =3D 0;
>   }
>  =20
> -/**
> - * efi_dp_from_file() - append file path node to device path.
> - *
> - * @dp:		device path or NULL
> - * @path:	file path or NULL
> - * Return:	device path or NULL in case of an error
> - */
>   struct efi_device_path *efi_dp_from_file(const struct efi_device_path =
*dp,
>   					 const char *path)
>   {
> @@ -1023,17 +947,6 @@ static struct efi_device_path *efi_dp_from_ipv4(st=
ruct efi_ipv4_address *ip,
>   	return dp2;
>   }
>  =20
> -/**
> - * efi_dp_from_http() - set device path from http
> - *
> - * Set the device path to an IPv4 path as provided by efi_dp_from_ipv4
> - * concatenated with a device path of subtype DEVICE_PATH_SUB_TYPE_MSG_=
URI,
> - * and an END node.
> - *
> - * @server:	URI of remote server
> - * @dev:	net udevice
> - * Return:	pointer to HTTP device path, NULL on error
> - */
>   struct efi_device_path *efi_dp_from_http(const char *server, struct ud=
evice *dev)
>   {
>   	struct efi_device_path *dp1, *dp2;
> diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader=
/efi_device_path_utilities.c
> index 552c5bb1f05..f3ef3eabdae 100644
> --- a/lib/efi_loader/efi_device_path_utilities.c
> +++ b/lib/efi_loader/efi_device_path_utilities.c
> @@ -7,6 +7,7 @@
>  =20
>   #define LOG_CATEGORY LOGC_EFI
>  =20
> +#include <efi_device_path.h>
>   #include <efi_loader.h>
>  =20
>   const efi_guid_t efi_guid_device_path_utilities_protocol =3D
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 5452640354e..47b583cc5e1 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -11,6 +11,7 @@
>   #include <dm.h>
>   #include <dm/device-internal.h>
>   #include <dm/tag.h>
> +#include <efi_device_path.h>
>   #include <event.h>
>   #include <efi_driver.h>
>   #include <efi_loader.h>
> diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
> index 1ba6641d821..bfaa9cfc207 100644
> --- a/lib/efi_loader/efi_fdt.c
> +++ b/lib/efi_loader/efi_fdt.c
> @@ -8,6 +8,7 @@
>  =20
>   #define LOG_CATEGORY LOGC_EFI
>  =20
> +#include <efi_device_path.h>
>   #include <efi_loader.h>
>   #include <env.h>
>   #include <errno.h>
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 19fb5d03fec..2acae7856f9 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -7,6 +7,7 @@
>  =20
>   #include <blkmap.h>
>   #include <bootm.h>
> +#include <efi_device_path.h>
>   #include <env.h>
>   #include <image.h>
>   #include <log.h>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index b3291b4f1d5..232e1dfc36f 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -17,6 +17,7 @@
>  =20
>   #define LOG_CATEGORY LOGC_EFI
>  =20
> +#include <efi_device_path.h>
>   #include <efi_loader.h>
>   #include <dm.h>
>   #include <linux/sizes.h>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index 210a846ebc8..1832eeb5dce 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -10,6 +10,7 @@
>   #define LOG_CATEGORY LOGC_EFI
>  =20
>   #include <dm.h>
> +#include <efi_device_path.h>
>   #include <efi_loader.h>
>   #include <efi_variable.h>
>   #include <efi_tcg2.h>
> diff --git a/test/lib/efi_device_path.c b/test/lib/efi_device_path.c
> index 5cc001e209e..5a358ddcb93 100644
> --- a/test/lib/efi_device_path.c
> +++ b/test/lib/efi_device_path.c
> @@ -5,6 +5,7 @@
>    * Copyright (c) 2020 Heinrich Schuchardt <xypron.glpk@gmx.de>
>    */
>  =20
> +#include <efi_device_path.h>
>   #include <efi_loader.h>
>   #include <test/lib.h>
>   #include <test/test.h>

