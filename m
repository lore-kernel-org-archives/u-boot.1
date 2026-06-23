Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0CECDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 13:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EABA084A3C;
	Tue, 23 Jun 2026 15:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TQo1Riy4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31C2684A12; Tue, 23 Jun 2026 15:22:33 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96123849FB
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 15:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490cdae130cso28230955e9.0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782220950; x=1782825750; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ecMTmK/L8cz36AAEvUR1jVQZJaFux0cKAo92D86JUgs=;
 b=TQo1Riy4D4HhT17UnWEY8m68Hk2zcNBl9i9RTdWOiRxMkVn2o2hlMRG/t7AYJA4HLq
 d3pJZIfoRxXr/8APxkCAOUTjq+lHSEUpWaMvwiiy/S9ZztxPSVqWPEDrqVHBb7m1c/1z
 NNMx+X6iyffQT8YKoPKRn4C1ogGczvu2+ijKW22yuEWx+eVqP0A97wxUy9f30IxaCLJ7
 vqoMhQt7w3OiKcnZ64eHLoapvarY3kQUElVhMuwwLCLpl/LDPrN7ivnagbOMl9V6qH+f
 ke0PeUQ4DfuXvj2eLeLDcQU+ct5HVZDvRFVWUPKd7sRb0vWtkZEYeIUDhCVGkeItNnXr
 SaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782220950; x=1782825750;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ecMTmK/L8cz36AAEvUR1jVQZJaFux0cKAo92D86JUgs=;
 b=r7QhDe7dm1a6u16VuoG9EIx5TnK60jv8gB8YgFinXVR3pqIExAelJOr7SAwGLCxRkr
 CR8B0VwRXXmGt7EfymySfBNtjjcTMz2yuoEIs9gcXMtGY9drjqOjXz6vUtk1P7Hth9B7
 moUatagyb3YS++PZ2WFsNNb96RpDjf5vgerI8f+tvcNWBki4pEvvLxzRH62ijb5oqvTT
 iOoJ4lLhn8ThbzPUhfoF/QugDoUJcvQItIa1NVKsmTEjyPQEEbIBkTs6jq+jW7bzmXbk
 dCRZ5LuNeY4VhlLrFi+kvt4pNUWk4pmu+H+J7rpZ0bPfObrt7ZR0JRczMxpxqqUO7aqi
 bRlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oHbmGFHkkGkCbGHn0fwP/6aRSHl88dG6fXioz2g2nAecWswkROryCRm1VBFU/aCveeNAZHJI=@lists.denx.de
X-Gm-Message-State: AOJu0YwqudRDHwvxIIqRSSUm3cVYgvbZhfBbJXqXcxEdHeEThmLYtfgO
 jy95iIlAYipw7ZPJ0+G9A7dZuzBQWMCel00B5VaUwcmO5cZz5A45y1+w2V9d+cz+iyw=
X-Gm-Gg: AfdE7ckodHMAZg8CF+NFp+Gntwg6+8Ombik4CyrLPg8/74UeuPz84DPOlT9WtrWT/FK
 dYr0S7xJ7mwAC/UuFiB853+OoJstaJkmhhT/qUT/CJqnCJIup+uXroT1kyZoIIb+9DiQTSroQv4
 iLiBk50lX2FK6nK14M0494PaD3vXBYha7F3hfduVO87Wpu6571bvT474AwOOm50z3dNSUNfc9Ax
 JHQXaIvYYkTFTlzK2A04t7gn/WWU9LJmpxLS7WDx96L4ioTniPJj8gh3qtQhZ53U6Ys8hBdQd6d
 sF7B6BmDtPXIHM0hrse2frNmDMY1nrIWLbNHCA4od84E+ul7y+awS5Ia1P2FRgnTMYDGDw0MK8u
 YMZRn1d4q2STz8A9tV6AoELwVLaeURDqzN4A3+V/cCMNUfISCFva/QEcJ/UmaN2PgR6befTQCx0
 ae1MS6Wt2CBMGGfr5IGUN2M/d5GHw=
X-Received: by 2002:a05:600c:620f:b0:490:c024:2ec8 with SMTP id
 5b1f17b1804b1-4925b345230mr44821925e9.0.1782220949644; 
 Tue, 23 Jun 2026 06:22:29 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a712sm349965745e9.13.2026.06.23.06.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:22:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 23 Jun 2026 15:22:24 +0200
