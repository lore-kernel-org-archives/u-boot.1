Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE19CA5FA3
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 20:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAE9280A53;
	Mon, 28 Sep 2026 20:59:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lbIcF40DlNY4; Mon, 28 Sep 2026 20:59:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E861880ADE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790629160;
	b=ehDQfeCVda0CzomaiTzw9oz0iHVeQTkqJVcQnFtrI9J/YhALNcNJt27UtcbA09Nyjq15
	 XS2dPnaO/jvQBUsRYNoqMJluHk0HRmecLheRUvmK7mX9+Ti8pHsbIBm/jmHR9213YWLYW
	 wXCLu0stL5ktfpbbU0vYiDCPoh8N4I/g+1fgC4qtBf4DpGcGcRS2RyMzf7abBGjiN1nDt
	 V32FaL5iVhImlmpRsWd59+18Qz3QzWBBGv1UMLjdmJl0kL7sooryeZgDCpuFLxtLzevoa
	 6SoUhFRqJkxLgsPHvK+dpPYvQ6N9nLC/bcYdq9Cj9kB/YJX8hP0l3c02DSj5pkslnNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790629160;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9gv7Evicek/im30w6oh/pAAvyhj95gsNYBFOP72a3LU=;
	b=Ebfo4/pYNU/OEaADKhU/43V0Fwh20ulHXNF+ERSSox00tFr/NC0/L+KUvhKc0F/OC25s
	 v2hTOP9yNUS0jlDeeAn3GOmEoRB7Dw3KtEEE2oPHaRiqFamEPkFmtW0ZAds3ankTL45wm
	 DhjAkkP8fJBVwRnkxfg+117AvZxeiQWWX1H2t0/odbwguVATjiW0fwNeiJ+wceKN4qElb
	 9sGoUg1VVgS/fgS8E2TBWagOvT8JnsJkDOLfgDEeeKat7H96/sCSNWWIyjt/MDhR4310I
	 /bUflftx+CH3+F9o3QOQzwoz3ZsJJuJoalbpXpzgMrUSTx28nmNrLrovpFT5zxFVAvw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790629160;
	bh=9gv7Evicek/im30w6oh/pAAvyhj95gsNYBFOP72a3LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u62LTesMUUXx4HtPiX7SvJ4NDlRQ7S4dpznfcSODhJ+W3ih4soLL1i9mRiIAghSNG
	 6BSuOMHOyoJiWk9OY0GTz8TpyaG6fl4UdQeoj8UDvsAdQMmu/JL4DAz0ZqkiUtF+XH
	 f2lX8zqOY7kJRE0CpH8pdyc8bCA88eTwkICzEHMbZiiK5lTbqRElESLxHbSpqdY/SD
	 wgBnJZIAOtYqFcInAZzY/czBeOK11JGVCg2p9zwtcszCUk0Oopeh5FupYiYacivu+L
	 9veUw1Ulhr4bGjt4rbr+lFLl5Tat+N9SURxRZq51WQwg+uNOmYmwcXrIXbOVotsJ+f
	 ftAZKiYfAhjig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E861880ADE;
	Mon, 28 Sep 2026 20:59:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D2C0A72
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 20:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B87DB4018B
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 20:59:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j36QsGGJqj-O for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 20:59:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9705F400B4
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::13"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790629158;
 b=pPq345t+ntinGkhChdyjixuw3gY8HFX0Jo4B/vtR5JYxtYrZJ8NF6d2KcQx523yBsBCT
 LyruEiypIDvgUJ/Tdypo7vsU3oNFtyiozDCRyIY/GDGFf64dOIHcVEw3OLy8QEzfOCELh
 KCliGpOUU6glZLjGwAi3SALmbbxN2uaHrfSeVgzWFxzqMyM/nwAl8xZbs0Vm9jg472q3X
 ysFV343O8Cr1r+u+zkcxctOJ02l1ir4jH9MBhbOGfKTze3gMZKzUKJLA8ilAnlV4GUZuf
 UpoSne+ZmHjfUDcXdXdEyO63F7YIhgTigSzizp0yVWWa6mXgRKkAwbVUY9WQERYiBSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790629158;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=9gv7Evicek/im30w6oh/pAAvyhj95gsNYBFOP72a3LU=;
 b=sh/h5FcTnE/zz4qef4zKADMf8ovJd+Xx7jJ/En9aHvPMINjSxi54vcijXOZZuJmMIETV
 Xw4vTuCydSytdZOzuNBmiKQKEQ7u0fvnm3JMQQgwwPjpKzulN8H5hAqJmnSI1d+VciJpi
 SkcKYRKXkvCip1s+MfqAVtxVqaIZrkF98GtR2gkYo/d6oHJMZiYTTCqUsyrY/bKfPrAk6
 mC/9uE9bVQHxxhh/jHkr+vdzaVLzEeYOf5YiVSbbdOFbANt2jnPq4HiEZJUkqDZeq4JlX
 6wgT1+xbqwXARsqgWWqvNKttV4bblAVU0Wg3Bjwd71b0MjBZnAjSQEkwFyAwvXyoCgw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=nUsf6eQJ; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::13"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::13;
 helo=smtp4-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=nUsf6eQJ
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9705F400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 20:59:16 +0000 (UTC)
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:ac2:22b0:78a2:84b2:2635:609b])
 (Authenticated sender: vjardin@free.fr)
 by smtp4-g21.free.fr (Postfix) with ESMTPSA id 8DA8819F54D;
 Mon, 28 Sep 2026 22:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790629154;
 bh=MHZY3HBVn/U9bJ+MsnpRbJEVOdsahaIY3Ny3qGK6xxA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nUsf6eQJyQ76pb2xcchw05aMllTM3JHDphVbt7TYeZmfKL0aMbeeYThgDvEvgNslA
 PBoh6K7p9Ex665drqzKdOrXY1zIgv1qmPr6ny4OSAcDo+0/ujHvTO1G1EWJRQkSWuW
 DA9YZr+KlaXeTGBgrGA+3LjZqj4vOEVyGQ6k5dFmt8Jp4tPw0wJSPiw2QWcJNi1cKv
 2Rn0c3PKTdvouZGU/Bz1Qbcy/AcioaAitZy8lQVhd0KJ3vveFp3kfsn1TcG+TVhUzE
 A50rL/Rbp4M7LsA0kTBD9H5+T9d/hU4T5x5vVB4rmc5EgVZYZROylXEACYHM+sufs7
 LpOud4nrZfShg==
