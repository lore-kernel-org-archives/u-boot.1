Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB42CC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 12:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35CAD875FB;
	Tue, 31 Oct 2023 13:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nEjkQtPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F19C187C97; Tue, 31 Oct 2023 13:06:21 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE3D875F8
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 13:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc2b8deb23so5570375ad.1
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 05:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698753978; x=1699358778; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCZxc2xyr/ljJtKHYRuxc6hCdFaNim9SRKX3U52WpD8=;
 b=nEjkQtPU4+il7GuwrOGEWzF1HEz6wUJDSRlB1v5kju8COhbzKhAU3sDYYxpgfnS2iz
 A4VBP4WPpW4zLOewTVm/ZSekXOafPxOL8Pl+nfqr4PkrZVMec/WYRvLPO1OvI63Tq1el
 gVf34zGMeW5kkQaHiY1yA28glW95rntlTXjUIckUIyQgBaNFHVcU6aG/bLCkHZAGmSm6
 Eudjba3sdbriWVcvXoi//5Au0gNeArfy1MEFBOWOhGnNppKIfXq683Hi5glufxsS2+IB
 2wknwrDJUjnA/12YKLrA3gXEnlXJEaudkC2LVVsqy+LBJeA2+Q5gT7XUZ1eCl10LfP0u
 0GNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698753978; x=1699358778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YCZxc2xyr/ljJtKHYRuxc6hCdFaNim9SRKX3U52WpD8=;
 b=u9ROgLA7U2fkEQ2KRB2rZTd3udGm36vktXMKRauP5aIpJEkXreN7dO5PmxArH1rZkZ
 9OtImQMtq8eO2/H5lItJHLG/BLkV77Y47Ex0YYdozxSzeWH9UnpZBN5VoYVuKSaPe6Jx
 iCPByWjq59W5l6Ah9N61fs8M9a8EDkwlW99zfVNhTFfyaiRGk90bgUn9ZvyYE46jAjIu
 n/5+YgwwHE2FpC2s6yS82fVsBgwyF0OzgyqTI7VJiKdS1B9af9IhPqT8AcI38MVEofjG
 HRdnqOpPUUEnDZUXsI3PAfyuGCD9imlAmHybpG2RzACAWXI7B7lAERa6sJ7QlqP9TKuY
 +2xA==
X-Gm-Message-State: AOJu0YzmU2YZcQ2dLSkPlYwKEd3mZk1k1IATORv7F4yJnEeqzoxqjXYv
 UGPps+m/3m1jZ/WPiCfoCwXuh3HENZUWmrNmuho=
X-Google-Smtp-Source: AGHT+IHTQoYP8bA/c3T+8iGNc36dCIM+dImpeRU+hC/5VJpvkMp7dG3h+B/Re63v0HUskJP5LQh1D5R/NaYeRzKuYKM=
X-Received: by 2002:a17:90b:812:b0:280:1d2a:acc9 with SMTP id
 bk18-20020a17090b081200b002801d2aacc9mr9340311pjb.4.1698753978144; Tue, 31
 Oct 2023 05:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231031101621.24926-1-marex@denx.de>
In-Reply-To: <20231031101621.24926-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 31 Oct 2023 09:06:07 -0300
Message-ID: <CAOMZO5DjnYOouRo9eH9LU6QPXcfSmFByigt4YtTu2KvGAWcj-Q@mail.gmail.com>
Subject: Re: [PATCH v3] cmd: mmc: Add mmc reg read command for reading card
 registers
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tobias Waldekranz <tobias@waldekranz.com>
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

Hi Marek,

On Tue, Oct 31, 2023 at 7:16=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:

> +config CMD_MMC_REG
> +       bool "Enable support for reading card registers in the mmc comman=
d"
> +       depends on CMD_MMC
> +       default n

"default n" could be dropped, since it is already the default.
