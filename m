Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCA5C5DF7E
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:06:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4FE381062;
	Tue, 18 Aug 2026 13:06:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id atB0E9rLPO-e; Tue, 18 Aug 2026 13:06:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3299680FFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787058378;
	bh=r3ttuacTpBmpxLEDxo/j6Raf4G6GgcY8pGJuaKhlXcQ=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xETZhIdR/KwuAju++VGn6/D68K1gitpUca+adb5JT2cukoOrPXybBoCScyxMXNrUr
	 cJy49KokNGADlth4f+MQH/+lDvoTjXnpiymOrOogR40oyjFcG2voGwsi1N21IB2OBu
	 fTKTp0E06WOI2++PcevECPBnGyVd2DfiwxUQKGPvTxweAXm2SviKez7RnvdbqiRW4+
	 WqAiqgB3QYNJ1Ez/lkgHfj/ptE/uQP3/QWlQj32gyYAcVpkGa0JQ5hoiz90yTCmBOr
	 4iQkX1YFlpqm3BuI5sSFlD2Oa0Zh+f94UKFvt33GVxx9hpD+61QoKFPh7VBHArBcQc
	 zBzwq+IBItolw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3299680FFF;
	Tue, 18 Aug 2026 13:06:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 71F672EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 01:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 63DBC400FE
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 01:04:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O32gBmuS-S_Z for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 01:04:44 +0000 (UTC)
X-Greylist: delayed 58002 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 18 Aug 2026 01:04:41 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1AC2E40015
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=linux.spacemit.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1AC2E40015
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com
 header.a=rsa-sha256 header.s=mxsw2412 header.b=FMXW8QoP
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=35.173.142.173;
 helo=smtp-usa2.onexmail.com; envelope-from=troy.mitchell@linux.spacemit.com;
 receiver=<UNKNOWN> 
