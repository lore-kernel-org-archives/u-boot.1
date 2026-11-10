Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73D760A2612
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KyOYpU4K;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hlObv1xu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DBC8812CA;
	Tue, 10 Nov 2026 12:24:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g2p90SZMwz99; Tue, 10 Nov 2026 12:24:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 255C3812BF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313477;
	b=XPpIKbQ9UELCOTOOV9WCo91kruQPEEuGVyhGB9wQ9+DTYn181akgEL+bH/D9ASQYdhBA
	 avcBGm4/3qzR/smaOB3qYoa6I7tnSJerOkLFc3oatFqTFrBwUJgm2znQZjc2dLe4KGoOD
	 rSE/BZ4LbYzoLyFeNS3woNw1+RXvmiPA+Z3tp/CKOZ6Pc3UWRBxNkBnxvJSNtSbU/ISUu
	 JgZAQaIa7nEvrbxVw60VcHlOAdh9vTlfN1myrW/xQqLQ7KwMN9gLEwjY+g5wJ/wHsxqsg
	 xA+EL7Gav4DwPHsvjYzS1TcWuDN5wrgQwgOXHL8DWYxJkc4Y3pi6AHAdBldtAU1YmYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313477;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0QVlNjKD9RgaNd+toQU7197MhYK1SpkU/UiXR70UzYs=;
	b=sXFuQvngbUmyj9et9eJnF+JRg/0l2HoDBLBVuZQebuwz/MBFclJVOd2qCpw+Zn/TgmZi
	 FnoyWHKJ4+E0sHGKNGfJ7kkUJzNExDGCwqSMBsn+uOdD67HybZErUwwPAQqRYJULoKhei
	 Ms7wF10nA5t0R+xTL2C8m8YN8DwNMWqaYR9qp5LwWXBRg1tUkHJH4R+Qu9N9tYoQO7U/C
	 kgfml8oBp2pRTO2agHcv60tldg6jAw7M1lSliN1RpkdUEXEfg8Ku61RPMN2Mzk43DZcyn
	 44wGLXY1PMjpiOqf9ZptJabp5FxqyC+1jLMrzSheYD6AsjuKTfwhJOVNLa9nbIjx/9Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794313477;
	bh=0QVlNjKD9RgaNd+toQU7197MhYK1SpkU/UiXR70UzYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KyOYpU4KVZ92EpqZ6/P0pzCF3rO2MCPgkHN0dc8n4i0OQIjtMGWV6+v+3isZgPubK
	 mfWBJiNgt5ujZhNm5eg098AEFeJA4AOMd67n363C6BN0Hoc1b3zmvCMClFh1SZcqq1
	 dXxAj0TnrBbkzUsCPOUiCR2bXFFj2dDj0Qzh5JIidX/tIgwbUl6D8x9y2zoCb9v5Bd
	 bnvOX0fBCicwvSiNvuCTjr1MUQPYrOk7R9OkTq7Z89zaGZo/3TjghcmcmX8VZV7lIK
	 LkrzNx6lVBhdwwuicigaxgWTmP3qDTFScDaYhR5OAGSBxziQjpCwRcTmQqN46t0Jxr
	 LTtQkIsCHKb9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 255C3812BF;
	Tue, 10 Nov 2026 12:24:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B904731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71EAC40347
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Axv8GM7QvaCn for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:24:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 877B840176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=hlObv1xu
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 877B840176
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:21 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso13365715e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794313459; x=1794918259;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0QVlNjKD9RgaNd+toQU7197MhYK1SpkU/UiXR70UzYs=;
 b=hlObv1xumnSQvoIDmqZBlsnDo8zSWP+2qBEKz+iB7v5/WkdKqABqPJ2/oDUYwyIhM8
 Aa2zhU5oTIFQhN6hY3HMTMcikgrXepnIJ5Rj0CpVGoi38cEZL3veakpn2vNGAxWqBvTt
 /5VhPmcE3/7t4vvH4zYdT+rYn2ZTyCvx9kjyuJLUfivusi6cBcYeAu0m7JoWUTIorutv
 ekH0Y0DfcIqZGVsySeNKXZsGrdU2geW/whScchmiggrDe3RWEAu2xlJMdvDgh+AUpGWo
 myTxN3+WiHwHqwssXP1F1QCKM0ZXBoM2H4CulYJqXxiZt1oyBpdH9mNuehuNy90quxyg
 iOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313459; x=1794918259;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0QVlNjKD9RgaNd+toQU7197MhYK1SpkU/UiXR70UzYs=;
 b=TWzu+594nWWxz0f00llWs5wzXfQrfKEXhjbuVgI7yXK2Yr0oGIQYIlIs4WmXEmaPlB
 gWsET6seLxLqJrmvDgI5vLSzsBQnH69OKyfZvM9kVIs/R8FlhmZMmozCj5soSVcXLs/c
 eFf41xW1k19g+j7szHoCdz4iK593PJD5iBP0hzX+XMsyLD2byb2jskSoW8rY/p7TvWY2
 ejw0n9axM+/K9cNtcU98m40uxBtEWpTF0KfQskpVEmB29ryuyIodsBIebarsFtGS5vjj
 B48oO42HLl5CKK38XALv3RfKap4KWpzPhwjURXPHncoPwUowsUjiz1w08iYvH63Ds/s1
 QqfA==
