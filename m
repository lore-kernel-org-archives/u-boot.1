Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67059CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 09:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21F134062C;
	Fri,  2 Oct 2026 09:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1uHZrW54bACs; Fri,  2 Oct 2026 09:37:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6FE00407A4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790933865;
	b=XXb9aDC294sphUP9dX+UfKTfzxExgDPhNpcKf7GHUeG/9Bbfv8Wr0E5lI1IXVDU4A/9k
	 /sHBiRauo1UlbsUF5/USfc5dZFl6JYZBHHDOCPYO+wafwR+y8FfHILOy81ugkzt17VnD4
	 8WczYHalYiPlN+eHFANLBl/smkNIl2FrQ8wghedby9IrxnbKERF1m71KtTVMbUxPIuR/x
	 D+IfeVHV5l5LUA+waqgYOsbxIExL+PMtkuSK6yV5qfgA6wyXvionE38vupKCkdpAH3cjx
	 QEPdlPfL8E18r6e25I1Plm3nUwAZrfEyGmbw/CJ+jNPMi553bGquwwHPBKkLh81I17A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790933865;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3vnYnI1e1gSw3/ZaZIbGSnMLuWKKmEO65TD4r7mw9lM=;
	b=m1Ori1YH0yYrnLIS/h94uA2U39QgHMf1TmXfZTB4Tm8tppdCz+DKoqo4AcmnH2/8zFOz
	 KGSX0tkHnzaPx4lMORVCRmJk1aMl1fHE8J97cg7P2HRFZNSiHhsaW3+Ece3TPfpNuCmnN
	 5EmUvW6h2nu2cjm5gYKZgX0M/06UvOQuwg56dPZSwq3hJ9Uz1lzI0/j/W1ZgkHCCwllAG
	 254UdXdxNKiR/JG2ptSvNcV1+LeBAdmOdLez9SNP7In9gsLSJPcXAkavlHjk7UorfUZ2G
	 Y+k5VvDNSbCp9SWs+Ezb07nO89w2PrtTnWJ38Zd7SAVIwMKdQlj5PsSKGD0GHm0W05A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790933865;
	bh=3vnYnI1e1gSw3/ZaZIbGSnMLuWKKmEO65TD4r7mw9lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z9yzf79sJhv+PeFoucjEgu1uzAswlMxDJBHzllHiI/EBFIePB/0tGEXOHZaxE1CqU
	 5IhXwk7rjivtlHn/7sffc8udplv14Zlm98rMDjdvITh1UIbgwJrRILrxUrNgAGU3WY
	 MsEQSx2rtrZf3t7PoXKRLMNQv2f/XzhIfrSnI8WPeF7gMgYKTHQOjy7GlRGSZnzRpP
	 8dKSYEdLaQha4ngZvw9nPOT+Gu3M6UsdF/woh4xjP9C3Th9p59AY02yyFw0shsc9dS
	 sZ0MjoUWJK8lAp6qUqPzf8HpMP6TezoymP72hTMyvVmURzFspoFoudQrmw0tElbv0G
	 aUzhf8BzeinoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FE00407A4;
	Fri,  2 Oct 2026 09:37:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AEB2A3AC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 92CFC80A82
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:37:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6VX6uLtqRCxr for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 09:37:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5E66580A53
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790933862;
 b=asElv7DYvYHGn8+TxO2//BmsVoFN/EQx8XnhubER4qfWQsMEtETWWLx1/VYvjQKuXW/s
 5LWagucBSWihuIu8snz1KnQz98fMJo8wCIcknCGhyvQB1MOHxYa8AHYj/sx6g/2ox/WP3
 EAs6EOdV6M1KBUT8/WvDuw6ap3iJQUNbEHG0u3xB3ofMwuSDaNcHe3hr2nKulonTa77k3
 wbEJVuQQhDMc3VHCzbYkxL5XmpV1PJ1WX49bbcgEi6IuYvIg5V9/EyrfpQkiC0B2DyA5I
 iA3+Re78QKFgnIdgw2dN2wM7KMYiwcf6gp1xreMMT5x/PahybGjV2PDdEQ70fmY7CaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790933862;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=3vnYnI1e1gSw3/ZaZIbGSnMLuWKKmEO65TD4r7mw9lM=;
 b=cM/j4ugvjd2LSRks1yEJo+T4LanGpxXCRRjd/hpYjDTUuLfFblT8K+bUbhHbo4eBJIiZ
 rRVM/WgUBIVTvqUrCtC4/ah/S6c3jEQNSuh5Jkloc4BidI7PunwJYHfRo93tPWo1Dk0i4
 udcOTG70tV0OpNRbO6UuomHHFJDFx7SHGvDvrNfZRzrlyWMpXhL/bm0zBI8XjPgkA0oo8
 xFOrU9v+lUaoal8D/Y7SzMw/s0sWnB8mDwzJDZQ38B5kYKYnlSkRTycXGi0YQD3YVq8vn
 J0ddneXGBeJ4vnNZeVw3Km6+9pqdAxhlN3LZOIflCkYE+pN6Sb1Im1URp6AI025lk3A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=uMejfVbS; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
X-Greylist: delayed 340 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 02 Oct 2026 09:37:42 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=uMejfVbS
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E66580A53
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:37:42 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hx3T92McVzMlZM;
 Fri, 02 Oct 2026 11:31:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790933517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vnYnI1e1gSw3/ZaZIbGSnMLuWKKmEO65TD4r7mw9lM=;
 b=uMejfVbS2c7FsJOrBJaCYJWqE8n6S6kQjazVDQl2DTkxQt99a73VLf3zyE/ILh/AbVWeFN
 7a6M091qJRgPi+eF0gHiY72x2b9uYwjjoTZCu1+pluEhdvKbhXIaCeIQQ/15fZTjSAE20m
 mF0Dy4bosh2OdYT2nMawRlUvp0kskMzv47XXiDi9HtEChho9UNKuS8ScPjcEyMnzkfl5Bo
 ua3KAJ0mBKPH5Ya95WkWwuGP4vudj02lCrbJQfOEllphzZ1egnFSohz8axHuhxG7q7GZaj
 FSzCz08c7jxBUpOgRtGD9xDEf6TAXcSGpW/IGw78Q0eJLIyEBq+kiif9t/WPfw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tony Dinh <mibodhi@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm: kirkwood: remove obsolete configs for Zyxel NSA325
 board
Date: Fri,  2 Oct 2026 11:31:52 +0200
Message-ID: <20261002093156.2238815-1-stefan.roese@mailbox.org>
In-Reply-To: <20260914-nsa325_configs-v1-1-d4089f3f5bff@gmail.com>
References: <20260914-nsa325_configs-v1-1-d4089f3f5bff@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9nyqbufxjxhhazh4ts3kect36mckcsuo
X-MBO-RS-ID: fa7036bb0fbdbb083ba
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

Hi Tony,

On 14.09.26 22:24, Tony Dinh wrote:
> Zyxel NSA325 board has been updated to bootstd, remove obsolete configs.
> 
> ---

Your Signed-off-by is missing, so I can't apply this one. Could you
please resend it with the SoB added?

Thanks,
Stefan
