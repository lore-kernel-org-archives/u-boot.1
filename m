Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7927E606A32E
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ADBXOWD1;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=puHB8xUa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EA8E8128F;
	Tue, 10 Nov 2026 12:24:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fJjPKwY9gJFl; Tue, 10 Nov 2026 12:24:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 817398129E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313475;
	b=HbS5Vb7mr+tTvzGQ1wvzwwh/A/KmfDBmOXbeTKB0pNK68ctnuM+rzp+KD2HEClaY6jNA
	 z114zOVH/JU3v4HRognFrcxOtvl50ZRktJLfQA5h3lxnyGRZVWoavzo3kSo4zbhfhjb/Y
	 JYecTGofTZBv2aHm9QQk5HiScHdt066MwKVRKZyBXYFAb+3vO3qkF3M2uPGpvyKBn0jvv
	 vEaWXcqN5VUfOLOT9cuG8G6RF++v6zviRi8pti9JBaI1eRafgKtFZj0IZhZvXIR7ER/cc
	 YoKMoWdvRZnez+uPO2SnaTdlgoSpeAMCeSxC+/ZNpVyAPWQsC0MVxXTcs8mHTTvLHxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Px8TWrV9w5Y+6+FS/8/rW54ol1bWx5N7yJ8JAg49rT4=;
	b=nwVI+NNqhqF5MIfZKjXDUmqsxhZy5BCZjBk8nWQ+wX5MICViTo6CNMjnLyz4KXZUivK0
	 Q0orKPQWcaqQSotnTmoXNvQzgKUWVgtYmGzIgFu9YJtPZUtVZuC8wpjzPzE61PHg6ckLA
	 ONkEw+s9ACUWOG8CSFMDknCSWzSvTwp9sAZQ2Juqbpzdx3Mhph708XRrJhzBQw5m3NYL8
	 uT2lCdnpvlrGVBpGu3DHRo3FU7Ccvprahf1s25lS1J/QxMfiYR/aE2K6ELAXzkmnvHE16
	 +8as3M347WfUlH05vGtCQkBEYWMQX3F+yVz/LDzyTA7/TSfhINY2QMw3JUCzk76onOw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794313475;
	bh=Px8TWrV9w5Y+6+FS/8/rW54ol1bWx5N7yJ8JAg49rT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ADBXOWD1g2Jm9ZbE10O+IBtbdK1UiiuiIh1rE2GwbDtUzdYFycuTksOZR7XwJagF1
	 s8EN4VfLch6G7NZqHhrkJIyR6D8cOktD+5ThPhhQPFyE3dLsU/Ejez+XrWM25PBN8y
	 SGEbROcEUUd1c9N+caBmgo14lvFdC4BG4paAYJQ0AJPH06j/mxRc07/SbnXnZIdsV8
	 O8iRlaAkLwPsTD7T5wMSD6viVJFmvjL+/Yb/LUkkwckJ6clOpCSU77c5SdQur0EotP
	 lbpdwKsVBZ2lZKU3q9srfzLQMw/jjlBx8RWSg0ek1IwLm2BdwRprZimw5k0kNyGKxc
	 0xmzzaXU3Lmwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 817398129E;
	Tue, 10 Nov 2026 12:24:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B6CB44B8
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97BFD4085D
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fT3zeCFXNRFR for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:24:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9614340859
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=puHB8xUa
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9614340859
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:20 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso15934845e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794313458; x=1794918258;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Px8TWrV9w5Y+6+FS/8/rW54ol1bWx5N7yJ8JAg49rT4=;
 b=puHB8xUaJGC9wEdjdZJilUk4F3Zh+oC1PCi8uadLkkXa9+BOZ6EKEVa6AiXp8bdP/e
 lzoHA3q+0CEhFs2mYTv0rXS6zNqU1akL0qki5nSYHYRNQccubaB5ZxDY2QB+VMXUQxCy
 D+dVbCoF+UfZmWw6U0u/dF0+bbDhHZG2nMwU1AQ8bvXu3NRpP6R667B/Nilch1xq10HB
 5V06QQkDyBGjlft9hEi5rXTg5adA0hqr4Zgn10hJsj/t25xqJ/MKqw81aePIFrphNX+b
 B7Fq6tWQ6gTvG+Osz/v5R6iKcW2JV304vYW2Q5Ppsiq9Izbwd8u7pXFArYHt0+LA6+Uv
 /ZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313458; x=1794918258;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Px8TWrV9w5Y+6+FS/8/rW54ol1bWx5N7yJ8JAg49rT4=;
 b=WldfaBgd2LW4pj/yXWqAYth+DdSesD0af8IEWJxNc5o+AS5S7g6oAwCfT+GoL4yIoB
 3BDc6OCx1Y8dHgAdVZHnI1uLFxd4gPFnVZj0x6LpWHinbO1Sx24stRC/QRs9Tyf2ogLp
 +3Vfz5tHd6ITG+wEfPzvvP8uEPQAHLaodZrD21LEocS5E98b0aJSMdVGHe8X3AgJVFMm
 ll+qmb0klGyoIEgAolSkq/gwfU1ZQ2oKonxcaUpqlz44R7A2QBhHVfORSBoUqsNND43O
 3AERwpaN5spByyrHLpVxha/nkMmnHaeqzP0PzwRvRxTuOgRmhoCBIxYlAgDRCnlK201I
 AcoA==
