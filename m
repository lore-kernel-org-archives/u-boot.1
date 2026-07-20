Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D939C4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 119AC80BE7;
	Mon, 20 Jul 2026 08:23:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4gnMFzGIIW6s; Mon, 20 Jul 2026 08:23:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7A4280BC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784535822;
	bh=mjX2gw/tmCw2WsmFg8xo3VlDlZJ9LFgCxMvEJoyPrjE=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZxSl70YMHi0CFFwtiXTP7SJK7UnNHzlE7v7CKqeTUgFI+7bun0rEIW/7nouLy0bc2
	 LlNR8Kq+1hshPS0qaRx+F6DwFNOMp2gLPY0qXZ20+knYK0app/jDTH9MObZL5YltCz
	 csX4dCplOQ1vCzIK/rJTRymzcJSeHuImO0oE7aU02Hq9N1PAzQutqu4hOgOi77NErc
	 QpLO7HXWjGLVpRI0psuqdyKJad8ke2h3WxGvLvXKloGrD9ojadP3djWLvz2AXbihmb
	 xlGeA/GFefKGwCFfLM35deThPgm8+bVi95F1GxH3NlAz7OPKW3L55TqwUhfDAP3vFR
	 TLLjva4QVDKyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7A4280BC4;
	Mon, 20 Jul 2026 08:23:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 66164282
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57C2A80BC4
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:23:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lUrgYiI_2Xlh for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 08:23:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 04A9680A88
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04A9680A88
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04A9680A88
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:23:39 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso8687215e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 01:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784535818; x=1785140618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mjX2gw/tmCw2WsmFg8xo3VlDlZJ9LFgCxMvEJoyPrjE=;
 b=b7Df+hoUfSf8SqnmTh3+eNKfK3ROUzurDs9lrsxATh0RAriCqiZmj4gGiwa7IYEhn6
 UeB9BFgFFrN9Uh0dLfjO5jr+bQxNTLQns1+R0Zyec8AlqCrT9F0spQESw3qu/Pfbqc/M
 POxKJYUe7hcJt/f6o/ocRWGjxrh7AAx1StLU1r1mAiLhlKLmZgmE7iJfkOuc9+r4PKDm
 8RexXXYPEtsmIqg7/XfEmg9dF1Hcg4Xx7kK0sdcnh4PBW69aQIg5YoIOyV8ScfmyZUPb
 SJeXMVmVcoYIQTrbzb/QB8yOHA5LzHIw+XLJ2+fpf4EO13KONVAcR7LU90/X/fY0VOd3
 aoDw==
X-Gm-Message-State: AOJu0Yz7bUGvdvZskCb6xHbDloj6oEPpSg//RskcS01kpR5PRXbgmb1H
 zI8DDNmmyXe0QptfmeYMqPJEt82npgoDScAiu+XDapmkMn0nO90dk9wSNzMKqmf8FHM=
X-Gm-Gg: AfdE7cki1aB1MrGcNkyhDCQfC2VO8ZsRKZrFhC32OxyfmDeN3KkSROHG0SIlL/d6D/b
 m0vzal5DaSDgqL/mhPpiCbUkk8RFFp9poVqnP9tsBxNq0XqH0GRdUoBJXu/XUjGIDj31zqLkcWb
 37U+mhtkyUcmuvBH1PzbPsIYZq7TgsB0hu8E8JRto6XTy2dwgT2N0TD6DrvCIWsATFheg9Lc4NP
 yImRFGi2vmPDpMjJz4V8e/A3EFvFwW1s/K0qRC5wL0EDcEaJiZ4WNVU3jqXlW6GCj2ppXgORW6S
 ZN3POvobI1GXbGHhbUOp7h4TxdhJD1YOwpOzoDxInvWP5A/94C8+R3WqYve1R0vr5VABc8l9le1
 x6Nh/514qndWHbZniCzgtb/zpzpVMyWnBfDmnr2htjlIyWzEIrGG2tXP+gJLRZpQIez0lyfO1KE
 IiSP4OedORZWdMp51bPjl2aP45tYvjGqvbuQ==
X-Received: by 2002:a05:600c:41ca:b0:495:21e7:fd53 with SMTP id
 5b1f17b1804b1-4954a50dacfmr100868475e9.18.1784535817612; 
 Mon, 20 Jul 2026 01:23:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c9c940sm242852495e9.13.2026.07.20.01.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:23:37 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:23:30 +0200
Subject: [PATCH v4 2/3] doc: Migrate mailing-list to lists.u-boot-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260720-osuosl-ml-switch-v4-2-20ec1c334dd2@linaro.org>
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
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784535818; x=1785140618;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mjX2gw/tmCw2WsmFg8xo3VlDlZJ9LFgCxMvEJoyPrjE=;
 b=YZg3Jmj7OgR9n+tqaYoR244AZpUAT055LJZyQjF6MdsZyfjb/PJzLkv5WPD+yT11gy
 mpzPOFH+khcLT9iHi0oC17yZgdX1rIvJH/iLgtOzYaClJXwwkvBqiAfd2Z+bZeX0m7m1
 32/kqQHxJBQTWDWOeqvhTfbqMpkWIWAmJSiuE1/8X7nv4i6gS8/uo2hQfBuDIQkq1+dV
 19bgqytq4hNBND09wyoC2Fb1eVUGEokg5K8Kg+dakyrt584Hz7peStv5ybdivQMIe3Qb
 H4l/espmM6qBkEqIY6w6TEcM3hK944g6QPakg8Mv/7PsADgRVsKFpoV19CkSaHzLw4oz
 5W1w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=YZg3Jmj7
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
From: Neil Armstrong via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>
Message-ID: <20260720082330.zJcDE7qVLW2aJP_wcmHZ732HWPh1Qbm71F2vGNfKmsg@z>

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

