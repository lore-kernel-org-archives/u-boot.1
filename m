Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B75FC982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 14:09:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C60960642;
	Tue, 22 Sep 2026 14:09:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HCD6A5n4IWNb; Tue, 22 Sep 2026 14:09:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5635060634
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790086198;
	b=G8DwrKIVvQC/IjskfjvJ1pkD/BnlVlQs/YiIYtjBscpkSeQasb13K5ChYfdi/tFVtPpU
	 +xrGVf8BAr6s+wPctYKkVCBf3RR3IeNnohn2QXTNvsEvZb+IaIg1AgZpxan9BKqnH/ZvG
	 EHfdrCjDDmCuE4XivS5HTnwjHB6mhGA+jCUJL7BlOZ5MFfK2kAvX44Hi6rMwDTOiPNMP5
	 uvteEvls/fz0MZ9oxLtdLBS9kANOyyYllD+I9glR+yfGo1aa7aEt03onCmNSzKrIWEAKq
	 NofePIG3phHU+OC/KabfrwVGN78GrQbEOXAN1lFvg9clCfCz1yWcBws6prE4NjUF0mQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790086198;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=E6VPsO7EBJJC7jZNbHK/5luCTkw+v7F9rk+jCOVGbr0=;
	b=qehYoVnt8wW+Wlr3TGtpmtyns31FFICkyKVb9+sOK7uxsZkC1LnhwdeYReIzlyJj8Rf3
	 yma7/amDLNA8sotnypPvnYpe17PRycyWY5hAQtZSk83cuUviF9TsxBrdqF1qozRmhao6z
	 kZ7KS7IqZYt3Y2Q8a6GBfewmaM8TJh5JWf6slR6Lm2+8OC88yfk3ekqp2/hX+9mtksNqE
	 qHJHu4KMYH85cUELsyqwjvk+HbY/0eQEsU6YDU/xEQtv+cREvHMlELRpKUpvOUk3ksb+2
	 r9Ks5VgBYOyS8VBvmqV+IrKzc7NKVO5znrZkANTHbqa5CkCkGBYrkXkPeCR5DbEGxxQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790086198;
	bh=E6VPsO7EBJJC7jZNbHK/5luCTkw+v7F9rk+jCOVGbr0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QLfP7CZu3CrVSyiwuY6lVbHrhGWELpaeCNlphcJ1NySw2wJ5Y0EBEE+tklXC7WOvO
	 r5LiSR+yi7Vmtk4VZpydSNF4wF/5kVRuPH9nnv5h+gPAIRWI7TSseK0pTdLgSPkl/U
	 XOF9XA44DtgVGH5uqv35diLvvxGFEdJoGDo9vAKx+BtdvzmjysmV9rG7UxEHMSf2YC
	 I/T0aqUezoRRrCNHN9+IrvtJkr16i1pTlKHyVntAcUvKjUWaNxynzkZInvzctZiHaU
	 49s6rryCqQ9OPEL00h5R9MPI3XUXDjIwXwzF1ZzcRPwaE4M2BZg9f3HaSPoZ3G0zI9
	 WC4v6ojuCEE9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5635060634;
	Tue, 22 Sep 2026 14:09:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2810AD1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:09:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24EBB406E0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:09:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4OhQUM5y7_Oa for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 14:09:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F19C3406CB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:36::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790086196;
 b=lOlKJEr6NXTa8qrgslwovCEWUI600Cj1qzr8Ytrt/dZsxjIon/NWhpzFW57GJ92UmzLw
 L7v6gcjCeYVF2wBSZOoeCjnO4MFhHhqYO5lj5XcgiCHhBLKrzxGOPrSAIpiFqWvH99BX2
 sbbgETmQBOOA5FkHXIW82FPVlu1TZrTAMqTSfJqUr1K+IowLh7ORuk1DahkGhhahFLN2q
 VtCTDXplfm7fnZ0DbqN+3B48vjQRFVp1PpHw1yq0hk3hFMC1Fa8ZM71WBfGN+eaQKR7GM
 +nfL4HTYd+PpELtiXSUQ92AJBcHizSAesjcwjwuOuuYuOY8rE3zK3PVjEfAc8WcDWVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790086196;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=E6VPsO7EBJJC7jZNbHK/5luCTkw+v7F9rk+jCOVGbr0=;
 b=cnQLAohsChBerMUcAuJfC7OOBMaHUK1KGHYbP+S2K7mckEEyiRFkF3kJzoMI56FfOSfa
 4JyKsD3VmZCMIiZcta0DpgoEse8U0m3xxopPWl9r3AfYBr/dUfTKgQw4ul4EChR6pDSX1
 f21NUSOcDLn2afPW3kI+i2ZztWjEHly0qI/N3fu9tjDU6T7ugDYsG9Wp+xLTiwTtkX0LM
 fDOWRYV9ccuJN7QCNHm672daxYOLmMb253ZFnp6oUW3Ip20a3psxEVFAgI6ajvDD3BVQi
 ePvv4y587JeOeqCQB67+Q7ho77SV2nQUvsbLOaXM+QklIoiBxnTqv0vOWaBlqXTaxMA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BcAnP+TS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:36::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::10; helo=mail-lf2-x10.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BcAnP+TS
