Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3C2CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 19:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A7B3838E3;
	Fri, 24 Oct 2025 21:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jZ68FSTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A250A838CC; Fri, 24 Oct 2025 21:55:15 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B155838C7
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 21:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4439fc3abfeso1164086b6e.3
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761335712; x=1761940512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTH0beTQ7EgiTSRMUG5Sfgvd+5p2HX29FKJTeUtFr9c=;
 b=jZ68FSTawwy+ekFMZhQEe/WiBjYK3IA1ekZ4THmIEqGTpkOCAZEE6JP8WLoQUoKttD
 PR/puTtX46r4G3KfIU8fSL+nO6YZESc0hwIakXXQHxz4rclCQOPgD8q5u1+WRlnDH9Jd
 WfR9ub1hSBL7X/Aq9S1OuQmKxYS2wCZeyOUQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761335712; x=1761940512;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTH0beTQ7EgiTSRMUG5Sfgvd+5p2HX29FKJTeUtFr9c=;
 b=XH2ZyQKRfDSJgZz8fITiW9TXLeP+TdBGycDycBbICAbocowE0yn0HkBzRsjTHwAwR9
 SEg2sl6INt3js7N/+VlRR4gNo0ydKfL2ciOiF5tu0HMaviNEsqS9dBf8UsDJ1HFoa4Lb
 SILQZwVv1MdWgRCsySpcTamZTakSIzHX1c+deRsnK3Zw8JPlEwzEm6epiAWJ8s23OYwx
 dlXfSaTIfA29hyY6wNG1M411Kk5bpW1Ir6PltQa+84hx4E87vrsvSFH08qR3JCloHTAp
 DB9qEcoYTrwYb/RnWlukRZYdCeqHzBvebzKVvmdS0BU2t3jApMMmuEHvyq+7PpiCy+rW
 4nuA==
X-Gm-Message-State: AOJu0YxYYbNlOKhn6JDznxpI72YBYkzYCblGlQzhyx7p8cfVE9vynBeF
 pLzABb+J5lZpAl5SWFwBCvoElZsYsq5XNBn22eaEoTWKim3HZ1uV5S0F/xoT8UKB/RSXZGrOx6V
 ajg03J/QNFQ==
X-Gm-Gg: ASbGncuxxL6ZAUZUO9mNuHWjYPRZzrjVNek7IWGpfgqtgrKw13ASpb3Y4XjdahDR8hS
 1FJ0w81yqcvJCVYaNepTv7VpyR9hpXULujPUCHdG2iyi68hvq9a4+uUO+YAAhpnt2jZyHVkP06y
 jm57osFI1blYX8u1YVtuCyK3SD3xJCCEYogm/qULlFbZh49S6yrZLrkTq+xvl+GabRwakgZj6lJ
 EaiTPiC3/x8F4LFknslhsxt8LAylmBUZ4m9RsoE+Ls0cI3GRBg4n3T8OPr6gB5zMjxmfU3eOXK+
 AQh06VxjcQwMs2iKtxgBFeu0D7oufHOoY6VFUuwtEo3lUXhbP1q+LhhMd7VW1T+vexX5te6YObc
 +e7pTvYeUw5AbqNledVJdCle4FvDaFfO459DMKDabmPz18VNdMf7HY1v0CoCUmi2HQOuN63ieKd
 pyY7tfGMXVJ0+q4opoJnwl/SIZgbe6zxMP6WskygOD3jExsExD
X-Google-Smtp-Source: AGHT+IHdRPUkjSNepc7xXNUV9ZZeUevnpZ8OixUytBp1eKSiYJK7FbHmTHnyWP9ZrZps0e8WyZH89w==
X-Received: by 2002:a05:6808:1a0d:b0:43d:20f2:2e26 with SMTP id
 5614622812f47-443a2ed7e2bmr13555019b6e.10.1761335712324; 
 Fri, 24 Oct 2025 12:55:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2eff7fsm10013eaf.17.2025.10.24.12.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 12:55:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>, 
 Martin Schwan <m.schwan@phytec.de>, upstream@lists.phytec.de
In-Reply-To: <20251021-ip_dyn_bootstd-v4-1-1452ad40ab0c@phytec.de>
References: <20251021-ip_dyn_bootstd-v4-1-1452ad40ab0c@phytec.de>
Subject: Re: [PATCH v4] bootstd: make it possible to use tftp for netboot
 with standardboot
Message-Id: <176133571125.2586772.1311639324029526521.b4-ty@konsulko.com>
Date: Fri, 24 Oct 2025 13:55:11 -0600
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

On Tue, 21 Oct 2025 16:34:17 +0200, Benjamin Hahn wrote:

> Add the option to load the bootscript with the tftp command (static IP)
> instead of the dhcp command (dynamic IP). For this a new function
> tftpb_run similar to dhcp_run, is needed. The selection of which command
> to use can be done with the ip_dyn environment variable, which can be
> set to yes or no. The ip_dyn variable was chosen as it is already in use
> on the imx platforms.
> Also edit the bootstd doc.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] bootstd: make it possible to use tftp for netboot with standardboot
      commit: fae6c54d238279bf79c66ca65330425dff2c952f
-- 
Tom


