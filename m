Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2404DE9D3ED
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 14:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA23802C1;
	Wed,  4 Feb 2026 15:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="RACDkEqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54FB980086; Wed,  4 Feb 2026 15:48:29 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 850D38063E
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 15:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1770216495; x=1770821295; i=frank-w@public-files.de;
 bh=ZoB5Y3TEzbt0+d1+QmmT+Sv1CXg1bZnMAOcnCRreTbs=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
 References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RACDkEqYhbqHA5b7Y9IRxj1Pzq/iW9I4nNfgUaCYFbOem7f2R6JOQG3mSaQTGbwA
 awe/MP0W4oyUh9O4H9ZSNV/q2YOiF/6Xp6Evsge3MiEq4RU0t2ET+4b6GCU1EiGzv
 zpTdolf+ueyo/9wYG/bLVVH4WVydttGLNDgFbaiCgPGQxWUULRuRD5CyH/SlqiaMb
 Sw7wcyjK25XhZdXmPi7IJm8YEoRN5Ig6UTUrmbqMogliz+lDP52jUMcU+0u1uXent
 aZX+fKuwdepetFByIHq2PHfQoj+fVq0wFT6tassQOiMhYNgaPwh0pf7fFwTpfFLq9
 7bMCJi5rweUygUtaPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([80.245.74.171]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MRTNF-1wANj81MSz-00SPVM; Wed, 04 Feb 2026 15:48:15 +0100
Date: Wed, 04 Feb 2026 15:48:17 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Tom Rini <trini@konsulko.com>
CC: Frank Wunderlich <linux@fw-web.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v6 2/3] test: cmd: add test for memsize
User-Agent: K-9 Mail for Android
In-Reply-To: <20260204135338.GV2603314@bill-the-cat>
References: <20260125131254.23210-1-linux@fw-web.de>
 <20260125131254.23210-3-linux@fw-web.de>
 <20260203233402.GU2603314@bill-the-cat>
 <5E5EDF2D-9CDF-4640-9639-88FD888B688B@public-files.de>
 <20260204135338.GV2603314@bill-the-cat>
Message-ID: <5B1F4D3D-1013-41BD-801E-1EAAEEE004B8@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7FuPl2hYve+n/V8ArT4Hq6jwhe+5Lna1ijiLrer8EONSwjK2A2D
 aLLXgxGz7KH5Zx42DPD/+UTobqnq2NawebsHx7db332abTPq9UH/dviyo5kPHM6ubGNGJ+g
 Z8EQpmIefuAPz62XgCb750RPsejj5tQ91rreGijBH01rcIs0HjmPd6oPTkapnK7ZH3N1nEE
 e1jWO55y2VolgCdKdtKVw==
UI-OutboundReport: notjunk:1;M01:P0:Uvzazu4TEME=;6AXQUaa5CZpaZ53zi+6ijmgWQoQ
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
Reply-To: frank-w@public-files.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 4=2E Februar 2026 14:53:38 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>On Wed, Feb 04, 2026 at 07:40:05AM +0100, Frank Wunderlich wrote:
>> Am 4=2E Februar 2026 00:34:02 MEZ schrieb Tom Rini <trini@konsulko=2Eco=
m>:
>> >On Sun, Jan 25, 2026 at 02:12:52PM +0100, Frank Wunderlich wrote:
>> >
>> >> From: Frank Wunderlich <frank-w@public-files=2Ede>
>> >>=20
>> >> Add a test for memsize command in same way as meminfo=2E
>> >>=20
>> >> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> >> ---
>> >> tested via:
>> >> $ =2E/u-boot -T -c "ut cmd cmd_test_memsize"
>> >> =2E=2E=2E
>> >> Test: memsize: meminfo=2Ec
>> >> Tests run: 1, 0 ms, average: 0 ms, failures: 0
>> >> ---
>> >>  cmd/Kconfig        |  1 +
>> >>  test/cmd/meminfo=2Ec | 17 +++++++++++++++++
>> >>  2 files changed, 18 insertions(+)
>> >>=20
>> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> >> index be79bf0747df=2E=2E2bafa156ca8a 100644
>> >> --- a/cmd/Kconfig
>> >> +++ b/cmd/Kconfig
>> >> @@ -927,6 +927,7 @@ config CMD_MEMINFO_MAP
>> >> =20
>> >>  config CMD_MEMSIZE
>> >>  	bool "memsize"
>> >> +	default y if SANDBOX
>> >>  	depends on CMD_MEMINFO
>> >>  	help
>> >>  	  Get RAM via command for use in scripts=2E
>> >> diff --git a/test/cmd/meminfo=2Ec b/test/cmd/meminfo=2Ec
>> >> index 53b41e3b49e0=2E=2Eba772a8b7616 100644
>> >> --- a/test/cmd/meminfo=2Ec
>> >> +++ b/test/cmd/meminfo=2Ec
>> >> @@ -7,6 +7,7 @@
>> >>   */
>> >> =20
>> >>  #include <dm/test=2Eh>
>> >> +#include <env=2Eh>
>> >>  #include <test/cmd=2Eh>
>> >>  #include <test/ut=2Eh>
>> >> =20
>> >> @@ -39,4 +40,20 @@ static int cmd_test_meminfo(struct unit_test_stat=
e *uts)
>> >> =20
>> >>  	return 0;
>> >>  }
>> >> +
>> >> +/* Test 'memsize' command */
>> >> +static int cmd_test_memsize(struct unit_test_state *uts)
>> >> +{
>> >> +	ut_assertok(run_command("memsize", 0));
>> >> +	ut_assert_nextline("256 MiB");
>> >> +	ut_assert_console_end();
>> >> +
>> >> +	ut_assertok(run_command("memsize memsz", 0));
>> >> +	ut_asserteq_str("256", env_get("memsz"));
>> >> +	ut_assert_console_end();
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >>  CMD_TEST(cmd_test_meminfo, UTF_CONSOLE);
>> >> +CMD_TEST(cmd_test_memsize, UTF_CONSOLE);
>> >
>> >Since the new test isn't guarded with memsize, this fails on qemu-x86_=
64
>> >where meminfo is enabled, but memsize is not=2E
>>=20
>> Does x86_64 test not use SANDBOX? Do i need to enable it somewhere else=
? Imho it should ve tested also there so guarding just prevents the test=2E=
 But of course i can add guards for it=2E
>
>No, it's qemu-x86_64 which is a different board :)

Ah ok,thought it is a platform test :)
Then i add only config-guards=2E

Should it send full series with the requested changes (squashed) or an upd=
ate (afair you have already applied to next/master)?

regards Frank
