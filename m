Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF684C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 21:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE0BA87DF3;
	Fri, 12 Apr 2024 23:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=extrowerk.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=extrowerk.com header.i=@extrowerk.com header.b="oM9lj40f";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="h0aTbAVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A96087ED3; Fri, 12 Apr 2024 19:27:23 +0200 (CEST)
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com
 [103.168.172.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ACF687E82
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 19:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=extrowerk.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zmizsei@extrowerk.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id D311D13802AD;
 Fri, 12 Apr 2024 13:27:18 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
 by compute2.internal (MEProxy); Fri, 12 Apr 2024 13:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=extrowerk.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1712942838; x=1713029238; bh=bJVLb1E/XIRf1lndfgug7a1d4Fpsy7Cf
 5yXlJ9UJ5ak=; b=oM9lj40fIPXNkibmbsvJhbOxkln/U8XksJnBbnZbkJolwwro
 XRMEn+4Bu8NtBLV1g3uwzA2XUQGmevaZs8xtTDQ6zOjQ4wpFb61hSgDh7wP4vzfA
 03I+7qWd1WCD3+y/afge51TypU3jeg/lsB6J8A0VuIUz4+sLu862cYXJhGQNtyre
 iWmkOYxj++ds/23yReioHHeqHW/st4UIDnZBb77krLT7vBMU291DS+z3CnKrpRro
 SBkFLktst03SZuID645YHr6Hx0FOEOg/JjvAzmydoVXFNIyxBAf154T1SYtqJ+4C
 Dy0GsP/h5OTjV2ewZ3JHJ6mGhK1F6IKFpenBWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712942838; x=
 1713029238; bh=bJVLb1E/XIRf1lndfgug7a1d4Fpsy7Cf5yXlJ9UJ5ak=; b=h
 0aTbAVRAshuF6Vcm990MNu3sGi20bCPKeYtn7W/0ILK8kepvAnvFxpgqMB896SCa
 h3QjXgkenuwFiKIm64kE4xDXcaURl84kKFushgJBLW+XAERYGiE6+Gt0KRcvHIqb
 et0eHnRBf5266Z24kh+r7Omcf/282AxhipoMxhVZJjS9KPS0GRwvrRw3cNpP3Kwq
 XYq3n6Z3Ss/qMwU+4sYoapB3TTyKnG6i6xwwD+z7a0C9n09rKSbAEhNwHyZoY52e
 z2XB/iHqBl6E7xSVcbtzRxR8m6Kt4QIUN51wBAgVi3Oz8MNc4Gq7LlIEHTzOOS9B
 9osnliu4xDnpdg96+E58A==
X-ME-Sender: <xms:9m4ZZmPJlp5SFw5G6Z8H8fGDJDl9pC1eGApkkoVzCm-4ntUZolD9Dg>
 <xme:9m4ZZk_NXMjrePew2hMDrwCP1vX2bCPDjx6gnyh7IP__32rHQbTz3ODc8UCm_mBGx
 8leJyKLId-vvb2B2OE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddguddugecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpefo
 ihiishgvihcukgholhhtjohnuceoiihmihiishgvihesvgigthhrohifvghrkhdrtghomh
 eqnecuggftrfgrthhtvghrnhepueevfffhgffhheekhffgudejvdefheettdehgfdvkeel
 geegieevudekhfehheeknecuffhomhgrihhnpehgihhthhhusgdrtghomhdpghgvnhhirg
 htvggthhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpeiimhhiiihsvghisegvgihtrhhofigvrhhkrdgtohhm
X-ME-Proxy: <xmx:9m4ZZtS8LG5Y_WGSXz2CangKrZ2-_GtQ1wiadcnV3eqSqZsWgJYyIw>
 <xmx:9m4ZZmtKBks_hNViFzxWaHprWao-8N5OeX8cadrjGNkkcA5tDh3QMA>
 <xmx:9m4ZZueVcTkbtBVfZUvDKz63T4P5cuOPxp1urxMq-APhf7JdCVqsHw>
 <xmx:9m4ZZq355IWbBFPb72zYOAXpRNCyWn1mNGD_QWo3GJ918FvvgGsxKA>
 <xmx:9m4ZZiEY1uXPXQxuoJEYx9sirnw_Lu3ji34lGep2CfSwpY51rNVF0MdN>
Feedback-ID: i46594767:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 376042D4007D; Fri, 12 Apr 2024 13:27:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
MIME-Version: 1.0
Message-Id: <080d0515-e36b-464e-bbf4-b77235826d6a@app.fastmail.com>
In-Reply-To: <7db1cc51-3a9c-44c3-ac16-369566f2ef20@kwiboo.se>
References: <cf475658-6c25-474b-934b-15da1363a39f@app.fastmail.com>
 <7db1cc51-3a9c-44c3-ac16-369566f2ef20@kwiboo.se>
Date: Fri, 12 Apr 2024 19:26:56 +0200
From: =?UTF-8?Q?Mizsei_Zolt=C3=A1n?= <zmizsei@extrowerk.com>
To: "Jonas Karlman" <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: Re: Can't get U-Boot working on Geniatech XPI-3566-ZERO
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 12 Apr 2024 23:18:50 +0200
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

Hi Jonas,

thank You, i tried my best to follow your hints as good as possible. Thi=
s is what i did:

- git clone https://github.com/rockchip-linux/rkbin
- git clone https://github.com/u-boot/u-boot
- modified the following files:

```
diff --git a/arch/arm/dts/rk3568-generic.dts b/arch/arm/dts/rk3568-gener=
ic.dts
index 88eb1bfd..847ebd51 100644
--- a/arch/arm/dts/rk3568-generic.dts
+++ b/arch/arm/dts/rk3568-generic.dts
@@ -16,7 +16,7 @@
        };
=20
        chosen {
-               stdout-path =3D "serial2:1500000n8";
+               stdout-path =3D "serial1:1500000n8";
        };
 };
=20
@@ -43,6 +43,7 @@
        status =3D "okay";
 };
=20
-&uart2 {
+&uart1 {
        status =3D "okay";
 };
+
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_d=
efconfig
index e7d5e55b..aeb117e7 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -6,7 +6,7 @@ CONFIG_NR_DRAM_BANKS=3D2
 CONFIG_DEFAULT_DEVICE_TREE=3D"rk3568-generic"
 CONFIG_ROCKCHIP_RK3568=3Dy
 CONFIG_SPL_SERIAL=3Dy
-CONFIG_DEBUG_UART_BASE=3D0xFE660000
+CONFIG_DEBUG_UART_BASE=3D0xFE650000
 CONFIG_DEBUG_UART_CLOCK=3D24000000
 CONFIG_SYS_LOAD_ADDR=3D0xc00800
 CONFIG_DEBUG_UART=3Dy
```

- modified this file:=20
```
diff --git a/tools/ddrbin_param.txt b/tools/ddrbin_param.txt
index 0dfdd31..826f927 100644
--- a/tools/ddrbin_param.txt
+++ b/tools/ddrbin_param.txt
@@ -9,7 +9,7 @@ lp4_freq=3D
 lp4x_freq=3D
 lp5_freq=3D
=20
-uart id=3D
+uart id=3D1
 uart iomux=3D
 uart baudrate=3D
```

- Runned the following command:
# ./ddrbin_tool rk3566 ddrbin_param.txt ~/rkbin/bin/rk35/rk3566_ddr_920M=
Hz_v1.21.bin=20
version v1.19 20240117
chip rk3566
version 5

new bin config:
uart id: 1
modify end

The file modification date changed, so i assume it should be ok.

- Runned the following commands:
# CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm64 make generic-rk3568_de=
fconfig O=3D"build/generic-rk3568_defconfig"
#ROCKCHIP_TPL=3D'~/rkbin/bin/rk35/rk3566_ddr_920MHz_v1.21.bin'  BL31=3D'=
~/rkbin/bin/rk35/rk3568_bl31_v1.44.elf' CROSS_COMPILE=3Daarch64-linux-gn=
u- make O=3D"build/generic-rk3568_defconfig"

I have acquired the MiniLoaderAll.bin via extracting the official update=
.img from the vendor.
# rkdeveloptool db MiniLoaderAll.bin
# rkdeveloptool wl 64 '~/u-boot/build/generic-rk3568_defconfig/u-boot-ro=
ckchip.bin'

- Then i have connected my USB-UART adapter to=20
BOARD PIN 8 (GND)  -> USB UART PIN GND
BOARD PIN 10 (UART1_TX)   -> USB UART PIN RX
BOARD PIN 12 (UART1_RX)  -> USB UART PIN TX

- Started minicom:
# minicom -D /dev/ttyUSB0 -b 1500000

But i still don't get any output at all.

Any idea what iam i doing wrong here?

Best Regards,
-- ext


Jonas Karlman =C3=ADrta 2024. =C3=A1pr.. 8, H-n 21:31 =C3=B3rakor:
> Hi Z,
>
> On 2024-04-08 09:40, Mizsei Zolt=C3=A1n wrote:
>> Hi,
>>=20
>> I'm trying to get a mainline U-Boot running on the Geniatech XPI-3566=
-ZERO RK3566 based SBC [1], but all my attempts have failed so far.
>>=20
>> The SBC doesn't have any SD-Card slot, please keep this in mind!
>>=20
>> I can build U-Boot, but when I write the resulting binary to the eMMC=
 using rkdeveloptool, the boot stops and I see no output on the UART pin=
s using 1500000 baud transfer rate.
>>=20
>> My steps were the following:
>>=20
>> - git clone https://github.com/u-boot/u-boot
>> - cd u-boot
>> - CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm64 make rk3568_defconf=
ig
>
> There is no rk3568_defconfig target but generic-rk3568_defconfig may=20
> work better.
>
>> - ROCKCHIP_TPL=3D'rkbin/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin'  BL31=3D=
'rkbin/bin/rk35/rk3568_bl31_v1.44.elf' CROSS_COMPILE=3Daarch64-linux-gnu=
- make
>> - rkdeveloptool db MiniLoaderAll.bin
>> - rkdeveloptool wl 64 u-boot-rockchip.bin
>>=20
>> After that I can no longer communicate with the board via UART and it=
 no longer boots.
>
> After looking at the specification for this board it looks like GPIO=20
> pin 8 and 10 is connected to uart1 and not uart2 that is typically use=
d=20
> for debug uart on rockchip devices.
>
>>=20
>> I've built uboot countless times, I've followed all sorts of guides, =
I've tried modifying FDT and transplanting the DTS from the official SDK=
, I have tried vanilla defconfigs and tried to modify them aswell, I thi=
nk I've tried everything, but no matter what I do I just can't get it wo=
rking.
>> The vendored U-Boot works ok, but I plant to run OpenBSD, for which a=
n upstream U-Boot would be better situated (according to the OBSD mailin=
g list).
>>=20
>> Please give me some hints because I'm running out of ideas. I've spen=
t countless hours trying to get this to work but haven't succeeded.
>
> You can try changing stdout-path to "serial1:1500000n8" and enable the=20
> uart1 node in generic-rk3568.dts.
> Also change to CONFIG_DEBUG_UART_BASE=3D0xFE650000, and also use rkbin=20
> tools/ddrbin_tool and change to use uart1 on ddr bin.
>
> After that you should probably start seeing something on uart and that=20
> may help you get a little bit further.
>
> Regards,
> Jonas
>
>>=20
>> Thank You very much!
>>=20
>> Best Regards,
>>=20
>> --Z--
>>=20
>> [1] https://www.geniatech.com/product/xpi-3566-zero/

--=20
--Z--
