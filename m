Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC08C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 07:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70CA583523;
	Wed,  9 Apr 2025 09:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AAc5Ov6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4768B8353A; Wed,  9 Apr 2025 09:46:46 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D49831A1
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 09:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 27B4043CF2;
 Wed,  9 Apr 2025 07:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557B8C4CEE3;
 Wed,  9 Apr 2025 07:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744184801;
 bh=bzOGb8nI8nA0ECjnqNiqH7jDS4ZkAGihP3P1d2nqd04=;
 h=From:Date:Subject:To:Cc:From;
 b=AAc5Ov6HO9twIhNUuaRxleXl1HruXat8RCPgjO7Mq7xQUhgKuc69Lbpqh3VDNgOt6
 Waod4m3YnU1zYIWmi0nm6XZW6kYMgxiq7Jr5OiY7eePo5pJvc0tTXq0lestZI9IsDW
 kAGP+fMFVevJGnyFAwozhxxPvMVsnYZ4VKMssSTEkws8tbEHJyyh3gCnkGjFAwIlDx
 UZWx27bmtS33ar5lNQhnE0ElyfpTWwKscSUmiHhdMaSO/Ml2hLMhBOBR2yrBj6vSOJ
 XdRD7swY0vF6W/Zb1+M7Rcj2rTUUD7GmKMdWOLoNfr0q09OFV64fS3XpznTqjuseSn
 NaIaXvvUtCLqA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 09 Apr 2025 09:46:34 +0200
Subject: [PATCH] tools/make_pip: Use virtualenv when invoking pip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org>
X-B4-Tracking: v=1; b=H4sIANkl9mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwML3dKk0rySUl0jE10DIEpJTjU2SrI0NTc3UAJqKShKTcusABsXHVt
 bCwDNKzHeXgAAAA==
X-Change-ID: 20250408-ubuntu-24-04-0dce32b95770
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.3-dev-7b9b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1597;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=bzOGb8nI8nA0ECjnqNiqH7jDS4ZkAGihP3P1d2nqd04=;
 b=owEBbQGS/pANAwAIARkNHbRmThk1AcsmYgBn9iXfjkTGzbnNsbSxm5aqdcAzul8BiMfXeeCTH
 QxPqPWLtziJATMEAAEIAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCZ/Yl3wAKCRAZDR20Zk4Z
 NSccCACtb9uc1v6oqJlJ/delYkRhQv6joxZIJiK7svGk5/37HllO2SfLhwRZ94y+UYYjj4hmLra
 y0fsarkUA0Z5RWehpLyiOGdDqMj/xEvmfTKLnPFafgPE6CKv4KiTPAbZm7O1tA7qPBuruORh4ju
 k9KfOXq5eZIzZ8gUMjZCpcMblsN8yAoTzaydSVSNHXqeqYYzcAuIFYS1hUetMEFRCTtifc5FBTp
 EFFbcd+7EywyD2Q3/WoqaXxNO0TfHzlCHxduD4ES8NpikW2BNwUbX3e8pV39GVwonE336bIioNB
 LfdZMU8YsMXiTWurvDt5ZeGLY3EWmyugcCdA2XPoPzqeP27l
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
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

Recent Ubuntu versions (24.04+) disallow pip by default when
installing packages. The recommended approach is to use a virtualenv
instead.
Because of this, "make pip" is failing on such versions.

To prepare CI container migration to Ubuntu 24.04, use a virtualenv
in the make_pip script.

Note: This has been reported on [1]

[1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/37

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
This has been tested in docker on ubuntu:24.04 after running:
$ apt install python3 python3-virtualenv

with:
$ ./scripts/make_pip.sh u_boot_pylib "-n"

And shows:
Successfully built u_boot_pylib-0.0.6.tar.gz and u_boot_pylib-0.0.6-py3-none-any.whl

Also tested with "$ make pip".
---
 scripts/make_pip.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/make_pip.sh b/scripts/make_pip.sh
index d2639ffd6e43..f7135938b13c 100755
--- a/scripts/make_pip.sh
+++ b/scripts/make_pip.sh
@@ -106,6 +106,10 @@ fi
 mkdir ${dir}/tests
 cd ${dir}
 
+# Use virtualenv
+virtualenv .venv
+source .venv/bin/activate
+
 # Make sure the tools are up to date
 python3 -m pip install --upgrade build
 python3 -m pip install --upgrade twine
@@ -122,6 +126,8 @@ if [ -n "${upload}" ]; then
 	echo "Completed upload of ${tool}"
 fi
 
+# Finish using virtualenv
+deactivate
 rm -rf "${dir}"
 
 echo -e "done\n\n"

---
base-commit: 34820924edbc4ec7803eb89d9852f4b870fa760a
change-id: 20250408-ubuntu-24-04-0dce32b95770

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>

