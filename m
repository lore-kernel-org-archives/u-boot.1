Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFC9D6CFA4
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 19:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C6883AC5;
	Thu, 22 Jan 2026 20:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JtCS0F//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F07783B0B; Thu, 22 Jan 2026 20:32:49 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E88839DF
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 20:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-59b72a1e2f0so1779128e87.0
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 11:32:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769110366; cv=none;
 d=google.com; s=arc-20240605;
 b=iBKwoTxHeBePFE8hThqQJVdpHBWwyCYMkNAdMuVV8itemvmZZm3RQQBFTIu3Z32OdZ
 l+Lo3simI9xkHsni4vbUuCOdltjXWUstbVXoXya8HMT8gDTpekeJ7Td1J0yVSRh9sTVI
 CJ6QL5D4uMgAfND1CqaxbG2D3JcZcopCp3MAuk4QpG0ukFitPE6PI8EZRZtAcOCVZLPs
 BEjHmdlo61cfJFJpxTyQLs3vBnh9KHXInRE7uSRJF9ULvV0Iic+G0AZ0mwTpj5h73k3O
 QqOcwm1dktlq6/2DwenA+bFkeDsn2n4v4cjR09giQidHrOEqadAbPUxjH8tFPOy0u9R0
 kHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+DfdbMbQwnsaIBicDZh2naVWfCH8fOX/xMz2aal823A=;
 fh=Zozkc55hrw4Lp34Ev8+YRXdX1xDWoI19pHSI9+EKu+U=;
 b=AHBpk6M1mgLkfmBuusxQaidJmfPj310LYibIRos+UNJyCPcvmSRm/SltqsJiAzjua3
 D0qpf5IY9P54ssrHkXLb70SY7wBSAnNZFUkfV5xLhVAccR0ksKjcCfuUnyYbw7tLmfk3
 1LEaQNew0AIT2hnVZg0U2R/aABznLbVzHlRBwWS0ppsKlZ2xpJiaMWVICeO9j7guNfvP
 Mb9HKMYBdoYZ/nB1lU+RCPxv4pnTSVl3rbqa/UcULhzpV2sn8+Xl0/5aefy5PktK6zb/
 yz17SxdUQVn6ARsfeuRkvYqbT9YzaftkiUuaCwKwR5HcyZI+KV1ixvbuWzqKXA/tM8mq
 uoIw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769110366; x=1769715166; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+DfdbMbQwnsaIBicDZh2naVWfCH8fOX/xMz2aal823A=;
 b=JtCS0F//QNSHEyJ1sfuxyCLH+NavHMZQ6vfEcLpqyiqK4ZyQSVsa9TvJNfHjFqmibZ
 xHd2KzulSXmZPyxtMYIEZj5mjT3z7sINCbbWuwdGqxFSadpQ0GL4LPeiy/39cT9hLlUN
 e8ZnvfbDG3QBGpx/SDZKB4wT5Pu5CI0lyzf2EUuqyQQ6VsUq+wKHHoKksj54b04Yn6i7
 lRCaoThKvQjZwI3ogZKofZp8vYxwQMX3oxaTV95TcVbAXqs9FOr6gk1ntMhhsiwWp+bD
 EiDUqOZ/Z/bymisLjaZuT9O0aBJxvYX4qmvfXoXbToI9VBJjui12CTlNq66aPWPz/Zy0
 SCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769110366; x=1769715166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+DfdbMbQwnsaIBicDZh2naVWfCH8fOX/xMz2aal823A=;
 b=Dpe2ROeR2iFqZIbYvNOByYbn604jYyPLMntMz+M6za8tZTRl6SWXbw8QHOJu4XnQJN
 AaO2T+Jx6dgQ5WZ7qnQzZ05X7/pPGOpSvXc/6dCZ8Renj/LZigUDM8WSkxl09dX3rBXV
 5iybb43KlTrsfcXdibB/wY9DV2n2C4uNJkM4GImjle9U9K6xupYoO4LxoeDab/7x/Wx8
 c6UYzUOybDTGjNoRzs3JqnJY8rBaEIg+VMSraL0zvRoUwZ66oPLRbnLYon70qPUr/I+9
 Mv1M2xb39WKRO2sU4QBY/oYWKpkNMy5W1w0/3eUWh3Z2+05Uk5NWuk8LBAYtddImgEIs
 DuIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLUUB9fscv3Ag+KMNhUepY35YDzjC/dPqZr+80UzkA4TEWfib8vWla7zUX+0l9FTcIwKIIb8A=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9YMsSXqZL7Fy+JS1ej/B9YT0UU5319H7edvtKgcRr36g5SaNt
 2GFKxdaL4fT8QqsSfjQ62PNe+JQW46ZpCojkA2j5WN/BhR35jsSUwSpCvvutWuyg5QN1a6GA+AD
 EZ12Pgar1nicrCRY6HlbfOcsyzV7JwcI=
X-Gm-Gg: AZuq6aJmPFZtNc0nocY+gMgJe4DN+Eg8x27cPuQkr5lAt+qiqQxAKTaeroWWoEaXFEd
 q1AaBldHOiH1Po3efc2AuCYJBldzaZbPmRcynTNWwFil2BUTf4GYSZix5OpxlwpG/EWmGFBaOFv
 p47v37MfaPda0In0hEG1tqiduO8JqqToSJWAvs+au76ksDhpnyrxBNaEx8H8BrCZdwXXQxZyxfj
 nJSxwIdkePlbu3UILLfB0yxgm7V4nmna4hWn9vty4w4xW8PjWxd49T1hOmIfkma0EB2O0ZfJepe
 mKYFg2VTPDR0wJpwyGjCUVGz6OM=
X-Received: by 2002:a05:6512:3505:b0:59b:7107:5030 with SMTP id
 2adb3069b0e04-59de492988cmr94799e87.24.1769110365699; Thu, 22 Jan 2026
 11:32:45 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
 <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
 <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
 <20260122142323.GX3416603@bill-the-cat>
 <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
 <20260122191042.GD3416603@bill-the-cat>
 <CAOMZO5CJ4BAi95gjV8a=_W-Wu=zr1dMOoDOCB4yUVAzY2ARBUA@mail.gmail.com>
 <20260122192840.GE3416603@bill-the-cat>
In-Reply-To: <20260122192840.GE3416603@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Jan 2026 16:32:34 -0300
X-Gm-Features: AZwV_QgitrEpZ06ww9w0XRdAHmDF8pBTaodNasa4ZiGDHrYhZ75ZqVFbbuV0ajI
Message-ID: <CAOMZO5BTDZqfeuZib=gby9BWsAMO962XGPthUSUVmzktM8_KeA@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
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

On Thu, Jan 22, 2026 at 4:28=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> Oh, does
> https://patchwork.ozlabs.org/project/uboot/patch/20260122172247.2995437-1=
-b-padhi@ti.com/
> also fix it for you, or no? Trying to figure out which case we're
> hitting now..

Just tested, but it didn't help in my case.