Received: from mail-lf2-x10.google.com (mail-lf2-x10.google.com
 [IPv6:2a00:1450:4864:36::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F19C3406CB
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:09:55 +0000 (UTC)
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b79784a6edso3947617e87.1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 07:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790086193; cv=none;
 d=google.com; s=arc-20260327;
 b=q4MPJhU8/M78cg47NLyM7QOHPBHlmeq2gHjSXGzUobSdILDK5Dz8jmXjnn09zl+gMG
 DnASEg/aIZ9Gk048+hYjhK6/nURaJpDN2CAbcPtehFClrJnAb3JKEywSaj+UUO578dxV
 9kcJXYhMig9tsZJC9hiM1P3/gbm8GEit7VtE6kSnKBRG2YQZKy9mDTqml3pB/FqRYu7R
 4y2xd68rfpOHmOeuwsZ1MFW4PevYMIwVpP5qkDPZvhNlpzwnk9BlK5nhIkzL6I8oSeo/
 d/k2sjOJ3+B9Ews+6hDp5qpN4u0OzzKGeR4El3Gk7OjJlrxRi4ycefQWVXyleMmgI65S
 hGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E6VPsO7EBJJC7jZNbHK/5luCTkw+v7F9rk+jCOVGbr0=;
 fh=gs6fktCGuS8NcwlEHMIl7Q4aAmjb61jVduf08zakXNg=;
 b=cUgxbx33drOOins/I5zkf7JhD/hefOXujpeUM65APorGjtaRqNchh/eINY6j+G4Zr5
 AX8TRs4ChZTp2XPCklUh5kJPqUhFMXmg2CupLF4AAPjdF0HQqzjbVMc0sKYH0mnn56co
 XC1ssT2We0+mlslkWRoVy3JMvdXHL9uGCZgiQzDOA8Z5YKuTYkZ6FL1JWU3N7chN0E0/
 xQU4YxwHot+o7W/GKDDGpdND7IUDuR9mWAbQ0OcWcCMyD7ndPLCabc2908kiFi58qIIz
 +TNDF8/mtaRe11Hy9HCZmHyCbX12eheKGEmOGsI3VryZ4K8y0BRdzH/V2SbERZjLXss0
 2stQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790086193; x=1790690993;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E6VPsO7EBJJC7jZNbHK/5luCTkw+v7F9rk+jCOVGbr0=;
 b=BcAnP+TSwuEjYSU3H4Otlr0+Y+fqsfmtcqWwRMhA99k1sAgUvY+MNTLk+5hMI9BOuC
 yoTh26Annr/gmi4prsibTHAZGv2AHWe6AoyLBs/FEQzJIzdad39/CZPg/II+CwJN/4c5
 Qjhp2pQXvcppjiibyL7E/JNXQCueB3P7kOFr38BEUBUZ1XaUnHwzwthJkkXrk/gCmA5N
 DPYhRBg9tEh5VSmYsfUJ3lnP0wAR6Ay5wlkAQcRMcVv9a2KQxoIqxFTPB1+TXZTjFRMp
 0K4wByWZc4wRdCkLSnGKatg6Q0c2mxv6e3Wp3j00Z1m/yUNqADDz6d6GIAApAgMSxv/n
 o2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790086193; x=1790690993;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E6VPsO7EBJJC7jZNbHK/5luCTkw+v7F9rk+jCOVGbr0=;
 b=MFfv0EUjQSUbHVqhmRZJen7DT1VV3/YmlypkkYFMuUUlu9IvRYF0Q2CZkpi4eYzsC8
 N6HyaE8lLv/lgQ1KEUW9rfq462iIehrE9f+S8kCPF7DL40gs06fIKOwDok2zYAnxM/I3
 v5+yShr4L62ghAu9stAr43MtJIWeWU5OblSgJ83gZdRNkjYifDGbBT8y3y8+IOTQT6GN
 +XOcH0l0NWHDozm51Fk8HFM0OOtQWA4at2DLK2E+TNEXuWcxV/XGek61ZU5e9CB3vNZ1
 SuVqwMZvwmnD0p7aG7XZNEITWe1g1e9/Kza1KR+F/oWkkc+psh6ftpXJJDv0CoQn69zu
 DJdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTJ2xna04ojC9waBg+ZVtdnIc+3dzAOeg1Rpj2TYWa/H6WLm8yvtkssZ0adUFu4lG31aB5dFI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lxdDgwD3tx3m+ZlGr/pgQi+5h9V98tZdgpwloMIXFJci/7Vr9J
 gA53UjDQcl2IHpzf7JUx3GescUZuTrtjJFr37SMfcMkD2lb+Wndg2nL92+8JZwBiERZNv4ua0Wm
 tesGT1/dHO6fkwjqM1FbycHZpKOX4mbRqw5xv
X-Gm-Gg: AYBFou04gyXNFiuNhEQabFMXfHs2Ni8VOh15016LX4hj4MdfzkCpuCOrF61kmEL0tV1
 VOakXWgFUxom/pL5dHVZW843m3aMaLJ2i5UNy2UnabOoPMZ4WqMbKbe/DJdVfraZg9nFSoV+VjI
 s/mKNk6aQoR01WSWvFKVsu9WDYE8pwJpYQT61Gru8Ui6tO41P5xPpVFt3bEarGVJoarKNCfTZMH
 WzBmmljWUN5/QPDh5DEHi+H7G9iOq5DbFuuug8YLEpBv4648RgV5b9QmvJ1yni9Xug87K1p+Fup
 dzxkL/bwlgqZ2Wt54VTElkzlUJ2Ksb4bjT9qyxNPjq2SvxCwnLW6+/gwhnXnZ7s3BQJ4ag+ysEJ
 zWhe1K8pODMsYTURbCsThhyAEiXinwC6WMgDohSn2Kad1
X-Received: by 2002:a05:6512:3a85:b0:5b6:186e:b79d with SMTP id
 2adb3069b0e04-5b8c194df51mr4573432e87.57.1790086191120; Tue, 22 Sep 2026
 07:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260922-imx91qsb-v1-0-8f8b0ae23af4@nxp.com>
 <20260922-imx91qsb-v1-2-8f8b0ae23af4@nxp.com>
In-Reply-To: <20260922-imx91qsb-v1-2-8f8b0ae23af4@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 22 Sep 2026 11:09:39 -0300
X-Gm-Features: AcwNN1U3Btv6X1bVUu9VAxA3XXOxA-wVxhgMlQIEZWh_nd3RVwjB2JmN-1JQcQ8
Message-ID: <CAOMZO5Am5fiBUgoaxaMjpbU5VQ+-Kp2fX1VkE+KDTC+7it4rmg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] board: imx91_qsb: Add i.MX91 9x9 QSB support
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Joy Zou <joy.zou@nxp.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Johan Jonker <jbx6244@gmail.com>, Ye Li <ye.li@nxp.com>,
 Joseph Guo <qijian.guo@nxp.com>, Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Alice,

On Mon, Sep 21, 2026 at 11:57=E2=80=AFPM <alice.guo@oss.nxp.com> wrote:

> +static void board_gpio_init(void)
> +{
> +       struct gpio_desc desc;
> +       int ret;
> +
> +       /* Enable EXT1_PWREN for PCIE_3.3V */
> +       ret =3D dm_gpio_lookup_name("gpio@22_13", &desc);
> +       if (ret)
> +               return;
> +
> +       ret =3D dm_gpio_request(&desc, "EXT1_PWREN");
> +       if (ret)
> +               return;
> +
> +       dm_gpio_set_dir_flags(&desc, GPIOD_IS_OUT);
> +       dm_gpio_set_value(&desc, 1);
> +
> +       /* Deassert SD3_nRST */
> +       ret =3D dm_gpio_lookup_name("gpio@22_12", &desc);
> +       if (ret)
> +               return;
> +
> +       ret =3D dm_gpio_request(&desc, "SD3_nRST");
> +       if (ret)
> +               return;
> +
> +       dm_gpio_set_dir_flags(&desc, GPIOD_IS_OUT);
> +       dm_gpio_set_value(&desc, 1);
> +}

Can't all these GPIO settings in C code be avoided here? You could
describe the GPIO hog in DTS instead.

> +       if (is_voltage_mode(VOLT_LOW_DRIVE)) {
> +               buck_val =3D 0x10; /* 0.8v for Low drive mode */

Please define 0x10 so you don't need to explain it in a comment.

Also, the unit for Volt is V, not v. Please check globally.

> +               printf("PMIC: Low Drive Voltage Mode\n");
> +       } else if (is_voltage_mode(VOLT_NOMINAL_DRIVE)) {
> +               buck_val =3D 0x14; /* 0.85v for Nominal drive mode */

Ditto.

> +               printf("PMIC: Nominal Voltage Mode\n");
> +       } else {
> +               buck_val =3D 0x18; /* 0.9v for Over drive mode */

Ditto.

> +               printf("PMIC: Over Drive Voltage Mode\n");
> +       }
> +
> +       pmic_reg_write(dev, PF9453_BUCK2OUT, buck_val);
> +
> +       /* set standby voltage to 0.65v */
> +       pmic_reg_write(dev, PF9453_BUCK2OUT_STBY, 0x4);
> +
> +       /* 1.1v for LPDDR4 */
> +       pmic_reg_write(dev, PF9453_BUCK1OUT, 0x14);
> +
> +       ret =3D pmic_reg_read(dev, PF9453_CONFIG1);
> +       if (ret < 0)
> +               return ret;
> +       /*The timer default is 8sec and too long, so change to 100ms.*/

Add a space after /* and before */. No need to end with a period.

> +imx91_9x9_qsb
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +U-Boot for the NXP i.MX91 Quick Start Board
> +
> +Quick Start
> +-----------
> +
> +- Get and Build the ARM Trusted firmware

s/firmware/Firmware


> +- Get the DDR firmware
> +- Get ahab-container.img
> +- Build U-Boot
> +- Boot
> +
> +Get and Build the ARM Trusted firmware

Get and build the ARM Trusted Firmware

> +Burn the flash.bin to MicroSD card offset 32KB:

at offset

> +
> +.. code-block:: bash
> +
> +   $ dd if=3Dflash.bin of=3D/dev/sd[x] bs=3D1024 seek=3D32 conv=3Dnotrun=
c
> +
> +Boot
> +----
> +
> +Set the Boot switch to SD boot.
> diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
> index b11730e1eac..076f6b48001 100644
> --- a/doc/board/nxp/index.rst
> +++ b/doc/board/nxp/index.rst
> @@ -12,6 +12,7 @@ NXP Semiconductors
>     imx8mq_evk
>     imx8qxp_mek
>     imx8ulp_evk
> +   imx91_9x9_qsb
>     imx91_11x11_evk
>     imx91_11x11_frdm
>     imx93_9x9_qsb
> diff --git a/include/configs/imx91_qsb.h b/include/configs/imx91_qsb.h
> new file mode 100644
> index 00000000000..2175e2d4212
> --- /dev/null
> +++ b/include/configs/imx91_qsb.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef __IMX91_QSB_H
> +#define __IMX91_QSB_H
> +
> +#include <linux/sizes.h>
> +#include <linux/stringify.h>

Is this needed?

> +#include <asm/arch/imx-regs.h>
> +
> +#define CFG_SYS_UBOOT_BASE     \
> +       (QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
> +
> +/* Link Definitions */
> +
> +#define CFG_SYS_INIT_RAM_ADDR        0x80000000
> +#define CFG_SYS_INIT_RAM_SIZE        0x200000
> +
> +#define CFG_SYS_SDRAM_BASE           0x80000000
> +#define PHYS_SDRAM                      0x80000000
> +#define PHYS_SDRAM_SIZE                        0x40000000 /* 1GB DDR */
> +
> +/* Using WDOG for reset */
> +#define WDOG_BASE_ADDR          WDG3_BASE_ADDR

You sent an earlier patch that removed the WDOG_BASE_ADDR definition.
Please do not reintroduce it.
> +
> +#endif
> diff --git a/include/power/pf9453.h b/include/power/pf9453.h
> index f33b839cde0..60c2a9f5e64 100644
> --- a/include/power/pf9453.h
> +++ b/include/power/pf9453.h
> @@ -64,6 +64,8 @@ enum {
>  #define PF9453_LDO2_MASK               0x3f
>  #define PF9453_LDOSNVS_MASK            0x7f
>
> +#define PF9453_RESETKEY_TIMER_MASK     0x1c

This should be a separate patch, as it is unrelated to i.MX91 QSB.
