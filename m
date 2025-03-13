Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC36C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E93880F9C;
	Thu, 13 Mar 2025 20:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mQ8NUXDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA59810E8; Thu, 13 Mar 2025 20:08:04 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029C380756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e5dce099f4so1735692a12.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741892880; x=1742497680; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cL5PjbCkPQgerz+ZH45qEetb+lBALlpWCkd/WkevvpY=;
 b=mQ8NUXDH+87OXeVUaal/RSAKuQ/SRmLSKDqICfWcFIp/WAunWyEF3rlgwVuX1gc8rK
 bbxIYq4Z5/asMqRDWGD95MHAz5rg5mvY8tRZvhOYdzyzvQt0+z709zUNYiIJznn1aDl/
 TUEb27ltFbSzpUu28DUDwlX3/ci2K6PwnfqQSf5AkLw4JfMXYBqPL9QdM55K/qZdvGYh
 +fzRwBn+2SL0qG9xUuLpf0Y18om127qHmAXvlB3KUVOZoyEskdi51N+CRDoztVHkpafC
 wgbS8On3z1pgxa52mQl8wVOwgVQtag74zF1vZ2k9cgbM7I+6PnZdWXljW6bb4g8bjEny
 tjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741892880; x=1742497680;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cL5PjbCkPQgerz+ZH45qEetb+lBALlpWCkd/WkevvpY=;
 b=PPTV4V/sYjgmIkS6aPAJHxih3Wg68aluR69DPqJTkjcC0qxRHk5M4KkBLHyNikREKd
 vhBp3gMELRndhTC2SacFBXQDDrhvYCyDtiHvBMfF2xDDemEpRbpJqZP6ULHXTR7G6n1G
 2VMBIG5/lj8gECcuOB5f5pEBfh9oJYU869gxQO2kVDQDoBzpx8IHsgV0iW5zDTf0YU/s
 Yhkmm9lDl78DFXI1x8xb7kh06s241xnMf0S4TY1oiAn43aBucPe1uAu9x14m0zch48De
 zCoFcXfV5mvyG6bd7wmg6eJla8qWifsF25iguuEJP1uZizkPDmfutM6YIfM65INxzrd4
 t5eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU26o2fWJSu6ONP5yhAGfNPpPAZH4ZVrjEU8ic1Apxxl6ElxX+EAyotDDRkG51n3gkaip3NJBg=@lists.denx.de
X-Gm-Message-State: AOJu0YzYskfEZEjrW0HGJi0YpkFfaySeJEtlaFAkTLpVopOx0VTSTKt8
 ljXPpZZnJV2olz8GGCJHxwBoBiLNbGbIcqAfICBHgyNGeaR8iCQXnzwER4eXQYoz1nay1f9LnhF
 R7Z2LEXYxpYGoeDxXVYTi8Hvj1IY=
X-Gm-Gg: ASbGncsgEWTC319Th+RwKTG/pA0bXNbF7g23friYv4n+ZzOCLRPHYVXuL5eRDjs34KJ
 2PtF9WUx0eqhKiYiFNIYtFJDz43gwo6esJJ3JtCLwgzEr2FbY8Y0RL/AvQhxx+CrKRBmWS1h1sj
 XFTc0eqx8z/zogdTbyKxvXYL2FdjdiFKVxcMYsgzipEJCmDE4ltZws3jORh63tbDkid0G4gg==
X-Google-Smtp-Source: AGHT+IGLZXuANaOHHE2bwrR8UG2Sy3bDFgcJNK4tDGNJNhJF2PeRGWfu7fWrpXFli7nrXLTH98yVocJpdTnvXafVSqE=
X-Received: by 2002:a17:907:a05:b0:ac2:b086:88e4 with SMTP id
 a640c23a62f3a-ac32902aa3cmr74918266b.1.1741892880074; Thu, 13 Mar 2025
 12:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
In-Reply-To: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 13 Mar 2025 19:07:48 +0000
X-Gm-Features: AQ5f1JqDCWmXkdAiVQp6PHX_mLdpGwOvloOFILdtdaSXNxY3NB67e06L4QYsPwc
Message-ID: <CALeDE9Nm+ZV6_3Vs0CE1o8vngquRq-JvvpsdUOLceM2nxkf7_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Better smartphone support (Qualcomm)
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hey Caleb,

Improve support for running U-Boot on [Qualcomm] smartphones, with:
>

Is there anything in this that is QCom specific? Like should this also work
on the Pinephone phones which have either a Allwinner or Rockchip SoC?


> * A boot menu which can be entered by holding power during boot
> * Hang on panic (so errors can be read on the display)
> * Serial gadget which can be enabled by holding volume down or via
>   boot menu
>
> In its current form, U-Boot's boot menu is perfectly adequate, however
> once an option is picked U-Boot will never return to the menu, always to
> the CLI.
>

I wonder if it makes sense to make this a generic option selectable by
Kconfig.


> On a phone (with no keyboard), dropping to the CLI effectively makes the
> device unusable until manually rebooted, since there is no way to run
> any commands...
>
> To rectify this, let's revive CONFIG_BOOT_RETRY for the hush parser and
> add an option CONFIG_RETRY_BOOTCMD to run the contents of "bootcmd".
>

Is there a way to do this without hush, a bit of thinking out loud by with
this hush makes less sense, and compiling it out has the plus of it not
being available from a security PoV.


> This provides for a flexible menu system which we can enter and exit.
> See qcom-phone.env in patch 1 for more details.
>

This over all sounds like a good way forward.


> Finally, provide some rough-ish documentation to describe how Qualcomm
> phone support works and outline some debugging steps for when UART and
> the framebuffer are unavailable.
>

Can we make that generic phone?

I have both of the pinephones, I can likely try this id there's no specific
qcom-isms, or if there's specific features I need to be aware of I can see
what they're missing at least.


> ---
> Changes in v3:
> - Minor wording/clarification improvements in docs
> - Introduce CONFIG_RETRY_BOOTCMD rather than changing the default
>   behaviour.
> - Enable some more gadgets in the phone config fragment.
> - Link to v2:
> https://lore.kernel.org/u-boot/20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org
>
> Changes in v2:
> - Fix CONFIG_BUTTON_REMAP_PHONE_KEYS name in qcom-phone.config
> - Add Tom and Simon to CC
> - Link to v1:
> https://lore.kernel.org/r/20240831-qcom-phones-v1-0-08614edd8e35@linaro.org
>
> ---
> Caleb Connolly (4):
>       board/qualcomm: introduce phone config
>       cli_hush: support running bootcmd on boot retry
>       bootretry: check for bootretry variable changes
>       doc: board/qualcomm: describe phone support and bringup
>
>  board/qualcomm/qcom-phone.config |  17 ++++++
>  board/qualcomm/qcom-phone.env    |  49 ++++++++++++++++
>  boot/Kconfig                     |   7 +++
>  boot/bootretry.c                 |   2 +
>  common/cli_hush.c                |   6 +-
>  common/cli_hush_upstream.c       |   6 +-
>  doc/board/qualcomm/board.rst     |   5 ++
>  doc/board/qualcomm/index.rst     |   1 +
>  doc/board/qualcomm/phones.rst    | 122
> +++++++++++++++++++++++++++++++++++++++
>  9 files changed, 211 insertions(+), 4 deletions(-)
> ---
> base-commit: 78f8c8c58f7d3f7c3a26af4afbd08aba21c14c90
>
> Caleb Connolly <caleb.connolly@linaro.org>
>
>
