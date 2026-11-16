Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32E606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ae/dkrFC;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FfTv3a3v
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4F9A60825;
	Mon, 16 Nov 2026 11:00:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j00tsWjmjNDu; Mon, 16 Nov 2026 11:00:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7CE3A607A3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826800;
	b=Chxp2TFihEweM/Fcz8eYz0e+WtIAVkwTR6jbx3W1KVDq5vQmnj9IQITIh6hpSXJhbcCP
	 GLdGoDRHvPms+3PgjKZUF7jvzid5GatUUIfymR5YBma5beGjysUOtcKstGhe0TKHCnotd
	 v0k/wO1TMkGXAyQYiRrt6lU4SXhD/pC1C+suV9moR8Qon6Gqi8td1RVAbAZauKkuYfLz2
	 Zwkeyutmz0SQxCYxPujvRCmFayba2UVe32io+NE1BeNFNg8Och+YEhpejEF56VUdUjmgk
	 +r/mCUKO3J9hmR3fBUmkbIlWJXckv6S5iW09PM44prfdDASCZq2jEGE1AC4qOHhyjiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826800;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=28nJLlgvi7fcsuk/UJ+3xJsbOvVWwzS/XHAUvMC4SwY=;
	b=Vq7qyiQPXPWBMlmgndmIHONocnDbNE79AoVfm3D0JNbHkpT4atDT6uGJHuQMzttMmSuP
	 087sV3mUuJC1v/yDX9bJxiCWkep4X1SZalLsWj6S5SZ7phZIyI/a6N5enENhzO4n6zTx0
	 ScT5UaMtwHKZSkF0ZisGloTmnCI5/6PH9JhgcKccx/J7NMCkGprnCbKV2EqoWx1SS5LYh
	 vlVkk9FbzrHLBFa7u31G6s4n0N56RRtfsCcvtErlhjAtmOvzAJdyZOK3pArLLUkKUl3E1
	 FRTsAdk5qOKAK9gDHwO5g9EAMWa9SMFbNHxmSCOkJhzLz9WNga1gs50cP49iEiZPAnQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826800;
	bh=28nJLlgvi7fcsuk/UJ+3xJsbOvVWwzS/XHAUvMC4SwY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ae/dkrFCkfMwRNjEUdo9vW+HNdpO6kEUBX0T915jYLMN2LsG4AQRBuZisuLC97x7y
	 1j6oiAfR3LcAFMIRbBC0Ap8SKEt+y6ojKBZfqDivU0k3WMFIWTSLDREEioXVDkxtbJ
	 yYTF2zUBtn5Zw1FACHgXAWnxVAhEyTPvTsKXNqU8koigz+1UgM1vUWa9FJUuCcVLz+
	 dCB8pyOf6SOPG09AkEwEKnTGT3OYg+TUknFcGTsuMHmLV8TpvHiu6SruqWhgUfscPP
	 JWa0aTRwjT8fJXq0sWWmyNWxjbACxqdtFdZfIU7I8ai+xDXE6gbFrEyda7Q760h/xE
	 Xd6XQh0+z4wUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CE3A607A3;
	Mon, 16 Nov 2026 11:00:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A38E21A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A2B880D48
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LYCYhM9J0uib for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D71A80D44
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=FfTv3a3v
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D71A80D44
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:39 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so26583165e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826778; x=1795431578;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=28nJLlgvi7fcsuk/UJ+3xJsbOvVWwzS/XHAUvMC4SwY=;
 b=FfTv3a3va6pLPeWmy6BX8h6I6Hij6Lf0yaU+3q04VysWaOkUxml9G7wPKgoSN2AbLt
 9qbgQjPDRIAh3gwdJ8ciFHLkJssHirYxL0JnDtoG7sSnb8sa+z0/WCzgAUVRf3V5RTOz
 ilxt+iK5aqSEgwFXopwfuKW6daiDjkKwWfUcaiqSQnX9jHChPRZ0JrqxrNhuwodOPrCz
 XRD2wtxfVscE/nMna9zvjwpI9sKPWn2qkYbXgXwlTiQCZMV8tKRxd+iGLNBiiLHQEz7J
 MT7Ju5CvdWUqSicqx+S0gwoaM+p7+uGzse/8sDBsNnZGXoS7ZLDS92Uqb4Ytj9VAvXUk
 djBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826778; x=1795431578;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=28nJLlgvi7fcsuk/UJ+3xJsbOvVWwzS/XHAUvMC4SwY=;
 b=XDVX+6qEuJw+K7LIL/oiYsY6jQfRR1ZFH3jZsDNhg4/5TDXQYo6mJKVote06TXBikP
 nAKPKqgt02Zn/GpciAI7HLsWsA1boVozoIUTpd1tRWxcHhpIjXTyHIkBwrX2e6OyMDcC
 2szG/tzAAFoZSlMd53jjV4siM6Z+Sb1VJb5/TytCYREoOk3BUQr2uxdALLHIljNiL3zC
 1f7q75p6uvLm0bum8R3QtmIlpiffYEjV1r5f73I1UFijpFfCl1YVbCQfQ1QXeRoVK2ii
 HAzhYX0tuwHcJo480XKGvo72g8XNQFtiUgV+teKQ/Nn3t8T0n5gz5hZnqoN7Nl7Igb85
 mhmg==
