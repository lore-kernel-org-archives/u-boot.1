Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1459CD6E58
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 13:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39BD083E5D;
	Thu, 13 Nov 2025 14:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Pr3HH/up";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7F3E83D77; Thu, 13 Nov 2025 10:50:39 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5D583979
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 10:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 6E4A14E41687;
 Thu, 13 Nov 2025 09:50:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 433EC6068C;
 Thu, 13 Nov 2025 09:50:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2547E102F22B0; Thu, 13 Nov 2025 10:50:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1763027436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=l10CxMqy4oEHJpg6/AnS22JgF8JFdEh3egptznF/7lc=;
 b=Pr3HH/upc/X+VzghKQKJFDEwvBPv/n+SDiJ3bc2KBqtj/TwncmTtgv6/vVJgQGGhW4eU9I
 lkJ0rwMiQlMBv0Pux2IB8drJ2Owa9u49h1/IfdWRVVWctZiDtv3DzSIikuh5aCB8wBdqO6
 7ry0Yu/OhRnuwW8P3W2BLuPPhL9opaMjKl9QI0Hd/nDgGRI7ogWZufe3xmBrPPVmdYGVqm
 n73d2Byzzndr/IGsbcqYiwSyHj2J9xCiqvfQzLuY3Ebpsmv5VYPdSZf9JAfjdGtA2++mdo
 hk3Tn3yuSIxwpv2b/6Fv08AkSTRHPDkvcTYQqgNioev3KCtYVw4L0qhZ/Vp66w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Vignesh R <vigneshr@ti.com>,  Tudor Ambarus <tudor.ambarus@linaro.org>,
 Tom Rini <trini@konsulko.com>,  <u-boot@lists.denx.de>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Steam Lin <stlin2@winbond.com>, Michael
 Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] mtd: spinor: winbond: Describe several chips
In-Reply-To: <87frcwexyt.fsf@bootlin.com> (Miquel Raynal's message of "Tue, 09
 Sep 2025 12:12:26 +0200")
References: <20250703170253.1231818-1-miquel.raynal@bootlin.com>
 <87frcwexyt.fsf@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 13 Nov 2025 10:50:34 +0100
Message-ID: <875xbegt1x.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 13 Nov 2025 14:16:58 +0100
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

Hi,

I am manually adding Michael, as apparently he was not listed
automatically.

On 09/09/2025 at 12:12:26 +02, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> Hello,
>
> On 03/07/2025 at 19:02:53 +02, Miquel Raynal <miquel.raynal@bootlin.com> =
wrote:
>
>> All these chips are dual and quad capable. They are also DTR capable,
>> but the core is not yet ready for that.
>>
>> Performances of all chips are comparable at 30MHz and are as follow:
>> Eraseblock single read speed: 938kiB/s
>> Eraseblock dual read speed:  1068kiB/s
>> Eraseblock quad read speed:  3751kiB/s
>>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> I believe this patch has been out for more than 2 months and is simple
> enough, any plans for taking it soon?

It's now been few more months and I haven't been notified this patch got
merged. It is also not visible in upstream U-Boot. Could we please speed
up the merging process, especially for such simple change?

Thanks,
Miqu=C3=A8l
