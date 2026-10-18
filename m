Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEB0CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 04:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78F5B811BC;
	Sun, 18 Oct 2026 04:31:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZcZ74paAD-7S; Sun, 18 Oct 2026 04:31:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 733C68122B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792297897;
	b=cBE2ECEuwOwiXL4BfCf81L1/rFhy1nZdIBine21DVkTj1J7OsLXipibxOfdbgq9ZJAa6
	 s+sZvqlN9KgGpJ/WzATPFiJ6ZvvndaV0JYS/4a8mD8TwUauzGmKe+qb0dZg29a/ti20O6
	 68Ma1G6rzaVvhxLAEJdlUlZOWKNL8t5b7HhlPwx4cTBBI97Q5An6yreO5IMIV5u9wRl2+
	 3J8pC5n1lluDGo3ahT6o2oPoPS+bLxVFsXe4YDKWlW1MpGy5SHNPoRS6EQkgmxOE6yqZP
	 A5PEiSEJvwWGGwywyVPojgXwTF8HQi5+/Y4G0OjYrRm2YVNeJQzQX8BCT+5OtlOy3Kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792297897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TeL4XG0oKohrYi1q5jw/bVr0cJvDUy9q2Qa0XKy4UTk=;
	b=fWzUskKSjgSk0PsfWIZ4sgm/WJQBG52FN2AuNPo5t012cRP0q3KNKnOEaaxWijruEmC6
	 NBO1VS0eh+mWRnRsLBHDWnOFyF+eh3ipp+DvyOwM0XNMqHFO5To5Em3xDOSn8mpU5Behv
	 tH3rWNzPIoL2RG3BNfXPe7oe/KAjc+Au8HcqO7ESzEt+fb7bpxrjYQ2pzsvIu8Tv3gdN4
	 J74cZQ+QMzl1zdGIZSy2gXjsvfpkvwFWrYWZihYMxzZ/F38PFvFLkJjz5XqN3KxNlyY8h
	 w0swvZACrCgYNqzRtNSqO1gumUDA0DSQiox7mlnAKaXi2S78WggbPUkkD6opPAPUOtA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792297897;
	bh=TeL4XG0oKohrYi1q5jw/bVr0cJvDUy9q2Qa0XKy4UTk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u7NUd+tPNAk059MuVdTqRJM+SYUgaWN/JqwwRRyAfcNFnPAPpfjH/8XMkgEUv+pAh
	 4oeramXsoZ5NDgoNEk17J8+H885adgQQkqtN4XlAP2DTlPhLyN7sShVtSBxrfYMcpO
	 wjQx2H+MbAAXVxet/mYFJTbdEDnxeVKbBfJzQRkAKa9vxso3PzxIDAt1xHinPGRqSu
	 m9fNW0IPGqcL+c2ZPmTdzyLRhXoFZ7TXVj/S1Iyd6UOd2KUoN0HX5/cq1/UYnFj8FZ
	 g+KY3uk1RyiTzp26X8tJuHHbr9EWlal/C9zeb7WbcoSetSA1Cqf1lBJTeTmUSqe7S/
	 agvockHL9lcwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 733C68122B;
	Sun, 18 Oct 2026 04:31:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FC3D61
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D4786063F
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:31:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x4Boa2x-6oaq for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 04:31:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DD8DB60634
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792297894;
 b=BklWshZ2Jva2qd/qqehQCNQp4YUBow2k96ECjKg1Px82ZfJ2l9MoVuBbjRfvChg5jEc5
 iPGoNv+J3wR7dVekHxIeQWKv9XeDV4TqFJWaJFNMxqplm5rv9d8uS0/46QpmdaZbBZisq
 QcQGxwrUo0rG85DU33bVfbjEEvHr4ElyWcRx6jIfAne86T8Kq3t18EtMt9/CQOdGN0Dlg
 /RTt/PGBgBwcPnYjxb2Z7CJheKfMUas3qHksoLL6uIzzQ4LIB14aq76NoDQXbAJ5s48gM
 RuDR8WTSQmjXf42yOwdHZ9oHNN49ldSlhkdpN0KkFU0NBpHillbxwjxw8q/FhMa21og==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792297894;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=TeL4XG0oKohrYi1q5jw/bVr0cJvDUy9q2Qa0XKy4UTk=;
 b=s6h54bwmCpDImlytLdQEaRRV6D/tpwVlGDVk6YkEEwDNSsOsvmjVBQV/5vjad1ProEdw
 hcXgT6E4BwB7yhLer7BQZ/D99ZLvc1ESvn0Oamxr687v/MMofBLwIFK01ZIJUk3DPpyCu
 F30HLXCfhjAHIYVmgDnWZHVvdvJCZUQXT9ZjYvoG3/6Sfn05hFJmzDd3d62mkCwocZvQM
 tQ/Vqf7vl3EuPcZr1KgRaji1/lKg0J5wnDLN9+5QEC4naaY3GRMw0iD+/DYwB8hqIUA2w
 M+b1CVpaY1SIf3vpYj8kf/sBdpHEj2HzgnXNEzMsvEiPVVFKcjqWhIPUzBZPyoyiBeg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fpHiKr8m; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=semen.protsenko@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fpHiKr8m
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD8DB60634
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:31:32 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-81ae6aefdceso951320a34.0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 21:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792297891; x=1792902691;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TeL4XG0oKohrYi1q5jw/bVr0cJvDUy9q2Qa0XKy4UTk=;
 b=fpHiKr8myEz6wgE3ZB3vSa+FWJ/70vW2pEbkkfsWLgHUsyYw6mYyud96ObHfeR1mu3
 9+8JubL4rIlabBmlGWzRXYah+2u11u5BYXQgS8kPB231Wp1X7KVdpy4ncLcIopb2kI1n
 HUWi9bF7N5/sgBMQKVWuhwc5axzDqkTJ8FsMPAnxkfAjyKa6LEo5/InvxjV5aUoeGsLO
 6t5MGBorDJ88aqdlsaDL2XVt5EDyHKdBO7KgpUwX9omU5mX4KyWP0zdIToRv6/aA3aj7
 7jenTmkrAcAQQ3aZtvz6ZBrGmM1EVLWAA+6wzSJYVlZtuecx/p1EC2BA7zlpp6WTHrzA
 AUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792297891; x=1792902691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TeL4XG0oKohrYi1q5jw/bVr0cJvDUy9q2Qa0XKy4UTk=;
 b=0lqkcLtlehNphsIb19M7avbtJCGWT+IOYwabvEWSSTF0e40QGaXhDFWp0XthGxLL8Q
 34+D190MR0a41miP4rb3dx1U6JfVFfCpftOkDIeFgDIlyAa4DGduzrFSxxtqB5Gic61h
 3Hlv3R+4+yGlFOyoYCpydG4FcSGFrdgFtXvWAjiepTEnT94vbRQYQ7n6pzNRmH1yuAyo
 fcbOy/PntocJtbTN27PcuMpiCYu7ryOL0ADXu66N5l0rdKTQEUndrKtT5kP63T6KlmXG
 7U7k2mvG60wVeyJfe6Fp5kiHSpYHNNkt8qIJzWNNt+LCtvi1FP22zLIk4kPxSpyQjWYS
 jg9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5fU7Y5kfyjvJY8geEZ1fIZRRXIV5VbfZN/+uEi0y08KK+BhtlwVar1AEr8LO4Q490txBLI4A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIx+4xaNQLdTxu+zUWBhXfApLyX9OjN09QUtuL6d9uyVkNgWvKR
 SK5Vi/Jb60VeoCWpfQ2a+p3FCsOUUqibASFxIf0iLOe76BspMGMv/yEuba9vZXVbn+SpTxZ1LAr
 Eo118P2Y=
