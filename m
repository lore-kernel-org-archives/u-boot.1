Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59247C531DF
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 07:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0420188EC5;
	Thu, 22 Aug 2024 09:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MoFbW//I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A6DA88EA9; Thu, 22 Aug 2024 09:19:27 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12CC388E7F;
 Thu, 22 Aug 2024 09:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5bf0261f162so788633a12.0; 
 Thu, 22 Aug 2024 00:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724311164; x=1724915964; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bK8eFonpixlpkyNRttdnbc/X8mbDgLTvD5FYg4eDsNc=;
 b=MoFbW//I8apjyfUCv0wBcFRcsLrAk9wU/cNjAc9a2aWHROXDVFI9rC8KEKsHZsDuPy
 5qGlBfpvmGJkSn3qzjwS26CwXsFH5vGtwrT7ifsjpanTo1nyUm5u1SRWGEnz4J7hxGRg
 ElRA/6kxJFySWL9uSYq14QOmy8k4T5ieiChZV+P4eDsm0j+DDSFfUDTbHrOnvILi0A8r
 e2HhEC9Y5vWqqDOlUyWgIJh3AMJxQSRKoUR01oRgSAw2hFXeaTlbIrILhfE8wn2EU25w
 xsiUstJyiWfrMUX2khJPWDcPqh4bqOC8WLygTP2QQiQ8DLnJUN0/IXXdNTCz3P74Rt1s
 O5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724311164; x=1724915964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bK8eFonpixlpkyNRttdnbc/X8mbDgLTvD5FYg4eDsNc=;
 b=OGu2OJoSnku3uqv+cfIVtBIXVdCbviNNaZKgP6NkZLmeuKX39vdKKxc3K5GIqp2gGR
 QDplJQobVUABJbhz1RvI+LFGopTSjaDb+0uGiDGVQ6iaAXj6cfrE8OSiSwTtcn96+xfD
 /zaa6St0YzBx0nTTK0IpMosRtAoanwQtLFS5okhJeAHXD3R08ADVllsDadI4TLUtwTDB
 rj1wu22JFK/bhqa4yAvRI9mC2XOSEvudDMkoi92L8hTR0RIMRd8TAW9ylydXZH6CKWVd
 yVXxiEBelB4emc9VVkNjboNT8G5HUQG1pAB7NVDNH2TVz6rr6U6O+PH/BoG+110+BpLe
 XBmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp9J/v1kfi+szMo5PoWhQeBwbDCC6w3Ote+2hjuWYtwF1aBX+HW+iwTsamO9kFhCqx+r+eM+GR5o2NB7h1lq4SZllsqit+OtA=@lists.denx.de,
 AJvYcCWUBFofE89Tm1zVz2rMAp5FBkiWxBCkXnw7+XGI/YRnzlc7QBX1ybmhtDiwyddCAcMbCMf528PubwbMWXVfvEIPQ40=@lists.denx.de
X-Gm-Message-State: AOJu0Yxh8QH23DTlkYhpMBGj6DwkPrPvT9eOdTqPOP+IHdaVIdB5mdRl
 5xjAYSR2vvfVTX27c3WDOQgDjWi8xIfwxHPFi15mL1RVgaSompOOUjdc0xMGxTdwTRl7l+DbhA2
 2Nmn7sB3H9ZR0WEI8HL09UTqcC04ZMwiP
X-Google-Smtp-Source: AGHT+IGq5uLn7wjuYHixmT6+aeiJGGIbvz6oiJ9VObAXrGV74ytClLJdAYLbfXLmPC8HhVgnr164DpDldhF4ohngvhc=
X-Received: by 2002:a05:6402:27d4:b0:5be:e94b:dc2b with SMTP id
 4fb4d7f45d1cf-5c0791cfc85mr568545a12.8.1724311163695; Thu, 22 Aug 2024
 00:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240819231535.GK1626301@bill-the-cat>
In-Reply-To: <20240819231535.GK1626301@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 22 Aug 2024 08:19:12 +0100
Message-ID: <CALeDE9NvYUqCsv8L4NurYtBfe4VxF2p-+_qG85EphP8YKhYWWA@mail.gmail.com>
Subject: Re: [ANN] U-Boot v2024.10-rc3 released
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de, 
 u-boot-board-maintainers@lists.denx.de
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

Hi Tom,

> It's release day and here is -rc3. Things have been mostly quiet, and
> with the -next window firmly open I believe things should remain quiet
> moving forward.
>
> In terms of a changelog,
> git log --merges v2024.10-rc2..v2024.10-rc3
> contains what I've pulled but as always, better PR messages and tags
> will provide better results here.
>
> I hope to remain on schedule and that means the rest of the rcs every
> other Monday, and with final release on Monday,  October 7th, 2024.
> Thanks all!

There's an issue with the tar ball at https://ftp.denx.de/pub/u-boot/

It's onlt 11Mb and there's no .sig

Peter
