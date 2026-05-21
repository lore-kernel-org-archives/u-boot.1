Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7540CD5BAB
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 23:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A62778488B;
	Fri, 22 May 2026 01:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PZqSMzR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA0BA846CF; Fri, 22 May 2026 01:28:20 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7DA68488B
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd8f9889a8cso747500966b.1
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 16:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779406098; cv=none;
 d=google.com; s=arc-20240605;
 b=a1P2IrXpnk87rZioZevHbkYpLRTu8cyAMMmNJ86XDmPixbnlIKsGWxBL8vvMbdMgPL
 MkB9lAMC0eL+VMp3C8T7x1HZl7fGWpcgrM0A4Vy/bnri+mXPHff3nWDRHEoV2vUGvY7D
 pvKG3Xr9SmSG9wCmoHjmQlKLCklbGH0OF3mxBryOt7LK4iduGjBq8UcRd+jjrpwuqK42
 Z3f8KElBz76JdyjAF+j7ZZvefvHIouvFGb7FUWw5J877ytUiLtppV7c7sPAMFj/cWl3+
 5p5eaaFfpbtBV+SsHpnTk+rCtee+ZLn90sJJm9tMg3RKlSKhLPPwgrxwwNavFBW1Hgtv
 rKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mpzK2mZ8+l89bwDNNv/ghDEWyjlaUKLxx42GS9zEDdU=;
 fh=UkYpimHuii4GqZdH6RdYCPYjv6GSF2hCxymjSk0mzuY=;
 b=GvfjU3ok2qTD2LGSth5U+JlOcWV4XoVG6Q3yc7v4IsygzMSSi/+CZjftEy9SuAyz1H
 8VkcOyQ4zWePNBXj2gb6h1tGaYmab8xEbyOY2E77nxOfYpZxPkrtj86kB2cYqTGTAJma
 Hz396ijLBimhoXilHfYv0yzxkYEN1Wz0YpednPJtSIyqL+ri8WH+q8U6kXNEJnbEKFfy
 BEfP0iHEJuAEWRJ923l2+FbN8EtBR4fPmqsXDdJloDWNbgEbYPCVw7V4X/GHIrWFGb3g
 f8Pzt/dgtgWMtKj7AbUfgOfb9YYOPfVjuJqMNRK+GkTqrq+i6Yd/b+NOOxDB2zx7tm8z
 OTTw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779406098; x=1780010898; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mpzK2mZ8+l89bwDNNv/ghDEWyjlaUKLxx42GS9zEDdU=;
 b=PZqSMzR/9rPOddvIEJHNAdsBIeCmcfmsrhMuDCSnxp6aVcGT//fDisJzlm/wIDVbiW
 MKmzNBZq2CDzLuk+yo2bn4klwXad01n9vv2tG5XXusYs9xFEbKoD/R0XtlNY4Ft4qngk
 F6G1pFkjtFNC0W731ss94P5Xa/5d9YmmoVxu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779406098; x=1780010898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpzK2mZ8+l89bwDNNv/ghDEWyjlaUKLxx42GS9zEDdU=;
 b=VRQ63JprIrRl5j5nBBt4lnREnxIckcKymjTy+cavnoYRQEn9FMlwACHBc86efv42oB
 BELdiXLf2RtEV2+zrGXNvf6H22/7LfUbtAtABqa2QrKdW2/DOMyKl1iSyhAp9q7uSoNa
 XT3yrd1P3sKUoSKZbgQ66+M6eQGA9u9AwLIixrVq/W6XzXLxJkiJcqjoq2Z+ToCLlF4B
 o4C/7+jkZWX66IQwwoIhxQ8IIRlV6Ru8nDp0U1iKyl0m7fUGdSlNEEGIShtt6f0wa2RV
 +TImXrOCv31X1K08uTX8mp5+pGiXz9z91gYOPN+9ZoDExJqIZKU83xChOkTcpYUe6A1d
 GD/Q==
X-Gm-Message-State: AOJu0Yz1FEoWknxAv+1LUzF+QQRnA7OG/cvcxNjtQg/IkdjPGa/t3yfS
 7x4AOb7vNF029XX0hjbqbrRW0IqWNEf6FcnwTaRNkWoVoQ6WGUy8r9aO4Q5rbzJeRw9PDNs4ZKi
 orTjd32+6GDMfEL8XUWIrQdRzLNJrL+R6dsdwPoxm
X-Gm-Gg: Acq92OEbVaXhF6XHM2uiQkqIDpCubDHdj6uJFwPzQSV7VxNoK7r9dM2ULY0kxfcKkzv
 fh7YNi4si0o0rgNaZOjKUb2NZceXs7HlZp7IXeGs9BKiFn9s8Cqhp5t7XqrR5xwIEU73OeGKPOD
 i1NLffN0EIbGaDNdmBJq/+Kn+dyzq52vZdeqfKfNwJog8F4Xq6vBKovscGQo0cHq8Aivy6PFdwE
 OAQgoy0VixgbKB7GAo6ERI9zchHrqw4Lop/VkQItoNXSICl8HlGIjxu89Q7YEebRc6CahpGkRYw
 npCREMYE8RvYxacm
X-Received: by 2002:a17:906:cc14:b0:bd0:6dbe:22b1 with SMTP id
 a640c23a62f3a-bdd22f2941fmr53830566b.12.1779406098364; Thu, 21 May 2026
 16:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260519152101.716714-1-trini@konsulko.com>
 <20260519152101.716714-6-trini@konsulko.com>
In-Reply-To: <20260519152101.716714-6-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 May 2026 17:27:52 -0600
X-Gm-Features: AVHnY4KX58_C2jlewwFyuRVFqP3w30TaaOG0TlndeIKPL-20c-6qwXlha56mME4
Message-ID: <CAFLszTjrW4TJhRqVhU9F3dm0wbTPXt55BAM6ry2jtzAR6Rp8rg@mail.gmail.com>
Subject: Re: [PATCH 5/5] virtio: Drop empty bootdev_ops structure
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On 2026-05-19T15:18:15, Tom Rini <trini@konsulko.com> wrote:
> virtio: Drop empty bootdev_ops structure
>
> We don't need to provide an empty struct here now that the caller can
> handle this being empty.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
>
> drivers/virtio/virtio-uclass.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