X-Gm-Gg: AYBFou22TwNl/uAidg2WxNpjh26z4CxJZeCH8gWmTJ6vO5TbIQmloj9YiKylTKyFyrT
 03GubnYssoYgTfB4WFnNJQAm2mpligEknoMEtxBINXmmHd7xIeg87P1kCFFCNdSIrzG+BKMM9X7
 qpSjhOGynHPVdhTS2jKQt6lll6pBMdxZ9HeXA9pmPMs+twQW1BwVv6Gm4LT0HsBKNC7rcL5oR6u
 xHM3pDTFH0X5VzuaeThJz55fc1JIUoMDfklrLET7ZcsctPjrlavrUoX4lxC5zIKzkEWe2BcYBo2
 kQ2jU3XaCDQHy06QEpe6308rI2J7dwm4yjtllaJ6H/ZHfiVzmO5RBP3ytugs9xX5RTtQA5kdil8
 ZDqKpzr7aMWgDYUYufdE4s1929ARmFeW1jtWAlU0ehLlILaHOnBYsnK0AjHC1aAyGMEJnQgsXtq
 FaOC2ZC27CCoJlI2W8Ahkw/RlyyYpsH7SKrdYVt9uBacMdlPcCYTICpF66jyvnxWo1dgzZfwIVX
 teCb20=
