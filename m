Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AE8C41513
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 12:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B586D87096;
	Thu, 19 Oct 2023 14:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697719764;
	bh=0dkop2YMJ2AN0eorB05hz1Y4aAodTQet6Sv0tCIl87c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JwYzqcQeZAefPvbit10YMn6ekX/c2gY4Tyynh137C6P5N1YGOTN7hrVyAChdJ29/s
	 RS+MtlqI/Fjc/A/Acghd7sbFqCvpP5mHDe6gE/m8rqB7DTZ5BIhKmD7jRDYgbZUIIS
	 ahqJ8Siv0HKM0+PUlddRveeWchcgAvJt666Mi0oGuuhg8rjU8dE4niYdc8KRW8hg5W
	 iPgrfgj2YqpKutb5y95cd478scbeH2X4wp3shVDhux5yuAAQ+jamCsoxjxMkvJ8RKe
	 MBKq5O6U8H6qpScvqPIRzJPM7/ZmmAil5muirwS1gHoB2wBJM1zRIreuO3x8rkxkjD
	 zA9dHdH/C7C5g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C15F58707C;
 Thu, 19 Oct 2023 14:49:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697719762;
 bh=0dkop2YMJ2AN0eorB05hz1Y4aAodTQet6Sv0tCIl87c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=O/0Qp1iXiQFwbb3xRl+3DPdOtnpCGURzM5zx/lSyMwsz4wEWUIT8n7umYC33V5Q69
 BPMzRSnI8yUGI6wXtD7XoabMTX/c3h1ObAoNfflGwfYrIuo/TgOYjLyMpoJIX+lwj0
 y5RC6YZqckBN/ZO2c2mXrBUGMNcF7rQuvDlNWbTYAWwzONOt9kiUO9J5rrPJYMhZRe
 pJWQVcmW7RzfSoNQtka3aHSPEUbwlq/bqLF3x/2QxpmzqugR3GgKI56YDxhumzuGvS
 yUR/Gs8n2Bj+jDGSsDu2UiXW75ADYEs2+3tpg+KnZo0n55zNkld3xkoAqivtL7CgWp
 ZMQSwT+mBw92g==
Message-ID: <529bab0f-a7ac-4f64-a1df-10f3699bd6dd@denx.de>
Date: Thu, 19 Oct 2023 14:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] ufs: Add a PCI UFS controller support
To: Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bmeng@tinylab.org>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <CAEUhbmXzgjRkzKq=TSQJADkCm75H-HugMz=4+g0ccNL2WWNWRQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAEUhbmXzgjRkzKq=TSQJADkCm75H-HugMz=4+g0ccNL2WWNWRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/19/23 07:08, Bin Meng wrote:
> + Marek,
> 
> On Wed, Oct 11, 2023 at 9:16 PM Bin Meng <bmeng@tinylab.org> wrote:
>>
>> This adds a PCI UFS controller support and enables the support on
>> QEMU RISC-V for testing.
>>
>> Requiring QEMU v8.2+.
>>
>> This series is avaiable at u-boot-x86/ufs for testing.
>>
>> Changes in v2:
>> - fix a build warning
>>
>> Bin Meng (9):
>>    ufs: Correct the UFS terminlogy
>>    ufs: Add a line feed to the end of some dev_xxx() messages
>>    cmd: kconfig: Make ufs prompt look similar to other commands
>>    cmd: ufs: Correct the help text
>>    pci_ids: Add Red Hat vendor and device IDs
>>    ufs: Allow mmio registers on the PCI bus
>>    ufs: Add a PCI based UFS controller driver
>>    ufs: Handle UFS 3.1 controllers
>>    qemu: riscv: Enable UFS support
>>
>>   board/emulation/qemu-riscv/Kconfig |  2 ++
>>   cmd/Kconfig                        |  2 +-
>>   cmd/ufs.c                          |  2 +-
>>   doc/board/emulation/qemu-riscv.rst |  8 +++++-
>>   drivers/ufs/Kconfig                | 11 ++++++++
>>   drivers/ufs/Makefile               |  1 +
>>   drivers/ufs/ufs-pci.c              | 45 ++++++++++++++++++++++++++++++
>>   drivers/ufs/ufs-uclass.c           |  2 +-
>>   drivers/ufs/ufs.c                  | 31 ++++++++++++--------
>>   drivers/ufs/ufs.h                  |  1 +
>>   include/pci_ids.h                  |  7 +++++
>>   11 files changed, 97 insertions(+), 15 deletions(-)
>>   create mode 100644 drivers/ufs/ufs-pci.c

Thanks, uh ... could you please just CC me on V3 (if there is one) ?
