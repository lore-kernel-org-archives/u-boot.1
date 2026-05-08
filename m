Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3908DCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 23:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A181384CE4;
	Sat,  9 May 2026 01:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eYo6NUlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5434584DF8; Sat,  9 May 2026 01:42:40 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9997D84CBB
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 01:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7dcdaf06498so1898603a34.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 16:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778283755; x=1778888555; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZN1IzPwunZIe+NyjNfjH/koKaqyTeLl0u4ZBqhH92cQ=;
 b=eYo6NUlWQ9u0srM/GZNq2L7jTyrjdMLN46q9VR7HCs8msQEelFwuAJrO1a6jtdfopx
 xvqG3k6Z+0kzzmZHBMi8MWMfts82ITCfjine7NrSAsORZDqg3nPPLOcXEoee/28KKnaj
 NACfIvAQWORmONN//QhQWhoS1oc0nB1qnS2Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778283755; x=1778888555;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZN1IzPwunZIe+NyjNfjH/koKaqyTeLl0u4ZBqhH92cQ=;
 b=sU6vrwCF9ugOM9VvPEjGYXB7sM6mkpcF8vfHL80KW3IlF/4/UWJ18hwoikhsO/5kJW
 oLmSuDWHD2WyvCEsQZFhv5+NS/ywXeki1CoTnALGKwYWoykM8FlUTMgsQMQJ7bfLofIZ
 kQ55efl0DMd7e4EopfFwqdpfBn9TrldEQ2rrSs6NZnRBoZY1/K+E6JgCEs4Y7EjQH7L0
 4gFQbTmsavW0ySM0eeX3uLm1n60hcaFBWmMz310k0b7/Io8JsZfuNC0/NuYGvD08OeBa
 rlS5jGb/V4PKObSKoS8DGUIQO4f3w+ulQ+5KK+8NvEnv1p3F31YOrzskoHLRjgpKjTRw
 m4Ew==
X-Gm-Message-State: AOJu0Yyw07SiiyNz6SCccEkIxuMC605I3iUIBUn+Cmz+g/AiWmpprFz1
 PPmeyeIuNRRVBz+pZPYaNe46yNt9n+6aFwCk3Ya/poPIk0D9QDJhktmcMOt5gY4SK7PNClRe7+C
 k93XPu9ZGw2/2BUI=
X-Gm-Gg: AeBDiesCVrj6GNI4Hd3oZugt6Cw7YmadivRV/6MaKeMm6wJ5/036R5J+ww6Eryk49H1
 4T9RuUYnaJ9cP0YIfMeBYot0jyshVe5M4QQP0p+egLjHcb4H0BGxHBU1YcxEj68DsESU/IRB902
 CesYQjuPaktEeWh0SrH5vPyoKg1XQ6sbKP8a+LWEiXQZjYqJDzccqqwQYpBvCeoCoHng8YRxNmK
 2OzhF0otaKuNPLpUrVhmCMWbwl6hdgEq9MqLt9QJp/469MYNp/rm0+fX8YsZoCFhfw+wJ0VAQPE
 7AdzHs8tTIGKu16iT79HfGUGKihMCcjjmMCgneQOnBetvXSg9sQfO3XgohPzUHFkxGzVn69bZyS
 KezF/OQP9lWojjkJy6a3kCJUQ2iQ0bmQ8t0DwYGynvZWBdUQBAb0Rk5+Pjfgbj0Iek7irpl2eKb
 V2oBmo8qU+dHhQ4ULkZRmzrY30e2idJoomHLIs/CTQ+nIyspmSMm1EoEoEunLFKbnptvjECieSM
 WPXIZj6Zh8jnYQMSDNf15llI3qYO+Xp2wDx0angEgZZ/oVhJ/wh4E8/ikCY+w==
X-Received: by 2002:a05:6820:4cc4:b0:694:6e61:8de0 with SMTP id
 006d021491bc7-69998d17b75mr3949358eaf.30.1778283755214; 
 Fri, 08 May 2026 16:42:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25c9a23fsm1813735eaf.7.2026.05.08.16.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 16:42:34 -0700 (PDT)
Date: Fri, 8 May 2026 17:42:31 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20260508234231.GF1858239@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DigdrTmORQw5dwWa"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
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


--DigdrTmORQw5dwWa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report. I think test code matters because it sets bad
examples, or might not really end up testing things the way we want them
to, and so should be fixed. Thanks!

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Fri, May 8, 2026 at 5:31=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 17
   - 3 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 17 of 17 defect(s)

Defect Details

** CID 646011:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 164           in
dm_test_phy_common_props_rx_unsupported()


