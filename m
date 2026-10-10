Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9A4CA9EBE
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 07:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8E5681103;
	Sat, 10 Oct 2026 07:53:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xjfHitRItIUK; Sat, 10 Oct 2026 07:53:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D0328100C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791618803;
	b=cJzs6xV5eackylmMWaDArlm/RDlGDRDHZIVO8sIBnydMJMz/rOlEUfNcN9iX9nPW8yDt
	 uwi8a2wfQYbydvdyA3b0asIw/ZgX+nvYD3wJtA+dsrLK5tvNo6DOthZ8ZOvpiv4ajnQ7h
	 ik+YWJ4M5BEl2XGFyW4uRy9CFD6pxnttsZv6yLX9M75Ee1l+F5vp7PQj1ErcTm5HlV0CA
	 MKnrBDtJ7I8wEEFSa/+kgykKOb27T+4o8dLmyYWmv1FuL7UZP/OpcmZF3zvx9wlqC+JDR
	 X4ETOUP9kmCDHWtLu8tYjxkxfLuNvseYTjIB/Ll0EAks2Y0+zDjKooIoE+61Ny4P+aQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791618803;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=po2+U0XCsarNkdMSGPltuC2h6cZ5VhhiOJvZLlvPBYs=;
	b=HxO+mI/6jsPsL9LdWGzqp8RSCMLE8fU5QUkoXI0csU9U9pXk7a++az2V42Z0J1gtLjcU
	 8dx3KkwZu4X1FNIeKMHdHnZLzld03k8xD1EIowir6tDflOpsPRAZuXI4DG5TrgsFb0cLa
	 FlABJ3qzre6NXUXQOmu004ppYqxkUgZ6AO6RY4j12LV11DlTqjos35yaLqurpS/h1R5dA
	 TZ+q1VmagE2+NjkAqXsr0ObSZw8BKD4KnGAJS1g/+RvzBpmPXZBTVg+qnvhcvpfkoRGWu
	 5Ar4aPj+m99CAIsqAgEmFvLYb9gXAAaeGsWynigl0T1URxyQWtPgMimBdboJ8M0jMUg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=lLgIyItK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791618803;
	bh=po2+U0XCsarNkdMSGPltuC2h6cZ5VhhiOJvZLlvPBYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nbuzyaqWRCj+rb25vVqx6OJV6UMSOq39aM/p+6vUInBgRR1BT8F91SQVX6Df5ZBBI
	 JIKdQcuc4VUXGVI/clUEq3DrouKsBg49JqqAaHj+BttGILIeJ9bgxJE/DEwvm3gJzO
	 Xpjqbk+Vyh4WqpLLC26NdWLV4v/jOVXhmzaGNj4G7Tek8JDDZ+6FEefhoOtkqXjcoN
	 A6ksowCxoHRdqpWeQUdL6LZpgFwnrfdAa0AqOKaIwjH0ozoqAEe0Oi2qX0LNZ4XdIl
	 IFMMZU+7Jlsq599oNPY5yWmYgiSnRyflThsZ7URdQHeOz7u48UegofqMPKlEp0moqZ
	 zRjIoTNxnIs0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D0328100C;
	Sat, 10 Oct 2026 07:53:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BB4FF9D1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD13380FFF
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:53:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VEtVMUIKhxeh for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 07:53:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CF86D80FB7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791618801;
 b=sNhHHbihqO826+QDgAoYe+HMTGZteGGu815zXu8h4eoqhVN6F1+hbW78eWg09+QIejRJ
 zUP1SkKMadSNAP39r2WjxiGJuA5mw8MRUna3w6DL3Z4ha33dhtftzHRImSgq3JadO+hGS
 AwVOuvZXzYKFqDmNrsUl6qRdu1vXCSgSxMQOofIe5CRMxZb9WrZWULs/v82Kzx0Sxd1rZ
 +Ww6N3tZKBOLs4JPMS4h8rcKkhQWBxkKhbST4xwSFjNxKh3xKx/63TYm9KLsTB9A7MAdx
 9ZDfwmvRVP0Yiw2EfUgyINKE3sZ5UtsW2vqx64B8Tpu5eKhOV5F+9wGvjT/aNFXjAvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791618801;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=po2+U0XCsarNkdMSGPltuC2h6cZ5VhhiOJvZLlvPBYs=;
 b=pSjgal0XXuJLdnXolT5JYnj1atQnjTXI9rbOK31cvFRu2l0HZCYSvMdUbfytVOYqmw9t
 YOeSD2CiC1gZStMorEO0k2CsKdeUpK3grgbUf3QaFmi56jGJJquvxU1tlWShdD+fYdz/H
 gpAffNCanrBlVWZkLIN0iZa9untUJ9/Zxyv+IZzXEryCy2mXi180jkTW7VaEN2bCVsz4h
 LroWY9cir7vxQ3+ZgowqZGfbazubvMJu43L1kIYK3P7URzJYBlijryM9QvxHnGyxVzJvP
 QD7N4vNMDfarpZPyrMpHNt2u8QnPNwWI376SAT7hvaOhdsdWnq9g3Dm8BNgjkiVKNjw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=lLgIyItK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=lLgIyItK
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF86D80FB7
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791618781; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Pp3mHiMzCU1dGmh5hDlHYoABnOOKc8l/6tpomrVecrch5ctiYFTyi4ogWd75ZCDqAbFXkLqr4+uXGo3B7SnhLQVvBK31tV6qhbKiluGXspOB+rK8+D9S3ciUd/GsAxyUbT+mgkyHFXU38l+QDbxi03EFmoj4YffHtymjR0p041k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791618781;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=po2+U0XCsarNkdMSGPltuC2h6cZ5VhhiOJvZLlvPBYs=; 
 b=ATEPs8kjWKqmvmQ2ceVBf9zoFFwzX3zn5+dKmxkM2EcH1jGdQZCCzG0MRrPQkpH4Vcu7iKexCcnUVV5+QZ0QG1E/HZj4OnE3Uj0q9o8QMCaDWEnF8QcpT0dBro+MZQum42ohin34z1WM6hxhp84WIudldaAcXuzVUuGAs2ofc+E=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791618781; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=po2+U0XCsarNkdMSGPltuC2h6cZ5VhhiOJvZLlvPBYs=;
 b=lLgIyItK4vmC4nioAVTOjEu9xF5LAbPCVsm4jZ3Y/8iSWPBitPzvzHooWuaU/CeL
 xNoHM9ogel80QpI3XY+z6bbAnDcUzNfWut0FGVUk9h51A+kmts9bPosKjZP+KSvouSy
 DupUHtF2ISRW83jlNbmrMNmMs56L17KK1LJ8sYTs=
