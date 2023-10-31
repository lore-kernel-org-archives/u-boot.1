Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842B3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 22:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2093E84003;
	Tue, 31 Oct 2023 23:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="VW0A1ZIx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E602B87641; Tue, 31 Oct 2023 23:54:00 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 192D281EC8
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 23:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231031225350epoutp03667d5666f32d4b9a18bdfce988792722~TUxQl7FM40478704787epoutp03F
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 22:53:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231031225350epoutp03667d5666f32d4b9a18bdfce988792722~TUxQl7FM40478704787epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698792830;
 bh=qGKECjVMIJoQr2bNvdEiK+L6zuyWQyE2r/iU3I5X2nk=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=VW0A1ZIxVoWKCvjqgAWoiErCh4DW2sgO5TdfdobzVusUtu+sMrKGPquuSevxh3aYB
 pCUKLVLutpPEX9D145m/EIvcYPNMrNf3XuP2AzPOJLZrQbtj3/yN3J6+cxT9Nx47Bg
 La+wKTkK0SD+K1/qBInDq7gUYoj6ZTv1aW6D2gig=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20231031225349epcas1p4c4a9f7cc25c77e8c763b04b2c37fb2c6~TUxPwtoBO1088610886epcas1p4v;
 Tue, 31 Oct 2023 22:53:49 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.136]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SKlmr4GpQz4x9Px; Tue, 31 Oct
 2023 22:53:48 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 35.00.10211.C7581456; Wed,  1 Nov 2023 07:53:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20231031225348epcas1p44c8eedeafc58dc6a690361b95297645c~TUxOjRifr1089210892epcas1p4e;
 Tue, 31 Oct 2023 22:53:48 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031225348epsmtrp11520768badd8dea52e079ab9ecaf707f~TUxOiqoy01361213612epsmtrp1j;
 Tue, 31 Oct 2023 22:53:48 +0000 (GMT)
X-AuditID: b6c32a38-463ff700000027e3-0f-6541857c768e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B6.35.08817.C7581456; Wed,  1 Nov 2023 07:53:48 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231031225347epsmtip20bb791e72eb5ab3e06e4497ad6002113~TUxOTjXsp0135601356epsmtip2H;
 Tue, 31 Oct 2023 22:53:47 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Tom Rini'" <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>, <ycliang@andestech.com>,
 <yanhong.wang@starfivetech.com>, <minda.chen@starfivetech.com>,
 <xingyu.wu@starfivetech.com>
In-Reply-To: <20231031130101.GI496310@bill-the-cat>
Subject: RE: [PATCH 1/2] riscv: dts: jh7110: Add a gpio-restart node
Date: Wed, 1 Nov 2023 07:53:47 +0900
Message-ID: <013a01da0c4d$1bd41570$537c4050$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKY/cAEqQywfKosz9ewW2vzrAmuLAEVzT+mAkfzUyGuy671YA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTV7em1THVYM4iGYtJywMtpk7azG7x
 dm8nu8XCGWeZLH50PWK0eHzoNZMDm8ee07OYPV4dWMXucfbODkaP22d5A1iism0yUhNTUosU
 UvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgHYrKZQl5pQChQISi4uV
 9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Izps48zF7QKVbR
 +raygfGsYBcjB4eEgInEjfuuXYxcHEICOxgl5nxrYIVwPjFKLPtyjQ3C+cYo8b15HksXIydY
 x55pU6Gq9jJKfN3QAlX1klHiy4aXjCBVbAJ6Ev8XLWQGsUUEVCV2fZzMDlLELDCVUeLg9OOs
 IMs5BYwlflwyAKkRFnCROHfpAyNImEVAReLEQjuQMK+ApcSjCY/ZIWxBiZMzn4AdwSwgL7H9
 7RxmiIMUJH4+XcYKscpJonPibWaIGhGJ2Z1tzCBrJQQ6OSS+n/rIBNHgIvFk6heob4QlXh3f
 wg5hS0m87G9jh2hoZpRYuuQgK4TTwyjxr+E6G0SVscT+pZOZQC5lFtCUWL9LHyKsKLHz91xG
 iM18Eu++9rBCAphXoqNNCKJEReLS65dMMLvuPvnPOoFRaRaS32Yh+W0Wkh9mISxbwMiyilEs
 taA4Nz212LDABB7Zyfm5mxjByVLLYgfj3Lcf9A4xMnEwHmKU4GBWEuE9bOqQKsSbklhZlVqU
 H19UmpNafIjRFBjYE5mlRJPzgek6ryTe0MTSwMTMyNjEwtDMUEmc99ir3hQhgfTEktTs1NSC
 1CKYPiYOTqkGppKCmpeX3VQnaM4tf7plyrup4g8ef5vqcp5VLUjz6+RSg2S1PceWcPAdsjvL
 89bzsLx5UU/X22uNMpHLcm0yvzBm/lJs2CUr9f9K6bcCPbltIfvi5N1O71ry5PeJHXuEA19L
 XxB5fpFPPdFH32X7+tfFR+xTGPYpzHF6+2DGum2s7++0WXz7Hu5/vc1uka9F/q/zlYXPttdq
 3lvxeVk71+Hjc+pzjrY4rZDdwzixffHW3Vu6fXPc14ezCul/zV3T0vByzqn/XSk/DJ9uW+Kp
 UNDEK9v79LPAzHu2rSa1G4+kpYYtEZD/23/O9w2XzvunPVEnGKoUk3n33dQ5rnS62V/O+/fD
 rbsqGXSMXWrnKyuxFGckGmoxFxUnAgCVXAPQHwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvG5Nq2OqwdW37BaTlgdaTJ20md3i
 7d5OdouFM84yWfzoesRo8fjQayYHNo89p2cxe7w6sIrd4+ydHYwet8/yBrBEcdmkpOZklqUW
 6dslcGVMnXmYvaBTrKL1bWUD41nBLkZODgkBE4k906aydjFycQgJ7GaUWPpqBiNEQkri89Op
 bF2MHEC2sMThw8UgYSGB54wSLzsrQWw2AT2J/4sWMoPYIgKqErs+TmYHmcMsMJNRYlnXJGaI
 oVsZJXruPWQEGcQpYCzx45IBSIOwgIvEuUsfwMIsAioSJxbagYR5BSwlHk14zA5hC0qcnPmE
 BaSEGWhX20awy5gF5CW2v53DDHGlgsTPp8tYIU5wkuiceJsZokZEYnZnG/MERuFZSCbNQpg0
 C8mkWUg6FjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4XLa0djHtWfdA7xMjE
 wXiIUYKDWUmE97CpQ6oQb0piZVVqUX58UWlOavEhRmkOFiVx3m+ve1OEBNITS1KzU1MLUotg
 skwcnFINTM2lEkEi6/3q4jYmab+Vkv6U/+CE5+F3jYtPe/Yr3UpXW+83XUX96Kpo7xchZxl3
 Xzb7rOKvMjvildfOqOiwpuqOJa37rpyvejxdbHW8wu+tKlv+GgsUpmt7FseF2UVd4pVLl24I
 jgya38SpfLXZZtKv5c21GZuywl6zLn+0qUfrN2voMoGNAfo8D7TiQ65wK5x8fzBlo0H0gf4d
 2vP47/umSt9nZykJS7wYWeZhsvqw07V9dTalgfz31TxqtjhZzA3pTMqrjVnvy3uwZOX0o03L
 l7tPjrVfpn1o6YONWw1P5jpafmOyE1l88tHOyGNma6M31RcprTs//3XJS4HG3xXnPqYt8znp
 /V82f1msEktxRqKhFnNRcSIA1E27OQYDAAA=
