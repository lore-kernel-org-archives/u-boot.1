Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C850606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eX2pURW9;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jRgnl7Bx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MHL6YTnD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 050AF811A6;
	Wed, 21 Oct 2026 16:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IVzhHs8XbHoe; Wed, 21 Oct 2026 16:05:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E7964811BF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598731;
	b=KfO9Xf2kChVAu34oT+zf+aZ/8m9gUYZU+90aKKkS+/Dj14dhRiKdVXDUHO9PZ20e2T9p
	 K1unzBc4Jr0QcApCJoILZ5AArswsew2uwDda3Ml3yfI1ws/j6MvqDk5jhitbg4IC6aNyB
	 pxQaUqgKOGNvulLDIFsYuZza7pIWxFUQvCyi+o4+jwJihQC00u7KbZZ6Sy/cfvteOzOh1
	 1fUinIqWun168xIhS7GAtCdAMaGA4L7N0SybBEAftLI5k6gwCgiZ8VuxU1licrzaPgTvy
	 Kv92p7Xx/F7N9zSUs/oXEGvrvKQ8yE99XTnUAEjNA7Kp4QwF4AAZOUDrxOBsrmfcq5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598731;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Gr4oBGQdjrpQxi043IHBPIPIwwLRvZViaIzSJXZInNU=;
	b=RKX9jvpNyPFeg/gp+dpDbK6ozk02hxsaXYPyVX+qQRPAOOVR1xtHJ639f0LJjcVy+lEn
	 l9iQ+l0Fs9kFhX1ETk46eX29knfHe4Ai6/aJnZlWv71y31azZI9M0TbPLxEdYVjHU7sf9
	 /czRWLreKqmWu+ncbdXLZtHRXTrNOEyz1jCMns7YnbWKDRQRpVHbWKcIZvJPpcXkC8D55
	 /Z487NFClJqWks/KMXMswAZHFUgCw8nb5SVV6hU1zXSyQbT4EEejh+jSIpl8Xw7Ckvsx8
	 L31p7K6Dqov07TB6awOHo8YMdqGlF0++/wzX04TAiyLKJxavcV0NR08BH6BnQFx/UCA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598731;
	bh=Gr4oBGQdjrpQxi043IHBPIPIwwLRvZViaIzSJXZInNU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eX2pURW9w+u9sEw/19erN3OWd3ibqh7taBznYoVxwOO4mzNAQ7vk+fmm6NwFSxn7b
	 lvLrUBI8V2xnmHq12zx2A3JCP4+M3PpJrYGZQU2FQso8+eau/km6CVHU+OVP89ff0g
	 RLt+KHbv5MwqOdXtDx84OaU2wkHGJa5sfTZuwCRPs8Kbg9NIZcpXRvkztHMhbXW5fR
	 P4eW61ZH/6q1CCSTLTWZJXQ6kv4L50TOvLsywmqSU/qzOlxsRE5rDRl3GGbZVQuQ0P
	 HJuABqNbHLgBsGv/MC8z9YHGuJMC0NCYdfg2lTpZWixO8pLOm5k43ymIjCYs/EYAmT
	 civUxqNLPZovw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7964811BF;
	Wed, 21 Oct 2026 16:05:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E88491184
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9F414039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N60OocjuL9xE for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:05:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E28804016B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598728;
 b=bLeZORz1RPQiooqS2vGVECXaa0yk4mO0eN3YfXcX0/nAxTVn5GLSmTMOFHO9v6PxYF3R
 65NOyiJbdLygbjGHVPSO2BRr50vv4In/Qe6c5Sfv7CPxFEw5c+w2BYQaTXjwkJ0Fvh/UD
 AcRU27/T2EFzOCETuUR0Y7v5Rf1n4LbjVX404dliHnkWwE3XOgCTfmhvZT2hb3m9DOGAH
 j/fNth83aH8YZhpMWAyF0bEWA2wBfX7qSGy/JF/9DhcPh7ZiGcm0wzKvFhM/g54nTew8x
 3CHknKdpGBjW6uw08wfQf9Rd0tEWgIhAyhQPZZKeagP+T41tqOnUhBMDUHuXwcJknAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598728;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Gr4oBGQdjrpQxi043IHBPIPIwwLRvZViaIzSJXZInNU=;
 b=k/y0LhM1yuUhds0UjJrXeV0GjpSrGbO+9412bIaYIccwpxu45OOCaKTwko4Hh1xNp0yk
 vJVt77SBW8Sg6xxSYS6n9SjcnKagQ3GU7R1JMVbKtKGvPo+RXxQNJGKI11uD1CRnxGFS3
 w1y6E1GSAPYP0t89bRUjk9rrr2Pa4GYedPMIT7S/pNPBTvEQCSLxGta44RF2Ze6LDFT6/
 jrz24XR5rsqAic7xOLR/Id+WFPsnkvqT8JqjCW8RqEkuACB4NgHOLiRR448rTk604xvoB
 IUzc2+GSCF1C1hYSRlb8xTcli/g0ZhRUUPyK/ck0gyzZX8Od2VuBH6/iDy7w1jntbmA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jRgnl7Bx; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MHL6YTnD; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=jRgnl7Bx; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MHL6YTnD
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E28804016B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:27 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFToj6141133
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gr4oBGQdjrpQxi043IHBPIPIwwLRvZViaIzSJXZInNU=; b=jRgnl7BxFDkq5Fos
 JOLaADsPRQPwaAbTs2rl1FramI8PvVxmRw9e4a0CBdOEPGFqcdiGkrOR9pdBQosQ
 klRw87GfC7BI2mi/jNSE4/vdG9SEPJivRGq9RBcYZSZJff5zoRDgNinvrRBv8i7Q
 w0kKCXpS/3CodH8GSv8g5WTeyU7XKJNdexeAUZ0Q9kaIJ4pI4C/MzX+mibcJn8v/
 jTfPmK9EmQo6OGC9cJ75LKepnWp6Uy0gbU63aQO9nuau3XG6PR3LRrsc5R33X9oV
 uF+YSPY6j3nNfey+wTf1h9VaRaSbeOeKFwRZLS0rEzjdSmBqa8xdBvJ8sNpr5dFp
 vrvOOQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex588rca-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-366c279b454so1764423eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598726; x=1793203526;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gr4oBGQdjrpQxi043IHBPIPIwwLRvZViaIzSJXZInNU=;
 b=MHL6YTnDVUHRx9XzW2PuLuxRzncva4onTqSe/Wlcf3R3sbY35JLwJWUttymw6V8Qs6
 0BGSOr9XEsqHOojhuSlQ3jXn6N/TBhCEm7Q6hvvCxWUwfXUoS9J6+6fvCKbToQWGSL9F
 kH36ZU+oV3Fnf3Bt5yGkc5vqf8cWcTmt/M4ptsKfBzUSv7v5LvTyKuhsirFeERS+TY3P
 o64FRrg9N5lFF9rCE2JHDqiAcBBvQQobZSk6mGT9toprKYd2ri08YsWC/qbb6tnfE1jD
 PYQ5x/Jxh/moeUdk2yde9fnA7eYGn+wvOYxbKeTi4EXgFs3ymfybxZ1khCibMGianu8v
 vUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598726; x=1793203526;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gr4oBGQdjrpQxi043IHBPIPIwwLRvZViaIzSJXZInNU=;
 b=u7TvbdAHqy3c3anKit1Fjs0NO8DnN5V8UmIreAfz2jFxHM0OlvVyXc295rLqkyPxw9
 oTYfpvziJYmsyV/4GcJEGz6yTpPyAidYz3G5qB1ShFsCa8zxliL9l6qpuSOXQIlYPKVb
 8WN29Gxc0gnsZCd0hZx2EzTWSu8xGwhspg52dLebYQsXVyV2A5UuDYCkJ2ElHOtf1z8x
 g7lO5ctVhw5BlAjbUpqo3dXoQ4aHq9XM5etb8f4rIbrdjFVNUgd1xoOTg2vDL9Q/IoDj
 xz/ro83+0BHK0l9Kaj/X8Wt83d8BQZgjCrvA23TKJcRJGKSho53RFILVeSbBuUMeYPiA
 uycA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwknFfTQk2d/nd/Slvhq+lFbzQeKw/dSiGIBP8LXIna9kEYE48/kXHB6iNuWVMRS8rm1fHFApE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLGC+wUttz9igWuaptne8ChiQzg3nTKvlWEGT6kHEOCKe72rkP0
 miVr2Q6NWRwgXyznYxyzHLM54ZLpLmpebBAhRjpCdEqCm+EaP18XQDIT9HVep/Dns8vNx4phmQF
 h1KUlZyCstcIpOXsW/12x4RJnZJi45kGeC1BJdSGn5KZJCF6dTr6l0QgNOBkfu0cMTG9icqg=
