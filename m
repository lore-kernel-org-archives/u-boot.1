Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3141FC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 09:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8081087480;
	Wed, 20 Dec 2023 10:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nY0zgoxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0721A8755B; Wed, 20 Dec 2023 10:17:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1348886FD5
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 10:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703063839; x=1703668639; i=xypron.glpk@gmx.de;
 bh=Yleul7H8+nbGr2Pb71l9zNbLTcykMWHCsXgYfiv+dLU=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=nY0zgoxIvzpDrkTvIPDt6TLVGY/3noQ7H1iqd6z6VO4mrg+2i9yxoYen1X3PFGzu
 9CfryNQgA2TkwyQAfS47DM8TU4+f5DgaTA34JxzVcZttPKobPrwi0Qa7Jn9yG0NjC
 xv8f4hGcXmiZh8JaS62zfsimzdzzPWSviPfMJcUlX/bzJjhE45lT61SYVUScWlr9A
 +/FU9dAejaLNowfBVfzB2C/b2Xb9SwK3U/sRVHz78pwtGkpoNNHd6R/F8rgFvbtzJ
 zP7QYAD8sxUIuEOCXKMuomxgc6K1wROmkflVjm5PoCvDluX0LSBMU0XoXF5cR+JeD
 jeIBO8j6026DkUH1/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSc1B-1rinSQ1CDR-00Sz7n; Wed, 20
 Dec 2023 10:17:19 +0100
Date: Wed, 20 Dec 2023 10:17:18 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 trini@konsulko.com, ilias.apalodimas@linaro.org, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_3/4=5D_net=3A_tftp=3A_remove_?=
 =?US-ASCII?Q?explicit_efi_configuration_dependency?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ222JWVWws04Tk93QommHXY6=qJFfiQfosYs5FG4JVGrA@mail.gmail.com>
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-4-takahiro.akashi@linaro.org>
 <CAPnjgZ0qw7j3TCMN+xH6ONaWvUyRvkWpsZJd2PQWHYBhZkTD6g@mail.gmail.com>
 <ZYDhClYupQxNJ++a@octopus>
 <CAPnjgZ222JWVWws04Tk93QommHXY6=qJFfiQfosYs5FG4JVGrA@mail.gmail.com>
Message-ID: <CD73D0D7-1040-4AD9-B5CD-741146DE0C34@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MDY+UkNrxVBSvtSr5lfg588aNduYmqFPk9+tNyrsG4NDZnOg0Fh
 N6Mjukt4eajd6w1LfBBrvpVZpfgu20KeGEr3RIgv+4pNpLRwe2KaG5jXsZG2Xmw6H69ub+N
 ds1/HTXO+JRe3SMeZjmOcaAfyOEwCjtDrtd5bmN1NywVV2t5O85Ga2ezWYqcBsk+NLFt4jd
 ooFneqUvh48mumtjv1L5Q==
UI-OutboundReport: notjunk:1;M01:P0:RZsmnz9fRIA=;BDFuUHxLhuPLUsimwu3/9Cpzor/
 Xb8x8xzpIO+69IrSY0xQhpfNnCZRjkQ8UGNxQ88MVs3xKhXRJKp6aCSX8cmW+Vc2ZQWjryxSn
 uI56oJmvKLdgEgZ5ylmQCS7AEwWBfe0YrxZ/jYLhPQlnItXVn5tuiGrxDoYgC4QspCEC23+0X
 KZEvSlvGGQNlncjKMzXwAk0Y8cw2607pVYe1mZqITQ1px+NDdgwk/8j6rNciIFHtLCOxk88+Z
 Kw8l6yJ0q5Oy2YJ67/4KlscH/5C9REM1Sk8whlXsT22/1EL1mOK6ZOmOeNaBuf1tbcps4cwmu
 O4FCM+G6XhNbSMJDfSShhA+1DKtqmQSu5DHJ/XtzPz1wLUV9c8M60l0TBEUSMHaaD6kaz7VNI
 cOaXHam2j/WG+aplj09e8u7VEhbAK6KDmFPzs5JtBW1u2FpuR3fvwnRBAK5GO8vbwqHB4JC5I
 Y+4/Ln5YSKKcJhX+YRZUUR2oasi0BROqKY8NDISaoHmqiML5ecsmb0Xx4+wCoRwQ3Kir5JCc2
 R8pxczRT1O/H9gMzQd/k/weSYYJznRClUuF5ZgZVuskzNHBPOAhMbgqJ4MfOaLPEOSBMrgJun
 xyvyaU1FZmeAlRrOQwcpJKklqTd5BxpTGyUMkb0yw8U4QXC2/hGQ9hqepT1Rh4DI3kzkSr7rA
 JE98iYTW0PDdwZ8JiZ1VADmPXIDWSuz1ldCJ7EI9NS34w98YYaIqjT5T9iWJEGtqt8GOgyAvU
 FR1h5cVIBnGTICqdYCTeT9WZPVdeNGU1/mvwnx6dMWqbYs89yJd8rrcKcZBo7x1onqcpp0v2j
 I7LMyLAiEULfLRbDoqRZzmnRnPQ9Olt4r43Byt07UomtU4+VLRakbXcX1usTZFBlNR+e9tIx1
 +mD+b6ZQDIUygwRBdmT82DpfjcmAobG2QeJy8Kd9NnojvpE/tfPzy6HwRj/Nyv5El4/+jwwZD
 oFxG+g==
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



