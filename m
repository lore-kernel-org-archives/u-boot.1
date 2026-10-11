Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04BDCA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:42:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84CE980A06;
	Sun, 11 Oct 2026 14:42:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fR1a5lCuonkH; Sun, 11 Oct 2026 14:42:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A721380E25
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791729751;
	b=rtD9KmU/FVOUwvBMsGroZodmgmSkeomvWbaQg4gge+GoMVOOxesv92SR+dOf6XNS+r/V
	 UO5APQWWInw2pNsOUIyqDgvg+4D55RBuG345Bw7VZ7z1jRQ0gq3yq3zytcsJmpR6sLuTt
	 089kSHc+M+LKHMtrZB82G+RXkXXodlRRl2O5l05DIh727RH8Q0pSAwLmfUijzJJv1es/Z
	 QgtJNk9PswqJyW9MhfeMUDjYytZdpKv8IS7eJxmw37TU0lAqRMS6/QGrDZ12ZLZk25X8+
	 R4yiXua2BpJP9Tbd6pMl4v2BVYDpyYWP4MORVIhfQYzj3uSbFDc9F6S6rJfPVY3+yKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729751;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=puTEgwt+Otd+xO3uEb4qVueHEx1p+BjPuMwTxE0WUeA=;
	b=UCV/79wed4K/vZG14TK/p0vThatNQa4OKY+62DfxqPG8z8wVV38Vj24M8vEobQ2qVgL5
	 IZIcmB5Di4dKxyKWMGTefK9y5G4+RCjtZ8ul5kv1W7IfmMx76ZqafKihfYmnb0DAvzkqe
	 nKEU+NHLgvJqzKaJb8tgpX22N59HPlQLZTLIHY1KUG9JOnq4fLlbrkfd5uO0ZzBX8yzg2
	 bLjFFWftHOBWRI1H6LymKHjH44NfPNCRbK4edn7Ez9BVsRVS1QJ2FtyrGPn0tvtfaRPhs
	 eQBYoeTlAGyHkzxOmj4rDilfUiZ9ePfxQWbLJPUsS9jgx4E9YOrwKJZ3rQ1E/TwZcqQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729751;
	bh=puTEgwt+Otd+xO3uEb4qVueHEx1p+BjPuMwTxE0WUeA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ciCSglvtos0+NRPXHpZYneVw9ymLxQ3Y3xNTP4AZxwbCbEefoMhZAorjLY7cs8x7B
	 ihYTcre4lXz3bGBoioqOe2xWE1DskXKkH5w7q37+EQlv/45VfNvLnLQq+pkQo7iMV6
	 38PxuDxUE5e9Az0J54gEdnyQmhnvLpxu8eNWoOzYTZRcdoYHQsbtNaBW/BEasm8UnW
	 65yAVvtHhWqpDfHapgcPHHjzjQhwDxwFhkxwzpbVC1Cg5F9+G1Z2Lh7w5AQ8y4O2L2
	 Yf7LddjJyRNrtYuy8HgIol9RqiiEOK9pN+5IalpwkGKFobEr2PZ3gvnGldsmbTlsC1
	 G9LRawnQVUltA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A721380E25;
	Sun, 11 Oct 2026 14:42:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BABF2E0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51C8E40071
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LMwNYwIn3zci for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 14:42:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6B0FD4002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791729748;
 b=Wmj/CdfsacWdemY/FVRP6g0o/LSuRQ2hD8VvcU0D5sg0uQf17eM6PX/NDEQNt/SqALRq
 qAKG9Wfjk+qWY9db/PrC1oziIDFKfCIgNjwWXWo+C0Wz1iK4nzpPa/gFfvcM5SgKwrdu4
 w+Vy6cuKzyaAhaFlIvU6621e8WpeC7iB4yjgRYrQhDBmU8R6y4YOPYdtBDBVFi5WvE+cz
 YcNzzXNpGECyqIYQjbolbm3lk5/Hgg9MnTLeIuD+SIyLv0ajRw3j9dsVf1jvPwaK4h2b5
 akFWCbAcXgOq8DYxvbB5IgVK9t55lVPVr3ABAw/WfHzESwOIHKpovQptQxB/H60gHAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791729748;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=puTEgwt+Otd+xO3uEb4qVueHEx1p+BjPuMwTxE0WUeA=;
 b=dy5ycRlMLtOZNKAtAJciAcTLzXGy0uQUjxZeC7SCc1GWQAvhOR7Wx0L8+WFEZlcrQymy
 FYpOUN9S/yunh0Bj+eyK2RJeyl6mqF47Q73DAU4Zpo5FrzQr3qhI+5fiNwW4lzwmIo3k8
 j7+SD6/8W/QhtWRgPOrOv5B/bDinb8lX4yKKlackvyg2C+4v1rkNbjVfD7zYK/o0lcK+a
 l89VzQct0+3LSq40J1sz1LvTY08ft32QOekmM8+7O8HyaslLCSq9N0owvS0VmL3yb8iZP
 WpqrMOlbVIjQ0tzQmqGQy3b22m5QJuzl+s2+GEkuUKdNJhmcybnJjwAsnx6P/3Qx0aA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=bhGbLg8V; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fIV5BVjT; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=bhGbLg8V; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fIV5BVjT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B0FD4002B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:27 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85aIA2793843
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 puTEgwt+Otd+xO3uEb4qVueHEx1p+BjPuMwTxE0WUeA=; b=bhGbLg8VtiE0Z21Z
 1VJqBHk4hfFx9gr3BCAKDNzxIXjsX/R9f5+UxMnhrxue0rXcCqqC2SN6ZGsKvA9T
 qwWmu7pkQcUTW3w5UC8HfXbq1v0PUSShiJCN89iEwLHn0r4eSol6QlGsrG+9EmLd
 rHBCX+y0ABcxaXFhwkyBcaNufXNNYyg+rn1H7Lus32BhHd0s70otrcypTkMbILMa
 zWITwbEfKLWS1wkcUYvn/Zo9rJBATZ02lCOUDgmZpWFSy6FNA8VBCT1LAsG4PYGl
 APLO51k4XGpt9M8G7dPpepBXODb4+kJQ9RbfbzX+NfBizk5qZxX4Epgp/6uCU09J
 pRUedg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7aqmukyj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso246846485a.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791729746; x=1792334546;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=puTEgwt+Otd+xO3uEb4qVueHEx1p+BjPuMwTxE0WUeA=;
 b=fIV5BVjT3ICz6n8B/B1YxDM99Rq4Zzx8aGyVl4PXi3CNPdseh5FVJfkB18b5lHR/qv
 e30JqOuGKbJELo4HhYE2rS2j3ub44mXtgAN6z7PUV6q3aksVEoHjkBvtFKR+dd/P+7d6
 YEYt+mUpNUV6a1elxctuUDKpDXCBz9sbBdaTCd3MPmJCGKmOhHWDB7FFNUWn4hUGad9y
 0hNrKQoNAnocAW/HBqsDpYR7KvbaEEwBTJBI9i+i4hi+6kP35hg9/dJjEsswyU77n2Il
 6BKM5h7Nvv2SjiIgXRiMen375U6+/4od7M0/1qHFVicNyflsLW/kHVVLXoi3ph6tUUL4
 m2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791729746; x=1792334546;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=puTEgwt+Otd+xO3uEb4qVueHEx1p+BjPuMwTxE0WUeA=;
 b=bBXpeNlYPBgy+X8MYoj6GC5NzPyZk1fU4Zxy5sbU8ZMWd8kqLGtpwnGAjiQKXAkwqR
 bb3MquEi1IYTFUW+1R+bQCyHrqjeyVPoSrRM9VNS7y48wbvbMc0JKtH5ytm6Mx4oN9W6
 YpVaXo2LoKWrMBkgKHHxSsjlO+n86gccQH8+3uiQnMYmXAbx/G8NJrRPqsz5T4C7uQSw
 LirdGhQHz7vS8NK9HZH+c8wzitiRAdp0idI9rA/PkFhK8fUu4OR8ZI7i4iTfnVsOa0NC
 AxLgR3FU1LaLP3Z21ji4P7Skd55rXMGptLxCWdxQa/3OzEp852b9z7ZUctAgeBK5QqAN
 z0Hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhxw/VXfTpcQTyqAm8sZpCNdma4/uB7yyeKPV9y5/limZCkvFKLHHuDYWMdgfCU8gdatS2+cs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLeEZibbx0b8HIMckuyF4DXJniURMyyyUva1g7AMtX4l1JVEODr
 YIZ/OV8t8sbbno9fbco1sCqVsWbflYDsIrQkpMF0Me1oe/G99nG8Z3kL8yyi5f2d7+p0SAq6z8u
 MWD7vnXYO/UNNG1SA2yjra9T6O1VWqImdmdP7C39DujUsFdiexLa1Xe7pTdEsDeFtTBeRRqM6Da
 8eHn97BQ==
