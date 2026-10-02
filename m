Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C4ACA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 15:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B15F240D19;
	Fri,  2 Oct 2026 15:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KtsuGx6m8WOx; Fri,  2 Oct 2026 15:26:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1FD0840BCC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790954765;
	b=KcjFYoT2QBg0on3/ecTEDRyEyReUspxSYJQE++AOYk3L0do+Iw+iKA5dfyYrolvkL4yM
	 p+ZyhYPlipH8hKzrzKuw3VKh/PL9FqGHqwALMTuiWV1YV4LU3jj2YqiWg4qJDMm7TXNaK
	 c3NDpVLC18F56vnRzVMXCdfsAv0JnMkhJoVCu+2b8TeG/sgGeZqy1W8V++ZHRDYhrErVF
	 QBhhuD53q5IkrCd5j4gJ4OMr6G1zqy55EIEdNMQVRbqsXurCQArLoH1WmLubF6l5t8NOS
	 rRvqfFNH2jJDS6yxeXLZpSgwSoLpWhVqk3rUj32S49HjvJjmiZdeWvZm6GPFwKrgimQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790954765;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=G119t4CG1nNxUvimRo5JC8uA73Cacbzmtf2lsi9eyCQ=;
	b=QeDqZJOH07xNLcO41eXiUKsNR0xXTgbz15h5Is97wOzftb7GbY77oQ6KNnPWTzhK7eps
	 HKechFAvmlxkaMGaTdEIftz+rcI/edxcJRJt6zsnlP7P/zzUgXBkoVwTSXKJSQV5TCRxP
	 mLNrtM5sEPq0qfmIrEJi3esyAI2i3ihEWcmgVszMi5hPbHhe5U9X1k1Ska30OMQt3Q+oH
	 8laViY5rroU0cl+J710+burtVrDRfJcFe9fZC7BU2QAt6G06FFb/B2z7icBIV239eKlO/
	 3eDfpZhEARmvcIJK1bZnfqqRMWEaK6y40uLuEWvPLCXbscRw9jXKUlltSjwyHG3Ppag==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mfnQ3dOC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790954765;
	bh=G119t4CG1nNxUvimRo5JC8uA73Cacbzmtf2lsi9eyCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TvxtEM+6UXmOPjbIfvpzNUZEpDs3uYl/ocSx8CHpBNKvzKWl9yHiSxm+q0EeaItMf
	 hiocxBc5Fn5+K3ZszD8jsBjS6Pf93gAMNTtipyhyYX4eNXnWluNRVfgR01bNJZ/fKk
	 onKaKTyZ+SEvlRE8g8be5bsKS7YKZaX9g743i5XLM1PxFJg7UaU2nDAzB9k6E16imu
	 mppJk77iA9pzTjGcN2WVxJtiSddAkXhMID8u8Qj3yPsKoi8jskR9qxiuM0RgiAGRCg
	 VxXRoqboFqqglVnlEIMRs4nshkp7I7M3f7zWQodEBEH8tYcbRwypTfP/mIpPPzYKb/
	 5jtYBli/gm14g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FD0840BCC;
	Fri,  2 Oct 2026 15:26:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9018E3AC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 15:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80FD440BC8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 15:26:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2rlEDPKG_pCh for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 15:26:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C481240C88
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::26"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790954764;
 b=MnZHOg21T2iMz8msMcs/0Ba/ejMUlS6CC1F9lh9jQCipHtSbXDzD/bvHAlR0l4XkLtok
 MvDEgqGfnAfqC8XP8F/72guWlOl/V+ojTrTDSpY8ftBmk8M/tsuSzTLiLhCvzc+5E+lOA
 5LshJus88cPbX2sdjlLedAdoLdShbpprUVBXXebRRJB1dieK3RRn2rZDyA8oWHI+3b+xY
 B67VjOzCVwIDtn6TyoYZxRM1V3oV2cP3y1+rKaj3ig6Xt+Ruu5JsrvbHCu4AYEtYMFwDL
 UEw0D9jkqQl9DEerXJOBItd/IBwdz3An2BZdUmyOeK0gbHIdIoC3c1FsR2QCItIZMjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790954764;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=G119t4CG1nNxUvimRo5JC8uA73Cacbzmtf2lsi9eyCQ=;
 b=VfOe+pNPAd3S6KuM8H5lnYHerT92rGdXYr/wL9r69CwW7Wv4tY+O4qekO73K8WINWFC1
 VWNWh4WIyy/tBj4lgX+ZrVkyPqN0KXF8XF8/I9rjgAmqfGX+6DvL8LIxwu9j0WoSAtMIW
 7gY5SJuTXwjpfwEB1Tpk0FZ81CJEvE1Ur3qB2jDbpSjoIoY0g7AtctppgZfXDXUBIq+Gv
 fVDWodmEbuGSqRt4eYmhLMgZrz0hb3SqXdKdMLB3LQgoG9fs94uOW0JqlDurOZRtCxexe
 3BXemeCvT0yfqKfvEuS5xFkQOPUSjhdHoWu6X3yhPSlK9EOcEy6xxJ2GwE40RhDeRPw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mfnQ3dOC; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::26"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::26; helo=mail-oo2-x26.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mfnQ3dOC
