Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0818EB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 02:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1815386583;
	Wed,  6 Sep 2023 04:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="EddycODq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A68058655F; Tue,  5 Sep 2023 13:43:17 +0200 (CEST)
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com
 [203.205.221.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C85338698F
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 13:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rtoax@foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1693914179;
 bh=2B1OXiF6cA5lnqeSKgt2ZqhCob+KgJOnMEXAAZwQJgo=;
 h=In-Reply-To:References:From:To:Cc:Subject:Date;
 b=EddycODqLo/9gDa0ucdqjLwWMeewPDzkfqpQUazPZfR5nr02r+0JB1u2+Fa3QJG9G
 rUH8GaTZLo/6mKvoEz8hmYnxG3HQg+njf/XJnCpRNfJhVY/97UKXlSFsQKggqUPmfV
 EeXxMYJ2+fZDlKMmPi4zbRPGQTAKaCpPJLmYqd0s=
X-QQ-FEAT: oHWrrGTW1dBWf/tYwAy1LivIoNEHFlYc
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-XMAILINFO: MnZETmYuOHHWoFwCkZc2FSQ5EorOKFDisoRxzXIIQMquNyuVHYPswlUhIU/NgO
 PmdJ9JYBnmk2kdVChkmkksHiVPKuK2flgx9dB7r1M4507W/qpYzK7KravmdpgK4caEib0moA/WcmO
 LOVWk3I99wIrv+B6SbJpsWMmqskfF7YRYY9Hfk5T4yrR4fPfrhCYBDrpHNAF+E6VkiBImcW6wye14
 l/5Tzcmgs4v/7S5sU0vVdRbmU0vq3Dy4rwvG8ECL4iT8hbn3qIv6b8/ABCZvjgEia4ampEYpo5+wb
 XWLhAxeffO/FUsNuAt460nMnTbbrNEBK2aaY6EIemfTQFOswppa0jPEh2+2nQ08LOcCHhU6K3o+j4
 NBncO57zS/9Hg4ekEK/sVUjX+iNs1nAHeI8pQrBl0u5G3Q7eT8NlBOC6N0RT1jedentUj1Wnzeg6d
 8/I4NclzGUmcoSTZnMWNbVUjbYZnRxAhz0koc4Gc0ldyPifq+vhH8VHebFIwx4s5I4pO1q1BGOnYj
 438ZssJ8CP4xOourloe8Dk+Wmjwf8ghgleG/k7xA0bPCV7c/SGYb4q/2uWWS+oB11upxkqz5ioHAH
 DFOxrzNenJtf+HYRxA2jxZOmbZmHUT1NzWZMLjBSz/8+1GUEfI+/xzEtZ1pog19qElY+PGnY5B/Hf
 B93HXSuX5n6kouIBZL6uULu52WIvIGBXMyG8891XlZ2VD7sCRueZAcyxVF2lQ9IRubaJOiGVkBtz2
 OnEhkQU16ZYV2W1bJE17ujqwyR5wOcMkh7w8089Vi0KSybYI9sfvk6wBq+vZfpNzLBU3/yh7c/n9Y
 tfe/+K2HZEQ9jLncoUGfBvaAmZ0i0XSIJiLZb4wppG+zCHTupkamhdk3FmsR8UXqawF8cK6+/4fGy
 XOMOvre6E/AtxJZAgMTbiimPu24+uJj+kzhP3tjt7kejazgL5l25cEKPOUYNzYcoZU1DcVO0ifxRI
 XHm8XfgGRFw1B7c6Ji
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 39.156.37.17
In-Reply-To: <tencent_A24996C4E5B08AD92BCDA82E62A88185D006@qq.com>
References: <tencent_0D22B14196104C56C3E5BB4AD46BCF283306@qq.com>
 <CAPnjgZ0mW0gtQdUprkR=BHoHX3pmbAqt2BTcJnH=4LyyzYxggQ@mail.gmail.com>
 <tencent_A24996C4E5B08AD92BCDA82E62A88185D006@qq.com>
X-QQ-STYLE: 
X-QQ-mid: webmail872t1693914178t1460224
From: "=?gb18030?B?yNnMzg==?=" <rtoax@foxmail.com>
To: "=?gb18030?B?U2ltb24gR2xhc3M=?=" <sjg@chromium.org>
Cc: "=?gb18030?B?QWxwZXIgTmViaSBZYXNhaw==?=" <alpernebiyasak@gmail.com>,
 "=?gb18030?B?Sm9uYXMgS2FybG1hbg==?=" <jonas@kwiboo.se>,
 "=?gb18030?B?SXZhbiBNaWtoYXlsb3Y=?=" <fr0st61te@gmail.com>,
 "=?gb18030?B?b3BlbiBsaXN0?=" <u-boot@lists.denx.de>,
 "=?gb18030?B?Um9uZyBUYW8=?=" <rongtao@cestc.cn>
Subject: Re:  [PATCH] binman: Fix SyntaxWarning: invalid escape sequence '\('
Mime-Version: 1.0
Date: Tue, 5 Sep 2023 19:42:58 +0800
X-Priority: 3
Message-ID: <tencent_31B4B3442EC7546E5F2B47BD10C30C628509@qq.com>
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

SSBKdXN0IHRyeQ0KDQoNCiZuYnNwOyAmbmJzcDsgYmlubWFuIGVudHJ5LWRvY3MgJmd0OyBl
bnRyaWVzLnJzdA0KJm5ic3A7ICZuYnNwOyBnaXQgZGlmZmYNCg0KDQpJdCBkaWRuJ3QgY2hh
bmdlIGFueXRoaW5nLg0KDQoNClJvbmcgVGFv
