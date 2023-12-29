Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9F0C46CD3
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 11:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB5687B03;
	Fri, 29 Dec 2023 12:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="p3GVhe4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C407587B03; Fri, 29 Dec 2023 12:09:14 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 954928715A
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 12:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703848151; x=1704452951; i=xypron.glpk@gmx.de;
 bh=F5H7LxCAv1raN8fGhiXwE1hFVULZIQJyEn/DMTcdebo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=p3GVhe4uVefeQGXMVMP+XrkRIyBHDGHe3RkFYw3zkcf4bgMmvBiVQMPa9BLMUWuj
 TOTRxo+PqOuee9G7++KeOhSxC44bSDWmOWsPQ9jBQ8xcHOy0plM4Pc6gvcZsVc7Ks
 u2CgbYdB2eBxpn05DkpJ/+qx/IcS1qH+rLImWAjb6I3ynNSAtM8czKJYmiRFsdJoy
 881Ckw9zo3a4Dw2Z3d8HJ+Mq7J7Iseso1vdRqjRB1v+RBjpCPZi6PBTyFjpMWaqhE
 FRjZIpo8avDTTVZRcbPvrsDBUcWs1LQpi/P0+Vf6ckTWCYpVIjqxZdrZH82TOKFSe
 IHzk9SkNZF8RKFgIPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.176] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw3N-1qsKVo2ifL-00j2nL; Fri, 29
 Dec 2023 12:09:11 +0100
Message-ID: <08e7b3cc-9588-46ab-844e-6edbe1154e43@gmx.de>
Date: Fri, 29 Dec 2023 12:09:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI: usage of sandbox virtual addresses
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <9f681497-d13c-4ccc-9209-7a8b33e3195c@gmx.de>
 <CAFLszThsThxhWCgP+UHmA5BxRUUBfDP7SDahtAm5WOrHoT0xhQ@mail.gmail.com>
 <e9a835ea-ea99-4db2-b5ad-ba7742397d46@gmx.de>
 <CAFLszTg17_xPGWMDG=1X+q2UTdJ_kO2pUshmDLt+cv9uPPcgJg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTg17_xPGWMDG=1X+q2UTdJ_kO2pUshmDLt+cv9uPPcgJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6KPm5PweQi9BRrnF8trGvO4LfprnNhHHjqZ0K0oaN4SCComzJ+K
 +Ovx3+CiadeTCBqZsMr9n6odExW9UpWDHrskku/9E4oTN/RmrT6P8Eoxe4AavrQa8Uy5Y4O
 nFMXiLyHKn4BfhWnSflm5s0rXw6hb1PjNZ5sPooGkOQSU1QXz5pB0aaKDo7kvlnjwiNGeul
 hpZtfWk+sM5bzkEECcZVw==
