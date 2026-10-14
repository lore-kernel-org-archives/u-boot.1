Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC4ACC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 19:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B61B440791;
	Wed, 14 Oct 2026 19:30:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vSCaJ-NxnpEb; Wed, 14 Oct 2026 19:30:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0DF72407A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792006237;
	b=Fmm32ckREMjJ41ptUcXUUx/9e3CWm6750qb8ryKy0a42gSgkq72RMMkb4iChCYL2tp05
	 QKMwz+RCHOF4iDKFH98f4N0mbcnADi58SBPnZPj04OrKR6uBFSd6RxYNq934wzm45eXvq
	 bscfH6ngy5+CgoiD3zErvxlFxnAtP1D0B+4BXOkkLgXhiy5Gxce4xg9mk/Z138SWlIWuu
	 d26jXbYfmkWRWDqlQc6IYVouKTgA1vXORCfnnHEkxvmKmuKfWJtP1BvKJ9jeu8IqCDh9v
	 9Ydkg7N1z5dpYMqEffaAht94q7y14rlcWMRwLHGBftjmfXq1o9/XWNCGjkjeSGMt9CA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792006237;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Tha//RCY6n7oABmcLueT9roVn5TI2x5voPYndVAjUHs=;
	b=ONspRTyZYHmWubitmiRCLabqr4jLXCZbh+0rtJeFWIFGLM9l8VEV3N4Ahoio+Ni8EZln
	 qPXUfUgdDke+Bec3xcL1fq9//yO2Gs4eQtJrqpOu5yQWtqi4PjkBKZ3JC4trAqrHMize9
	 E0nrorLUfmo6mgRLDe4GhmFtCGBJnpq567uTzzNvUwnNFEpaCV4jslok+pMLb5IS7woxV
	 /HIDkPIMTixcLf200sId9KPLI1I2VgPZGDuOifiy8nQSW/+NMqbjgKekpIN+++15EYKQ5
	 XdqC4my0hupC97mGHdDCXMbZIO2OhJ+9mFiTzpFoJvMrSa/tXKEM5O99XFkLcSxTfNA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792006237;
	bh=Tha//RCY6n7oABmcLueT9roVn5TI2x5voPYndVAjUHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0fNhy97NMe0eC8zqVMYQZSpODnZ2K9uStHu6Ip/FqSpuq4pSFRyeeFhr5irwKfsp0
	 nCojMFichsfSyxi+5ImVVg5Lrt8+7XfcI6w5VfIzSME6larJzmDNjYN2iVM8YwvOMe
	 jEl+A/Qr0IlcD9CPnfCW0vAOyHg+ZvgdqlWWs2KuTEDWIDDksr1ys1J9OAD4fh2ngn
	 6PWpiqxsSMWgRXdgFRaoEs8ilIZuj9GVC35F7HvSu9kDdW9PF3+g6OSs1xtHRaz2PV
	 Z2wkpRazWwmswBu4Oax5CFRHZrVJTqJslCdGL+c+SvCmRo87N9gMjAF0umpGt3PYLK
	 zByLnTLoCzwlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DF72407A3;
	Wed, 14 Oct 2026 19:30:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54338A58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E57280E33
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:30:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wmTqhtXBiiAE for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 19:30:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 411D480F4A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792006234;
 b=HMNviwtolr6RZ3Bp0y1Q2j2dYAc968HrEkMaC807aHWRS3nA5o8bsZVSOUR4ixD/lKlL
 eY0/4VLPngNN9nlDGCqu4LQ+h8ZLuA6PPdRZUqI9Din5lGwijewoHY9aUC3xt+Xt21LXe
 s8qMJSRi4xO4q9EBJLzFlRgctJucxqbLHV7Dsxo3zkIAOAoSJkE7ZZXPyeaJUq2Edkctf
 1crUoQ3gIKRMqln5KJYVKCpl2YZaKMwoFuEMyjbLuGkr4jikdpvtbUAXZqB4CbuAOZ4Tx
 8kXQwhnlgwaMT0hWcsltACbbejz2/OkUivTZAeglICj0aYNTxf0vAcEw1A1O3YppKRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792006234;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=Tha//RCY6n7oABmcLueT9roVn5TI2x5voPYndVAjUHs=;
 b=escMvB3MvNtlx5YNoicWsg8Q4slXng0rrn7qBquKtJ7PePsws5UbLyqTjBdS3utcV5Lp
 aJpbbqfnQ6RQ714Ze4YZa1eLunxZWEILcwgbfx2Kp7aoWOPfIVVA1TNXFwDr8a4kzR1No
 6F7zsioGx3kv6vxGUO6SwfPw41us6F9Rf8GPhBayH58tnD/ZQGGKjiHu4xoQGaF5CcGc9
 so9Wo0w0LK7eo9frk0DTKidACTO5Tp9Bweep5hVGI8owJEFMaE+Kheo3KUeP8IPiPlyz8
 JmTDCVqSdPUWHOXNMjGtH23GQ1Mlt1LYzL3FgGowhUvKd1o3pjig2bnMfUuUUgf+8AQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Z6KQNoXI; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Z6KQNoXI
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 411D480F4A
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:30:33 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so2841645a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792006233; x=1792611033;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tha//RCY6n7oABmcLueT9roVn5TI2x5voPYndVAjUHs=;
 b=Z6KQNoXIKJ3jm+FjlncU5kPyvjczcQ5n6lr5bc1qNeMGupkyaXwEvW8ZLfd8hdv0wg
 IW4dGOu1eGLuN4lti0e6LPWMim0unm2kE5FrtbX6OOF1UYPWj1wWoyVLD+xZurVD6DM0
 JVhLLwrXUTzPLRRgmzubtXYxOSXrFFZc0X6/yvMBvQI2SxCHQ622Ai7IQE5ULCbGmcTo
 gH41yQtQiz4EOK69rCD+Y5DZ57puozJ6COrIkrTndFfjQk7T7anUYRHmDOU+ikbIe+qP
 lVBGRX96vHY4w/UVpbG/0k5PbYzvK71pIJUmJxw7AHUh+B6rwTKvq0BSvqe61PA3Lnoq
 7jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792006233; x=1792611033;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tha//RCY6n7oABmcLueT9roVn5TI2x5voPYndVAjUHs=;
 b=lmp+Ct0/gz8Mo3YYIWW65z9MSm3fyYabMDCWcKyaFUYEEafHTRaBqX5spRFzoCs49r
 RiIksnqggcBYLjKFHBb+eazFuaes3oPOzURXlTAVHJWiseiMFTzei9tjnmZX/9Jgq4/b
 jWL4W8/DKCc5CPDXJNU3rN5tZCT9ERNv7443RZ+boNdMZCP9M/55SDMUTrWOoTQ1Of1/
 bBjksIdhpyx4RvrAcATa67GtYDSFu2Zi/wttbHYFHuMJHOexLxMCLRQDv1wVRf/z9AmN
 my+0fwBxUf4bV4CeP8G4EE6ICFIPxicK44vHZVdUHbCLGwHb9HPG4lAxzS3p7MuJgpUw
 6iXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrNFz0qAvX+9Y59ENoefh6bzg02xg8s+gTz9Eet156ceYxoLb9v9uSxSr19K46AjS/H1AKDFE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLz21C9EE8Z5btLIejweCAoJmAovpBBltaIDvEDjDWaMTX0uNn9
 d5kBVO/BbD7wL6uQ24V4UaarFIpSEy2qoTzXYbzxIEwN5/WlQHzK71cg
