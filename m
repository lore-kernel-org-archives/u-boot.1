Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A57CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 14:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 947574078E;
	Mon, 28 Sep 2026 14:45:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AIiRY58ba2D9; Mon, 28 Sep 2026 14:45:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CCD2C40719
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790606737;
	b=K6juX4SgYV/7XA+cjOsyvz37DWsLPP/H7zBh53XYjG4Jlg9Mg0mZZSJ7kuxcVWTjS2qM
	 LGSPa8QUSefnz/Ksih8lOSAS9ZPYjEoHuCHgCXkeSik+SLc8IMi0fW6P2mXCH1Q7RsWLv
	 8tD3haKrFhCaZrsJ2TXyCjotQC+Bh730iC33h2WMwsCeDhpMb8s7PUl/EF7t5za5X96u2
	 umPP7KV3Qra72o86G1Zx7ZwPXEG2LOYB+9CeT8Xms2G9h5hIorDJmzOMPWPwjr2Mdf14f
	 otfFid7ZLqWdcTbHUpv9Jw5DnWt7+rNhcbVxmhhf18j4X3c2OUHXMVItUBeagrvlckQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790606737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=grg/Bmk55gv5EpEzepLmwLqQnnXSfNRXDE2ZqvsNX0I=;
	b=eSpsezGOxaF0lgYxlkqzotYRxzJkmPWiqeCnr6ZVHQgXF83kx7kwoUmgQ/sz+4OoARM0
	 ofN3B/5jb1ofS/AjQkJBsbdk0217t8kpRzzEUo0fgZYSVX/Tw8PO8Z2rv4z+nTScubOQN
	 kDC1b4qvIvFr/XrFTJQe3xC5TgizsBYYrgMqeQm0v7kyqRKPdyAZrkbwOzcI1w9AtSGg2
	 7EMSnq3x7ItcNFrWrKHHVP1l8k8BDdugXjnAKvbmFtbC8LeTH3yflWlld+iJihz79qf2F
	 2T7YbA/spZ5br1daJg40m6gPY9MWTCDb6cEbvmQElhwF+EiletO6RKYSPVr7x9GU9Pg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790606736;
	bh=grg/Bmk55gv5EpEzepLmwLqQnnXSfNRXDE2ZqvsNX0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lG7t7bFxnJyzd/+9l0wEYMlxG9UYByCHRCSbixUsb9/mGe6kEeEm4/IuSJi0vVOjs
	 TuhWnGSC9kaaS2uhX9vxKbtYUK8/3XTbJJX9wJBcWGNB4FjR60PtrYm/KejtPJjlu8
	 zPYgs/xcW97ggUi+W+2FwFyBukmWxpCORqK1s7G6NAL9Cm2DIaoZWrdIvdeGqJDOIJ
	 wvhiCBqmRlvNw8haA+TSJYXNplnARmB0ACeqrSUoF0vk2pap0mR1Ez7U6QIS7bU25O
	 1+XW5YqCSWN3h0FMajTAwgfAe2iS53oCbjAtKw8HJCi0EZzeHyW/87rKxCzg83cGFK
	 g7jmqh0psWtGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCD2C40719;
	Mon, 28 Sep 2026 14:45:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 842143D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C07B80DAF
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:45:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wrhh9KafKbOf for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 14:45:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 150A080EA1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790606731;
 b=ndk++G9f4JDxyGzRqmbTSr4QDbJDZ7WZo4wFInTKF+brksvKsgewEmeueVCJpFqCyfs/
 /MWEUPNE8Y9t3VF30GwVNgPhpwZDViQSdYs170FvFZy1wBEUE359oTTdRQ+IRjQVefVge
 2X6ENOycFXzR2ciT4b2kj2dJZFPI+2yyMygl68mA20N0ZVBAYMzMJnMKZrFdm2o5xasOH
 QpltDX8MB2JHCiwIuV3es62MU8Ze0+ggYGCar6rTHlzxEhorloxU/f6jHu21B0hdnR8Zm
 h3R9aIYHcmVLoC64/wiJ0Hquqo8mt0RwN6eC3ESp/o+4RHRBLZ5+W/aQldd9HYyytkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790606731;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=grg/Bmk55gv5EpEzepLmwLqQnnXSfNRXDE2ZqvsNX0I=;
 b=LhdyWOU1arpysRwcZsAUbO4KtIGfenA5QKP2HhxxhWTF+GETN7Sf8IDEtEMszOt7O3K6
 6EsmOTh1NR/lGNMOCp90zBurUib8p+4k/nRYZPB+wKEytB2QlXWwTSgYr+uD5gPAvTPuB
 QBqbsfS4XmDjble21rs8g8XvhoZUm5rkWLYBzWBrg9Kf/7ISxaMMoebQ4TNH4pNRj1kn/
 rm+Zxn5g7u9oWASmr/Nbt9jJplbxAmgVmf296GjYgFqVmbw1PurWpQtA4KHzrzaq9Z8Li
 7LAy1549+MiiLxSimOJkWCQaauTN0P7AGwelxrvmKKXbp6tpp+CVlpuF5v8tqbi1egg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=m5HSC3CM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=m5HSC3CM
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 150A080EA1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:45:30 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac5ef2610aso994132a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790606728; cv=none;
 d=google.com; s=arc-20260327;
 b=sj22ti800cJTadR977Sik+aTW5BziL/e5IQyTaXckKtHjbUJ0lT3ppjWAgl7U1Ja/b
 qe01Q45lagZt4A4StIAM6T0eSNcmsoRv4RWwmi91I7pfHShAKGM2oP9DzTnZrbNH3bsP
 eEi+YLo1p1+DjndiJBfzLDg3F+Y6F7f5CNKjb6m3Bl3mphF1EilZNl/lE3P/j/itPAGt
 OiL9BEpzcrjwElSrNQkfoJ/x2mYavYV/41wRCT9tRi/Ne0ticjK95Vku3sx2NqJsbS6E
 7u4kcEcv0V4d5p8oO2NiAqkaxQaqRY4hHBnQ+oXjV4QitdOnskPTdvtu9OnhLj6M/KUL
 BavA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=grg/Bmk55gv5EpEzepLmwLqQnnXSfNRXDE2ZqvsNX0I=;
 fh=fjzHfKI1tpcoV5+EnEGxuIqiAC6qcFR/q062YGAY08I=;
 b=kdYb88t3E0VqpVdjpILxg+bdrsAvgAtFgLPhOeeCB82iPx5NHaJ435RMSgyIDcCeTV
 p5TZwj6ZtCJFAA4RqhDrxvLhgVWYedHVE4tV6r6/lQX8WvlXHFg7Z+lpuWdah9YDdy5E
 n9NKwmsaYlI7Au8p0D7qW3aFV083bNvY/wBZedz9xMceks51Jn1oKR4m40kxjzvjXmyp
 jjoHhgYYNQQTf2bk38dspFb/lpAK3QEpt1E734hlV6jGWaxAwkvXfSvKghHuRGnHVnJz
 gg7DqVcKdRJd0EsR+Mvl7NL44Pua+R6LkB62PEAM8QXAFZ+XA61SsaamdJdI5pXLs12W
 MWgw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790606728; x=1791211528;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=grg/Bmk55gv5EpEzepLmwLqQnnXSfNRXDE2ZqvsNX0I=;
 b=m5HSC3CMD0suNvgkzZipkS2Gwq2ui8HQPB21Jh6K83LguaHhdYBVGqFAuAJ9rUp4CL
 WaNl/52mrVpZms5CoCaaec8Zq9IL31J7QOp9HHRmMwXVzHsuPHIOi92Wi08FS0pKjo5v
 4QJ9wx6zctzLhRgj9wgQZx61CkBxGAfXovh9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790606728; x=1791211528;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=grg/Bmk55gv5EpEzepLmwLqQnnXSfNRXDE2ZqvsNX0I=;
 b=Ec3ZF+qxttXnWbjXe9jl58Z5OKCr83BjNgb3YfOiEGVMQGvJ+KDGVUKbcWdO4HpxkF
 qDGw4wBGxUnJEm/3WI+sA1cliF9hlBjYw8RfGL6DvFY3blEEvCBY+Co+Cf/e2Qy/oMU9
 8850QdOl4XNDXL5JZspartDTnUtN1HwXB+syKXVeCM0sR9x2mQvMHhBTQOxagan9xqjq
 iXbRJ10XhzYcvUJKkbQ2mnLsAVaCblhRocExu90+344WZjcpOAZ54yUDSxEa4csZREC1
 /pyh3dlxeV4j7nDPsrVa9b8Y6y1kEw5XeQ5Sg76p2TK5ce56ktweqbtMlIvX/knyeM5i
 W4oA==
