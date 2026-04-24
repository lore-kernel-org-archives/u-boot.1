Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36149FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B988843F5;
	Sat, 25 Apr 2026 20:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cYumNRln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E21B842BF; Sat, 25 Apr 2026 19:01:10 +0200 (CEST)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com
 [IPv6:2607:f8b0:4864:20::122a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B5480087
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-12c7212836bso6157000c88.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777136466; x=1777741266; darn=lists.denx.de;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zfm/g0LsZvduljyylmsZ/z/boJCMUEoAB9cg1Qeg/w=;
 b=cYumNRln0a1Duu9rCI0354xG27G/GfLkV+tSDncXRkKsdem74OfLpeQU8Sxw/4/Tpw
 bhE3y5HM+pdomBJryieEfLy6L8UXSOOIUmoOeYUqf7V+3Hg8EvD9AXKgyN0cK45ydj1H
 qDOcstNZ6i1Xb9kDRzDRoN3RcJ0pU4jk4GOYQ0xrlJB++lDPG4BfsTkT9deERF4XfnXy
 kzL4zghGXYY00bBfvlrNSC+GG2j86BbRlO+fB0apqY5msimQh+Igtppo5mq1nMGNOALw
 rNkVjLupAEfJcBbPOUJWczG4e+OssizjIyoAAwG0h3hk1OK+D15Ppw90P0Jd4yV8DTXM
 iGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777136466; x=1777741266;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3zfm/g0LsZvduljyylmsZ/z/boJCMUEoAB9cg1Qeg/w=;
 b=PBLqP2fuuvnUsKUOA2VulXwqv8voli0i18n2CV8oPqRhSJjDuOJPGHy+ynl5Myg7ao
 TYd0Zs8lqYVf77GvBUTOExK243bT06xTXK4UTt/JFNcFoARJ1ndNBhBA0ZHRnPEBhoni
 LSbkQuznuVbtDXJjI01xBCyGFRlLmWSl8a/351npKviLrXhGzxB7KwNXRbcCe192Vhgx
 Pid7Zha8pu8hhIUOFm4iAu6p5RMncRN48yu1PK4mRKgDKEuGM2gUaWZEH4/afMoKxS0b
 2jet+zEu4hu+ohoSM5AnHcBEcMvqCqqt/0EjMIrwPkC89PwXW6rVJnDX6BnCFP3i0Ycs
 IP5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bAyZNBNXtiwWwbvDKRX6XQenfGwSaiWz9hVrbfXM/kuG9rFEC6hp+NuwO3t/ZlKmDxLUqymY=@lists.denx.de
X-Gm-Message-State: AOJu0YxL4s9VUzpu/kmg2ytpFtT9L6OYge1QnucCLm62+V1Djrpx+Tbx
 dronruFLLXNxVcvTvrxUnRYnsCV4VYs3r3q5QAFLMD8rPbg9nBRqDDw4M8ZYQw==
X-Gm-Gg: AeBDietBaQafubK4AYMYIunbgMaUXAbmbwOiFOIE09oIqmZa+ZsHR6NLsasnUZhsGFw
 hD8k8C9JjEqhEYZYWs8+jwgRZmY7MTzpxbdZ1HneRwwZ8rR8awj+qdR4zzTKd7HYHQ7JssJsYOV
 PExB0Dvx3dWN+aOZYZ1upMHeA3OPkwP31UMvrN47ujXJIDXDMtrFgLHmS3bfWwveayFpUTaQ8Lp
 NmoAP3UNO8jVbnsPvZnO4sxleIib+bEUn1qXXdgHYEQzHnwURztfBV5u7QBZODa8RdfpvHn2SOA
 KMSPIIzHcynAHrNsiYb9oa3n60Wt+d0fP79OsWa7Gmh4p5xgtdYCM+vWCzPCtr9CaiUzmiQOMFq
 Ae1mkh4rW8vROOrzZiOymKsk8AkGiADYH79KTWEFLeBshbu2TAfHYmjFR3LF1Fzik9dQ6cedRX6
 6luTYi4TbxwSDFEPK0UtDOUDM9OigfB0MTpZ42DNTEzPF727MY18yCriYP/STzGezddGKJqq4iP
 t70ALwua4Ee/8voGZAzHg==
X-Received: by 2002:a17:903:4510:b0:2b2:a6a2:c8ca with SMTP id
 d9443c01a7336-2b5f9ed123cmr247232705ad.13.1777049313399; 
 Fri, 24 Apr 2026 09:48:33 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab40786sm247603515ad.79.2026.04.24.09.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 09:48:33 -0700 (PDT)
Message-ID: <c4532203-1827-4740-aaa0-35f086bfe126@gmail.com>
Date: Sat, 25 Apr 2026 00:48:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] net: phy: air_en8811h: use standard
 rx-polarity/tx-polarity properties
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com,
 ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de
References: <20260405144944.41074-1-lucienzx159@gmail.com>
 <20260405144944.41074-3-lucienzx159@gmail.com>
 <CAFLszTiL-j=i0AFyoDc8yKFAxoKzdZms6tqiT_ePohYGaGM-RA@mail.gmail.com>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <CAFLszTiL-j=i0AFyoDc8yKFAxoKzdZms6tqiT_ePohYGaGM-RA@mail.gmail.com>
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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
>> net: phy: air_en8811h: use standard rx-polarity/tx-polarity properties
>>
>> Replace the proprietary airoha,pnswap-rx / airoha,pnswap-tx boolean
>> device tree properties with the standard rx-polarity and tx-polarity
>> properties defined in phy-common-props.yaml.
>>
>> Backward compatibility is maintained by reading the legacy boolean
>> properties first and passing them as the default_pol argument to
>> phy_get_rx/tx_polarity(). If the standard properties are absent the
>> legacy values are used transparently, so existing device trees remain
>> functional without modification.
>>
>> Link:https://git.kernel.org/linus/66d8a334b57e64e43810623b3d88f0ce9745270b
>> Signed-off-by: Lucien.Jheng<lucienzx159@gmail.com>
>>
>> drivers/net/phy/airoha/Kconfig      |  1 +
>>   drivers/net/phy/airoha/air_en8811.c | 58 ++++++++++++++++++++++++++++---------
>>   2 files changed, 45 insertions(+), 14 deletions(-)
>> diff --git a/drivers/net/phy/airoha/air_en8811.c b/drivers/net/phy/airoha/air_en8811.c
>> @@ -1046,6 +1047,47 @@ static int air_leds_init(...)
>> +     ret = phy_get_rx_polarity(node,
>> +                               phy_interface_strings[phydev->interface],
> Should you use phy_string_for_interface() here instead of directly indexing?
>
>> diff --git a/drivers/net/phy/airoha/air_en8811.c b/drivers/net/phy/airoha/air_en8811.c
>> @@ -1046,6 +1047,47 @@ static int air_leds_init(...)
>> +     ret = phy_get_tx_polarity(node,
>> +                               phy_interface_strings[phydev->interface],
> Same here.

I will use phy_string_for_interface() in the next patch.

Thanks
>
> Regards,
> Simon
