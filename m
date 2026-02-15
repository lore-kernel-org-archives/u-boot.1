Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2526EF5868
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 07:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D876780FA1;
	Sun, 15 Feb 2026 08:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="O0PVmO6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E96083C32; Sun, 15 Feb 2026 08:58:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 457B080B98
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 08:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771142328; x=1771747128; i=xypron.glpk@gmx.de;
 bh=aPgfcbOhVbByrNBnMl4CWi9LnMf7hsASdIHN9tL+HWI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=O0PVmO6kjITskO3yIt0y3nK/hfIfuuTTg7hvpcjwRWFd97POXiGer4iZmDraV2s8
 OcuMouwbiwXm8PDmTDEfyuNGzOxKKDXuFptJylV7CNGdeQCBpc7mUhtNAONZCBBoU
 A6QzC71+79Wy7Gi9YUaab3qn59LA7/3ZyVtNuEFiIK4tBqp8Ns0WNxuX14SPeXmnY
 qEk614VwZQF1pFe2El225f0FuQ2c+kjl1dhE5qMMKqlJ0jOThqyqk6I/iCbRhKK3o
 PINm9x2V8vBlAlNyS6CEY3sIO6MjzcVy4Gs5wKUXgvr0GXa9MGLmDsJAi87NoOKkY
 bF3OA8x/hOElHodMsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1vp2370Mqf-00DQu9; Sun, 15
 Feb 2026 08:58:48 +0100
Message-ID: <ea41ff4b-68a4-4f35-aefa-995b6e2cf5ca@gmx.de>
Date: Sun, 15 Feb 2026 08:58:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] efi_selftest: Enhance MBR test for
 PARTITION_INFO_PROTOCOL
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: eballetb@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260212204511.619392-1-javierm@redhat.com>
 <20260212204511.619392-8-javierm@redhat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260212204511.619392-8-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oSZBS/Qom6Wy4HYuFguSwbU/zypmHurm5EzRjdDqyfdbmBX5LJE
 4XhSZ1x5Nf/WH1+TuTmmR9dy/P3pTRqBsXb9gMQ+nvV9xvI1Zcxj6lbqLy51VnCSrphcNam
 nrWSJ82PQGifzZzmT6sZtSMAjmNLhoii+CsvmWdQYhAWHotGSG7oPBDdbheoSjFE60ixIhH
 ogcYDwqWnXSNCbmRGwBEA==
