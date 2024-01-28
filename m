Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB388C47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 08:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED2EB88120;
	Sun, 28 Jan 2024 09:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="omJvJcux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FDEC88121; Sun, 28 Jan 2024 09:51:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E36B38803F
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 09:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706431893; x=1707036693; i=xypron.glpk@gmx.de;
 bh=19IjJG0POn8CP/ZSV1/bokw2/kNxY3uQnUztI13aP60=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
 In-Reply-To;
 b=omJvJcuxqHae1MSydP9rcIMbrUw6FhDohy55smHzGRMwlCTb4ukifggsNVlfVJqa
 EDIPkqj/7Q0An0SC0f837wJJnLDZx4GiB9BvaznJL1sctq1zgXOu8S7sUhftsA4jc
 UEhBtqnwf7GdjFLsktyrbp6KebR7b75+xGGjw2j157MGldt5nd0em/2iFsk5+QRFb
 BYV3KkAViG8HlszNbQNE+iS1bSPKP0MN7blbpPSjxNLZul1PtQ+aMP0jJB2brlmc8
 xHgiuRZZKtZbGezfyxHEM3Sxaq4Rx3ZZV1R8wymkmKlovOhc3J9uby4/UhIhvoNHO
 ItcyS4Tht8IWrjZCkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTqW-1rWqah1pFG-00WYoT; Sun, 28
 Jan 2024 09:51:33 +0100
Message-ID: <eb078cd8-a041-4b35-b3f3-def5e1919477@gmx.de>
Date: Sun, 28 Jan 2024 09:51:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20240127154018.GC785631@bill-the-cat>
 <70BB005F-709B-4B50-AFDB-85EAD7BFC5E8@gmx.de>
In-Reply-To: <70BB005F-709B-4B50-AFDB-85EAD7BFC5E8@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7msbH6L5NqnvfQ4o2JOFU2E/3nliRzukKCFnzVHHtxYI14JfcVH
 ADD3AcabZLORZ6l7yGflKpUBM1mRWhb7rL/JVXzZow/wacgD8i0TGp7BAMnD39o2vJGDO/Q
 h8ed7KeD+JS1hOVJJb4EJGQ8+1YCebvWPRKzphBomtslNmHbYSHhSStwMlffuZhiYQjewK7
 sxCqFU2zctpJvHhyW+/sw==
UI-OutboundReport: notjunk:1;M01:P0:V+bOuYsTb4M=;gT9Q2fjoF/B9H7H3Mgp0v25qHzJ
 f0a0ts3DW1SgVP/4lEKVRDmHTd2H4rTzSvajvdW+SfLAXbAgDIH5ya6k9+irUVQDA3ichCacX
 qbWJoYcubzAANC2gHI2spdGzShm1jCCOT4q1QERICXzWuIyO1H+aa9oLC5Tljb1ENfh5hU1Px
 ElVT3UXg5RYaNZQg5U9kYkJe7bbsMFBLEuDRVYCnj89C2pBWniHaZ1FCvOp1meU+vjoHkKD76
 cj0RjwI12nxb5RrM8NcHqOOQmHuLCKUkLKOIFYtL1UFnEk+IFnOBRplTpWXohQ/sfwSfmI6dm
 5JJfgJP5uLQffBN5tn/a2BvVXwaIYn0TaPCD/jDrmaELm6gcKDcCXO5pVPr7y3YhjSxVNvdLt
 3cJ72rX9eML+xStyb+RPmTkYIrBANcrQbGrilvYNQME9pbXTNmxuX/8nAQh7zmCxc4PILmr+8
 JDJF8UrgD8TOdVQ5QnW9vKbM+t4maVcJAtqXmqLOhy579loXcKI/vTIkfTZNJG8hxMKOCcL8u
 A5s5LWPiAnjenCqKeTkkzFQL4AKHEnZJr9smH73jJm6ugi3uHE4s497jtqQg09lhBJudzf1X4
 wE9F6UauGOQnoKtQNh++5CIMmdsHBr1FvWv2llQZS+5qCkOUrjzNjTUP92uuk5niaxMpI3xez
 cRGCbtsRz+zosglGqs9HsLOzheH6uk27M2zlPQyZo3kBn51Kpugqgrdh9DxfzGxJzDY2do0kw
 plgmSd2r8+eHhNrH2GXbmux4MPMGdrf9OA9oXWqTvB1CxCkEWEIAsTg/jX4tR5rAcXffq397D
 2xSUCSCtF2sJh+025bPwc/JIP+fHcE1elUOrTRRQ2S7+uB8p2+j0sr4fgIQRg/AJ0I97N593w
 nCyVD/hedYFLYNZkTUvX8/ybPojF8uiYFxutnKL6JUlriPc3tOyXmAmCFNzg2Qpktx0BZfXKw
 REKXK6aZHP66I6o2iQ6+Hyn6Org=
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

