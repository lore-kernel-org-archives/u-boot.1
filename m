Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889ECC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4863187785;
	Thu,  2 Nov 2023 23:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jrwbWJco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8B6E87784; Thu,  2 Nov 2023 23:49:36 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2356B87763
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5af6c445e9eso17898687b3.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965371; x=1699570171; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jbnXxVGWrgEZTHhMlX809Dr0KAWzIHrZ4i79cLnNO4U=;
 b=jrwbWJcoXiADh57i8BlnicoBIp2vHnyW+xXxn2tlSUqq6NaQ/oBHERBwXKph/BT3Dm
 ljBymGc+CDOSpe+K0faBireaGmqO6rbtKECLuPbtTo3ZnGOYEvKROmFZhGNE53XShUih
 fbgbqCQ14/cTjkMqY5tfRrIDhWLnytJS310es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965371; x=1699570171;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jbnXxVGWrgEZTHhMlX809Dr0KAWzIHrZ4i79cLnNO4U=;
 b=hTkW/K3zasBibxUksaHQ7YW5FPQEio69NacLua0wrkKPdJLF5Vyae6B2Hkl0V3oNXD
 Ppqe1YQAWTuq0thYmhnrLpA26xIMRmNv1VMZb/KwYWXlT5gHE4fGf/qJMrRxeTnwBHAk
 +AxESKrdujWkrVZbl2fUAh1Xga8AQK56UeYK56Kilen4se3wkaadDIw7Qdcs5zRHhktJ
 tCS8wqIgQLndr58SJGYuS1oLd/iKNXQxONiIW0MPQnng1IxnxQm5hEHzlQCbPLNCqu7s
 6SFOgPGgw0SAfVW2P5PfbxQIhuOECp1ML1vuTHb1WGMGLUWXo+qoGXM8iZT1vhlUI3eF
 l9UQ==
X-Gm-Message-State: AOJu0Yzcan8MhkbBVShl0ta/bWvNQtjK6i/Z1ntKP6BOZvisCaE54r8e
 /ZTaiApgc1BlfJwGGyFdjA2prfucH18T6+5chf4XhA==
X-Google-Smtp-Source: AGHT+IH2V3eaTxPs+UtWZWdArgVDLQRQGXojvMqHr85HP/MHT0NlksV7GDAfJAsGOTNHQ9sCtAp7coQnwgKoARWV44w=
X-Received: by 2002:a81:ca48:0:b0:5a7:bfbf:691d with SMTP id
 y8-20020a81ca48000000b005a7bfbf691dmr1172277ywk.42.1698965370684; Thu, 02 Nov
 2023 15:49:30 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Nov 2023 17:49:25 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <b1d5604f-93ef-4ece-b359-c6f7365476f8@ti.com>
References: <b1d5604f-93ef-4ece-b359-c6f7365476f8@ti.com>
 <20231014204033.3077052-1-sjg@chromium.org>
 <20231014204033.3077052-2-sjg@chromium.org>
Date: Thu, 2 Nov 2023 17:49:25 -0500
X-Google-Sender-Auth: n0j1Zhr0rLwRdDuiN7_ZfD-yPTY
Message-ID: <CAPnjgZ35dSHOLwWrW9EdgQOWdb1He92kaziuwRKQ1tOHy0QEdg@mail.gmail.com>
Subject: Re: [PATCH 1/6] binman: Reset missing bintools after testing
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon

On 15/10/23 02:10, Simon Glass wrote:
> For tests which fake bintools being missing, we need to reset the list
> afterwards, to ensure that future tests do not also see the bintools as
> missing.
>
> Reset the list when processing is complete.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   tools/binman/control.py | 2 ++
>   1 file changed, 2 insertions(+)
>
Applied to u-boot-dm, thanks!
