Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CE4D1D48A
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 21:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC6CF843FF;
	Fri,  9 Jan 2026 22:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=icloud.com header.i=@icloud.com header.b="dEhBMxh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3837843D4; Fri,  9 Jan 2026 22:24:33 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster3-host4-snip4-10.eps.apple.com [57.103.66.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8C0C843AD
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 22:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuri.honegger@icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-13 (Postfix) with ESMTPS id
 1CA4918002E5; Fri,  9 Jan 2026 21:24:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 bh=2mLAHsVyLx4Huy94PEdWM2dQAb+KyeWZx8el38Qm2d0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=dEhBMxh5Mp+7bXbEm0aWEIbFVytMNBlULd1XozmP0TWY6wqdL3MsiXVXVWGYMxACLTnUqdRtp/kFwZHV6tkWSyw1XcNgECmEw6Ron/OXF7jhk7vuksZDmDmFEIk9SK3XzSCxbCrUeI8G4XCxmEzwcq7QHI/3i9IHa1JXRuX0lK9XhfZZLQTZXsMmLCCRFJ45jVdgvwLEHmZGcWDbRVdQ1lujNl4DsNj5oQDCZ2XvjX/JdGR9i5PAwrSflr9F+W3zd45bUQqfUW3lYvV2oanyY2eKkaCCbnzxclVGmkBF/iSj3gHppQwVAgjSaTB823b/haBd8/gcdDlrWtWGZ7RvdA==
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-13 (Postfix) with ESMTPSA id
 202E418002D5; Fri,  9 Jan 2026 21:24:27 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: Placement of FDT in memory
From: Yuri Honegger <yuri.honegger@icloud.com>
In-Reply-To: <CAFLszTjwSCwS8Nu0Xzg=movSN3B26fifjA2+b23ORx14joM4vg@mail.gmail.com>
Date: Fri, 9 Jan 2026 22:24:25 +0100
Cc: u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <B748B2DA-7A8E-4794-8DC9-CA094D65589B@icloud.com>
References: <B157C9A8-9D26-4C06-B2F5-BABDFD7A8BFC@icloud.com>
 <CAFLszTjwSCwS8Nu0Xzg=movSN3B26fifjA2+b23ORx14joM4vg@mail.gmail.com>
To: Simon Glass <sjg@chromium.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Authority-Info: v=2.4 cv=Pv+ergM3 c=1 sm=1 tr=0 ts=6961720d
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=x7bEGLp0ZPQA:10 a=MquUGpQHRscA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cm27Pg_UAAAA:8 a=v3ZZPjhaAAAA:8 a=3dV358RhpV4O6KFCrWoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDE2OCBTYWx0ZWRfX+0Yg+f8GTa3I
 Zv65ttKqebLxK16fY5wbF3Djc8khsAcUyQ5FPUyBRg0O4p+nrFF8AXcEoet4xkguHdVGf52WRCO
 ea9oijx/XIz/UAuY2PSR+yMv6R5DTkOqBn9P35K94AO2dDTEP4V8cxqT7rM8yeR82Q+pqS5m/Jq
 Pb33D+uXD/vMyOJ5/4J/CdjOW/tTIe7pUnggL0ZWtCmL9uoOb7JtiVN4DdV7zyY6HpXNyX7edi/
 phjoGwNEfzeei5mSyDNWcyEaEd/95X/2pcBCP0sN6MWucUE1mkW0kuUwzXXJ5Tl6zTrJC5hlNOs
 esZPZmT2twNcwmWityk
X-Proofpoint-GUID: LcEjazrKJrLUU_SxsaMTuXiqbrlAV27I
X-Proofpoint-ORIG-GUID: LcEjazrKJrLUU_SxsaMTuXiqbrlAV27I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1011 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601090168
X-JNJ: AAAAAAABbYmHwU7fp4ltWbPepFjrlz0lFkGqfN1KI7PokLgZO+cEgS55vzSSFkMqaSR49fbltmyFxYe6DUGRR6ANpusFVAGeOZnyZPuyqv7L1W9GQAFtBhk0CjeQAMomyRqSvX76dK6/cDjS4ziop/lnmwmY8erMG4yyy7HYOMMf/V2+CakH9iB3YCk/h0U/VfU8JOGRKj1Z5U1v0G+LraGZGShAWY10M18Uez+I5wKK69EdeAG+xGOWcegehRfu7P57j9i2m29bQQZSc0KEG4JyxUXqSEGdZMOG1N5LbRivEzR7eFK+g9gxKsBj5CU7K8oSSEBmV5W80qhp+QRpqJxA90m7VUb0PEMulZ2ujdozPjVz8XRhwd94EkKpUjX2kESB0wNua96KlQVDWMSM3RCI1wU8X1f8E5Ry1B78x5kumEFvh+M46ix5sbOI9lJKug+QG4A30hIrsds3IcQrm6hvHSWU7iwzXU5WtX2LYVCni1rssHUEnt1jiw17kjBu07VvqrQgnJaM5MNoz6pXp0iHj0PFN59V0aOOXFLn6Nqr84sralZ1QzWYIu3igE0s2q6DWmf5Y6hF4xwsb/mH6DSvS6DTaPV0VMparqKk5DFVAqZ0FH9g
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



> Am 09.01.2026 um 12:34 schrieb Simon Glass <sjg@chromium.org>:
>=20
> Hi Yuri,
>=20
> On Thu, 18 Dec 2025 at 16:30, Yuri Honegger <yuri.honegger@icloud.com> =
wrote:
>>=20
>> Hello,
>> Recently I've been playing around with the imx23-olinuxino
>> (mx23_olinuxino_defconfig) and booting NetBSD using u-boot. During =
that, I've
>> noticed that NetBSD panics because u-boot places the device tree in =
the BSS
>> section of NetBSD. NetBSD clears the BSS section and then complains
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
> Do you have a value for fdt_high before you set it to that?
>=20
> See boot_relocate_fdt() for the logic.

No, fdt_high doesn=E2=80=99t have a default. I found fdt_high by =
backtracking the code in question to find a way to get it off the path =
where it automatically chooses a memory location just behind the kernel =
image.

I=E2=80=99m mainly wondering about why we have the relocation logic =
active in this scenario. We already have the fdt in memory from when it =
is loaded from disk. We have to provide a manual address for this, so we =
can choose it so that it doesn=E2=80=99t overlap. As soon as we bootm, =
u-boot relocates it to an address that conflicts, while the original =
address would have been fine, so I=E2=80=99m wondering about the reasons =
for the relocation.

>=20
> Regards,
> Simon

Thank you,
Yuri

