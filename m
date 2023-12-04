Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82F4C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 18:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08AC8766C;
	Mon,  4 Dec 2023 19:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U/dPRg8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E478876AE; Mon,  4 Dec 2023 19:44:09 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA028760C
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 19:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5d719a2004fso14176827b3.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 10:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701715446; x=1702320246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sfd0XyoVAz/pM/itO7k2kP/Twl4aePd4XqlU5y7g9lM=;
 b=U/dPRg8cL61LI77YgMw5W+eAYg+SSp8OQrohtQ++cwl/Ew/Ag4+m5u5Mc3PrJWmlRz
 Cx3Kf4HSXcglheAWU4UxKzagpUCXqmjlhIoXO5ta/Nb0aUiXFlH2F/Iju9ASNpGs5j5K
 e/9qTnt+4RDz9CJ+IQmtMJjE8eQXX8cErEe+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701715446; x=1702320246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sfd0XyoVAz/pM/itO7k2kP/Twl4aePd4XqlU5y7g9lM=;
 b=oG2WiG1PpIjSuhNRTLRQ/YBOebkQOlehqc2D371HJVi6GZ5m8tt5LOqHnaJsyfbod6
 wihWBGGbAyM6EncgKTShjnUszHH1dftIdc+EeZ19ZRqn+A/l0EltxZffpi2Jjy+37EWo
 kei5Ti4HRH4kNJP+Xzyu0L1v2c35f5bFfubfLOEf5NGz26qhidSYk+xTk34udS620D0B
 mhgaTPMaYu7Ly6TKeBAzmhKaI3sfi3NmZ4lLrviz5gC81EFLzFWvjfe0YU4hRn12sQPi
 yTVP58LlTZbd29009sYU83LzzfgvreHnGzqTGalNbIOLHu2UHpgtnf1hXNQktrseX3w+
 wSWQ==
X-Gm-Message-State: AOJu0Yy3MtJ8GFXny+2CZV/TuOU04fMeuY5g5falqtKcvFxjF3wjBaUi
 0qlGpNF5XaurswxEz4C5+raNdGvBAw6LUWKjglmGu2th
X-Google-Smtp-Source: AGHT+IHhS+bpn3pcCJCi3ahjDLzZECydsINQMTRN798EJVb7cUJZ8D9PpnUQdXO3cjOq455LWpxxMg==
X-Received: by 2002:a81:9b48:0:b0:5d2:bb18:5837 with SMTP id
 s69-20020a819b48000000b005d2bb185837mr1909813ywg.16.1701715445871; 
 Mon, 04 Dec 2023 10:44:05 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-38a8-7605-2d5e-44b8.res6.spectrum.com.
 [2603:6081:7b00:6400:38a8:7605:2d5e:44b8])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a0dc906000000b005add997ae53sm2556777ywd.81.2023.12.04.10.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 10:44:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/1] efi_loader: generated SMBIOS table below 4 GiB
Date: Mon,  4 Dec 2023 13:44:03 -0500
Message-Id: <170171539121.2051356.1572059742264968174.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120222558.32014-1-heinrich.schuchardt@canonical.com>
References: <20231120222558.32014-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 20 Nov 2023 23:25:58 +0100, Heinrich Schuchardt wrote:

> We currently use an outdated format 32-bit format for SMBIOS tables.
> So we must allocate SMBIOS tables below 4 GiB.
> 
> 

As this is reflects what has been done the longest, applied to u-boot/master,
thanks! And we shall revisit all of these topics for v2024.04 or later.

-- 
Tom

