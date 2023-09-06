Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7300EB8FA6
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 02:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BEB286940;
	Wed,  6 Sep 2023 04:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="euMcd/OM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C3AC8659F; Wed,  6 Sep 2023 03:34:21 +0200 (CEST)
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com
 [162.62.57.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4134486590
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 03:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rtoax@foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1693964047;
 bh=qXc6X7ghLyICEps3/k7kq3by/1gr2rR1azV6azEYTxw=;
 h=In-Reply-To:References:From:To:Cc:Subject:Date;
 b=euMcd/OMNzAu6CZ1cn8V8l1mX+0F9HipKk7i9c1t1MyFLyZeHkMMfst4O1M9lGGLo
 6F+Voqy3uTyvQqYqb0cSHNVPISHa0Uyvsneyw3a3Tx/t1Sw8xEwUotiRO1+rHUh8QE
 leTUvGwg6izVpiYqROacccTFJrBse1EHIltNolnA=
X-QQ-FEAT: oHWrrGTW1dDcx9FDKRrPeMctvggFgZ/w
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-XMAILINFO: MNsLylogNlqch7ZA1JE6Zg3aV0nRjRYZdNgpVQYXWjMuPVt9DEkVn/lIk9Puq1
 xxkI6kFmNVVwfUy1PefblTAGQ8zNqoHWW2MgiHaIZz3lT2AAdCMPP4X1AbErMRjAHXeXNcqjE7xCE
 TtWuizdjGIwEIf2K3PXSyt21pLYUa3fMAbptUieRSWt+zaQF7vXV1qpL1NojrYTi3J2+dsT9r7e8y
 l19NmxVRfruplyAI+K7CrKzRjZcPKF8QeZCSeU9cKT0WRGAJ8SiJTan2hhBqQlYPwkYDUw/MwU6sB
 YGThU3RdVFYcVI8Y4MTdnLfZJvwqil97uzO6ZE4IT66X4R5x0voJKCqJYGXYbkZja2GF+zrRDTxIB
 6FoVGgn8fZWPQyiLnzvPi8L35124rJLth8eivaZMuL73JWLEn4XbWnCpk6I4NZclf1nsPbsSex3nb
 gHWtNxaMNG/G2e9kiMoWAcV6VKSi+/5fHylVBrkEzqrkJalxkQHDPK7WN/Y/bNfRYXw3rMp0oGt7I
 0M14L7o09dMQBR9/iRjiJ0GUjhRM48q7zovVCGlLijcsRRMD6l9/2UIwN0WJ1F/Ffdx7EYO5CnoJc
 xDd9tptINWwg31rLKiZUD7TJv6ih/w6rHxC/SV1UparKuWns0Oc3l5ciYaBIV+qDS28nWMvGX9WYg
 8+lyqMwsXqLhTkmjY6b21KY9J5721LPrGvZOVoySB9KMyC6tottiNgUac6hb+tDK2cQrSFoa8NU2Y
 93g0Mm3VJPEU91oOOReoSCywvPaVcfvKOI62MNkX2pu3ePuj9MiXw9g31buMLXhrpRFg8l63Lm4vp
 jiHHtCcx9WgewpwhIwk/sy8sBub69xEXs6VgerSL4MHt/ARUsxTnftnAeL5CJvWORbMrIqzZmCCxc
 PHTNKhO+SPZW9t2nm7hOuR8Uf/biqdXXHv9SAzj272xr/Up5iKXUN5++OOKL4/7p8vJwLCWAGayrA
 6FPZ8VYg==
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 39.156.37.17
In-Reply-To: <CAPnjgZ1fWjL_qy+W4ygOvA2dDjK2v15zTJFkeNdqSSCDq8FuWQ@mail.gmail.com>
References: <tencent_A957A85155C40E033B2189AC8CCB3995F607@qq.com>
 <CAPnjgZ1fWjL_qy+W4ygOvA2dDjK2v15zTJFkeNdqSSCDq8FuWQ@mail.gmail.com>
X-QQ-STYLE: 
X-QQ-mid: webmail872t1693964046t7966883
From: "=?gb18030?B?yNnMzg==?=" <rtoax@foxmail.com>
To: "=?gb18030?B?U2ltb24gR2xhc3M=?=" <sjg@chromium.org>
Cc: "=?gb18030?B?QWxwZXIgTmViaSBZYXNhaw==?=" <alpernebiyasak@gmail.com>,
 "=?gb18030?B?SXZhbiBNaWtoYXlsb3Y=?=" <fr0st61te@gmail.com>,
 "=?gb18030?B?Sm9uYXMgS2FybG1hbg==?=" <jonas@kwiboo.se>,
 "=?gb18030?B?b3BlbiBsaXN0?=" <u-boot@lists.denx.de>,
 "=?gb18030?B?Um9uZyBUYW8=?=" <rongtao@cestc.cn>
Subject: Re: [PATCH v2] binman: Fix SyntaxWarning: invalid escape sequence '\('
Mime-Version: 1.0
Date: Wed, 6 Sep 2023 09:34:06 +0800
X-Priority: 3
Message-ID: <tencent_BA46C710370DF285E4B2EA2E35553A5FF909@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-Mailman-Approved-At: Wed, 06 Sep 2023 04:56:11 +0200
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64
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

VGhhbmtzLCBTaW1vbg0KDQoNClRoZSBmb2xsb3dpbmcgbGluZXMgaXMgbXkgc3lzdGVtZSBF
TlYgYW5kIG1ha2UgbG9nDQoNCg0KJCBjYXQgL2V0Yy9vcy1yZWxlYXNlJm5ic3A7DQpOQU1F
PSJGZWRvcmEgTGludXgiDQpWRVJTSU9OPSI0MCAoV29ya3N0YXRpb24gRWRpdGlvbiBQcmVy
ZWxlYXNlKSINCklEPWZlZG9yYQ0KVkVSU0lPTl9JRD00MA0KVkVSU0lPTl9DT0RFTkFNRT0i
Ig0KUExBVEZPUk1fSUQ9InBsYXRmb3JtOmY0MCINClBSRVRUWV9OQU1FPSJGZWRvcmEgTGlu
dXggNDAgKFdvcmtzdGF0aW9uIEVkaXRpb24gUHJlcmVsZWFzZSkiDQpBTlNJX0NPTE9SPSIw
OzM4OzI7NjA7MTEwOzE4MCINCkxPR089ZmVkb3JhLWxvZ28taWNvbg0KQ1BFX05BTUU9ImNw
ZTovbzpmZWRvcmFwcm9qZWN0OmZlZG9yYTo0MCINCkRFRkFVTFRfSE9TVE5BTUU9ImZlZG9y
YSINCkhPTUVfVVJMPSJodHRwczovL2ZlZG9yYXByb2plY3Qub3JnLyINCkRPQ1VNRU5UQVRJ
T05fVVJMPSJodHRwczovL2RvY3MuZmVkb3JhcHJvamVjdC5vcmcvZW4tVVMvZmVkb3JhL3Jh
d2hpZGUvc3lzdGVtLWFkbWluaXN0cmF0b3JzLWd1aWRlLyINClNVUFBPUlRfVVJMPSJodHRw
czovL2Fzay5mZWRvcmFwcm9qZWN0Lm9yZy8iDQpCVUdfUkVQT1JUX1VSTD0iaHR0cHM6Ly9i
dWd6aWxsYS5yZWRoYXQuY29tLyINClJFREhBVF9CVUdaSUxMQV9QUk9EVUNUPSJGZWRvcmEi
DQpSRURIQVRfQlVHWklMTEFfUFJPRFVDVF9WRVJTSU9OPXJhd2hpZGUNClJFREhBVF9TVVBQ
T1JUX1BST0RVQ1Q9IkZlZG9yYSINClJFREhBVF9TVVBQT1JUX1BST0RVQ1RfVkVSU0lPTj1y
YXdoaWRlDQpTVVBQT1JUX0VORD0yMDI0LTA1LTE0DQpWQVJJQU5UPSJXb3Jrc3RhdGlvbiBF
ZGl0aW9uIg0KVkFSSUFOVF9JRD13b3Jrc3RhdGlvbg0KDQoNCg0KJCB1bmFtZSAtcg0KNi42
LjAtMC5yYzAuMjAyMzA5MDFnaXQ5OWQ5OTgyNWZjMDcuMy5mYzQwLng4Nl82NA0KDQoNCg0K
JCBnY2MgLS12ZXJzaW9uDQpnY2MgKEdDQykgMTMuMi4xIDIwMjMwNzI4IChSZWQgSGF0IDEz
LjIuMS0xKQ0KQ29weXJpZ2h0IChDKSAyMDIzIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwg
SW5jLg0KVGhpcyBpcyBmcmVlIHNvZnR3YXJlOyBzZWUgdGhlIHNvdXJjZSBmb3IgY29weWlu
ZyBjb25kaXRpb25zLiZuYnNwOyBUaGVyZSBpcyBOTw0Kd2FycmFudHk7IG5vdCBldmVuIGZv
ciBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0Uu
DQoNCg0KDQokIG1ha2UgcWVtdS14ODZfNjRfZGVmY29uZmlnDQombmJzcDsgSE9TVENDJm5i
c3A7IHNjcmlwdHMvYmFzaWMvZml4ZGVwDQombmJzcDsgSE9TVENDJm5ic3A7IHNjcmlwdHMv
a2NvbmZpZy9jb25mLm8NCiZuYnNwOyBZQUNDJm5ic3A7ICZuYnNwOyBzY3JpcHRzL2tjb25m
aWcvemNvbmYudGFiLmMNCiZuYnNwOyBMRVgmbmJzcDsgJm5ic3A7ICZuYnNwO3NjcmlwdHMv
a2NvbmZpZy96Y29uZi5sZXguYw0KJm5ic3A7IEhPU1RDQyZuYnNwOyBzY3JpcHRzL2tjb25m
aWcvemNvbmYudGFiLm8NCiZuYnNwOyBIT1NUTEQmbmJzcDsgc2NyaXB0cy9rY29uZmlnL2Nv
bmYNCiMNCiMgY29uZmlndXJhdGlvbiB3cml0dGVuIHRvIC5jb25maWcNCiMNCg0KDQoNCiQg
bWFrZSAtajgNCi4uLiBbdG9vIG11Y2ggbG9nc10NCiZuYnNwOyBTWU0mbmJzcDsgJm5ic3A7
ICZuYnNwO3NwbC91LWJvb3Qtc3BsLnN5bQ0KJm5ic3A7IE9CSkNPUFkgc3BsL3UtYm9vdC14
ODYtc3RhcnQxNi1zcGwuYmluDQombmJzcDsgT0JKQ09QWSBzcGwvdS1ib290LXg4Ni1yZXNl
dDE2LXNwbC5iaW4NCiZuYnNwOyBDQVQmbmJzcDsgJm5ic3A7ICZuYnNwO3NwbC91LWJvb3Qt
c3BsLWR0Yi5iaW4NCiZuYnNwOyBDT1BZJm5ic3A7ICZuYnNwOyBzcGwvdS1ib290LXNwbC5i
aW4NCiZuYnNwOyBCSU5NQU4mbmJzcDsgLmJpbm1hbl9zdGFtcA0KL2hvbWUvc2RhL2dpdC1y
ZXBvcy91LWJvb3QvdG9vbHMvYmlubWFuL2V0eXBlL3NlY3Rpb24ucHk6MjU6IFN5bnRheFdh
cm5pbmc6IGludmFsaWQgZXNjYXBlIHNlcXVlbmNlICdcKCcNCiZuYnNwOyAiIiJFbnRyeSB0
aGF0IGNvbnRhaW5zIG90aGVyIGVudHJpZXMNCiZuYnNwOyBPRkNISyZuYnNwOyAmbmJzcDsu
Y29uZmln
