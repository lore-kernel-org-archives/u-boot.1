Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BC8C36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 12:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9264803DF;
	Fri, 21 Mar 2025 13:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eYKeoV+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F302805C8; Fri, 21 Mar 2025 13:31:57 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DF878001F
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 13:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-543e4bbcd86so2112608e87.1
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 05:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742560314; x=1743165114; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2719QJrOzWUYYAY0suqbO3jHLrfmQvFHiMbH82Epxag=;
 b=eYKeoV+nfgj+6Ui1VtDBruSUTyOLOyaM1e6tOj+lbKO01YeC0a2I98JVJY7W4M+++U
 29JcRS/+INfVn5+WQeNEdRsBEtRVsZaddvhjiOKEGlpW3ZVqDiT4rEjaNxRVJhYr8puM
 Zn+mVmm3qMZHsKO5XhWlGcY++Yl2zbE2W23HFthQoSkxTGiMyzlg5ntjgGhGQ7MWaXfj
 I+WX34iY9YM8P9+elVULcottTp6SUa3BT3r2n0WEOt17AYK/KfKvW1Ukjb/5ZiUGZZOa
 DJZEBLLTp/ZZUfElVKJqpu9Du1BOMat7cd58oYn+k/PzI2Jb1XMRYcgomXeGYtBuRzqM
 gsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742560314; x=1743165114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2719QJrOzWUYYAY0suqbO3jHLrfmQvFHiMbH82Epxag=;
 b=qPBoi/A6ohkIG3NMxLSaJ4aMq6LbutFMiRo2bKGwUoswRg9AcJpBcJsWBvoiEXvnkH
 YPnLulc5kLTMxCBn5FXtgsN4eJ43OuLtz2+7XczTDtSeLaZG7E3VL3jAGK7n4QgrPqbV
 dx3tfWM+lIcMh+u2VutiUjZ66p+C6EuWW0mpSO00fD9tLQgksUTQ/Pehkd+l4tXCpJnz
 jLpKUM14+xOvhfBTK5WPSsPCtwuDa0b9EvTdRJjw+LYz4iSAgLKWETLXs6EJrpu00r4S
 4fuROx0r2U3kalCtx100YyHv8+i2cVhWL+2DpS6GoBO3L4ciOXEAKkw/tTkuQUqLehUt
 QAOg==
X-Gm-Message-State: AOJu0Ywn/wACL/uRygDJy4Dedkzu4WkoD8VNBqA+G6U2A9I57R+4bHDX
 dflDrWbBCqc7KBs4QqjgCD2rrDUx7tfNdONW9TkZ6U43kUw7QRTRRo9fXa9/5ubdqN9dS6cP3R5
 KVj4YkEojozWONIVYqQCaEKr+HHM=
X-Gm-Gg: ASbGnctFSEssHStgZsMQX8DZH0dNJn7aBdQjR/ikuSxvf5Zb3vg7LigmKaaY0xKI8UL
 MdS29Zrtg3E+dvreZkiSyRGTEnbMoSE8zX84MygshcO8e+PHKBLi/jgFE1D5l6OQW/ifl+d7WOR
 Ub0M7PnkqOweMcxrNrU0+c7B4EpggXIlv2XHx+LUDdow3jAysc6lw9Nu8rvg==
X-Google-Smtp-Source: AGHT+IFHVZfVF0ZamttRhkBKfuEUWO/BaEWJcMydHe3rQ+EkytoXvUUJL9I7fZVSfouT8OEBYn9dnA/Fo6e1531jWEM=
X-Received: by 2002:a05:6512:4006:b0:549:31e4:9ea with SMTP id
 2adb3069b0e04-54ad64facaemr1221805e87.52.1742560314034; Fri, 21 Mar 2025
 05:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250319072520.100555-1-aristo.chen@canonical.com>
In-Reply-To: <20250319072520.100555-1-aristo.chen@canonical.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 21 Mar 2025 09:31:42 -0300
X-Gm-Features: AQ5f1JruWIaEdXS2gh69tTPvR6f8py69j8O_omxRWpkL6Jh3xOW0rV3S6tmpbR4
Message-ID: <CAOMZO5CUqgCpeggXQFBh9+TQ75LRJxCRXrW2uv8UFTtncFJD9w@mail.gmail.com>
Subject: Re: [PATCH] configs: Remove duplicated bootcmd 'mmc dev ${mmcdev}'
To: Aristo Chen <jj251510319013@gmail.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, trini@konsulko.com, 
 aristo.chen@canonical.com, festevam@denx.de, marex@denx.de, 
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org
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

On Wed, Mar 19, 2025 at 9:40=E2=80=AFAM Aristo Chen <jj251510319013@gmail.c=
om> wrote:
>
> The 'mmc dev ${mmcdev}' is defined twice, so remove the duplicated one
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Applied to u-boot-imx/next, thanks.