X-Gm-Gg: AYBFou0pkwJoW3FapNLqpruVd777pOW56ibibRr9uAdau7PnWJAOXqMsbgMr+s2rq6p
 bWY37BKiEP+yH3LbjcVjB8f0fl2hSNT4wnfsxpMH2xXmJnlqtELZRYz74VpLFVbBRLcYcL82WLe
 nC/QiFIzwjupxFNGYPmmVstKINvRGVPvIuU/h/jI48jItKCOplJ8Q+j3/uq5+lZKiGvKz1COuVF
 unU659wAwKKEbyXCM7on2NgLNZGc2RBqZMVnIHPO8lkanKVJ86BGQ/J347WAkfzv/Vb/I05uQ2e
 1We7jhXp7jaiNk09s0ryFlsqFe3fXDxgUc+p2bOhEdkN/Z+zx8Mu74JhAetpY7uiw6Ce97jAuV2
 pJQexh6ZhHvPm1+E1upRtGKhwiuS+mOrWpm+O1aQNySjS
X-Received: by 2002:a05:620a:1a25:b0:93c:bc33:71f8 with SMTP id
 af79cd13be357-93ebd25ca7cmr1281249185a.43.1791729746068; 
 Sun, 11 Oct 2026 07:42:26 -0700 (PDT)