X-Gm-Message-State: APuU4Z8rkI0Y7g65sArAiErOapMHvHOiOccNi+BLC+u+I6QJrk7UliG7
 WfHPnYZjn04sIfqspnOQE5TmEQ0OtsyUgdIK5tHbXl7c3Mhxd4Y6JEpJz/BMeFOX1+E=
X-Gm-Gg: AYBFou3RlsQJxXIufxTPKbAX3DLrQDXUnfbZ3+bb+KjSkPdzuPv82V5B9q9k7O7Wy77
 1lvgnXiMzC5cEs6+awJXgi6QFqpQHienpoyS5vfu6Aq0DRnX82341yICTTz0EpMsuQkvg5lRgig
 1/EEer0b3485Nu7T8H8wm2SjalgDE+NoSoT/n71vw6j+07WbvwmIgzyT+HbrTR+502mkY89BUdl
 zCo+IqqUtEf6HeyIntT1rH0kgro8ao/9Nn/HENs7DSB+ibYhK+txR+6om9p7bR+tPgZXCfxaYd3
 dERKUwISVL3R8ldFlDBanWlHzBJKafVE7TvQtFXorn/MGyPGMaF+2hRa89op1iuFBNS2YQBU9aA
 iSmHwH+V9drJg8ekCGo7MDz4ORqtIStKXzwF8i99ar5Lc0J4Cjh0Qt/5MFude3Hl6LP0G99WPVH
 OGRzr+9QOVLmsK5Zp4iDPTuaUw/kt4N2cF2kxGmLy0SPUWPHJEz8dXO4f+O7QK9VzJfPSbZSbSu
 YsxROhyJhYtOe62UaiKwFpPS2CFjncogfiaQQHTPa65Bxf5WFMMmjJlaKFftcxE6JKEnKcr2N3C
 aKg52OaW9YtCr04luJT6Ry/7magwle9WECHLKQcPucsFn+7a
X-Received: by 2002:a05:600c:6089:b0:4a2:d99:3171 with SMTP id
 5b1f17b1804b1-4ba0234a805mr39685435e9.23.1794313459419; 
 Tue, 10 Nov 2026 04:24:19 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:e865:f651:6131:9a7d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm99279315e9.11.2026.11.10.04.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:24:18 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 10 Nov 2026 12:24:09 +0000
Subject: [PATCH v2 12/12] test: Fix test_basic file system tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-qcheck_fix-v2-12-1c76e0b68f29@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ensure that /sbin is on the path so that distributions that do not have
it will still be able to successfully run these tests that need fsck.
Add a forced clean of the newly created file system to cope with the
fact that there is an orphaned file on ext4 that will cause the
integrity test to fail later on if not removed now.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 test/py/tests/fs_helper.py              | 4 ++++
 test/py/tests/test_fs/fstest_helpers.py | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index e3824b2c1fd..48b047aeefd 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -250,6 +250,10 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False)
                                       shell=True).decode()
             if 'metadata_csum' in sb_content:
                 check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=True)
+            # Cannot use check_call here as it will return an exit code of 1
+            # as it modifies the file system. The -f is needed as although the
+            # fs is marked clean, it is not really.
+            call(f'fsck.ext4 -f -y {fs_img}', shell=True)
         elif fs_lnxtype == 'vfat' and src_dir:
             flags = f"-smpQ{'' if quiet else 'v'}"
             check_call(f'mcopy -i {fs_img} {flags} {src_dir}/* ::/',
diff --git a/test/py/tests/test_fs/fstest_helpers.py b/test/py/tests/test_fs/fstest_helpers.py
index d25326ee993..6164eca476a 100644
--- a/test/py/tests/test_fs/fstest_helpers.py
+++ b/test/py/tests/test_fs/fstest_helpers.py
@@ -3,9 +3,14 @@
 # Author: JJ Hiblot <jjhiblot@ti.com>
 #
 
+import os
 from subprocess import check_call, CalledProcessError
 
 def assert_fs_integrity(fs_type, fs_img):
+    # Some distributions do not add /sbin to the default PATH, where fsck lives
+    if '/sbin' not in os.environ["PATH"].split(os.pathsep):
+        os.environ["PATH"] += os.pathsep + '/sbin'
+
     try:
         if fs_type == 'ext4':
             check_call('fsck.ext4 -n -f %s' % fs_img, shell=True)

-- 
2.47.3

