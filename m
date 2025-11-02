Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C664ECCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 04:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA2C88307F;
	Sun,  2 Nov 2025 05:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="NnYYo/PD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A4C830A0; Sun,  2 Nov 2025 05:57:32 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster4-host11-snip4-10.eps.apple.com [57.103.65.221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C940382A9E
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 05:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-7 (Postfix) with ESMTPS id
 701131800099; Sun,  2 Nov 2025 04:57:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=F7vq9TiCUJ8LIWbc306qCUQiSydk7VgQIuUWIY2zKtQ=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=NnYYo/PDZQ1+L6XGwwBvde6vD60pphkDw0vVUMlPAdCoLQS3Mn9h1jsuuwL0wHmuFPzRZnzYjEVnKv+2+NQswe9uY3nOxheodmymbQ9vxYE5/GeF2ff2TxyZEcdptjIRk8/+Xx3P6MUx6jeORM2K3YulBYs+sKRWu6RNorxXpxBwzbVeGWLrFDOK/LAZF65IpFgXAN7+KwmV4nOJkkQd13Ei7t/Ti4m6XK4mBJnTVhy+VAIvi/EsvocK1zIiEp4Nj2q8NomW4XFXE/krqgEVTjoIWUVN4la+/P2Ilsg19eL0qr1U+KhgwYCztcwh0JSuid3mHgZAZpszvI9Ocd1+GA==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-7 (Postfix) with ESMTPSA id
 C043B1800103; Sun,  2 Nov 2025 04:57:20 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
Message-Id: <490112A0-3D3B-4209-AC15-43A5A74C546D@infi.wang>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v4 5/5] net: phy: aquantia: use generic firmware loader
Date: Sun, 2 Nov 2025 12:57:07 +0800
In-Reply-To: <1fc25e78-4a7c-4471-b381-f35e69a8d5d8@mailbox.org>
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
To: Marek Vasut <marek.vasut@mailbox.org>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-6-root@infi.wang>
 <9942f1d3-669e-48a6-923a-c2607eafdd02@mailbox.org>
 <FEAA3555-3109-41E7-A58F-5B601B6C2FB5@infi.wang>
 <a8f176dc-59c3-4af4-88ed-03d064f2e7c2@mailbox.org>
 <8968863B-CFDC-4EE9-9062-08219AC0838E@infi.wang>
 <1fc25e78-4a7c-4471-b381-f35e69a8d5d8@mailbox.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: SKnOrSKma1OqDiaQc2TzqQ58C8c9PttV
X-Proofpoint-ORIG-GUID: SKnOrSKma1OqDiaQc2TzqQ58C8c9PttV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDA0MyBTYWx0ZWRfX9ztXfLNATgLV
 LKBAtpnP3oBsT0uKQSIQZ9IeXlmDH+g0+GmpSnxUM+WmLDp09i3UOmEnhlbVgLb9sca7ZCpvfig
 mykRJxL4n1ROdLlWBTHmNnSVz0/nNK0SoC6QWaQDtWtnZIFsrSzgD4gS8/nbN8ElFjEBjOmjyzr
 ddkMNcUZdLmDiOmqJfip6liWQhstypgzRGdrb1GmOZMyAWBnK5kIEM1qCe9m07KBUZaZnqZPhi0
 SM1s67F0hGVBaJIi7sz62/6cc7J/P71RjyIrMit+eE49NzY2e9sQLzwwXl3+71hS5HQRu6NoU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2511020043
