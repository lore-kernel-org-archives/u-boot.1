Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F22EFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE17F843D4;
	Tue, 28 Apr 2026 16:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EbH4gnI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A664F845D0; Tue, 28 Apr 2026 16:00:00 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D311845D8
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 15:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so1921341966b.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 06:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777384796; cv=none;
 d=google.com; s=arc-20240605;
 b=R3mba3VDe+4fwXU8qM1kktmBwgWNwxmnSTZ/4ksfku+Xee1rwrX++7UVWgTnY+kMVW
 nXaghxp2j1R4hEIhYJpy7rbuCOManBb9gCbpk0ATbjyvBiK0VapDi7oTpZAeY9ZjWiAI
 Dc0pSRGnIsBO3se5f7jYQG/VQOX7yD3jRwOaSugKGeTm6+L3508iOPdj9edXyLBMFj69
 1MVeuQF3MibFM6+dHTeB6EJwnhOu2mzr7VtxxVb8I9TpawccaEKWh9qjEtHsvCnG1gsV
 uUPYC//n3Hx/A3s0PFvjxYLpV40iamk+NuEpRmd5QZU225pbI9eaiAjZpHED6Xa+hGGF
 IbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q1XlP3TsY6s5EpXadS8fMqYCVdo1CSFJKdyTu3gWaZg=;
 fh=uYygouUcXquA9jB60WPg+6SEYLSPCZdmxiZIPJJzF5g=;
 b=dF2PbwYdGF0isyUwMvQct4bDlNB+O+sOqrGmeRmsLKUbZDxmGMpvxNdDa9PyIB1r9C
 QsxyHave8TTd/gztETcK25DrE78Pn6cDNbbpNuH7WEj/oVdQ/TkJEzDEx5BO+UN+knWA
 rmDjbdGwi0C1iy+E2+eqCx+OGzSpsNWBYZxKoL3vb3N7qz67RXj8QeuiCwghEPKdAZmy
 VaMuCweMI7fz2SoMcltszkEqI3RUSy3b98NuH+FzTL8AuLMGq5wkG5qj+XlBeeJ6BLbg
 HmWS5YEEhsIC6+ROrfoKtQA9SM9ztkhWQKeSGMVzTOW3DADycLrkgRZMQuWCFY1amwZv
 YMLg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777384796; x=1777989596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q1XlP3TsY6s5EpXadS8fMqYCVdo1CSFJKdyTu3gWaZg=;
 b=EbH4gnI3IpX/9wQ9EwowccVwfayIrnwaBjaMpPz1WDi2Etd+TOtitdomVWGXKfq0oj
 VryTWsXmyGqIE8oPj6aD9OdbZfOfQHwo6U8GJ4EPCdjPdr03OXm1Iy2xwhWB3J39TzYu
 eM5SjEP7wqdnPYwws4ne8BE0GtwWTIw1zJaTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777384796; x=1777989596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1XlP3TsY6s5EpXadS8fMqYCVdo1CSFJKdyTu3gWaZg=;
 b=ExRs/rirueo+t759QoqJ5lGOwZr5SsNNlPaFQvckOACpTiVZXR6My+F/ZOUf1Jds31
 ysnr8UpOlkRSTBdeuVNYAp4trzcIYCd4Pfff+zYnUgkS0fJCTcFh/qhWGIQHNhM7Ponv
 t5R3RROGYeZZ03kS3cbqCcVV6/OHFrKSnDvfvEv4Yhfye4EvGiOShTZufHsedHT5pfJB
 sj4eeED/WsU3zlsv/1ALhb1BnvCno5Zj6XJOB4eWY/ZwFtIvqRQaMYtSjbm2R8zKeCq4
 oG/G+R9SZYmBYpciBpy7MOsN/05oHVOp8smkOkBm8qxDxnsOsNi7t8kLiQyaGYGj3Ou2
 vUFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8arwquBBn88F1Nr50mHzjFFOtAlh7CrKjQAqRYcnaHXxAZtwUWSJolIW1TcjDfAbvDgZGeLO0=@lists.denx.de
X-Gm-Message-State: AOJu0YwF3Q3Wq4gOq50YvcJI1HbVesnBcT8oYOdl4TJ9w0ooZG7z9pDl
 aMOkQAiiR0SDPcX7HC0L8spQDJrcA+zCZ8FQkqQEgyvCTa+WMmqwn6u8GwliBGpY+he5bgYfuFV
 XBNxki8lBl3DxHK82SzD3F4mnZ1ADWIcGlVQ1G99z
X-Gm-Gg: AeBDiev5CjgGxwIJKCkSTFuZ16Hj6mxAi8G/sSV82bKUw40Db1vu5D8Tt/WdyS/vaVO
 zIGphhmryQ6BLYtnCvGoObC95U+XuBwiNy7YbW7ca3nXqw0zVB1ECwvNRmJAHb11dKGAySJKwBt
 08uukHddzouzkkgF90f2BEhPLdfJVsxQsCnpgDJYNLNpdwLfJvsgqf5rV7AJTb0BgjG/JxYCFRi
 mpeeUKziER7YhXH9J8Q083ahU8bJ2wL4Bqi7G6ujxGC0je8wmAi6W/IDEWNbh3GncI2NS7cy730
 ilbH0Qxi9ebxAqpm
X-Received: by 2002:a17:907:199a:b0:ba9:bb46:345b with SMTP id
 a640c23a62f3a-bb8028b3bdfmr211138466b.18.1777384795776; Tue, 28 Apr 2026
 06:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260416093927.602613-1-daniel@thingy.jp>
 <20260416093927.602613-4-daniel@thingy.jp>
In-Reply-To: <20260416093927.602613-4-daniel@thingy.jp>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 07:59:39 -0600
X-Gm-Features: AVHnY4IFecPCANTVlf2HdbCs142f_mdfM6egPrAEZ7UixqNx8JmsnrKKhdDIh_o
Message-ID: <CAFLszTjHMFrRpzrazW4-EWbO05uHMbUOZ54e=DK6am+92_s5ew@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] timer: goldfish: Use __raw_readl()
To: daniel@thingy.jp
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com, 
 sjg@chromium.org, u-boot@lists.denx.de
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

On 2026-04-16T09:39:20, Daniel Palmer <daniel@thingy.jp> wrote:
> timer: goldfish: Use __raw_readl()
>
> The Goldfish timer registers are native endian, so they act as
> big-endian on the m68k virt machine. Currently, this driver uses
> readl(), which works by luck because it's currently broken on m68k.
>
> Use __raw_readl() instead to avoid breaking this driver when the
> endianness of readl() is fixed.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Tested-by: Daniel Palmer <daniel@thingy.jp>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
>
> drivers/timer/goldfish_timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
