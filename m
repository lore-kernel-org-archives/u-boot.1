Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07C7C79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 10:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E010580992;
	Tue,  8 Sep 2026 10:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w0rVtdiMOIlk; Tue,  8 Sep 2026 10:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A9E9E80889
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788862337;
	b=h4yKmuKRmXBW0Ly2zzWD11igHaVV/V2qV4I5pEKiwQL16HikfmgGVUOMqGvkuBUijWce
	 9e4ZlsXzOVHI7MtJc82pGS7shTZfU+AQO1/7o7/DOwCSxWv3vnW9qS+ZV/cwA4gNw8gTS
	 Qb9dAtx/8s/v04EtqHlGBE9nquajUoB8YXCTepfA8lwu7vFAlBjVg/2OB0WQxKDf16eJZ
	 TyIlSN/CkGpigX5D+jD0lenpgwGTjybFdT1sthICnybdD1zuD5FQh4KDX9k9qY9gqJI3l
	 9fPx28eVpTjRlTeY1CZ8qmwR7g39R91A7CU4pvCSJ5c4FovNDPLc7eMhL1UCHSeX0/w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788862337;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=D2ZZq6TZcdLqWWSMZLygokr97xPTOLPbUkefiuujzKY=;
	b=jOpPvmqD3EeWjUz+d6Y6MfPiXbSU2SIbl7IChGYqfNzKuMDYexgdaJPlT75Bi6SzuEh7
	 nQ70VCnmf3qUGTCwbYIEHe5/Utx0Lp+WeJf9rQh98ttQ0Ea3TvUmBLfNZAXyrSG14Fwet
	 SOnjL/0AIhJcM3RFvrMyJ+4+3snOcrYEuold30VwjogMdwWQToofjtrYwLpccJMyjk120
	 jiHOPWVsIgz9VduqK57su9xApwALVRr3BH9mXA461Uvmg3gUiH8DNIDqI260t1uf+NFIh
	 5jJZStXq3uXMww7u8/PsD7c0+BGej2Kf8KxziR8Yg+H8pGMjopMxVcg8lXD9Y/7dbfw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788862337;
	bh=D2ZZq6TZcdLqWWSMZLygokr97xPTOLPbUkefiuujzKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zl8OlaIDHOyCO8jNUuXngw99zSQ8lG39K6Ag3qb7StWoIuG1/RY+mhONDmlq39VG9
	 uqJJl/gjEOJW+Mnn2ZgU0vq/bm5jNedQ3NxnkDo3CYz/UbIkrMyluha3VzL2NqQDO6
	 3Z6nBlrEsYzxGCq4je6dkmhy03ajnBlybJoiGOTjMwH0Lzx1RN1/LFOQy2Rv57zZ+z
	 YPFNm0OgBascwo1FdNCsGdvX5urdoAHrbYW1UzjAHmDHMUwbIJlldVVpofAPF0J0wW
	 mB43bXnI/IaGpNcbZJmJI9nZWZJTp88UXLO0atX/LKuSlPg7mKPozzta3XOZQ7KjlU
	 uy5whaTwIgYJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9E9E80889;
	Tue,  8 Sep 2026 10:12:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EC3AD90
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FBE140441
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:12:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WSazYltxfLOc for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 10:12:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 362AF4043E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788862335;
 b=a8wj836fZffqU0c4k7hTnjOQlaIHDX+W5/Uy1XX9ldnk4RHbe9j67RII9Kb7/y7qJnXV
 DWasrFMXfJ42E8FdK2SuBAJY/P4kTJmUVWsCMe+ECjpkUS1gAY/2eWZB97S7cn1lozdaq
 ywut+BdHyMiAcI/XIkORFJ1Ksxh8rM6clb9EPHxbO7XS/XOxP3fjiJewq+XKAXPOufUtK
 VeCTYLSXWsXVCkdoOyd82m0Ak4E++ksH6VywI2572u8idVLPtl7NLNX2KO5OkTOIVflZ9
 tvUFKoamNu7NXxbR33h72RaUQYO0/p9Ob7UiYSNypX4bLRYOj8YXaqFjm3ACnowclbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788862335;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=D2ZZq6TZcdLqWWSMZLygokr97xPTOLPbUkefiuujzKY=;
 b=TGukWVTju+oaKefXxParjsCVfs8eNKj3iBCwMIjltFRZaf7Jni24b4f4+JAbSUAN/O1J
 lwiaWf7tm3uC/u8q31mn3spf5TFSE3udE02xj1mJ82khpYZMQHaQhu8t/LHjQkJMIKEa1
 ksdZbY2oBekCkiYhFIj2hEHeT2J6iVN3XT/jvVnSUPBftr3Ah5H3ks7YOHvG2T+0Yb2s+
 PKT3WaxVhiH4CsSCxdhDmRgo8c+xRX8oJYvI5vI2H3JEpVIYItU9PKHSS1xNPuUcWtRMN
 lyles1P4hXPXTUF4Q+cdvW9VdW1rbXb+1BR2XM8wLbKuuzt6+vRTgpoPSuQSZxUwGTA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=W8x+ycTV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=W8x+ycTV
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 362AF4043E
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788862296; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=m46ukfy84Lki09h0nEB5HTW+ZGvB1jxpKiZDReP3TVsVx8Sq9jzKsrDo4mRCQMAc2djtHnsNGLq07JISek/frmw4aSyhEK/rAya12s7AXI76iJG7Lt9gg0Oxb8dT+YzkFX9AmijkQvuMxaNOSFTCpzuwN8pAezyCDLeY5OGb6Uw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788862296;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=D2ZZq6TZcdLqWWSMZLygokr97xPTOLPbUkefiuujzKY=; 
 b=BNov6OnL0ngP2d6YvfpCC6pfkMJmqNyfAiMVUdzzKJTmnNPfQQoUZdVcXgL+LDaTM9QdEzmEfLOU3/fcLuCl9i0sxlc8no3A2Mka4AGRJ+vG7cDRAo5NwnqDLRIzEi8/DrZiqMJUg1sHmQh3OfhXg/qxs1Az8f+0axQ4pcFLD94=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788862296; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=D2ZZq6TZcdLqWWSMZLygokr97xPTOLPbUkefiuujzKY=;
 b=W8x+ycTVhB/gmjz/6bI0W0jR2qFcv02u2l/NqanPIWdNITWCdzfwMxAmLJaf6F7l
 IkNkh9r6roFbxbZ6H86+x5XL/9CQ3fuQNEVJDwhcDpzA5saVCT/uc4dSXRdHbtCV6xj
 VeodEaI6dn2IhBVwo2N/Ocwa2ArQtf9KulGOo3f4=
