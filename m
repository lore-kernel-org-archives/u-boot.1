Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8DFC9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 16:26:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9390483980;
	Sun, 18 Jan 2026 17:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ax9WMzfs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69178307F; Sun, 18 Jan 2026 17:26:10 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C3E58389A
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 17:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7cfdd3146deso1319572a34.2
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 08:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768753567; x=1769358367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skaHD2ZK8wsoM9YD9rQPN2+QgspBRM5OWlzt2BKzGIw=;
 b=ax9WMzfsWEMAjP4HEYRVdQHk/MSP2qIxgUT1KSTOe/NSppgeupRoAIBmGji6nv+C3d
 pHTZrXcMpUfcCXrTaxev+0UfcoLVj2L4VbpwjfL66OJ+rM2e6VCUt69U+kL1Nk8xIXN6
 h1SSzjmALloPFdE0kcWKS9218D0xk4zP5nL8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768753567; x=1769358367;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=skaHD2ZK8wsoM9YD9rQPN2+QgspBRM5OWlzt2BKzGIw=;
 b=vsDxPqFu4+CyBlZOrxtl7Bckx/Zph66YSAc4kNa1/n5MgdtEi3ycZqw09YrSQ6/s4p
 CYtXYIQqcMq6grI2eX0hMO6PXQAoihfztJyfH+9JaImQz+tNQAQTgjDGlvGXM+/SgiVP
 ZLsA3SZJ0CsuwVjcTVIp2qis092oJ16289u/4/nx8uZIUDZ4MIagAWW0ZUAGQufKbYqR
 pKfDPy6kM+7Va8MQAWdYpSQszCSF+BNhc3Dkuz8hBXzuJn6HDE2BBRRtzzBpMOruuOS9
 IGVdireL52NpgPUzO0NFS60IwWKXAhB8fyrjP3UG/b6QS4S36pMJsfVb/a4h0cC3ML+J
 TRog==
X-Gm-Message-State: AOJu0YxD68SA60VW3H5BIUS4dBwBk7rNQooruE/sZAQ4kzQzDprzfgCL
 yNxvW2akko6THUeu1Qwck+VIwlJrEMUlVcYCuXpgIef1SjFZJjbppc8AUWTUCaUIKoq1+jAvPc+
 06vooBrg=
X-Gm-Gg: AY/fxX6jmK99rYp2rfKrTeU9fTfcziH87ao+2i7Yo9rbmVCvBIA0l4DI0J2UIyEKLlC
 Arb+8dslVJcRpoH2thAvAU3/KpIBqJu/aZOZUc0PhhzMtGbBLdvww0oLJcLxyY2izOIUNTpjmdo
 EQzzULshsGg1kSyzx+Z89r6MqGmaHFLToJbDguJsHE4oaRumbmWhxlKJmKXtiNTtZ6qLYQpyL5u
 DDP6J5BTJ5A5l0wGTs06Wns9T03SEJGIqu5f6L29yEMRuZreuxfOd6Tz3Liim3h8Njf5mCq+O4B
 zK7RHRmPDb0Ld1Hb3wvNt+NsMC+R1cKtG28MwMo/BMLwh1ornXNyCFuDK2GTa95bq4TZOCPBJ7Q
 8VEnJTQJf7nXYQA07KdccvcLuGxuG05gqLEllY/1cOvLnQkGwSQlxBOLF7MSDChcq3+xQfWtcni
 OiR7pw4WeC7cGhycs9swykb4A/179W3oNdIdGSoGrrp7R95+eqiF+P1+p82A9Fajwn8Mh+fwCML
 HH3g0sG03djfEse2zMX8Bqh6fWCEnpTVciCxw==
X-Received: by 2002:a05:6830:3bc3:b0:7c7:da3:ed22 with SMTP id
 46e09a7af769-7cfdeeab584mr3666792a34.32.1768753567190; 
 Sun, 18 Jan 2026 08:26:07 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2a696esm5272134a34.21.2026.01.18.08.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 08:26:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260118014350.1329144-1-festevam@gmail.com>
References: <20260118014350.1329144-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20260117
Message-Id: <176875356636.59866.11278392755090959419.b4-ty@konsulko.com>
Date: Sun, 18 Jan 2026 10:26:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sat, 17 Jan 2026 22:43:50 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit ff498a3c5efb424accc1d825cc45cede2540ca13:
> 
>   Merge branch 'qcom-main' of https://source.denx.de/u-boot/custodians/u-boot-snapdragon (2026-01-16 15:14:37 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