On 1/27/24 21:56, Heinrich Schuchardt wrote:
>
>
> Am 27. Januar 2024 16:40:18 MEZ schrieb Tom Rini <trini@konsulko.com>:
>> Hey, I'll just pass this on directly rather than to the list.
>>
>> ---------- Forwarded message ---------
>> From: <scan-admin@coverity.com>
>> Date: Sat, Jan 27, 2024 at 10:36=E2=80=AFAM
>> Subject: New Defects reported by Coverity Scan for Das U-Boot
>> To: <tom.rini@gmail.com>
>>
>>
>> Hi,
>>
>> Please find the latest report on new defect(s) introduced to Das
>> U-Boot found with Coverity Scan.
>>
>> 1 new defect(s) introduced to Das U-Boot found with Coverity Scan.
>>
>>
>> New defect(s) Reported-by: Coverity Scan
>> Showing 1 of 1 defect(s)
>>
>>
>> ** CID 479279:    (TAINTED_SCALAR)
>>
>>
>> _______________________________________________________________________=
_________________________________
>> *** CID 479279:    (TAINTED_SCALAR)
>> /cmd/smbios.c: 180 in do_smbios()
>> 174                             smbios_print_type2((struct smbios_type2=
 *)pos);
>> 175                             break;
>> 176                     case 127:
>> 177                             smbios_print_type127((struct
>> smbios_type127 *)pos);
>> 178                             break;
>> 179                     default:
>>>>>      CID 479279:    (TAINTED_SCALAR)
>>>>>      Passing tainted expression "pos->length" to "smbios_print_gener=
ic", which uses it as a loop boundary.
>> 180                             smbios_print_generic(pos);
>> 181                             break;
>> 182                     }
>> 183             }
>> 184
>> 185             return CMD_RET_SUCCESS;
>> /cmd/smbios.c: 154 in do_smbios()
>> 148                     size =3D entry2->length;
>> 149                     max_struct_size =3D entry2->max_struct_size;
>> 150             } else {
>> 151                     log_err("Unknown SMBIOS anchor format\n");
>> 152                     return CMD_RET_FAILURE;
>> 153             }
>>>>>      CID 479279:    (TAINTED_SCALAR)
>>>>>      Passing tainted expression "size" to "table_compute_checksum", =
which uses it as a loop boundary.
>> 154             if (table_compute_checksum(entry, size)) {
>> 155                     log_err("Invalid anchor checksum\n");
>> 156                     return CMD_RET_FAILURE;
>> 157             }
>> 158             printf("SMBIOS %s present.\n", version);
>> 159
>> /cmd/smbios.c: 174 in do_smbios()
>> 168                            (unsigned long long)map_to_sysmem(pos));
>> 169                     switch (pos->type) {
>> 170                     case 1:
>> 171                             smbios_print_type1((struct smbios_type1=
 *)pos);
>> 172                             break;
>> 173                     case 2:
>>>>>      CID 479279:    (TAINTED_SCALAR)
>>>>>      Passing tainted expression "((struct smbios_type2 *)pos)->numbe=
r_contained_objects" to "smbios_print_type2", which uses it as a loop boun=
dary.
>> 174                             smbios_print_type2((struct smbios_type2=
 *)pos);
>> 175                             break;
>> 176                     case 127:
>> 177                             smbios_print_type127((struct
>> smbios_type127 *)pos);
>> 178                             break;
>> 179                     default:
>> /cmd/smbios.c: 154 in do_smbios()
>> 148                     size =3D entry2->length;
>> 149                     max_struct_size =3D entry2->max_struct_size;
>> 150             } else {
>> 151                     log_err("Unknown SMBIOS anchor format\n");
>> 152                     return CMD_RET_FAILURE;
>> 153             }
>>>>>      CID 479279:    (TAINTED_SCALAR)
>>>>>      Passing tainted expression "size" to "table_compute_checksum", =
which uses it as a loop boundary.
>> 154             if (table_compute_checksum(entry, size)) {
>> 155                     log_err("Invalid anchor checksum\n");
>> 156                     return CMD_RET_FAILURE;
>> 157             }
>> 158             printf("SMBIOS %s present.\n", version);
>> 159
>> /cmd/smbios.c: 180 in do_smbios()
>> 174                             smbios_print_type2((struct smbios_type2=
 *)pos);
