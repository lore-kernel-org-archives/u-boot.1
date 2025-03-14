Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35087C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 20:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3710E81FC8;
	Fri, 14 Mar 2025 21:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O2rIKofF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D1B81FC7; Fri, 14 Mar 2025 21:39:39 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BF6E81E8C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 21:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7c55500cf80so197328585a.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741984776; x=1742589576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5o2u1djcNVsKcJFVVemtKBMVXu0BAdT2+Q0ZSbEyFqs=;
 b=O2rIKofF5EKZT5hdUrT1wsnJv7lMJFyZ+2LBlX144Jd+Vphum17UVwHwZRtdhlJQUk
 REZZw5hJHXqX5o/N6Q/k2r7NbKPZ+DsXUfNsuvL5FGT5PAnP9PfPzv5Fxwcb+J2VlGLr
 phySeTbFafjYti7X9V2nJWasrXxqZO8ipLCqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741984776; x=1742589576;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5o2u1djcNVsKcJFVVemtKBMVXu0BAdT2+Q0ZSbEyFqs=;
 b=jJz/WLRQotyWc+dA+jF5IpMEApkwEh4rFe6qSi5cSNppycCzVeUagYTHYb7L9FVW1s
 z5tkxZ9YuuzrEp9WlfdFhM+AXDoCGsWd04U5KFVHNWZ7d2CvS72eTBzSJmK+c33xEUJj
 NB87z3ddaxsansRqUL2TTD5oi+mCxddJrDiuNfYSyFRRqNv5aXbA1HM4JyxXTFO4Jmgc
 uOUqvTGnWbhUCnnMYRRnyrnRI9GIunQiE+vCQF6MSxSvE/aOb8lOeTCowYE2CIyJSyb8
 IaRUfhdKgT29WsbojWODu+sLz4G+KW07B5wm+EyFJ2gCvIhQjaVumVmNM1E0P3J1CAte
 tS2Q==
X-Gm-Message-State: AOJu0YxczTTCI4HXZ/hjyX2+tvZT12jrYTTsv5+LzCdCpsJAIL5cXERE
 vL5GZq0sbCypBMoy3ZSk26nkfAv0IOGiuwtZT5p6GmnB+FqzeHtMGjT/SyLngVp7eaOUue8R/IO
 e
X-Gm-Gg: ASbGncucR1fWuPxFBvsuFrZCEc0NK1B/v0GhrOszFXlqkP3YjzAwJvfHvkjswj+mNjq
 H8iJV71jiMWbllBVwHaHwSnOurp+CwudUOJLcJTLKRzw+pxCuKyZZSHAHh/ZlWW8ot4o1kWdXa4
 K2jZo4LpuB7SsyJREwb4VIU1fGtwq9NQQjZOI2LxRiRvwYAog9TvWt9WtWaJOeFcTe5S/MYP2tL
 IwbU4WVKMYfjwCGHpPSBQTZ5ru4vUfLuG+NF6SBnrrPIaiaI0WnJvmp0BLQK78gkXeDI1AX2nbD
 HooXy6/o2VRzJ3mCxuLnhLinHePaoDWey3jbPyfQ2MW5
X-Google-Smtp-Source: AGHT+IGuz5Smo51u5Jog8bnHP4Mxy7ROVje/OMzraRM0qwzq0F7qGma8J+jiAIMsaVTok42r1XH2Hw==
X-Received: by 2002:a05:620a:4546:b0:7c5:47e0:e705 with SMTP id
 af79cd13be357-7c57c7e5bf5mr457474685a.24.1741984776377; 
 Fri, 14 Mar 2025 13:39:36 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d72b94sm298787485a.77.2025.03.14.13.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 13:39:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>
Cc: marex@denx.de, clamor95@gmail.com, alexander.sverdlin@siemens.com, 
 kever.yang@rock-chips.com, mkorpershoek@baylibre.com, 
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jenneron@protonmail.com, 
 jonasschwoebel@yahoo.de, Anatolij Gustschin <agust@denx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Soeren Moch <smoch@web.de>
In-Reply-To: <bea64d2913c5c768989d7fcf5201449997187016.1740927024.git.dsimic@manjaro.org>
References: <bea64d2913c5c768989d7fcf5201449997187016.1740927024.git.dsimic@manjaro.org>
Subject: Re: [PATCH] common: console: Delete obsolete VIDCONSOLE_AS_{LCD,
 NAME} options
Message-Id: <174198477335.2277875.15177172661013316270.b4-ty@konsulko.com>
Date: Fri, 14 Mar 2025 14:39:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sun, 02 Mar 2025 15:52:57 +0100, Dragan Simic wrote:

> The configuration options CONFIG_VIDCONSOLE_AS_LCD and CONFIG_VIDCONSOLE_AS_
> NAME have been marked as obsolete and scheduled for deletion in late 2020.
> 
> That's already long overdue and the last remaining consumers of these options
> have already migrated to using "vidconsole" in their "stdout" and "stderr"
> environment variables, so let's delete these two configuration options.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] common: console: Delete obsolete VIDCONSOLE_AS_{LCD, NAME} options
      commit: f853295a6a0913f9d0df72c11dc62834452820f4
-- 
Tom


