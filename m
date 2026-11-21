Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A3606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0F8JmN26;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pa7fH43O
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDAC86063A;
	Sat, 21 Nov 2026 16:31:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IPGgCOGfU0Sj; Sat, 21 Nov 2026 16:31:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A89C60626
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795278662;
	b=s6cqzFohoDV2zGWLrcVvTz1ORPK+gGADipGe3AJtZulD04xHxw6BDwnK8abz10tGk9Nr
	 J8LJXedTpCvNCwyG5kBWOFLb8WtpEOPwbCQQCgL8WX89DR8T9KBRQ11wkjKdmnc/FIHZ0
	 Mr+Hz6sS9db8EMeCNe7Gm4Cb76IRW0HFvke7C1CBslYG1aVggGoGksfnoZm4ZBxoTtkAz
	 fSKhysyXtG3+7uXcOCOyJxAnCyCMblHhUaIBMvxda6ml+8OTLDRUgzyeCXZvSr2Tl1ptm
	 2eaXvNpE1pNRsMmphITEoZjZlK97w6mmnNN2izwIsB6aa5XD9ohDtysyZH/a4QgQR7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795278662;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1coQtc3d8+xUTFxRLqZtJDCRa9fc6rfxMo8/pSDhlW8=;
	b=U50qsU6M6X+/MParDD+wYRLba5ak+zPsO2PIYWJXlXYf46AUsXGXw78U2iJgG07R1CGx
	 NA0YUGKksWroPRtai36NSC3+jy/Hb1XL96z1O9yxYPRu3yaKDugYvWLHG6x/CJK12KpIQ
	 MYmvggCU5P/Q/awy+eFFaxVJmakS1FWDWJYD7K2h5aDckV+0yH3QtrvJJpHfYLVFj+a/u
	 0oCxCMqxDXrlCLZa5A1AG4Do2B57QwarkQ3D4e2TDG80c/+LRIUrATnZdYxSOZLe4VnuR
	 kah5NuV8u2BeM99t8c/O7u/0RTIssbi1XOMsmy3hc6aijINVPVbRhNsoIuh+Hifqa3A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795278662;
	bh=1coQtc3d8+xUTFxRLqZtJDCRa9fc6rfxMo8/pSDhlW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0F8JmN26Tydv+C77dBSbHfYxayhrXn+YgqCjmTuaGgfomDDFlE7sgh7BJUOnajCIX
	 VD0qlhZg25SPzRS8ZeLFNTjAcjX6HuO91mqj28HChzeO4neyPn7Yu5JKHKPhSBZlBS
	 J+rvcY4LPJQrzYr0dV71Wfwx0zmGd8XjMAx7yY7fUwuNFor2It4Lmv6jcj5XMpX8gS
	 /QzHoqM6gKhJeVpdMfxfvOqg/y/vib6bi9jEYm6hkJgcbz2dAsobvcEZeNldJ+23fg
	 S8+dHrSRvtxeF71/hPEkTAcL4OizJJPCj/pTD/D2LvVedBpfeCu+57VTdwlztVt8Od
	 AX2JnuVdTfn1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A89C60626;
	Sat, 21 Nov 2026 16:31:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BB725A58
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 16:31:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ACD5A4009D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 16:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RE_fTl-QwHyN for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 16:31:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A835C40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pa7fH43O
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A835C40012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 16:30:59 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso21971745e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 08:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795278657; x=1795883457;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1coQtc3d8+xUTFxRLqZtJDCRa9fc6rfxMo8/pSDhlW8=;
 b=pa7fH43OlW/WHvQTPOUy1hCNFze5NPQA7pilWJ42TmZscOhMXvAHATUTFLSJHtA00E
 XH/PbpBQKGI2ka6y5ngLziJxbWWByPlJU5gI6HWu/beFTLN/P3/Ux7t50JPYjpn8ihhZ
 Q0XRsW7vj9KprSmd+rJat+F9o7aekzpiHxtriS2QItFFKBm/tOlUunIQp2MlItoyuKcZ
 YrIP3cBXqcK1UIFP73B3MZ9WtcZpCyQ/2RhKCENRMfAPtGDROXJhM3gvG8Y0jcsRp1+Q
 wf9rdcELFj5bmmQB3+S8X3l1HhoWuet/KnLC5anUtOWExqS6vD3KH0eUbNYwHVU430b8
 8Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795278657; x=1795883457;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1coQtc3d8+xUTFxRLqZtJDCRa9fc6rfxMo8/pSDhlW8=;
 b=eeefAFwXd/wtH0JWBTmk0fe3AvtTLR5EUZRJCmKboTt0jOlci6LAOHhci4HvdM8P1A
 N63uU/fUl7uQuM/QxkiNnW0Qcj8zUMQh92Xz51pQm7h21oPaZ+5K2KyNjnSGqFN1tPd0
 7Sx5ldKktnMkK0ff0pvpBYnCDjjUAkZkm4N/RK3npD78MmvMGCDF+sEY+RV1pqLQOyvP
 WIYzWkCAXkXTVGcUc9dv5k/4NAvSyNqvWV96zkPGMVpttt1xjG4sv+RZ1iua3WBMccwD
 fpNfACb40LasBaq+6WrBdkgETtLsOLsm+2V6B+FyTs4y8Ajb4Ej5A0nB2F4JdmA/jydD
 wqRA==
