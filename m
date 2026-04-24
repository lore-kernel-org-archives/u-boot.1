Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA238FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A8284374;
	Sat, 25 Apr 2026 18:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QkUcrSlN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C728E83FB0; Sat, 25 Apr 2026 18:28:53 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 286AF8439F
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-50d87c138e1so90630871cf.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777134528; x=1777739328; darn=lists.denx.de;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+beSAOPwtW8EprolRDlwZ2L0dTQnjWV0S86OW2SNQI=;
 b=QkUcrSlN/12EQr89v0Pt2GvkvV8tMkN6f+RmGNT37FxX325fAEcO7zn+4D4JNOnxBx
 tXDLt7wI96VxwxX+LCZZGeP9VK4pefMD+0BrGzelg5Pv6PDGUS/UNMETXHMaZPQt289Z
 NQL0wqg88UenPww4JiMC05j/OTJFhhKb+B+LVl2/ogUfoaCaORCGf75xX0snhS7FGPbk
 c9cABxN6nqeyBulsH5C7g5Pavf5y3iM03o0mdacDAAh8+JK7/eilF2m57OWHiZXechSm
 /lmTkOUZzoYHTNjGY94ydrMuYqh/m5+WqckDs7RCTbNSOp16g+dOuRMSFS0Ya0IWwK/O
 yk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777134528; x=1777739328;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n+beSAOPwtW8EprolRDlwZ2L0dTQnjWV0S86OW2SNQI=;
 b=mUC0HVvIuORPT9CdiFk3UTNCN1bOc3Mx0uersl3kxVFCwC1LsVHcOusDG4C/tWUjsC
 7kT/1V1mvEaslyDEFnPkOKWEjYFBxb74/xQvTvJdmKiRzZiETyopT9188qIBJEs/6FlP
 XcjKxcZBwdWYZGRBykHkQZeP39F2sNE+i+I/t/mwWIxW8cg0+EFlTw1cwax5CR1JaFrr
 xDSrIgtw3BO/EG04L3oB8QL2fSJeBW/py07PE2Ga9gRsGtfrdsP3QzKZCQZgnCT5s+mX
 JZQXHtEx7dmUneptZ0jyZOEVhiDDW6/9GtkPXhEnHpaX1mrXWab8YOifyHHjLnVVe8YX
 rPDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/b3pj4eKhu4bwsYlCgLrR5KoN/bRfhmCttPdXQNth23cBNe6l37g0o8Foacw1FoSO59MGQaM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6EO/leSFZjnAY6Co/x4f3SdmkkLm6G+blLcRqCL/U4nrwKx4B
 J7LLKTFUI5CG+JS7nDgCldzaxUtzSg+PK5zFrP6wXI+R4+KrVOEDOiQBPlbkRw==
X-Gm-Gg: AeBDievVThNjPrMeWFPCYDbdxOkW6z2hrdo0yuEVBP0a+GOsR1+R+Nwp4f3UNxxqQox
 +vvqDAwFsZq+P77pSpSZrfP0yDCcFV3ZgP6BqYtxPhiJEPuzzPGHmowxHMd3Y3CfQC4gPXUtEZ0
 JgLdX6hFmdn0Wq8Kbz3IJdm9wpavQnwaa173HUhKuVX6NU7223DuHDei/+g026XStfXuLwCdffj
 rDWxqlXYCy3FcKsgYEmd7LG/RXx7/n64Qwgc3uOsHiu0E9/030x3YFDVj10RV/EyyUmnHlEu0Az
 s5MI+2uIlrwD5UBXd6bFJgXUd9A+odJjY9tJPjSl0DvZOw3xyExewz4omvITDjv5dpDSIZcrVaK
 d+Y7V1yrov+WHepw2nXmeqN6qpJvnvT29MTJhGXJrcDh7zA5LPBp1Czm9zb8ZJSW2x4ja5ID1eW
 yJMUhhAWP6/dRRE8hutJzjHhfFRy8Rq63qN1r9JW43h5a1xTiUQ2trkqMl/62GUAztV4U247//i
 cd5HHiIapCwjmlpDDkuHQ==
X-Received: by 2002:a05:6a00:93a8:b0:82f:9c37:ea65 with SMTP id
 d2e1a72fcca58-82f9c37fbdcmr24211265b3a.42.1777049208707; 
 Fri, 24 Apr 2026 09:46:48 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebb3f8asm24942852b3a.36.2026.04.24.09.46.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 09:46:48 -0700 (PDT)
Message-ID: <39b348ed-ffd3-46bd-9de3-e7bbac224766@gmail.com>
Date: Sat, 25 Apr 2026 00:46:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] phy: add common PHY properties support
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com,
 ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de
References: <20260405144944.41074-1-lucienzx159@gmail.com>
 <20260405144944.41074-2-lucienzx159@gmail.com>
 <CAFLszTj_einDasc5rRzt4KjyLuG2AS+=Y5w6H14aHuE43-dx1A@mail.gmail.com>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <CAFLszTj_einDasc5rRzt4KjyLuG2AS+=Y5w6H14aHuE43-dx1A@mail.gmail.com>
X-Mailman-Approved-At: Sat, 25 Apr 2026 18:55:32 +0200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


Simon Glass 於 2026/4/11 下午 10:37 寫道:
> Hi Lucien,
>
> On 2026-04-05T14:49:40, Lucien.Jheng<lucienzx159@gmail.com> wrote:
>> phy: add common PHY properties support
>>
>> Add a new PHY_COMMON_PROPS library that provides helper functions for
>> PHY drivers to read standardized polarity properties from the device
>> tree node:
>>
>>    - phy_get_rx_polarity() / phy_get_tx_polarity()
>>    - phy_get_manual_rx_polarity() / phy_get_manual_tx_polarity()
>>
>> The dt-bindings/phy/phy.h header with PHY_POL_NORMAL, PHY_POL_INVERT,
>> and PHY_POL_AUTO constants is provided via dts/upstream/include, which
>> is already in the build include path.
>>
>> Ported from Merge tag 'phy-for-7.0':
>>    git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
>>
>> Link:https://git.kernel.org/linus/e7556b59ba65179612bce3fa56bb53d1b4fb20db
>> Signed-off-by: Lucien.Jheng<lucienzx159@gmail.com>
>>
>> drivers/phy/Kconfig                  |   8 +
>>   drivers/phy/Makefile                 |   1 +
>>   drivers/phy/phy-common-props.c       | 286 +++++++++++++++++++++++++++++++++++
>>   include/linux/phy/phy-common-props.h |  69 +++++++++
>>   4 files changed, 364 insertions(+)
>> diff --git a/drivers/phy/phy-common-props.c b/drivers/phy/phy-common-props.c
>> @@ -74,6 +74,10 @@ static int ofnode_get_u32_prop_for_name(ofnode node, const char *name,
>> +     if (!name) {
>> +             printf("Error: Lookup key inside \"%s\" is mandatory\n",
>> +                    names_title);
> In U-Boot drivers, error messages typically use log_err() or pr_err()
> rather than printf(). This applies to the other printf() calls in this
> file as well. Please can you switch to pr_err() for consistency? Also
> note that these errors consume code space, so you could use
> log_debug() if you don't want to do that.

Sorry for the late reply.

I will switch to pr_err for consistency.

Thank you.

>
> Regards,
> Simon
