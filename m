Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95083C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 18:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0649A84D0F;
	Wed, 15 Jul 2026 20:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iKYO4j8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FD1584D1F; Wed, 15 Jul 2026 20:42:43 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3995384CC7
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 20:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-698beff7178so1296170a12.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140961; cv=none;
 d=google.com; s=arc-20260327;
 b=NI032W7Q+Qrbmx8yrn9vniEFgR6qFpTM1WuN43O7l+bg0M+4pwUppZh4/RC4vmeXvX
 59C7Pw13xgbn+XRYpX6svj/PxXJXKQzHaXiOI2bHgy0JSbE9mDFBdFr6qH3sO6oBChpa
 Ff5k1R9WjRO6ENPCe/mGdcg8QdWVG2YDpO1wOI29jLQj4/RH9THutMBPdZee8LXqGMSn
 DrJrRe1PhxBvAoqazDxlaG6w4go20Ddq5hSVdLPNHu74ydFxS8pexJGZA5WCSAhpiyyr
 5IU4QYUPsltRWZ9tgelmIH/ADNYYww7NxQIUDnExRlDEY4XbE8bV5LctK71ptX37j1mI
 cHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e/pfptWIDYaWVzLLpgMEkTFfLKftK9WD5425eUKhXzw=;
 fh=kimxHiw3EdsRWZ/84qPIkIdJF+1xIu48y1C0DQW/JkQ=;
 b=Fn1icB9y4y6whxrcsTTkwlWLUdTKfuzcB5LhX/BGS/hm4H9/cxuDobNkhnBvqZ5459
 GnjnKaf3n7kHE9FGdd4TPcvrvyuDxPX0z8BK9iY9KKJCUQ12JwPlWORelxvs2UMFJcO3
 oskUnBPMabs5Tbsg8FXHt2C5Iu9RWjFCrfXeQx97HFjOLnKG9FIu7mU02+46mUj5PdRV
 CcBIGDbKrlC35Pnn8vPlhz827Z+HLv0hTHVf2CpYW7O8xWPbuMBZYKptfb9p7c2Dw7N0
 Vujv1UnbO218Kcjh3j/OheDsHewjzWL9MPAAWSCFAUt3WWKG3rem+ODVEzn4eGtmxPDd
 NLdw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784140961; x=1784745761; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e/pfptWIDYaWVzLLpgMEkTFfLKftK9WD5425eUKhXzw=;
 b=iKYO4j8Z47aUL8fDdywf9AcHRvHREZVhZY16S0weDFzpqfsxFB4ud8HY7apHLTMzxU
 0oo8JlHib7Qp3OUuxnDfBYtWRyPXqfJVN8hd2bH7FC74yKhUgBNW7cU4GjfvLZaNG2Cp
 BthCTostpIuWQ0Ug9Toi4i9uGhHDz4Xno7fZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784140961; x=1784745761;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=e/pfptWIDYaWVzLLpgMEkTFfLKftK9WD5425eUKhXzw=;
 b=Itj9FtALbNo3LywpmvBE1YmfTNSLu7sKiO0ECxA8w3LinsogyHyvFEQXd1cJt3djpU
 nXN8jLiHksUZYFRcjdUC6YvA5l8+xFgVEt+JRC5ku4sQ4m6wzMmHZwPpfxb5sQoiWqcy
 dA7WRmT1BWpddirRwksVmQUbF1HKZS7WJ4coeGkDOhfUSzM6f3SdJ8DldEs8nEH8SkZG
 6G/S3nk0D/bRRi/zO08HdRRz1vmpPuH+IwVtxmwMWwPu7bPHkrnB2YFAi5N214jr0vxU
 NcFtVp5bqqfBRtMEjY/XfmrgLho3Ar17cd3E5oFFE89+TGhsrXHkEJP1SaJMVdEcX1Bx
 yLDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrofhhK/g3C3PUh7Ofon3Z32es0NWaC5JoyfjKrMmX/9oXGkiZUDDnCBGOUnt/2e9neuhCN/Zw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3uIn/HaIsuscACYl2f1NzhF87Z1tOaD/XtlWMfWPVIjE9BOjs
 g1JDsVY/rpCXWWW+jikOBRd3bcJFY7o29TPMhRTiPz49sAmZAQOHv3ihd4yTLPZVo+dywZ2QJao
 Ev7Luztikk6kPntm/hHxnvnS8OQO93I6sgA0yJrlk
X-Gm-Gg: AfdE7clbZZMI5b/09yLPmn6t01HrPktJnD8mUHU9hSPwqeNWw9BzwWDnkitd5jh+4HH
 sU1KTASUihJXxwbDCKKi6KxYb4MBqjuJpYQzGGk333g8WUaLMSDrDTXqzqHwVY6ZWHJQR1Ozwv6
 L4hh1XcIsk5zMpDcnOXNvRgzNHAcNbQ+i3wy+TmfmOjo41VM7AE5YtD5k+w6fmJElQRzNsd9I8j
 Qu+aLu2VL2GwiSkG+bEkSTYoh6xSblxqkZmw5YQa7bT2jCRG1rKOBpT6isITorv0IoPUHs=
X-Received: by 2002:a05:6402:40c6:b0:698:e595:a5c with SMTP id
 4fb4d7f45d1cf-69e198a73bcmr2305584a12.6.1784140960722; Wed, 15 Jul 2026
 11:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260706215446.4068820-1-visitorckw@gmail.com>
 <20260706215446.4068820-5-visitorckw@gmail.com>
In-Reply-To: <20260706215446.4068820-5-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jul 2026 12:42:20 -0600
X-Gm-Features: AUfX_my_SMzPiyrHcPP5WQOTiSuPEyY7j4ceyvt2aFmiPKe0hUjAvqJnRAjp0YU
Message-ID: <CAFLszTiWyEZCBarMUfc-J4gnSixijU2t33xAE5hxZhNQgsOLnw@mail.gmail.com>
Subject: Re: [PATCH 4/4] MAINTAINERS: Add entry for 9PFS
To: visitorckw@gmail.com
Cc: trini@konsulko.com, bmeng.cn@gmail.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.denx.de
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

On 2026-07-06T21:54:42, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> MAINTAINERS: Add entry for 9PFS
>
> Add maintainer entry for the newly introduced 9P filesystem
> subsystem, including the protocol core, vfs integration, and
> virtio transport driver.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