UI-OutboundReport: notjunk:1;M01:P0:2roirFDEJjc=;hwxJTsf4Gn/P2OpYcaFIqwYN+Yh
 dUGdmcOPwqh4JkLyz+VypOrIsF4E9pRiIpSSOSvxWHr7NozE02XUdlxBkpfy7g80k81P6FLCB
 118s6OU5+J+178sWz82FHFFGxXJlfvOYS7e4Qeixxs71nsETHD/cziDt5gT1d92dEGNnS209/
 lQz4MVEXIHtRE2B1w4HV4ttCAUVNTv1bg0UJSbU1E7YsFQ4gHL6oCR+w09Xa1JjI6cfJ3BtI9
 M1Y6YgiXZFrT3ieXBGQsvKQVVJetbiXH84GwoO/T+CgDbkRebDDKA33AcuRtTpPyX4cEqk6y4
 umpvwgU0he5qVOWvS8uZcFBDezTZZ60Kw2YTGwQ1HkUfAwLvoOO5Rdulu5AzsntvyVggg6zCw
 dBDQkhbsMBjAUOXFmcn8OPHms7o5qMczhhNJZs50KbOqy3tr4i6hAC79lFtsOCoiH5Ha+GgpG
 4nipJgBUcz1QoCDCZxG78pdGEGFycZGjx8HPGCcqYu0MpOt6ylpSXkFF7Fvh17iP+bzFVTJ9t
 YvEMYW5OMokoTdJ4BOprmjDFQN5KY2x2JtjYJIAQ5txBX4GX5TMuP/YFsWc/R/oPVUirff+mI
 B1IZFSL9DmAU0JtA7+j8rz/OFthn21BYBaxwsav7IpSMRBUWKP1Y8fE1gOmWyudAM0PqEDO+S
 q9hKIyvymsRQwGYoqQL0XOw75WqQOxIXcIBdLt9kMa2GCSqQET9ckklTJjbtpvWwWpY9rJMlp
 HcHOhxp3RB5oYguDnysQZC2oSa8EdIpFR2mfj+6ZItsn1WKNC6zrRM/xI4Ooec4P2TvXkPsqo
 9SSslJP9xq+HzZIMZrERC8GQKjgEt2GWzRVrFlzi1lRFjj2FiIZiWcsXknVzRwBPTkCEeGH+e
 qGNG4o8rfPItn/qKcYcpxe1B9ERIKjh50XOA7uV15aRRq+U59Jsu3NqY9hM84b1aZHGozJjIn
 SJAhX1wYYrjxK7l6xtkS8IlkDqGWnExsfEY/v1ZI39bkJmShtmXeHpT7JBjiwwvXNlB8FJG/V
 2/9e3F4nxJtL4oTmCDA24VPZOrG7TKF2PqB0Mw6+dA0zqHNAt9yHkDs89NC28M+qx0P8gFZty
 i7gb/O7lPxg22m9imxEXKekfy32ehfq69HH4jjEDZ6a3J8w7ptNVOeAdKr8di6Y5TvnaMxLxK
 EFnkyheLOHS6lfPiOcKIVcPFTnpadAbuzFjyFsWIxwYgN3LLGAuEFowHi8JaKxlXA93xxSKzl
 Aj4B8WpVrWNZOoR/L5UEv6knExDzS5dlByLx4zMCD82sM7PhDPPLh+7OH55ooQLKscMPJQK6y
 IdgGc5SmhSfqayhlo4S6pDUaimasguSO318oP/KQUPsoAMBWnrwSjTOAIcRDYfsxnzWxLtfCA
 WsW14V0tgZ3JcCi28bSn2J5oGjaK+5XBW5S5w1NZZBpBQDEp0hjXUzr/XgVznmCgICc+INJ9i
 T8LOCcguovIu52fuEaRpD+9TF2MmKBWmZDwvLyfJcNZHrvDhkoplwuUHWirB5KS/BdO5YGvkq
 gbAGA3+f4Fa0MZWGXRO3Up6mij3iH52YB/gGYC+FQ2Qxb/oYbwLXmwUp343XOW/CK67oaatqT
 SbxTQvqMZ55X5g8j2fEFzE75P6soX94KLZWYBRzB+oMLuXUNOjEF6MTcmLuLPMFajZiFMaXDV
 VWrTP2KJEIjlUF71l0iPw6gz9gmmpVBo1+nYQEKJCi6qM+Xvpukoy+HU0wbhruZRRa3pEaY4w
 zqQ93wlHJGRBw6znYApwkHoMFb7QX/X2rFY42gopGOBqQi6+/hqhybwnVW+SQDX/eodduFHIt
 F86pS8+2mO8LgEQLaXsp5X+8I6PdtkdExaDjH5zW7nGpt1PaJaQf4rU0DaqxM2QXZdExqhO6b
 e/biq93vivGO+fhPg3GfjZ0dX5LaPpvoTpS0SoI/HVPg3PvoGw4dZt1Hy2zaGDAp2/+UOkUkn
 04rpz7PyGeSmKIyP+eZmdvKYOh0u6DJgygY6kn4qHXlQAW+/P8hzcSb67z/6jx0ruS7zX0KJw
 uHFk6ogQjCdetxmipqV9u1Mw3ExYT/AOBFau0XY+FbAFgc8sLR9bbeenZLifeG3B1O4rdjYO1
 qL6PaK8b5t/ls9jm0FNvOb6UOTQuFsNHqAoM6xFl0k/8qJmY29vaRFG4L+OMjhejKufK4vW2P
 GnMvT9QM++z5+KLIwXYr1f8DwOhgI3Yd6KWPhmZ4cLsTwpla5tShbGQMdvIHpGha+8gxdYhtC
 uTXv/DA3j5idn2g53C036KoYhaaF9CFpRiUvfcJRYRoDLVX4gL5IZ1B1RI6SwjZ5Png91Mn4c
 78AIGj8jTZly3nC1dnFfTIBAeXzZNQ9S/nBCaHebtMYz6QBzHxZhCvZ8K1FplMMsrY5crWpMe
 6KknEYEnuTrgMumx7/jR+r1m1ZOG6+V/yGzZ5mMbMLboWYt/6pq23UczA8XUNVer3G9pN61wH
 ZMnScnAADFc9xUorG7jTi2EpmUY54QBgVJPF7sg4PW/x0/OsWKlAYmB5tlfEpd8kLqY82Vo9X
 MoQ6e+urOpxTsZeCIbUS56mV8mXnA4FtUizW9V1N6e9bXN+gCrvqRsFn/buhPZIdAWc2raCV/
 a/ccQLJ6uKNXxhA4xF+ligY26LrJS9IRrglm5hDQdjPNG9hKnW/VlMhRt4p1SuwYSdfFBqtZ4
 BhkCDSk/BMAfEy9XFyJ9kcXJP8c5OdkjHWn3YI14VuJKbG8djwYfLsCMXK7i3uVotCO2cjvc3
 EhdesG0B062WGrY6kVC1mtjQL2yeWoaZ2Lsuxu0ipQ4bYrkvJKVq957N8PrREhR1Yn/LTHv4F
 7NAz0XuDrS/l7WagwxM/W6gRV9WGj84QLw8f2D8LuQFnbltvs7rbl0LZoa9imTLaeARi7NgR1
 o5/TS5b5mFeIFqMrBfOagcb5Ddt0X9LXzKPq5r7nynpYTa3IaVXBMVHhDpxDA1L90545obMEq
 Tkc5vEXeXjwx8067FebMd7OVkONLAg2rqPGT4tNe0PL6ip+dwlDE+IUOyH5+sMTWg3s/8Q2+V
 Zr8VuEtVb4SccD91WJfvq1gWQpDMU5Iz62J0mBjZbNX1AMAXiha4m3J/ofxjOaHomc9afB0mY
 YqeOay/qcN6/ZlZ/jtbZ5MWE9HFYlUZY7oBvDKc4HJranNMptuuwf9+NL3/8EsuY4nBUxs1cg
 5t8a8wH1snCP+5wRFpDU9OPTogcMk5XVMg6bDHDiqI0pgN88qhzlQlAlSkhCwh0Hhzif8J0ob
 qk9Q+CAlAZj/W6ZXEMbv3FhiWoEongyIniaEnvFZCndC0CesQpcN1gVDxrQzC9QSwgKSO7FxW
 NMPMpiOMfiSRokOX/XgzO9dPO8zN4xHgsJaIvtcfNcILqZCLvkooU2LUl4Ure5pJe2yl2ghz0
 j9x6MGYdsYr4s1V0mf1bseX1720SoEaSItIQA97GCDXcEh5KUM9w1GvamXSOuzSgvRYhIpHFF
 1d+rIQi/d0tQdkZFRufA28WjtpCWGbHsRUtggso6np5BidUaCZQJXiw3FkztuT1NXeow60hfO
 /eRpCrmc6vCeNmUVy53mThrc7ZANWr/ETNb5RQZec2CwDUMf7ABkoX4+SpprJVmXi3727uRoI
 Mcd8mXda9YNJ6zA0QIKEnHhMmuHR/8MEcDOH54OS5s9qrHavHe7Fvtp7rIrab7YmRPF5TAj0N
 POaAfHZHYDZRn2frEphDPzDQysBOJFaD24DOQOocRYydh0VloSrb9E8B8gQWQn3Kqq7AQPk6z
 0oJBXYEHDXEgesI3Xb8JvAlsjUGWX5V4+cB8AufMI4MnkDo/hqcAZphC+73xxcYg6lN3I+c1r
 wUoIsVvm2PL88rT6amiCyEeQLBStZeDlAF7/5BxhsIyro6I3IYbmSNyvcArUHQVTGK9U+QU5L
 GN5ekMxUgaQCzheee0E4tHjAuNWQPnAHhuXyKYy6SEhWj6OWH5qqgZeNb8S+Ilo1UmgFsxRYp
 op7V5T7UgSQWdOvrFpnoUTPB8f0JK+GeAFpKwnnpYu4qWglErrjTUwvJAggKy66/4/XtcH220
 9fX/Hic/A9Ua868Hf3V2FJTQn/2/Hys+2Lqm2b509QBkxbSHlyIAwDbhXoLY5S7NRl/CV3Jes
 Icq/8U3Wx5zPd1ZYJcM4bnoV/jBk/KpNrFqScOzSQhevydr5cm71XvUXFeZcN4QKCPHQRoaoL
 ggDv4Xjk0dvdMHwJMg/QBlPReo5avzmavRRYMDkS9mEcFVa4mnc/YG7gu9tT21FbudQ4nv9iV
 9vFZxoNH6RP4iynhDHo3FATGWi5dUo5v4peOIoZ01cLKxa9Hbke520/J3vpHwjkZHryLfcOVJ
 VJNiiP7BEEb5ewM73xB4r3oXgnCzrYSEJBF4cfyu0Ix+GWFqo9nOlYc2AC4cMvjm+9Elat5S5
 FzvszK8yWRufrPO8OIqITriXWrh9H2L6miMz5ciuGLzvTGPKfQr+JuikfT1x/Ia2zoEMhjmgg
 ZQTQ6em6FiRD6nr/LVNrjBEQvYwhd1TEIbr7CACRxxfZMZ0tWzdKmZrd4VobjeoFoE+3UzT9N
 Q7B2g6WU0ke+kKj0T3sB4o8qM+agKmX17B4htqhNyhmT+KT/t0ehXVfkRCDq7dM0wO/IF3GtM
 iIsKLy+L/9vwTFX1+x125M/UaPECmU0QtJ40O2jB7NR3BEOn7PniZ1GYdYDu8Jos2vrhWZYyw
 YrXKH6socEbNeUe9b4Sz2swHtqD5MvssjShLS2hcAGdub5G59q4Ns0yZ8W6x0HTnKi+BbrjJW
 x8AdocCUcj2s6AfA9cEjYpwUrNT2PSmPcG7C4WHHGe+j4G9cIaHtFers7UGJ4UMNJKzRaBFF6
 9W6HurOqhll5a4swoWtlfJ+9fuVvJAcEFe3zJx5q5DiAOvqTtfD2bvvRLnsQWsnOI4sU7u0o6
 CB7kF98ap9Y0AQZskCkAoZF2HWwMicJigfEwz8pa9AXh+fTEd81tdNINm+oKyiqJKEh88oeJW
 ec0DkTTgSznmjE07gnYkGfAAyq5g5e7+g0NUsVvzLS3eUnMs9PkcScSU8bSTc2jKx0qZqceS6
 myZSju4D31cvfw3kxRJd+SyOsmOmBsXm/WQ0SLRDqtkYmEAIZfYHnvp6RrdlWOCgXqS7JzcJe
 dl5V9tKPfe9DnaTTUJpumCvlpwfWh4VLb/rzs22kmjLbZWATrlWm5tuYc2n8M6nFvHNRXIiFw
 jfYAso3tGXx0fS4b32MpcPYwIO9rcm2V+JWEAQJMTJnfnUdQ0sWgSFPmP+PBGb5NwR1qy7QkR
 pcotfVkhqK5aDpz8Xa6t
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

