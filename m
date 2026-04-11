Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CFCF3ED40
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D93D84154;
	Sat, 11 Apr 2026 16:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="TPSiBi/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27A85841F2; Sat, 11 Apr 2026 16:58:03 +0200 (CEST)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ae])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFAB784118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Sat, 11 Apr 2026 14:56:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1775919480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78QaezHpQzYmKodAuLRU0kKPR7dzb2Jlj332PXEv81M=;
 b=TPSiBi/r6LI2gqt+fs7hxb61kVUuwlsaTHRFU3XcxgrkzGuh/PCHBSX7Pu8bSdSWyluaAK
 wxDzp8XeYNMvDYo5RKSBLqLNmroD5XWCl707VoSVvlvz5MbXw9K/4k3lM41n/OnBhaBW/B
 XZADjHHdRa6Jrruak9R1Dhy/BJ8RrEmTLrdO9DoIq7Zev9CF6WZhKZu8lI7HEOkCvebDiA
 xHpGKC/9Z408s2tLAa/7WZksFSiQOykDkdGSGdsVaCEWBYaBYirzr5qIPT4lKF06dES542
 Ja6uGndJmtpI9iVs/gFbj7Bl3RFqwgsjnN2ppPYknscUJYX79rX32wXNMYN3dA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>,
 David Zang <davidzangcs@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 1/2] autoboot: allow custom prompt without requiring
 AUTOBOOT_KEYED
References: <20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org>
 <20260408-ui-cosmetics-v2-1-721dc6d2116a@postmarketos.org>
 <CAFLszTgwK5nUs2QA2Mh_pkTXycAiA0L4ukD8qywubW1AmTetxw@mail.gmail.com>
 <CAFLszTgvueYQUyGCQp3amZN20__LMvz_Eu5S_m=OQf9QDsr+DQ@mail.gmail.com>
 <tdc3t2.1tjebl3bs6nc5@postmarketos.org> <20260411145330.GV41863@bill-the-cat>
In-Reply-To: <20260411145330.GV41863@bill-the-cat>
Message-ID: <tdc48k.33h7i0pp1hoxk@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
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

On Sat, 11 Apr 2026 14:53, Tom Rini <trini@konsulko.com> wrote:
>On Sat, Apr 11, 2026 at 02:47:00PM +0000, Ferass El Hafidi wrote:
>> Hi Simon,
>> 
>> On Sat, 11 Apr 2026 13:34, Simon Glass <sjg@chromium.org> wrote:
>> > Hi,
>> > 
>> > On Sat, 11 Apr 2026 at 07:27, Simon Glass <sjg@chromium.org> wrote:
>> > > 
>> > > On 2026-04-08T16:34:55, Ferass El Hafidi <funderscore@postmarketos.org> wrote:
>> > > > autoboot: allow custom prompt without requiring AUTOBOOT_KEYED
>> > > >
>> > > > The autoboot prompt used to only be customizable in Kconfig when
>> > > > AUTOBOOT_KEYED was enabled. For a usecase such as having a nicer
>> > > > autoboot prompt alongside a splash screen, there is no reason for
>> > > > AUTOBOOT_KEYED to be required for this.
>> > > >
>> > > > Remove the dependency to AUTOBOOT_KEYED, and use AUTOBOOT_PROMPT in
>> > > > print_boot_delay() instead of a hardcoded string.
>> > > >
>> > > > Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
>> > > >
>> > > > boot/Kconfig      | 30 +++++++++++++++---------------
>> > > >  common/autoboot.c |  2 +-
>> > > >  2 files changed, 16 insertions(+), 16 deletions(-)
>> > > 
>> > > Reviewed-by: Simon Glass <sjg@chromium.org>
>> > 
>> > Actually doc/README.autoboot documents CONFIG_AUTOBOOT_PROMPT as part
>> > of the CONFIG_AUTOBOOT_KEYED group. [...]
>> 
>> Sure can!
>> 
>> > [...] Since you are decoupling these,
>> > please can you add a patch to update the documentation? Really it
>> > should move to doc/ though, if you have the energy for that.
>> > 
>> 
>> It's already in doc/, what do you mean by that?
>
>It should be in rST and part of our public docs, rather than a plain
>text file under doc/.
>

Ah right, sure can do that too.

Best regards,
Ferass