Received: by mx.zohomail.com with SMTPS id 1788862293806153.14542069759375;
 Tue, 8 Sep 2026 03:11:33 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:11:26 +0000
From: Yao Zi <me@ziyao.cc>
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, E Shattow <e@freeshell.de>,
 Eric Chung <eric.chung@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH] MAINTAINERS: add new SpacemiT custodians
Message-ID: <ap_fTqRkI3DA648R@pie>
References: <20260908-00-add-spacemit-custodian-v1-1-7f9c8d8150ee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-00-add-spacemit-custodian-v1-1-7f9c8d8150ee@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.841.89
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

On Tue, Sep 08, 2026 at 08:46:13AM +0000, Yixun Lan wrote:
> Introduce SpacemiT custodians and document custodian's git
> repository and management information in the MAINTAINERS file.
> 
> I will do some u-boot development for SpacemiT K3 SoC, and also
> help to review and test patches of K1 SoC. The idea of having
> a separate tree from RISC-V realm is to better handle SpacemiT's
> patches which not all RISC-V related, and have better dedicated
> CI testing, also off-load some burden from RISC-V maintainers.

Thanks, this would be helpful,

Reviewed-by: Yao Zi <me@ziyao.cc>

Best regards,
Yao Zi

> Signed-off-by: Yixun Lan <dlan@kernel.org>
