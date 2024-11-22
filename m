Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F7CE65D25
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 04:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C29448878A;
	Fri, 22 Nov 2024 05:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31BBD8921A; Fri, 22 Nov 2024 02:56:34 +0100 (CET)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34F6888DD9
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 02:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=hal.feng@linux.starfivetech.com
X-QQ-mid: bizesmtpsz8t1732240542tzn0kvp
X-QQ-Originating-IP: PXExxzDfnaGZsXBR6f3Yh7qTNgA+dpkJBjexc58HEyk=
Received: from [192.168.125.68] ( [183.27.98.255])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 22 Nov 2024 09:55:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5430661908228356672
Message-ID: <CA5A95C66FB76A59+44cb6507-e25e-4354-8f45-3c1e03460552@linux.starfivetech.com>
Date: Fri, 22 Nov 2024 09:55:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] riscv: dts: jh7110: Add u-boot device tree for
 JH7110 based boards
To: E Shattow <lucent@gmail.com>, Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
 <20241119020425.51989-6-hal.feng@starfivetech.com>
 <CANV2PTOK2QSWtCFzPX7tSLj+xcs6zc0mn4UafBYcZCjyN6BsTg@mail.gmail.com>
Content-Language: en-US
From: Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <CANV2PTOK2QSWtCFzPX7tSLj+xcs6zc0mn4UafBYcZCjyN6BsTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:linux.starfivetech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M86u6xf659ZEvvNo5VJ6VLQ7MVAntPSTQjzjra1o0fTIcs8IDaGuY2IS
 AXANBYm2ffriCNYMOsw4MmpISS4TAaoIAKWDsoDHtmKzC/uirdFtEKW/E6h8GXfXoWdwglz
 KndSfp+s4KdSc9FT/a1+Hx7LjhmvhLWnYhtYe3UoodcgTr3W6PZ6Dy87J2zRRS6N0kJ+FQ5
 7L9yUZDVzKwPtc3RDm3vYJhvDVxzek9EkBvuAeSPGShIfdq7Cj5XlN0KwBy7kFzg2hAzGZT
 M4qq1MmrDRVG3DKLxP/VaIqm//iKUqpSlttwiovZL/xYBM3XxxNSvyhOZASUTn8+dHcuHwA
 kwBnejchu/xwVb41sAlVTv5bJ8PIGXeXjna2oi6bPSjegiXxL68HCjKU3/RAHx0wYONdkOv
 3czq2/UAo4RFzxdN1sArtx+4CkOa6gOhwF/1TZPHFYUEUoFyudKSlNJp2DgHqOzZ70pWyhc
 X7Js2itMC9nqBip47GJidz9KVsSqa8PCXIVfEOsaxpRM0GS2IoZEnJp3kxo99RG5QvFgQKx
 iMLygiDxW9ILb+vWo5G8iGNJt2qMaPi7eztFRil4iVPyuj+xwGnRhcp2wmLmkizYrfQrKqU
 kZPRvnZ+7uGi4ldiRBrDtrsd/8H3eOO+CXYKqEEp4HsJFPmrEEh46uRBc8e4SLx3bbqZApd
 CDerrT95mJkgGX48gHvphBl+cmBC9JXsYdRgymR3KBSX+UQfJXxhnKtV+Zn/+J+g/7vcnoU
 Nu3Ivkhi42h+pAg6fUZMjxyWXUWl5L/7/kHJUHO92gS3o5Jy8jRyLbcvZ5HReBcAoMt5Tz4
 lmGVFhvhujOPQm+QVV3CiOWjySChRa9PssSxiE/rZL501pEJnkZrEaOi93AOAub2JRr/+7v
 Jcp3PSDJtCtH+4IHf5VKxlETxp63gsqQvdUOjPN6GoO7gZSqr9OHGYcpnmrAvoQHxupG9uU
 qyFaHd8funm35KQIgGjKbqtTmHnIkaJUUNGmTe+cnpGrNmPshYBfjSm1ARXbK9C/3Xf8=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Fri, 22 Nov 2024 05:32:22 +0100
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

On 11/22/2024 8:28 AM, E Shattow wrote:
> On Mon, Nov 18, 2024 at 6:06 PM Hal Feng <hal.feng@starfivetech.com> wrote:
>>
>> To support the other JH7110 based boards, add u-boot
>> device tree for them.
>>
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: H Bell <dmoo_dv@protonmail.com>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi           | 10 ++++++++++
>>  arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi        |  6 ++++++
>>  .../dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi |  6 ++++++
>>  3 files changed, 22 insertions(+)
>>  create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>>  create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>>  create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
>>
>> diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>> new file mode 100644
>> index 0000000000..cf4f0d4c06
>> --- /dev/null
>> +++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>> @@ -0,0 +1,10 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include "jh7110-common-u-boot.dtsi"
>> +
>> +&phy0 {
>> +       /delete-property/ motorcomm,tx-clk-10-inverted;
>> +};
> 
> Why delete this property?

Here I kept the same with the configuration before OF_UPSTREAM applied.
Is this property required in U-Boot?

> 
>> diff --git a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>> new file mode 100644
>> index 0000000000..9df1e5db55
>> --- /dev/null
>> +++ b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>> @@ -0,0 +1,6 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include "jh7110-common-u-boot.dtsi"
>> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
>> new file mode 100644
>> index 0000000000..9df1e5db55
>> --- /dev/null
>> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
>> @@ -0,0 +1,6 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include "jh7110-common-u-boot.dtsi"
>> --
>> 2.43.2
>>
> 
> Reviewed-by: E Shattow <lucent@gmail.com>

Thanks for your review.

Best regards,
Hal

