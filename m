Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3D6D49221
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92EEF89187;
	Mon, 18 Nov 2024 15:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cJ0YxU4G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B583389396; Mon, 18 Nov 2024 15:19:36 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E2989124
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-460ad0440ddso27323161cf.3
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731939573; x=1732544373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3aQu/O9urhIq3wwZNFbZFws3DKJ3LjHW+R53pei/Wz8=;
 b=cJ0YxU4GkDR0PhfpOG4/9I4uiTRO0HIfCbN0w/T3bznwSe5IwYLqrZGzkn7gcIWDi0
 O18Zr9VRd7F0dHfPko38rnv2peo0uj039Q0qZzOgz0MwyNyClSaZywkXWlHO4Ovto+pW
 RKye+SKEY785pHkRVncgMN2Lt+7I2v7hAslUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731939573; x=1732544373;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3aQu/O9urhIq3wwZNFbZFws3DKJ3LjHW+R53pei/Wz8=;
 b=UIXhe5gWzIVyhZxHIWYNB+DCc+Gkg3MFeJZpuYcs7xMVBPF2Hodzm6oGOqlUDCOYpb
 jajAM79c5At+dlaucwNt3MDEz/li0fXynWgepu08/qKa3EGdO9WEGyGuxpDnQabZV5Co
 Q7bYWE6/dwzJUhc+rx0SmIlo30Gr7DcWsBi0utaKUMQVqqefuaCfYpKCsN5rx2dAUN8B
 BaE3utQ9OSJnK7WN7npu25zpn7oc9pxFzYUawJD362L+kLhH6xpz59B5gPm5lXuMPzuy
 7mCPF0LLmgJqRcKIriV8KBLKXN65L8qa02l66b22Dmmo/exnx28e0r5jB++MO1MvyXE1
 Rflw==
X-Gm-Message-State: AOJu0YxmKS/XyrzNqItVbZp19ocIuebogUnEDB4/yL5ZVi2Zs8NR5C9c
 1+uQiGUmw4dgRAde1F+JrhWDSecIy0BTO6f47VEsNzpRJdDlkCINDwtyBiKB5WQ=
X-Google-Smtp-Source: AGHT+IGqiRMpo5sHQTtDonh2pzQ6u6d2el752fkFT3AkH/f2kthX7djBr8HVMq92eLstl8hab9lNZA==
X-Received: by 2002:a05:622a:6113:b0:461:6f0a:3826 with SMTP id
 d75a77b69052e-46363ee1e15mr225905931cf.55.1731939573542; 
 Mon, 18 Nov 2024 06:19:33 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24e44sm59075981cf.59.2024.11.18.06.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 06:19:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20241031175025.74124-1-sjg@chromium.org>
References: <20241031175025.74124-1-sjg@chromium.org>
Subject: Re: [PATCH] dm: sysinfo: Shorten the SYSINFO_ID prefix
Message-Id: <173193957135.3366111.7992721769488938600.b4-ty@konsulko.com>
Date: Mon, 18 Nov 2024 08:19:31 -0600
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

On Thu, 31 Oct 2024 18:50:23 +0100, Simon Glass wrote:

> We are about to add a large number of new entries. Update the prefix to
> be a little shorter.
> 
> For SMBIOS items, use SYSID_SM_ (for System Management) which is enough
> to distinguish it. For now at least, it seems that most items will be
> for SMBIOS.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


