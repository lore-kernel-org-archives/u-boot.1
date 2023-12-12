Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C62C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D64877D9;
	Tue, 12 Dec 2023 17:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hNY0I8tO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 613E486D33; Tue, 12 Dec 2023 17:44:30 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 509B5871DE
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d2eea4af93so9878885ad.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702399466; x=1703004266; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40v3NtwE3sKXyoytrNOHq3d18R9tNwHClLtGAiGoeP8=;
 b=hNY0I8tOljd+eLVoNbyfWz0GIgmerL8B4zWRcj8lMa/x/O/mNMrsAK8lXS2+tnJdze
 h+ifNmVymgFp9gKvTr9nPEKvLMN07fVmnOQdyMHTKPqaNAcPd8TniHWwRXVAS+KoXc1h
 6sG7YBZ/EAABznWfUJi046iTnB+UuOAu7bjal03vaYB7ho/Te/qUwMhQ26ZaCFFfHhnN
 re6Ei+q/VYez1Sh2HHMHV1YdJQcEXV+2qwIWHcEb4Kyv8cWgGQxR0nvKYKjy/UiH+uIP
 P1VqQZf7EODtaH7X01ncovVRJYer5kcvRhQ7OkLF//wMDtPIQZhvMcYotyIa4nT45BD7
 ueww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702399466; x=1703004266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40v3NtwE3sKXyoytrNOHq3d18R9tNwHClLtGAiGoeP8=;
 b=WUVUS6Deoc9egPJbHXLgZKxKDSkpaFkTcIyEfY9v1ThainNmueSte0J4cb6TsfHYPh
 6Nd9FD3Y4MXemZzbx7LQWbd07jeMevvIY6rSBmaadnVnyPCQvM6yllBTq5xmMY0Ahz9V
 uVFYeK6bqWFKthUFUGM1rbtFhlNzS/Pcyj/QPJHUONcuG8afQ9HXHTRl04g7rLNfyUtF
 nVLQGhj5wBXzoTlpS71TbtKGngc2C63mdxPAjxkItWc0XHGzaHiH/xMoaRHUHDlkuP2i
 XSFwaycW3kJ9oE7BKnhFLEwVFUv2HY9CFkk6PwcNqLVErm3P+daUkjJ3Qz4y+ExXY+xb
 pZkw==
X-Gm-Message-State: AOJu0Yz6t82YDLfO8JtnQn5WF9S2ETwcjjnQ+Xah2dcB/OQLz7DIDupH
 ZJ1nAGbor/gb06Oq5q96lDT59mRsb7DLnX1lbn0=
X-Google-Smtp-Source: AGHT+IEbPrlbmLuMHqSqikQvGv5agEbeUoqawTEnpDUS5GdnnRc1C7V4lqebgJIlbbfdawOULNl6DwwFohGXG+3IvDM=
X-Received: by 2002:a17:90a:c08a:b0:28a:dbd0:81b2 with SMTP id
 o10-20020a17090ac08a00b0028adbd081b2mr46054pjs.3.1702399466608; Tue, 12 Dec
 2023 08:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20231212162046.744484-1-festevam@gmail.com>
In-Reply-To: <20231212162046.744484-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Dec 2023 13:44:14 -0300
Message-ID: <CAOMZO5A+4xuXeOP2ezgHAG8bgHj0mUFvskEEOXzntFt4y8YKrQ@mail.gmail.com>
Subject: Re: Pull request: please pull u-boot-imx-20231212
To: trini@konsulko.com
Cc: sbabic@denx.de, u-boot@lists.denx.de
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

Hi Tom,

On Tue, Dec 12, 2023 at 1:20=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> From: Andrejs Cainikovs (1):
>       apalis-imx8: add USBH_EN gpio hog

This one did not apply cleanly, and I messed up the From: line (it
contains a double From:)

Could you please fix it while applying?

Thanks
