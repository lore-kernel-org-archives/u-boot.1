Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF94606A329
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b62ls2Ps;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YUXpaTou;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iN5lKw68
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A7BB40737;
	Thu, 29 Oct 2026 15:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UnCgBafcXQUI; Thu, 29 Oct 2026 15:02:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7DD7740707
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793286166;
	b=dZmcqDapLDr1ZJO+kfg3lF69GIhsafNOT3X5ovYmcq7I9erH1yyS4v9loXVU/RI8tlqS
	 U7f5qnvnLNmd39e3oYXwZiXuHkoC/CyGoMnZ3nJktT9UqAnZWr/cqataFIUcsX/F7k7nx
	 EF+vI7Ns0HKQVuEK4T76E3rlCYpUYBoKz+DSaIxau8Dg0CiIRfVHpI53KYmtNc/zQU+D+
	 GkxdzLG+7AEZPgJrwgMMxRKrzRpJlkptKb2HE+da8ZJg65o/NKnaNm2QKHmzEkfOMVGnV
	 aU1BW9Xgp5BXccEQyOJDIMuSCweBW286gi8RdWZdbe8fv8FZq9OltZxqzIDlEt/DaSQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793286166;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=D9enH1TdgHDq3pdrvj6FyVUyg68PMd/gjkFhAlEd1bY=;
	b=sDgQ1n7LsDslUOQkm61cVUxJFO49yzUSL9lvYwpji5XiQ1DxWfwjMmEWtn4W2Od5UlPR
	 7Q/NQoAx8N2MBKn++8rFDwmTjM8P/araNoM39a+P6JeVuR9nldJYtJ4U0GCq+/kLHIlZ0
	 XyTFjzrRWC/4rpgheBTGI5Bdsz2f/sy7H+CH05Cmwi3o33VIl4lQPIC0G7CT/OAWc/sTN
	 emAK80zgH5ge3YaHHHjF2Xug6Lh8kVrsW/xfXCPrbSnhhLNgz5Mr9zHRr36kSSDu/X4+3
	 +cWwplNi4oHt4/jAi+BdcdiRJfTz9mHh4fle5cruG7wZWTgaz/Z420QPyrBiVNKKsIg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793286166;
	bh=D9enH1TdgHDq3pdrvj6FyVUyg68PMd/gjkFhAlEd1bY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b62ls2Psjt2eULjd2oXGiDp5UUW3a/u3meUEUDkjiEQ77ktNW0VKeC75IPE5j3htm
	 c9463mc8SN2hDkfZtW3jK5Cr9YWnaSSoakfBSx7Ln7Clyw1IWQRrB0vNkA23EFy4/Y
	 zkb6rapnEtYdazto9ja9hOHwdv7VFN1NBXsKmLI9sy1RvfjDmantfDaVXn/AEm945b
	 5pkduPiNtwl39E70usHqJAZMDf9K/lN+ry58JPy2+SvRaoIS+v2rx2RiOIJ1GL2jdE
	 E+gveg20BiwlZ0zuPv0HYzjrC4hxBwWJ3t2mcNE1qjD/6jxyNLUV15N6ayA9+ncLq7
	 qC8PbHcbuSY5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DD7740707;
	Thu, 29 Oct 2026 15:02:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17B6A972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1BC3400D5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:02:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vdDwjPb1axZi for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 15:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3ABCF40024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793286164;
 b=PRmKck6LdmpZa4po11yvevT80jmnMdXGceIV2Ai5koQV5tCvSr0OXEDFqmbJPON/I5zD
 +6Cya97+/PtIcCWeCBhaPWTYNotCAd43+KV5YE7xl4HQp4Ic1397nj7tU/Gc9l5H6Z1it
 P+eDsfUzsfIkO35j5BT13Ajkk7A2as/WPv8frJqpQ4hJyStA29gb5UQ956NIJTEMCCzLa
 asN7oWwV5hJ6FQzBbr537c+U7U0oNnda7PsQLuU/6bvOr7SkX13qGyIplamx38Cp8tKJF
 gMAdOSKcJNM7NlfsC7PYHeKtqnwnmSP2EXkI81lI0Y4Ln4ThnIqwNMk4U8yJ28EGF7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793286164;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=D9enH1TdgHDq3pdrvj6FyVUyg68PMd/gjkFhAlEd1bY=;
 b=EiVg4h0TWidT0vQfgwKU8O5JT2qIzQNdjhXuSZ6icRn0QPxGWgQZIlXHNfi2y1G+CU5n
 8j+NszZ78ip7vcwTsQnSKfuPDYgGLZpCLL/FUf1TwxkoKcItGjXiCDThY3dGQpgT4BTu+
 AoEnBdNcd4gBswDoNLV71L/N6J3s2/VqTJ2t/3odwDv+mnwu4Srg8VTpwwkLUiuMzzvwo
 9sXiOcq+VYRzDZpWyt8QdJ39xpZQkaJkUywjcy9hFDfALSLfZzdQikIH557WT2XUoImYs
 nGgkTuXqm08FQAV034S0ptHlkOccNFqd7uwfceUvIB5aK7IqUG/3ExZPG3KgtwEUN1Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=YUXpaTou; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iN5lKw68; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=YUXpaTou; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iN5lKw68
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3ABCF40024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:02:42 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCeHjs610464
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D9enH1TdgHDq3pdrvj6FyVUyg68PMd/gjkFhAlEd1bY=; b=YUXpaTou8KqysRh9
 PHZCTLB2MG+p/4pt0VZ1qB4rd08qKiQP40J4xyTQGwJ8QvnclGUPrybCRj8rsiH2
 B+5azX3aAQeM8eS4DcobxTG+6XxG0dY0m1AuuPDbeYgD89dNsZrTpz5bN8zkp26w
 QY02IdvkFrMFd0HP7UsBHLisgJXLHfh1q8kdY4yOFOym7pupGvkPOoyVrl6Lqy0S
 JAv6oqIRqfKPnnEETYK3oWsn4bvE2bjov0yXpF2/yMozj9WVB7Wk+5wmFfSCDYzw
 It5qQ7+xqMTDPs5RpFgiqxEFeZPmicPHq6IkTdwR/UqjmoyXd4vc53xtedUoaWWK
 9HNdnw==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hktmpb7rm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:02:41 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-679f81d5d7bso2967977d50.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793286161; cv=none;
 d=google.com; s=arc-20260327;
 b=GoPhFQ3/Kxm4olUIxuNgZ2XTMZs7cTwa7dfQPCWFNRv1Tjt3gPOpOgJDtHasItLlDP
 eb1X5vJcnl87Ae+94vQx87j3Y2zyH60XV52XV+9fr5lhQBXjgwcjLbTL3ZiHE0rNSos6
 ZyenJl79MXB8Urr4qOOJyG2oALEUsGJRsnlbajSTsCgIF6vBRb7d/csmIZEmkdi8pYLA
 sUyiA5eyNnrpNk5xQ8fvS8nH50XjF3cDl7Nl4+OX2ju1Z2DWwjOH2CsJl9f/x/2gYxQc
 Esvo+p6SoWQJYQVFYMlhQCkMHMYltFrmPQA94mvdDFZJUk9rbtoRHn4bynfB5ltFY2mL
 2yCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D9enH1TdgHDq3pdrvj6FyVUyg68PMd/gjkFhAlEd1bY=;
 fh=i9/SgGtsL1YneY+55J2+fNQ/znD8XWYmIK8YAy42Jj4=;
 b=Atu4ce+GkUVcDjhY+ht/n9qzf2Uho7viwVs6Tlq4yD4Gt0gPJVjApC7caURyUwDQr6
 hWYsMlW5xWgooMTOnhOr9dlzknWDUyye4CkzamR2wWwiQQgqAlIZQXWb73OZ5WnXnovP
 XgsLHPMQDlwtPUlhqlgGvyuYun0DR986b2RXoQbO/phV9bDKdmLcOFejO27X9CT3cavy
 lMNEbCK1C26ctgf7xU5ocl3ZsynveZhbXxp2pGseEA47f4OQWGR7OqgYyXp/s67V810X
 JvC779iSYdghsxLnyzYH3JAf49Ke65r/RZWQIkSmx8jiNjWxMGtPvHFST8FOjKRBeofH
 DyGA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793286161; x=1793890961;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D9enH1TdgHDq3pdrvj6FyVUyg68PMd/gjkFhAlEd1bY=;
 b=iN5lKw68aO0eFlClxov1jCg1fpa/GFGW5FGKtMiBjPpLZSJNjalnMAxBAApfOWOqNU
 /KgMnVLletOKj/ptOcoG+UTo1TgVtMVUaOmaMuyumcwyMN/wxdn2/y255HCqh4sz+wsL
 ByKIp8DqvIb8z3shVCWFvL9DUveymk8RstjbJbAB62BllDLClinEnqP6yERVP6CMxtOa
 l/v76LRvAjvfc8Hna5x9Okj8Lvb3JxewfK+gR0irgRwa3zh1iZWm7U1EQkZDN/TyeCOT
 e/wIb4NV+jTI6C4cnHELU2F/Q+JgWEXFgyWrG2qv4kBtvs+VtL8YKApico1qtnA8SLrf
 6xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286161; x=1793890961;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D9enH1TdgHDq3pdrvj6FyVUyg68PMd/gjkFhAlEd1bY=;
 b=cMPHbAzANmY593wdd8mR/Q5vETLkTt79vOdoyAi3Vafur0O6dmZapKE6sVmyz+jtI/
 UqyQLwH+IqeF5oQRA5MU4BMIg75KNLJOyjv2fs4cy+lSzEKjt99YC4vpLol7GYNcKRMP
 J2Lk+NL+39XPdmTKsEd9CngVscSca6CeJeksBzSm5FBjUiT4fjBlzBcgD/nys5LSPOJ+
 Cs2pZoisXnWoV9wFDolbAnftDZAokfT1lfoFVjyIePyBoJHgPfL8V3iSgzE53PC0NjXp
 WiP40T77Nzw91lekh/uGcj1fwN9Q0Xw5HECwNSxVLAXBhK8A+E9UH0lwGq/Gqh3V0370
 reMw==
