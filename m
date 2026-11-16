Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0CA606A32F
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TgbWE5o4;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5QbEObh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9248380D7B;
	Mon, 16 Nov 2026 13:08:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id njPHlqzhcqdi; Mon, 16 Nov 2026 13:08:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6FCFF80E75
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794834524;
	b=lIqMpSfTHUgJgFKiATmOT2EPWo5NMNtyJuooPsevc1MbROJCF9+IZHyzioixpseapWef
	 paICM/duVu2RdoGSFHVfXm/BmxHde89v6VayXRUmBFrR/pigMXY4PfKpk8tc2DD7pr2/B
	 33cWmwS2kJukuejtSj7wRYk2i+6HvygJZPDqrFKVXuwdFG4Xau+lo6aqthdHVMl/FYH1n
	 aBa960td7Sc7djZb/R3Ka5fWR+BNloDXhg8X88S2Xov1Yozme6wcuWKp1FJy+08eEdh7D
	 PNw771OsI1HutKealzX7VX/w66x7E59OdhnaspAeEKE8BZzuxbxZA7pB5CH9wsz+I0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794834524;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/e8Txj9Aa8va0D4HGgm7/2urpPKKAEYifpAOsZzDbXs=;
	b=lA2Zf/1GpJ6qXZM3q82uS1UYskduAsTDHIqRKJKcVxKn2Yv9VFL0R3qxR1Nocnr6FUNL
	 Zl/Ra6u6vKTthAFn1+cazQcXLkIEzXDSzMqBFsirJG/3lFmTQadnjNSpVgE+eC+gmwmdm
	 tFlOmUdn2TqY/5xc6kZXNTAcgVTxNfu+wl3lBFagXBZl4zKEKNO44KasGwDjrecC+QEjj
	 8B9oP80hEqLRlU7piagkmiYgQFPPAuey84TzwqjkDr9RANUUncoZguDp71dbx0KLkJRjE
	 fLymZqamLclDKG3O5mwec4mpn/slmUPQxnzY1u/2M7B7WWpT5tGQwW+sCsDjWyLHOcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794834524;
	bh=/e8Txj9Aa8va0D4HGgm7/2urpPKKAEYifpAOsZzDbXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TgbWE5o4JpnbPMwClTN4GOdQEZg+6lRtJ+T7L7K1Ou5T4wdc8Bj2mMW3sgtiX7t8a
	 Zi7UK784LO90blakWw22O24Cm3QfeWTtNCdW7Lejk08UgjA7MeG7K3ud13b1mXGn14
	 o74vWymb4VGp71e5OhP4zPIsEQpCNAuN3X+B5ovHOff4ASkGDydl66gjS3ofDOGW41
	 hEJOmev7/hLPP1HnvP0no+kbfogVh479mT38Q3H6qrxW4t+SOMch6dWT0JC/5ZETvb
	 73wy71pT24Gc+qSszEp9fwlSzFmRbWd7qxgAI+hoheJNX+JR+Wwq643GwcDIV3m7ke
	 KHich+FGPW4gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FCFF80E75;
	Mon, 16 Nov 2026 13:08:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 12344169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 046C24069A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:08:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vKTKc9_IS74 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 13:08:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C8ACF40693
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=I5QbEObh
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C8ACF40693
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:08:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8167162487;
 Mon, 16 Nov 2026 13:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAEE1F000CF;
 Mon, 16 Nov 2026 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794834515;
 bh=/e8Txj9Aa8va0D4HGgm7/2urpPKKAEYifpAOsZzDbXs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=I5QbEObhJPVrE/F5DPDPtYtaZXmsOmLgEVVne3x4GzKC/J/2jLeSrl3NV4zPCrNLV
 0yUqmQ2NdKBPw9Tzp3nCvsCTSd2rU2bOQ4CJfpnGHXP33jQkKbyRskcDmEKSO9I6ec
 8dcQv9ibNRRML+l1gdouzZV4CvZ46T9N2lvevcf144mR9hI9+CJ0uKQ5zqJsifta7H
 J6OAqGBUs0NeCmD+PlEg1QnutV0Ow2rnccENwXkdnshXtVIpUWNIR2Vl/ONUxR6LKw
 TEFeghSI6qqVA9LNhDEHoQX0fJdpMQoPtogWsOpdVrhJY9UW/aNIFMxqkO60221+Uz
 WfzCMxb5+Za1A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: York Sun <york.sun@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 u-boot@lists.u-boot-project.org, Sebastian Siewior
 <bigeasy@linutronix.de>, Rob Herring <robh@kernel.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Francesco Valla
 <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, Aristo Chen
 <aristo.chen@canonical.com>, Petr Hodina <petr.hodina@protonmail.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>, Sam Day
 <me@samcday.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov
 <alchark@flipper.net>
