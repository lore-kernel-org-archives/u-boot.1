Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDA5C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 21:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C9788717;
	Thu,  8 Aug 2024 23:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BtpSm+cv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7425388717; Thu,  8 Aug 2024 23:07:40 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D6588669
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 23:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723151256; x=1723756056; i=xypron.glpk@gmx.de;
 bh=dlQDM7QLHmQCJrYkjbOR/6kt1I4lEAMCQBlqRBurqig=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BtpSm+cvPtwyxnDxbMSnu3CYJ5KYpZc24JTtAO2FiR4JXXIN/KkhrdEeXq3WzSTU
 YgU9lo5kSIl/6SA8Dl2lhu5g9rK9EDt8zoCOw7SJBwWNZVTfcQoPSLUJRh0ouj8U9
 MMnSrhF1L2Mi4PCytfyvxIrLLbudnkyWFWDwCZgIl1hPrJScWbjDAL7W10gnyifHe
 +6oIsVKp/XSOvzIrrhX7i0O2gwjSF5IhK4Tx9iO0eFpgl5tfwShFFn87Ep5bIdpIG
 SHFNA3YhtBO3xZcN/I7HcAkCdGrPVwRS7rz9PdEPIV0t0pcj6CrIwbUKlo/Rsps6g
 6GZ3juljK4O3qXCb/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRMi-1sm74W2WfE-00SL40; Thu, 08
 Aug 2024 23:07:36 +0200
Message-ID: <ecbf0aab-0632-4848-8c68-b612c907ec23@gmx.de>
Date: Thu, 8 Aug 2024 23:07:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/39] bootstd: Create a function to reset USB
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-7-sjg@chromium.org>
 <eb48b869-a130-46a0-b35b-22bdb30daa7f@gmx.de>
 <CAFLszTgngCiS-Ajws3z8gXZAZM771iBLvT5Zn9oAaoqM_0B=jQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTgngCiS-Ajws3z8gXZAZM771iBLvT5Zn9oAaoqM_0B=jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EBwzoXQXy4Aqd4UZktQ6z44SHYDism9GQY/hxF61ffPavD2ruhz
 4+DQ2+PpGS5uIdU3XXBca5mkalOBmfN5CP+cVIioM08HCU/RRjaclACdivzIir/V5dD1kug
 dkQVbSNsHeJbY2vptmU4rSUen0lT2iTfxyR/bN6LgClMcH3h58MTNgxbLdxdglPhwXhAj7Y
 RFIZEVUosn//ZWGphbbeQ==
UI-OutboundReport: notjunk:1;M01:P0:KOOJvO4whMw=;UeqEKVxp3soRVm4WSPTtinlg2rW
 FsqOGTKB25ZaLVyvBLZgYDD9AqTM6BpqlP0SqEnlgxmHHmx3e+s3znS29OXwFjy8ZuCMrY5GX
 gsaUyqFucgj85u0iHr44b88ZizK69nIEgQB+OREsFBFQXaorN2YHp8MILd1+6JkeTMWT7ydcj
 wX+oPhBEAUBTeD9H0wiAh6jMKg+jxqd0HxZCvG2jhHBoUxE2oeKXeiEHPZ2RV+GcZa8/ng7+E
 Lphc9bXshkmto195nY+lKvBT39nWuAR57QeU4/ZXmxa/42HVzVZumEyBb+5ju2KxrQk4eA7+i
 1GK3OW+pyPuRrmnV43XgftIXj1TSGxMjx5C7HHyYVCOgb13W1tWu5wKtpVavl3xUISUVeLG8d
 NPnt3LSWZY5SGyn0dtqrQBplNpire70QXUby7BbKwGrRT1DEpKZisqrAug/eAuOQ8erbiNFls
 2iWuMGe9zJNUoiC9p62s1y8fKDWF4aVdHehRld64/VrqSctnZhlw4b3GRKJSCKXIA8od7pd0D
 OBaR4eyCJwAdTd3gQVFUoru3q0lhak8nXsd/i1+Xpc7wWl104oum7bVC6tikdcLXkW+Dfezn/
 BBF52iO91ra1Q/rnnjVNVwsoc8B52K1w/Ek9I41i6UAtZwV6seLy3HC4Y7tFzBD3mTn/4PQVK
 PCmeGOPROh+eA8DOLSfM5QJaHm35wfQqUzNGhX2yN4doTIoQvZvS2VCJPQhGa+HFYcuBZoqLy
 wloIH8ilNfgY+IDIK1xfjz8onsfvVR9ZvWAoKYNXe1vioLAzgG6FLTybi9X+hYnhd44vZhohk
 AXirEjMvHfqmuwKpQqvo878g==
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

