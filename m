Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0966FC79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 738B760803;
	Wed,  9 Sep 2026 20:37:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iC2W4Sx4WZyb; Wed,  9 Sep 2026 20:37:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AD00D607FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788986276;
	b=XEClvOi53Lo4f8IAorNW3IfIWZ3rL12qeliVhbR2ydYhIOOdLgSOD0+i7R9qQR/b6D2J
	 QP7TnUyoijN6WFgPs9IHlXkexm98JA5VQ5JGLE3DIayX/a6CkAKG8oEHeep0IDelz3fwA
	 5c44LgUEKQy3KiBo56SBOULAwEi43CaW1dOAS1jj2VIdbJr3voMpjlT9ugKvdZ0CXpVHd
	 N1ZWKvbGOGm1h2P/grgW6qBOJfIxlgw3Pdj3g68YWGPwpoyUC0DtS34BpQ4wvwMyZaXDt
	 61eUbMlkm8WdeycriFmi51pajSXioX86O1gjw5TSjjDd638Qiqr7Jh5uLxd6wXDak4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788986276;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nHcwydXfw65Ul7ZPnJqOc91oeuAGau1vqCDRKGR4tto=;
	b=nBY00f8EAEFn4k8DZCNyhd1lz/jSvK70sjICsuP7YHTNUOstXBGpuCYH/rOoPdOOoeKG
	 PxK6hwiVM7SQpjXC6iradNQZpkq7qaIWCYqdU2laVGViAohWTA4aCyNuxMYgHA5gGnyhW
	 2andxbc2K/eDS0dUtENh7rbfWqnUemHBQEaJsTN8PFBVVlUG7p2yfLJHHf8WKMM3M4hp5
	 GHLwOEGVFQYW0YA4vCMOG8alKTLbmYhn9Z03napMkAhZubGLzh80ckDJCjGGeLXIN7nUk
	 Z1+CvuDcgRLn9hIwJbz7EsoJNthAPhxfGPhP3p+kcsHx2LScINnB+SGfjlADbLnnDgQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788986276;
	bh=nHcwydXfw65Ul7ZPnJqOc91oeuAGau1vqCDRKGR4tto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=taHw88Mco1K7zQgc5Q5YEDl0uQYIl3rqif/x3M6C9Fs2BSoyAVL+Us/iPCw34CBi6
	 fh4P1w2AmydbYcq2Aqo9EQKBsrBKehHJLvM7o/5P8KkmKcoWiwcDwljqa5u/dbHFEz
	 lkIYtOUwxm5x33NVQAe4WghXsIeaRuDcauKSyFjGVDdxRqbRVR97QOOsYA5N8R+mia
	 Q/Y7IDj9XEf8r0m5C/VUjA3zB+I42A3rIODqEF8DtqQ3Q2WZPqHzP+v38w7Vv12Lpf
	 UeYWEvmMN0Tr7jeztps59cd/zKF15urSsJs4MGb0Cl6ojncJrrNjd7gDhK97Tn29JV
	 2bRQkg0mT1oWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD00D607FD;
	Wed,  9 Sep 2026 20:37:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F26A243F
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D84A780C4D
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:37:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vjiZg9ALmgLy for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 20:37:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D687980AA1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788986274;
 b=RWygESlHuNJZZ95i/XMrTvmrdWx+qsgqaGW6IxYHMcimULKTzUkc7zQdYeLM3/XyZn7r
 i0lmiSwCDLl9otcdm2J9TIzXXeSrd6HhjG1CWeQxCIuqQ8cmyfEiln1yA7lBPXbzzGmnK
 OD0Bi+JTIoDfo7DW9T0Wfrm5PGTA4qoMN6tmObI8JItV632moXfvUkjO2oDDzs2PEDgOC
 Rz+F50HB2YvgxLbN74POx+QV+zEnCezKZzdLqdyJlOsepbLDZSe0B3Tm6y1iwgqMPhKw8
 joFptCFcjYVKFPdq5JEbkd3VvkItJ6hTMZ23as7SR7THqTUFR6cSrsBbP7rJhSi3JsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788986274;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=nHcwydXfw65Ul7ZPnJqOc91oeuAGau1vqCDRKGR4tto=;
 b=DtfEtVDjfs4yYCze6rKSJ1GGvywJ68aHVFpIhVpb4c4KCmq00M+SwxfxGy1H+pSym00+
 SgePl8gLcq/zsOFWuNTuVReOujMk4XtEszXexqdgr7tbB1hrwHdaP1WIBiSjDfn+yW9oS
 UWICWl7IhOJ7H7zeoKvI3AuX7bEg3unkwScg7Lkid59n2xsJWRLKdawLccg3IvTgZZqvn
 1sYGSxTAW6h7Ivrkh0SZqKm1cFhEuBCkX7xz97ZBwEhdX4BPQXVJ3kJvRqA2iIkQgsoi/
 BBQ92i97ey1t2wZ7Inx8lOnsB/JnYyueZt6ggi3JIDk6qbImSGg+mD0EhnizZ6NCy1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=YwJaTsRl; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YwJaTsRl
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D687980AA1
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:37:53 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so9645425e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788986271; x=1789591071;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nHcwydXfw65Ul7ZPnJqOc91oeuAGau1vqCDRKGR4tto=;
 b=YwJaTsRlMdjdN+qB1qAo/HEEScIcbatE/NmiovUUoHDxuX5m3YRBfo+sMii/ayXOj2
 vj8zq58BEciRyO6vAZWnhbgBoF9JIqiakDR+bT52SEldzuvDdiPqmiCn3pyk5XgenI1o
 W/OsKD6Wvs6PJ55BqAPtGjkKfgJUr0y4SKaDFk+EcvOsaAfX/k/iHRLokFtGZAtIU/+B
 miZXyRx2R2sQgjshggNB6tgtX5srRkOhelFMhUo4JfK0PlsyVZne1YaV5Z7WkZvJOQiG
 SBhCZ+d97eUoiCCDCsoJGrwgCLrUtgveIYBcSnuReA9MSpMH48SAF/HPZ5Zadlsz1p4l
 z7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788986271; x=1789591071;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nHcwydXfw65Ul7ZPnJqOc91oeuAGau1vqCDRKGR4tto=;
 b=PN42ZonIa98WBz1xuNSEFlPq62i6umTQLxXdfAsy7YvcNtwgwOBSp5X8KHSSDHOv2H
 uVl3bjmIAzYhU/1wHTpls2KzoW26bfHy8hQoULLiH4Jvei/tSFF+7YMuX2iha9dchgXK
 FEZDi/A5WysszQY096zi8klp+9i6Ry/3Zd2sKORg7b4yyjZdqbJQzMu1MF+Wg78hRhkA
 qmX48WxxhTsQ/8/YnpOO9mt6hgx035iyq3T/vJp/v7IcVg94at/sN6cWqUu/9YIFuElf
 NV4B+J7u5MsyVSh5SSyL1IqMaIcYoObyyDqcX5KGbt0gqhS/ggNfAQyeoHQbX9cGbE85
 Bklw==
