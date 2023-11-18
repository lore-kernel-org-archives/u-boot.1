Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C47C5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F012C874D0;
	Sat, 18 Nov 2023 18:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OOeSoJQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10FE486EE5; Sat, 18 Nov 2023 18:11:51 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33F586D11
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d9a6399cf78so2424946276.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327505; x=1700932305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+6lMHCyMAG7SBDzcmwfP6vyvh98sstroQpASibjTktE=;
 b=OOeSoJQQ3CdAEtPil5nMfR+tQMZ7BpN59kD3uDDLYSj6A7g2Er373DyNMByJ/199GW
 v5JkJ8G5lMmJ/eptFmRRijPutQw0sE+AU1IlzHZ7Qjyht/44zPYrf076eC1/Chiogs0q
 QNSLyC8HAAtw3i3lB+E/PXn8ilxd1vn5CzAV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327505; x=1700932305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+6lMHCyMAG7SBDzcmwfP6vyvh98sstroQpASibjTktE=;
 b=Erg1VVTw1m5Q1a9ndCbwJKBPaJUXYDjJLNzQiw4l9tNA+2PMrdgY/fQ9JV+1uylI7p
 Q9pjzD0tEmwOBc8ISEe4/6ZQfIqJ0ZKH+SIFIXsKWw49SSwRyqobNh7T+PzQRFYDl3ou
 kVCbb2txptBhwyPEH8BunGDuDtwUJBkpNLT/KTTd1wHS1loYn0k8Y2vTrOSPQ8ZT5jRd
 xjKcJLhJwwn1gz0dGSrZzE+iDckSoSKnxDju535asPHviXPerpl+cXzcgOmbRIl+FybO
 uP26LJ3DlwByDLz3wguy7gwRmogDmi2iB/Qjqy5aeqed24hHJiC5lFIlqQMe2DucpJ6s
 ds0A==
X-Gm-Message-State: AOJu0YwON9YoQZmUza/d+qEvIn8d5jMsaTQeK5veYHDNmD2tmUNokFZ1
 2fOK5m7pGEVdq1DUZC08Uu3vp5OAMWm16aXNKPC8+FKfoTuLRkBqGOI=
X-Google-Smtp-Source: AGHT+IGQNibceudEdpvl1LmiZyoiVH4efyI6V81Gd4gktNUcSJbOBG0gh0VVDkav93S8WgYmE/zpyQ8n9LeHWbzpOy0=
X-Received: by 2002:a25:7046:0:b0:d9c:e4e1:b3e9 with SMTP id
 l67-20020a257046000000b00d9ce4e1b3e9mr6073988ybc.22.1700327504863; Sat, 18
 Nov 2023 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20231117212039.1210784-1-i@shantur.com>
 <20231117212039.1210784-2-i@shantur.com>
In-Reply-To: <20231117212039.1210784-2-i@shantur.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:07 -0700
Message-ID: <CAPnjgZ0bdMs7WgudQVkrERrbf_+x5vvXa4S7TkN48iYM2K6=hQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] bootflow: bootmeth_efi: Set bootp_arch as hex
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 17 Nov 2023 at 14:22, Shantur Rathore <i@shantur.com> wrote:
>
> bootmeth_efi sets up bootp_arch which is read later in bootp.c
> Currently bootp_arch is being set as integer string and being
> read in bootp.c as hex, this sends incorrect arch value to dhcp server
> which in return sends wrong file for network boot.
>
> For ARM64 UEFI Arch value is 0xb (11), here we set environment as 11
> and later is read as 0x11 and 17 is sent to dhcp server.
>
> Setting it as hex string fixes the problem.
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>  boot/bootmeth_efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Now the question is how to add test coverage for this.