On 07.08.24 16:36, Simon Glass wrote:
> Hi Heinrich,
>
> On Tue, 6 Aug 2024 at 19:56, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> On 06.08.24 14:58, Simon Glass wrote:
>>> Set up a function for this, since it needs to be used from multiple te=
st
>>> files.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>    test/boot/bootdev.c        | 19 ++++++-------------
>>>    test/boot/bootstd_common.c | 12 ++++++++++++
>>>    test/boot/bootstd_common.h |  8 ++++++++
>>>    3 files changed, 26 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
>>> index 1bf5929c396..de16a51956d 100644
>>> --- a/test/boot/bootdev.c
>>> +++ b/test/boot/bootdev.c
>>> @@ -16,13 +16,6 @@
>>>    #include <test/ut.h>
>>>    #include "bootstd_common.h"
>>>
>>> -/* Allow reseting the USB-started flag */
>>> -#if defined(CONFIG_USB_HOST) || defined(CONFIG_USB_GADGET)
>>> -extern bool usb_started;
>>> -#else
>>> -#include <usb.h>
>>> -#endif
>>> -
>>>    /* Check 'bootdev list' command */
>>>    static int bootdev_test_cmd_list(struct unit_test_state *uts)
>>>    {
>>> @@ -201,7 +194,7 @@ static int bootdev_test_order(struct unit_test_sta=
te *uts)
>>>        test_set_skip_delays(true);
>>>
>>>        /* Start up USB which gives us three additional bootdevs */
>>> -     usb_started =3D false;
>>> +     bootstd_reset_usb();
>>>        ut_assertok(run_command("usb start", 0));
>>>
>>>        /*
>>> @@ -317,7 +310,7 @@ static int bootdev_test_prio(struct unit_test_stat=
e *uts)
>>>        test_set_eth_enable(false);
>>>
>>>        /* Start up USB which gives us three additional bootdevs */
>>> -     usb_started =3D false;
>>> +     bootstd_reset_usb();
>>>        ut_assertok(run_command("usb start", 0));
>>>
>>>        ut_assertok(bootstd_test_drop_bootdev_order(uts));
>>> @@ -357,7 +350,7 @@ static int bootdev_test_hunter(struct unit_test_st=
ate *uts)
>>>    {
>>>        struct bootstd_priv *std;
>>>
>>> -     usb_started =3D false;
>>> +     bootstd_reset_usb();
>>>        test_set_skip_delays(true);
>>>
>>>        /* get access to the used hunters */
>>> @@ -398,7 +391,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_=
state *uts)
>>>        struct bootstd_priv *std;
>>>
>>>        test_set_skip_delays(true);
>>> -     usb_started =3D false;
>>> +     bootstd_reset_usb();
>>>
>>>        /* get access to the used hunters */
>>>        ut_assertok(bootstd_get_priv(&std));
>>> @@ -527,7 +520,7 @@ BOOTSTD_TEST(bootdev_test_bootable, UT_TESTF_DM | =
UT_TESTF_SCAN_FDT);
>>>    /* Check hunting for bootdev of a particular priority */
>>>    static int bootdev_test_hunt_prio(struct unit_test_state *uts)
>>>    {
>>> -     usb_started =3D false;
>>> +     bootstd_reset_usb();
>>>        test_set_skip_delays(true);
>>>
>>>        console_record_reset_enable();
>>> @@ -556,7 +549,7 @@ static int bootdev_test_hunt_label(struct unit_tes=
t_state *uts)
>>>        struct bootstd_priv *std;
>>>        int mflags;
>>>
>>> -     usb_started =3D false;
>>> +     bootstd_reset_usb();
>>>
>>>        /* get access to the used hunters */
>>>        ut_assertok(bootstd_get_priv(&std));
>>> diff --git a/test/boot/bootstd_common.c b/test/boot/bootstd_common.c
>>> index e50539500a0..ff0aff4bbe7 100644
>>> --- a/test/boot/bootstd_common.c
>>> +++ b/test/boot/bootstd_common.c
>>> @@ -20,6 +20,13 @@
>>>    /* tracks whether bootstd_setup_for_tests() has been run yet */
>>>    bool vbe_setup_done;
>>>
>>> +/* Allow resetting the USB-started flag */
>>> +#if defined(CONFIG_USB_HOST) || defined(CONFIG_USB_GADGET)
>>> +extern bool usb_started;
>>> +#else
>>> +#include <usb.h>
>>> +#endif
>>
>> Why can't you always include usb.h which defines usb_started?
>> Is there a bug in usb.h?
>
> I can, but even in tests it is not great to access globals. Having it
> in a function lets us call out these particular settings better, which
> has aided debugging, at least for me. These tests are special in that
> they are not DM tests, but do stop USB.

I was just wondering if we can can rid of the #if here. That should not
stop you from creating a function to access the variable.

Best regards

Heinrich
