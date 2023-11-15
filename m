Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7E6C5ACB2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C404B871E7;
	Wed, 15 Nov 2023 23:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="SVwp/sus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04A1D87206; Wed, 15 Nov 2023 23:47:02 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CADAE871E4
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700088418; x=1700693218; i=xypron.glpk@gmx.de;
 bh=DsbWnnJAfqQpPZCyV/Wy/HAVqYTzSvBhe98X/THzd7k=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=SVwp/susaSOBNRImrspeTEk12NitZSBuVGdzucAYyTsLEapWD9e26Hnv75gZ7uER
 Nngy+40SYCGGgweZME6d8WW+2H35mzCrpPPZ9le9IyWHY4TSIzrzcrGZBht0vFFQj
 Fiy5SeaMl7PPecqq7xzCmZI9X9N2dW2bL2vLevfrHknaVDe3F72IOfDKW3/QlJp0C
 41GtZOXs+yA+iwi9kpFDtMMvaC6a8ltV0TGKEnYunkQ33SQMnjt+7sucGw37EoU5p
 XSA7M+R5qj0LBWrR5XilzoVdmW0auLug/hmamUKb3QQX7WFKvwiALCcmNt3Iac/Qk
 2o2qH7a6GyWpLzAtig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f5T-1r4lZd0pPr-0049O9; Wed, 15
 Nov 2023 23:46:58 +0100
Date: Wed, 15 Nov 2023 23:46:56 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>
CC: u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_bug_-_bootflow=3A_grub_efi_crashe?=
 =?US-ASCII?Q?s_when_bootflow_selected_explicitly?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ3V65sCuRV_NzJFZHL7-ZHq9SQUTxvvbj5GszFAhJ4WzA@mail.gmail.com>
References: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
 <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
 <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
 <CAHc5_t2vLU9gHufMS_Fjv6j5+E8ksgCCLzKQ7NxTHzJsdcmsNQ@mail.gmail.com>
 <CAPnjgZ3VY_M+zd2na+N9WCxj-L2F+KKhLgykQ21FTA7GPVrKNQ@mail.gmail.com>
 <CAHc5_t1fBzzpJaQed9kcKF92ProStsutmOBW-1jmi5vWFvLM8g@mail.gmail.com>
 <CAPnjgZ3WNmnNv7DjMFDM9Med3yRng32N6tku4NGxbwA5DRhQgA@mail.gmail.com>
 <CAHc5_t1H39YV=HSSa7TCEdzRctAX+zibkx1vsuwEW-raOL9TcA@mail.gmail.com>
 <CAPnjgZ3V65sCuRV_NzJFZHL7-ZHq9SQUTxvvbj5GszFAhJ4WzA@mail.gmail.com>
Message-ID: <CAC53B67-9BC2-4EB4-9846-F78166140BD0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2GdLG9s2ogQFk5qwy4RLk6qBsTVilenw4soAOyEP5x8lkekLPqB
 lyhWsaUhBv9EU6FLbPU4ZWBE8gnoVOMqHv7rX6BdWx4no0pq9Ut9JKv/pFsNW9wR2dkkbr0
 bwKop5XAttuN3sUCOBrxCPLkTqJlimUXwN7piAmi2qwMFS3ZwDh0lbJDCyCjlNB79LHRpyE
 jjJ3WA2wrTsRzifHCvNpg==
