Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0BDCCA464
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 10:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06F8581488;
	Fri, 16 Oct 2026 10:06:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q_FSJKwiNo31; Fri, 16 Oct 2026 10:06:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 39C2E8146F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792145184;
	b=Y4RPNXm0I1lvRkWXangpMkyka1hr1gxEPmEmoQ4lWd0SGE1oip4zAaAvwfwiCxMtkRrK
	 ydThy3Xcn+/C6dAeOaMrQHCmZdL+YrYdQGzUxlq2nu+00UUkMGq2/dbj5lVKZ1WAl5trf
	 mKDH3jGrqMG/2CZGFg5vU43fClsITiGlpIB04/t92LJ5c5uHpj6A42B72uBcB4paUlSZ4
	 HpHp+WyZBTVz918WJy+0NRFhnLjjJHLVEtXY9Yc/obIv3X+3XrOB41g4z2xujPk2G8T/Y
	 k8JaGMNDHJhBPOtycdn8PXxEtn+9cQHRGeALxwFKunwR1i9uhvXj5/HYnoBeGxG052A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792145184;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bGhqQQvmLF63PwmOfjcMKQUcGDyUCgYjyVCVdriJzI8=;
	b=MkRpTF2wnTxfBzVzp1t5/gGPAumS2sJh+Gp2grNIG/nFrShyYpqoKCSaQcb5DYYPmuvo
	 OCke/Bxqii+5Xo6AXzjq7d3HSLio63CJyo3GIxh5GrBhJpXlb1SupoE5yG0Hfm0JL34fn
	 glCAQNrfhZY/DbgKmBwdKwOK8W9R2p7uh3irw1gYwf1OSYQZOGSMzbBgfqq49dC6X3hzT
	 /u9Ci7O+r583GhaGUccRgzejwzegDX8IYjrMi9MXUWRRNNXOFHB+MF42sOQZsECclL0Eq
	 7MPjqb0cLF0kunTB3mxl5cDLbemIOrJxBmYD1FFLMuLIT65TcSfPV9/eBuJmYbeDEwA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAsX9eNq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792145184;
	bh=bGhqQQvmLF63PwmOfjcMKQUcGDyUCgYjyVCVdriJzI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S7sN9cH2A0OqM2cJmMGM+gRWctvDtWQk5dYeBjmdKyu3lrkxLcrQ5FVJ4cJjPxjpv
	 +oOVRytv6APftlKSq/FbmJgTagri8eT4X/4HSsy65UcM/bHXWvhto1ixDZZhz6/j2O
	 TmCIdFwHINDp76V1nwOhVoFUAnxo6bsBm6QLcRrNKvxdFXaNBgkGlRHaecCUsnrd7r
	 OIMvm17IAm1S2SjiKGfBV0WU3TvHQH6o998wzq4wG3xQKNgKBXhyB7RmJ+r1Cm75L8
	 BBVGrQ7qkDxSbHj3IE/099SiMRf/jokUpiZeEYFfrDn3jtV9KjmAo1uWKTkoOEvxF6
	 EyZcrUHFZkr6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39C2E8146F;
	Fri, 16 Oct 2026 10:06:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BEE661DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B075B8146F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:06:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L0WdakBFbhnI for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 10:06:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E4CB68146E
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792145182;
 b=MS8Q5qaRRTzk5tCgTjuF23PzH0io045xbIcb21vA3Gqaj2qjjZ9SjBkqQIqTp9Y33Zcs
 2IGhCjgHY3zO9xlmtCdBf31X1FeYljNDXxnOjUFaqCglruPvhrALAnCPKmafLb2mBaurp
 O3JMCgGZny6c4jErZkIKRyAilSRf8KfS1LXdBDjR6aesD/09ku9kUt7JM0+VuBglX7/2r
 //oHNMw14XrFq2a9QWhEkk9OH+OWW72qvVTPM7JSUBBiXQhJTQ/7fuyQLEJBoqu10fJOX
 V9RtGg0TOF+fcLTffvij9ZE0avmGFOwbNvgn2U/xyiZXaADKS+p3yK823mmUCgf0rRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792145182;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=bGhqQQvmLF63PwmOfjcMKQUcGDyUCgYjyVCVdriJzI8=;
 b=m/QKEf2y+eVaIiwv87BvtN2aq41hB9S7WqCPfWRLu4Ctt49AASr7CxwgCgWWlhT4GwWu
 jgmN8sTsUTiW3lFnnW+caSNOJwhwWJwjeDoNy1LuJ1tgoY6DzCMt4B8iFlOkZ6g4wxLEL
 5LabOY9Yn3+cBW6ubqol0rraiD6y0ZNsQs8pxLS0isdPscD82ciTNTOUL5qdOuPYf4mfK
 BflR1uIdh8PdKVK/ZwmNdWUckOBtCWYZTWlvvv+nSth8yzxq+VUimwnRE0+sCLvLUjVVm
 CAoYiRNNDLVb7osVq9uprmeDL46WzGAnU5I29hiQNXU8VS9BQjArm7n/UhtMHdJnLuw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iAsX9eNq; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iAsX9eNq
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4CB68146E
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 10:06:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA26360008;
 Fri, 16 Oct 2026 10:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8821F000C4;
 Fri, 16 Oct 2026 10:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792145176;
 bh=bGhqQQvmLF63PwmOfjcMKQUcGDyUCgYjyVCVdriJzI8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=iAsX9eNqTRuwM/732j0wUkQLW1WTceMRBjN5o39a3K4xPzgQLhn+tBN8F+PT2Ko7E
 muFYrGzpttLxna+2JIks9plBbOMiZRyjybIHkDpJlrM9nQ84CD3j1Dnrh3YNnqVCX9
 +jZXszDX5/eBIjJaitI3GxL99TnvRM/be8OoHqscy9x5/6EQmuS2UX5NLtnbkxRqY7
 YbaDE92Qe5jiKLMsPOi0+VhS7Z0giy/bZFzkpCjUSDhrfJ/1i3MpDrEjP4Pg+L8usy
 SIY60gZc5OOgv/n0HTRslnGztmagkLo6Qiv3VpAd6/KU9ycnPVBbhzYY63Vq/NjgXd
 jVrDMYvAroWQg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: phodina <petr.hodina@protonmail.com>
