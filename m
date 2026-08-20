Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB0CC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAABE607D5;
	Thu, 20 Aug 2026 12:13:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4o5PH0ygjPgX; Thu, 20 Aug 2026 12:13:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787227993;
	bh=VQH8MJFw7vEZBN8yMCL1Z0s3w/9m3PxBFppVj9MvNCQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ANlRfcYTlHtMpL3N4FgE9KgQ6C9A3kcAIprR1CMpM6Wr+1ik1VHp7Sfw9wjRi/GV5
	 rLfAwwKMmGFtQhQQTO3iFkuycYWWcgGGlNS+S8ti1rXKeHaX9nSon27j3jRSej5Xf9
	 ornMNcECkYo10sFn4R+jiOEN50xfZwoEJ8OtQ7vVJ+rdZZoDOqLxvFsvd3GexGgTeh
	 g30UknPfCEOQXyNnSgYDc8hLtCbVgLm+colVp/VwN2CsBknMdTqsrraPbHDNY4BlUy
	 DohvLAMkiFrJ0OQzaqqGssuu6FLEZXki0nvBnh9mRu1jtmdtB1WBYM5JleiDDLBWqW
	 DQL4xX1cJjpQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19753607FE;
	Thu, 20 Aug 2026 12:13:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 471AC3AC
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 233C180CD8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hQulGhzWIKKN for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:13:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=WMuxEmfD
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40B1580CD3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:09 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso295973366b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787227988; cv=none;
 d=google.com; s=arc-20260327;
 b=aX5PlKlY5y4uXjO+N6KyEip6ZLOrSP4GrUdEu4SeRFo5ATE+cXowGvWXKlkKdHKukU
 yANqY3spJxH/LW2JmWlkqikuf/C+m4PP4vd1epbIxgkVAStLx7X3h8sVAtW2kl3EILFP
 AbPtqXnceAnCb4W8tfJ2TbT3oZstX1+36Hc0CWUqAM5JF23G1ja8WXI2ZkD5PptmaA3u
 Yxhw2CahU/pt5c684SeHQ8yCxcxtds29jBClDyo2qsDc1JBfXMTTcPfm0rz5+qntwWNk
 sGCoXYlnjdEgB+uS5AAWbXaKB1UxHKhRlYpF5awuOKbcXCzk0l5BDtv6mgeWRljvNt86
 zFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VQH8MJFw7vEZBN8yMCL1Z0s3w/9m3PxBFppVj9MvNCQ=;
 fh=Bwjok4jWsPwFzEPPOJOguv26ANoKPtuv9PCfDq8ap3w=;
 b=ma3waN2VO1lOJbhcGl/rZ55pWT4aKGwK5aYQzVAjhS8QwDcG/ZClMsQnq2AyFX4vkF
 5RJnGJmWuAHLzUNaIq3khL3CLEHUn8BLh3AjKTDf3SpuQUFbMlUI2WngRM5QNkKT4a7N
 8ESD85XfixzFAmKQtJRtc4Vt8rgJnS+7SzZFTpvMj9Natwr0BPh6hgsiet/xCcb+NMMl
 4LIJSHdxKnfGXGADMWKrr05DGZzaXmXWxKjqi73hJJYIV2TXsv3e+ES2BqshDp/oX+xR
 SZkeE832Cnu88R2aPYxiwlmPhJBRKh3bB/xFerTaDHNR/sKxd2jrW2wqqoCth2RgyMJd
 T5xA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787227988; x=1787832788;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VQH8MJFw7vEZBN8yMCL1Z0s3w/9m3PxBFppVj9MvNCQ=;
 b=WMuxEmfDrIl4YYjqSlSc2Yusg0iuFNRVJJeC+dbRL770g4v45atlkC7KL9CQHgrpXj
 z/g1AwebQMYJG4IJ0rdJLl7COZlrKqT40OJy0nJPiwviqPmXVMKVxQe8drI+jUXww4RO
 yTM2DRc1rGMLHtGg+WszQl2w4tnZGlMzdgjFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787227988; x=1787832788;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VQH8MJFw7vEZBN8yMCL1Z0s3w/9m3PxBFppVj9MvNCQ=;
 b=nKJvJvsS9CO1ktS9QYfYxNS4rUA7SW5KlS+NVbA2xnskR6+J1WzHIdz1SfPxELPcgr
 ZKB695DY90ucOF/Y+6UhHkquUMx7kqDFNRpk/Rr/BNKXVbdJrrPs8HlbJlry84rrgAe8
 R/k2Uou3fpw82V7NGpOLSlzVMyfaYwn3tY55uZKPeRWaNW+sco6TewcCxNXZwQ7gWy5B
 gKP/RgeGL3nyo7xNabPi37sH3Fb/+8zUEtHOdRUZyL0PW9nn63SD1iWE3RtCxBV6bDZp
 YR/lAXf0+Oiv0QToO352J5dv8471H7reI9z6rydBvcd0WjHXQA3RT20rgWvIjq3N5WAy
 7cAA==
X-Gm-Message-State: AOJu0Yz9tyjnmOrNdfq1Fh5wWZkPhxRHJub+uarzSc7hlvT8vP5ONKZu
 2jl5bSm3RjATy8NSDDkgMKmolzzf3amxvckb9lJytIyXQEChfr4VbMrXv4BRbA08qTaBC4rsN+7
 SxLCLr0Qccc+Ng667z3cXYkB+EAc3fCbtpo8Pep6P
X-Gm-Gg: AR+sD13ArwKQRV9WYOJ+Jy9k2hKp9P0vs7DvWFFv3oGVJnLiGrwQOVhK7p48PzgCQbO
 5DvdrPCdRKJaaND38yHwpxpSG7Upp4zEgDwSK4Er+WEJ9on97zJSmGqCUEUH/eNAGngmPzS+Svu
 6ZdeGtQ+gShhF1teDG+uwJjHD4+9dWnSwNNdESt/ODN72030dYIVEjWct/nIwP3sPUGyFrsOmK1
 z4Naoevh4SNtpohkoSePUrby3vlmZhgYZ7pNklhU6tXqoRhcMZawGV6ml+hIPDOaCgPhJKn4K6N
 Xg1ZGRRVfbwLPMunjKPNSgY0kNrJYe2l0oOghdRqZoMhgzRrrr1onQ==
X-Received: by 2002:a17:907:c709:b0:c20:2165:d74f with SMTP id
 a640c23a62f3a-c242e3b5bb0mr860592966b.22.1787227987839; Thu, 20 Aug 2026
 05:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
 <20260811-b4-reset-edl-rebootmode-v1-6-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-6-2e15adc156a3@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 06:12:44 -0600
X-Gm-Features: AcwNN1Ve5JYByTWu6yI5L2GvEbezN4d8HATvs_nDCOJDR1rb8E-9nY6aq8HhBuo
Message-ID: <CAFLszTi407gE7L-C-AU91bR+wTkuX+cpCajf5yff9a-w5KBNRA@mail.gmail.com>
Subject: Re: [PATCH 6/8] configs: qcom: enable PSCI reboot-mode framework
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-08-11T05:18:35, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> configs: qcom: enable PSCI reboot-mode framework
>
> Enable CONFIG_DM_REBOOT_MODE and CONFIG_REBOOT_MODE_PSCI in the shared
> qcom_defconfig so the "reset -<mode>" command can trigger the reset modes
> declared under the psci "reboot-mode" device tree subnode (for example
> "reset -edl").
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
