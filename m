Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FF1C47072
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 15:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60B998309D;
	Fri, 29 Dec 2023 16:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kmYlBFZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 309BC87A54; Fri, 29 Dec 2023 16:53:32 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D2258082A
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 16:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703865209; x=1704470009; i=xypron.glpk@gmx.de;
 bh=bwnvVWawi+rlVV6HHDe+cva9Zh/fs8aqZ03RhCQDiNA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=kmYlBFZ1uLk3Tabk1tA46/cvjjxoP07PPdEPwh/wh6X1bjmT8kY8sRnl0vNcoKLi
 oXFvbv0fdlDe6RBIb/wIuHudPvzGC/GvpRj9+OGZ79YgGlBPedT8HTLO3C8odRxzH
 0/k/2SDyOqRMuJOr4nXh8qtR4AcAC+V+NXEj8Q+3U5729f9RFwaz4j4HkUEedlxe9
 BwxGLckulL/lhq1u62HDLaSunuuGiO4rcuKu21eBOt4E9VYJ50hGDhi7W34Qo1pVE
 Hcn9PWKt9oLIfeHAuWR+jaU10UVmxEgNJ5zXSx235fsu7cUoaxCIuL+D9ztWJ6e10
 yR8bHCu/IO3mDyl+8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNJg-1rnP471Cx0-00VOqB; Fri, 29
 Dec 2023 16:53:29 +0100
Date: Fri, 29 Dec 2023 16:53:28 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: ACPI: usage of sandbox virtual addresses
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTj1npgL8F0H2prS_iBS-Kj2p+-Ena_ccQSe4dXPLGAM7w@mail.gmail.com>
References: <9f681497-d13c-4ccc-9209-7a8b33e3195c@gmx.de>
 <CAFLszThsThxhWCgP+UHmA5BxRUUBfDP7SDahtAm5WOrHoT0xhQ@mail.gmail.com>
 <e9a835ea-ea99-4db2-b5ad-ba7742397d46@gmx.de>
 <CAFLszTg17_xPGWMDG=1X+q2UTdJ_kO2pUshmDLt+cv9uPPcgJg@mail.gmail.com>
 <08e7b3cc-9588-46ab-844e-6edbe1154e43@gmx.de>
 <CAFLszTj1npgL8F0H2prS_iBS-Kj2p+-Ena_ccQSe4dXPLGAM7w@mail.gmail.com>
Message-ID: <AA53366A-42EF-4F81-B1BC-C4408ED066B6@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9yS6zMx+bgPACm8cUYxveBEy887o/0o4QtAwwbGtJklzVYo6PgM
 zIN5ZV0LNomndOEyHj20Cjr7ZToB2rvTwgU7JVPc+0SdNjUF7XV8mf+sqlTiwoeYuqX0cMY
 96IwfIFq+78HtPxUeFbr2PGL5WeXSowV/BShMHdETIW+XUhA+uMzPmF57nQJUrT9/hXQSw5
 D36HhTAQbKFpA24OgKiVg==
UI-OutboundReport: notjunk:1;M01:P0:jCVhLdYdW0s=;2+5jUC/U2EBu3Knn06w4aYZXkMC
 cefma/HcLnpOBHKeHcGg/aSU37jzOLiHT8P6kdQSBKMTjfnxJhrNDoRwhIfUYLjUym+JJPfcu
 IAo5DP9vsO0KHiNZztJq/w+2KnxcV1kpiA6i9zl6VAKFGW+vPZR3h7CA72fdaG601RC+AW0rc
 cSZeBI3tOYrB9Q2Wj3uK735OAsfuIG3I+Fl1GyeokWwkKuUb/hyLVtrq8ibi62sV/QoFftW9C
 MyvXiayMuA1iEaxgGCYZ549E4SAoc0Sj7dIL3QiDAguP97CAtAzbQQPTbgf1jtNsIkBtWo7Rb
 CPg78Ptxgky2nhWwjE+qwDrNGcsQOrEX/XCTLpYn1387nZDxEvXkWbpDNruNFVpuvNnXxLn8J
 fNavT1jNtuHYoih0/DvmBhERdq7Dg5dskYfca/yjZwoR5WGn/zKORrQkaUGjFcRSoICqw+c9B
 GXAj6MDGOoO9CFSB1QE8hbN69v2G9gnIkyU8YYdLJK+1j9Nr2+/Pyhv9aL0CmdF1WY4UEz1F5
 T6e1SE0WCMInLnoy25VwynYbQKeo8PB4nBogcfk+dp/y/jBFOAFHZ5IdvWAAVe8IFy4kmNgGq
 jwBKBxaTimER8hD3NdJ74IvlLgZY2lWFfW8r9hzrop57Eo6YRn1Af7o8lilG9mtajH3Aci2hQ
 +y1sCJMKIMB0QvHTbPYr2ZfiT8JkV5iBMAh5d6g5cqP9d3xz6gDVts0n5RLkcUiNLRNUiqpWV
 7duVbqa0BCJgVksUSC03z8/Iu1ysChYRlKq2aM9S6BDgTRTT5myDmNKbpcyNdzhmyPFydHBpE
 Ha1uq633XFQw+q8Z4gdEAx2WKcJE1WREzAWpPZXl0zT7H7VRODX3tQAs3h9tLX3q6garS8O+y
 BVfuio7oD8Xr2nguStF31sN6aQsT5ZfZbFcPLuaYqvqHfclo/PTUK+t3HYJOuKyP1FeDp6MSw
 9wsEO4IZdDXl//Xm09d00e40J0E=
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



