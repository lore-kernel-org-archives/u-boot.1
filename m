Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA16C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 08:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D44888B58;
	Thu, 18 Jul 2024 10:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XR9CewPp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB03F88B06; Thu, 18 Jul 2024 10:24:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DFA688AE5
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721291010; x=1721895810; i=xypron.glpk@gmx.de;
 bh=6638/Zh3L2yQjsYHc7R2SivXw2sBVsE1gpIGXSiz0z8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XR9CewPpmMaP8EDxBt3LdzQ71qtG0INxKM318orBqlPdzZyEkK4gWa5Q9R1L1KvS
 GpECaaSPO62PKYJE0iDDeO1hetfK3Z4QUlyKHSk5yZjd8MNT93OjKnLqx9HC6HR+7
 B9nJ9nE1WnpkVqIbP/UGfJhhcxbsnGLaswcr4jScARICMclDQP+ggSLOupRk7xC0t
 trUlhiSWESD1q/7NS/9qTzlYkc4rknao/7pASrNsB8LZN8RhoX9CP1P0/fRJ9adJC
 BxbWQB+6TsX0hEfsmZ/QVTlPv0TLY1FNpPOpyCpRktmLghZaT6g+9hIPouPs4JyUA
 R0B38Vs5kCDnrovb2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1snGke3vlN-00WxNt; Thu, 18
 Jul 2024 10:23:30 +0200
Message-ID: <89fa43bd-dbf3-4bc7-b4ba-29c3cc579a9a@gmx.de>
Date: Thu, 18 Jul 2024 10:23:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/21] Universal Payload initial series
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 michal.simek@amd.com, seanga2@gmail.com, sheng.tan@9elements.com,
 akashi.tkhro@gmail.com, abdellatif.elkhlifi@arm.com, agendin@matrox.com,
 linux.amoon@gmail.com, andre.przywara@arm.com, afd@ti.com,
 artur@conclusive.pl, bmeng.cn@gmail.com, bb@ti.com,
 caleb.connolly@linaro.org, chanho61.park@samsung.com, devarsht@ti.com,
 eajames@linux.ibm.com, etienne.carriere@foss.st.com,
 francis.laniel@amarulasolutions.com, ilias.apalodimas@linaro.org,
 vanbaren@cideas.com, mr.bossman075@gmail.com, jonas@kwiboo.se,
 jpewhacker@gmail.com, kever.yang@rock-chips.com, leon@georgemail.eu,
 lukas.funke@weidmueller.com, abbaraju.manojsai@amarulasolutions.com,
 marek.vasut+renesas@mailbox.org, marex@denx.de, mkorpershoek@baylibre.com,
 n-jain1@ti.com, nm@ti.com, oleksandr.suvorov@foundries.io,
 pbrobinson@gmail.com, rasmus.villemoes@prevas.dk, raymond.mao@linaro.org,
 semen.protsenko@linaro.org, samuel@sholland.org, yangshiji66@outlook.com,
 sughosh.ganu@linaro.org, sumit.garg@linaro.org, sunil@amarulasolutions.com,
 tom@tom-fitzhenry.me.uk, troykiskyboundary@gmail.com
References: <20240713070055.2172883-1-sjg@chromium.org>
 <87a5iliubh.fsf@bloch.sibelius.xs4all.nl>
 <09FB197A-06C8-4162-AAB6-3823BA2840B3@gmx.de>
 <20240716190852.GL561963@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240716190852.GL561963@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P5XTRJE42dcHDfs3Q9Xhqb7oX14aiESB26VEnE0odKHPC6goY1M
 slyIDtAOxf6lRtinpyl09VXvGpo+Va+1dHUlfw1Qo9fbOz52yLGzkML7YWdKJiJ+PeBEt+2
 5VHrKDnO3FVYKPj8OrGVfLY2gnabQbBd9ZqH6FBiFl1b9BTIEARrtH1NG8a/nN67j0S62bj
 0VDvak4zZqdbFGRkaR6cw==