Received: from mail-oo2-x26.google.com (mail-oo2-x26.google.com
 [IPv6:2607:f8b0:4864:31::26])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C481240C88
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 15:26:02 +0000 (UTC)
Received: by mail-oo2-x26.google.com with SMTP id
 46e09a7af769-821c01c2fc5so10060a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790954761; x=1791559561;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G119t4CG1nNxUvimRo5JC8uA73Cacbzmtf2lsi9eyCQ=;
 b=mfnQ3dOCM8jooWscDwO/3sjZHfJhPnDDxQzCJYfWFndgJwxtk7xVmikgjIrftObl2e
 bz7Z6fZ9+XrxzMNIX55xMZcX3X+VyAbWKWEu4K7VuHRT8RkYPPYr1Uck6iuoerjCDDIA
 Q+JLGCYHKLEyV/EgnBBMKW1eG8OEIITdLyfXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954761; x=1791559561;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G119t4CG1nNxUvimRo5JC8uA73Cacbzmtf2lsi9eyCQ=;
 b=BQJatzx2ZhZNVUYQbIB7KXcfJ0GKxFoO+f/p6puANqLHHkFmYzIWYrDYiRI32WYOul
 GM5urFQ6H3s7FfmWfMwlbxragp7JeuO8jZSg3aP6yBC2TQh78cQkGhIaDBIdPaWrjWny
 0qkqM/SLUIuWpuWwBtkgOBSZXEeYuUb0WQKb9hw2+rP7YpLQEM51hIicXCFw2puhkv0d
 luBKrv1PYW2pFVTS9R2jM4Kr7JaeJgcJbtoNAuxQGkMKgZxDK2WNSClsLRnUUoMim4H7
 A+4BVdO9maTMGM4fjz0HvwXeO5Xg81PjjNLxSrBRv6yazgUIKNw73bW4VvZpEZjLFE1P
 DLRQ==
X-Gm-Message-State: AFuF++kMqtzRNqrGelwjGVXgppdPrfPqlLj2rwPo7CicGYcAS89DkTlH
 eS6xWakBKuq7S7TLV9BQR6RNp5n8ypAf5GJbhfgSoVR8XlhmGd1gIFTgTFWllTd5IR6yDiZEibs
 cM+fx/6cx1d/P
X-Gm-Gg: AYBFou3RImoa8g7G1ZyDJ0aFO4rwg0/307My67SfmYeYbH6MfpBXifS9c2usDQMipn7
 9PCxzVS8YCV+TiX+JAC8Id6eMWKNCm0opWOuZFKnZ2ZIVIbWeBWc2505Vud1JK1fiIgDLFtZVUi
 9K+3t2YNggzRT9xRs3cf76XP5jBixjoLYsKYVE/VNnK//0oBNSxoTP88jINo00xdrfobHAqLCPL
 G5YUEciYvFnzslWhL1eS1j2dNG/3OlCuq7agq3dPF+bgMUCK9x4JaSe2Zpxhmq8XTMA/jzTx4EB
 yF9K4MuU2oE7F9IXm3+DGKydU5GUQ+jkD1InbVT/z/udWSmssg8YfbLtSTO3rF3ARDp/QGGgan2
 36IFPIPLaNMSHZx2yhU+okXSU3kK6nNifQaQmuaRqyzZ/8h2eFsjVvfNUKVbgTSbyvNMND5HWSs
 W1YhUXxf6znW72TMcovAzxchPGGzrHBgCIFgReBuYoS/SzFbL5LriRsLtm3028UpQpoST7+z5lz
 6m8LlNXxllIyYEPv7cgax9Dv5+pqV+9ycL9i4ySMNf5UoJKVs7nsdWgDVtHOrUnhyGn8WzkAlwe
 n8HkC3CCNUCCq/gtbyQ=
X-Received: by 2002:a05:6830:2656:b0:81f:8f5f:f1dc with SMTP id
 46e09a7af769-82281c7f839mr2583159a34.8.1790954761283; 
 Fri, 02 Oct 2026 08:26:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8236f631878sm786084a34.9.2026.10.02.08.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 08:26:00 -0700 (PDT)
Date: Fri, 2 Oct 2026 09:25:57 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Guodong Xu <guodong@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Chris Packham <judge.packham@gmail.com>,
 Randolph Sheng-Kai =?utf-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>
Subject: Re: [PATCH 01/10] iopoll: Add readw_poll_sleep_timeout
Message-ID: <20261002152557.GS858934@bill-the-cat>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
 <20261002-mt2824-v1-1-bc44cf0e0289@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="14k9vG9Nfp58rRZw"
Content-Disposition: inline
In-Reply-To: <20261002-mt2824-v1-1-bc44cf0e0289@bootlin.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--14k9vG9Nfp58rRZw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 03:02:19PM +0200, Beno=EEt Monin wrote:

> The readl poll API with sleep and timeout support was introduced by
> commit ce786ae3913f ("iopoll: Add readl_poll_sleep_timeout"), add the
> 16-bit variant.

Please be clearer that you're referring to the linux kernel commit this
came from.

--=20
Tom

--14k9vG9Nfp58rRZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar/NAgAKCRAr4qD1Cr/k
CsHrAQDl2nn7wuQ39RJFPC8Bs22WZoQUE2/hGiKfkixyZw+oXwEA83YJz/ErpOd/
UFjAAX1srLQjwb9zBaleLOpO/xUkjwQ=
=tZHj
-----END PGP SIGNATURE-----

--14k9vG9Nfp58rRZw--