Received: from smtp-usa2.onexmail.com (smtp-usa2.onexmail.com [35.173.142.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1AC2E40015
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 01:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1787015016;
 bh=r3ttuacTpBmpxLEDxo/j6Raf4G6GgcY8pGJuaKhlXcQ=;
 h=Mime-Version:Date:Message-Id:To:Subject:From;
 b=FMXW8QoPNyGdjDEMFgxcOzlIKZenobtIYeSN1EQlyicmvArGt1kSxaKikNWj8IKXf
 LvwUX5tk7VEfXFMfSlhi7BFJ9gHh+fvlg+t3qASX/1ryLrw1dKQ5TKjTyGLNcdiUcX
 nZurMSp8bn4bBASrQ10v4I5UBPjCFp5HeqR9gpBI=
X-QQ-mid: esmtpsz10t1787015014t01efc13c
X-QQ-Originating-IP: jfJQWVh33GCQ10tvEEWOlIkSztxsXbQlxMgG4Exy1rM=
Received: from = ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 18 Aug 2026 09:03:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 707725886485996054
EX-QQ-RecipientCnt: 11
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=4ff214fd76a40c1c046d515a453c13f5d1bb3e1c5f3e1b39c601aaf95a87;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 18 Aug 2026 09:03:30 +0800
Message-Id: <DKRNYAH9YSW5.X8HMOZQ2VYB2@linux.spacemit.com>
To: "Junhui Liu" <junhui.liu@pigmoral.tech>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
Cc: "Heiko Schocher" <hs@nabladev.com>, <u-boot-spacemit@groups.io>,
 <u-boot@lists.u-boot-project.org>, "Huan Zhou" <pericycle.cc@gmail.com>,
 "Guodong Xu" <guodong.xu@oss.qualcomm.com>, "Tom Rini"
 <trini@konsulko.com>, "Raymond Mao" <raymond.mao@riscstar.com>, "Lukasz
 Majewski" <lukma@denx.de>, "Yixun Lan" <dlan@kernel.org>
Subject: Re: [PATCH v2 1/4] i2c: k1: fix wrong bus speed setting
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <20260815-k1-i2c-fix-v2-1-7d2a48607233@pigmoral.tech>
 <DKR3Q808Z4E0.27KFK7LNAM3K7@linux.spacemit.com>
 <DKRADSUN4GN9.299FCK1VIS6EH@pigmoral.tech>
In-Reply-To: <DKRADSUN4GN9.299FCK1VIS6EH@pigmoral.tech>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M+EtDX7VsKFY9ZJCsSMOgZpzXCx+xynpILTjBNXMzfLtpiqK1DCXU6vk
 j7dKb+pOAdP8itgp04AvFf1xuUyWd91RtPUS4zAZxluFWcFNGb9R5UlYPxom5GE1bXU5zF6
 NF5knCnpk7jRQu4JDjx4TTNJj8fZAImM9CB/Vi33zchfdoeYPjcOkovCFXuMbq0GKLBCn8x
 4Wu4tGzVhsGL3+Rfr3tbGbIav0pCEINTHKXDeE0iKRSzkjfVMu3VjDZd6yn6S0N3pvjgh99
 m2HSRm8F6y3QcTxum7LFbJkWKShvatAnhIHgrG3aJ2yCV27BUOon+a5bBecYFwe3eOyIPY2
 5xpfNcz1HAqK9TANzHJmcAxneSmfg7xv4vtI2Zt4teWpRMcpBNcZDm08NctRsB4cwhg1oKS
 LgaohTRy1T+y6JfJKn0j7YwzQzL72TgqpV+vN07P7R16V4JMU5+9KP/e5UfSqD8swa2s4Ao
 zCYy47BaE5iA3nxKbhA13qMdUo4Kh468Rzf+DUAHG+4ep2oeMxL2JYAPLPpKSZakpFyujVh
 gnnCuQCVNKruJsMWTJDbFZuS0DsgsGaTyl9EIAycPmQ7PoSNhwKY/o4SJBVsfLZ8UuZeelZ
 79IncdOL1o5dK2qK/Nofh6t8aBjbEWbZqLuAiv6uoxNQEPEWCtMz+3pznOcDV+BOVE051rU
 NUAzvgo4rqlh8h7F+bWVoYxWn4a8Dvp1AKFDtJ1h2eKJD+GN0OMsASd6TRMlt843GpVo2qv
 FPFdIiV1Qi5ZpVsDuQhHJbRJ/xYbVlFnUAG71MrQggwEHJoQrjPrAxusslyYWYQopORTxxE
 8n0UyZpS78QDfFL3eUQ1+GGwQN8hHuB+RJ/ieA6zhKdVgO6dXydI8rAq6Ls2YIL6fHVhoAq
 9W9h03IRX43+djn+VrperszrTLNB6SarTGkThU7HVvwF4R+Tiz99zo6YpzjXAG0cg/y1Brh
 94fF+FXJy2gV1g3QnyXmzEb9uJbP/jAEyKF3GGzUg0c6dg0iaBr0XZmef+mUnriL1UHTUFh
 HEuGd77Que0E9xw+C1UAQ5PwWxZjIwtA9DJkkNTJLmczJ2NHKd2Q3oZokA06deWC6wJ9Yyq
 k/Y0s6uCPoN
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:06:17 +0000
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

--4ff214fd76a40c1c046d515a453c13f5d1bb3e1c5f3e1b39c601aaf95a87
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Aug 17, 2026 at 10:25 PM +08, Junhui Liu wrote:
> Hi Troy,
> Thanks for the review.
>
> On Mon Aug 17, 2026 at 5:12 PM CST, Troy Mitchell wrote:
>>> The controller bus mode should be selected according to the requested
>>> I2C bus speed. However, the driver currently passes the functional cloc=
k
>>> rate to k1_i2c_set_bus_speed(), so the selected mode does not reflect
>>> the requested bus speed.
>>>
>>> Fix this by reading the clock-frequency property from the Device Tree,
>>> defaulting to standard speed, and drop the unused clk_rate field.
>>
>> `clock-frequency` is the requested SCL rate, but this patch only changes=
 the
>> value passed to `k1_i2c_set_bus_speed()`.
>>
>>> @@ -496,10 +496,13 @@ static int k1_i2c_probe(struct udevice *bus)
>>>  		debug("%s: failed to enable clock\n", __func__);
>>>  		return ret;
>>>  	}
>>> -	priv->clk_rate =3D clk_get_rate(&priv->clk);
>>>
>>>  	priv->base =3D (void *)devfdt_get_addr_ptr(bus);
>>> -	k1_i2c_set_bus_speed(bus, priv->clk_rate);
>>> +
>>> +	speed =3D dev_read_u32_default(bus, "clock-frequency",
>>> +				     I2C_SPEED_STANDARD_RATE);
>>> +	k1_i2c_set_bus_speed(bus, speed);
>>
>> `k1_i2c_set_bus_speed()` only changes `ICR_MODE_MASK`. It does not progr=
am
>> the ILCR divider or initialize IWCR, so the actual SCL rate still depend=
s on
>> the register reset values and may not match the Device Tree.
>
> Yes. This patch only aims to fix the ICR_MODE selection. On the K1 board
> I tested, the register reset defaults are enough for both the PMIC and
> the EEPROM to work under U-Boot.
>
>>
>> Please calculate and program ILCR from the functional clock rate and the
>> requested SCL rate, initialize IWCR as required by the hardware, and rej=
ect
>> unsupported rates. The functional clock handle or rate therefore needs t=
o
>> remain available to `k1_i2c_set_bus_speed()`.
>
> That's a fair point. The current driver is aligned with the mainline
> Linux K1 I2C driver. It does not include your later work to program
> ILCR/IWCR:
> https://lore.kernel.org/linux-riscv/20260508-k1-i2c-ilcr-v7-1-8c2dde5c3ed=
5@linux.spacemit.com/
>
> Porting that change to U-Boot is not a small amount of work. I'd prefer
> to keep that as a follow-up series rather than mix it into this ICR_MODE
> fix.
Then:

Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>


--=20
Troy Mitchell


--4ff214fd76a40c1c046d515a453c13f5d1bb3e1c5f3e1b39c601aaf95a87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCaoOvYg0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQv87gA/A51KAdE3vq0CZ0539Ozqu8DfYt9qes5ZNafYkmZ
47OjAP9yfm3mYJsUODYmGJU/wSljPpgyTTt2dP9NeDWz0Rl2Ag==
=Y2s7
-----END PGP SIGNATURE-----

--4ff214fd76a40c1c046d515a453c13f5d1bb3e1c5f3e1b39c601aaf95a87--
