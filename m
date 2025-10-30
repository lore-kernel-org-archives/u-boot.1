Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D09ACCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 07:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27C2838E7;
	Thu, 30 Oct 2025 08:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QKaLzext";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 260A7838F8; Thu, 30 Oct 2025 08:53:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A6F7838D7
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 08:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761810807; x=1762415607; i=xypron.glpk@gmx.de;
 bh=DbNXy9zpQ5RAhtQtnkfhE9denM+63x99Wtz1LSTqVaU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QKaLzextoWT2ULOy3vs+JQ9YPNtUJx2O2dhcwnkOTT6HH1BylEaq5Z9avdpQOrno
 QNU6AwnPVgLGQrn4TF1pmMb/hruyTuVskn+Z6BMaDkpANCC552AMAmZh61eE9tgbm
 ifPCtB3oZxYhYQhonDl3hL9DoiZdVtxvyxwVHriegkoQety44GrPD/Dh18ZaEncYj
 Gaoh8cKj1jwpURi5Hzn4Y63bsdnqkk58zZDWaMuHifU6IsJSbcU99BpYErL/le3CL
 NRXZlEp7WAaiuHdFLncLLMXUepRXKxokcb1iTCY4OJEIpDEEWLQLeo7kOajdkxHro
 eaEkI1/UX2hcma5wdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.161.182] ([93.94.208.154]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNct-1vuZFB1gfH-00gZMV; Thu, 30
 Oct 2025 08:53:27 +0100
Message-ID: <2f1605c2-c23c-41cf-b9e2-78c29d5475dd@gmx.de>
Date: Thu, 30 Oct 2025 08:53:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] ram: starfive: drop references to 16GB memory size
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
References: <20251030062354.35413-1-e@freeshell.de>
 <20251030062354.35413-2-e@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251030062354.35413-2-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JaQ3cfFvNsuryuAThtfOLW6Qhrp4AphJYY8eey/7/gD6r61ZZW3
 m/0fT6wHG5Cp/v/j4nyc5TkRudbDJhfek0kFQZnxMCa4/DVjLXediB3/iYKSbgAH0QfaMwk
 2SkB8IOQUql+tex9y+Oc+u5QCE2vMAo9gy9uEQZ+bGqOf0PmPU4vgDpkiTLfV3NvXQOUatu
 8C3Qp7tBAipAu75pXXPYg==
UI-OutboundReport: notjunk:1;M01:P0:tkri7PpzZjU=;mMtTNX0kULZSqbncbaZEk8nxmXo
 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
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

On 10/30/25 07:23, E Shattow wrote:
> 16GB memory size is not addressable on StarFive JH-7110 SoC because the
> DRAM uncached alias begins at +8GB offset from start of DRAM. The logic
> for 16GB memory size is a fall-through to the default for an unknown siz=
e.
> Let's drop this unnecessary 16GB memory size and rely on the case defaul=
t.
>=20
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>   drivers/ram/starfive/ddrcsr_boot.c  | 3 ---
>   drivers/ram/starfive/ddrphy_start.c | 1 -
>   drivers/ram/starfive/starfive_ddr.c | 1 -
>   drivers/ram/starfive/starfive_ddr.h | 1 -
>   4 files changed, 6 deletions(-)
>=20
> diff --git a/drivers/ram/starfive/ddrcsr_boot.c b/drivers/ram/starfive/d=
drcsr_boot.c
> index 6764b3ed5cc..ece6f5aae94 100644
> --- a/drivers/ram/starfive/ddrcsr_boot.c
> +++ b/drivers/ram/starfive/ddrcsr_boot.c
> @@ -231,7 +231,6 @@ void ddrcsr_boot(u32 *csrreg, u32 *secreg, u32 *phyr=
eg, enum ddr_size_t size)
>   		mask =3D REG8G;
>   		break;
>  =20
> -	case DDR_SIZE_16G:
>   	default:
>   		return;
>   	};
> @@ -260,7 +259,6 @@ void ddrcsr_boot(u32 *csrreg, u32 *secreg, u32 *phyr=
eg, enum ddr_size_t size)
>   		out_le32(csrreg + REGOFFSET(0x10), 0x3c);
>   		break;
>  =20
> -	case DDR_SIZE_16G:
>   	default:
>   		break;
>   	};
> @@ -286,7 +284,6 @@ void ddrcsr_boot(u32 *csrreg, u32 *secreg, u32 *phyr=
eg, enum ddr_size_t size)
>   		break;
>  =20
>   	case DDR_SIZE_2G:

Why don't we drop the line above? It is just falling through to default.

Best regards

Heinrich

> -	case DDR_SIZE_16G:
>   	default:
>   		break;
>   	};
> diff --git a/drivers/ram/starfive/ddrphy_start.c b/drivers/ram/starfive/=
ddrphy_start.c
> index efe3f8a181a..f26bc9ccaad 100644
> --- a/drivers/ram/starfive/ddrphy_start.c
> +++ b/drivers/ram/starfive/ddrphy_start.c
> @@ -267,7 +267,6 @@ void ddr_phy_start(u32 *phyreg, enum ddr_size_t size=
)
>   		mask =3D REG8G;
>   		break;
>  =20
> -	case DDR_SIZE_16G:
>   	default:
>   		return;
>   	};
> diff --git a/drivers/ram/starfive/starfive_ddr.c b/drivers/ram/starfive/=
starfive_ddr.c
> index b31ed3bcf61..9e902f03ee9 100644
> --- a/drivers/ram/starfive/starfive_ddr.c
> +++ b/drivers/ram/starfive/starfive_ddr.c
> @@ -47,7 +47,6 @@ static int starfive_ddr_setup(struct udevice *dev, str=
uct starfive_ddr_priv *pri
>   		size =3D DDR_SIZE_8G;
>   		break;
>  =20
> -	case 0x400000000:
>   	default:
>   		pr_err("unsupport size %lx\n", priv->info.size);
>   		return -EINVAL;
> diff --git a/drivers/ram/starfive/starfive_ddr.h b/drivers/ram/starfive/=
starfive_ddr.h
> index c29d26b510c..3ab0b0e8fa6 100644
> --- a/drivers/ram/starfive/starfive_ddr.h
> +++ b/drivers/ram/starfive/starfive_ddr.h
> @@ -48,7 +48,6 @@ enum ddr_size_t {
>   	DDR_SIZE_2G,
>   	DDR_SIZE_4G,
>   	DDR_SIZE_8G,
> -	DDR_SIZE_16G,
>   };
>  =20
>   void ddr_phy_train(u32 *phyreg);

