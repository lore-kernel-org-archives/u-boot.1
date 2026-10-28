Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273B7606A326
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cFjyv8dq;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=LucvCmbi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05CF881111;
	Wed, 28 Oct 2026 14:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BPZKrta3ouxL; Wed, 28 Oct 2026 14:55:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25F4B81137
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793199325;
	b=bMbv8ljHfQPR7KWX1P2gZ5fnF5/QEMX4lVZJqmTmD5ZHn6djW0RPsC762Anbnhm6VV2m
	 G8LGh2Z2emRf1ys87/PEZc5+pjevCtW/x1f/pPtvodBbOLi++ItbmHypUuEbCFxRBfd1C
	 v9dK3FnBC2zxbpiQHpbW+AeJnzZONTHFpv9xzIB1dcbOX+FctJhOqL/V7b22qwQtup5nb
	 VltNB7BlrbpDfcZwjVRWoG44mbOr88zlnW/TSjrCwdzMO2IzkbmQtgF9u9HkWcZmVqXuC
	 VsUvSN2oncsPhIMbrAUUKKpIBY4iHINnLjC/DoX6AQjZOu06pFSRVWOUuYZUJe39zoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793199325;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Virus-Scanned:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ly4NuQwy5FyPM86097AKXNmW9jYgbhqbwy2ho57WgtQ=;
	b=cQR9HllW04Rs4GutVg/clAuxObBU7aq156GgrNaTRn7cwBo32WTE9jztF7Y985u3onUI
	 OMHpnkRSt5PlLfB0IASsR+ED8H4y6LYc8T1AuzwEsqAtEXhE5uVUMeGjirgH9H+sn5PFD
	 YJ1gT6jUwkHZOW03SKCe8y2ujeS/QZpKzwtACTYgeKAm1rE7d7fuapiJObEDKTPerDggM
	 5jm0fN/dHhiNaUROKGDYcCnkEgJBkuGqbBzk4ysno8GjE6EpYZp/uoD5VDYr2vaXtkpr/
	 WeNh6bLnyNlJIGOKrgO6lFUEo/i5ey29iRvOj8MDVz5JUJxvdGEufnVvj9BiYwequYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793199325;
	bh=Ly4NuQwy5FyPM86097AKXNmW9jYgbhqbwy2ho57WgtQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cFjyv8dqtnaLbFjgkt4qBJJk6ebRt8n0kzMbLGLVgtXVxgWjlYtYtZud6YuRzNeAX
	 5+gak8u8A4zyvUlXrgOOcg1OyTJzfXIuiJX5KMJ4YUNawRVpivGg298Vkdd4w9gjbW
	 0Jd6oXM/Y2l9ed23UQp87Aw2h5GKR6QFHO7YTxWKrbVC3xCdZSjH8a5iekppwXwaAp
	 wV8HS1QyQw27inLusle7D2CxWZOYcrc1JdtFuPquidS07loEwt2141rBoZoeeAQ5A/
	 ToC6bjLmyzOyjK1onxRCI8AxXukuqDv462EKFbZ2eCyX6BEzz6A4WDS3NoIraLdDW/
	 YFpig3ZLiwa+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25F4B81137;
	Wed, 28 Oct 2026 14:55:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 12C21235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2C534008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bdoVtnwi-4P0 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:54:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 533D3400AD
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793199297;
 b=S32H5Q60836Q4KqIg5qhB9FERwd3uUHokVLKgyTdxWKa5YEBA6ILeLAvMH0MiF/xeoG0
 lZDcK41mIAEl/UOIAZw/7QnbbIPpKLCOhnESiCptVcpmDGe+fkd9DYcPM3KjhKpLBf1gR
 FvgjARBClTU7JMqfB/iJPCdeqSyKc16/ET05/W883vcNqgIrTOIgBVGoDE+YZXJRZe5rW
 kyfg7k7hyY4SINFUMudKfZZQJGmi+1eWnVOF1Wrqx8dgqYJnJ2Sm1+vkdH/X7Z336h1H2
 /EhIHZENdr0tkcFPiRbKyHK//OKsVghimthDDsQAhQCEmekUiISabdsqQ5XvQDbv1bA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793199297;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Subject:
 From:To:Cc:Date:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Virus-Scanned;
 bh=Ly4NuQwy5FyPM86097AKXNmW9jYgbhqbwy2ho57WgtQ=;
 b=sBPsY3WeojC1E5V7vxS3GnZTHUkae/bBvWWpJTCeLbpILM9FvvjmIF/KSQb82G1CWLwp
 KViTiQ24xxk5k+2plMpUfolGZZrNkNIIMRQvRlvib52HA7pn+U0Js0vkIF0F6bwLtS1K/
 vpH7cfK205nn1Dyg2lk4+q19e8Jw4uYPIfOuOJJDXTFmYq2xGu6OrNBvOtVpHxF534xPa
 KKMNMEt4/Csep0jl93YkPsPfhh6uGEWbVpyfyqGk9kzoS/l+jO9fgyQzbdahalmgCw+q1
 bDIqdwKtZx4EfNDVcnQhj4g0RO5Gtw7SLFw9ZWQkLs+tne0YFkXZadDRM8JfMv5KVDw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=LucvCmbi; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=LucvCmbi
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 533D3400AD
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Ly4NuQwy5FyPM86097AKXNmW9jYgbhqbwy2ho57WgtQ=; b=LucvCmbi887C5W/CODPrguGP+o
 Kd7T9Km+UlLtaHSdXJeEdacjMJ9/cCRB6jsXIHVkqoVemzmQ+9XreQj0K7uagHpSeQO+MfV6RXXlr
 bokhVFN7z/d4TR1Ae+1fWASs67TcnhvWcxIIpZDJ+TsTwBGbuVYDgWzZZL+iy51ORr/vptc4deb7b
 FNh5S7SMrBAPijAlUHNEb6NhqHq1zUiFQf9EbuwlKKkI1xZxMlmEzkA4PBbgwk51hLGR9zPciuQPS
 0yqTweJQhmPjSn4/uz09w8cigRzWdoks6MBk9hewbJOvZHjxeKMZG99B/++Nxj7+E7MJ9/PnUU9p9
 ieBshQnA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xM53D-000KVF-0Q; Wed, 28 Oct 2026 15:54:51 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xM53C-0002gn-1O; Wed, 28 Oct 2026 15:54:50 +0100
