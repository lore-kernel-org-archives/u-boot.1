Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D515CD462BF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F2B88B0A;
	Wed, 13 Nov 2024 16:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="D1leLE35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95628894E1; Wed, 13 Nov 2024 16:17:32 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB5588606
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 16:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731511046; x=1732115846; i=xypron.glpk@gmx.de;
 bh=PJvmjy8WTgxX3zGCPqdVQxEEOdNJz9cvnY1gzJobtpE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=D1leLE35OQ3MBVj4pL+R6vC3E/LtRinO3GF9oWSzKSz6cY5FGg35E6zaTbucHWzO
 eIu0Ijdp58LzP2mi4cIiGdNgJAMMt/PItystK+umDs0RvewRNV/bBvd6lgNRro8W4
 cb4uwF3KRhZ+37t5zbusr5PaMmGgfvX6AZAK/FA+nQSs78SM+64AByRmthlNVHdv0
 xj02OmVixvhY6h1lJljT1U42Qd64N3FgNyuD2pGacKJvid9pI+DzfBCmQNuTqfZZ6
 t5XIO9BNCN5DT8cS6Xzmj2EGOXWoq0BrM2ctU/7xYcYvQ1zN7iUYz4q179Yzu6Md1
 LZyqNDsui/y54k92YQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5GE1-1tsFOq3FFV-0139Lf; Wed, 13
 Nov 2024 16:17:26 +0100
Date: Wed, 13 Nov 2024 16:17:23 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Janne Grunau <j@jannau.net>, kettenis@openbsd.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de,
 Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH 2/2] efi_loader: remove non vital devices first
User-Agent: Thunderbird for Android
In-Reply-To: <CAFLszTjDaQGaaL9qM_s+oxNrAkGhunGkbAjyR1giEDgnShUfzw@mail.gmail.com>
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <20241031-iommu_apple_dart_ordering-v1-2-8a6877946d6b@jannau.net>
 <87zfmi4rzy.fsf@bloch.sibelius.xs4all.nl>
 <4ff61e8e-03c7-42d2-b2fe-8dba1697641f@gmx.de>
 <CAFLszTjDaQGaaL9qM_s+oxNrAkGhunGkbAjyR1giEDgnShUfzw@mail.gmail.com>
Message-ID: <5FA71CBD-F9AF-442A-8564-4F663F44BF42@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OSDwUr8RKt2IZ9bCp4eQLINmwx3uiiApgq9D9U2VOWd1rhDrnwo
 NExONbfBYLYh40u3QoqmgwOKEijAOVV7kDEEt1W9k4YswN1SunYBoBHvy5THJif6TxJTt7V
 lCC/V0WPieaROHbOuxW8SqBBbrXadGEtvWTjUJkrQDF4nbuCfeh/4eZYZxZpviWzzjivNbP
 gZlf1nGxfdiKj+jl1OkvQ==
UI-OutboundReport: notjunk:1;M01:P0:LDjFDctTO1E=;i7zOx5BDGAaVIl8nHoJHpvREmgK
 7IzXywwBFP3Wk8JsPbO0pHnr7J6ZB/I3dJ0M4mMcja6KeZJbI3Cscl3Gvd8MVBJ633S8aWhy6
 anyLRy1kj1Wp5SiLPkvksng48pJtycxl8EKWSLa2A5TBercxRRK1W8RJOLWxJHVrYmrJBkgj8
 7ZbdWEjMQr3bM1Y9Yu2GcXAcCuASIpW5jE4jn4Rj7SjHpgMDnCcYrYnaxaSXjaqeVRioGwH7a
 2E9j6e/KK6pRQ+h0hBsptvpBGiPV8xSG+WBde+EPYaSpohDOgunnr9+73TBYo9G+fzgaNYvCi
 sgRvNS/mGfSp0CHkm2GBHr+ksJtm0zARW3DBYh/14zDgXaVwg10YfCp1nok1+YBGvoUakord9
 sMzTiASR20K2Q+1brS3d1ARbwaTqOKNNB4tTttIKvGJ9SV3P23dpFNWcPQglAOgCy3L2VxlhD
 NncctR7U4wXCNEJAzDC6No938N6lUx9w/UJpLJLlIvJUP9cu05/bPVDI0wKG9xzLpFCWocX9d
 qfzI27iZK0lsFaTJ7D0w8Xlh27coItCcxX/iYjh/qMLjWyHSw49tcB6zRIGcid3Yql3n++6dc
 8R67n1/KjZejMSJNy3V1SiMJSbC++SOReW4/btZhctITg1FIZ5TNPWYHIz823Cij7SLp5w46B
 x/qoQRmAXPjmRC56K6cXo0g8zCKL/t8Oj0PM/3yRXn9OHiX6g5fZBPWdVMubsNzurSyE3Yn6H
 SqarrN1/YM+S9Pvkh+K0QsksWLPd4fBx5zIbMafvccQ77o1bSjKND7rfiAQALLrWz/a+We+EU
 hfFkTsbvJUu0Gyzc/cmrgrDZy0koP7PLXyxianfMS0HVFm1rZdoYzwqYraVsTkEenGs78oAWl
 cXfCD4dVqgvlCROmVcWmKeBG0abwPTI3pO+jB/672svoDIbJRP2N1N96s
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