X-Gm-Message-State: AFq9FYJjibR6AA+RnQY9qnGXO15Af7NpeoXtBdr3xyyyO3YeVWHasi1A
 B6pl52dHsGCGwnY6nodWRLIw9LelqsfZUqFya/0aqx81ROaL07Y7ykIa4n7NIwObMo5yAT6Mx2L
 bj1aC7IqNXgC9xhVuKihbQ4mBDLPHcXu301+LpvAk
X-Gm-Gg: AYBFou0a/jxywm+0+iaDwxesiDmom5mRbJsmQDwwXJHQSpzB3FhUx7s9rUeEjkbHCJd
 uirgr6EgXm6F34YvO/CuUwr+Cmm13zswMG2Iyhf9tB2QHpBKwIvlqMQI7FWc9uEJRlwZf0XZgIv
 HGEEGVSjek49p0bfrmIgomHnDJ8S/Q5SIfVaeXi75UYKjfNtbK/ML089iJ5MZlay72++nKymP2w
 tAyAptq5BXdaMNkSwfRLYlIZdcQ2IQMviBP3oFvCMiZ7d3DrYCDr3C4/0KTh45A1ZLNAGjDEHs8
 /D8Y/srSRXRGfdRLWRYwE1P8d/El5MEVkMznwfB2tNPIXY3u+9XfGA==
