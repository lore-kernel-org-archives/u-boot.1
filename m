Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137C0CFB446
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 15:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A9A18870D;
	Mon,  7 Oct 2024 17:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OkkDpwtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C7888D38; Mon,  7 Oct 2024 17:23:46 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4165D886A7
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 17:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cb2aac40faso47108766d6.1
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728314623; x=1728919423; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uPVWzEK+BW/ZxCZDSFXp0ezL7BvM6QVu7xAcwgqKNeM=;
 b=OkkDpwtF7bYhbf9G8w5YsdatT00Cq9xOnSHG7U5dmSBaMJJ8E/8cxNo1htZXrywi7U
 LMQtvWpHavmERXs9gKlfy3+OFQ4yz6YKDlDaekkOBJKcsZwEaI0Z5Yq7UuM5YFjRMcMp
 1WMHcTuYEuBCtJX9eyVFCF1GothD/NHFZEqyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728314623; x=1728919423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uPVWzEK+BW/ZxCZDSFXp0ezL7BvM6QVu7xAcwgqKNeM=;
 b=E+kDEtfqlDmGat54tgza09h7Gw1qS4op2Gfkxxku5s/JgUEziMQ71CbbodoLxzmwWD
 R3EiC+XU8aUDoDFrHyiAiXCzjFXZRdKaGk4bT5mA01LMOZpkm5Qu1EfoaWNT8xPfyZAU
 o8TpUdx1n9RmJ6RCzpoDOLEz7EaP8ZRYWnQ9WYLfaoyIGDC7bODg3xkGxaGl0OplUZuK
 ywnnsoEmfTS88WT+qo2kZIQ1TezXSVjqAt2kqCFN7JVGsul/H9Y4fH/yZsXHgoxPZEyb
 vYvBVj2g3huRO6QRJqrq/AaFf+n/GOMY2vg5JeodtHruUCTT8Kf7R4LjLILNE6ed2kgs
 Qilg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKpWzMpWD3Xfxx1qrLFPfgSKFEh/0hCH6FHxVq2vNXNou02boMRgpC41y1eXwHFRWXdkXpRCI=@lists.denx.de
X-Gm-Message-State: AOJu0YyCW6fjvITqch+qBHFH6Cq26NXOmmcpNoVwQK3JSim+QTrue7EN
 FRbLX+j9l1Aep48t8A5ZJw8V+xWCOoQTBzJvg6VTFm55EBqSKr+wGxLo2TG4yjYn6bcSLSxhdZp
 Tvl+VA9VRJq4f9p5KuBuwi6JlR1XMXpxONFhO
X-Google-Smtp-Source: AGHT+IFYoCWdZNxdZZ5tJSXQg4dnLe6hpvQdjteYBbjgH0FYOhVBSjNyR3WKT9nljSbEbxMZ8eW9XxZX31LW5ljUnFE=
X-Received: by 2002:a05:6214:262f:b0:6c3:5338:9116 with SMTP id
 6a1803df08f44-6cb902da924mr262543186d6.23.1728314623123; Mon, 07 Oct 2024
 08:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
 <20241004-qcom-phones-v2-1-c7ab67ac3043@linaro.org>
In-Reply-To: <20241004-qcom-phones-v2-1-c7ab67ac3043@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Oct 2024 09:23:32 -0600
Message-ID: <CAFLszTidEE2km0Lrha1Na5O4fnpTYcDVo8WwAz_Rrk8JYFR8MQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] board/qualcomm: introduce phone config
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Fri, 4 Oct 2024 at 06:46, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Phones don't have keyboards! Introduce a phone-specific config fragment
> and associated environment file to make U-Boot more useful on these
> devices. This allows for navigating via the buttons and enabling
> various USB gadget modes or displaying info about U-Boot.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  board/qualcomm/qcom-phone.config | 12 ++++++++++
>  board/qualcomm/qcom-phone.env    | 49 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
