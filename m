Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A5DC88E45
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 01:07:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C14C96061A;
	Sat, 12 Sep 2026 01:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R60-jqxS0IYE; Sat, 12 Sep 2026 01:07:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A03326068C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789175266;
	b=KapDWPlu+1vN+PlF5hqY2hEENkTNJ5MTq0T/zu40djBCjnPPgBLFaKQ3eGZhBq1RoFv1
	 eFJnSieGKCNC/z6WNBUp7mj75Q5w8qvvymV/B4grpeWRuQA2AFDRLNpphyGd0VcRLT/ys
	 FqE9WIdBtFC1x2UuIpdWoFEtIUxYeP8mq4zVW6EvdShZgbnGr+3yq7xHXnKeo4UbJM2ps
	 k2zvTBX4qbciHKKqWfu1EDRqPwXuPPWEKfeQ06X1ObEk8AQUBjtFj9vXcAUlanUwQ6HQm
	 oIkGIl4cS7CHWDNWna+nnOkyagzbyClqUnb7Vzi+38jude9g+xc3GCkhDGi43LGw0vw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789175266;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ovwkixAwoCZAb0C/J5L6JxlEkj3S/TWo5jeauQ+ki/A=;
	b=YEHKJB/bhleAD9oBfGbGqSADGow/2bIFj9IuK0HiczcA7Zu/26jeho2yHaUBZEmmrPUg
	 hq6YN3yoGbPq1frWX8oLl1QXXX5YoxUjITXNxOonPIMOG0jJ9wY1JtF7TBLfaS0v/5yXT
	 o8HS0gQ9Cr5oe6uiPDLqe2mPdRzrYvsbZrC7hNiwGOdNqKxc0kJ7YWkL7XhA9O5oX9Pzf
	 UxOzqzVWJ/ZgssFcRlTISt6noftKs35p/epj5M8her0Gy9jCHmS4tXZwMVVqPmTwZFR7R
	 MrLqcO935QOIus8exJXLCjh/Y1xK+C6CJ3DZxKFsKKFIv6z+HKmmw3A1n/cPO+5YyuA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789175266;
	bh=ovwkixAwoCZAb0C/J5L6JxlEkj3S/TWo5jeauQ+ki/A=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SU21WPDtofw1UwG9vq6RDpFTnQ2gZM9I5uKQhWj3xw9QzuAD/3jram2pyprH6dzJ4
	 ziyDelpdPNgVYC7MnIpq4IrvpL/mkNvo2eAsAHH9b0ayHiGuCTVvLL411rJtxMW7bt
	 gsVpvXez6vhoywyhjct/m5V12ZunRaApyRNX1DpiCciVVt+bzmmA7/liSUJ1p0q2mF
	 5rgHwC+Xia9cRTUga99qh0LxjeU37pe/jAEW7DEbqK7lMy10qtW3lLZUY8iCSBUOon
	 yc1MxHdjN2zX6BYBTXCe3GyA5tFn4C0MSk84dmMPMcafybsNtvSTKbK5zTYitT/cy6
	 gVtvvdgbDBTgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A03326068C;
	Sat, 12 Sep 2026 01:07:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BB97A72E
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F3E94020B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YIfVp3RYPUtR for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 18:40:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 04F134000B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.105
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789152009;
 b=E/JP3X/fjrGiIvbwkX9errBCqy9RMKldr2OXapWtJwCTHRa1QK9opguAZq2iWoxCy1OW
 qkz6JEWATi3sAiWagVMs0gicmKnK6V8KhxyDVDFZB/qgHGKtGbe5fkye/1Dpgm3CRUap9
 tdpQ8kNXXi5DNZ4leo8S9CoASI3NzvcxSY+xs2a6a9f+4qRuPUvEoGVHtHkBWTYhjy2hO
 ee8ezY300mbdpl4DjaksSi08rUfct2JxkqFe/gLSyrOn9IKTXRtRHubfLxo1Jn0eugfv3
 3FfPFUouskcKs88M2W9zTgC0MklTQ4KMSS8SJ96DO8DMUgBNPVZKhnjrlmrbnqUl0sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789152009;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=ovwkixAwoCZAb0C/J5L6JxlEkj3S/TWo5jeauQ+ki/A=;
 b=JAGJdleQrJ5z+x5JBYH9pHdtkfvixkTXCrULQiftGynm6O0nnEnWuBb0ciWGuHlBFf9R
 i+OXcG2ZzCzrdmNcWJlBwB64puiALOptpSs0tyTafYZ4akxjHx31OmGvqXJPW0T7s8fkb
 6irUE892NxOv1xu2cECWm2mU8fe8KC4junEi64d6Jzl7uigZSX22TBH0NS19OZt3EdB/x
 Y6jyI91zC1eYi5Yb/VA0rD/kcGy4nopf2hrOCuVqNM3Z47xe5cjXNb1lZAr756fi29sC3
 QG4e1ep/JvudEJEsD8GI5zTXk+//E6luHUcA2+w5zKphuBiN1Lu4RVODmhWRdUNcsHA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=KKf2p1ae; 
 arc=none smtp.remote-ip=109.224.244.105
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.105;
 helo=mail-244105.protonmail.ch; envelope-from=petr.hodina@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=KKf2p1ae
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04F134000B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1789151993; x=1789411193;
 bh=ovwkixAwoCZAb0C/J5L6JxlEkj3S/TWo5jeauQ+ki/A=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=KKf2p1aeZi1VumnJjV2+gB1uXAGdlqaQYQCdI45CgkGJUT3lvDNp0/athIqMzt59J
 cpfgqvTpj46h0BSfGGzj6mr60qOLMQSSFpwa+mTQB8zg1n3jkI8ubmuxeJFmvSIi58
 lwUz9WNCPiHb82G/ZkJzg0WkpkkdZmPhd6nqttCWUaOYjj1Of2jY7m1BnTttJxBAxY
 Hn/HE0BBBUNRj3C0TuyjvtDtJUUdVdJ0I5ymCd/MsNC1WMjLYITGy0SCnbI1UXNNDb
 Xi17VTJLY1yBw8XIQpv78HGcRmnG2QMMdPaey+qPa2km4VcuzMTLc9IQp2/KFsX/yX
 WR9Wn7S5iSUJA==
