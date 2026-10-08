Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D57CA6016
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AC6B60808;
	Thu,  8 Oct 2026 22:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P7gmmdyjQ0hj; Thu,  8 Oct 2026 22:36:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BE93960832
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791498999;
	b=Y+mMY/amTJWNnHJZ8aCY6fKOjGsKi0XPHMruIe/GDeNxsPqLq/3AdDEn6d+9NMmDNWA8
	 ziuDsfJBTGka9K14pDHYOOKOavJYiee+VbI4qIZJDAZk0gDJbK9EIDHCLdiK9rG5DzeUs
	 Q5xUASl66ywE126owXLeo8uYThBAL8GTczvbYkiPS0NkVczxTy9+mXlRDiwN5fVHf3od+
	 XOc1CQeMIiGFcnreXHR7dexrZvquXwgghH9Rvi6mGDmQzOXUdaSE72dipur545oVduVYT
	 jls57JHOUEva8oL1rN7eMBs2Cam3hwDbUXFgsGzbV8iDUv4hrQp0JivtHSrV3VVDKMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791498999;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iZOortZNrdloHVvJNrvaVGmtFwSop+6R/2c252q1R5I=;
	b=a+jwUK81sKdhee1VUBnBaq3rHv3cCGLk67ozSK5cbd1uekjmZxJZvyfaQBhnWmsSIWq/
	 ep7W4aLT/bKYAc4cyC/anXrhxbYTe+iRaNtNLFGDAKQM059MRfRdgqodIRdNeKxjvnvPs
	 LZorAsd1wlxjOvBa+lxtFYgsD4jmrNTOztQXU6EOtyUWOClv6sQxK+lh/8OyzTUMeI1lA
	 l6UB6Zg0S31LL64Kz/4sCySVo1zfm2K9iEU1XS/MH91wWcUAmfeGHNs/lDKCZHKpkrCbX
	 bT/C6aaW8wSJSMb0QDTh+wOslSjZSYEY7dUxChYta5hpqlm8K/JIetsOwCtgNtRK6Rg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791498999;
	bh=iZOortZNrdloHVvJNrvaVGmtFwSop+6R/2c252q1R5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fORl607/P+4Ehv7QFH59I4diwogmEb1B38J5QgYB8bqL1koZLJHnafVIO88Is4MVP
	 YV9CnnqNFj/4tGd0aAEp2EgfMeX1TIenpxM4haj+6pO23PdB+d1yhrDBHs/aHVmFFb
	 ZftSjTlLtUjz+EtOVf8ejR+9j6eLKrzUY+CwINKyrb0VB+cfZLEifyLrSiKxnVYklB
	 KCl5igFGyszqyfu3hM+KdmmFSzFQI3kPUWpd/lhYiiAabol1Ctey0JUEwd0W42PdnV
	 sw6tI2YEhvmqCkBqgtfH1zz40zI5zYNMwLQkQEd6e76/VHx0TJ18wFwUD03AgDq98F
	 Ki/2v5UkJUIRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE93960832;
	Thu,  8 Oct 2026 22:36:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A7F18156
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DD3940098
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WpvE4CZCmHfe for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B50204006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::15"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791498998;
 b=BEZLL8F3V57hIsqJchzEe85SuaEf/GpbzRLH4QFdXhUFwyUn/YHGGRXUjMXlJaw6c1T9
 lDlTAlM+eUdqbyw+BFMOAAxyyBaiOrF8zGF/l7QeqwsV3eoJehxRSh2KHrvcyZoOpP4a6
 4McmZeHXmp2iDIUn5PjwRLfVS1G59PzMkl4NdTxqQwp0S5htp6m5eqn/9vEz3kKx5euQC
 wtGhLbW0UUYEqZeRLufrvquDlLZKucYIXiBK82NnQCCR2CiGui4TE28+YbH0iWweWfm/Y
 Vfa951g5ToL9L1hCWCGSpigNEUnfRdLW1wPM0Q6FFST0Lu1Bq7My91q1LGBkLoorA0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791498998;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=iZOortZNrdloHVvJNrvaVGmtFwSop+6R/2c252q1R5I=;
 b=Yvr2L2CA/WwdRUKEFuSBXA7GK+1R3OMeO5j8UTmcfc8/I7zjVA4ccesiIcgc+6FYndyE
 rwcwBxLku9RNttOvC0B5uYwyRYIxWxN6vlx9K0luJEMxB/M5ax/0tLZZPCfHnBU0rzDgF
 es5fNf6cJ43/A9E4GimkWfFMw+iR4kY5KKwHXeVIEzCVr/lstiSWHA0cohpO37hENdpAK
 2NzYj46g9gXNaDDilyBGlJzdlNHFJ9mds5xVYiNhimHBGfqMMi4vwyJWdZ1LBGa/hz24T
 GXfvQ3cWerqvDE3n6/Tg0bwha4byvHA6LVb4dVBFSXD92afhLbHTMw4f381o2GjazXQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=qiFfbg3o; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::15"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::15;
 helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=qiFfbg3o
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B50204006F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:36:37 +0000 (UTC)
Received: from L30177.local (unknown [IPv6:2a01:e0a:ac2:22b0:548:36d:1051:820])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 7CCD3780331;
 Fri,  9 Oct 2026 00:36:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791498996;
 bh=NlwjV8WHbHCtequnYq95BWvAlOl80q8YUHcO6XvUa6c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qiFfbg3oPZpdKiZqWiWqGBZ6F7z+BL1+qPennMpd490fngTeAKyoIBvHSJKpUElRC
 2H1PZOCX/xIAAtAEZTpox/OBhybmjDArEpwP+VOPiJsf/4cna/8Eiu1oH8tn9J0hwz
 rc+gH/dK37CkQH6TcO11DqQF0YXq2wn5INyNx6caeRwQ1lY4JhojtIaTIdBM/sKSBR
 Be3gYZH4ORfgGTPqb8ZrbWAjZz5QwscE9g4cQUD+q65BLDyrm1IwEVHK/6yThLGfCv
 KEuG28w06Y0JxqsY2JB3jzsp/g7N9JQAXAQM7SIYAbQGWOEz5pgnSEzD9aTH/yCrRm
 kRD2zVP1W1Jsw==
Date: Fri, 9 Oct 2026 00:36:26 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: Re: [PATCH v6 12/13] doc: lx2160a: document the sd1 hwconfig option
Message-ID: <asga6m8Voff3NFtf@L30177.local>
References: <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-1-vjardin@free.fr>
 <20261001204731.1774613-13-vjardin@free.fr>
 <20261001204731.1774613-13-vjardin@free.fr>
 <20261007104737.siyopctt5alyeehz@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007104737.siyopctt5alyeehz@skbuf>
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

Hi Vladimir,

> 2x40g should have the "SRDS_PRTCL_S1" field as "13 or 20" as well, no?
> Because protocol 20 is literally 2x40g.

right -> v7

> Why "of protocol 13"? You could simply say "Active DPMACs for each mode:"

ok

> For clarity, I would recommend one more column

thanks, I'll take your recommendation with the template from your former
email.

> Also, I think a clarification is in order, that your SerDes1 protocol
> naming convention needs to be read from right to left, compared to the
> SRDS_PRTCL_S1 table from the hardware RM.

Right, and it is good to mention it since I had face that issue.
I'll comment it into the v7.

Best regards,
  Vincent