Subject: Re: [PATCH v2 0/7] Support fastboot boot in SPL
In-Reply-To: <avr9DX4apWNryHVi@macbook>
References: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
 <179458689495.70612.1391691837782870153.b4-ty@b4>
 <xhkdbld6tqcto.fsf@mkorpers-koolstof.csb> <avr9DX4apWNryHVi@macbook>
Date: Mon, 16 Nov 2026 14:08:32 +0100
Message-ID: <xhkdbik1wrkj3.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 13:55, Carlo Caione <ccaione@baylibre.com> wrote:

> On Mon, Nov 16, 2026 at 11:40:19 +0100, Mattijs Korpershoek wrote:
>> Hi Carlo,
>>=20
>> On Fri, Nov 13, 2026 at 17:21, Mattijs Korpershoek <mkorpershoek@kernel.=
org> wrote:
>>=20
>> > Hi,
>> >
>> > On Wed, 04 Nov 2026 10:40:20 +0100, Carlo Caione wrote:
>> >> Support fastboot boot in SPL
>> >>=20
>> >> Test farms need to run successive U-Boot builds without rewriting boot
>> >> storage. Add optional fastboot boot support to SPL so an already-runn=
ing
>> >> SPL can receive U-Boot over USB and hand off to it in RAM. U-Boot pro=
per can
>> >> then load the operating system using its usual boot methods.
>> >>=20
>> >> [...]
>> >
>> > Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-=
boot-dfu (u-boot-dfu-next)
>> >
>> > [1/7] spl: fit: reject failures loading an explicitly requested FDT
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/1a3297db459c3baebdd7d51a7b6e740d3e29816e
>> > [2/7] fastboot: invalidate stale and incomplete downloads
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/6abd0cfcf58db69fad1130a8b4b1c3584b2f7de4
>> > [3/7] usb: gadget: fastboot: do not boot after a failed acknowledgment
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/72e4069217d76b4d358f561dd2c8160acf0fe485
>> > [4/7] spl: ram: allow loading FIT images from a supplied buffer
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/154c4246d60a2012d5fb23920fd1e77e7159ea55
>> > [5/7] spl: support booting FIT images downloaded with fastboot
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/fddc8df36f5219e3742e3b8eb3a9b0f21c30b315
>> > [6/7] spl: fastboot: support legacy U-Boot images
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/02172ea8e838e9a3a00b30bf7f868d5b273af173
>> > [7/7] spl: fastboot: support raw U-Boot images
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/4dce3b1e0e17625ed73f37784433c54da4cd719c
>>=20
>> This series seems to introduce some build errors in the CI:
>>=20
>> Building current source for 1 boards (1 thread, 112 jobs per thread)
>>    sandbox:  +   sandbox_spl
>> +common/spl/spl_ram.c:109:12: error: =E2=80=98spl_ram_load_image=E2=80=
=99 defined but not used [-Werror=3Dunused-function]
>> +  109 | static int spl_ram_load_image(struct spl_image_info *spl_image,
>> +      |            ^~~~~~~~~~~~~~~~~~
>> +cc1: all warnings being treated as errors
>> +make[3]: *** [scripts/Makefile.build:272: spl/common/spl/spl_ram.o] Err=
or 1
>> +make[2]: *** [scripts/Makefile.xpl:553: spl/common/spl] Error 2
>> +make[1]: *** [Makefile:2452: spl/u-boot-spl] Error 2
>> +make: *** [Makefile:179: __sub-make] Error 2
>>     0    0    1 /1              sandbox_spl
>> Completed: 1 total built, 1 newly), duration 0:00:34, rate 0.03
>>=20
>> Link:
>> https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/jobs/146829
>>=20
>> Can you please fix this and send a v3 ?
>
> Oops, yes, I'll fix this and send a V3.

Thanks, dropped v2 from u-boot-dfu-next in the meantime

>
> Thanks,
>
> --
> Carlo Caione