X-CMS-MailID: 20231031225348epcas1p44c8eedeafc58dc6a690361b95297645c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031082448epcas1p33a8ff166d2e48df3dcd6c0b1f0132efc
References: <CGME20231031082448epcas1p33a8ff166d2e48df3dcd6c0b1f0132efc@epcas1p3.samsung.com>
 <20231031082439.395320-1-jh80.chung@samsung.com>
 <20231031130101.GI496310@bill-the-cat>
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

Hi,

> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Tuesday, October 31, 2023 10:01 PM
> To: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: u-boot@lists.denx.de; ycliang@andestech.com; yanhong.wang@starfivetech.com;
> minda.chen@starfivetech.com; xingyu.wu@starfivetech.com
> Subject: Re: [PATCH 1/2] riscv: dts: jh7110: Add a gpio-restart node
> 
> On Tue, Oct 31, 2023 at 05:24:38PM +0900, Jaehoon Chung wrote:
> 
> > Add gpio-restart node to do reset.
> >
> > Before applied this patch, System Reset Extension doesn't appear with
> > sbi command.
> >
> > OpenSBI 1.3
> > Machine:
> >   Vendor ID 489
> >   Architecture ID 8000000000000007
> >   Implementation ID 4210427
> > Extensions:
> >   sbi_set_timer
> >   sbi_console_putchar
> > ...[snip]...
> >   IPI Extension
> >   RFENCE Extension
> >   Hart State Management Extension
> >   Performance Monitoring Unit Extension
> >
> > After applied this patch, System Reset Extension is supported from SBI.
> >
> > OpenSBI 1.3
> > Machine:
> >   Vendor ID 489
> >   Architecture ID 8000000000000007
> >   Implementation ID 4210427
> > Extensions:
> >   sbi_set_timer
> >   sbi_console_putchar
> > ...[snip]...
> >   IPI Extension
> >   RFENCE Extension
> >   Hart State Management Extension
> >   System Reset Extension
> >   Performance Monitoring Unit Extension
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > ---
> >  arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/dts/jh7110-starfive-
> visionfive-2.dtsi
> > index e40f57a15080..e94f9fe826a8 100644
> > --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > @@ -34,6 +34,11 @@
> >  		device_type = "memory";
> >  		reg = <0x0 0x40000000 0x2 0x0>;
> >  	};
> > +
> > +	gpio-restart {
> > +		compatible = "gpio-restart";
> > +		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
> > +	};
> >  };
> >
> >  &osc {
> 
> My only concern with this change (and a few other similar things I've
> seen of late) is where is this change with respect to the upstream
> kernel? The goal is the dts files should be able to be dropped in from
> the kernel (except for -u-boot.dtsi), so we don't want to have changed
> get dropped when they're re-synced.

I understood what you said. Its node was applied with first dts files.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/riscv/boot/dts/starfive/jh7110-starfive-vision
five-2.dtsi?id=54baba33392d428a8be4942441a92a9b05cf537e

Then I will wait for re-syncing dt files about visionfive2.

Best Regards,
Jaehoon Chung


> 
> --
> Tom

