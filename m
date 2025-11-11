Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BADCCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 06:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1A083AEC;
	Tue, 11 Nov 2025 07:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LFMof7i1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C318D83B0B; Tue, 11 Nov 2025 07:39:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD32F83AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 07:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762843191; x=1763447991; i=xypron.glpk@gmx.de;
 bh=VrDr+8v4FbzROj5SqLgUTEKI2+y6j54eVh03ipX0Tfs=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LFMof7i1CAh9vgRTElbtHHA++IpaBGAL5LsoPe7FiOlfU+DlnqLUgOGx9cGtJRHF
 lTaI3Nmn414zPz/hZZw7Kdts3UY/REZDIXwPJU1QE6UANapBj+JkmuQ4mOaoMwsmn
 k9zVse+zDy/98+QEfuRSn6g8DKM9qONRU5tqtUorgMiCR2PfwvQVKhopc1BT/bjTb
 n6wYHuzOtqr6lY6/t6Xeqdf9aqljksZwfoP8TXz4aCNXw2S8ihTkCWHKrnr6mctfI
 03unfYlgX8H5xqskfC2CtGLHN8Boew6wLQ72E5z3BeGeGbP3Zl+nQWOBsdd+Ka62M
 XxNuCsAEGgNQ/D4JYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([143.58.85.124]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MAONd-1vTSTU1fAZ-007nJw; Tue, 11 Nov 2025 07:39:51 +0100
Date: Tue, 11 Nov 2025 07:39:50 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Heiko Schocher <hs@nabladev.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 3/5] test: cmd: hash: add unit test for sm3_256
User-Agent: Thunderbird for Android
In-Reply-To: <20251111054813.1966-4-hs@nabladev.com>
References: <20251111054813.1966-1-hs@nabladev.com>
 <20251111054813.1966-4-hs@nabladev.com>
Message-ID: <AF767FFD-6798-455F-A1C8-F433C509680A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wMdrnRlVY1mOmAQvdxWTaP5SOz//pQCfJYK9FPG7GGPVcZ54yjb
 dQ7GiKB5bx+mukABvmauRwfsjH+V6FjkbANWJvYYfi7T6ymq5SSgMyEEUhIo2li1bnM9gBU
 KhtHRRBkSIjee8unaK/1mkAbUcZGnySgqlD1johTsz6/tqOJ/bZHP0tumKhyQgZMmue+wvS
 qL8gliRBRBk1CFSSYUrJA==
UI-OutboundReport: notjunk:1;M01:P0:LbIPal1llxQ=;3vnH7QC3f7f2EQRokUJAliG9uWS
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

Am 11=2E November 2025 06:48:10 MEZ schrieb Heiko Schocher <hs@nabladev=2Ec=
om>:
>add simple test for sm3 256 hash
>
>Signed-off-by: Heiko Schocher <hs@nabladev=2Ecom>
>---
>I wonder why this tests are under DM and not under CMD
>Should we move them to CMD ?

We should use CMD_TEST() in the test/cmd/  directory=2E

Best regards=20

Heinrich=20

>
>Ignored checkpatch warnings for too long lines=2E
>
>(no changes since v1)
>
> test/cmd/hash=2Ec | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 46 insertions(+)
>
>diff --git a/test/cmd/hash=2Ec b/test/cmd/hash=2Ec
>index bb96380c351=2E=2E3f7f64d27d3 100644
>--- a/test/cmd/hash=2Ec
>+++ b/test/cmd/hash=2Ec
>@@ -103,3 +103,49 @@ static int dm_test_cmd_hash_sha256(struct unit_test_=
state *uts)
> 	return 0;
> }
> DM_TEST(dm_test_cmd_hash_sha256, UTF_CONSOLE);
>+
>+static int dm_test_cmd_hash_sm3_256(struct unit_test_state *uts)
>+{
>+	const char *sum =3D "1ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747e=
d035eb5082aa2b";
>+
>+	if (!CONFIG_IS_ENABLED(SM3)) {
>+		ut_assert(run_command("hash sm3_256 $loadaddr 0", 0));
>+
>+		return 0;
>+	}
>+
>+	ut_assertok(run_command("hash sm3_256 $loadaddr 0", 0));
>+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
>+	ut_asserteq_ptr(uts->actual_str,
>+			strstr(uts->actual_str, "sm3_256 for "));
>+	ut_assert(strstr(uts->actual_str, sum));
>+	ut_assert_console_end();
>+
>+	ut_assertok(run_command("hash sm3_256 $loadaddr 0 foo; echo $foo", 0));
>+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
>+	ut_asserteq_ptr(uts->actual_str,
>+			strstr(uts->actual_str, "sm3_256 for "));
>+	ut_assert(strstr(uts->actual_str, sum));
>+	ut_assertok(ut_check_console_line(uts, sum));
>+
>+	if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
>+		ut_assert(run_command("hash -v sm3_256 $loadaddr 0 foo", 0));
>+		ut_assertok(ut_check_console_line(uts,
>+						  "hash - compute hash message digest"));
>+
>+		return 0;
>+	}
>+
>+	ut_assertok(run_command("hash -v sm3_256 $loadaddr 0 foo", 0));
>+	ut_assert_console_end();
>+
>+	env_set("foo",
>+		"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
>+	ut_assert(run_command("hash -v sm3_256 $loadaddr 0 foo", 0));
>+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
>+	ut_assert(strstr(uts->actual_str, "!=3D"));
>+	ut_assert_console_end();
>+
>+	return 0;
>+}
>+DM_TEST(dm_test_cmd_hash_sm3_256, UTF_CONSOLE);

