Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E036ECD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C16284869;
	Mon, 15 Jun 2026 14:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g9dQRpwz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D698684884; Mon, 15 Jun 2026 14:30:49 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53824846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A797741979;
 Mon, 15 Jun 2026 12:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BD81F0156A;
 Mon, 15 Jun 2026 12:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781526645;
 bh=7xYwdvHNiqW8IKZ1FzjowciEETRs8wyxnCvKLQ1EltU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=g9dQRpwzX44KYP9rqpQrNcuqitmtU1ie4pFDQCkjM4Byx3udHfbUkVkNb6FZJpkW2
 ox5osL+zzfB7rWz2fPIYPTIrxL6bJQFIFQtZBG1YDCidG8NcSM6ZobZU4ssQyHw7ZM
 vIvYPJXtwTQtIOkI81X67O25iss6ZeQM4TnO5fGWagDB7pv83BlxdJhtOn5XZxhGlp
 jgeaAxQzVtbPg1ykYAgH2W3DuF8kgPMldNpvCkNjibsPGEud/8zMshT91DSWFK7tVb
 kJfXQ34EHVgLUnH02ybXSRDdqEy6cwjc6fnPsUCvRd7EeJnvsoEPcpYXOEdIKTWSJp
 cODDDLtfKk+2Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, me@samcday.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Heiko Schocher <hs@nabladev.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, Casey
 Connolly <casey.connolly@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/2] cmd: fastboot: Add keyed abort option
In-Reply-To: <CAFLszTgX3x2hoFTWVy2WCuKRuZAB_T+QLAp13YTkhbM8wpkZRg@mail.gmail.com>
References: <20260602-fastboot-abort-keyed-v1-0-414aac5a06b8@samcday.com>
 <20260602-fastboot-abort-keyed-v1-1-414aac5a06b8@samcday.com>
 <CAFLszTgX3x2hoFTWVy2WCuKRuZAB_T+QLAp13YTkhbM8wpkZRg@mail.gmail.com>
Date: Mon, 15 Jun 2026 14:30:43 +0200
Message-ID: <87wlw0gf4c.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Sun, Jun 14, 2026 at 05:49, Simon Glass <sjg@chromium.org> wrote:

> Hi Sam,
>
> On 2026-06-02T08:45:46, Sam Day via B4 Relay
> <devnull+me.samcday.com@kernel.org> wrote:
>> cmd: fastboot: Add keyed abort option
>>
>> Works the same as CONFIG_CMD_UMS_ABORT_KEYED does: any keypress will
>> abort fastboot mode (rather than only ctrl-c).
>>
>> Signed-off-by: Sam Day <me@samcday.com>
>>
>> cmd/Kconfig    | 6 ++++++
>>  cmd/fastboot.c | 9 ++++++++-
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>
>> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
>> @@ -103,8 +103,15 @@ static int do_fastboot_usb(int argc, char *const argv[],
>>       while (1) {
>>               if (g_dnl_detach())
>>                       break;
>> -             if (ctrlc())
>> +             if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
>> +                     if (tstc()) {
>> +                             getchar();
>> +                             puts("\rOperation aborted.\n");
>> +                             break;
>> +                     }
>> +             } else if (ctrlc()) {
>>                       break;
>> +             }
>
> I wonder if you could create a shared function (gadget_abort_check()
> ?) to keep this and the code in usb_mass_storage.c in sync?

While I usually advocate to avoid code duplication, I don't think it's
needed to create a new function here. It's only a couple of very simple
lines.

To me this can stay as is.

>
>> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
>> @@ -103,8 +103,15 @@ static int do_fastboot_usb(int argc, char *const argv[],
>> +             if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
>> +                     if (tstc()) {
>> +                             getchar();
>> +                             puts("\rOperation aborted.\n");
>> +                             break;
>> +                     }
>
> Can you please update doc/android/fastboot.rst to mention the new
> Kconfig and the abort behaviour. There is currently nothing in that
> file about how to leave fastboot mode at all.

For the current behaviour, I have send:
https://lore.kernel.org/all/20260615-fastboot-doc-ctrl-c-v1-1-f932dea17c0a@kernel.org/

>
> Regards,
> Simon
