Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6327C61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 07:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 001C880BB4;
	Wed, 26 Aug 2026 07:00:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aleXJZN4P36x; Wed, 26 Aug 2026 07:00:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787727630;
	bh=ULVnTka/mAyMyxMIxRdXlphEys9uuChDZoa07qdhWIw=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y+Whs+d55BxK0gyS7+uoIoLbJwOAjc90Wei0T4gTzZyByZyq1g9hv/rnESWyOaBNF
	 r85HwdWc3kUxrifPU/gZpjUL1rUzhN3wvBliZFqlm3BuNQuCxCZxD34sPbeoCfl/xU
	 cvVLUrVpKXikyX4Mv3duzJ31F4KuY6dSqOIknZa2/yC53QfElC7R6uy8bWxN84f+Jy
	 CQ2vzrqt//b8gVZSXa8rpB+YPdXZlTcl1z6TpAjrJUeTIzBJXc8u0VH+nA/YveA4jp
	 Y38o4xGr2OzARUgoaTVp/QOFCUT4FZ++Nz4HPhZDT1S5zDX67R4jLVvCzmqtl9PovN
	 kYNktVSqnx9Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99F4D80B6E;
	Wed, 26 Aug 2026 07:00:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 922A52FD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77EBD40550
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kzud4cebs-4I for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 07:00:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Qcb3IdVq
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9666A404C9
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:00:25 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a17cb94b26so1047117a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787727623; x=1788332423;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ULVnTka/mAyMyxMIxRdXlphEys9uuChDZoa07qdhWIw=;
 b=Qcb3IdVqj2TwcETWwENfpwgjdiq7Io4gQqvsxsmJcFwk5NAjvScPNkjp11uFi84VTL
 t/zcEuQn4fE9O2MPOsfqJpMzgl/Qeh7QWupCjF+JLlpBHIipWgMjo9Pq+V2DXeORLdGa
 5um8h1PYEqrWE3VVgDGuDqgwT4nQ8J6AG0F/kfaOsXPpVtzOaN/mgGlxAmGyoDCFKoAp
 MUMUO7aSa72UkEAtTtPgCBuHL7JAzpwOCaJVCl0VoTxpvwzRoXVj7Yy15bdInXYov0vu
 oazhjTjzHKXiVRtXnwB8mKIwDXGy9Us40Bd3rbyLTDhPmplluaplsEiSunPpv0qa3F2b
 DrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787727624; x=1788332424;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ULVnTka/mAyMyxMIxRdXlphEys9uuChDZoa07qdhWIw=;
 b=R9nyNOz6+UuewOUiZKi7OcNKZYvq8qc+7uoP7K73IPdtQwF6b3iw4dpl+YtckpIm70
 tOMGgTSdyx9HV0o+1DRUFfhGFsZ04kPd8e339Mde4iiCSB2iLj77q43OoanriymMd06b
 rOBfuqR/QaGo65BWu9IKrZLwDck5h21RSMqz4VHVh6IEj+GcTGQymMExOVOS5d/GwIim
 KM/ReJsb+xcsWreb9ewn3DnbUvgMJCyDmLhHJO5tPYtAdK77ciIyzkXkZBlsai/XY+bs
 X03cdyr3oG32/O4LjhXe18h7ScXxFDd+wQHkLNM5Dsxz5/Pv9V9gysuOQpF99D0ZNLwA
 7HGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYfDEo0XojSR+tNfTnvlnYrg+s6o/2UlIBZ9qrAPVthO12DgCyuEeiuTTYR5qJGKyqAbH0Ke0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n/IIobF1jd2PkxBMF6iL20rEvgeIbYAndF+BH9ykNH6WAppgYP
 /3WSLPdUM19sFrCHdyZW8EV1OzH8DCNyWV+/8PNXoebAdFc3TB9uKB51Lp30XM/mkg0=
