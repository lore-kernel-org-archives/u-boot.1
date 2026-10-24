Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69294606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PSaiRfEJ;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=Rs0dubTy;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=QNa/mTqs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEA438167A;
	Sat, 24 Oct 2026 18:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GHQ1CPJRecIu; Sat, 24 Oct 2026 18:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0DA348166E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792865012;
	b=oPfTKMOQqelixqfA/tuHy6rnx+B6AMUp9f1pHS6fsQTF+8n+HtvWe5ON2tCao2w6Uz4Q
	 Al4Ry2W6WlJSEpTWK8wEw9JW30Rf5Zi7lGMXqyxHMV1gj+JlVqIXYVHwGLMTOLhTKdjxf
	 KqpTE0iBheaLZye9dnx4s4acD/GWIFerWm9mWrpam3mFmQiLWgKONfEOyrNWXTd8PisPi
	 cvVR+0bnl0QVpeApPAPi0o+fqQX3JOOQUALGS3PVLLlSsGTAGgdRp97S+rMmVSU909xI8
	 WHe5R3gwVbIoxA8fng7YSr6MgG7vNztiRj37Gj4twqobBau4JeJ8+OjHUX1G802dMDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792865012;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4b+DibvQ+UlbLLiNXS/6spK3mCuuMWaTxUmGiXYS89U=;
	b=OaqdBXjhECHezgw6NucuLVyhDCFxS4OkxEbYTVvcPFYS+s9NEnYR9+AcrhqtVudTmHSh
	 CUQNpWuWQM44pvOKchsFTPCmrCHkw8wZKhCUwDOCUr8dB25Cb0ACCZfoYHi6yx4SymQ67
	 GwmxhqzYeoLuNfuSoUkEK6+pmm6555dAjEv+6zJRvujHDDbAuaivvUmZ38YCd8Q3mQ2f5
	 trRm4ka8gfgsZxVcqOxFHDwTmRcaTGfh6hKGxhH7TctKkZji7r5ClTSbEgiF6H0hpCNAG
	 BUZb4Nxpy5kLIzdHfg+NKAvV4aqWMRZaN6aLjZgRy5YrquwUsIE0Tw5nckV8wCTZrHw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792865012;
	bh=4b+DibvQ+UlbLLiNXS/6spK3mCuuMWaTxUmGiXYS89U=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=PSaiRfEJYbwV+K4lzJNbmOlDYIpOM27E+PW9DMDnPl49G4qSLxxI6UJUMMPj1NFY2
	 Y5Ej78y51CJlA8SgLqwZUr7Wz8IZsidDhwFEBYaCFbWvCsbpoM95Ecr4eNY5dN2JsX
	 A4cHHiBi0ViljcOCf2DM4gDKal4ek7HSOFodoYUTzxg24RN5teqn+zqImpYvgbiJju
	 Oh9O03oiaYzFIz0SJ9lhlWLMUaHRWX2So3fEAab2pJYAYjeR7sijRLbPAX4qN4iEum
	 GCvqEy6N15bcWAp4ce3WihI5QexZxYvuSJHRI32fvHFheuBBqk3hMZL7INzy0eSpjj
	 ME+Fvd3QMRYeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DA348166E;
	Sat, 24 Oct 2026 18:03:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0041E3D9
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6B044009F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:03:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F4sYoIRC8xRS for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 18:03:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C029740049
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792865009;
 b=JWOfy9iedQA3A26cUfygaGlK0awPz1NmnnBdZ/ZAPdnKl7n3VSL3Eys1SB9MjTJveeyk
 8HTBJBq4Y6/92JsG9iJJkj8Bjopsi9Htpw3wMd7GINlORUr8etH6Rt/eBFqqk20SGChzb
 EUpYz1IzvI56xdbWmL7ktFBmSK9fso+FpEvZvaxZqBHtq8MvU5SSGvAENx6w1mo2+IJfv
 2u+LAmG/8EdvHhmkp91BUSXBSlh32UtF2kzRuGIQbmV17nfmX9cEXz5jps1EEpp7lnsQx
 gxnVUcXXyodRqd+y6210m9RsEiq4bcNGI/y4PYc3InhprWs+1xfmjCn0bkAHuYUXqww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792865009;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=4b+DibvQ+UlbLLiNXS/6spK3mCuuMWaTxUmGiXYS89U=;
 b=MSaRci7+ZIpb1ZzhbcwhqjtzLYCMhLB2CkvXD/taVAP0OEgThaDsAZiky6aa8B9+QC5l
 Rf9XIGfMhXiXYAqhv9fnEzgqrYGpFrmy5kFWIV9gy3V5QaRc20txhsfq/vVQghF1EEN36
 7Lpr4+/pN5Fp9an6mEQ04sN/E8NfQOLiI5GAFgoZYl6ATgQ+u1ftMMr8whlNRujioPnMn
 qG2F2gdCTcjVwHM/fBnh4vwe/qVQk8ezt9AI5q8sH/8Mdv2YCp7VBRGp6UGTAQFGqcksU
 E3jheNmWuTz1NIp/0m0KyjDTNoh5cmTIV9x01LATi/CoJyOsQhoTNK//gZA2ldCRo7Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=Rs0dubTy; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b="QNa/mTqs"; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=Rs0dubTy; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=QNa/mTqs
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C029740049
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792864999; bh=4b+DibvQ+UlbLLiNXS/6spK
 3mCuuMWaTxUmGiXYS89U=; b=Rs0dubTyECwRzgId4uM8OVRvVr5JeSYZWiXXitYtV/Ioe/9CQv
 P6uXyFDRbm3o+jmhtFl8/EdnTs3bZk5MvFSBvC4pgSAZ0pqv454uEUiAb7N1TXgJ8un+A/DzVQI
 rpOoZKEp/HpdJu3Kjdcbg91UyeGTLTkDT5drvZrTYeXyhy5efxe2aHU+492lN+WqQVU3adbTlCq
 4VSJso515/kExyaTQYsDWjzJLRPvgNI+z8sNsrozk3b8GxLnaYV2qC1rSxTALpuunb2WCNMuAtp
 dJvHJEJlxU8o+Yw69ZiQmFsPLC6M4B8NSvFho5y/+571DVSyGlzDKKlIe2UCAk7KfXw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792864999; bh=4b+DibvQ+UlbLLiNXS/6spK
 3mCuuMWaTxUmGiXYS89U=; b=QNa/mTqskhG59gqLDE1XNaIlf1XTGekglzY55skaCdk8cHdWbq
 0lyHOyJAbSv/QQ/puoClgQLz6ilgUqb/NnCQ==;
