Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A42C5B549
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 13:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB8882A0A;
	Sun,  1 Jun 2025 15:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c/4//U4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 176E982A36; Sun,  1 Jun 2025 15:32:27 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0770782A0A
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 15:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-55320ddb9edso4010483e87.1
 for <u-boot@lists.denx.de>; Sun, 01 Jun 2025 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748784744; x=1749389544; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmJH5VfDb9o0alZkQVf+7nZwUsWHUGsuFQLeXzRE2vA=;
 b=c/4//U4pynYm9vlcS9smW31zRVy0DyI3NnTMqaEGuOeWvELRT8SyvsxPn3r4kuPjcC
 NbTBO/psUfSdVRwsLt1ZHI5DkqWVaQ5zClLaQbfitH7MpQr+R25Yvzl6F1vEq8fIMlez
 aGAeFgZHzhBtMirHXcaW/osZh6ooSryIo6+W3QoLthiyi0zxOGWN3Ah5rf1nhCAotyt/
 fyVYwTbXn8+oiLTCcH9J1N6nZ5EGcz4ksM2SGC2qMSt7L7u4oeyBz45cihO1OZilUeoY
 Nt/NVtAAgybALoNGO1zUuB705vIg7Xi1RHIRC6krqyMvA0HzK79/7pZSYv2IwaI1iDHL
 3F9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748784744; x=1749389544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmJH5VfDb9o0alZkQVf+7nZwUsWHUGsuFQLeXzRE2vA=;
 b=mygFs3gPiKJZYXA3JaU5Cbhe09oLH2X8Ncc8qPPwk6N6FuCaM6WLbukx40yeQf0DSg
 6kza0DA6836I6kaCAeTxhOvmqVbdGy3tq79PPFxxSPZCGo08JQj8vieEjpj3UepOIIoj
 fNHeBpVircn5XnvnpiW8h1OHiWkl2UZAITNWh58m0hwWz0xdM47yiTw2xjpl7SNe8Iav
 5/RmapvLNToOQNfhEv+CRMOC3Yl3Ph+9Wk9FhK7esrotPOVJIeZSgbgnqW1bPUjs17Cu
 IUf3RvCKLXNCVP/w8IJuhXSmQK6n8Q6qkhU1cFMNFMriFEeXppiomWXcnWTuWBrb3V8Y
 qNdw==
X-Gm-Message-State: AOJu0Yx/XzvAOR9uTIn3TLLqKkz9YzbGwV2UcbY3hOCVJS1k6a25N4Zi
 y7Zw1G2I0lPMuSjfVY7e1FENLe+LYpUUtAMW00KPAmDYQ6BeVO/EV1e36lAnmMWu9JNHMSe5kre
 5PKTJ/jGTAWDbNrXFyW1uu6M96HSMUGs=
X-Gm-Gg: ASbGncsKiGHBxftvJjA+3IXCFw0NukfxMVNKoFe6vYw4jOuYO/RaVsbOvLRcc6CqeHd
 +38gQjcWJd1lPmD7teFutlEsPZCDYPHJAr7J7mHdPMu2Yzen3O6CkrOltC0qH8AIwwVb0k7/ndu
 zVumAm504GnUh9jL5Dz4e3+6PbTOt3Bbia3DYomugvvJtkm+kUAFE1lF6S+sBim2us
X-Google-Smtp-Source: AGHT+IF2aK9/ZbhdJ6YsKwOejrANgNPB83WXfWxhq1n95JJFraMz1tXX4Q/GEdQydwR+/eQfQXPOHVlqSUhcEFyqx94=
X-Received: by 2002:a05:6512:1389:b0:553:287e:718 with SMTP id
 2adb3069b0e04-5533b93a5f0mr2935136e87.48.1748784743945; Sun, 01 Jun 2025
 06:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250523172018.4164647-1-tharvey@gateworks.com>
In-Reply-To: <20250523172018.4164647-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 1 Jun 2025 10:32:12 -0300
X-Gm-Features: AX0GCFuSuPCmVGpJBIqJPK0jShP_qpFoZ6JCVKKtUs8UGdpJmxXonghqrAWtwtg
Message-ID: <CAOMZO5CECrOp9j7tfoahavvk5d2j_ZHY3M9z_c=wrZta5vkv_A@mail.gmail.com>
Subject: Re: [PATCH 01/13] configs: imx8m*_venice: enable several commands
 useful for scripting
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, May 23, 2025 at 2:20=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> enable cat, xxd, and the ability for setexpr to return values in
> variables which are all useful for scripting.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied the series to u-boot-imx/next, thanks.