X-Gm-Message-State: AFq9FYImnbebg7OXdTgSTIOMS1aY06AMgtF2SncXQrLAitdoVHVA9HU/
 jCx5yP6IT8UrZPhS1EnH/zb0oXvreARgbuba0lQb1G2UfqTeKtwO5xDYVYf0KYJgOV9EP9kcBa3
 poE54mPVIubrcYs+rAN+5qCxOfriHarnjkhe5R+WO7+//+36FongWCCLCa0dn0aQ3srf71lRgJD
 TGVqKqS1jKyYtGcSHgwThHVKasYiPbuaEVHFI57XT3gvue7g==
X-Gm-Gg: AYBFou2oI5MJzT8Ln6yP9WpdUTcwUeBBo86Lg+6vWNjztyD7NQTTyVe35T+WNaW70XX
 3V/x0M4J11Fu4pAkgqhqfiG0IisizknM4lo2REl4YgWZ2mTJnS12TA1S2020ZBUMRivnmrO6vKZ
 LUHeKDT05vVBZe8B3RnzRuEBq7xMtHHcjWCeNXOZqRLVq87rc21Yg9D6s=
X-Received: by 2002:a05:690e:12c3:b0:679:ad30:f010 with SMTP id
 956f58d0204a3-67a7baaf6e4mr3921774d50.14.1793286160735; 
 Thu, 29 Oct 2026 08:02:40 -0700 (PDT)