On 2/12/26 21:45, Javier Martinez Canillas wrote:
> The EFI_PARTITION_INFO_PROTOCOL test was added before the protocol fully
> supported MBR partitions. As a result, it lacked specific checks for the
> content of the raw MBR partition record.
>=20
> Now that MBR support has been implemented, enhance the selftest to provi=
de
> coverage for the MBR entries too.
>=20
> This verifies that the protocol correctly reads and exposes MBR partitio=
n
> records and prevents this functionality to regress due future changes.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
> (no changes since v1)
>=20
>   lib/efi_selftest/efi_selftest_block_device.c | 26 ++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>=20
> diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_self=
test/efi_selftest_block_device.c
> index f145e58a267a..9c4be834eebb 100644
> --- a/lib/efi_selftest/efi_selftest_block_device.c
> +++ b/lib/efi_selftest/efi_selftest_block_device.c
> @@ -19,6 +19,7 @@
>   #include "efi_selftest_disk_image.h"
>   #include <asm/cache.h>
>   #include <part_efi.h>
> +#include <part.h>
>  =20
>   /* Block size of compressed disk image */
>   #define COMPRESSED_DISK_IMAGE_BLOCK_SIZE 8
> @@ -319,6 +320,25 @@ static int execute(void)
>   	u64 pos;
>   	char block_io_aligned[1 << LB_BLOCK_SIZE] __aligned(1 << LB_BLOCK_SIZ=
E);
>  =20
> +	/*
> +	 * The test disk image is defined in efi_selftest_disk_image.h,
> +	 * it contains a single FAT12 partition of 127 sectors size.
> +	 */
> +	static const dos_partition_t mbr_expected =3D {
> +		.boot_ind =3D 0x00,
> +		.head =3D 0x00,
> +		.sector =3D 0x02,
> +		.cyl =3D 0x00,
> +		.sys_ind =3D 0x01, /* FAT12 */
> +		.end_head =3D 0x02,
> +		.end_sector =3D 0x02,
> +		.end_cyl =3D 0x00,
> +		/* LBA 1 */
> +		.start_sect =3D cpu_to_le32(1),
> +		/* Size 127 sectors (0x7f) */
> +		.nr_sects =3D cpu_to_le32(127),

UEFI only exists on low endian systems. Field nr_sects is naturally=20
aligned. cpu_to_le32() is superfluous here. But it is a nop anyway.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +	};
> +
>   	/* Connect controller to virtual disk */
>   	ret =3D boottime->connect_controller(disk_handle, NULL, NULL, 1);
>   	if (ret !=3D EFI_SUCCESS) {
> @@ -405,6 +425,12 @@ static int execute(void)
>   		return EFI_ST_FAILURE;
>   	}
>  =20
> +	/* Compare the obtained MBR with the expected one for the test partiti=
on */
> +	if (memcmp(&part_info->info.mbr, &mbr_expected, sizeof(mbr_expected)))=
 {
> +		efi_st_error("MBR partition record mismatch\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
>   	/* Open the simple file system protocol */
>   	ret =3D boottime->open_protocol(handle_partition,
>   				      &guid_simple_file_system_protocol,

