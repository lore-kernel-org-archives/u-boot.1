Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8835DC36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 20:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD8A81951;
	Tue, 25 Mar 2025 21:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DduPdVVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E97A81CA8; Tue, 25 Mar 2025 21:18:08 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 923AE81951
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 21:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224191d92e4so119902725ad.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742933884; x=1743538684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZUB/s2ROqssMxf+PvQ4HVkk4S5ZIMNx0bhUGVkKce0=;
 b=DduPdVViRe0LlF1vcy88uPUDgdsZhy+EW8aWF3SpRQwfE2Qh+MNESxQCT6kYZa59l2
 j0Eil/mdXWzhgc0iCvyww6jZJB5oZ+iWw/BdNiyrusWVQXtKgaKoqaCpnNiIM2WlP8sG
 3JOcZiwYtX/JQ4Ce1KvpsDPAQf4RifbOKtoMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742933884; x=1743538684;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZUB/s2ROqssMxf+PvQ4HVkk4S5ZIMNx0bhUGVkKce0=;
 b=Cx1Z9OXwfHgqLJW9cvnsthjbLzt5II1L5tfwQ4DPdTDuzgRsnanLv3cZA3j4ub1K49
 kQRzKxOSpUfn4Q7AmtY2EAW2NGuCeWHfF081F5Rb8jC1yT5C3ybP2VT+mg1XwbayzAOB
 JCe9BlG6bcW+ccVHOQWb6vvfre6aEH0THY/I5fm9P9y+y3ZZzWOokMSYQamI92U860TV
 LS5XTebEV9ZXK5w57RS4WlWlanoJlRWCGjv8pOMkKxRW0PlYPM5ANgT8VobxgajeQlG/
 0dEKhQxQuqEHCFvcZX1pHUxe7J9d8RTgvbWxnEat1qjFmbHUrj3hR6kBrjD4+Mp9o6No
 Nxog==
X-Gm-Message-State: AOJu0Yw5eNpYuIXccLftch4KMmmk+1KBtIQ8CMt7tRx42aQIls3JmfyP
 DzXYF5NB25m/XN0v+npxGAuN5rKuqx+VHoVpHBv+Eixw5D8qYWvDDm0kfuwoxSHS3bkPHzoVDhF
 JkbI=
X-Gm-Gg: ASbGnculYSs+IpF9c3c5zfvFFzAzKcF0Pyu2ctMD5VOOSi1AO37lq11uRqu0ikJKqrP
 EcrkkAZYBqfuHFxAVLkxu5U7UsZE2d9ckgnOfWVFRvRGpLJloCz5Jlu/W/lOLRn57uUewKitGaB
 5C6mJo2h9N/QarOt/IGNPsfbZ16s89JTUNP+ScWkXMY7otMbYJnLr27wljICrjV2szztFQVhOlK
 dehM5rEHtsl7s91l+F+QjhooQ6AaIxlX7kszQKWpp5dT3KCBsy0ORGnxkq1M6q445Sq/9rpJE/c
 Kr6ZEDxToo3N2feYlyxq1XTvruDqL7xsffLU+DAmcQ==
X-Google-Smtp-Source: AGHT+IFJFZVd38aIEbugJ213G55sbb1N/eCeK0GeBbJE/FnftlJXZl3SUmZ7CcuhvwpZmYY0NAEnYA==
X-Received: by 2002:a17:902:c94a:b0:224:93e:b5d7 with SMTP id
 d9443c01a7336-22780e3fb00mr284873535ad.34.1742933880886; 
 Tue, 25 Mar 2025 13:18:00 -0700 (PDT)
Received: from [127.0.1.1] ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f6fbcsm94947975ad.239.2025.03.25.13.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 13:18:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
In-Reply-To: <Z-KLp1zWkAXvvmRU@swlinux02>
References: <Z-KLp1zWkAXvvmRU@swlinux02>
Subject: Re: [GIT PULL] u-boot-riscv/next
Message-Id: <174293387976.370169.14442511383228262899.b4-ty@konsulko.com>
Date: Tue, 25 Mar 2025 14:17:59 -0600
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

On Tue, 25 Mar 2025 18:55:35 +0800, Leo Liang wrote:

> The following changes since commit d574229880378081691dc06c430424015be0740c:
> 
>   Merge tag 'qcom-next-20250324' of https://gitlab.denx.de/u-boot/custodians/u-boot-snapdragon into next (2025-03-24 12:38:48 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


