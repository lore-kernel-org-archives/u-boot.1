Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57FBC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AF5E86FC9;
	Sat,  4 Nov 2023 21:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="d4e63YuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1932086FF4; Sat,  4 Nov 2023 21:56:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E67386FC3
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699131392; x=1699736192; i=xypron.glpk@gmx.de;
 bh=uq1wr5cKEohw63UEosTGmsr17sU8Dej4bHOOZB4p1QQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=d4e63YuD1FmbU9kxjB2LGszYmR3gg6H5mUc+1oVacJmy/uCMQJ+JV+0RLiJP9MXX
 mtfgqzjoj84ZCiD1KDgX03z3AYTtuvuCtHyAwSAGVid4qACXOOQJfvXDCDCFOt8JQ
 FwE6KYERampQQr5rILKtB1xJGDoA7dQKMiy7cnz2nn7GqJYWJab/LbOw8WwTm6QGI
 UvKk+EsFyhsb6LzhHpX2gEuXpaqOtvEDbjmrlz7lqfmGzfJaQ2bVZhMVv3tk2vWWg
 3ya6Kyi8mnqV9AKyOXMJyR1ntjHccDG768AAJJIiwSeE6g6jgYfcRB5iakl+QAfvi
 Ayf3DWyWLZarevfKrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([159.148.28.2]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIwzA-1qjUQv3D90-00KOtq; Sat, 04
 Nov 2023 21:56:31 +0100
Date: Sat, 04 Nov 2023 22:56:30 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, Hongxing Zhu <hongxing.zhu@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?US-ASCII?Q?Re=3A_uboot_reports_adding_disk_failed=28EFI=5FNOT=5FF?=
 =?US-ASCII?Q?OUND=29_and_first_disk_is_gone_in_next_scsi_scan?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ1r60UomKz5DkH-POvsj0jKq1rNENniwZpAn3AWHk94EA@mail.gmail.com>
References: <AS8PR04MB86760A4BC079AF5BD57C81B98CA7A@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB867669CC8B5EB411BDEF45348CA5A@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAPnjgZ1r60UomKz5DkH-POvsj0jKq1rNENniwZpAn3AWHk94EA@mail.gmail.com>
Message-ID: <2F0F7B2D-8DDF-439C-9889-8FA0B21CF36C@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:suv2TexNz04fdU/U6TT0n/Eb0v6IBCMTzHvBQYDTHjTSmZ24KvY
 57HCoMMmms+oR0doz1gdAxiKxI6VIXTbxwcIAJnmrJaIGoKNkNVEgEsRzxZ3kX0Q4F6UANM
 pyJcMatXT90J0pxMlp3pdIBb6qAOFDY6r1OCI18idu6Qk8fPXuOByJyNqHRvP+thhJG9rKN
 LLsHzR+8YTuJNbGLRmWyQ==
UI-OutboundReport: notjunk:1;M01:P0:RfzjVW1lfRs=;U0xoiFxYXkrhN8UCODB8P7lqYYq
 l/AHHEHIttARtQ8Dx0UhwHTNPQZ6YcVNZ+8CmfTu9ac/fqNDhILiC5ESOdt4pxpefmuiK7NFt
 Qb0EMn4qoa8kz6T3mex5vzMV+sqAeS5ytlb9OLqB3hwu6c8dXF1MSdGkyGnaQgqaD78pO6ccH
 Q1lTlQ+14L2L9yCAEttDO+O+yLfvvWXo622wCnh2DSj3citc0VyDrVrpJWKs5qPkIgKhtCxTo
 PihMr+Eiz40NP8aXt1owXYYmprG/c/yyDY0mUHCi8yuEEC6OKNbsaUWZDgfrrzTrlRkXRi9cl
 +KmFDMqTYK32hmK0wgUKhyFec1yxkuCNMhRL9Hnmt5jWc+vIezC+a6VU7ZnEJJnsh853/hiF2
 /tmM2OTYo56UtGworqQfblaXAJFaxrJrtRBz3V8o6XIw9dLDYuBL0Ml8qO7wvAEOyHCT6dr+y
 zUsXRBNFT6hsHbDZI+kO2HQ/txhuZQWQPlSCS0iO/GG1rhuW8Khy04iAuzr9AxJSbvPBBq7KX
 U9B419flYOncWfPNZw7n6aHZdgwxpklhPaUWoMwA49ebt95VosgenzbCMmajJYOnIS9Qf5Viu
 61Ro3KxGSaE2hXoKcRhBpFC5T2nodEMImTNRQLs0zrMDkiOFSm+cn/alc1NQxbFBsNyDa0vtH
 r/V5C5Txk4TkaYN1XN4LtF0l3TocBG36i4VLjWwZV7MUaemrvpBl+bTuQ7xIDTZ8DIrcEwvqq
 d8hE20r4yTndi5DkqXystJkdmMlTfMN8g/fDZCGXbjXwUPV+CoTZ78Nl+W1IBcZaSEaM2TxzH
 CdwBe/0T6Nzay2uYYlVZvm0qKa5tYqmjk0s3zD9e6SbXfNy+dY5QjBvHCZm4JcaP+ijdGLFWV
 j5XTEpz4V096/Z7hqESmqJWEdowEtcz5gr6lWa4OaiJ2KPgmiSYqtH3F30ZCn5H6xklIvYU/k
 3qlIiHIvMsepf+yEXWu6xEGyuVI=
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



Am 4=2E November 2023 21:43:52 OEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>Hi Richard,
>
>+Heinrich as I think this is an EFI bug=2E
>
>On Thu, 2 Nov 2023 at 19:37, Hongxing Zhu <hongxing=2Ezhu@nxp=2Ecom> wrot=
e:
>>
>> Hi Simon:
>> I found that the EFI complained that the disk install path is not updat=
ed for the second disk=2E
>> The install path is =E2=80=9CEFI: installed device path '/VenHw(e61d73b=
9-a384-4acc-aeab-82e828f3628b)/Scsi(0,0)'=E2=80=9D
>>
>> when first disk is added=2E

