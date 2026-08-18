Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F488C5DF70
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 07:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10814607ED;
	Tue, 18 Aug 2026 07:26:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pykL-x5JNB36; Tue, 18 Aug 2026 07:26:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CC7060611
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787038010;
	bh=R7wKC+A0Qkpgg2SO7LK17H5dHCpagYwpKEtbujyv/iY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZT8pS315G9xraXCtBnbIHukXSKEiydPjqWb4xXmYEO0ec/cs/rtt2MXEEb1GHoU+I
	 00iIXeu4n4o45KhLzbni2m3Ce8n1olcOWmq2v6EA/7Kz5KQc0H/wbhZD8M/T4kRpd7
	 csjE5zHt5XUXOFmMrQbZ9J9ep2mjwmJshqEvbEFnIAJvTBT5EyQpcyLq/YC37/egUw
	 KMKm8FPVq8og4RWBVdswQd+t2qf6hE171N2Rjp2RGYQD4g7H3oaj9WhAtzTME9TfY/
	 bPJ8mJkjVgOPm3kaNCgpd3mPXJrY7vj6u4hkt1QWs6l+wf0C6rMxQFL58QVNUwuy0c
	 5ZklmbVPJHoWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CC7060611;
	Tue, 18 Aug 2026 07:26:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A787C194
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DADE605F1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:26:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s-V0u6zvaGYn for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 07:26:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0B45F60611
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B45F60611
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JAZ+OZ9J
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B45F60611
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:26:46 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so804138866b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 00:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787038004; cv=none;
 d=google.com; s=arc-20260327;
 b=pbA5XQEQk7bw/H2kV3CSmRyU0KN7Z/pcO35zLlgbHeobwsZgq8PJyQFbuip4B9E/Vy
 HplwNbgULBC8ZVk7nRsXwAqk5fkY877rxpfJKQMfPTiug2/Kw1ZZkRtpLUdocqKMnB5N
 +6lF6NmEkX/Wx/HYP5BZX2v12xKcFiiulXE7rgwGmaShAw8wpaqDNo2cvKFM/PKQHoM1
 yapVHjmRuoc7dGR4K7zUlZToVT4OQXXJfLZcKlB4DSNfhyrmcGquTdrPHGVyRSsgQXop
 s2mBbnQRe2FA3LRf9oXURuIZ37CU6uOR2GFOpWOGtGbk4gpOVNxpof5ErfdZXmFWIHw3
 DZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=R7wKC+A0Qkpgg2SO7LK17H5dHCpagYwpKEtbujyv/iY=;
 fh=gWirqQ9SS38nCq8JBivrZh/rSfNt3ewGTOhkGDL6hbA=;
 b=DXw4QexnJO2fFimPGofe0czgxquL1nf9dZhSFMIMDmO/Pb+Y53OH3uDZOtmtQ1pQdM
 AWcrKI75j4Bxd+oQK8PnqNV9TRT4GWrgHzQOoAJOEavr5QWA0Rubyb6Us5c5AyMhztB8
 BlxX1HNl4d7YgAOxgewdk/OwO8xqEFeYN4+Tlsl98Qzz3Tu/DZuAv316y8eehl2k20SU
 dyDiZKnNBtIJI+JAHDtJYsKmj01TZMDn/bDWRfRvPhcEQrBLj/5E/M2cAEqkFNPjGJue
 QJIjCPgbErM/psEbwKt2Y5N/SxYXyrQQyrRbFDgqSCXTAItllau0kwTGRSTEWfIRNTeq
 Yxbg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787038004; x=1787642804;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R7wKC+A0Qkpgg2SO7LK17H5dHCpagYwpKEtbujyv/iY=;
 b=JAZ+OZ9Jk9bDSiy4sKhR6dIO5P2w3G7u1EHKVjh87L4lg1P8qgZsNdGrlgNmmxQjwd
 mOoaWU4I56Ok9C9GtkwJHriVj4irveIW/na68J0NRNeVerzPfp305DYQrS4gjrm0HulX
 D9/T9ftlgWkhxK2PFouLpFnjMmmAYWoKfrzwT8kVZY/G/w465DEtoy/I+O/2L0AyyqUX
 +vMfexGxwXGgE+MVpYcd/runz7+AjN1+yIRMYOj1XnUaNemNzCHmE3gePBjT5EDwHLwr
 sp8dYxHsiATWOrKtQZ8edFeNQ+AsAcAFQ9yJVCcF+GeSk2J5naEr/s0AYzDBeWyn6SgT
 pj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787038004; x=1787642804;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R7wKC+A0Qkpgg2SO7LK17H5dHCpagYwpKEtbujyv/iY=;
 b=o/E87Wt6H62lnkXNHzC3sUaFWfqVaIQeRIVmrU+Oloex5flYrjcovzlca+VZn19waB
 HrHmrD8uI+Cy+GTNe/to5yY0cFMiZGi0ACOJTw2CjMLPetkoP2rmIgjARykiqYcWshcU
 7INmJJkkmTwmBfvyqyS4h4LiTLjCPMAR+GtRFDV47/JHAjpTcN2kxCru/pErCsG4OxmA
 WsGjJWpwjDLS21uhJU64D3LK8H+BymMVkW+RiJqTe+WnEmKQiub/VUP/Gb6SWVq/Jjv2
 viBd+0lPXnnnYrG4WKzGJSW9d8JxvDJvcVRVI4N0cFnbD9Cy2kGvfTfmOBRC4z3bFdwT
 CSbA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpazkq5Br9iGmRXlKDOpkF1S2QZ9xglGvO8DxVp+Bu4xgWhV7/mm8LOsnngFsRhW8PB5LMx2Q4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwBY820WvmjAaBG7BYi9bJIq5i/ICOV9hWfLPXCOjH8SQlp8pbV
 JuBTint98kUL/UmxlHPqIz+EOkjWu0pb4aE6cfE8MSXNdoXKJPvcM8R5EEPCMTKXHC5pnKKZBmz
 R/0UnLYmL59zK8PyamkmOkS5YF+Gvwry4UmJz6cHO8w==
