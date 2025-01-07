Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4B6E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:32:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0FE803DC;
	Tue,  7 Jan 2025 16:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="crJFOfCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB7EE80601; Tue,  7 Jan 2025 16:32:32 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B578036B
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso17044202a91.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263946; x=1736868746; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DE0VmrPC3nSM/vEPPByst3R5sF2S7XJDzALlAW9KW/M=;
 b=crJFOfCShYKnS1ouoCZIbjjVpEfT/UkCZ18RGGAjINrCEDZaHEGYSeDJJPBmiSq3XL
 rsLmmshmvt/b0Ww8P8BR9VbjAev1U8dGjX74JiP5eq4mzMvFLWtcjtaB6SZyftTHCJIK
 YAwqC0rvpqTKA3MrIQn19Z/quI4Y485+j1Qio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263946; x=1736868746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DE0VmrPC3nSM/vEPPByst3R5sF2S7XJDzALlAW9KW/M=;
 b=dYYynmTwCy8bzhOqDRSj5T3g1660bMX0wsyh8sGkeTje2FNA1Tcjni5kxQSW8IJxoa
 G9FiTDYzXxg+4mHOkjQz9UPuDNxVF70ArDE3ltLS1TMFPlTu/Q5gk6mkYSFOgJrwKWQ6
 oAox0FOUxIyi8VntlBEs/kDMBLNdzl/WP2ZjoeGQiC9JiC8jCd3TiitotCn5V3e+KH8n
 cM59x8kiifyfw4TKdq7fnPTECIolf/WB4BsE09N1Za9EkaYKUuL4SkHbI5x3c+MOaAXt
 ASVrwj0xMfFXAkvRyWeL//UqCPei+X4dwYQGo9bJ8SI9JxDYRND0tPcajLmkChJ9WcK6
 eyFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4TKhcgCo4X7PJgP1OHC9kU0IAwI5Uvg1B/vPZw3d3dLEbwxl8lnKfd5AC8A1jLNjqNptO1jM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxn6Osi1Q83IrzQlP1wE5XFJWKWUUZ5yGrYUxTIYI3xagXXYqe7
 JrYh+hqXKUuirc1AyCuKPwNM3vWNmaarqUgNwLa0ejA1/StqUoag9VXsbZbovRXwRf5wiks+VhX
 HaqM02B8zLNouhUBqPSlgQ2qqbocdpvxoJBbR
X-Gm-Gg: ASbGnctpXuEVZp42eVKyXUa4JdQMycUAmb/Xgl8XhdX8v+RkOC3svL3HgOQoEscuiNu
 PxkfJy0y8GSlO90VIwNLZA7Y1tS8KbolMHDlp4NY=
X-Google-Smtp-Source: AGHT+IHMGd2tyJV3LS9qOjh4/5akDlULTwkesfpw5zsLXjpW1HZ4uZbePAlvwC/PnvkXShRXaKgI21z1MH7OGB+aXZQ=
X-Received: by 2002:a17:90b:2e41:b0:2ee:af31:a7b3 with SMTP id
 98e67ed59e1d1-2f452dfcd53mr95329573a91.7.1736263946608; Tue, 07 Jan 2025
 07:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-9-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-9-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:32:13 -0700
X-Gm-Features: AbW1kvYoS-UNguYmfLQom7TnCfbDiboWqQXk8fUYaKD0pewqI8BKgj_6swUTl6o
Message-ID: <CAFLszThLZQM0u56SKYL5mV+eqbHctQBDdVEy9XN8WZw53M7o3g@mail.gmail.com>
Subject: Re: [PATCH 09/15] soc: qcom: smem: stub functions
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
> Allow smem to be optional for Qualcomm platforms by providing stub
> functions.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  include/soc/qcom/smem.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
