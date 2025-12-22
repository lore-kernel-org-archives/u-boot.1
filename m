Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADB6E6ADF9
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 22:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7522483F59;
	Mon, 22 Dec 2025 23:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YBzy0DoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C88F83E83; Mon, 22 Dec 2025 23:26:27 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B6B83F14
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 23:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c6cc366884so2094645a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 14:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766442384; x=1767047184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5UiSbQ+p8pn+hr51duCHBjixSaTSzHgqd/E0dKVmRQ0=;
 b=YBzy0DoD6ppZMWVfrB+1hoUVggQ8DEehKEpUURm2EDNf1w4EMItR8GEkDp95xTFosx
 IA5G7+Oe7ED023dWvPqk9wNtBazQzE4kau6GqMmrSJzdDVTBU42RJz+oMyqDccHoLnUE
 Mulw0oHWHe7l/ucC3hHxfQ3V9gDgC/+XgoSgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766442384; x=1767047184;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5UiSbQ+p8pn+hr51duCHBjixSaTSzHgqd/E0dKVmRQ0=;
 b=IM9hgmkrUOS9kiqIzK4//ZZ+awLkDgHfYma8yfm6pF2KFZvcBsUnlnsyfxPhvu6IXN
 5yV5yn8Cu3NcpRTyEDQ7KRfr8mDKChI/dNkkfgMRHO+oWnBU8jnxbnOwAgqN8AykKnjR
 a99xnKKGPJY/z+P9qcTphoqdgrXSBgBsXGEThgReheXWcvWRCRorciC+6x4WAmX8kJN7
 GdeQODmmBR6FK+Vdz0EbqpFu33xAa64OKGCiH925J+dhEIGPYbKD4ZI3s8lQa5Cd0ALx
 DNHwkYMqMe1UdOGGQ50464/PdYKd+aEa2o/AxmsMcSJB7MmkWwdkaZ0z5IesUOIdF+A0
 v+3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLBOKXroz316VWHSLqO7BeVzW83dh4Cndjmu8BE9LjlddCx/AGmLnRXayAOYMTiyAZ4Jl/DbU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9gETDUWC6UyCRCIsBWE7QND3FMwatTDEsoz+oGhlIuC2VxYUP
 ScZob1cFofi4v862YlVF0f/NDJ6x64TwCSJ8OpB9Mug/0O62fDcL1QRZjl8Css0jlcY=
X-Gm-Gg: AY/fxX7oW3MxgHjr180A6rn5XSrC2vlY9f16wEm42HM5H2V0vhDNKK9Yn4QiqaT2bn6
 7irDUHHYBKysyVQ765erleWW+YzXHA61FQD/uyeHmFYoPDAXkJvueecSQzvQjPbnQo9ZWn69XVG
 9Zo9JExfZux4ZZnygsfZhq++qRU1XFNMzJeuoQs4JQGahWf3o9EJgfrGjmW1EX84jvKkmMgO5HC
 Z5g2ImuigyUDnrC9UnuCbIsTmjPTmlK/gwQWaFgsI4gW2awXZoj8YqV2Bo5BGUXAjq7G0VOjWlZ
 H9jvk3cZOA6OOjzP4fnuT+HxFwLL3m5nN1wnikr2ByOQmmunwmA11Of7/1FFT3gEhyiNh9nmTyb
 MhvzQyhMTrkohdQfeQz+Xk6GhJnJ7eSLZ8VOw/fMKmDwKELjzExNDwhhdxb+ynLiE3il0zP3A5F
 h1rVn0SRG93+SqJz/gdV5f4Z1dJbGDh7skIpOTuCt0UWqtvQij
X-Google-Smtp-Source: AGHT+IHen2Iwtv7vyMgiVp315eR5+Mhxr6GZ3qQc5bFlYqDayzIuNW6wQBqEMIo0wfoa+GahlxwEjA==
X-Received: by 2002:a05:6830:410f:b0:745:a41d:22c8 with SMTP id
 46e09a7af769-7cc6689c924mr5918637a34.1.1766442383800; 
 Mon, 22 Dec 2025 14:26:23 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673c32esm8283376a34.9.2025.12.22.14.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 14:26:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: neil.armstrong@linaro.org, quic_varada@quicinc.com, 
 casey.connolly@linaro.org, andrew.goodbody@linaro.org, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, mibodhi@gmail.com, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20251222090105.2275585-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251222090105.2275585-1-balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2] drivers: scsi: fix double decrement of block count
 in 64-bit LBA path
Message-Id: <176644238299.926535.14000759304743520383.b4-ty@konsulko.com>
Date: Mon, 22 Dec 2025 16:26:22 -0600
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

On Mon, 22 Dec 2025 14:31:05 +0530, Balaji Selvanathan wrote:

> The scsi_read function incorrectly decrements the block count twice
> when handling large disks that trigger the CONFIG_SYS_64BIT_LBA code
> path (reads beyond block 268,435,455). The variable 'blks' was being
> decremented both inside the 64-bit LBA block and after the successful
> scsi_exec() call, causing incorrect block count tracking and data
> abort errors on large capacity disks.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] drivers: scsi: fix double decrement of block count in 64-bit LBA path
      commit: c0add0039825fbd40620284c202f7c4569154605
-- 
Tom


