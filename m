Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA0FD637A8
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 18:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C910089198;
	Wed, 13 Nov 2024 19:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KjvmcwnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E7DA891B0; Wed, 13 Nov 2024 19:45:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 769CD88E94
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731523545; x=1732128345; i=xypron.glpk@gmx.de;
 bh=Yo+G+mJrQrDgDYkgPkOJG0aNWCTO0M5YFGtHDSTs1rg=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=KjvmcwnCwNP5p1gUUylLnbNqUqqKXGCFPTSV81xKpcIbszFLd3/8oXKGhxlE7orT
 VlreZDJn2iAQ74BfUpsHxtVBx+44B+rxgd+FQbS8eFVM7ToOhHubfGiiuIYqegdGF
 7+OuuUX666gImrYw0qxDIBRc1oAM1xDm047Xf/WnRzB7U65JLt0jOIVPE1TQ61Oc7
 qUkyEH1Iw2AgGp1PHHuAJj82PgRa7cjdC1j8BtY7ClF8G+NcwAEenpGRldUWXxr3n
 1cPq8gploisTdNSF+SwBjvft4H/4tVHEFMahJmzGNE2cJkhZOi+/jienzQLl7EoJ4
 eZRHxe79oLdHsMBwGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwfWa-1u0Dxa3zjO-010wis; Wed, 13
 Nov 2024 19:45:45 +0100
Date: Wed, 13 Nov 2024 19:45:42 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Janne Grunau <j@jannau.net>, Mark Kettenis <kettenis@openbsd.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH 2/2] efi_loader: remove non vital devices first
User-Agent: Thunderbird for Android
In-Reply-To: <CAFLszTi9As9YFFoWuD9GW6gHpriZSNVCFmq5fKkdCi9jeRuqjQ@mail.gmail.com>
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <20241031-iommu_apple_dart_ordering-v1-2-8a6877946d6b@jannau.net>
 <87zfmi4rzy.fsf@bloch.sibelius.xs4all.nl>
 <4ff61e8e-03c7-42d2-b2fe-8dba1697641f@gmx.de>
 <CAFLszTjDaQGaaL9qM_s+oxNrAkGhunGkbAjyR1giEDgnShUfzw@mail.gmail.com>
 <5FA71CBD-F9AF-442A-8564-4F663F44BF42@gmx.de>
 <CAFLszTi9As9YFFoWuD9GW6gHpriZSNVCFmq5fKkdCi9jeRuqjQ@mail.gmail.com>
Message-ID: <C4EB5D10-D037-49BE-BE0A-00BD3D1514FC@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3esY6CNXo69SyXw820BXzMKW4GkNHiRzKk6hCCNNICR6sPQ8D4+
 IW5UtSJqE7ZFm35hkP0nVipHFDDntn5jW+BfSqfX8KHeH3mwe7oAlTXCnBQwnU3Z6qgvmIJ
 oYRv63G1sQm9sqdT7mCpsQy4yFu1o3BsXOCc6RvNQV/RB+9IstU5nYqPwvHY0iUzroOLfkp
 5+EGAFl9fzjoLkNwWQ6XA==
UI-OutboundReport: notjunk:1;M01:P0:tLkaQDiD5Es=;zXpINBhoZcc2HDPPnttTTazAayj
 FasNQvX+dzjbxrIYPzFjd9ogzf0RUXJ9LV9z/JV7O8Oz1YVFjWcewQNK6OfJRNE9UrPKC/ndF
 +tf3YnEYr1Ma/uVL5cGiSbVcEw69n2RVbp8etciU4hbpGKMhnEB9blO4OXAor2QQ9ql80QyqZ
 yE2a1Sd7euNm4gbpa6vLRyEQ1net6mRtZcBfjw74U9qEl6nABqkZWgpmHerg97qfoR5lJzTgx
 eKJ13Pf9IeTtI2gpAkr9W0rBxLtRe9RyRVap9AyZeNFeC+Ch8ZMKstJL2uaRpeadWjWj5Yv/d
 qVbZPSdc2L449/Ao4+XzhTPEED9mXkWRMzN1ENQxFCDhtpqSSPwrgf5Jm3SRKyNyID4J2RXOE
 tL6EQ1UjHet6YeAv5+/MSKkThuYd818/1nE8nFKafFGEjOgMBl9s7Pt/pINeWnWLeOTPLvOQB
 ZHcQr8muz9WKbujeJhHCtGyv2V6JeN+W/8SrUjBrpnr6xoyLTDtAao1bPV6TltJI+O83K6yoJ
 H+WzcH7r8lujn/QjT2iQ0XCpLv8rFmaisAkg81iw9AzN8n3CnRLIZTsVfFNiG1OHGmGRrej9D
 /g8wh3nxkUqYBPlDrXnoHjRfdMjqoDoK5zt6MoWnUKbR3qQYPUDM5QjFVVanFZJBX1lxVuAZC
 /z/Hwd9LeYCMvvO8VNUXeXa41llcO/l8KQ+jMcPrwgaYK4TVB7EOlf2FczI0wqA20MOQ84K1T
 7Ro0wnvBuvK1QTclbLT0oyI77OkI0mgldvCrhs6Eqe2I+zF5qx6ajgX7+gz1z3SbPPuuN27Dj
 CN3Iidzg10oTBhms8pMff56eBAm+RAjjlZwt5DEtRKip2pdOb6A3YhnZmzLU469PtrvuzyOxl
 NPdhhpzJj6mrnRtdMP3rAO/xbxBYXQWrPkliBiGWNVR4HLkqaenFD92YK
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

