Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12DFD1D48A
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 21:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98706843F5;
	Fri,  9 Jan 2026 22:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=icloud.com header.i=@icloud.com header.b="aCcpJS8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30A24843D4; Fri,  9 Jan 2026 22:13:36 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster2-host1-snip4-2.eps.apple.com [57.103.64.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8F7A843AD
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 22:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuri.honegger@icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-3 (Postfix) with ESMTPS id
 3676318000B5; Fri,  9 Jan 2026 21:13:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 bh=Vy4LZpRCoeLfb+PrND5ff3PM4Bb1EJCSBCjKhfalrwE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=aCcpJS8cFNShsx+MIwE931vbqvRRgoNLBfwIb2FO/6DiGSZxAuUpewVNlanPEg3/+UvI56CIByHDFaY6keegPpycwUC7sQ9BRSB3wJwtU0qpyBrfq3T3TthyVJkx1LOMupkKbCysHnVoORZX2FuTtKsfYqYlBfThyR9C8dfF6PQ1halmmaNPnVYQXTJsfFOCX9iua3nnq20bxJgBUwu8b8Wtra8qburP9jRS/HskSyCwq7vlpXE5A1e2XO3ehmRFCHzfpU5Ly/cazD3NwdpyoU5Lq+hROrTGRJ7wWGCf7nEFSzAodPew6mN7unibYQrf2Ngy/Y/gZG7DRPm40E39fw==
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-3 (Postfix) with ESMTPSA id
 D26401800998; Fri,  9 Jan 2026 21:13:27 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: Placement of FDT in memory
From: Yuri Honegger <yuri.honegger@icloud.com>
In-Reply-To: <20260109170958.GE3416603@bill-the-cat>
Date: Fri, 9 Jan 2026 22:13:25 +0100
Cc: u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <89B99CA3-BA46-4755-BAFE-95C1944AAAAF@icloud.com>
References: <B157C9A8-9D26-4C06-B2F5-BABDFD7A8BFC@icloud.com>
 <20260109170958.GE3416603@bill-the-cat>
To: Tom Rini <trini@konsulko.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-GUID: vPg8nkjyv3YC0AMIrED5dILNhn476s0K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDE2NiBTYWx0ZWRfXz9gjcvIrMB+f
 0DhzuDX/pNffn0CdTZHOqqPJU6ihBPc6U81zLpnFURQePbYdEAVVeQ76EVzQzFPTV4Qj1+pf7dV
 N8e5u4bVI0Ii/LJQexsqRhQZHLYnuafPZU5TGJSVQ3KxjEmo0vezscAN8pKw3X5xI1QLgBT29cY
 b0Tq1ZAE8pfe0d2kbOGjKerAtPrnSPJfonY7hGNv8SWUFN3N6fHy9A/kbKhuU8BPScZlGK6Rd5c
 NGTWaVqZS0QMQDgOg4iYUYcqn6QdBTsRvaCBos6CuOZdxMC80/utH4/Qc4/W9nJJcy8f68bQLgz
 gPBOtXSooICAQHGEpR6
X-Authority-Info: v=2.4 cv=b/G/I9Gx c=1 sm=1 tr=0 ts=69616f79
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=x7bEGLp0ZPQA:10 a=MquUGpQHRscA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XpE1AkgCAAAA:8 a=k-42gJp3AAAA:8 a=zLIg5tn8IvlcWDOysXsA:9 a=QEXdDO2ut3YA:10
 a=nBVXOfS-3XAA:10 a=dpZMgbseYPk84XhQl7oQ:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-ORIG-GUID: vPg8nkjyv3YC0AMIrED5dILNhn476s0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 clxscore=1011 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601090166
X-JNJ: AAAAAAABCAIreUtaOk2lRi+jl4c0i+Q1ucJp23iMQX95Ulq7fZnBnzfYftLL4P3Ps84hh30QAyZYoheTtrcFvSRf7l+agqoJHle8hxdAasgI8zPzlcPvqnlgr3D+EIoFpK0o8LdpMHY2aw/VSulxykeltNewUMXOlfva4bMt7CudK2kTSX5Av7np8fLDhKP+VPNylVWNZcrpzbNdjER1W3FoIUaUg4jcNsW27IGgNsEJ56Dz/EvOPFHvbvmAJXWu74w0Y/3vgBBTj3yj9QDW4wFMU8gQ/5HkXnedn2c6kQnTWdqiiLGKqOz+bhwlpNudzT3OECdqHP3F5mBzdY9XLLjT1lV57UVpIku+P4EgH//6lyzQH888tXxLfV4HgEQBc6Xu1kIgLVJwSXPtS+IIf9mOr5Y+FBrJjYBXHmSE24/QoCd4NHcVZXerdcEti8nI6g1xvoTk933FkYgb/3PmyW16p74BEB94rnlTI8or7ZZOopYsh6HxEf9+G95F4bAXH+dLBHje3lfepQQlfLTpUcPKw4m/HuVZe6h8NiN5/i6t8y+T0+Pr3OqpCqM9LgtOLl0+lWMyCzYV0H0YKYs2SRTsi9XboWTDjLSOeQaJW6ZNoWthF/Jg5M0uG1bW6Q==
X-Mailman-Approved-At: Fri, 09 Jan 2026 22:54:20 +0100
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