X-Gm-Gg: AYBFou2l5fYQmZFjWOSDyhcNM2XCL0nmMLRUrBAKcKTmVKypp9YeUZF+spf7Thd8qDu
 RQcCEGRVT4sU+b3Z7dpYnU5x3g4eO6dPJnvhntYHdiYSoHN7xzptOrUWajo/tFGZ+GzrpDDr8YD
 ldXiXVyYKiHiBircxoIGkietd7T728Lt6e/Tcnz/hb9YzcbgmnOn0nXhNwJa3bPBv3SI9qHNrVd
 3RgmPUAUE3Yxg0pPp83g3xNqO9v3uZ/WHnGvtNBPDTKfdCK411hMvwqpn+mld/Y0grSoEHBeuwa
 uRLsT058rR9XBek6undhpBqoDwzVXUZK13A3PIyFJFlQYwKgoPc/Vl8nqK/4O7j3k5UGGXfX6lG
 DcltnqKSYhxgv1YIjekyZ/WKGy6kIu3WArKSJUItjxzdPv+cGXvpGwURiqbmN6qNlDmdO0Zh31l
 iGEPybsRNGXOaUqhM71hE4Gx2LHB2A/eE2XXVkrxarlwrjt1qy33WVSm6FDAj5Ykqg8D7P0DM=
X-Received: by 2002:a17:90a:5184:b0:3ac:17c:6e82 with SMTP id
 98e67ed59e1d1-3ac15d46137mr4833039a91.45.1792006233153; 
 Wed, 14 Oct 2026 12:30:33 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac939588a8sm402034a91.4.2026.10.14.12.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:30:32 -0700 (PDT)
Date: Thu, 15 Oct 2026 03:30:28 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 2/3] doc: virtio: Mention the RTC device
Message-ID: <as_YVJZU62jzF25K@google.com>
References: <20261014190631.2232208-1-alan.tseng.cs@gmail.com>
 <20261014190631.2232208-3-alan.tseng.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014190631.2232208-3-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Hung-Chun,

On Thu, Oct 15, 2026 at 03:06:30AM +0800, Hung-Chun Tseng wrote:
> The list of supported device types still only named network and block
> devices. Add the entropy, 9P and RTC devices, and note that the virtio
> RTC device needs QEMU v11.1.0 or later.
> 
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
> ---
>  doc/develop/driver-model/virtio.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Nit: Since this patch also mentions other virtio devices, the subject
title should be updated to reflect that rather than only mentioning the
RTC.

> diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
> index e5da9f430..211304706 100644
> --- a/doc/develop/driver-model/virtio.rst
> +++ b/doc/develop/driver-model/virtio.rst
> @@ -28,7 +28,7 @@ queues configuration and buffer transfers are nearly identical. Both MMIO
>  and PCI transport options are supported in U-Boot.
>  
>  The VirtIO spec defines a lots of VirtIO device types, however at present only
> -network and block device, the most two commonly used devices, are supported.
> +network, block, entropy (rng), 9P transport and RTC devices are supported.

Since u-boot supports more virtio drivers now and likely even more in
the future, I'm wondering if we should present them as a bulleted list
for better clarity, rather than listing them inline in a sentence.

Regards,
Kuan-Wei

>  
>  The following QEMU targets are supported.
>  
> @@ -72,6 +72,8 @@ Requirements
>  ------------
>  It is required that QEMU v2.5.0+ should be used to test U-Boot VirtIO support
>  on QEMU ARM and x86, and v2.12.0+ on QEMU RISC-V.
> +The VirtIO RTC device (``-device virtio-rtc-pci`` or
> +``-device virtio-rtc-device``) requires QEMU v11.1.0+.
>  
>  Testing
>  -------
> -- 
> 2.43.0
> 
