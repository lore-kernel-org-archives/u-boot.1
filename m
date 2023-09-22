Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC2ACD484C
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0B7A86B89;
	Fri, 22 Sep 2023 20:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eJsZfcIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEE6486B9A; Fri, 22 Sep 2023 20:29:17 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD17586B5D
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59e7fb87f1cso32145587b3.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695407354; x=1696012154; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1+S4+uiBm25+RiOyGRj2G2LbhWakiOTdkYF3rmCaYgk=;
 b=eJsZfcIa0ECnAROObpYeZKIzBMHO22tOnV6MNXsGD1yPOJ9DRDDwYLR7OsM53klR6f
 g7u8SQ1CnLOGhAswenMlxCW6hKuetlRoUo/Vh6MPF2i/aekrMLrVqsyZM7Wpi8fMHW1e
 nbHijrwT5tS25pmc64CdvYvTKFk5Byolfo5ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407354; x=1696012154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1+S4+uiBm25+RiOyGRj2G2LbhWakiOTdkYF3rmCaYgk=;
 b=V6sgFxVoZL9nBVCl98/FrPv5fATOwALWaBAG2k1skeIUeFU7srqUFz7usQSnTLnLDG
 IdHF1AH4xxHcnwfV8vZ8pC7jgeYGYtuOqXuCrTE20b8nmW/H8HclRbBdpiqoqqzXHRB4
 6+D5/SWZBHQwP6d6eihh6zmnw0WxyzlY6tuMVD3ZiZIL465i0EDuU41cF7pAA1LF2jPs
 fWaiEi09/9Z2KWiBn5j98sPth04ti7DI55d4pPsXs3T2ZKXAI7iRG4q/frn9rn90t4Fo
 YKyZsF/8AEByxcOXM2iiN3ymw//31cQgrINku0tdkbmJ17xe8MPjCAw3z0E9zH0n5k90
 devA==
X-Gm-Message-State: AOJu0YzjhL/0ice1wq3E3p5Pcwsd8ty1qBSDbnHc8J//V6obKDoXeEjo
 LQq7QFS7NMZY2D2XNIxj6A1X6djBX1Hfe8c4CQxBHQ==
X-Google-Smtp-Source: AGHT+IGlyf0/82zOawC1a3Qik1o/uDwl8BN/7P5mB5ZnZ1cnbLje52DqudTJvG8Tb+kTWkvBfUWgQlpS9cjvUtcj/J4=
X-Received: by 2002:a0d:ce85:0:b0:59b:9f06:1706 with SMTP id
 q127-20020a0dce85000000b0059b9f061706mr521897ywd.26.1695407354398; Fri, 22
 Sep 2023 11:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
 <20230920225811.153474-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-6-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:27:32 -0600
Message-ID: <CAPnjgZ3mOJpqzyzjNApaqVXW8Nk3UDZ0u-6WhQ=tRmor4SoHrQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] test: bdinfo: Test both bdinfo and bdinfo -a
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
> Factor out the core of test for all bdinfo output into bdinfo_test_all()
> and then reuse it to verify that both 'bdinfo' and 'bdinfo -a' print all
> the bdinfo output.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/cmd/bdinfo.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