> Am 09.01.2026 um 18:09 schrieb Tom Rini <trini@konsulko.com>:
>=20
> On Thu, Dec 18, 2025 at 11:04:59PM +0100, Yuri Honegger wrote:
>=20
>> Hello,
>> Recently I've been playing around with the imx23-olinuxino=20
>> (mx23_olinuxino_defconfig) and booting NetBSD using u-boot. During =
that, I've=20
>> noticed that NetBSD panics because u-boot places the device tree in =
the BSS
>> section of NetBSD. NetBSD clears the BSS section and then complains=20=

>> that the device tree is corrupt.
>>=20
>> Reading the logs, it appears that FDT and kernel get loaded at =
non-overlapping
>> ranges, but then u-boot relocates the device tree right after the =
kernel into
>> the BSS section.
>>=20
>> ## Booting kernel from Legacy Image at 42000000 ...
>> Image Name: NetBSD/earmv5 11.99.4
>> Image Type: ARM Linux Kernel Image (no loading done) (uncompressed)
>> Data Size: 11950164 Bytes =3D 11.4 MiB
>> Load Address: 00000000
>> Entry Point: 00000000
>> Verifying Checksum ... OK
>> ## Flattened Device Tree blob at 41000000
>> Booting using the fdt blob at 0x41000000
>> Working FDT set to 41000000
>> XIP Kernel Image (no loading done) to 42000040
>> Loading Device Tree to 42b93000, end 42b99a0a ... OK
>> Working FDT set to 42b93000
>> Starting kernel ...
>>=20
>> The bootm command seems to insist on having to relocate the device =
tree.
>>=20
>> Is this something the OS is expected to deal with?
>>=20
>> In the meantime, I've managed to work around this by running
>> env set fdt_high 0x41000000;
>> before bootm. Is there a better solution than this to force the =
placement
>> of the device tree?
>=20
> So, interesting setup. It's not a FIT image, it's a legacy image, so
> there's a few details missing that might be helpful here. But, why are
> you loading the image so high in memory? And we're calling it a Linux
> kernel, not a NetBSD image, so we should likely be updating our docs =
for
> booting modern NetBSD releases.

Yes, NetBSD only generates legacy images when compiling the kernel. I =
suspect there could be licensing issues with FIT stuffing everything in =
a single file depending on how it is distributed. Most device trees are =
GPL. I haven=E2=80=99t looked into it all that much to be honest.

The memory location for the kernel are the defaults from u-boot for the =
imx23-olinuxino (see mx23_olinuxino.h and mx23_olinuxino_defconfig) and =
memory ranges from 0x40000000 to 0x44000000. Is there an issue with how =
they have been chosen?

As for u-boot calling the netbsd kernel a linux kernel: That is NetBSDs =
fault, for some reason it produces images with =E2=80=94os linux, =
although I don=E2=80=99t know the backstory.

>=20
> The big problem is that for a legacy image, we don't (and can't in
> many/most cases) know where the OS ends it's BSS and so have to hope
> that we're relocating to the correct spot (in other cases we can see
> this overlap and avoid it).

I agree, we can=E2=80=99t expect u-boot to know where the BSS is. =
Perhaps I should have explained my question better. Why does u-boot =
relocate the device tree before jumping to the kernel? If we have to =
provide manual addresses anyways during the loading step, we already =
have to take care of ensuring they don=E2=80=99t overlap and so on. =46rom=
 NetBSD=E2=80=99s point of view, they already were in a perfectly =
acceptable place before the the relocation.=20

> At
> =
https://docs.u-boot.org/en/latest/usage/environment.html#list-of-environme=
nt-variables
> we document all of the environment variables and bootm_low / =
bootm_size
> / bootm_mapsize are relevant to this case, along with perhaps just
> loading the kernel image lower in memory to start with?

Thank you for pointing them out, I=E2=80=99ll play around some more and =
see if I can find a setup that doesn=E2=80=99t require too much =
fiddling.

>=20
> --=20
> Tom

Thank you,
Yuri

