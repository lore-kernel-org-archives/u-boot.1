Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC69CC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA7187792;
	Mon, 27 Nov 2023 14:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NZD0IGFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 443D087797; Mon, 27 Nov 2023 14:01:46 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB5087792
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso5449313e87.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090103; x=1701694903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wyiR2jVJ4p1meeNGxOfrkmg2SjWDWAw0ref9nazVreE=;
 b=NZD0IGFq0yxm3zK5/fRktzA/YTpGGbPUS/uJSoLV1k+tTvCGi9/7bh9HGgL8XOt3Qn
 V0HHqPs3dQdxneiRKBAJBR3Icbp9V5Jc7wEi/dcGJPS2hM8Aho2mfUu1kB95XXYVJApI
 C/ZVD2T9OzsII/aqFgXwyUbGyHcGg9aoepkMNkYBPzQ2CYZPwql7/SjOlLfxmn6/qX/Z
 Zl9or0G+bS4iAqtALZXOqzSEsMCOqEdap4uS6DKKC6UFv+8qkWNq1B0Zq6rHTSv6b1UZ
 ISdqpVkFAKqH8KxeRB8F6P6ItyHkB4Momn0QjmQeuhXA/EiuQol6xyIlPZHc/Cb8syXa
 MiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090103; x=1701694903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wyiR2jVJ4p1meeNGxOfrkmg2SjWDWAw0ref9nazVreE=;
 b=uWph0J0Iks+9nBIS0fCjgR1lzMn98frnYFnHB5HHKiDdxBPH0S3WM2W4cqu7GCddYQ
 FRT4hCFZ9LuRozbkqjuaEnLJCw49EIg63YjdbtmudvrC+xKlwb/Cu94fJOHZlPVdeX6E
 py/PppBDjaL4W/2l1VDMSrpLohuLoaBduQFHn++t90UIwyPVpFYBv7vNzjQHMy9GIcy1
 y4TmmjYG0rfk3gZ7nWOuCtREo8rlek+tWdFOquS0VqLFD9fOxa43PYom8RfvuyXb9/42
 9ni9ZOmtFCsdxPDkOB6UuqmYRBUFslNlLVjT1VHZ9Ex+jPijT2zHeTuA5hyw3dYqZEuz
 Ac4g==
X-Gm-Message-State: AOJu0YwVxHw4JO3WN1FzWtxhdj1HbYn8AcAIuM5GTclJrf8FFFYKzCfN
 Pn3rsSgIDoxdo+aVF1z/5UyT28yX3HSY3lC8iK1Sgw==
X-Google-Smtp-Source: AGHT+IF8rbUhHfYb2J7WYcwNxwDMrhjv9/LOk1/smXNYZLvhTQbkRoNMtT6E0acoJ7nwWSostzzV9g==
X-Received: by 2002:ac2:5230:0:b0:4f9:5426:6622 with SMTP id
 i16-20020ac25230000000b004f954266622mr7250299lfl.69.1701090101522; 
 Mon, 27 Nov 2023 05:01:41 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:41 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 40/43] .azure-pipelines: init submodules
Date: Mon, 27 Nov 2023 18:57:23 +0600
Message-Id: <20231127125726.3735-41-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Azure CI does make testconfig then passes U-Boot sources
to docker image. Inside docker image owner of U-Boot files
is different, so user doesn't have permissions to update
submodules. In this case we can do init before we run
test docker image.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 .azure-pipelines.yml | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index d6f3fa423c..b6fa843e8c 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -113,6 +113,7 @@ stages:
     steps:
       - script: |
           cat << "EOF" > build.sh
+          set -x
           cd $(work_dir)
           git config --global user.name "Azure Pipelines"
           git config --global user.email bmeng.cn@gmail.com
@@ -134,6 +135,7 @@ stages:
           make O=${UBOOT_TRAVIS_BUILD_DIR} testconfig
           EOF
           cat build.sh
+          make initsubmodules
           # We cannot use "container" like other jobs above, as buildman
           # seems to hang forever with pre-configured "container" environment
           docker run -v $PWD:$(work_dir) $(ci_runner_image) /bin/bash $(work_dir)/build.sh
@@ -196,7 +198,9 @@ stages:
           set -ex
           # the below corresponds to .gitlab-ci.yml "before_script"
           cd \${WORK_DIR}
-          git config --global --add safe.directory \${WORK_DIR}
+          git clone \${WORK_DIR} /tmp/u-boot.git
+          WORK_DIR="/tmp/u-boot.git"
+          cd \${WORK_DIR}
           git clone --depth=1 https://source.denx.de/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
@@ -506,7 +510,9 @@ stages:
           cd ${WORK_DIR}
           # make environment variables available as tests are running inside a container
           export BUILDMAN="${BUILDMAN}"
-          git config --global --add safe.directory ${WORK_DIR}
+          git clone ${WORK_DIR} /tmp/u-boot.git
+          WORK_DIR="/tmp/u-boot.git"
+          cd \${WORK_DIR}
           pip install -r tools/buildman/requirements.txt
           EOF
           cat << "EOF" >> build.sh
-- 
2.30.2