___________________________________________________________________________=
__________________
*** CID 646011:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 164             in
dm_test_phy_common_props_rx_unsupported()
158     	unsigned int val;
159     	int ret;
160
161     	ut_assert(ofnode_valid(node));
162
163     	ret =3D phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>     CID 646011:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
164     	ut_asserteq(-EOPNOTSUPP, ret);
165
166     	return 0;
167     }
168
169     DM_TEST(dm_test_phy_common_props_rx_unsupported, UTF_SCAN_FDT);

** CID 646010:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 236           in
dm_test_phy_common_props_tx_more_names()


___________________________________________________________________________=
__________________
*** CID 646010:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 236             in
dm_test_phy_common_props_tx_more_names()
230     	unsigned int val;
231     	int ret;
232
233     	ut_assert(ofnode_valid(node));
234
235     	ret =3D phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>     CID 646010:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
236     	ut_asserteq(-EINVAL, ret);
237
238     	return 0;
239     }
240
241     DM_TEST(dm_test_phy_common_props_tx_more_names, UTF_SCAN_FDT);

** CID 646009:         (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 253           in
dm_test_phy_common_props_tx_find_by_name()
/test/dm/phy_common_props.c: 257           in
dm_test_phy_common_props_tx_find_by_name()
/test/dm/phy_common_props.c: 261           in
dm_test_phy_common_props_tx_find_by_name()


___________________________________________________________________________=
__________________
*** CID 646009:           (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 253             in
dm_test_phy_common_props_tx_find_by_name()
247     	unsigned int val;
248     	int ret;
249
250     	ut_assert(ofnode_valid(node));
251
252     	ret =3D phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>     CID 646009:           (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
253     	ut_asserteq(0, ret);
254     	ut_asserteq(PHY_POL_NORMAL, val);
255
256     	ret =3D phy_get_manual_tx_polarity(node, "2500base-x", &val);
257     	ut_asserteq(0, ret);
258     	ut_asserteq(PHY_POL_INVERT, val);
/test/dm/phy_common_props.c: 257             in
dm_test_phy_common_props_tx_find_by_name()
251
252     	ret =3D phy_get_manual_tx_polarity(node, "sgmii", &val);
253     	ut_asserteq(0, ret);
254     	ut_asserteq(PHY_POL_NORMAL, val);
255
256     	ret =3D phy_get_manual_tx_polarity(node, "2500base-x", &val);
>>>     CID 646009:           (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
257     	ut_asserteq(0, ret);
258     	ut_asserteq(PHY_POL_INVERT, val);
259
260     	ret =3D phy_get_manual_tx_polarity(node, "1000base-x", &val);
261     	ut_asserteq(0, ret);
262     	ut_asserteq(PHY_POL_NORMAL, val);
/test/dm/phy_common_props.c: 261             in
dm_test_phy_common_props_tx_find_by_name()
255
256     	ret =3D phy_get_manual_tx_polarity(node, "2500base-x", &val);
257     	ut_asserteq(0, ret);
258     	ut_asserteq(PHY_POL_INVERT, val);
259
260     	ret =3D phy_get_manual_tx_polarity(node, "1000base-x", &val);
>>>     CID 646009:           (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
261     	ut_asserteq(0, ret);
262     	ut_asserteq(PHY_POL_NORMAL, val);
263
264     	return 0;
265     }
266

** CID 646008:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 31           in
dm_test_phy_common_props_rx_missing()


___________________________________________________________________________=
__________________
*** CID 646008:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 31             in
dm_test_phy_common_props_rx_missing()
25     	unsigned int val;
26     	int ret;
27
28     	ut_assert(ofnode_valid(node));
29
30     	ret =3D phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>     CID 646008:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
31     	ut_asserteq(0, ret);
32     	ut_asserteq(PHY_POL_NORMAL, val);
33
34     	return 0;
35     }
36

** CID 646007:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 296           in
dm_test_phy_common_props_tx_with_default()


___________________________________________________________________________=
__________________
*** CID 646007:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 296             in
dm_test_phy_common_props_tx_with_default()
290     	unsigned int val;
291     	int ret;
292
293     	ut_assert(ofnode_valid(node));
294
295     	ret =3D phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>     CID 646007:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
296     	ut_asserteq(0, ret);
297     	ut_asserteq(PHY_POL_INVERT, val);
298
299     	return 0;
300     }
301

** CID 646006:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 314           in
dm_test_phy_common_props_tx_unsupported()


___________________________________________________________________________=
__________________
*** CID 646006:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 314             in
dm_test_phy_common_props_tx_unsupported()
308     	unsigned int val;
309     	int ret;
310
311     	ut_assert(ofnode_valid(node));
312
313     	ret =3D phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>     CID 646006:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
314     	ut_asserteq(-EOPNOTSUPP, ret);
315
316     	return 0;
317     }
318

** CID 646005:         (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 111           in
dm_test_phy_common_props_rx_find_by_name()
/test/dm/phy_common_props.c: 105           in
dm_test_phy_common_props_rx_find_by_name()
/test/dm/phy_common_props.c: 101           in
dm_test_phy_common_props_rx_find_by_name()


___________________________________________________________________________=
__________________
*** CID 646005:           (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 111             in
dm_test_phy_common_props_rx_find_by_name()
105     	ut_asserteq(0, ret);
106     	ut_asserteq(PHY_POL_INVERT, val);
107
108     	/* "usb-ss" has PHY_POL_AUTO; auto is supported here */
109     	ret =3D phy_get_rx_polarity(node, "usb-ss", BIT(PHY_POL_AUTO),
110     				  PHY_POL_AUTO, &val);
>>>     CID 646005:           (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
111     	ut_asserteq(0, ret);
112     	ut_asserteq(PHY_POL_AUTO, val);
113
114     	return 0;
115     }
116
/test/dm/phy_common_props.c: 105             in
dm_test_phy_common_props_rx_find_by_name()
99
100     	ret =3D phy_get_manual_rx_polarity(node, "sgmii", &val);
101     	ut_asserteq(0, ret);
102     	ut_asserteq(PHY_POL_NORMAL, val);
103
104     	ret =3D phy_get_manual_rx_polarity(node, "2500base-x", &val);
>>>     CID 646005:           (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
105     	ut_asserteq(0, ret);
106     	ut_asserteq(PHY_POL_INVERT, val);
107
108     	/* "usb-ss" has PHY_POL_AUTO; auto is supported here */
109     	ret =3D phy_get_rx_polarity(node, "usb-ss", BIT(PHY_POL_AUTO),
110     				  PHY_POL_AUTO, &val);
/test/dm/phy_common_props.c: 101             in
dm_test_phy_common_props_rx_find_by_name()
95     	unsigned int val;
96     	int ret;
97
98     	ut_assert(ofnode_valid(node));
99
100     	ret =3D phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>     CID 646005:           (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
101     	ut_asserteq(0, ret);
102     	ut_asserteq(PHY_POL_NORMAL, val);
103
104     	ret =3D phy_get_manual_rx_polarity(node, "2500base-x", &val);
105     	ut_asserteq(0, ret);
106     	ut_asserteq(PHY_POL_INVERT, val);

** CID 646004:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 183           in
dm_test_phy_common_props_tx_missing()


___________________________________________________________________________=
__________________
*** CID 646004:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 183             in
dm_test_phy_common_props_tx_missing()
177     	unsigned int val;
178     	int ret;
179
180     	ut_assert(ofnode_valid(node));
181
182     	ret =3D phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>     CID 646004:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
183     	ut_asserteq(0, ret);
184     	ut_asserteq(PHY_POL_NORMAL, val);
185
186     	return 0;
187     }
188

** CID 646003:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 49           in
dm_test_phy_common_props_rx_more_values()


___________________________________________________________________________=
__________________
*** CID 646003:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 49             in
dm_test_phy_common_props_rx_more_values()
43     	unsigned int val;
44     	int ret;
45
46     	ut_assert(ofnode_valid(node));
47
48     	ret =3D phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>     CID 646003:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
49     	ut_asserteq(-EINVAL, ret);
50
51     	return 0;
52     }
53
54     DM_TEST(dm_test_phy_common_props_rx_more_values, UTF_SCAN_FDT);

** CID 646002:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 146           in
dm_test_phy_common_props_rx_with_default()


___________________________________________________________________________=
__________________
*** CID 646002:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 146             in
dm_test_phy_common_props_rx_with_default()
140     	unsigned int val;
141     	int ret;
142
143     	ut_assert(ofnode_valid(node));
144
145     	ret =3D phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>     CID 646002:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
146     	ut_asserteq(0, ret);
147     	ut_asserteq(PHY_POL_INVERT, val);
148
149     	return 0;
150     }
151

** CID 646001:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 66           in
dm_test_phy_common_props_rx_single_value()


___________________________________________________________________________=
__________________
*** CID 646001:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 66             in
dm_test_phy_common_props_rx_single_value()
60     	unsigned int val;
61     	int ret;
62
63     	ut_assert(ofnode_valid(node));
64
65     	ret =3D phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>     CID 646001:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
66     	ut_asserteq(0, ret);
67     	ut_asserteq(PHY_POL_INVERT, val);
68
69     	return 0;
70     }
71

** CID 646000:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 129           in
dm_test_phy_common_props_rx_no_default()


___________________________________________________________________________=
__________________
*** CID 646000:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 129             in
dm_test_phy_common_props_rx_no_default()
123     	unsigned int val;
124     	int ret;
125
126     	ut_assert(ofnode_valid(node));
127
128     	ret =3D phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>     CID 646000:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
129     	ut_asserteq(-EINVAL, ret);
130
131     	return 0;
132     }
133
134     DM_TEST(dm_test_phy_common_props_rx_no_default, UTF_SCAN_FDT);

