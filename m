Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AC6C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3942E60648;
	Mon, 27 Jul 2026 08:16:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qQGDVZrnwKHR; Mon, 27 Jul 2026 08:16:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70D0D60627
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785140210;
	bh=GGKuQ2lQ9+uNkXmoaQlRRRa/b7ECeG7ExnYjFPnhOZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iWCPRUvRM+WL9NwCXx/pCL2y6X6m71eHLzTLA4rOC+5ZVS4OhPhmQRVhUM33m26wa
	 R1E3WS63quixoYOKYiZ6IvmvwHGkpNthxkPz/gY76rXSNPRsGB3s2KSSLaWM+prIOz
	 EowdgMkdQpZ5ODYzRkoq0/UcsuL5hBbbpPb4wKorRFuLK5m2+NdGQIHiRffR7+aYAd
	 cyrzsweynLL5BANWeZ1ARlz7dYwwZJjI9HV3FC2NuDEk9lnAzZgaXVceLODJ4RN6AB
	 ezZsr34OJ5UfBdXD4eVVkR1mFbCqEdwxS+MsQOrYpxJy56fkATOHr1HrFASZQoItI8
	 JFOxbulr8eP0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70D0D60627;
	Mon, 27 Jul 2026 08:16:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2603E39E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0CBFF60627
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:16:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Ob6TQatfhIu for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:16:48 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0007960602
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0007960602
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0007960602
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:16:47 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C16284671; Mon, 27 Jul 2026 10:16:46 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A096D82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:16:43 +0200 (CEST)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-381216921aaso2277787a91.1
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 01:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785140202; cv=none;
 d=google.com; s=arc-20260327;
 b=d4TPyY7JWp87kEwtDDNQM0nk9a3u4SFnOC2J1OUZ/RiHQ+QZED/6dn14KHYE6RGnha
 aZoX9okPpYfuMUo6PWT0npPsKfB1c1stPn8vS4WnraqiFpKMDD18cnbI0sparh9lmz3v
 n4ONwo0TBITpkaPfDxYW1kjJowrUR+Z/Z0Xf0yoO6gHwgXSbAj55BC65yV5cnb5OuYiG
 Bpr0C2lnMBEtW6k7+F9c7jjInlzRFBOo+1bLzCeH3HNiL8pd2Z25nmMedahWZiAo71pn
 QhA5ZWS6fkzK1eX8D0BUj+pM4KdRlJY9HYmuv+BdgRMKN4CsT83aVmHjUBprspuXVBjk
 2A0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GGKuQ2lQ9+uNkXmoaQlRRRa/b7ECeG7ExnYjFPnhOZc=;
 fh=HcJf74WYQkA07iePBtzQ/sdK3OJnQEqx1C9KsWDtNtg=;
 b=rInxRilXzaEmwp6LX9Bkzyn1b/PnLTHD4lTj8vZhXWeR6Z/3UKDPemyzemn0TrfdFg
 aogu01r85R03QLlh3rGAVtrER9ehBk/RyjmdO/ynNzI6u4kTtypTIW9mpTngwyloyQ3n
 t9l2O1m3dBQ1Nnv2PeJz/XHppP2CbDfOzMwokYdp3nI/ThvtkYlk56EsdvV1r9lK9HEb
 lU5c1C0H+6DMMKBDJ5HSiJ8f9DJcZmxEh2NShrxC2C8w5gYMa4PEcnDNr8i2FmmpaKLr
 oT5qT15cBgn8xCnY6FBxCwL11s2LVVMC0wRnoYY8Ac83wC1K2+1mXpbX6VgiYlA/zr1J
 KAWw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785140202; x=1785745002;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GGKuQ2lQ9+uNkXmoaQlRRRa/b7ECeG7ExnYjFPnhOZc=;
 b=R/jLvsEV5HAO3jzLSXS3YyhohW0bN81ptSwvsmlUEmKrn7nQaX/Qy6za76pKJtvB02
 0WN4GuFpgE6xiI/xF7ZS5Cs3/J+Pz5dl9NO622l6LlHjPT+zJ+D4EHcv5GwVOdH8kEqV
 ju+I/mkBItXUqAgOsBST4uBIDqBN8aPHRVUQbLpgRmXn2M9CKJV2mOfXQJ+Rcz9YTi8t
 MAmq7YYIO5QLASJP69Ora7oOrJl7OnUYtl5PNijCHwXUcNv3aEEQI70BEM1ZZcH40V2K
 H3q5tagKszDuEEVl32fMxuaPm+XAKytE6Fztt7cHKP7kiapt6Brhmnk2WZR3OOpnXStc
 j14A==