UI-OutboundReport: notjunk:1;M01:P0:atel53f0/Iw=;HSIGci8xaDhHGng1nBShbHpMLjf
 KyZf5oMGX2wQ3XNxWs9V5VxE8TLeAcTcUVNFvPZW3SH5ISA/VbP5D4n8n/sBmRq4DrxhghEJR
 DLmD/HeLAWzHUlpAod7oAx0oq+Lc+C0+ARAyrcl7h3RPS8M3Pa9fBiJxZ7b98Y0/c+DWnqelq
 bb8O21eezgHkhIprHvrped3tMIIWgcsPbrp7r//3LZjCX4G5oDIdw9hmAW3+2vHqzTSBEoURO
 ZZTS93rBYs4cJvBk9fqIwVmIMbhUmVulKNkucI4TTLJgo2dPLxmqHqKqQPy5cHwnWVno0axwr
 3RBE1sSxO2Iu/AHg+i6soEjRLosOh412whP87pivJzS6yT9q8ucrA5xx9IwEWxihtW1FE5iwV
 CU6wn0PMZ0vPW9JJkYYo3MBfKDgM0iGEWIoJ49Z7oqExA0jGniTdgir996t9Nujgnih1VB9Cv
 6pigSdBq+Vr/84WHkXDFgL52NbqCHAI6Ow38Q9UPurrlkY2dCmOSykijM2ORyp0dnbwbEMwHL
 FFKJ5nOiAYxKTk4ND0ELO702UCG1/d+HNtOfaJXeX6vUDuuR7WtFGzagjkhuKGtqT+NG9zjhw
 jYlo5L2LTxNAX9BoFtxesiGA1tiQjSmHb4axdiJKujemnwxYzj5fyoP7wUut3OYIVYZrY7BNP
 PdOsilne5Pkt0Azb40bWOswdCc+JYM5uDUr7NKK6ZhSkxosjmGCyXxGR/FLz6ZIEIilppNrEs
 azbhnxJCfJ38J7Aivbb63vDTDkRGbjxqlHmNDOcnzthYoHfW1QGRK14tpx4EVf2GZANteh+M4
 e/9EzG0rPV0xgBWYoLfFsHbb1h7zosLEg0xpS81u80s1FLmzR9MYDN/AABklXiCqpTMtk1YN1
 G6YuzisXLFSa6+E0RdJ/C9q2FAefE+0ZYcbRRgjzcwpfjoxseBGV2skW6/tN1Up0Qi1rfIcGQ
 8lwBQw==
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

On 12/29/23 09:26, Simon Glass wrote:
> Hi Heinrich,
>
> On Tue, Dec 26, 2023 at 10:03=E2=80=AFAM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
>>
>> On 12/26/23 10:50, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Tue, Dec 26, 2023 at 8:56=E2=80=AFAM Heinrich Schuchardt <xypron.gl=
pk@gmx.de> wrote:
>>>>
>>>> Hello Simon,
>>>>
>>>> currently we use sandbox virtual addresses in all ACPI tables. This
>>>> means that an application started by the U-Boot sandbox consuming the=
se
>>>> tables will crash due to accessing invalid addresses.
>>>>
>>>> Shouldn't the ACPI tables be migrated to use valid pointers?
>>>
>>> The confusion arises due to the difference between addresses and
>>> pointers. If we store addresses in the ACPI tables, then things should
>>> work.
>>>
>>> My approach has been to avoid using casts, but instead use
>>> map_sysmem() and mem_to_sysmem().
>>>
>>> Which particular piece of code is wrong in this case?
>>
>> Tables DSDT, XSDT, RSDP, FADT in the sandbox contain sandbox virtual
>> addresses instead of pointers to real host memory.
>>
>> All code referring to these tables should be changed.433:				*gnvs =3D =
map_to_sysmem(ctx->current);
>
> I'm still not quite clear on this...can you point to functions or
> lines of code? When I look at acpi_add_table() it does use memmap, but
> perhaps some parts are wrong?
>
> Regards,
> Simon

Here are some examples where the wrong values are set. We must get rid
of all map_to_sysmem() calls where writing ACPI tables.

lib/acpi/acpi_table.c:
170 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rsdt->entry[i] =3D map=
_to_sysmem(table);
188 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xsdt->entry[i] =3D map=
_to_sysmem(table);

lib/acpi/base.c:
27:             rsdp->rsdt_address =3D map_to_sysmem(rsdt);
30:             rsdp->xsdt_address =3D map_to_sysmem(xsdt);

arch/x86/cpu/baytrail/acpi.c:
81:	fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
82:	fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);

arch/x86/cpu/quark/acpi.c:
76:	fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
77:	fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);

arch/x86/cpu/tangier/acpi.c:
47:	fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
48:	fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);

arch/x86/lib/acpi_table.c:
200:	tcpa->lasa =3D map_to_sysmem(log);
271:	tpm2->lasa =3D map_to_sysmem(lasa);
433:				*gnvs =3D map_to_sysmem(ctx->current);
575:	fadt->x_firmware_ctrl =3D map_to_sysmem(facs);
576:	fadt->x_dsdt =3D map_to_sysmem(dsdt);

Best regards

Heinrich

Best regards

Heinrich
