Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A242C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57C2E80A9F;
	Mon, 20 Jul 2026 08:34:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iFa9yBXNcD7a; Mon, 20 Jul 2026 08:34:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16C7280A78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784536478;
	bh=eOOLWUu7m0Ephr6DI2kcTVjwA66tRBH4U1+vK8nGexs=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dRmK7bmWuHqhG99U8vGrBSkOsererKUzU4XKYQqZH8IhAc5cIx00oomkC7iCteF4A
	 DdABLV5D2g4aSxtiPZfoHDhW/NouXtxr6zaCBId9/+axp2Cz53687VPtxiww/+o8+O
	 iSaJ33aBFReXSevlETeddbF3Kym1fGqsROumc9yqIiR0Ysxu3nhuAXdGbX1bVy6LNn
	 6WauS7LxX/sW/IFYOgwOKARr4fL6oAuMjMeS3rVZPmyjt1VhCbzcv8wakQuQB6WeMS
	 JgzEoQ6VhTcz+Pjl5wOxaUhHKKuChz3OwXNlPwOXH5OCmQRhwNHK4D8i54qlK9/Obs
	 /aXwd3spF0YVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16C7280A78;
	Mon, 20 Jul 2026 08:34:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 99C5E206
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8AC8A80A78
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ALKkeYUEFuKd for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 08:34:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 599568099D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 599568099D
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 599568099D
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 08:34:35 +0000 (UTC)
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-90327237340so35728676d6.1
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 01:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784536474; cv=none;
 d=google.com; s=arc-20260327;
 b=cKHFxH6HQPNH8lYhJL6icRmCdUqDxCjPirZqZsThqkZHHcy4Bs6atlHeKNosu1/9ax
 G+yEMTrdkitvKlYootbSjSHfqPkKxVqcasXERseBCpKKlGQdCQSNkRQB/IDx4f3v28fd
 JgH48bp+CIKntiecJcewirP3PQ+1R/XxGTECvKW32/pFJ/h4sl964xG9HvbZdTMnEHOC
 vGBhIY29fXGVq/chvqv8vkJD40Ieg+MhSWoLdzqndSlID4VlQcVSqTybcNYRdfYs4f51
 dssdOXcaP3AU0RFOLLdsbrPHkItZS1IZUlcXRRXSzCiwRwFmEuZoocUBclSCw0BgTtVS
 DACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eOOLWUu7m0Ephr6DI2kcTVjwA66tRBH4U1+vK8nGexs=;
 fh=FJNocD74GKmrEzZRCbawol6icJDV3ilG/7+czrr1PBo=;
 b=E+/KlbNd/n9sfbR/nX4u/ASFER7E0/2Vf14tluakVFF8iV4sXxv+waN/Vvj47KdAXJ
 OPOOmip10dNC88/z4rKQ7tv2lgG5t0/8skg8Et0Zbb4YGjPvojwSxLOTuGMA+TGlDO3y
 gFinJo8tTEWq4c/olE92DUke9/nug/G6d7Nla0wcQtjKtsdPWqD+mLwfiZCDMbceZ0EI
 vx9g9q2SQP8iQYrEJ4vwmW7K0hVUQseyBOTwYIaAs5gqjoENqUaT+6OlhyG9beckoi8V
 qvR+ZuItaIZF+pE/ycfriTGFnihomNn0/KMh00wr5aV4xRmHWLV4nSZq5N5O3yMTejpk
 KHAA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536474; x=1785141274;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eOOLWUu7m0Ephr6DI2kcTVjwA66tRBH4U1+vK8nGexs=;
 b=fF3Q1HX2Xz9mZ0best5PNRFQiDyw5RCFQkfMieAH5xaAimxUHfjogxiDvNbbajb3RP
 ANfg1JXJED7GQODbUJ6zEeoAriInH7z/c+7K+Zj2lS6WMX4Dbzyx+qUwDjGm301k5POA
 l33i97JPyj8OdwqtAThpAjxVj5u2WLiqok/mwEjz65GaFGRNYI2zVQtICh+hOlZQKEwY
 VBxQiJqZmttYae1T6oIhcXtk2+9TksJw0p7WZD8hRA8jYPcBl7Ru6U83pK2dC+RoyAro
 /JwA2EL+mSMwJf07LcjD7NNrSoEpsPM+sGvUafAABnc73x4A9MqIPbu1g8zUt+IB3fZJ
 iqew==
X-Gm-Message-State: AOJu0YxcV2abITbyxlEUFNySCCDxJ3t3fEdt8VyLMuFC4woQtUYxXlnP
 f0eu2UUiea74UicJ+ib2kWXfCZDNJuaKbdLlhbR2j7XuOA+ROVrMU0kIXPmuqyl71M8MfKo82AX
 ajMDJqfmQ6pFSZgdDAS7RHM0NSCLAZG8=