Date: Fri, 11 Sep 2026 18:39:46 +0000
To: Marek Vasut <marek.vasut@mailbox.org>
From: phodina <petr.hodina@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexey Charkov <alchark@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Anshul Dalal <anshuld@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, David Heidelberg <david@ixit.cz>,
 Petr Pavlata <petr@acrux.cz>
Subject: Re: [PATCH 1/4] common: Add command line parsing utilities
Message-ID: <U6YrT3S_BQGuySCLDPjwnTxE9bvcH4uMX9vLfz5D0b32Kumb7X-TVcYowyUHmESFKNVU8jSLlDPqYQI9Y6owcWFWAicWEhCrB7lL4J1z6JE=@protonmail.com>
In-Reply-To: <17753947-74ac-4b42-8d94-436e7984e062@mailbox.org>
References: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
 <20260911-b4-android-bootargs-carryover-v1-1-6ebb43da3df0@protonmail.com>
 <17753947-74ac-4b42-8d94-436e7984e062@mailbox.org>
Feedback-ID: 23468634:user:proton
X-Pm-Message-ID: c63aaaf07b292b4b41b8ff7fd31ddb66efb35bbf
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 12 Sep 2026 01:07:35 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Friday, September 11th, 2026 at 8:30 PM, Marek Vasut <marek.vasut@mailbo=
x.org> wrote:

> On 9/11/26 8:18 PM, Petr Hodina via B4 Relay wrote:
> > From: Petr Hodina <petr.hodina@protonmail.com>
> >
> > Add a new utility library for parsing command line parameters in
> > key=3Dvalue format.
> Is this reinventing environment or UPL ?
>=20

The target is a chainloaded environment. In this case u-boot running on And=
roid devices where you unfortunately don't have the possibility to use UPL.

As stated above it's purpose is to simplify the operations on the command l=
ine arguments from the previous stage and pass them to the next.

Typical example is to remove the skip initramfs or extract the value for th=
e panel to pick the right dtb (not part of this patch series)
