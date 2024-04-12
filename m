Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44124C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 21:58:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D7A87E43;
	Fri, 12 Apr 2024 23:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F0R3gSFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BB3287E01; Fri, 12 Apr 2024 23:58:47 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D79387E01
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 23:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43CLwWFH076090;
 Fri, 12 Apr 2024 16:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712959112;
 bh=ypen7t1CQlH6wubbHAspij8MTckdlYWxtjejAqZn+kg=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=F0R3gSFO/OHOhHHybBZawHlPWqXJbsLNnligIiR49ZOEo2Qk3HtUxsI9J5Q5nP7e0
 2osbb+bbhPpNwWgrZ/t7UKJRvCp2EK/z8hi036xHYxCCJVq9SesYjhvFZbfrQr5ZLH
 BewbHgc79FJeuDxHAGEYcIQEn6ci9R5+oEzSTJGQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43CLwW4N021735
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Apr 2024 16:58:32 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 16:58:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 16:58:31 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43CLwVHk118287;
 Fri, 12 Apr 2024 16:58:31 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>
CC: <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, "Simon Glass" <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 "Neha Malcom Francis" <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, "Roger Quadros" <rogerq@kernel.org>, Bryan Brattlof
 <bb@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 01/16] board: Define GUIDs for firmware images
In-Reply-To: <CAC_iWjLEzeXmhc=EiGT3++1a5W5JRrZHivgSN=JMN+mQtpTZeQ@mail.gmail.com>
References: <20240408223134.165877-1-j-humphreys@ti.com>
 <20240408223134.165877-2-j-humphreys@ti.com>
 <cac63a03-b019-4aed-83de-db2effa1a2f1@gmx.de>
 <86zfu2z1p4.fsf@udb0321960.dhcp.ti.com>
 <a2fb8782-66d5-44ad-8238-d565e0934de9@gmx.de>
 <CAC_iWjLEzeXmhc=EiGT3++1a5W5JRrZHivgSN=JMN+mQtpTZeQ@mail.gmail.com>
Date: Fri, 12 Apr 2024 16:58:31 -0500
Message-ID: <868r1iz1iw.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:

> Hi both
>
> On Wed, 10 Apr 2024 at 10:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>>
>> On 09.04.24 23:05, Jon Humphreys wrote:
>> > Heinrich Schuchardt <xypron.glpk@gmx.de> writes:
>> >
>> >> On 4/9/24 00:31, Jonathan Humphreys wrote:
>> >>> Define GUIDs for the different firmware images (tiboot3.bin, tispl.bin,
>> >>> u-boot.img, sysfw). >
>> >>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> >>> ---
>> >>>    include/configs/ti_armv7_common.h | 17 +++++++++++++++++
>> >>>    1 file changed, 17 insertions(+)
>> >>>
>> >>> diff --git a/include/configs/ti_armv7_common.h b/include/configs/ti_armv7_common.h
>> >>> index 3def7b1027e..4ce14a9b84c 100644
>> >>> --- a/include/configs/ti_armv7_common.h
>> >>> +++ b/include/configs/ti_armv7_common.h
>> >>> @@ -16,6 +16,23 @@
>> >>>    #ifndef __CONFIG_TI_ARMV7_COMMON_H__
>> >>>    #define __CONFIG_TI_ARMV7_COMMON_H__
>> >>>
>> >>> +/* GUIDs for capsule updatable firmware images */
>> >>
>> >> Please, provide code comments for the GUIDs, e.g.
>> >>
>> >> /**
>> >>    * define K3_TIBOOT3_IMAGE_GUID - firmware GUID for K3 tiboot3.bin
>> >>    *
>> >>    * This GUID is used in capsules updates to identify the tiboot3.bin
>> >>    * binary.
>> >>    */
>
> I'd go one step further tbh.  Those GUIDs can be used by OEMs/ODMs
> producing capsules for their future products.
> Currently, we don't have a documented way to allow users to redefine
> this (but Linaro is working on it).  If both TI and an OEM use the
> same GUID and try to upload the firmware to LVFS, we will have a GUID
> clash.
> I think we should have that on the comment as well, until we can
> properly sort it out

Ilias, I realized I may have defined the GUID's a bit incorrectly.  I
was thinking that the GUID's identify the firmware type (eg, SPL vs
Uboot for TI devices).  However, the SPL binary for say am62 will be
different than the SPL binary for say am64, so I should have unique
GUID's per firmware type *per board*.  Correct?

If so, I'll need to move these definitions to the board .h files, and my
generic capsule binman nodes will need to have each board override the
image GUID used.

thanks
Jon

>
> Thanks
> /Ilias
>> >>
>> >> Cf.
>> >> https://docs.kernel.org/doc-guide/kernel-doc.html#object-like-macro-documentation
>> >>
>> >> Best regards
>> >>
>> >> Heinrich
>> >>
>> >
>> > Heinrich, thanks for reviewing!
>> >
>> > I modelled the GUID macros after how other boards and even core code
>> > defined there's.  (eg, include/configs/kontron-sl-mx8mm.h or
>> > include/efi_api.h).
>> >
>> > However, if this is the new direction, I will format as you suggest.
>> > Please confirm.
>>
>> Hello Jon,
>>
>> Without properly documenting macros we make the live of developers more
>> difficult. Yes, we still have a lot of missing code documentation. But
>> we should not follow poor example.
>>
>> Best regards
>>
>> Heinrich
>>
>> >
>> > thanks
>> > Jon
>> >
>> >>> +#define K3_TIBOOT3_IMAGE_GUID \
>> >>> +   EFI_GUID(0xe672b518, 0x7cd7, 0x4014, 0xbd, 0x8d, \
>> >>> +            0x40, 0x72, 0x4d, 0x0a, 0xd4, 0xdc)
>> >>> +
>> >>> +#define K3_SPL_IMAGE_GUID \
>> >>> +   EFI_GUID(0x86f710ad, 0x10cf, 0x46ea, 0xac, 0x67, \
>> >>> +            0x85, 0x6a, 0xe0, 0x6e, 0xfa, 0xd2)
>> >>> +
>> >>> +#define K3_UBOOT_IMAGE_GUID \
>> >>> +   EFI_GUID(0x81b58fb0, 0x3b00, 0x4add, 0xa2, 0x0a, \
>> >>> +            0xc1, 0x85, 0xbb, 0xac, 0xa1, 0xed)
>> >>> +
>> >>> +#define K3_SYSFW_IMAGE_GUID \
>> >>> +   EFI_GUID(0x6fd10680, 0x361b, 0x431f, 0x80, 0xaa, \
>> >>> +            0x89, 0x94, 0x55, 0x81, 0x9e, 0x11)
>> >>> +
>> >>>    /*
>> >>>     * We setup defaults based on constraints from the Linux kernel, which should
>> >>>     * also be safe elsewhere.  We have the default load at 32MB into DDR (for
>>
