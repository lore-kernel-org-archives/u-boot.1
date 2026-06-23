Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D4ACD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 13:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E89E584A2C;
	Tue, 23 Jun 2026 15:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uzIiu8iG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C4284A20; Tue, 23 Jun 2026 15:22:36 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02284849FB
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 15:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso80218605e9.0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782220953; x=1782825753; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=njZ7iX419khtpTvWA+PcuM7+SceI1nyN7tzK3t8gSDE=;
 b=uzIiu8iGT3kADtwIY/1l7hmF/CTRa81Z9NQeMVyP2DLN9h5fcCKUHCcsHo8j+QWBbS
 vXBlklqcg5MnzU9fFq5+FAiKLVZ+w9BEcn95B19hmdM0lnj7x4O7DmSpi+f+MXIzK/DD
 EGWh0IYm50INGXyDCNCgV5HnrbKSZ3cwP0MxY2ZX8wzu9CwSm9SEBdkOutj9Dc1UVhgx
 2Fsv6CqumfJ6NmNHgz/dTOhWJItBttmK5Z9KlHfhvSECgwgTXBDr396YktuCPEAnBHq1
 eASgvcv9hDbUprXA2hNfQpyZL7Bg5czQsGHCAmAtxeA4xLTN4cRBDr/HpwsHe3hngKfi
 w74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782220953; x=1782825753;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=njZ7iX419khtpTvWA+PcuM7+SceI1nyN7tzK3t8gSDE=;
 b=KaWTM9WBmH0e9MPlu/QY5HqyUjldvOF4avjK2qyjOVTgZ1yhFeVElwE2VbbyIXvhGN
 a/dooRmAB/IhADJI3NAkKj1+6Xbs8AkeYubZ27jy5CTJYqC4peysOAjZ5mUXBM9di974
 xYlHRCXCk+ViIXyJm74j/SkH0lq/E47+0dL37t5ERoVDQRmrgI0afnZPBOKu0ojcDwiC
 GxoevJCck7Ap/TTeoLKmP4lG4qoN6jkfuwcgGf08BUmKfS1AFaV3SgalgjFkhDctU7Y3
 oXk55S8ptxPBDPfw7UK/xvBxZG+p3pbW4tPG1ZnvF8/urRGDCIhGYulBOqmj7wGGXk8h
 b5og==
X-Forwarded-Encrypted: i=1;
 AFNElJ8R3Y9QKJE+fIEx0ejhoc9xFnkCuggJ09ZBmbSGAK+Ruq9IPScuQIAlxSKM+U4V8YGvbg2uFXE=@lists.denx.de
X-Gm-Message-State: AOJu0YxObEyAU0wypC5pxgD1q6KzQUbF6xf1WNTjsq2Lck0n/LL8cxdn
 wE4bMZ01FHbT5zu+lgOtkxm8pX6O3TVTHp2DvW6XFwliYnS+ri68aLjUVJlismTL8bc=
X-Gm-Gg: AfdE7claBm+2RzHgLZIXQyeSSaZ0J66SavQrIv82BFY5CD7xhTgaolcTqNfao8N6byc
 IcCUuk1TRml4PI1yh5U+FTuS5XkhkhiBYNL/iwNG/m1L4g2+N6+AZ/BlEPfu51DvqcyYufER+C7
 4C6IjEEeRbR97oAhzhQaVQUsuOfNne8rcu0WZ5I3+wlUROCVrFqeID9bC8ZP9n3pJl+VICe1MtI
 ZaBhHaQjS6Wu+eOIg4Ga1S/0XKYV9lcJ4wCli6n0O1B0aB8GtOCqopvebbo7pojxBVBBD86Rvsi
 F+DzDvLW/k5WqrFAGCh5ZRHWCLXYFmA+5la5kylYMteh1QejU8lqPyZzeB8K5iio198dD93z0RI
 vDSuAw2C4I+UtdpHjaO8gSxe9ix8khtxOQmjbZhiaf8MS4GeARxyHS9VoxxwE+Pi6pT2JfIAJkb
 Py4wM08pkPHSKwaToZlpyiGWgzYsM=
X-Received: by 2002:a05:600c:818d:b0:492:2f2e:e7e7 with SMTP id
 5b1f17b1804b1-4925b37ec5bmr35891915e9.17.1782220953249; 
 Tue, 23 Jun 2026 06:22:33 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a712sm349965745e9.13.2026.06.23.06.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:22:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 23 Jun 2026 15:22:26 +0200
Subject: [PATCH RFC v2 3/4] MAINTAINERS/README: Migrate mailing-list to
 lists.u-boot-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-osuosl-ml-switch-v2-3-28fd46e89e46@linaro.org>
