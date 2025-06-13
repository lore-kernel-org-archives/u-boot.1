Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B41C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 15:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6432682D21;
	Fri, 13 Jun 2025 17:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CCoRiruF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96B0282D7C; Fri, 13 Jun 2025 17:46:09 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FE4A82CE7
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 17:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1749829563; x=1750434363; i=xypron.glpk@gmx.de;
 bh=4WvzzchUUl/7LRT+H/lvsLlQWvb49IKjUXSsOFpkklw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CCoRiruFSVx4f+HnsICkxqA0GpKiezoo87Z/qCqCWpIEc1dNQ1ssucGhSFHxmFqi
 IYc3GOAxJlQONUvtXO3K5AtA7bniYdywI9wyZYhPsLEV74OZnfibZ5/EuPQPBjW+O
 RZdbIi/lAOUQcXg1U5S9mWeSO6G8SggbY6O5qLclysrLOcDX2u+n4x9lJUs4bna7m
 kJp8NuCfz1P1s1x75XJg7WJhCVaj++b/FVZsCIe73FJFeQy2zr1uSt6Hy4Ur+dzXA
 S4vlBBQoRmBirSUHxZbtX0N1v8bNW+OPoymL25FT6dZUPA/5ffmfZ4FZn0C6fqdZh
 8VyDweb7pcz8+Ejdxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([61.8.131.101]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bWr-1urQc534OR-011xMH; Fri, 13
 Jun 2025 17:46:02 +0200
Date: Fri, 13 Jun 2025 17:46:00 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Javier Martinez Canillas <javierm@redhat.com>, u-boot@lists.denx.de
CC: mkorpers@redhat.com, mskrivan@redhat.com, eballetb@redhat.com,
 mripard@redhat.com, alexl@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/3=5D_efi=5Floader=3A_disk=3A_ad?=
 =?US-ASCII?Q?d_EFI=5FPARTITION=5FINFO=5FPROTOCOL_support?=
User-Agent: Thunderbird for Android
In-Reply-To: <87ikkzvghz.fsf@minerva.mail-host-address-is-not-set>
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-4-javierm@redhat.com>
 <2584944A-D0CF-44E5-ABAE-C3E156ED8539@gmx.de>
 <87ikkzvghz.fsf@minerva.mail-host-address-is-not-set>
Message-ID: <975875C4-8B41-4228-AF6C-6090DE1B68DE@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z/WjHEliBRNxRz1B8X/rF381HTOGGicNkN0O91KVANwgGwYNla0
 yTzzUd3W1aKHiEiPrifd0KlyVYlcpq+VTKNGzE5ZFsSYpWueMt4k7t7f1Tj43WbXvw75Pl0
 k8KHajDtKfemaNrAPTMbLZ4zLyFWR+Xb4612GRnxioMz/DVTfI+lixt4Gz8mcJsy6w045+/
 Idg/eulNO/rDRZh777PPQ==
UI-OutboundReport: notjunk:1;M01:P0:zGWLB2GSUEk=;MRNZSG4ani4/S9jNVA54mgals9t
 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
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

Am 13=2E Juni 2025 16:54:48 MESZ schrieb Javier Martinez Canillas <javierm@=
redhat=2Ecom>:
>Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede> writes:
>
>Hello Heinrich,
>
>Thanks for your feedback=2E
>
>> Am 13=2E Juni 2025 10:57:38 MESZ schrieb Javier Martinez Canillas <javi=
erm@redhat=2Ecom>:
>>>The UEFI 2=2E10 specification mentions that this protocol shall be inst=
alled
>>>along with EFI_BLOCK_IO_PROTOCOL=2E It provides cached partition inform=
ation
>>>for MBR and GPT partition types=2E
>>
>> U-Boot is targeting the EBBR specifcation which defines a subset of UEF=
I=2E
>>
>
>Interesting=2E I knew that the u-boot EFI implementation was to support
>SystemReady IR (what is now called SystemReady DeviceTree) and EBBR,
>but I didn't know that meant to only implement what's required by EBBR=2E
>
>I noticed that EFI_PARTITION_INFO_PROTOCOL is not even required by SBBR
>and only EFI_BLOCK_IO_PROTOCOL is required there just like for EBBR=2E
>
>> Which application needs this protocol?
>
>We are experimenting with a new A/B boot protocol and an EFI binary that
>implements it=2E It's inspired on what the Android Boot Loader does for i=
ts
>A/B booting too=2E
>
>The project is https://gitlab=2Ecom/CentOS/automotive/src/ukiboot and rea=
ds
>UKI (https://uapi-group=2Eorg/specifications/specs/unified_kernel_image)
>images from raw data partitions=2E Just like ABL reads Android Boot image=
s=2E

Linaro already implemented A/B EFI Boot in U-Boot=2E (https://docs=2Eu-boo=
t=2Eorg/en/latest/develop/uefi/fwu_updates=2Ehtml)=2E What are you missing =
in the existing solution?

Best regards=20

Heinrich

>
>> Are you planning to add it to the EBBR specification?
>>
>
>I haven't thought about it before but I also didn't know that u-boot had
>this requirement=2E Probably it should be documented somewhere to make it
>more clear? Maybe I didn't look enough but didn't find a doc in the repo=
=2E
>
>> Best regards=20
>>
>> Heinrich=20
>>
>

