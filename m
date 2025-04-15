Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C96FC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 03:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F81C82102;
	Tue, 15 Apr 2025 05:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="vTdpvniy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90B882145; Tue, 15 Apr 2025 05:36:39 +0200 (CEST)
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com
 [203.205.221.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9133E820F8
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 05:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiehui.he@foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1744688184;
 bh=4+l/K97z7q4v7HLoyJTJYqOhfgawu/IlxTvirbTnHiQ=;
 h=From:To:Cc:Subject:Date:References:In-Reply-To;
 b=vTdpvniy/Na/Oeyp0UaPs0+uRFNza8gynu0Cl4xLiUoDR/lznwVgg6Jg2LM78YMi5
 XMFok4YapNSreH4BSgTI4H0Tz7bxQwDxAP7GNn3tdN9Yt4dvzYbUepi2iC1K/Enx+K
 ZQrV/NH4I4yQeJOvj1fUWQyIIjYiGTrNiVcw0dP8=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-XMAILINFO: NbiOBCZD5TwSocbg2caT+H1X/8YABsazFqhxq0mrvKZl9GKW/UkUwgy6QdHGUQ
 7El5VfQdH+I4WnbiGzLKVrMFeb+5LuVE4DzFHkYcKOZT3beN0nnSDjj1uMa1BwcAf8Vv6t/xLbtrr
 lYqTf5JM8kLVDEqy4NaPJINSwgVtZXtZBZXVGjo3Fkmh4veY1IVW/dYQ7Wg0oBZ288ifA4UpKA5/s
 eINnoKqFYxE9z1h2h4Frew3yAEKDxnlnpwcED+27QeUVBgR1Z8gULhZtPtpr4uIxv20lRTUo0pgYh
 upYRYh0orC+l9C7y0Fptb9y6TchSJle+rDpZyrzgKhPcr+HVr3cXkPhN0Ai2z85OL+ZecsrkskCJU
 OGsBY7aOIyQX/YncBI8/IYpqjP1xwXJqt1bBkruFqCghRXamntX1/wFXhpW3VIwHFWmAjuQrN7qgb
 b8bbWjVFGCHMdJKLYJk/cujOwRuh217EwPNqd37e+51D5L7GoEgFVPFYun+eJ7qLdZMcgx6dY6sx0
 eCoXh43tfWpH/phrsQCJEHE5mjP24uXIN6cIni5SmxZe8Z3OOKYbKuFeawdjsdaapMNKAkVBigM8v
 Jh9N4NauonKF6V+PeodpJWDwoitbA5CNxjeuUQTQw7wM+xKeHMAk65+krdecjnQ0xPy0K66AoBD8/
 ew5CMIyCgeUhkTRYEBetoBKC2MnTE3VpFGBG2m876dWfaV3SWU16OTxYnva6B28SeVXtd0UB1xjo4
 lNJqKPZAeGqHPfA82212KQlF/KSocpMgNhuj92nbXhOD/UUIZNxlAHSfSpEK+m71DiprbDG4274xl
 qDLgW7KL/mBUycWi4iFsZYKCa8pQTQdWkj3AOWIBXJc+ZHOM4CXGJofXNA7+y3QdrtWm7hQSFpfH9
 RWhVJGHIJXVMs04KPqRfW42e6yeXQcvawA9gkFBGMmupngb3nz3UQEbJXgC4jt9UpuGTle4YGYMgt
 NcIf7z15Q7pvpIP8QN+WCidkkqQjKw4kGCppQ9j7IvLOIrb9iY
From: "=?utf-8?B?SmllaHVpIEhl?=" <jiehui.he@foxmail.com>
To: "=?utf-8?B?Sm9uYXMgS2FybG1hbg==?=" <jonas@kwiboo.se>
Cc: "=?utf-8?B?dS1ib290?=" <u-boot@lists.denx.de>,
 "=?utf-8?B?c2pn?=" <sjg@chromium.org>,
 "=?utf-8?B?cGhpbGlwcC50b21zaWNo?=" <philipp.tomsich@vrull.eu>,
 "=?utf-8?B?a2V2ZXIueWFuZw==?=" <kever.yang@rock-chips.com>,
 "=?utf-8?B?dHJpbmk=?=" <trini@konsulko.com>,
 "=?utf-8?B?Y2hlbmpo?=" <chenjh@rock-chips.com>
Subject: Re: [PATCH] board: rockchip: Add LCKFB TaishanPi RK3566 Board
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 15 Apr 2025 11:36:17 +0800
X-Priority: 3
Message-ID: <tencent_7CC544247A4DF034D14A52CFD850DCBC4F0A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_95ED0C0545D87B6A8C4B62EC045D53AD2406@qq.com>
 <97b55630-1a02-4e0c-9b0a-d90dd867618f@kwiboo.se>
In-Reply-To: <97b55630-1a02-4e0c-9b0a-d90dd867618f@kwiboo.se>
X-QQ-mid: xmsezc28-0t1744688177teqc1b15l
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

SGkmbmJzcDtKb25hcyw8YnIvPjxici8+VGhhbmtzJm5ic3A7Zm9yJm5ic3A7eW91ciZuYnNw
O3JldmlldyZuYnNwO2FuZCZuYnNwO2hlbHBmdWwmbmJzcDtzdWdnZXN0aW9ucyE8YnIvPjxi
ci8+T24mbmJzcDsyMDI1LTAzLTMwJm5ic3A7MTk6MjcsJm5ic3A7Sm9uYXMmbmJzcDtLYXJs
bWFuJm5ic3A7d3JvdGU6PGJyLz4mZ3Q7Jmd0OyZuYnNwO2RpZmYmbmJzcDstLWdpdCZuYnNw
O2EvY29uZmlncy9sY2tmYi10c3BpLXJrMzU2Nl9kZWZjb25maWcmbmJzcDtiL2NvbmZpZ3Mv
bGNrZmItdHNwaS1yazM1NjZfZGVmY29uZmlnPGJyLz4mZ3Q7Jmd0OyZuYnNwO25ldyZuYnNw
O2ZpbGUmbmJzcDttb2RlJm5ic3A7MTAwNjQ0PGJyLz4mZ3Q7Jmd0OyZuYnNwO2luZGV4Jm5i
c3A7MDAwMDAwMDAuLjEyNmVkZTM3PGJyLz4mZ3Q7Jmd0OyZuYnNwOy0tLSZuYnNwOy9kZXYv
bnVsbDxici8+Jmd0OyZndDsmbmJzcDsrKysmbmJzcDtiL2NvbmZpZ3MvbGNrZmItdHNwaS1y
azM1NjZfZGVmY29uZmlnPGJyLz4mZ3Q7Jmd0OyZuYnNwO0BAJm5ic3A7LTAsMCZuYnNwOysx
LDg0Jm5ic3A7QEA8YnIvPiZndDsmZ3Q7Jm5ic3A7K0NPTkZJR19BUk09eTxici8+Jmd0OyZn
dDsmbmJzcDsrQ09ORklHX1NLSVBfTE9XTEVWRUxfSU5JVD15PGJyLz4mZ3Q7Jmd0OyZuYnNw
OytDT05GSUdfQ09VTlRFUl9GUkVRVUVOQ1k9MjQwMDAwMDA8YnIvPiZndDsmZ3Q7Jm5ic3A7
K0NPTkZJR19BUkNIX1JPQ0tDSElQPXk8YnIvPiZndDsmZ3Q7Jm5ic3A7K0NPTkZJR19TUExf
R1BJTz15PGJyLz48YnIvPiZndDsmbmJzcDtUaGUmbmJzcDtTUEwmbmJzcDtjb250cm9sJm5i
c3A7RkRUJm5ic3A7aXMmbmJzcDtub3QmbmJzcDtpbmNsdWRpbmcmbmJzcDthbnkmbmJzcDtn
cGlvJm5ic3A7cmVsYXRlZCZuYnNwO25vZGVzLCZuYnNwO3RoaXMmbmJzcDtjb3VsZDxici8+
Jmd0OyZuYnNwO2JlJm5ic3A7ZHJvcHBlZC48YnIvPjxici8+QWNrLiZuYnNwO0kmbmJzcDt3
aWxsJm5ic3A7cmVtb3ZlJm5ic3A7YENPTkZJR19TUExfR1BJT2AuPGJyLz48YnIvPiZndDsm
Z3Q7Jm5ic3A7Li4uPGJyLz4mZ3Q7Jmd0OyZuYnNwOytDT05GSUdfU1BMX1BPV0VSPXk8YnIv
Pjxici8+Jmd0OyZuYnNwO1RoZSZuYnNwO1NQTCZuYnNwO2NvbnRyb2wmbmJzcDtGRFQmbmJz
cDtpcyZuYnNwO25vdCZuYnNwO2luY2x1ZGluZyZuYnNwO2FueSZuYnNwO3Bvd2VyJm5ic3A7
cmVsYXRlZCZuYnNwO25vZGVzLCZuYnNwO3RoaXMmbmJzcDtjb3VsZDxici8+Jmd0OyZuYnNw
O2JlJm5ic3A7ZHJvcHBlZC48YnIvPjxici8+V2lsbCZuYnNwO2Ryb3AmbmJzcDtgQ09ORklH
X1NQTF9QT1dFUmAuPGJyLz48YnIvPiZndDsmZ3Q7Jm5ic3A7Li4uPGJyLz4mZ3Q7Jmd0OyZu
YnNwOytDT05GSUdfRFdDX0VUSF9RT1M9eTxici8+Jmd0OyZndDsmbmJzcDsrQ09ORklHX0RX
Q19FVEhfUU9TX1JPQ0tDSElQPXk8YnIvPjxici8+Jmd0OyZuYnNwO0l0Jm5ic3A7ZG9lcyZu
YnNwO25vdCZuYnNwO2xvb2smbmJzcDtsaWtlJm5ic3A7dGhlJm5ic3A7ZGV2aWNlJm5ic3A7
dHJlZSZuYnNwO2VuYWJsZSZuYnNwO2FueSZuYnNwO0V0aGVybmV0Jm5ic3A7ZGV2aWNlcywm
bmJzcDt0aGVzZTxici8+Jmd0OyZuYnNwO3R3byZuYnNwO2NvdWxkJm5ic3A7YmUmbmJzcDtk
cm9wcGVkLjxici8+PGJyLz5J4oCZbGwmbmJzcDtyZW1vdmUmbmJzcDtib3RoJm5ic3A7YENP
TkZJR19EV0NfRVRIX1FPU2AmbmJzcDthbmQmbmJzcDtgQ09ORklHX0RXQ19FVEhfUU9TX1JP
Q0tDSElQYC48YnIvPjxici8+Jmd0OyZndDsmbmJzcDsuLi48YnIvPiZndDsmZ3Q7Jm5ic3A7
K0NPTkZJR19TUExfRE1fUkVHVUxBVE9SPXk8YnIvPiZndDsmZ3Q7Jm5ic3A7K0NPTkZJR19T
UExfRE1fUkVHVUxBVE9SX0ZJWEVEPXk8YnIvPjxici8+Jmd0OyZuYnNwO1RoZSZuYnNwO1NQ
TCZuYnNwO2NvbnRyb2wmbmJzcDtGRFQmbmJzcDtpcyZuYnNwO25vdCZuYnNwO2luY2x1ZGlu
ZyZuYnNwO2FueSZuYnNwO2ZpeGVkJm5ic3A7cmVndWxhdG9ycywmbmJzcDt0aGVzZSZuYnNw
O3R3bzxici8+Jmd0OyZuYnNwO2NvdWxkJm5ic3A7YmUmbmJzcDtkcm9wcGVkLjxici8+PGJy
Lz5JJm5ic3A7d2lsbCZuYnNwO3JlbW92ZSZuYnNwO2BDT05GSUdfU1BMX0RNX1JFR1VMQVRP
UmAmbmJzcDthbmQmbmJzcDtgQ09ORklHX1NQTF9ETV9SRUdVTEFUT1JfRklYRURgLjxici8+
PGJyLz4mZ3Q7Jmd0OyZuYnNwOy4uLjxici8+Jmd0OyZndDsmbmJzcDtkaWZmJm5ic3A7LS1n
aXQmbmJzcDthL2RvYy9ib2FyZC9yb2NrY2hpcC9yb2NrY2hpcC5yc3QmbmJzcDtiL2RvYy9i
b2FyZC9yb2NrY2hpcC9yb2NrY2hpcC5yc3Q8YnIvPiZndDsmZ3Q7Jm5ic3A7aW5kZXgmbmJz
cDsxNDA3MDgwZi4uYWU5YThjOGEmbmJzcDsxMDA2NDQ8YnIvPiZndDsmZ3Q7Jm5ic3A7LS0t
Jm5ic3A7YS9kb2MvYm9hcmQvcm9ja2NoaXAvcm9ja2NoaXAucnN0PGJyLz4mZ3Q7Jmd0OyZu
YnNwOysrKyZuYnNwO2IvZG9jL2JvYXJkL3JvY2tjaGlwL3JvY2tjaGlwLnJzdDxici8+Jmd0
OyZndDsmbmJzcDtAQCZuYnNwOy0xMTIsNiZuYnNwOysxMTIsNyZuYnNwO0BAJm5ic3A7TGlz
dCZuYnNwO29mJm5ic3A7bWFpbmxpbmUmbmJzcDtzdXBwb3J0ZWQmbmJzcDtSb2NrY2hpcCZu
YnNwO2JvYXJkczo8YnIvPiZndDsmZ3Q7Jm5ic3A7LSZuYnNwO1JhZHhhJm5ic3A7Uk9DSyZu
YnNwOzNDJm5ic3A7KHJvY2stM2MtcmszNTY2KTxici8+Jmd0OyZndDsmbmJzcDstJm5ic3A7
UmFkeGEmbmJzcDtaRVJPJm5ic3A7M1cvM0UmbmJzcDsocmFkeGEtemVyby0zLXJrMzU2Nik8
YnIvPiZndDsmZ3Q7Jm5ic3A7LSZuYnNwO1h1bmxvbmcmbmJzcDtPcmFuZ2UmbmJzcDtQaSZu
YnNwOzNCJm5ic3A7KG9yYW5nZXBpLTNiLXJrMzU2Nik8YnIvPiZndDsmZ3Q7Jm5ic3A7KyZu
YnNwOy0mbmJzcDtMQ0tGQiZuYnNwO1RhaXNoYW5QaSZuYnNwOyhsY2tmYi10c3BpLXJrMzU2
Nik8YnIvPjxici8+Jmd0OyZuYnNwO1BsZWFzZSZuYnNwO2FkZCZuYnNwO3RoaXMmbmJzcDts
aW5lJm5ic3A7aW4mbmJzcDtjb3JyZWN0Jm5ic3A7YWxwaGFiZXRpY2FsJm5ic3A7b3JkZXIm
bmJzcDthbmQmbmJzcDtub3QmbmJzcDthdCZuYnNwO3RoZSZuYnNwO2JvdHRvbS48YnIvPjxi
ci8+VGhhbmtzISZuYnNwO0nigJlsbCZuYnNwO2ZpeCZuYnNwO3RoZSZuYnNwO29yZGVyJm5i
c3A7YW5kJm5ic3A7cGxhY2UmbmJzcDtpdCZuYnNwO2FscGhhYmV0aWNhbGx5Jm5ic3A7aW4m
bmJzcDt0aGUmbmJzcDtuZXh0Jm5ic3A7cmV2aXNpb24uPGJyLz48YnIvPkJlc3QmbmJzcDty
ZWdhcmRzLCZuYnNwOyZuYnNwOzxici8+SmllaHVpPGJyLz4=

