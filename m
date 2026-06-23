Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B199CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 13:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF2584A1C;
	Tue, 23 Jun 2026 15:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EB/trtTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B85F84A12; Tue, 23 Jun 2026 15:22:34 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE56B849ED
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 15:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-462ebd5d37dso5452639f8f.1
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782220951; x=1782825751; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VYNmjWpPAhh0gFibaskv9hjdYi7YHkAXw6SlV7B1i6A=;
 b=EB/trtTtqNHu5Grek/SBIZZaS9ACHEBmFTrDCn+YWPUZT3p9HbsMTSX5ZgRnILQWSH
 rmGY1CCBnAuMpd6Wne4+4sd/NLdmpe71lvbI+n7EeZ/FpYayUzEnCOd/PYHKIcb44jm5
 Y1IVSrTzGbu5gcDu+I2zKqDdCcDJ1kfn3muwr+S9Qd9oZqzBsGy4d6CSA00xTWsvoue/
 q9j9FGMVWBZwtKh/9oIZpjJjwsPZct5G3UEQXeEQjvHs3UXY5Xl37QeGiByxn3ObnT2z
 R8XiIkasT0bJUqETLP2jwTfOycGUos0YfLKa1TLyJVryHYDaaKT+J1kTPSqVpnMdoxWI
 EJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782220951; x=1782825751;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VYNmjWpPAhh0gFibaskv9hjdYi7YHkAXw6SlV7B1i6A=;
 b=oKlfE8ooSISbj5zRIBBvAR0uaaDyfyVWSVFjZ9nqDrGEBjbT3cyHv+kZZoKvSCuUq7
 wMuRr9FU5hQ85MuG8KS5VWywgKb+2xqeUG419L4WpaJlr6xYdVJ2MGIdVDjL/Th91K+n
 Aj6LqJTtIfUiqjyQ58DX7hhpcWau9BrpMBNcbL9xlLT0baa9lULkCu+vUTaFwZDXpSBT
 PP6IHEqKyRY9bwzqQfZWCEbdT7HSAKvhIN1jS4MDGp+2p1OGpYk6BxM0drebZnBlLkdZ
 D5TkJFbz5LZE4WL4gZ/ZJKURsjp5u3CfrIixKT4hZaZ1RqvlsYvpTsehUtEOr/fGQ3rq
 pBlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RC8CzEO2xVrfPbc2s2q2ZEDSYVZMDGNCLvABk8vXUju1Av5+ArKeDiZE/MZY2K2ABqj058jQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxuH73mfwYKA66rqzvgnr1IEXdv2fSD8MtxsXYOaV1VGnxhJMtz
 qn8Kc0EZi1RMmIHIo1Q/LxFBuYZy1CT/F0OUea4e2KGQpTkpbvJ5TdgEvuEDDYaEcDU=
X-Gm-Gg: AfdE7cnbVrgyB/n2PKX0OwQSWVG2uNGiIR5kXVO3WSUu93FrQNahBU9auczmtOseG2J
 bALPEo2F/upUmmCBqUwxohszshw1Q0XSac+g1JfWSE4YK/EhMS7VavZXRpOd1kb4JutmEfCf2Ua
 OtzE/CZJl33bmCUAcsZ/5gR8CLs0vOsje8KmzXyrPTJSBk2gpyfmRB9uPlZ1oAw/wAv+gHwPKPq
 mNQEGSFJM7uKGJEavO3aG9T+uTLF69GA79l4aaIQF/L1tuMr1UZBCGZt0Zrq27/buligozWzTsl
 apLIugUOp7305ArKz/4UYufhQ+tKWdPnhOzClokmfFsvz5hCwp2aonFX4IxD0BT/SOZruwjjKYR
 dZ+CE74QaU84rF8ZyOXZqI6TdZ9TBViuobDMsrsLwVWC0iIa2wl3BvGrHyPxIQ4IruXMkmqIULw
 RnL4xiDXEBh7pgJPQr9XEd2KQQQCE=
X-Received: by 2002:a05:600c:4503:b0:490:50c5:8153 with SMTP id
 5b1f17b1804b1-4925b3896ffmr41698355e9.2.1782220951096; 
 Tue, 23 Jun 2026 06:22:31 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a712sm349965745e9.13.2026.06.23.06.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:22:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 23 Jun 2026 15:22:25 +0200