Subject: [PATCH RFC v2 1/4] tools/patman: Migrate mailing-list to
 lists.u-boot-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-osuosl-ml-switch-v2-1-28fd46e89e46@linaro.org>
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
 Neil Armstrong <neil.armstrong@linaro.org>, Wolfgang Denk <wd@denx.de>, 
 "Mike Frysinger <vapier@gentoo.org>, Fred Bloggs" <f.bloggs@napier.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9465;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vd7zFH1xQPDGDYqHYyO8o5l69Ceu6cV900F3iJtGyqs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqOoiQYkBtv+w0Xk5iVcaTaIHoNhtRAljbxeXl73v+
 4R+rzNaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCajqIkAAKCRB33NvayMhJ0W7ND/
 0Zayfcq9B79AI6li2/QmN/rLTAyiTTV6CGFpntJYEIHEC6lMhXuTfteZV9aiPJhWo+9Uh3KofjG7yM
 NOqPtfU2ARgvJQtm8Pu1y10j+Wfb6V/0jP/B12Y/y1JSI7m7w5CRWiUxJSQaEhgsT45Oexr1WbyD7N
 ajUYDEAuM91rT065RF9z7plD3Tp3kTAax8UnmZvhWhSS3iqjLEWmw/cNQxAH+6tyJzCsAWTUjM1t+H
 51fBef0SunXPLfMe3Yudip+bVYy8V4bKRhbe1FMaYOf5qujdROmNYRVVGuKcO4xzEEeXrWakKVs6fh
 lw2XmkUfnwj49OitfwC9RXDCOKXjyQPgqpR8xq4GTHCv8fiUa+luAk4cjEp8rYg9tZ8fLdmIBB+7jA
 6w/+TEr1N4kpde0Z9Yn3aa4w/Xiz6YyUk+ANy8LimlitB4X5yMYP8p6R8VkWzlVFxGL/CoCd9Pv2ao
 31rxPvg1tFFh2emR1y5HV3tkwWZj8R8oa9CAKtzExF/WG3X3s7YvS8ljw+zYiNOcz2RzxUrsCriFwY
 KFTBe1B3Z69KIAqHAJCGUd5XlnQtqTCNcNzbCCj3CXEBW0EmIFoBUu9UI0nhRBadA/JmwOy02ZzFv3
 29z5w33uHeXaAL1UaroKWMgFSrgcyxa84/lMlHJ5inZYf3te/z6FH/WkLTYA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Approved-At: Tue, 23 Jun 2026 15:23:02 +0200
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
domain, so update all references of the list.denx.de to the new
domain in the patman code.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 tools/patman/func_test.py       |  6 +++---
 tools/patman/patchwork.py       | 38 +++++++++++++++++++-------------------
 tools/patman/patman.rst         |  2 +-
 tools/patman/settings.py        |  2 +-
 tools/patman/test_checkpatch.py |  2 +-
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index d029181765c..3ed0e79d8d4 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -209,7 +209,7 @@ class TestFunctional(unittest.TestCase, TestCommon):
         count = 2
         alias = {
             'fdt': ['simon'],
-            'u-boot': ['u-boot@lists.denx.de'],
+            'u-boot': ['u-boot@lists.u-boot-project.org'],
             'simon': [self.leb],
             'fred': [self.fred],
             'joe': [self.joe],
@@ -256,7 +256,7 @@ class TestFunctional(unittest.TestCase, TestCommon):
                 prev = next(itr)
                 if 'Cc:' not in prev:
                     break
-        self.assertEqual('To:	  u-boot@lists.denx.de', prev)
+        self.assertEqual('To:	  u-boot@lists.u-boot-project.org', prev)
         self.assertEqual('Cc:	  %s' % stefan, next(itr))
         self.assertEqual('Version:  3', next(itr))
         self.assertEqual('Prefix:\t  RFC', next(itr))
@@ -269,7 +269,7 @@ class TestFunctional(unittest.TestCase, TestCommon):
         self.assertEqual('      Cc:  %s' % mel, next(itr))
         self.assertEqual('      Cc:  %s' % rick, next(itr))
         expected = ('Git command: git send-email --annotate '
-                    '--in-reply-to="%s" --to u-boot@lists.denx.de '
+                    '--in-reply-to="%s" --to u-boot@lists.u-boot-project.org '
                     '--cc "%s" --cc-cmd "%s send --cc-cmd %s" %s %s'
                     % (in_reply_to, stefan, sys.argv[0], cc_file, cover_fname,
                        ' '.join(args)))
diff --git a/tools/patman/patchwork.py b/tools/patman/patchwork.py
index d485648e467..70eb45a98a6 100644
--- a/tools/patman/patchwork.py
+++ b/tools/patman/patchwork.py
@@ -588,7 +588,7 @@ class Patchwork:
                 "mbox": "https://patchwork.ozlabs.org/series/446956/mbox/"
             comments: Web URL to comments: 'https://patchwork.ozlabs.org/api/covers/2054866/comments/'
             headers: dict: e.g.:
-                "Return-Path": "<u-boot-bounces@lists.denx.de>",
+                "Return-Path": "<u-boot-bounces@lists.u-boot-project.org>",
                 "X-Original-To": "incoming@patchwork.ozlabs.org",
                 "Delivered-To": "patchwork-incoming@legolas.ozlabs.org",
                 "Authentication-Results": [
@@ -598,13 +598,13 @@ class Patchwork:
  header.s=google header.b=dG8yqtoK;
 \tdkim-atps=neutral",
                     "legolas.ozlabs.org;
- spf=pass (sender SPF authorized) smtp.mailfrom=lists.denx.de
+ spf=pass (sender SPF authorized) smtp.mailfrom=lists.u-boot-project.org
  (client-ip=85.214.62.61; helo=phobos.denx.de;
- envelope-from=u-boot-bounces@lists.denx.de; receiver=patchwork.ozlabs.org)",
+ envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=patchwork.ozlabs.org)",
                     "phobos.denx.de;
  dmarc=pass (p=none dis=none) header.from=chromium.org",
                     "phobos.denx.de;
- spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de",
+ spf=pass smtp.mailfrom=u-boot-bounces@lists.u-boot-project.org",
                     "phobos.denx.de;
 \tdkim=pass (1024-bit key;
  unprotected) header.d=chromium.org header.i=@chromium.org
@@ -632,10 +632,10 @@ class Patchwork:
  (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
  (No client certificate requested)
  by phobos.denx.de (Postfix) with ESMTPS id 48AE281426
- for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:09:55 +0100 (CET)",
+ for <u-boot@lists.u-boot-project.org>; Tue,  4 Mar 2025 14:09:55 +0100 (CET)",
                     "by mail-io1-xd2e.google.com with SMTP id
  ca18e2360f4ac-85ae33109f6so128326139f.2
- for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:09:55 -0800 (PST)",
+ for <u-boot@lists.u-boot-project.org>; Tue, 04 Mar 2025 05:09:55 -0800 (PST)",
                     "from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
  [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
  ca18e2360f4ac-858753cd304sm287383839f.33.2025.03.04.05.09.49
@@ -649,7 +649,7 @@ class Patchwork:
  RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
  autolearn_force=no version=3.4.2",
                 "DKIM-Signature": "v=1; a=rsa-sha256; c=relaxed/relaxed;
- d=chromium.org; s=google; t=1741093792; x=1741698592; darn=lists.denx.de;
+ d=chromium.org; s=google; t=1741093792; x=1741698592; darn=lists.u-boot-project.org;
  h=content-transfer-encoding:mime-version:message-id:date:subject:cc
  :to:from:from:to:cc:subject:date:message-id:reply-to;
  bh=B2zsLws430/BEZfatNjeaNnrcxmYUstVjp1pSXgNQjc=;
@@ -683,7 +683,7 @@ class Patchwork:
  ca18e2360f4ac-85881fdba3amr1839428939f.13.1741093792636;
  Tue, 04 Mar 2025 05:09:52 -0800 (PST)",
                 "From": "Simon Glass <sjg@chromium.org>",
-                "To": "U-Boot Mailing List <u-boot@lists.denx.de>",
+                "To": "U-Boot Mailing List <u-boot@lists.u-boot-project.org>",
                 "Cc": "Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
  Alper Nebi Yasak <alpernebiyasak@gmail.com>,
  Brandon Maier <brandon.maier@collins.com>,
@@ -701,19 +701,19 @@ class Patchwork:
                 "X-Mailer": "git-send-email 2.43.0",
                 "MIME-Version": "1.0",
                 "Content-Transfer-Encoding": "8bit",
-                "X-BeenThere": "u-boot@lists.denx.de",
+                "X-BeenThere": "u-boot@lists.u-boot-project.org",
                 "X-Mailman-Version": "2.1.39",
                 "Precedence": "list",
-                "List-Id": "U-Boot discussion <u-boot.lists.denx.de>",
-                "List-Unsubscribe": "<https://lists.denx.de/options/u-boot>,
- <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>",
-                "List-Archive": "<https://lists.denx.de/pipermail/u-boot/>",
-                "List-Post": "<mailto:u-boot@lists.denx.de>",
-                "List-Help": "<mailto:u-boot-request@lists.denx.de?subject=help>",
-                "List-Subscribe": "<https://lists.denx.de/listinfo/u-boot>,
- <mailto:u-boot-request@lists.denx.de?subject=subscribe>",
-                "Errors-To": "u-boot-bounces@lists.denx.de",
-                "Sender": "\"U-Boot\" <u-boot-bounces@lists.denx.de>",
+                "List-Id": "U-Boot discussion <u-boot.lists.u-boot-project.org>",
+                "List-Unsubscribe": "<https://lists.u-boot-project.org/options/u-boot>,
+ <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>",
+                "List-Archive": "<https://lists.u-boot-project.org/pipermail/u-boot/>",
+                "List-Post": "<mailto:u-boot@lists.u-boot-project.org>",
+                "List-Help": "<mailto:u-boot-request@lists.u-boot-project.org?subject=help>",
+                "List-Subscribe": "<https://lists.u-boot-project.org/listinfo/u-boot>,
+ <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>",
+                "Errors-To": "u-boot-bounces@lists.u-boot-project.org",
+                "Sender": "\"U-Boot\" <u-boot-bounces@lists.u-boot-project.org>",
                 "X-Virus-Scanned": "clamav-milter 0.103.8 at phobos.denx.de",
                 "X-Virus-Status": "Clean"
             content (str): Email content, e.g. 'This series adds a cover-coverage check to CI for Binman. The iMX8 tests
diff --git a/tools/patman/patman.rst b/tools/patman/patman.rst
index 549e203c254..a3cf81e6e8b 100644
--- a/tools/patman/patman.rst
+++ b/tools/patman/patman.rst
@@ -110,7 +110,7 @@ To add your own, create a file `~/.patman` like this::
     [alias]
     me: Simon Glass <sjg@chromium.org>
 
-    u-boot: U-Boot Mailing List <u-boot@lists.denx.de>
+    u-boot: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
     wolfgang: Wolfgang Denk <wd@denx.de>
     others: Mike Frysinger <vapier@gentoo.org>, Fred Bloggs <f.bloggs@napier.net>
 
diff --git a/tools/patman/settings.py b/tools/patman/settings.py
index 17229e0d823..fe65b1d3fb7 100644
--- a/tools/patman/settings.py
+++ b/tools/patman/settings.py
@@ -162,7 +162,7 @@ class _ProjectConfigParser(ConfigParser.ConfigParser):
 def ReadGitAliases(fname):
     """Read a git alias file. This is in the form used by git:
 
-    alias uboot  u-boot@lists.denx.de
+    alias uboot  u-boot@lists.u-boot-project.org
     alias wd     Wolfgang Denk <wd@denx.de>
 
     Args:
diff --git a/tools/patman/test_checkpatch.py b/tools/patman/test_checkpatch.py
index b4722330f86..923a275c617 100644
--- a/tools/patman/test_checkpatch.py
+++ b/tools/patman/test_checkpatch.py
@@ -283,7 +283,7 @@ index b167b028ec..beb7dc634f 100644
 +
 +BOOTSTAGE
 +M:	Simon Glass <sjg@chromium.org>
-+L:	u-boot@lists.denx.de
++L:	u-boot@lists.u-boot-project.org
 +F:	common/bootstage.c
 diff --git a/common/bootstage.c b/common/bootstage.c
 new file mode 100644

-- 
2.34.1

