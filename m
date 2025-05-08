Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E5FC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 11:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF9E1822D7;
	Thu,  8 May 2025 13:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="di+nI77k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E9A82153; Thu,  8 May 2025 13:55:57 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6243082153
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 13:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 548BtmdP1659644
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 06:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746705348;
 bh=1CKQurXvGrPvLCa7yvHugawb8jipj7vt+BZYIPxopOQ=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=di+nI77kmJl4aDY3jMFqeoSZbYf4Nq5CPEn/EEfsqJjuMD8uMS7MJTqmtgCbqNOhI
 pU5L6/ukdcCipLuaCyxSaKuAolIY0mPA3oK1WA9jKiNUKW9NqRBCFJRiibVxbD8RvH
 nBs+BspkysAIpje8FR1Iy2WYNFG0oTMMgcl8VPzM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 548BtmJ4068894
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 8 May 2025 06:55:48 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 May 2025 06:55:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 May 2025 06:55:48 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 548BtlBT028081;
 Thu, 8 May 2025 06:55:48 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 8 May 2025 17:25:26 +0530
Message-ID: <D9QRD18KX8RE.2B9GYFBL8G5WN@ti.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <cfsworks@gmail.com>,
 <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 4/7] arm: dts: k3-{j721s2/j784s4}-binman: Pack HSM
 firmware inside tispl.bin
From: Anshul Dalal <anshuld@ti.com>
To: Andrew Davis <afd@ti.com>, Beleswar Prasad Padhi <b-padhi@ti.com>,
 <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250506104202.16741-1-b-padhi@ti.com>
 <20250506104202.16741-5-b-padhi@ti.com> <D9PTUSDYSWS0.J9VVKD57OPPM@ti.com>
 <218f2201-6094-4a93-aae6-e919cbeeda56@ti.com>
 <2fb353e4-b119-40d8-9eb2-717ec2422eaa@ti.com>
In-Reply-To: <2fb353e4-b119-40d8-9eb2-717ec2422eaa@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Wed May 7, 2025 at 8:53 PM IST, Andrew Davis wrote:
> On 5/7/25 9:56 AM, Beleswar Prasad Padhi wrote:
>>=20
>> On 5/7/2025 3:09 PM, Anshul Dalal wrote:
>>> On Tue May 6, 2025 at 4:11 PM IST, Beleswar Padhi wrote:
>>>> Pack the HSM firmware in tispl.bin fit image so that it can be unloade=
d
>>>> and used by R5 SPL to boot the HSM core. By default, point to the
>>>> firmware for HS-SE device type. This needs to be changed to point to
>>>> appropriate firmware when using a different device type.
>>>>
>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>> ---
>>>> v2: Changelog:
>>>> None to this patch.
>>>>
>>>> Link to v1:
>>>> https://lore.kernel.org/all/20250422095430.363792-4-b-padhi@ti.com/
>>>>
>>>> =C2=A0 arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
>>>> =C2=A0 arch/arm/dts/k3-j784s4-binman.dtsi | 14 ++++++++++++++
>>>> =C2=A0 2 files changed, 26 insertions(+)
>>>>
>>>> diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721=
s2-binman.dtsi
>>>> index 73af184d27e..9c8b29f53bb 100644
>>>> --- a/arch/arm/dts/k3-j721s2-binman.dtsi
>>>> +++ b/arch/arm/dts/k3-j721s2-binman.dtsi
>>>> @@ -273,6 +273,14 @@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>>> +#ifdef CONFIG_K3_HSM_FW
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hsm {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hsm: blob-ext {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filen=
ame =3D "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 };
>>>> +#endif
>>>> +
>>> Why do we have the hsm binaries pre-signed? Having a common binary like
>>> the DM with signing using ti-secure might be a better option.
>>=20
>>=20
>> Andrew can correct me if I am wrong,
>> HSM is meant to run secure software stack and services like Authenticati=
on etc. It is a +1 to TIFS. To establish ROT, we need the HSM binary to be =
encrypted, and authenticated by TIFS first before it can do stuff by itself=
. DM is not a secure entity, so signing the image doesn't make sense for me=
.
>>=20
>
> I think Anshul is not suggesting that the HSM binary be unencrypted/unaut=
henticated.
> Rather that the encrypting/signing be done here in binman like we do with=
 TF-A/OP-TEE.
> (which both are part trusted images to be loaded by TIFS).
>
> To that suggestion I agree, the customer will be doing the signing of thi=
s binary, right?
> If so then since all other customer signing is done as part of binman, it=
 makes sense
> to also sign HSM firmware here too.
>

Yeah, that is what I was going for. With that change it could be
possible to also have a single binary for all platforms (gp, hs, hs-fs)
in ti-linux-firmware?

Also, why are we not adding an unsigned variant of the hsm binary in
tispl.bin_unsigned?

[snip]
