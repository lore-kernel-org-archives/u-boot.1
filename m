Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2592CC47074
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B958287A34;
	Mon,  8 Jan 2024 01:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n/aaJOZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E71287955; Mon,  8 Jan 2024 01:16:12 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6318E87987
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-680a06cc763so14526636d6.1
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672967; x=1705277767; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+eowPZlpWllHiZTuwfQ9MjgtljefLa655YtZ0Dr80+k=;
 b=n/aaJOZHm+eN54V6c88gOFR8acE9QCx4qsb73BipmtIlLc6e77hnZv94jj+8IGpa4U
 GsF7hHfNc+2eZ8Oql6spGrC6CDbWM3/1omcfHeU/LHVVClSQJ/bgqzXTcI3/Z6L3cslu
 cWTeM45dQ9cbBtsItxL5rYbiI6QzN1k6l3nk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672967; x=1705277767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+eowPZlpWllHiZTuwfQ9MjgtljefLa655YtZ0Dr80+k=;
 b=UhVHmNHCG61KsvSveuesTC9OjRr8w3rX7FMahSqQcF0iGXSrh20oJy9lQl97ucOGzn
 pEv5yR3Ti02pCbPnDbFNy2gvabN+Cwmb9V+0KtEjcuTZNPQqmqGdPcStQcCiZesI68+/
 9HFCJ19GAwinQ9D5UeaYtbUkKNyacydCxVo9+u3ZKIq5KyITYdMVbRcrIOVg3d9ZyeUd
 tw0IMiUjZ+QlvqpyeCkS/aqnyfoTF1ggu922RkY4B3l9yOub6icuknFdxbiFqN+PYes0
 9llgboAGsU60ImHYMDgmjg1EQQGZi79cndgUSBMzwK+ZQXMy/eDi7sA2qswwI9KM3YTW
 tZlA==
X-Gm-Message-State: AOJu0YwpUR3mzKFnYFS4UWkFgzvg4LRgBCZ/rfyZNqCoY56jjlpW8txY
 TF7010NMnt9DQBWj6x/8r60ndCyjq1Sp9vhAI7xGwZbLHbA7
X-Google-Smtp-Source: AGHT+IE6iWTCnx2NAGjgfA1rkFSb81Y7/kG+JsD9k6Xr73pOhu0kNnmx1LWucJK8PbccDWAY7UGpFvkqHL5+R+0ycLI=
X-Received: by 2002:a05:6214:f6f:b0:67f:f68:ab47 with SMTP id
 iy15-20020a0562140f6f00b0067f0f68ab47mr4861175qvb.111.1704672967039; Sun, 07
 Jan 2024 16:16:07 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:06 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <a67e7053-e02c-440a-9288-7c3d71c1627a@gmx.de>
References: <a67e7053-e02c-440a-9288-7c3d71c1627a@gmx.de>
 <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-13-sjg@chromium.org>
 <da23504c-e4c4-461f-a6f6-5d52bc79a549@gmx.de>
 <CAFLszTjcmRxoG6C_nw2wX1gfK9y076YF7aPtME=jr=4MH4zTZQ@mail.gmail.com>
Date: Sun, 7 Jan 2024 18:16:06 -0600
X-Google-Sender-Auth: 3ipOBbhkRpEelyUflGztwFbb-NU
Message-ID: <CAFLszThQPkjR92bhEiF2uBYrMtbdc0wbxTxm=D9RPhHB0oAxOg@mail.gmail.com>
Subject: Re: [PATCH v5 12/12] efi: Correct smbios-table installation
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 1/1/24 01:37, Simon Glass wrote:
> Hi Heinrich,
>
> On Sun, Dec 31, 2023 at 9:27=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@=
gmx.de> wrote:
>>
>> On 12/31/23 16:25, Simon Glass wrote:
>>> At present this code allocates memory when writing the tables and
>>> then unnecessarily adds another memory map when installing it.
>>>
>>> Adjust the code to allocate the tables using the normal U-Boot
>>> mechanism. This avoids doing an EFI memory allocation early in
>>> U-Boot, which may use memory that would be overwritten by a
>>> 'load' command, for example.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>
>> In patch 11/12 you changed the address fields in ACPI tables from
>> sandbox virtual addresses to pointers. Do you plan to do the same for
>> SMBIOS?
>
> I haven't looked at it, but could if it would help. Are you planning
> to add an EFI test app for sandbox?

Yes, we need a test checking that the SMBIOS protocol is correctly
installed. A tool like dtbdump.efi (lib/efi_loader/dtbdump.efi) would
allow to dump the SMBIOS table to file and then use dmidecode to check
the tables for consistency.

Best regards

Heinrich

Applied to u-boot-dm/next, thanks!