X-Gm-Gg: AYBFou3166MY5mEQQ9k8dWgGux+/pieHfPog5kbHV7RPAktL2wb8RnH9H5rOhR12FmY
 PKc0gifPMDDc9B2z8uo3Q04SPy4lxZU5rGCbw5JIwcy4AE9LqOCPh0U6RGikl06XvSc98ygT0k1
 Yw1Iy24uVd0f0c62gGCB+jWI3g+EMW//du1WmBQsLYCzY/6zsjxXeWhIE4cHG20QNXnHMbIfzpn
 LLqkIwdJ75QqRrEQKlYlGcug+Kltp0D8vQ56VFfsq1ZPbAH+4Tv4ySR5psV08o34RLZTFSc1Uk/
 YeuTgvrUWUCk24YqYpduekP4F5mnD4HqyTXOYaKs+HtOm60oZWh1XXV4L969/wyRDhssZdZbDJg
 uH9/qBjuvipTWPCbDK33UW9pLltt5+BXBqtn9dx5l5Q1ZxCNdnatAIVF9x4ks5G1RG6wwjqJSXF
 ATaEvHBME6Lwrgvcxk5X8=
X-Received: by 2002:a05:701b:2915:b0:166:29a2:f83f with SMTP id
 a92af1059eb24-1909f5c7e8fmr2959055c88.5.1792598724000; 
 Wed, 21 Oct 2026 09:05:24 -0700 (PDT)
