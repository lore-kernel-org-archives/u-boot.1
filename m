Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDBFCA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 12:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FBEF83443;
	Sun, 31 Aug 2025 14:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oJ+frCMF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A272B838AA; Sun, 31 Aug 2025 14:40:48 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C5CB833E9
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 14:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1756644046; x=1757248846; i=xypron.glpk@gmx.de;
 bh=TbZzsKbyZSCQFxCvvqLyl1cTn0SQ+nfNH0UqT3O888U=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=oJ+frCMFOVCBuU1nu8ic8cGiecAKGjVqBTjCqQuB9E7PIwAw3AIjRufXmV9exxIY
 1+PHp54ZQS8oLeYRft06HAJE9y9ISBA0EbpMJN9PG7mZQ0LTLKGpjoWXLICXPoqk+
 qmflY/T/eiObQS8sNPyUTIG7fuX+3xV4lClOxmZRMHNRCjVaoudME7OY5H5lTH+UN
 BJLHI/brZ/t6XjA25P6WX5ofHMranLFKO3exjC7vSRT84J+7/mFuTE9eGGE1ccJdN
 ZemAc4nxkjmdl6fDj7cMvghfpVBzrdjS8xH/MownqhER+LJ09rEZCMV6AApuSdXPP
 9sjRvNnNWt+TItMowQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7QxB-1uPPPc37vh-00u2Ok; Sun, 31
 Aug 2025 14:40:45 +0200
Date: Sun, 31 Aug 2025 14:40:45 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 10/10] doc: Use a em-dash instead
User-Agent: Thunderbird for Android
In-Reply-To: <CACAHuLB=Dw9RdQ5d_WGkyJUhWLkES77anXj7j1kefZUw-_0dQQ@mail.gmail.com>
References: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
 <20250825223251.674591-11-adrianocarvalho.pt@gmail.com>
 <4605b3ff-6499-4233-be0c-bd3a0898b1c9@gmx.de>
 <CACAHuLB=Dw9RdQ5d_WGkyJUhWLkES77anXj7j1kefZUw-_0dQQ@mail.gmail.com>
Message-ID: <A4755516-00FA-4868-B0E7-33A8F2D14978@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fSwVwB0ci8wCxS167GWz23y1umMGZKj/f7YLx8voEw6kHt5zQ5w
 EvzkVw3Xy7C3Ntw021bIcMPXzEeRjg3YCx+HBONH2SsmNNN0Qx2zLVe+hQSP/6l6Ey2238D
 wkz/rSOwmF/oAaffSlvpBN8t1b39b6Join4Vo8DAZn8K5IbDveCWSL3OWF6qggnZCK5tFlw
 eDKTg+qNQG5gQxluEJ25g==
UI-OutboundReport: notjunk:1;M01:P0:6peWOf122c0=;o11zbqI8vQI8wIkIEIurIMFm8Ak
 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
 95FQclQ8PQEwwNvQ838
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

Am 31=2E August 2025 14:20:19 MESZ schrieb Adriano Carvalho <adrianocarvalh=
o=2Ept@gmail=2Ecom>:
>On Sat, 30 Aug 2025 at 16:22, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>> [=2E=2E=2E]
>> This file is also used as output of buildman -H on the command line=2E
>> Unicode does not work if the console is using an 8-bit codepage=2E
>>
>> With the patch an error in the CI occurs:
>> testtools=2Etestresult=2Ereal=2E_StringException: AssertionError: 67348=
 !=3D 67350
>>
>> For details see:
>> https://source=2Edenx=2Ede/u-boot/custodians/u-boot-efi/-/jobs/1234573
>>
>> Dropping the patch=2E
>>
>> Best regards
>>
>> Heinrich
>
>Should I use "--" instead?
>
>After using "--" or dropping this commit altogether I should resubmit
>the complete patch series (not only this commit,) right?
>
>Com os melhores cumprimentos=2E / Best regards=2E
>Adriano Carvalho

All the other patches are in yesterday's pull request=2E '--' would look o=
dd in the buildman -H output=2E

Best regards=20

Heinrich=20

