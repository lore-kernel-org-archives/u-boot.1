Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2ACC47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1C54878C8;
	Mon,  1 Jan 2024 17:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M5xB0od5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ACD88785A; Mon,  1 Jan 2024 17:49:36 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DAD287805
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78154f49182so339527385a.2
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127772; x=1704732572; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ajCKhqeCqMAJjNOhdH9Mlz4rTEK8FshXeAhyaQ/Ztbs=;
 b=M5xB0od5GmMxZKduCv6I3Y67QFcczP/rDtu+/VNrhgJxuB0IM7yeZbIl8ycPo0AM7P
 8QfLm03Y9JIEzpXyBTnMyY4c6SinlOGdTRmI2Cncor8RVVpIM+YE69ONX8B3APDGdhkV
 T1fBLF6rWH8X6mVid7Kp8wHhC09LtjmqBeyzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127772; x=1704732572;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ajCKhqeCqMAJjNOhdH9Mlz4rTEK8FshXeAhyaQ/Ztbs=;
 b=F5ZIHcA5JQr7u3runu+opEa8MVLIJA18C4JG58xSsNfeG3oU1JU5h8yxqXGrZne6RC
 NlyrE+9kiFAdZcup2hACt4TXmbBeJBJ0c+aiihALjv3e5F00oR++rEXxyVLNSkB8gqMk
 GRdjwG5KrECFGlOliNrLX5e39KahOoWNzMZ01mKWeniRPfuK1uaX6BH7n1x4my8plXgy
 sSYqCSLqdVdAHUdq0hIce5nxF5A4sppdedgGkBgbQ5RFZ5jsofkBgVryo7I3A9H0CZAh
 aisqVqc2EgDPkWOIvNwYEqq8nxMLJwB+7RC+mgKssQR1nO2FIcmQ4bwAGuT4ui5NZjmK
 ZR3g==
X-Gm-Message-State: AOJu0Yx2JvP+k0YIqkPcqN3GS+SmIBykSfFjGYbuu/8+jMH3rHdaPg18
 2eC6ltmK5oAAi98CrOE7DpxJ5+FPOYtnKTIvEO2/eUKXeShq
X-Google-Smtp-Source: AGHT+IHkeHOLGfMRiKb5hadX25YqN/odf6YIdJinNYNE0Ul0zvhSR/HeSK9qOhTuXzBqd//8MaB8omRR3yN+PtQlF8E=
X-Received: by 2002:a05:6214:23c8:b0:680:925f:da04 with SMTP id
 hr8-20020a05621423c800b00680925fda04mr4724895qvb.94.1704127772257; Mon, 01
 Jan 2024 08:49:32 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:49:31 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1gNb2Vaanjw8--0n=QPYnWwfWdexHFE7zS7cPhCop_+g@mail.gmail.com>
References: <CAPnjgZ1gNb2Vaanjw8--0n=QPYnWwfWdexHFE7zS7cPhCop_+g@mail.gmail.com>
 <20231215094230.130121-1-heinrich.schuchardt@canonical.com>
Date: Mon, 1 Jan 2024 11:49:31 -0500
X-Google-Sender-Auth: 6IkqwwDD0PR21JFhBjJODK9Cgi0
Message-ID: <CAFLszThM5EUyD9XSQMDStTyTOyVZM98ZTsoLx2gbx3piDf4v-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] buildman: type cotaining
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Fri, 15 Dec 2023 at 02:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/cotaining/containing/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/buildman/boards.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Applied to u-boot-dm/next, thanks!
