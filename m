Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5D4C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 11:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7878087CC1;
	Thu, 15 Feb 2024 12:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ID+gxKIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 604CC87D5E; Thu, 15 Feb 2024 06:29:40 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FF828772A
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 06:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=steven.hill@konsulko.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51197ca63f5so619592e87.1
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 21:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707974977; x=1708579777; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ewMenJoK1c2UUi2UpTGvuSY+tzXKh6NTNNHC2cwX+Lw=;
 b=ID+gxKIqjPmPOcK937kaOqGZrunhyzRq44LmuKzx+XxN8EA14NTLewzR+e6LkMAnRZ
 VwMbN9oL3x/cvD5FA1tMiFh+8z82Q48168AqbKJLOHhMaTaK2WiayurAu2NMe/D0Iord
 6TeI4Em54RfRCJBvp4r7e2xkeBCNvBtfxdV00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707974977; x=1708579777;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ewMenJoK1c2UUi2UpTGvuSY+tzXKh6NTNNHC2cwX+Lw=;
 b=gzjT8NauwrePtSeNVk7/qch6jV0ZO0Dppc2OO9rHjRC4psjDYYYviGmB9/qHzm8lK6
 l1Spu4BWU30oK5j6hfCHx5f2Jy6KjN/mNYsSKgeFqVyN/pKMyAvCFyEvs1RiU4LLq00C
 AHiXwiud66DZ8GNAwHzuic4ncyc6ODZc5vscpSeYRRVwGD600u9ueQCCcXkkNk7WaKoj
 Pg+aPKQlFnu/A5w0rT6PjYA6q8egwTc6dBf7Pu5yLFabnTAaDwAQs/R2i2cvIFnxK4J6
 FvYC34McssbPLja84TL/u9dgd1kr8YUKs3VQ1O+6A5o9WLE5i/XmAQ95QkTq4Nk5P7g9
 FRfA==
X-Gm-Message-State: AOJu0Yxi/6tUcKy/6iqnATQqhXhCFAjGervKtXXWqu+grl6F8TvKyr+z
 RFds7j7CCuI+S6rp2zWAuqtHvXpEIiW9G8FDN/IvU5RvN3o7k7hPG7mleLEIMbj+ukD2rsX+s30
 bWjJU1Q2N+RWJ3UdbhHju1D62ZfZJmJrddExVrz1FVsLe+OmOtlWpvw==
X-Google-Smtp-Source: AGHT+IE27J5NVMS1o89Bu4CFgDyJdQy8MY8xusaSuPRboVD27nocOnkbKVm2gnZa0zVk4C+g8uCbLTTCb7m2ZmeHdnY=
X-Received: by 2002:ac2:51aa:0:b0:511:69bf:d1f7 with SMTP id
 f10-20020ac251aa000000b0051169bfd1f7mr687915lfk.50.1707974977211; Wed, 14 Feb
 2024 21:29:37 -0800 (PST)
MIME-Version: 1.0
From: Steven Hill <steven.hill@konsulko.com>
Date: Wed, 14 Feb 2024 23:29:26 -0600
Message-ID: <CAJf3FBCEZ_6w1YXEP8R2L69gOO2ud7CCbLH+AA8aazH=jM6T=w@mail.gmail.com>
Subject: TI LCD Driver and splash screen.
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: multipart/mixed; boundary="000000000000ce482c061164e944"
X-Mailman-Approved-At: Thu, 15 Feb 2024 12:30:49 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

--000000000000ce482c061164e944
Content-Type: text/plain; charset="UTF-8"

Hello.

I am bringing up a new am335x platform and need splash screen support. I
already wrote new backlight and LCD panel Linux drivers for the platform.
The kernel side is solid. I brought the device tree and backlight driver
from the kernel and put it into v2023.04 U-Boot. Currently getting a
"cannot allocate frame buffer memory error" and have tried a bunch of
different things. I have attached my current defconfig. The panel/graphics
portion in the device tree I copied from arch/arm/dts/am335x-brxre1.dts to
start. Was hoping people had some pointers or ideas.

Cheers,

Steve

--000000000000ce482c061164e944
Content-Type: application/octet-stream; 
	name=am335x_metrohm_dsplus_defconfig
Content-Disposition: attachment; filename=am335x_metrohm_dsplus_defconfig
Content-Transfer-Encoding: base64
Content-ID: <f_lsmrz8vr0>
X-Attachment-Id: f_lsmrz8vr0

