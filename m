Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92315CA0FF6
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 07:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A624A863F9;
	Sat,  2 Sep 2023 09:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UxQ+db8q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9162786411; Sat,  2 Sep 2023 09:51:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95905847D9
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 09:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693641062; x=1694245862; i=xypron.glpk@gmx.de;
 bh=AgkfcJQdT4Zq63N7OY3t9/X+44yd7vlJGFvQtVck7pw=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=UxQ+db8qFi19YfdlZmRNy4JagIRJJt+1zqZN0UWAQWi5pMrgicVKLVBNn3ssPW1aME+5k06
 oX5oZKi5D4bgsrHpMi2d7T/SwZ3Z8xNxau9mPEUE5wcN7ooPg3KzGu4Y642in3Jsrt4eXwK8w
 EKj0bIDNMnlR/XhyyxP/Q+KJg7qP7NP98J8vdT3qJvRSd2Y8Z6PldA1idOBQJu3tXxTfqVl41
 Of/8bJXkuF9emBfjTliRHYWTGZVUbqKliNjMTZcHafkyk6jIimGZ5B7EenG/nL6fIF0OaVJ56
 Uk/FM0dx/n3Q1nb5bIkwWp3l+g15qL82HNv96BKxU+xf60Ddkpig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzfv-1q9vQN37A9-00XKuM; Sat, 02
 Sep 2023 09:51:02 +0200
Message-ID: <a1e38d39-ac45-4705-8860-8c6688e338cd@gmx.de>
Date: Sat, 2 Sep 2023 09:51:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [NEXT] Pull request doc-next
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GssGBG76FbYLlTB+PbAWX0cj02hLbTLr3yVQP5XvtIX7V0/Y2T2
 22YxhpgynS47WQr/WhyHE7wFOhWLuZ10aapY5pCva3oderRu0h5MmBHK9u/2a2ATGcDJ2D7
 VZzuIsKAYAAl3CUVS8yWcg6xWtDAWLMtM2iHLga30cBZM+aUDFe8Rds7o8rIsR8rdjqslxS
 mI0igNJBbNhuTOjoIE+Cg==
UI-OutboundReport: notjunk:1;M01:P0:3a8ytrxIUY0=;6gYiyD89OBbPWkJu05ifnJS0HXr
 6dnZ0XKrd/3nhC0ZE6e92A1mf0jq5du9VPU3ujdrR4fm3TFQpVLXnMzdPKM6fOa14p/mIK5qh
 cQfAIXYr7AvIthnfiB4VlplYy6YiVQcbq7/rYJuYFCT2L5kN9QCfa+eeC9+wlhJeGcpZh4VLk
 Q7SvLG+kc8Ds4Cw72vRVMwaYXodwqQn4DB289D5G/xlkPjb6vS1CqV0OGOAfXTMq9bQ+1XLA1
 KFXwBmgtEcX3z99RG4uLXnc7S79kJE9l1UlLAdf/szHTd7nAumpdJXfzQ6Lycx2XFjQpURDGL
 HHXlhRaydlhZ1DERtKdF35bKt0IKetv7hicyguPF9TXdpX3n/7ZIbRECD8q2sPVQqwFl92ZW+
 1kahexLo86cHw/uDttrzXH1ZRStGPXbF6G1JQc3y/9EDGqNDbFPJS/e91HMFaH+keyyMj3FXL
 FhREd37W4jT3FwIFD4YB9g1+SjytYnIc8pPpY9R+cukwtEaO5lvhPZqYCAXpC7x+OB1BAXann
 +VWWQZJFPvBXgHfK2wAO6aO5bYn5PPlM3BIA6oaAZfnE6hg5vEYj9dGxTk5l3gjB+1pz84hgy
 ycdOMlrq8dKjdz1kXvSlawFXkeHqs439KdrTXY4W82R5zBLKkdK+Il1W8n0fUy1sujpyhByba
 Op5vqMeKwas9JtKpm2C9igHCe0d+DAntyW3+B/kxwQnMdrL/130jYJjobfqJANZw1crXXaJmy
 O8Zf4PF97bHAyTGvTJ6OK/rvY0b4Qb2CaEW03upWrnFITRQmxF7614eBJx7Xlp5QNJSgdGh5W
 XBXusknW+HIc+rRg6EdtkqjD/QEpK661BJPCn9gbRYVgcLlYxxNlVL4eKtw/5eUqsfUrqM8GN
 eiNRFN8rc4Z/xUrpJs4HO5oVVyT/eXUf9o972cSt/p7xkcMuRADiXwU+FwWTUHO1QGgGNQKoB
 blpTVPoowkI1HGoa+p8doL9EHts=
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

Dear Tom,

The following changes since commit b8b512a45358d50bce2e17b5941c5e39b52a059=
4:

   Merge branch '2023-08-31-replace-more-init-hooks-with-events' into
next (2023-08-31 15:10:42 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git tags/doc-next

for you to fetch changes up to edd8149cc686f749c51fafcfbb7802da73b42aea:

   doc: board: ti: am64x: Fix build step numbering (2023-09-02 06:14:34
+0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17599

=2D---------------------------------------------------------------
Pull request doc-next

* Update TI am64x documentation

=2D---------------------------------------------------------------
Nishanth Menon (2):
       doc: board: ti: am64x: provide image alt text
       doc: board: ti: am64x: Fix build step numbering

  doc/board/ti/am64x_evm.rst | 7 +++++--
  1 file changed, 5 insertions(+), 2 deletions(-)
