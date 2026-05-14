Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BF8CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 17:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85AFB84690;
	Thu, 14 May 2026 19:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZRXx8+vw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CAD78469A; Thu, 14 May 2026 17:39:19 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E138464D
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 17:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3684a6f3b0bso2145083a91.1
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 08:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778773155; x=1779377955; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7hSKs7NJLJdko221WcMrZM31BmFeyw36M449R8Vo5GM=;
 b=ZRXx8+vwBKQ+HU0wGbGUGiPUZYgzGS7X7BZvzi94eF3P3Yg9a02R2gjaUoZFJpRrmT
 jY7FNY0X3+zeK96Hed3Lxk4qKlT3/YF95fZDc6n0Er4YjaZs39cRfOmzGmQ44zLHF/Ug
 efST3FBOQ2BqeqVbUfGS5mCCbZoR70FlS6zlibyDgZPP9CuBWv/ui4/1aH0jv/Px+Pgf
 9IPFxpaiUA7QCyEOeR4TZfIJ5q+9oq8rLkdimlCT9JmlqUYia48sbzteKgUZzGuy1WiV
 duHx76PauJ7WoAeZSmKpXzE85Fvo1rLQ9Rn5LKiS8AoOVj/T44CeRwrLyprsIuQbmzZi
 IM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778773155; x=1779377955;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7hSKs7NJLJdko221WcMrZM31BmFeyw36M449R8Vo5GM=;
 b=EoSzmTTn+7rUkv3lb8cEhIZI38dvNGyC/vgw/TDCDc+w/1pNshqU2W8QTwwsiFClhe
 YKqgXsY0jT+Be0rwULXo+TFzTZr44xpM8TMGFTGUn9A8m+85pEH+/8i4wMEY30uG1f9o
 vM1gW5wBTHwl3FoD/2vjVDNLiVnXDCsXR3Ek4dVQYSw4iQd35jGjo+BOhdSR4o0I53K7
 exD2nu9jAYbfpq+TYcPSvG2RYTh0g1THrUzTrIMyvOGTsIKywi/Kuz8KV9J4d9AcfxTM
 SC6zj84ajH2PJ0iWRH56ohvu+hoVNdpFbsTeR7hzP5+yT4jmlhgr4BEkWvBgUoLZVrwi
 wO2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iVY5YHSZ+lDrJkBwOExwKu+0ShsqDdJ6oBoaS4MvGNdLdzqnI94RYBkMzl7N+F6DWwV5+R8s=@lists.denx.de
X-Gm-Message-State: AOJu0YxOW99nqzk2yCXbkWEWTyBrm1CSoro79FPvH+xzIGbxfoiHjnGv
 E9K0rs3IFLt5JQcpp8Eo6gtHGhThdOOzYlt6EplaKqR2mETslb0b1cRu
X-Gm-Gg: Acq92OEmEM8GLE61EgpjVDY4p904ZT6RxVzYGo/m8fdDo4OesCyTqSqRXWI2ovhekkj
 CbheI/a3t4UKY3mQA97s9nhXPmrvzzeUkDj+vIlmawd5EjW9XO4CAyt+VeYbbS8lmvAfEiG2Xpp
 lskdQg9vr3EWWPuBZInkzS7/eOMvyeyd11K2YE1fsVymBCm6iWy2Fq7UyFKKAx2Ry2LABQ5r/3b
 X7RVXzb5uxKWkSatX4UgF4IXh2cdSmsbBTzIdw55CMPFHu09eWbeny1QTuix5M9mvHrpS+nypwW
 wZ94mXUGuuHIS5nclST7ewbn8K75PidyQ2tAxnyXm+mEPVzYLhKlu4GrUdYY3A2atddz/U9Fc32
 WtcFimBi5DetBU2RuvSOjCEODxlupBom/F5zcu6vlNfSAHI+xsqNBcYgg0e1MCNvs55UgCmwCE9
 IdL7lc8TwOYYVLfQ05zc7yDItEAAscyZskiZG4fpRK24Nw251eH0G63YxH0DrCcuXHR4CnCr8en
 hVU9+7cuDo=