>> 175                             break;
>> 176                     case 127:
>> 177                             smbios_print_type127((struct
>> smbios_type127 *)pos);
>> 178                             break;
>> 179                     default:
>>>>>      CID 479279:    (TAINTED_SCALAR)
>>>>>      Passing tainted expression "pos->length" to "smbios_print_gener=
ic", which uses it as a loop boundary.
>> 180                             smbios_print_generic(pos);
>> 181                             break;
>> 182                     }
>> 183             }
>> 184
>> 185             return CMD_RET_SUCCESS;
>> /cmd/smbios.c: 174 in do_smbios()
>> 168                            (unsigned long long)map_to_sysmem(pos));
>> 169                     switch (pos->type) {
>> 170                     case 1:
>> 171                             smbios_print_type1((struct smbios_type1=
 *)pos);
>> 172                             break;
>> 173                     case 2:
>>>>>      CID 479279:    (TAINTED_SCALAR)
>>>>>      Passing tainted expression "((struct smbios_type2 *)pos)->numbe=
r_contained_objects" to "smbios_print_type2", which uses it as a loop boun=
dary.
>> 174                             smbios_print_type2((struct smbios_type2=
 *)pos);
>> 175                             break;
>> 176                     case 127:
>> 177                             smbios_print_type127((struct
>> smbios_type127 *)pos);
>> 178                             break;
>> 179                     default:
>> /cmd/smbios.c: 174 in do_smbios()
>> 168                            (unsigned long long)map_to_sysmem(pos));
>> 169                     switch (pos->type) {
>> 170                     case 1:
>> 171                             smbios_print_type1((struct smbios_type1=
 *)pos);
>> 172                             break;
>> 173                     case 2:
>>>>>      CID 479279:    (TAINTED_SCALAR)
>>>>>      Passing tainted expression "((struct smbios_type2 *)pos)->numbe=
r_contained_objects" to "smbios_print_type2", which uses it as a loop boun=
dary.
>> 174                             smbios_print_type2((struct smbios_type2=
 *)pos);
>> 175                             break;
>> 176                     case 127:
>> 177                             smbios_print_type127((struct
>> smbios_type127 *)pos);
>> 178                             break;
>> 179                     default:
>> /cmd/smbios.c: 180 in do_smbios()
>> 174                             smbios_print_type2((struct smbios_type2=
 *)pos);
>> 175                             break;
>> 176                     case 127:
>> 177                             smbios_print_type127((struct
>> smbios_type127 *)pos);
>> 178                             break;
>> 179                     default:
>>>>>      CID 479279:    (TAINTED_SCALAR)
>>>>>      Passing tainted expression "pos->length" to "smbios_print_gener=
ic", which uses it as a loop boundary.
>> 180                             smbios_print_generic(pos);
>> 181                             break;
>> 182                     }
>> 183             }
>> 184
>> 185             return CMD_RET_SUCCESS;
>> /cmd/smbios.c: 180 in do_smbios()
>> 174                             smbios_print_type2((struct smbios_type2=
 *)pos);