Message-ID: <79648af2133070a0f6fd9273b7b5870c79fdf2b6.camel@ew.tq-group.com>
Subject: Re: [PATCH 10/16] usb: ehci-mx6: unconditionally run usb_oc_config()
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Marek Vasut <marex@nabladev.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>, Fabio
 Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>,  Tom Rini <trini@konsulko.com>
Date: Wed, 28 Oct 2026 15:54:49 +0100
In-Reply-To: <523b0b3b-f260-41bf-8455-b58acca52b03@nabladev.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
 <9a416f0664c8594c0af0573b5385dc4cef7e2dcf.1793091394.git.nora.schiffer@ew.tq-group.com>
 <523b0b3b-f260-41bf-8455-b58acca52b03@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.6/28167/Wed Oct 28 07:24:17 2026)
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

On Tue, 2026-10-27 at 18:25 +0100, Marek Vasut wrote:
> On 10/27/26 10:39 AM, Nora Schiffer wrote:
> > On i.MX6/7, VBUS enable and OC polarity is configured in the usbmisc;
> > there is no PHY driver handling this. Always run usb_oc_config() when a
> > fsl,usbmisc exists.
> Would it make sense to add usbmisc PHY driver ?

Having a separate driver would make sense, as the usbmisc is a separate OF =
node
with its own compatible.=C2=A0Thinking about this again, maybe not a PHY dr=
iver
however, but a UCLASS_MISC - on Linux usbmisc_imx is a (subsystem-less) pla=
tform
driver too and it doesn't really implement any features that would fit the =
PHY
subsystem.

Best,
Nora


--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