X-Gm-Message-State: APuU4Z+m74oT+QDVPutTQ1cu9Z+CHNrwfFSOtIeKbm3zN2WnCH5Jegls
 UbcEPIE57nNQYYPUMdX3YLxRfSgzwaZS/nPPO5XvCaUg1GTTRmyAt5d43C30u2sABSs=
X-Gm-Gg: AYBFou06sas4XCgZDFsoCsM6VdF+iXrqgwzsPw1l7j6xcyISKcAO092IpHIPavXPEhe
 mnP9RwKvtrEyZ57aexZD6GRxKSTyWVh5WR78KJuVbP3DEsiWqU9fy8Q7/FgqMyMKzI3NSpto91H
 goIIBVuw48yqPY7+dCaHnP1bGwB0sQfQ1e/F/G90XuKKxCpvzhN0y3s27/WHQBoKYfrYp67j1vL
 M2NT4/E/3uKjKKTcYrTSXbPNhsCwKht4irfUEJbgmT64Z1lFYWGGKtBHNgVDYxawk4iU/J3UCOK
 7x/X9/dCmgXiSDXRLKC0UsskPyHsttgWmaXAd9h8Jox/7JCOqpeQADAZlxFBTIM0YwIqLW0PAaS
 nNhXw+0gmx56U27gLLqiwoieirrXy2/iGFAXlq9RN+AxqxuD4KdOJSEZo10HA9sBUFiWIBax6Qh
 voH43F0XxCZL/4SJWOTPqAXebuyDcJZT4HTZ5OsBzb4ocO4uNgBtmLZCXXGl4o+pLmhIL1Fth+P
 yT4jcxVD4XM/CZdSAHODUTN+/ClPMiH3xwM9bq5Mw0qVFZrRKQFLMnqdiZ0hz11B2LM4km8BEYq
 UFJ4P2scsEndNDu2PRzUW1Reg5agHcMIsSI3GzLNAffrJiVeAg==
X-Received: by 2002:a05:600c:a00d:b0:4bb:6842:66ef with SMTP id
 5b1f17b1804b1-4bb6842670dmr122523035e9.30.1794826778176; 
 Mon, 16 Nov 2026 02:59:38 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:37 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:34 +0000
Subject: [PATCH v3 14/15] test: Fix test_basic file system tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-14-b6cf7e96944b@linaro.org>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
In-Reply-To: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>
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

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 test/py/tests/test_fs/fstest_helpers.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/test/py/tests/test_fs/fstest_helpers.py b/test/py/tests/test_fs/fstest_helpers.py
index d25326ee993..c8fa0b006ae 100644
--- a/test/py/tests/test_fs/fstest_helpers.py
+++ b/test/py/tests/test_fs/fstest_helpers.py
@@ -3,15 +3,21 @@
 # Author: JJ Hiblot <jjhiblot@ti.com>
 #
 
+import os
 from subprocess import check_call, CalledProcessError
 
 def assert_fs_integrity(fs_type, fs_img):
+    # Some distributions do not add /sbin to the default PATH, where fsck lives
+    local_env = os.environ.copy()
+    if '/sbin' not in local_env["PATH"].split(os.pathsep):
+        local_env["PATH"] += os.pathsep + '/sbin'
+
     try:
         if fs_type == 'ext4':
-            check_call('fsck.ext4 -n -f %s' % fs_img, shell=True)
+            check_call('fsck.ext4 -n -f %s' % fs_img, shell=True, env=local_env)
         elif fs_type == 'exfat':
-            check_call('fsck.exfat -n %s' % fs_img, shell=True)
+            check_call('fsck.exfat -n %s' % fs_img, shell=True, env=local_env)
         elif fs_type in ['fat12', 'fat16', 'fat32']:
-            check_call('fsck.fat -n %s' % fs_img, shell=True)
+            check_call('fsck.fat -n %s' % fs_img, shell=True, env=local_env)
     except CalledProcessError:
         raise

-- 
2.47.3