Q09ORklHX0FSTT15CkNPTkZJR19BUkNIX0NQVV9JTklUPXkKQ09ORklHX0FSQ0hfT01BUDJQTFVT
PXkKQ09ORklHX1RJX0NPTU1PTl9DTURfT1BUSU9OUz15CkNPTkZJR19IQVNfQ1VTVE9NX1NZU19J
TklUX1NQX0FERFI9eQpDT05GSUdfQ1VTVE9NX1NZU19JTklUX1NQX0FERFI9MHg0MDMwZmYwMApD
T05GSUdfRU5WX1NJWkU9MHgxMDAwMApDT05GSUdfREVGQVVMVF9ERVZJQ0VfVFJFRT0iYW0zMzV4
LW1ldHJvaG0tZHNwbHVzIgpDT05GSUdfQU0zM1hYPXkKQ09ORklHX1RBUkdFVF9BTTMzNVhfTUVU
Uk9ITV9EU1BMVVM9eQpDT05GSUdfQ0xPQ0tfU1lOVEhFU0laRVI9eQpDT05GSUdfQU0zMzVYX1VT
QjA9eQpDT05GSUdfQU0zMzVYX1VTQjBfUEVSSVBIRVJBTD15CkNPTkZJR19BTTMzNVhfVVNCMT15
CkNPTkZJR19TUEw9eQpDT05GSUdfVElNRVNUQU1QPXkKQ09ORklHX1NQTF9MT0FEX0ZJVD15CiMg
Q09ORklHX0JPT1RNRVRIX1ZCRSBpcyBub3Qgc2V0CkNPTkZJR19ESVNUUk9fREVGQVVMVFM9eQpD
T05GSUdfU0RfQk9PVD15CkNPTkZJR19PRl9CT0FSRF9TRVRVUD15CkNPTkZJR19GRFRfU0lNUExF
RkI9eQpDT05GSUdfQk9PVENPTU1BTkQ9InNldGVudiBib290YXJncyBjb25zb2xlPSR7Y29uc29s
ZX0gY29uc29sZWJsYW5rPTAgcm9vdD0vZGV2L21tY2JsazBwMiBybyByb290ZnN0eXBlPWV4dDQg
cm9vdHdhaXQ7IGxvYWQgbW1jIDA6MSAke2ZkdGFkZHJ9IGFtMzM1eC1tZXRyb2htLWRzcGx1cy5k
dGI7IGxvYWQgbW1jIDA6MSAke2xvYWRhZGRyfSB6SW1hZ2U7IGJvb3R6ICR7bG9hZGFkZHJ9IC0g
JHtmZHRhZGRyfSIKQ09ORklHX0xPR0xFVkVMPTMKIyBDT05GSUdfQ09OU09MRV9NVVggaXMgbm90
IHNldApDT05GSUdfU1lTX0NPTlNPTEVfSU5GT19RVUlFVD15CiMgQ09ORklHX1NZU19ERVZJQ0Vf
TlVMTERFViBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX01JU0NfSU5JVD15CkNPTkZJR19TUExfRklU
X0lNQUdFX1RJTlk9eQpDT05GSUdfU1BMX0VUSD15CiMgQ09ORklHX1NQTF9GU19FWFQ0IGlzIG5v
dCBzZXQKQ09ORklHX1NQTF9GU19MT0FEX1BBWUxPQURfTkFNRT0idS1ib290LmltZyIKQ09ORklH
X1NQTF9NVVNCX05FVz15CiMgQ09ORklHX1NQTF9OQU5EX1NVUFBPUlQgaXMgbm90IHNldApDT05G
SUdfU1BMX05BTkRfRUNDPXkKQ09ORklHX1NQTF9ORVQ9eQpDT05GSUdfU1BMX05FVF9WQ0lfU1RS
SU5HPSJBTTMzNXggVS1Cb290IFNQTCIKQ09ORklHX1NQTF9PU19CT09UPXkKQ09ORklHX1NQTF9G
QUxDT05fQk9PVF9NTUNTRD15CkNPTkZJR19TWVNfTU1DU0RfUkFXX01PREVfS0VSTkVMX1NFQ1RP
Uj0weDE3MDAKQ09ORklHX1NZU19NTUNTRF9SQVdfTU9ERV9BUkdTX1NFQ1RPUj0weDE1MDAKQ09O
RklHX1NZU19NTUNTRF9SQVdfTU9ERV9BUkdTX1NFQ1RPUlM9MHgyMDAKQ09ORklHX1NQTF9ZTU9E
RU1fU1VQUE9SVD15CkNPTkZJR19TWVNfTUFYQVJHUz02NAojIENPTkZJR19DTURfQk9PVEZMT1cg
aXMgbm90IHNldAojIENPTkZJR19CT09UTV9ORVRCU0QgaXMgbm90IHNldAojIENPTkZJR19CT09U
TV9QTEFOOSBpcyBub3Qgc2V0CiMgQ09ORklHX0JPT1RNX1JURU1TIGlzIG5vdCBzZXQKIyBDT05G
SUdfQk9PVE1fVlhXT1JLUyBpcyBub3Qgc2V0CkNPTkZJR19TWVNfQk9PVE1fTEVOPTB4MTAwMDAw
MAojIENPTkZJR19DTURfRUxGIGlzIG5vdCBzZXQKIyBDT05GSUdfQ01EX1hJTUcgaXMgbm90IHNl
dApDT05GSUdfU1lTX0kyQ19FRVBST01fQUREUl9MRU49MgojIENPTkZJR19DTURfTE9BRFMgaXMg
bm90IHNldAojIENPTkZJR19DTURfU0VURVhQUiBpcyBub3Qgc2V0CkNPTkZJR19CT09UUF9ETlMy
PXkKIyBDT05GSUdfQk9PVFBfUFhFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ01EX0NMUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NQTF9FRklfUEFSVElUSU9OIGlzIG5vdCBzZXQKQ09ORklHX09GX0NPTlRS
T0w9eQpDT05GSUdfRU5WX09WRVJXUklURT15CkNPTkZJR19TWVNfUkVMT0NfR0RfRU5WX0FERFI9
eQpDT05GSUdfRU5WX1ZBUlNfVUJPT1RfUlVOVElNRV9DT05GSUc9eQpDT05GSUdfU1BMX0VOVl9J
U19OT1dIRVJFPXkKQ09ORklHX1ZFUlNJT05fVkFSSUFCTEU9eQpDT05GSUdfTkVUX1JFVFJZX0NP
VU5UPTEwCkNPTkZJR19CT09UUF9TRU5EX0hPU1ROQU1FPXkKQ09ORklHX1JFR01BUD15CkNPTkZJ
R19CT09UQ09VTlRfTElNSVQ9eQpDT05GSUdfU1lTX0JPT1RDT1VOVF9CRT15CkNPTkZJR19DTEs9
eQpDT05GSUdfQ0xLX1RJX0FNM19EUExMPXkKQ09ORklHX0RGVV9URlRQPXkKQ09ORklHX0RGVV9N
TUM9eQpDT05GSUdfREZVX1JBTT15CkNPTkZJR19NSVNDPXkKQ09ORklHX1NZU19JMkNfRUVQUk9N
X0FERFI9MHg1MAojIENPTkZJR19NTUNfSFdfUEFSVElUSU9OSU5HIGlzIG5vdCBzZXQKQ09ORklH
X01NQ19PTUFQX0hTPXkKQ09ORklHX1BIWV9BVEhFUk9TPXkKQ09ORklHX1BIWV9TTVNDPXkKQ09O
RklHX1BIWV9HSUdFPXkKQ09ORklHX01JST15CkNPTkZJR19EUklWRVJfVElfQ1BTVz15CkNPTkZJ
R19ETV9QTUlDPXkKIyBDT05GSUdfU1BMX0RNX1BNSUMgaXMgbm90IHNldApDT05GSUdfUE1JQ19U
UFM2NTIxNz15CkNPTkZJR19USU1FUj15CkNPTkZJR19PTUFQX1RJTUVSPXkKQ09ORklHX1VTQj15
CkNPTkZJR19ETV9VU0JfR0FER0VUPXkKQ09ORklHX1NQTF9ETV9VU0JfR0FER0VUPXkKQ09ORklH
X1VTQl9NVVNCX0hPU1Q9eQpDT05GSUdfVVNCX01VU0JfR0FER0VUPXkKQ09ORklHX1VTQl9NVVNC
X1RJPXkKQ09ORklHX1VTQl9HQURHRVQ9eQpDT05GSUdfU1BMX1VTQl9HQURHRVQ9eQpDT05GSUdf
VVNCX0dBREdFVF9NQU5VRkFDVFVSRVI9IlRleGFzIEluc3RydW1lbnRzIgpDT05GSUdfVVNCX0dB
REdFVF9WRU5ET1JfTlVNPTB4MDQ1MQpDT05GSUdfVVNCX0dBREdFVF9QUk9EVUNUX05VTT0weGQw
MjIKQ09ORklHX1VTQl9HQURHRVRfRE9XTkxPQUQ9eQpDT05GSUdfVklERU89eQpDT05GSUdfVklE
RU9fTE9HTz15CiMgQ09ORklHX0NPTlNPTEVfTk9STUFMIGlzIG5vdCBzZXQKQ09ORklHX0NPTlNP
TEVfUk9UQVRJT049eQpDT05GSUdfQkFDS0xJR0hUX0xNMzUwOT15CkNPTkZJR19BTTMzNVhfTENE
PXkKQ09ORklHX1ZJREVPX1NJTVBMRT15CkNPTkZJR19TUExBU0hfU0NSRUVOPXkKQ09ORklHX1NQ
TEFTSF9TQ1JFRU5fQUxJR049eQpDT05GSUdfQk1QPXkKQ09ORklHX1ZJREVPX0xPR09fTUFYX1NJ
WkU9MHgxMDAwCkNPTkZJR19CTVBfMTZCUFA9eQpDT05GSUdfQk1QXzI0QlBQPXkKQ09ORklHX0JN
UF8zMkJQUD15CkNPTkZJR19XRFQ9eQojIENPTkZJR19TUExfV0RUIGlzIG5vdCBzZXQKQ09ORklH
X0RZTkFNSUNfQ1JDX1RBQkxFPXkKQ09ORklHX1JTQT15CkNPTkZJR19MWk89eQojIENPTkZJR19F
RklfTE9BREVSIGlzIG5vdCBzZXQK
--000000000000ce482c061164e944--
