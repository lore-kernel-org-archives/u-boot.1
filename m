Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847EBF55104
	for <u-boot@archiver.kernel.org>; Sat,  7 Mar 2026 18:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50C583A8C;
	Sat,  7 Mar 2026 19:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J95wxG4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6BFC83BC7; Sat,  7 Mar 2026 17:36:39 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC80E839A8
 for <u-boot@lists.denx.de>; Sat,  7 Mar 2026 17:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-359863611faso2825097a91.3
 for <u-boot@lists.denx.de>; Sat, 07 Mar 2026 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772901396; x=1773506196; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zMvXJLbfLARkl8MQPzoaxzah3408Fyfoe5ahfNMaIxE=;
 b=J95wxG4gzCrOS11HiTe6hGNlj4UMgR6y361VFH6Avika+dXYs1NjHM1CJaVlm0S4MN
 DipZtgHhMHy2MfjS/rO/bJAz5vMMV2o26fbQtDkzRZl9Li4jGUF9X3T6QM4TTHzQqz98
 zpowQKC473Dkh1BAnWFaYKFRuSdLbeTJpwTTM+SxqZsw3D0X2B89HH1YBvWDOrzc+Q2q
 IAro3ZJUO0gnYsHYerlM0LA7wWY4GT0l/HCJGfKCECqkdtwu7CjOAvDy64R7ZQMcSqqg
 gHuxuWQhRv+FAdpthkpmr6G22cLZfxzrAMvwUUn3lO68g+Bw7VjsC1h6j5+SgGAIIWWL
 nitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772901396; x=1773506196;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zMvXJLbfLARkl8MQPzoaxzah3408Fyfoe5ahfNMaIxE=;
 b=PWRG0Vh83RoW9xGtkBPE98TlP03FIXoMN5rnaEF2nhKYQb2+gyIjKtnKjjGt+c6Dl9
 C3ORIV/hXMyq/zN/Nw79qUC8emVQ7zQPrs4GYu1gr8a5rRHii5IBIu1ZzPvsAuexZDzY
 /Eag7p+eGQDjp/zqOC8mnUUMWw1Ezqhwd7Eg7bDq76uiCwOCLmcaYWKnkqPxyvqlznmf
 bS0vBI6Y0Fq1O0oSdL5ttLjNanDx190rIn+PAcIPWHg4YGHIgPglsvqT9o42mTrEiwFr
 oH3jq8K72Z5Rn/IuhPinq8z0s7O8QyG/bPDsotjBA3INLDzy8+PkL1wylS87oa1a+euh
 Dhhg==
X-Gm-Message-State: AOJu0Yz8P/zRQhk1ugs2fD1VOglv/agYs4Xh+HgUuGXTuzNT4JmkVzKI
 CqyeuphTdGfR9H5n/K5Tdv9N+vdbb+UJMA9/g+qYoXz3dHdYHD8/g4Ku
X-Gm-Gg: ATEYQzwGIurGGiUQTAC8jpzRpJvwunk1EIczl4DD4LRLFwoEW8qwQdI23ZXC/45YQ3I
 6rJ/ArRzQs3CpzBHcEBADdCqWQ4SzUWNf/rFXbDhOF5u6kRj0gCVNxH0LSaBWORnMkbp3Vuf0gp
 efm2G3W3+2IHbcvfxZA1gWiPcBnvo0g7S+t3X0fwnvIWHZ+6b1vu2lzCxgvH0FJ24MKkllwcngv
 owHt88ARZrtnp86E1ZGSmuCLVmAiXl0VxU3RSgfEr7NOBAGl2ShsUkSmw1W29CNXhowsyVB+QNC
 yeDg1obSd8pzp0M65EXxLxRLPvbAqY8mPZ3fH08evoqyldB1gGu84VguuOVQOHOO9Q6DjVblC9e
 q0n7P8MW1KyfLI7LQN7ng4MtlQwOBZmLK61idBCKUdniFRo2A2GX1crEprz0z3gW+1x3cHeEAmr
 DlEIugaU77USSUTONGzAcV7vpkzY8/xMQqFICTfcvjLDHD+EyhvldZL2Ur0jISFdgrst4=
X-Received: by 2002:a17:90b:51:b0:359:7b9a:2cf4 with SMTP id
 98e67ed59e1d1-359be12f79amr5827385a91.0.1772901396084; 
 Sat, 07 Mar 2026 08:36:36 -0800 (PST)
Received: from google.com (61-230-19-63.dynamic-ip.hinet.net. [61.230.19.63])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359b2d60767sm8770924a91.8.2026.03.07.08.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 08:36:35 -0800 (PST)
Date: Sun, 8 Mar 2026 00:36:30 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <simon.glass@canonical.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Alison Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@sysam.it>
Subject: Re: [PATCH v4 13/17] m68k: Call bootm_final()
Message-ID: <aaxUDuHNHSQI74ir@google.com>
References: <20260306023638.2678886-1-sjg@chromium.org>
 <20260306023638.2678886-14-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306023638.2678886-14-sjg@chromium.org>
X-Mailman-Approved-At: Sat, 07 Mar 2026 19:22:24 +0100
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

On Thu, Mar 05, 2026 at 07:36:22PM -0700, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Add a call to bootm_final() before jumping to the kernel. This adds
> the "Starting kernel" message, bootstage tracking,
> board_quiesce_devices() and dm_remove_devices_active() which were not
> previously called on m68k.
> 
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> Acked-by: Angelo Dureghello <angelo@kernel-space.org>
> Tested-by: Angelo Dureghello <angelo@kernel-space.org>

FWIW:

Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> 
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Add new patch for m68k conversion
> 
>  arch/m68k/lib/bootm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
> index 3dcff8076e3..7e36ac73169 100644
> --- a/arch/m68k/lib/bootm.c
> +++ b/arch/m68k/lib/bootm.c
> @@ -65,6 +65,8 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
>  
>  	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
>  
> +	bootm_final(0);
> +
>  	/*
>  	 * Linux Kernel Parameters (passing board info data):
>  	 *   sp+00: Ignore, side effect of using jsr to jump to kernel
> -- 
> 2.43.0
> 