X-Forwarded-Encrypted: i=1;
 AL+hErGE8NzA1AFhIFc9AIxlOi1Sy0lJlwcUvTuySUhQ70mLAHRWy1r4i2QpDmQqHb4tKqVvnorL3Vg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9UFbKHVrJml/P09zXTxZqzKAg3ji59XFyl5Ft2SQAE29g4mrFp
 ZBCrY3D+dYdBMtGv+WvSllABShjckn+WcpDWuUc1WeBtwE3i4WsrI0XxkX+OUE5HjhU=
X-Gm-Gg: AZFdTZdSlTT1RmqI1R0rKcNs4MLEPYR5yzsYpdU/EM78nwMRDmA4il+yNyZIlv9mKd3
 CstQTUBMGr6YEP6XrCBXe8nla7xHYwrWv2FvopKINIJ5EpsIPvS5reGErF6LYN32U6MRxB06DvX
 wdMfPbsw+giNJhwtYDRr9StxBBZG63XXb70p8qf2tEZiNA7c9oOxZuo3cOI/0ibVQD1K/IUgCQA
 lWRnLZPDOIl1QNx30LGytpI1Pf5D2UGf8cXaS99JowNAJHLPE7520ZbEWMvoVj1pMz6AyMGd5er
 EKMkCYa/Vbybgo9eSnYQ5kQqWFQ7U2YnGVzhDLVHJqIzFzrfdN98TO/uDDmxks+ZLFzQTJ/6iiw
 Diadp23hpu/rnhr0rmD2F+FKb8BJ0QDwE3jjWQUfiDo6hA0thU1EP7F44ujxGUvCRkKwXsfDCU5
 4Sko60Cwty/d6aykpih9k9Wrx2HBViIYhCHaCuiuagHaLVNCzM6I+k/PrvAfy/lA0me5tIhGZOS
 N2otkgsxBfylmguYdi5u6XEov0W8F647WJPovy9iVfWhO25Os6TGPWyMiOCCL4DD6HlTyi/590Z
 XWZd7LYm3GIHemVcnFfSGEf0qvkC+6cGNqvr+3tcxV+4LhjnZFqWCdIFodUCBp0aDZ61NIBX8Cf
 wGeYKx9bvFrKW
X-Received: by 2002:a05:600c:8b83:b0:4a3:59c9:a747 with SMTP id
 5b1f17b1804b1-4bb8880642cmr141668865e9.17.1795278657361; 
 Sat, 21 Nov 2026 08:30:57 -0800 (PST)
Received: from macbook (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90655f5asm66132975e9.1.2026.11.21.08.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 08:30:56 -0800 (PST)
Date: Sat, 21 Nov 2026 17:30:55 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v3 2/2] arm: mediatek: run board_init_f() with the caches
 on
Message-ID: <awHG70eD8qDwGc7L@macbook>
References: <20261120-std-upstream-mt8188-spl-caches-v3-0-b5ab70d56006@beckhoff.com>
 <20261120-std-upstream-mt8188-spl-caches-v3-2-b5ab70d56006@beckhoff.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-std-upstream-mt8188-spl-caches-v3-2-b5ab70d56006@beckhoff.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 17:29:19 +0100, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> Device tree walks and other setup is very slow without caches, so turn
> them on before relocation.
> 
> On an MT8370 module, from bootstage marks before each initcall, two
> boots each:
> 
>   step                            caches off        caches on
>   initf_dm                        349.8 / 349.7     4.6 / 4.6 ms
>   serial_init                     204.7 / 204.7     3.0 / 3.0 ms
>   dram_init                       162.2 / 162.1     2.3 / 2.3 ms
>   relocate_code                   22.0 / 22.0       0.4 / 0.4 ms
>   board_init_f() to main_loop()   819 / 819         87 / 87 ms
> 
> and from the serial console, after power-on (includes 5s debug usb wait):
> 
>   U-Boot banner                   7336 / 7335 ms    6772 / 6775 ms
> 
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
>  arch/arm/include/asm/arch-mediatek/misc.h |  1 +
>  arch/arm/mach-mediatek/Kconfig            | 10 +++++++++-
>  arch/arm/mach-mediatek/cpu.c              |  6 ++++++
>  arch/arm/mach-mediatek/early_caches.c     | 10 ++++++++++
>  4 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-mediatek/misc.h b/arch/arm/include/asm/arch-mediatek/misc.h
> index dd248d222b97..517fbe7842ff 100644
> --- a/arch/arm/include/asm/arch-mediatek/misc.h
> +++ b/arch/arm/include/asm/arch-mediatek/misc.h
> @@ -15,5 +15,6 @@
>  #define APSW_VER		0x0c
>  
>  void mtk_early_enable_caches(void);
> +void mtk_early_disable_caches(void);

nit: same as before these functions are really only dealing with
dcache, not caches in general so I think a more proper name would be
mtk_early_disable_dcache

Otherwise:

Reviewed-by: Carlo Caione <ccaione@baylibre.com>


--
Carlo Caione