This should be fixed this in U-Boot v2023=2E10=2E

https://github=2Ecom/trini/u-boot/commit/e07368ea57d224557570a6715dcffdbc8=
83a8079

Best regards

Heinrich

>>
>> But the path is same when the second or later disks are added, and EFI =
repors that the path had been installed already=2E
>> EFI: Path /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b)/Scsi(0,0) alread=
y installed
>>
>>
>>
>> That=E2=80=99s why the below error when run efi_disk_create_raw() funct=
ion=2E
>>
>> Adding disk for ahci_scsi=2Eid0lun0 failed (err=3D-9223372036854775788/=
0x8000000000000014)
>>
>>
>>
>> Do you have any clues about this?
>>
>> Thanks in advanced=2E
>>
>> Best Regards
>>
>> Richard Zhu
>>
>>
>>
>> From: Hongxing Zhu
>> Sent: 2023=E5=B9=B411=E6=9C=881=E6=97=A5 10:57
>> To: sjg@chromium=2Eorg
>> Cc: u-boot@lists=2Edenx=2Ede
>> Subject: uboot reports adding disk failed(EFI_NOT_FOUND) and first disk=
 is gone in next scsi scan
>>
>>
>>
>> Hi Simon:
>> Nice to meet you=2E
>> The u-boot I used is based on v2023=2E04 tagged version=2E
>> Layerscape LX2160A RDB board has four SATA controllers=2E
>> Based on LX2160A RDB board and two or more SATA disks connected=2E
>> I encounter one =E2=80=9Cscsi scan=E2=80=9D problem=2E
>>
>>
>> After the first SATA disk is detected and probed properly in the first =
=E2=80=9Cscsi scan=E2=80=9D=2E
>> The other disks would complain that =E2=80=9CEFI_NOT_FOUND=E2=80=9D err=
or listed below,
>> when run the first =E2=80=9Cscsi scan=E2=80=9D command in uboot environ=
ment=2E
>>
>> Does this error matter?
>> BTW, =E2=80=9Cscsi info=E2=80=9D says that all disk info can be dumped,=
 and all disks are works well,
