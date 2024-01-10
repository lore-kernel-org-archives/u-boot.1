Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D42C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03DF58786F;
	Wed, 10 Jan 2024 10:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MSg9qBU2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63FA487905; Wed, 10 Jan 2024 10:52:56 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C4581EC8
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40A9qj25022483;
 Wed, 10 Jan 2024 03:52:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704880365;
 bh=AA/6QCR20S7XCYUwDH2wBf0wuPdVaR/CouKHmh5JMKs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=MSg9qBU22DvKws76ikja5frI3mWFy78kt9N9oTtNNrDHMB8oCSAFzFPW8Y9t88/QB
 1YkIXgTWm9GLa24zp29x8ggA6mD7ANspgeSKV++3M/x66HwLLoGqXGIXWp2wCN6OdD
 uW/rhRc7rj5qH7S/SiZ58ycWTtsGrnEGgQeZmpAw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40A9qj3Y079839
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Jan 2024 03:52:45 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 03:52:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 03:52:45 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40A9qeuE009725;
 Wed, 10 Jan 2024 03:52:40 -0600
Message-ID: <e7a75cce-ec5c-4c74-86e3-c7467f8b5643@ti.com>
Date: Wed, 10 Jan 2024 15:22:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/16] tools/fdtgrep: Include __symbols__ table
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
CC: Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, <srk@ti.com>,
 <r-gunasekaran@ti.com>
References: <20231219103418.3445886-1-danishanwar@ti.com>
 <20231219103418.3445886-16-danishanwar@ti.com>
 <CAFLszTjVBzpM-GiraSSNtXtbbQGPDUrCo7ZDjyeByx7Xtg+t_A@mail.gmail.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <CAFLszTjVBzpM-GiraSSNtXtbbQGPDUrCo7ZDjyeByx7Xtg+t_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Hi Simon,

On 26/12/23 3:17 pm, Simon Glass wrote:
> Hi,
> 
> On Tue, Dec 19, 2023 at 10:34 AM MD Danish Anwar <danishanwar@ti.com> wrote:
>>
>> This is required for overlays to work at SPL.
>>
>> Loading of symbol table depends on DT Overlay support in SPL
>> so make it compile-time dependent. Without this SPL fails to
>> boot some platforms where this feature is not enabled
>> (e.g. dra71-evm.)
>>
>> Without including the <linux/kconfig.h> file, the symbol
>> CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY will not be visible and
>> we will never include the symbol table.
>>
>> So include <linux/kconfig.h>
>>
>> Due to some reason it needs to be included after
>> [#include "fdt_host.h"] otherwise it causes a build error.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  tools/fdtgrep.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
>> index 7eabcab439..706b4a35f4 100644
>> --- a/tools/fdtgrep.c
>> +++ b/tools/fdtgrep.c
>> @@ -22,6 +22,8 @@
>>  #include "fdt_host.h"
>>  #include "libfdt_internal.h"
>>
>> +#include <linux/kconfig.h>
>> +
>>  /* Define DEBUG to get some debugging output on stderr */
>>  #ifdef DEBUG
>>  #define debug(a, b...) fprintf(stderr, a, ## b)
>> @@ -1234,6 +1236,12 @@ int main(int argc, char *argv[])
>>                 disp.fout = stdout;
>>         }
>>
>> +       if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY)) {
>> +               /* include symbol table */
>> +               if (value_add(&disp, &disp.value_head, FDT_IS_NODE, 1, "/__symbols__"))
>> +                       usage("Cannot add __symbols__ value");
>> +       }
>> +
>>         /* Run the grep and output the results */
>>         ret = do_fdtgrep(&disp, filename);
>>         if (disp.output_fname)
>> --
>> 2.34.1
>>
> 
> I may have replied elsewhere, but please use a new fdtgrep option for this.
> 
> Regards,
> Simon

This patch is actually not needed. Without this patch also I am able to
apply overlays at SPL. Even without this patch I see symbols table
getting included while using fdtgrep tool. I will drop this patch in v2.

-- 
Thanks and Regards,
Danish