Cc: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>,
 u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>, Sean Anderson <sean.anderson@linux.dev>, Casey
 Connolly <casey.connolly@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Antony Kurniawan Soemardi
 <linux@smankusors.com>, Petr Pavlata <petr@acrux.cz>, David Heidelberg
 <david@ixit.cz>
Subject: Re: [PATCH 1/2] dfu: expand ${...} env references in dfu_alt_info
 before parsing
In-Reply-To: <aj8wvIhFZdSil-1q2YQVmKKzohzAE5YcQ-Qb5PT-k7NI29-4EtV5b03isWC-dHOh9tjjyKP-1SWvZgmcfYcus6ip4_5C2y7v8LKldPJG0hg=@protonmail.com>
References: <20261004-b4-dfu-alt-info-env-expand-v1-0-700eb0e54b61@protonmail.com>
 <20261004-b4-dfu-alt-info-env-expand-v1-1-700eb0e54b61@protonmail.com>
 <xhkdbjynl7kcz.fsf@mkorpers-koolstof.csb>
 <aj8wvIhFZdSil-1q2YQVmKKzohzAE5YcQ-Qb5PT-k7NI29-4EtV5b03isWC-dHOh9tjjyKP-1SWvZgmcfYcus6ip4_5C2y7v8LKldPJG0hg=@protonmail.com>
Date: Fri, 16 Oct 2026 12:06:14 +0200
Message-ID: <xhkdbtsmm559l.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Oct 13, 2026 at 15:59, phodina <petr.hodina@protonmail.com> wrote:

> Hi Mattijs,
>
>
> On Tuesday, October 13th, 2026 at 4:20 PM, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>
>> Hi Petr,
>> 
>> Thank you for the patch.
>> 
>> On Sun, Oct 04, 2026 at 22:48, Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org> wrote:
>> 
>> > From: Petr Hodina <petr.hodina@protonmail.com>
>> >
>> > As dfu_alt_info is read via env_get() it needs to expand the ${var}
>> > references using cli_simple_process_macros.
>> >
>> > Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>> > ---
>> >  drivers/dfu/dfu.c | 16 +++++++++++++++-
>> >  1 file changed, 15 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
>> > index 90d8b45ce8a..fa074db242c 100644
>> > --- a/drivers/dfu/dfu.c
>> > +++ b/drivers/dfu/dfu.c
>> > @@ -6,6 +6,7 @@
>> >   * author: Lukasz Majewski <l.majewski@samsung.com>
>> >   */
>> >
>> > +#include <cli.h>
>> >  #include <env.h>
>> >  #include <errno.h>
>> >  #include <log.h>
>> > @@ -178,7 +179,20 @@ int dfu_init_env_entities(char *interface, char *devstr)
>> >  		return -EINVAL;
>> >  	}
>> >
>> > -	env_bkp = strdup(str_env);
>> > +	/*
>> > +	 * Expand the dfu_alt_info here as it's read via env_get() which
>> > +	 * does not expand references the way hush does for a command line
>> > +	 */
>> > +	env_bkp = malloc(strlen(str_env) * 2 + 1);
>> 
>> Can we explain why we picked strlen(str_env) * 2 + 1?
>> 
>> Is it an arbitrary choice or is there any justification?
>> 
>
> It's just good enough solution to work the problem of flashing the pinephone pro and skipping the USB3 phy enumeration issue for the maskROM and rkdeveloptool commands :)

I see. It's really nice that the pinephone pro can be flashed with this!

>
> Then again you are right here to ask about the implementation.
>
> Looked around and there are two more consumers in 'boot/pxe_utils.c' and 'boot/bootm.c'.
>
> My take on this expansion size problem would be to add a helper function that runs the expansion first just counting the size needed. Then allocate the buffer. Say implemented as such:
>
> -       env_bkp = malloc(strlen(str_env) * 2 + 1);
> +       size = cli_simple_macros_size(str_env);
> +       env_bkp = malloc(size);

I like this idea, but looking at the code in common/cli_simple.c this
does not seems easy to implement (at least to me)

Looking a bit more at this, it seems that a lot of boards have a local
define DFU_ALT_BUF_LEN set to SZ_1K:

$ rg '#define DFU_ALT_BUF_LEN'
board/xilinx/zynqmp/zynqmp.c
639:#define DFU_ALT_BUF_LEN             SZ_1K

board/xilinx/zynq/board.c
172:#define DFU_ALT_BUF_LEN                SZ_1K

board/xilinx/versal/board.c
314:#define DFU_ALT_BUF_LEN             SZ_1K

board/xilinx/common/board.c
72:#define DFU_ALT_BUF_LEN              SZ_1K

board/amd/versal2/board.c
363:#define DFU_ALT_BUF_LEN             SZ_1K

board/emulation/common/qemu_dfu.c
12:#define DFU_ALT_BUF_LEN              SZ_1K

board/st/common/stm32mp_dfu.c
18:#define DFU_ALT_BUF_LEN SZ_1K

board/socionext/developerbox/fwu_plat.c
13:#define DFU_ALT_BUF_LEN 256

arch/arm/mach-rockchip/board.c
41:#define DFU_ALT_BUF_LEN                      SZ_1K

In my opinion, it's good enough to use SZ_1K for the buffer length here,
documenting with a comment that it's based on DFU_ALT_BUF_LEN.

Does that work for you?

If you want to attempt cli_simple_macros_size() instead, feel free to do
so, of course.

>
> Alternatively we can preallocate some buffer size and attempt to increase it in a loop (bounded to some max size).
>
> What do you think?
>
> I'd later also send another patch series that would fix the expansion in the 'boot/pxe_utils.c' as it's fixed to CONFIG_SYS_CBSIZE and does not check the return value. Matching the implementation we deem as a correct one.

I agree that we should check the return value, good catch!

Thanks
Mattijs

>
> The reason is we'd like to use the PXE to boot the CI images later as alternative means to the DFU.
>
> '''
>         if (label->append) {
>                 char bootargs[CONFIG_SYS_CBSIZE];
>
>                 cli_simple_process_macros(label->append, bootargs,
>                                           sizeof(bootargs));
>                 env_set("bootargs", bootargs);
>         }
> '''
>
>  