X-Received: by 2002:a05:690e:12c3:b0:679:ad30:f010 with SMTP id
 956f58d0204a3-67a7baaf6e4mr3921744d50.14.1793286160035; Thu, 29 Oct 2026
 08:02:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019-upstream-optee_rpmb_b4-v3-0-c97cf24fc56f@oss.qualcomm.com>
 <20261019-upstream-optee_rpmb_b4-v3-2-c97cf24fc56f@oss.qualcomm.com>
 <CAC_iWjL5V9q=4aJF-T_FXjTTevy6ix2L-PEfE8UcP8riR-duAQ@mail.gmail.com>
 <CAPzfCAZzkoY5=1BQ6Shn1EDSF-zscT4jeNwT+v7spyD8X5PT4w@mail.gmail.com>
 <CAC_iWjJ-gfCye1_q7wXgTjxBjCZWRqrxw8XDo1z00_kHkw1RHA@mail.gmail.com>
In-Reply-To: <CAC_iWjJ-gfCye1_q7wXgTjxBjCZWRqrxw8XDo1z00_kHkw1RHA@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 16:02:29 +0100
X-Gm-Features: AclHuK9WJgxZ79BOBVQCFGu-slC83udccEHMQ1Mzq8M06TuK_L_k8BM09T4ZsyI
Message-ID: <CAPzfCAY==KE_qHySiggMkvA4u5RLABQovC-j=LVu0Nd9LPFqJw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] optee: do not announce RPMB from within a
 supplicant RPC
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1OCBTYWx0ZWRfX4wPdEMVzyO6L
 xqFZCkNqTiTaxEQSu1BguRd5cdHekb36gUCyk03XXQyAjjcWLr86TEFqz9siYDGfCuaWcwyrGxl
 Ls+xycLOtiSFcmrtncYA5aEQ+48FtObKfJG2KmiWB7OC1WbXFkDtROSRmccWGEn40cbOT/v+HSW
 AY2ehlGa1crlkZ5MDeJxO5KGsq39JldipmosqYbVLeHnp9fMtX8BiOJQC2SBIIMJPVdBAGh6VG6
 2cu2d+NfO4mVuCZQAJ5WmQw1VNyLHVcorg2gmu+XdMoU7UHp6yJzBlcGaGTsirdSaZ4cfXcHqL8
 ObBkM/VY0+wcdlWAarWOjZHgN9TFe/VKOj3F398eb9e0iOin1LyrzZA9UZnyOTVn/NTh/z9442d
 S7QTldfPumfYdzaiu1WhNIJ/7JFDH4tCjIyZYG2dyFfrO0mwQdCdb9XCt50sDIixdLy4xVm9j2C
 PZpC2SSfs0yNZ1EZUsw==