X-Received: by 2002:a17:90b:4f81:b0:368:65d1:893 with SMTP id
 98e67ed59e1d1-3692344690amr3962195a91.5.1778773154626; 
 Thu, 14 May 2026 08:39:14 -0700 (PDT)
Received: from [192.168.0.3] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb115c38sm2861424a12.28.2026.05.14.08.39.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 08:39:14 -0700 (PDT)
Message-ID: <44a6161b-7560-4221-9b4b-432a8e5f4bcf@gmail.com>
Date: Thu, 14 May 2026 23:39:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260508234231.GF1858239@bill-the-cat>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <20260508234231.GF1858239@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 May 2026 19:13:12 +0200
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

I will fix coverity issue in the next patch.

Tom Rini 於 2026/5/9 上午 07:42 寫道:
> Here's the latest report. I think test code matters because it sets bad
> examples, or might not really end up testing things the way we want them
> to, and so should be fixed. Thanks!
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Fri, May 8, 2026 at 5:31 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
>
>     - *New Defects Found:* 17
>     - 3 defect(s), reported by Coverity Scan earlier, were marked fixed in
>     the recent build analyzed by Coverity Scan.
>     - *Defects Shown:* Showing 17 of 17 defect(s)
>
> Defect Details
>
> ** CID 646011:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 164           in
> dm_test_phy_common_props_rx_unsupported()
>
>
> _____________________________________________________________________________________________
> *** CID 646011:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 164             in
> dm_test_phy_common_props_rx_unsupported()
> 158     	unsigned int val;
> 159     	int ret;
> 160
> 161     	ut_assert(ofnode_valid(node));
> 162
> 163     	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>>      CID 646011:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 164     	ut_asserteq(-EOPNOTSUPP, ret);
> 165
> 166     	return 0;
> 167     }
> 168
> 169     DM_TEST(dm_test_phy_common_props_rx_unsupported, UTF_SCAN_FDT);
>
> ** CID 646010:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 236           in
> dm_test_phy_common_props_tx_more_names()
>
>
> _____________________________________________________________________________________________
> *** CID 646010:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 236             in
> dm_test_phy_common_props_tx_more_names()
> 230     	unsigned int val;
> 231     	int ret;
> 232
> 233     	ut_assert(ofnode_valid(node));
> 234
> 235     	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>>      CID 646010:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 236     	ut_asserteq(-EINVAL, ret);
> 237
> 238     	return 0;
> 239     }
> 240
> 241     DM_TEST(dm_test_phy_common_props_tx_more_names, UTF_SCAN_FDT);
>
> ** CID 646009:         (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 253           in
> dm_test_phy_common_props_tx_find_by_name()
> /test/dm/phy_common_props.c: 257           in
> dm_test_phy_common_props_tx_find_by_name()
> /test/dm/phy_common_props.c: 261           in
> dm_test_phy_common_props_tx_find_by_name()
>
>
> _____________________________________________________________________________________________
> *** CID 646009:           (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 253             in
> dm_test_phy_common_props_tx_find_by_name()
> 247     	unsigned int val;
> 248     	int ret;
> 249
> 250     	ut_assert(ofnode_valid(node));
> 251
> 252     	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>>      CID 646009:           (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 253     	ut_asserteq(0, ret);
> 254     	ut_asserteq(PHY_POL_NORMAL, val);
> 255
> 256     	ret = phy_get_manual_tx_polarity(node, "2500base-x", &val);
> 257     	ut_asserteq(0, ret);
> 258     	ut_asserteq(PHY_POL_INVERT, val);
> /test/dm/phy_common_props.c: 257             in
> dm_test_phy_common_props_tx_find_by_name()
> 251
> 252     	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
> 253     	ut_asserteq(0, ret);
> 254     	ut_asserteq(PHY_POL_NORMAL, val);
> 255
> 256     	ret = phy_get_manual_tx_polarity(node, "2500base-x", &val);
>>>>      CID 646009:           (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 257     	ut_asserteq(0, ret);
> 258     	ut_asserteq(PHY_POL_INVERT, val);
> 259
> 260     	ret = phy_get_manual_tx_polarity(node, "1000base-x", &val);
> 261     	ut_asserteq(0, ret);
> 262     	ut_asserteq(PHY_POL_NORMAL, val);
> /test/dm/phy_common_props.c: 261             in
> dm_test_phy_common_props_tx_find_by_name()
> 255
> 256     	ret = phy_get_manual_tx_polarity(node, "2500base-x", &val);
> 257     	ut_asserteq(0, ret);
> 258     	ut_asserteq(PHY_POL_INVERT, val);
> 259
> 260     	ret = phy_get_manual_tx_polarity(node, "1000base-x", &val);
>>>>      CID 646009:           (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 261     	ut_asserteq(0, ret);
> 262     	ut_asserteq(PHY_POL_NORMAL, val);
> 263
> 264     	return 0;
> 265     }
> 266
>
> ** CID 646008:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 31           in
> dm_test_phy_common_props_rx_missing()
>
>
> _____________________________________________________________________________________________
> *** CID 646008:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 31             in
> dm_test_phy_common_props_rx_missing()
> 25     	unsigned int val;
> 26     	int ret;
> 27
> 28     	ut_assert(ofnode_valid(node));
> 29
> 30     	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>>      CID 646008:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 31     	ut_asserteq(0, ret);
> 32     	ut_asserteq(PHY_POL_NORMAL, val);
> 33
> 34     	return 0;
> 35     }
> 36
>
> ** CID 646007:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 296           in
> dm_test_phy_common_props_tx_with_default()
>
>
> _____________________________________________________________________________________________
> *** CID 646007:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 296             in
> dm_test_phy_common_props_tx_with_default()
> 290     	unsigned int val;
> 291     	int ret;
> 292
> 293     	ut_assert(ofnode_valid(node));
> 294
> 295     	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>>      CID 646007:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 296     	ut_asserteq(0, ret);
> 297     	ut_asserteq(PHY_POL_INVERT, val);
> 298
> 299     	return 0;
> 300     }
> 301
>
> ** CID 646006:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 314           in
> dm_test_phy_common_props_tx_unsupported()
>
>
> _____________________________________________________________________________________________
> *** CID 646006:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 314             in
> dm_test_phy_common_props_tx_unsupported()
> 308     	unsigned int val;
> 309     	int ret;
> 310
> 311     	ut_assert(ofnode_valid(node));
> 312
> 313     	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>>      CID 646006:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 314     	ut_asserteq(-EOPNOTSUPP, ret);
> 315
> 316     	return 0;
> 317     }
> 318
>
> ** CID 646005:         (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 111           in
> dm_test_phy_common_props_rx_find_by_name()
> /test/dm/phy_common_props.c: 105           in
> dm_test_phy_common_props_rx_find_by_name()
> /test/dm/phy_common_props.c: 101           in
> dm_test_phy_common_props_rx_find_by_name()
>
>
> _____________________________________________________________________________________________
> *** CID 646005:           (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 111             in
> dm_test_phy_common_props_rx_find_by_name()
> 105     	ut_asserteq(0, ret);
> 106     	ut_asserteq(PHY_POL_INVERT, val);
> 107
> 108     	/* "usb-ss" has PHY_POL_AUTO; auto is supported here */
> 109     	ret = phy_get_rx_polarity(node, "usb-ss", BIT(PHY_POL_AUTO),
> 110     				  PHY_POL_AUTO, &val);
>>>>      CID 646005:           (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 111     	ut_asserteq(0, ret);
> 112     	ut_asserteq(PHY_POL_AUTO, val);
> 113
> 114     	return 0;
> 115     }
> 116
> /test/dm/phy_common_props.c: 105             in
> dm_test_phy_common_props_rx_find_by_name()
> 99
> 100     	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
> 101     	ut_asserteq(0, ret);
> 102     	ut_asserteq(PHY_POL_NORMAL, val);
> 103
> 104     	ret = phy_get_manual_rx_polarity(node, "2500base-x", &val);
>>>>      CID 646005:           (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 105     	ut_asserteq(0, ret);
> 106     	ut_asserteq(PHY_POL_INVERT, val);
> 107
> 108     	/* "usb-ss" has PHY_POL_AUTO; auto is supported here */
> 109     	ret = phy_get_rx_polarity(node, "usb-ss", BIT(PHY_POL_AUTO),
> 110     				  PHY_POL_AUTO, &val);
> /test/dm/phy_common_props.c: 101             in
> dm_test_phy_common_props_rx_find_by_name()
> 95     	unsigned int val;
> 96     	int ret;
> 97
> 98     	ut_assert(ofnode_valid(node));
> 99
> 100     	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>>      CID 646005:           (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 101     	ut_asserteq(0, ret);
> 102     	ut_asserteq(PHY_POL_NORMAL, val);
> 103
> 104     	ret = phy_get_manual_rx_polarity(node, "2500base-x", &val);
> 105     	ut_asserteq(0, ret);
> 106     	ut_asserteq(PHY_POL_INVERT, val);
>
> ** CID 646004:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 183           in
> dm_test_phy_common_props_tx_missing()
>
>
> _____________________________________________________________________________________________
> *** CID 646004:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 183             in
> dm_test_phy_common_props_tx_missing()
> 177     	unsigned int val;
> 178     	int ret;
> 179
> 180     	ut_assert(ofnode_valid(node));
> 181
> 182     	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>>      CID 646004:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 183     	ut_asserteq(0, ret);
> 184     	ut_asserteq(PHY_POL_NORMAL, val);
> 185
> 186     	return 0;
> 187     }
> 188
>
> ** CID 646003:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 49           in
> dm_test_phy_common_props_rx_more_values()
>
>
> _____________________________________________________________________________________________
> *** CID 646003:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 49             in
> dm_test_phy_common_props_rx_more_values()
> 43     	unsigned int val;
> 44     	int ret;
> 45
> 46     	ut_assert(ofnode_valid(node));
> 47
> 48     	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>>      CID 646003:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 49     	ut_asserteq(-EINVAL, ret);
> 50
> 51     	return 0;
> 52     }
> 53
> 54     DM_TEST(dm_test_phy_common_props_rx_more_values, UTF_SCAN_FDT);
>
> ** CID 646002:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 146           in
> dm_test_phy_common_props_rx_with_default()
>
>
> _____________________________________________________________________________________________
> *** CID 646002:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 146             in
> dm_test_phy_common_props_rx_with_default()
> 140     	unsigned int val;
> 141     	int ret;
> 142
> 143     	ut_assert(ofnode_valid(node));
> 144
> 145     	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>>      CID 646002:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 146     	ut_asserteq(0, ret);
> 147     	ut_asserteq(PHY_POL_INVERT, val);
> 148
> 149     	return 0;
> 150     }
> 151
>
> ** CID 646001:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 66           in
> dm_test_phy_common_props_rx_single_value()
>
>
> _____________________________________________________________________________________________
> *** CID 646001:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 66             in
> dm_test_phy_common_props_rx_single_value()
> 60     	unsigned int val;
> 61     	int ret;
> 62
> 63     	ut_assert(ofnode_valid(node));
> 64
> 65     	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>>      CID 646001:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 66     	ut_asserteq(0, ret);
> 67     	ut_asserteq(PHY_POL_INVERT, val);
> 68
> 69     	return 0;
> 70     }
> 71
>
> ** CID 646000:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 129           in
> dm_test_phy_common_props_rx_no_default()
>
>
> _____________________________________________________________________________________________
> *** CID 646000:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 129             in
> dm_test_phy_common_props_rx_no_default()
> 123     	unsigned int val;
> 124     	int ret;
> 125
> 126     	ut_assert(ofnode_valid(node));
> 127
> 128     	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>>      CID 646000:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 129     	ut_asserteq(-EINVAL, ret);
> 130
> 131     	return 0;
> 132     }
> 133
> 134     DM_TEST(dm_test_phy_common_props_rx_no_default, UTF_SCAN_FDT);
>
> ** CID 645999:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 84           in
> dm_test_phy_common_props_rx_more_names()
>
>
> _____________________________________________________________________________________________
> *** CID 645999:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 84             in
> dm_test_phy_common_props_rx_more_names()
> 78     	unsigned int val;
> 79     	int ret;
> 80
> 81     	ut_assert(ofnode_valid(node));
> 82
> 83     	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>>      CID 645999:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 84     	ut_asserteq(-EINVAL, ret);
> 85
> 86     	return 0;
> 87     }
> 88
> 89     DM_TEST(dm_test_phy_common_props_rx_more_names, UTF_SCAN_FDT);
>
> ** CID 645998:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 218           in
> dm_test_phy_common_props_tx_single_value()
>
>
> _____________________________________________________________________________________________
> *** CID 645998:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 218             in
> dm_test_phy_common_props_tx_single_value()
> 212     	unsigned int val;
> 213     	int ret;
> 214
> 215     	ut_assert(ofnode_valid(node));
> 216
> 217     	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>>      CID 645998:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 218     	ut_asserteq(0, ret);
> 219     	ut_asserteq(PHY_POL_INVERT, val);
> 220
> 221     	return 0;
> 222     }
> 223
>
> ** CID 646014:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 201           in
> dm_test_phy_common_props_tx_more_values()
>
>
> _____________________________________________________________________________________________
> *** CID 646014:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 201             in
> dm_test_phy_common_props_tx_more_values()
> 195     	unsigned int val;
> 196     	int ret;
> 197
> 198     	ut_assert(ofnode_valid(node));
> 199
> 200     	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>>      CID 646014:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 201     	ut_asserteq(-EINVAL, ret);
> 202
> 203     	return 0;
> 204     }
> 205
> 206     DM_TEST(dm_test_phy_common_props_tx_more_values, UTF_SCAN_FDT);
>
> ** CID 646013:       Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 279           in
> dm_test_phy_common_props_tx_no_default()
>
>
> _____________________________________________________________________________________________
> *** CID 646013:         Integer handling issues  (INTEGER_OVERFLOW)
> /test/dm/phy_common_props.c: 279             in
> dm_test_phy_common_props_tx_no_default()
> 273     	unsigned int val;
> 274     	int ret;
> 275
> 276     	ut_assert(ofnode_valid(node));
> 277
> 278     	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>>      CID 646013:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "_val2", where "ret" is known to be equal to -95, overflows the type of "_val2", which is type "unsigned int".
> 279     	ut_asserteq(-EINVAL, ret);
> 280
> 281     	return 0;
> 282     }
> 283
> 284     DM_TEST(dm_test_phy_common_props_tx_no_default, UTF_SCAN_FDT);
>
> ** CID 646012:         (TAINTED_SCALAR)
> /drivers/phy/phy-common-props.c: 156           in ofnode_get_u32_prop_for_name()
>
>
> _____________________________________________________________________________________________
> *** CID 646012:           (TAINTED_SCALAR)
> /drivers/phy/phy-common-props.c: 156             in
> ofnode_get_u32_prop_for_name()
> 150     	props = calloc(n_props, sizeof(*props));
> 151     	if (!props)
> 152     		return -ENOMEM;
> 153
> 154     	err = ofnode_read_u32_array(node, props_title, props, n_props);
> 155     	if (err >= 0) {
>>>>      CID 646012:           (TAINTED_SCALAR)
>>>>      Using tainted variable "idx" as an index to pointer "props".
> 156     		*val = props[idx];
> 157     		pr_debug("%s: resolved value %u at index %d for name '%s'
> from '%s'\n",
> 158     			 __func__, *val, idx, name, props_title);
> 159     	} else {
> 160     		pr_debug("%s: failed to read u32 array '%s' (err=%d)\n",
> 161     			 __func__, props_title, err);
> /drivers/phy/phy-common-props.c: 164             in
> ofnode_get_u32_prop_for_name()
> 158     			 __func__, *val, idx, name, props_title);
> 159     	} else {
> 160     		pr_debug("%s: failed to read u32 array '%s' (err=%d)\n",
> 161     			 __func__, props_title, err);
> 162     	}
> 163
>>>>      CID 646012:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "*props" to "dlfree", which uses it as an offset.
> 164     	free(props);
> 165
> 166     	return err;
> 167     }
> 168
> 169     /**
>
>
>
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=overview>
>
> Best regards,
>
> The Coverity Scan Admin Team
>
> ----- End forwarded message -----
>
