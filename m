Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF12CA9EBE
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F5D4607B2;
	Fri,  9 Oct 2026 17:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rddPVVg6nBr9; Fri,  9 Oct 2026 17:14:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 365C160658
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791566049;
	b=IDhoofEerO3C99WL9qWoy9sa/X2TCU/BGihhix0bMq+i5KHUpj0NEsvqA6DWsXGoy8r6
	 8Rs6x0ffsCw/PZERsmN4ka9w3SX+0Kc5IH9FTgzT+cZPMLPNxXvZx6SCYheX84v2leLE9
	 Oauj3Fj8AGXH/xIYs/Mq5wwu9ZUAOCpfg6kdhf+1hB+1GSIlCOnC7Z36v6KMisjJOd6jr
	 Rt//p0cKvdPomO15YUflL4rnmwyqnHBpfPW4qul9iou5gnppZvf3C4f8TLEESX+NKpnuD
	 SwgIkZp5ev1mtqrIy0tTh7G2hZ7SvqODwzDedIOoZ7l6rCXTF8Sf4XSitaCR/Ku0G1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791566049;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uTK5UlX8y6tntdZeDtjpD1/DoVkhLSIpwptOwOpH6RU=;
	b=Ud579RE4NilFLTrqHnl/NjSM9uYc4Y2oz1y5cUfdfA6lgFP/U9IK3q0THz51TVRVbJgf
	 wVkIZkYB4oAOoIZ4S8/cCBGcH5Q2rMzA9UC8ruqHI351IhHnZR+MFZHZVaRg8NyreZuiR
	 GxxqfeiAgJGQ5x6YJJPL5dk+toFRxIQZcAgYaLgtLLhdXtPLZqvIt0OouMxmsjyBCaGdS
	 tnJRLubXvlhUjSRjW/3HyoiJISXPKuJLOU64FssuOSSjAd60lHoTJhfDzjLXCp0JST1zH
	 eUMsypijpUF+6UbxX5vCo2zhgf2MLtqLGrKUWXsBB14Pwt/wEkpgEQNZK8Q6v/CI8Eg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791566049;
	bh=uTK5UlX8y6tntdZeDtjpD1/DoVkhLSIpwptOwOpH6RU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p6ley6uZ7JtFOSowyKZy+dRzR1LQreLjMEEQwl3yLA2rd7gDYCtzH5FXcOk2+/nAc
	 Pey3DCjrvYruq37z0mAVwDGV73EdCyLQzgh/FgnrZazYiAQfoPQCrXD8DJire+mt+G
	 wFsf34jeb/YwzMyr5AQKNAPN1jITvqkJ7rFDynkPAhvSKgy8QB9FFMACGzM3CvqqU9
	 Ig4gleNGZAlPUG1D0ohfW/74xnXSrX7KmUkQab29+rrn5oTIeHOSJhIi7iPID6zk0q
	 jj8CaE2HyAv1LTRTuAskUuROsUnHnwBIGKAuh9yF/IaEKsXxQGLga149XwXnlkS7YC
	 iYrVq7/nO3L6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 365C160658;
	Fri,  9 Oct 2026 17:14:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6796F2AA
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D4CE408C6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mujK9zx89PK3 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:14:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 531D340880
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791566047;
 b=KbANC9rZfSP/ZnjtLvrmAzmS1WZT+WBPOx1pOVmlt8IH3UR8bGe3TMaN0kLhcbvISG+S
 0dvUSQfy8l0lQ6RvFa6nBev7baZV72WGfIc84EIOze7aaO9fHUlnvsDVgjCpj7JuvpJL+
 GGD3ixDtE38LfUlIye4SAJjw98/YwE6BrPRagdprFHkb8c0zpMWGgiN0Crgwn76kUX8oX
 BgYD4DF3lYQO6KFMGhsw9cPB+eMJUXjH74F2Z+cFnyNDHgVFN46CuDPpf+mmy2pk14s7q
 lLK84gdYqamadbutoGGW3mm0TjC98tXLn200U6vbpNDbpjPRXvxEzCs8ZikBzxY/8PA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791566047;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=uTK5UlX8y6tntdZeDtjpD1/DoVkhLSIpwptOwOpH6RU=;
 b=FTjod98mMoJds3OvX6ZuzgwdQ7VX5Fs/vauQknT26H1TcQC7Th96Ijr9yVm09VUBrt0j
 9lqIhWmWCMgWXI2bIqmI1ORNfv7Oh7jI8acc7LqlPtnUqS8DTF/vTYzTnrSK1XJphxHlb
 IF4ec0hwhjcjZ8aoRioJAGJ+nvKqQXdLK6EnPo3Y9zG5fkzh4XvKwcg/d/LdfYoF0rUfv
 ihAL2TcV6aU5EbKCcWm1sscdEFvfvBMAueODrG7Pvvf0wJFA6jQIa3nVFVif21Ie/KO7o
 pZj1Nr/5SK/pUhNLp+j2YAPh08GWU84htv8ZX9q+JmnXrWDroPEh9hKdgEm2pYxBLYQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qKHxSMkj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::9;
 helo=mail-oi2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=qKHxSMkj
