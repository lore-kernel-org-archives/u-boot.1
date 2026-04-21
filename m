Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF33FF8FA6A
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8ABA84376;
	Tue, 21 Apr 2026 14:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DB+ohToW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A2384390; Tue, 21 Apr 2026 12:32:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F289842B7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 12:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776767522; x=1777372322; i=xypron.glpk@gmx.de;
 bh=8xNFAn7MIQPylTVh6diuDjgBIl+Xr2Cbnji/q8ZfF/E=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DB+ohToWTL3qQZbpIWGbr7Sj9GQL2czFXzzmh9+Nga+DvF57CZW6ruYaR2kw7HL9
 oBVIq4FdghyiSu/+uv+lUrX+eT+OzWd2kx5ETWvcvL8sOPj5vEwMTQ7rxYDeb1S6G
 RNUT5+a32QnUTnBvNPoleA9Ug3dcfh5TDg4FGHlXusUHf14T/aX1h5LMTxy+E1EmB
 g5kNAyq81lRADLY34DuWD79OWg1nXduU8gXRzT+DOv3SiOaySSZOyqw2npbnF3Q0H
 SF+CN/vkajmze5fcXuhyp0Z7wRI25OFvUUBTYvxFgkj+wkfg6eO2Vm7xRwPpvqOYP
 n80wtBxRt8LExWcafA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89Gt-1wIguA1wg7-00BErg; Tue, 21
 Apr 2026 12:32:02 +0200
Date: Tue, 21 Apr 2026 12:31:30 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com,
 Paul Barker <paul.barker.ct@bp.renesas.com>
CC: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Udit Kumar <u-kumar1@ti.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adam Ford <aford173@gmail.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Tim Harvey <tharvey@gateworks.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Gilles Talis <gilles.talis@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Stefan Roese <sr@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, Fabio Estevam <festevam@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Maarten Brock <Maarten.Brock@sttls.nl>,
 Kory Maincent <kory.maincent@bootlin.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Anshul Dalal <anshuld@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Martin Schwan <m.schwan@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 David Lechner <dlechner@baylibre.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Beiyan Yun <root@infi.wang>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Shantur Rathore <i@shantur.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Sky Huang <SkyLake.Huang@mediatek.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/6=5D_net=3A_make_NET_a_menuconfig?=
 =?US-ASCII?Q?_=28and_downgrade_NO=5FNET_to_a_simple_config=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <4bc9cdaf-38bc-4edf-b19f-d7301c84b49c@cherry.de>
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <20260420-net-kconfig-v1-3-9900002d8e72@cherry.de>
 <18031190-2B66-4DEF-8382-6CB9DCCFA3A1@gmx.de>
 <4bc9cdaf-38bc-4edf-b19f-d7301c84b49c@cherry.de>
Message-ID: <F8BBB1E8-BD83-4D66-9D27-6C109ADCCB63@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1FZkZEMrGCy4Jj1S/4e1P9sX2e3Az9RpnAjbFZ973p8AzwHq1Ki
 3woaf7djBzQTtv55BErwRt2gne+g+S3t2CWM21q2W8fkp245fr2usrTx5P4iXXzX8mujIVe
 YRt1jLoA70z0xg45rIZ6erzI1Afc4pvfzMSKVxp35nvfY74dPirVP5HRxSErjeCYoKphlxe
 SP0cuc8B1/QFKoVB97RjQ==
UI-OutboundReport: notjunk:1;M01:P0:l9t6g3ROakY=;OM2HATVPdAR3mEbf8sb6P1Xtw8e
 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
 JO72og==
X-Mailman-Approved-At: Tue, 21 Apr 2026 14:37:42 +0200
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

