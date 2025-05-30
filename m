Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1592AC5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 13:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EF2482CD2;
	Fri, 30 May 2025 15:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PYiqI72k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF65782BF3; Fri, 30 May 2025 15:31:29 +0200 (CEST)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2451182B32
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 15:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-601f278369bso4094695a12.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748611886; x=1749216686; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XgJw3uR5AhqvbIZJBKzBSdeJIG+fbCRqPCmLVjSFjWE=;
 b=PYiqI72k87yS4YnqOvLLWndQm2zGVPYfjrrkCZzdcv8nNo5NGl3UPhKDGLEqlfkjIO
 9CwKWfZfsTvy8jzwHQ5UK/jNFu8RcjtSpKLfcKDtx1K9lcbeSoFvMw/PWilQtwTFWYi9
 6w1Um7ATnWCtZouC/5iM/6OuEg3RlSERgh7bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748611886; x=1749216686;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XgJw3uR5AhqvbIZJBKzBSdeJIG+fbCRqPCmLVjSFjWE=;
 b=HeUa/uGxi2tYAkM1gAReDclrZ3ION0Y/nmD5/P2twNMQ11DaoqU8r8pt4LDIQHW2vP
 4QdXXClNys9jT598MI0Ftzvvn2PjeEZUMUGLoIdv3qwsNr5/XRSaKJVgluEs20/dqVzl
 8oW3N2u5/+OdvNKKCkZjiGvxMwmK3uwFnghXxWi6cYeAgzl2Xn6mEb8WXA4927QwXnNG
 RtdWXeLcbTjT5VzOzGWZxpdaBafEPVxpKXgbO3pO8nM27cCBob8wfyxUd0+1mFPde9lt
 PAO2N4BTXJB7/ZOp+OKzUYpKtZScgbFWPmgedDiycTp9y1jEsTcvI4N4OzbkO/wnR68p
 sgvw==
X-Gm-Message-State: AOJu0Yws7VKTCJPy0MbDoZ+qv7dimxeZk6jd4cxtm76D9Ugg1ghEXK0F
 oc4TD+NgYe+u01rAv0C9w2HY9MouhWB2e8KRq04MVm5nu+6GkSob+UgLEKAWYwhEdgeesJ8D+yC
 wdAZ9ykk6kfebFpq/zhQbAj+KUC1dpn2c0xD2nWBj7GUmCTdR1NbOa+55OBo=
X-Gm-Gg: ASbGnctUo+rzYJqJIKGWoypAogF9RzBnG71aaueqwXgWKBsOQ5q6u33hOkA4VwS0BTE
 EjbjD00SaMxgcXrOzvZmrwy82gjmYPP9XGFGjMbksxKCCmlDSPw4Hta2Hb6tdwo0qckO4MkVmXk
 Mc5bjhLy4PPZhLVTy5sv//skeDxndfibo=
X-Google-Smtp-Source: AGHT+IHqlQxzMCpVeUTUHlXCHowhdKt18OXfjI857w030Tw3aMBvvfzBSBqwqzbgJCC4xYhvs0Z18ruF5EpKcbIonB0=
X-Received: by 2002:a05:6402:5113:b0:601:f4ff:c637 with SMTP id
 4fb4d7f45d1cf-6056e14a5ddmr2836112a12.16.1748611885570; Fri, 30 May 2025
 06:31:25 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 May 2025 14:31:13 +0100
X-Gm-Features: AX0GCFuTL5gxgCa8LsBKtJUzC4tr74rLTqlnpe3hbhTdngHXXWlR18hIqm_P4yQ
Message-ID: <CAFLszTiFLpYoJnu65CWgqKgq6=ffXpWh4kcXqSaBjAwgkoP6vw@mail.gmail.com>
Subject: Azure runners
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

I have always found the azure pipeline to be slow, but I found that it
actually does support having your own runners / agents. I set up 8 of
them on ruru:

https://dev.azure.com/simon0972/u-boot/_build/results?buildId=90&view=results

It sort-of works but I get this error:

