Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CFDC71157
	for <u-boot@archiver.kernel.org>; Sat, 21 Jun 2025 17:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFE082CCE;
	Sat, 21 Jun 2025 19:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IVdZHSPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C7B782CF4; Sat, 21 Jun 2025 19:19:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 699D48210D
 for <u-boot@lists.denx.de>; Sat, 21 Jun 2025 19:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750526388; x=1751131188; i=xypron.glpk@gmx.de;
 bh=zr2si95s8z4MI23vwT3hSYpv+D3FGi0UwRZtW19iu8A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IVdZHSPAqWtqdAPNs+2RxCcWnIlpQ6uFGGVvGKWZxxe83zzN/wVaHqjuC8dAGbuW
 QNmOFoShTEEcJ16lLZEanC7itg8hyHsNPWywOe1JUSSX6wesm0cZlm00WLxUD4VwM
 iOqGrLMQ8whLnMdqmqTKIxfn2vI18zk3qWR3US42zu7OjXVyGpQ09GISUnXqp6KwB
 KvF1egPAsBa9c9cWyeJTj+D9Oo8LkngPZOlIKyTxRzebbf6CElphU8lFnUFUVBzuR
 55NdvJYeA/jdWBuDZYHH5dFeiqLx/w6qLXkbuUhifyRTbewQFIvJ20I3c8VmI6Et1
 0+Z0DokUb1FYZch0vA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNJq-1uFCF73kSA-00Nsl7; Sat, 21
 Jun 2025 19:19:47 +0200
Message-ID: <61b4648f-8a78-4551-a8bd-fd7c4a0638a3@gmx.de>
Date: Sat, 21 Jun 2025 19:19:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request doc-2025-07-rc5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:snwN0HjVjPA5S0HVo1xMyDZmSFjG4kR1p2GVhAPIA2//OF7IOoX
 mOXBLZVS6/MiPBchwcgk1h9ptjogk95rA2tATAtrHWjDS0BuFGFbclWjKz27MpKVWtMWRKd
 IgIpDKjnrKwDadFuS1orPG9B6qBuPgvUzSab2xDjYR0gdZ1eeXSVV5Bwb5lTwl9l4aos87l
 XIbc3qGkb9qoHgT+Uqg2A==
UI-OutboundReport: notjunk:1;M01:P0:tPxWrRy1He0=;FP1x5vnuIoddb0jJdsMMTe9Auqk
 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
 jTKM=
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

The following changes since commit 721eecd9cbf2cc59c5230abd37d02d4a02f75cc=
7:

   Merge patch series "common/spl fixes" (2025-06-19 11:01:52 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/doc-2025-07-rc5

for you to fetch changes up to 820bbf1d46f5d3fd30d306e955d2b4d1487c3484:

   doc: cmd: wget: remove erroneous note (2025-06-21 19:03:42 +0200)

=2D---------------------------------------------------------------
Pull request doc-2025-07-rc5

* in wget documentation remove erroneous note about CAs

=2D---------------------------------------------------------------
Jerome Forissier (1):
       doc: cmd: wget: remove erroneous note

  doc/usage/cmd/wget.rst | 7 -------
  1 file changed, 7 deletions(-)