X-Received: by 2002:a05:6808:3084:b0:533:72c7:f80c with SMTP id
 5614622812f47-53cd63bfbd7mr3593758b6e.42.1792297891222; 
 Sat, 17 Oct 2026 21:31:31 -0700 (PDT)
Received: from localhost ([2605:a601:1514:4f00:264b:feff:fe59:d7f7])
 by smtp.gmail.com with UTF8SMTPSA id
 5614622812f47-5388a55671asm4433367b6e.5.2026.10.17.21.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 21:31:30 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Klimov <alexey.klimov@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Minkyu Kang <mk7.kang@samsung.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH] lmb: Enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_EXYNOS9
Date: Sat, 17 Oct 2026 23:31:28 -0500
Message-ID: <20261018043128.26916-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Since commit a3075db94d49 ("lmb: Reinstate access to memory above
ram_top") secondary CPUs cannot be brought online on the E850-96 board
in the Linux kernel:

    smp: Bringing up secondary CPUs ...
    CPU1: failed to come online
    CPU1: failed in unknown state : 0x0
    CPU2: failed to come online
    CPU2: failed in unknown state : 0x0
    ...

This is happening because EL3_MON (the Secure Monitor firmware, which
also implements PSCI) cannot handle 36-bit addresses in its CPU_ON PSCI
function implementation. The E850-96 board has two 2 GiB RAM banks: the
first one is mapped at 0x8000_0000, and the second one at 0x8_8000_0000.
The commit mentioned above changed the LMB behavior (in U-Boot) in a way
that the memory from the second RAM bank (which is mapped at 36-bit
addresses) is not reserved anymore. The change in 'bdinfo' output:

    - reserved[4]    [0x8_8000_0000 - 0x8_ffff_ffff], 0x8000_0000 bytes
    + reserved[3]    [0x8_ffff_3000 - 0x8_ffff_ffff], 0xd000 bytes

That in turn leads to the Linux kernel image being placed in the second
RAM bank with 36-bit addresses. The corresponding change in /proc/iomem:

    -   f480_0000 -   f67e_ffff : Kernel code
    + 8_fa80_0000 - 8_fc7e_ffff : Kernel code
    -   f6b6_0000 -   f71a_ffff : Kernel data
    + 8_fcb6_0000 - 8_fd1a_ffff : Kernel data

As evident from the Exynos850 device tree, it uses "psci" as a CPU
enable method. That means the kernel relies on PSCI firmware (which is
implemented as a part of EL3_MON firmware in case of Exynos850 SoC) to
bring up secondary CPU cores. So when bringing up secondary CPUs the
kernel makes an SMC call (for each secondary CPU) to execute CPU_ON PSCI
function (see PSCI spec [1]). The kernel passes an "entry point address"
to that SMC call, which is the address of the secondary_entry() function
in the kernel, which should be executed when PSCI returns to the kernel
from the SMC call:

    static int cpu_psci_cpu_boot(unsigned int cpu)
    {
        phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
        int err = psci_ops.cpu_on(cpu_logical_map(cpu),
                                  pa_secondary_entry);
        ...

The pa_secondary_entry is a 64-bit variable, which is perfectly fine
according to the PSCI spec. Unfortunately, in case when that address is
actually bigger than 32-bit value, the EL3_MON firmware doesn't execute
the function at that address -- that's the reason the secondary CPUs
don't come up. And as discussed above, the kernel image is now located
at a 36-bit address, which means the secondary_entry() function is at a
36-bit address too:

    - secondary_entry() address:   f67d_f5a8  // 32-bit address
    + secondary_entry() address: 8_fc7d_f5a8  // 36-bit address

It seems like a bug in the EL3_MON firmware, e.g. it might truncate the
address to 32-bit by using a u32 variable (instead of u64) to store it
internally. So the right way to fix this issue would be to fix the
EL3_MON, but unfortunately it's closed source. So instead just enable
LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_EXYNOS9 to limit the available
memory to the 32-bit boundary.

Although this platform could benefit from having all memory available in
U-Boot (e.g. for transferring big images over TFTP), and it looks like
there are no hardware limitations on this platform too (DMA has 36-bit
support, etc.), limiting the available memory in U-Boot is still the
easiest way to workaround the EL3_MON problem, and 2 GiB is enough for
all use cases in U-Boot currently. And of course all 4 GiB of RAM is
available to use in Linux in any case, so it's not a bad tradeoff, and
in fact it just brings back the previous behavior (before the "Reinstate
access ..." patch).

Enabling LMB_LIMIT_DMA_BELOW_RAM_TOP for the whole ARCH_EXYNOS9 family
also seems justified, as it's likely that all modern ARM64 Exynos chips
may share similar EL3_MON software, and thus possibly the same PSCI bug.
For example, a similar issue was mentioned in exynos-mobile related
patch [2], stating that after "Reinstate access ..." patch only CPU0 is
able to come online on some variants of the Samsung Galaxy J6 (based on
Exynos7870 SoC).

This was tested on the E850-96 board:

  1. Using 'bootefi' to boot the Linux kernel image
     - before this patch: the issue is reproducible
     - with this patch applied: the issue is not reproducible
  2. Using 'booti' to boot the Linux kernel image from 0x8_8000_0000
     - before this patch: the issue is reproducible
     - with this patch applied: the image can't be loaded there anymore
       ("Reading file would overwrite reserved memory"), as the second
       RAM bank is reserved in LMB again
  3. Using 'booti' to boot the Linux kernel image from 0x8000_0000
     - the issue is not reproducible

[1] https://support.arm.com/documentation/den0022/fb/
[2] https://lore.kernel.org/u-boot/20260614-j6lte-lmb-v2-1-6046b54db536@disroot.org/

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 lib/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 021a82d47092..e0bfd10f2b7f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1371,7 +1371,8 @@ config SPL_LMB_ARCH_MEM_MAP
 config LMB_LIMIT_DMA_BELOW_RAM_TOP
 	bool
 	depends on LMB
-	default y if ARCH_BCM283X || ARCH_MVEBU || ARCH_ROCKCHIP || STARFIVE_JH7110
+	default y if ARCH_BCM283X || ARCH_EXYNOS9 || ARCH_MVEBU || \
+		     ARCH_ROCKCHIP || STARFIVE_JH7110
 	help
 	  Some architectures can not DMA above ram_top boundary,
 	  which is after 4 GiB or 32-bit boundary too. Limit the

base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
-- 
2.47.3