Am 21=2E April 2026 10:37:54 MESZ schrieb Quentin Schulz <quentin=2Eschulz@=
cherry=2Ede>:
>Hi Heinrich,
>
>On 4/20/26 10:24 PM, Heinrich Schuchardt wrote:
>> Am 20=2E April 2026 13:36:09 MESZ schrieb Quentin Schulz <foss+uboot@0l=
eil=2Enet>:
>>> From: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>>>=20
>>> This will allow a bunch of simplifications across the code base=2E
>>> Disabling NET is the equivalent of today's NO_NET choice=2E This means
>>> that if NET is enabled, either the legacy or lwIP stack is necessarily
>>> selected, which allows us to simplify if NET_LEGACY || NET_LWIP into
>>> if NET in a later commit=2E
>>>=20
>>> Config fragments - or defconfigs including other defconfigs - setting
>>> the network stack (NET_LEGACY or NET_LWIP) must also set NET (or unset
>>> NO_NET) if the config they apply to - or the included defconfigs -
>>> unsets NET (or selects NO_NET) as otherwise the NET_LEGACY and NET_LWI=
P
>>> symbols are unreachable=2E This is the case for the two defconfig modi=
fied
>>> in this commit=2E
>>>=20
>>> NO_NET is now a convenience symbol which hides NET entirely to avoid
>>> modifying many defconfigs=2E If one selected NO_NET to disable the
>>> networking stack in the past, this will still work for now=2E Technica=
lly,
>>> we should be using the "transitional" Kconfig attribute but that is on=
ly
>>> available since Kconfig from Linux kernel v6=2E18 and we're on 6=2E1 r=
ight
>>> now=2E
>>>=20
>>> Note that this moves CONFIG_SYS_RX_ETH_BUFFER from under the Network
>>> menu back into the main menu as it seems like it needs to be defined
>>> even when there's no need for NET support at all and menuconfig option
>>> doesn't work the same way as a menu=2E
>>>=20
>>> Signed-off-by: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>>> ---
>>>=20
>>> I'd say we should have everything net-related depends on NET as well,
>>> so that disabling networking support with NET=3Dn is also disabling
>>> anything related (e=2Eg=2E Ethernet controller and PHY drivers, USB
>>> Ethernet, USB gadget CDC/RNDIS, network CLI commands, etc=2E)=2E
>>> ---
>>> configs/am62px_evm_r5_ethboot_defconfig |  2 +-
>>> configs/j722s_evm_r5_ethboot_defconfig  |  2 +-
>>> net/Kconfig                             | 23 ++++++++++++-----------
>>> 3 files changed, 14 insertions(+), 13 deletions(-)
>>>=20
>>> diff --git a/configs/am62px_evm_r5_ethboot_defconfig b/configs/am62px_=
evm_r5_ethboot_defconfig
>>> index 8baec9d43ff=2E=2Edf49324b25a 100644
>>> --- a/configs/am62px_evm_r5_ethboot_defconfig
>>> +++ b/configs/am62px_evm_r5_ethboot_defconfig
>>> @@ -5,7 +5,7 @@ CONFIG_ARCH_K3=3Dy
>>> CONFIG_SOC_K3_AM62P5=3Dy
>>> CONFIG_TARGET_AM62P5_R5_EVM=3Dy
>>> CONFIG_DEFAULT_DEVICE_TREE=3D"k3-am62p5-r5-sk"
>>> -CONFIG_NET_LEGACY=3Dy
>>> +# CONFIG_NO_NET is not set
>>=20
>> Does this imply that NET_LEGACY is the default? Choosing LEGACY as defa=
ult would not be plausible to me=2E We should use LWIP as default=2E Then e=
very new board will use it, hopefully=2E
>>=20
>
>(below, "current" means the value in master branch, so before this series=
 is applied)=2E
>
>(current) CONFIG_NET is the default already, see https://source=2Edenx=2E=
de/u-boot/u-boot/-/blob/master/Kconfig#L794-L824=2E This series does not ai=
m to change anything but the name of the symbols=2E Yes, we could make NET_=
LWIP the new default stack, but not in this series=2E Also, we have an issu=
e that if you enable SPL_NET you need the legacy stack, even in proper (acc=
ording to https://source=2Edenx=2Ede/u-boot/u-boot/-/blob/master/common/spl=
/Kconfig#L1152-L1154)=2E So we would need to tackle this first (we don't ne=
cessarily need to support lwIP in SPL, just that the choice in SPL shouldn'=
t impact the choice in proper)=2E
>
>If you're asking about this defconfig specifically, it's simply because i=
t is not a typical defconfig=2E It includes configs/am62px_evm_r5_defconfig=
 which sets CONFIG_NO_NET=3Dy=2E Because NO_NET used to (before this series=
) be a choice with (current) NET and NET_LWIP, am62px_evm_r5_ethboot_defcon=
fig needed to override it with another choice, namely (current) NET=2E Beca=
use NET_LEGACY is automatically selected when NO_NET is unset (due to NET d=
efault y), we only need to unset NO_NET in configs/am62px_evm_r5_ethboot_de=
fconfig to restore the current state of enabling the legacy stack (current =
NET, now NET_LEGACY)=2E This is not changing anything, just moving things a=
round=2E
>
>Does this answer your question?
>
>Cheers,
>Quentin


Acked-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