Am 20=2E Dezember 2023 05:46:16 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi,
>
>On Mon, 18 Dec 2023 at 17:17, AKASHI Takahiro
><takahiro=2Eakashi@linaro=2Eorg> wrote:
>>
>> Hi Simon,
>>
>> On Mon, Dec 18, 2023 at 08:01:46AM -0700, Simon Glass wrote:
>> > Hi AKASHI,
>> >
>> > On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
>> > <takahiro=2Eakashi@linaro=2Eorg> wrote:
>> > >
>> > > Now it is clear that the feature actually depends on efi interfaces=
,
>> > > not "bootefi" command=2E efi_set_bootdev() will automatically be nu=
llified
>> > > if necessary efi component is disabled=2E
>> > >
>> > > Signed-off-by: AKASHI Takahiro <takahiro=2Eakashi@linaro=2Eorg>
>> > > ---
>> > >  net/tftp=2Ec | 10 ++++------
>> > >  1 file changed, 4 insertions(+), 6 deletions(-)
>> > >
>> >
>> > I have the same comment here as the 'fs' patch=2E
>> >
>> > > diff --git a/net/tftp=2Ec b/net/tftp=2Ec
>> > > index 88e71e67de35=2E=2E2e335413492b 100644
>> > > --- a/net/tftp=2Ec
>> > > +++ b/net/tftp=2Ec
>> > > @@ -302,12 +302,10 @@ static void tftp_complete(void)
>> > >                         time_start * 1000, "/s");
>> > >         }
>> > >         puts("\ndone\n");
>> > > -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI)) {
>> >
>> > Shouldn't this depend on your new CONFIG? What happens if EFI_LOADER
>> > is not enabled?
>>
>> The trick is in efi_loader=2Eh=2E
>> If EFI_LOADER (more specifically CONFIG_EFI_BINARY_EXEC) is not defined=
,
>> this function gets voided=2E  See patch#1 in this version=2E
>>
>> I took this approach in order not to make users much worried about
>> what config be used as they are not familiar with UEFI implementation=
=2E
>
>OK, but we really need to delete this function, so what is the plan
>for that? The info that EFI needs should be passed to the bootefi()
>function, not set in a global=2E

Hello Simon,

Bootstd is not the only way to boot=2E Please, do not forget the shell=2E

The user loads a file with tftpboot=2E At some later moment the user execu=
tes bootefi=2E

We need a place where we store the device from which the image was loaded=
=2E

In future we might have a register of loaded files=2E But that is beyond t=
he scope of this patch series=2E

Best regards

Heinrich

>
>
>>
>> -Takahiro Akashi
>>
>> > > -               if (!tftp_put_active)
>> > > -                       efi_set_bootdev("Net", "", tftp_filename,
>> > > -                                       map_sysmem(tftp_load_addr, =
0),
>> > > -                                       net_boot_file_size);
>> > > -       }
>> > > +       if (!tftp_put_active)
>> > > +               efi_set_bootdev("Net", "", tftp_filename,
>> > > +                               map_sysmem(tftp_load_addr, 0),
>> > > +                               net_boot_file_size);
>> > >         net_set_state(NETLOOP_SUCCESS);
>> > >  }
>> > >
>> > > --
>> > > 2=2E34=2E1
>
>Regards,
>Simon
