Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5DAC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 624BC82991;
	Mon, 20 Jul 2026 10:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AF4jMOyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2FA88488B; Mon, 20 Jul 2026 10:23:40 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD0884119
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso10537295e9.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784535818; x=1785140618; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mjX2gw/tmCw2WsmFg8xo3VlDlZJ9LFgCxMvEJoyPrjE=;
 b=AF4jMOyIK92MqdXvVczfSqLToeLd4b8HZtM0jmtviRZkZdaP8eR5KhhTg/jW0vk3SB
 etB+8AKSVMjxPT6gItMOEy4fziqLv03TT/uPZeOr4bJw4EHD449TurLpaWnyrIHBxr8s
 OwJQNR9ZX3LH/MghkjqS/oMOKZWZ9F7nyEmdGhcmSQEI/4Xesd/igQJrlVYkzgFppzMh
 JzpYtF/YCTxKypIeIeHdj8wzoqLZhkKU8dGottvqW6AAJEn5AE8floLnCEtMOOC1e1Tk
 cBx2ulEc1ideiX7Nnc6745tgDfv4kBo82ro+gIuq7RlkfsGj1J6B1sHFQG6PN5480ke+
 ogFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784535818; x=1785140618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mjX2gw/tmCw2WsmFg8xo3VlDlZJ9LFgCxMvEJoyPrjE=;
 b=UhAakmu4KXhrsqKNgzcydPcZ+13iNgeUuXgcj/6odz2Y04SrIDJGezbuVcKva0SVY5
 FOtzjdbP6Aw2smltTXBeoqAkC5HTX6LvqwF9hDTBqg+Wf4YKsllxEzknKThNmyjVL3t4
 kH/wr+/Qz3EyHSKHI0rEfCWKrMj1UBwG7C3wwgksPE9eGNeX/xHVK4Xgs7zfAGGj/iIK
 GfLeuuPSnUM1O9aa+pqLreZSgE7SZwaYc5ZElPyXQzZ1OCud41JgvnZTI0ifhyKsV8hC
 ycSkahYVRaG5h4RpTVYv3/GSfxVXSkVqmyheD8AgUe01Qh7UDy8dArJ1mMMQH5+gmzu5
 qqCA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcQBTDG25G9rEOLnRvwanEI4mSUtpHb+SMLa1W2joLW/tJcR+x2YwFina2NMBmVaVCLoCexAk=@lists.denx.de
X-Gm-Message-State: AOJu0YwbVm9hyioGUbT2MHSQ6eD/N1NnolWXotRmiK4sdJjDct1raRSN
 ILNdmbUTrf65eb4YHRKwJsuK4UvNPurSIkavcMguyAnktZzruVdjFX+nrWFZo3b78RQ=
X-Gm-Gg: AfdE7cme9fhvcZ2/ysnIilS5JENZGabsqFXrM9pOHe8sQWP4nt1s5KttvY1pnq87ft0
 d3c1NwRdJ75L4AsFCQx40kBnatdXwbq8bWSUfYuJj7Y0NCwQDftCYAAQXZlTmDgeW82KUhJyNl/
 E24LfGEpYWCzdY3yLrSkHXGcLFc34hF5yLf1qoKPHBMq0Jc6UZYWeBxnCAOZ2Db5z2fAW18IuYn
 KW0dv6wV+A3pkcEdHSlim6ykw/sc7dfat6F9J+qSxkSeuZVepzPJ1VYYJxAccS3hl8gEwtmVt5q
 g5AYcZOFP/KLFemcAgnSFrr4V7DxSL5Ulbl0jTxHOijLzgefu2v08oM2rZBmwasOB8VSWT8ipN5
 p3Jwo6Y40n6YxU6Mt/r00rrveo9wAljshdbkd8WTxwogjyXX3itKTaxJo4rekbelAEVPOiSmcAZ
 nya0Jl+VO3WBXB6UzKra/gVNIEi4Y1M1plog==
X-Received: by 2002:a05:600c:41ca:b0:495:21e7:fd53 with SMTP id
 5b1f17b1804b1-4954a50dacfmr100868475e9.18.1784535817612; 
 Mon, 20 Jul 2026 01:23:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c9c940sm242852495e9.13.2026.07.20.01.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:23:37 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 20 Jul 2026 10:23:30 +0200