X-Gm-Gg: AR+sD12TlscsuX23SR/QiCbJWn0LrXKZPpY/qziANq1fkW6/Ab7CDiCc7ndcNG04mf6
 IcQg79PSkXycpbEGVpB4Poyhy84unamjHe7E4rP5VKiomoP6SlIKH6QgZ0FNzpLUzvisqKl+snz
 +tWZ2vfAZCqoKbgehoRNn7k6lz1d1HPLbbiASJ7GEYJFv47igY9eemwxQlIHFpJOXy4MBWQq0MH
 MSSwJE/gJ/k47a89n+qCF9hgL3AhU3w4tng6KVAqtwB93eMn0+SSFi/1qI4veFM65GUwOJ8RNzv
 9vt6ejHIeQ9Xt43DE1rMq+4wDBvayD5rZ6YGVw2F+Cebt0oCzvBe5Wzd1f28+QWqHHsknqGmSHB
 wITCcvTkGfGHLl5vvwqQRXldpbD0HcNxqrSaZlbqmuh/t2gcxOTJyk+T5iS6QTwcyiLRAMoVd6D
 My
X-Received: by 2002:a17:907:a606:b0:c1c:2007:298e with SMTP id
 a640c23a62f3a-c212a208e62mr1476092666b.24.1787038004198; Tue, 18 Aug 2026
 00:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-mtk-dts-drop-mt6357-dtsi-v1-1-fe6ce3fdf1c0@baylibre.com>
In-Reply-To: <20260817-mtk-dts-drop-mt6357-dtsi-v1-1-fe6ce3fdf1c0@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 18 Aug 2026 09:26:35 +0200
X-Gm-Features: AcwNN1V85j-t328Ahbw7FV_jQ9zIEAoCRhf_qtL2vZrDwYK6UTFONrj3Ez4lfGY
Message-ID: <CAEHHSvbFRh8o8iqVuKwQhmj9B9DfwY4C+0GcuxvkjPK7jfb-2w@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: mediatek: remove mt6357.dtsi
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
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

