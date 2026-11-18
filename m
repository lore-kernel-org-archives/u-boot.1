Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF2606A334
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=njtNI5/a;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UKOa5xW8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 669B5608A3;
	Wed, 18 Nov 2026 09:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1vSs55T3za4O; Wed, 18 Nov 2026 09:53:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 23AEC6084B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794995613;
	b=AI1YDi4lYbhLI8SG2tfz4eAfOm+5bqzz6uStmPBBF3KcIXjRkYZMrku0G6lFw80Hkmov
	 KfDU0jhOzbkSExc6Yl1qf77w8/f/p5IoxmETZJ03q37h3USpB5o7LXwAO/lfhGkKSEvR8
	 +LD/wbkq5VqlayGk4E0WlXgfKGG/xCud+DpED4aNYzOYCGYtILr5rgPzqRnOap6DsiuCY
	 MUcqDACqeYg1zq3WSV4VZx3StsETslR+vCOGovMVORRSpT58Trv3pPkWLzm6hz7q5NljN
	 95yUVMyizOpwlEZyshP6ZdT+jLUU+aeVLOFd8nT1Trgc162u1DYxXtiIPp0MwiWC8vw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794995613;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QD3BZVrHgVqbwcXG5uvAOOAjOuy2DfvW0dA1TB6wknM=;
	b=kSs//hUThjYa/kTFE/ZrYYS3nTgz4/pcL/g60SuFz/n6fZ25S3//RpGCitxJy5EkP6/Y
	 PwJFYvzRPm2Z6S1200QLZc5yYkqdl5YGZueh2UciFwiPuo2QokwFru+/WT/E63Usg8fSW
	 kiTzyV1M5ugK6UHrv3ZVrp9DDTQdus9EUkT4r4npomTCgBt8ha2FPj82j0BnUDNIs5EqW
	 8fT01IiYHToN++yv2i0iKcdtQYNVZqVFuI/vaOMw1VVctFU7JjNLkWFsr7VEiVohD+NKc
	 xm0ABlW57xMxMWqZxZ7OumrKKbXjxJrClyhPaKs9fMTCXJ1zViAMf3SAJzokbF27UQg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794995613;
	bh=QD3BZVrHgVqbwcXG5uvAOOAjOuy2DfvW0dA1TB6wknM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=njtNI5/auc/gTgddz6zpzAlopABzAIfZkgDgqf4jsgRDEVzVA5OCkNUor4lwd2e90
	 wOH8iLE+/mzuKXDwwqjNLYBDQ3Co/OeXVpkKjn1M3/6c3nZ5W08/JGoNuThKWizXcG
	 NMVvxwvYFE9pgbqo+AgrNx42ih+2xRVVItQyY9XIdGAiMqKImrRw+KdP1xOIvhU2zj
	 08OjphIMJZ5W7Auvo5HP0aqygL26YFkzfKftlfA+mJQL7JtmVRmHS2ifCfbn0hImun
	 bJWOyW8HVz43UIujLqblYHbyipOf+2ufWqQrtlb+7/ejYKq8zilCQcsOmEHGncAX87
	 t66C4o0C19ppA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23AEC6084B;
	Wed, 18 Nov 2026 09:53:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 87DD361
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79D2B80CD4
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XoQJHRpSKm6g for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 09:53:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 70F4C80C86
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=UKOa5xW8
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 70F4C80C86
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:53:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E36945B48;
 Wed, 18 Nov 2026 09:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6881F000C4;
 Wed, 18 Nov 2026 09:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794995609;
 bh=QD3BZVrHgVqbwcXG5uvAOOAjOuy2DfvW0dA1TB6wknM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=UKOa5xW8U/4IytCCDpZtgrTZRwgEnjwGCkjuT7l4tEpJP6pr60a6IyBEzKY3ruv+K
 zFXzFKKeIORH/pYU4wI90uflpoRk0vOdSbvc8OGUDRnRHbAeml2ft+uOudSUMNpA+S
 8jnqktxUwSRskjz//9K5LbGrfY8cW23aI25owq3Fms//1YvqgJ2GtViomk6P6K//6r
 5L0NBK0pi4mthtYfHH1/2YX8x75BCe9frnyLvziZpcT7KgZVVtDNQJjslAn9WwwjEb
 yEb40q+uZccX2im6OAH/05ux1/AsIQg/4JZT6DuQgcpLmEz82kl+mHrrbjJjXhSa2T
 YZsx12TGZIfaQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>, Marek
 Vasut <marek.vasut+usb@mailbox.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, Francesco Valla
 <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, Aristo Chen
 <aristo.chen@canonical.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>,
 Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/6] Support fastboot boot in SPL
In-Reply-To: <av1KkSo_66l1C33S@macbook>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <179492230542.246593.14014203987510433850.b4-ty@b4>
 <av1KkSo_66l1C33S@macbook>
Date: Wed, 18 Nov 2026 10:53:26 +0100
Message-ID: <xhkdbv75upisp.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Carlo,

On Wed, Nov 18, 2026 at 07:51, Carlo Caione <ccaione@baylibre.com> wrote:

