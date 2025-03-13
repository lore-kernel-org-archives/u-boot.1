Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19CBC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F89180FF7;
	Thu, 13 Mar 2025 20:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ts+IJT6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A51F78168B; Thu, 13 Mar 2025 20:56:25 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962F280756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-30613802a6bso15469851fa.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741895783; x=1742500583; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjJu46hOPkvLgshHHLuWXkEFS5pqnM7FPnkshjvTzxU=;
 b=Ts+IJT6kpHjUBJx5WZ6falQBiw8oDv77cMFINncO5ZGdm2sTFKo2JY6tzVXlqjrwTt
 ic4rzzT8k8eiNAD20xuN24rZYU8CYM/kFfU26n7fjR5GppAqxNlfJ6hnxokZFcH2kRvJ
 s/BiSVVE/vJFAwZMjvKYPTfUmF5mU7p3oEw1ABRrhwD5LbWpCIhTtpAl/uQOPJBRcaYG
 dY8gdi0KPAI3lK+GjnyD5cgfMPANQurs8HXkYXHiFzisoc2otTlh8rbGQJPH4DEsnIhk
 /mc+f2s0jedEzuijvZTZQkOu/ogqGfSfLzt6TzH3mXdz9CRmdIThEI8VIo7tVeRGUR5/
 Jzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741895783; x=1742500583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mjJu46hOPkvLgshHHLuWXkEFS5pqnM7FPnkshjvTzxU=;
 b=XlKqezkt4OK4yy2AS4FjPSPIg0Q0WkmetiugAM5LlQrePDMxRsgVVeFyIIQljjzTe8
 24zCe+am70SnlzLp23Wo2UhMAervyGdyawDG6eKLuIvYTcgYchQCRb20ndp99Hqf7ppv
 cTUwVjlvxx0O92mthL1FY9HGD/cPbmM4IaYqeyf5UsMHApex/YLbmQeeK9Xk1j+DgccC
 Fy2c7dHrznD1bY8knDMy+ezA0zIyUixF2oEjtT2NEOtqvgfdnsWr3+DlGq5gFDfo9bhM
 FUq1/KlLyy61qjcIdD8dkcz2GyJypS8N6012yJ70B6ZkfspccXyZUe+sHjTPFWSSIbpX
 lZOw==
X-Gm-Message-State: AOJu0Yw5jx3VvRM3cL8KNccK1sK5loZZYnUIeZaMtKtNTTMd5+Ug20SN
 0YU6YnOJcY0/0ChP7UvE9JiZp5IT9o81CiGIoeOQkjdIWslDrp1cfDRMhq/8+IM0oZlhOxHtP13
 Zif12hCldTy4QO5uRVCRyrzDIH7c=
X-Gm-Gg: ASbGncsuLTiaVltHLSuezZbONqY9vJL5X0YFgvkovMFdb2a6DTNCXTztwTVK4bS0EFj
 yqH9yQZ/WG+9nKpNBwn+4V/3HTVQoKGSWUY5i4jci2BrbPEOqMZqDJyPC5G61Jf0kbq0r0oJahb
 2IVYF/SNTLqM6AeHVEpClaV1b7TfU6SYp1kfyeJ93kXiwy+UCu5BPAws2Jfg==
X-Google-Smtp-Source: AGHT+IGk10DYHxK9JAkqkrP6ih3jn0yYA6j8qkkCdRuBLz3BdnX16hagZu6DHYRltyZ1bncmBFWfnJ8/FyBY9k3IrCk=
X-Received: by 2002:a05:6512:3c9f:b0:549:8fd0:bad8 with SMTP id
 2adb3069b0e04-549c09eda21mr354335e87.21.1741895782495; Thu, 13 Mar 2025
 12:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250227152942.3966518-1-trini@konsulko.com>
In-Reply-To: <20250227152942.3966518-1-trini@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 13 Mar 2025 16:56:08 -0300
X-Gm-Features: AQ5f1JoTvkDUyMXwexDmVlaYqPmQSYIuN4gqGmsfZm2sPYeLa4BKgUhIsFcwH8U
Message-ID: <CAOMZO5Ax0C=AhuG6pfUq=MW1Ad6z3DNyu9fxvg5KAa+4S+k9gg@mail.gmail.com>
Subject: Re: [PATCH] mmc: fsl_esdhc: Migrate ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE
 to Kconfig
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Fabio Estevam <festevam@denx.de>
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

On Thu, Feb 27, 2025 at 12:47=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> The flag for enabling the ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE quirk can be
> handled easily enough in Kconfig. This lets us remove a function but not
> obviously correct usage of the IS_ENABLED() macro.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot-imx/next, thanks.
