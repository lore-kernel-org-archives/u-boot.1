Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA06AD74954
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 03:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F02891D2;
	Wed, 30 Oct 2024 04:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BUfs+QNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC8D3891D4; Wed, 30 Oct 2024 04:54:21 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4053891BB
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 04:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cc03b649f2so41282106d6.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730260458; x=1730865258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nxiZg1HNj5gtjjWPeOOve1cS0S6iCP+BTxQf7KKuY1Y=;
 b=BUfs+QNwaX+k2nVZ4armj+iFAeFsIDgJ9iBu6twPelbx8rGQwOCrTN3S1f6iir3kzr
 Gx4DIIc3SqsKlcVHtUhmqnJkzhaKlvxTMJA1KeZqdebiI0iWWrLNcg3dr9Xzr/Vrz9M1
 AiYoSSWa7TEXfbGrHsDaKnL3A1HrGw7zENgis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730260458; x=1730865258;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nxiZg1HNj5gtjjWPeOOve1cS0S6iCP+BTxQf7KKuY1Y=;
 b=UlLnzX2oQr5CNEfjCyjFcrgUuWa4kiYNy3rYruMDIWtCMbAoP6oljCdhEn7cFyV1OV
 VQF3r9/N/i3t4DDL3/6iRGqb3j1EUaS2I0d0VEq7tJtqWVI5JMxqzacSaDryq9o0LxVJ
 upqhLsXSTrU5Uh2AoOx+eTnbq0gAJaKjN0gUyDsTQ0GgUqEfPIuHyhJVcsg/ZoDr0YGo
 gdCN9DTM6dFLFa90iox2C6uqDhu1SVFWWdz9bY4LrhM3pGLF2gVuUgNEhtl1s3bg099N
 gruL4RX4ROUm0MwFreORUvdnezwctenyrb1SOYQIcPKV/mhw2lvsXwKbEdTUiUCxfDkS
 RVuQ==
X-Gm-Message-State: AOJu0YyvRLt3dP009xDrBuoR/q/C9u1FIV/F1EuOmERklaZP1grdaqyj
 X18MOR3DkxL5QpVeVQLWpAzs3uHy411hH+L4xracTs/dj8RU8YLvZaXeoXwU2hZ+8eKPlAGuo/n
 3n5hlLg==
X-Google-Smtp-Source: AGHT+IGYDrfD1VSV58ifEtGET5+1jP3eEsEBvD9VCjkZ3P470Xv4f/oak5rpsb/zFP8lUseLrtATIQ==
X-Received: by 2002:a05:6214:498c:b0:6cd:f6de:8ad2 with SMTP id
 6a1803df08f44-6d18585e41amr241124986d6.45.1730260458623; 
 Tue, 29 Oct 2024 20:54:18 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17972f51csm48332676d6.3.2024.10.29.20.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 20:54:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Christopher Cordahi <christophercordahi@nanometrics.ca>
In-Reply-To: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
References: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
Subject: Re: [PATCH 0/6] memory: ti-aemif: Add DM support
Message-Id: <173026045687.3520773.1795686581183927525.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 21:54:16 -0600
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

On Mon, 21 Oct 2024 17:13:24 +0200, Bastien Curutchet wrote:

> This patch series aims to add DM support for the AEMIF controller that
> can be found in the DaVinci SoCs.
> 
> This controller has already a driver used by the Keystone SoCs so I
> add my work to it.
> 
> As we can now easily import Linux device-trees, I try to stick the
> most I can to the Linux bindings of the AEMIF controller. To do so I add
> an 'intermediate' driver called 'ti-aemif-cs'. It's in charge of
> configuring timings for a given chip select of the AEMIF controller.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


