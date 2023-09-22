Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A93CD484C
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A647386B93;
	Fri, 22 Sep 2023 20:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kx5Gursw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D3B86BA7; Fri, 22 Sep 2023 20:29:19 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B8886B81
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59e8d963adbso31916297b3.0
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695407354; x=1696012154; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j3WPt6xNWDlIjb/wdTiRG7eTlvlYV1t+zsu4w1oAAKo=;
 b=Kx5Gursw9m7OBCxC+wyUUleVLD+ptVYwJL6l7F6aC4ARXK+5b+36u48nOwleKz307O
 1DMVQeYSitaffpdatL+Rpz3mmfxAL2Glq/ulSAs/ye6l1GgwC3tU7ZyspshhbXg2jA4z
 o/aEMyNX8ivRaDirF+24lLZsqcnKlnrTTXZ7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407354; x=1696012154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j3WPt6xNWDlIjb/wdTiRG7eTlvlYV1t+zsu4w1oAAKo=;
 b=R2YC8SkNPBbU4fMqDmg4ifzRgQONrVv5Fg5eRbITtLXiJABAAcZb1ElRxCp4RNXA8E
 F68hzpF/UKjGoyPgc+Db2hDzRjxo6phz1USl6ShtYhn/Q5EoZhzWpXlDfRn0pXV60EV6
 ncQdqZDqfMm8ymeZQZfbWfa09UOls3enILcuPhtB7O7w7E7+eXYYZoQXFLpHa2olvcVV
 duL8TR00H1mk6MxNGsUNwYJLvx6pF6w5ZIOPAjLn5/UkhIN6+l/nPTkESL4MvqCUc/mp
 FSmrvBxXeBCEBSNzuJV0kSI2VMbl62WUz5FEWL42kqZE+Rk/IcQ57ySwBLC/1WUx5kYF
 0a8A==
X-Gm-Message-State: AOJu0Yy6ZvA7yJT58Bqv/X4ebS+R8SWqlPjYHxIJthkNfyAZfjw4o7kl
 6NDR6TcRNHz3pJGlPg7Eb+GagLmliw8yZGFhk/2MXH4B9tog0ufkDys=
X-Google-Smtp-Source: AGHT+IENTpoEXshsFbwFrSkl9gbFOsRxGWVATgMuB11ywLqqeeCjXfYJsy72aOJamaForAGCaz/dYt34ZQ5JG4YHDS4=
X-Received: by 2002:a0d:df56:0:b0:59f:3c81:3a25 with SMTP id
 i83-20020a0ddf56000000b0059f3c813a25mr497276ywe.14.1695407354403; Fri, 22 Sep
 2023 11:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
 <20230920225811.153474-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-4-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:27:31 -0600
Message-ID: <CAPnjgZ2scrYdbjQ1qG_4s_=Ba2Z3hTOm3ZjBWYN-zcCTBw0fiw@mail.gmail.com>
Subject: Re: [PATCH 4/9] configs: sandbox: Enable GETOPT for sandbox and
 sandbox64 target
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>, 
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 20 Sept 2023 at 16:58, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Enable GETOPT so that 'bdinfo' command with getopt() support can be
> tested in CI.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/sandbox64_defconfig | 1 +
>  configs/sandbox_defconfig   | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