>>
>> after the first =E2=80=9Cscsi scan=E2=80=9D
>>
>> In the consecutive rescan operations issued by =E2=80=9Cscsi reset=E2=
=80=9D or =E2=80=9Cscsi scan=E2=80=9D commends,
>> the disks would report =E2=80=9Cunable to unbind devices (-1E)=E2=80=9D=
 error=2E
>> The first disk is disappeared at all after the next =E2=80=9Cscsi scan=
=E2=80=9D operations is finished=2E
>>
>>
>> Did you used to encounter such kind of issue?
>>
>> Any suggestions and guidance are very appreciated=2E
>>
>> Logs:
>> =3D> scsi scan
>>
>> scanning bus for devices=2E=2E=2E
>>
>> Target spinup took 0 ms=2E
>>
>> AHCI 0001=2E0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
>>
>> flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
>>
>>   Device 0: (0:0) Vendor: ATA Prod=2E: ST1000DM010-2EP1 Rev: CC43
>>
>>             Type: Hard Disk
>>
>>             Capacity: 953869=2E7 MB =3D 931=2E5 GB (1953525168 x 512)
>>
>> Target spinup took 0 ms=2E
>>
>> AHCI 0001=2E0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
>>
>> flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
>>
>> Adding disk for ahci_scsi=2Eid0lun0 failed (err=3D-9223372036854775788/=
0x8000000000000014)
>>
>> SATA link 0 timeout=2E
>>
>> AHCI 0001=2E0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
>>
>> flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
>>
>> SATA link 0 timeout=2E
>>
>> AHCI 0001=2E0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
>>
>> flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
>> =3D> scsi info
>>
>> Device 0: (0:0) Vendor: ATA Prod=2E: ST1000DM010-2EP1 Rev: CC43
>>
>>             Type: Hard Disk
>>
>>             Capacity: 953869=2E7 MB =3D 931=2E5 GB (1953525168 x 512)
>>
>> Device 1: (0:0) Vendor: ATA Prod=2E: ST500DM002-1BD14 Rev: KC45
>>
>>             Type: Hard Disk
>>
>>             Capacity: 476940=2E0 MB =3D 465=2E7 GB (976773168 x 512)
>>
>> =3D> ls scsi 0:1
>>
>> <DIR>       4096 =2E
>>
>> <DIR>       4096 =2E=2E
>>
>> <DIR>      16384 lost+found
>>
>> <snip>
>>
>> <DIR>       4096 var
>>
>> <SYM>         12 linuxrc
>>
>> =3D> ls scsi 1:1
>>
>> <DIR>       4096 =2E
>>
>> <DIR>       4096 =2E=2E
>>
>> <DIR>      16384 lost+found
>>
>> <snip>
>>
>> <DIR>       4096 usr
>>
>> <DIR>       4096 var
>>
>>
>>
>> =3D> scsi reset
>>
>>
>>
>> Reset SCSI
>>
>> scanning bus for devices=2E=2E=2E
>>
>> unable to unbind devices (-1E)
>> =3D> ls scsi 0:1
>>
>> ** Bad device specification scsi 0 **
>>
>> Couldn't find partition scsi 0:1
>>
>> =3D> ls scsi 1:1
>>
>> <DIR>       4096 =2E
>>
>> <DIR>       4096 =2E=2E
>>
>> <DIR>      16384 lost+found
>>
>> <snip>
>>
>> <DIR>       4096 var
>>
>>
>> =3D> scsi info
>>
>> Device 1: (0:0) Vendor: ATA Prod=2E: ST500DM002-1BD14 Rev: KC45
>>
>>             Type: Hard Disk
>>
>>             Capacity: 476940=2E0 MB =3D 465=2E7 GB (976773168 x 512)
>>
>>
>>
>> Best Regards
>>
>> Richard Zhu
>>
>>
>
>Regards,
>Simon
