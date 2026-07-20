Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E00C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E20D82991;
	Mon, 20 Jul 2026 10:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lHQLafpD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97F4484119; Mon, 20 Jul 2026 10:34:37 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA2980517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-8ef1dc934d1so40708336d6.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784536474; cv=none;
 d=google.com; s=arc-20260327;
 b=UQ7zFvbElaJK/LoGZa0Xu5PWcfePKo5AEgyFipqTerivZYG0HbhV/QcgM7oQuMzW29
 UwAqhIqEKUmiIJfG3m76pJ0pYzAgdo5GO99KHzXBEDKEEjiSJezqSRDdTUfmuQsaYMDj
 YXo7qOwNVKLgH2KirFBspE5nIDKyNicpC3ZcYOu6LDbcpDqHzUQJwx3ZkIQGg/nkyKBR
 FCtPtuKjoiw5mP+LtT7wT+IQzj5kAdo6XNy+R/zcJ+CqvxmiygSvs0F3dlGdQUtclcf9
 b0DuDZFC8J3yggqt7vqtphDPLBQ6zSEDYV/Aox1bi9JbmcUioun2EJue5FOjMJY1JC2v
 OQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eOOLWUu7m0Ephr6DI2kcTVjwA66tRBH4U1+vK8nGexs=;
 fh=bwyqfxK51230PPCsUpE7kUv8KYdhODTp7F0jelOmqr4=;
 b=QIyDRADp5SM00hAVuG3bXeEpr7Ww2dURj12K+HE1BJsPpE1bFeoelRVM4lXQkzO/Wz
 0NbA7ctAqc3/uikvZGF6l5hfWGEkxUNfQdlXmtzxqE3MekzFQdtLJjVUu5UysPhQVjrD
 2QnkpmVs1DPzElN0iXANu++J4L52Ro9/hWDFzX8imwx9Y4ZcPXCOQev49H+MZjk7b3b/
 am5TGH0QU1I2oSZOVljal1bPBJX+r+eVBnQPwz/duhUKPGSSpE5rK9J+N5LDKenMFcYF
 VegX7UmFw1nSjWAwPBvKSZ6butTs7Mk4Xd2f92EML1EKnCNAN1eSG8urZhYq4+WerhAi
 tprw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784536474; x=1785141274; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eOOLWUu7m0Ephr6DI2kcTVjwA66tRBH4U1+vK8nGexs=;
 b=lHQLafpDcU6V9AQv70qYXjckd/h81NJv4h0LieLVSfmKh3+lWyIzaKXuRZYOVft6CZ
 AGkz36jr8q8zTL46lAk3MM7VaqgTnJpc+pL8bV7VtFH69xemi5YeHd61KgjIf/wv5eyq
 SezUIeR1Rt28zsAXmv2zUVkkAQ7JZ47QcapNq4A+Kr4EuNOfg5GIsNt4/YDINBgG/FMp
 IL9tMpEXpZr1UQ2VZJKW6ahi8BhuHm8FaR4jUaq2wwH3eUgEKcFxSWY+TaWIrlK8SkPo
 4xrWYeXtoKyW/eVmMIKAywsQFdmE7V2UKeiQm6FShKrDL5iezI29gaqHjwnV2ovTDJQ2
 N5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536474; x=1785141274;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eOOLWUu7m0Ephr6DI2kcTVjwA66tRBH4U1+vK8nGexs=;
 b=fBPfJgd6eD99BBG14i3L6mDY7SM+PEzKVh5WS8ESR72BorO323gCnW2y4pU0fq3JlI
 Y+o+biL+QnVHEbdBwdSgay5NdDfkPKEl1e5ktFQ+ClDSillHBQdVoEeSOikxtGH+JImc
 pDNoPd93H4cuA8mhb0pv+58OvlxHDAYBBr5DEkm2dSN9OSY9blrMr9EVt8SJ+o8FE5nr
 Qzx3xKlv57oO6Q7rx/KrUcKi5QWu9fXIDL3YIhOLxcgfasHz2dJ5tJKNdwn7DWloPp/m
 nVMSJKDW5l9pWhu7+IByiblnM/qzVXSuh51fRxSphp433kuAeuuCHY0LdPb7ybhjp60K
 a9vA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8MFOx5OhVbm1sthmc3MBVIrPFXJhgQxP1z2wkAd1kWZZa8ZbCsnXQkszJRO+0gt902BkAmh4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6m09TRQwaWEaBqbOTmKas9/6m9Mtiq8x/0Pirbjak1lrXKCal
 zsWptE9seIS3RvfKn+hSpG6EF6PbGjT6VY9KYsXyME694hJbALe0se2lK59Dq2O9nRcXwgL8BE7
 4Nujj8PgmC/t1veYAlKnabCV6yDcdx4s=
X-Gm-Gg: AfdE7cnS/tmFVzZevPkXiqej14BxFgo1+pr6jmMA/axDgpAUlcrHDdHEiDUInK0aZ9V
 GcvXkEYFWuefoo3MIReClIFr9c15d9IET3F8u6YvlQMfzNPua4CgTC7krQhZe03e4vmn2XO5xW2
 DpdPvtpECedw4wIrddKDv5/01Tjt4csfsMACuocUOqZKtfYP4vtWb8P38z8saMsvyDvaI4bKyYy
 AxgPWoA+UxeVK0leFkikvQs8XbxF41WMSuzXM+HfUuNM46tv94QhJVxbd4HDq+ZHzQwXqqnQv1a
 2NvIKo3ckW0wpFBlevCaWw6SFz171AIyB4tWcZzXdQZVMAr6p3GPNl4wdMdiyT0pUDVrV9vdrFx
 5k6Fx9OsV5BL7+eTSlfomhWNCS++gf8R7SynBzMvVjm5CgwHXMHZvK43M
X-Received: by 2002:a05:6214:23c8:b0:8dd:2260:70df with SMTP id
 6a1803df08f44-907787c4777mr120429036d6.6.1784536473943; Mon, 20 Jul 2026
 01:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
 <20260720-osuosl-ml-switch-v4-2-20ec1c334dd2@linaro.org>
In-Reply-To: <20260720-osuosl-ml-switch-v4-2-20ec1c334dd2@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
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