>> 175                             break;
>> 176                     case 127:
>> 177                             smbios_print_type127((struct
>> smbios_type127 *)pos);
>> 178                             break;
>> 179                     default:
>>>>>      CID 479279:    (TAINTED_SCALAR)
>>>>>      Passing tainted expression "pos->length" to "smbios_print_gener=
ic", which uses it as a loop boundary.
>> 180                             smbios_print_generic(pos);
>> 181                             break;
>> 182                     }
>> 183             }
>> 184
>> 185             return CMD_RET_SUCCESS;
>> /cmd/smbios.c: 174 in do_smbios()
>> 168                            (unsigned long long)map_to_sysmem(pos));
>> 169                     switch (pos->type) {
>> 170                     case 1:
>> 171                             smbios_print_type1((struct smbios_type1=
 *)pos);
>> 172                             break;
>> 173                     case 2:
>>>>>      CID 479279:    (TAINTED_SCALAR)
>>>>>      Passing tainted expression "((struct smbios_type2 *)pos)->numbe=
r_contained_objects" to "smbios_print_type2", which uses it as a loop boun=
dary.
>> 174                             smbios_print_type2((struct smbios_type2=
 *)pos);
>> 175                             break;
>> 176                     case 127:
>> 177                             smbios_print_type127((struct
>> smbios_type127 *)pos);
>> 178                             break;
>> 179                     default:
>> /cmd/smbios.c: 180 in do_smbios()
>> 174                             smbios_print_type2((struct smbios_type2=
 *)pos);
>> 175                             break;
>> 176                     case 127:
>> 177                             smbios_print_type127((struct
>> smbios_type127 *)pos);
>> 178                             break;
>> 179                     default:
>>>>>      CID 479279:    (TAINTED_SCALAR)
>>>>>      Passing tainted expression "pos->length" to "smbios_print_gener=
ic", which uses it as a loop boundary.
>> 180                             smbios_print_generic(pos);
>> 181                             break;
>> 182                     }
>> 183             }
>> 184
>> 185             return CMD_RET_SUCCESS;
>> /cmd/smbios.c: 174 in do_smbios()
>> 168                            (unsigned long long)map_to_sysmem(pos));
>> 169                     switch (pos->type) {
>> 170                     case 1:
>> 171                             smbios_print_type1((struct smbios_type1=
 *)pos);
>> 172                             break;
>> 173                     case 2:
>>>>>      CID 479279:    (TAINTED_SCALAR)
>>>>>      Passing tainted expression "((struct smbios_type2 *)pos)->numbe=
r_contained_objects" to "smbios_print_type2", which uses it as a loop boun=
dary.
>> 174                             smbios_print_type2((struct smbios_type2=
 *)pos);
>> 175                             break;
>> 176                     case 127:
>> 177                             smbios_print_type127((struct
>> smbios_type127 *)pos);
>> 178                             break;
>> 179                     default:
>>
>
> The values may come from QEMU, so may be "tainted". We could check the l=
ength of the individual structures against the total size of the SMBIOS ta=
ble.
>

In Coverity I marked this as false positive with the following comment:

"The only case in which the data is tainted is when copying the smbios
table from a prior firmware state when running as EFI app or from QEMU.
Sanity checks should not be in the smbios command but where we import
the table."

Best regards

Heinrich