X-Gm-Gg: AfdE7cki2HUotwXb4+NgDmYSau8Z5vzJruvXsllFltYbiKVPlyg6R7hQ6dvc1m1ZRKg
 KdrJXlQEIDg3sayABc1dkNexR0D/mqfdPWgcpB8iehIxdSloC+LdlStdp772KuhvqhPt3577jK0
 Xvt6+UmWQepdmyeu1QXlUUMPb2o9rAufRQXwdYCZVt/A7FKoUdYP+gfyMuTQCbfzSm2vpF8y/Ul
 GWJO1M7jBEl65leYUO/gBAtRR1IjYnDH4P8f0r1g8hUSzgYg1LANe5uZCkSxtSDxNka3IQjGnvD
 WYP5yiN/PTuFcCxkLnmTN60HRv+kJEX/xEM9GmSPppLZHurfCuHUhRJpCuAR9FySYfdjO971xGJ
 GZgrg/FLScrlKe6izQSKJPqTSHDViajNbGQoKlZNG0TjlaojR5AtHCsk3
X-Received: by 2002:a05:6214:23c8:b0:8dd:2260:70df with SMTP id
 6a1803df08f44-907787c4777mr120429036d6.6.1784536473943; Mon, 20 Jul 2026
 01:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
 <20260720-osuosl-ml-switch-v4-2-20ec1c334dd2@linaro.org>
In-Reply-To: <20260720-osuosl-ml-switch-v4-2-20ec1c334dd2@linaro.org>
Date: Mon, 20 Jul 2026 09:34:21 +0100
X-Gm-Features: AUfX_mygyK2a_CTMRVCd09EpnYsoJimV__Vj_E43GtEVGXLdG7QtWHYWPGKYWe0
Message-ID: <CALeDE9PzEPejh4ojSqGHzXYBFCLMgcCW=VomxWRCQHSSibHTtA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] doc: Migrate mailing-list to
 lists.u-boot-project.org
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Schocher <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Quentin Schulz <u-boot@0leil.net>,
 Heiko Stuebner <heiko@sntech.de>, David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784536474; x=1785141274;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eOOLWUu7m0Ephr6DI2kcTVjwA66tRBH4U1+vK8nGexs=;
 b=q6N2XsMEiFWST3SU9aFpk3IwAh3sEFCxeFK7MjkpHIzZ7C3/xzPafgErATN2WJi41e
 g3ddeCLZP566Kk5PZ/44AAG/rQqbZvKYsoCxXbTYpfbruTbb9ufenNWV3gv/UyZS19QF
 Y37YKmjzwN7guHKvipSzmT4bIjypU+epcsHzvphBpVFx8l5eO0oFiBdKNDFdLVehlqAw
 ZbAP9CnqeuJMi0D9gY3G2SShicitRjBgD3uzBzGycBeQlI/cCq/vlCBuIdLRABTy28hP
 neHV2U4kw7ZVI1AGSkVjRT1aB5ozQe0aPqtzdofV29+2ACO1fiwlzJOmvXmnUdLuvY3z
 iJ8w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=q6N2XsME
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
From: Peter Robinson via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Peter Robinson <pbrobinson@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>
Message-ID: <20260720083421.vV-lw14k-u39P7kEZze6EtMIKd1zvZ41WP-S5rB65p4@z>

