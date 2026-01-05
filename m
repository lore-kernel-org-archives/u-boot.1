Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A14C79FA3
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D54F83EAF;
	Mon,  5 Jan 2026 17:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m5z5XHaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8014983EAF; Mon,  5 Jan 2026 17:43:48 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ABF983E21
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c6e815310aso123620a34.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767631420; x=1768236220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USRE7daqoMuOpBwwLU5PSED7duTzpRDiSkrhJ8C8peI=;
 b=m5z5XHaPBmhDBw3wSQDzln5UrZqz8pgwvWJ293T06TFdIf6e4ccyinaAOSWYV+OKyE
 GpET9Y5NZqpZkrX4ncsdBQoXisgZgRPjF27CZ+fpwa1pZhbP1nYIF04lYZSWKuJk461F
 FDJOQFGOf1NeWIAlzjoFOmICHi2t5OMeGWCs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631420; x=1768236220;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=USRE7daqoMuOpBwwLU5PSED7duTzpRDiSkrhJ8C8peI=;
 b=SvaXfkwBuIB5Mbhw8EDOhsWjJbX7LbNDh4366sJZqavzgAzK+b0k8Hx8gIYb6vjF/n
 VVoRV1SWCeOxrPTKonxHR+yhr7to5WNDvx02rZ4MFDydYdYCnF0dMItwqKOTYgtboixf
 YQ8Jy/yjlUrVPCKJv5s5i47ime+/KfdEZ4n9IeEMxNU4CQiuZoD3N1NmpHNrQo8WjnpD
 tK0nPCE6iBs6NxKgL1EOHyBhlcXPctrvJe4ODOa4vSW+6NoBH9hSef85F3SGyTr7lxVs
 oLVX5cX0MbKleilIybT0s9MYy9G0o1byNEYrfyuQYRXwdXcKpuBlVD+0jVVoQlkZoQJ4
 oaMA==
X-Gm-Message-State: AOJu0YybBuMIUXFfrdRQTs16aMx0LyicY2RbFSAXC5MygsqsF/iDdROr
 JjU3kIpGEom0CBNK+zqjC9V9/Af/lBzBwEZUxe4WbR8IZAFHax1eIWZjM0VeHuAII9g=
X-Gm-Gg: AY/fxX7DYRAjN0JvbEAQ772gU4Kt5PfBMoGUeQWjyCGKsP+TQK6xydwHdIG93hPWBIF
 WqptkdLa4OfALo8Z9OvMxKgEtK8vIyLGigkEoL7Vgimb9ib5mnOaeDqSXzgP9q+zglsabY1EwHN
 aBBc/PvYb5d6T/lCR+Ezbv96udUn+FCcDO6UcKUasse471loNnZOu3ZeVd3D9xSQx9rPYd0caqx
 8YMNrESSMxnV7rdzGlL/e9hb/DrwhHAhU0csYnM9GBaxdhfMOEnJ+g3icIsiB49XnJgBUoiup1n
 i4n0uP6e/NaBvH2l2cRiDDGxkwymqtP8Zbouv6DFvWl4EgImiPEdTmXlD9kKeSw5VG8v4RyE7W3
 AxKB0Sk71q+Y6oyxdklmLojEMoWYpCwBcbewZFTiswahOkwPKJBYCDD+kBniT/EW5H9PDRzhaXk
 03IhoewpfDexdtU1pFwdbB9aoCCcBHKb87h2h7ZQX9yIK+d2DpwYhXT2MtDyFuLbBiitcmp2vPP
 ENU+gwLUxWMUlnScgoRS+jF5/agdtX/MW1zaQ==
X-Google-Smtp-Source: AGHT+IH0MoQgijnQyndNXvFcrdUoYX67wHV2sYZhJCKwamLOMrSWG3AKHtTlHGWgzlSZ9KroFKjbyA==
X-Received: by 2002:a05:6830:3141:b0:7ca:c9db:5436 with SMTP id
 46e09a7af769-7ce4662cc2amr37827a34.8.1767631420038; 
 Mon, 05 Jan 2026 08:43:40 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce45ffbfd6sm159258a34.21.2026.01.05.08.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:43:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Adriano Cordova <adrianox@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Message-Id: <176763141899.3271216.15651216830076609485.b4-ty@konsulko.com>
Date: Mon, 05 Jan 2026 10:43:38 -0600
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

On Tue, 02 Dec 2025 20:32:50 +0100, Marek Vasut wrote:

> Synchronize local copy of DTC with Linux 6.17 . This includes the
> following picked and squashed commits from Linux kernel. The squash
> was necessary, since the DTC here contains changes which were also
> part of DTC in Linux alraedy, and the squash helped resolve those
> without going back and forth with the changes.
> 
> The following commits from Linux are picked:
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c
      commit: 0535e46d55d7423094d8b553d704a0f7f678de77
-- 
Tom


