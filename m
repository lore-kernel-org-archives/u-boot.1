Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABB1C282EC
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 16:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CD3481895;
	Thu, 13 Mar 2025 17:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E5MO/Cfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA39F81895; Thu, 13 Mar 2025 17:37:05 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7495A80F9C
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 17:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7c54b651310so150855785a.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741883821; x=1742488621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZQGFeA9QqTVy87r8NpActPcQIgSsiM+z9YR52q5A6mc=;
 b=E5MO/Cfo/i3wcz5sUyY3oe0gJE7m4QMt3SvN3BSpugsro7a4nnnCLdjI7VLQuzhNUw
 k2IkPwhlzzn4qIM76TKNZ9M2ms0Oq94wtgroq8rMwE9WyDRNG/elBJTY/9XrkM1gLUdM
 Tbuyc3JZ+CgzJKCHbQZkPf9OAsGkt2YOlSz3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883821; x=1742488621;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQGFeA9QqTVy87r8NpActPcQIgSsiM+z9YR52q5A6mc=;
 b=hLVUioBE+ZvTx2Do1NfgH/GEVrNwQvdwlW4HQfACZE3s3NKDbWl5wkjgFY9hZ0sCUc
 Kdf79ibKl9g5f9x/dkNK24Hv/UjJNGmBxLE4ncP31/32TTR6E+DdjVEewkHnfF00X4ww
 LcNulz1B3eAoJLnoMcuaBlDV2r3u5ICgeInS9YUVaLkBGu89jb3oLjNt9cFJccX4d/Ic
 iCkqHK6kSIYIkN6+g5s13KYrUmOG7rvU/z6OwS+ChpdC6/SDD9/YJNlfMuWY9ZjebnJv
 Zp2jyrytKWe3iyw+0u+UxWkKR7DgCcN7MMWBFf6oat/fyEXMwhRPZM1V2Ft23rf5s59E
 lbQw==
X-Gm-Message-State: AOJu0YwCuZnYKH8fqIA6TCNRcQtF6k8myyTQxyidptS0MPkJI3BdOEgT
 9suc93FFb0qg6e6kzOwEdSp0vxgsXHZaGYzDKeDctBlQnDlQAcBkKQcnvaM3beI=
X-Gm-Gg: ASbGnctPeXbMOfaRJakRNvPdCMsos+EXeqYnPYZ6IzPL9lK48A+voWc8XiTOrViHSr5
 5AbY4MzTm2oFyXhN/KLmLtfLT/D/AWKVXLolLhRPyV9vIPlrevSRQUF85URlPKpAwe7Lm5aChgw
 h4Zau1c1GBDm8klT89IoTFMJeVyp3vDEMQ5NloB2ib3aXWs9SV8oMRM42esWY5En86RCf8aSuKu
 4/+MYRdZV/WHbxPDdC6Tm5dSXOTu4ClGKduefEgTEVqypaARSvVHmaj6jZ3O0vCizq3lQdiVnup
 3kREhWEH3yB1f0/Ys5ZzD6LKxEJDNSiaZgIhEqmR6ktERY7rrRMEAoA=
X-Google-Smtp-Source: AGHT+IF/0KpuhdqCf5rx+ktf34+grejsmzrMT6Qz4V9GRlUgzXJalpygG+FOJZADHzhjVkFw7tUF/g==
X-Received: by 2002:a05:620a:600f:b0:7c5:4949:23f1 with SMTP id
 af79cd13be357-7c579f8f40cmr66670685a.40.1741883821017; 
 Thu, 13 Mar 2025 09:37:01 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d8a3acsm116157585a.109.2025.03.13.09.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:37:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, mbrugger@suse.com, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <CALeDE9NNZGOvYQNv=XtHryfebDwjULbm30XmzjE_bAXDuz2w9Q@mail.gmail.com>
References: <CALeDE9NNZGOvYQNv=XtHryfebDwjULbm30XmzjE_bAXDuz2w9Q@mail.gmail.com>
Subject: Re: Pull request: rpi-2025.04
Message-Id: <174188381986.1161541.7472672662896829252.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 10:36:59 -0600
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

On Thu, 13 Mar 2025 11:18:55 +0000, Peter Robinson wrote:

> Please pull the updates for the Raspberry Pi.
> 
> Updates for RPi for 2025.04:
> - Copy Bluetooth device address in DT
> - Keep warnings from firmware in DT, if any
> - Only add frame buffer node if CONFIG_FDT_SIMPLEFB is set
> - Add identifiers for the new RPi 5 series
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