X-Received: by 2002:a05:620a:1a25:b0:93c:bc33:71f8 with SMTP id
 af79cd13be357-93ebd25ca7cmr1281237785a.43.1791729744077; 
 Sun, 11 Oct 2026 07:42:24 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179dc0c8asm3854326a12.13.2026.10.11.07.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 07:42:22 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 16:42:00 +0200
Subject: [PATCH 5/5] doc: android/avb2: document the root key provisioning
 and lock state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-upstream-avb_lock_unlock_b4-v1-5-a45aeca54016@oss.qualcomm.com>
References: <20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com>
In-Reply-To: <20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1OCBTYWx0ZWRfX7JEzupFn+6/2
 ri2jEtKug/cYSyrW+NtdWoQkDatLU058dEu3yv7gWPIHQuraQO5+eP7P0GttByYwmWu9J1NHwlI
 x3IagTGmcHVF6qi0Uwt1TRjXel06I0E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1OCBTYWx0ZWRfXyfztecXKoU5u
 n8KKbJ0mOfDCAnZzRwPebRs/jfyF6kac51krtswLL+9mwkSNI2iN85tiSr+1MiNUpOtjgSD6+q7
 Q0dp1OyDrV4EdHfzQJwhIlNZuuIZpKOC6NGzpIDDW+X1+I6LRgCpov4XhW6sjzlMsgya3xSuA/Q
 IPEnL1l+s3yd1roQZ2Dtt7b9M+rNBuDms5d9LHGJfkKWJPk/f/ik0wU6+p8tB5xipjTbC6H6unh
 TsTQVhWghC318nyN38WDRff8QR44sP8w21DM/i5xulRnwoanS+mSzFrqaNjR09uAaz4r5SfxX4J
 3UDf2JdFszpVbbCNsmy+14+DqfQr/fL4E/ozwOAtgUNS7L2odH2Ww8WrBjSvJN0/1sCisXFZx4S
 Axf7nwgY1FJXyWHLAUVPEqicpK+ckHwE6wfsb4x2ldZsBhjVhTif3xDf3ol23xITuDwO34hT+dx
 Do3uhaE5T2zOgRtaZLQ==
X-Authority-Analysis: v=2.4 cv=Uq32pOwB c=1 sm=1 tr=0 ts=6acba052 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=8x3teu7IPyAgyLZ5nhcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: vT8UnIRGWefY5XEQIwlBUBF8zjYjJHQH
X-Proofpoint-GUID: vT8UnIRGWefY5XEQIwlBUBF8zjYjJHQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110058
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

