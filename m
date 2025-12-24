Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35ACE74908
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 03:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AC4D8419A;
	Wed, 24 Dec 2025 04:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ns/r+jO9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2050E841A5; Wed, 24 Dec 2025 04:19:04 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94E0F84198
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 04:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766546341; x=1767151141; i=xypron.glpk@gmx.de;
 bh=ZTwW65Mc1CQ0iW+SsNxs7MwayRz/uGqmt2g8/wlE+HY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ns/r+jO99sCaVdMQmgLPXrOvunGk6hmBEOhCgXTacovWA1Byw1RQat0M7aUL3hTd
 tqUtbCNlsDL4Gz+bThAP3grltNks5T3azwsozbHc05ri0VHdtXhuIFbFlwGK1koAc
 XnWo8BqHoq5bQOnTYBDcvv001qOGXvvMojJAF0JqvpGFnGsXQPyNNfIx5RmJ8bEoP
 U/IbD20jJml0xCS3iV/ROE2JZLxEoGt+YL/FrMoM8cSbt2RfiiraYyb/h+j7kYKOM
 S14C6vIf9k2LrbCimwTxnuee2J8dyXJPVO50qfPfmZ8x4hgRa/DVjkMN4G4Pj9JSd
 KOkRF9gi22cfGGaBHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Fs-1wLLn83bHS-00mDCM; Wed, 24
 Dec 2025 04:19:00 +0100
Date: Wed, 24 Dec 2025 04:18:57 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/3=5D_test=3A_env=3A_Add_te?=
 =?US-ASCII?Q?st_for_environment_storage_in_SPI_NOR?=
User-Agent: Thunderbird for Android
In-Reply-To: <bb3d1ff2-4cc1-48da-a47f-3aef44277791@mailbox.org>
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
 <c31bd8b3-2604-4193-abba-6815845e8967@gmx.de>
 <bb3d1ff2-4cc1-48da-a47f-3aef44277791@mailbox.org>
Message-ID: <61B4E140-F702-49F2-8F9A-CBCC5C8498AE@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HhQubn7/KIN33IEuAgZ9SbgAWraZHcNKTkvvSzuPl6gthkgV9EW
 OBT0jFWQN8ZFN61oqHEmdn/KlziCnGJZzdbZqLASGDDtKcRdmD56YP+sLC5XTGlhQ5M5mJp
 9NhHYevoMYU1EE9pym9TenGzhi/OCHiMbOpkBxQ5DHdvv+nTqdLS6DH4dncnKz25TKsBcqJ
 IV0WZCpflSz9JIMa4P9qA==
UI-OutboundReport: notjunk:1;M01:P0:KRyhEB+y8T4=;7DmKN/POiyeXUP4Icd34Ykw+FSu
 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
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

Am 23=2E Dezember 2025 19:55:45 MEZ schrieb Marek Vasut <marek=2Evasut@mail=
box=2Eorg>:
>On 12/23/25 6:32 PM, Heinrich Schuchardt wrote:
>> On 12/23/25 15:31, Marek Vasut wrote:
>>> Add test for environment stored in SPI NOR=2E The test works in a very
>>> similar way to the current test for environment stored in ext4 FS,
>>> except it generates spi=2Ebin file backing the SPI NOR=2E
>>>=20
>>> Signed-off-by: Marek Vasut <marek=2Evasut+renesas@mailbox=2Eorg>
>>> ---
>>> Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>>> Cc: Jerome Forissier <jerome=2Eforissier@linaro=2Eorg>
>>> Cc: Simon Glass <sjg@chromium=2Eorg>
>>> Cc: Tom Rini <trini@konsulko=2Ecom>
>>> Cc: u-boot@lists=2Edenx=2Ede
>>> ---
>>> V2: No change
>>> ---
>>> =C2=A0 test/py/tests/test_env=2Epy | 99 ++++++++++++++++++++++++++++++=
+++++++++
>>> =C2=A0 1 file changed, 99 insertions(+)
>>>=20
>>> diff --git a/test/py/tests/test_env=2Epy b/test/py/tests/test_env=2Epy
>>> index 383e26c03b0=2E=2E48e31f19b3c 100644
>>> --- a/test/py/tests/test_env=2Epy
>>> +++ b/test/py/tests/test_env=2Epy
>>> @@ -457,6 +457,26 @@ def mk_env_ext4(state_test_env):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 utils=2Erun_and_log(c, ['cp',=C2=A0 '-f=
', persistent, fs_img])
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fs_img
>>> +def mk_env_spi_flash(state_test_env):
>>=20
>> Thank you for adding the test=2E
>>=20
>> Unfortunately pylint doesn't like your code=2E Please have a look=2E
>
>Is this something we run in CI ? If so, CI builds did pass=2E
>
>If not, how do I trigger this ?

I just ran pylint from the command line=2E

Best regards=20

Heinrich