Date: Sat, 24 Oct 2026 19:03:19 +0100
From: Bradley Morgan <brads@mainlining.org>
To: brads@mainlining.org
CC: peng.fan@oss.nxp.com, trini@konsulko.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: powerpc: Add mpc8 regex to match drivers
In-Reply-To: <20261024180047.8158-1-brads@mainlining.org>
Message-ID: <B8F2A8F5-5D41-4249-BFBA-4E52F59E5EC8@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24 October 2026 19:00:47 BST, Bradley Morgan <brads@mainlining.org>
wrote:
>The POWERPC entry only covers arch/powerpc/, leaving mpc8 drivers
>and headers under drivers/ and include/ unrouted.
>
>So to fix this problem, adding a N: regex for mpc8 would be a good idea
>
>Signed-off-by: Bradley Morgan <brads@mainlining.org>
>---
>NOTE: This sits on top of pengs PR,
>If you dont pick his series,
conflicts
>shall happen!!

My series! Sorry! :(

>---
>MAINTAINERS | 1 +
>1 file changed, 1 insertion(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 1d331ce92d1..050b48eeac3 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -1453,6 +1453,7 @@ POWERPC
> M:	Bradley Morgan <brads@mainlining.org>
> S:	Maintained
> F:	arch/powerpc/
>+N:	mpc8
> 
> POWERPC MPC8XX
> M:	Christophe Leroy <christophe.leroy@csgroup.eu>
>

--- Thanks!