> On Tue, Nov 17, 2026 at 14:31:45 +0100, Mattijs Korpershoek wrote:
>> Hi,
>>
>> On Wed, 14 Oct 2026 14:24:28 +0200, Carlo Caione wrote:
>> > Test farms need to run successive U-Boot builds without rewriting boot
>> > storage. Add optional fastboot boot support to SPL so an already-runni=
ng
>> > SPL can receive U-Boot over USB and hand off to it in RAM. U-Boot prop=
er can
>> > then load the operating system using its usual boot methods.
>> >
>> > The standard host command, fastboot boot u-boot.itb, accepts a FIT bui=
lt
>> > for the target, including any firmware required by its SPL handoff.
>> > Uncompressed legacy U-Boot images and raw binaries are also supported
>> > when enabled by the board. Raw binaries use the board's configured load
>> > and entry addresses. Legacy and raw downloads are rejected when SPL FIT
>> > signature verification is enabled.
>> >
>> > [...]
>>
>> Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-bo=
ot-dfu (u-boot-dfu-next)
>>
>> [1/6] spl: fit: reject failures loading an explicitly requested FDT
>>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/comm=
it/088e6f84ba52e62b96b018d48fc0a9d5deb57307
>> [2/6] fastboot: invalidate stale and incomplete downloads
>>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/comm=
it/c99169ecd5aacd748dd2a84837ae80b346fd8e07
>> [3/6] spl: ram: allow loading FIT images from a supplied buffer
>>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/comm=
it/0160e29255b32b0f0158da4cae69bf360aa9e6d2
>> [4/6] spl: support booting FIT images downloaded with fastboot
>>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/comm=
it/93ba4e8d4d3d5c75470e9e4a805997260182d9d5
>> [5/6] spl: fastboot: support legacy U-Boot images
>>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/comm=
it/a8ed070e54f83cb16149db910b2c46297e7e7828
>> [6/6] spl: fastboot: support raw U-Boot images
>>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/comm=
it/c52cc53f454a3f7e039357a839a2b92f56432bc6
>
> Hey Mattijs,
> just to double check because I see this reply to my V1, but the revision
> to apply should be V3 at [0].
>
> [0] https://lore.kernel.org/all/20261116-ccaione-upstream-spl-fastboot-bo=
ot-v3-0-7b39e7a348c6@baylibre.com/

Yeah, I did explicitely apply v3.
Here is the history of what I've done:

$ b4 shazam -s -l --check 20261116-ccaione-upstream-spl-fastboot-boot-v3-0-=
7b39e7a348c6@baylibre.com
Looking up 20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@ba=
ylibre.com
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 8 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 36 code-review messages
Checking attestation on all messages, may take a moment...
Retrieving patchwork CI status, may take a moment...
---
  =E2=9C=93 [PATCH v3 1/7] spl: fit: reject failures loading an explicitly =
requested FDT
    + Link: https://patch.msgid.link/20261116-ccaione-upstream-spl-fastboot=
-boot-v3-1-7b39e7a348c6@baylibre.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
    =E2=97=8F checkpatch.pl: passed all checks
  =E2=9C=93 [PATCH v3 2/7] fastboot: invalidate stale and incomplete downlo=
ads
    + Link: https://patch.msgid.link/20261116-ccaione-upstream-spl-fastboot=
-boot-v3-2-7b39e7a348c6@baylibre.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
    =E2=97=8F checkpatch.pl: passed all checks
  =E2=9C=93 [PATCH v3 3/7] usb: gadget: fastboot: do not boot after a faile=
d acknowledgment
    + Link: https://patch.msgid.link/20261116-ccaione-upstream-spl-fastboot=
-boot-v3-3-7b39e7a348c6@baylibre.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
    =E2=97=8F checkpatch.pl: passed all checks
  =E2=9C=93 [PATCH v3 4/7] spl: ram: allow loading FIT images from a suppli=
ed buffer
    + Link: https://patch.msgid.link/20261116-ccaione-upstream-spl-fastboot=
-boot-v3-4-7b39e7a348c6@baylibre.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
    =E2=97=8F checkpatch.pl: 261: WARNING: Use 'if (IS_ENABLED(CONFIG...))'=
 instead of '#if or #ifdef' where possible
  =E2=9C=93 [PATCH v3 5/7] spl: support booting FIT images downloaded with =
fastboot
    + Link: https://patch.msgid.link/20261116-ccaione-upstream-spl-fastboot=
-boot-v3-5-7b39e7a348c6@baylibre.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
    =E2=97=8F checkpatch.pl: 288: WARNING: Use 'if (IS_ENABLED(CONFIG...))'=
 instead of '#if or #ifdef' where possible
    =E2=97=8F checkpatch.pl: 454: WARNING: Use 'if (IS_ENABLED(CONFIG...))'=
 instead of '#if or #ifdef' where possible
    =E2=97=8F checkpatch.pl: 479: WARNING: Use 'if (IS_ENABLED(CONFIG...))'=
 instead of '#if or #ifdef' where possible
    =E2=97=8F checkpatch.pl: 488: WARNING: Use 'if (IS_ENABLED(CONFIG...))'=
 instead of '#if or #ifdef' where possible
  =E2=9C=93 [PATCH v3 6/7] spl: fastboot: support legacy U-Boot images
    + Link: https://patch.msgid.link/20261116-ccaione-upstream-spl-fastboot=
-boot-v3-6-7b39e7a348c6@baylibre.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
    =E2=97=8F checkpatch.pl: passed all checks
  =E2=9C=93 [PATCH v3 7/7] spl: fastboot: support raw U-Boot images
    + Link: https://patch.msgid.link/20261116-ccaione-upstream-spl-fastboot=
-boot-v3-7-7b39e7a348c6@baylibre.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
    =E2=97=8F checkpatch.pl: passed all checks
  ---
  =E2=9C=93 Signed: DKIM/baylibre.com
---
Total patches: 7

Somehow 'b4 ty' send the wrong confirmation email.

You can double check at
https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commits/u-boo=
t-dfu-next
to make sure, but I believe this is v3.

Thanks for following-up on this.

Regards
Mattijs

>
> Thanks,
>
> --
> Carlo Caione