X-Received: by 2002:a05:701b:2915:b0:166:29a2:f83f with SMTP id
 a92af1059eb24-1909f5c7e8fmr2959007c88.5.1792598723271; 
 Wed, 21 Oct 2026 09:05:23 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d3ae06fsm7480185c88.19.2026.10.21.09.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:05:21 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, aswin.murugan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, nathbappai@gmail.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, jbx6244@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 2/8] clk: qcom: add NEGCC driver for nord
Date: Wed, 21 Oct 2026 21:34:42 +0530
Message-Id: <20261021160448.3893858-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXz8oAFl0HETH0
 YZafeug4nvnmdnyTCShB/k5pE0kjPGmdT662kxvRM7Ki0ATaouButItzR5uqkgfaqj0pq38v1z8
 +d56NUjKFO7xHnOtCSGN96Bwh3wfaGU=
X-Proofpoint-GUID: 6zdGoa7PwSM61C3In_77WwWqtyFuVTGf
X-Proofpoint-ORIG-GUID: 6zdGoa7PwSM61C3In_77WwWqtyFuVTGf
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad8e2c6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ZbK5yrU8Lf4ruc1qkoAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX5JJCpvN1VmZM
 QP7aVAyHdF4+gTHTqlUvGQCXhmGMrw9UAZHYxTRjZKcrFOViiwkh657gLpAxXpAM33ZsA+ZYp8Q
 pmQsWy+Ceq+zXX8JoP5/D1pN+x6STiI1DggKkfnDElf1YC/WLQ1jEOWK7xfWL7z34EWUO0zRLkq
 nsEFmjCog0F2Iv2ov6rvp3wa9KuoBosKHOU194WnKIEIfV/9pQp7ukI213NPXlYlYxPhFwD2b2d
 Ezr1qvizVLzGJ8BPk+X89QlWWx7rcapf5BOe9/lgFF/K1exh/9+m59ScIiGsjL4jIZDkOc5rful
 2fbzpvpRnbrlePPCKJsx+cTf/ci91R0GaHNycAiDCemAP7mtllHqttkU+Eu5pMCUY5SYI7PHPaO
 j+a5jccn0ApMiIA+aMnyqjMpaxe1iWeLLFaYSIUumNteTs7dUvpqhqm30LyNZYI75nGTTQA530Y
 tobPv2wTxQAe5+a1oCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the nord NE Global Clock Controller (NEGCC).

