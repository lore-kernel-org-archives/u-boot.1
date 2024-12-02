Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F21D78312
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 12:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F84888C8F;
	Mon,  2 Dec 2024 13:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="gWygJwHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BCCA88FDE; Mon,  2 Dec 2024 13:18:59 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by phobos.denx.de (Postfix) with ESMTP id B8F7188AAC
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 13:18:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=s3AiCiZxJzPWHeuXEbk+6ZSKBdaSWJFfWl8BdOL7FDs=; b=g
 WygJwHzwhxm7cmEVzL0AtOYyXpwvSHcobqUyRDxq7dTEt6Yf3Uit/JGzCMD/pXO8
 ZoxsT1AIOYrG+Liy30Zbx8L6QZovp8H2KLl4g9r9boBR5TzNCiiClgkNTcogeswh
 gOTmWpKjSFs4tBIxebijZQyV/LAMzQPmhnDCt7R8iQ=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-118 (Coremail) ; Mon, 2 Dec 2024 20:16:24 +0800 (CST)
X-Originating-IP: [58.22.7.114]
Date: Mon, 2 Dec 2024 20:16:24 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Patrice CHOTARD" <patrice.chotard@foss.st.com>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, 
 "Tom Rini" <trini@konsulko.com>, christophe.priouzeau@foss.st.com, 
 "Patrick DELAUNAY" <patrick.delaunay@foss.st.com>, 
 etienne.carriere@foss.st.com
Subject: Re:unable to access 'https://source.denx.de/u-boot/u-boot.git/'
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <a7df8a2a-78c8-4542-8af8-dab3c4b59392@foss.st.com>
References: <a7df8a2a-78c8-4542-8af8-dab3c4b59392@foss.st.com>
X-NTES-SC: AL_Qu2YAf2fvk8j4iCebelS8zNM9K56MKvt5LljqcQFePgqqTHL3g4cZnlBM0vW6uLS+3R3dw2U4lQgCk5ZXPwW
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <22662f2f.bf56.193874ce608.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: digvCgC3XxAYpU1niAw1AA--.37985W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwapXmdNndLDCgACss
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
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

CkhpIEFsbO+8jAoKQXQgMjAyNC0xMi0wMiAxNzowODo0OCwgIlBhdHJpY2UgQ0hPVEFSRCIgPHBh
dHJpY2UuY2hvdGFyZEBmb3NzLnN0LmNvbT4gd3JvdGU6Cj5IaSBBbGwKPgo+U2luY2Ugc2V2ZXJh
bCBkYXlzLCBpdCBzZWVtcyB0aGF0IFUtQm9vdCBnaXQgcmVwb3NpdG9yeSBpcyBub3QgYWNjZXNz
aWJsZS4KPgo+RmV0Y2hpbmcgb3IgY2xvbmluZyB1LWJvb3QgcmVwbyBsZWFkcyB0byB0aGUgZm9s
bG93aW5nIGlzc3VlOiAKPgo+Z2l0IGNsb25lIGh0dHBzOi8vc291cmNlLmRlbnguZGUvdS1ib290
L3UtYm9vdC5naXQKPkNsb25pbmcgaW50byAndS1ib290Jy4uLgo+ZmF0YWw6IHVuYWJsZSB0byBh
Y2Nlc3MgJ2h0dHBzOi8vc291cmNlLmRlbnguZGUvdS1ib290L3UtYm9vdC5naXQvJzogVGhlIHJl
cXVlc3RlZCBVUkwgcmV0dXJuZWQgZXJyb3I6IDQwMwoKSSBhbHNvIHNlZSBzaW1pbGFyIGlzc3Vl
IGZyb20gQ2hpbmEgdGhlc2UgZGF5czoKCmdpdCBmZXRjaCBvcmlnaW4gCmZhdGFsOiB1bmFibGUg
dG8gYWNjZXNzICdodHRwczovL2dpdGxhYi5kZW54LmRlL3UtYm9vdC91LWJvb3QuZ2l0Lyc6IEZh
aWxlZCB0byBjb25uZWN0IHRvIHNvdXJjZS5kZW54LmRlIHBvcnQgNDQzIGFmdGVyIDEzNTA0NyBt
czogQ29ubmVjdGlvbiB0aW1lZCBvdXQKPgo+VGhhbmtzCj5QYXRyaWNlCg==
