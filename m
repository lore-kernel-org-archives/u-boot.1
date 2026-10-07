Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AD5CA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 12:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8609606C6;
	Wed,  7 Oct 2026 12:16:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gX3ABXZZYRgJ; Wed,  7 Oct 2026 12:16:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2540F6066D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791375419;
	b=CKIbS/dtGd97ZGaEcBNYKqOn0n01LFRyN5KajjjZkKqGZzXR4z6UZCzUhfoLLe3/a6wK
	 uPc2KPo4O7Ij11vIRySLScV4ZCbSecn8SNKBoAJ3/BusbXYSQtANbInrAsxcKr+lGoUBX
	 ZP5DpXwfTzrlNdhe59v+cR/ZucInzriU9GIprmutIS16eTgOKNsTW6SmzYtm95SaSazqg
	 uE6qR0hNr2z9V5jClbnt/RqKA7dTq+yaDSAVI2eCk32M7IpDs40JbFB2P98VXkghuiEOo
	 9oUdmrZU/23M7Dw92v/M2GDpJbU4MRbfo36+vELtbMFVku5lG4ARNUZXsLlHGh2vFXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791375419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IYLAXWbJUmdgIqpTkAOtOYeFnNROW0vlagVC8Q873Mc=;
	b=m5lCU6Bwg5776w3VenQ2n6g+KmGm3urWIOvEU5F5PURAF3mWnEAZYgSLg7xYjb3QEMl0
	 4PjnlSU6OHghMQ0ii+17QeuvnrWSIEuEdB+BaS3VkOIXH4K024jxJgsWJiYDB29teyLjC
	 k6KX/9BU0i37uIHScfUeQEXCZZzPaRHGRI1hg9NjUQ5oFDLWvRVbxnkiYvoHZSu3RpRJL
	 2BucgH06gPUonYoK9ZfxiaYSD8biP1MJdJH/aHIuxMyW2loD07/tYOOfxn3DIbsflV/mN
	 xPx2wVA4Ry6bMXwufq03Xv7vwu97orZnJvUlonHj7s/4jqP/6XGFdupg0yswY+Xt3nQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791375419;
	bh=IYLAXWbJUmdgIqpTkAOtOYeFnNROW0vlagVC8Q873Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T+VDrwwA8VraPjr6I1UW3jWIQYAnEbCtl5fJRIT7duGjSdloTSMQBEBEztW+yj1LU
	 oFFOC+iWnGwBRnBc/JwSptV3SgPSKunrky98wzUjsccfgQGbBImEuhrSI4oD2LK85R
	 KuoKntL0YrBMEbrvUeyRM6+mxTCK/7nbOwrFW6CM1iz4XBcSS0bq0IedaBwunDvax/
	 4R3aj2Q4lJkqlSajbrQ6LBaXJIevBeA+LzbTLDX4nqpw7UQINqP/H6p6MxF7ZJ46By
	 DEYTlqzwa4g0eR1q5qX10SwA/65X6oU3+wza6HuLOJEC5K9pQof4HQN2aIMe3MocRA
	 3EwYS/VE4BbUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2540F6066D;
	Wed,  7 Oct 2026 12:16:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D5D7338
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 12:07:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0373C40080
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 12:07:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nSmep1zXUY6k for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 12:07:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3D7FC40057
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791374870;
 b=MRRn8TiEL7pLCVwu7evHC6Y6lv/ZOV/19HjVimsRwTwhIl6Sh3Rc3aIa8br5nsWNAwZS
 uUwYi1NSTuA/w/uIoow9J5JAk4B1TtvBoCMdM/RZ+G7BL8sJaAva2PqgawWB/vl22iXbl
 RjpHLFYxEuCPTUZNM8ZGrruRQEgdUTgdDra0qxXVBDNeWMQ/J78BIZtbrRFHAwYAALJq1
 57zBG4wfM0lLL2hYEouGr4H1EYbEpe7mlV5Mmk90Of5pKZAXgt2t1psfJL31j/5PeIq43
 L/a7nkcpg3gLj+V5sdWPksFS8lRvJlZuyM3q3OPpKKucMAyFRAQpC0+pvQLavKm/eJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791374870;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=IYLAXWbJUmdgIqpTkAOtOYeFnNROW0vlagVC8Q873Mc=;
 b=SwWocGYRIzBOVBBuvhZFf06vVhV2ueruGSr19BKINi8EaSztoITHbMTI8vfoDl0LLJlC
 7veVc46/MGQppZhYqmaF2/YTTEzDFkJ30CqC2f7wtoWl7G/rPHjb4692tnzPBBp5rCDAD
 SRyV8lPj396J7nLr+C8wqLokvArlTnNmDVjLrsqdYlgwp7784tbMn1IJ4bLCBnZ+QuiD2
 6MpYNIX6Sr4omQ+OY8GreF1Q9Gq0zckLELzPswMfwG8qFFXTmhWE7tHwsslebnZSEVCSh
 FziYmci3hFcnPk5k6+m0vJdXxt1K05mbOczwaTEOKg96PHY6LNzgvxDHbTi0/MX9OUw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Gg4ieK86; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Gg4ieK86
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D7FC40057
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 12:07:48 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48b042c0728so547607f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 05:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791374867; x=1791979667;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IYLAXWbJUmdgIqpTkAOtOYeFnNROW0vlagVC8Q873Mc=;
 b=Gg4ieK86Fx/Ed7fxF89+EWouKMW/xflPdubiDJQtXJUR5UmTX3vcZDK73tgrru8ZcB
 cgbRWeuJyt2e6mttxXPWOW0pdxQoR9jmKIatsfxdXwr671R/xaetEEtYrCI0VGCoEjFP
 KF9gYZ0XiJO/bKSHXY1q4jgjZTfw8/TkTH0YN06uFN6cdjngivDosEoKSxuTO9C54f/g
 WQHMdFpck0ZPS+QGJbb3X5DOc4KqjxTXbenwyTKoJnpz+ZpwVeOoWNS9bYKu62/JSbzz
 c0yTFAvmqjI/crErhAnqCWtyTD9H7iTCJrTOAEL8IwwgI3eLi6F9qnu8hZoFNdMyI0RN
 g/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791374867; x=1791979667;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IYLAXWbJUmdgIqpTkAOtOYeFnNROW0vlagVC8Q873Mc=;
 b=bm6CxHJLcz2IdTtRMJb2l/d0Um2+5fD4hh+QjNP1vrB2rKk4ug7kxpv7AGrD85+9+d
 +Y8/kHFcbl3v254BZ7m0ZmVbY9DEf9saE4eryVpJUCyWL1U+c7Lbfy2Gfblw8ymsc2r6
 R3Sz2fc8heI3IdzfmQP/Z59tljCboVtHnr7vcGabKPDFnSl9F+jKuQg4uaY9EWsVo+nt
 gHPJUvr/O4sW2YqPyN+NsT8k1RIwaxQxjE4KH4cpQlP+KUK/+XxIjQlJ0i8/5hAvDL9z
 43EFeYGPubTi60S2QzofJ5ASY3drnSD8yD238hpRAY0sh/r0SQuqsLhmOiucYklzj1Q8
 gPUA==
