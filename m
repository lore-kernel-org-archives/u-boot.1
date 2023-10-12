Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0490FCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F29C486F17;
	Thu, 12 Oct 2023 05:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k3fxxtSf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA77786EDE; Thu, 12 Oct 2023 05:44:41 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF77286EA2
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d8a000f6a51so567063276.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082264; x=1697687064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PtdK6Hc57PO0RXjG+Qlte/TBKOXP4EOJzi8fF2fn33A=;
 b=k3fxxtSfjRDkjrDYxCjTTmySee0OCsNstr0CHTiFYNYUElkhiVBVNaWTmLDUyVniUn
 PZqNkh0qeQMUByTFDCDGA2DOWdq44y5+JG9QBQ3l5EwJ6RJ85ymxLJq2B/AKkdhDSNtd
 dAmPaSPN+oSzB9tM6aPe28/OiUhX5+wB4SP88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082264; x=1697687064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PtdK6Hc57PO0RXjG+Qlte/TBKOXP4EOJzi8fF2fn33A=;
 b=slsMnxe0pzx0RISMdT0dhjKM/KmdZ5k/TfQZrWXEPf+cxrktp1rXLWhfCy05x48Bjd
 dh9oFFe/3MMYXeT7sMMSqEcBwvifxGVEqwPdFG8xYtBUYG5HT60i0Om0D055EpZyw6ag
 pul5gR9h26bSihb79Ov+OGroDcSSTABkXB+LMtv3WdrLJgTpEaMGyHFK2z3RdeZFdQbn
 KOGWHU689EWFDRchEXFWloZsPuNNoQh3CF5t7Ot3NAi0SSAqU55J6+a1DDK95fGjwrNV
 FDklQlKd+C0px7Hi+RWSb5tqLNtzJYOhwc+6oijKGH9fh7gF80fvk2V/8S28Jtw2zeka
 vHvg==
X-Gm-Message-State: AOJu0YxVnsS2bbbUOdNeXjNHSWB8HUEcTVI1gNvaYjBESndKYgLa442C
 o3YICWS+L2L4yEVDJMyvREa6dbgRC2me1SCH0NROTQ==
X-Google-Smtp-Source: AGHT+IFP8Er0pNyH8YO8awTuPOjkx7CtjVNZUVbx8poY3udfmF9RfgcJksMt+83fZr0hhU0YS6NiVYv6MrSaoPilxYk=
X-Received: by 2002:a25:cbce:0:b0:d9a:4ae7:f32 with SMTP id
 b197-20020a25cbce000000b00d9a4ae70f32mr7816175ybg.3.1697082263771; Wed, 11
 Oct 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231011-binman-firewalling-v4-0-a08085d300e9@ti.com>
 <20231011-binman-firewalling-v4-2-a08085d300e9@ti.com>
In-Reply-To: <20231011-binman-firewalling-v4-2-a08085d300e9@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:44 -0700
Message-ID: <CAPnjgZ0ZHWB2NWW9drQB5rOpoHMoRAQciJREVBenJ553r15p3Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] binman: ftest: Add test for ti-secure firewall node
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de, 
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
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

On Tue, 10 Oct 2023 at 23:25, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> Add test for TI firewalling node in ti-secure.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  tools/binman/ftest.py                              | 22 +++++++++++++++++
>  tools/binman/test/319_ti_secure_firewall.dts       | 28 ++++++++++++++++++++++
>  .../320_ti_secure_firewall_missing_property.dts    | 28 ++++++++++++++++++++++
>  3 files changed, 78 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
