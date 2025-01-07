Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE906E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA83D80601;
	Tue,  7 Jan 2025 16:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XEC05PZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB6E180607; Tue,  7 Jan 2025 16:31:04 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7418F80607
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21a1e6fd923so13936975ad.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263859; x=1736868659; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j8BEMIW2G5ssdDGvRGxY+wWdNz05LTstOvlD+o+pjNI=;
 b=XEC05PZmvSJ0HXv/vVKqXkxqe8R6xHNTQJ6xXEy84le2FcOM+Zp4qluOAjHQiS8Jxg
 Z4L93RWsbGr2mTXZbN1Yn2Lg7WtIyK5phXU94UMVkq3TzamevJZvs7WhPpeGqdWA5Sgu
 nbIW2rAQgjx1dMQOycUeNuKz5iS2PEoM/Vy9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263859; x=1736868659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j8BEMIW2G5ssdDGvRGxY+wWdNz05LTstOvlD+o+pjNI=;
 b=E5ymNs1wibkNlVv/zB8Uujf5tV8Nqe+eGNcpDzwS4sfUCjaRoL0zvavOa1UOJ11HD0
 EBiTaHJx6O0LOib6Y8oJJfd+8rLL06d55x/VlUT3OP1QXq+IkhS83KeC6yE96YvWb1G0
 cWGhUYZCHdZCtrZHJBok6+6XZqYLmPHTHCvNlQfS9ptn9rpoxcqy8dzruZHSMgiBBL1v
 yGSW8kT0r9wDDnukLU20QMyw/LsMwgkdg44q0XJnFq0EWNj4/TJ4lyrWPgzRd0Y7mUGv
 dNXeeDiKGZHfnYnE8uej3Ob+oJl0jOWa2kDlmZUBwxx2bYbbgyU+XE0ZD/qK5nNVlRJL
 yC9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV66R7AcQ6+o1amesdxwFqyf7pFWWLkYu35qGqFgGL5u6F7J+57xyD1JiunNo4gbz41NanxjS8=@lists.denx.de
X-Gm-Message-State: AOJu0YyR4Tq3s8/K9nKifm1cIas0/tMdH0UQqy+GLrBlLnPUGrxYACE9
 5tVXr2a0lJMLrDcr4OtX6exopENdIQLw+YQVW1LISTVoysLSIABwgqVmJ3kHJ8d6w98i1JhFjrh
 RGNfcI6IgGCgnX34rGft81gZVNFiNo6XWTf4h
X-Gm-Gg: ASbGnctUAGX2rjMauk0ozg6vIVsFW6qWRjiBdGz0tQ2G2A43TSKL/n+fmShyRkWUPLV
 U06qz/Eqxk8XZdFJY3/PtCtDVGkIcsPS2D/ZmHVo=
X-Google-Smtp-Source: AGHT+IH0zkbQZBNf9L9WPPl99BvpdHpwjMJtdX3NpDtf6WG+i2/SwLQX8JeR8LO1sCcHyk/DvpcunfF7lf12daxMw9Q=
X-Received: by 2002:a05:6a00:410d:b0:727:3c37:d5fb with SMTP id
 d2e1a72fcca58-72abde8461bmr83933634b3a.16.1736263859037; Tue, 07 Jan 2025
 07:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-5-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-5-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:30:28 -0700
X-Gm-Features: AbW1kvZFlkz5ZcoA-yNhz3BxwUiPHWmoPzUeID1CRrxJgSw3JdnHLIjPWdSnyew
Message-ID: <CAFLszThqZzZYyQ5utstK1RO-nHbvfEELDmunsCZAgQbHqp=bnw@mail.gmail.com>
Subject: Re: [PATCH 05/15] soc: qcom: import smem from Linux 6.11-rc2
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Sun, 24 Nov 2024 at 12:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Import the SMEM driver from Linux.

Which version / commit hash?

>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/soc/qcom/smem.c    | 1279 ++++++++++++++++++++++++++++++++++++++++++++
>  include/soc/qcom/smem.h    |   20 +
>  include/soc/qcom/socinfo.h |  111 ++++
>  3 files changed, 1410 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
