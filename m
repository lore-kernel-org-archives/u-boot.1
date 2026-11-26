Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D3606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xQnX4m5E;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=f3wkGizD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E58E8114B;
	Thu, 26 Nov 2026 13:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YDeZ0jzUYQO0; Thu, 26 Nov 2026 13:04:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3CB1981113
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795698240;
	b=irYkFlS3h55cUIew17AkoXhmBceldFRYvk+0tlRH6QP6t5UjvKVldc+HpyRvxKrx/QDs
	 /ilVsqsdZrrrVJFAKsckApMCHtLuPTiVQTUe44+yjpC5RXLLCC+hCSqJmzvasaRzSx2Py
	 TK1vDZSUcjc2trEf3gnrYg0SFjdED/K0V79WlSz6fZoZ7UJ7/8EKwOPwtnoqEdhUCe5gs
	 uO9N0YGY5bOGtiE92cQhNXkGDPbGMMmjUzJDvn+he77lVwwyZ3+FtkZCeOLBQ7mIsMSw7
	 2DeAlG18GBdK3vH516+jmNne+XstomUhzP71cw/sZj3UnIJYZiCX+942M+5GKotHbhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795698240;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yDbxvThVJgMXLFu2MtfH4F5qnkwz+oG8KZLL7zJ6dUA=;
	b=lF3opMtQ5FaroySD4EYt38Kav6K9zA7Lc6Q7nw1KK1v0roXzZpw3o1o0o+bcPsdEL+Ft
	 5Lqk35FlAxWgU0fO7oGr8RD+kUp6l0bqL3Y1ESowFh/rbq8d3nTW98YheGGSpY0l9ngYO
	 qMsEtwkhIM90vkZYdlgnspRFQQuYSYbMFROEPtNWsuYmJCpNrP57yBENWEkrhYhCcxlPo
	 fpdK6GpAFb22p0VOMJYXLpDNIwofRkeQA3jCfgHsVgmK1vy5pN45TSf7nBRw9GPLYjdLH
	 z6leFL6ST6Q2SF5XfOyD77vA2nJnWJmYCnybQQh+Wr6FcEHTMOVbkUQAWc5J41RA1Cg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795698240;
	bh=yDbxvThVJgMXLFu2MtfH4F5qnkwz+oG8KZLL7zJ6dUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xQnX4m5El+pOr6iZ5frScQEYuTtgVvA4PuBX9RDBLi1a9Ooh/LEYx7XKeM8fvnbKL
	 BpHIhKGQbo5+nHn2duvZ6wVaz0T6xJ9X2hmllJPfUrTWZjovTjaMg06Jzz/+Z+rkEh
	 bLKRouyI9BkTi/sXeGzbdYimKH+2Xd7T6XzkSja/j7Q8YYfaeiOrAlFnyVqSUlNhyb
	 q1mVXKTj14zyYlao1O0HgRoE2Fu8VUTIj0e7eloCqYZA8GSlRsg146cXZpO8GLJsnG
	 3gm6NjO6KGZLbGGeEJ5OdRkyFAfUEgeQOpyWfiXjt8A2It4yX23Mb9bro0XyiITkMD
	 og7yJNhXseyGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CB1981113;
	Thu, 26 Nov 2026 13:04:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CA851AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 313FD409B1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:03:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7humspJILRd8 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:03:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C1CBC40952
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=alexander.stein@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=f3wkGizD
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1CBC40952
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=yDbxvThVJgMXLFu2MtfH4F5qnkwz+oG8KZLL7zJ6dUA=; b=f3wkGizDXmEOry6yX2Xw5nLP9I
 Et9nrs12tmE27ljTy3qRXFlcVZsgGimpmIGosHn2syguDortGS0Ykn6TeWNhv4k8PkUdggZFvPqsb
 LHL+/2LoU4QWcZgVMACYrtm2bbbXo9kvJkV+57lzCoV4RmwtBlcsWE4VPmCcjLj6tjjI1s+NSr1+1
 jG/GmvjYjmQhnr6LPccilYhXjDiR0/LLwx+hXqGfBaBexZAUkPjACY2xAPG1O8v8vFUzpa7+pmdwX
 /e8rFv/alaamtmzWvmGDT78QzylC9YV3n4K/34S6lnDcOJgO+ZLL/9khlVdBVLxWE3LRu+ASdjQ96
 +I4azHLQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xWZ8T-0000BR-25; Thu, 26 Nov 2026 14:03:37 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xWZ8T-000Cwu-0Y; Thu, 26 Nov 2026 14:03:36 +0100
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Fabio Estevam <festevam@gmail.com>,
 Max Merchel <max.merchel@ew.tq-group.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Paul Gerber <Paul.Gerber@tq-group.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Adam Ford <aford173@gmail.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Paul Gerber <Paul.Gerber@ew.tq-group.com>
Subject: Re: [PATCH 3/6] board: tqma6: add SPL support
Date: Thu, 26 Nov 2026 14:03:35 +0100
Message-ID: <6345821.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <b4f96b56-7034-4745-b863-55debaf5c941@ew.tq-group.com>
References: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
 <CAOMZO5Au35UKfYKAXsvJeb6osi19cyLYDQbO4B6HqddEhVq5xA@mail.gmail.com>
 <b4f96b56-7034-4745-b863-55debaf5c941@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Donnerstag, 26. November 2026, 13:33:17 Mitteleurop=C3=A4ische Normalzei=
t schrieb Max Merchel:
>=20
> On 11/26/26 11:52, Fabio Estevam wrote:
> > On Thu, Nov 26, 2026 at 7:47=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-=
group.com> wrote:
> >> Update defconfigs to use SPL.
> > Same here: please improve the commit message by explaining why we're us=
ing SPL.
>=20
>=20
> The SPL is used for dynamic RAM detection and selection of the U-Boot=20
> devicetree.
>=20
>=20
>=20
> In the next version of this series, I will change the description to the =
following:
>=20
> TQMa6 is configured for booting with SPL.Dynamic selection of RAM timing=
=20
> before loading U-Boot allowsadditional RAM configurations to be added=20
> without the needfor defconfigs.By detecting whether the CPU Ethernet=20
> workaround is present,the appropriate U-Boot devicetree (depending on=20
> the system I2Cbus used) is selected.

Not sure if this is a mail client problem (same as in 1/6 response): Please
make sure don't miss the space character after punctuation marks.

Also use imperative style: "Configure TQMa6x for booting with SPL." and
so on.

Best regards
Alexander
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


