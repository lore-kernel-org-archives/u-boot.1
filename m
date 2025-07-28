Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFA7C83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 18:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89AC982E52;
	Mon, 28 Jul 2025 20:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="Jd3a+t3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB5E582E34; Mon, 28 Jul 2025 20:09:04 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA1682E34
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 20:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1753726124; x=1754330924; i=frank-w@public-files.de;
 bh=xoI8BvFMBES6/8G2OZXeJLIJtWy0PqqiwCScPOBAwZA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
 References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Jd3a+t3HznrHo53+1KohMBEoz5CW0ISXcScAdB5DpoSr7JNYt9NuYjmbxWPh5tfm
 6ZV5b6rZd2DlhX1pJBAM458PihAq6zQyNlKKlodmSOUNtPSdZth6rfjEvrwic4HSI
 mzTEB23sSvCerWoUwSC6oY2MTDO6svAbvchRxKhvog7t3S8youx1nSPQZac6OZv/K
 GKYZmm+Qa4xke0Ii0SRQB/GVpIRSBePalFk/m0SB6ed6ki8ZEKGBAsFO1D2HebKz/
 fmUsclhSy3A8XzrborXjpqHYj7Pu/TtA3HT0u3pX16TyTS2PL/osc5LqGoLC+jw6+
 br3EykQuemRJxIqD/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.158.239]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MStCe-1v7QXd2ydS-00NqXb; Mon, 28
 Jul 2025 20:08:43 +0200
Date: Mon, 28 Jul 2025 20:08:42 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: "Lucien.Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org,
 tien.fong.chee@altera.com, trini@konsulko.com, sjg@chromium.org,
 xypron.glpk@gmx.de, seanga2@gmail.com
CC: lucien.jheng@airoha.com, daniel@makrotopia.org
Subject: =?US-ASCII?Q?Re=3A_=5BU-Boot=2C_v2=2C_1/1=5D_misc=3A_fs=5Fl?=
 =?US-ASCII?Q?oader=3A_Add_request=5Ffirmware=5Finto?=
 =?US-ASCII?Q?=5Fbuf=5Fvia=5Fscript=28=29_for_flexible_f?=
 =?US-ASCII?Q?irmware_loading_via_U-Boot_script?=
User-Agent: K-9 Mail for Android
In-Reply-To: <f4be2285-eb0a-49c1-8595-a73a231465e8@gmail.com>
References: <20250727141609.15425-1-lucienzx159@gmail.com>
 <2f6dcd69-1e18-4a9a-a07e-9b59f79212da@mailbox.org>
 <f4be2285-eb0a-49c1-8595-a73a231465e8@gmail.com>
Message-ID: <F1C856C7-A075-4EFA-A39B-905A9C40D524@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/YEVUkkqEUKc02zTF4ZejupQzRvkvK6JPFQSh09XBtalGGsiFBK
 Vx6G37XSy0ZvoIi1O4VbxUwoG9ci7Xquhyevj0CJNnCfkH4yn1VMB4l+uGTZL+x4ifrZgVd
 sniP/Mbvo0D/uT4mbknUX94UoGi22tHlNcUBPab9R8Xvkld/uJIkQQz1ocA1iRZuP4kDtz1
 unDiPcu6fIFdq2Dl+3Gsg==
UI-OutboundReport: notjunk:1;M01:P0:jNOl9SW3CoE=;aC6l4DEzehRVEmTRQM+/3569TjE
 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
 uGp48=
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
Reply-To: frank-w@public-files.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 28=2E Juli 2025 18:34:01 MESZ schrieb "Lucien=2EJheng" <lucienzx159@gmai=
l=2Ecom>:
>
>Marek Vasut =E6=96=BC 2025/7/27 =E4=B8=8B=E5=8D=88 10:46 =E5=AF=AB=E9=81=
=93:
>> On 7/27/25 4:16 PM, Lucien=2EJheng wrote:
>>> This commit introduces a new API, request_firmware_into_buf_via_script=
(),
>>> to the fs_loader framework=2E
>>> This function allows firmware to be loaded into memory
>>> using a user-defined U-Boot script,
>>> providing greater flexibility for firmware loading scenarios that cann=
ot be handled
>>> by static file paths or device/partition selection alone=2E
>>=20
>> Please run some 'fmt -w 72' on the paragraph above=2E
>Got it=2E Will modify for the next version=2E
>> [=2E=2E=2E]
>>=20
>>> I've validated this API on the Banana Pi R3 Mini=2E Here are my test c=
ommands and logs:
>>> 1=2E=C2=A0 `env set en8811h_load_firmware 'env set fw_addr 0x46000000 =
&& env set fw_size 0x24000 && load mmc 0:3 0x46000000 /boot/EthMD32=2Edm=2E=
bin && load mmc 0:3 0x46004000 /boot/EthMD32=2EDSP=2Ebin
>>=20
>> The 'load' command sets $filesize variable AFTER the load completed=2E =
The $filesize variable contains the actual size of the loaded data=2E You w=
ill likely need to expand the script a bit:
>>=20
>> env set fw_addr 0x46000000 && env set fw_size 0x24000 && \
>> mw=2Eb ${fw_addr} 0 ${fw_size} && # Make sure the memory backing the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # firmware is initialized to som=
e valid
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # content=2E
>> load mmc 0:3 0x46000000 /boot/EthMD32=2Edm=2Ebin && \
>> if test ${filesize} -lt 0x4000 ; then # Validate that the size of loade=
d
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 # data is correct
>> =C2=A0 load mmc 0:3 0x46004000 /boot/EthMD32=2EDSP=2Ebin
>> =C2=A0 # Validate loaded data size here again
>> else
>> =C2=A0 env set fw_size 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Indicate =
failure
>> =C2=A0 exit 1
>> fi
>OK=2E I will expand the script you mention=2E
>>=20
>> [=2E=2E=2E]
>>=20
>> Looks pretty good otherwise I think , thanks !
>Thank you for your great advice=2E

Hi,

Is it possible to trigger it from uboot console?

E=2Eg=2E setting these vars from there and then call the firmware load fun=
ction and maybe network init?
regards Frank