Describe the three root key sources (AVB_ROOT_KEY_BUILTIN, _TEE, _BOARD),
how to derive the SHA-256 digest of the vbmeta signing key with avbtool
and provision it into the TEE persistent value with "avb write_pvalue_hex",
the fail-closed behaviour when it is missing, and the device lock state as
seen from the U-Boot shell and from fastboot (flashing lock/unlock with the
mandatory userdata erase).

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 doc/android/avb2.rst | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index a5147012413..b43b58a07a6 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -74,6 +74,62 @@ Note that device lock state and rollback protection are only enforced when
 backed by OP-TEE (see `AVB using OP-TEE (optional)`_); without it,
 verification is advisory regardless of the root key source.
 
+Provisioning the root key digest in the TEE
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+With ``AVB_ROOT_KEY_TEE`` the trusted digest is the SHA-256 of the public key
+in the AVB key format (the 1032-byte blob for a 4096-bit RSA key, the same
+encoding that vbmeta embeds), not of the PEM file. Compute it on the host from
+the private key used to sign vbmeta::
+
+   $ avbtool extract_public_key --key key.pem --output key.avbpubkey
+   $ sha256sum key.avbpubkey
+   7728e30f50bfa5cea165f473175a08803f6a8346642b5aa10913e9d9e6defef6  key.avbpubkey
+
+and store it from the U-Boot shell as the named persistent value, which the
+AVB TA keeps in RPMB-backed secure storage::
+
+   => avb init 0
+   => avb write_pvalue_hex avb.root_pub_digest 7728e30f...defef6
+   => avb read_pvalue_hex avb.root_pub_digest 32
+
+Until the value exists, ``avb verify`` and the Android bootmeth fail with
+"Public keys are not accepted"; a wrong digest is rejected the same way; the
+value persists across reboots. Provisioning is a one-time factory step and
+should happen before the device is locked; see the note above on protecting
+the value from normal-world writes.
+
+Device lock state
+-----------------
+
+The AVB TA stores the device lock state next to the rollback indexes. A
+locked device refuses to boot on any verification error and reports
+``androidboot.verifiedbootstate=green``; an unlocked device boots with
+verification errors tolerated (``orange``) and rollback protection off.
+Changing the state resets all rollback indexes in the TA.
+
+From the U-Boot shell::
+
+   => avb init 0
+   => avb lock
+   => avb unlock
+   => avb is_unlocked
+
+Over fastboot, with ``CONFIG_FASTBOOT_CMD_FLASHING``, using the standard
+Android commands::
+
+   $ fastboot flashing get_unlock_ability    # OKAY 1
+   $ fastboot flashing unlock                # erases userdata and metadata first
+   $ fastboot flashing lock                  # likewise
+   $ fastboot getvar unlocked                # yes / no
+
+As AVB requires, both transitions erase userdata (and metadata) before the
+state changes and are refused if userdata cannot be erased. On a slow
+(emulated) eMMC the erase can take minutes; a TCP client may time out
+meanwhile, the device still completes the operation.
+``get_unlock_ability`` always reports 1: the "OEM unlocking" setting Android
+keeps in the frp partition is not evaluated.
+
 AVB 2.0 U-Boot shell commands
 -----------------------------
 
@@ -93,6 +149,13 @@ different testing purposes::
         <partname> by <offset> using data from <addr>
     avb read_pvalue <name> <bytes> - read a persistent value <name>
     avb write_pvalue <name> <value> - write a persistent value <name>
+    avb read_pvalue_hex <name> <bytes> - read a persistent value <name>
+        and print it as hex
+    avb write_pvalue_hex <name> <hex> - write the bytes given as a hex
+        string to persistent value <name>
+    avb lock - lock the device (verification errors stop the boot);
+        resets all rollback indexes
+    avb unlock - unlock the device; resets all rollback indexes
     avb verify [slot_suffix] - run verification process using hash data
         from vbmeta structure
         [slot_suffix] - _a, _b, etc (if vbmeta partition is slotted)
@@ -134,6 +197,12 @@ OP-TEE::
    CONFIG_OPTEE_TA_AVB=y
    CONFIG_SUPPORT_EMMC_RPMB=y
 
+and, to take the root key digest from the TEE and to lock/unlock over
+fastboot::
+
+   CONFIG_AVB_ROOT_KEY_TEE=y
+   CONFIG_FASTBOOT_CMD_FLASHING=y
+
 Then add ``avb verify`` invocation to your android boot sequence of commands,
 e.g.::
 

-- 
2.53.0