Am 13=2E November 2024 15:39:22 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>Hi,
>
>On Wed, 13 Nov 2024 at 05:52, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>> On 11/1/24 21:29, Mark Kettenis wrote:
>> >> From: Janne Grunau <j@jannau=2Enet>
>> >> Date: Thu, 31 Oct 2024 23:48:02 +0100
>> >>
>> >> DM_FLAG_VITAL marks devices which are essential for the operation of
>> >> other devices=2E Removing these devices before their users can resul=
t in
>> >> hangs or crashes=2E
>> >> This potentially fixes EFI boot of Renesas rcar3 devices=2E Their cl=
ock
>> >> devices (and with this series the dart iommu) are the only devices
>> >> markes as vital=2E
>> >> The arm boot code already handles devioce removal in this way=2E
>> >
>> > There is a typo in that last sentence of the commit message (devioce)=
=2E
>> > Otherwise:
>> >
>> >> Signed-off-by: Janne Grunau <j@jannau=2Enet>
>> >
>> > Reviewed-by: Mark Kettenis <kettenis@openbsd=2Eorg>
>> >
>> >> ---
>> >>   lib/efi_loader/efi_boottime=2Ec | 1 +
>> >>   1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/lib/efi_loader/efi_boottime=2Ec b/lib/efi_loader/efi_bo=
ottime=2Ec
>> >> index 4f52284b4c653c252b0ed6c0c87da8901448d4b4=2E=2E7db3c95782970f8c=
06a970a8ee86b1804cd848b6 100644
>> >> --- a/lib/efi_loader/efi_boottime=2Ec
>> >> +++ b/lib/efi_loader/efi_boottime=2Ec
>> >> @@ -2234,6 +2234,7 @@ static efi_status_t EFIAPI efi_exit_boot_servi=
ces(efi_handle_t image_handle,
>> >>              if (IS_ENABLED(CONFIG_USB_DEVICE))
>> >>                      udc_disconnect();
>> >>              board_quiesce_devices();
>> >> +            dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL | DM_REMOV=
E_NON_VITAL);
>> >>              dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
>>
>> Simon's patch 6224dc9ba428 ("arm: Remove vital devices last") addressed
>> the same issue for bootm on arm=2E But what about about other architect=
ures?
>>
>> This logic should be moved to drivers/core/root=2Ec instead of replicat=
ing
>> code=2E
>
>We could have a common helper, but it should not be in driver/core as
>this ordering is more of a policy decision=2E Unless we can add a
>parameter telling dm exactly what to do=2E=2E=2E
>
>BTW, Heinrich, this behaviour is exactly what my bootflow_efi() test
>was supposed to check=2E But since it doesn't have the
>exit-boot-services piece at your request=2E=2E=2E
>
>Regards,
>Simon


Why can't we generally remove non-vital devices first if all are to be rem=
oved?

I cannot see anything device specific here=2E

Best regards

Heinrich

