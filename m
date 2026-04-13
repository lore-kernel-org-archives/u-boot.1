Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E865F34C52
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1DA084199;
	Mon, 13 Apr 2026 15:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y1oa2VdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 754C38419E; Mon, 13 Apr 2026 15:35:55 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCF484199
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35fc258aaa4so97854a91.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:35:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776087350; cv=none;
 d=google.com; s=arc-20240605;
 b=PI8Y6TFHurNrOJ5uIhBtrbOIRA32X/CRY9EOHJom6F8cB/bqgh6r8CZ9ebxWmn+Jna
 staKD8xYzn+Oh4GgEbuvL9kA/cQzJLM1p5nQHIOQ6PgnQ5AmmWJo4pZdCiEu8q1QASTP
 +OSjtwnY/3mwFZNKHBIp8koFbVElrgFUseEjrniVKr4mGQnFDU02tiqi1u7F0ISG22Ki
 7hP6E3Qn5Yahhh89hr7M5gIgWDpqMQcNNMSRDoesvO0bKNwtxKTv3UV3eJUDU1yagoeU
 FdX5HEhiI/nrKAgnbPtS9mS3SuAFjP0YiJ1zQBEP/2oP68zB9/qlsrfpFbQLz37e5XEP
 9Vuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ygBqtaDeczLtrb9gTTS2ihYIf9Ld8W15j39cpcyZ0v0=;
 fh=mvcsXzL7JtZ03J5pmO/qI22jN3bCOwpAY3DyNXEQFI4=;
 b=iDpSHlwbv0IeLj5ByPkf54JVlvlupgF0GpL4w97WLhK30KGKhNzy3ZKPJYaEL6k+KE
 dth6XaoODh5/yOm0SV5obhNagn/xKqxtjRa0PZOZdwcPDuOdUDRhgoPLS1//PkOFLYH3
 DXOKKc5hyRYTgnYtutzDKdFfVsiB38QdhwFyiiIq7pvmNuLLrsefSPuCNuRTTaypZkxf
 3Y1Tcd3Pw29xWAwO9dXdK+01zldKeeyD5c68bJjyQjsrWHj0kQPC30HT4rC//WVfwp7g
 S31mG7QkpsSVJrMqe29V/bURtEDojceL78mBOaHq+24UpVN1c0oVL7xFw80337KhuhiQ
 8pEQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776087350; x=1776692150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ygBqtaDeczLtrb9gTTS2ihYIf9Ld8W15j39cpcyZ0v0=;
 b=Y1oa2VdCsu7iB+bAK6qVX4MpUJNKXESYMt08xrCUqPdId3Z+RxeKXEH+hUOH7IUPiz
 KWvvIxxrMWuSgoBlEvi3Ed0tIb/DDtxoxb4tIz5/RFD3y/yZxBnrXMHqQ+1jOXc8oZRj
 mOjsdKzlw6TfJl3XA9++HiUUoZDZqzKaWN8pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776087350; x=1776692150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygBqtaDeczLtrb9gTTS2ihYIf9Ld8W15j39cpcyZ0v0=;
 b=XscOsve7AbihYPRLvVwCzlvb3OTSQzb8+Jq2ZzL4T60Pwtqkz8GkpjZzUyD8VZE5nj
 sav/3yRLIm+1Qjx5+u1OoLif5A8UFJ4bGl1q1BtaSxV0KokRv/VA98G4PO0+GNt9m1ee
 FmZgoSx8vmVzrMMrdrGkNbPKXkzWiMnZTST87tm7zFNHJFuwvlPm9rxl8yHcYQoLn1X0
 5LRZDCOeFWMBh9eciBtdicGsDT5HQSJbvVMo8wMpuV6+0d7WHUsKlT6vRkVyTR6zjHB0
 oUesmulW15f+4BDrG+LdIZwhCKle2iJLdzSHaRDQhOGVdG8GjJwMrm9yuKjCzaXexXKh
 pLWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+z0MBp4SN+i3eB4KmMNd4vdPnLlMMNg9fxdmvOr6pBwPYa2f/aOq6PHGXTJtBLkWgwK5Rxf7s=@lists.denx.de
X-Gm-Message-State: AOJu0Yzq+S5rGcEh8mKEiwiygJT0tBYtMUryfJAE9PI6CWjcuk6+/Vyb
 2hSeTJk6jE22PBltL+yBPd13wva7JMGrh49AysgZW9Z0N/yeQLDCMjh3HcTxY2IvxbPuuu7ff1C
 iodaWQtwDrilp0kOe+jxShWeQxTMQP+nGhdRb3OFNSf5VXIzkBGk=
X-Gm-Gg: AeBDieu2H60J0O9Vx5HtFpItd5hG2e0aOqlCfxWPGTFuEJ4kGbKr4q9HJDv4OkwYa27
 6xpW4/v2qwejqRE8YZpnbp8OdVWVQy21Kuq/uk588zCNXxrXHVXm6Pn0jY/0BEQsJUUTWbsWJqy
 IBu3py+tVtouazdxy3f5R414Y/iYKWh5E9HYh0gymTfLklIo7n/sykrvnlS3d+Iq41zqjkw9kI5
 ssoCEe/cCMSxwjzOZnn5HarAIGyQ0qdO+Ga+FM0oAYpZj8bVujZvd2LNGvuhcry57Q2i6vEGZqF
 LPxIGQ==
X-Received: by 2002:a17:903:1207:b0:2b0:5ec1:97c1 with SMTP id
 d9443c01a7336-2b2d5939275mr139079945ad.7.1776087349745; Mon, 13 Apr 2026
 06:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260413062439.56470-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260413062439.56470-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 07:35:27 -0600
X-Gm-Features: AQROBzCvb7FFpja2DQ2UoXzMj4CVyUSYCAlOqNwuv2n7p8HVTH9Ixo-fCz8sAq0
Message-ID: <CAFLszTiiR8ge76TFVB8Jj=hKT87M48wF9-ZYvcAjWDyk8j=ZGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: correct title of CONTRIBUTE.rst
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de
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

On Mon, 13 Apr 2026 at 00:24, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The title should be 'Contributing' as this is not the 'Overview' of the
> U-Boot project.
>
> The top title should be H1, the other titles H2.
>
> Fixes: 0290cec364f6 ("Add an initial CONTRIBUTE.rst")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/CONTRIBUTE.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