** CID 645999:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 84           in
dm_test_phy_common_props_rx_more_names()


___________________________________________________________________________=
__________________
*** CID 645999:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 84             in
dm_test_phy_common_props_rx_more_names()
78     	unsigned int val;
79     	int ret;
80
81     	ut_assert(ofnode_valid(node));
82
83     	ret =3D phy_get_manual_rx_polarity(node, "sgmii", &val);
>>>     CID 645999:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
84     	ut_asserteq(-EINVAL, ret);
85
86     	return 0;
87     }
88
89     DM_TEST(dm_test_phy_common_props_rx_more_names, UTF_SCAN_FDT);

** CID 645998:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 218           in
dm_test_phy_common_props_tx_single_value()


___________________________________________________________________________=
__________________
*** CID 645998:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 218             in
dm_test_phy_common_props_tx_single_value()
212     	unsigned int val;
213     	int ret;
214
215     	ut_assert(ofnode_valid(node));
216
217     	ret =3D phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>     CID 645998:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
218     	ut_asserteq(0, ret);
219     	ut_asserteq(PHY_POL_INVERT, val);
220
221     	return 0;
222     }
223

** CID 646014:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 201           in
dm_test_phy_common_props_tx_more_values()


___________________________________________________________________________=
__________________
*** CID 646014:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 201             in
dm_test_phy_common_props_tx_more_values()
195     	unsigned int val;
196     	int ret;
197
198     	ut_assert(ofnode_valid(node));
199
200     	ret =3D phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>     CID 646014:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
201     	ut_asserteq(-EINVAL, ret);
202
203     	return 0;
204     }
205
206     DM_TEST(dm_test_phy_common_props_tx_more_values, UTF_SCAN_FDT);

