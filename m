Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E37CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 17:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D728836A3;
	Thu, 16 Oct 2025 19:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I6dv9MHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B58F0836D1; Thu, 16 Oct 2025 19:38:24 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5858E8367F
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 19:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-74526ca79beso658502a34.0
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 10:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760636301; x=1761241101; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5ivtf4PfFsP8OT3Dtoi84r2f88T3pyq0xauRw5OhbU=;
 b=I6dv9MHC+5/nnVs+OKTbkg+i7x+Q28BB4WlVj3HbPIOceVmrN5pq1G/7B80fRUXvhM
 L+g5GucQ9bDbBgZ41z0wAflxhZXb3uHGUg5OQ6Qufb6cUUiQFYXDuUXCVZnkmzavsJYG
 NAScHUGC2kdWF8boHZBNJ3fmfRvVjCxPtQR04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760636301; x=1761241101;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a5ivtf4PfFsP8OT3Dtoi84r2f88T3pyq0xauRw5OhbU=;
 b=oP1b0XkSZVIucbx1J6RZfmXIVgV9FUscbucBdLTvC8//cDTDpN1gG/hKWoPs67fQhb
 EoWS10nmCrTKoLal4osyoMIaOAWddjP6O1M7mI4jVaUS99DFiZUkmbX6haoZlZrANMOC
 xcIlY+LlXi787PiSEiT2K9efFIem7CE+gZ3KgBksU5mSgzXn4+Fww8pdKdFJpF0yypNr
 haKZkPBgTHlzBfK2T4J0/7vsWf1QFVSefiiykSVwU+vnc0IHClXvpljrlM+Rmi+nawFH
 ZWjE05R043IDf4zdsI6VKQwEI+PI95RFikqgCq99xCe1N0cYF7J8aUYUHp20q7C7r7VL
 C8oQ==
X-Gm-Message-State: AOJu0YyWGaRfika40IcayZ9IaStbPrNK8DgEvtWljCVDIeT0KhJQvE5Q
 IG31lEi1Q1csNzIyr+vnh1O797WJ6l4UIjNvb64ZOYtTJflSnwyxBX5cl8yZQgys8sjB2+/xlF9
 EbDcKcCw=
X-Gm-Gg: ASbGncum8Py6n5OuVfe+3dvEZBzYUU+pVmXLoSg28RYiuTOi5HqHkxm2bU0k/jlsU6J
 60pfiEAL3gVHiTP2ElDZCtI2+Gd31Xy/iUqo8qxIWrNik7cypUVxpL9cYpLH2CeptCafYjo4NG2
 J4cVXHULGJj9U479v7nLNKXe5PweJwUxmm/pt9MZKQaF/00vKC6DnZhLrucPlIYEEto1HuB3Tz4
 o3J182C1e18OWq/xa8uJ+xq4y1Cffmaj1dGClLNMpnmhA/zTvgRhIk+j/2P0Z7Z9LKXuvggQOnj
 EW788oHlPQVJY216HaT8DAgfKSjcianu/GULblxBDqe9d5Ipl4f3xkXXz616TdOuUXJyGyQJC5I
 a+ecHU7so7oormdfhbR5Edzx+NfeddEVDdt5N2qOpKdRVpY/2IZveY7Yt8CHAmlYXPbfWMaVRao
 Q2JA1dC5ExGM4TLbe3XSw+L7Kps8yObtZ/jVK4cBKi59gCF7Z6
X-Google-Smtp-Source: AGHT+IHXFJjx/CrXzGOAhSw0mGKu+evBwgjyL9jQRKHz3OLmEX5X6AIXx8H1X0Ptx4dOnu9lvxE2mA==
X-Received: by 2002:a05:6830:6c15:b0:749:32a:6e79 with SMTP id
 46e09a7af769-7c27cb7df6cmr249292a34.29.1760636301033; 
 Thu, 16 Oct 2025 10:38:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c27a206ac7sm335079a34.17.2025.10.16.10.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 10:38:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com, e@freeshell.de, 
 ziyao@disroot.org
In-Reply-To: <aPDgCxYfqFzxgsWb@swlinux02>
References: <aPDgCxYfqFzxgsWb@swlinux02>
Subject: Re: [GIT,PULL] u-boot-riscv/master
Message-Id: <176063629917.212270.1145034876136991424.b4-ty@konsulko.com>
Date: Thu, 16 Oct 2025 11:38:19 -0600
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

On Thu, 16 Oct 2025 20:07:51 +0800, Leo Liang wrote:

> The following changes since commit 2ba64e303b2706e5c42a6bf982326d632342ca66:
> 
>   Merge patch series "fix an7581 panic caused by attempt to support multiple RAM size" (2025-10-15 15:08:27 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


