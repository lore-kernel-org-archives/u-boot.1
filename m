Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DBEE74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C65289655;
	Tue,  3 Dec 2024 20:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RcHjAEhF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3996D89671; Tue,  3 Dec 2024 20:39:31 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 497CD89655
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa5325af6a0so837382766b.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733254769; x=1733859569; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UAS1EiGbTWwX+IDk21x97X0aZBPacorpmR44pIOEGqI=;
 b=RcHjAEhF3WySSbpmGRD2DY7Qq/vZ+Lm/aerCejpLnhr3ToB16CQXp85Pqgh10pnJEy
 UJKG9Ggb/1hnnWVUXt2IKiGvG7AS8Pq2rTi90Pdl8+kwCZHrnLtaPCjVKe1F0ipyx/Sg
 YK0BZD0hOJwXb+LYExWQ+tzHQFVCcsPyCb2hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254769; x=1733859569;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UAS1EiGbTWwX+IDk21x97X0aZBPacorpmR44pIOEGqI=;
 b=G9ve9hcvPax5yuwiZZaNTNaf8NHMeg6msUDahfFVKq0T5MmW9i/1Fn17/PhZnt/0HE
 1zMQTTXJpS0IAnKGmscpKMOS8yqBA59gEP/AtK9wl6ZF+262MutFsvhMBorvKa8LKuiI
 SiE3OcEyjsSA1M/kbwmmnULBDN6WN2TliUF5EDlNPtd8XB4DCvkjtihvG55lqvUjVhOi
 saMSIOYF3zrfq4pBO03wuW7fbK36qPYmyi1m3mJocAHeMiQp3IeVmeiGix7DVWwn59y6
 JqdugTZ0Frjd2OBLDLsvQm/fY0a9SIlwVwuYdCGtFXHl+vA2nwJSAblgzvqhqygBi3W7
 hZmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGFc6H6oBrN3CdFDcQmzoVZNonNuTJQXht37722+LDmu7BlefYtOYwVBPmcLpCyMeFVnYZCJM=@lists.denx.de
X-Gm-Message-State: AOJu0YzMP1dDOQHPX/ZSKjgTNaKbOy1mp2ChZK+AO4VnTNRpbTO5jYwa
 e5C7h539jKc2p/NozVU3cn/H5LlI4KvwYOK4oAco7Q33pef5PLC+pbr05gUS510icb6HvQXa7yi
 8oYwZ8ifyaY41unEMW/zpkWZDfGt7+7THW0ZlXvIk+3nJR+k=
X-Gm-Gg: ASbGncuXcRKgy5lFBV2C403oSuLJQPD8/UFWqg9RHGwh0f2N/6W2H+u4x7iH7pFSGe0
 KhMVYK8Mq/brNwFD3Q3DlMpcDij+pJE2+
X-Google-Smtp-Source: AGHT+IGdroG87jd0gINYUZw7lTeVJKE61nuJqeZsv3uHx42puPpK3lhsVFrwHUA9OeoK1RfUxEprNdNC1hCl+pikMwM=
X-Received: by 2002:a17:907:7809:b0:aa5:1b7a:5579 with SMTP id
 a640c23a62f3a-aa5f7d38d78mr338193766b.21.1733254768707; Tue, 03 Dec 2024
 11:39:28 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 19:39:27 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241103003322.626036-22-sjg@chromium.org>
References: <20241103003322.626036-22-sjg@chromium.org>
 <20241103003322.626036-1-sjg@chromium.org>
Date: Tue, 3 Dec 2024 19:39:27 +0000
X-Google-Sender-Auth: cxelEZpZy1awXe6-8oYkKIuP2d8
Message-ID: <CAFLszTjmgLnbZ1+WFFA-t_wOM5h+VXkqCTAQtCsbEBdFHAm8kw@mail.gmail.com>
Subject: Re: [PATCH v3 21/25] ide: Drop unused status_led.h header file
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/ide.c | 4 ----
 1 file changed, 4 deletions(-)

Applied to ci/master, thanks!
