Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D12C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD8648781E;
	Tue, 12 Dec 2023 17:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="klgst+h0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E2AC86EF1; Tue, 12 Dec 2023 17:14:57 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085068781E
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ce4fe4ed18so548349b3a.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702397692; x=1703002492; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zfRq5NUiaBjQAPzQmltprYvA3a7SDqAIBMs11TcK6w=;
 b=klgst+h0LlUB/ugl35eTX2W2wFQ16f1iZiR8sWovG+I57ygJwq7ZbbSepsnTOM24vM
 u++RL9+e4LX3aHE9CkNkEn2rkIIG0oRQVOdJ6rm5Lc5Q2uT9XUqLBsF4s01TGMMKq6EA
 gwmKEu6pbaJeVo7rU/r7uV2rihTNJ6snVLPbllit6bm5BZNW15qHtm9cC0y9wwrZf2Nv
 j+Uyw957Z0wxoyQokumOLIVcCZ50X7ZKRo2UyqMDxIfHD3yjcBz9WPEW4QhfGq67FFQq
 1o7/vtyRkv6ikWhJ3Wlrz7U6xm9MN3nK9/hjf2BOvuvvZPEyZDs3xjlDUP7ymTz/kbgi
 cwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702397692; x=1703002492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8zfRq5NUiaBjQAPzQmltprYvA3a7SDqAIBMs11TcK6w=;
 b=uDlrM8OvF8UB+6rxDUg0JgylNxTxV+Y1bVtBIH0YGBu35+pKgf6E1FBfAg4bkoqXzj
 TfP6wbrRq/7KRLGUS8oPpMZoCdeEtFGnf9vxfuuhHdnYAEZFbBYZdxzunGGwLQpx7kAf
 UTAhgQ2yCx/1pmKlJeJBOSfCoy6nWK76dLUqt+PqAr6swbtP8ICdShrhGKFpmRPpth3Z
 jisUCdNrAwRbAbxOB/6d7vcEPnBcUTQyeONYVblaG6IvtvE0k78JxnXmdaepi1xRfbR5
 rTwGwuP/9R8+glrxz089dUcOmJ4YmFH/scpovPBqKTcG+0XQxbx4AZ3utzkair70x6UY
 HkXQ==
X-Gm-Message-State: AOJu0YxsOXmjCgobUAzkLZjBxn8mfoOppbA3RKJKDWZ+3X/7n6ajMTPb
 UWkaNbit89eP9ukon6HbYzcO+QjW30xq42GsuEjsR+YK
X-Google-Smtp-Source: AGHT+IGNI/UA0/HsAPJi1N1+lJJ4fS5E+DPAaWcalUGw/Zu+aQjfTh79aCru8EWg3q2JvflV6jTrSQjnlov8mXGZFCY=
X-Received: by 2002:a05:6a00:2401:b0:6ce:4f4c:d475 with SMTP id
 z1-20020a056a00240100b006ce4f4cd475mr13774019pfh.3.1702397692117; Tue, 12 Dec
 2023 08:14:52 -0800 (PST)
MIME-Version: 1.0
References: <20231104214743.308722-1-festevam@gmail.com>
In-Reply-To: <20231104214743.308722-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Dec 2023 13:14:39 -0300
Message-ID: <CAOMZO5Ct9qOx=_zqbGgaa45O=tjNAgqiASnmTr-9MNQY3X0g1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] pico-pi-imx6ul: Connvert to DM_SERIAL
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Sat, Nov 4, 2023 at 6:47=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> The conversion to DM_SERIAL is mandatory, so select this option.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks.
