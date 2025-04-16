Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87305C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 12:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8453682DF2;
	Wed, 16 Apr 2025 14:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DW3Z+E/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D3F382E27; Wed, 16 Apr 2025 14:36:38 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EADC8003E
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 14:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2A18361135;
 Wed, 16 Apr 2025 12:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50245C4CEE2;
 Wed, 16 Apr 2025 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744806993;
 bh=zc2dwSRPE12gzkGGkgVyB1LH1GiTlivYtm5CwcyH724=;
 h=From:Date:Subject:To:Cc:From;
 b=DW3Z+E/6DR4+TQeMKUbSwBe6pbGVOwKpYRkT6MRD1lKF2vZlHJU9T5+AZbUt+AINC
 i9SCMsVyPoXFbQigbKQuRRHer6PMN9i2AAwBqPbGdjlhFalJGMY8O+pdhe78Ir3PpJ
 3tQm4bBWpIJqfgSQhmsfOKT02exDPPsSOTC+1mbrMbCbF6CMp8UlChZNRllwx+s/cW
 /Vu5NtXRhHcGR7zqBGK2QXcfVGuVMccdkrvvy0xMryzdBgPLY7eYj+foZVWTaa/sAQ
 7LXZ1wzbP1bWSz5TzQUfrHztFCDC9PRYp1KqYoypOI5Os7kY5M+j7q0iwklOfxQ9fM
 Ykykw6K84gy6A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 16 Apr 2025 14:36:28 +0200
Subject: [PATCH v2] tools/make_pip: Use venv when invoking pip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-ubuntu-24-04-v2-1-bad2be600857@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEuk/2cC/1XMwQ6CMAzG8VchPTvTVcbAk+9hOAhUWDQb6YBoC
 O/uJPFg0su/yfdbIbI4jnDOVhBeXHTBp6BDBu1w8z0r16UGQjKYY6nmZvbTrChXmK5r+URNZax
 FSJNR+O5eO3etUw8uTkHeu77o7/cHVf/QopVWaApLJaFtivbyYPH8PAbpod627QM99jzeqQAAA
 A==
X-Change-ID: 20250408-ubuntu-24-04-0dce32b95770
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.3-dev-7b9b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=zc2dwSRPE12gzkGGkgVyB1LH1GiTlivYtm5CwcyH724=;
 b=owEBbQGS/pANAwAIARkNHbRmThk1AcsmYgBn/6RPwqWxPJ+JS7/xChIhtCU3jeU55n+xH9320
 9FykHkVZZyJATMEAAEIAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCZ/+kTwAKCRAZDR20Zk4Z
 Nf7WB/0U9xy9jI3WNcnJByi5aWCDBWXDZYhMqWmH5dPyS+jmj6UdmfDAjHNNNmoLlB4I6tEaT9q
 V2wc2EcjXtuV29TvTKOC7Lj8rMLJQNvxd/YdA2QPvLPg2jk0ZTr+9O4aIqGD/myAl/GlDS/9xyL
 jA79yIfBJNtUffnR23Q38ZsFl+6Zsw9AgNftb2B2PeSq7o2HUajkkMfaxYx/f486kHQmE3H51gQ
 L6dLKb+CjftU91HF9xYf3uMduwawxoucGc7Zf+1wJT3dn61ktaHlW0Ge9qN+ty/0/JtFuAhDNEX
 lHIpfbWhAds4WuHGkdGTMn6cXUzwVG1jfedxm7PF4I3Fgg0x
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
installing packages. The recommended approach is to use a virtual
environment (venv) instead.
Because of this, "make pip" is failing on such versions.

To prepare CI container migration to Ubuntu 24.04, use a venv in the
make_pip script.

Note: This has been reported on [1]

[1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/37

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
This has been tested in docker on ubuntu:24.04 after running:
$ apt install python3 python3-venv

with:
$ ./scripts/make_pip.sh u_boot_pylib "-n"

And shows:
Successfully built u_boot_pylib-0.0.6.tar.gz and u_boot_pylib-0.0.6-py3-none-any.whl

Also tested with "$ make pip".
---
Changes in v2:
- Use venv instead of virtualenv (Tom)
- Link to v1: https://lore.kernel.org/r/20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org
---
 scripts/make_pip.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/make_pip.sh b/scripts/make_pip.sh
index d2639ffd6e43..33ad51ada703 100755
--- a/scripts/make_pip.sh
+++ b/scripts/make_pip.sh
@@ -106,6 +106,10 @@ fi
 mkdir ${dir}/tests
 cd ${dir}
 
+# Use virtual environment
+python3 -m venv .venv
+source .venv/bin/activate
+
 # Make sure the tools are up to date
 python3 -m pip install --upgrade build
 python3 -m pip install --upgrade twine
@@ -122,6 +126,8 @@ if [ -n "${upload}" ]; then
 	echo "Completed upload of ${tool}"
 fi
 
+# Finish using virtual environment
+deactivate
 rm -rf "${dir}"
 
 echo -e "done\n\n"

---
base-commit: 9d9fbdab0e9664bff147109cc89ad2786f6ecd83
change-id: 20250408-ubuntu-24-04-0dce32b95770

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>

