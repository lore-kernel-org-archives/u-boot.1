Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66397C44501
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 15:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CAC584BEE;
	Mon, 13 Jul 2026 17:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jWcbMe75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B628E84C63; Mon, 13 Jul 2026 17:57:05 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D35284C13
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 17:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso2204884f8f.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783958221; x=1784563021; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+mORYxeppZay9OcryMgYtP3wAr5q3iJmYYvymDWeHsA=;
 b=jWcbMe758v1onibOGmoutIiOXNf/FwqyGkbLkrSrQojRR3yU3t9ep/SCGb+cJXMe9T
 HsPR7vpf9jqWQTgm5XsWxy0kNwCrXpX7murzEQCI4RNByhY/czjQSlLTfixDMJApzNx/
 slmtiDZ5r7EqRMVfb2lS44DhNNecYl1QF6IXodcjURGEebFV6qNwitpinhylnKlt1ydx
 8UKArDXIFO5oqJMql5ATxVbi/ccCBIurckpVmA357KHK4oFpZMpcf2odKbuvh7AH0xJp
 7egKzFHsmxBZkMIgBfa/Xn6ZKD6M+g1D8vcARnDPSPG9DmYJoT8muyzDP6jdEi9Qn6tJ
 I0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783958221; x=1784563021;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+mORYxeppZay9OcryMgYtP3wAr5q3iJmYYvymDWeHsA=;
 b=tCyioIbyFBfU6Hk7lBoDFWutaAyxinKF+PK2BQaLLZyg0lWnO7oAScqoVN0U9O+oeB
 kjK35efjjXPrfCOFthvc4K+BoJTZe17P//aaULZtNDSCTn66MMja+BK3ZQq5f8c1/R4c
 uCNdc9Pn81y0c3mbSt6YYDjBm6tPgx9nf28EIJiA3MnRKe7hcIyoJXKSWy50I1yev61b
 kH3TqnYerVUmAsrN3xjtquVz5V9N5d1YUivxA3K6zahaKT5DD86qHL1vtye2lSTJjQWz
 mhi0w62Q4MfBVWH7KuHlnSAmCBmHRJ84cfz1lwDwdMCQfLSyf2aawpurqNPV+X4s2zJB
 rEbA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/QT2kWZhbA91PEBl2DAkvADrZ6/zN6C0WMe+obkqsGR6JR7YFANdFndsfx/xJ8Rs7pKHqpns=@lists.denx.de
X-Gm-Message-State: AOJu0Yzn4VrGEBeNencwXuRNJQoa0mGU/aWMmzplLnIHYuZd+k+iZjl0
 uPrb44i4AFxhMbZDaw3lTHnjSCUjOp8fIZjcXBFudZGmeN2NswlLS1psGgFNtwyipkc=
X-Gm-Gg: AfdE7cld8gsBeiWRTrP0b1dF3264z52FHZAz9Q7zDAie/2Zu/awj/noj+IOrQnmyLuU
 5RBMRwnJVl1EnzrrQ7k9zj90HjKrnEQo0sKXh2fZTqV2fmxca5oDnwPpQYAd7sRu2uVaBS6pBgc
 Bo3RAPIjzqh6kevU+0nC4VM1hSnYeqBTFAIqupzrXSGFe5eawdyy0P4Fa61jC6TBAfq3lJuLTjA
 /H1TXEYlx6JxOVwTT+oiGpAjIq67YNy16qX9bFss8SMJ/Bvxxef1S3VB8gqXgGru4jKyEuGMoWz
 gqZ1VJI74LVYX2LgCL3Y+JOzUQOwOQpWE00lR4mab0tWv5cmlSQwM+/cr+b0rE08yyahZ3tp2lv
 kquJCbXe7PPkrSUouFNh/QcsHf5dMAQ7TrqGAB0XnhX3vCsVDEngwdhw2P68bMfhpbDHzduPuCF
 /j2vtWP5TZhYYXzp5L/1augbHnZb7Yr5QPTg==
X-Received: by 2002:a05:6000:2010:b0:460:71e6:e3b with SMTP id
 ffacd0b85a97d-47f4634deafmr372631f8f.27.1783958221261; 
 Mon, 13 Jul 2026 08:57:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634debesm352946f8f.8.2026.07.13.08.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:57:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 13 Jul 2026 17:56:56 +0200
Subject: [PATCH RFC v3 2/3] doc: Migrate mailing-list to
 lists.u-boot-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-osuosl-ml-switch-v3-2-48b71dec1a23@linaro.org>
References: <20260713-osuosl-ml-switch-v3-0-48b71dec1a23@linaro.org>
In-Reply-To: <20260713-osuosl-ml-switch-v3-0-48b71dec1a23@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5526;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4RgQSm57SJtmqweaLQjsT/h5zcvE52EDGkRxQN4BHnE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqVQrIrsYiupiK2aU2ywTClGHDVZkAu12lfEilzP9N
 J/oAhsOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCalUKyAAKCRB33NvayMhJ0VYTD/
 4kFH5vvNpaqUjtCr7sNh4zfK9rE75x2IWHd7Hk4RP6iqFpA03tSng8ICpHz20ieFM61Zco6/dNEgkT
 faIZkXQqlMYuybIgaZjKsJU9Plco9gOhBuw37Gbc7S6sokapw0qmHn6Cl6RfYOj+SuxU+b6Z7dtm19
 a1FZ78/VTJjmN4B4o8r5gDoeUIV0a27VtAHFMPt3aNX+OhfOYqzynif3wxJ5+oknoTneNC0gfW5MdJ
 v2AKSzFabJvOVCW3t1mroi5NX4ZYktzWgqPA4ugfBlBPd7arw3xiXEiT8s2XCsT/zO5x9Nv0lPhAg5
 Q0H+iguTP8q3SMPAsypa+/zxaFVy0Yh72racKEVuwasS0TQCllcxYTvWVcYgNGBEU4Ybk2IbFI8PMi
 ywcZSYsA3pUg0W+/gDNk3BSmHAXQ+yAZ2jZDTQwlf9wwFMKitO45t3DtAta6PKJxCvwQrR1f+1oXrR
 EUa/5PmjDPWUdJezD5+0TS7qVFFs6DVXw0kAUN6hCAAwJKhkHzvRM10VsIsFQjQA2d/39z5K6M1E0Z
 vR8fxlXlbhknDm2eWqZE8K/QTfcGjlcYN/KJ+ob+qj9slRBLFR8BWQpJfM7vPLghob32bj7OOAn9Nf
 cIft0fw12yjkU3upKlIWckmGRVt3C21V+aZllVEZfjHF1FIjnOov7smq9pdg==
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

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 doc/CONTRIBUTE.rst              |  2 +-
 doc/develop/security.rst        |  2 +-
 doc/develop/sending_patches.rst | 12 ++++++------
 doc/git-mailrc                  |  2 +-
 doc/index.rst                   |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

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

