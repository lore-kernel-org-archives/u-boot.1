Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9DB606A336
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OHrHLugq;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KX9uxdrL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9BC960906;
	Wed, 18 Nov 2026 10:46:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id feL8RFuu8yV2; Wed, 18 Nov 2026 10:46:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 05F06608AD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794998784;
	b=sRJnoV0+7mBvo84ZdGJhzhnbZQkygNAPVZyyX9LqlEwoOJMhgCVzK4ULK+Un4x101CMd
	 8KYxPYbN+AwvV8cAPlzZYUf7osDThaN9SXGVIp1megZbgwAweLDAh5b105HPLJ0igHH6W
	 KYk63Btip4WeunVH4JnepnXkRVWTG2zpa4sS3D/nWSpJJN8QYVSoCXEl0qcxz07SHC/fN
	 Ig4bo7QMHw855g8NVD3qPt9PlNzPzYeFFRbPrHCQoeKyfz4HPzvYEfWdxa5/27nABatO4
	 Z2odNdDen8pbrLyQXsAKK+v0S5fFZKYdmhvtQKkdYKjRV03+S/3Uaki0ck97GEg4ZtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794998784;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1nfca0Wf3LV/o0JDqIbOF2U9PNsyx/HFt1JGDWDrq+Q=;
	b=AHio8jIzPzBiTQ915PS8fYL4yRDkOOucVU/C0EpQFQkvYnL+1D1ce1whGxH8MGtEyd5t
	 TVGaxFRzADcJGZeviBzdQaNuRDHl47glKX5i2/u6DO0lyUf2kj5seXb6VCA5fdVSR/Afn
	 oYQT4vbrAaxVesr+6gSENAEDUxCSMKTYhgYb5UAbL2pJY5C1/TPYFVMededkrJHtG4Yjf
	 PN6+9gdoV2Az7JxbkK4x+1UGKu7B8gB//VKROzVPcF+huXvvRLASn2mnZpWVsOSiqtIFQ
	 WTIaWFFcq4ImZCkW7ALyKp2JbstSeggI0uQ9an2kjLoWb8491Oy7XhrL98RshtNJ31g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794998784;
	bh=1nfca0Wf3LV/o0JDqIbOF2U9PNsyx/HFt1JGDWDrq+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OHrHLugqsV4wRDu4MQj6RCGyyfO/GKTU8fUA1zFJ554PfSoMFAe2adcsq6a/4vzv+
	 C7xzgS+FSKk4Zu/AHzgLsJE1J4PvEvbAkZPIaeMZSONcM4WcCUs4bVkg7UYtakzY6G
	 I+Mr9Ltd2W2Hl9iuGom7Lcd7jVsrAXcCeMWoz63RLWFHhbLFHYpuvw9UzXIyhfIqsa
	 FhZzQTaeVlqNn9l5/EQFVWFfr6nNTWx2cPLQI+WREuXWQfvVTE2GDL9W1f7IX67i3L
	 5shLtc4R5d9xIQQA2X1sYXtRuYPlJkMBCfpPMB8a8TpTq1vzqxOnLZW8EPoIJz/zAx
	 WxvuZAOwsWIKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05F06608AD;
	Wed, 18 Nov 2026 10:46:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E14B2FB
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F41D408D4
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:46:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ootaa3hOqdLN for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 10:46:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 16C2E408AC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=KX9uxdrL
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16C2E408AC
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:46:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31C2784820; Wed, 18 Nov 2026 11:46:19 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 534E78481B
 for <u-boot@lists.denx.de>; Wed, 18 Nov 2026 11:46:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c4cdc606b47so123313466b.0
 for <u-boot@lists.denx.de>; Wed, 18 Nov 2026 02:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794998772; x=1795603572; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1nfca0Wf3LV/o0JDqIbOF2U9PNsyx/HFt1JGDWDrq+Q=;
 b=KX9uxdrLhzkco0JzrTv1PIGb/Ie9fIz+HA7j0RCX47PEQh9EYMjQ4j2D0E305V6YcF
 MxSg5r7JDLMMXE7mVXGmz+URpgS7SHc41K7mQO2kIqTG2ViSks/z5TxmSQeunxQ5L4V6
 z2W0nFmvjxj/HBXY9C60FIrOyrLxB6SCdZ83mPMy9cMu2KaVC5FeyxXyYI32Q9iHe9Hr
 QgeNR1Xuz1BYhMFi1Y13WT2u7MadtQrKbNyrt06traBedeaaatUY5YtahAChXlQCH9+9
 WgGJVoYhVbOU3H5sHML+GMiDajfe9Xj1RIBBJgti5tHyn8IwZKHq/hLWaGh3QQBhcI5e
 fzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794998772; x=1795603572;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1nfca0Wf3LV/o0JDqIbOF2U9PNsyx/HFt1JGDWDrq+Q=;
 b=VITjj2ktjAQtIP6qLdyssskAT/Hy4+YjsSeKzT3YbIcNQOOTrx5NHPtGlUuBhhgAWY
 MZt/mpvXWJUXZXwjQ3+zTmEp2rnzw1ebvUhxW8C/waW7bGte4D4KVadpbSwtqivOhc5f
 sDYGRSiTXVTrB1RNF/nDtYBvvbBjpmmxm4GuWJFPgwY6ghqMeDWByPYgTIALxyRsDAjP
 xs6Q1FPUyVkFAy9Y3xhiQY07dVCTa0dmHkInktoCZNqjljj4CYJZuL6aEZhjrQn/FqMG
 M0lAUuthP+kzilMY+0ebSh/5vgO6fOnqVQIxGbmugJwW7KAu2wSc0fk3A19PzhSCsNZx
 n1gg==