Date: Mon, 28 Sep 2026 22:59:04 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v4 00/10] board: lx2160a: runtime SD 1 lane configuration
 for LX2160A boards
Message-ID: <arrVGH72xh8-bFIh@L30177.local>
References: <20260928101330.881662-1-vjardin@free.fr>
 <20260928191412.GN858934@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928191412.GN858934@bill-the-cat>
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

Hi Tom,

On Mon, Sep 28, 2026 at 01:14:12PM -0600, Tom Rini wrote:
> On Mon, Sep 28, 2026 at 12:13:19PM +0200, Vincent Jardin wrote:
> >  .../cpu/armv8/fsl-layerscape/doc/README.soc   |   7 +
> >  board/nxp/lx2160a/eth_lx2160aqds.c            |   4 +-
> >  board/nxp/lx2160a/nbxv3/eth_nbxv3.c           |   3 +
> >  board/nxp/lx2160a/serdes_split.c              | 588 ++++++++++++++----
> >  board/nxp/lx2160a/serdes_split.h              |  16 +-
> >  doc/README.fsl-hwconfig                       |  61 ++
> >  6 files changed, 556 insertions(+), 123 deletions(-)
> 
> Those two doc files, has anyone asked you to please convert them to rST
> and then update them? And, I don't hate the idea of doing that as a
> follow-up, but since we have people touching the files that understand
> the content, this is the time to convert. Thanks!

ok, I'll do it, but after this serie ? I'll emit a set to convert
those from legacy to RST.

Best regards,
  Vincent
