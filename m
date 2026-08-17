Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDFEC5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F63E607B0;
	Mon, 17 Aug 2026 13:34:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VuXst4vsMACq; Mon, 17 Aug 2026 13:34:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 692D060828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973662;
	bh=rePHr6hWWeXKd+ib15BOL2MnV7d8bd0oUpxNPJxiDxc=;
	h=Date:Cc:Subject:From:To:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AlhXK5KrECMzXTYxobmlYze23fOs8YUFi9WfYEjyOZtEGpN7+dmukIHbo3tAxCsKW
	 n6g5b95ih86zN/eI0eP+JhQCBpoi0myzST2/d4AWEOGdrlyiZaEKO8T4m3sVP9udYM
	 TADpIZnLjRsYWDs0jmGwPEMHIe9j4gDia/vJhk0Qz4cAAZzQaoBPYCQQUWgeFbJ2dV
	 LJ1Y4Rny7GcLnN3zJ3oEDJAZK91YwnY54rKTM+bLdRtd/dBlm4UVdjIMALUxgSkhMK
	 acZBB0umkOriZb7GVrU5vkcUsUUfDTzRogo0aAj63fGNCORSVw+Kx+4UrUzLek8TcX
	 uU1xONJQSQ/TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 692D060828;
	Mon, 17 Aug 2026 13:34:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2E03147
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A21374016B
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:13:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wiLe-blue0ZF for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 09:13:48 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=43.155.80.173;
 helo=bg5.exmail.qq.com; envelope-from=troy.mitchell@linux.spacemit.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D4F3640087
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=linux.spacemit.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4F3640087
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com
 header.a=rsa-sha256 header.s=mxsw2412 header.b=Dqn/xucc
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4F3640087
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1786957962;
 bh=rePHr6hWWeXKd+ib15BOL2MnV7d8bd0oUpxNPJxiDxc=;
 h=Mime-Version:Date:Message-Id:Subject:From:To;
 b=Dqn/xuccvWejuCXPOhluQu7BSZuyTfw7QK2jRyipFdk65KdIsK1u+4enW4cwBjvNR
 HJJ+GTYfYadAym4S8qZnu42gYoQ+kdYlkcvnXXIw2Pvv9bvZ+eLa+1ocC0PBt+A8ql
 eNbODtj5vz0S0IBO95W0YWP4/XnfGF/wl32fy0yU=
X-QQ-mid: esmtpgz14t1786957960td5f4f900
X-QQ-Originating-IP: huaEffoEZcCq4v20jfKJOC52+EAypm8AvHBXvlIHKNM=
Received: from = ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 17 Aug 2026 17:12:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11502246777460626454
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ade7df15626e4122d3a30d7caf22f3337a66623ab09c572313c074322f7d;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 17 Aug 2026 17:12:35 +0800
Message-Id: <DKR3Q808Z4E0.27KFK7LNAM3K7@linux.spacemit.com>
Cc: "Heiko Schocher" <hs@nabladev.com>, <u-boot-spacemit@groups.io>,
 <u-boot@lists.u-boot-project.org>, "Huan Zhou" <pericycle.cc@gmail.com>,
 "Guodong Xu" <guodong.xu@oss.qualcomm.com>, "Tom Rini"
 <trini@konsulko.com>, "Raymond Mao" <raymond.mao@riscstar.com>, "Lukasz
 Majewski" <lukma@denx.de>, "Yixun Lan" <dlan@kernel.org>
