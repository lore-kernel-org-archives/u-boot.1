Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA794CA0EFA
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 21:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 422CE829E7;
	Sat, 23 Aug 2025 23:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kHPPvd74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B075E80077; Sat, 23 Aug 2025 23:14:50 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979D180EE5
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 23:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3e67d83ee4bso16183495ab.1
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755983687; x=1756588487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKhniBguSpNdchSBatYnJvd6CjO+ms7aRrHvLiHpcek=;
 b=kHPPvd74v5I2LyGy15/R6NTdzWze7MfpK7mYSTC5mHDcHGLXPxBhjUOdwV8DhuDYtG
 LsCoIwJTsGbL00Q6/YPsVbwqbm+vDfmhPyEqpeImUDT+NapfKMXZO4s2G9uGLGZ/IGX5
 BLiHRoQ6e0mZtnB9CtgDhLDSseGawwJdiP8LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755983687; x=1756588487;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YKhniBguSpNdchSBatYnJvd6CjO+ms7aRrHvLiHpcek=;
 b=KsNdtPUreBg4Rgx2P2y6lIFxm2l6DRdfRTVZwpGFN8hyB2FbthCO0iEZvndFaP7m0t
 6vAIdxHS/M2WYcTxAPep/LnSKVuaVLUE7U7KP/QdmU7MBoTJ6q1sVVZiWHvGohy11oMt
 alhQ2DRgLTmDGC/rgmy2CttpWGZO3Wek/CX4aEk+di8A2lshusHlGQ/6GCsQLNKVfOA+
 W2ArdaeNcI0N5EjWT+vmK0t8XaH6uQG6QDeoZPgNU+/GCCkZElUdTC/CqRVBGWmTJgAW
 Q+HEtU8kKj115i7RwL2SEgy6nRTMUcly6aG204N3Lc9ChhlhMYQ3s95fWxOo5bITev9j
 EpQA==
X-Gm-Message-State: AOJu0YyrCHO5n2rKRQXRZJNjYenJZuyiY/adH+PajeG1aBGo1wdF2FXG
 trkAalDjObtWwL9BcWoYwfsL/IaIgYZ0/Jyr1gVKgGdD0p+GOg6gkPVB2ahAmKmKFGNVId9yFD0
 tOgph+xk=
X-Gm-Gg: ASbGncs6Sue2IXJJdmWm5irf4FHN3rDuhJOAzb4D1dlFabn8tb+DrzgrLM7HPJYcGeS
 Yc/f/qtbXDopWkJyGvN+WevtNbRAS++GzY9YMOG9ST1ZW7ec8w2oFVlWqM+6RgbGcq5Te+cjSt6
 uY4TZzT0IXiP/GdxqeWs+Q1Il98wtH2Yg3F0f1veCZ++4d4Rxulgiev9Jgu7xIQN7M+3BExTqup
 RknwATFBIrHIKnWNkCf8c0xdJaVR1UM7ic5GM7Ssqhvs0L/fznFrkfq0E/IK/TjrakhtJq4bI/i
 uaPQKrE2ZWHY0MLPk90tYVx5sysbT07PuzgbCqon6B+phDBelSlyYxoxQzUdD2Z4Pwwl5xfCgoQ
 oAskRBTTaBTMZLmsQyjyjuwXVyXvw5KX4/R4OWPBiZFD4YUBO3/82Pak=
X-Google-Smtp-Source: AGHT+IFBRs7RDxJG/rA86N6epmwKmz0MaZvk9E4qpvM33ipAaXDMWg1Au5ANFfE7cY3+vXtvwonF1g==
X-Received: by 2002:a05:6e02:152d:b0:3e8:b64c:105f with SMTP id
 e9e14a558f8ab-3e91f93e0e9mr113716025ab.5.1755983687307; 
 Sat, 23 Aug 2025 14:14:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ea4c28624bsm21423305ab.18.2025.08.23.14.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Aug 2025 14:14:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Tim Harvey <tharvey@gateworks.com>
In-Reply-To: <20250823190249.352162-1-marek.vasut+usb@mailbox.org>
References: <20250823190249.352162-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <175598368635.1246629.14102870857675462949.b4-ty@konsulko.com>
Date: Sat, 23 Aug 2025 15:14:46 -0600
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

On Sat, 23 Aug 2025 21:02:35 +0200, Marek Vasut wrote:

> The following changes since commit 94e690c44a03959c39f0f5a44a9b89c851af3b60:
> 
>   Merge patch series "bootstd: rauc: Fix segfault when scanning device with unsupported layout" (2025-08-21 15:05:15 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