X-Received: by 2002:a05:6402:454c:b0:6a6:32e3:9ba with SMTP id
 4fb4d7f45d1cf-6aac8f5b0ddmr8176048a12.10.1790606728343; Mon, 28 Sep 2026
 07:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260922060941.534035-1-hs@nabladev.com>
 <20260922060941.534035-3-hs@nabladev.com>
In-Reply-To: <20260922060941.534035-3-hs@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 08:45:13 -0600
X-Gm-Features: AclHuK8IM0I31vpGWFBNYg4npzQf2gx2Scdprc_2UUey-JOVgDjraORhcGdpVZU
Message-ID: <CAFLszThpVVk5ygKDGfGndZKKoBnmx0pUD_k4MBvL0RSw6m-Nrg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] sandbox: spi: let a slave name the driver that
 emulates it
To: hs@nabladev.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Vignesh R <vigneshr@ti.com>, 
 Simon Glass <sjg@chromium.org>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heiko,

On 2026-09-22T06:09:29, Heiko Schocher <hs@nabladev.com> wrote:
> sandbox: spi: let a slave name the driver that emulates it
>
> sandbox_sf_bind_emul() binds the SPI NOR flash emulator for every slave
> on the sandbox SPI bus, whatever that slave is. There is no way to
> emulate a different kind of SPI device, and a test for such a device
> therefore cannot be written.
>
> Take the name of the emulation driver from a "sandbox,emul" property on
> the node of the slave, and fall back to the flash emulator when the
> property is absent, so that every node in the test device tree today
> keeps the emulation it has.
>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>
> drivers/mtd/spi/sandbox.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
> @@ -518,6 +518,27 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
> +static struct driver *sandbox_spi_emul_lookup(ofnode node)
> +{
> +     const char *name;
> +
> +     name = ofnode_read_string(node, "sandbox,emul");
> +     if (!name)
> +             name = "sandbox_sf_emul";
> +
> +     return lists_driver_lookup_name(name);
> +}

The property name sandbox,emul is already in use - see
arch/sandbox/dts/sandbox.dtsi for i2c-eeprom, sandbox-rtc, the PMIC
and the swap-case device, and drivers/i2c/i2c-emul-uclass.c /
drivers/pci/pci-emul-uclass.c on the consumer side. Everywhere else it
is a phandle pointing at an emulation node whose compatible selects
the driver, and dtoc even hard-codes #emul-cells for it in
tools/dtoc/dtb_platdata.py. Reusing the same name for a string that
happens to be a U-Boot driver name will confuse anyone reading a
sandbox DT, and it bakes an implementation detail (the C symbol of the
driver) into the device tree. Please follow the I2C and PCI pattern:
put the emulation in its own node with the appropriate compatible, and
reference it here with sandbox,emul = <&spi_ram_emul>. Then
sandbox_spi_emul_lookup() resolves the phandle, binds the driver named
by its compatible, and there is no new schema to invent.

> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
> @@ -530,9 +551,9 @@ int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
>       drv = lists_driver_lookup_name("sandbox_sf_emul");
>       if (!drv) {
> -             puts("Cannot find sandbox_sf_emul driver\n");
> +             puts("Cannot find SPI emulation driver\n");
>               return -ENOENT;
>       }

Now that the name can come from the DT, the message should say which
driver was not found - otherwise a typo in sandbox,emul gives the
reader nothing to go on. Something like printf("Cannot find SPI
emulation driver '%s'\n", name) would help, which means passing the
resolved name back from the lookup helper.

Regards,
Simon
