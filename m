Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D51F327BE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 08:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44AA48439F;
	Tue, 21 Apr 2026 10:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JO3P126d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B477C843C0; Tue, 21 Apr 2026 10:00:07 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3921E843DC
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-670f6ae9c7dso5366617a12.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 01:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776758401; cv=none;
 d=google.com; s=arc-20240605;
 b=Om2cTJOBkbxT6VdiAkqpxCkZE5FH7t9bcL+DSHlEcQsfhZUXV/mJsCo8ydpwfAE5ZT
 oEsoHmzO0GD/KIqg7ny/zjug1vfqugyb2ghPl2VYhK4hSIVyge24VlGsNelTQKD8wQyU
 k3P7odojGhCJsVz+WsWeySK5e2R4INs6liGWUD+uAbP3abo33tAXO77S0jt9RofXtOLf
 IoQtuokkW3Vlj1kfDK2I+KMGEr4Zl0pKcBekgitx3DQ3qgRDp6kdTtK6hMJDf/isked0
 tqk8nNlOlMGG0qQbKhD4ZUBL8JscHNrFhymSxgJO8IOHCWpcSPa12nU72SdtmJFzVqf7
 qzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yfI8mgVySPVQ9IKYsVMqn97P9pYx2CjPbJpMkkGQvuU=;
 fh=4xiQLcln00hm7Bgtqq1oD4zOqB4mGPuT/8lVExx9kCg=;
 b=KSAwghqqyPqxbh57PzuDnpYquP9QdIzHFsCuG8UqJN+sQv+u3LcnOC+8dVJxJg6Lb8
 ErpJ6QtWWSkaILxDNj8k1XkDjRNgoTdjLTKZ8PRez2C6pCCchQuGU/BzZZmcqJKwnkDy
 1m6cLCMGUwTYWl6CPlHwl4H00LN4gj/isj8jrpiDNwlzs2Kf4bJ0ho8O/bjNmIMQu9Ci
 6bbme+Yhl7/OXlssADqYvdj5ThN7z9Q1uy4Z+5Ygp03jBkC2a6uOmjI4gx+yxpABN2Cw
 ZEexECa0X88LOEA1aXNCTKghYmN1MbpxbwyZLs/TiN7ZOhZ/W4P4ytOHOPsl5D3px1AG
 Ozrg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776758401; x=1777363201; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yfI8mgVySPVQ9IKYsVMqn97P9pYx2CjPbJpMkkGQvuU=;
 b=JO3P126dBIF31K4QTXWHCWaZ+zKlkKojhwIbRQPFTRwx5EAddZ02pN3TP/78MdgPEq
 Q/D5+qJ/BH1Qu9eDtc9V4MnNUiLZV2AvOY3BcUbpkxM/uH+pQkfK7P1Wz7oFO13LWtk3
 l/Ah8wRsRD9dJO6SY+qgzElp7PrqZJacCtNTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758401; x=1777363201;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfI8mgVySPVQ9IKYsVMqn97P9pYx2CjPbJpMkkGQvuU=;
 b=YTZrBLi4/+eiPWcp8o9bpry5410eQOjXyGozHxZ4903+WL7z+9xN/zrzABpWzs3evC
 N5HQ1Kqbo0NejwRUVK+gdBBTxg5x4PqsXETXJprBI0L8hgM4ZtGAX+fIK/sD3666XQcA
 7qb6Kc0ffyQtNZ6FJEhGji0sFzIYVttxtGrTZqv37bgf86uVvaIKzwvEYvrETIgyc0gO
 NAoZWMwEGMNOeIP69DV1WUC17dslclCTBMj51/pdl5FTcPuq0TJGzqvjPWq5QZ58e4AM
 vgqzp6r/eStQ9q6YyRpFSKe2muifAb8D1iplyWIwOM5XNwFCsSMYCQxAJvQJfOx/ofyM
 jmUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QRQxMbn8zsjzjSpI5QPO6jY6I30X1VcCTldwg8QRVO8VVeURQA2qixCcUQZqund9cXWkzeQY=@lists.denx.de
X-Gm-Message-State: AOJu0YyFjI7Bn4F9AjQlVEJ0sON7oEIfDpvdbj6qLh+Lml1reVN6j8OK
 4QQ27vWa8KqCBZSDFWNL+TRSZuqYioJ1QK/bRroeOlAWQoISCloQeZ7guU8qewJ/zl0PzLZVz3V
 +nywHI70+gvORFQlDWa+pp23cLjGlXYyYNJiQ1ZHp
X-Gm-Gg: AeBDiettIyQw3SrSMRPqVLFDgxLZWHVdyE5UgbyeQyXoysaH4feUeqIijwYvh4Y/qfH
 is3csF4pjLfGU08FrVpKFVmfjg/aawGj5VJg5LzcBlruOldL0OLvQJnxi3r85t0JqkVGv8wIOeL
 bKSGtW1+eVDyo0ug5vWqglELH1O6HDh9oSnL9bElvqskNJZ1qPlt5KuRBGkKbRvbhzd4qDt5ykj
 aev8wdJEF9s0FMOmu+Ymw/r81YiQXCrJxRdcpBZa6/ygXTSFMf0r+hjXxGGe3bNXwgxRAEGWZmW
 JJUDDAdUBl3bVh4HHkpB
X-Received: by 2002:a17:907:3e99:b0:b9c:9dcb:36c6 with SMTP id
 a640c23a62f3a-ba41b2e4b11mr730300866b.47.1776758400915; Tue, 21 Apr 2026
 01:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
 <20260420220321.71147-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260420220321.71147-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 19:59:49 +1200
X-Gm-Features: AQROBzBo8Km-pZZthLcvTyJpHaRLXAwBt6VW_4O52fsDHEP1hJdz6_Q_RoBKSCY
Message-ID: <CAFLszTjdxjLb-BK5p9rdk55LxxYZCM11rED6n=Fta84RWKeJnQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] efi_loader: correct efi_binary_run_dp() return
 value
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Javier Tia <floss@jetm.me>, 
 Ying-Chun Liu <paul.liu@linaro.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 2026-04-20T22:03:17, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:
> efi_loader: correct efi_binary_run_dp() return value
>
> efi_binary_run_dp() is expected to return an efi_status_t value.
>
> Reported-by: Simon Glass <sjg@chromium.org>
> Fixes: 6422820ac3e5 ("efi_loader: split unrelated code from
efi_bootmgr.c")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> lib/efi_loader/efi_bootbin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