X-Gm-Message-State: AOJu0Yx7wLLtx684Dn3+eZa6xjrbUazJf0X7Igyw6uLJorpUG219iQjf
 jKQ0hVNW4onSogWo5iL/0HEG1Adcsk+CmNUDw7P0uNArOvLNgXNjYqhFysCEF+ELeVCxvCbqxpg
 YoGkKjEx2AgsT0/svz9R23KdRm7Sjfgs=
X-Gm-Gg: AR+sD12K9eYHNzPkgbY7tc8bdltyxjQv9lsN08ubB5nMS4ux5nKQ4MYMZbsZzYzMSr/
 k7z5xBm9ciyCX9ZONTf0lpWIB9O3v/BHAvWtL/uClXfgW0O7pQl5wTX0aa3ukr/RW9xZ7exNOBC
 Hh7cuNDD2e9YZytaOwK1IvQvNaKqS3Ba55gplQGs0c/d1DS6hmiHWRigqw5WVyG/quXfAlYB41L
 53gQ/iVE7AAboShI9fFVhUitFroWS6cvQFzqU3Qdxaf4/7bCs0Z2y63edjUdSIWxZSUIthSPqFb
 1HYBVJtl0HuIyqt8O5A=
X-Received: by 2002:a05:6a20:3946:b0:3c3:875d:705e with SMTP id
 adf61e73a8af0-3c67dc46c38mr7150562637.19.1785140201855; Mon, 27 Jul 2026
 01:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260722131626.77086-1-advaitd@mechasystems.com>
In-Reply-To: <20260722131626.77086-1-advaitd@mechasystems.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 27 Jul 2026 11:16:30 +0300
X-Gm-Features: AUfX_mys1JCTJYfQBh2QRbfmJG26WTAt_E0wAsRwarjLShFZ-J-4rsC1ht-QPNI
Message-ID: <CAPVz0n0foVmCUN7REcYgcrthCO-uK_G=qw4kRUSvt0oW_Mro6w@mail.gmail.com>
Subject: Re: [PATCH v4] video: add ChipWealth CH13726A AMOLED panel driver
To: Advait Dhamorikar <advaitd@mechasystems.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785140202; x=1785745002; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GGKuQ2lQ9+uNkXmoaQlRRRa/b7ECeG7ExnYjFPnhOZc=;
 b=OOEy1oNdRorl8tiMZK1Pc7LbyPkwuC9ZCHy40Ftu4XMdBhW3oCigfblKi7SimHA7hA
 AKdAuKHWJK1/FJ+1PrKbpK2Eh1TiITukmAnbludWdTWnZltSrd2/ASY0J0UQXcBdKIpF
 UfnGfsjx1DPNwx5YWCCWfqaHypCt0F6noGf4gLgkZcOuLYUACXdoP70NylD6MqbKcXiv
 l0SaQe6OMYBygzbKVbhOimlqPZndRKCUhgN+YIav71X5RRGzbjdI9IwHRZeAPqtZjOfY
 djRmNtrGkNgaOA8+57yU9djh0BfjH23IWZ1mVA4BJJXoKj/LYXTG53++Sk9rr40LqYAJ
 L6ag==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=OOEy1oNd
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=clamor95@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OOEy1oNd"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

=D1=81=D1=80, 22 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 16:19 Adva=
it Dhamorikar <advaitd@mechasystems.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Add support for AMOLED panels based on the ChipWealth CH13726A
> MIPI DSI display driver IC.
>
> The driver configures the MIPI DSI interface for 4 data lanes in RGB888
> video mode, performs the panel reset sequence, sends the vendor-specific
> initialization commands required by the controller, and enables the
> panel using the standard MIPI DCS Sleep Out and Display On commands.
>
> This driver is based on an earlier implementation by Pratham Malaviya.
>
> Signed-off-by: Advait Dhamorikar <advaitd@mechasystems.com>
> ---
>

Seems fine.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