** CID 646013:       Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 279           in
dm_test_phy_common_props_tx_no_default()


___________________________________________________________________________=
__________________
*** CID 646013:         Integer handling issues  (INTEGER_OVERFLOW)
/test/dm/phy_common_props.c: 279             in
dm_test_phy_common_props_tx_no_default()
273     	unsigned int val;
274     	int ret;
275
276     	ut_assert(ofnode_valid(node));
277
278     	ret =3D phy_get_manual_tx_polarity(node, "sgmii", &val);
>>>     CID 646013:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "_val2", where "ret" is known to be equal to -95, overfl=
ows the type of "_val2", which is type "unsigned int".
279     	ut_asserteq(-EINVAL, ret);
280
281     	return 0;
282     }
283
284     DM_TEST(dm_test_phy_common_props_tx_no_default, UTF_SCAN_FDT);

** CID 646012:         (TAINTED_SCALAR)
/drivers/phy/phy-common-props.c: 156           in ofnode_get_u32_prop_for_n=
ame()


___________________________________________________________________________=
__________________
*** CID 646012:           (TAINTED_SCALAR)
/drivers/phy/phy-common-props.c: 156             in
ofnode_get_u32_prop_for_name()
150     	props =3D calloc(n_props, sizeof(*props));
151     	if (!props)
152     		return -ENOMEM;
153
154     	err =3D ofnode_read_u32_array(node, props_title, props, n_props);
155     	if (err >=3D 0) {
>>>     CID 646012:           (TAINTED_SCALAR)
>>>     Using tainted variable "idx" as an index to pointer "props".
156     		*val =3D props[idx];
157     		pr_debug("%s: resolved value %u at index %d for name '%s'
=66rom '%s'\n",
158     			 __func__, *val, idx, name, props_title);
159     	} else {
160     		pr_debug("%s: failed to read u32 array '%s' (err=3D%d)\n",
161     			 __func__, props_title, err);
/drivers/phy/phy-common-props.c: 164             in
ofnode_get_u32_prop_for_name()
158     			 __func__, *val, idx, name, props_title);
159     	} else {
160     		pr_debug("%s: failed to read u32 array '%s' (err=3D%d)\n",
161     			 __func__, props_title, err);
162     	}
163
>>>     CID 646012:           (TAINTED_SCALAR)
>>>     Passing tainted expression "*props" to "dlfree", which uses it as a=
n offset.
164     	free(props);
165
166     	return err;
167     }
168
169     /**



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--DigdrTmORQw5dwWa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaf505AAKCRAr4qD1Cr/k
CuXSAQCuxKjX5Z068U2HSargLrxJBcbm1k5y1jCsm4RHrLUMbwD/Ugf/WbzN0VmL
Ps887BX0cnnGenRzDIOlYbbDR6acXgY=
=8nvz
-----END PGP SIGNATURE-----

--DigdrTmORQw5dwWa--