Received: by smtp.zohomail.com with SMTPS id 1791618778568550.1486148928565;
 Sat, 10 Oct 2026 00:52:58 -0700 (PDT)
Date: Sat, 10 Oct 2026 07:52:51 +0000
From: Yao Zi <me@ziyao.cc>
To: Hiago De Franco <hfranco@baylibre.com>,
 Leo Yu-Chi Liang <leo.liang@sifive.com>,
 u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH v2] board: sophgo: milkv_duo_256m: fix fdtfile quoting
Message-ID: <asnu01a12_v8TK5_@pie>
References: <20261009-256m-fixes-v2-1-33405d040636@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-256m-fixes-v2-1-33405d040636@baylibre.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.596.93
X-ZohoMailClient: External
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

On Fri, Oct 09, 2026 at 11:38:23AM -0300, Hiago De Franco wrote:
> CONFIG_DEFAULT_DEVICE_TREE is a quoted string, so the quotes end up in
> the environment:
> 
>   fdtfile="sg2002-milkv-duo256m".dtb
> 
> Use DEFAULT_DEVICE_TREE instead, which the build passes to the
> environment preprocessor without the quotes:
> 
>   fdtfile=sophgo/sg2002-milkv-duo256m.dtb
> 
> Fixes: 98b59e181daa ("board: sophgo: add support for Milk-V Duo 256M")
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
> This is a continuation of
> https://lore.kernel.org/all/20260930-256m-fixes-v1-0-69546876ff28@baylibre.com/,
> as asked by Yao Zi.
> 
> Tested on the Milk-V Duo 256M (SG2002).

Reviewed-by: Yao Zi <me@ziyao.cc>

Regards,
Yao Zi