Plugin: terminalreporter, Hook: pytest_sessionfinish
PermissionError: [Errno 13] Permission denied: '/home/azure/azure/agent3'

There's some strange things in the script about user permissions. I
have the job running as the 'azure' user, if that matters.

https://dev.azure.com/simon0972/u-boot/_build/results?buildId=90&view=logs&j=9e29582b-d0a0-5467-6dcf-a3d3e6c87501&t=79f48d58-f5a8-5041-69c0-6dcb1e113d04

The problem seems to be that System.DefaultWorkingDirectory is set to
'agent3' even for other agents, in some cases:

azure@ruru:~/azure$ ls
agent1  agent3  agent5  agent7   vsts-agent-linux-x64-4.255.0.tar.gz
agent2  agent4  agent6  myagent

azure@ruru:~/azure$ grep -rs agent3 agent4
agent4/_work/1/testsh/test.sh:./test/py/test.py -ra -o
cache_dir="$UBOOT_TRAVIS_BUILD_DIR"/.pytest_cache --bd ${TEST_PY_BD}
${TEST_PY_ID} ${TEST_PY_EXTRA} ${TEST_PY_TEST_SPEC:+"-k
${TEST_PY_TEST_SPEC}"} --build-dir "$UBOOT_TRAVIS_BUILD_DIR"
--report-dir "$UBOOT_TRAVIS_BUILD_DIR"
--junitxml=\/home/azure/azure/agent3/_work/1/s/results.xml
agent4/_diag/pages/173b639e-3618-4148-8dad-bf8e2c733763_1.log:2025-05-30T13:21:08.9893891Z
+ ./test/py/test.py -ra -o cache_dir=/tmp/sandbox/.pytest_cache --bd
sandbox --build-dir /tmp/sandbox --report-dir /tmp/sandbox
--junitxml=/home/azure/azure/agent3/_work/1/s/results.xml
agent4/_diag/pages/43dd2b38-f02d-4f5c-9938-f9411d19a44c_1.log:2025-05-30T13:21:08.9893894Z
+ ./test/py/test.py -ra -o cache_dir=/tmp/sandbox/.pytest_cache --bd
sandbox --build-dir /tmp/sandbox --report-dir /tmp/sandbox
--junitxml=/home/azure/azure/agent3/_work/1/s/results.xml

azure@ruru:~/azure$ grep -rs agent3 agent2
agent2/_work/1/testsh/test.sh:./test/py/test.py -ra -o
cache_dir="$UBOOT_TRAVIS_BUILD_DIR"/.pytest_cache --bd ${TEST_PY_BD}
${TEST_PY_ID} ${TEST_PY_EXTRA} ${TEST_PY_TEST_SPEC:+"-k
${TEST_PY_TEST_SPEC}"} --build-dir "$UBOOT_TRAVIS_BUILD_DIR"
--report-dir "$UBOOT_TRAVIS_BUILD_DIR"
--junitxml=\/home/azure/azure/agent3/_work/1/s/results.xml
agent2/_diag/pages/6bd29aa6-be66-4287-a442-3d8108258ca0_1.log:2025-05-30T13:24:34.1360963Z
+ ./test/py/test.py -ra -o cache_dir=/tmp/sandbox64/.pytest_cache --bd
sandbox64 --build-dir /tmp/sandbox64 --report-dir /tmp/sandbox64
--junitxml=/home/azure/azure/agent3/_work/1/s/results.xml
agent2/_diag/pages/26bdbd5f-9710-46ad-88c1-5e99a7c3cde6_1.log:2025-05-30T13:24:34.1360950Z
+ ./test/py/test.py -ra -o cache_dir=/tmp/sandbox64/.pytest_cache --bd
sandbox64 --build-dir /tmp/sandbox64 --report-dir /tmp/sandbox64
--junitxml=/home/azure/azure/agent3/_work/1/s/results.xml
azure@ruru:~/azure$

It seems a bit strange. If you have any ideas, please let me know.

Regards,
Simon