X-Forwarded-Encrypted: i=1;
 AKwUvByMe018tTadoc3yFcGJshgKoAuzQ60MUfJoQGaBl0WIuPSqa+uNC/lnVwmK+6soYcz1GwBZYuA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++krHRYSs0uMnrFdZRDpPC6kHlgKqjqTJejPuoBOUMlYkTx12PK4
 DcmNzpwMceC4hai41MNoqmLazrx0h863bIIUt+Aot7ldpqqK0kHVcX2SB6bxlyQdsZI=
X-Gm-Gg: AYBFou3w4Wi+pPCgpmeweMZik5AsbN0CIp6h1lNPhepjb3E+phjO4eUll1cKS4s8NZn
 W7r8PUSjcEiKiWId7ebVRlQo6mtLqf6y/6gKrHsZ5KWgdZlfvUibP/W9jJ8aSF4H++is6Wk4O7J
 Za/XtBs6e4jOEfD0AHTwlhRoJtb7I/zKUl6Uv5nqK/yiTdINavdGLsSIzbo4gYTaIzjip2gIQes
 IIEbmi5MuNh8F/57VqDo3sQDV2wyzi84nQnfnILTNARPjDJkHK8KPc2/XiZPtJEICKofc5V0DXG
 /eHSAEcecqP3SlBJEw4FFjqLzNBvkyOleLwSgNSGk1PJUEJCe0luqNspShQetMhI76dhI2VME5G
 W87nuw/DcCQF/eJjJv0xAq8fzibRiatYQSaBl3IAnivad5GGc9vjhNYs5Kqbwnp9wDjI22SZiB0
 NwyGdDmKaPk9P5o/PIIs9u6zz+9W3f54Aiq3uwUzMHGPzbXK7i+IuB+bfG3LuYM+33J+/nBAsOO
 pbdyTNzc70bBoB1Avi9zupWX+/Um2cYRH7R4UCj+fNFfxWC/X5KLQIhyQ==
X-Received: by 2002:a05:600c:3e0d:b0:49c:ff8d:b548 with SMTP id
 5b1f17b1804b1-49d1f358668mr174808985e9.11.1788986271166; 
 Wed, 09 Sep 2026 13:37:51 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20fce7a7sm174084545e9.4.2026.09.09.13.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 13:37:50 -0700 (PDT)
Date: Wed, 9 Sep 2026 22:37:49 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>
Subject: Re: [PATCH v6 2/6] configs: mt8188: enable eMMC FIT boot from SPL
Message-ID: <aqHDTZyARD1awneb@macbook>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
 <20260906-ccaione-upstream-mt8390-spl-v6-2-4d4a11d5741d@baylibre.com>
 <a5d869be-80f3-45fe-a312-615a0d7b4dcb@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d869be-80f3-45fe-a312-615a0d7b4dcb@baylibre.com>
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

On Wed, Sep 09, 2026 at 14:35:53 +0100, David Lechner wrote:
> On 9/6/26 10:30 AM, Carlo Caione wrote:
> > Enable the shared Genio 510/700 SPL path entered by the external DDR
> > loader. Keep BSS after the downstream SPL reservation, leaving a 0xc800
> > guard after the copy window and space for the initial stack and early
> > allocations. Use an 8 MiB heap for loading the firmware FIT.
> > 
> > Load BL31, OP-TEE and U-Boot from eMMC partition 1 using generic SPL
> > support. The MediaTek BL31 stalls when given a runtime devicetree as its
> > platform parameter, so pass NULL there while retaining the standard
> > firmware entry-point parameters.

[...] 
> > +# CONFIG_SPL_USE_TINY_PRINTF is not set
> 
> I guess this is for SPL fastboot support later?

Fastboot needs it too, but the current normal SPL configuration already
requires it: the MediaTek pinctrl driver's mtk_get_pin_muxing() and
mtk_pinconf_get() use scnprintf(), which tiny printf doesn't provide.

--
Carlo Caione
