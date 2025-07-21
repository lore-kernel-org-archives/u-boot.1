Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08CEC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 15:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1AC831D5;
	Mon, 21 Jul 2025 17:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="Iulx/CgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13129831D6; Mon, 21 Jul 2025 17:54:07 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18881831B5
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 17:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1753113237; x=1753718037; i=frank-w@public-files.de;
 bh=CM9xGtp5b8I+VUiWYCUuK23HeB7K+0RKyRMR2vtWfzw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
 References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Iulx/CgXkVbiS/g7xsTHHes1CnfJGi7bibpOxrC159A5Mciz4JPpKTLUmYa0FgsF
 fFgRTA8W03I2zuLgsaJphD3oBJTa+B0z1AJ8zlQ1w/5Zlv1GYsr/bpWFuZ/wXkK4R
 8JX8pC/0NSpUtdvstuIrqnsSusgJzNFpVJWfO9MtrjNJPJrSKhRcHaT1GAyl99Ij8
 fg5lHjflK5nNO6shc6rvzn51E8CzGbv7YKzYzRbK0mgtYOV0sE+3q1dc00StpQ+Ga
 iTut6Xz/dhhj4JewOd8HH957zPYIKttv8i2w0QnydOlTtWopIY/4c2kwRj87NZtZW
 g8cIO6BySMuvmSVJjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.245.73.96]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hzZ-1ulLTn32nP-00wQsJ; Mon, 21
 Jul 2025 17:53:56 +0200
Date: Mon, 21 Jul 2025 17:53:54 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Tom Rini <trini@konsulko.com>, "Lucien.Jheng" <lucienzx159@gmail.com>
CC: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, tien.fong.chee@altera.com, sjg@chromium.org, 
 xypron.glpk@gmx.de, seanga2@gmail.com, lucien.jheng@airoha.com,
 daniel@makrotopia.org, albert-al.lee@airoha.com
Subject: =?US-ASCII?Q?Re=3A_=5BU-Boot=2C_v1=2C_1/1=5D_misc=3A_f?=
 =?US-ASCII?Q?s=5Floader=3A_Add_request=5Ffirmware?=
 =?US-ASCII?Q?=5Finto=5Fbuf=5Fvia=5Fenv_API_for_envi?=
 =?US-ASCII?Q?ronment-based_firmware_loading?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250721153348.GD193579@bill-the-cat>
References: <20250720150404.25844-1-lucienzx159@gmail.com>
 <f97fbf07-39c1-406a-9349-0ec84bf0300b@mailbox.org>
 <20250721153348.GD193579@bill-the-cat>
Message-ID: <DDBEE665-62DB-4CC3-86A5-6F765E2D5490@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xZiPwg6GgoB9rC3UmZyoTREs4hBas0c5HjIB2fk9yWiEDpeamWM
 IkO4U5yy0Pk6HavpU5cG+ZCpCq+rttwuBWqaGVwAy49avm2wOc05p+UFR+iZ8itWvW2Qgz4
 nuCF39klXL1Y+ybommuG5HOylB0JaMTBDbAJilMYcCwVHCGiyeArJ3iE1rRbzZkyC07uwsd
 ISLmMLFnUOM0ePdYTGE0A==
UI-OutboundReport: notjunk:1;M01:P0:eCI+LGk4/gQ=;yg7Zah8dlwtWscA2WJdSFRjYwp5
 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
 Ec1ElxnRXEAL5nuWr
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

Am 21=2E Juli 2025 17:33:48 MESZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>On Sun, Jul 20, 2025 at 10:47:50PM +0200, Marek Vasut wrote:
>> On 7/20/25 5:04 PM, Lucien=2EJheng wrote:
>> > This commit adds request_firmware_into_buf_via_env() to the fs_loader=
 driver,
>> > enabling firmware loading into a buffer
>> > using environment variables for path and size=2E
>> > It supports multiple entries via indexed variable names
>> > (e=2Eg=2E, "fw_dir0", "fw_size0")=2E
>> > This provides flexible, scriptable firmware loading without hardcoded=
 details=2E
>> >=20
>> > Signed-off-by: Lucien=2EJheng <lucienzx159@gmail=2Ecom>
>> > ---
>> > Change log:
>> > - Re-sending as previous version and add more maintainers to review=
=2E
>> >=20
>> >   drivers/misc/fs_loader=2Ec | 59 +++++++++++++++++++++++++++++++++++=
+++++
>> >   include/fs_loader=2Eh      | 18 ++++++++++++
>> >   2 files changed, 77 insertions(+)
>> >=20
>> > diff --git a/drivers/misc/fs_loader=2Ec b/drivers/misc/fs_loader=2Ec
>> > index 66803f4b997=2E=2Ea4f4448f5cc 100644
>> > --- a/drivers/misc/fs_loader=2Ec
>> > +++ b/drivers/misc/fs_loader=2Ec
>> > @@ -228,6 +228,65 @@ int request_firmware_into_buf(struct udevice *de=
v,
>> >   	return ret;
>> >   }
>> >=20
>> > +/**
>> > + * request_firmware_into_buf_via_env - Load firmware using environme=
nt variables=2E
>> > + * @dev: An instance of a driver=2E
>> > + * @buf: Address of buffer to load firmware into=2E
>> > + * @offset: Offset of a file for start reading into buffer=2E
>> > + * @fw_index: Index of the firmware entry to load=2E
>> > + *
>> > + * This function loads firmware into the provided buffer using envir=
onment
>> > + * variables to determine the firmware file path, address, and size=
=2E It supports
>> > + * multiple firmware entries by using indexed environment variable n=
ames such as
>> > + * "fw_dir0", "fw_size0", etc=2E
>>=20
>> To make this really scriptable, this code has to run a script which doe=
s the
>> firmware loading and then points the U-Boot code to the buffer with dat=
a in
>> it=2E
>>=20
>> Instead of "fw_index", use "char *script_name" or some such=2E Then, ru=
n the
>> script=2E The script should set up two environment variables, call them=
 e=2Eg=2E
>> "fw_addr" and "fw_size" or some such =2E Then, this code should read th=
e two
>> environment variables, validate them, and possibly copy their content i=
nto
>> $buf =2E Finally, the code should always unset fw_addr and fw_size =2E
>>=20
>> Note that request_firmware_into_buf_via_env() should also have 'size'
>> parameter which describes the maximum size of loaded firmware, so the c=
ode
>> could verify whether the copy of firmware into $buf would write past th=
e
>> buffer and prevent that=2E
>
>And for v4, can we please put this patch and the patch using it in the
>same series? I see there's some feedback right now from Frank on the
>other patch about how maybe this part should be implemented=2E

The airoha phy patch does not yet use the fs_loader,it uses only similar c=
oncept to be
replaced by fw_loader=2E Currently it uses own
vars and loads directly without fs_loader as far as i see=2E

For fs loader it must be more generic,so basedir and vendor and filename m=
aybe need to be separated=2E
Or vendor is part of filename=2E=2E=2Ebut in this case it is again redunda=
nt in env (could be
defined in driver),but not that easy to determine if file is in rootdir of=
 e=2Eg=2E usb=2E Then
basedir and vendor is empty,but subsystem
and part set,filename from driver=2E

Possibly vendor can be optional in fsloader so it can check with or withou=
t=2E So driver can set it but fs_loader tries first with and as fallback wi=
thout vendor string if file is not found there=2E

There are much complex subpaths (e=2Eg=2E
mediatek/mt7996, i know, wifi firmware not
related for bootloader, but imho we should think about it that this can ha=
ppen)

regards Frank