On Mon, 20 Jul 2026 at 09:23, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> The U-Boot Mailing-list is moving to the lists.u-boot-project.org
> domain, so update all references of list.denx.de to the new
> domain in the documentation.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  doc/CONTRIBUTE.rst              |  4 ++--
>  doc/develop/security.rst        |  2 +-
>  doc/develop/sending_patches.rst | 12 ++++++------
>  doc/git-mailrc                  |  2 +-
>  doc/index.rst                   |  2 +-
>  5 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
> index e8fa595ed4a..8494315254e 100644
> --- a/doc/CONTRIBUTE.rst
> +++ b/doc/CONTRIBUTE.rst
> @@ -28,7 +28,7 @@ Contributions
>
>  Contributions to the project are welcome. The U-Boot project uses a fairly
>  traditional Linux style development work-flow using git and `a mailing list
> -<https://lists.denx.de/listinfo/u-boot>`_.
> +<https://lists.u-boot-project.org/listinfo/u-boot>`_.
>
>  Patches should be sent to the mailing list using ``git send-email`` or the
>  equivalent commands using ``b4`` or ``patman`` with appropriate sign-off and
> @@ -41,7 +41,7 @@ The b4 tool automates a number of components mentioned above.
>  Code is not the only thing you can contribute to the project. As most
>  open-source projects, the U-Boot project suffers from a lack of reviewers.
>  Consider spending some time reading patches on `the mailing list archive
> -<https://lists.denx.de/pipermail/u-boot/>`_ and providing feedback to
> +<https://lists.u-boot-project.org/pipermail/u-boot/>`_ and providing feedback to
>  contributors when something could be improved or if you have questions. Contrary
>  to what's most often believed, you do not need to be an expert to review patches
>  and the project will benefit from people with different skillsets and experience
> diff --git a/doc/develop/security.rst b/doc/develop/security.rst
> index 84b130646f3..ed652ec756e 100644
> --- a/doc/develop/security.rst
> +++ b/doc/develop/security.rst
> @@ -11,7 +11,7 @@ Contact
>  -------
>
>  The preferred initial point of contact is to send email to
> -`u-boot@lists.denx.de` and use `scripts/get_maintainers.pl` to also include any
> +`u-boot@lists.u-boot-project.org` and use `scripts/get_maintainers.pl` to also include any
>  relevant custodians. In addition, Tom Rini should be contacted at
>  `trini@konsulko.com`.
>
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
> index c3e0ef27824..768c8375cf4 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -5,7 +5,7 @@ Sending patches
>
>  *Before you begin* to implement any new ideas or concepts it is always a good
>  idea to present your plans on the `U-Boot mailing list
> -<https://lists.denx.de/listinfo/u-boot>`_. U-Boot supports a huge amount of
> +<https://lists.u-boot-project.org/listinfo/u-boot>`_. U-Boot supports a huge amount of
>  very different systems, and it is often impossible for the individual developer
>  to oversee the consequences of a specific change to all architectures.
>  Discussing concepts early can help you to avoid spending effort on code which,
> @@ -25,7 +25,7 @@ Using b4
>  Use the `b4 <https://b4.docs.kernel.org/en/latest/>`__ tool to prepare and send
>  your patches. b4 has become the preferred tool to sending patches for many Linux
>  kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` that
> -targets ``u-boot@lists.denx.de`` and integrates with ``scripts/get_maintainer.pl``
> +targets ``u-boot@lists.u-boot-project.org`` and integrates with ``scripts/get_maintainer.pl``
>  for recipient discovery.
>
>  Start a topical series with ``b4 prep`` and keep the commits organised with
> @@ -51,7 +51,7 @@ additional runs.
>
>  When the series is ready, use ``b4 send``. Begin with ``--dry-run`` to review the
>  generated emails and ``--reflect`` to copy yourself for records before
> -dispatching to ``u-boot@lists.denx.de``.
> +dispatching to ``u-boot@lists.u-boot-project.org``.
>
>  .. code-block:: bash
>
> @@ -86,8 +86,8 @@ patman now lives outside the U-Boot tree; install it with
>  General Patch Submission Rules
>  ------------------------------
>
> -* All patches must be sent to the `u-boot@lists.denx.de
> -  <https://lists.denx.de/listinfo/u-boot>`_ mailing list.
> +* All patches must be sent to the `u-boot@lists.u-boot-project.org
> +  <https://lists.u-boot-project.org/listinfo/u-boot>`_ mailing list.
>
>  * If your patch affects the code maintained by one of the :ref:`custodians`, CC
>    them when emailing your patch. The easiest way to make sure you don't forget
> @@ -145,7 +145,7 @@ General Patch Submission Rules
>    If you believe you need to use a mailing list for testing (instead of any
>    regular mail address you own), we have a special test list for such purposes.
>    It would be best to subscribe to the list for the duration of your tests to
> -  avoid repeated moderation - see https://lists.denx.de/listinfo/test
> +  avoid repeated moderation - see https://lists.u-boot-project.org/listinfo/test
>
>  * Choose a meaningful Subject: - keep in mind that the Subject will also be
>    visible as headline of your commit message. Make sure the subject does not
> diff --git a/doc/git-mailrc b/doc/git-mailrc
> index 65626d89eac..f0ba30a5c74 100644
> --- a/doc/git-mailrc
> +++ b/doc/git-mailrc
> @@ -5,7 +5,7 @@
>  # Then when sending patches, you can use:
>  #      git send-email --to u-boot --cc i2c ...
>
> -alias uboot  u-boot@lists.denx.de
> +alias uboot  u-boot@lists.u-boot-project.org
>  alias u-boot uboot
>
>  # Maintainer aliases.  Use the same alias here as patchwork to keep
> diff --git a/doc/index.rst b/doc/index.rst
> index 5d732ff7a54..6fe8ca0788b 100644
> --- a/doc/index.rst
> +++ b/doc/index.rst
> @@ -9,7 +9,7 @@ This is the top level of the U-Boot's documentation tree.  U-Boot
>  documentation, like the U-Boot itself, is very much a work in progress;
>  that is especially true as we work to integrate our many scattered
>  documents into a coherent whole.  Please note that improvements to the
> -documentation are welcome; join the U-Boot list at http://lists.denx.de
> +documentation are welcome; join the U-Boot list at http://lists.u-boot-project.org
>  if you want to help out.
>
>  .. toctree::
>
> --
> 2.34.1
>