X-Gm-Message-State: APuU4Z84x9uefuNmuMpmjYJOMwVo7sDo+q6oQloz8OW9jKEMjNtJ8Tkp
 xHWlm8AY6BJLGSIGt1CzSKEa1dCLxOfiS5OYTTabSscs8Ti/kVM2mIs+N5SFB6XQrTE=
X-Gm-Gg: AYBFou22Y5b/SDN2Xkm9tqGEIuaDBGgiTQqJwH1FW39PCn0yQ6PAEAW+/IqWWkQNbQz
 Ksoa/ne+488U7JdY4fTWgKfB4mBThxWZNpRd1Xky+X8h4hjBz7rrmJj6ucl51mJjBvMjUCk4TFV
 eb+XQbFAApnoEU/4pAPUe4Fxbc7uJH7ub6LsLByqvdhfG807UVBAykaFXIdtks37LMtUrLvvB2a
 lfa0eoqFsWP5kyxwL6nwD+PHTXhubSy4WMwLYAZt4Ep7KiI3AxSTxyxSyUM8UHfDOVKsgql9nSE
 84NenZ+HK7Ya8eWErNGlhaUyKG7yO48oZjSFYr+FFcyEtb02xNA+WU0i0PX30N7q8ReN5MHwpWY
 dSoaO/TLHo9wN6RLCQp9vjJ7hGKw5V1M7JIEoEVXA3ERB9fs2KgaXo6DwT2JitOCcjOne3BMea4
 W533fLWf3/4dNwownSsOuLZC9reeiJ5ooV9OQZ7bVnEjLwG+8FL7l8t9wwbd91xvKLDOQoy+QKH
 IJJL54pf0qBt8A8YBvUjpGYzI8JXe4q5lw0KkNFAef+ANi4qGTpVtBfyYqeCd0WTzJVZJTZPaqC
 xSbx9jnVehPWMmkPCriUF/p1xpcECdGL/Lev0AcF7dZ8mcvZ
X-Received: by 2002:a05:600c:a310:b0:4ba:809:5453 with SMTP id
 5b1f17b1804b1-4ba0809556amr264075e9.31.1794313458333; 
 Tue, 10 Nov 2026 04:24:18 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:e865:f651:6131:9a7d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm99279315e9.11.2026.11.10.04.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:24:17 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 10 Nov 2026 12:24:08 +0000
Subject: [PATCH v2 11/12] buildman: Cope with CPP="gcc -E"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-qcheck_fix-v2-11-1c76e0b68f29@linaro.org>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
In-Reply-To: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anshul Dalal <anshuld@ti.com>, Alexey Charkov <alchark@flipper.net>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow the use of "gcc -E" as an alternative to "cpp" when set in the
environment as the value of CPP. Accept it as a valid command for
running the preprocessor and adjust the test to not depend on a fixed
number of arguments. Also split it into parts for constructing the
command list so that the validation for running a command does not fail
when it tries to find an executable named "gcc -E".

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/buildman/boards.py    | 3 +--
 tools/buildman/func_test.py | 5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
index 5d5d3a3822b..111789f1bd4 100644
--- a/tools/buildman/boards.py
+++ b/tools/buildman/boards.py
@@ -244,8 +244,7 @@ class KconfigScanner:
 
         temp = None
         if b'#include' in tools.read_file(defconfig):
-            cmd = [
-                os.getenv('CPP', 'cpp'),
+            cmd = os.getenv('CPP', 'cpp').split() + [
                 '-nostdinc', '-P',
                 '-I', self._srctree,
                 '-undef',
diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index fce615ba8b8..eb13589ba17 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -378,7 +378,7 @@ class TestFunctional(unittest.TestCase):
     def _HandleCommandCpp(self, args):
         # args ['-nostdinc', '-P', '-I', '/tmp/tmp7f17xk_o/src', '-undef',
         # '-x', 'assembler-with-cpp', fname]
-        fname = args[7]
+        fname = args[-1]
         buf = io.StringIO()
         for line in tools.read_file(fname, False).splitlines():
             if line.startswith('#include'):
@@ -424,7 +424,8 @@ class TestFunctional(unittest.TestCase):
             return self._HandleCommandObjcopy(args)
         elif cmd.endswith( 'size'):
             return self._HandleCommandSize(args)
-        elif cmd.endswith( 'cpp'):
+        elif cmd.endswith('cpp') \
+                or (cmd.endswith('gcc') and pipe_list[0][1] == '-E'):
             return self._HandleCommandCpp(args)
 
         if not result:

-- 
2.47.3