Am 13=2E November 2024 17:03:03 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>Hi Heinrich,
>
>On Wed, 13 Nov 2024 at 08:17, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
>
>wrote:
>>
>> Am 13=2E November 2024 15:39:22 MEZ schrieb Simon Glass <sjg@chromium=
=2Eorg>:
>> >Hi,
>> >
>> >On Wed, 13 Nov 2024 at 05:52, Heinrich Schuchardt <xypron=2Eglpk@gmx=
=2Ede>
>wrote:
>> >>
>> >> On 11/1/24 21:29, Mark Kettenis wrote:
>> >> >> From: Janne Grunau <j@jannau=2Enet>
>> >> >> Date: Thu, 31 Oct 2024 23:48:02 +0100
>> >> >>
>> >> >> DM_FLAG_VITAL marks devices which are essential for the operation=
 of
>> >> >> other devices=2E Removing these devices before their users can re=
sult
>in
>> >> >> hangs or crashes=2E
>> >> >> This potentially fixes EFI boot of Renesas rcar3 devices=2E Their
>clock
>> >> >> devices (and with this series the dart iommu) are the only device=
s
>> >> >> markes as vital=2E
>> >> >> The arm boot code already handles devioce removal in this way=2E
>> >> >
>> >> > There is a typo in that last sentence of the commit message
>(devioce)=2E
>> >> > Otherwise:
>> >> >
>> >> >> Signed-off-by: Janne Grunau <j@jannau=2Enet>
>> >> >
>> >> > Reviewed-by: Mark Kettenis <kettenis@openbsd=2Eorg>
>> >> >
>> >> >> ---
>> >> >>   lib/efi_loader/efi_boottime=2Ec | 1 +
>> >> >>   1 file changed, 1 insertion(+)
>> >> >>
>> >> >> diff --git a/lib/efi_loader/efi_boottime=2Ec
>b/lib/efi_loader/efi_boottime=2Ec
>> >> >> index
>4f52284b4c653c252b0ed6c0c87da8901448d4b4=2E=2E7db3c95782970f8c06a970a8ee8=
6b1804cd848b6
>100644
>> >> >> --- a/lib/efi_loader/efi_boottime=2Ec
>> >> >> +++ b/lib/efi_loader/efi_boottime=2Ec
>> >> >> @@ -2234,6 +2234,7 @@ static efi_status_t EFIAPI
>efi_exit_boot_services(efi_handle_t image_handle,
>> >> >>              if (IS_ENABLED(CONFIG_USB_DEVICE))
>> >> >>                      udc_disconnect();
>> >> >>              board_quiesce_devices();
>> >> >> +            dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL |
>DM_REMOVE_NON_VITAL);
>> >> >>              dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
>> >>
>> >> Simon's patch 6224dc9ba428 ("arm: Remove vital devices last") addres=
sed
>> >> the same issue for bootm on arm=2E But what about about other
>architectures?
>> >>
>> >> This logic should be moved to drivers/core/root=2Ec instead of
>replicating
>> >> code=2E
>> >
>> >We could have a common helper, but it should not be in driver/core as
>> >this ordering is more of a policy decision=2E Unless we can add a
>> >parameter telling dm exactly what to do=2E=2E=2E
>> >
>> >BTW, Heinrich, this behaviour is exactly what my bootflow_efi() test
>> >was supposed to check=2E But since it doesn't have the
>> >exit-boot-services piece at your request=2E=2E=2E
>> >
>> >Regards,
>> >Simon
>>
>>
>> Why can't we generally remove non-vital devices first if all are to be
>removed?
>>
>> I cannot see anything device specific here=2E
>
>No objection to that=2E=2E=2Ebut it needs to be in a new function, not be=
come the
>default behaviour of dm_remove_devices_flags(), which is supposed to do
>what it is told and in one pass=2E

dm_remove_device_flags() makes no specific promises concerning the deletio=
n sequence and its internal working=2E But obviously it will fail if non-vi=
tal redources are not deleted first=2E

Leaving this broken function exported and writing a new one has no user be=
nefit=2E

We could copy the old function to a new static function that we call as ne=
eded from the old function name=2E

Best regards

Heinruch

>
>Regards,
>Simon