X-Gm-Gg: AR+sD10gZRySMPsI5n5JslpRq+DRZ6w0xV3jAdH6P8II7mZ0uUvZenjghcV4aqiaLsH
 kGHZR3YWjfFJtn1ndrXv6dOBI37qHJeGJhV5GxHnHvMuZyNHZ6/R1cMWYqnQm/gSmirSG7ah6Sn
 3bvEavDRpwJnnACydArcbTmzqdmXf+ouLCL35uY7BfxetOzqlFdj14+pUmX+bU3i/tW5nYQGsrz
 idd6s4PFfjZqDiRn727OuoQcEFNVMQX0s6UvuCuDLZNxHon3bJoUpRnloOjFlQmCuXGA+e6eRx1
 D/0DPaIAH6D4KpGDlnZNq2RamYBH8dpgHhqaL6Mp9d+c/l2Joi7uHnqwpH7n4lKu666arTD2qSA
 YlIpcaUwg6rXbUets9zbiDSSuyhpdHLN9vn5b2kS2H1u3HaW1Zu8ftThzdOeBDkJlrnm9fCJ27V
 4EdSQzVWlhzvTaheO+pZaPwg6a/q2qpWucoHNikISZwfhioqhZs02KzjEWkz6W1mjjUsP5P3ngU
 p4T5PIFye/dz88vvOnDsXg/oVsfLqcxQLiTyDL1UUdtoK2aNg==
X-Received: by 2002:a17:907:1c87:b0:c21:180c:d82d with SMTP id
 a640c23a62f3a-c250c3bfa5dmr535241866b.20.1787727621487; 
 Wed, 26 Aug 2026 00:00:21 -0700 (PDT)
Received: from localhost (host-212-171-227-71.retail.telecomitalia.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88af72sm400480666b.36.2026.08.26.00.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 00:00:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 09:00:19 +0200
Message-Id: <DKYOJUOY5PO8.GSPT5Y9HO6LK@baylibre.com>
To: "David Lechner" <dlechner@baylibre.com>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.u-boot-project.org>
From: "Carlo Caione" <ccaione@baylibre.com>
Subject: Re: [PATCH v4 2/6] configs: mt8188: enable eMMC FIT boot from SPL
Cc: "Julien Masson" <jmasson@baylibre.com>, "Quentin Schulz"
 <u-boot@0leil.net>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>, "Ryder
 Lee" <ryder.lee@mediatek.com>, "Weijie Gao" <weijie.gao@mediatek.com>,
 "Chunfeng Yun" <chunfeng.yun@mediatek.com>, "Igor Belwon"
 <igor.belwon@mentallysanemainliners.org>, "Julien Stephan"
 <jstephan@baylibre.com>, "Macpaul Lin" <Macpaul.Lin@mediatek.com>, "Tom
 Rini" <trini@konsulko.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Vitor Sato Eschholz"
 <vsatoes@baylibre.com>, "Johan Jonker" <jbx6244@gmail.com>, "Bastien
 Curutchet" <bastien.curutchet@bootlin.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Alexey Charkov" <alchark@gmail.com>, "Suhrid
 Subramaniam" <Suhrid.Subramaniam@mediatek.com>, "Arnaud Ferraris"
 <arnaud.ferraris@collabora.com>, =?utf-8?b?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>
X-Mailer: aerc 0.22.0
References: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
 <20260814-ccaione-upstream-mt8390-spl-v4-2-f4f92978a79e@baylibre.com>
 <2f402d43-d5f1-44bb-831c-5fdc71e12da9@baylibre.com>
In-Reply-To: <2f402d43-d5f1-44bb-831c-5fdc71e12da9@baylibre.com>
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

On Tue Aug 25, 2026 at 10:01 PM CEST, David Lechner wrote:
> On 8/14/26 9:47 AM, Carlo Caione wrote:
>> Enable the Genio 510 and Genio 700 SPL path entered by the external DDR
>> loader at 0x40000000. Bind the raw SPL to the loader's 0xaf000-byte copy
>> window, place BSS separately in DRAM, and retain the non-overlapping SPL
>> malloc region.
>>=20
>> Use generic SPL MMC, GPT, FIT, and Arm Trusted Firmware support to load
>> the firmware FIT from eMMC partition 1. Keep U-Boot proper at the shared
>> MT8188 CONFIG_TEXT_BASE of 0x4c000000.
>>=20
>> The MediaTek BL31 used on these boards stalls when passed the runtime
>> devicetree as its platform parameter. Enable SPL_ATF_NO_PLATFORM_PARAM
>> so SPL can still use the tree to locate OP-TEE and U-Boot while passing
>> NULL as the separate BL31 platform parameter.
>
> If we do another revision, it could be nice to explain where some more of
> these parameters come from. For example, 0x400bb800 seem quite specific
> like there would be a reason for it rather than a nice round number.

I'll fix the commit message in the next version.

--
Carlo Caione

