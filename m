Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612EEC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 587D988838;
	Sat, 13 Jul 2024 17:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ob+SiTFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AE8F88836; Sat, 13 Jul 2024 17:13:57 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E886287E13
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-79efbc9328bso216483485a.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883634; x=1721488434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sllq07vyz/0C5In1ycjmolGLnRMU6E0smC/hl1CqmFM=;
 b=Ob+SiTFfZPDTEit8vLD2PqAdSI8VJGsEdjYGpWwVRmhLW43eReBU+x8LOsIzHY5r47
 WOAc0jBtM1SBXNbegkxcbWSLJalzCWBeWUzGrYkSjjHqAeFVn8Hclx52hGG6XIy3+Ct0
 BgHd3cy+C3ouzNX5Vch/0bzJNEW2mFVUawUXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883634; x=1721488434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sllq07vyz/0C5In1ycjmolGLnRMU6E0smC/hl1CqmFM=;
 b=bXJhHoTfv+mZLUa9sUNqjfaDtyzuKPBUBXIAcGTkEWmcmz5kL7Etu8lDjkyPhLWkZh
 oz/IQDHcUfyt6Mnd2Oanvw7zQn/7CU+ugjbtvPI3a9yytkfQBUu4e3B1Q7/EEu6KfauE
 iwTEIhmzEjZlYo+2FNemReCwp113SRLl6fEmr0I/speELXZd6g+UYKaEHY9K8S3W1sRS
 oAhqnyYH6EyusE+cP2GNTAZi8cmpU8o1XUettwsJ5gVAjGG4K8bVSZQdEI9eyoQeoJWO
 n2hKea8fduVU6WvKYsX4LyJ4ns1EfUr6WeoHZnqecbxJpkjAWDV1A9XcB/D0xd2Kw4I0
 C0wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiDa/ihtQZZ9VrkAdslYVy+T4B0q/Ke6odtzNz4tLgTzya068QVde2o3ZXrlvcf8YyuuA0buu1mQQ6CQsl4Ene2xTTrw==
X-Gm-Message-State: AOJu0Yw5V3vwr/ANYokhMglXtaMxkYpepdHDXYDswHrLANXk50UwbARX
 pndLKZn0OTT17Zaqdcg9IElQyTrAxZp6mCZ6EddSU3DU9vVFmValjANSwGY7b658y2ci2hOfb3z
 aQsNiar2wqIcV2HIvNIyokttR2CvgSXWkG1iR
X-Google-Smtp-Source: AGHT+IFdv0xc3dJrFXHu/6V6jZp58I+JsfD15043aH/JWpmvmLI2naHT8g7DCiezu9wemp2ctvxGTh4DY8Ex+SEr+c0=
X-Received: by 2002:a05:6214:1c8c:b0:6b5:90a8:913a with SMTP id
 6a1803df08f44-6b61bc7f758mr213175786d6.8.1720883633800; Sat, 13 Jul 2024
 08:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
 <20240711-b4-qcom-rpmh-v5-5-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-5-fbf04ce6a7e8@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:42 +0100
Message-ID: <CAFLszTiLr2fdephDBfpB8Qs1y4P8ABVkY6cmQ22WX2+i-1mTLA@mail.gmail.com>
Subject: Re: [PATCH v5 05/23] soc: qcom: cmd-db: replace cmd_db_ready() with
 cmd_db_init()
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Thu, 11 Jul 2024 at 17:47, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Using the driver model for cmd-db is fine, but it's unnecessary
> complexity which we can just avoid in U-Boot. Instead let's just have a
> function to initialize it and call said function when initializing rpmh.
>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/soc/qcom/cmd-db.c | 74 ++++++++++++++---------------------------------
>  include/soc/qcom/cmd-db.h |  4 +--
>  2 files changed, 24 insertions(+), 54 deletions(-)

We should use driver model for drivers.

Regards,
Simon