X-JNJ: AAAAAAAB/MUNWcAap7Gvn0GIYXi2P3t9gb6jZOe/HbGUlGVfozf96tPHdEEkP21AvPH4C534UY+s8YoxbNHHl/jBeH2tsSNUUy0m8FUl7iYupPcTDlHLWvbwjihjzm6XdkJ5jZJFBWrwEXWfF2QfggJV+EbqfAGQlFAoI+hZVthzIjEWSGaUryRV7YwfEouyblIsM6oXph/t9mIXULd0R2CvJLbsSUwgzUfiMtlEAPuCWzc2B4ahIpUTfhlTbdazzBMYFDmD0xgE5GmFa+tzaemnjCRKam1O199g2SZjOWTmfnKRAkVSCGCg9rTieMaulgoUb5tM0E6S2Q1rl3iIorRPlwSYCcDT6hqoirMfN4UUZbAVCv9m8+1DKM7Sr/zu+7hMSzyR1cg/NiCGgNSBkCtgGNSKMRFK7AwX7Dks0AZw5kszR2C6a9s1LP+0j8WK3rL/lrbvQ6k+TmQ+fdogI4mmfsTw3ubTOMQ5amCKqCGdP5SEoqm3Em4Ue2j9uJuIXvsoPLJ9NGbOVEiqstrREE68opnKO7apoc8Mai1y8UVBnDYZnQQJHMxiHCkdH4OMH4PSP2WlB//5SbeLChq+1bbrhgnjbF7GJOPOn4XWmOWlvBRCSAbrAkyVurKYijZi6G0jalUswwE2VIfTc3KaNgcZeLX6gSZnH3ZWi8CFWMV6icVP1BDoC6q9JEOzAlHrToE7XrPp3Krpa9O3S5R+LfCKeRpTlpjaDzAdKSSoeSTDTNv6KwhzdhV+IES5SkjamXdXE6OEHt3/dhc7m4mMRQYgcA==
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



> On 1 Nov 2025, at 7:54=E2=80=AFPM, Marek Vasut =
<marek.vasut@mailbox.org> wrote:
>=20
> On 11/1/25 8:45 AM, Beiyan Yun wrote:
>=20
> Hi,
>=20
>>>>> Can you not use the plain FW_LOADER to load the firmware from =
either storage, UBI or Block ? Is FS_LOADER even needed ?
>>>> Thanks for the suggestion, and yes you can, but that API is =
script-only=E2=80=94it expects the board to stage the blob and just =
copies from the address exposed via *_addr/_size. The current users of =
this driver expect the old pattern: the bootloader mounts a filesystem =
(MMC before, now possibly UBI/USB/etc.), reads the firmware, and applies =
it. Keeping an fs-loader node in the DT is effectively the same contract =
as the legacy MMC setup, just generalized.
>>>=20
>>> Can you maybe write a script which implements the old loader =
behavior in a compatible manner ?
>>>=20
>>>> The fs_loader driver gives us several things the script path =
doesn=E2=80=99t: a standard way to describe the storage via =
"/chosen/firmware-loader"
>>>=20
>>> Try this:
>>>=20
>>> "fdt addr $fdtcontroladdr ; fdt print /chosen"
>>>=20
>>> And then look at the "fdt" command and what it can do regarding =
reading content of DT properties into variables.
>>>=20
>>>> , runtime overrides through =
"storage_interface/fw_dev_part/fw_ubi_*, and no requirement for a =
board-specific script. So FS_LOADER isn=E2=80=99t redundant=E2=80=94it=E2=80=
=99s the part that replaces the hard-coded MMC flow with a configurable =
backend, while the script helper stays available for boards that want =
extra logic.
>>> Maybe a more generic script can be a replacement for the older =
hard-coded approach ?
>> Fair enough, I=E2=80=99ll remove fsloader for now.
>> I still believe it would be valuable someday: if reading from nvmem =
cell is implemented, the same DT could be used for both U-Boot and =
Linux.
>=20
> See example above, you can read anything from the U-Boot control DT =
both in U-Boot shell and in U-Boot env scripts, using 'fdt' command .
>=20

To make sure I understand the preferred architecture: are you suggesting =
that FW_LOADER is the preferred method, and that all the logic for =
finding, mounting, and reading from storage should be handled by =
board-specific scripts that parse the DT using fdt?

My main objective with FS_LOADER was to provide a "zero-script" default =
for most common use case. While scripting is powerful, it seems =
beneficial to have a C-based driver that can natively read from a =
filesystem described by a standard DT binding, rather than requiring =
every board to script the same "find-and-mount" logic.

Am I overlooking al drawback to that C-based approach, or perhaps =
missing some prior discussion on this?

Thanks,
Yun

> --=20
> Best regards,
> Marek Vasut