Subject: [PATCH v4 2/3] doc: Migrate mailing-list to lists.u-boot-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-osuosl-ml-switch-v4-2-20ec1c334dd2@linaro.org>
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
In-Reply-To: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
To: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Heiko Stuebner <heiko@sntech.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6282;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=yXr53xV0S+G6+3WWz/StHKCtL4nDWqLl5EFXWV/eiZE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqXdsEZKUc6c5ADNU0oBd5KnuGk7hgEm0CKoQ6jMqp
 bJCeY2GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCal3bBAAKCRB33NvayMhJ0QGsD/
 kBghKzktVxfnN2bMIIIB72/teLyHF2YRTyZURewtF1LLTzS1UZDSh1cGD/fPxQKmyFd9Ek5/h39CVO
 WhgwV48lbEvi75xQIHLi+4iFLcqiLhMV0VpD6I+CbFWQsGsfmyLn5cdWs8e14wlG4RZeSFC8H+sp5y
 Jncw7GC57JsTKagMN1A6e0cnY7ESiHGEmbWtNqdNS3YYtpoIgexzPS7aWMT3np+W9fHZNufP1nK0dP
 Ssd92ezhLkK7EeOAa65OERaarZV8rqOWMGn7S1U890ZigMA+xoNIU5HnAq7HRcgCba33I+EDioZkMQ
 LW6KhwDgvZ61R9wTX9DppYx6dQbuuA+KBNBt1O8qI4XV+HgUqUG1HSkgnO5Orh26sDs1Lf8v+udkiT
 fU35wHQsq6N2RyTN3ZREStbPsWBAITpKauRNzmolgQ6CZmeQ8uYj//B5OdYx+3Bd1/HX8iF5nltV/a
 Y8qs2bXlGdm5VU8VNTB5WYrnIoropekfG0EARi0MM4MrhTw0F8zHRm0+QwSMBQdQTJkiadK5hq1TN0
 5JnkD56ggWA8HyU0YaHsluyTL9y8fQlZj5tTrbwiDbqKHBTi0MmxGCioZubqRhdm0mwIo4R4ZJ6Rok
 wzTqdal0+OzKZElI72LaaTbm82cF3/1cehv+KMZAoUZkiyrZX5gP9B4UsS4g==
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 doc/CONTRIBUTE.rst              |  4 ++--
 doc/develop/security.rst        |  2 +-
 doc/develop/sending_patches.rst | 12 ++++++------
 doc/git-mailrc                  |  2 +-
 doc/index.rst                   |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index e8fa595ed4a..8494315254e 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -28,7 +28,7 @@ Contributions
 
 Contributions to the project are welcome. The U-Boot project uses a fairly
 traditional Linux style development work-flow using git and `a mailing list
-<https://lists.denx.de/listinfo/u-boot>`_.
+<https://lists.u-boot-project.org/listinfo/u-boot>`_.
 
 Patches should be sent to the mailing list using ``git send-email`` or the
 equivalent commands using ``b4`` or ``patman`` with appropriate sign-off and
@@ -41,7 +41,7 @@ The b4 tool automates a number of components mentioned above.
 Code is not the only thing you can contribute to the project. As most
 open-source projects, the U-Boot project suffers from a lack of reviewers.
 Consider spending some time reading patches on `the mailing list archive
-<https://lists.denx.de/pipermail/u-boot/>`_ and providing feedback to
+<https://lists.u-boot-project.org/pipermail/u-boot/>`_ and providing feedback to
 contributors when something could be improved or if you have questions. Contrary
 to what's most often believed, you do not need to be an expert to review patches
 and the project will benefit from people with different skillsets and experience
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
index c3e0ef27824..768c8375cf4 100644
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
@@ -25,7 +25,7 @@ Using b4
 Use the `b4 <https://b4.docs.kernel.org/en/latest/>`__ tool to prepare and send
 your patches. b4 has become the preferred tool to sending patches for many Linux
 kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` that
-targets ``u-boot@lists.denx.de`` and integrates with ``scripts/get_maintainer.pl``
+targets ``u-boot@lists.u-boot-project.org`` and integrates with ``scripts/get_maintainer.pl``
 for recipient discovery.
 
 Start a topical series with ``b4 prep`` and keep the commits organised with
@@ -51,7 +51,7 @@ additional runs.
 
 When the series is ready, use ``b4 send``. Begin with ``--dry-run`` to review the
 generated emails and ``--reflect`` to copy yourself for records before
-dispatching to ``u-boot@lists.denx.de``.
+dispatching to ``u-boot@lists.u-boot-project.org``.
 
 .. code-block:: bash
 
@@ -86,8 +86,8 @@ patman now lives outside the U-Boot tree; install it with
 General Patch Submission Rules
 ------------------------------
 
-* All patches must be sent to the `u-boot@lists.denx.de
-  <https://lists.denx.de/listinfo/u-boot>`_ mailing list.
+* All patches must be sent to the `u-boot@lists.u-boot-project.org
+  <https://lists.u-boot-project.org/listinfo/u-boot>`_ mailing list.
 
 * If your patch affects the code maintained by one of the :ref:`custodians`, CC
   them when emailing your patch. The easiest way to make sure you don't forget
@@ -145,7 +145,7 @@ General Patch Submission Rules
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