X-Forwarded-Encrypted: i=1;
 AL+hErF+2ejaNdJJXnsp+j4SttMzj8bPX2/XiP+etAwsH/KImWim6ARrDftDB+1KccY3taKbw5o1/QM=@lists.denx.de
X-Gm-Message-State: APuU4Z8MJIWLO27zwUU2uPTQMK5+oMx16qHAzuUxAQKine4yu8CghlT2
 YJsPppXjKUfBLlsdjMYnrlDaqG0NSjHrcO60xJHd1wM4d55rcWvbaVUhSsslLHO/r6PPSQFVmbP
 LNLYA0HrlJqkSw0ua06ot3dQnH9OSf6I=
X-Gm-Gg: AYBFou1Pnns/KnMyQh1VYBog9prus4V/jUVWblQSdt9q/dKkJ8xIW1WVNAntn0+zuxc
 p4/0R6NJzfVjJ0c47baENoZfF4f1rYB3obfp8wmEZDsMpdhbirETBl9wUFm3Wxqe3HmYxde221w
 WsZ3uG+VVZiNxFxU6rvkwMkmsqNAhSRLO5IZc+wpf/uf6gAxEBlao7hgSidUAU8WITUU76AjVlj
 7ZaNe0BZjvwhjDCjfyLdBa9hSBm82NGOC/trp3kAubeVg9A3rxrDdImxc3Oc8UxQyOA4qTTcHh1
 7yrofo3tXSBeVYyVt7DIBQvGYnVLqDVCZGCV3N93onvpsQjR132ADa9XLqimCdY3BE58hubP2PC
 7D1qcmnBulAdRt5f4Tvon4qcgZdJh2Op0oJEB/MjVeo+steAV04Q4lOk6qG80lqwindCy3o8FwW
 NOC6ISCyhwaWfm/q21mg8MyiNFaE6sag==
X-Received: by 2002:a17:907:ea8e:b0:c46:7ec3:fde2 with SMTP id
 a640c23a62f3a-c510e19b619mr180065666b.11.1794998771542; Wed, 18 Nov 2026
 02:46:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930075527.92697-1-clamor95@gmail.com>
 <20260930075527.92697-2-clamor95@gmail.com>
 <xhkdbfqy567t3.fsf@mkorpers-koolstof.csb>
 <xhkdbcxt65btd.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3HUqT+TqyRrkyc83r-sDXMcMEXpqPPYxhinvp1rs8pDQ@mail.gmail.com>
 <xhkdbse0ypi3o.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3NSBJo+n7=Km5+GmyuQ7QQ=FhKydXP=dqBnJC7w4K=4w@mail.gmail.com>
In-Reply-To: <CAPVz0n3NSBJo+n7=Km5+GmyuQ7QQ=FhKydXP=dqBnJC7w4K=4w@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 18 Nov 2026 12:45:57 +0200
X-Gm-Features: AclHuK9RsinGWFcuoKHU9EqKkNPk7UNvgADB0eXp_l5fuTL6km45usM60l0ERw0
Message-ID: <CAPVz0n0e1r42peR3nv9ma-nFmhsiXB+cZCa6EdN35MA_U8K-SA@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] fastboot: Add
 board_fastboot_flash/erase/get_part_info hooks
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Ion Agorria <ion@agorria.com>, Peter Geis <pgwipeout@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_FAIL,SPF_HELO_NONE autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D1=81=D1=80, 18 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 12:4=
4 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> > > You are mixing up. This patch does not add any vendor commands. It
> > > allows using native commands with vendor quirks seamlessly.
> >
> > I know it's not exactly the same thing. I'm just worried these extra
> > hooks will make stuff less maintainable in the long run.
> >
> > >
> > > For example. Tegra devices require bootloader and bct to be encrypted
> > > and bct to be updated every time bootloader is flashed.
> > >
> > > $ fastboot stage bootloader.img
> > > $ fastboot oem board:write_bootloader
> > >
> > > Used has to stage bootloader, then write is with some custom vendor
> > > bootloader flashing command which we have to make, document etc etc.
> > >
> > > This series allows intercept native fastboot commands of flashing som=
e
> > > partitions and apply vendor specific adjustments directly. So I can
> > > flash bootloader, boot and system with native command `fastboot flash=
`
> > > but bootloader flashing will be performed with encryption and does no=
t
> > > require from user any additional movements.
> >
> > I understand, that it might be easier from a user experience point of
> > view (just fastboot flash <whatever partition>)
> >
> > But adding extra vendor hooks also means having a specification of what=
 vendors
> > should do in these hooks: adding docstrings, adding documentation in th=
e
> > fastboot.rst page and such.
> >
> > I'm not NACKING this series, I just wish to discuss in more detail why
> > 'oem board' is a wrong idea.
> >
> > For example, do you have a closed-source userspace that forces you to
> > use 'fastboot flash' on tegra devices?
> >
>
> On production tegra20 and tegra30 devices bootloader must be encrypted
> with aes engine before flashing, and bct must be decrypted, updated
> and re-encrypted before flashing. We decided to use hardware boot
> partitions to store bct and bootloader, so we do not have traditional
> boot partition. Hence we are using fastboot flash to intercept

boot > bootloader (typo)

> "bootloader" or "ebt" and "bct" commands to flash partition and use
> our own implementations for them (for emmc and spi). All other
> partitions can be flashed by default and need no special handling.
