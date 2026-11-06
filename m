Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F0606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hanq/r2s;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TR6PE484
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF164606AA;
	Fri,  6 Nov 2026 21:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7PIH9yVt_CJh; Fri,  6 Nov 2026 21:45:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18559608D7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794001502;
	b=N25J9vYP9m8v76OwW7nfyAcs2guZEaK/ezPisgrYS+DdLbHchUm/rOJ6wa7Vm4YEvtNr
	 0zgqeGkMThQ5egWOXZRn0PcRtZLKbi46XU84Q85UuUknMDC8T0x6Bp/nxXvrxb7CpbJhM
	 Hn/5UYZdTf6hXQgSLJxfv/LYkG9l2miPhft1IgmAufQeLey+m2XYdBKKckFYlTLucW79p
	 MYrfKuVMGGAa/EyNBN3YQ67eCIgiLO74U8I8e9dPOwQPmn6tuoP5QJPhR64GZELidS4yH
	 2cRTLqg5jdfbWbp9ZlCzayGrGy5So5WW7TiAoIkUaqzYYe6AZsrkdzHkaqPIfF0MgFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794001502;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0/cpPUhlWgGB6uUX9/9MVEJgHKUCvcporraEmYiewfY=;
	b=SX9Dg1ARMqIl6CvyMYWILdxYJ0FaoGwHWe9kIqZmOfUthMWaayDYvcWiwXcGz72vS9rG
	 9HZfyHNK7exDKaPbbRBo6EdQPsNhzdfC34oYhPNzJRgkUGcAiXrR4kfzlIQJYh2PX+OsB
	 f1oCiObR+MPo2LvXZt0RJuOJyZnwYJgTh1tE/MZL5KiDavYV/kANTHMLCm5JMaO1nP3IV
	 2UYhTKOlHpeuFNDnlJ1qTEwcL0oeaSZGUEbCQAcD3Q0NfrCA+ePuksrBdc6YxgDDiiS1X
	 hmktBTq3PLypLjotIsdp+9fq+I0EUO0J0AsEZD60eQW0QBCYLr3SJqxo5lkVvxbV4cg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794001502;
	bh=0/cpPUhlWgGB6uUX9/9MVEJgHKUCvcporraEmYiewfY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hanq/r2sL8sZp2h+tO66ynNK0kCc7KhAPPxhhcL44IH79K9HDxwmx0qScR69bKeeb
	 RTSr5/t8bIXCuqJR9nSuWyuxL3b3hX27A8UGJ55C/XwbibesNazb2fSWnOkRDcBGY8
	 GuWDovz7YIROfK5dVKo8gNWAcbg5VYOLF9Btv8AeiXdKHGhDQA6OkE7vpdIvp3HfAf
	 Smuc9WLjnlFCqoz+noVPFDVkLOxcGv+bndNYizPXLCPPy4VcOIzjkRMnkxg4S5YtaD
	 pFFxGU3AELZvFZJbIjUIy/AanjXBK6K3Te9onjiRxg95jkeBtIXINN5ppS1LhDA91T
	 yxvN/qU+jdmOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18559608D7;
	Fri,  6 Nov 2026 21:45:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CA4232A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8286E812C5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ImL1BBqlL9ul for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:44:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 54E59812BF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TR6PE484
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54E59812BF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:44:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 214CC43C77
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091901F008AB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794001498;
 bh=0/cpPUhlWgGB6uUX9/9MVEJgHKUCvcporraEmYiewfY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=TR6PE484aSuPG+FVhsDdFSMaDL/myNXEVVo9T/YvBsZsXWb3V1UzsZHtI1XYoH3yk
 mukbIr7eG82+Q0XZeIHZi55DSTdzmqn5yEBIMh7w/JE5jZEU7/g8SlajS1xxvd0NUq
 XURu+dyVnQaGnZTls/HEgklHUM5wqV0LZ0rdLuCtMB/SOjM1qyWRcqZLl6895lqIJM
 d8vSZscBMpCnEYDNZ103kARj3gldb37y3772n7QQQUqKW4JfHCwks9i8ROAamca9t8
 sFhTkZlzGXh5gcdXByjp5PXxh/9HVmMoOcNecfvHYc3b5Sb0BIBNIRHer/+uA3nA5r
 7IJJeYEImtvfg==
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5be4d648aacso869785e87.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:44:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGEoNDrUe8t3EAtG55wg+Ke3INI2WiXmiRwJjqwUiL0llhXjK4icVJ09kPkD7K6sIrh+Sut9dM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z811cfk+M9k+e+RUCBE8BwjgnTH0NyydyB9pFY4G7w7+xwn42RV
 0K1NReq9NOfYZOBGxYdcqiRqs/HmX9E308FeVK6dBpWDTWr5kDriuCNoC1Ry1N4G0uF4z0/fvcf
 Khlc2BVIRHJ0/Zz3w8eJSIWZERe5Izhc=
X-Received: by 2002:a05:6512:a96:b0:5bc:cc46:1849 with SMTP id
 2adb3069b0e04-5c003c3cba1mr1181372e87.54.1794001496607; Fri, 06 Nov 2026
 13:44:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106194621.510146-1-oss.patchbox@gmail.com>
 <20261106194621.510146-2-oss.patchbox@gmail.com>
In-Reply-To: <20261106194621.510146-2-oss.patchbox@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 6 Nov 2026 22:44:43 +0100
X-Gmail-Original-Message-ID: <CAD++jLnsCa1rgzZodwj_7uP+SEfQEmEPRA8aUqWx-fG6ReaSxw@mail.gmail.com>
X-Gm-Features: AclHuK_NBW1dhPNqvGN97kTrVBub9y4l-DWi_nFWLoGyI5hMmqgN6fP-q6Vo8AU
Message-ID: <CAD++jLnsCa1rgzZodwj_7uP+SEfQEmEPRA8aUqWx-fG6ReaSxw@mail.gmail.com>
Subject: Re: [PATCH 1/6] usb: musb-new: ux500: Free the controller if the host
 probe fails
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stephan Gerhold <stephan@gerhold.net>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 8:46=E2=80=AFPM Yuho Choi <oss.patchbox@gmail.com> w=
rote:

> In host mode, ux500_musb_probe() allocates the struct musb with
> musb_init_controller() and returns the error when musb_lowlevel_init()
> fails, for example when no device is connected. The struct musb is not
> freed on this path, and the driver core then frees the private data that
> holds the only pointer to it. Each 'usb reset', or 'usb start' after
> 'usb stop', probes the controller again and leaks another one.
>
> Free the struct musb when musb_lowlevel_init() fails.
>
> Fixes: 845d9cf61c3a ("usb: musb-new: Add glue driver for ST-Ericsson Ux50=
0")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