Le mar. 18 ao=C3=BBt 2026 =C3=A0 02:20, David Lechner <dlechner@baylibre.co=
m> a =C3=A9crit :
>
> Remove the downstream mt6357.dtsi file. This is no longer needed since
> it is available upstream. The upstream version is more correct/complete
> as it doesn't have incorrect `compatible =3D "fixed-regulator"` propertie=
s
> on the regulators and has an adc node (not used by U-Boot).
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  arch/arm/dts/mt6357.dtsi | 282 -----------------------------------------=
------
>  1 file changed, 282 deletions(-)
>
> diff --git a/arch/arm/dts/mt6357.dtsi b/arch/arm/dts/mt6357.dtsi
> deleted file mode 100644
> index 3330a03c2f7..00000000000
> --- a/arch/arm/dts/mt6357.dtsi
> +++ /dev/null
> @@ -1,282 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> -/*
> - * Copyright (c) 2020 MediaTek Inc.
> - * Copyright (c) 2023 BayLibre Inc.
> - */
> -
> -#include <dt-bindings/input/input.h>
> -
> -&pwrap {
> -       mt6357_pmic: pmic {
> -               compatible =3D "mediatek,mt6357";
> -
> -               regulators {
> -                       mt6357_vproc_reg: buck-vproc {
> -                               regulator-name =3D "vproc";
> -                               regulator-min-microvolt =3D <518750>;
> -                               regulator-max-microvolt =3D <1312500>;
> -                               regulator-ramp-delay =3D <6250>;
> -                               regulator-enable-ramp-delay =3D <220>;
> -                               regulator-always-on;
> -                       };
> -
> -                       mt6357_vcore_reg: buck-vcore {
> -                               regulator-name =3D "vcore";
> -                               regulator-min-microvolt =3D <518750>;
> -                               regulator-max-microvolt =3D <1312500>;
> -                               regulator-ramp-delay =3D <6250>;
> -                               regulator-enable-ramp-delay =3D <220>;
> -                               regulator-always-on;
> -                       };
> -
> -                       mt6357_vmodem_reg: buck-vmodem {
> -                               regulator-name =3D "vmodem";
> -                               regulator-min-microvolt =3D <500000>;
> -                               regulator-max-microvolt =3D <1193750>;
> -                               regulator-ramp-delay =3D <6250>;
> -                               regulator-enable-ramp-delay =3D <220>;
> -                       };
> -
> -                       mt6357_vs1_reg: buck-vs1 {
> -                               regulator-name =3D "vs1";
> -                               regulator-min-microvolt =3D <1200000>;
> -                               regulator-max-microvolt =3D <2200000>;
> -                               regulator-ramp-delay =3D <12500>;
> -                               regulator-enable-ramp-delay =3D <220>;
> -                               regulator-always-on;
> -                       };
> -
> -                       mt6357_vpa_reg: buck-vpa {
> -                               regulator-name =3D "vpa";
> -                               regulator-min-microvolt =3D <500000>;
> -                               regulator-max-microvolt =3D <3650000>;
> -                               regulator-ramp-delay =3D <50000>;
> -                               regulator-enable-ramp-delay =3D <220>;
> -                       };
> -
> -                       mt6357_vfe28_reg: ldo-vfe28 {
> -                               compatible =3D "regulator-fixed";
> -                               regulator-name =3D "vfe28";
> -                               regulator-min-microvolt =3D <2800000>;
> -                               regulator-max-microvolt =3D <2800000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vxo22_reg: ldo-vxo22 {
> -                               regulator-name =3D "vxo22";
> -                               regulator-min-microvolt =3D <2200000>;
> -                               regulator-max-microvolt =3D <2400000>;
> -                               regulator-enable-ramp-delay =3D <110>;
> -                       };
> -
> -                       mt6357_vrf18_reg: ldo-vrf18 {
> -                               compatible =3D "regulator-fixed";
> -                               regulator-name =3D "vrf18";
> -                               regulator-min-microvolt =3D <1800000>;
> -                               regulator-max-microvolt =3D <1800000>;
> -                               regulator-enable-ramp-delay =3D <110>;
> -                       };
> -
> -                       mt6357_vrf12_reg: ldo-vrf12 {
> -                               compatible =3D "regulator-fixed";
> -                               regulator-name =3D "vrf12";
> -                               regulator-min-microvolt =3D <1200000>;
> -                               regulator-max-microvolt =3D <1200000>;
> -                               regulator-enable-ramp-delay =3D <110>;
> -                       };
> -
> -                       mt6357_vefuse_reg: ldo-vefuse {
> -                               regulator-name =3D "vefuse";
> -                               regulator-min-microvolt =3D <1200000>;
> -                               regulator-max-microvolt =3D <3300000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vcn33_bt_reg: ldo-vcn33-bt {
> -                               regulator-name =3D "vcn33-bt";
> -                               regulator-min-microvolt =3D <3300000>;
> -                               regulator-max-microvolt =3D <3500000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vcn33_wifi_reg: ldo-vcn33-wifi {
> -                               regulator-name =3D "vcn33-wifi";
> -                               regulator-min-microvolt =3D <3300000>;
> -                               regulator-max-microvolt =3D <3500000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vcn28_reg: ldo-vcn28 {
> -                               compatible =3D "regulator-fixed";
> -                               regulator-name =3D "vcn28";
> -                               regulator-min-microvolt =3D <2800000>;
> -                               regulator-max-microvolt =3D <2800000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vcn18_reg: ldo-vcn18 {
> -                               compatible =3D "regulator-fixed";
> -                               regulator-name =3D "vcn18";
> -                               regulator-min-microvolt =3D <1800000>;
> -                               regulator-max-microvolt =3D <1800000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vcama_reg: ldo-vcama {
> -                               regulator-name =3D "vcama";
> -                               regulator-min-microvolt =3D <2500000>;
> -                               regulator-max-microvolt =3D <2800000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vcamd_reg: ldo-vcamd {
> -                               regulator-name =3D "vcamd";
> -                               regulator-min-microvolt =3D <1000000>;
> -                               regulator-max-microvolt =3D <1800000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vcamio_reg: ldo-vcamio18 {
> -                               compatible =3D "regulator-fixed";
> -                               regulator-name =3D "vcamio";
> -                               regulator-min-microvolt =3D <1800000>;
> -                               regulator-max-microvolt =3D <1800000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vldo28_reg: ldo-vldo28 {
> -                               regulator-name =3D "vldo28";
> -                               regulator-min-microvolt =3D <2800000>;
> -                               regulator-max-microvolt =3D <3000000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vsram_others_reg: ldo-vsram-others {
> -                               regulator-name =3D "vsram-others";
> -                               regulator-min-microvolt =3D <518750>;
> -                               regulator-max-microvolt =3D <1312500>;
> -                               regulator-ramp-delay =3D <6250>;
> -                               regulator-enable-ramp-delay =3D <110>;
> -                               regulator-always-on;
> -                       };
> -
> -                       mt6357_vsram_proc_reg: ldo-vsram-proc {
> -                               regulator-name =3D "vsram-proc";
> -                               regulator-min-microvolt =3D <518750>;
> -                               regulator-max-microvolt =3D <1312500>;
> -                               regulator-ramp-delay =3D <6250>;
> -                               regulator-enable-ramp-delay =3D <110>;
> -                               regulator-always-on;
> -                       };
> -
> -                       mt6357_vaux18_reg: ldo-vaux18 {
> -                               compatible =3D "regulator-fixed";
> -                               regulator-name =3D "vaux18";
> -                               regulator-min-microvolt =3D <1800000>;
> -                               regulator-max-microvolt =3D <1800000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vaud28_reg: ldo-vaud28 {
> -                               compatible =3D "regulator-fixed";
> -                               regulator-name =3D "vaud28";
> -                               regulator-min-microvolt =3D <2800000>;
> -                               regulator-max-microvolt =3D <2800000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vio28_reg: ldo-vio28 {
> -                               compatible =3D "regulator-fixed";
> -                               regulator-name =3D "vio28";
> -                               regulator-min-microvolt =3D <2800000>;
> -                               regulator-max-microvolt =3D <2800000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vio18_reg: ldo-vio18 {
> -                               compatible =3D "regulator-fixed";
> -                               regulator-name =3D "vio18";
> -                               regulator-min-microvolt =3D <1800000>;
> -                               regulator-max-microvolt =3D <1800000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                               regulator-always-on;
> -                       };
> -
> -                       mt6357_vdram_reg: ldo-vdram {
> -                               regulator-name =3D "vdram";
> -                               regulator-min-microvolt =3D <1100000>;
> -                               regulator-max-microvolt =3D <1200000>;
> -                               regulator-enable-ramp-delay =3D <3300>;
> -                       };
> -
> -                       mt6357_vmc_reg: ldo-vmc {
> -                               regulator-name =3D "vmc";
> -                               regulator-min-microvolt =3D <1800000>;
> -                               regulator-max-microvolt =3D <3300000>;
> -                               regulator-enable-ramp-delay =3D <44>;
> -                       };
> -
> -                       mt6357_vmch_reg: ldo-vmch {
> -                               regulator-name =3D "vmch";
> -                               regulator-min-microvolt =3D <2900000>;
> -                               regulator-max-microvolt =3D <3300000>;
> -                               regulator-enable-ramp-delay =3D <44>;
> -                       };
> -
> -                       mt6357_vemc_reg: ldo-vemc {
> -                               regulator-name =3D "vemc";
> -                               regulator-min-microvolt =3D <2900000>;
> -                               regulator-max-microvolt =3D <3300000>;
> -                               regulator-enable-ramp-delay =3D <44>;
> -                               regulator-always-on;
> -                       };
> -
> -                       mt6357_vsim1_reg: ldo-vsim1 {
> -                               regulator-name =3D "vsim1";
> -                               regulator-min-microvolt =3D <1700000>;
> -                               regulator-max-microvolt =3D <3100000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vsim2_reg: ldo-vsim2 {
> -                               regulator-name =3D "vsim2";
> -                               regulator-min-microvolt =3D <1700000>;
> -                               regulator-max-microvolt =3D <3100000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -
> -                       mt6357_vibr_reg: ldo-vibr {
> -                               regulator-name =3D "vibr";
> -                               regulator-min-microvolt =3D <1200000>;
> -                               regulator-max-microvolt =3D <3300000>;
> -                               regulator-enable-ramp-delay =3D <44>;
> -                       };
> -
> -                       mt6357_vusb33_reg: ldo-vusb33 {
> -                               regulator-name =3D "vusb33";
> -                               regulator-min-microvolt =3D <3000000>;
> -                               regulator-max-microvolt =3D <3100000>;
> -                               regulator-enable-ramp-delay =3D <264>;
> -                       };
> -               };
> -
> -               rtc {
> -                       compatible =3D "mediatek,mt6357-rtc";
> -               };
> -
> -               keys {
> -                       compatible =3D "mediatek,mt6357-keys";
> -
> -                       key-power {
> -                               linux,keycodes =3D <KEY_POWER>;
> -                               wakeup-source;
> -                       };
> -
> -                       key-home {
> -                               linux,keycodes =3D <KEY_HOME>;
> -                               wakeup-source;
> -                       };
> -
> -               };
> -       };
> -};
>
> ---
> base-commit: 7581a12eb96c8b8825b65a9c597696cb28cb6155
> change-id: 20260817-mtk-dts-drop-mt6357-dtsi-e9dd7eca708b
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