UI-OutboundReport: notjunk:1;M01:P0:tgFEdbqj4tQ=;e2bR6sB1PqeiL9qF32IZRevEjVk
 PUAeqTYbZcQHsSMwMaodTcH7qa/LfPzz9prX+IYrM6djuDimoR0imCB88OwFVrcCFlZuT5ik6
 XIo4HvpC6lKBPC8/PlDdJlfQbzAYsf+B55gN8lsMZjCwZLVnNw8BRxFVyimjqfP/I6jLurDNx
 LTbMe3ZhO6cXw6V64q6NIEx41EjSXH4qNw5Z9pWShK7WINSM6FQoB8Qf5Xf8HeowfelN1Z+zR
 G7jFDZ8YRpxV28pDmgSetDTpAOj4iez+gIPg/ED5VUeq7lPCsp7ju/3ll18DtClfH4d7HW2aZ
 L0ZCO8wWmRq+z7xZuL/EHTiMT+I1SwJLs0HHm934YiR9sKX+5zVNO9esGTUB4MlDNc7kK5JOC
 kJmqvdA338pLF/y7vQyMUOhS1A7GTtkGnq9n1IjjBtviAEgUyvyUQZsrRTxIR6dRneLq9LBso
 pE5mziIOfuzGPASeEnRqwkdRipXnw/8/9Qkprs1OCk9WqGPhytOxOmWH+E9z0kewWaV4xjCUy
 4IrXZ0Yl6wMOee22Og/LVcKSCm2ktzFq6C5idfwLfuNTUuEOPGjRVdHyneGa8yedeDT8zEkBB
 WPbsB44UY5PerC9owLn80hFNYA2PPoqbzcigcrgSIsqbEclEckVGvktolJsjaCmoJV7lkgp53
 aqkTC7iVJ0jLAssYPqmOG9slZ+rTjMF5mf29hwn+zXp0/p4UqpFE9tEZ8ijwt7vzNRNIlNjLG
 bXQ4g+1ZkY9LO16S13qK9h1Vw5l2XUZ6gG6KgB2YcCmeMZaqPEWmEe/vSklUtJjDbw9ENTJqh
 WWQzHiyFMqKer2P82JD0dxz6nfwFS40UapTXUxk+zSZsgJQZbHtHXNJTv8Lu8SvnUK5wj4yqY
 J9KNrRJMdcbe4KtSnidAbLe6nvMFY8jGYp1dEZurllZ1TsJPzQ9z51mwpaxw1If+GkxiTEi43
 Ud53ISqdriWYi9XrP+dKB6Af7SY=
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



Am 15=2E November 2023 23:15:46 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Shantur,
>
>On Wed, 15 Nov 2023 at 15:13, Shantur Rathore <i@shantur=2Ecom> wrote:
>>
>> Hi Simon,
>>
>> I have figured out the cause of the crash=2E
>> It happens here -
>> https://github=2Ecom/u-boot/u-boot/blob/master/boot/bootflow=2Ec#L470
>> while doing - free(bflow->buf)
>>
>> As I understand it,
>> - Just before starting kernel EFI binary calls usb-uclass->usb_stop()
>> - This starts removing all devices in my case ( 6x usb_hub, 2x
>> partition, 1x blk, 2x bootdev, 1x usb_maas_storage)
>> - While removing bootdev, it ends up calling bootdev-uclass ->
>> bootdev_pre_unbind -> bootdev_clear_bootflows which calls
>> bootflow->bootflow_remove and bootflow_free
>>
>> I don't know why this buf cannot be freed, is it because the EFI
>> binary in the buffer is still being used ( efi/boot/bootaa64=2Eefi ) ?

EFI binaries should never be started from memory allocated with malloc=2E =
efi_load_image() should be invoked which allocates EFI memory via efi_alloc=
ate_pages()=2E The handle created has to be passed to efi_start_image()=2E

>> But commenting this line out fixes the crash and linux boots happily=2E
>>
>> Fixing this properly is above my pay grade as of now=2E
>
>Great, thank you! I will send a patch=2E

Free() typically crashes in U-Boot when freeing the same memory twice=2E

Best regards

Heinrich



>
>Regards,
>Simon
>
>>
>> Kind regards,
>> Shantur
>>
>> On Wed, Nov 15, 2023 at 3:58=E2=80=AFPM Simon Glass <sjg@chromium=2Eorg=
> wrote:
>> >
>> > Hi Shantur,
>> >
>> > On Wed, 15 Nov 2023 at 08:23, Shantur Rathore <i@shantur=2Ecom> wrote=
:
>> > >
>> > > Hi Simon,
>> > >
>> > > >
>> > > > Is this the blue port on top of the USB-C connector?
>> > > >
>> > > Yes, that's correct=2E
>> > > For my drive I needed -
>> > > https://patchwork=2Eozlabs=2Eorg/project/uboot/patch/20231110141311=
=2E512334-1-i@shantur=2Ecom/
>> > >
>> > > >
>> > > > Which version of Armbian / download link?
>> > > >
>> > > https://redirect=2Earmbian=2Ecom/rockpro64/Bookworm_current
>> > >
>> > > > Yes it is scanning first, before reading the efi app, etc=2E
>> > > >
>> > > > I have the same hardware so may be able to dig into this=2E
>> > >
>> > > Sorry, I meant to ask if anything specific to USB=2E
>> > > I see it loads efi from the network or disk and calls bootefi with =
the
>> > > loaded address=2E
>> > > I don't know deep boot / efi stuff, just trying to compare how it's
>> > > loading efi differently than fatload in this case=2E
>> >
>> > There is nothing special about USB in boootstd, so far as I know=2E
>> >
>> > But until we figure out this bug, it is hard to be sure=2E
>> >
>> > Regards,
>> > Simon
