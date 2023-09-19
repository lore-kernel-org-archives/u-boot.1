Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E0DCD342F
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 01:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A656D86983;
	Tue, 19 Sep 2023 03:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dkkZ78Qj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 758AC86915; Tue, 19 Sep 2023 03:05:00 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E1186993
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 03:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so6561021a12.0
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 18:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695085498; x=1695690298; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qn6mf74Sl/6O1llPotrAEb210NvEUkB3PyyNcWrXdKY=;
 b=dkkZ78Qj4cssEqMIp5BuJfvHUz1+Ciesn3XMyixTDNcScX3PxqZwooUt+ULc4ynvgv
 jbqpOp2hSFiX114rvmEXrkJnNNUlp67PqX6tAs6cLMLUcExysdbLvtLSIfnOCla49KQt
 v6HWstZoEAAld2M73PuaiHO9cIqMjTSBwYsJNWPelOwJu4JXMTp/VE3Vg30asLk1mUIi
 XQCzxfKYaTAW3LMyeu4qeh1qDvCb+SnTty0SE35XvMVFkplAOMscRIv2xPlbsXcpNfRQ
 PpFLDg805kF1RD4RgtYDIdSomoi4Z/yMo4amaWY48rqtMBYxu9/k0d+ZTS7Dupt9cGn0
 2+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695085498; x=1695690298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qn6mf74Sl/6O1llPotrAEb210NvEUkB3PyyNcWrXdKY=;
 b=oTYsSl0LGi8j8lNmRj51FAnUtbibiWjinKGUt96Pn7Zl/yaYllEvMI6pQoEVPenOUn
 HX8jlW/M70Xu9wPXUDWyOxhyHO40Eiwb1H9bxaXmXmxPm6PDmcZtM4c9HaUSu3SiVHgh
 eOvqK64wfdb6Q2/aDO/TpPN9EeZkbQDL1pGVlVh88a6KNXNZEB7ANA6DhwqiCm+P/15N
 gPreTWaohisrcRV8HWZ4dac4OZ06x5INelOG7ZSO3aq13HbFensUB+cDUG7Xg9DIeAp7
 YqelBLJzQjeV6mYwLOVpyLvjiNK7RDbUuhAis3lxe4x74eK9YjJNyE3rMumVjUsr1e/Z
 9Y7Q==
X-Gm-Message-State: AOJu0Yx4ssKIzaVorhliSXLU9FLda8sUSIgYvgeaYfXDPhpMbBTMPwbx
 MzBcOpsgTKy8tTx8CbN4frMKKnKTE17Qe15JzTsdTg==
X-Google-Smtp-Source: AGHT+IFjV9MbkiTvLXnWJei4QJEOZCq4Bpl1VGIAOZe0RlZBgfwK5GV8SvMaY9FfugitKkRMRAPgtE5+imcUovgc8xs=
X-Received: by 2002:aa7:d04c:0:b0:52b:db31:3c5c with SMTP id
 n12-20020aa7d04c000000b0052bdb313c5cmr8551578edo.0.1695085498037; Mon, 18 Sep
 2023 18:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230917101308.1250-1-ivprusov@salutedevices.com>
 <20230917101308.1250-2-ivprusov@salutedevices.com>
In-Reply-To: <20230917101308.1250-2-ivprusov@salutedevices.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 18 Sep 2023 19:04:44 -0600
Message-ID: <CAPnjgZ011OA9WviiQ+rsdk30MjTR6KP=6heT8RozU-CBu-vr9Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 1/2] dt-bindings: clock: Add Amlogic A1 clock
 bindings
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, prusovigor@gmail.com, kernel@sberdevices.ru,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
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

On Sun, 17 Sept 2023 at 04:14, Igor Prusov <ivprusov@salutedevices.com> wrote:
>
> Add clock bindings for Amlogic A1 from linux-next next-20230821.
>
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>  .../clock/amlogic,a1-peripherals-clkc.h       | 168 ++++++++++++++++++
>  .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |  25 +++
>  2 files changed, 193 insertions(+)
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h

Reviewed-by: Simon Glass <sjg@chromium.org>