Am 29=2E Dezember 2023 15:31:24 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Heinrich,
>
>On Fri, Dec 29, 2023 at 11:14=E2=80=AFAM Heinrich Schuchardt <xypron=2Egl=
pk@gmx=2Ede> wrote:
>>
>> On 12/29/23 09:26, Simon Glass wrote:
>> > Hi Heinrich,
>> >
>> > On Tue, Dec 26, 2023 at 10:03=E2=80=AFAM Heinrich Schuchardt <xypron=
=2Eglpk@gmx=2Ede> wrote:
>> >>
>> >> On 12/26/23 10:50, Simon Glass wrote:
>> >>> Hi Heinrich,
>> >>>
>> >>> On Tue, Dec 26, 2023 at 8:56=E2=80=AFAM Heinrich Schuchardt <xypron=
=2Eglpk@gmx=2Ede> wrote:
>> >>>>
>> >>>> Hello Simon,
>> >>>>
>> >>>> currently we use sandbox virtual addresses in all ACPI tables=2E T=
his
>> >>>> means that an application started by the U-Boot sandbox consuming =
these
>> >>>> tables will crash due to accessing invalid addresses=2E
>> >>>>
>> >>>> Shouldn't the ACPI tables be migrated to use valid pointers?
>> >>>
>> >>> The confusion arises due to the difference between addresses and
>> >>> pointers=2E If we store addresses in the ACPI tables, then things s=
hould
>> >>> work=2E
>> >>>
>> >>> My approach has been to avoid using casts, but instead use
>> >>> map_sysmem() and mem_to_sysmem()=2E
>> >>>
>> >>> Which particular piece of code is wrong in this case?
>> >>
>> >> Tables DSDT, XSDT, RSDP, FADT in the sandbox contain sandbox virtual
>> >> addresses instead of pointers to real host memory=2E
>> >>
>> >> All code referring to these tables should be changed=2E433:         =
                   *gnvs =3D map_to_sysmem(ctx->current);
>> >
>> > I'm still not quite clear on this=2E=2E=2Ecan you point to functions =
or
>> > lines of code? When I look at acpi_add_table() it does use memmap, bu=
t
>> > perhaps some parts are wrong?
>> >
>> > Regards,
>> > Simon
>>
>> Here are some examples where the wrong values are set=2E We must get ri=
d
>> of all map_to_sysmem() calls where writing ACPI tables=2E
>>
>> lib/acpi/acpi_table=2Ec:
>> 170         rsdt->entry[i] =3D map_to_sysmem(table);
>> 188         xsdt->entry[i] =3D map_to_sysmem(table);
>>
>> lib/acpi/base=2Ec:
>> 27:             rsdp->rsdt_address =3D map_to_sysmem(rsdt);
>> 30:             rsdp->xsdt_address =3D map_to_sysmem(xsdt);
>>
>> arch/x86/cpu/baytrail/acpi=2Ec:
>> 81:     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
>> 82:     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
>>
>> arch/x86/cpu/quark/acpi=2Ec:
>> 76:     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
>> 77:     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
>>
>> arch/x86/cpu/tangier/acpi=2Ec:
>> 47:     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
>> 48:     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
>>
>> arch/x86/lib/acpi_table=2Ec:
>> 200:    tcpa->lasa =3D map_to_sysmem(log);
>> 271:    tpm2->lasa =3D map_to_sysmem(lasa);
>> 433:                            *gnvs =3D map_to_sysmem(ctx->current);
>> 575:    fadt->x_firmware_ctrl =3D map_to_sysmem(facs);
>> 576:    fadt->x_dsdt =3D map_to_sysmem(dsdt);
>
>OK, I see=2E But at least within sandbox, the address is what we want to
>store, not the pointer=2E Are you worried about what an EFI app will do
>in that case, when we run an app from sandbox? If so, then yes it is
>definitely a problem=2E
>
>Regards,
>Simon

The sandbox is an environment to run EFI binaries inside an OS=2E So the A=
CPI tables must contain pointers=2E

The acpi command should display sandbox virtual addresses=2E All conversio=
ns should be moved to the command=2E

Best regards

Heinrich
