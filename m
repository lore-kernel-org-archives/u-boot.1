Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BEDCA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC11481198;
	Thu,  1 Oct 2026 20:41:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8mudNG29znwY; Thu,  1 Oct 2026 20:41:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EB10581162
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887296;
	b=s/TlhLqiHgvbws2+IMAeetLN87GEvkzQkgJXE81fDpsrmToCDe+A7Xabj7rhfNJW3nBF
	 qf2QK5H0lmwamKIfBVjzEmtKiVRR5pHmdAuoZHIgnnBE5fbZZ2S/CWoemRTmuNb9VzBHe
	 3V3l+XG4CVMFaXV00zmhCYknFFwKXcWmD2iaLOseivp1pNk1LUrGIL5ifWR5hX2xTLSKc
	 71AoulkUj+oaJ0fC2WHujdZTWaQDfNLr6SZ0JsMFWZfPDLmVrJLFy5VQx/jLcmHLfi/4Y
	 Sdp0GIJlQTrROmrsje3H4NGIah4fFAqTcQF41r/RvuugWc85ZiZY79rejkauJ8swwCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887296;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y+1uLCc7I78wo+ZI31k78xF8He0HKBD8QTMmUCm7cvE=;
	b=UPaecd37/2g2fu3Qvg6IxIf5DQ7GZQEFO7jdXWzY30WA7uha/2Rk0LLytayLu+LdSsN2
	 T1EO68uXIamQMvD/1owJUI0UVZRS8ZOntgCEiV6sxiJrxKzA0g32eLf0Q1C/0vOoJuG1e
	 U7GJFjMoG3l1lOLSsRPSOfoP+Rbkie8P6GOtDvEvCSMcgiz/5Gz56OYKnr6ehM01iN5G7
	 B+L8RLC47gD9WbdwE2FTmTCp/x+p3W386TuFBrugqgbyhRO71ar5GhxEtu8Y146/yVdL9
	 J1UoS59+mt007b+Dysi9bxAavjyrAT7ksKKh6bqurx3zTJsgmdpMU+ZcovuhOlN0O8A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887296;
	bh=Y+1uLCc7I78wo+ZI31k78xF8He0HKBD8QTMmUCm7cvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NQDHltyYHkKwygij3lHyhs6S3K97Eg5Qsz7AlziI5WEYLs3DAXeETk3uSs/nG62Y4
	 2A1yhlSZ/y1NTXfUQi94B4VeMweeuW23qf9JcpaFwGFBJQtNQgSJ7hQIfc41fHXH/X
	 icPfxkcyJTOgoDny1lWZHt5Kh+Gv1cZ27Glra25L6gXvVp7m4ccBGG58d7L9BuLvUI
	 xXX70ts1dWCMmyCKLDzYEYNeTs4YetnX9ibgtcWrSyIA2zdshhSEDrHDbKQPLePpY9
	 5jrcGVYOCB9lms9o6fR9QTRBDoYFUwAVOQOpqz/uJYip/yPq8rsPpWB/tvLU4KSrUk
	 FLpJMm78btAew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB10581162;
	Thu,  1 Oct 2026 20:41:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E52DD33B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6D5340BEC
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:41:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T45Jo27eDbbX for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:41:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2EE6B40BEB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887292;
 b=nHFldrvKLfJ//Tn+jDMMYKSqwkIwSPq02ApUbRfWF2jh+b2SUmHpDtL2WYrzvbD4Gusc
 2tsqhaZi+1KmAXtXjYfOoX8DU6T4QdArX+Ab701+R4TEWlh4JHQFhDAuPheI9T4//g5Af
 w8uLRzyr05k2tLFk8UWIXSHKyXkF/AlfEB667jyY8o4Uz5P9PrzJj0KK3Y79Uy6a77ZW5
 dMAbFNRWSXNMok97HxODet7G6S7lAfvav+7eUs7QLC/qyKUy6a4odWlnCHfhJqVtxGvJa
 GKMNJ34mjZ6g7UL8J7zDh4kDsPj+LYyjmcnwYo0xswdBLJtVbEUwlzsBFR4HCf3+DTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887292;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=Y+1uLCc7I78wo+ZI31k78xF8He0HKBD8QTMmUCm7cvE=;
 b=RmPmMXtOWObBsPK3T1g250LQsCiM0IGkUiFkZNHQGCmP2Drcp2WEK4uYoUIYDbzSzPt0
 oeZ65HTaJmEcsQIM0auyn5wSyhVPZ8uRz1MVitWoSd1ZBtsVEF20cUsHWmX+TxQ1Cm1wM
 cYjfgnZ61/ES1peft39pDeGyIXfonFj+pYKnVle1chELzPffY3mk2dRqFRNZokshQQo6i
 xmvR1fhXVQcswEJWsftY9lW94MU0a1cT7yqvNnt6c4rzdaDQu8jgmu8MbbwevtZjMhumf
 NfJ9RL/wz3F99CAg97AqRlI2p0qMt4Ylx5HBqLrgONo7Ey8EJ9sikfySufrpzLslDMw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=uhRnXYjq; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::11"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::11;
 helo=smtp2-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=uhRnXYjq
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2EE6B40BEB
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:41:30 +0000 (UTC)
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:ac2:22b0:4c30:72d6:1cef:7a3c])
 (Authenticated sender: vjardin@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 1D8152003A4;
 Thu,  1 Oct 2026 22:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887288;
 bh=68FJFeGQ3YUSk0AYN9u7enx0zq794ofate2RR5rzAXw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uhRnXYjqnuQnwxgrGA3JEYTDYyXq/QTUZCdhBfRwZrO/vKzTr/mq+VQ+j4yWXCPtF
 SR89fafDqIb+xOTQSEbSV3wAWaQ2mHBOq7+nWmSgkaJYPfsCAhgmBqh+2RpleE6F0p
 gDdz9VgvuXvCeYmLCeOH1yF6F42cT4YwUZN6sAW9DWQZvPkhGcVQXmGnN8quoQSGK4
 nCTyMLzeE6OVZWAuSxnRekHWwHxQBHFPyKgEqwQdHbePH9BSguIRtKCIHnPyy3XAHH
 XiIfaR+Igr1sslv+H60MxhvbpVoz6RZLEqqriZ/TcNIf/2uBchxQL8ACYlyeTUVpeN
 WR/ENj+s24ngA==
Date: Thu, 1 Oct 2026 22:41:18 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v5 12/13] doc: lx2160a: document the sd1 hwconfig option
Message-ID: <ar7FbpxWqAqVZJ4k@L30177.local>
References: <20260929175947.1379710-1-vjardin@free.fr>
 <20260929175947.1379710-13-vjardin@free.fr>
 <20261001152514.vkcl3mw7gaz67xqo@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001152514.vkcl3mw7gaz67xqo@skbuf>
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

On Thu, Oct 01, 2026 at 06:25:14PM +0300, Vladimir Oltean wrote:
> "A reference clock from which 10.3125 GHz clock net can be derived"
> sounds like it includes 156.25 MHz too, but the code is hardcoded for
> 161.1328125 MHz.

ok, so my draft for v6, I'll use:

        - PLLS needs a 161.1328125 MHz reference clock, for which 2x40g,
          40g4x10g and 100g4x10g program it. It can come from the SD1
          PLLS reference clock input, or from the PLLF one with
          SRDS_INTRA_REF_CLK_S1=1. A 156.25 MHz PLLS reference clock is
          not supported. With protocol 13 PLLS is not in use, so nothing
          checks that clock before these modes start it.

Thanks,
  Vincent
