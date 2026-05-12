Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE9DCD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 11:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B6A380398;
	Tue, 12 May 2026 13:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EgI4BFW1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4AE8801A9; Tue, 12 May 2026 13:41:59 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A938E8394E
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 13:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c8025aecc40so2553842a12.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 04:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778586116; cv=none;
 d=google.com; s=arc-20240605;
 b=P/gg7fEprx2fpuqmvQSQsUEJr5jdVzITq3NqmAvH5sWiJ+vltk0+fEtbMzXBJNOJ3w
 jaP3FoVFSiccoBlvIF/yoyLNvS8VIBE+VAo95q8thQrkB6UWIrphlZyRTw4Q//Kflh4a
 +mM1OUMb0rzZ8pVjfbn6nUJBawUMZwbBWZ9V4l793eTms0nG0WyDMlK+b0L5WoOIhH5L
 ze8BufPymr6qGvdeLymmpJLu3s8sPZyi2XjR55g/Exqd1R1UlQvyvuaEHTtpZPBJbiUb
 q53kmfcHkIWJFj4Wm18F44zMlxaMIATTDG9V/K6PGQbax3WllezWOp8JTBKAoic81grR
 grhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wBSeoGlEEJTkrssP0VPIBPkoFnQ5k2JE1EuugMqzS08=;
 fh=wgk5ribbbTIbz5NwDyq+e//Tc/Aqa9rT1o3XTLgGm78=;
 b=KIt60nm4Wx3FhocMiw+Ws2GqFrcaEfla+7qGeQQqydUWT9bSf5zzCIMO1P+XAYR4AV
 bK735fylJ+toq5jsmrRqN4cKa6l6vhOQ74Z6MsGVrJG7pJk82UfuhahbVTANIeZlv2IG
 X/4CDx88zRmAOhvoWJhtLp0jewsDOrbcFnHl9t2xkm+BdlIUT9RMcLNjpdvTz6bOpy9y
 HBSrcWN0XjJ9kfu6rsQlIssQaqi3bMlgp/EjqT7frChyIKDGtyupvbUUy75HA5UQZPPD
 C+LlPoc6mjoFa0gGbqlrim0xpGL8BY5cWmi1okU/p81OOsaFTRpU4/ZWRiNOMeWMHqgu
 cePQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778586116; x=1779190916; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBSeoGlEEJTkrssP0VPIBPkoFnQ5k2JE1EuugMqzS08=;
 b=EgI4BFW1ZmAPDOsRLoT9O4P45SCTEwamY5k8UNU2ICyFg2LQeo+PNuwbErTG2aZlGx
 EZv85PQICS5UDuwkAMexcHTv/+njz5h13vlvHKpv5Dcs2akjiHhZrUsUcX22mNlEbw3A
 R1NdToL8qLHOu6IyBTK7fG30EJq5UKMNCZp6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778586116; x=1779190916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wBSeoGlEEJTkrssP0VPIBPkoFnQ5k2JE1EuugMqzS08=;
 b=OkKtSyG4yLsDFmTZFThr2SUHDAl5P2SxEtSSBjXAYkx17mvSnGmuYtti31fkIyAKYG
 Lgjdd0EX5PMyhbWtditBpMvo67TK7gZ2CMsoBE7EdXB8AGmsyF7MfKM91adgNeTSvfJO
 166NI7fCRR7/9Yu5YiswPcBOX6fhuuUcSOmeP1c45BoSnd69EtxrX5b/3ZQFV1IwHEXC
 rWZcPhivrzZZap6nzhcf1N4Lmv2QwEYWuoU+4RPl3KcmC+Umlo4ucjk6JM3ViZS56bLj
 PSsrPKdzY8qvVsRXXTl6FIuQ+n0dHaGUwgog3lQj8lIc/hGZXfh7vw4N/FKrfgaZ6W9y
 nUqg==
X-Gm-Message-State: AOJu0Yw4ZEUtf+n/U83T46eAsD/eOmrjLRwROlkqSZfUeV5dlyC/aZZB
 xewsKYhl0ueCfe+j1txRQ/YsUjQrCnktY8LG5WJ5wRH2deJLPsDyT8X82IES6yhtVk/ucFnlMBV
 mjgUmWG4MIJkS5iKh580U7eorbA7lGNnvIm14QXFd
X-Gm-Gg: Acq92OFX+P09F5Gk2FkU5osf+JGWw+KODF7wBYLwRIZ9W9m4RXqJLJ193WDvMVMSeXF
 iF9Loi/SGleZZmAQYplTec089Sg1mqTBYRyZ2LfewGeBPpblMLjv8jR96YY8fiPT0Pxe3sMNWZ1
 Qu1i7hH0ScGnXB9pAH0pE9+6I3rap69HWOhc3VC0UOVNc9edQiW6GXSRR8Bk2bs0moKlLdReUAj
 MvbaisYOoILsb6/j6SOqqKn1RULP/ekACjO1S/avMpG37Srodq1RTN6NO/GjO5o3Msfh0k9gWmY
 RsO/1w==
X-Received: by 2002:a05:6a20:2449:b0:398:8ea8:5f9f with SMTP id
 adf61e73a8af0-3acd42a9bd6mr3447194637.16.1778586116119; Tue, 12 May 2026
 04:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260512083949.3493010-1-christian.poetzsch@kernkonzept.com>
In-Reply-To: <20260512083949.3493010-1-christian.poetzsch@kernkonzept.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 12 May 2026 05:41:41 -0600
X-Gm-Features: AVHnY4LZ3sTXLryyvII3mJNbVJEOGis8bN9kCsg90kDj3-SRULDxBV4sLvtYixY
Message-ID: <CAFLszThAo7B_Hyj84H5Btbdji4QQxQaZfzHjrrNEFE89GjBRYg@mail.gmail.com>
Subject: Re: [PATCH] virtio: fix return value check
To: christian.poetzsch@kernkonzept.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-05-12T08:39:49, Christian P=C3=B6tzsch
<christian.poetzsch@kernkonzept.com> wrote:
> virtio: fix return value check
>
> The virtio_blk_do_single_req function returns ulong, which normally is
> the processed size, but in an error case can be the actual error. Use
> the special IS_ERR_VALUE macro to test for error.
>
> Addresses-Coverity-ID: CID 645833 (DEADCODE) & CID 645834 (NO_EFFECT)
> Signed-off-by: Christian P=C3=B6tzsch <christian.poetzsch@kernkonzept.com=
>
>
> drivers/virtio/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