Received: from mail-oi2-x09.google.com (mail-oi2-x09.google.com
 [IPv6:2607:f8b0:4864:32::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 531D340880
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:14:07 +0000 (UTC)
Received: by mail-oi2-x09.google.com with SMTP id
 5614622812f47-4f6b95ba1f6so12700b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791566046; x=1792170846;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uTK5UlX8y6tntdZeDtjpD1/DoVkhLSIpwptOwOpH6RU=;
 b=qKHxSMkjoX+ZhGijDS7vzkE1PVw/ys+R7/+ePGK9h5A8db6qAFYmm3s0idRI5sOfyA
 hWhF9VQrVQoT8ih/2ENYOYIWcTiEGjAg5hjHMLwbi/1BvaXigkvj/XKBEfJVuBq/46VZ
 SX7kwHszomf7dBUWWp4tGZ56+uIpOZq9dFdsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791566046; x=1792170846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uTK5UlX8y6tntdZeDtjpD1/DoVkhLSIpwptOwOpH6RU=;
 b=BMeVkgefoynqmmUprM8JYPZx3BykThjhSj433BZXOe2EIg59qG+cuInbIlVqb0mvdv
 ElqBxhV/LETDLPL45SmIJI6lLyl3OsiRWbXJU/0nMBbt5k0TutpnMWLWWH4yqZYzJusH
 0NF06HCqIk/CXlDhu+MlF+QkUUifsv9mp/FZ1UFtzcC/37rSZJ+6fd2GMRihnbAwstrP
 DbMccAHq+eAlTsw5P9HCKdBZH+3OE4wlSWGRz0q5BrkXjeSDzDWcosLuSJ/YUaGM4kLC
 O/7GAb4RAevZqQi7er/9/UV5u01eR0bskc6lzTiKsvtOiMCOhdyei+EfnfTsMttMFdzw
 xeng==
X-Gm-Message-State: AFuF++neoFzEkDkWJVswPqykvctw6DFeqmWjI9FHu9314sx39+xb+sYD
 QZHvYWkFInnTyUMv8FUyG8CYn+geariNhVNmwDyr0ZRrLpXjY8ueHwC7kfxHPxKJOVwm0g7Phb8
 Rk36Th9yHRfIlDnc=
X-Gm-Gg: AYBFou0HqW5yQrXB/reaaH6iQXZcmgb9Hrwkt5nKwxVTQoFwtn84EVyUJ1c5cwDapIh
 11o083CcKpBl6XfABFcus23TV3k5fXuYKmGAsa41V1Ej2Du95nFIwFAXIhx0QX4RG38jMZk1a5i
 6yOdhVUBsz1r/B97dItN4A+mkW8MI/UZxrHRauflzWGj0g9BUDkmOINbqzayLgS++s4X7Y0fben
 XiQk5VypZWcFLxhiFNEI18F9xEGruN/vpJu1BR1tDUrBo0xYUGmx/cohH4m6i8U7E0icO93Orav
 U2wHBpMION5S8pTW7ZqYAntTYp0X0iBZ4GNcC2nQQA4PDx5A08pVPqzGkwbdM/EK1VQoAU/CC8u
 xv0K9JEeGXMe2KyMk2NnNtQT995MfxzOc2mLcjlVqCvrg1/Pdt0/2evhSpGZkAUFexLJYUF3W+2
 Rnt7DHDXtk5FHPdnqjy+ijkp079Nr0i3XY+ibkrvPMgs3Uc3SlArv9LFrG1y9e8C4WaUvLCs9x2
 2Pf5xCskRQ52lb/rAq9DfG+p9tK80npAf4MyotItGJZVOllRkhuams3rRiSyW0akNzkzcYsv/26
 baSEpiElB7oLzEexiiE+yHUjLJNzo4Evqh6tUHW7t0E=
X-Received: by 2002:a05:6808:10ce:b0:4d6:9153:2966 with SMTP id
 5614622812f47-50c59398fe4mr1995040b6e.55.1791566046063; 
 Fri, 09 Oct 2026 10:14:06 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe916sm2663918b6e.1.2026.10.09.10.14.05
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 10:14:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] Gitlab CI: sage: Update for labgrid 26.0 behavior
Date: Fri,  9 Oct 2026 11:14:04 -0600
Message-ID: <20261009171404.2628469-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This is the patching part of the u-boot-test-hooks changes done here[1].

We now have an LG_ENV file per hardware, so we need to point at that
when talking with a given place. This file now says where the
coordinator is, so don't set LG_COORDINATOR.

[1]: https://lore.kernel.org/r/20261009171328.2627684-1-trini@konsulko.com
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci-sage-lab.yml | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci-sage-lab.yml b/.gitlab-ci-sage-lab.yml
index 798c33e6becd..94e3c0756e48 100644
--- a/.gitlab-ci-sage-lab.yml
+++ b/.gitlab-ci-sage-lab.yml
@@ -18,8 +18,6 @@
     - git clone --depth=1 https://git.u-boot-project.org/trini/u-boot-test-hooks -b update-sage /tmp/uboot-test-hooks
     - ln -s sage /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s sage /tmp/uboot-test-hooks/py/`hostname`
-    - export LG_ENV="/tmp/uboot-test-hooks/bin/sage/labgrid-sage-env.yaml";
-      export LG_COORDINATOR=172.17.0.1:20408
     # Prepare python environment
     - python3 -m venv /tmp/venv;
       . /tmp/venv/bin/activate;
@@ -27,7 +25,8 @@
         -r tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.txt
         labgrid==25.0.1 setuptools
     # Acquire and turn on the exporter.
-    - labgrid-client reserve --wait board=${LABGRID_EXPORTER} &&
+    - export LG_ENV="/tmp/uboot-test-hooks/bin/sage/${LABGRID_EXPORTER}-env.yaml" &&
+      labgrid-client reserve --wait board=${LABGRID_EXPORTER} &&
       labgrid-client -p ${LABGRID_EXPORTER} acquire &&
       labgrid-client -p ${LABGRID_EXPORTER} power on
     # Prepare ssh
@@ -50,7 +49,8 @@
         --board ${TEST_PY_BD} ${OVERRIDE} -T 4;
       RC=`echo $?`;
     # Wait for the exporter to have the device ready
-    - while test `labgrid-client resources |
+    - export LG_ENV="/tmp/uboot-test-hooks/bin/sage/${LG_PLACE}-env.yaml";
+      while test `labgrid-client resources |
         grep -q ${LABGRID_EXPORTER}/${LG_PLACE}/; echo $?` -ne 0; do sleep 1;
       done
     # Fingerprint the exporter
@@ -70,7 +70,8 @@
     # Release and power off everything.
     - labgrid-client -p ${LG_PLACE} power off
     - labgrid-client -p ${LG_PLACE} release
-    - labgrid-client -p ${LABGRID_EXPORTER} ssh sudo poweroff && sleep 15 &&
+    - export LG_ENV="/tmp/uboot-test-hooks/bin/sage/${LABGRID_EXPORTER}-env.yaml" &&
+      labgrid-client -p ${LABGRID_EXPORTER} ssh sudo poweroff && sleep 15 &&
       labgrid-client -p ${LABGRID_EXPORTER} power off
     - labgrid-client -p ${LABGRID_EXPORTER} release
     - exit $RC
-- 
2.43.0

