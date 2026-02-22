Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42600C636B3
	for <u-boot@archiver.kernel.org>; Sun, 22 Feb 2026 16:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4924A80FA1;
	Sun, 22 Feb 2026 17:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lmgnqEA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8809783642; Sun, 22 Feb 2026 17:27:12 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15C3D801BE
 for <u-boot@lists.denx.de>; Sun, 22 Feb 2026 17:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so14510585ad.3
 for <u-boot@lists.denx.de>; Sun, 22 Feb 2026 08:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771777628; x=1772382428; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=narSQsCqoHKBIhuxjO2TaCc52GIyeIEEW76j+AucpGU=;
 b=lmgnqEA/v73VM5V4Tu142dE1CGuz06U7fPCpShtj0NkmigqpXs2w35Twet74oh4HXB
 p9VqQTno3vlG+eumyWmpwLaaDGbnTSRX7XUTakoazIc+SUNl58SCVw0ZldijIBobIVaV
 zWHpiVA+/pM9h3bjWPI3Y/TQIu2o32bRoEcARHkWsT7M7Uk+oy28tPBpXWQo7T2fdpYW
 IbZgwp+VmcHk6STEO0uxSM83PKdmzbMccMun1dwUVPgscUsIT/RzyXZ1jy3N82BTEMkr
 DayUusZBywCPbnyit5txCOyFxTVsB9hMft+jNs/LnRsypprzcHBaScNqp3Hybqr80P8K
 duVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771777628; x=1772382428;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=narSQsCqoHKBIhuxjO2TaCc52GIyeIEEW76j+AucpGU=;
 b=FTW5nWErHfOZpCTcm0pvCoZk7mDSHLoCiWUBIzijBeCZ2JQK2QO2DDF20EIsIo0TGS
 9fNl7KrPNMTXNQHwX3p53WvNDWfcs+lXM7IYce5uu1SGtSr0vdDDUZttciXb0e2y2vpX
 BJOduQacC3CYMfHWcVrAC4YSOMZ7e0ebwH3/ya+di+9iHOBKd9Pd2y0ODhlk+oQpd6UZ
 mT1zbmUrqCaWvGu3OINWVE3jlMIxGdhkPhWjsXwBxg8PJSpfXYX/LgTz+HzBo8dXsITN
 mRZnDDfhH51b2gH3zCSUJJXAm4YNaqKdXccp2tptl83tzLKZAfmgKK+3qSNn4f3v5xKz
 UhsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/ux9G43upzqdWX8DXcpRuLIS6Cty3fekwitw114YMx0mRuKNqw2GN+ziSOXBEr0iPZ+ESDCM=@lists.denx.de
X-Gm-Message-State: AOJu0YxSD9yG9XvpfQFFt64U5obCrL2InpMtDLZRpaZbOrs6QerkM6Pt
 jrv+Sgy81Kwmk3oMSDua+Q1NJILfFSkqXqoVaDesQiOfhvcbqpiFiVNt
X-Gm-Gg: AZuq6aJrKVPsncVqOa956SY1PT7WskeqXArm4LtxJuh9YOA+LE5C0yo31PW/BdlMwPs
 hqWuXGYN2B8/ZTDiCjM7AGEhvmeo37IuRlz8ZLTVnGXYWGiR6cnWvy3GyvYwXXNIkYknPK3ObyR
 LCEOW5jU6kM5xMy6m/y3CEFeqeUIs349oy/ooyHTPW2RN3h+EAsL2S5WzTQIMjDkt8jsGQcNTVz
 XSGwvdz0428G3ZURxhhOPWh+vqc10nunzrJQu9zyK2lsD5amBAsh3wLv7OivyH8fb/c2a7LfwCV
 7nj/+AIzZs4TfjckGSn3IhZ8tahaDRR+B07vw47x+qlBgP0TJq3oJH0c4FOOZjiJRDAL4mADfSa
 4TJFRN1gyajLhajWsPXBi/cWpNEOtCJWnslCEeYIFJxExIV+vNK3oJpzpMttCwqP5gz4AsIbjEn
 UZPgFigP9+kA68GfYu4U5U+D79tQQXo6Nk3alN6GpnNl8AHIHV9mGuU34YuB6rq0AAJ5hKnFdmf
 v4q3XWS6pE=
X-Received: by 2002:a17:903:b4f:b0:2a9:62da:9c21 with SMTP id
 d9443c01a7336-2ad742b22ccmr46046785ad.0.1771777628466; 
 Sun, 22 Feb 2026 08:27:08 -0800 (PST)
Received: from [192.168.0.2] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74e350b4sm49829995ad.4.2026.02.22.08.27.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Feb 2026 08:27:07 -0800 (PST)
Message-ID: <8e1c4274-797e-4f2d-b1ff-c6ef67bffacd@gmail.com>
Date: Mon, 23 Feb 2026 00:27:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] dt-bindings: net: airoha,en8811h: deprecate
 pnswap-rx and pnswap-tx
To: Tom Rini <trini@konsulko.com>
Cc: jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, ericwouds@gmail.com, kabel@kernel.org,
 vladimir.oltean@nxp.com, frank-w@public-files.de, daniel@makrotopia.org,
 ansuelsmth@gmail.com, mkorpershoek@kernel.org, skylake.huang@mediatek.com,
 u-boot@lists.denx.de
References: <20260221163114.87553-1-lucienzx159@gmail.com>
 <20260221163114.87553-4-lucienzx159@gmail.com>
 <20260221164556.GZ3233182@bill-the-cat>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <20260221164556.GZ3233182@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Feb 2026 17:47:59 +0100
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

Hi Tom

Tom Rini 於 2026/2/22 上午 12:45 寫道:
> On Sun, Feb 22, 2026 at 12:31:13AM +0800, Lucien.Jheng wrote:
>
>> Deprecate the proprietary airoha,pnswap-rx and airoha,pnswap-tx boolean
>> properties in favour of the standard rx-polarity and tx-polarity
>> properties defined in phy-common-props.yaml.
>>
>> Update the example to use rx-polarity with the PHY_POL_INVERT constant.
>>
>> Link: https://git.kernel.org/linus/44f62aa1b1209232cedcfb39097fc1bfbe75bbc7
>> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> And for clarity, my comment about cherry-pick also applies here. The
> script tools/update-subtree.sh makes doing the cherry-picks
> straighforward.

Thank you for your comment.

I checked devicetree-rebasing.git and it only has the v6.19-dts tag.

I will try to manually cherry-pick all phy-common DTS-related commits 
from Linux.

Thanks.

