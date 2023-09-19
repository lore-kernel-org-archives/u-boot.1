Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC44ECD3445
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBC7986ADA;
	Tue, 19 Sep 2023 09:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SjfGwcd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E76386AF3; Tue, 19 Sep 2023 09:20:22 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7289F86A21
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50336768615so22247e87.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695108020; x=1695712820; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/iSnfyWzCgOC2q/1HUp5zSmmhBhfP2tqBYoUqy1TDI=;
 b=SjfGwcd+rK8HL7yysLf/1DZTQl/13ySNOLNN4ynzWdXgEr7BDDZBrKLEh+8g2FgqfB
 vuj4JUdSEwHwtNeUBWMTO8J/aiW5YjU3yRCJhW35BZJcRZt63iJiFEy9oaG8GTEVKFiU
 XwXGOX+14noRp+hTuwagbpVgKU20Tf8gUXhJLkaUytvNgpnjhkSpTIzyCp9r/NC2kepF
 EdTKDUXOKWhOhJD1vG61542QCLpwCA9qDMAo5H5wIEi23QHsYyvAD0zDFa2eWdKiEPVR
 GVqfc5uDFawO+5vphLakvXp9/hqqD+hr3CHEwBeliraLDLFa4WMNfXb1AqtFjg8jMZm/
 F8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695108020; x=1695712820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/iSnfyWzCgOC2q/1HUp5zSmmhBhfP2tqBYoUqy1TDI=;
 b=vfkzbtgwpDj8eGFpGOj3xhFodhAnc/wSPBUmpkKV/pSmuERE3NO3S3a7p8jftf0RRq
 T/HfwBPO136X18iFuuaXrwLTAqzDvpKnFta0LIB8IcJmS3ciBmYFsdHDBl+6pqNIgMyJ
 QPHKCz/Ww24lqk0JijNjTKChK/Sm3Cw5x08gr9vnx2RbmWa1bfy81xO/j21asSDWr1Mk
 Z6xbdM/FaIvCdHqvRzIImqERvc1EEnQyVyGjrZsflS2zlDVQOFAVPJDdG9K7v1A5/kdH
 bFMsHMhOYVO5N0vb3Q7Fi3xTHN5xKRrHL9219JPldWc/Ma2Y4mwYN+NRUG6KcxsOmJ6r
 /OxA==
X-Gm-Message-State: AOJu0YyXaCddmx/K/SYevx7MGIvUU01phJWX79Z/MIRWdKOp0hS8Y1n/
 SHO3jrYgG1ZPyeveJv2MP8RIRyolywajLhqR+LaF893J
X-Google-Smtp-Source: AGHT+IHLF6UEHutParqxF4mSyp0LVX4WRmgf0wkVkTB5Tkkw6yPIoXMTO8MplOUyazOEj0laFYMVkp8eoL58jT5RmTk=
X-Received: by 2002:a05:6512:3a8b:b0:4fb:8585:eefe with SMTP id
 q11-20020a0565123a8b00b004fb8585eefemr10942987lfu.57.1695108019674; Tue, 19
 Sep 2023 00:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-20-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-20-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:20:04 +0800
Message-ID: <CAEUhbmXjFsf3D-rJW3yiLQ4EUNytdhdnBi9a2mV6vWxAz9+Brw@mail.gmail.com>
Subject: Re: [PATCH v4 19/20] x86: doc: Split out manual booting into its own
 file
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Move this out of the main file since for simple users it is easier to
> rely on standard boot.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add new patch
>
>  doc/arch/x86/index.rst       |   1 +
>  doc/arch/x86/manual_boot.rst | 276 +++++++++++++++++++++++++++++++++++
>  doc/arch/x86/x86.rst         | 272 +---------------------------------
>  3 files changed, 280 insertions(+), 269 deletions(-)
>  create mode 100644 doc/arch/x86/manual_boot.rst
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