References: <20260623-osuosl-ml-switch-v2-0-28fd46e89e46@linaro.org>
In-Reply-To: <20260623-osuosl-ml-switch-v2-0-28fd46e89e46@linaro.org>
To: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Javier Tia <floss@jetm.me>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Daniel Golle <daniel@makrotopia.org>, 
 Simon Gaynor <simon.gaynor@ezurio.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Alice Guo <alice.guo@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Yao Zi <me@ziyao.cc>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2258;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=O8e7ndlqO1X38Y+rY349ANYu5otivdSRKIY/CkwT/F8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqOoiRnEfsfm2NJ4AXUROFicUkW6SqS5hXlH9GIcOh
 FUptJR2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCajqIkQAKCRB33NvayMhJ0SezD/
 4268afoPxN2fnyg31Rc0p8SXyiaiRtyTYLyIQpdOD2mx7EASCYt/J6vlcGYoAXG8S4EhoqNMtgOpcE
 TaZYKtJguwO0w3e/s2gXQpIgbr2Xl3/LFbGaEJN0ah4PduoitA3WcCA7IgnhRWUJ69R31R4h5dx0rr
 rKzYsjp8fRUIXUisY3hspTKW0ve7VVa13z5D+NTV6kZigNxh3oKEH6jCYaXDJ2KMFvEBuBNpiUBMtQ
 LRlHnsT24MXgkRw6D+HRr4MF7M1LgqDQuRtEEtF8unDgmAHevZ4O9mvMF2WIQ0DF3o8AMbw/k9qGEJ
 3iQF7sIxdXKqRsnbYeTAxnW89yXU0n/WT5/SKOXku/EWvEe2IWyPfIbQLRFCGCq6ZEqN9g4VBgO+tw
 9YcacTpd7TdIkp6dBleP9//m4MTRXAC5ZIgaMrmeNj8CX/PcRg0lhNQ2wZF4anG7DfnZxLbMRD2kgv
 LbCxdCvIh8kiFR+M7QhRTSKsugEO+II7j96oOqLQowCXIBfsYmEw9K4LdHrAQnUwtza65xXB7YiiWi
 2fsfLCRG6TGQexgn/+IH1ZSYC/tB1pStkIZimhbXl5fpd9tDFZmWPaZv7HnFhxfbR6qY11+64IOZr0
 n6zKQ5vcMGlyNHBMPdkHaDprk1Kt+QJUx55dhlXZLxBX2o1lybH23vpz6r7Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The U-Boot Mailing-list is moving to the lists.u-boot-project.org
domain, so update all references of list.denx.de to the new
domain in the main README and MAINTAINERS files.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS                   | 2 +-
 README                        | 4 ++--
 tools/u_boot_pylib/gitutil.py | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af196465..a3777cafeee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2049,7 +2049,7 @@ F:	test/py/tests/test_xxd/
 
 THE REST
 M:	Tom Rini <trini@konsulko.com>
-L:	u-boot@lists.denx.de
+L:	u-boot@lists.u-boot-project.org
 Q:	http://patchwork.ozlabs.org/project/uboot/list/
 S:	Maintained
 T:	git https://source.denx.de/u-boot/u-boot.git
diff --git a/README b/README
index 5653f687e82..b7b5e7a4bad 100644
--- a/README
+++ b/README
@@ -45,9 +45,9 @@ Where to get help:
 
 In case you have questions about, problems with or contributions for
 U-Boot, you should send a message to the U-Boot mailing list at
-<u-boot@lists.denx.de>. There is also an archive of previous traffic
+<u-boot@lists.u-boot-project.org>. There is also an archive of previous traffic
 on the mailing list - please search the archive before asking FAQ's.
-Please see https://lists.denx.de/pipermail/u-boot and
+Please see https://lists.u-boot-project.org/pipermail/u-boot and
 https://marc.info/?l=u-boot
 
 Where to get source code:
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index 34b4dbb4839..59688aa7147 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -528,7 +528,7 @@ send --cc-cmd cc-fname" cover p1 p2'
                   "Please add something like this to a commit\n"
                   "Series-to: Fred Bloggs <f.blogs@napier.co.nz>\n"
                   "Or do something like this\n"
-                  "git config sendemail.to u-boot@lists.denx.de")
+                  "git config sendemail.to u-boot@lists.u-boot-project.org")
             return None
     cc = build_email_list(list(set(series.get('cc')) - set(series.get('to'))),
                           alias, '--cc', warn_on_error)

-- 
2.34.1

