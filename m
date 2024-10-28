Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF73D13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 10:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4DC388C66;
	Mon, 28 Oct 2024 11:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FLag+otO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16FBA885F4; Mon, 28 Oct 2024 11:12:14 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 007EC88F4B
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 11:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730110319; x=1730715119; i=xypron.glpk@gmx.de;
 bh=O85B6iaTUzoQ/13rJeQOXB5xRKiKxwBHO/kyjIPeeiE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FLag+otO5WRuKQCfOLumSJ95E/U+JDS3qVS2LBU3kV41A3NaRlT6lgPR8QhifnBb
 OUgtJ+hyaQ8syqrO7gTJQkOLKVBTB8999UTvBcT+99ueKrK8WLlYGMIulPhbvIaor
 k5wdtTrJpf5n8jYR6NDoIBF4lY54/H5xfmuKWhjwcdBdHC524ZrKDiH1X1nTGyc03
 XXf07DI42OJBiW/BpVQZJYE3/YHXN//EYRH65K/0lqS9b4YfM+XEplvJD7oyeLTFF
 nnHLuMk0r37UQALNloeVspiaFCsNseUCsjM2ydQEV4KQYX2bKLoqXkVxH7fl0qKL8
 2hbxZDUS0qxEv25q6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.150.8.169] ([145.103.114.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWici-1tP5Qk3BE0-00P6lx; Mon, 28
 Oct 2024 11:11:58 +0100
Message-ID: <67974fc5-0aee-4160-a29e-61a29e383f2c@gmx.de>
Date: Mon, 28 Oct 2024 11:11:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] test: efi: boot: Set up an image suitable for EFI
 testing
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Eddie James
 <eajames@linux.ibm.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-8-sjg@chromium.org>
 <e29d4360-87c0-478c-be50-f9af99e6c2b9@gmx.de>
Content-Language: en-US
In-Reply-To: <e29d4360-87c0-478c-be50-f9af99e6c2b9@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PW5P/D9Vg0EQqSixZVoIyciumEjLqhV+MGSNwnIrPFcVc3BRiGN
 PXYtDoc7XCLx5jXx5sNYvGn484XpIgwfpmlBs+S+G1z+DSq9wOpUsKxQxRWM0EUvi85IMhm
 N+Dj6rvdTDwV8SJ5nq9g8ZkrIrtIqJqBypOzrhb/Gz2tr3wmIfG52iJR3Djjowg3Oou/OY0
 H+ST6gFY/9J4Vg50WcGqQ==
UI-OutboundReport: notjunk:1;M01:P0:4VV1eCFlQzc=;mZbAHzooXaV58uUSpDDpVSKvRjy
 Cvp+vPgcRw0N+aYfMME7Ws3Ax/b9EmPepOQ+hXUXv39z29DFFa/FoS3Y5A/1AMZYjQW5Wc+j5
 5RsPuXELPx6TkXHG12WYZEtWg2UPpY2qBDev6d+cdmPek1Dz2O70liUJL5cy0DwgjLdr6HYWI
 61g1/p/2Onh5TLglXmn+2Ys9Y2AE7ZdXu0XI1U23GQj4nNtRz+bJm7Ki3V15QS4uZc5n3LKl1
 4hCB7naR5Xzbd/hnDKMMXwoCRs0XV6Da/tFd9av1zTJ4+8NtQdfZjr3FG8M7XIXbD7Zu4ug2Z
 mWOhG5iKUDN6OzcZ+ImHTYAn3chVti22R5vy9oeLTKdSxLyla4UGzCNMK3iUeZjj8cj6tGiC7
 kAu8ZP+Aj9BLdkJ0Fm8wxP2Re9WoIrt7tmzvbfifyny8vqaT6iKpz8iuRENxa3a55lZGxxlC5
 wAULft/IaGI/hcsf5z2fPtBAKS15sC2PXBKgx5+clevsihmnw7/APGbDXTEfXc43fB24e4X47
 uMMYswkkFtK6aNzjD8pK9GHApct9NjqPReRgpZbJGM2Ug0y7aHkic+RDCe7RtS3Um4E+c/Q5r
 4RcF0ec9XX3sXFNgs1cNGRYaqFPnuNtmN2+Lojrp4znnX2eCVsY0hQseCYA8V6cwizW/nBPp8
 QjnRz/cMb6VIS2UF9EPaJGXnRQT/lOwPWcTP2wHO2XYqpqYqCbNvSPciFjM7kedwJiJb/0FbT
 TDWigerhOv71X3lY7Z9vbtfhqVSk3v2nMuMAW/nmRTbPjdYIAFEqkkfcmU8eYizN9zKnlzHmN
 folvA4EvJoMPPw48YX2bIIydBoxl58+2sffJr3mBblUA8=
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

On 10/28/24 07:08, Heinrich Schuchardt wrote:
> On 10/22/24 14:00, Simon Glass wrote:
>> Create a new disk for use with tests, which contains the new 'testapp'
>> EFI app specifically intended for testing the EFI loader.
>>
>> Attach it to the USB device, since most testing is currently done with
>> mmc.
>>
>> Initially this image will be used to test the EFI bootmeth.
>>
>> Fix a stale comment in prep_mmc_bootdev() while we are here.
>>
>> For now this uses sudo and a compressed fallback file, like all the
>> other bootstd tests. Once this series is in, the patch which moves
>> this to use user-space tools will be cleaned up and re-submitted.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>
>> ---
>> Here is the patch to avoid sudo and CI fallback:
>>
>> [1] https://patchwork.ozlabs.org/project/uboot/patch/
>> 20240802093322.15240-1-richard@nod.at/
>>
>> (no changes since v1)
>>
>> =C2=A0 arch/sandbox/dts/test.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 test/boot/bootdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +++++++++-
>> =C2=A0 test/boot/bootflow.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
>> =C2=A0 test/py/tests/test_ut.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 52 ++++++++++++++++++++++++----
>> =C2=A0 5 files changed, 65 insertions(+), 9 deletions(-)
>> =C2=A0 create mode 100644 test/py/tests/bootstd/flash1.img.xz
>>
>> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
>> index 9bf44ae3b0b..f40fd5a2b16 100644
>> --- a/arch/sandbox/dts/test.dts
>> +++ b/arch/sandbox/dts/test.dts
>> @@ -1512,7 +1512,7 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flash-stick@1 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <1>;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "=
sandbox,usb-flash";
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sandbox,filepath =3D "testfl=
ash1.bin";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sandbox,filepath =3D "flash1=
.img";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flash-stick@2 {
>> diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
>> index 369105ca4cf..c892854b227 100644
>> --- a/test/boot/bootdev.c
>> +++ b/test/boot/bootdev.c
>> @@ -221,6 +221,10 @@ static int bootdev_test_order(struct
>> unit_test_state *uts)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Use the environment variable to overr=
ide it */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_assertok(env_set("boot_targets", "mmc=
1 mmc2 usb"));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_assertok(bootflow_scan_first(NULL, NU=
LL, &iter, 0, &bflow));
>> +
>> +=C2=A0=C2=A0=C2=A0 /* get the usb device which has a backing file (fla=
sh1.img) */
>> +=C2=A0=C2=A0=C2=A0 ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq(-ENODEV, bootflow_scan_next(=
&iter, &bflow));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq(5, iter.num_devs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq_str("mmc1.bootdev", iter.dev=
_used[0]->name);
>> @@ -260,7 +264,11 @@ static int bootdev_test_order(struct
>> unit_test_state *uts)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_assertok(bootflow_scan_first(NULL, NU=
LL, &iter, 0, &bflow));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq(2, iter.num_devs);
>>
>> -=C2=A0=C2=A0=C2=A0 /* Now scan past mmc1 and make sure that the 3 USB =
devices show
>> up */
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Now scan past mmc1 and make sure that the 3=
 USB devices show
>> up. The
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * first one has a backing file so returns suc=
cess
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq(-ENODEV, bootflow_scan_next(=
&iter, &bflow));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq(6, iter.num_devs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq_str("mmc2.bootdev", iter.dev=
_used[0]->name);
>> @@ -322,6 +330,10 @@ static int bootdev_test_prio(struct
>> unit_test_state *uts)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3 MMC and 3 USB bootdevs: MMC should =
come before USB */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_assertok(bootflow_scan_first(NULL, NU=
LL, &iter, 0, &bflow));
>> +
>> +=C2=A0=C2=A0=C2=A0 /* get the usb device which has a backing file (fla=
sh1.img) */
>> +=C2=A0=C2=A0=C2=A0 ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq(-ENODEV, bootflow_scan_next(=
&iter, &bflow));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq(6, iter.num_devs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq_str("mmc2.bootdev", iter.dev=
_used[0]->name);
>> @@ -339,6 +351,10 @@ static int bootdev_test_prio(struct
>> unit_test_state *uts)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootflow_iter_uninit(&iter);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_assertok(bootflow_scan_first(NULL, NU=
LL, &iter, BOOTFLOWIF_HUNT,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &bflow));
>> +
>> +=C2=A0=C2=A0=C2=A0 /* get the usb device which has a backing file (fla=
sh1.img) */
>> +=C2=A0=C2=A0=C2=A0 ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq(-ENODEV, bootflow_scan_next(=
&iter, &bflow));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq(7, iter.num_devs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_asserteq_str("usb_mass_storage.lun0.b=
ootdev",
>> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
>> index 539abe63ebe..d94c07963d5 100644
>> --- a/test/boot/bootflow.c
>> +++ b/test/boot/bootflow.c
>> @@ -533,7 +533,7 @@ static int prep_mmc_bootdev(struct unit_test_state
>> *uts, const char *mmc_dev,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 order[2] =3D mmc_dev;
>>
>> -=C2=A0=C2=A0=C2=A0 /* Enable the mmc4 node since we need a second boot=
flow */
>> +=C2=A0=C2=A0=C2=A0 /* Enable the requested mmc node since we need a se=
cond bootflow */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root =3D oftree_root(oftree_default());
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node =3D ofnode_find_subnode(root, mmc_d=
ev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ut_assert(ofnode_valid(node));
>> diff --git a/test/py/tests/bootstd/flash1.img.xz b/test/py/tests/
>> bootstd/flash1.img.xz
>> new file mode 100644
>> index
>> 0000000000000000000000000000000000000000..9148b91a20c1f0acb54449b124d14=
08961e92507
>
> We should not accept such binaries. This was just how xz was hacked
> (https://en.wikipedia.org/wiki/XZ_Utils_backdoor).
>
> This binary wouldn't conform to the GPL 2.0 license either.
>
> Best regards
>
> Heinrich
>
>> GIT binary patch
>> literal 5016
>> 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
yp9
>> z9<Ke9SBS3!ukGU#4CI-@!yY10$Hu`~TkU;%B9<w_?}51x8UCnvkWast$>!$S*si%Y
>> z#K@3yE)2HKtuQf<(p%-MP;{u#ln=3DwpQ1YA#gF=3DREU4Ysw)eE4nJR61Dj5RfBZ~dM*
>> zSMp96hovw!v!`3u@q#5n+3D*c)52Q{z19NhVU|dnO=3D-{cW*eIX_2Q97jaK23vWBG7
>> z@m-4+V3|8nS|8n5(7fuqxU~m1hiT=3D)sP4+=3DFIXUT1|kn%EzpMCxRuaG>(_h94n9E@
>> z^-0~gvKr&93iu$m=3DJxNvH`Z>5eVq0gWqPV|6Dd^9zrpc%XLqFfRKYs#OhX;3>Jm;b
>> zh)!B^-RF<)Tr}SWQrPsyLGNqxRRqOIG#PiTgwEoM7^!y@5qBOR-Cf%U)jHUm7=3Dx1n
>> zabX0NS!nxd?gq)JryA$B@Ibw^qlg)E=3DDN@e$6aC^s8+O<N*T+sZtE3VJS6CHR;Hfb
>> zj6!OYV>_{x@AiR~<_W*A<j@8rZy})!cUSg4dNp5pXk>_j#gJdl-^e|Hn)_#5WHWmA
>> z*>1210pl<x|1SJEm1hL6rCToRBa2%(;ktp6=3D{I?DPoB?_h#?1Y%pMU_Pnn5X#zFHB
>> zkD8>k_~Sa)Oa|ASTX<>*J$=3DfQh1r%Sk4yV+%E8c2*ol{zZAGEORz}_=3DpJYbILT?~9
>> zx@Ww_ZY!Phs9}DZ;|(-K7u0?|<x*!^Q((Pp0U@L0j5%*kym>tedsc3u1!ajplM14D
>> z?)FvVYF1EAD}VwEmh!>y)l!<B_<wT8$jHNU{OnXe*r~#qv;d5N2DZJiLI6N8ou4Vd
>> g!6FL)+!7BD4?iLFVyT<d=3D5|Q;_y0ElgRR})0MlW=3DWB>pF
>>
>> literal 0
>> HcmV?d00001
>>
>> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
>> index 39aa1035e34..f647e2f0af2 100644
>> --- a/test/py/tests/test_ut.py
>> +++ b/test/py/tests/test_ut.py
>> @@ -28,21 +28,22 @@ def mkdir_cond(dirname):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not os.path.exists(dirname):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.mkdir(dirname=
)
>>
>> -def setup_image(cons, mmc_dev, part_type, second_part=3DFalse):
>> +def setup_image(cons, devnum, part_type, second_part=3DFalse,
>> basename=3D'mmc'):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """Create a 20MB disk image with a singl=
e partition
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Args:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cons (ConsoleBas=
e): Console to use
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmc_dev (int): MMC device n=
umber to use, e.g. 1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devnum (int): Device number=
 to use, e.g. 1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 part_type (int):=
 Partition type, e.g. 0xc for FAT32
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 second_part (boo=
l): True to contain a small second partition
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 basename (str): Base name t=
o use in the filename, e.g. 'mmc'
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Returns:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tuple:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 str: Filename of MMC image
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 str: Directory name of 'mnt' directory
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> -=C2=A0=C2=A0=C2=A0 fname =3D os.path.join(cons.config.source_dir, f'mm=
c{mmc_dev}.img')
>> +=C2=A0=C2=A0=C2=A0 fname =3D os.path.join(cons.config.source_dir, f'{b=
asename}
>> {devnum}.img')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mnt =3D os.path.join(cons.config.persist=
ent_data_dir, 'mnt')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkdir_cond(mnt)
>>
>> @@ -78,16 +79,17 @@ def mount_image(cons, fname, mnt, fstype):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u_boot_utils.run_and_log(cons, f'sudo ch=
own {getpass.getuser()}
>> {mnt}')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return loop
>>
>> -def copy_prepared_image(cons, mmc_dev, fname):
>> +def copy_prepared_image(cons, devnum, fname, basename=3D'mmc'):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """Use a prepared image since we cannot =
create one
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Args:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cons (ConsoleBas=
e): Console touse
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmc_dev (int): MMC device n=
umber
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devnum (int): device number
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fname (str): Fil=
ename of MMC image
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 basename (str): Base name t=
o use in the filename, e.g. 'mmc'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 infname =3D os.path.join(cons.config.sou=
rce_dir,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 f'test/py/tests/bootstd/mmc{mmc_dev}.img.xz')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 f'test/py/tests/bootstd/{basename}
>> {devnum}.img.xz')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u_boot_utils.run_and_log(cons, ['sh', '-=
c', f'xz -dc {infname}
>> >{fname}'])
>>
>> =C2=A0 def setup_bootmenu_image(cons):
>> @@ -549,6 +551,43 @@ def test_ut_dm_init(u_boot_console):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with open(fn, 'wb') as fh:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fh.write(data)
>>
>> +
>> +def setup_efi_image(cons):
>> +=C2=A0=C2=A0=C2=A0 """Create a 20MB disk image with an EFI app on it""=
"
>> +=C2=A0=C2=A0=C2=A0 devnum =3D 1
>> +=C2=A0=C2=A0=C2=A0 basename =3D 'flash'
>> +=C2=A0=C2=A0=C2=A0 fname, mnt =3D setup_image(cons, devnum, 0xc, secon=
d_part=3DTrue,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 basename=3Dbasename)
>> +
>> +=C2=A0=C2=A0=C2=A0 loop =3D None
>> +=C2=A0=C2=A0=C2=A0 mounted =3D False
>> +=C2=A0=C2=A0=C2=A0 complete =3D False
>> +=C2=A0=C2=A0=C2=A0 try:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loop =3D mount_image(cons, =
fname, mnt, 'ext4')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mounted =3D True
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_dir =3D os.path.join(mn=
t, 'EFI')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkdir_cond(efi_dir)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootdir =3D os.path.join(ef=
i_dir, 'BOOT')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkdir_cond(bootdir)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_src =3D os.path.join(co=
ns.config.build_dir,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f'lib/efi_loader/testapp.efi')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_dst =3D os.path.join(bo=
otdir, 'BOOTSBOX.EFI')

As said I can live with the -n switch though that standards defying
bootsbox.efi name provides no benefit whatsoever. But, please, do not
ignore the switch.

Best regards

Heinrich


>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with open(efi_src, 'rb') as=
 inf:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wit=
h open(efi_dst, 'wb') as outf:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 outf.write(inf.read())
>> +=C2=A0=C2=A0=C2=A0 except ValueError as exc:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print(f'Falled to create im=
age, failing back to prepared
>> copy: {exc}')
>> +
>> +=C2=A0=C2=A0=C2=A0 finally:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if mounted:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u_b=
oot_utils.run_and_log(cons, 'sudo umount --lazy %s' %
>> mnt)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if loop:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u_b=
oot_utils.run_and_log(cons, 'sudo losetup -d %s' % loop)
>> +
>> +=C2=A0=C2=A0=C2=A0 if not complete:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy_prepared_image(cons, d=
evnum, fname, basename)
>> +
>> +
>> =C2=A0 @pytest.mark.buildconfigspec('cmd_bootflow')
>> =C2=A0 @pytest.mark.buildconfigspec('sandbox')
>> =C2=A0 def test_ut_dm_init_bootstd(u_boot_console):
>> @@ -559,6 +598,7 @@ def test_ut_dm_init_bootstd(u_boot_console):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setup_cedit_file(u_boot_console)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setup_cros_image(u_boot_console)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 setup_android_image(u_boot_console)
>> +=C2=A0=C2=A0=C2=A0 setup_efi_image(u_boot_console)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Restart so that the new mmc1.img is pi=
cked up
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u_boot_console.restart_uboot()
>