UI-OutboundReport: notjunk:1;M01:P0:sPs/vy5pxc8=;Sa8aUiOzJEXN0xIBvNdZncjL7xx
 hVt5RnhXt6ZZ2gePXjERt6wCExNcNwhggSom26+Tsulzd3TTqCPxmt9KqyGINkHSOkQfeOkt6
 niKHnt+j9WUfOt1NTY0j+9wkEvk1ReCXmYxmur+bybMCyFfQ2vd+WVpNkHG1tCuEyZ/EvhO8W
 fiRtyWCppDIXbiunXcYQrmBrO5BFQBo0rZhMWY+/rCitXCXXGd8VGbpm8NGYmDOcbBtgqrQOf
 0Ex7k4xpnNxop3b/GCBgZZ4Py9YSAfBQYJKM2IHRaYIt+M0m7aohBwLjybKblzYmVO8k0QDM8
 N34Sr/mj92hllPjYD08IWQNUmFze9hA3j4+A2LYEL1OkGatMA6Ifr0ehgzIsTwjiBwN3X20ye
 VTZqAI4S1p+e6CR5xMV1n172usneNCCiiLe7It1hV0lWLaNHMso+2Ecm5/Woa0CnO2GCyHIdF
 gl/0ZJO4+023qOjtY/RPmRCRmTfXZYk6nV3cpGDYTwHJ+EJV2gLftvA1CVzfSLzmVU3OtWoXa
 cgsG9jRxSUDHvKhFxGBzOKyDQ1YC+nZg4BzpKTNnr6x0sWjbBesWcljm9qKTuqoBLXj42iti9
 xNdMASECvq9lKu1x+QlbkU2KQ0/9kEpjPJ/J4vIMISb0oCzGUKlvioSsPW8o0MagHDav6iM5k
 6VHGMOLRcn+EBofAZQnxHPXxWTlZDqfIwuOKou+Dqgo7/Ty5IN/QLR30RehV8gphC6evf0Ph4
 Z5b6CGQBu7Jjrd4myOlAV3AQmHy12LcPLyU7eJI2Q8aUoPxeQoBZZ/ts6IahF+0Wq42H8WZP+
 puhxSQTbhfQYbh6qeL8ziK8A==
X-Mailman-Approved-At: Thu, 18 Jul 2024 10:35:04 +0200
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

On 16.07.24 21:08, Tom Rini wrote:
> On Sat, Jul 13, 2024 at 09:40:17PM +0200, Heinrich Schuchardt wrote:
>>
>>
>> Am 13. Juli 2024 10:12:50 MESZ schrieb Mark Kettenis <mark.kettenis@xs4=
all.nl>:
>>>> From: Simon Glass <sjg@chromium.org>
>>>> Date: Sat, 13 Jul 2024 08:00:34 +0100
>>>>
>>>> Universal Payload (UPL) is an Industry Standard for firmware
>>>> components[1].
>>>
>>> I think you have some trouble understanding the concept of industry
>>> standard ;).  I guess you want this to become an industry standard.
>>> Firmly https://xkcd.com/927/ territory if you ask me.
>>>
>>>> UPL is designed to improve interoperability within the
>>>> firmware industry, allowing mixing and matching of projects with less
>>>> friction and fewer project-specific implementations. UPL is
>>>> cross-platform, supporting ARM, x86 and RISC-V initially.
>>>>
>>>> This series provides some initial support for this, targeting 0.9.1 a=
nd
>>>> sandbox only.
>>>>
>>>> Features still to come include:
>>>> - Support for architectures
>>>> - FIT validation
>>>> - Handoff validation
>>>> - Interoperability tests
>>>>
>>>> This series is available at dm/uplb-working and requires the alist
>>>> series at dm/alist-working[2]
>>
>> Why is this series needed?
>
> Because UPL is a standard, supported by other projects, which requires
> more than Just Nothing Else on top of what we do today. Please do
> provide constructive feedback on the changes themselves, but bringing in
> UPL support proper is something we should (and will) do. Thanks!
>

SPL loading a FIT image (e.g. EDK II + OpenSBI) seems to be very close
to UPL. What is missing?

UPL is meant as the interface between two firmware pieces and not
between firmware and the OS. Why should we let main U-Boot support UPL?
Isn't SPL support sufficient?

Which other projects implement the UPL standard?

Best regards

Heinrich