Implement the qcom,nord-negcc driver to provide clocks, resets and
power domains required by nord peripherals during initialization.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig            |   9 ++
 drivers/clk/qcom/Makefile           |   1 +
 drivers/clk/qcom/clock-nord-negcc.c | 186 ++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-negcc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 7228d5ecbf9..3cc5e453f66 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -63,6 +63,15 @@ config CLK_QCOM_NORD
 	  on the Snapdragon Nord SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_NORD_NEGCC
+	bool "Qualcomm Nord NEGCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the North-East Global Clock
+	  Controller on the Snapdragon Nord SoC. This driver supports the
+	  UFS, USB, and QUPv3 clocks and resets exposed by the NEGCC
+	  hardware block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 193740682aa..c369909c44d 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
+obj-$(CONFIG_CLK_QCOM_NORD_NEGCC) += clock-nord-negcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-negcc.c b/drivers/clk/qcom/clock-nord-negcc.c
new file mode 100644
index 00000000000..82340749ffa
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-negcc.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,nord-negcc.h>
+#include "clock-qcom.h"
+
+#define NE_GCC_QUPV3_WRAP2_S1_CLK_CMD_RCGR		0x382a8
+#define NE_GCC_USB31_PRIM_MASTER_CLK_CMD_RCGR		0x2a038
+#define NE_GCC_USB31_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x2a050
+#define NE_GCC_USB20_MASTER_CLK_CMD_RCGR		0x31030
+#define NE_GCC_USB20_MOCK_UTMI_CLK_CMD_RCGR		0x31048
+
+/*
+ * negcc-nord.c calls qcom_branch_set_force_mem_core() on
+ * NE_GCC_UFS_PHY_ICE_CORE_CLK and NE_GCC_UFS_PHY_AXI_CLK. This U-Boot clock
+ * framework has no FORCE_MEM_CORE_ON primitive (confirmed absent from
+ * clock-qcom.h/.c) — flagged as a YELLOW residual risk, not worked around.
+ */
+
+static ulong nord_negcc_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n", __func__,
+		      priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case NE_GCC_QUPV3_WRAP2_S1_CLK:
+		WARN(rate != 14745600,
+		     "Unexpected rate for NE_GCC_QUPV3_WRAP2_S1_CLK: %lu\n", rate);
+		clk_rcg_set_rate_mnd(priv->base, NE_GCC_QUPV3_WRAP2_S1_CLK_CMD_RCGR,
+				     1, 384, 15625, CFG_CLK_SRC_GPLL0, 16);
+		return rate;
+	case NE_GCC_USB31_PRIM_MASTER_CLK:
+		clk_rcg_set_rate_mnd(priv->base, NE_GCC_USB31_PRIM_MASTER_CLK_CMD_RCGR,
+				     3, 0, 0, CFG_CLK_SRC_GPLL0, 8);
+		return rate;
+	case NE_GCC_USB31_PRIM_MOCK_UTMI_CLK:
+		clk_rcg_set_rate_mnd(priv->base, NE_GCC_USB31_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
+				     1, 0, 0, CFG_CLK_SRC_CXO, 0);
+		return rate;
+	case NE_GCC_USB20_MASTER_CLK:
+		clk_rcg_set_rate_mnd(priv->base, NE_GCC_USB20_MASTER_CLK_CMD_RCGR,
+				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
+		return rate;
+	case NE_GCC_USB20_MOCK_UTMI_CLK:
+		clk_rcg_set_rate_mnd(priv->base, NE_GCC_USB20_MOCK_UTMI_CLK_CMD_RCGR,
+				     1, 0, 0, CFG_CLK_SRC_CXO, 0);
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk nord_negcc_clks[] = {
+	GATE_CLK_POLLED(NE_GCC_AGGRE_NOC_UFS_PHY_AXI_CLK,  0x330f4, BIT(0),  0x330f4),
+	GATE_CLK_POLLED(NE_GCC_AGGRE_NOC_USB2_AXI_CLK,     0x31068, BIT(0),  0x31068),
+	GATE_CLK_POLLED(NE_GCC_AGGRE_NOC_USB3_PRIM_AXI_CLK, 0x2a098, BIT(0),  0x2a098),
+	GATE_CLK_POLLED(NE_GCC_AGGRE_NOC_USB3_SEC_AXI_CLK, 0x2c098, BIT(0),  0x2c098),
+	GATE_CLK_POLLED(NE_GCC_AHB2PHY_CLK,                0x30004, BIT(0),  0x30004),
+	GATE_CLK_POLLED(NE_GCC_CNOC_USB2_AXI_CLK,          0x31064, BIT(0),  0x31064),
+	GATE_CLK_POLLED(NE_GCC_CNOC_USB3_PRIM_AXI_CLK,     0x2a094, BIT(0),  0x2a094),
+	GATE_CLK_POLLED(NE_GCC_CNOC_USB3_SEC_AXI_CLK,      0x2c094, BIT(0),  0x2c094),
+	GATE_CLK_POLLED(NE_GCC_GPU_2_HSCNOC_GFX_CLK,       0x34014, BIT(0),  0x34014),
+	GATE_CLK_POLLED(NE_GCC_GPU_2_SMMU_VOTE_CLK,        0x57028, BIT(0),  0x57028),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_CORE_2X_CLK,    0x57008, BIT(1),  0x38020),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_CORE_CLK,       0x57008, BIT(0),  0x3800c),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_M_AHB_CLK,      0x57000, BIT(30), 0x38004),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S0_CLK,         0x57008, BIT(2),  0x3815c),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S1_CLK,         0x57008, BIT(3),  0x38298),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S2_CLK,         0x57008, BIT(4),  0x383d4),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S3_CLK,         0x57008, BIT(5),  0x38510),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S4_CLK,         0x57008, BIT(6),  0x3864c),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S5_CLK,         0x57008, BIT(7),  0x38788),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S6_CLK,         0x57008, BIT(8),  0x388c4),
+	GATE_CLK_POLLED(NE_GCC_QUPV3_WRAP2_S_AHB_CLK,      0x57000, BIT(31), 0x38008),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_AHB_CLK,            0x33028, BIT(0),  0x33028),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_AXI_CLK,            0x33018, BIT(0),  0x33018),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_ICE_CORE_CLK,       0x3307c, BIT(0),  0x3307c),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_PHY_AUX_CLK,        0x330bc, BIT(0),  0x330bc),
+	GATE_CLK_POLLED(NE_GCC_UFS_PHY_UNIPRO_CORE_CLK,    0x3306c, BIT(0),  0x3306c),
+	GATE_CLK_POLLED(NE_GCC_USB31_PRIM_ATB_CLK,         0x2a018, BIT(0),  0x2a018),
+	GATE_CLK_POLLED(NE_GCC_USB31_PRIM_EUD_AHB_CLK,     0x2a02c, BIT(0),  0x2a02c),
+	GATE_CLK_POLLED(NE_GCC_USB31_SEC_ATB_CLK,          0x2c018, BIT(0),  0x2c018),
+	GATE_CLK_POLLED(NE_GCC_USB31_SEC_EUD_AHB_CLK,      0x2c02c, BIT(0),  0x2c02c),
+
+	GATE_CLK(NE_GCC_FRQ_MEASURE_REF_CLK,      0x20008, BIT(0)),
+	GATE_CLK(NE_GCC_GP1_CLK,                  0x21000, BIT(0)),
+	GATE_CLK(NE_GCC_GP2_CLK,                  0x22000, BIT(0)),
+	GATE_CLK(NE_GCC_GPU_2_GPLL0_CLK_SRC,      0x57000, BIT(19)),
+	GATE_CLK(NE_GCC_GPU_2_GPLL0_DIV_CLK_SRC,  0x57000, BIT(20)),
+	GATE_CLK(NE_GCC_SDCC4_APPS_CLK,           0x18004, BIT(0)),
+	GATE_CLK(NE_GCC_SDCC4_AXI_CLK,            0x18014, BIT(0)),
+	GATE_CLK(NE_GCC_UFS_PHY_RX_SYMBOL_0_CLK,  0x33030, BIT(0)),
+	GATE_CLK(NE_GCC_UFS_PHY_RX_SYMBOL_1_CLK,  0x330d8, BIT(0)),
+	GATE_CLK(NE_GCC_UFS_PHY_TX_SYMBOL_0_CLK,  0x3302c, BIT(0)),
+	GATE_CLK(NE_GCC_USB20_MASTER_CLK,         0x31018, BIT(0)),
+	GATE_CLK(NE_GCC_USB20_MOCK_UTMI_CLK,      0x3102c, BIT(0)),
+	GATE_CLK(NE_GCC_USB20_SLEEP_CLK,          0x31028, BIT(0)),
+	GATE_CLK(NE_GCC_USB31_PRIM_MASTER_CLK,    0x2a01c, BIT(0)),
+	GATE_CLK(NE_GCC_USB31_PRIM_MOCK_UTMI_CLK, 0x2a034, BIT(0)),
+	GATE_CLK(NE_GCC_USB31_PRIM_SLEEP_CLK,     0x2a030, BIT(0)),
+	GATE_CLK(NE_GCC_USB31_SEC_MASTER_CLK,     0x2c01c, BIT(0)),
+	GATE_CLK(NE_GCC_USB31_SEC_MOCK_UTMI_CLK,  0x2c034, BIT(0)),
+	GATE_CLK(NE_GCC_USB31_SEC_SLEEP_CLK,      0x2c030, BIT(0)),
+	GATE_CLK(NE_GCC_USB3_PRIM_PHY_AUX_CLK,    0x2a06c, BIT(0)),
+	GATE_CLK(NE_GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x2a070, BIT(0)),
+	GATE_CLK(NE_GCC_USB3_PRIM_PHY_PIPE_CLK,   0x2a074, BIT(0)),
+	GATE_CLK(NE_GCC_USB3_SEC_PHY_AUX_CLK,     0x2c06c, BIT(0)),
+	GATE_CLK(NE_GCC_USB3_SEC_PHY_COM_AUX_CLK, 0x2c070, BIT(0)),
+	GATE_CLK(NE_GCC_USB3_SEC_PHY_PIPE_CLK,    0x2c074, BIT(0)),
+};
+
+static int nord_negcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map nord_negcc_resets[] = {
+	[NE_GCC_GPU_2_BCR] = { 0x34000 },
+	[NE_GCC_QUPV3_WRAPPER_2_BCR] = { 0x38000 },
+	[NE_GCC_SDCC4_BCR] = { 0x18000 },
+	[NE_GCC_UFS_PHY_BCR] = { 0x33000 },
+	[NE_GCC_USB20_PRIM_BCR] = { 0x31000 },
+	[NE_GCC_USB31_PRIM_BCR] = { 0x2a000 },
+	[NE_GCC_USB31_SEC_BCR] = { 0x2c000 },
+	[NE_GCC_USB3_DP_PHY_PRIM_BCR] = { 0x2b008 },
+	[NE_GCC_USB3_DP_PHY_SEC_BCR] = { 0x2d008 },
+	[NE_GCC_USB3_PHY_PRIM_BCR] = { 0x2b000 },
+	[NE_GCC_USB3_PHY_SEC_BCR] = { 0x2d000 },
+	[NE_GCC_USB3PHY_PHY_PRIM_BCR] = { 0x2b004 },
+	[NE_GCC_USB3PHY_PHY_SEC_BCR] = { 0x2d004 },
+	[NE_GCC_QUSB2PHY_PRIM_BCR] = { 0x2e000 },
+};
+
+static const struct qcom_power_map nord_negcc_gdscs[] = {
+	[NE_GCC_UFS_MEM_PHY_GDSC] = { 0x32000 },
+	[NE_GCC_UFS_PHY_GDSC] = { 0x33004 },
+	[NE_GCC_USB20_PRIM_GDSC] = { 0x31004 },
+	[NE_GCC_USB31_PRIM_GDSC] = { 0x2a004 },
+	[NE_GCC_USB31_SEC_GDSC] = { 0x2c004 },
+	[NE_GCC_USB3_PHY_GDSC] = { 0x2b00c },
+	[NE_GCC_USB3_SEC_PHY_GDSC] = { 0x2d00c },
+};
+
+static struct msm_clk_data nord_negcc_data = {
+	.resets = nord_negcc_resets,
+	.num_resets = ARRAY_SIZE(nord_negcc_resets),
+	.clks = nord_negcc_clks,
+	.num_clks = ARRAY_SIZE(nord_negcc_clks),
+
+	.power_domains = nord_negcc_gdscs,
+	.num_power_domains = ARRAY_SIZE(nord_negcc_gdscs),
+
+	.enable = nord_negcc_enable,
+	.set_rate = nord_negcc_set_rate,
+};
+
+static const struct udevice_id gcc_nord_negcc_of_match[] = {
+	{
+		.compatible = "qcom,nord-negcc",
+		.data = (ulong)&nord_negcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord_negcc) = {
+	.name		= "gcc_nord_negcc",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_nord_negcc_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

