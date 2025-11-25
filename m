Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6B4D0E6F9
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 14:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BEEC8404D;
	Tue, 25 Nov 2025 15:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="2ZoHF2dm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD31840AA; Tue, 25 Nov 2025 15:54:26 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1544384011
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 15:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 9E14F1A1D39;
 Tue, 25 Nov 2025 14:54:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6AF3A606A1;
 Tue, 25 Nov 2025 14:54:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 40887102F087D; Tue, 25 Nov 2025 15:54:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764082462; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=p1gbsH9bd7E92yGZEj5k4EPl0DtgbhbXBwQ6Yn9gHGQ=;
 b=2ZoHF2dmODD/8Uu7IpLrIKbEz/TaSotMyWlUDjKbDyuC2ccUjU1CB2I5DCuzPe+ICkrok0
 WPKSC3MNN3jyKb0l66duvBjxFgkL/eNmMSN9aDK/XCG22f8crLnXVX7I7hmxLELXUnURUm
 Uu3lrmBDAaR0hUsqcFINEyo9AcCz7rF2tNr9xuR84tgnMsOWyJVE8wYISl1ijQgpfkKZGt
 ABclZzmbr6HGp9rE/AYBtH7P4xgMUGlDCjMttcIW3yNRni3KE/xh9mnmavA3ktdDSvWPtj
 2StJuLp6SSr8Ec/Ois2tML4R37j2XDdhbb31XWZz4WplrCW8jzGFstZ1tvpF0A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,  dinesh.maniyam@altera.com,
 Jan Kiszka <jan.kiszka@siemens.com>,  Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Tom Rini <trini@konsulko.com>,  Andre
 Przywara <andre.przywara@arm.com>,  Andrew Goodbody
 <andrew.goodbody@linaro.org>,  Tien Fong <tien.fong.chee@altera.com>,  Kok
 Kiang <kok.kiang.hea@altera.com>,  Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,  u-boot@lists.denx.de
Subject: Re: [PATCH] driver: nand: skip BBT scan during SPL to reduce size
 and complexity
In-Reply-To: <45a5d75f-99f6-4583-9071-2f892aadb2e6@mailbox.org> (Marek Vasut's
 message of "Tue, 25 Nov 2025 12:55:30 +0100")
References: <20251113030357.15397-1-dinesh.maniyam@altera.com>
 <e7e19789-6c0b-4ede-b7a3-ad5002a7b9ed@gmx.de>
 <45a5d75f-99f6-4583-9071-2f892aadb2e6@mailbox.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 25 Nov 2025 15:54:19 +0100
Message-ID: <87tsyiupr8.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 25 Nov 2025 15:57:19 +0100
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

On 25/11/2025 at 12:55:30 +01, Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 11/25/25 1:00 AM, Heinrich Schuchardt wrote:
>> On 11/13/25 04:03, dinesh.maniyam@altera.com wrote:
>>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>>
>>> Guard the Bad Block Table (BBT) scanning with `#ifndef CONFIG_SPL_BUILD`
>> Thank you for looking into this issue.
>> In the patch you use CONFIG_XPL_BUILD not CONFIG_SPL_BUILD.
>>=20
>>> to prevent running `chip->scan_bbt()` in SPL builds.
>>>
>>> The SPL only requires basic NAND read functionality to load the next
>>> stage and does not need full BBT management.

You do not need full BBT management, but you probably need some of it,
at least the part that finds it and interprets it, for sure.

>>> Running the BBT scan in
>>> SPL unnecessarily increases code size, memory usage, and boot time.

"unnecessarily" :-)

>>>
>>> This change ensures the BBT is scanned only in U-Boot proper, where the
>>> full NAND subsystem and dynamic memory are available.
> How do you guarantee that the content that you read from the NAND is not
> corrupted, or read from already spent cells, or is even aligned with
> what U-Boot would read after scanning the BBT ? NAND suffers from
> considerable bitflips and short cell erase cycle count, the bad block
> table scanning is very likely mandatory. Disabling it because it
> increases code complexity and size is not a good reason for disabling
> it.

I agree with Marek, you cannot simply close your eyes on the BBT. You
*really* need to know what you're doing here.

In some cases (which must be clearly identified by the system owner) you can
leverage the BBM only, but:
- this requires a bit of logic anyway (finding the BBM location +
  reading and remembering the block state)
- some drivers set NAND_BBT_NO_OOB_BBM which prevent the OOB to be used
  for writing the BBM, in which case you don't have any other choice
  than searching for a BBT.

A third option might be tempting, but is IMHO unreliable, it is to rely
on the ECC results. For instance, many chips still use Hamming ECC
schemes, which will generate invalid reports above 2 bitflips. So on a
badly damaged block you will end up with misses. Also hoping for the ECC fe=
edback to
tell you a block is bad would require to read the entire block, because
any single page in a block may lead to a block being assumed bad. It's not
like you can just read X pages and tell "I have no error, so it's
fine". Because if the block was declared bad by the OS because of page >
X, you won't detect it and you'd read stale data.

Thanks,
Miqu=C3=A8l