Subject: Re: [PATCH v2 1/4] i2c: k1: fix wrong bus speed setting
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Junhui Liu" <junhui.liu@pigmoral.tech>
In-Reply-To: <20260815-k1-i2c-fix-v2-1-7d2a48607233@pigmoral.tech>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <20260815-k1-i2c-fix-v2-1-7d2a48607233@pigmoral.tech>
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NHTDxyKr+cuO/OiOMtXYp4ShDDhD0o9pYFm4eQYo0QP9M//JxU8IlmzZ
 povL5cwwXbVLc7qlb0+IuaIXyflFw1vWWxVjlcWMAea33iKPPY3d3VuC8X8nRT/swsRtb2O
 yExuqmPWTr7S//5bZZF7WWxxBiQWnHkb86sZT8vCyXoYrIIJgPtE5ZWHq/ahROTklaGL39V
 S1S2W/7LsPhdbR3Z0KW6zqo3jqiDTtHLnGa7oVkSzowtZFaQCNgMr/RY374XoIZjn0d0Vqa
 +i02sY8cZTXHTutbW4vpEc9+umMZ5RgXBAdLuabzcmcm8rlxAjNgsujYQBtf5Dy0sroeh7p
 rOJ5DTEFUFHoxevyqP6ezPpsgsHDXE/k15JDtFToKuxuNgjOgbGWKvuPqFvOwTT5JdeGgeP
 V4995kvRG65tUSLav++49cRx8pw26/TKkEsaZ3LbEXEk01QWvZMjBpIGbqCg+WyC+s7L2PA
 2qw2uEnnXG1vR5l1tyN4fsBOyFpOIdepKMx9+u3dKgxBRM/BaI475y9s1HVQ16DAv3w2dIH
 EdIR38E6PoqXqf6lGu2BlhLqIn17nYfGo0R/3i434r14kIh7d8OxBAsDyfBriJv+3rq0hTO
 /2O2Qa/Am1w7ZdTDuSphsyviMfSxrVhKDPrHpUnPPecejuVYIw3ZIJk6VJOY1mj1aLqaEKF
 g/rL81bx36uncwft/EmF1cgrXAHf9jiM/1AqCPhMuGUeNoYsXfPSh88ujuttC7P3Sd1t+ZP
 8hE+6m1o6VR1cPieF+3+ni3j2YY1NtNZfftT9HG6DIKRS5zKO/ZWK3rDf80zQlAKH2ez1uV
 Ks2AH0ZtuL6bs2Zo3LNvsvlEWpCEu3TLTo6ANi5PWUeJ0PTpMCGFAMv3WgwPclp15RKWngc
 iiUPqOuD5xdVp7Np9AUgseaf3ru3vOzen5dzabNVn4GJB5vZ+7UW+aJk1SQdNbqtohQ0zvq
 BjL8lcnIEeMwUpLaJr57aWagjISZtgqxKoPjgtDm2I+1ONCgmwoSLwYkW6tuYcVgKTRZPIF
 yGd2UArRzmkqokfRLI3tocSGsh23DsQMdrJdZBZ9oJAOu7BdgwZd/f01B+9mWoPSa45xFU8
 m71DvnH8b2S
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

--ade7df15626e4122d3a30d7caf22f3337a66623ab09c572313c074322f7d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

> The controller bus mode should be selected according to the requested
> I2C bus speed. However, the driver currently passes the functional clock
> rate to k1_i2c_set_bus_speed(), so the selected mode does not reflect
> the requested bus speed.
>
> Fix this by reading the clock-frequency property from the Device Tree,
> defaulting to standard speed, and drop the unused clk_rate field.

`clock-frequency` is the requested SCL rate, but this patch only changes th=
e
value passed to `k1_i2c_set_bus_speed()`.

> @@ -496,10 +496,13 @@ static int k1_i2c_probe(struct udevice *bus)
>  		debug("%s: failed to enable clock\n", __func__);
>  		return ret;
>  	}
> -	priv->clk_rate =3D clk_get_rate(&priv->clk);
>
>  	priv->base =3D (void *)devfdt_get_addr_ptr(bus);
> -	k1_i2c_set_bus_speed(bus, priv->clk_rate);
> +
> +	speed =3D dev_read_u32_default(bus, "clock-frequency",
> +				     I2C_SPEED_STANDARD_RATE);
> +	k1_i2c_set_bus_speed(bus, speed);

`k1_i2c_set_bus_speed()` only changes `ICR_MODE_MASK`. It does not program
the ILCR divider or initialize IWCR, so the actual SCL rate still depends o=
n
the register reset values and may not match the Device Tree.

Please calculate and program ILCR from the functional clock rate and the
requested SCL rate, initialize IWCR as required by the hardware, and reject
unsupported rates. The functional clock handle or rate therefore needs to
remain available to `k1_i2c_set_bus_speed()`.

                                            - Troy

--ade7df15626e4122d3a30d7caf22f3337a66623ab09c572313c074322f7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCaoLQgw0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQvixQA/A3hj4lows2eyiVz53LXVkiaEyx6mr4XpYZMY0Rx
BeGEAQCB/DkZybfQQ/SgC30KkdDX1CPADpV6breky1Cok1AbDg==
=ezAM
-----END PGP SIGNATURE-----

--ade7df15626e4122d3a30d7caf22f3337a66623ab09c572313c074322f7d--