X-Authority-Analysis: v=2.4 cv=crYOAF4i c=1 sm=1 tr=0 ts=6ae36011 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=C3il3JjQyxpNlIqSj2EA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1OCBTYWx0ZWRfX1NJBtACzN5GT
 hqjmSCyiZDncvNm6p/9rLYueBKx2SEC3YL5JeLJitb+f9S6+pipNIQwwMNoZ65iE9bxgdB2mGC5
 sPrh38J43VYttJQiNj4c9LC0/qdPUY8=
X-Proofpoint-GUID: 3qj7CRV_D6TLA9N4MV7CJa2rFNHnruJl
X-Proofpoint-ORIG-GUID: 3qj7CRV_D6TLA9N4MV7CJa2rFNHnruJl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290058
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

On Thu, Oct 29, 2026 at 3:31=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 29 Oct 2026 at 16:07, Igor Opaniuk
> <igor.opaniuk@oss.qualcomm.com> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, Oct 29, 2026 at 2:36=E2=80=AFPM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Igor,
> > >
> > > On Mon, 19 Oct 2026 at 15:10, Igor Opaniuk
> > > <igor.opaniuk@oss.qualcomm.com> wrote:
> > >
> > > [...]
> > >
> > > >
> > > > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> > > > ---
> > > >  drivers/tee/optee/core.c          |  7 +++++++
> > > >  drivers/tee/optee/optee_private.h |  2 ++
> > > >  drivers/tee/optee/rpmb.c          | 11 +++++++++++
> > > >  3 files changed, 20 insertions(+)
> > > >
> > > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > > index a47c76811cd..f7670096b61 100644
> > > > --- a/drivers/tee/optee/core.c
> > > > +++ b/drivers/tee/optee/core.c
> > > > @@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *par=
ams, uint num_params,
> > > >  static void handle_rpc(struct udevice *dev, struct rpc_param *para=
m,
> > > >                        void *page_list)
> > > >  {
> > > > +       struct optee_private *priv =3D dev_get_priv(dev);
> > > >         struct tee_shm *shm;
> > > >
> > > >         switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> > > > @@ -450,7 +451,13 @@ static void handle_rpc(struct udevice *dev, st=
ruct rpc_param *param,
> > > >                 break;
> > > >         case OPTEE_SMC_RPC_FUNC_CMD:
> > > >                 shm =3D reg_pair_to_ptr(param->a1, param->a2);
> > > > +               /*
> > > > +                * Tracked here rather than in optee_suppl_cmd(), w=
hich the
> > > > +                * sandbox TEE driver shares with its own private d=
ata.
> > > > +                */
> > > > +               priv->in_supplicant++;
> > > >                 optee_suppl_cmd(dev, shm, page_list);
> > > > +               priv->in_supplicant--;
> > > >                 break;
> > > >         default:
> > > >                 break;
> > > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/=
optee_private.h
> > > > index daff3e04493..92e3b3bea10 100644
> > > > --- a/drivers/tee/optee/optee_private.h
> > > > +++ b/drivers/tee/optee/optee_private.h
> > > > @@ -42,6 +42,8 @@ struct optee_private {
> > > >         struct mmc *rpmb_mmc;
> > > >         int rpmb_dev_id;
> > > >         int rpmb_original_part;
> > > > +       /* Non-zero while a supplicant RPC from OP-TEE is being ser=
viced */
> > > > +       int in_supplicant;
> > > >  };
> > >
> > > I am not sure what was fixed since the last version.
> > The changelog is in the cover letter [1]. For this patch, v3 moves the
> > counter back into handle_rpc(), where v1 had it. v2 had moved it into
> > optee_suppl_cmd(), but the sandbox TEE driver calls that with its own
> > private data, so v2 wrote into sandbox_tee_state (the issue you've repo=
rted)
> >
> > [1] https://lore.kernel.org/r/20261019-upstream-optee_rpmb_b4-v3-0-c97c=
f24fc56f@oss.qualcomm.com
> >
> > > This is only defined on private data  for !sandbox right?
> > > Then it's used unconditionally in handle_rpc(). Won't that break buil=
ds?
>
> My bad on the previous message, I meant UFS not sandbox*
>
> With this config
> CONFIG_ARM=3Dy
> CONFIG_KVM_VIRT_INS=3Dy
> CONFIG_ARCH_QEMU=3Dy
> CONFIG_SYS_MALLOC_LEN=3D0x1000000
> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x40200000
> CONFIG_ENV_SIZE=3D0x40000
> CONFIG_ENV_SECT_SIZE=3D0x40000
> CONFIG_OF_LIBFDT_OVERLAY=3Dy
> CONFIG_SYS_LOAD_ADDR=3D0x40200000
> CONFIG_DEBUG_UART_BASE=3D0x9000000
> CONFIG_DEBUG_UART_CLOCK=3D0
> CONFIG_ARMV8_CRYPTO=3Dy
> CONFIG_ENV_ADDR=3D0x4000000
> CONFIG_PCI=3Dy
> CONFIG_DEBUG_UART=3Dy
> CONFIG_RELOC_ADDR_TOP=3Dy
> CONFIG_EFI_HTTP_BOOT=3Dy
> CONFIG_FIT=3Dy
> CONFIG_FIT_SIGNATURE=3Dy
> CONFIG_FIT_VERBOSE=3Dy
> CONFIG_FIT_BEST_MATCH=3Dy
> CONFIG_BOOTSTD_FULL=3Dy
> CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> CONFIG_USE_PREBOOT=3Dy
> # CONFIG_DISPLAY_CPUINFO is not set
> # CONFIG_DISPLAY_BOARDINFO is not set
> # CONFIG_BOARD_INIT is not set
> CONFIG_PCI_INIT_R=3Dy
> CONFIG_BLOBLIST=3Dy
> CONFIG_CMD_SMBIOS=3Dy
> CONFIG_CMD_BOOTZ=3Dy
> CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
> CONFIG_CMD_NVEDIT_EFI=3Dy
> CONFIG_CMD_DFU=3Dy
> CONFIG_CMD_MTD=3Dy
> CONFIG_CMD_PCI=3Dy
> CONFIG_CMD_UFS=3Dy
> CONFIG_CMD_NFS=3Dy
> CONFIG_CMD_SNTP=3Dy
> CONFIG_CMD_TFTPSRV=3Dy
> CONFIG_WGET_HTTPS=3Dy
> CONFIG_WGET_CACERT=3Dy
> CONFIG_CMD_EFIDEBUG=3Dy
> CONFIG_CMD_TPM=3Dy
> CONFIG_CMD_MTDPARTS=3Dy
> CONFIG_CMD_SPAWN=3Dy
> CONFIG_ENV_IS_IN_FLASH=3Dy
> CONFIG_NET_LWIP=3Dy
> CONFIG_NET_9P=3Dy
> CONFIG_AHCI=3Dy
> CONFIG_SCSI_AHCI=3Dy
> CONFIG_AHCI_PCI=3Dy
> CONFIG_DFU_MTD=3Dy
> CONFIG_DFU_RAM=3Dy
> # CONFIG_MMC is not set
> CONFIG_MTD=3Dy
> CONFIG_DM_MTD=3Dy
> CONFIG_MTD_NOR_FLASH=3Dy
> CONFIG_FLASH_SHOW_PROGRESS=3D0
> CONFIG_CFI_FLASH=3Dy
> CONFIG_CFI_FLASH_USE_WEAK_ACCESSORS=3Dy
> CONFIG_SYS_FLASH_USE_BUFFER_WRITE=3Dy
> CONFIG_FLASH_CFI_MTD=3Dy
> CONFIG_SYS_FLASH_CFI=3Dy
> CONFIG_SYS_MAX_FLASH_SECT=3D256
> CONFIG_SYS_MAX_FLASH_BANKS=3D2
> CONFIG_SYS_MAX_FLASH_BANKS_DETECT=3Dy
> CONFIG_E1000=3Dy
> CONFIG_NVME_PCI=3Dy
> CONFIG_PCIE_ECAM_GENERIC=3Dy
> CONFIG_SCSI=3Dy
> CONFIG_DEBUG_UART_PL011=3Dy
> CONFIG_DEBUG_UART_SHIFT=3D2
> CONFIG_SYSINFO=3Dy
> CONFIG_SYSINFO_SMBIOS=3Dy
> CONFIG_SYSRESET=3Dy
> CONFIG_SYSRESET_CMD_POWEROFF=3Dy
> CONFIG_SYSRESET_PSCI=3Dy
> CONFIG_TEE=3Dy
> CONFIG_OPTEE=3Dy
> CONFIG_TPM2_MMIO=3Dy
> CONFIG_USB_EHCI_HCD=3Dy
> CONFIG_USB_EHCI_PCI=3Dy
> CONFIG_UFS=3Dy
> CONFIG_UFS_CADENCE=3Dy
> CONFIG_UFS_PCI=3Dy
> CONFIG_UFS_RENESAS=3Dy
> CONFIG_UFS_RENESAS_GEN5=3Dy
> CONFIG_UFS_TI_J721E=3Dy
> CONFIG_SUPPORT_UFS_RPMB=3Dy
> CONFIG_VIRTIO_9P=3Dy
> CONFIG_FS_9P=3Dy
> CONFIG_MBEDTLS_LIB=3Dy
> CONFIG_TPM=3Dy
> CONFIG_TPM_PCR_ALLOCATE=3Dy
> CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=3Dy
> CONFIG_UTHREAD=3Dy
> CONFIG_UNIT_TEST=3Dy
>
> I am getting
>
> drivers/tee/optee/core.c: In function =E2=80=98handle_rpc=E2=80=99:
> drivers/tee/optee/core.c:458:21: error: =E2=80=98struct optee_private=E2=
=80=99 has no
> member named =E2=80=98in_supplicant=E2=80=99
>   458 |                 priv->in_supplicant++;
>       |                     ^~
> drivers/tee/optee/core.c:460:21: error: =E2=80=98struct optee_private=E2=
=80=99 has no
> member named =E2=80=98in_supplicant=E2=80=99
>   460 |                 priv->in_supplicant--;
>       |                     ^~
>   CC      lib/efi_selftest/efi_selftest_miniapp_exit.o

Right, thanks. v3 was based on a tree from before the UFS RPMB support
landed, which split struct optee_private into one variant per RPMB
backend. I've just rebased on main, the field only ends up in the eMMC
variant and
your config fails exactly like that.

In v4 I'll add in_supplicant to both variants. handle_rpc() is common to
both backends, and keeping the counter there avoids #ifdefs in core.c.
With UFS nothing reads it, since optee_rpmb_available() is eMMC only.
Let me know if it works for you and  I'll send v4 shortly.

I've just tested this PoC, it builds with your config, with qemu_arm64
+ eMMC RPMB,
with OPTEE without RPMB, and for sandbox.

Thanks,
Igor
>
> Cheers
> /Ilias
> >
> > The field is not conditional, struct optee_private always has it.
> > handle_rpc() is in core.c, which is only built with CONFIG_OPTEE, and
> > the sandbox TEE driver never calls it. The only other user is
> > optee_rpmb_available(), and it skips every TEE device that is not bound
> > to the "optee" driver before calling dev_get_priv(). So nothing reads
> > the field from a sandbox device.
> >
> > Btw, the series builds with -Werror for sandbox_defconfig, for sandbox =
with
> > CONFIG_SUPPORT_EMMC_RPMB=3Dy (so rpmb.c is built next to the sandbox TE=
E
> > driver) and for qemu_arm64 with OPTEE and SUPPORT_EMMC_RPMB.
> >
> > >
> > > >
> > > >  struct optee_msg_arg;
> > > > diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> > > > index d4abc48f764..a40573c9281 100644
> > > > --- a/drivers/tee/optee/rpmb.c
> > > > +++ b/drivers/tee/optee/rpmb.c
> > > > @@ -210,6 +210,7 @@ void optee_suppl_rpmb_release(struct udevice *d=
ev)
> > > >
> > > >  void optee_rpmb_available(void)
> > > >  {
> > > > +       struct optee_private *priv;
> > > >         struct udevice *dev;
> > > >         struct uclass *uc;
> > > >         u32 tee_sess;
> > > > @@ -219,6 +220,16 @@ void optee_rpmb_available(void)
> > > >                     !device_active(dev))
> > > >                         continue;
> > > >
> > > > +               /*
> > > > +                * mmc_init() may run from the RPMB supplicant itse=
lf, while
> > > > +                * OP-TEE is blocked in that RPC and holds its RPMB=
 lock. A
> > > > +                * nested call would then deadlock, and OP-TEE is a=
bout to use
> > > > +                * the device anyway.
> > > > +                */
> > > > +               priv =3D dev_get_priv(dev);
> > > > +               if (priv->in_supplicant)
> > > > +                       continue;
> > > > +
> > > >                 if (optee_open_enum_session(dev, &tee_sess) !=3D 0)
> > > >                         continue;
> > > >
> > > >
> > > > --
> > > > 2.53.0
> > > >
