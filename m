Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66443C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFD2C8643D;
	Mon,  4 Sep 2023 18:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="bEnUeaWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FEC8682B; Mon,  4 Sep 2023 18:52:57 +0200 (CEST)
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net
 (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F19AD863DC
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 18:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=CMka/bQ6hD+aPN9PD/DZoTfml2GvsRONp5MsHJltdbE=;
 b=bEnUeaWTIVVs2jSOWvDt+e8vLfhoWo+26WFSjRnMWuBAJbv6F5PiCjGYcRZ4SKmXbMp4
 YLhns+4WYWYO9k95+FOtcuFS01YNgUT7G/jlZfx4mRqwM1pF+4vOM9red5YhymskM5b7tb
 qhJ2sWEKr/g5mTKD4R0z5UgkEeR9pmFuqJuWv5Az0EvLMx0dsuLWcmGXlsUQol1F0DNfLK
 e7+wNx0bMieGnjUi8IebfTFMsGA8/7mbtKpdIlVZW/EihO9Wwx2lD7ch44TlfszAdxRAYM
 kbUoVBPuxKYhYWGZ3u5fEUaE9cbIMHgoLPAGbCFXtdwsdcuntSd6zL1cBLCz+5vQ==
Received: by filterdrecv-d7bbbc8bf-s5hdm with SMTP id
 filterdrecv-d7bbbc8bf-s5hdm-1-64F60B65-16
 2023-09-04 16:52:53.44216519 +0000 UTC m=+10084395.378913855
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-9 (SG) with ESMTP
 id gU9U6rOLSQuEEyDg4ftDfQ Mon, 04 Sep 2023 16:52:53.124 +0000 (UTC)
Message-ID: <c2b9e22b-e55a-03d3-1bac-f7801a8d60c4@kwiboo.se>
Date: Mon, 04 Sep 2023 16:52:53 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Binman how to build using Rockchip BL32 binary as OP-TEE
Content-Language: en-US
References: <CAC928HYMtd=RZnZYW9CNc5wPjzGk11X0+RpcuwHMFEuUpv0C4w@mail.gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAC928HYMtd=RZnZYW9CNc5wPjzGk11X0+RpcuwHMFEuUpv0C4w@mail.gmail.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h0ZprrWiKLPiVuR2y?=
 =?us-ascii?Q?KmEKax=2FXMEfgPND1WQtqLQz3lYyrBVMMNFj93WO?=
 =?us-ascii?Q?RHmHrsMFa4tZioPbIOt=2FNcSONVI2aD99FgV+Xrq?=
 =?us-ascii?Q?qEZfCcP8LEW1IJGLc+lEl0E2wcemqd=2FQcEe0XwE?=
 =?us-ascii?Q?Fi3UH+lSJcdmzKqsNOoKYfCiwYrZjdxwyW2n51?=
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>, Simon Glass
 <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

Hi Massimo,

On 2023-09-04 17:05, Massimo Pegorer wrote:
> Hi,
> 
> Is there any way for binman to package FIT with U-Boot TF-A and
> OP-TEE, using bl32 binary provided by Rockchip as TEE?
> 
> I've tried with TEE=/path/to/rkbin/bin/rk33/xxx_bl32_vX.YZ.bin, but
> binman failed.
> 
> In my poor understanding of Python code, it seems binman accepts only
> ELF format or a binary format starting with optee_v1_header, but
> binaries provided by Rockchip in rkbin repository do not have this
> header.

One way that I have used/tested before was to create a tee.elf version
using something like:

$ aarch64-linux-gnu-objcopy -B aarch64 -I binary -O elf64-littleaarch64 xxx_bl32_vX.YZ.bin bl32.o
$ aarch64-linux-gnu-ld bl32.o -T tee.ld -o tee.elf

tee.ld:
----
ENTRY(_binary_bl32_bin_start);

SECTIONS
{
        . = 0x08400000;
        .data : {
                *(.data)
        }
}
----

And then make with TEE=tee.elf, however keep in mind that U-Boot may not
treat the memory region used by OP-TEE properly for aarch64.

Regards,
Jonas

> 
> Thanks in advance for any hints!
> 
> Massimo

