Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA6CE92714
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 15:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F58E83C8C;
	Sat, 27 Dec 2025 16:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RUl4SkoN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F7A83C91; Sat, 27 Dec 2025 16:45:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C2B283C6C
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 16:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766850337; x=1767455137; i=xypron.glpk@gmx.de;
 bh=M6YvchkZCjrUUIHJke+yHJ5zu9QoEVNZtMp+pccrN/c=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=RUl4SkoN6uhhJsU1gZILzht30fQYNcOR/RHjHl1/o/s7N6BBquJ0iz5Bh43BfAty
 6Dxgg5n4X3I1CcYIPg0zGXYmOUBXzg0OyXtSFs6/xc8Irh/oKFSk3Dye+jwS6KXIW
 jeOTObPeuUT+ij+MC350fwU2vzHEkEUhStwA6Je4b+mx01zVNGK3JI/W27ZUT3nxP
 bW9+5rJniUJ0rGHNgef5VWIvkFtq+67jTeyvcTNQ7t8F56yBYV07hFBCJh6iJ8mF0
 Xdm7ef+FiQPt8B/XOr00USqjLyAEh6JvsPqEWDQAlYhxrSaZVEoSQUQslJ26fCkqW
 VEQD9NCSv4w6i9EEaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([46.114.1.197]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU4s-1w7TnA3o3Q-00hHXh; Sat, 27
 Dec 2025 16:45:37 +0100
Date: Sat, 27 Dec 2025 16:45:31 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Manjae Cho <manjae.cho@samsung.com>
CC: u-boot@lists.denx.de, sujin.u@mobis.com
Subject: Re: [PATCH] Fix typo "addtional" -> "additional" in pflash section.
User-Agent: Thunderbird for Android
In-Reply-To: <20251227150816.GL710860@bill-the-cat>
References: <CGME20251227142137epcas1p4115a7a2e7519bbddc095c9d3baf760f4@epcas1p4.samsung.com>
 <20251227142036.10661-1-manjae.cho@samsung.com>
 <20251227150816.GL710860@bill-the-cat>
Message-ID: <4BF10B06-DB49-4E63-9FBB-D02882E43549@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pAnVoP0lscfr3Dqc2xmClvXme/aP61tPVqsnYxfv13ndmETGGTy
 d2D1fmAtOj9I3cYt0RlAU7swoirzji4UCvqqDHAPMqgNT2yXPjQ4cBR7VhjCH9Y8cJMcJSA
 0ltujsPA68RH7+GaoOqCVSNN3Uck3mxaox3BEgpZXUV+LQ7/yFxKwIils0QoZIDMce8yXJ8
 fbaJbdBTW37PJ2Y5Vq0Lg==
UI-OutboundReport: notjunk:1;M01:P0:0wx0FoTifsU=;zt0m4aCMKmeNyGf+ef/Wf0DILyN
 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
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

Am 27=2E Dezember 2025 16:08:16 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>=
:
>On Sat, Dec 27, 2025 at 11:20:36PM +0900, Manjae Cho wrote:
>
>> Also add network testing example using virtio-net device, which
>> should be helpful for users wanting to test U-Boot networking=2E
>>=20
>> Signed-off-by: Manjae Cho <manjae=2Echo@samsung=2Ecom>
>> ---
>>  doc/board/emulation/qemu-riscv=2Erst | 25 ++++++++++++++++++++++++-
>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/doc/board/emulation/qemu-riscv=2Erst b/doc/board/emulation=
/qemu-riscv=2Erst
>> index b5948d9affc=2E=2E25fe7beb43f 100644
>> --- a/doc/board/emulation/qemu-riscv=2Erst
>> +++ b/doc/board/emulation/qemu-riscv=2Erst
>> @@ -43,7 +43,7 @@ qemu-riscv64_smode_defconfig instead=2E Note that U-B=
oot running in supervisor
>>  mode requires a supervisor binary interface (SBI), such as RISC-V Open=
SBI=2E
>> =20
>>  To create a U-Boot binary that can be utilized with a pflash device in=
 QEMU
>> -apply these addtional settings to qemu-riscv64_smode_defconfig:
>> +apply these additional settings to qemu-riscv64_smode_defconfig:
>> =20
>>  ::
>> =20
>> @@ -205,6 +205,29 @@ Invoke QEMU with:
>>      qemu-system-riscv64 -M virt -nographic \
>>      -drive if=3Dpflash,format=3Draw,unit=3D0,file=3Du-boot=2Ebin,reado=
nly=3Doff
>> =20
>> +Testing with Network
>> +--------------------
>> +
>> +The QEMU virt machine supports VirtIO network devices, which can be us=
eful for
>> +testing network functionality in U-Boot=2E To add a network device, us=
e the
>> +following QEMU parameters:
>> +
>> +=2E=2E code-block:: bash
>> +
>> +    qemu-system-riscv64 -nographic -machine virt -bios u-boot=2Ebin \
>> +    -m 256M -netdev user,id=3Dnet0 -device virtio-net-device,netdev=3D=
net0
>> +
>> +This will create a VirtIO network device (eth0) that U-Boot can detect=
 and use=2E
>> +You can verify the network device is recognized by checking the boot o=
utput for::
>> +
>> +    Net:   eth0: virtio-net#0
>> +
>> +From the U-Boot prompt, you can test network functionality with::
>> +
>> +    =3D> net list
>> +    =3D> dhcp
>> +    =3D> ping 10=2E0=2E2=2E2
>> +
>>  Debug UART
>>  ----------
>> =20
>
>This is a case where it's appropriate to do 2 patches=2E If Heinrich pick=
s
>it up as 1, that's fine too, but it is two distinct changes=2E
>

Thank you Manjahe for addressing both the networking description as well a=
s the typo=2E

The added information does not look RISC-V specific=2E We already have doc=
/board/emulation/blkdev=2Erst=2E I would suggest to add a similar file for =
networking=2E

There are different noteworthy network devices in emulation (e1000, virtio=
-net-pci, =2E=2E=2E)=2E You can have user network or use tap/tan=2E You may=
 want to set the mac address=2E Tftp and DHCP provided by QEMU are of inter=
est=2E So quite a bunch of information that we can add over time=2E

Best regards

Heinrich


