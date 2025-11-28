Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F474D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE25B83A84;
	Fri, 28 Nov 2025 17:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MvyFBAYg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 997CC83957; Fri, 28 Nov 2025 17:11:12 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F9C83A57
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3ec96ee3dabso1488121fac.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764346264; x=1764951064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AX5wS5Xd1oHOx4/fmKdjDtDWBESQKc38D+Flgf408RE=;
 b=MvyFBAYgUgn5tRaFcQHOFwBnSgHoUnU0OTIOEjXs6g0R5FFpssm7Zg4dOD3R80kpNn
 RwK3dQhiQQpXBkIdFTDGZcBBlw/EXok3RekKOffaSjj0vSVmWMHl8XH863hhtfa+Cecw
 xIZfUMVKooxXhs8Bo2FdJoc+m+FR1W4612zpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764346264; x=1764951064;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AX5wS5Xd1oHOx4/fmKdjDtDWBESQKc38D+Flgf408RE=;
 b=D4XeahMeE5rYwdO996z6IMNuCFmGcZgys0WmuCS0poFTKtLCja0IyzO9uM7Yy7Wvka
 mSCutdc71y7glePb+/L995leLBK35hg1IkKLk+OIHc+Tw7iZbh+kwgcHkI9cU7R/yBHK
 P3Aygv+P6dcW+DtDgGxZURGQh6jAxxlADM1BWx4tW+YadAV/OnmbPhl7xhtzjMyvOU9X
 279OPgiEFgaHS5sicNbwklkzeCQ5DQ5webocWQlcYWa/IAURpK3hwsc/1awqxYppV/mK
 YR6fgaNFUun1LTMxMh0qPUWLrxGK0bAfhGzVp2JHPiaAylrqecdeP2+IwJLhH56augoc
 2bhw==
X-Gm-Message-State: AOJu0Yyaygq3C/PUoNpybCKUMYXrtAjU4XgWU9PpVXrXyss7OkY3OOvb
 yvL6/LFCXrEsxNfR/dsBgvMp2WLTGGK3Fa8s1i7LjUSoojKnreOhZ6rrKMbN1hMQH00=
X-Gm-Gg: ASbGncvdfwLKpSCQJ8v1CR5Z3iRxCuQGc7Ee7s+aUNAHpMDLKJq+LBw+JwLhMf165wd
 l7IpTjvt7tuZ/pUHcrtjDmpT1jn4zhg18CWbEQUbbd1ECluLaB2PDBVNPFzFeRqkaqVjia+JDPB
 d+OvPkfyqEMR/X700pfanJlwMteZ4LJGyweWrG3b3owf9kxJf2IGhzFzQsuDk4v00+P5vWf6sUg
 vktOUDcfiVrT00EDZ9Zx7NqudMttNX/RRWrM4uDwLMdCurHo/VyvLUQVv4PQdYpHf6h3ZmvkXNa
 3MUeJ1M5P2okZ0xWp0e0aZGcfYtEXIKiIZSfFXIrb22w+uXU/Y0WGvW188geteu4arGrf5u7gkj
 nrOmBCcdo0ND8E5WtvDET2EtgyTISZyXTda9czxkNFVRtbby/Fy95q9H0yevVczC6HNxFXgrtcj
 vYKddPDaSliPCfTV2oYe+R9ABK7kSQvb6dcRrRi3bbUZ0CcanX
X-Google-Smtp-Source: AGHT+IFgtVBkQ3sWxQOCzgK1snKRlFRqtXe27i+tRD9jCale1BkDy0sllXd8MeOdYlIplA+mYx+jlw==
X-Received: by 2002:a05:6870:bb05:b0:3e7:eb08:654a with SMTP id
 586e51a60fabf-3ecbe2b7c7bmr14058757fac.4.1764346263940; 
 Fri, 28 Nov 2025 08:11:03 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca3e8a5sm1957358fac.7.2025.11.28.08.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 08:11:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251127195749.81156-1-marek.vasut+usb@mailbox.org>
References: <20251127195749.81156-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <176434626313.216060.4938073951295499125.b4-ty@konsulko.com>
Date: Fri, 28 Nov 2025 10:11:03 -0600
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

On Thu, 27 Nov 2025 20:57:40 +0100, Marek Vasut wrote:

> The following changes since commit 962711498ddac6179f1d1f3fa123397ba02a381b:
> 
>   bootstd: rauc: Only require partitions for one slot (2025-11-27 09:27:03 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


