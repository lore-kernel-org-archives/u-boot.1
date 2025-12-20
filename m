Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF283E6689E
	for <u-boot@archiver.kernel.org>; Sat, 20 Dec 2025 10:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C3BC80325;
	Sat, 20 Dec 2025 11:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511C3803F5; Sat, 20 Dec 2025 11:12:30 +0100 (CET)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::190b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11F1580050
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 11:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dYKvv4zJzzRQ6;
 Sat, 20 Dec 2025 11:12:27 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dYKvt6rrgzWDl; Sat, 20 Dec 2025 11:12:26 +0100 (CET)
Date: Sat, 20 Dec 2025 11:12:26 +0100
From: Quentin Schulz <foss+uboot@0leil.net>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/3=5D_doc=3A_cmd=3A_bdinfo=3A_sp?=
 =?US-ASCII?Q?ecify_required_dependency_for_some_info?=
In-Reply-To: <0b319cf5-35b3-4b5c-ae12-8a1a8cb7f2d0@gmx.de>
References: <20251218-b4-bdinfo-doc-v2-0-2fb328750026@cherry.de>
 <20251218-b4-bdinfo-doc-v2-2-2fb328750026@cherry.de>
 <0b319cf5-35b3-4b5c-ae12-8a1a8cb7f2d0@gmx.de>
Message-ID: <0976B2BC-F123-4BBF-972F-3FB0A7DA1569@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Infomaniak-Routing: alpha
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

On December 20, 2025 12:10:48 AM GMT+01:00, Heinrich Schuchardt <xypron=2Eg=
lpk@gmx=2Ede> wrote:
>On 12/18/25 12:44, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>>=20
>> The devicetree, current eth and IP addr info are only available when
>> certain symbols are defined, so let's make the dependencies explicit=2E
>>=20
>> Signed-off-by: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>> ---
>>   doc/usage/cmd/bdinfo=2Erst | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>=20
>> diff --git a/doc/usage/cmd/bdinfo=2Erst b/doc/usage/cmd/bdinfo=2Erst
>> index a139c9d855c=2E=2E2a5873a400a 100644
>> --- a/doc/usage/cmd/bdinfo=2Erst
>> +++ b/doc/usage/cmd/bdinfo=2Erst
>> @@ -77,9 +77,13 @@ Build
>>   current eth
>>       name of the active network device
>>   +    Only shown if CONFIG_NET=3Dy or CONFIG_NET_LWIP=3Dy=2E
>
>Thank you for updating the documentation=2E
>
>I think we should get rid of all of this CONFIG_NET || CONFIG_NET_LWIP st=
uff and have a single symbol identifying network support in future=2E
>
>For maintainability and readability I would prefer
>
>"Only shown if network support is enabled=2E"
>

Good thing I wasn't the only one bothered by this :) I'm working on someth=
ing but it'll have to wait for me to return from holidays for it to be sent=
 to the ML=2E If you want a sneak peek: https://source=2Edenx=2Ede/u-boot/c=
ontributors/qschulz/u-boot/-/tree/b4/net-kconfig

I prefer to make this separate from this series so this isn't blocked by a=
 big series (big not in terms of patches but in terms of modified files)=2E

>
>
>> +
>>   IP addr
>>       network address, value of the environment variable *ipaddr*
>>   +    Only shown if CONFIG_NET=3Dy or CONFIG_NET_LWIP=3Dy=2E
>
>ditto
>
>> +
>>   fdt_blob
>>       address of U-Boot's own device tree, NULL if none
>>   @@ -95,6 +99,8 @@ lmb_dump_all
>
>The LMB information of course depends on CONFIG_LMB=3Dy=2E
>

Indeed, missed that=2E

>>   devicetree
>>       source of the device-tree
>>   +    Only shown if CONFIG_LMB=3Dy and CONFIG_OF_REAL=3Dy=2E
>
>The dependency of the devicetree output on LMB is a bug in cmd/bdinfo=2Ec=
 and should be fixed=2E
>

Will try to fix that=2E Seems like it was introduced in https://source=2Ed=
enx=2Ede/u-boot/contributors/qschulz/u-boot/-/commit/85007da94bad2d27e40e02=
58fa5437a35034ee1d so probably an oversight=2E

Note that we're missing a few "fields" as displayed by this command=2E E=
=2Eg=2E whenever VIDEO, DM_SERIAL, MULTI_DTB_FIT and CMD_BDINFO_EXTRA are s=
et=2E

Cheers,
Quentin
Hi Heinrich,
