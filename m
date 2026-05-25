Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2521BCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6472848DC;
	Mon, 25 May 2026 17:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eCUKRYAk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D166E848E6; Mon, 25 May 2026 17:27:54 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9BC6848DC
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bd9a71b565aso1079944466b.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722872; cv=none;
 d=google.com; s=arc-20240605;
 b=bwtnAXWUAz/C0EdEX98WW7RoNLTAGxy4aMEtM0vusGh/L4aMUrs8boDiDJxxsmr8Mn
 5y3HIy6WJVVMoWOxdd83Jjv2WBaZJWO5a0anvdaQ+1Bz77xRorejBMT8lSV2iibzCr2W
 KJlRixf3Tjn/d1tQP/LpaMqstc5dgXxEQrWoCJ6CjmggU/T2kg0zrzzaNHeTq/vmd6Ry
 7O1AEmrAcBCclUzbR/woO2YaFDXt1ATKjM7AgT6crZ9xuWEdD1uKXvlKWQfSGIDgMbMT
 ZrKswGaKgwROcuZZ2U3f3stJ1Z+Hk86t51lsjyd7HApoQjSsJ/GafZ37mLwrQEzdWn7o
 f3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=duRJJnWl1W2jTMevvtpBzUN3/pVbyIIa7RVJd4+i5iM=;
 fh=uHnctjfjo81NP+4b9H5aVwcI8F1nm2RvYATNLKEK624=;
 b=IWYAWIWfv+7wi0aBKbV3/wv9fDfoTJtrdLXEPGXIMECJQ1k8jGN3wp5t1bx7x6G87d
 W+CW+lwYlcrQJbmcPwogPiDcj3ZgfRnhHxqUTr7Vk/IVGETs0U+AjqocMnnMNTcCgOhO
 f1IkQQkpYUIV2WcNoPrmrOfOmDB9ylNad9ZeEzx7L2iDgfQlefUJaVbBxieqoTwhzQsA
 P9mGtj9xpdo4zUQfKTQLs73GsDO/Qkef/sAs566o+Ne5nD9gk66yemFGBdq7BTHIXFCB
 mPUuiX5h8iVgwd7CQJf+lg1AO/gIqfwTjoUJO2aA1GpBH73mXglNvMKHXrxDuGpvt0wF
 TjcQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722872; x=1780327672; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=duRJJnWl1W2jTMevvtpBzUN3/pVbyIIa7RVJd4+i5iM=;
 b=eCUKRYAkSkPlQZbgi62Jk3HidNH1RiixljeeE+IZpg7pSIdmbAje4GF8kyMf8WtKk8
 nxC8gVUEjpWCr4fj4w0EEebzsv2xw8IoJOTVAm1/F3g003IGaK0ugMlqVDujw/xtbGBg
 h023/5ih8GCcDsseXrdZlu7SaUw1LDVji+zwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722872; x=1780327672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duRJJnWl1W2jTMevvtpBzUN3/pVbyIIa7RVJd4+i5iM=;
 b=SqwIMC6xUVALGjxvmK1Y7boIQEw8dyPS21V2Ut0nUN/9zhAaFUF08c4b25oTvQaotA
 GR3hamaQz4aX+Q+KOVAurFBz99z2j93JmrYyOMuAKMz9xJ6OANqHfVWqVZ/VcYWUUduI
 H4qvvejrF88qiFLk3IsrPBWbU7fWGhbUfKUBsy3oWzY0k+ynwZwandeJb7CaFxb38pRW
 aiAMciBHlg2AmEBCCb0qD/Gn/4mW6j2K7uFbcPwzAllXALo26pR4lZ/0T1A9pYLd7aqB
 znyYa8Ezzr9fWnlARXtjZ6QuXJtR5meFZ/xx+Wk9rfJf1dlWNh5AUuAZ2upukGxGNL+X
 do4A==
X-Gm-Message-State: AOJu0YxCkS5QN904ga4Whngnk0foJ90rCDAYFAlqz2/hqdOcbQ9piaAw
 D2E04pWe1ooyQLczf5uFSk64VKwqw0rY8vtoRA1lr3eK33v8jymNbJzqaWWpLQD5HNAORQPgqip
 ve8v+hnhkZ7YEir7yBdOsV0JXIDRBJ+eGH7yZDDQP9PnMwvGFQf8=
X-Gm-Gg: Acq92OF/5FjsP5oleLBBKtrbLT21uYqW/5YzdQhP6O2Fge+NiTISTDIcKs13LUReE9k
 Z52cTSsR0jRTV/syvCBFmvM1RsCJH8uuPHixRiHsF0Xn6WPhqRtmMDL4PXdegwyVvdZJeMM2yS+
 KYqXiBuiqReDf3edjyZ01CioW9RbH/juPYkE4nyjjvNst4lJrID8Ka8k2GXic5BfGmI98wsABA+
 99bkP+SesUSc8hBlNTj5HBeENnm5s9zGOPLfaqmn6jQ23I79euFU7GrkTSt023DmEtCzhwhLeDA
 xMEG4j10k1gFhUEO
X-Received: by 2002:a17:907:72d3:b0:bdc:ac75:73b9 with SMTP id
 a640c23a62f3a-bdd266bc8e8mr876472766b.43.1779722871652; Mon, 25 May 2026
 08:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260519225458.5587-1-ravi@prevas.dk>
 <20260519225458.5587-3-ravi@prevas.dk>
In-Reply-To: <20260519225458.5587-3-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:27:39 -0600
X-Gm-Features: AVHnY4IkDW9GXub3Wg_LHMeTT90WhIjjSxDpWonv-OaM5Eb4P10sxaE0bExioBI
Message-ID: <CAFLszThSNLeKdGko48Cenf6evwCpODfnn=iiKXYZJZ-BMwJaHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] doc: develop: add section on embedding scripts
 inside control DTB
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-19T22:54:57, Rasmus Villemoes <ravi@prevas.dk> wrote:
> doc: develop: add section on embedding scripts inside control DTB
>
> Add a section that explains how one can embed scripts in the control
> DTB and run them from the U-Boot shell, the advantages of doing that
> compared to using a separately built FIT image, and the configuration
> knob that must be turned on to allow this to work.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> doc/develop/devicetree/control.rst | 58 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
