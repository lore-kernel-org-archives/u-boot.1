Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBCDCD4850
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A5A86B72;
	Fri, 22 Sep 2023 20:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VuK0PlEY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3256386B37; Fri, 22 Sep 2023 20:29:05 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2BD386B3B
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59e88a28b98so42257927b3.1
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695407341; x=1696012141; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fu9cvk7HvK4AdaMn9Kc2h3cFDUi9W21qqqqSAaitTLI=;
 b=VuK0PlEYN9NBl+4mDeLTYPk0/6bZCvJBHF0Uhg51qtL4lG52pfEjCXHnr8mi2wfqGF
 V75sjSdsSV4CVECdpk8n+jVl74AuMJE3O0k51EzxXPEteRjrLg7j0QKvgtfMao3r4ULQ
 EcSASB+BfKjDmk20nzZfa2lMZfa1Rhy0zBb0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407341; x=1696012141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fu9cvk7HvK4AdaMn9Kc2h3cFDUi9W21qqqqSAaitTLI=;
 b=OxajNQivUrabtU+d82sTqgxRpODnlQFD41FEySxf2KfpvhH1jylkH9r2YAvFoLW0m2
 iILJyHcIXk3UBslmYNS5OW9axSML3lYPLx+g+TEHwiD/g7+mVQMXIp8VpRQY4KYQ2fvl
 T+L3oLv10p+8G2hDvuR0RQnTntrn985NBpOEhpCuePAivsIrzJodtZ7AIM7dazRvf9W9
 77LWVYXVHtWr7t3ss+3veC4K88Ygwy0K5ul0ZDpPi3l2XnJwTcuTSXxumK2T/x/ynMHJ
 JHcPLnyLcxT3B/qRAaR/03ai8pgjP7k635UlbtN3w60pCewiFy9c0a1fk9pTzP1p5XKT
 L0ag==
X-Gm-Message-State: AOJu0YziBAH3nch8GGF7e/rfizghEy7ge04Axnan8D/mDXDZtMlTr3tB
 0l7LxpeUikmgVDq1WnCiJEdlzuHwnGwATAbwCylqS7rQkaYNVXc9AFU=
X-Google-Smtp-Source: AGHT+IEwPxbmXUrNS4OXO3D5UYWI0dM/C2y5YXKSHc/mJsGWQbpipS1HairQY8AbmCnevtfJC+Lj5ENnTYx7REeBiY4=
X-Received: by 2002:a0d:d4cb:0:b0:59b:5255:4882 with SMTP id
 w194-20020a0dd4cb000000b0059b52554882mr2608933ywd.20.1695407341310; Fri, 22
 Sep 2023 11:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
 <20230920225811.153474-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-5-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:27:31 -0600
Message-ID: <CAPnjgZ2cEb8RfCXvA6VA6FDtW5CbS5EV-jfO1CcFvnp2Xpv2oQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] test: bdinfo: Rename bdinfo_test_move() to
 bdinfo_test_full()
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
> Rename bdinfo_test_move() to bdinfo_test_full(). The former is a
> remnant of deriving this test from another test. No functional
> change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/cmd/bdinfo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
