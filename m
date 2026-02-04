Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA1BE83045
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 06:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5353C839DF;
	Wed,  4 Feb 2026 07:40:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="Q5YDqnxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64906839DF; Wed,  4 Feb 2026 07:40:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D2D839A5
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 07:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1770187205; x=1770792005; i=frank-w@public-files.de;
 bh=Il5DT1yHms6CipEU8B3b4e/+aZyiAZ7xSXCMu6E0VYw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
 References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Q5YDqnxXvLqe8OrJq3ey6ChIrudhkaQMZ8shMd9MkbKEHM39T3ojj2LhF+WvWoOI
 KXzPDqi4CKC101ypjy+4lZHjYfm+CIgz6R2yRNfy8cHjg9i8btOpOei3zD5bTL9nS
 YBaozwbeDThe+jir957KhpIX602cs3JFMEFoyO40phADHeifPwqrD5WoI2cEvwCKr
 ezir3db8eJUYCVpJ67Y7zKQku8RbnPGyNKSMDUGQneNsiqQRNwnE25HH+CyQdMkRy
 UkCWnl2x2fXq9KFgcT17gRQqDthPrCt+RzzKZSOQcHgRzOrfnTUghO1yGicBlM2BF
 YbrHS4gJDQLmS6JRZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([80.245.74.171]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MvbBk-1vWH5O3X1S-013NF0; Wed, 04 Feb 2026 07:40:04 +0100
Date: Wed, 04 Feb 2026 07:40:05 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Tom Rini <trini@konsulko.com>, Frank Wunderlich <linux@fw-web.de>
CC: u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v6 2/3] test: cmd: add test for memsize
User-Agent: K-9 Mail for Android
In-Reply-To: <20260203233402.GU2603314@bill-the-cat>
References: <20260125131254.23210-1-linux@fw-web.de>
 <20260125131254.23210-3-linux@fw-web.de>
 <20260203233402.GU2603314@bill-the-cat>
Message-ID: <5E5EDF2D-9CDF-4640-9639-88FD888B688B@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:McMBl3OSQjI+aSt0pVKFhwE6GUgRy0EsDNszehpiKkt1g16xQMd
 XDYxjPau8SQnh6nYn3P7dv2dPhR80k3ic9w0cKMr73UZ0Sl5gDqABNWyWGYfjKT7rSmpiFv
 twgjO9UZilsH7BwbEBGtcXYinZ4z+FjRp1/e+ugQrnM4aoDrBOxtBCEWFwkg04M/ppWjt9C
 3PsEIZlkZoQxChgvQGOPw==
UI-OutboundReport: notjunk:1;M01:P0:cJZJINOhJ3Y=;BAfYoA+qJkCHF2b+bmVXGcpLHnq
 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
 LoxjUhtJ49Ud7CxdmEGH
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
Reply-To: frank-w@public-files.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 4=2E Februar 2026 00:34:02 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>On Sun, Jan 25, 2026 at 02:12:52PM +0100, Frank Wunderlich wrote:
>
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Add a test for memsize command in same way as meminfo=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>> tested via:
>> $ =2E/u-boot -T -c "ut cmd cmd_test_memsize"
>> =2E=2E=2E
>> Test: memsize: meminfo=2Ec
>> Tests run: 1, 0 ms, average: 0 ms, failures: 0
>> ---
>>  cmd/Kconfig        |  1 +
>>  test/cmd/meminfo=2Ec | 17 +++++++++++++++++
>>  2 files changed, 18 insertions(+)
>>=20
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index be79bf0747df=2E=2E2bafa156ca8a 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -927,6 +927,7 @@ config CMD_MEMINFO_MAP
>> =20
>>  config CMD_MEMSIZE
>>  	bool "memsize"
>> +	default y if SANDBOX
>>  	depends on CMD_MEMINFO
>>  	help
>>  	  Get RAM via command for use in scripts=2E
>> diff --git a/test/cmd/meminfo=2Ec b/test/cmd/meminfo=2Ec
>> index 53b41e3b49e0=2E=2Eba772a8b7616 100644
>> --- a/test/cmd/meminfo=2Ec
>> +++ b/test/cmd/meminfo=2Ec
>> @@ -7,6 +7,7 @@
>>   */
>> =20
>>  #include <dm/test=2Eh>
>> +#include <env=2Eh>
>>  #include <test/cmd=2Eh>
>>  #include <test/ut=2Eh>
>> =20
>> @@ -39,4 +40,20 @@ static int cmd_test_meminfo(struct unit_test_state *=
uts)
>> =20
>>  	return 0;
>>  }
>> +
>> +/* Test 'memsize' command */
>> +static int cmd_test_memsize(struct unit_test_state *uts)
>> +{
>> +	ut_assertok(run_command("memsize", 0));
>> +	ut_assert_nextline("256 MiB");
>> +	ut_assert_console_end();
>> +
>> +	ut_assertok(run_command("memsize memsz", 0));
>> +	ut_asserteq_str("256", env_get("memsz"));
>> +	ut_assert_console_end();
>> +
>> +	return 0;
>> +}
>> +
>>  CMD_TEST(cmd_test_meminfo, UTF_CONSOLE);
>> +CMD_TEST(cmd_test_memsize, UTF_CONSOLE);
>
>Since the new test isn't guarded with memsize, this fails on qemu-x86_64
>where meminfo is enabled, but memsize is not=2E

Does x86_64 test not use SANDBOX? Do i need to enable it somewhere else? I=
mho it should ve tested also there so guarding just prevents the test=2E Bu=
t of course i can add guards for it=2E


regards Frank