X-Gm-Message-State: AFuF++kKpe72KKnaDjXlBtaxeW270zdSHCllNvKFpl7Rk/tHmSQXKmrG
 jnoCEKSw/sB9Q/Bcfqo/x53BY+gmkv51+6gLHrZpCXoZ9NirnTbJmHLhWiKP+0cghk8=
X-Gm-Gg: AYBFou0OmNT91eMFM12UX9i2fJFsZO+0Zx5dFvWRFbY9DSWO3oEycIDBVOngqjKiemZ
 UQ/KHvk5L8Xzkt2Qj7h2aWiJViyoLek1WufiVk8+lOhjXXbapZUVBYSoR/IhU/GDUew4/Ek1SwQ
 Pa0Nli+dh3qPFwartkmysqsEGYPnjSRnPhMvRoTJtp9He5ICw+8DaAy6/syg7+NQkfCoMaIp7Dr
 DRlEUMmVGOJ/gcam82U6SuOC+gcHKO+h/qb9wJiAw+4Ty4O8eron4XGMWC6ykcgXOx61oTe5WEi
 1NYT6UBHvryTbPvYdhxzPCXZrQQUL5LjirK1qpiZp9GN6h6XMq2bgliftQLC3CljFj+RvwEyBhw
 gvAfnaD3hYaFDZx1wpr9rxlnUdWFN4GY+hNkj99cSUTMZwvqGLWN1CdMiMvTXpMq09SjZTKYcho
 FiZjMnkryweGzNlTK2ewx7GU/Dx9ExVFTUmBLzJiuVs6EIFe8s8kEbHDQuY4/Q3G1LiqCtDayiy
 vaARFJXb8t/mHOZYzIpczBM7IJmWINrsbTK/rGz98vn1i8jkuxhzQOLegiN96ZGfOxkjJmb7Ove
 iM0=
X-Received: by 2002:a05:600c:524f:b0:4a1:6d35:779a with SMTP id
 5b1f17b1804b1-4a1800d1ca4mr32337335e9.3.1791374866730; 
 Wed, 07 Oct 2026 05:07:46 -0700 (PDT)
Received: from macbook.tail959722.ts.net
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a180310c9fsm47592975e9.4.2026.10.07.05.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 05:07:46 -0700 (PDT)
Date: Wed, 7 Oct 2026 14:07:45 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v3 0/5] firmware-owned devicetree for EBBR / SystemReady
 DeviceTree
Message-ID: <asY1exCswTF3-TvB@macbook.tail959722.ts.net>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <CF9CE178-91B3-4F7E-AC97-DE37B8D63CDF@gmx.de>
 <9A8EEB25-DEA9-4CBA-B932-1E1D1D477246@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9A8EEB25-DEA9-4CBA-B932-1E1D1D477246@gmx.de>
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

On Tue, Sep 29, 2026 at 00:20:41 +0100, Heinrich Schuchardt wrote:
 
> Thinking of other boot stages like EDK II the device-tree may already
> have to be created in U-Boot SPL.
> 
> Multiple RISC-V systems boot via
> 
> U-Boot SPL -> OpenSBI-> EDK II

Agreed: that chain has no U-Boot proper, so the EFI hooks in this series
never run. If U-Boot prepares the DT, it would need to do so in SPL and
hand it onward but, yes, this series does not yet enable it in SPL.

Cheers,

--
Carlo Caione