Subject: [PATCH RFC v2 2/4] doc: Migrate mailing-list to
 lists.u-boot-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-osuosl-ml-switch-v2-2-28fd46e89e46@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8089;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GZ/msR8uc99Zxz2z2t7v11YHYQWYCExNT6n2J0AJsoM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqOoiRLcjzuJS/ZeeR/BHDRghj+27d6fjab+q9MrIC
 cQaGzZqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCajqIkQAKCRB33NvayMhJ0SrdEA
 C3p3uJoanWtUYZhuWI0F+uQIoluP1ZRKta5ZNJmf5ZhnIFn8xo3StyyQMLjAv4mw8d6CgInAis9lj3
 PR6puLhEbrSXwdAodavyemzEaUBkW3ZfEppVe85fuf+HNZZh5cL9J1Ag1L7kMsawnXIZ2omkr5QuOS
 U2PPQSr7ShYCnmSAq1uXXyaDL5liuyXAwz0rfrTA+zPK3QLND8dy8xkkSEzaNoKfNV/ThLFuDqCo6O
 1QtSvnxbklANpCoObZK2oIl/OG+71vGlXUXwVdvn6U1Pasu9irOzy0SWGM8rlM+7gWoppqGpEwW+ND
 USAJGX/31y+58f8mzDGukpNvxpa4FG4mGeE1QsLM43N4euA6c8NpK1UQXlq062gkqJNpBXJu0z0L1B
 h78co1Q4OkBuEPamdHIZwU/0toFmMjE/sFAkQcoKmyxCkpG3GW/RCVI7i/d0W9/8eQOW6gIPMb+84j
 BL4fMTyIzNZjQd+iE4/gTTp1dYvBvhY42shjWQ2/094t3kacaks4bXQD6B9+ldLDOXrg3OMui6zC6H
 6VdsSceoIwnZy3/AhJ+og4cSg1/08ip/yQE6w41cRhBjN04w7Rt5Ekpt+UsopnFmwyzgIFEKVj/U+a
 Su4q/KXgiBLI9/jfHHjmEeOHH5rfBGg3Mvd+cNMOBezr8mrvW+zLLc5YxA5Q==
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
domain in the documentation.

The URLs were manually updated since the mailman links don't
match anymore after the archive import in the new mailman instance.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 doc/CONTRIBUTE.rst                       | 2 +-
 doc/chromium/chainload.rst               | 4 ++--
 doc/develop/codingstyle.rst              | 4 ++--
 doc/develop/historical/generic_board.rst | 6 +++---
 doc/develop/security.rst                 | 2 +-
 doc/develop/sending_patches.rst          | 8 ++++----
 doc/git-mailrc                           | 2 +-
 doc/index.rst                            | 2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index a6e1cd1fb68..9777383f245 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -29,7 +29,7 @@ Contributions
 
 Contributions to the project are welcome. The U-Boot project uses a fairly
 traditional Linux style development work-flow using git and `a mailing list
-<https://lists.denx.de/listinfo/u-boot>`_.
+<https://lists.u-boot-project.org/listinfo/u-boot>`_.
 
 Patches should be sent to the mailing list using ``git send-email`` or the
 equivalent commands using ``b4`` or ``patman`` with appropriate sign-off and
diff --git a/doc/chromium/chainload.rst b/doc/chromium/chainload.rst
index b00ee94eaa4..c396073001e 100644
--- a/doc/chromium/chainload.rst
+++ b/doc/chromium/chainload.rst
@@ -42,9 +42,9 @@ Nyan-big
 
 Compiled based on information here::
 
-   https://lists.denx.de/pipermail/u-boot/2015-March/209530.html
+   https://lists.u-boot-project.org/pipermail/u-boot/2015-March/208951.html
    https://git.collabora.com/cgit/user/tomeu/u-boot.git/commit/?h=nyan-big
-   https://lists.denx.de/pipermail/u-boot/2017-May/289491.html
+   https://lists.u-boot-project.org/pipermail/u-boot/2017-May/288915.html
    https://github.com/chromeos-nvidia-androidtv/gnu-linux-on-acer-chromebook-13#copy-data-to-the-sd-card
 
 1. Build U-Boot
diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index 26881cf3900..a7230a0e364 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -29,7 +29,7 @@ The following rules apply:
 * Use the `b4 <https://b4.docs.kernel.org/en/latest/>`__ tool to prepare and
   send your patches. b4 has become the preferred tool to sending patches for many
   Linux kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` that
-  targets ``u-boot@lists.denx.de`` and integrates with ``scripts/get_maintainer.pl`` for
+  targets ``u-boot@lists.u-boot-project.org`` and integrates with ``scripts/get_maintainer.pl`` for
   recipient discovery.
 
   Start a topical series with ``b4 prep`` and keep the commits organised with
@@ -55,7 +55,7 @@ The following rules apply:
 
   When the series is ready, use ``b4 send``. Begin with ``--dry-run`` to review
   the generated emails and ``--reflect`` to copy yourself for records before
-  dispatching to ``u-boot@lists.denx.de``.
+  dispatching to ``u-boot@lists.u-boot-project.org``.
 
   .. code-block:: bash
 
diff --git a/doc/develop/historical/generic_board.rst b/doc/develop/historical/generic_board.rst
index 12550a140e0..bf4bb25cf92 100644
--- a/doc/develop/historical/generic_board.rst
+++ b/doc/develop/historical/generic_board.rst
@@ -64,17 +64,17 @@ separate function calls so that they can easily be included or excluded
 for a particular architecture. It also makes it easier to adopt Graeme's
 initcall proposal when it is ready.
 
-http://lists.denx.de/pipermail/u-boot/2012-January/114499.html
+http://lists.u-boot-project.org/pipermail/u-boot/2012-January/114135.html
 
 This series removes the dependency on generic relocation. So relocation
 happens as one big chunk and is still completely arch-specific. See the
 relocation series for a proposed solution to this for ARM:
 
-http://lists.denx.de/pipermail/u-boot/2011-December/112928.html
+http://lists.u-boot-project.org/pipermail/u-boot/2011-December/112165.html
 
 or Graeme's recent x86 series v2:
 
-http://lists.denx.de/pipermail/u-boot/2012-January/114467.html
+http://lists.u-boot-project.org/pipermail/u-boot/2012-January/114103.html
 
 Instead of moving over a whole architecture, this series takes the approach
 of simply enabling generic board support for an architecture. It is then up
diff --git a/doc/develop/security.rst b/doc/develop/security.rst
index 84b130646f3..ed652ec756e 100644
--- a/doc/develop/security.rst
+++ b/doc/develop/security.rst
@@ -11,7 +11,7 @@ Contact
 -------
 
 The preferred initial point of contact is to send email to
-`u-boot@lists.denx.de` and use `scripts/get_maintainers.pl` to also include any
+`u-boot@lists.u-boot-project.org` and use `scripts/get_maintainers.pl` to also include any
 relevant custodians. In addition, Tom Rini should be contacted at
 `trini@konsulko.com`.
 
diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index e29fa175727..4ac820ec78f 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -5,7 +5,7 @@ Sending patches
 
 *Before you begin* to implement any new ideas or concepts it is always a good
 idea to present your plans on the `U-Boot mailing list
-<https://lists.denx.de/listinfo/u-boot>`_. U-Boot supports a huge amount of
+<https://lists.u-boot-project.org/listinfo/u-boot>`_. U-Boot supports a huge amount of
 very different systems, and it is often impossible for the individual developer
 to oversee the consequences of a specific change to all architectures.
 Discussing concepts early can help you to avoid spending effort on code which,
@@ -29,8 +29,8 @@ See more details at :doc:`patman`.
 General Patch Submission Rules
 ------------------------------
 
-* All patches must be sent to the `u-boot@lists.denx.de
-  <https://lists.denx.de/listinfo/u-boot>`_ mailing list.
+* All patches must be sent to the `u-boot@lists.u-boot-project.org
+  <https://lists.u-boot-project.org/listinfo/u-boot>`_ mailing list.
 
 * If your patch affects the code maintained by one of the :ref:`custodians`, CC
   them when emailing your patch. The easiest way to make sure you don't forget
@@ -88,7 +88,7 @@ General Patch Submission Rules
   If you believe you need to use a mailing list for testing (instead of any
   regular mail address you own), we have a special test list for such purposes.
   It would be best to subscribe to the list for the duration of your tests to
-  avoid repeated moderation - see https://lists.denx.de/listinfo/test
+  avoid repeated moderation - see https://lists.u-boot-project.org/listinfo/test
 
 * Choose a meaningful Subject: - keep in mind that the Subject will also be
   visible as headline of your commit message. Make sure the subject does not
diff --git a/doc/git-mailrc b/doc/git-mailrc
index 65626d89eac..f0ba30a5c74 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -5,7 +5,7 @@
 # Then when sending patches, you can use:
 #	git send-email --to u-boot --cc i2c ...
 
-alias uboot  u-boot@lists.denx.de
+alias uboot  u-boot@lists.u-boot-project.org
 alias u-boot uboot
 
 # Maintainer aliases.  Use the same alias here as patchwork to keep
diff --git a/doc/index.rst b/doc/index.rst
index 5d732ff7a54..6fe8ca0788b 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -9,7 +9,7 @@ This is the top level of the U-Boot's documentation tree.  U-Boot
 documentation, like the U-Boot itself, is very much a work in progress;
 that is especially true as we work to integrate our many scattered
 documents into a coherent whole.  Please note that improvements to the
-documentation are welcome; join the U-Boot list at http://lists.denx.de
+documentation are welcome; join the U-Boot list at http://lists.u-boot-project.org
 if you want to help out.
 
 .. toctree::

-- 
2.34.1

