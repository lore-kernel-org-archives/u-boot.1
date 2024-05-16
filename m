Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF27C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 21:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6AE3883E6;
	Thu, 16 May 2024 23:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gorIqTyj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6367288476; Thu, 16 May 2024 23:51:13 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC9ED883C2
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 23:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-792bdf626beso791720585a.1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715896270; x=1716501070; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnHm/AeAoqnACCy9bW9R/8iHsq3BIYtvG4vAnTBneC0=;
 b=gorIqTyjr6TsLr+szCKHYxfAq6R+kEHfWtX7ZNE+02FjSdazXuIY120KfqJBXBrSB7
 wxxZEEpXkcPGt3UJRV94gZkwrhfkOVZV785moWuzHl83iCGHXPRzQw41ao9+Z90KWOnI
 jsK0t19rslBhNWdz/djtWoIi15yfGrRyKDJxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715896270; x=1716501070;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UnHm/AeAoqnACCy9bW9R/8iHsq3BIYtvG4vAnTBneC0=;
 b=AogjLcL/s/0Ju6GrFf8agD8NG8lQr7ug1aXOZYTxtgQMK5FSk9uqYBEIztVDJzZTGh
 j/zRSNq6jTZ2Nb7OUqUEI9O1mZ5fGz0TPDpprdOgP9ZnULOJnwaqAVnkAJiHGRpEJLfy
 SLnvOcpWifDq4U0EiyGI7NiR/8nz4Je+Oq+dLSzvwT5EMpXh5u+tHwAjw3wZdBIG8bzB
 Y7z4cc3vQ/KKttjt6EjtYjdkRfxuMOJ9nOGo44MgEVQDVBhKTdVEk64HUgLaiOZBQKl0
 suj8dWTh8udc6Xi4G661ykFrg1G+n1S34A55keAFqnopjD5Hx4VESBgQvihDcKFteP8L
 d/sA==
X-Gm-Message-State: AOJu0Yw3tQ7vsXvue+unCyEiwMVZeDZwllpg7Mrft8WRe1etqVHgrpIg
 oELK6YVVXCx8EP1VTLqbjn5KSWKK4wTU4KHyc/YzYqgadZ8JMWUhiI9P8ejmjpU=
X-Google-Smtp-Source: AGHT+IG9mEr3wRr+k8lLn0YHzhMcKq26WYhJfIy1EIWZYF6i3pAiRQTVooA+xyKICZxtGOttv49y2A==
X-Received: by 2002:a05:620a:70f8:b0:78d:5d86:ee3a with SMTP id
 af79cd13be357-792c6ccb596mr3119929985a.27.1715896269755; 
 Thu, 16 May 2024 14:51:09 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf27f78fsm840020685a.30.2024.05.16.14.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 14:51:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, 
 Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20240510-b4-upstream-j721s2-of-upstream-v3-0-43672b7134b7@ti.com>
References: <20240510-b4-upstream-j721s2-of-upstream-v3-0-43672b7134b7@ti.com>
Subject: Re: [PATCH v3 0/6] Enable OF_UPSTREAM for J721s2 and AM68
Message-Id: <171589626831.945221.9507115118281659321.b4-ty@konsulko.com>
Date: Thu, 16 May 2024 15:51:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 10 May 2024 10:20:19 +0530, Manorit Chawdhry wrote:

> Series splits AM68 and J721s2 support along with enabling OF_UPSTREAM
> and adding stdboot support for both the platforms.
> 
> Boot logs: https://gist.github.com/manorit2001/6c669e4273933bc46c3b28a631a96ae3
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


